Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34812E282C
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987188; cv=none; b=dt0tazaUSFq/IDzj5dsmk8qR1h/ApqOdJvNIoHdWHnNZtJavdHUU0bkaIm2wtnoei8vSt2p3ZTnX3cKzD+bcXwKiyV9IKxAL06cChveBBJeQRktp5mv8MOnAOoGmts06DJcY7r81HSh6/tm0ULgYNxTXesyjkPRsB8PLLdBWS9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987188; c=relaxed/simple;
	bh=x2jA7LsQq3fILl4EDA8dyzbgFdc4nPks5Vd9ehBiBbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3ZJ1TaImurePHZyG73biKg4rrnbxJmXlWMKgXtDSiAMdw9Vfx5oPa2NNcuxGwLm4tfSYYun9q318cTDhcaa4dsvHsVazMZYDTPvL+0nvSEHFevI580OYneGJqWf0PhYrClrSs3hITx8MAoXGq6P4aI+Phk5yvaYarUUCOpCwQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIZDWEtL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIZDWEtL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D90C4CEF4;
	Tue, 12 Aug 2025 08:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754987187;
	bh=x2jA7LsQq3fILl4EDA8dyzbgFdc4nPks5Vd9ehBiBbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIZDWEtLM+4pHfhgBKgaPVdjQBQfPrElZURbZt0/i4lMCHG8tlLQmEjM2G7J9LeWi
	 MUujq9DhO/CcFKzkttVd6oWBZpGx5T1VrL9Dy25vexhllfMFaBo48BfM/PT0OroVoI
	 yWMywpPiV7CL+JYaOxP/S1ybXYb80CzsG3ZqNiiU1FsGnnTtBX+u6zneab1Z3GwGWH
	 uFn/e2y4iiBAVLnTTpa2UCoh1VTRL0iinquM+PkNmbJ1UwCR3sGpE3XD0Vl6qK8ss3
	 Hw2E+SE73kTMqA6RfYrHrbPEL4WWHNYP5M/COiyoTTFQHPpNoQNUy1DxDsibiFk6Xy
	 hfRLKBWSdO0ig==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/3] mptcp: add IPV6_UNICAST_HOPS socket option support
Date: Tue, 12 Aug 2025 16:26:14 +0800
Message-ID: <51c833ad712205283262d980e5049d10280b697d.1754986785.git.tanggeliang@kylinos.cn>
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

Implement setsockopt/getsockopt for IPV6_UNICAST_HOPS in MPTCP:
1. setsockopt(IPV6_UNICAST_HOPS):
   - Sets hop limit on MPTCP socket
   - Propagates value to all IPv6 subflows
2. getsockopt(IPV6_UNICAST_HOPS):
   - Returns current hop limit (from inet6_sk or system default)
3. Syncs hop limit to new subflows
4. Uses conditional compilation for IPv6 support

Provides standard IPv6 hop limit control for MPTCP connections with
consistent behavior across subflows. Completes IPv6 socket option parity.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/296
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index ae9b376071c9..83071e5c608d 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -459,6 +459,7 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 		return mptcp_setsockopt_first_sf_only(msk, SOL_IPV6, optname,
 						      optval, optlen);
 	case IPV6_TCLASS:
+	case IPV6_UNICAST_HOPS:
 		return mptcp_setsockopt_all_sf(msk, SOL_IPV6, optname,
 					       optval, optlen);
 	}
@@ -777,7 +778,7 @@ static int mptcp_setsockopt_sol_ip_all_sf(struct mptcp_sock *msk, int level,
 	int err, val;
 
 	if (optname != IP_TOS && optname != IP_TTL &&
-	    optname != IPV6_TCLASS)
+	    optname != IPV6_TCLASS && optname != IPV6_UNICAST_HOPS)
 		return -EOPNOTSUPP;
 
 	if (level == SOL_IP)
@@ -798,6 +799,8 @@ static int mptcp_setsockopt_sol_ip_all_sf(struct mptcp_sock *msk, int level,
 		val = READ_ONCE(inet_sk(sk)->uc_ttl);
 	else if (optname == IPV6_TCLASS)
 		val = READ_ONCE(inet6_sk(sk)->tclass);
+	else if (optname == IPV6_UNICAST_HOPS)
+		val = READ_ONCE(inet6_sk(sk)->hop_limit);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow;
@@ -809,6 +812,8 @@ static int mptcp_setsockopt_sol_ip_all_sf(struct mptcp_sock *msk, int level,
 			WRITE_ONCE(inet_sk(ssk)->uc_ttl, val);
 		else if (optname == IPV6_TCLASS)
 			WRITE_ONCE(inet6_sk(ssk)->tclass, val);
+		else if (optname == IPV6_UNICAST_HOPS)
+			WRITE_ONCE(inet6_sk(ssk)->hop_limit, val);
 		unlock_sock_fast(ssk, slow);
 	}
 	release_sock(sk);
@@ -1583,6 +1588,7 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 			       char __user *optval, int __user *optlen)
 {
 	struct sock *sk = (void *)msk;
+	int val;
 
 	switch (optname) {
 	case IPV6_V6ONLY:
@@ -1597,6 +1603,13 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_TCLASS:
 		return mptcp_put_int_option(msk, optval, optlen,
 					    inet6_sk(sk)->tclass);
+	case IPV6_UNICAST_HOPS:
+		val = READ_ONCE(inet6_sk(sk)->hop_limit);
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+		if (val < 0)
+			val = READ_ONCE(sock_net(sk)->ipv6.devconf_all->hop_limit);
+#endif
+		return mptcp_put_int_option(msk, optval, optlen, val);
 	}
 
 	return -EOPNOTSUPP;
@@ -1706,8 +1719,10 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
 	WRITE_ONCE(inet_sk(ssk)->uc_ttl, READ_ONCE(inet_sk(sk)->uc_ttl));
-	if (ssk->sk_family == AF_INET6)
+	if (ssk->sk_family == AF_INET6) {
 		WRITE_ONCE(inet6_sk(ssk)->tclass, READ_ONCE(inet6_sk(sk)->tclass));
+		WRITE_ONCE(inet6_sk(ssk)->hop_limit, READ_ONCE(inet6_sk(sk)->hop_limit));
+	}
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.48.1

