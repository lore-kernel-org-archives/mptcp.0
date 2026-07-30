Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C3837A498
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 02:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380066; cv=none; b=SoJgLgPEB64ST74o+Y6LZeW9XAKd7NuuiWhqGMa972tEnRYnqZoLaUePqIDXur+GjgBNdLCxcm4tvkFizfEvFgO6ZstLwRyDcYBSbsxuA6c2EnZgjPSLevWvGCs4ZqbrFP/gygwMK9U5Ilfk3s9syRKgT2jW/yymU8lVQNXCnQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380066; c=relaxed/simple;
	bh=rwu8deKZGVe8SmyWi/hEuHJiiVBpvG7ZAk6fqto/KcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhYk91uxMzJsgPilpLb3miT6bTKc4ItuGZnM2SPcT0Rnh27hjbUEGnkPK8tqisS1MSXjUMoBeKtsu12jYHazqIkxH0uKTQAehX68bP9eYsY2ZBgumQOmr7rTkiVvT8K8e5MNrj5l22/i7qboDdZbRQvhVrk1+S+E6HcJoewDFPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHRy1vSO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHRy1vSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F7D1F000E9;
	Thu, 30 Jul 2026 02:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785380064;
	bh=XDX0U+/iVtt01S16tIoLgpUE3pgRThp7Vr4ImZoK42I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZHRy1vSOShrUDmwGppg8V8qRMZoMV4X/HFXz5DO0tLsSHCc40lBgmD4l2Jx/IOC/v
	 KHfwDlwbtXEqpvz7sfAaJOujpkDmrk5sHdoXXH863npKedxRK3gtYl3OVKtnoDbqQA
	 QPK5xY0WobTpTDeTSZyvmIaJWoatZKNflLFl/DO1mZOGXw7qgfKjk0XJLVgAi/QoFD
	 hMAy/Puu2m30xev/ouF3mDnz85QFlPZRRixx1Zlf8OUT/RlSYtYHp5TcgYokO0xwk+
	 O9huxadCEuQUVaOhtqhPa31oxkg6KwaxSy+72NCrVKHv6Imgrkmo4tqsxjHE/vENaM
	 yHKLA0iRFXkog==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: David 'equinox' Lamparter <equinox@diac24.net>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v4 06/10] mptcp: sockopt: implement IPV6_TCLASS
Date: Thu, 30 Jul 2026 10:53:59 +0800
Message-ID: <99dba4119e87c33b1da6055042efcacddf115419.1785378180.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785378180.git.tanggeliang@kylinos.cn>
References: <cover.1785378180.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David 'equinox' Lamparter <equinox@diac24.net>

The IPV6_TCLASS setsockopt just needs to be forwarded to the individual
TCP sockets, like IP_TOS is already handled for IPv4.

Coincidentally, ssh uses this sockopt and prints an error in the middle
of your ongoing SSH session when it doesn't work (very annoying when
doing SCP/SFTP on a multiplexed session.)

For setsockopt, the value is first applied to the MPTCP socket itself via
ipv6_setsockopt(), then propagated to all existing subflows using
__ip6_sock_set_tclass(). The setsockopt_seq is bumped to ensure that
subflows created later will pick up the setting through
sync_socket_options().

For getsockopt, the value is read directly from the MPTCP socket.

Also add sync_socket_options() support for IPV6_TCLASS, so that new
subflows created after the option is set inherit the correct tclass
value.

Cc: Mat Martineau <martineau@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>
Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/568
Signed-off-by: David 'equinox' Lamparter <equinox@diac24.net>
---
 net/mptcp/sockopt.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 3dbf8d27005c..676268f922b1 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -396,6 +396,42 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
+static int mptcp_setsockopt_v6_set_tclass(struct mptcp_sock *msk, int optname,
+					  sockptr_t optval, unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int err, val;
+
+	if (sk->sk_family != AF_INET6)
+		return -EOPNOTSUPP;
+
+	err = ipv6_setsockopt(sk, SOL_IPV6, optname, optval, optlen);
+
+	if (err != 0)
+		return err;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	val = READ_ONCE(inet6_sk(sk)->tclass);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		if (ssk->sk_family != AF_INET6)
+			continue;
+
+		slow = lock_sock_fast(ssk);
+		__ip6_sock_set_tclass(ssk, val);
+		unlock_sock_fast(ssk, slow);
+	}
+	release_sock(sk);
+
+	return 0;
+}
+#endif
+
 static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
@@ -438,6 +474,11 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
 		release_sock(sk);
 		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case IPV6_TCLASS:
+		return mptcp_setsockopt_v6_set_tclass(msk, optname, optval,
+						      optlen);
+#endif
 	}
 
 	return ret;
@@ -1505,6 +1546,13 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_FREEBIND:
 		return mptcp_put_int_option(msk, optval, optlen,
 					    inet_test_bit(FREEBIND, sk));
+#if IS_ENABLED(CONFIG_IPV6)
+	case IPV6_TCLASS:
+		if (sk->sk_family != AF_INET6)
+			return -EOPNOTSUPP;
+		return mptcp_put_int_option(msk, optval, optlen,
+					    READ_ONCE(inet6_sk(sk)->tclass));
+#endif
 	}
 
 	return -EOPNOTSUPP;
@@ -1619,6 +1667,10 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	syncnt = READ_ONCE(inet_csk(sk)->icsk_syn_retries);
 	if (syncnt > 0 && tcp_sock_set_syncnt(ssk, syncnt))
 		pr_warn("Failed to sync TCP_SYNCNT=%u to subflow\n", syncnt);
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family == AF_INET6 && ssk->sk_family == AF_INET6)
+		__ip6_sock_set_tclass(ssk, READ_ONCE(inet6_sk(sk)->tclass));
+#endif
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.53.0

