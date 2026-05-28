Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DB130C353
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 05:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779947707; cv=none; b=gS0OlSFWVy2CWsagUrUNY3KZLP3eS65OK8tBeDNlfWZTH8ayhNxOEWRAi31T3mUqppj/aIid4dXLUZI/ZyV9s0wt+u1Lq1KBXgGm6iMA9MN6LPLWHAYNkpYDOhaySUDqDVh6bCuX/RYKxAPUfC3mrPsw67dDspjxIIoO3AaWRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779947707; c=relaxed/simple;
	bh=A9tYxw+Zn1LA/ziarPzR6b4b8QgIJ1MkR3+IOGmXh6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EiFbjPsMs7feiAqERpJG0k9Uv5MJacT/lpxgtJJXjw/pMwG3iKdTyic5Ip21m2WxN4aORT6DyV04G4K/8Bur0/9Jp/X4dy/Dhl0fQVNea2tls/SXHRpDLcKz5aG+V2o+fJdbPmVF5AvhwYfDIajzr6Ry2HO/V2w5aLYzNgJgJNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRxr3dJS; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRxr3dJS"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4585a116a4aso10362595f8f.3
        for <mptcp@lists.linux.dev>; Wed, 27 May 2026 22:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779947704; x=1780552504; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJ77+0lG1ji9sCSYntZP/KM8dw4RDg8LxDEFGOALtrY=;
        b=eRxr3dJS7ObsBEiA4QzOkSu1suBt4BnhJu2wsw1Rh5sDPpey5dzDVIXpdNmmKeh2Xd
         BoP3++lwrxcJHfYLl3EMzW9xb6mLlS5CLNgukabHD5udAcyaTMRw8XSG/8ZZEAHGavPI
         BSyLqdwSnrfRagm2k3N/bmECVt1X06+gTH1JVwSlDSJrYKyevnosBK6TW5PgagEVKbOz
         hoM5O1nDQ3lcDEyNdP1WwiIlkkXS5LHaFTMQT4aarxx5pV6Z1QaqZuZWUYXMVOzy8r/l
         hYNwoEnZXFH13MWW+RTq+v8cCTwJxQPgG48bdipe68c3MlKVoZD0zi8alSYkjnpSONI4
         x8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779947704; x=1780552504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dJ77+0lG1ji9sCSYntZP/KM8dw4RDg8LxDEFGOALtrY=;
        b=DI9RjvcjvRWIdGhkw+gPGH87w9/5MPX3x2dg3cyVFjqhkioYdXBliD53mqi28cZPbv
         Q5Jx/b2sS8I0v5Wdhx3Wf/ObMPEJQ9qhbvebxHemNM+eBwzQLfCL4rbDnJjX4unrqKSL
         yJlpxiOuergsO2FIuXUh1DXHUGHkWRwsGIx7x9N1bfSQQKlgThuG98+kjqmJVl2flMLM
         bo4rZ5ho0q/qsJGHNDZaoiTAgzxUD6FlJZg3uFlolxn8j2eCBjKdLMWkzzBmPb8LIKyz
         YJdJmFDX4SDyFMD66+gIccJX3BmnN2MO2+6Gdu5osAaFH2OhkNTU6vUi1rzx03jd6aHp
         tDRQ==
X-Gm-Message-State: AOJu0YycLNAS1oYanBv/WcUbPFWc8Qru56CwN/RC6zNeLUwccFVM1Uu3
	cRtiXnrQcTk4NKIgn+rc/nhhfputmD9gFQbV5ywPlKYbJsCAUIttFdvlmh30Sf6l
X-Gm-Gg: Acq92OFdHHzMBrfwhIhQUTWqiCDgSPcZQ9T+jJXxCwOknCkCdAly21NJfSqjhl5azrP
	4zSNKUZy+TELkXa3lcFnKc6K1t18MhLM6L4fg9/IQExcTxHqRN745GB/1g5IGfQcUSFx1vW8Tk9
	rMHEzj+UdQdND4ZZA9Pe4vqK1Zee0NJ0Q0hDjVwdcSoVsO8PIJKCSi8hi8hZLslcm6DKYVMY5/8
	Bdnbmq9Cmrwykm+QKXSS5RazremltUGAC1Gdkrbgubz8+9Okzkq7ZRjxlQt2KmEnLpJ2iyPHAev
	9AFLlA9wXKGaBUhQeS4GAGKd9jZnKNF/W81aenaZoTH+3bmTycO0+q97AtdHNs5IhPHIUtCV9LW
	EMndTL8WxDUQsiLGbsm0kFEWEbyC2mgg8m7OiDW9RlbHjwRBO0Hrvmwizij2YaUVONir+e20PpW
	5+BBY990i6T/iqHT8wFBMR0wD0mVvtpfugYhGsvhsd2HgSrDS5rr/EQoF8QNiqtOp2bgO53fqmF
	eTb2y2NVKgc/BKmq+YM8pHMc9eC7RMD
X-Received: by 2002:a5d:5988:0:b0:45d:77f4:1ac2 with SMTP id ffacd0b85a97d-45eb3330a14mr42467455f8f.0.1779947703987;
        Wed, 27 May 2026 22:55:03 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a2c87sm11002245f8f.17.2026.05.27.22.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:55:03 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v9 2/4] mptcp: propagate RECVERR sockopts to subflows
Date: Thu, 28 May 2026 06:54:56 +0100
Message-ID: <20260528055459.55133-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528055459.55133-1-devnexen@gmail.com>
References: <20260528055459.55133-1-devnexen@gmail.com>
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

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Assisted-by: Codex:gpt-5
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/sockopt.c | 131 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 109 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index b9cac04a749a..cc510501ccd9 100644
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
@@ -394,6 +399,82 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
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
+		/* SOL_IPV6 options on a v4 subflow (v4 MP_JOIN, or userspace PM
+		 * grafting a v4 subflow onto an AF_INET6 msk) would otherwise
+		 * abort the loop with -EAFNOSUPPORT from ipv6_setsockopt().
+		 */
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
@@ -436,6 +517,10 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
 		release_sock(sk);
 		break;
+	case IPV6_RECVERR:
+	case IPV6_RECVERR_RFC4884:
+		ret = mptcp_setsockopt_recverr(msk, SOL_IPV6, optname, optval, optlen);
+		break;
 	}
 
 	return ret;
@@ -781,6 +866,9 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
+	case IP_RECVERR:
+	case IP_RECVERR_RFC4884:
+		return mptcp_setsockopt_recverr(msk, SOL_IP, optname, optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -808,27 +896,6 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
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
@@ -1473,6 +1540,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
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
@@ -1493,6 +1566,12 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
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
@@ -1601,6 +1680,14 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
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

