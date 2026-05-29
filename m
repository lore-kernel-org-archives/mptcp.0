Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF157370D6D
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076734; cv=none; b=oHeOk4R6rzQ5KL+F/WlqUIP402FVGhZZ1hk81UYo6VGwZ/FrbUcrkKGfo/NMcfG/BmIDV4Qwuo1x+7jBsFcn47B+gsOVj2y3KHDPHYbRf3afVF99JnrpkYerSFkxrOuLOrH/5QbOdgZ6sGcDb5PUW4e2ubIWdXYfl1L4RdVB7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076734; c=relaxed/simple;
	bh=CdqrNzJqljtnv5V0E0iWXUe0qiEWfFAC79g8Onrx+6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5nm6e/6Rp9JuGeohpeAr2ibymf0y9UHclB/ganm9ubqSCkYf1xim/u0iNpDKWkq+lJ5/wp5zmqq+R5J5mY2Ii53F9+siapMQ2/UKi10smafdNvR55Zmmz9ljIYzuaCEGmxcT0U52Bis2Coh2Q1Neu0b4uQzrqKok0dynRD9q7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L++gRsAG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L++gRsAG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4908b92904fso27961135e9.0
        for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780076731; x=1780681531; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0l2a23bjsyhMnuZqOUF7QTbzTDrWowY//AfeLkvxiM=;
        b=L++gRsAGbn5CFyP0PDFWf8bDVJ1QiiJ7Mk3yfq0BFbZZBHx3B+g6zOljXYzI0cBZay
         tb4QG4CsaHHQ51dQlNqiYTcl113rTd4/XfU0fslxmBJNuyqCvOE88eqC/Q2mL6A6pYOD
         hzEgJH6eurmifpIhKBGKHvxQ0i8S0atB1BrwygBwc6ke548YDKfPb3dclbKIwpdv/B8Y
         0ptIontIkS/6vD4MFm37Ia3H80QYNutGQe7efS6e89v6t6aJ0L2LsqhW5HwrZbBormUr
         cPlv39tq8lgMg1fQBWchSSyz1I0L/fI/1WPjcH6b1nJ5DCXWq76cy4lkO4AyiZJcCffl
         Nw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780076731; x=1780681531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f0l2a23bjsyhMnuZqOUF7QTbzTDrWowY//AfeLkvxiM=;
        b=I5MtIMC5AE4d0O+r6O7pRfio6ngq+ospAg84TRUK6M1U/EcIMjGOp5ehe+I+3dWDk2
         fZcx0F7h+qaWiyBuDKlZeQ4unWWKaWkrSUFL5OQb99wvOOppoHDR+eUFmCvneWvg1jby
         3p2cNBFmSMYuzoJq0IwTeEJOH0G6TKi6V6732ha1tTxtn51BbGbp7DiAwR+WL6rMyjX3
         K6habmfVxdBTlJm8BvAqPkph4YZYt7onuIdYjI09RfN565QeH5M6qJWAIvol2hqFSPRg
         Ke+K/JaUY7IW54QffbyPdi+cRVs/iB+eFq8CCt7h2ZLYOk+jVyUGWOurh8d18d4umNAM
         w3SA==
X-Gm-Message-State: AOJu0Yx5iyN4pAOCx6A+VUWEPbjZmdvISez4CNaOj1zFX6HCICe2HwDx
	i5V7wyxzTldGo48bc6u82TM8ZSyksh0eHjXevZmlHB07fMoNd4/aHx91oaU1TA==
X-Gm-Gg: Acq92OHGFj5GWNGLCOe/FCJOPGpseKnxSKY7b/tAsZ8ddPeWhoyOfEVSBuRwsaetwbz
	7JJvNE+lT6lcELwIX6ybg6Y2hRyQkysK7QnwQjnQdxKH3PktHCzBXc+3qHUXIGu886mJNma2vd4
	vf6QN30t9tRvRBBc+zO2w4ErwjvchrSCLApDLOER7bXULUFLqyky4QucHRopTSUf77Kiybtxr4L
	yysvUewH7MM6R61GNyHMa4RGVhqn6aaIsJLdXcfJOw0SAY/cwWVBO4CoxD5O6IbrERyoiIF7M2p
	0Jte5KumFC5bNwN5wc9yn5Y5n53AOBjUYiemYtBI/DkhTB7Ud6Eq/OmT0c5DEKl5XMgRnY4vRwE
	0WSy3oqPm4VGMHXbq0lba8h5xri/C9SVhH3h3Xro0UfjzLHPgY7V7w+wYgTCxNkoiU4J0fY5rRL
	AhP6byytz/7yvqM0BMcD9R7UCyVeqhiPQi3JjnRMA5lQO7efKXU6XxUK9jIdXjYMKxHQy9I+7Xk
	DNzmtK8+Za89SZDObVbtQ==
X-Received: by 2002:a05:600c:6b6a:b0:490:53d3:4753 with SMTP id 5b1f17b1804b1-490a2952f8fmr7201205e9.31.1780076731149;
        Fri, 29 May 2026 10:45:31 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c09ab75sm18738075e9.6.2026.05.29.10.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:45:30 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v10 2/4] mptcp: propagate RECVERR sockopts to subflows
Date: Fri, 29 May 2026 18:45:20 +0100
Message-ID: <20260529174524.260199-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529174524.260199-1-devnexen@gmail.com>
References: <20260529174524.260199-1-devnexen@gmail.com>
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
 net/mptcp/sockopt.c | 138 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 116 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index b9cac04a749a..76ff3c41a481 100644
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
@@ -394,6 +399,85 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
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
@@ -436,6 +520,10 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
 		release_sock(sk);
 		break;
+	case IPV6_RECVERR:
+	case IPV6_RECVERR_RFC4884:
+		ret = mptcp_setsockopt_recverr(msk, SOL_IPV6, optname, optval, optlen);
+		break;
 	}
 
 	return ret;
@@ -781,6 +869,9 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
+	case IP_RECVERR:
+	case IP_RECVERR_RFC4884:
+		return mptcp_setsockopt_recverr(msk, SOL_IP, optname, optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -808,27 +899,6 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
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
@@ -1473,6 +1543,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
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
@@ -1493,6 +1569,16 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
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
@@ -1601,6 +1687,14 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
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

