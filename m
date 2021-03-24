Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E76F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 13:16:18 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lP3Mv-0003lL-37; Wed, 24 Mar 2021 14:16:17 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: <mptcp@lists.01.org>,
	Florian Westphal <fw@strlen.de>
Subject: [RFC PATCH mptcp-next v2 5/8] mptcp: setsockopt: add SO_MARK support
Date: Wed, 24 Mar 2021 14:15:43 +0100
Message-Id: <20210324131546.13730-6-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210324131546.13730-1-fw@strlen.de>
References: <20210324131546.13730-1-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Value is synced to all subflows.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/sockopt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index f33a9ee12544..cb29013d7d74 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -66,6 +66,12 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 			ssk->sk_userlocks |= SOCK_RCVBUF_LOCK;
 			WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
 			break;
+		case SO_MARK:
+			if (READ_ONCE(ssk->sk_mark) != sk->sk_mark) {
+				ssk->sk_mark = sk->sk_mark;
+				sk_dst_reset(ssk);
+			}
+			break;
 		}
 
 		subflow->setsockopt_seq = msk->setsockopt_seq;
@@ -103,6 +109,7 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	case SO_KEEPALIVE:
 		mptcp_sol_socket_sync_intval(msk, optname, val);
 		return 0;
+	case SO_MARK:
 	case SO_PRIORITY:
 	case SO_SNDBUF:
 	case SO_SNDBUFFORCE:
@@ -193,6 +200,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_SNDBUFFORCE:
 	case SO_RCVBUF:
 	case SO_RCVBUFFORCE:
+	case SO_MARK:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
 	case SO_LINGER:
 		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
@@ -521,6 +529,11 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	} else {
 		sock_reset_flag(ssk, SOCK_LINGER);
 	}
+
+	if (sk->sk_mark != ssk->sk_mark) {
+		ssk->sk_mark = sk->sk_mark;
+		sk_dst_reset(ssk);
+	}
 }
 
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.26.3

