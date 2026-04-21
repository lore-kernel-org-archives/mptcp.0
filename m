Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E0528980F
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776798825; cv=none; b=GD1uYsypb3Fb/IM915N5Zc1FkyH0VgMqErnaQGIVnvfis5rz2gPUnva8nJw7DUQirnpadoaqSnpz6/9ClKn+P0WStRehQga9tJXkI+3P+vbieHuHcq7a41Pe2WkWc+YTFDROvvMpe1ZFUNMGCNkbfgHp9zWVgmr0kW6HwAVeFfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776798825; c=relaxed/simple;
	bh=H2DxqvPp1p1h/pp8QJa8KtnMGSyLhcvXbIy6wIAiF9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4CbU8hV4NCMi0UFaB3R4Zsz9GrhP1gIU0MhAsiPF+gHz86+MRizz8IijnLmg9LQXOQlrr7WijdWR5boi0XCIkJAEB5J5/KyRUVT04g0avdKxJAYEuTDqvZqemUutEs06tTF9XKbnF9JVwolVDKb/aV+n2vEb0+54mCWcxfVX5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdvQDYTm; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdvQDYTm"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d73352cf2so3866262f8f.1
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 12:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776798822; x=1777403622; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2WxMhAslpbON7+vuHLR3IrAIYssnVtmPuFkoGSXvBI=;
        b=DdvQDYTmKNs5vp6VEyPOSVskKFf/QpGbUZQCK0cSdLlmMXe3t9Xo1ChejZ0t4XQKGN
         ZRR0QdgCUpYhEXAAki22MkR0U3Otx0cWn1na+ri/22P0NPuyn6VCu5MZX6/3JGiWSCoD
         GgbjstaOtx/gJfbwH8BfMed8xThU4gtU3JR9TAMNLLjs07RxWmYqYx8tFsm1Nw/QF1AO
         dwyhTJ4cPAanJ9TAQgMhgtHAY+T/yVUn7VoRRL7DkPXHLZSm49XsY79xqX8TdS3FgfYp
         sDkB87GlgNbWC5CzA2OjASYwrkFvMrOMdH9JDIizP/juwgHQd6ueFTwgMuR/I6iqiA/p
         CWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776798822; x=1777403622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/2WxMhAslpbON7+vuHLR3IrAIYssnVtmPuFkoGSXvBI=;
        b=Rwe3bLYv7IbKIgnjzihhas+4q93lQQexKaNBlqLikaJgjq88rVJH00MDVd4sfNg333
         8E9ESEWkcYVWusNhFxjlFiPLzJCc4bBLIqo2Y1VUU6RJKgD0JFIt6MngacmeKaysyGXT
         UKDRxOov0/2hzWrHzg5IbosmL1T8PCDl7GlEs9Wvn5KnSRnoukQg8i68Zf4vx9q5POvb
         fjwtxfKJ6SXDgbXRRr6qQZHOg4nQ2FYNqSUd9tQQ8gzegrRMVuajLl441OrrI6Kz2EEr
         clxpIqrVHD9I0OZNfQ3RGa6R1ZFcr6tEVSfWqr/C3KmEqe/yChc0kYlxyLLl3GKdYNXh
         IZWA==
X-Gm-Message-State: AOJu0YwXF7Z9lJ3f8+Xj5EuzTFp81TDD/8r1GNvU8aSGpSrhFAVuh63q
	LqWL3RNEyWHATZse1UxWemKe7B3zXAoJcnz/6IWTCWvg4YA5CEnUISdr1hP6r8mv2xU=
X-Gm-Gg: AeBDietFGNESbRZ9oY8G+9p8JZ0Eyru2emmOJjjvhffaCqc0s2LzgFGKly32SjO0d5f
	/40FdI7/gizZ9uf0u18mC1rr11oisgm4FQaIj7BR/CfPL1aud5r8AIUXDpXLyW8RDMEpmclAVCK
	X+sLqji4sAxIRGdSQ0csvqIVBRCooNATMlFLD419ATSs7LzZjpGhUh39lqP/gbPqS2dcl1z16jO
	Ii0jl4X3THaPjpEg/xAshKC7pvsxyIqQxA9+VhpyqcCQbT/SvgIkS2e0XrtLYPFkTvOHqSWeytU
	eHOhhyf8DSpxKX4wd1m7wWKy5voAtLaPM4HSgnSGLZX57R4Ja4klYx/BdXC7gJXMZ/uv2GByn42
	ZlVY6fGwt+gtUGK4Dblt8MsY5rQV321Itf5G8w4Txb3C7lNOI6EMnYGJZbUfY/TJyKXcK/Rt+0s
	hAiW7B50U63e8f/WTjmYZvib1K9/khKGe34KOItVkfIkSSDSeo6VV72V8ly8a0AW/tBQQqctYoQ
	SpiHzybU0NymioQpsTppg==
X-Received: by 2002:a05:6000:40df:b0:43d:a37f:8d5c with SMTP id ffacd0b85a97d-43fe3dc812fmr32694067f8f.17.1776798821544;
        Tue, 21 Apr 2026 12:13:41 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d112sm43859447f8f.29.2026.04.21.12.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 12:13:41 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v2 1/3] mptcp: propagate RECVERR sockopts to subflows
Date: Tue, 21 Apr 2026 20:13:35 +0100
Message-ID: <20260421191337.58341-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421191337.58341-1-devnexen@gmail.com>
References: <20260421191337.58341-1-devnexen@gmail.com>
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

v1 -> v2:
  - Retargeted to mptcp-next per Matthieu Baerts' feedback (net-next
    closed during the merge window; iterate on the MPTCP tree).
  - Guard mptcp_setsockopt_v6_recverr() and its dispatch cases in
    mptcp_setsockopt_v6() with #if IS_ENABLED(CONFIG_IPV6) to fix
    the MPTCP CI link break on without_ipv6/with_mptcp configs
    (undefined reference to ipv6_setsockopt).

v1: https://lore.kernel.org/mptcp/20260421152216.38127-1-devnexen@gmail.com/
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

