Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE84038F653
	for <mptcp@lists.linux.dev>; Sun, 31 May 2026 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780239606; cv=none; b=H79h+mnrrD7bdckAWQUr3rlnqRCmNxMAp7yNE6XIkkxUDPuXomyRgRvAt+5CR1mwFg/87M3HUwwrgwORxv3lD2j/VHLwf6107cexHGkmLJERLuDzdlG2BSMjRR9SRbWUgeEsUaFkg90VVqhHpWnDTlJd6n2Jk3XmAQqOTvQaUOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780239606; c=relaxed/simple;
	bh=Sm1aRJcx9WN39lT7jimSfvsGSCRCbwufyUnFWQtkyJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDdxXEzP90bcUVhEGpBOnfQ8ras3tnsl/lMb7fzvhvE6ts9FkH/AahUg0LunJQCHeY1FPK0AFl7vRB8pWLZvKZVy4lqflobm00Zkp84ICthjm9/dPa/dlGBngFphi+7PLkWymR9iSAvVxqjZwtAxFnN2wyKrJS86UWE0VcXeuqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oI+jWl93; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oI+jWl93"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so1338528f8f.2
        for <mptcp@lists.linux.dev>; Sun, 31 May 2026 08:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780239601; x=1780844401; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2bQNClhWj4BQV5TCxgPeXRdDDcMegD7PhEQZl5kbOY=;
        b=oI+jWl93sSLP8oD2TMyTKkg439Mq8rd+taqiljozjjFz9a9FskdJEQGngD9WNTS4Sc
         m3LwPapdDiMCpLhTKFkUooJec51yGb8GTtQAmrJ2M0LiS14s/EjlhAisHiJT7intXVuM
         yIPlu103fmt8X9xAiTWTxYIw0RY4oTvXMXWvA6OmsgN1QpL02BPBJiO0UwDwAiVVOmxI
         7q58ilTWq6FtGSF6LwiWuEJg43TMIWwHbhkBeKhXb0vbPl+qNafoemOBplgaIBoio/v7
         oGzYQN88X9m3QHOXg7y5EfraFfvkyha5yEqy48iP9s1Wx+0/amqnHaHj0RaOTu2Vm4Wm
         xpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780239601; x=1780844401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y2bQNClhWj4BQV5TCxgPeXRdDDcMegD7PhEQZl5kbOY=;
        b=ZWYMG34I6JxFNk5ZF0KfvMDM4FGuYhxmFvmphHTyoDXr+W6rW7be6wMAQbUyMualtW
         rXQ//XSnMv93wrZupy+K9wkt/7Y4pRpSlwjJFJq8GF3aCJuoQ/1w1TirnxAnGyxmufa9
         eMNa6zWSZdIR1UUJ49shhZx3gQe9SiVSSMyFxlWd7ZvWel1bVVjZ0797CQqI5dGlHQZ2
         aG1aESbE266zhJX4C0Hs6GLWKpeE1fa1E4rRZm2VJWdVO3zPXLKggukHwP634USKGlnF
         0b1+93uM/I+QXsd7O4Tmlj5sjVsreRpTekDJzyg2j9ROv8w65WEbuQZJu0FvGy0AGqsT
         5YxA==
X-Gm-Message-State: AOJu0YwmrrzmQ7NOfVGVfIEf8KeRLqLOf5WTCMFOC/vu6hUaClekjRTT
	TXAwT63QKIJUyqA4byZ3u8QgZ7RESZP7AkmYNuCYfIYyi4jw2NxH0hlqP2KBjA==
X-Gm-Gg: Acq92OGaTXH2CISRL/Sa+3XKlg+mIyrL62tk4vhbnW0T9Fir346MF3P58SJIHDPdDjH
	nGv4AcI7420nuRTbCzV37iYryFDgJfdptWkDB0EWGsiuQ90mDJ7zXZ8i/Bv29F+dFW90RTVAqQh
	OIhdwVK1ajTN/JESMBN/Rx+UT0wJ2zrgnvDev//l9bbcCt6lbiJDlCmywJOtHn7eJSx5JwRs4si
	3Bo1i8H7RoODxjzz1I5bTmaCpif+xuP6nt8q2WOQsWJhfnWk3KY7H71oaDkp5oGUnBV75oIknIV
	0CtQ+1FGV3m42Mxe5dAt9q47ucAxXBay+y5wsIQaFeaYIoWYhJbm/BuzlgTFucbHjbcUqCkV/Fi
	ozGXEa2kbvotiYHvdJInYP2GZUWH9TniQ4ArhhYH3yj+ng/K5nfzH+xwW99gIwAKHKChMXwhNtE
	RyGqAxs3o1GbbVMLwW+AwL/uJ1Mowz3jUsNwBh39c8RK2lgI+dkRii5e/PEq2/mHsvh1XMsB5JL
	d/Dqjobb2+ad/l7kf58fg==
X-Received: by 2002:adf:f611:0:b0:45e:e44b:312b with SMTP id ffacd0b85a97d-45ef6b55d5bmr9607699f8f.18.1780239601050;
        Sun, 31 May 2026 08:00:01 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3587072sm19133545f8f.34.2026.05.31.08.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:00:00 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v11 2/4] mptcp: propagate RECVERR sockopts to subflows
Date: Sun, 31 May 2026 15:59:51 +0100
Message-ID: <20260531145955.322337-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531145955.322337-1-devnexen@gmail.com>
References: <20260531145955.322337-1-devnexen@gmail.com>
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
 net/mptcp/sockopt.c | 140 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 117 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 7be9a46cbdbe..a2a980304660 100644
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

