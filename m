Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91E1E5729
	for <mptcp@lists.linux.dev>; Sat,  2 Aug 2025 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754120317; cv=none; b=AUBKv28E+PmqxRZmVyAobmE0HCCunufZiySkKL9GAEpZ8gX4G0KH2kHPpbx/KYVcQ6MiNzV+DBGd+jf1RvAa5I4ASxBwzMqKCnTSx5E1+f/SaQM0EdThjlee2S42DpNXquCcQK66qlEpFMf/ghVlRymDDfUf6vHY4N3kVrlTq5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754120317; c=relaxed/simple;
	bh=S80WTPrINUPLKJuHscgiHMRl66+MeiCTXHK9tXKoY9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1HPsjIiyPNhJHnarsmpE0JiYYMLCOE5mWvAxJxWeda2U37N0ZNBrOPHmf5qywN7sLcQSvdV2gBBvScsnT3A4yWewF0b9hTnXVv2Jz8idPCGVULcg4AofokAJ1fwE+Lvy/5+ZD1F0awaQNSJvHtfYeBx3icrCW5axnVK96rou6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVU40yim; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVU40yim"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8570AC4CEEF;
	Sat,  2 Aug 2025 07:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754120317;
	bh=S80WTPrINUPLKJuHscgiHMRl66+MeiCTXHK9tXKoY9k=;
	h=From:To:Cc:Subject:Date:From;
	b=KVU40yimi1+TELy3s/VQnyMQT44fimJeR+y+atYWCNe0pfA1Y5HDX+rFHpvbTVqWI
	 ooriRV7OU5WZUdV94oYt0+4kbOhlsblIvdwZLLiC0hvBo1Waug3wQCfGQD8M+D+m8t
	 hoI04xgBrB1JZaYeDfhOXPEYjSxA82NutTh7l7C3XUXR7XPGoJ6q2Q+YXnUi89aU0x
	 ibYbankUVObP9ekC+AXoMXvMXS5RwzRXojyYijCFVhP8YBPVl858gv+raq4UEdhG9Y
	 RerT0z9EmjDVV6nD5TLD8WZOLhW8yoT0ElNBQV19yi6RK+d/AW/v9esIVjfy1sabzs
	 OeowYNaPj2njg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH mptcp-next v2] mptcp: implement IPV6_TCLASS socket option support
Date: Sat,  2 Aug 2025 15:38:31 +0800
Message-ID: <ca2083bad7afa47302f362e75886d528c97aa5ce.1754120241.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds full support for the IPV6_TCLASS socket option in MPTCP,
ensuring consistent traffic class handling across all subflows.

Key changes:
1. setsockopt(IPV6_TCLASS):
   - First sets the traffic class value on the main MPTCP socket
   - Propagates the new value to all existing subflows
   - Uses lock synchronization to ensure atomic updates

2. getsockopt(IPV6_TCLASS):
   - Returns the current traffic class value stored in the main socket's
     inet6_sk structure

This implementation mirrors the existing IPv4 TOS handling (IP_TOS) and
ensures QoS settings are consistently applied to all underlying TCP
connections in the MPTCP session.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508021003.tEAjvv2S-lkp@intel.com/
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/568
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v2:
 - check CONFIG_MPTCP_IPV6 to fix the build error reported by kernel
   test robot.
---
 net/mptcp/sockopt.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 2c267aff95be..1d5b80caf507 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -384,6 +384,35 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
+static int mptcp_setsockopt_v6_set_tclass(struct mptcp_sock *msk, int optname,
+					  sockptr_t optval, unsigned int optlen)
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
+	val = READ_ONCE(inet6_sk(sk)->tclass);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast(ssk);
+		inet6_sk(ssk)->tclass = val;
+		unlock_sock_fast(ssk, slow);
+	}
+	release_sock(sk);
+#endif
+
+	return 0;
+}
+
 static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
@@ -426,6 +455,8 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
 		release_sock(sk);
 		break;
+	case IPV6_TCLASS:
+		return mptcp_setsockopt_v6_set_tclass(msk, optname, optval, optlen);
 	}
 
 	return ret;
@@ -1475,6 +1506,9 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_FREEBIND:
 		return mptcp_put_int_option(msk, optval, optlen,
 					    inet_test_bit(FREEBIND, sk));
+	case IPV6_TCLASS:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet6_sk(sk)->tclass);
 	}
 
 	return -EOPNOTSUPP;
-- 
2.48.1

