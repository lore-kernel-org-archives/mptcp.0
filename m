Content-Type: multipart/mixed; boundary="===============2049080116669736169=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 2/2] mptcp: leverage the deferred actions for
 packet scheduling
Date: Mon, 11 Jan 2021 23:43:26 +0100
Message-ID: <34918ed732944158fd7e5ce697f9f88644bb2c59.1610404441.git.pabeni@redhat.com>
In-Reply-To: cover.1610404441.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7314

--===============2049080116669736169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This change leverage the infrastructure introduced by
the previous patch to avoid invoking the MPTCP worker
to spool the pending data, when the packet scheduler
picks a subflow other then the one currently processing
the incoming MPTCP-level ack.

Additinally we can fourther refine the subflow selection
invoking the packet scheduler for each chunk of data
even inside __mptcp_subflow_push_pending()

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3d5ac817b2fb..af45affc0a17 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1508,7 +1508,9 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_sendmsg_info info;
 	struct mptcp_data_frag *dfrag;
+	struct sock *xmit_ssk;
 	int len, copied =3D 0;
+	bool first =3D true;
 =

 	info.flags =3D 0;
 	while ((dfrag =3D mptcp_send_head(sk))) {
@@ -1518,6 +1520,18 @@ static void __mptcp_subflow_push_pending(struct sock=
 *sk, struct sock *ssk)
 		while (len > 0) {
 			int ret =3D 0;
 =

+			/* the caller already invoked the packet scheduler,
+			 * check for a different subflow usage only after
+			 * spooling the first chunk of data
+			 */
+			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			if (!xmit_ssk)
+				goto out;
+			if (xmit_ssk !=3D ssk) {
+				mptcp_subflow_defer(mptcp_subflow_ctx(xmit_ssk));
+				goto out;
+			}
+
 			if (unlikely(mptcp_must_reclaim_memory(sk, ssk))) {
 				__mptcp_update_wmem(sk);
 				sk_mem_reclaim_partial(sk);
@@ -1536,6 +1550,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			msk->tx_pending_data -=3D ret;
 			copied +=3D ret;
 			len -=3D ret;
+			first =3D false;
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
@@ -2244,7 +2259,6 @@ static void mptcp_worker(struct work_struct *work)
 	if (unlikely(state =3D=3D TCP_CLOSE))
 		goto unlock;
 =

-	mptcp_push_pending(sk, 0);
 	mptcp_check_data_fin_ack(sk);
 	__mptcp_flush_join_list(msk);
 =

@@ -2905,10 +2919,12 @@ void __mptcp_check_push(struct sock *sk, struct soc=
k *ssk)
 		return;
 =

 	if (!sock_owned_by_user(sk)) {
-		if (mptcp_subflow_get_send(mptcp_sk(sk)) =3D=3D ssk)
+		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
+
+		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
-		else
-			mptcp_schedule_work(sk);
+		else if (xmit_ssk)
+			mptcp_subflow_defer(mptcp_subflow_ctx(xmit_ssk));
 	} else {
 		set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags);
 	}
-- =

2.26.2

--===============2049080116669736169==--
