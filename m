Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340944A1381
	for <mptcp@lists.linux.dev>; Wed,  6 May 2026 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086569; cv=none; b=leUCumtD1ZSlm7uwfHdZCh5YHUsO/gtjkB5f+F/MfD2Q28DC9YWFMD8nopuDbgsteki4n84BSyCd++hCczGRow9Uhzt3xdgJEMgHmEQ+j0Ge6LouPJgQhdmcRPhjtVfMC866Y9CGiAGbueCSz0uIMgKyIzAMudvaTcJC/0KI6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086569; c=relaxed/simple;
	bh=GZT5QDafmDQaFuy3H5Bd9tB26FM0kh2nZExuK4qFmb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExkTYL5AmFTTMRZ7b/ONbzHH21AMsZJZ9wTFvR4sCn4E8LW1aDYfqNABcdpyOlngM4uGu4JyO2jM44VYBlkM2FgqOxbB3R1981MHv1QKXmslFHaqdgKtuSLuqa5p/aKMCam0xPB6NsrfE31gVkBJMfmDHHAP9coKji6b7vmWx9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN8uahrK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN8uahrK"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48896199cbaso58732145e9.1
        for <mptcp@lists.linux.dev>; Wed, 06 May 2026 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778086566; x=1778691366; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5Yf68IfJTVfs3CpXG+5aOQokgamkcBKH9LlSeuIq8Y=;
        b=LN8uahrKg424f0sHSCZPn+Rwng8BG2BDilY+p5+24fxzw1r2eW9yzToV0+U/MOJLz9
         zVtCTOFbfbdjI4g2BiL5T9TKLbcThHj66yis/i/5UgENwdsXqYn/E2zHI5JCUicHqF50
         m6GNxiKaevPfTo9siY3t9AdH5iMtp5g8CjO9DZ7fbVyITRovB9hez5TtGLqNyKH73hZs
         4d6BUMtFHLIiWMuKAY0+cqgpT1ow88qx8wkwjDqQOkkgZ+v0tVs8w5SpyNu0bsH3rbcc
         aN5l+FlDjzuVry9dacXWC38deehvsftyqQbhOTOxG0Mg9i/YzDZG/shRXEqQJcc7JGvK
         vwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778086566; x=1778691366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w5Yf68IfJTVfs3CpXG+5aOQokgamkcBKH9LlSeuIq8Y=;
        b=HgbcT5Zf3FuR6iPLoHJArAJCWvoCRUzWwfv8LUw+BTC1kDmXMLFaf1qYvDvAd77jqY
         p5M+gQZWb2arFyIGFOS/ZMMbxuQLMSU7yhNMXh9YGbgyWMQagPe78W6CqPQFO4BehHCV
         dRnCtxmuPuJIdoGuNeAWEUURSw4pjonHbB3CREJyVfFyturqClfdpLggHThNgWuzZ29u
         ulSoHaNWwyoLz9QXZjcyfiWlkSVJW/cRMOBcpv0D063nFHd38NwdX6+0YLK7R1pkNrFZ
         Iqvs3QE3dU0q0QPpNrYd5NHu+C6LW+kRUhl7+YYoP3cA6mERwWXuLjKKNv8Nfeb7pp52
         +M/g==
X-Gm-Message-State: AOJu0YymyHhgl4Ok13ZrzRtVWPGP5uu0ZZCjjc6oArczjshkO9vQpyXu
	jY124DH0VHMNCfNO2cOtkIpHAL2vWAJQtsSS/5/q0uuQmK2j+7wVuzy2lf53OHADor0=
X-Gm-Gg: AeBDievmdGwfsnD2qDnoxT9ySQ5ZoByEm5eSajJ4/GZzZlm9HSDf4whQGvbzxxtQDN0
	FzOQrn6kInByY6T7W+DyL2dpBqC/kv2ZKsUQwkfPl8mIu4TQLRFgMn52wM3UVWCV7ZN/CZYoVPs
	U9+BlaKdzfFUWhStaTfSn2jYPhLCagY3h/ne3n7kQwEMc7FOoAfuuFv0ETYJJ1Pvcjm/8lQk5mP
	2rMtsz9ur9jhhwiX/I5txWpxYVm7pjedPEJ9F6qJXvN7WVu7s2Tf12J4SQNu28tmd/lFMwg/k0S
	pjIWaECQ3nRsImvS8ls1xYApZz7XFY0JWkiYOkF+P/LHN2TzN4BoTarskvYtut6Y6KMdxpuc5Ji
	vo9t87IzYGQIeOYkTUSegkHPuJV62i4tjvBoeLGS9OrwpfxOcc1bNElC7uq93/wuBHGZ2XiiAne
	13xErmYcBnTxbftf1galsAGeFWn2tijBF09l6nLWww7u/yqEgaN/WZFkIxtYN5DwjQO7sqsXMDc
	sbNIcS5Q7TVBV6WrFzD1caCswxHnbxj
X-Received: by 2002:a05:600c:4f0c:b0:488:9fb7:376d with SMTP id 5b1f17b1804b1-48e51f59fc5mr69206555e9.28.1778086566396;
        Wed, 06 May 2026 09:56:06 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538d2878sm94586715e9.15.2026.05.06.09.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:56:06 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v6 2/4] mptcp: propagate RECVERR sockopts to subflows
Date: Wed,  6 May 2026 17:55:54 +0100
Message-ID: <6a28b1d7069ddeab82f22c42ddb28bbc90589492.1778086500.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778086500.git.devnexen@gmail.com>
References: <cover.1778086500.git.devnexen@gmail.com>
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
SOL_IPV6 to avoid the -ENOPROTOOPT that ip_setsockopt() returns on
level mismatch in AF_INET6 msks carrying IPv4 subflows.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Assisted-by: Codex:gpt-5
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/sockopt.c | 123 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 101 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 20c737b2e704..3046e9eb2c33 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -8,6 +8,8 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
 #include <net/sock.h>
 #include <net/protocol.h>
 #include <net/tcp.h>
@@ -19,7 +21,11 @@
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
@@ -388,6 +394,81 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
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
+
+		if (level == SOL_IPV6 && ssk->sk_family != AF_INET6)
+			continue;
+
+		ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
+		if (ret)
+			break;
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
+	int val, ret;
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
+	else if (level == SOL_IPV6)
+		ret = ipv6_setsockopt(sk, level, optname, optval, optlen);
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
+	default:
+		release_sock(sk);
+		return -EOPNOTSUPP;
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
@@ -430,6 +511,10 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
 		release_sock(sk);
 		break;
+	case IPV6_RECVERR:
+	case IPV6_RECVERR_RFC4884:
+		ret = mptcp_setsockopt_recverr(msk, SOL_IPV6, optname, optval, optlen);
+		break;
 	}
 
 	return ret;
@@ -775,6 +860,9 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
+	case IP_RECVERR:
+	case IP_RECVERR_RFC4884:
+		return mptcp_setsockopt_recverr(msk, SOL_IP, optname, optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -802,27 +890,6 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
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
-
-		ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
-		if (ret)
-			break;
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
@@ -1467,6 +1534,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
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
@@ -1487,6 +1560,12 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_FREEBIND:
 		return mptcp_put_int_option(msk, optval, optlen,
 					    inet_test_bit(FREEBIND, sk));
+	case IPV6_RECVERR:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet6_test_bit(RECVERR6, sk));
+	case IPV6_RECVERR_RFC4884:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet6_test_bit(RECVERR6_RFC4884, sk));
 	}
 
 	return -EOPNOTSUPP;
-- 
2.53.0

