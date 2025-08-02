Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5CCE571
	for <mptcp@lists.linux.dev>; Sat,  2 Aug 2025 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754126408; cv=none; b=NAAWF0nTlUB9ic+qknvvWMb7xVWEPwGkRi5uEI4v3pt7gvo4DhkwTkek3Lv26aeoSYb1oJwyCFPoZlw72pkYuZABoiGjgYbVTYr0jn+sYpmBenO/T4HN8oWiSJPpwfdRnAcCRA2KlPd+4jMBvsc7ccEvn+ooB3ADqS7MPRC7n9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754126408; c=relaxed/simple;
	bh=JEfwSZb9HQjo0OZrUvC5KagnaR1iX5qNLQBUVmOyaY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkCN2/ZpyT8C7Dc5RiNoML3QuMjzfZ/n2IOMMnhiOV67xKTDnyNYc9rVlIfjigH7lKB70Y+zVUTr9TRKXMrJpgWCJj6ag4Chlu9Tae+Pci4NV6P8t8q/3z+5q8WyQRq1Lyxi9+6d/nGMj1n4sb0IAi67wDjiKLn2fn0q5i1Nm3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNoKYiHa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNoKYiHa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298C1C4CEFA;
	Sat,  2 Aug 2025 09:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754126407;
	bh=JEfwSZb9HQjo0OZrUvC5KagnaR1iX5qNLQBUVmOyaY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNoKYiHaqlqECzFYS0SDIefioWQs3DEAG27KWxd6GRvuw702fJ2Q477dX7mgmqto+
	 KG87umYcG6SMssPbfNiEEAUK2tYAAc9HtdyCf6CR2GmG2fmySHQAnzXz42aG6dAgZE
	 8VmcjV5aa0EG/KzE+wWk/FglpzHJKQDwW20HMnjpGSd9FfsavtRNJ8VPz84iIFm3ZD
	 BimWIrWvhirIBJ/nWpxerbcSOukMqQi2Z90BOfIJdJ/lIBqm0QdxUUYLLH3TtEOKVR
	 0ZP6sQLJMJ4NPYJcrzRb+/7S6H3QmzoBALckRR+qcwyhqvq3hgtbWWdI7aaAvsw6cO
	 lUV/l9tSiIHug==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/3] mptcp: add IPV6_UNICAST_HOPS sockopt support
Date: Sat,  2 Aug 2025 17:19:57 +0800
Message-ID: <0fd13a7bb3ca420a1e68f49fe93e7baada72890b.1754126092.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754126092.git.tanggeliang@kylinos.cn>
References: <cover.1754126092.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Implement setsockopt/getsockopt support for IPV6_UNICAST_HOPS in MPTCP:
1. Adds mptcp_setsockopt_v6_set_hops() to handle IPV6_UNICAST_HOPS:
   - Applies hop limit to the MPTCP socket
   - Propagates hop limit to all IPv6 subflows
   - Uses conditional compilation for CONFIG_MPTCP_IPV6
2. Adds getsockopt handler for IPV6_UNICAST_HOPS:
   - Retrieves hop limit from inet6_sk(sk)->hop_limit
   - Falls back to net->ipv6.devconf_all->hop_limit when not set
3. Syncs hop limit to new subflows in sync_socket_options()
4. Maintains option sequence counter for consistency

This enables applications to control IPv6 hop limits in MPTCP connections
using standard IPv6 socket options, ensuring consistent behavior across
all subflows.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/296
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index cc13006b5dc9..11663250bade 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -413,6 +413,34 @@ static int mptcp_setsockopt_v6_set_tclass(struct mptcp_sock *msk, int optname,
 	return 0;
 }
 
+static int mptcp_setsockopt_v6_set_hops(struct mptcp_sock *msk, int optname,
+					sockptr_t optval, unsigned int optlen)
+{
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int err, val;
+
+	err = ipv6_setsockopt(sk, SOL_IPV6, optname, optval, optlen);
+	if (err)
+		return err;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	val = READ_ONCE(inet6_sk(sk)->hop_limit);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast(ssk);
+		WRITE_ONCE(inet6_sk(ssk)->hop_limit, val);
+		unlock_sock_fast(ssk, slow);
+	}
+	release_sock(sk);
+#endif
+
+	return 0;
+}
 static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
@@ -457,6 +485,8 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 		break;
 	case IPV6_TCLASS:
 		return mptcp_setsockopt_v6_set_tclass(msk, optname, optval, optlen);
+	case IPV6_UNICAST_HOPS:
+		return mptcp_setsockopt_v6_set_hops(msk, optname, optval, optlen);
 	}
 
 	return ret;
@@ -1530,6 +1560,7 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 			       char __user *optval, int __user *optlen)
 {
 	struct sock *sk = (void *)msk;
+	int val;
 
 	switch (optname) {
 	case IPV6_V6ONLY:
@@ -1544,6 +1575,11 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_TCLASS:
 		return mptcp_put_int_option(msk, optval, optlen,
 					    inet6_sk(sk)->tclass);
+	case IPV6_UNICAST_HOPS:
+		val = READ_ONCE(inet6_sk(sk)->hop_limit);
+		if (val < 0)
+			val = READ_ONCE(sock_net(sk)->ipv6.devconf_all->hop_limit);
+		return mptcp_put_int_option(msk, optval, optlen, val);
 	}
 
 	return -EOPNOTSUPP;
@@ -1616,6 +1652,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	__ip_sock_set_tos(ssk, inet_sk(sk)->tos);
 	WRITE_ONCE(inet6_sk(ssk)->tclass, inet6_sk(sk)->tclass);
 	WRITE_ONCE(inet_sk(ssk)->uc_ttl, inet_sk(sk)->uc_ttl);
+	WRITE_ONCE(inet6_sk(ssk)->hop_limit, inet6_sk(sk)->hop_limit);
 
 	if (sk->sk_userlocks & tx_rx_locks) {
 		ssk->sk_userlocks |= sk->sk_userlocks & tx_rx_locks;
-- 
2.48.1

