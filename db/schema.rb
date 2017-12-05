# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171205171511) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "import_requests", force: :cascade do |t|
    t.string "type", null: false
    t.integer "import_id", default: 0
    t.string "state"
    t.integer "total_count", default: 0
    t.integer "succeeded_count", default: 0
    t.integer "failed_count", default: 0
    t.text "exception"
    t.datetime "created_at"
    t.index ["type"], name: "index_import_requests_on_type"
  end

end
