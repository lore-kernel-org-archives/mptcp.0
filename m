Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED572E1C7E
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987186; cv=none; b=BU5PD3X8xFkGlKe9gepJWUZJ9WDKBmiPW3qXEgoy7sYSsTMbA1zPUEVyof7/srqjbvzB7wYfdpcg+nnPr2pck6QGl8TTiXhqN7I3Tz3KZl17ZgZp/J3CJXhwaMjyKzzGG5XjarxIPLZfNupuoa5XhUMgIxgoFznzZL5VAWxS7dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987186; c=relaxed/simple;
	bh=I5RtSXRacqiZpjDFnrA6ZmMGGoidkmPXje6AQM8fHWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dktj3LT35kzzCZHQxdEgBVIorSwrzEhqGVxg9rKVJ2D1nM3s4T6JjHW+HDRxDA1F36SWV+p90eoD7EmVgSGfajkSChEcIAxKWsZHfNDS9R/dcUs0gDTRWEG6n8gXN3LTuYh8xq5hFTgFJRgrdvivaolWY8yD+mN1oVOON++LxA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHp2Oexw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHp2Oexw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F9AC4CEF0;
	Tue, 12 Aug 2025 08:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754987185;
	bh=I5RtSXRacqiZpjDFnrA6ZmMGGoidkmPXje6AQM8fHWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iHp2OexwB3T94iqai6dx7kX/x/5HMlKSEKzulNLkdCSjWKvMoN4tktSEBWk889MLf
	 9EKQgZW71o/qNp8+WpO+2QewMaRxDNN4KNpSGk9dqaWGTswntBHkZGHi8G/+CXtan6
	 MDjQeji0VKFJXEz6hEAbszVst/RAakh5F17I9+jswOZvhm4qTq7nWYmJFKInQ7DYBL
	 i+SiwyeMY+wO0+m1KpEeHm4NwHsPbjfKPUAEJSARPyjdndzZmyjBBUlSrxNzfJeMJm
	 YlYt17qsOcqmzoJMnyLz8f2shN6964kP9ND9KVaMoxTOjb0Inji5z8UuvDm+ybhKuf
	 dbcjGemVVwPxQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/3] mptcp: add IP_TTL socket option support
Date: Tue, 12 Aug 2025 16:26:13 +0800
Message-ID: <80bc3cad279b6fadef53fd399301194ea41c13bd.1754986785.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754986785.git.tanggeliang@kylinos.cn>
References: <cover.1754986785.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Implement setsockopt/getsockopt for IP_TTL in MPTCP:
1. setsockopt(IP_TTL):
   - Applies TTL to MPTCP socket
   - Propagates TTL to all subflows
2. getsockopt(IP_TTL):
   - Returns current TTL from inet_sk(sk)->uc_ttl
   - Falls back to sysctl_ip_default_ttl when unset
3. Syncs TTL to new subflows
4. Maintains option sequence counters

Enables applications to control IPv4 TTL settings consistently across
all subflows. Resolves outstanding requests for TTL support in MPTCP.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/296
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index bb296813c578..ae9b376071c9 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -776,7 +776,7 @@ static int mptcp_setsockopt_sol_ip_all_sf(struct mptcp_sock *msk, int level,
 	struct sock *sk = (struct sock *)msk;
 	int err, val;
 
-	if (optname != IP_TOS &&
+	if (optname != IP_TOS && optname != IP_TTL &&
 	    optname != IPV6_TCLASS)
 		return -EOPNOTSUPP;
 
@@ -794,6 +794,8 @@ static int mptcp_setsockopt_sol_ip_all_sf(struct mptcp_sock *msk, int level,
 	sockopt_seq_inc(msk);
 	if (optname == IP_TOS)
 		val = READ_ONCE(inet_sk(sk)->tos);
+	else if (optname == IP_TTL)
+		val = READ_ONCE(inet_sk(sk)->uc_ttl);
 	else if (optname == IPV6_TCLASS)
 		val = READ_ONCE(inet6_sk(sk)->tclass);
 	mptcp_for_each_subflow(msk, subflow) {
@@ -803,6 +805,8 @@ static int mptcp_setsockopt_sol_ip_all_sf(struct mptcp_sock *msk, int level,
 		slow = lock_sock_fast(ssk);
 		if (optname == IP_TOS)
 			__ip_sock_set_tos(ssk, val);
+		else if (optname == IP_TTL)
+			WRITE_ONCE(inet_sk(ssk)->uc_ttl, val);
 		else if (optname == IPV6_TCLASS)
 			WRITE_ONCE(inet6_sk(ssk)->tclass, val);
 		unlock_sock_fast(ssk, slow);
@@ -822,6 +826,7 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 	case IP_LOCAL_PORT_RANGE:
 		return mptcp_setsockopt_first_sf_only(msk, SOL_IP, optname, optval, optlen);
 	case IP_TOS:
+	case IP_TTL:
 		return mptcp_setsockopt_all_sf(msk, SOL_IP, optname, optval, optlen);
 	}
 
@@ -1547,6 +1552,7 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 			       char __user *optval, int __user *optlen)
 {
 	struct sock *sk = (void *)msk;
+	int val;
 
 	switch (optname) {
 	case IP_TOS:
@@ -1563,6 +1569,11 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 	case IP_LOCAL_PORT_RANGE:
 		return mptcp_put_int_option(msk, optval, optlen,
 				READ_ONCE(inet_sk(sk)->local_port_range));
+	case IP_TTL:
+		val = READ_ONCE(inet_sk(sk)->uc_ttl);
+		if (val < 0)
+			val = READ_ONCE(sock_net(sk)->ipv4.sysctl_ip_default_ttl);
+		return mptcp_put_int_option(msk, optval, optlen, val);
 	}
 
 	return -EOPNOTSUPP;
@@ -1694,6 +1705,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
 	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
+	WRITE_ONCE(inet_sk(ssk)->uc_ttl, READ_ONCE(inet_sk(sk)->uc_ttl));
 	if (ssk->sk_family == AF_INET6)
 		WRITE_ONCE(inet6_sk(ssk)->tclass, READ_ONCE(inet6_sk(sk)->tclass));
 }
-- 
2.48.1

