Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2295A6D0F
	for <mptcp@lists.linux.dev>; Tue, 13 Apr 2021 15:55:09 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lWLNb-0006rv-NU; Tue, 13 Apr 2021 17:55:07 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v2 05/10] mptcp: setsockopt: support SO_LINGER
Date: Tue, 13 Apr 2021 17:54:42 +0200
Message-Id: <20210413155447.14043-6-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210413155447.14043-1-fw@strlen.de>
References: <20210413155447.14043-1-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to PRIORITY/KEEPALIVE: needs to be mirrored to all subflows.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/sockopt.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index bfb9db04d26b..ee5d58747ce7 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -143,6 +143,47 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	return -ENOPROTOOPT;
 }
 
+static int mptcp_setsockopt_sol_socket_linger(struct mptcp_sock *msk, sockptr_t optval,
+					      unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	struct linger ling;
+	sockptr_t kopt;
+	int ret;
+
+	if (optlen < sizeof(ling))
+		return -EINVAL;
+
+	if (copy_from_sockptr(&ling, optval, sizeof(ling)))
+		return -EFAULT;
+
+	kopt = KERNEL_SOCKPTR(&ling);
+	ret = sock_setsockopt(sk->sk_socket, SOL_SOCKET, SO_LINGER, kopt, sizeof(ling));
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow = lock_sock_fast(ssk);
+
+		if (!ling.l_onoff) {
+			sock_reset_flag(ssk, SOCK_LINGER);
+		} else {
+			ssk->sk_lingertime = sk->sk_lingertime;
+			sock_set_flag(ssk, SOCK_LINGER);
+		}
+
+		subflow->setsockopt_seq = msk->setsockopt_seq;
+		unlock_sock_fast(ssk, slow);
+	}
+
+	release_sock(sk);
+	return 0;
+}
+
 static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 				       sockptr_t optval, unsigned int optlen)
 {
@@ -182,6 +223,8 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_RCVBUF:
 	case SO_RCVBUFFORCE:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
+	case SO_LINGER:
+		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
 	}
 
 	return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optlen);
-- 
2.26.3

