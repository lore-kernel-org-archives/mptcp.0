Content-Type: multipart/mixed; boundary="===============9106224968495261383=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 4/12] Squash-to: "mptcp: Add handling of outgoing
 MP_JOIN requests"
Date: Thu, 05 Mar 2020 15:46:41 +0100
Message-ID: <e81a24968586ed1211f70910f5d1fd6c1597b4b0.1583418572.git.pabeni@redhat.com>
In-Reply-To: cover.1583418571.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3877

--===============9106224968495261383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Schedule 3rd ack retransmission via delack timer, and clear
it on fully established event

v1 -> v2:
 - clarified some comments (Mat)
 - reordered expression to detect 3rd ack for clarity (Mat)
 - dropped duplicate comment (Mat)

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 67 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0e3e273131c4..5b61fd78c01c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -341,6 +341,38 @@ void mptcp_rcv_synsent(struct sock *sk)
 	}
 }
 =

+/* MP_JOIN client subflow must wait for 4th ack before sending any data:
+ * TCP can't schedule delack timer before the subflow is fully established.
+ * MPTCP uses the delack timer to do 3rd ack retransmissions
+ */
+static void schedule_3rdack_retransmission(struct sock *sk)
+{
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	unsigned long timeout;
+
+	/* reschedule with a timeout above RTT, as we must look only for drop */
+	if (tp->srtt_us)
+		timeout =3D tp->srtt_us << 1;
+	else
+		timeout =3D TCP_TIMEOUT_INIT;
+
+	WARN_ON_ONCE(icsk->icsk_ack.pending & ICSK_ACK_TIMER);
+	icsk->icsk_ack.pending |=3D ICSK_ACK_SCHED | ICSK_ACK_TIMER;
+	icsk->icsk_ack.timeout =3D timeout;
+	sk_reset_timer(sk, &icsk->icsk_delack_timer, timeout);
+}
+
+static void clear_3rdack_retransmission(struct sock *sk)
+{
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
+
+	sk_stop_timer(sk, &icsk->icsk_delack_timer);
+	icsk->icsk_ack.timeout =3D 0;
+	icsk->icsk_ack.ato =3D 0;
+	icsk->icsk_ack.pending &=3D ~(ICSK_ACK_SCHED | ICSK_ACK_TIMER);
+}
+
 static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *=
skb,
 					 unsigned int *size,
 					 unsigned int remaining,
@@ -350,17 +382,21 @@ static bool mptcp_established_options_mp(struct sock =
*sk, struct sk_buff *skb,
 	struct mptcp_ext *mpext;
 	unsigned int data_len;
 =

-	pr_debug("subflow=3D%p fully established=3D%d seq=3D%x:%x remaining=3D%d",
-		 subflow, subflow->fully_established, subflow->snd_isn,
-		 skb ? TCP_SKB_CB(skb)->seq : 0, remaining);
+	/* When skb is not available, we better over-estimate the emitted
+	 * options len. A full DSS option (28 bytes) is longer than
+	 * TCPOLEN_MPTCP_MPC_ACK_DATA(22) or TCPOLEN_MPTCP_MPJ_ACK(24), so
+	 * tell the caller to defer the estimate to
+	 * mptcp_established_options_dss(), which will reserve enough space.
+	 */
+	if (!skb)
+		return false;
 =

-	if (subflow->mp_capable && !subflow->fully_established && skb &&
-	    subflow->snd_isn =3D=3D TCP_SKB_CB(skb)->seq) {
-		/* When skb is not available, we better over-estimate the
-		 * emitted options len. A full DSS option is longer than
-		 * TCPOLEN_MPTCP_MPC_ACK_DATA, so let's the caller try to fit
-		 * that.
-		 */
+	/* MPC/MPJ needed only on 3rd ack packet */
+	if (subflow->fully_established ||
+	    subflow->snd_isn !=3D TCP_SKB_CB(skb)->seq)
+		return false;
+
+	if (subflow->mp_capable) {
 		mpext =3D mptcp_get_ext(skb);
 		data_len =3D mpext ? mpext->data_len : 0;
 =

@@ -388,12 +424,13 @@ static bool mptcp_established_options_mp(struct sock =
*sk, struct sk_buff *skb,
 			 data_len);
 =

 		return true;
-	} else if (subflow->mp_join && !subflow->fourth_ack) {
+	} else if (subflow->mp_join) {
 		opts->suboptions =3D OPTION_MPTCP_MPJ_ACK;
 		memcpy(opts->hmac, subflow->hmac, MPTCPOPT_HMAC_LEN);
 		*size =3D TCPOLEN_MPTCP_MPJ_ACK;
-		subflow->fourth_ack =3D 1;
 		pr_debug("subflow=3D%p", subflow);
+
+		schedule_3rdack_retransmission(sk);
 		return true;
 	}
 	return false;
@@ -633,10 +670,12 @@ static bool check_fully_established(struct mptcp_sock=
 *msk, struct sock *sk,
 		return true;
 =

 	subflow->pm_notified =3D 1;
-	if (subflow->mp_join)
+	if (subflow->mp_join) {
+		clear_3rdack_retransmission(sk);
 		mptcp_pm_subflow_established(msk, subflow);
-	else
+	} else {
 		mptcp_pm_fully_established(msk);
+	}
 	return true;
 }
 =

-- =

2.21.1

--===============9106224968495261383==--
