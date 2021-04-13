Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8080D70
	for <mptcp@lists.linux.dev>; Tue, 13 Apr 2021 15:55:17 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lWLNk-0006sO-2l; Tue, 13 Apr 2021 17:55:16 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v2 07/10] mptcp: setsockopt: add SO_INCOMING_CPU
Date: Tue, 13 Apr 2021 17:54:44 +0200
Message-Id: <20210413155447.14043-8-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210413155447.14043-1-fw@strlen.de>
References: <20210413155447.14043-1-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replicate to all subflows.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/sockopt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1ad6092811e5..7eb637488dc2 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -101,6 +101,9 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 				sk_dst_reset(ssk);
 			}
 			break;
+		case SO_INCOMING_CPU:
+			WRITE_ONCE(ssk->sk_incoming_cpu, val);
+			break;
 		}
 
 		subflow->setsockopt_seq = msk->setsockopt_seq;
@@ -125,6 +128,15 @@ static int mptcp_sol_socket_intval(struct mptcp_sock *msk, int optname, int val)
 	return 0;
 }
 
+static void mptcp_so_incoming_cpu(struct mptcp_sock *msk, int val)
+{
+	struct sock *sk = (struct sock *)msk;
+
+	WRITE_ONCE(sk->sk_incoming_cpu, val);
+
+	mptcp_sol_socket_sync_intval(msk, SO_INCOMING_CPU, val);
+}
+
 static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 					   sockptr_t optval, unsigned int optlen)
 {
@@ -145,6 +157,9 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	case SO_RCVBUF:
 	case SO_RCVBUFFORCE:
 		return mptcp_sol_socket_intval(msk, optname, val);
+	case SO_INCOMING_CPU:
+		mptcp_so_incoming_cpu(msk, val);
+		return 0;
 	}
 
 	return -ENOPROTOOPT;
@@ -230,6 +245,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_RCVBUF:
 	case SO_RCVBUFFORCE:
 	case SO_MARK:
+	case SO_INCOMING_CPU:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
 	case SO_LINGER:
 		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
-- 
2.26.3

