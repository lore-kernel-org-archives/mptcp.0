Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E87107A5
	for <mptcp@lists.linux.dev>; Fri,  7 Jul 2023 16:00:27 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso3200158e87.0
        for <mptcp@lists.linux.dev>; Fri, 07 Jul 2023 09:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688745625; x=1691337625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zs40Wv0SyhVUhbgcdeM7Gg6KzSx5ZB7NtkjcYXBnZZw=;
        b=KlkYl9N9/Itd0nGuIW0XAKhRux5HVXj+x/kI/n/6svqCb5rkZDsaUSqWqPL2AqCYAA
         EOLl8UKJSxI9HXSxx5m6lG//RCTcf5zMp7WFNXDtEwiTVuJRKQxLjI3jCeUOTDhUretb
         8VP+S0GQi5feUZMtoEllbbLsR/hOcaLbm+NFMHP8M7dPzF6Dc/ck7mBY7OAuNBG8H5kq
         C84VS1zUvX+YcWM6Sa5yR1NE8li8cCgesMCNHsPnqiPVofMtqN4zYgNDfq8MDyp8QzNe
         ZJU07HsvJeNh3QjXZmzSVDj363Qt100PheIBpRqnlBI49s9Lblo6CtiBNWuUxgBJywwW
         4rAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688745625; x=1691337625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zs40Wv0SyhVUhbgcdeM7Gg6KzSx5ZB7NtkjcYXBnZZw=;
        b=diTYh4KhtgglZMU3evlbliTr61bEw2VmtBorJ3B8n1smdC9nmzFEJhbWbcNdErPzEn
         0M/lgCC4LMNEBHLh57GTmuFuda/F79WUUcipUE68LwDtsk6QkCt7+XLHDZzV21V9IrA6
         mSnLoUT4zPaYdb3nb9v5uNKy1SeF4nT+37iv16YH1L64m4fb3i+I/xQ0CeJTXV2TnX0G
         U0vr53aix3lympNJ/0PB8l9mJk2Roj2W9SKUfq/XNmoSTLk2vs3Hw3wcq0un7suo1A3c
         p4CLx61B5rbEUkv6syYuaGYRFoY9J0jD7T85jrMuAsrVktPX6mSXpBMgWshFpaNdu19F
         xJJQ==
X-Gm-Message-State: ABy/qLaOyd6ZWz/0TiWD209YAwtB+wC5PYtUvVBdzqTPn7oe646Nz6rv
	7Tv/ztB8WX7x7voaxdqbWgqYKNRxKC064KCuupy3Xw==
X-Google-Smtp-Source: APBJJlGW5iU5E7kFwkawcnW3KsV6FX/Bi3GixO0iq29EivD2i9Lhhws2lqvkuEa3e2NDj26ZpAN1Hw==
X-Received: by 2002:ac2:5f9c:0:b0:4dd:9f86:859d with SMTP id r28-20020ac25f9c000000b004dd9f86859dmr4176907lfe.13.1688745625407;
        Fri, 07 Jul 2023 09:00:25 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e11-20020a05600c108b00b003fba137857esm2829186wmd.14.2023.07.07.09.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 09:00:25 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 07 Jul 2023 18:00:11 +0200
Subject: [PATCH mptcp-next 1/6] mptcp: sockopt: move tcp_inq code to a
 dedicated function
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230707-mptcp-unify-sockopt-issue-353-v1-1-693e15c06646@tessares.net>
References: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
In-Reply-To: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=SeAojrZHb4JIp44g9i/MxXtEYOj9Oyes8H0LveEFbH8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkqDaXidBu86G2caeF3DGj+dnEBA1jB5u2yZQrd
 /3R468H3eGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKg2lwAKCRD2t4JPQmmg
 c9YnEADr3EeMQ/P0O9LFLOR/gPsZfLYOEf+xnVqMdd98PR1vV/4Y8lD2uWanGXBEPzVN/3HeXJ3
 e441x2Hsb5OEyNEi7xBjrvUjPGrQMpe5xe+fFkNdTDUwNyU7br8Nb1NxaWHjc6JbIyf9bzhJPbm
 aD77e8CyTpR8DLG/zigKCTCoZ3iDKJj4hSPrdsVloTd1DgQ4YdbrFXz4sV0fmdQEXidMqJKUfCt
 qA0Y4WsImi2kM1yA3afTXdnfWNyQ4cX60pd3vaXWzZd5UyPkwPs83smRl+AFcr8iUiR+K2qr7XT
 7NUMd7/7wTunZ6yKGWVUHTA81G2BiZzxaUQZKxo+oub5z3C8w6MDszt7LTwz21ehw9ExW+58nPL
 /AIoXwQ2glptPkmDAEFCMjZiFJWr4E5O0Kquj7ZhagMwfFjGh/s25Ye51HbHNvR6Tye/HpGwJHG
 nLgglJwlidAUyOln0M88dAuhzbpNUiTqhqkPpFMxebBq1aEscGsI6/hjwFeQz0/1j1Gf8OtBZTB
 MQFgEOObYoB5E/jrAJiKH0rG9xhmIxtF06Lajf0SnkZL0lrRe7LHcL1Pl2FrUDFmYInYCEfhn4k
 24+N5ITCezlwyBmXFXsQ3/oRpVmOGLWaP8mHaJO4DHow3ZvozFLdQWWs7U99pKjf2kOX76JFrtF
 vAxj8p52BFoKoXQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Similar to what we have with the other TCP socket options where each of
them are in a dedicated function.

It is clearer like that.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/sockopt.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 63f7a09335c5..a46a00bf0f08 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -577,6 +577,25 @@ static bool mptcp_supported_sockopt(int level, int optname)
 	return false;
 }
 
+static int mptcp_setsockopt_sol_tcp_inq(struct mptcp_sock *msk, sockptr_t optval,
+					unsigned int optlen)
+{
+	struct sock *sk = (struct sock *)msk;
+	int ret, val;
+
+	ret = mptcp_get_int_option(msk, optval, optlen, &val);
+	if (ret)
+		return ret;
+	if (val < 0 || val > 1)
+		return -EINVAL;
+
+	lock_sock(sk);
+	msk->recvmsg_inq = !!val;
+	release_sock(sk);
+
+	return 0;
+}
+
 static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t optval,
 					       unsigned int optlen)
 {
@@ -784,21 +803,9 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
-	struct sock *sk = (void *)msk;
-	int ret, val;
-
 	switch (optname) {
 	case TCP_INQ:
-		ret = mptcp_get_int_option(msk, optval, optlen, &val);
-		if (ret)
-			return ret;
-		if (val < 0 || val > 1)
-			return -EINVAL;
-
-		lock_sock(sk);
-		msk->recvmsg_inq = !!val;
-		release_sock(sk);
-		return 0;
+		return mptcp_setsockopt_sol_tcp_inq(msk, optval, optlen);
 	case TCP_ULP:
 		return -EOPNOTSUPP;
 	case TCP_CONGESTION:

-- 
2.40.1

