Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB60E571
	for <mptcp@lists.linux.dev>; Sat,  2 Aug 2025 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754126406; cv=none; b=dntDJ5+krV6bb+1nmxhkgGEGge4rDTxSMC4hmdlxNwSSlnXv7fygZiMLSsTXEG6uOa/WqDxfguNUX9jHAUn+42cqNCPPEIGf95uYctR0VG2xduwxvJA+KLZ7P05+yLgx+m6+podRS+0iTniCWVNS/1cqyjgvC4Pftqum7oVhrJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754126406; c=relaxed/simple;
	bh=nis7Lsic0+Q3DLwJHo6YTCytDVXcdWUG//OuLkxEz4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K07PU+FcyZDYoY0B1lRiiM9bKIPpfw03kBgQTAplTd5LzpTLcQIfbh8Di0Z1NMBTQgoyiI7zSdubSJWbnGlxoFa+jZ/VJlpwXCOQIzyHlncfpeIR8QLaioJpjXExDfo+Qaxw8W/2iQDlqKkbTm0ODKLJLGAtmv4bpm9+7P9X5Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jevLol6A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jevLol6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AA3C4CEF8;
	Sat,  2 Aug 2025 09:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754126405;
	bh=nis7Lsic0+Q3DLwJHo6YTCytDVXcdWUG//OuLkxEz4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jevLol6AohzX18WENwb0BnwfVEs1gHLZ5bms3AQLsjSZpXBmQW3Uby86voGvq6LgR
	 B/LmJZYe8ef4ZVigQdSDZJ4NN52Sy6HH2+cGzox6xawylt4g7lQl2ABOKKNtcMibjo
	 fwK5/hs2JAYa5Y+b4TFMJXeOQWE7i34TCn1mqgMjkyv1rjVw8SNv9jICTQ+2cWiRSZ
	 xZJKTxKFO02VHwGxU3upbbdfFzn1XtYxQwP+xYMazmUDQGiv6XdXgLFS9aTpMWxxeZ
	 jglNw3FTwPyQ7ora+0mPrttrM5NOLZYBtv+5VDXvlm+6XKxcCZrv2VDz/D1Y0Aus9N
	 ErDjjZSKfTsuw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH mptcp-next 1/3] mptcp: add IPV6_TCLASS sockopt support
Date: Sat,  2 Aug 2025 17:19:55 +0800
Message-ID: <19d4a7b3f07a5dbd703abb2ce7fb511aa8e5f2ee.1754126092.git.tanggeliang@kylinos.cn>
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
 net/mptcp/sockopt.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 2c267aff95be..b4ccc0acadae 100644
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
+		WRITE_ONCE(inet6_sk(ssk)->tclass, val);
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
@@ -1545,6 +1579,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	ssk->sk_incoming_cpu = sk->sk_incoming_cpu;
 	ssk->sk_ipv6only = sk->sk_ipv6only;
 	__ip_sock_set_tos(ssk, inet_sk(sk)->tos);
+	WRITE_ONCE(inet6_sk(ssk)->tclass, inet6_sk(sk)->tclass);
 
 	if (sk->sk_userlocks & tx_rx_locks) {
 		ssk->sk_userlocks |= sk->sk_userlocks & tx_rx_locks;
-- 
2.48.1

