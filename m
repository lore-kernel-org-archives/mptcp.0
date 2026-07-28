Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89724248B1
	for <mptcp@lists.linux.dev>; Tue, 28 Jul 2026 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238830; cv=none; b=V6PkU6ox24HP+S9XRA5yTs/9IYoLnUdZ/xqfGmR31DEqUOgdWWZ8Yd5jeLGDHd48OMneJfI9Eec7/9kxC1Tibpd/NXtpbyrkLH9B5XGb/E0pPe6PZyujEod0ExRY59yhh9zbx1y809TL6DxFjNyvzGvzHhxRAvqMxb1CuLEb9gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238830; c=relaxed/simple;
	bh=Fd6JYCHxVTeGccxrws8f8opkIAjjrxbL9efbOMplhBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvMiX2aIdw2P1p8uLZ/oCUkcevxE/sdtRiIisFkTCQxieDe2J5m5acY8aRN//D7bFrmYdDMA7erZEQkyCtcJxKWMLQLWMqjSgOKL+DT/nW143Lg9eZR5ehYXWh+i8hSSOoq9KCPLrWZl1J6tkQxess1mISTgXFMzkjpYylNoPiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3XasJrX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3XasJrX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E081F000E9;
	Tue, 28 Jul 2026 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238827;
	bh=gEv34C4Ft6ujnBwBMcpAgnfM4HGEYX5QCGRky+RjKsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X3XasJrXSozANTAPJKn6nP6KPFWAGiMgDnhTxUsgexqF5bxWHBcPhV5TLLnNCP0oK
	 IVKNmpjvv4wu0l6SZad2++RZkq2W6vELcECO6kiIkoij6tjnuKCOAirq0rNEKWPRoh
	 vuwex3fXfVZTjfuGorgfall4nH28PNkFuZqSuDO++fCnFTEO9rLcrq/3+3L2CTJFXM
	 Q1XefKPizPrcXtBak97MLL3cS1t9y3MaiHrphy3h/SbWH4ghuUSkuTY2SXj7VWwyn1
	 TdTKwjzhSXhO+XgB80O3SorBKmT4tK5zCpO0EcOhPitqMxsHeDaBNL9BFI864WLBv7
	 W2+KRufKANhfw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: David 'equinox' Lamparter <equinox@diac24.net>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v3 8/9] mptcp: sockopt: implement IPV6_TCLASS
Date: Tue, 28 Jul 2026 19:39:41 +0800
Message-ID: <c7db111845a72c50cac51bb334027b79692f2de2.1785238723.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785238723.git.tanggeliang@kylinos.cn>
References: <cover.1785238723.git.tanggeliang@kylinos.cn>
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
 include/net/ipv6.h       |  1 +
 net/ipv6/ipv6_sockglue.c |  2 +-
 net/mptcp/sockopt.c      | 44 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index d61ccb48b5a5..03b87a818c51 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1253,6 +1253,7 @@ static inline void ip6_sock_set_recverr(struct sock *sk)
 }
 
 void ip6_sock_set_tclass(struct sock *sk, int val);
+void __ip6_sock_set_tclass(struct sock *sk, int val);
 
 #define IPV6_PREFER_SRC_MASK (IPV6_PREFER_SRC_TMP | IPV6_PREFER_SRC_PUBLIC | \
 			      IPV6_PREFER_SRC_COA)
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 34a25583942f..c59f25fbb336 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -373,7 +373,7 @@ static int ipv6_set_opt_hdr(struct sock *sk, int optname, sockptr_t optval,
 	return err;
 }
 
-static void __ip6_sock_set_tclass(struct sock *sk, int val)
+void __ip6_sock_set_tclass(struct sock *sk, int val)
 {
 	u8 old_tclass = inet6_sk(sk)->tclass;
 
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index dbfae244a731..c3af056a8080 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -396,6 +396,36 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
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
@@ -438,6 +468,11 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
 		release_sock(sk);
 		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case IPV6_TCLASS:
+		return mptcp_setsockopt_v6_set_tclass(msk, optname, optval,
+						      optlen);
+#endif
 	}
 
 	return ret;
@@ -1505,6 +1540,11 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_FREEBIND:
 		return mptcp_put_int_option(msk, optval, optlen,
 					    inet_test_bit(FREEBIND, sk));
+#if IS_ENABLED(CONFIG_IPV6)
+	case IPV6_TCLASS:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    READ_ONCE(inet6_sk(sk)->tclass));
+#endif
 	}
 
 	return -EOPNOTSUPP;
@@ -1619,6 +1659,10 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
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

