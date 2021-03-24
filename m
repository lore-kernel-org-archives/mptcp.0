Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419406F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 13:16:27 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lP3N3-0003lb-Ff; Wed, 24 Mar 2021 14:16:25 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: <mptcp@lists.01.org>,
	Florian Westphal <fw@strlen.de>
Subject: [RFC PATCH mptcp-next v2 7/8] mptcp: setsockopt: SO_DEBUG and no-op options
Date: Wed, 24 Mar 2021 14:15:45 +0100
Message-Id: <20210324131546.13730-8-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210324131546.13730-1-fw@strlen.de>
References: <20210324131546.13730-1-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle SO_DEBUG and set it on all subflows.
Ignore those values not implemented on TCP sockets.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/sockopt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 6d59b25f3658..d345ebc3947a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -48,6 +48,9 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 		bool slow = lock_sock_fast(ssk);
 
 		switch (optname) {
+		case SO_DEBUG:
+			sock_valbool_flag(ssk, SOCK_DBG, !!val);
+			break;
 		case SO_KEEPALIVE:
 			if (ssk->sk_prot->keepalive)
 				ssk->sk_prot->keepalive(ssk, !!val);
@@ -121,6 +124,7 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	case SO_KEEPALIVE:
 		mptcp_sol_socket_sync_intval(msk, optname, val);
 		return 0;
+	case SO_DEBUG:
 	case SO_MARK:
 	case SO_PRIORITY:
 	case SO_SNDBUF:
@@ -217,9 +221,21 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_RCVBUFFORCE:
 	case SO_MARK:
 	case SO_INCOMING_CPU:
+	case SO_DEBUG:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
 	case SO_LINGER:
 		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
+	case SO_NO_CHECK:
+	case SO_DONTROUTE:
+	case SO_BROADCAST:
+	case SO_BSDCOMPAT:
+	case SO_PASSCRED:
+	case SO_PASSSEC:
+	case SO_RXQ_OVFL:
+	case SO_WIFI_STATUS:
+	case SO_NOFCS:
+	case SO_SELECT_ERR_QUEUE:
+		return 0;
 	}
 
 	return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optlen);
@@ -551,6 +567,8 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 		ssk->sk_mark = sk->sk_mark;
 		sk_dst_reset(ssk);
 	}
+
+	sock_valbool_flag(ssk, SOCK_DBG, sock_flag(sk, SOCK_DBG));
 }
 
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.26.3

