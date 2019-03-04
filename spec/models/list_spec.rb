require 'rails_helper'

RSpec.describe List, type: :model do

  describe '#complete_all_tasks!' do
  	it 'should mark all tasks that belong to this list as complete' do
  		list = List.create(name: "Chores")
  		Task.create(complete: false, list_id: list.id, name: "Take out trash")
  		Task.create(complete: false, list_id: list.id, name: "Mow the lawn")
  		list.complete_all_tasks!

  		list.tasks.each do |task|
  			expect(task.complete).to eq(true)
  		end
  	end
  end

  describe '#snooze_all_tasks!' do
  	it 'should snooze each task by 1 hour' do
  		list = List.create(name: "Chores")
  		Task.create(deadline: Time.new(2019, 3, 4), list_id: list.id, name: "Take out trash")
  		Task.create(deadline: Time.new(2019, 3, 4), list_id: list.id, name: "Mow the lawn")
  		list.snooze_all_tasks!

  		list.tasks.each do |task|
  			expect(task.deadline).to eq(Time.new(2019, 3, 4) + 1.hour)
  		end
  	end
  end

  describe '#total_duration' do
  	it 'should return the sum of the duration of all tasks' do
  		list = List.create(name: "Chores")
  		Task.create(duration: 50, list_id: list.id, name: "Take out trash")
  		Task.create(duration: 100, list_id: list.id, name: "Mow the lawn")
  		expect(list.total_duration).to eq(150)
  	end
  end

  describe '#favorite_tasks' do
  	it 'should return an array of all incomplete tasks' do
  		list = List.create(name: "Chores")
  		Task.create(complete: true, list_id: list.id, name: "Take out trash")
  		Task.create(complete: false, list_id: list.id, name: "Mow the lawn")
  		Task.create(complete: false, list_id: list.id, name: "Brush the cat")
  		
  		incomplete_tasks = list.incomplete_tasks

  		expect(incomplete_tasks.count).to eq(2)
  		incomplete_tasks.each do |task|
  			expect(task.complete).to eq(false)
  		end
  	end
  end

  describe '#favorite_tasks' do
  	it 'should return an array of all favorite tasks' do
  		list = List.create(name: "Chores")
  		Task.create(favorite: false, list_id: list.id, name: "Take out trash")
  		Task.create(favorite: true, list_id: list.id, name: "Mow the lawn")
  		Task.create(favorite: false, list_id: list.id, name: "Brush the cat")
  		
  		favorite_tasks = list.favorite_tasks

  		expect(favorite_tasks.count).to eq(1)
  		favorite_tasks.each do |task|
  			expect(task.favorite).to eq(true)
  		end
  	end
  end

end
