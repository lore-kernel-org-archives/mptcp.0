Content-Type: multipart/mixed; boundary="===============7184134783202639679=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 1/2] mptcp: fix fallback for MP_JOIN subflows
Date: Thu, 08 Oct 2020 22:34:58 +0200
Message-ID: <4e8a4502e830a28c2f11d4f1e279e24afc21fabb.1602189151.git.pabeni@redhat.com>
In-Reply-To: cover.1602189151.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6254

--===============7184134783202639679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Additional/MP_JOIN subflows that do not pass some initial handshake
tests currently causes fallback to TCP. That is an RFC violation:
we should instead reset the subflow and leave the the msk untouched.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/91
Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c  | 32 +++++++++++++++++++++++++-------
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 10 ++++++++--
 3 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4055769e4fde..ad2bc95dd638 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -657,6 +657,12 @@ bool mptcp_established_options(struct sock *sk, struct=
 sk_buff *skb,
 	if (unlikely(mptcp_check_fallback(sk)))
 		return false;
 =

+	/* prevent adding of any MPTCP related options on reset packet
+	 * until we support MP_TCPRST/MP_FASTCLOSE
+	 */
+	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
+		return false;
+
 	if (mptcp_established_options_mp(sk, skb, &opt_size, remaining, opts))
 		ret =3D true;
 	else if (mptcp_established_options_dss(sk, skb, &opt_size, remaining,
@@ -711,7 +717,7 @@ bool mptcp_synack_options(const struct request_sock *re=
q, unsigned int *size,
 	return false;
 }
 =

-static bool check_fully_established(struct mptcp_sock *msk, struct sock *s=
k,
+static bool check_fully_established(struct mptcp_sock *msk, struct sock *s=
sk,
 				    struct mptcp_subflow_context *subflow,
 				    struct sk_buff *skb,
 				    struct mptcp_options_received *mp_opt)
@@ -728,15 +734,20 @@ static bool check_fully_established(struct mptcp_sock=
 *msk, struct sock *sk,
 		    TCP_SKB_CB(skb)->end_seq =3D=3D TCP_SKB_CB(skb)->seq &&
 		    subflow->mp_join && mp_opt->mp_join &&
 		    READ_ONCE(msk->pm.server_side))
-			tcp_send_ack(sk);
+			tcp_send_ack(ssk);
 		goto fully_established;
 	}
 =

-	/* we should process OoO packets before the first subflow is fully
-	 * established, but not expected for MP_JOIN subflows
+	/* we must process OoO packets before the first subflow is fully
+	 * established. OoO packets are instead a protocol violation
+	 * for MP_JOIN subflows as the peer must not send any data
+	 * before receiving the forth ack - cfr. RFC 8684 section 3.2.
 	 */
-	if (TCP_SKB_CB(skb)->seq !=3D subflow->ssn_offset + 1)
+	if (TCP_SKB_CB(skb)->seq !=3D subflow->ssn_offset + 1) {
+		if (subflow->mp_join)
+			goto reset;
 		return subflow->mp_capable;
+	}
 =

 	if (mp_opt->dss && mp_opt->use_ack) {
 		/* subflows are fully established as soon as we get any
@@ -748,9 +759,12 @@ static bool check_fully_established(struct mptcp_sock =
*msk, struct sock *sk,
 	}
 =

 	/* If the first established packet does not contain MP_CAPABLE + data
-	 * then fallback to TCP
+	 * then fallback to TCP. Fallback scenarios requires a reset for
+	 * MP_JOIN subflows.
 	 */
 	if (!mp_opt->mp_capable) {
+		if (subflow->mp_join)
+			goto reset;
 		subflow->mp_capable =3D 0;
 		pr_fallback(msk);
 		__mptcp_do_fallback(msk);
@@ -767,12 +781,16 @@ static bool check_fully_established(struct mptcp_sock=
 *msk, struct sock *sk,
 =

 	subflow->pm_notified =3D 1;
 	if (subflow->mp_join) {
-		clear_3rdack_retransmission(sk);
+		clear_3rdack_retransmission(ssk);
 		mptcp_pm_subflow_established(msk, subflow);
 	} else {
 		mptcp_pm_fully_established(msk);
 	}
 	return true;
+
+reset:
+	mptcp_subflow_reset(ssk);
+	return false;
 }
 =

 static u64 expand_ack(u64 old_ack, u64 cur_ack, bool use_64bit)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index aa0ab18d2e57..de5219fd3570 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -369,6 +369,7 @@ void mptcp_subflow_shutdown(struct sock *sk, struct soc=
k *ssk, int how);
 void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		       struct mptcp_subflow_context *subflow,
 		       long timeout);
+void mptcp_subflow_reset(struct sock *ssk);
 =

 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info =
*loc,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5ca8032e0d24..d2eb5f2abe5a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -271,6 +271,13 @@ static bool subflow_thmac_valid(struct mptcp_subflow_c=
ontext *subflow)
 	return thmac =3D=3D subflow->thmac;
 }
 =

+void mptcp_subflow_reset(struct sock *ssk)
+{
+	tcp_set_state(ssk, TCP_CLOSE);
+	tcp_send_active_reset(ssk, GFP_ATOMIC);
+	tcp_done(ssk);
+}
+
 static void subflow_finish_connect(struct sock *sk, const struct sk_buff *=
skb)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
@@ -343,8 +350,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 	return;
 =

 do_reset:
-	tcp_send_active_reset(sk, GFP_ATOMIC);
-	tcp_done(sk);
+	mptcp_subflow_reset(sk);
 }
 =

 struct request_sock_ops mptcp_subflow_request_sock_ops;
-- =

2.26.2

--===============7184134783202639679==--
