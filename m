Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CB225E824
	for <mptcp@lists.linux.dev>; Fri,  3 Oct 2025 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759485276; cv=none; b=nVjaEzyUCuID2QZc7YD0+utG0WiIQcoIg2Z2rRAtRo4TbQ3FZiMI2YoHejpvsg/yeo8Udf8WPxglmwmRJlNUDd9TYuHW2iSh3mir9G6AYqANzMNSkNIcyTLToQoU1hV+jpEZ5bLO97hcgglXEQzd+/QLAFgeK5hn6oIPYywKMGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759485276; c=relaxed/simple;
	bh=hmjzNW7HYCyeU1/9j3tr+TPDpXAVQev+7wQplh+FkqM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TWsAWVLFPvwcobSe4ttI3K3BU9rAVtHWxbGSy4M9OlD6H5nDL0mj63WtO1+SKMHwl/U5NXqjZIvDg/U831KtqFssX4eYfoaAkAyTPDg7UKd5GMYq6lcrAwY7IOboV7f3fyxot2nIgVfajE8miu+JIEGLCaDG1NdzyDHxMZag1RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-42570afa5d2so59590945ab.0
        for <mptcp@lists.linux.dev>; Fri, 03 Oct 2025 02:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759485273; x=1760090073;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwpWLGG1U3lEPd6VA5CWEm4P855CFqtcAkIMwkDixZ8=;
        b=taw7K+65yfEFEIV1cGyILK4vN/8D2eWmAgqRFyZx6+9f7gW4yiy4622O1Mm3O/YwFH
         B5gcJTVtijy0T4p6daKweMpihzuHmT4eTQQq3HmVTWXiLolxTIuB94lmQuAeSxm4PxHH
         7S/ieGdZvA2mU8txLc8ZH5tUObn+v3taw+bk8UAKxrM5drvsiQlJQzID+NQmKLYtDWa2
         t0poCrZUSOi5vcMq6YiV1CuyR3xg1SJ3zID5dyTLyFxlvHymic7sxdr2UITRTjFcR4/B
         jg7+AncBzrf8eFc2HJZPkY7aDMLjQWCTsWylKpfadyYMx2wTxMyoAlFkU3jsS3u7nV+J
         TIpg==
X-Forwarded-Encrypted: i=1; AJvYcCXEasZbF5DPqcXtkOZ92Z1PPjQpm6aLY5YxMEbTjHWRuVY4qzI85vFQHVDkFrg81VPy+AY2fg==@lists.linux.dev
X-Gm-Message-State: AOJu0YznEFbQc3nJw1Nb/PL+ET/TpMSmWYAvdHT8NtdgKaOhlizOz8nU
	65LUY4prXwRX+pORrgDuHV9Akxu9QEqsbcvF1NTCdlqILL8bXZLmJYwyIeT3ECkveq48fqseXTe
	/HAtpQ3tiHmg2PDfZFZ/g1CjNyBABnX+9P9fIHp99+GbLeJHvDcDC3JiKDWo=
X-Google-Smtp-Source: AGHT+IFq+FrCGW05FvVub9DgxVXHEPuJsL2AxiIEciAW4uwLbqczWW/1hQbMpcoSdmbyfZNTdvyi1AdabAhobcFgbt+kC//o+hvK
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2b:b0:3e5:4e4f:65df with SMTP id
 e9e14a558f8ab-42e7ad19143mr31659005ab.9.1759485273675; Fri, 03 Oct 2025
 02:54:33 -0700 (PDT)
Date: Fri, 03 Oct 2025 02:54:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df9d59.a00a0220.102ee.0111.GAE@google.com>
Subject: [syzbot] [mptcp?] possible deadlock in mptcp_subflow_create_socket (2)
From: syzbot <syzbot+fb2c3fa2ba28aec94627@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    262858079afd Add linux-next specific files for 20250926
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14f88942580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=997066872b7941b6
dashboard link: https://syzkaller.appspot.com/bug?extid=fb2c3fa2ba28aec94627
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7b65e4026db8/disk-26285807.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/30f313e0811e/vmlinux-26285807.xz
kernel image: https://storage.googleapis.com/syzbot-assets/13fbc9bd375c/bzImage-26285807.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fb2c3fa2ba28aec94627@syzkaller.appspotmail.com

netlink: 'syz.4.799': attribute type 1 has an invalid length.
netlink: 'syz.4.799': attribute type 1 has an invalid length.
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.4.799/9142 is trying to acquire lock:
ffffffff8e645260 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:318 [inline]
ffffffff8e645260 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4896 [inline]
ffffffff8e645260 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:5220 [inline]
ffffffff8e645260 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_cache_noprof+0x40/0x6f0 mm/slub.c:5718

but task is already holding lock:
ffff888030248f18 (k-sk_lock-AF_INET/1){+.+.}-{0:0}, at: mptcp_subflow_create_socket+0x137/0x7d0 net/mptcp/subflow.c:1772

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (k-sk_lock-AF_INET/1){+.+.}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       lock_sock_nested+0x48/0x100 net/core/sock.c:3720
       mptcp_subflow_create_socket+0x137/0x7d0 net/mptcp/subflow.c:1772
       __mptcp_socket_create net/mptcp/protocol.c:99 [inline]
       __mptcp_nmpc_sk+0x148/0x760 net/mptcp/protocol.c:131
       mptcp_connect+0x71/0x830 net/mptcp/protocol.c:3729
       __inet_stream_connect+0x2ae/0xe70 net/ipv4/af_inet.c:679
       inet_stream_connect+0x66/0xa0 net/ipv4/af_inet.c:750
       __sys_connect_file net/socket.c:2089 [inline]
       __sys_connect+0x316/0x440 net/socket.c:2108
       __do_sys_connect net/socket.c:2114 [inline]
       __se_sys_connect net/socket.c:2111 [inline]
       __x64_sys_connect+0x7a/0x90 net/socket.c:2111
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       lock_sock_nested+0x48/0x100 net/core/sock.c:3720
       lock_sock include/net/sock.h:1679 [inline]
       inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:907
       nbd_mark_nsock_dead+0x2e9/0x560 drivers/block/nbd.c:318
       sock_shutdown+0x15e/0x260 drivers/block/nbd.c:411
       nbd_clear_sock drivers/block/nbd.c:1424 [inline]
       nbd_config_put+0x342/0x790 drivers/block/nbd.c:1448
       nbd_release+0xfe/0x140 drivers/block/nbd.c:1753
       bdev_release+0x536/0x650 block/bdev.c:-1
       blkdev_release+0x15/0x20 block/fops.c:702
       __fput+0x44c/0xa70 fs/file_table.c:468
       task_work_run+0x1d4/0x260 kernel/task_work.c:227
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
       exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
       syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
       do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&nsock->tx_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       nbd_handle_cmd drivers/block/nbd.c:1140 [inline]
       nbd_queue_rq+0x257/0xf10 drivers/block/nbd.c:1204
       blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2129
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2367
       blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2976
       __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
       blk_finish_plug block/blk-core.c:1252 [inline]
       __submit_bio+0x2d3/0x5a0 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x2fb/0xa50 block/blk-core.c:755
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2447
       filemap_read_folio+0x117/0x380 mm/filemap.c:2444
       do_read_cache_folio+0x350/0x590 mm/filemap.c:4024
       read_mapping_folio include/linux/pagemap.h:999 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
       adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
       blkdev_get_whole+0x380/0x510 block/bdev.c:748
       bdev_open+0x31e/0xd30 block/bdev.c:957
       blkdev_open+0x457/0x600 block/fops.c:694
       do_dentry_open+0x953/0x13f0 fs/open.c:965
       vfs_open+0x3b/0x340 fs/open.c:1097
       do_open fs/namei.c:3975 [inline]
       path_openat+0x2ee5/0x3830 fs/namei.c:4134
       do_filp_open+0x1fa/0x410 fs/namei.c:4161
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&cmd->lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       nbd_queue_rq+0xc8/0xf10 drivers/block/nbd.c:1196
       blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2129
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2367
       blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2976
       __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
       blk_finish_plug block/blk-core.c:1252 [inline]
       __submit_bio+0x2d3/0x5a0 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x2fb/0xa50 block/blk-core.c:755
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2447
       filemap_read_folio+0x117/0x380 mm/filemap.c:2444
       do_read_cache_folio+0x350/0x590 mm/filemap.c:4024
       read_mapping_folio include/linux/pagemap.h:999 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
       adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
       blkdev_get_whole+0x380/0x510 block/bdev.c:748
       bdev_open+0x31e/0xd30 block/bdev.c:957
       blkdev_open+0x457/0x600 block/fops.c:694
       do_dentry_open+0x953/0x13f0 fs/open.c:965
       vfs_open+0x3b/0x340 fs/open.c:1097
       do_open fs/namei.c:3975 [inline]
       path_openat+0x2ee5/0x3830 fs/namei.c:4134
       do_filp_open+0x1fa/0x410 fs/namei.c:4161
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (set->srcu){.+.+}-{0:0}:
       lock_sync+0xba/0x160 kernel/locking/lockdep.c:5916
       srcu_lock_sync include/linux/srcu.h:173 [inline]
       __synchronize_srcu+0x96/0x3a0 kernel/rcu/srcutree.c:1429
       elevator_switch+0x12b/0x640 block/elevator.c:588
       elevator_change+0x315/0x4c0 block/elevator.c:691
       elevator_set_default+0x186/0x260 block/elevator.c:767
       blk_register_queue+0x34e/0x3f0 block/blk-sysfs.c:942
       __add_disk+0x677/0xd50 block/genhd.c:528
       add_disk_fwnode+0xfc/0x480 block/genhd.c:597
       add_disk include/linux/blkdev.h:775 [inline]
       nbd_dev_add+0x717/0xae0 drivers/block/nbd.c:1981
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2688
       do_one_initcall+0x236/0x820 init/main.c:1283
       do_initcall_level+0x104/0x190 init/main.c:1345
       do_initcalls+0x59/0xa0 init/main.c:1361
       kernel_init_freeable+0x334/0x4b0 init/main.c:1593
       kernel_init+0x1d/0x1d0 init/main.c:1483
       ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&q->elevator_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       elevator_change+0x1e5/0x4c0 block/elevator.c:689
       elevator_set_none+0x42/0xb0 block/elevator.c:782
       blk_mq_elv_switch_none block/blk-mq.c:5032 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5075 [inline]
       blk_mq_update_nr_hw_queues+0x598/0x1ab0 block/blk-mq.c:5133
       nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1486
       nbd_genl_connect+0x135b/0x18f0 drivers/block/nbd.c:2236
       genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
       netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
       netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
       sock_sendmsg_nosec net/socket.c:714 [inline]
       __sock_sendmsg+0x21c/0x270 net/socket.c:729
       ____sys_sendmsg+0x505/0x830 net/socket.c:2617
       ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2671
       __sys_sendmsg net/socket.c:2703 [inline]
       __do_sys_sendmsg net/socket.c:2708 [inline]
       __se_sys_sendmsg net/socket.c:2706 [inline]
       __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2706
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       blk_alloc_queue+0x538/0x620 block/blk-core.c:461
       blk_mq_alloc_queue block/blk-mq.c:4399 [inline]
       __blk_mq_alloc_disk+0x15c/0x340 block/blk-mq.c:4446
       nbd_dev_add+0x46c/0xae0 drivers/block/nbd.c:1951
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2688
       do_one_initcall+0x236/0x820 init/main.c:1283
       do_initcall_level+0x104/0x190 init/main.c:1345
       do_initcalls+0x59/0xa0 init/main.c:1361
       kernel_init_freeable+0x334/0x4b0 init/main.c:1593
       kernel_init+0x1d/0x1d0 init/main.c:1483
       ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __fs_reclaim_acquire mm/page_alloc.c:4269 [inline]
       fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4283
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4896 [inline]
       slab_alloc_node mm/slub.c:5220 [inline]
       __kmalloc_cache_noprof+0x40/0x6f0 mm/slub.c:5718
       kmalloc_noprof include/linux/slab.h:957 [inline]
       kzalloc_noprof include/linux/slab.h:1094 [inline]
       ref_tracker_alloc+0x133/0x460 lib/ref_tracker.c:271
       __netns_tracker_alloc include/net/net_namespace.h:362 [inline]
       netns_tracker_alloc include/net/net_namespace.h:371 [inline]
       get_net_track include/net/net_namespace.h:388 [inline]
       sk_net_refcnt_upgrade+0x10c/0x1b0 net/core/sock.c:2384
       mptcp_subflow_create_socket+0x31a/0x7d0 net/mptcp/subflow.c:1785
       __mptcp_socket_create net/mptcp/protocol.c:99 [inline]
       __mptcp_nmpc_sk+0x148/0x760 net/mptcp/protocol.c:131
       mptcp_pm_nl_create_listen_socket net/mptcp/pm_kernel.c:662 [inline]
       mptcp_pm_nl_add_addr_doit+0xacb/0x1460 net/mptcp/pm_kernel.c:826
       genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
       netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
       netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
       sock_sendmsg_nosec net/socket.c:714 [inline]
       __sock_sendmsg+0x21c/0x270 net/socket.c:729
       ____sys_sendmsg+0x505/0x830 net/socket.c:2617
       ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2671
       __sys_sendmsg net/socket.c:2703 [inline]
       __do_sys_sendmsg net/socket.c:2708 [inline]
       __se_sys_sendmsg net/socket.c:2706 [inline]
       __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2706
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> sk_lock-AF_INET --> k-sk_lock-AF_INET/1

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(k-sk_lock-AF_INET/1);
                               lock(sk_lock-AF_INET);
                               lock(k-sk_lock-AF_INET/1);
  lock(fs_reclaim);

 *** DEADLOCK ***

4 locks held by syz.4.799/9142:
 #0: ffffffff8f9b93d0 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8f9b91e8 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8f9b91e8 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8f9b91e8 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10d/0x790 net/netlink/genetlink.c:1209
 #2: ffff88807928ee58 (msk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1679 [inline]
 #2: ffff88807928ee58 (msk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_pm_nl_create_listen_socket net/mptcp/pm_kernel.c:661 [inline]
 #2: ffff88807928ee58 (msk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_pm_nl_add_addr_doit+0xa6c/0x1460 net/mptcp/pm_kernel.c:826
 #3: ffff888030248f18 (k-sk_lock-AF_INET/1){+.+.}-{0:0}, at: mptcp_subflow_create_socket+0x137/0x7d0 net/mptcp/subflow.c:1772

stack backtrace:
CPU: 1 UID: 0 PID: 9142 Comm: syz.4.799 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 __fs_reclaim_acquire mm/page_alloc.c:4269 [inline]
 fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4283
 might_alloc include/linux/sched/mm.h:318 [inline]
 slab_pre_alloc_hook mm/slub.c:4896 [inline]
 slab_alloc_node mm/slub.c:5220 [inline]
 __kmalloc_cache_noprof+0x40/0x6f0 mm/slub.c:5718
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 ref_tracker_alloc+0x133/0x460 lib/ref_tracker.c:271
 __netns_tracker_alloc include/net/net_namespace.h:362 [inline]
 netns_tracker_alloc include/net/net_namespace.h:371 [inline]
 get_net_track include/net/net_namespace.h:388 [inline]
 sk_net_refcnt_upgrade+0x10c/0x1b0 net/core/sock.c:2384
 mptcp_subflow_create_socket+0x31a/0x7d0 net/mptcp/subflow.c:1785
 __mptcp_socket_create net/mptcp/protocol.c:99 [inline]
 __mptcp_nmpc_sk+0x148/0x760 net/mptcp/protocol.c:131
 mptcp_pm_nl_create_listen_socket net/mptcp/pm_kernel.c:662 [inline]
 mptcp_pm_nl_add_addr_doit+0xacb/0x1460 net/mptcp/pm_kernel.c:826
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2617
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2671
 __sys_sendmsg net/socket.c:2703 [inline]
 __do_sys_sendmsg net/socket.c:2708 [inline]
 __se_sys_sendmsg net/socket.c:2706 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2706
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa199d8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa19abc5038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fa199fe5fa0 RCX: 00007fa199d8eec9
RDX: 0000000000000000 RSI: 0000200000000400 RDI: 0000000000000003
RBP: 00007fa199e11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa199fe6038 R14: 00007fa199fe5fa0 R15: 00007fff33ff5d78
 </TASK>
netlink: 'syz.4.799': attribute type 1 has an invalid length.


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
