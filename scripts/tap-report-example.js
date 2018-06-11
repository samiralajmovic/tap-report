const tap = require('tap');

tap.equal(1 === 1, true, 'skip message', { skip: true });
tap.equal(1 === 1, true, 'todo message', { todo: true });
tap.equal(1 === 1, true);
tap.equal('foo', 'foo', 'custom message');
tap.test('subtest exampke', t => {
  t.deepEqual({ foo: 'bar' }, { foo: 'ba' });
  t.end();
});
