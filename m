Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05783BB69A
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395577; cv=none; b=t+1/prWXUC70A/fbxKy0NR1WnpBwdaavcfHP/XBgEVDCOepkXugUscWhD5pqG0HmT2lkL9uy23e0x0BIxclc/C/CE5YuZ/3N+bBzbadw2S2L8O21b5nUP3aZK91qKWMWbdNNDh5e4JYIKqwjQvbhNLHjBGUuWIVh7K15LFUtnFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395577; c=relaxed/simple;
	bh=K6l8M2ImgLWDN8CNAxnVhqrnL3ehaBwMea8ZVifFxn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLnmZpXKHms+4E1j1GI3+c56ujJKbVO449Euj1p/5kD2EVCaeOyZS6M/zN7LmZWZ1R+7at7QvN570Q0yyiu9CDofEWq+ApGtwstm5XG7chlZm9tVV/MmOL+qpD6ZWvIiZg9bhxwCVNRzgXHgjtS5PB4q4t9fKH+fW280IK66m2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q7iByrdg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7iByrdg"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f7872abb6so1067516f8f.3
        for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 00:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785395570; x=1786000370; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NFrk/CZh/9/ejNoVEbaW39y3qp7KGHiAW2542tNoiGQ=;
        b=q7iByrdg8czmr//ml80EacxtIs8DxO+NQY17ocKZc4jaDva9WvP3BXF8sduyKi6hEO
         84l2TFtyTB2EUPd5zAhBu/yOoVyoi6o0FTwWq8mSHtOm6llfqdiaEizWEdGo3myIs8Wq
         yWjlgiZ9/JQ+ZjuqjT82W3ngu4mVP5wyEJ2+XHYtpLF0JsOiD1QsB9ygwkhz0oTrI1MT
         MvZ6oL16Kr3Me6ZtixWkLjM9iOxKY57Q0aD1dOyT+4gUz+DY3uVjNlZvlv5KkaZOlfWi
         Ml2toUBINIRJDWjslgQB7Za6xgt+Ty5wfMa13ZerLQvsQLMjFZN5Xa+bNmnOPnap4NWO
         8EqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785395570; x=1786000370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NFrk/CZh/9/ejNoVEbaW39y3qp7KGHiAW2542tNoiGQ=;
        b=m9yCh6IsYo2q6Yw20C7gZ8hQG/+7BxahpfQ3dESAwL4ZbwpS7e06xQ/7QSRrHhEzK5
         kY6ht2iqWteWXjBgQSr2r8UugoNjgrGxHED9BtzPt9EuuRlqiXl2V/ol2vC+ZJ7Y5KeT
         mpmoi7Qj7X++n+s7ZSw2ZQw29xGhI9Du5A4azop+kPrx3o+CG55/n9OaHey6V1GiZi5Z
         //ioL6JMPm98SudINbHCwf16DVqZ9KS0cI3R3eRjHOTy4TtXlZ8OLsl/vvgkYCglpula
         aVq78BVKy2vb32P9PySP/hw7/vqiws1ZG5EX6o4lA7f5q/1vDQ3snqx0peBAg0Yql+qZ
         sB+Q==
X-Gm-Message-State: AOJu0YxURI1Bwrc6FzTjtNOs2CUCmpiNs9zXrKtmccPnU2xWctOMZcX8
	MqoCWIL3Cu41GaV8Y20p1C72Qlh0fmolpV+ysCktG8zXw+GhuT8qC91sfxhCiw==
X-Gm-Gg: AR+sD10YjhglR7wv69AyIpdaTihQPawV/+d6UhQXZNaR/BeS/Sgub4qvIuGjt6IbeGS
	4xdkxdi4bjxiSlZ0nSfGOcYXsffI9NuBoidMJCeAsDKV6RiME3deyeh3LYB8itlVdPOWbWXL55p
	yFPNABJe2+INtnSyS4xs1EhCjtHh+HQL8iC8V4rZHW062L3ZlftA0ShHFsI/x3hLMAf/paWjlNj
	eFggr5Y9LniqfToFpcX0iocipCZPbIzIfAhg7UYeRjb0sZK+KvBkODgIBkD3SyIcFR0HgXNU1as
	fomcgbG1NbIsHKQ5vm5yaXgWUi7AjRhiT4ou3pzgqxPKlioMyeynRjCern3mu3+SZpMZ/fJ0Ced
	IwOXMjL5Kxwhyl+4RfuhX9ulZ0TFRWGqL2n/HA6srykVrmmZHlHn/0AV+bAy/o5IUucHGtbHRhz
	kCJiVq5ygZdt/aMgmEmXFlANAU0dbpe2UOwqCW0aajgkf6JkDUJOR1J2obTAM0ih2V+ZIDsNDSi
	g37PtFgwHBVAD+MVDJnG2MkHibcP0m3Ezg42N1XNOJ6ditd
X-Received: by 2002:a05:6000:381:b0:47f:762f:32a9 with SMTP id ffacd0b85a97d-47fc80c62admr1713288f8f.12.1785395570221;
        Thu, 30 Jul 2026 00:12:50 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88d6e5bsm3821717f8f.3.2026.07.30.00.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:12:49 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v12 3/4] mptcp: propagate RECVERR sockopts to subflows
Date: Thu, 30 Jul 2026 08:12:43 +0100
Message-ID: <20260730071244.69473-4-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730071244.69473-1-devnexen@gmail.com>
References: <20260730071244.69473-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 net/mptcp/sockopt.c | 140 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 117 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 2ba56832587e..bc9d581a9744 100644
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
@@ -440,6 +525,10 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
 		release_sock(sk);
 		break;
+	case IPV6_RECVERR:
+	case IPV6_RECVERR_RFC4884:
+		ret = mptcp_setsockopt_recverr(msk, SOL_IPV6, optname, optval, optlen);
+		break;
 	}
 
 	return ret;
@@ -785,6 +874,9 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
+	case IP_RECVERR:
+	case IP_RECVERR_RFC4884:
+		return mptcp_setsockopt_recverr(msk, SOL_IP, optname, optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -812,28 +904,6 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
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
@@ -1478,6 +1548,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
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
@@ -1498,6 +1574,16 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
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
@@ -1606,6 +1692,14 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
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
2.53.0

