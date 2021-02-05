Content-Type: multipart/mixed; boundary="===============6296696715221151774=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net 4/5] mptcp: add a missing retransmission
 timer scheduling
Date: Fri, 05 Feb 2021 17:55:13 +0100
Message-ID: <a04175fe2ff0a2414af090bdd2817593c711ec85.1612543972.git.pabeni@redhat.com>
In-Reply-To: cover.1612543972.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7654

--===============6296696715221151774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently we do not schedule the MPTCP retransmission
timer after pushing the data when such action happens
in the subflow context.

This may cause hang-up on active-backup scenarios, or
even when only single subflow msks are involved, if we lost
some peer's ack.

Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c  | 3 +--
 net/mptcp/protocol.c | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 331967d709de5..b63574d6b812e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -919,8 +919,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
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
index 5e75e89931915..b5d290c8d998f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1574,6 +1574,9 @@ static void __mptcp_subflow_push_pending(struct sock =
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

2.26.2

--===============6296696715221151774==--
