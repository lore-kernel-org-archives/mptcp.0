Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966CE2DEA98
	for <mptcp@lists.linux.dev>; Sat,  2 May 2026 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777756819; cv=none; b=a7BRpl7dmtBbaFghn13/k2vG9bHnryYIYMOfiIELDBd4p/YJwkB5FsekfauTZRJ/3+fdZUHi52bQxd7m+g6IWv8w5ZWsf2MWDoWlb3LMgBQN6yb/cCl0VBQv8oAeK+xMju0T6ufpeMAnby/zfNXrX2p8Nj6Ij/RdYkQQbQnKklc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777756819; c=relaxed/simple;
	bh=dRw03HDHPifZK+1/GQrOdbW8fYCNqkTv127CMHBg9UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0UAH68SodHI8ssc+4aGkx7XhvGfQ81hzgHGYflQVYJTd5+Xpt8ajyW8pOaVh+vIQs/Xl9GrDYL2IeDyPR56ci6VoGko0N3EDIg+9PgWI7xMKu6Wqq2QBsmoa5AQ6hQMU9GH3oOoohAo/RQwBs/1u7saXPawdh9Sj20bIwaLynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dn+q+hjp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn+q+hjp"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d75312379so2201179f8f.1
        for <mptcp@lists.linux.dev>; Sat, 02 May 2026 14:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777756816; x=1778361616; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tn5z5rghKByXHpHoCWMCWDKnfvZ/R9vY3BgrEcYyArE=;
        b=Dn+q+hjpfLHstxvF9bxGT/xupYcjX//VXKdtA3hz+tYuF7ydcYZLPvBnDxv48XcPMF
         DxWIul5C2GJSpAh8RRXNI0PgqdbQAp19odANK5XaqzkavWoRGMMhovs3lXvbL3ZwLdXw
         PmnDKXdCTc0SvOO8Xg29zNNpkLLvTznvCkauDmPqLFAnA5tdQ9qCP6WkleUojE5f6L+d
         WHzN7PBNxV8Dnnc4am9eZZ77dgEG13bkk1DlFqcN6PsSuhnzqLPg+RClMlEovAR1uZR6
         LqsISDd3B3D3JMiqNS4Te/m+NGLbVHKY8udxxtJmyBI3VNBABX4ByL4puiWBfAIUVBz7
         xESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777756816; x=1778361616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tn5z5rghKByXHpHoCWMCWDKnfvZ/R9vY3BgrEcYyArE=;
        b=RriOSKL7WijAZqCwad9Z+lZes3os1rEU0IaME8QqecIdWaW6+FLPQPJBAIp65aUrAx
         cW/KF8ZhvPoBgZ9rSYyDlD+hK8i2gHoh6GbwOWVV/tNDgDM5fs/BFZm/qs8tSj1J2O5A
         Dp03NSFXZkP6APGL8/m4H/MxT58I8P/k+792oBg5ZkyyQKtNYVQ3Rwi8/3LUgDrsizFi
         v3Y4Yq6x350FwdSdIVmHOVir8pDYn1QQFl3/tJHCtn+cWlChgHBff4Yg9zq26YYVh+yO
         sJkYYhtc+26kB3UWQVW3C5Hf6xcNMHnwYIkAUQl2PoTDupbPwawPNN9xddf3YBFIw3ff
         aVPw==
X-Gm-Message-State: AOJu0YznRmiCyJ1W62t16gGPW/2htfA1j878BG8Sb9BUdgC1kA2Sucxs
	3JFEz+h6jg7nHeqJAHG5xxRyWVVV30ylgnpt+SWG3DrD+MD93cpQo77o0fIfTyz7
X-Gm-Gg: AeBDies9rKTnmajSY4bHY2x8rmGuLTokswjywb44yjCQ7/kFISga+4pkCprjQl+Hw2H
	QSewlvVcDhurVnE9Lqzo2KNmG05LWpTlycTE9Vx+9NTTrbkVk1R+26p3CtcDJsItzcFkDD7jpnP
	paH0VmA6b+W+g/+N1g9TQYyaOxXmOW+iJQ1GCjDAFjkl7RFkgQMuifXzrEr9WezDvxyNbX9/Kmp
	7q99f+TPZ6Q//gY247b3PG82hG6s/ImrxfXtAZct3/KMTyIpTqajgonf9Ny+RetM2OzaOegHOmk
	U93n13PKocyYPGvd/Tizc0uaOnxkv5A5nfsHtID233+faajeercxQnD86VyI2ivd6GMONd84Qpi
	PHUD12nWY1XEBzklCaYERnrqZh9TdZ4ZuCPlQgXxb9AYf1UoFItcqtHCyjCr8dXii1JEqfmV3iH
	f6Q1jeEHwjGEuQMtA/AjOegAWA1Y+BkFyAJ77iyX7wghzo9csngbm9CGASdE6ERelx/0Z0s/c7y
	/6oVyonsNfDHF9dCvz210sU8vdwmaf/
X-Received: by 2002:a05:6000:2b07:b0:444:1fd4:a4ff with SMTP id ffacd0b85a97d-4494e5f0615mr12049714f8f.9.1777756815481;
        Sat, 02 May 2026 14:20:15 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a981defb3sm19490140f8f.20.2026.05.02.14.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 14:20:14 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v5 2/4] mptcp: propagate RECVERR sockopts to subflows
Date: Sat,  2 May 2026 22:19:58 +0100
Message-ID: <072e47482484e10bc8894fda10e9c1e27ba5a27a.1777756707.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777756707.git.devnexen@gmail.com>
References: <cover.1777756707.git.devnexen@gmail.com>
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
 net/mptcp/sockopt.c | 95 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 77 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index b828cdd9657c..56265b076f6e 100644
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
@@ -388,6 +394,57 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
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
+	if (optlen < sizeof(int))
+		return -EINVAL;
+	if (copy_from_sockptr(&val, optval, sizeof(val)))
+		return -EFAULT;
+
+	if (level == SOL_IP)
+		ret = ip_setsockopt(sk, level, optname, KERNEL_SOCKPTR(&val), sizeof(val));
+
+#if IS_ENABLED(CONFIG_IPV6)
+	else if (level == SOL_IPV6)
+		ret = ipv6_setsockopt(sk, level, optname, KERNEL_SOCKPTR(&val), sizeof(val));
+#endif
+	else
+		return -EOPNOTSUPP;
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	ret = mptcp_setsockopt_all_sf(msk, level, optname, KERNEL_SOCKPTR(&val), sizeof(val));
+	release_sock(sk);
+	return ret;
+}
+
 static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
@@ -430,6 +487,10 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
 		release_sock(sk);
 		break;
+	case IPV6_RECVERR:
+	case IPV6_RECVERR_RFC4884:
+		ret = mptcp_setsockopt_recverr(msk, SOL_IPV6, optname, optval, optlen);
+		break;
 	}
 
 	return ret;
@@ -775,6 +836,9 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
+	case IP_RECVERR:
+	case IP_RECVERR_RFC4884:
+		return mptcp_setsockopt_recverr(msk, SOL_IP, optname, optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -802,23 +866,6 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
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
-	return ret;
-}
-
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -1463,6 +1510,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
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
@@ -1483,6 +1536,12 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
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

