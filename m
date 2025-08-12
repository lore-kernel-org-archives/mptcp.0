Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB562DECC6
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987184; cv=none; b=T2bfn7Zb0jJMMVKcvz830DNSknOMxhoIcCL8MRaZOqxbHi8D4eZvwht3ba0qDsLWh9BcCyUsGE1DTtg2aAzhU+faLLWdKiDWt83jkqKUr7yu7YpkyC2SPmgbFo39q31bbDX0LbdNADgmL8MsvU2Vxx0LMnFx2KsjytT7027ve20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987184; c=relaxed/simple;
	bh=fOSL+P7SXaMOUYWaJ2bZSr5gFszy4n5wCsvvBKv11Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MuhMQvdd742B3h9PjYpSbSaxuN3v9yD1Av3m1xUOsQyHvEObR1X32I3Daqa3fGDgHxoJ8DzFmYThc71qejDgC8woQP1ceMUOVfbbxbY4dJOwSucE+L89rMfrn+W2LN66MBfRrMKm0wpGXFgJV/3qUfzx1avQdXGO0S7khqpakx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifBcJfCk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifBcJfCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DD1C4CEF0;
	Tue, 12 Aug 2025 08:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754987184;
	bh=fOSL+P7SXaMOUYWaJ2bZSr5gFszy4n5wCsvvBKv11Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ifBcJfCkXadMBwiOgVcONw1YeD+nzZdtdy54Xwc6f8v3bAwGjIpBFvlHaMI7cm7AN
	 7aPTcIaMxJdK2klP9bVpim/hpIWre4qTfJKp3/ww4JbFremXtesAkWMWVQ0/B+Zc0h
	 eEy+b4uBaYeKQCUDIyge9XNhjRyWqkYxBzpQpVO3MG6GozgDboZa9dAieObQSr7Hsu
	 7eDmZHwQSJE5gJd0ocyQzUeR+pMpUbLYHo21wyRsqm57h7W4lAVJscPxkG164bPBgD
	 8wcLiUHeYDbOKkzpIE9KDlVO2x/mU2wUHgjUKcXfISc6nljksWvODRa3eJLSpGYcX8
	 oLOllEhVDJk8A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH mptcp-next v2 1/3] mptcp: add IPV6_TCLASS socket option support
Date: Tue, 12 Aug 2025 16:26:12 +0800
Message-ID: <2617b8684039574734b8622936ef126d6a7cd519.1754986785.git.tanggeliang@kylinos.cn>
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

Implement support for IPV6_TCLASS socket option in MPTCP:
1. setsockopt(IPV6_TCLASS):
   - Sets traffic class on main MPTCP socket
   - Propagates value to all IPv6 subflows
2. getsockopt(IPV6_TCLASS):
   - Returns current value from inet6_sk(sk)->tclass
3. Syncs traffic class to new subflows

Mirrors existing IPv4 TOS handling and ensures consistent QoS across
subflows. Fixes reported issues with traffic class propagation in MPTCP.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508021003.tEAjvv2S-lkp@intel.com/
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/568
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 5b0648ab663e..bb296813c578 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -458,6 +458,9 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_FREEBIND:
 		return mptcp_setsockopt_first_sf_only(msk, SOL_IPV6, optname,
 						      optval, optlen);
+	case IPV6_TCLASS:
+		return mptcp_setsockopt_all_sf(msk, SOL_IPV6, optname,
+					       optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -765,7 +768,7 @@ static int mptcp_setsockopt_sol_ip_first_sf_only(struct mptcp_sock *msk, int opt
 	return 0;
 }
 
-static int mptcp_setsockopt_sol_ip_all_sf(struct mptcp_sock *msk,
+static int mptcp_setsockopt_sol_ip_all_sf(struct mptcp_sock *msk, int level,
 					  int optname, sockptr_t optval,
 					  unsigned int optlen)
 {
@@ -773,10 +776,16 @@ static int mptcp_setsockopt_sol_ip_all_sf(struct mptcp_sock *msk,
 	struct sock *sk = (struct sock *)msk;
 	int err, val;
 
-	if (optname != IP_TOS)
+	if (optname != IP_TOS &&
+	    optname != IPV6_TCLASS)
 		return -EOPNOTSUPP;
 
-	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
+	if (level == SOL_IP)
+		err = ip_setsockopt(sk, level, optname, optval, optlen);
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else
+		err = ipv6_setsockopt(sk, level, optname, optval, optlen);
+#endif
 
 	if (err != 0)
 		return err;
@@ -785,6 +794,8 @@ static int mptcp_setsockopt_sol_ip_all_sf(struct mptcp_sock *msk,
 	sockopt_seq_inc(msk);
 	if (optname == IP_TOS)
 		val = READ_ONCE(inet_sk(sk)->tos);
+	else if (optname == IPV6_TCLASS)
+		val = READ_ONCE(inet6_sk(sk)->tclass);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow;
@@ -792,6 +803,8 @@ static int mptcp_setsockopt_sol_ip_all_sf(struct mptcp_sock *msk,
 		slow = lock_sock_fast(ssk);
 		if (optname == IP_TOS)
 			__ip_sock_set_tos(ssk, val);
+		else if (optname == IPV6_TCLASS)
+			WRITE_ONCE(inet6_sk(ssk)->tclass, val);
 		unlock_sock_fast(ssk, slow);
 	}
 	release_sock(sk);
@@ -885,7 +898,8 @@ static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
 		return mptcp_setsockopt_sol_tcp_all_sf(msk, optname,
 						       optval, optlen);
 	case SOL_IP:
-		return mptcp_setsockopt_sol_ip_all_sf(msk, optname,
+	case SOL_IPV6:
+		return mptcp_setsockopt_sol_ip_all_sf(msk, level, optname,
 						      optval, optlen);
 	}
 
@@ -1569,6 +1583,9 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_FREEBIND:
 		return mptcp_put_int_option(msk, optval, optlen,
 					    inet_test_bit(FREEBIND, sk));
+	case IPV6_TCLASS:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet6_sk(sk)->tclass);
 	}
 
 	return -EOPNOTSUPP;
@@ -1677,6 +1694,8 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
 	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
+	if (ssk->sk_family == AF_INET6)
+		WRITE_ONCE(inet6_sk(ssk)->tclass, READ_ONCE(inet6_sk(sk)->tclass));
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.48.1

