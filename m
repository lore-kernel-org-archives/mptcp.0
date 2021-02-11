Content-Type: multipart/mixed; boundary="===============0469229813181458743=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 6/6] mptcp: add a missing retransmission timer
 scheduling
Date: Thu, 11 Feb 2021 15:30:42 -0800
Message-ID: <20210211233042.304878-7-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210211233042.304878-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7764

--===============0469229813181458743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

Currently we do not schedule the MPTCP retransmission
timer after pushing the data when such action happens
in the subflow context.

This may cause hang-up on active-backup scenarios, or
even when only single subflow msks are involved, if we lost
some peer's ack.

Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/options.c  | 3 +--
 net/mptcp/protocol.c | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 82a37cc26776..8fec3dabe109 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -880,8 +880,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 		msk->wnd_end =3D new_wnd_end;
 =

 	/* this assumes mptcp_incoming_options() is invoked after tcp_ack() */
-	if (after64(msk->wnd_end, READ_ONCE(msk->snd_nxt)) &&
-	    sk_stream_memory_free(ssk))
+	if (after64(msk->wnd_end, READ_ONCE(msk->snd_nxt)))
 		__mptcp_check_push(sk, ssk);
 =

 	if (after64(new_snd_una, old_snd_una)) {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0dbf5cbd7e56..06da6ad31c87 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1582,6 +1582,9 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 		mptcp_set_timeout(sk, ssk);
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
+		if (!mptcp_timer_pending(sk))
+			mptcp_reset_timer(sk);
+
 		if (msk->snd_data_fin_enable &&
 		    msk->snd_nxt + 1 =3D=3D msk->write_seq)
 			mptcp_schedule_work(sk);
-- =

2.30.1

--===============0469229813181458743==--
