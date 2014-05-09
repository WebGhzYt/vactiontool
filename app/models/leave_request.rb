class LeaveRequest < ActiveRecord::Base

    state_machine initial: :pending do
        state :pending
        state :approved
        state :unapproved

        event :approve  do
            transition :pending => :approved
        end

        event :unapprove do
            transition :pending => :unapproved
        end
    end
    
    belongs_to :user
    belongs_to :leave_type

    validates :leave_type, presence: true
    validates :reason, presence: true
    validates :leaves_from, presence: true
    validates :leaves_to, presence: true
    
    validate :leave_request

    def leave_request
        
        leave_type = self.leave_type.leave_type
        logger.debug leave_type
        leaves_to = self.leaves_to
        leaves_from = self.leaves_from
        applied_date = self.applied_date
        user_id = self.user_id
        @current_user = User.find_by(@user_id)
        
        unless leaves_from.nil? && leaves_to.nil?

            # arr_of_leave_dates = (leaves_from..leaves_to).to_a

            leave_days = 0
            $check = false
            temp_leaves_from = leaves_from

            while (temp_leaves_from <= leaves_to)
              if temp_leaves_from.to_date.weekday?
                leave_days = leave_days + 1
              else 
                $check = true
              end
              temp_leaves_from += 1.day
            end

            logger.debug leave_days

            # leave_days = (leaves_to.to_date - leaves_from.to_date).to_i + 1 
            self.leave_days = leave_days
        
            leave_applied_gap = (leaves_from.to_date - applied_date.to_date).to_i

            if leaves_from.to_date > leaves_to.to_date 
                errors.add(:base, "Invalid date as Leaves_From must be before Leaves_To !!")
            end

            if applied_date.to_date > leaves_from.to_date
                errors.add(:base, "Invalid date request!")
            end

            @record = LeaveRecord.where(:user_id => user_id)
            @sl_allowed = @record.where(:leave_type_id => 1)
            @cl_allowed = @record.where(:leave_type_id => 2)
            @pl_allowed = @record.where(:leave_type_id => 3)
      
            sl_requests = 0
            cl_requests = 0
            pl_requests = 0

      @all_leave_requests = LeaveRequest.where(:user_id => user_id)
      
      @all_leave_requests.each do |req|
        if req.leave_type_id == 1 && req.status == 'pending' || req.leave_type_id == 1 && req.status == 'approved'
          sl_requests = sl_requests + req.leave_days
        elsif req.leave_type_id == 2 && req.status == 'pending' || req.leave_type_id == 2 && req.status == 'approved'
          cl_requests = cl_requests + req.leave_days
        elsif req.leave_type_id == 3 && req.status == 'pending' || req.leave_type_id == 3 && req.status == 'approved'
          pl_requests = pl_requests + req.leave_days
        end
      end

     
            if @sl_allowed.first.leaves_allowed && leave_type == 'SL'
                if @sl_allowed.first.leaves_allowed - sl_requests == 0
                    errors.add(:base , "You dont have any more sick leaves to access.")
                elsif @sl_allowed.first.leaves_allowed - sl_requests < leave_days
                    errors.add(:base, "Sorry! You are left with less sick leaves.")
                end
            end

            if @pl_allowed.first.leaves_allowed && leave_type == 'PL'
                if @pl_allowed.first.leaves_allowed - pl_requests == 0
                    errors.add(:base , "You dont have any more planned leaves to access.")
                elsif @pl_allowed.first.leaves_allowed - pl_requests < leave_days
                    errors.add(:base, "Sorry! You are left with less planned leaves.")
                elsif leave_applied_gap < 14
                    errors.add(:base , "Sorry! You should inform two weeks earlier.")
                end
            end

            if @cl_allowed.first.leaves_allowed && leave_type == 'CL'
                if @cl_allowed.first.leaves_allowed - cl_requests == 0
                    errors.add(:base , "You dont have any more casual leaves to access.")
                elsif @cl_allowed.first.leaves_allowed - cl_requests < leave_days
                    errors.add(:base, "Sorry! You are left with casual less leaves.")
                elsif leave_days > 1
                    errors.add(:base, "Sorry! Only one casual leave can be granted at a time.")
                end
            end 
        end
    end
end
