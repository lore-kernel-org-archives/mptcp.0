Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF56EA51
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 09:19:16 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 130-20020a1c0288000000b003b494ffc00bso249078wmc.0
        for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 02:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=5knTb6IDn+ThzKUjPbnne3nwnpWv2uOtNFRFpDFKse0=;
        b=yCleEs3YxRxFTD6qdrC14ALInCKuxgxL8P8nB5z5i2ncoXV3Fos0DxMqj4w/hwhI/D
         S8BKbjVuIrZdqmrHGrxxnIbaKE9yTnWNdbUAzIgrK+NMuL9ISIO1VqXNemgLOu9ks6OE
         foJ5jow//+1IGHa25aus7acDqYMiR51S29ZUI/0/BpCBBLPZAPV57q2OHAt0wcVRoXnE
         yQ4RmXWFvJB/ydpBk5G5z+oLpAtooybQi8qzMFQ5InTVPb9K4dkg3kt3b3P9hLoFtUZb
         8V4M32w5+vo3+2bdJeYxuzXNP6s9LajZb3yZ3nAN7YLM/LX+xO80V3kTjrT5qghUb2SL
         QTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=5knTb6IDn+ThzKUjPbnne3nwnpWv2uOtNFRFpDFKse0=;
        b=2jGOGYQPqyCoTgc+h46TnG00IaOwz0idS2u7r4R8rlXBjdyokAn4eW4mnIWqPlFLmM
         3ZqFtT56SnjHpYEoSv8cIpum9PLzS5+x4K04KNFvDcMh1eOuJg4n1Ti4Jg5+jjGeLsBE
         uPca7XQQ/4eNA/e2HAhaz5Ft9+QQ3ZG0ldQVJW69VHULmcJ/0aX5SQDgYBQC5RCNijem
         HUOR/A9oD3zdUbrnXWdlVn8pAi5ssUfTqI14HHnqbRHnjBhqxFgvnp84nPusE9XuVcEz
         g2mWWWRATnHjrlobKTSlfwiajSxeffh3FMpX6G3tNY/9ivrQOsLYQLilekZXkVPnqn5U
         4V4A==
X-Gm-Message-State: ACrzQf2prHF/A6bUyDmvVjBjBRydaA8Fjk9D1Y4Vrd6TYSckPC+qz51e
	Ws1whZyQQyUNM5wyyI45iA1WQB7Aqf0Sh6rc
X-Google-Smtp-Source: AMsMyM4TmiLkr/34aMiEc3mTiayaGMyN1I49F97yA+wcWU/n7iASWfkom0G+E5pSVKLO3nIib52+6g==
X-Received: by 2002:a05:600c:4f46:b0:3b4:fed8:331e with SMTP id m6-20020a05600c4f4600b003b4fed8331emr6043727wmq.198.1664356754971;
        Wed, 28 Sep 2022 02:19:14 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bq21-20020a5d5a15000000b0022afe4fb459sm3799851wrb.51.2022.09.28.02.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 02:19:14 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next] mptcp: sockopt: use new helper for TCP_DEFER_ACCEPT
Date: Wed, 28 Sep 2022 11:18:52 +0200
Message-Id: <20220928091852.1933333-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2052; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=80h/HWcgBlVdso8XPNXEkpdA2HGGN2JknGp1a0yxT7Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjNBE2m3jysoiCYumIXTXua7tT9Y7Vj+Dqt+UiNHbK
 xGwQmjGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCYzQRNgAKCRD2t4JPQmmgc/WTEA
 DrFRgrd7cGO0oFzuHc+zYyAWgX/s7N/e82CgyZhONcjL736CI81mnjfeFU4/YnNXFJubsbHDHOtXRf
 s/s4ji6WXJz0xFPBQr/wwTfkL2thoAdzEmd99TLEhSPQdOdCa+iGUlFyP28v8OWBVZAAArDrc0r6sU
 6yu3diAajtrItUkiXXJoMhoP7IiC07TtedXkpNuta/qnKja71OPv1NsWzwP6s2cQVN+19lQ2ZOpLsZ
 03o5rZ+tzCNQkisVS1N+os1lvOVgY4E69ZeFNJvKxZAyfxaV6TQLTkzC2hnrUe3fX/PS+UxXQ4+vna
 ybWYCaDe1Bt4I/0XVs/NYbqsXgNyQTneQPPjAImswVusHPq1VVn3KIrZgDANwhlfge+2SLvX1EtY2Q
 QlhyrD2D/pS88ySplW142EmVoF1DMrntXYwlp7O7m6H+2jID/8pAc4q59/zCApKn1tEYDWL8o9IhIA
 qIDdpp6HmuInvDNdzLRyH59RaMxmHxMxgj9nqu6MrMFvmbizHg8wknwF1f6WWU5ydPgK4ITRr6KDUn
 wG5adsRZWQRYDAQDId6vyWjoMhsmTaP7oYC8wQNqmIJ6DmI302ATlh5uojFWx4ExI30PZuWp17Lc28
 GEXzeVyBl7kHzr/lcD/3BUHcMskufIo5OY8VmMNck3pm36ap3Gvz1B/FnAgA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

mptcp_setsockopt_sol_tcp_defer() was doing the same thing as
mptcp_setsockopt_first_sf_only() except for the returned code in case of
error.

Ignoring the error is needed to mimic how TCP_DEFER_ACCEPT is handled
when used with "plain" TCP sockets.

The specific function for TCP_DEFER_ACCEPT can be replaced by the new
mptcp_setsockopt_first_sf_only() helper and errors can be ignored to
stay compatible with TCP. A bit of cleanup.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/sockopt.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1857281a0dd5..f85e9bbfe86f 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -758,18 +758,6 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
-static int mptcp_setsockopt_sol_tcp_defer(struct mptcp_sock *msk, sockptr_t optval,
-					  unsigned int optlen)
-{
-	struct socket *listener;
-
-	listener = __mptcp_nmpc_socket(msk);
-	if (!listener)
-		return 0; /* TCP_DEFER_ACCEPT does not fail */
-
-	return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT, optval, optlen);
-}
-
 static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int optname,
 					  sockptr_t optval, unsigned int optlen)
 {
@@ -810,7 +798,9 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_NODELAY:
 		return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
-		return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
+		/* See tcp.c: TCP_DEFER_ACCEPT does not fail */
+		mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname, optval, optlen);
+		return 0;
 	case TCP_FASTOPEN_CONNECT:
 	case TCP_FASTOPEN_NO_COOKIE:
 		return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,

base-commit: 6711fbb5e6c8541f84685542127455c18145d559
-- 
2.37.2

