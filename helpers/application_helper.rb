module ApplicationHelper
  def has_sidenav?
    return false unless user_signed_in?
    # return false if controller.controller_path.start_with?("static_pages", "admin/", "guest/")
    true
  end

  def is_active?(args)
    match = false
    controller = controller_path.gsub('/', '_')

    # ex) :users
    if args.class == Symbol
      match = true if controller == args.to_s
    end

    # ex) "users"
    if args.class == String
      match = true if controller.start_with?(args.to_s)
    end

    # ex) [:users, :projects]
    if args.class == Array
      args.each do |v|
        if v.class == Symbol
          match = true if controller == v.to_s
        elsif v.class == String
          match = true if controller.start_with?(v.to_s)
        end
      end
    end

    # ex) users: true, projects: [:index, :show]
    if args.class == Hash
      args.each do |k, v|
        if k.class == Symbol && controller == k.to_s or k.class == String && controller.start_with?(k.to_s)
          case v.class.to_s
          when "TrueClass"
            match = true
          when "Symbol"
            match = true if v.to_s == action_name
          when "Array"
            v.each do |action|
              match = true if action.to_s == action_name
            end
          end
        end
      end
    end
    
    match ? "is-active" : nil
  end
end
