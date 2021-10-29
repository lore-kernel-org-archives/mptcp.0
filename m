Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6908E29CA
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 11:09:38 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mgPlQ-000891-Mi; Fri, 29 Oct 2021 13:09:36 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v3 1/2] mptcp: sockopt: add SOL_IP freebind & transparent options
Date: Fri, 29 Oct 2021 13:09:26 +0200
Message-Id: <20211029110927.12315-2-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211029110927.12315-1-fw@strlen.de>
References: <20211029110927.12315-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These options also need to be set before bind, so do the sync of msk to
new ssk socket a bit earlier.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 no changes
 net/mptcp/sockopt.c | 66 ++++++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/subflow.c |  3 ++-
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index b452571e8d9b..b818e91f2e09 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -390,6 +390,8 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case IPV6_V6ONLY:
+	case IPV6_TRANSPARENT:
+	case IPV6_FREEBIND:
 		lock_sock(sk);
 		ssock = __mptcp_nmpc_socket(msk);
 		if (!ssock) {
@@ -398,8 +400,24 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 		}
 
 		ret = tcp_setsockopt(ssock->sk, SOL_IPV6, optname, optval, optlen);
-		if (ret == 0)
+		if (ret != 0) {
+			release_sock(sk);
+			return ret;
+		}
+
+		sockopt_seq_inc(msk);
+
+		switch (optname) {
+		case IPV6_V6ONLY:
 			sk->sk_ipv6only = ssock->sk->sk_ipv6only;
+			break;
+		case IPV6_TRANSPARENT:
+			inet_sk(sk)->transparent = inet_sk(ssock->sk)->transparent;
+			break;
+		case IPV6_FREEBIND:
+			inet_sk(sk)->freebind = inet_sk(ssock->sk)->freebind;
+			break;
+		}
 
 		release_sock(sk);
 		break;
@@ -598,6 +616,46 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	return ret;
 }
 
+static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int optname,
+						   sockptr_t optval, unsigned int optlen)
+{
+	struct sock *sk = (struct sock *)msk;
+	struct inet_sock *issk;
+	struct socket *ssock;
+	int ret, err;
+
+	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
+	if (err != 0)
+		return err;
+
+	lock_sock(sk);
+
+	ssock = __mptcp_nmpc_socket(msk);
+	if (!ssock) {
+		release_sock(sk);
+		return -EINVAL;
+	}
+
+	issk = inet_sk(ssock->sk);
+
+	switch (optname) {
+	case IP_FREEBIND:
+		issk->freebind = inet_sk(sk)->freebind;
+		break;
+	case IP_TRANSPARENT:
+		issk->transparent = inet_sk(sk)->transparent;
+		break;
+	default:
+		release_sock(sk);
+		WARN_ON_ONCE(1);
+		return -EOPNOTSUPP;
+	}
+
+	sockopt_seq_inc(msk);
+	release_sock(sk);
+	return ret;
+}
+
 static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 				       sockptr_t optval, unsigned int optlen)
 {
@@ -627,6 +685,9 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
 	switch (optname) {
+	case IP_FREEBIND:
+	case IP_TRANSPARENT:
+		return mptcp_setsockopt_sol_ip_set_transparent(msk, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
 	}
@@ -1068,6 +1129,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
 	if (inet_csk(sk)->icsk_ca_ops != inet_csk(ssk)->icsk_ca_ops)
 		tcp_set_congestion_control(ssk, msk->ca_name, false, true);
+
+	inet_sk(ssk)->transparent = inet_sk(sk)->transparent;
+	inet_sk(ssk)->freebind = inet_sk(sk)->freebind;
 }
 
 static void __mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6172f380dfb7..72ccbd85941b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1425,6 +1425,8 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	if (addr.ss_family == AF_INET6)
 		addrlen = sizeof(struct sockaddr_in6);
 #endif
+	mptcp_sockopt_sync(msk, ssk);
+
 	ssk->sk_bound_dev_if = ifindex;
 	err = kernel_bind(sf, (struct sockaddr *)&addr, addrlen);
 	if (err)
@@ -1441,7 +1443,6 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
 
 	mptcp_add_pending_subflow(msk, subflow);
-	mptcp_sockopt_sync(msk, ssk);
 	err = kernel_connect(sf, (struct sockaddr *)&addr, addrlen, O_NONBLOCK);
 	if (err && err != -EINPROGRESS)
 		goto failed_unlink;
-- 
2.32.0

