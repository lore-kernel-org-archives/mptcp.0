Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A9D373BE9
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777324215; cv=none; b=j5BxU2Ux+Sqd5dksvdfVqcEJHT6NqfXEYtkA8RdZ5Fq4pjPk744lWZ/kRzlXJ5ou0psBDRUn3x8FoNDXtumusH8XHR/M96FIwsGN93ZdJvaXchIqIbJah5ZInRVKHMgrPMb7cEazkcMO0W5SY6O7pjmwZGETWq+SxWcQRv1mbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777324215; c=relaxed/simple;
	bh=21n/IkP3HBL8pk/doD+Ot25dbNmAqv3B0EI6xv5U8i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4p8gAvau5BP2WxhJlp3R5q3TJx0rMsczS37nOQ6cItrc3BJmrYohzeix84eesRclKmQtroLmTfZuMUjjPRRStxQgdE1103KQ37UMhHD4zuAOzjWmKOO5eVUC4CRfHPFZaSX5w5H1d7r55UNhGEiJCPenhrdZdjdx39DKFdx7PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7QdU5Zb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7QdU5Zb"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so128632705e9.0
        for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 14:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777324212; x=1777929012; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfYiYNQJTdWnNWUoj9J/fGv+Q8abljuPE7hTCTHMhwc=;
        b=K7QdU5ZbucAaWs0udvNFKfqISjwqKT4uTSJmYngfdT8+a+VCgxS+DCTurnVEhxceRP
         GvHPtA83mgOuI/1kK5Aep8r5Q0za0BaH8rFInGIBdPGWGXbzQUdbrDELognBispFRG/6
         D8HCHOy7cY8btfJjXGd/N7rtbI/vXzWcgWh1BpsJHwm4mawJIZLLJ0pM4+/hxyLq9krM
         Kk/S/QR9waRO6k4UVvf6kc5va9zL/36WvI5gRwhLt8vhufsjc5Af2K0OgDcen2X+ERoq
         aF/2CWJ5jna/ZPmk0ZZRS4ddr/3xQD976rmyaOmBpaSHEIrGCM/P53rMMF2iM1SwSbJS
         qAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777324212; x=1777929012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZfYiYNQJTdWnNWUoj9J/fGv+Q8abljuPE7hTCTHMhwc=;
        b=N5ZL1hp57JYjjukJRPCGxrMBv0kWLQoZs3NNoLADo6ppg7I19XrAtSCifs33tKqCxu
         NB4XWU2xCDPuk/rbAec8eQbzkFJhEb9ASDLFQ1b8Zr0x2keXs4EuUZfgIlNo0tomXkl4
         MYSMNRANECqBEbZcpu3gdcDnvJMuWh04z87+Gvo/ZxEQQsUQDLFESkETNEOoXCM/NRtf
         kZTQrNQT8+eDEtuTHPFZYhrb/8B0l6DR1sxq9gz8UHZQmBEoeTS7l3ANdhXpIE5+OEKa
         EFfWwuj0e5ogscJUxxHGvhrztkYaKPJ+m2DdvZ6ZVdmuc4H1Hdu3QqpVKUNJaN4a4g2P
         MnzA==
X-Gm-Message-State: AOJu0YzTOEWSTdunjiOfqlrygSB0nUTkndInj44lLvK1ESYMeWf2HJdV
	+y0Zonwqd4JBDeK5CcX5D0WRs6FS77eK+QaAc2N9QUi3DGiiYNNXpWogyCan+Cc2
X-Gm-Gg: AeBDieuCyAU7kBDhDvgtP+Go/Z14ChxwOgcVdcK2gjsudtQxOOtrQBfU1JfNxKhWKad
	ShGAjJ1PZloVcOAZM2eXS929DyZxGFvcPwkRKnesWikL7aiNEKoQxy3Fi6anu5AL44lVz25nNpU
	UG9j62AOf3Y7QvSWFfIHMKqFIdTM+nwH4CcTDjusvDjFGBJGagO/dKNk7sU/+WM9u1hazjLJVX8
	fZkODEoCk75cP/pSrEb/agYIy203ppYRk3RVe42C+qcXQZsaFUwl8k9jePoguRc+icODArt7pwG
	BNHJVoN0ZikAFSS7a85nKVlFZwPmiEmSg/6KZ6bbJyf8jeOy/yOah/NyShM4buJZ40w6x2Yy3wf
	bGVb/HmubdTz5F9uq7mLtsrEe4jOkLLT3fH/nl0/ylMHi7JV1fb7TDHVVy6FKMmxX/ej9FAGTOi
	t27eqrk4LeGVl4IWidhAC2Tr378HFJYAqjAJ6/4LSRTRn//CzlCRdiXO2A5waLZ3JjDb5BwGnq0
	I3xqQBFcxRFWizUK9hUjA==
X-Received: by 2002:a5d:5848:0:b0:441:1fa5:457e with SMTP id ffacd0b85a97d-44647be581bmr736133f8f.13.1777324211778;
        Mon, 27 Apr 2026 14:10:11 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d5ee9ecsm1107145f8f.16.2026.04.27.14.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:10:11 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v4 2/4] mptcp: propagate RECVERR sockopts to subflows
Date: Mon, 27 Apr 2026 22:10:04 +0100
Message-ID: <21762831cbe0d70fd963dd7f0ed9e05b050a7d1f.1777324037.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777324037.git.devnexen@gmail.com>
References: <20260421223338.52743-1-devnexen@gmail.com> <cover.1777324037.git.devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Propagate IP_RECVERR/IP_RECVERR_RFC4884 and
IPV6_RECVERR/IPV6_RECVERR_RFC4884 from the MPTCP socket to existing
and future subflows. The setsockopt path forwards each option to
every subflow via mptcp_setsockopt_all_sf(); newly-joining subflows
inherit the four RECVERR bits through sync_socket_options() now that
MPTCP_INET_FLAGS_MASK covers them.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Assisted-by: Codex:gpt-5
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/sockopt.c | 97 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 79 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 41c9dc9cf95e..171e83e66a97 100644
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
@@ -388,6 +394,41 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
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
+		ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static int mptcp_setsockopt_v6_recverr(struct mptcp_sock *msk, int optname,
+				       sockptr_t optval, unsigned int optlen)
+{
+	struct sock *sk = (struct sock *)msk;
+	int ret;
+
+	ret = ipv6_setsockopt(sk, SOL_IPV6, optname, optval, optlen);
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+	ret = mptcp_setsockopt_all_sf(msk, SOL_IPV6, optname, optval, optlen);
+	release_sock(sk);
+	return ret;
+}
+#endif
+
 static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
@@ -430,6 +471,12 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
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
@@ -764,6 +811,22 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 	return 0;
 }
 
+static int mptcp_setsockopt_v4_recverr(struct mptcp_sock *msk, int optname,
+				       sockptr_t optval, unsigned int optlen)
+{
+	struct sock *sk = (struct sock *)msk;
+	int ret;
+
+	ret = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+	ret = mptcp_setsockopt_all_sf(msk, SOL_IP, optname, optval, optlen);
+	release_sock(sk);
+	return ret;
+}
+
 static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
@@ -775,6 +838,9 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
+	case IP_RECVERR:
+	case IP_RECVERR_RFC4884:
+		return mptcp_setsockopt_v4_recverr(msk, optname, optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -802,23 +868,6 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
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
@@ -1463,6 +1512,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
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
@@ -1483,6 +1538,12 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
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

