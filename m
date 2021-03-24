Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF2A6F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 13:16:10 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lP3Mm-0003l5-O7; Wed, 24 Mar 2021 14:16:08 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: <mptcp@lists.01.org>,
	Florian Westphal <fw@strlen.de>
Subject: [RFC PATCH mptcp-next v2 3/8] mptcp: setsockopt: handle receive/send buffer and device bind
Date: Wed, 24 Mar 2021 14:15:41 +0100
Message-Id: <20210324131546.13730-4-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210324131546.13730-1-fw@strlen.de>
References: <20210324131546.13730-1-fw@strlen.de>
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
 net/mptcp/sockopt.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index dd9e921018f8..f0a88753dfdf 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -56,6 +56,16 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
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
@@ -94,6 +104,10 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 		mptcp_sol_socket_sync_intval(msk, optname, val);
 		return 0;
 	case SO_PRIORITY:
+	case SO_SNDBUF:
+	case SO_SNDBUFFORCE:
+	case SO_RCVBUF:
+	case SO_RCVBUFFORCE:
 		return mptcp_sol_socket_intval(msk, optname, val);
 	}
 
@@ -110,6 +124,8 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	switch (optname) {
 	case SO_REUSEPORT:
 	case SO_REUSEADDR:
+	case SO_BINDTODEVICE:
+	case SO_BINDTOIFINDEX:
 		lock_sock(sk);
 		ssock = __mptcp_nmpc_socket(msk);
 		if (!ssock) {
@@ -123,11 +139,19 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
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
 
@@ -441,6 +465,12 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	}
 
 	ssk->sk_priority = sk->sk_priority;
+	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
+
+	if (sk->sk_userlocks & SOCK_SNDBUF_LOCK)
+		WRITE_ONCE(ssk->sk_sndbuf, sk->sk_sndbuf);
+	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
+		WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
 }
 
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.26.3

