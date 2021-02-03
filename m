Content-Type: multipart/mixed; boundary="===============3588989045505171358=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net v2] mptcp: fix spurious retransmissions
Date: Wed, 03 Feb 2021 15:12:15 +0100
Message-ID: <451311adaceb5d5c4f69b12c22fd321b8d907bed.1612361402.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7608

--===============3588989045505171358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Syzkaller was able to trigger again the following splat:

WARNING: CPU: 1 PID: 12512 at net/mptcp/protocol.c:761 mptcp_reset_timer+0x=
12a/0x160 net/mptcp/protocol.c:761
Modules linked in:
CPU: 1 PID: 12512 Comm: kworker/1:6 Not tainted 5.10.0-rc6 #52
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf=
21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Workqueue: events mptcp_worker
RIP: 0010:mptcp_reset_timer+0x12a/0x160 net/mptcp/protocol.c:761
Code: e8 4b 0c ad ff e8 56 21 88 fe 48 b8 00 00 00 00 00 fc ff df 48 c7 04 =
03 00 00 00 00 48 83 c4 40 5b 5d 41 5c c3 e8 36 21 88 fe <0f> 0b 41 bc c8 0=
0 00 00 eb 98 e8 e7 b1 af fe e9 30 ff ff ff 48 c7
RSP: 0018:ffffc900018c7c68 EFLAGS: 00010293
RAX: ffff888108cb1c80 RBX: 1ffff92000318f8d RCX: ffffffff82ad0307
RDX: 0000000000000000 RSI: ffffffff82ad036a RDI: 0000000000000007
RBP: ffff888113e2d000 R08: ffff888108cb1c80 R09: ffffed10227c5ab7
R10: ffff888113e2d5b7 R11: ffffed10227c5ab6 R12: 0000000000000000
R13: ffff88801f100000 R14: ffff888113e2d5b0 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88811b500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd76a874ef8 CR3: 000000001689c005 CR4: 0000000000170ee0
Call Trace:
 mptcp_worker+0xaa4/0x1560 net/mptcp/protocol.c:2334
 process_one_work+0x8d3/0x1200 kernel/workqueue.c:2272
 worker_thread+0x9c/0x1090 kernel/workqueue.c:2418
 kthread+0x303/0x410 kernel/kthread.c:292
 ret_from_fork+0x22/0x30 arch/x86/entry/entry_64.S:296

The mptcp_worker tries to update the MPTCP retransmission timer
even if such timer is not currently scheduled.

The mptcp_rtx_head() return value is bogus: we can have enqueued
data not yet transmitted. The above may additionally cause spurious,
unneeded MPTCP-level retransmissions.

Fix the issue adding an explicit clearing the rtx queue before
trying to retransmit and checking for unacked data
Additionally drop an unneeded timer stop call and the unused
mptcp_rtx_tail() helper.

Reported-by: Christoph Paasch <cpaasch(a)apple.com>
Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v1 -> v2:
 add sanity check in mptcp_rtx_head() - I missed the fact that
 msk->rtx_queue can still be not empty even with all outstanding
 data acked. =

 @Christoph, I'm sorry to bug you again, could you please give this
 2nd variant another try?
---
 net/mptcp/protocol.c | 3 +--
 net/mptcp/protocol.h | 9 +--------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 305d25cbc216a..88a6fb6f7ecc8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -363,8 +363,6 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
 =

 	/* Look for an acknowledged DATA_FIN */
 	if (mptcp_pending_data_fin_ack(sk)) {
-		mptcp_stop_timer(sk);
-
 		WRITE_ONCE(msk->snd_data_fin_enable, 0);
 =

 		switch (sk->sk_state) {
@@ -2270,6 +2268,7 @@ static void mptcp_worker(struct work_struct *work)
 	if (!test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		goto unlock;
 =

+	__mptcp_clean_una(sk);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag)
 		goto unlock;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1024ea1512d2b..71ca3f039112c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -335,20 +335,13 @@ static inline struct mptcp_data_frag *mptcp_pending_t=
ail(const struct sock *sk)
 	return list_last_entry(&msk->rtx_queue, struct mptcp_data_frag, list);
 }
 =

-static inline struct mptcp_data_frag *mptcp_rtx_tail(const struct sock *sk)
+static inline struct mptcp_data_frag *mptcp_rtx_head(const struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

 	if (!before64(msk->snd_nxt, READ_ONCE(msk->snd_una)))
 		return NULL;
 =

-	return list_last_entry(&msk->rtx_queue, struct mptcp_data_frag, list);
-}
-
-static inline struct mptcp_data_frag *mptcp_rtx_head(const struct sock *sk)
-{
-	struct mptcp_sock *msk =3D mptcp_sk(sk);
-
 	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, =
list);
 }
 =

-- =

2.26.2

--===============3588989045505171358==--
