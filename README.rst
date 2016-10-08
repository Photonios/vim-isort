This project is a fork that adds the ability to configure ``isort`` from your vim configuration.

vim-isort
=========

Vim plugin to sort python imports using `isort <https://github.com/timothycrosley/isort>`_


Usage
=====

Call the ``:Isort`` command, which will re-oreder the imports of the current Python file.


Installation
============

* Install `isort <https://github.com/timothycrosley/isort>`_:

.. code::

    pip install isort

* Add the plugin to vim using `Vundle <https://github.com/gmarik/vundle>`_ or any other plugin manager, pointing to this repo:

.. code::

    Plugin 'Photonios/vim-isort'

(Or if you don't use any plugin manager, you can just copy the ``python_vimisort.vim`` file to your ``.vim/ftplugin`` folder)

Configuration
=============

You can pass any configuration option for ``isort`` by setting ``g:isort_options``:

.. code-block:: viml

    let g:isort_options = {
      \ 'line_length': 10,
      \ }

See a full list of options for ``isort`` here: https://github.com/timothycrosley/isort#configuring-isort
