Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB552F2A
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 16:53:47 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1nlZ2E-0000lO-Ed; Mon, 02 May 2022 18:36:30 +0200
From: Florian Westphal <fw@strlen.de>
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next] mptcp: sockopt: add TCP_DEFER_ACCEPT support
Date: Mon,  2 May 2022 18:36:24 +0200
Message-Id: <20220502163624.6110-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support this via passthrough to the underlaying tcp listener socket.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/271
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/sockopt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 826b0c1dae98..423d3826ca1e 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -756,6 +756,18 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
+static int mptcp_setsockopt_sol_tcp_defer(struct mptcp_sock *msk, sockptr_t optval,
+					  unsigned int optlen)
+{
+	struct socket *listener;
+
+	listener = __mptcp_nmpc_socket(msk);
+	if (!listener)
+		return 0; /* TCP_DEFER_ACCEPT does not fail */
+
+	return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT, optval, optlen);
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -782,6 +794,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_setsockopt_sol_tcp_cork(msk, optval, optlen);
 	case TCP_NODELAY:
 		return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
+	case TCP_DEFER_ACCEPT:
+		return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -1142,6 +1156,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_CONGESTION:
 	case TCP_INFO:
 	case TCP_CC_INFO:
+	case TCP_DEFER_ACCEPT:
 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
 	case TCP_INQ:
-- 
2.35.1

