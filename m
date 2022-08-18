Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160C443F
	for <mptcp@lists.linux.dev>; Thu, 18 Aug 2022 16:55:32 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1oOiGy-00018b-1V; Thu, 18 Aug 2022 18:21:32 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH RFC mptcp] net: tcp: prevent transition to FIN_WAIT2 when mptcp has unacked data_fin
Date: Thu, 18 Aug 2022 18:21:23 +0200
Message-Id: <20220818162123.30198-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an mptcp connection closes down, a MPTCP-level DATA_FIN (flag in mp tcp
options) is sent.

We should wait until we can be sure the peer has received the mptcp-level ack of
that DATA_FIN.  Else, we can end up with the last mptcp subflow in FIN_WAIT2 state.

In that state, TCP won't respond to incoming ACK anymore, because no
progress happens from TCP point of view.

mptcp-packetdrill example:

// MPTCP sk moves to FIN_WAIT1, subflow remains in ESTABLISHED state:
+0.5   close(4) = 0
+0.0   >   .  2:2(0)  ack 1  win 256    <dss dack4=1 dsn8=2 ssn=0 dll=1 nocs fin, nop, nop>

// receive DATA_FIN ack. MPTCP sk moves to FIN_WAIT2, subflow remains in ESTABLISHED state.
+0.0  <  .  1:1(0)  ack 2  win 450    <dss dack4=3 dsn8=1 ssn=0 dll=0 nocs, nop, nop>

// Receive DATA_FIN.  MPTCP socket is removed, subflow sk moves to FIN_WAIT1.
+0.0  <  .  1:1(0)  ack 2  win 450    <dss dack4=3 dsn8=1 ssn=0 dll=1 nocs fin, nop, nop>

// acks the clients DATA_FIN, but packet might get lost
+0  >  .  2:2(0)  ack 1  win 256	<dss dack4=2 nocs>

// Receive DATA_FIN retransmission, subflow still in TCP_FIN1 state.
+0.01  <  .  1:1(0)  ack 1 win 450    <dss dack4=2 dsn8=1 ssn=0 dll=1 nocs fin, nop, nop>

+0  >  F.  2:2(0)  ack 1  win 256     <dss dack4=2 nocs>

// Ack the tcp-level fin but also retransmit the data fin.
// Note that we still claim mptcp-level dack4=2, i.e. the
// servers DATA_FIN remains unacked.

// Without this change, this 'ack 3' moves the subflow to FIN_WAIT2 state.
+0.0  < .  2:2(0)  ack 3 win 450    <dss dack4=2 dsn8=1 ssn=0 dll=1 nocs fin, nop, nop>
+0 > . 3:3(0) ack 1 win 256 <dss dack4=2 nocs>

// receive another retransmit of data fin...
+0.0  < .  2:2(0)  ack 3 win 450    <dss dack4=2 dsn8=1 ssn=0 dll=1 nocs fin, nop, nop>

// ... but without this patch, nothing happens, TW sk won't send anything.
// With this patch, the subflow remains in FIN_WAIT1 and replies with a DSS ack.
+0 > . 3:3(0) ack 1 win 256 <dss dack4=2 nocs>

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/181
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/mptcp.h  | 4 ++++
 net/ipv4/tcp_input.c | 5 +++++
 net/mptcp/subflow.c  | 8 ++++++++
 3 files changed, 17 insertions(+)

Full test case stashed here for the time being:
https://github.com/fw-strlen/packetdrill/commit/60a3f57ea309f910643e06dbf123236741c7f8d9

Its possible to either change tw_sk to have enough mptcp context to be
able to send a packet back, or we can supress/delay the tw_sock
transition.  This is what classic TCP is doing when it receives another
FIN while in FIN1 state.

This change makes the test case work (another dss ack is sent), but
there may be other corner cases where we need to delay the sk ->
tw_sk transition.

If the general idea looks ok, perhaps its better to replace

tcp_time_wait(sk, skb, ..

with a mptcp aware helper, e.g.  tcp_time_wait_check(sk, skb, ..
and place the option parsing for mptcp-subflows there?


diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 02ca83493470..de2249996671 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -152,6 +152,8 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info);
 
+bool mptcp_subflow_pending_data_fin_ack(const struct sock *ssk);
+
 /* move the skb extension owership, with the assumption that 'to' is
  * newly allocated
  */
@@ -297,6 +299,8 @@ static inline int mptcp_subflow_init_cookie_req(struct request_sock *req,
 }
 
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
+
+static inline bool mptcp_subflow_pending_data_fin_ack(const struct sock *ssk) { return false; }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ab5f0ea166f1..c3281e0cf9db 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6608,6 +6608,11 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			 * marginal case.
 			 */
 			inet_csk_reset_keepalive_timer(sk, tmo);
+		} else if (sk_is_mptcp(sk) &&
+			   mptcp_incoming_options(sk, skb) &&
+			   mptcp_subflow_pending_data_fin_ack(sk)) {
+				inet_csk_schedule_ack(sk);
+				inet_csk_reset_keepalive_timer(sk, tmo);
 		} else {
 			tcp_time_wait(sk, TCP_FIN_WAIT2, tmo);
 			goto consume;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c7d49fb6e7bd..d3e285bc45b8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -351,6 +351,14 @@ static bool subflow_thmac_valid(struct mptcp_subflow_context *subflow)
 	return thmac == subflow->thmac;
 }
 
+bool mptcp_subflow_pending_data_fin_ack(const struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct sock *sk = subflow->conn;
+
+	return READ_ONCE(mptcp_sk(sk)->rcv_data_fin);
+}
+
 void mptcp_subflow_reset(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-- 
2.35.1

