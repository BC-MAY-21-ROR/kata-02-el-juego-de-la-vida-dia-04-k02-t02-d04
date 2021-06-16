require 'spec_helper'
require_relative '../src/cell'

describe Cell do
  describe '#live!' do
    context 'create dead cell' do
      it 'changes cell state' do
        cell = Cell.new(:dead, { x: 0, y: 0 })
        expect { cell.live! }.to change { cell.state }.from(:dead).to(:alive)
      end
    end
  end

  describe '#die!' do
    context 'create alive cell' do
      it 'changes cell state' do
        cell = Cell.new(:alive, { x: 0, y: 0 })
        expect { cell.die! }.to change { cell.state }.from(:alive).to(:dead)
      end
    end
  end

  describe '#alive?' do
    context 'create alive cell' do
      it 'returns true' do
        cell = Cell.new(:alive, { x: 0, y: 0 })
        expect(cell.alive?).to be_truthy
      end
    end
  end

  describe '#dead?' do
    context 'create dead cell' do
      it 'returns true' do
        cell = Cell.new(:dead, { x: 0, y: 0 })
        expect(cell.dead?).to be_truthy
      end
    end
  end
end
