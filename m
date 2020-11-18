Content-Type: multipart/mixed; boundary="===============8842277195628395505=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: WARNING in mptcp_reset_timer
Date: Wed, 18 Nov 2020 18:02:59 +0100
Message-ID: <dab4b6fd4e6469423a3e6270b36bb2c2c55feec9.camel@redhat.com>
In-Reply-To: 00000000000097726005b4645c04@google.com
X-Status: 
X-Keywords:                  
X-UID: 6781

--===============8842277195628395505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-11-18 at 08:47 -0800, syzbot wrote:
> Hello,
> =

> syzbot has tested the proposed patch but the reproducer is still triggeri=
ng an issue:
> BUG: sleeping function called from invalid context in sta_info_move_state
> =

> BUG: sleeping function called from invalid context at net/mac80211/sta_in=
fo.c:1962
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 412, name: kworker=
/u4:4
> 4 locks held by kworker/u4:4/412:
>  #0: ffff888040956138 ((wq_completion)phy12){+.+.}-{0:0}, at: arch_atomic=
64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
>  #0: ffff888040956138 ((wq_completion)phy12){+.+.}-{0:0}, at: atomic64_se=
t include/asm-generic/atomic-instrumented.h:856 [inline]
>  #0: ffff888040956138 ((wq_completion)phy12){+.+.}-{0:0}, at: atomic_long=
_set include/asm-generic/atomic-long.h:41 [inline]
>  #0: ffff888040956138 ((wq_completion)phy12){+.+.}-{0:0}, at: set_work_da=
ta kernel/workqueue.c:616 [inline]
>  #0: ffff888040956138 ((wq_completion)phy12){+.+.}-{0:0}, at: set_work_po=
ol_and_clear_pending kernel/workqueue.c:643 [inline]
>  #0: ffff888040956138 ((wq_completion)phy12){+.+.}-{0:0}, at: process_one=
_work+0x821/0x15a0 kernel/workqueue.c:2243
>  #1: ffffc9000163fda8 ((work_completion)(&sdata->work)){+.+.}-{0:0}, at: =
process_one_work+0x854/0x15a0 kernel/workqueue.c:2247
>  #2: ffff888024d04d00 (&wdev->mtx){+.+.}-{3:3}, at: sdata_lock net/mac802=
11/ieee80211_i.h:1015 [inline]
>  #2: ffff888024d04d00 (&wdev->mtx){+.+.}-{3:3}, at: ieee80211_ibss_work+0=
x93/0xe80 net/mac80211/ibss.c:1683
>  #3: ffffffff8b337160 (rcu_read_lock){....}-{1:2}, at: sta_info_insert_fi=
nish net/mac80211/sta_info.c:644 [inline]
>  #3: ffffffff8b337160 (rcu_read_lock){....}-{1:2}, at: sta_info_insert_rc=
u+0x680/0x2ba0 net/mac80211/sta_info.c:732
> Preemption disabled at:
> [<ffffffff88e7da0f>] __mutex_lock_common kernel/locking/mutex.c:955 [inli=
ne]
> [<ffffffff88e7da0f>] __mutex_lock+0x10f/0x10e0 kernel/locking/mutex.c:1103
> CPU: 0 PID: 412 Comm: kworker/u4:4 Not tainted 5.10.0-rc3-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/01/2011
> Workqueue: phy12 ieee80211_iface_work
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x107/0x163 lib/dump_stack.c:118
>  ___might_sleep.cold+0x1e8/0x22e kernel/sched/core.c:7298
>  sta_info_move_state+0x32/0x8d0 net/mac80211/sta_info.c:1962
>  sta_info_free+0x65/0x3b0 net/mac80211/sta_info.c:274
>  sta_info_insert_rcu+0x303/0x2ba0 net/mac80211/sta_info.c:738
>  ieee80211_ibss_finish_sta+0x212/0x390 net/mac80211/ibss.c:592
>  ieee80211_ibss_work+0x2c7/0xe80 net/mac80211/ibss.c:1700
>  ieee80211_iface_work+0x91f/0xa90 net/mac80211/iface.c:1443
>  process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
>  worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
>  kthread+0x3af/0x4a0 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

This looks unrelated?!? Likely introduced by:

commit dcd479e10a0510522a5d88b29b8f79ea3467d501
Author: Johannes Berg <
johannes.berg(a)intel.com>
Date:   Fri Oct 9 14:17:11 2020 +0200

    mac80211: always wind down STA state

and fixed by:

commit 7bc40aedf24d31d8bea80e1161e996ef4299fb10
Author: Johannes Berg <johannes.berg(a)intel.com>
Date:   Thu Nov 12 11:22:04 2020 +0100

    mac80211: free sta in sta_info_insert_finish() on errors

which stands only in the -net tree.

I'll try to squash my tentative fix with the above...

Thanks,

Paolo

--===============8842277195628395505==--
