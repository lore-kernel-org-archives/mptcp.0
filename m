Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DFD6D13
	for <mptcp@lists.linux.dev>; Thu,  8 Apr 2021 18:50:08 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lUZjC-00016X-Ts; Thu, 08 Apr 2021 20:50:06 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp 04/10] mptcp: setsockopt: handle receive/send buffer and device bind
Date: Thu,  8 Apr 2021 20:49:30 +0200
Message-Id: <20210408184936.6245-5-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210408184936.6245-1-fw@strlen.de>
References: <20210408184936.6245-1-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to previous patch: needs to be mirrored to all subflows.

Device bind is simpler: it is only done on the initial (listener) sk.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/sockopt.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 43da4696336f..bd60c335d6aa 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -85,6 +85,16 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 		case SO_PRIORITY:
 			ssk->sk_priority = val;
 			break;
+		case SO_SNDBUF:
+		case SO_SNDBUFFORCE:
+			ssk->sk_userlocks |= SOCK_SNDBUF_LOCK;
+			WRITE_ONCE(ssk->sk_sndbuf, sk->sk_sndbuf);
+			break;
+		case SO_RCVBUF:
+		case SO_RCVBUFFORCE:
+			ssk->sk_userlocks |= SOCK_RCVBUF_LOCK;
+			WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
+			break;
 		}
 
 		subflow->setsockopt_seq = msk->setsockopt_seq;
@@ -123,6 +133,10 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 		mptcp_sol_socket_sync_intval(msk, optname, val);
 		return 0;
 	case SO_PRIORITY:
+	case SO_SNDBUF:
+	case SO_SNDBUFFORCE:
+	case SO_RCVBUF:
+	case SO_RCVBUFFORCE:
 		return mptcp_sol_socket_intval(msk, optname, val);
 	}
 
@@ -139,6 +153,8 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	switch (optname) {
 	case SO_REUSEPORT:
 	case SO_REUSEADDR:
+	case SO_BINDTODEVICE:
+	case SO_BINDTOIFINDEX:
 		lock_sock(sk);
 		ssock = __mptcp_nmpc_socket(msk);
 		if (!ssock) {
@@ -152,11 +168,19 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 				sk->sk_reuseport = ssock->sk->sk_reuseport;
 			else if (optname == SO_REUSEADDR)
 				sk->sk_reuse = ssock->sk->sk_reuse;
+			else if (optname == SO_BINDTODEVICE)
+				sk->sk_bound_dev_if = ssock->sk->sk_bound_dev_if;
+			else if (optname == SO_BINDTOIFINDEX)
+				sk->sk_bound_dev_if = ssock->sk->sk_bound_dev_if;
 		}
 		release_sock(sk);
 		return ret;
 	case SO_KEEPALIVE:
 	case SO_PRIORITY:
+	case SO_SNDBUF:
+	case SO_SNDBUFFORCE:
+	case SO_RCVBUF:
+	case SO_RCVBUFFORCE:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
 	}
 
@@ -460,6 +484,7 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 
 static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 {
+	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
 	struct sock *sk = (struct sock *)msk;
 
 	if (ssk->sk_prot->keepalive) {
@@ -470,6 +495,33 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	}
 
 	ssk->sk_priority = sk->sk_priority;
+	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
+	ssk->sk_incoming_cpu = sk->sk_incoming_cpu;
+
+	if (sk->sk_userlocks & tx_rx_locks) {
+		ssk->sk_userlocks |= sk->sk_userlocks & tx_rx_locks;
+		if (sk->sk_userlocks & SOCK_SNDBUF_LOCK)
+			WRITE_ONCE(ssk->sk_sndbuf, sk->sk_sndbuf);
+		if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
+			WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
+	}
+
+	if (sock_flag(sk, SOCK_LINGER)) {
+		ssk->sk_lingertime = sk->sk_lingertime;
+		sock_set_flag(ssk, SOCK_LINGER);
+	} else {
+		sock_reset_flag(ssk, SOCK_LINGER);
+	}
+
+	if (sk->sk_mark != ssk->sk_mark) {
+		ssk->sk_mark = sk->sk_mark;
+		sk_dst_reset(ssk);
+	}
+
+	sock_valbool_flag(ssk, SOCK_DBG, sock_flag(sk, SOCK_DBG));
+
+	if (inet_csk(sk)->icsk_ca_ops != inet_csk(ssk)->icsk_ca_ops)
+		tcp_set_congestion_control(ssk, inet_csk(sk)->icsk_ca_ops->name, false, true);
 }
 
 static void __mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.26.3

