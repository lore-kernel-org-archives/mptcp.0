Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659B028643A
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810826; cv=none; b=gMMQE7Yne7XXTXrwuQ1Ek8ZUWWIjKlvG7gSlpBp8v3lJc0NZ5INL/NYDCt4Mlk/uNDXgi60H3ZmxjPMN/V0gFegTWmrlXrLRwCH17MsJNga58tzKySoWoFm8MI9v03tj0websyF/JQEoIHWI/xQBryUrW27d9oo0GnW9xylpVWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810826; c=relaxed/simple;
	bh=gP3xPc2+iFOqL5Q+LRb6XPRPMrGN4TgqPKGtHGkGx6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tN13IeBombrQXdNNbUDYwrnMrHkSrq/3RXLBiMhYPzrwLMDN8FZydzf6w/mp2HgWng0m/XTJQOdErSi27UTdvP5ZRVY19WSXw6pdjKZdiD3AHXq1WwZIj5NReJJdXESBt/9C8ljdaXllriADo0tCLCSkzAIYSamw6bpyOeaJeOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmHpLMC0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmHpLMC0"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ad135063so40873995e9.0
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 15:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776810823; x=1777415623; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYNaU+7FMxSTwZANJDmlLzMBd40D//blvKqYMGhS5nM=;
        b=WmHpLMC0PaMFLfNerQncuPuj94XaDw6gA/8ssSBP6fYRav9bc8/3Li83RsRZruaJSl
         0Y9qeA25IDaDrqLQ4F5O/0Wg6g34C8IDuq8XxYRuWwf3Asc0r3Rl120kw6WiqYsV27lA
         FtpsQhlKYzWUljA95G7kY9q/eAuVlXwvVsG4k14IHoszPLiwwxoacfTe3mTHghwSCE/+
         up0XzN9sX0c2RON+F9473ZUrZqn0IfcjQkBBP2m7eDByK6vPJerLnPV8vnx/Frdii3h1
         4aQAzZQgK2J5xFXJXmuUkjxPsJ8DzNwAE9e2CNZEhI8Y/PJgzReZata1fTB8eddbYIyr
         DENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810823; x=1777415623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xYNaU+7FMxSTwZANJDmlLzMBd40D//blvKqYMGhS5nM=;
        b=IewnMdwoiVQaMNDxDVd5kfrSqCDWjGnJhPykddt6KCIyG9dEsn20G3oUXMHizg/avG
         EErfT6mT5atWSe+DPsxWpeVsRu2lF4EulEnRVJjxOzZAEpr7gFQa0+Y9UpdxaaAC4uDC
         1e20eoAx4rodakVLDwVCDVdw95S2uaU2YSx0RjFQJSmSUJYiXuW3+WLIic37fzn+D+Hx
         Fvp5Zdge0wVPnDuzB+nNlZ4LKkVUd+kJb7LPtVPLr1XFj1KbaELjenfn7Rsqop0hXFGv
         wnD0xLClJtit/ntCvJEHuwUSt+lE8cg194phkJ2D15n4q0etLdNkU+9NBj71jcY0Ln6D
         ltzw==
X-Gm-Message-State: AOJu0Yy55maH4m2YprRs5ZMyFLYwCQNdF2baZ5S1Ee2cHg68xU55dlsO
	vHotXu7wejKCmMhCfetfhkUifrg3sKebH6AK5zCRynDaUgiafw1fIbrwwJ/j79Kv
X-Gm-Gg: AeBDiesMduH1gQTOoW9IxCDdZV6llM5DQxUPrKDyivrqd3KWJBBkl0pJzBpAY8i+DxW
	lHYv6bx5V4zrl7/JS+/lQCPfPYTdHCB9v5ZZ0ruH6hgAVrQ4CyKy65c8n4KADCNyvhEjQQw/72A
	jo+O3YBpen+fD9xB4Yae2yRP0VGavbBpj0DKtPgE1uuAO+MpJ41ZykgA0G3DqW4XGGbpu5fRwAR
	u/BSaShaytkU/fp6PIrYVrHS1gEjaVfQXYL+H8UZ5krVEbmbc7RYwKdoxGRa5KVb0xhwFdFbmhi
	jwMhNVLFHhttd2FJcarjNU4MEUxcmqW+AQg5zWA9D22VJ1n3hGTAcdjR7zQdomhxvcpb9RFK/cY
	kjTHtGnrp94lEJgRxCPirqsa9ZPHhW+Dp8Xo3nPutiEsGU1+8aq5hU1fvO0zPW3OY2EbDw8L1bG
	tXDhU/9U8FcUB6fnq222K4k4BGU7Zz20aLk3JT47M9zlF7jx7EWkI1wM1CHETnwmtMXEB7dFQnP
	Sl6LhlXOhZXu57fXwzXWQ==
X-Received: by 2002:a05:600c:a30b:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-488fb74dfe5mr195605825e9.8.1776810823459;
        Tue, 21 Apr 2026 15:33:43 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c01cfsm413350505e9.10.2026.04.21.15.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:33:42 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v3 1/3] mptcp: propagate RECVERR sockopts to subflows
Date: Tue, 21 Apr 2026 23:33:36 +0100
Message-ID: <20260421223338.52743-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421223338.52743-1-devnexen@gmail.com>
References: <20260421223338.52743-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Propagate IP_RECVERR/IP_RECVERR_RFC4884 and
IPV6_RECVERR/IPV6_RECVERR_RFC4884 from the MPTCP socket to
existing and future subflows.

Apply the matching sockopt according to the subflow family so mixed-
family subflows stay aligned with the parent socket configuration,
including disable-time errqueue purge semantics.

Signed-off-by: David Carlier <devnexen@gmail.com>
Assisted-by: Codex:gpt-5
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/sockopt.c | 129 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 79db15903e7a..acb0ca330e44 100644
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
@@ -384,6 +386,72 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
+static bool mptcp_recverr_enabled(const struct sock *sk, bool rfc4884)
+{
+	bool enabled;
+
+	enabled = rfc4884 ? inet_test_bit(RECVERR_RFC4884, sk) :
+			    inet_test_bit(RECVERR, sk);
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family == AF_INET6)
+		enabled |= rfc4884 ? inet6_test_bit(RECVERR6_RFC4884, sk) :
+				     inet6_test_bit(RECVERR6, sk);
+#endif
+
+	return enabled;
+}
+
+static int mptcp_subflow_set_recverr(struct sock *sk, struct sock *ssk,
+				     bool rfc4884)
+{
+	int level, optname, val;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (ssk->sk_family == AF_INET6) {
+		level = SOL_IPV6;
+		optname = rfc4884 ? IPV6_RECVERR_RFC4884 : IPV6_RECVERR;
+	} else
+#endif
+	{
+		level = SOL_IP;
+		optname = rfc4884 ? IP_RECVERR_RFC4884 : IP_RECVERR;
+	}
+
+	val = mptcp_recverr_enabled(sk, rfc4884);
+	return tcp_setsockopt(ssk, level, optname, KERNEL_SOCKPTR(&val),
+			      sizeof(val));
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static int mptcp_setsockopt_v6_recverr(struct mptcp_sock *msk, int optname,
+				       sockptr_t optval, unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int ret;
+
+	ret = ipv6_setsockopt(sk, SOL_IPV6, optname, optval, optlen);
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool rfc4884 = optname == IPV6_RECVERR_RFC4884;
+
+		ret = mptcp_subflow_set_recverr(sk, ssk, rfc4884);
+		if (ret)
+			break;
+		subflow->setsockopt_seq = msk->setsockopt_seq;
+	}
+	release_sock(sk);
+
+	return ret;
+}
+#endif
+
 static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
@@ -426,6 +494,12 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
 		release_sock(sk);
 		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case IPV6_RECVERR:
+	case IPV6_RECVERR_RFC4884:
+		ret = mptcp_setsockopt_v6_recverr(msk, optname, optval, optlen);
+		break;
+#endif
 	}
 
 	return ret;
@@ -760,6 +834,33 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 	return 0;
 }
 
+static int mptcp_setsockopt_v4_recverr(struct mptcp_sock *msk, int optname,
+				       sockptr_t optval, unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int err;
+
+	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
+	if (err)
+		return err;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool rfc4884 = optname == IP_RECVERR_RFC4884;
+
+		err = mptcp_subflow_set_recverr(sk, ssk, rfc4884);
+		if (err)
+			break;
+		subflow->setsockopt_seq = msk->setsockopt_seq;
+	}
+	release_sock(sk);
+
+	return err;
+}
+
 static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
@@ -771,6 +872,9 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
+	case IP_RECVERR:
+	case IP_RECVERR_RFC4884:
+		return mptcp_setsockopt_v4_recverr(msk, optname, optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -1459,6 +1563,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
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
@@ -1479,6 +1589,12 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
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
@@ -1536,6 +1652,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 {
 	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
 	struct sock *sk = (struct sock *)msk;
+	bool recverr, recverr_rfc4884;
 	bool keep_open;
 
 	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
@@ -1586,6 +1703,18 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
 	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
+	recverr = mptcp_recverr_enabled(sk, false);
+	recverr_rfc4884 = mptcp_recverr_enabled(sk, true);
+#if IS_ENABLED(CONFIG_IPV6)
+	if (ssk->sk_family == AF_INET6) {
+		inet6_assign_bit(RECVERR6, ssk, recverr);
+		inet6_assign_bit(RECVERR6_RFC4884, ssk, recverr_rfc4884);
+	} else
+#endif
+	{
+		inet_assign_bit(RECVERR, ssk, recverr);
+		inet_assign_bit(RECVERR_RFC4884, ssk, recverr_rfc4884);
+	}
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.53.0

