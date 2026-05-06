Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE423EDAB7
	for <mptcp@lists.linux.dev>; Wed,  6 May 2026 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086880; cv=none; b=Ugy5o/M39cx37Y+rj3Sp/I4lluq7xXQxh3ogz0YldXs5S2QclC2x6pUrmlhOk+dEUuuC7vWVm9sZppii+zVjeAAeSmsco62RLuiDDKCV+if5dcFGlp3kGlRmgDDj8t4aOLHDRIGUhYIm5xcKw+oysEF1pBoc84HCw29kUxPcWsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086880; c=relaxed/simple;
	bh=I8c2mqrn+GbPusWKR9GgjeQNF+Oi6stveIzi8mTd7YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdLy5Ni5+GFgSj3Zmyn8ovmyBt5kpq+k5o94cAs8tGlRaRI7YqHglvYTgnDaQ6ro50FTdlTgVav+XI3MJWzbnkJ1x+fsfGizf9KBUd597rA7iboh5TTzgYuCQ+vQbgQmoqJtpE26Z6uae/z1HWFHYLcqnw3iZaOgtpOTDKQMf9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Saq0GBF7; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Saq0GBF7"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67c566cb519so8177533a12.3
        for <mptcp@lists.linux.dev>; Wed, 06 May 2026 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778086876; x=1778691676; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUpWtIZiW0hfUH+jamgfz3Eo7DhnYhBOXFc7dMF9+2g=;
        b=Saq0GBF7kZARYYKrpPrI2Vaq09tANr4vvLAqbw3id45VhDcoaEO3KCOPfSH9iueEJa
         s2pNnAN4mRqHQl41z+cKVBFoViLiLImSBDw76l4oom2f4xdXwxgDlJptb2OpnnoNuhbR
         CsDXaslCJL3zjhNIV3LfaS3xB7+bc5/Axr2XZEAgvCnxLcNO7nSr2Ln65/1U++1fU1cs
         aFCBlpCI5+lPlsNzMMVvw9AZ5fNHqB1W58LZE+INUnynxeQls/+DHOPohijfEGuHYvNN
         D8vN7SK9lkC6bl6gT6O445g4BsyAyIpRZGdvgTJRSm2Z1hqsNDYX8S3JNYKZ5zX60/iW
         UziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778086876; x=1778691676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lUpWtIZiW0hfUH+jamgfz3Eo7DhnYhBOXFc7dMF9+2g=;
        b=kEIRlM+7ZCuspNDjN0vlYk0d/ZxP/sLVLoEDoWAvs15yHbN+MlIYCBnY6QT9M6qCWU
         ruW5/aIUcYoh2gqSs1+rw7FZyk4TraiSriGJaspdFruDPMovORNDbM1EExzq01xHxWTV
         qma5+OSm06OZs2hTrB9Yfc79xm+x1SQGPoK9tYXDD3LEVL7fjwF7G7D9TD3N5c0/Q3H4
         MDytC460Pjy/xDwInLeUYrLnyj6kgQAHoI4Q2fCy3Uz1295mVacPgoNo57kijjcg2C1K
         PX44nRQ1VRtYOzQ6HosAtjcXZDXMuHFtvXsdE/aLTvO4UoF1CNkEvvaH8YKRtOjHpqMi
         qErg==
X-Gm-Message-State: AOJu0YwMFtjWRXrS+T3nmkvxDjh/+fUtduKW6g21z6ajDX7aYlG19RYt
	cfKeiyLyTl0kfeh5RHGtVpw3cvnVDtfq4pFKrQ51BbNge+eVeGxb4RKiLBMsIjStCl4=
X-Gm-Gg: AeBDievccz8qBlNEbg0y3eIX19LQ8D+pajWK8rcRYumvSwK3yEnaVUPhbY2abgvCigQ
	I5xg8dTg2HH2/+RTZU/ZhD8uKlUFgLpYURDr3rWU36JtkrnnnG+hY9VDKpLt8Zj26u+Ko/6LPEV
	VVSKw4VpO+iDn3MzmOrcYIYIGuYHV/ofoXA85KJsJPaSGHtSf9kdYFKguTYql4vM3aXWehF1+g3
	oEB+6tGxxmd0otBIDcX9gcJlSBC6ZYh/75b6ddioAcqgw+sS3Cj8VGMEvwb1mL4JR+44Nx8Ps8u
	fcXJO9RnwRfNQJpbUtmW3iHtK5ACcxqO4ruFz353w5skWyFAGf3uaKLHla8OBOXKWvs0RhEGWsv
	OmxbZBwdey1N4piFtrD0EdmSPTug/r1jsOP44s/IF2502Bvt1X0EdmT/LX22XzjWI7qnpyhAwZ+
	yFyHOxpgfK4/eF0kQw7OmQit9aFKn2rqFcLoJxsl0myt7hBiCEWogUiiy4wPRvJ9RCF81m5EfNw
	DOy3vQBqsTpHDvIW5f9cg==
X-Received: by 2002:a05:600c:3548:b0:487:1108:48b8 with SMTP id 5b1f17b1804b1-48e51e0a60fmr74441105e9.2.1778086564877;
        Wed, 06 May 2026 09:56:04 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538d2878sm94586715e9.15.2026.05.06.09.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:56:04 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v6 1/4] mptcp: sockopt: factor inet_flags propagation into a mask
Date: Wed,  6 May 2026 17:55:53 +0100
Message-ID: <32ed11e8643124839d86e5dbd9f9429ddbed58a4.1778086500.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778086500.git.devnexen@gmail.com>
References: <cover.1778086500.git.devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce MPTCP_INET_FLAGS_MASK and replace the per-flag
inet_assign_bit() calls in sync_socket_options() with a loop driven
by the mask that calls assign_bit() per set bit, preserving the
per-bit atomicity of the original. Further flags propagated by MPTCP
can be added by extending the mask rather than touching the call
site.

No functional change.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/sockopt.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1cf608e7357b..20c737b2e704 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -16,6 +16,10 @@
 
 #define MIN_INFO_OPTLEN_SIZE		16
 #define MIN_FULL_INFO_OPTLEN_SIZE	40
+#define MPTCP_INET_FLAGS_MASK \
+	(BIT(INET_FLAGS_TRANSPARENT) | \
+	 BIT(INET_FLAGS_FREEBIND) | \
+	 BIT(INET_FLAGS_BIND_ADDRESS_NO_PORT))
 
 static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
@@ -1540,6 +1544,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 {
 	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
 	struct sock *sk = (struct sock *)msk;
+	unsigned long mask = MPTCP_INET_FLAGS_MASK;
+	unsigned long src;
+	int b;
 	bool keep_open;
 
 	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
@@ -1586,9 +1593,11 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
 	tcp_sock_set_maxseg(ssk, msk->maxseg);
 
-	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
-	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
-	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
+	src = READ_ONCE(inet_sk(sk)->inet_flags);
+
+	for_each_set_bit(b, &mask, BITS_PER_LONG)
+		assign_bit(b, &inet_sk(ssk)->inet_flags, src & BIT(b));
+
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
 }
 
-- 
2.53.0

