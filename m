Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9876D13
	for <mptcp@lists.linux.dev>; Thu,  8 Apr 2021 18:50:26 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lUZjU-00017v-Sl; Thu, 08 Apr 2021 20:50:24 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp 08/10] mptcp: setsockopt: SO_DEBUG and no-op options
Date: Thu,  8 Apr 2021 20:49:34 +0200
Message-Id: <20210408184936.6245-9-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210408184936.6245-1-fw@strlen.de>
References: <20210408184936.6245-1-fw@strlen.de>
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
 net/mptcp/sockopt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 6be8abbed6eb..e7a710d1d1de 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -77,6 +77,9 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 		bool slow = lock_sock_fast(ssk);
 
 		switch (optname) {
+		case SO_DEBUG:
+			sock_valbool_flag(ssk, SOCK_DBG, !!val);
+			break;
 		case SO_KEEPALIVE:
 			if (ssk->sk_prot->keepalive)
 				ssk->sk_prot->keepalive(ssk, !!val);
@@ -150,6 +153,7 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	case SO_KEEPALIVE:
 		mptcp_sol_socket_sync_intval(msk, optname, val);
 		return 0;
+	case SO_DEBUG:
 	case SO_MARK:
 	case SO_PRIORITY:
 	case SO_SNDBUF:
@@ -246,9 +250,21 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
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
-- 
2.26.3

