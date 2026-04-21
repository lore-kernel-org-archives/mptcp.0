Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526C3D8910
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784946; cv=none; b=A+tg8Ocg6lP1Zs+t2IGzDUDzP2K8ITxIwGYGOCJrwt2sF4p2hF1HZzpwwlkqUm9KZUeYSUvEnA8GHdIj0WwJY3qZVrAWM27OSyd24jsOiHMoQOd2J4LUDoPrEi+rQHH3WRL+0cBFTNkQLnqbd98XVyLWD1pkOuZZSTs99XoC4rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784946; c=relaxed/simple;
	bh=10bVTT8LwhDFPnvBCTR3jKRRmNsviYTHVq+4E0ZWOds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZQn7zgQkbbeb7W90nkC+rPZuFgflzb2ysvUFh+6kiWTmdiqJ2LzNN2w5OhnFFzYj4orElju3cO44A3gysuppTN92R2A3uMwfj2dHY/d+fSRwvyoq2NODTiXwoS1oHokYTekk/jz+pxKI4cQTwVedO/q2tsw2tV75UAAquCgW2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKtKeyYy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKtKeyYy"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43eb05b1875so2596585f8f.3
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776784944; x=1777389744; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vej0hMbFq4b4vlO5xettSBT3c1QoZw4sK8xxsnU8g+A=;
        b=gKtKeyYyF3RVT8pCmNLDIDSeRJhTz4FiKfqm1a0NnBv/ef6BmSyzvBbGx2ZXyrQbIe
         ANtzkiav9q2g3zXF9PnXgH9pXwVY5TlscuMTUx1tUUMKHXaOTCocfbGbFeDBDYNbEYwY
         1YUB0ryqu/Re7zIfGyzBj35pnkFzagY7xL7iUj+ckwYdy6ZJ+3F+wKCbKgYU0I58kWzC
         MTxBFGk2b5HqqSBOnHDb+DIjPk6nDMPazXOdi2YfeZ+Avz5ZFfdbZQBJrtR5JD+SYaQH
         Xektq8iychiFPzGXwHc8gizW7HG1rrjut4pLe2QYu88nj57UPgjxy8jxq4AKLUiyIR6A
         7UnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776784944; x=1777389744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vej0hMbFq4b4vlO5xettSBT3c1QoZw4sK8xxsnU8g+A=;
        b=roYvJqV+0zRxu4UkgGG+0nBzVxjahoJv5GFF4AY/aT9kjtygKa+XEAig6hbG/wmqbk
         16DRnHYUT3wuBFuKGGZyysyg5Wfh4N+GkC4472YIYWJCws2TGCh1VhqR9IbxMdkgenXs
         +5I3OF04J9rvu1oF43u9hMA1ly5seg6WPrX2hdFsDqLCfXQF2Qt+sQtoAvKquLGu9rCs
         d4EOGiwLJacK99klUvIYtiK+KjbnCPAId6uY5URwOHWin3pdaDVAQxRzaHkChP98lzmn
         YnWP1xBMyWTCaSxcoycqWROYzxZeYdRaNBkq6R/xN8O74lJyqer81hyGmosjOHXz4GYq
         dlTA==
X-Forwarded-Encrypted: i=1; AFNElJ8a9Qp6zG7IR9lUrYHrql7tDbVK2ySkWrtcOimH9m3ng6lRtPqFnF/hG4yvunIVOPZSSudQDw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7bDzy2ElaHmUTAzicwjZM0OtDS873MOHlqxATmxE9O6ehzftB
	vaTSSevuQN0ozHOPrgt4OytRwElhBihxW3BDxY7BBAJEsuKv87id93Cg
X-Gm-Gg: AeBDietNV9oJz4ah+mTRAHFGDHkBn2xAWC3ZB1NuOWZW/gbvdzdK5xgRkN78JcbPnQ5
	AUa3krjF7bA8rF17JGzxkjYQ+ERZQN8L34WlwQ3skl0sUULO/RnafiExlEWtzanL8PXuLWxPm8a
	tj5eSVbNjr2Yt96INd5Obt/CHxQMh+d3tzxPXFOdobSNp5+4bmShwSyzBGCYYLBT92u4yLO0IGD
	VfzYh7ceeAgWLIJjwVhd2kVy76WBWCh2K5wWniNokowQMiuErtHsBnFqb+y+qJOBMxhtbMvCaqt
	+DpQtE2SmISqdag2sWBRvaMgDocRq8Y+thYiMaUCaDl1MRlnvSKFqynxD4n2BB1rp1Q8NGt6bmt
	6R9ax2Bglikszd7pHNRh7wbIe+P0kYzmBQ656y3TeEgTfNFMtnNAOI6gs2rc6rrTn8iZstCYDMs
	QOitqrhrqNKcL0ZsbRi++5ectDdJMVmQV5VWpxm2AoVOgG1JWLepFHfxUlL02dBxKurf5/B90PO
	QJVhk9Lhf2y2cA9w8kXOQ==
X-Received: by 2002:adf:f584:0:b0:43f:e16f:3cc3 with SMTP id ffacd0b85a97d-43fe3dfd5efmr19868551f8f.22.1776784943477;
        Tue, 21 Apr 2026 08:22:23 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4411c9f4f03sm8975225f8f.1.2026.04.21.08.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 08:22:22 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH 1/3] mptcp: propagate RECVERR sockopts to subflows
Date: Tue, 21 Apr 2026 16:22:09 +0100
Message-ID: <20260421152216.38127-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421152216.38127-1-devnexen@gmail.com>
References: <20260421152216.38127-1-devnexen@gmail.com>
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
---
 net/mptcp/sockopt.c | 125 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index de90a2897d2d..b2b7ef888dff 100644
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
@@ -384,6 +386,70 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
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
+
 static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
@@ -426,6 +492,10 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
 		release_sock(sk);
 		break;
+	case IPV6_RECVERR:
+	case IPV6_RECVERR_RFC4884:
+		ret = mptcp_setsockopt_v6_recverr(msk, optname, optval, optlen);
+		break;
 	}
 
 	return ret;
@@ -760,6 +830,33 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
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
@@ -771,6 +868,9 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
+	case IP_RECVERR:
+	case IP_RECVERR_RFC4884:
+		return mptcp_setsockopt_v4_recverr(msk, optname, optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -1459,6 +1559,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
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
@@ -1479,6 +1585,12 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
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
@@ -1536,6 +1648,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 {
 	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
 	struct sock *sk = (struct sock *)msk;
+	bool recverr, recverr_rfc4884;
 	bool keep_open;
 
 	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
@@ -1586,6 +1699,18 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
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

