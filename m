Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20D12F8E87
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 05:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779947706; cv=none; b=CYo3bnTZtgs0vBoU8XM0bzDGWOfhHky09WfB111ODmNJ7BgGyGWVDaOwk7KTMW+ZL3ZjSh1HOC97+SSqubufuJGX5fyFKC1m5WPTCieY8o7nDU+HF4RoCHvLwpY9j0Xd4vVqvCh1K5jW6JiUZ8mux+Rvp16XXIUJvlXp4Rzx8rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779947706; c=relaxed/simple;
	bh=PJ89tchvDdk572/bznw24XqiiC6pPJVpO6DU6QBUReg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=debgb53iFLsMZEeKescKl/iPRsAFuacNLlpDTLdwXMUXGub5g/s9uhJlTehE6oEt0vLafdTqubLTZq9tggVPA5flB/mbY4HUfc/wo0siQ7kuE88SxIi+fs/0vE8W+QAAfRZh8VhB4510pj0g6cIjf8IVNOg2lW1seSFNqJS6Nl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYOGlY8J; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYOGlY8J"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45edc09f51bso887712f8f.0
        for <mptcp@lists.linux.dev>; Wed, 27 May 2026 22:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779947703; x=1780552503; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tEwFdlK27fIl0TDlXr3cd18aseo5fOVuIOlraFSGQU=;
        b=qYOGlY8J7xyU8rpx2C8wG7Z8I4pDcU/9yQ9NcAhx2Ef1JOFChRmHeO0WJKYc9O84ct
         VMGqo2T58RrPL997s35SAi6Dv7zV7z7Ka0CJVVIzJzjyzPzyyBGoUezUe5fIU5GQfbEP
         tLxtTkYM+ZSv84JeSamQTHCTCB7lrO7gaAvz5bweUXyQ+D9P6HMdea/8xBDPslxMCSjI
         URo5YsVEZvq60bhkPovWC5JMq7koQh+ylcJ23fprlzjna3nMsRVmLXPzrvvveeytZKnw
         dQG0+UH2CTuisGiql0WfrnTo9YLczDxTna/Ba7N+1sUJzUva02mi8a4dB4fuWCwSfyOx
         s0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779947703; x=1780552503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2tEwFdlK27fIl0TDlXr3cd18aseo5fOVuIOlraFSGQU=;
        b=szyV0pe+q3GRkwqCZgTKdFKBiGnHW2v4eydSJxJ6+7VLp5S1XG/rBXWY4ZRe4houy2
         jLEnGnxvJg/yYgCUI1Js/IlaVkK2Nq1hUek1ah4iscRusT/toW8qMRrU2FJEFqQVL6ud
         m9MHv+WG3hqBL+EQzBATZkLl8+672mBqhjconPwDseCQquPl+e+5jsPGGJ8vdXa+FETd
         Q9o+vxJ0iZ5sZyL1wkJYtopKdb5De8dIDZatjSOhHWuj4KZ9F2nTWCAXXtinp312+KcN
         B14YJoVBo526q6Ln7MmIxF9MsOrkI6MQeo6nTBiDcVhOH+fMfyHwi1B2oPH/6rdQuxqO
         U7ng==
X-Gm-Message-State: AOJu0YxaEKOYqgIh87EGN/hJoyHeFtKaEmg8ahNDfdKdcKREmy1BsKfc
	DCgcu2Nqg2EmAQf8cEC2/YatSr34qXzN3ueFLwBc0y3Qz64lAWdj7L1vw5j7k0t9
X-Gm-Gg: Acq92OGzJqfw8q5/5RjGyuXIrnLFGkIebnT44RgLgMqIAReYtTgubKWMjLOLSK7UaZf
	sRzaCqW2h4ucee1u2FW+poNSYSrQioV3IiRLxx26GhOHk+EEseAx7dPPfbG6EuKlc29Q3QyOh+z
	tz6eSaNpxNgVzaKgQd5Bq+socaMLR3+BlUcyVviFBKZoZamwRiEsNMzZ024gJ0RNUh2+7uEGckJ
	tZHSeZDrDWzpVH2xVRlOebvD2cdYIAOi2Aipj9JjMY9KOVZH5tXeBO1hCY9StPSoop3DONHRaGH
	v0J7+XEcZrrYxjz2+4qmSLGvauQdL7eoI6ALT4sJTi+1QJg9N6qbG1RgsgZpYIIb4/0FDKUxzmX
	nRgmPJS96pDG7myJAYiLpMaz2rrXEs+0A28vvd8FJIXFzupkg0LC4xnaCVS2/ymT7PKE8pCAN77
	jTDt9vGaegr67QgexOMvxjeEuH2+QxrJT1NBgwIUT6VR0yQDfZXv8X3nL/uEcL0IkSxwxCXBaBG
	8NsnhBK0z4OQ7/uSX1+BQ==
X-Received: by 2002:a05:600c:4583:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-49042252732mr429700545e9.0.1779947703105;
        Wed, 27 May 2026 22:55:03 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a2c87sm11002245f8f.17.2026.05.27.22.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:55:02 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v9 1/4] mptcp: sockopt: factor inet_flags propagation into a mask
Date: Thu, 28 May 2026 06:54:55 +0100
Message-ID: <20260528055459.55133-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528055459.55133-1-devnexen@gmail.com>
References: <20260528055459.55133-1-devnexen@gmail.com>
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
index 87b5796d0135..b9cac04a749a 100644
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
@@ -1546,6 +1550,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 {
 	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
 	struct sock *sk = (struct sock *)msk;
+	unsigned long mask = MPTCP_INET_FLAGS_MASK;
+	unsigned long src;
+	int b;
 	bool keep_open;
 
 	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
@@ -1592,9 +1599,11 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
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

