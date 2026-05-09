Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727BD1E520A
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778361421; cv=none; b=NeIDCWqTTGEEPjv9ghqbzYB8nLROd12yAIxgrdXUczla04bDNYiH2tfdZ7GyrCx34DL2euBCmjnowQ6nI+mFdLIdx/vCaCPOthIvsxOTbhrlZFQU/e5pd2XWI/swcPKLWAi08HqBkQH7gw8MbFlCm7f4YBUoJJVW5Ov0LdTJ1wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778361421; c=relaxed/simple;
	bh=pUthHQqsJaiRKRrCIAVZjiacspE0mlEOLD59Gv5HEkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0BfjVLS6m//ODjnjKQ47eSMiOlds0ptW3cWwbjMYKYS6llybSsbfDGo+9o/9XiOTjFKmMThzBsh16SFP2SG8yPqHMdXsABrZeqmFVVtR88eIpg4jiImD27y/EO+sVrE+qZfutVuba90hRdw4lNTHzjkconUg7YgYJl7ybbLuok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVOyiQku; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVOyiQku"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso34256515e9.0
        for <mptcp@lists.linux.dev>; Sat, 09 May 2026 14:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778361417; x=1778966217; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snwsgZrtGDoz0Pqqz1w9HFQtwim/+rA4FFV46ZVGsFk=;
        b=LVOyiQkuzL6M7m7Ee9zJlEROiU2YcpvbAweExK6jqjb6xF949rt3f2y6BoKiTjPftE
         ii+516Fcd4I0k8U9JCpVD16FDM97rOm9ZML6Vq/akJde13tuMveO0MjR8CdgPu5WBX/l
         S54RClTanaES3nuKLrdxCtB4nTk91EA74MHlhLS/2/UfxmwQ3kmhAHO1JjV4g30tX2z9
         6gWrResHIpeHOucdY416Qx3IYN8B082subMGelr2hJW0dLUHqpfQQXVovSIjdPCtWSmH
         A5tlcQV5CEeUBU1JkaV8FIYhZh6kgh9pCIgLhNT+BUxEbTVBrogboawkuEO/dvSqHBoD
         zmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778361417; x=1778966217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=snwsgZrtGDoz0Pqqz1w9HFQtwim/+rA4FFV46ZVGsFk=;
        b=evu4F2s+ghB9gQQocMD0dJtPDMR2rXdshSj1f68W4IlwBIrL0t2x6VVknwS2YBh3Z9
         sfoefVbPY1ooi3K06j4bVv7kSNQvkG8AnceVTCBoZwBJRFcRB8CqeVS5Sc991W7WcCK7
         +mwzK6+tFWVFyS21fszyGypQAflkBngDIIy5MS1OkZzE3tKbfRXgvMIpaZXNjKnxc3jV
         q4//6oclTld2NuzT73mjgNai2q9eECjNVoWvQ761C7YESl2HSP8YSdz58Qd6mn6kE1Nr
         vZGm9PMKQzsyKKikvax4uZ1PlGMwDz7/R1LnsvzI2v3DdE5bClWI0jMbqeIn+5FF1FmK
         MNpg==
X-Gm-Message-State: AOJu0YwHsjnOdp5KLw/ZQcmMps2g3yRREtAcbwHFXrkfx9IBLmj2Db2Z
	y/aPfzZAqfn5Nz2SsF0t0XYIyIfUy1Pylu0bZVRuOu1wcJbziJbjOSQaNPTzR2Ys5S4=
X-Gm-Gg: Acq92OFY7pp7VpICEJNNHmCTrl6x3/L4ahU8BVcDFjQCjk/ov+LZXzSUGZGNckuZrU3
	sRdZUGS6RsCnZ8YaYUG4n1SUhcxjiLBavpH4bFCDGzrrlq68UouMJ+IlzbEh4yjRzBtq1IpHPuG
	dGeg7uiWePJkI1+IvEdnmyudZJtei/Ng2DbB3RSHYekfe1lhbFN52Ka98ekxNiES2TPY2tlgJSL
	yExpcdwzNa8YFghLUi28lRfNVI+6J1SfWzd7ofzr/IPYLDI/UeD8Qb503Cs8hdaQHBPfArnn813
	gaU0fd6vw8gxZbKK/JoAf0aOiwwQqSKhtgkBbbz/rOGdCThmQ5EsXAv0JifCRIlcs8vk654ooWM
	QeGL0j1apMGogvS7Q8ya3FsTjdhOiEDyPBXNxn/ejkIw0Mk8JWu2LYW7Sp2DUuHnTlebH7m2hPV
	oRxiKXBZBlXn/kTzEqBR3V4Sjg9XcXf4mbjfTsZlgfqdyRTwXvzca/uCNeBUcU9UhVZiv3hEQBy
	/yg6kqY8FM=
X-Received: by 2002:a05:600c:3151:b0:48a:7605:751e with SMTP id 5b1f17b1804b1-48e51e0837amr276137205e9.4.1778361417277;
        Sat, 09 May 2026 14:16:57 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d89af2esm30110455e9.0.2026.05.09.14.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 14:16:56 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v7 2/4] mptcp: propagate RECVERR sockopts to subflows
Date: Sat,  9 May 2026 22:16:45 +0100
Message-ID: <20260509211651.104934-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509211651.104934-1-devnexen@gmail.com>
References: <20260509211651.104934-1-devnexen@gmail.com>
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
 net/mptcp/sockopt.c | 133 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 109 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 114436d2e401..fbbd1692af7e 100644
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
@@ -394,6 +400,81 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
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
@@ -932,8 +999,11 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
 	if (level == SOL_IP)
 		return mptcp_setsockopt_v4(msk, optname, optval, optlen);
 
-	if (level == SOL_IPV6)
+	if (level == SOL_IPV6) {
+		if (sk->sk_family != AF_INET6)
+			return -ENOPROTOOPT;
 		return mptcp_setsockopt_v6(msk, optname, optval, optlen);
+	}
 
 	if (level == SOL_TCP)
 		return mptcp_setsockopt_sol_tcp(msk, optname, optval, optlen);
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
@@ -1493,6 +1569,12 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
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
@@ -1537,8 +1619,11 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 
 	if (level == SOL_IP)
 		return mptcp_getsockopt_v4(msk, optname, optval, option);
-	if (level == SOL_IPV6)
+	if (level == SOL_IPV6) {
+		if (sk->sk_family != AF_INET6)
+			return -ENOPROTOOPT;
 		return mptcp_getsockopt_v6(msk, optname, optval, option);
+	}
 	if (level == SOL_TCP)
 		return mptcp_getsockopt_sol_tcp(msk, optname, optval, option);
 	if (level == SOL_MPTCP)
-- 
2.53.0

