Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903D537E5F2
	for <mptcp@lists.linux.dev>; Sat,  8 Aug 2026 03:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786160493; cv=none; b=rGXwxZXNQ0JCoTU/aYgD/+iPOMCdlfgJTClegDo1pFQpDFtzyy62I/WoqbK0jXMEOMbRfxajf7vMHDILJygwvXVNZZP4rYBJDZHwuA5eBe5jRvyovekOkdp0JW3qyi98dFjS/P3xTTAZ7vMCiF5uI2ck4Oz7i6gPBm57QOaJWOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786160493; c=relaxed/simple;
	bh=qPOS48vWO0ThFPApFseoiG0gsENX1eZurcq3WKwTBwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9tTIH/xh9Oto1K7Sl0fdg/sOob5hOJKT+bfRIFNZXMzy4MDYRdVwo+KcqadDQm7me2F9Ohoh+iIVnJsIl4xJsP90aNEvHmYZt2zQlnFCpgmA9GqOVoLIqfmc5uYFs2TtOHcej+vLIt8SmN80QPbwlVbzWhiKDio6tVjkVTitik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZX/1Ttkb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZX/1Ttkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FDF1F000E9;
	Sat,  8 Aug 2026 03:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786160491;
	bh=V4CSAw6pqeeeL5RmCbjsXgbGLccOBcQ2NxtKW14BdzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZX/1TtkbL1QxFkjlnHAE3qerG8ajS1v2dq3lvZBwzhO4/ElHf21Q4ri7q8R1jncaZ
	 rb1xV9s6etRLHhRmy31rhbdzRy+ffllmWUELZRETcsgvh8qe2AKm4Ry2/hYasvitY9
	 uaHgvY9ikIVPgM2KOkB+hRImeE+FzMgg4d/ZeWPH27b5H/qE9emK8ZCyKvtgyvOi+P
	 KZVMsrTbwf3+D9BnIq+8MCWjLlVzz2NY72j8kPgnbSk7y3q0up+St3fHe+gk7ro7kH
	 3GcOunLn37SKnXvZEU9N4ZGw/A7vLw/k2fG8NWuFvTLDw8lBEeqBiocMFqnFhXr2c2
	 I+tbLvEnl5i8A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: David 'equinox' Lamparter <equinox@diac24.net>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v5 08/11] mptcp: sockopt: implement IPV6_TCLASS
Date: Sat,  8 Aug 2026 11:40:38 +0800
Message-ID: <819f1fcd22f08a0b294b9a211d13da9fee94ec4b.1786159812.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786159812.git.tanggeliang@kylinos.cn>
References: <cover.1786159812.git.tanggeliang@kylinos.cn>
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
index 43a8d1c37137..ac326e3f289e 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -485,6 +485,42 @@ static int mptcp_setsockopt_recverr(struct mptcp_sock *msk, int level,
 	return ret;
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
@@ -532,6 +568,11 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 		ret = mptcp_setsockopt_recverr(msk, SOL_IPV6, optname, optval,
 					       optlen);
 		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case IPV6_TCLASS:
+		return mptcp_setsockopt_v6_set_tclass(msk, optname, optval,
+						      optlen);
+#endif
 	}
 
 	return ret;
@@ -1602,6 +1643,13 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 			return -ENOPROTOOPT;
 		return mptcp_put_int_option(msk, optval, optlen,
 					    inet6_test_bit(RECVERR6_RFC4884, sk));
+#if IS_ENABLED(CONFIG_IPV6)
+	case IPV6_TCLASS:
+		if (sk->sk_family != AF_INET6)
+			return -EOPNOTSUPP;
+		return mptcp_put_int_option(msk, optval, optlen,
+					    READ_ONCE(inet6_sk(sk)->tclass));
+#endif
 	}
 
 	return -EOPNOTSUPP;
@@ -1729,6 +1777,10 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
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

