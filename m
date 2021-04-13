Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5122270
	for <mptcp@lists.linux.dev>; Tue, 13 Apr 2021 15:55:13 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lWLNf-0006s5-Sq; Tue, 13 Apr 2021 17:55:11 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v2 06/10] mptcp: setsockopt: add SO_MARK support
Date: Tue, 13 Apr 2021 17:54:43 +0200
Message-Id: <20210413155447.14043-7-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210413155447.14043-1-fw@strlen.de>
References: <20210413155447.14043-1-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Value is synced to all subflows.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/sockopt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index ee5d58747ce7..1ad6092811e5 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -95,6 +95,12 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
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
@@ -132,6 +138,7 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	case SO_KEEPALIVE:
 		mptcp_sol_socket_sync_intval(msk, optname, val);
 		return 0;
+	case SO_MARK:
 	case SO_PRIORITY:
 	case SO_SNDBUF:
 	case SO_SNDBUFFORCE:
@@ -222,6 +229,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_SNDBUFFORCE:
 	case SO_RCVBUF:
 	case SO_RCVBUFFORCE:
+	case SO_MARK:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
 	case SO_LINGER:
 		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
-- 
2.26.3

