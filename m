Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8BB51E43C;
	Fri, 18 Sep 2026 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789756732; cv=none; b=fPGOLcBHaKx5Sy/ZvmppiO83l9WqFF3lUy+DFP8YizyamEn2eXlQbQt9KIlfspHaTTw0+4fsCxZpeEErZOWUOhjndmFWjXGc5w4mc+oeCJOOc2K+tDY+7Efbu8rcoN1gr+8kjPMEJrFXMTueEP6zztezhzXFRROCoN21Lsoe2+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789756732; c=relaxed/simple;
	bh=fbWZZc8WwHlYza1PP7pAIgFAufWY3zIAyOEtVmk/sho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ivDCiiGNnE/yJbc3PKQaikMt1yQbUY/TZNbZKGJ61UYNaxgY4ot8INXAgtTh0hsX3vZMZAcm3c8RrNtziowMKL0I/YDVinO3l0nj0XveHDUJTXup470f+MMOZowLy3f6GQ4XMh4fTgiauMToNiJjKnnTv/bON7FBHwy7+7kW8Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xkj4drDw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xkj4drDw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB89C1F0089A;
	Fri, 18 Sep 2026 18:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789756725;
	bh=2y7axseDLzTxuDDQ3sumIb+ws2cPPLcPH4O+iaVMq0Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Xkj4drDw7PqDHbi8VYzXRWluum2lNGqg6HwYdY4Et1WY/ixopopuckEzuFxoFYkuy
	 wF8ms12VczQfoaHJp5IXT4/DM3vcAvc/VWG5Nef3bj48kzV4rnLeVJygFI1zN8A3HX
	 iLZGs0J6Yuk5o9ZpcOAuSqZBOUjM/CFCY34q5ov6HCIz7r4KfhBJ+oF5jMtNlKpRfb
	 Ynyx3tQ2yr6NcK3rd8vpvFhI3zHY35u+IUUbqytOpUhp6/xYeeSZQ3Ajh+dATUU0Ap
	 ZGP0KPDETIswKxGvtWkiO1e8Q+OQOdTTQoxw0/uZ1dCHon1H2sYEpOAt19ma2WIQSC
	 dzznARva2Uo0g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 18 Sep 2026 20:38:27 +0200
Subject: [PATCH net-next 3/4] mptcp: propagate RECVERR sockopts to subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-net-next-mptcp-msg_errqueue-v1-3-dd77e1738248@kernel.org>
References: <20260918-net-next-mptcp-msg_errqueue-v1-0-dd77e1738248@kernel.org>
In-Reply-To: <20260918-net-next-mptcp-msg_errqueue-v1-0-dd77e1738248@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 David Carlier <devnexen@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7716; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ZV6SJUXmelrp3RjG7TZg+4EZ/ra6RMfmhMZOXd3tH80=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWtmpNXKFbU7v0LENczPHfZ7lq7ihkLZsn3cr30aRyq
 sSUSo39HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOZ94uRoVXHtUpi3bqreo3T
 2YSfRHy+EGC5ZenlLwFX/M4ksoUkGjD8L4ibuO/vZ+/z5zcsMs5nPX0kIHPB3L2MVwMWdtcqrN6
 xjBUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: David Carlier <devnexen@gmail.com>

Propagate IP_RECVERR/IP_RECVERR_RFC4884 and
IPV6_RECVERR/IPV6_RECVERR_RFC4884 from the MPTCP socket to existing
and future subflows.

mptcp_setsockopt_recverr() snapshots optval into a local int, applies
it to the parent socket via ip_setsockopt() / ipv6_setsockopt(), bumps
msk->setsockopt_seq, and forwards to every subflow via
mptcp_setsockopt_all_sf(). Newly-joining subflows pick up the four
RECVERR bits through sync_socket_options() now that
MPTCP_INET_FLAGS_MASK covers them.

mptcp_setsockopt_all_sf() skips IPv4 subflows when called with
SOL_IPV6: ipv6_setsockopt() on a sock with sk_family != AF_INET6
returns an error, which would abort the loop and leave the remaining
subflows desynchronised. This branch was unreachable before this
patch (the only caller was TCP_MAXSEG, family-agnostic); it becomes
live with the new IPV6_RECVERR / IPV6_RECVERR_RFC4884 caller and the
v4-subflow-on-AF_INET6-msk case (v4 MP_JOIN, or userspace PM grafting
a v4 subflow onto a v6 msk).

Assisted-by: Codex:gpt-5
Signed-off-by: David Carlier <devnexen@gmail.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 142 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 119 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 2ba56832587e..922f6ae5c80c 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -8,6 +8,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <net/ipv6.h>
 #include <net/sock.h>
 #include <net/protocol.h>
 #include <net/tcp.h>
@@ -19,7 +20,11 @@
 #define MPTCP_INET_FLAGS_MASK \
 	(BIT(INET_FLAGS_TRANSPARENT) | \
 	 BIT(INET_FLAGS_FREEBIND) | \
-	 BIT(INET_FLAGS_BIND_ADDRESS_NO_PORT))
+	 BIT(INET_FLAGS_BIND_ADDRESS_NO_PORT) | \
+	 BIT(INET_FLAGS_RECVERR) | \
+	 BIT(INET_FLAGS_RECVERR_RFC4884) | \
+	 BIT(INET_FLAGS_RECVERR6) | \
+	 BIT(INET_FLAGS_RECVERR6_RFC4884))
 
 static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
@@ -398,6 +403,86 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
+static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
+				   int optname, sockptr_t optval,
+				   unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	int ret = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int err;
+
+		/* SOL_IPV6 options on a v4 subflow (v4 MP_JOIN, or userspace PM
+		 * grafting a v4 subflow onto an AF_INET6 msk) would otherwise
+		 * abort the loop with -EAFNOSUPPORT from ipv6_setsockopt().
+		 */
+		if (level == SOL_IPV6 && ssk->sk_family != AF_INET6)
+			continue;
+
+		err = tcp_setsockopt(ssk, level, optname, optval, optlen);
+		if (err < 0 && ret == 0)
+			ret = err;
+	}
+
+	if (!ret)
+		sockopt_seq_inc(msk);
+
+	return ret;
+}
+
+static int mptcp_setsockopt_recverr(struct mptcp_sock *msk, int level,
+				    int optname, sockptr_t optval,
+				    unsigned int optlen)
+{
+	struct sock *sk = (struct sock *)msk;
+	int val = 0, ret;
+
+	/* Let ip_setsockopt() / ipv6_setsockopt() validate optval and optlen
+	 * (so 1-byte boolean writes keep the same ABI as plain TCP) and update
+	 * the parent's RECVERR bit. Re-read that bit under lock_sock() and
+	 * push it to the subflows: concurrent setsockopt callers cannot leave
+	 * parent and subflows desynchronized this way.
+	 */
+	if (level == SOL_IP)
+		ret = ip_setsockopt(sk, level, optname, optval, optlen);
+#if IS_ENABLED(CONFIG_IPV6)
+	else if (level == SOL_IPV6) {
+		if (sk->sk_family != AF_INET6)
+			return -ENOPROTOOPT;
+		ret = ipv6_setsockopt(sk, level, optname, optval, optlen);
+	}
+#endif
+	else
+		return -EOPNOTSUPP;
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+	switch (optname) {
+	case IP_RECVERR:
+		val = inet_test_bit(RECVERR, sk);
+		break;
+	case IP_RECVERR_RFC4884:
+		val = inet_test_bit(RECVERR_RFC4884, sk);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case IPV6_RECVERR:
+		val = inet6_test_bit(RECVERR6, sk);
+		break;
+	case IPV6_RECVERR_RFC4884:
+		val = inet6_test_bit(RECVERR6_RFC4884, sk);
+		break;
+#endif
+	}
+
+	ret = mptcp_setsockopt_all_sf(msk, level, optname,
+				      KERNEL_SOCKPTR(&val), sizeof(val));
+	release_sock(sk);
+	return ret;
+}
+
 static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
@@ -440,6 +525,11 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
 		release_sock(sk);
 		break;
+	case IPV6_RECVERR:
+	case IPV6_RECVERR_RFC4884:
+		ret = mptcp_setsockopt_recverr(msk, SOL_IPV6, optname, optval,
+					       optlen);
+		break;
 	}
 
 	return ret;
@@ -785,6 +875,10 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
+	case IP_RECVERR:
+	case IP_RECVERR_RFC4884:
+		return mptcp_setsockopt_recverr(msk, SOL_IP, optname, optval,
+						optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -812,28 +906,6 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	return ret;
 }
 
-static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
-				   int optname, sockptr_t optval,
-				   unsigned int optlen)
-{
-	struct mptcp_subflow_context *subflow;
-	int ret = 0;
-
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		int err;
-
-		err = tcp_setsockopt(ssk, level, optname, optval, optlen);
-		if (err < 0 && ret == 0)
-			ret = err;
-	}
-
-	if (!ret)
-		sockopt_seq_inc(msk);
-
-	return ret;
-}
-
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -1478,6 +1550,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 	case IP_LOCAL_PORT_RANGE:
 		return mptcp_put_int_option(msk, optval, optlen,
 				READ_ONCE(inet_sk(sk)->local_port_range));
+	case IP_RECVERR:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(RECVERR, sk));
+	case IP_RECVERR_RFC4884:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(RECVERR_RFC4884, sk));
 	}
 
 	return -EOPNOTSUPP;
@@ -1498,6 +1576,16 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_FREEBIND:
 		return mptcp_put_int_option(msk, optval, optlen,
 					    inet_test_bit(FREEBIND, sk));
+	case IPV6_RECVERR:
+		if (sk->sk_family != AF_INET6)
+			return -ENOPROTOOPT;
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet6_test_bit(RECVERR6, sk));
+	case IPV6_RECVERR_RFC4884:
+		if (sk->sk_family != AF_INET6)
+			return -ENOPROTOOPT;
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet6_test_bit(RECVERR6_RFC4884, sk));
 	}
 
 	return -EOPNOTSUPP;
@@ -1606,6 +1694,14 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
 	src = READ_ONCE(inet_sk(sk)->inet_flags);
 
+	/* RECVERR6 bits are only read on AF_INET6 sockets; copying them onto a
+	 * v4 subflow is dead state and diverges from the SOL_IPV6 skip in
+	 * mptcp_setsockopt_all_sf().
+	 */
+	if (ssk->sk_family != AF_INET6)
+		mask &= ~(BIT(INET_FLAGS_RECVERR6) |
+			BIT(INET_FLAGS_RECVERR6_RFC4884));
+
 	for_each_set_bit(b, &mask, BITS_PER_LONG)
 		assign_bit(b, &inet_sk(ssk)->inet_flags, src & BIT(b));
 

-- 
2.55.0

