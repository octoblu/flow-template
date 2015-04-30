_ = require 'lodash'
FlowGenerator = require '../flow-generator'

describe 'FlowGenerator', ->
  beforeEach ->
    @sut = new FlowGenerator()

  describe '->constructor', ->
    it 'should create a new flow', ->
      expect(@sut.flow).to.exist

  describe '->addNode', ->
    it 'should exist', ->
      expect(@sut.addNode).to.exist

  describe 'when calling addNode with a type', ->
    beforeEach ->
      @sut.addNode type : 'megatype'

    it 'should have a flow with a node that has a matching type', ->
      existingNode = _.find(@sut.flow.nodes, type: 'megatype')
      expect(existingNode).to.exist

  describe 'when attempting to add a node without a type', ->
    beforeEach ->
      @sut.addNode()

    it 'should fail to add the node', ->
      expect(@sut.flow.nodes).to.be.empty

  describe '->linkNodes', ->
    it 'should exist', ->
      expect(@sut.linkNodes).to.exist

    describe 'when called', ->
      beforeEach ->
        @sut.addNode type: 'Arizona'
        @sut.addNode type: 'California'
        @sut.linkNodes(0, 1)

      it 'should add a link', ->
        existingLink = _.find(@sut.flow.links, {from: 0, to: 1})
        expect(existingLink).to.exist

    describe 'adding a link for nodes with invalid indexes', ->
      beforeEach ->
        @sut.addNode()
        @sut.linkNodes(2, 4)

      it 'should not add a new link', ->
        existingLink = _.find(@sut.flow.links, {from: 2, to: 4})
        expect(existingLink).to.not.exist

  describe '->toJSON', ->
    it 'should exist', ->
      expect(@sut.toJSON).to.exist

    describe 'when toJSON is called on a flow with nodes', ->
      beforeEach ->
        @sut.addNode type: 'hue'
        @sut.addNode type: 'trigger'
        @sut.linkNodes 0, 1

        @flowInJSON = @sut.toJSON()

      it 'should return a JSON string containing specified nodes', ->
        expect(@flowInJSON).to.have.string 'hue'
        expect(@flowInJSON).to.have.string 'trigger'
