Content-Type: multipart/mixed; boundary="===============0090351597358380186=="
MIME-Version: 1.0
From: syzbot <syzbot+42aa53dafb66a07e5a24 at syzkaller.appspotmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: WARNING in mptcp_reset_timer
Date: Wed, 18 Nov 2020 08:47:06 -0800
Message-ID: <00000000000097726005b4645c04@google.com>
In-Reply-To: ed19859176b6de825f93fe189c2cc443fb5f2c0e.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6779

--===============0090351597358380186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering=
 an issue:
BUG: sleeping function called from invalid context in sta_info_move_state

BUG: sleeping function called from invalid context at net/mac80211/sta_info=
.c:1962
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 412, name: kworker/u=
4:4
4 locks held by kworker/u4:4/412:
 #0: ffff888040956138 ((wq_completion)phy12){+.+.}-{0:0}, at: arch_atomic64=
_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888040956138 ((wq_completion)phy12){+.+.}-{0:0}, at: atomic64_set =
include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888040956138 ((wq_completion)phy12){+.+.}-{0:0}, at: atomic_long_s=
et include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888040956138 ((wq_completion)phy12){+.+.}-{0:0}, at: set_work_data=
 kernel/workqueue.c:616 [inline]
 #0: ffff888040956138 ((wq_completion)phy12){+.+.}-{0:0}, at: set_work_pool=
_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888040956138 ((wq_completion)phy12){+.+.}-{0:0}, at: process_one_w=
ork+0x821/0x15a0 kernel/workqueue.c:2243
 #1: ffffc9000163fda8 ((work_completion)(&sdata->work)){+.+.}-{0:0}, at: pr=
ocess_one_work+0x854/0x15a0 kernel/workqueue.c:2247
 #2: ffff888024d04d00 (&wdev->mtx){+.+.}-{3:3}, at: sdata_lock net/mac80211=
/ieee80211_i.h:1015 [inline]
 #2: ffff888024d04d00 (&wdev->mtx){+.+.}-{3:3}, at: ieee80211_ibss_work+0x9=
3/0xe80 net/mac80211/ibss.c:1683
 #3: ffffffff8b337160 (rcu_read_lock){....}-{1:2}, at: sta_info_insert_fini=
sh net/mac80211/sta_info.c:644 [inline]
 #3: ffffffff8b337160 (rcu_read_lock){....}-{1:2}, at: sta_info_insert_rcu+=
0x680/0x2ba0 net/mac80211/sta_info.c:732
Preemption disabled at:
[<ffffffff88e7da0f>] __mutex_lock_common kernel/locking/mutex.c:955 [inline]
[<ffffffff88e7da0f>] __mutex_lock+0x10f/0x10e0 kernel/locking/mutex.c:1103
CPU: 0 PID: 412 Comm: kworker/u4:4 Not tainted 5.10.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 01/01/2011
Workqueue: phy12 ieee80211_iface_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 ___might_sleep.cold+0x1e8/0x22e kernel/sched/core.c:7298
 sta_info_move_state+0x32/0x8d0 net/mac80211/sta_info.c:1962
 sta_info_free+0x65/0x3b0 net/mac80211/sta_info.c:274
 sta_info_insert_rcu+0x303/0x2ba0 net/mac80211/sta_info.c:738
 ieee80211_ibss_finish_sta+0x212/0x390 net/mac80211/ibss.c:592
 ieee80211_ibss_work+0x2c7/0xe80 net/mac80211/ibss.c:1700
 ieee80211_iface_work+0x91f/0xa90 net/mac80211/iface.c:1443
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[ BUG: Invalid wait context ]
5.10.0-rc3-syzkaller #0 Tainted: G        W        =

-----------------------------
kworker/u4:4/412 is trying to lock:
ffff8880268c29d0 (&local->chanctx_mtx){+.+.}-{3:3}, at: ieee80211_recalc_mi=
n_chandef+0x49/0x140 net/mac80211/util.c:2741
other info that might help us debug this:
context-{4:4}
4 locks held by kworker/u4:4/412:
 #0: ffff888040956138 ((wq_completion)phy12){+.+.}-{0:0}, at: arch_atomic64=
_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888040956138 ((wq_completion)phy12){+.+.}-{0:0}, at: atomic64_set =
include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888040956138 ((wq_completion)phy12){+.+.}-{0:0}, at: atomic_long_s=
et include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888040956138 ((wq_completion)phy12){+.+.}-{0:0}, at: set_work_data=
 kernel/workqueue.c:616 [inline]
 #0: ffff888040956138 ((wq_completion)phy12){+.+.}-{0:0}, at: set_work_pool=
_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888040956138 ((wq_completion)phy12){+.+.}-{0:0}, at: process_one_w=
ork+0x821/0x15a0 kernel/workqueue.c:2243
 #1: ffffc9000163fda8 ((work_completion)(&sdata->work)){+.+.}-{0:0}, at: pr=
ocess_one_work+0x854/0x15a0 kernel/workqueue.c:2247
 #2: ffff888024d04d00 (&wdev->mtx){+.+.}-{3:3}, at: sdata_lock net/mac80211=
/ieee80211_i.h:1015 [inline]
 #2: ffff888024d04d00 (&wdev->mtx){+.+.}-{3:3}, at: ieee80211_ibss_work+0x9=
3/0xe80 net/mac80211/ibss.c:1683
 #3: ffffffff8b337160 (rcu_read_lock){....}-{1:2}, at: sta_info_insert_fini=
sh net/mac80211/sta_info.c:644 [inline]
 #3: ffffffff8b337160 (rcu_read_lock){....}-{1:2}, at: sta_info_insert_rcu+=
0x680/0x2ba0 net/mac80211/sta_info.c:732
stack backtrace:
CPU: 1 PID: 412 Comm: kworker/u4:4 Tainted: G        W         5.10.0-rc3-s=
yzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 01/01/2011
Workqueue: phy12 ieee80211_iface_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4483 [inline]
 check_wait_context kernel/locking/lockdep.c:4544 [inline]
 __lock_acquire.cold+0x310/0x3a2 kernel/locking/lockdep.c:4781
 lock_acquire kernel/locking/lockdep.c:5436 [inline]
 lock_acquire+0x2a3/0x8c0 kernel/locking/lockdep.c:5401
 __mutex_lock_common kernel/locking/mutex.c:956 [inline]
 __mutex_lock+0x134/0x10e0 kernel/locking/mutex.c:1103
 ieee80211_recalc_min_chandef+0x49/0x140 net/mac80211/util.c:2741
 sta_info_move_state+0x3cf/0x8d0 net/mac80211/sta_info.c:2019
 sta_info_free+0x65/0x3b0 net/mac80211/sta_info.c:274
 sta_info_insert_rcu+0x303/0x2ba0 net/mac80211/sta_info.c:738
 ieee80211_ibss_finish_sta+0x212/0x390 net/mac80211/ibss.c:592
 ieee80211_ibss_work+0x2c7/0xe80 net/mac80211/ibss.c:1700
 ieee80211_iface_work+0x91f/0xa90 net/mac80211/iface.c:1443
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


Tested on:

commit:         6997faa9 Merge branch 'fix-several-bad-kernel-doc-markups'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=3D15ae97be500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df9f2db0042d65d21
dashboard link: https://syzkaller.appspot.com/bug?extid=3D42aa53dafb66a07e5=
a24
compiler:       gcc (GCC) 10.1.0-syz 20200507
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D12080af25000=
00

--===============0090351597358380186==--
