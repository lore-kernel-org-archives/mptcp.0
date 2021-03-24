Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D543E6F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 13:16:22 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lP3Mz-0003lT-94; Wed, 24 Mar 2021 14:16:21 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: <mptcp@lists.01.org>,
	Florian Westphal <fw@strlen.de>
Subject: [RFC PATCH mptcp-next v2 6/8] mptcp: setsockopt: add SO_INCOMING_CPU
Date: Wed, 24 Mar 2021 14:15:44 +0100
Message-Id: <20210324131546.13730-7-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210324131546.13730-1-fw@strlen.de>
References: <20210324131546.13730-1-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replicate to all subflows.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/sockopt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index cb29013d7d74..6d59b25f3658 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -72,6 +72,9 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 				sk_dst_reset(ssk);
 			}
 			break;
+		case SO_INCOMING_CPU:
+			WRITE_ONCE(ssk->sk_incoming_cpu, val);
+			break;
 		}
 
 		subflow->setsockopt_seq = msk->setsockopt_seq;
@@ -96,6 +99,15 @@ static int mptcp_sol_socket_intval(struct mptcp_sock *msk, int optname, int val)
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
@@ -116,6 +128,9 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	case SO_RCVBUF:
 	case SO_RCVBUFFORCE:
 		return mptcp_sol_socket_intval(msk, optname, val);
+	case SO_INCOMING_CPU:
+		mptcp_so_incoming_cpu(msk, val);
+		return 0;
 	}
 
 	return -ENOPROTOOPT;
@@ -201,6 +216,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_RCVBUF:
 	case SO_RCVBUFFORCE:
 	case SO_MARK:
+	case SO_INCOMING_CPU:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
 	case SO_LINGER:
 		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
@@ -517,6 +533,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
 	ssk->sk_priority = sk->sk_priority;
 	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
+	ssk->sk_incoming_cpu = sk->sk_incoming_cpu;
 
 	if (sk->sk_userlocks & SOCK_SNDBUF_LOCK)
 		WRITE_ONCE(ssk->sk_sndbuf, sk->sk_sndbuf);
-- 
2.26.3

