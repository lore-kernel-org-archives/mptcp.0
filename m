Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B1E1A6825
	for <mptcp@lists.linux.dev>; Sat,  2 May 2026 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777756817; cv=none; b=P3+pVXglygaYvk9AwEhtl8IOpOLoHg8MtOkbFRpR9DrstLPNA7NfLsu9JffVa93v6qXYHcV+WFmy1XL///ZA14e8ZTPMmmZv2EvbRFAO0X9gT9pYq0zq0bBiMy38UPdvCJ05DLtaNvq9NQxAJJ5QaWR5Y43wru83YkHDOl9Sx+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777756817; c=relaxed/simple;
	bh=xEXE2bc5iPaZN+2whmBVNlS14eYoNhOCNrWhZYi5alc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXwNnbxsLqRxvSmP5TMnlvr5XX72h3I24m54orfJ907/NxV9ugtYccGdv6LbSBt0oeizq59JWDYRwSu0SrPRbUtNNhBEAD37yEEjNAhAQT2psJTpHrabPzO4ukf7Xb2ScPmsG25X/6yvaKA7AmX0Q9K4VysmPZ6xKd4IFd0SGzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEQdeAFT; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEQdeAFT"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-445795cf6f1so1708795f8f.1
        for <mptcp@lists.linux.dev>; Sat, 02 May 2026 14:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777756814; x=1778361614; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGCCWJrtrsRJ2Jme2YYckkzIP7ChzSwrrPArTaO+ixA=;
        b=aEQdeAFTeadkq+mytXTWVOZ2L8vjU8mFMnsnBoMkve+d0sxWgGvERciAU3oh5155os
         dwstuFLdZBrQDUKrWzqLe7u0rYKZMhNJaPizufcFwljW2HOg6dbwKpOb8hYWYbC9Lm5D
         mmIgZPID/47GN7l3xKVSwiGsk1ueDojowTAPNimN5Bsb8EofpAojw04BF2OhMje2qf4C
         6ByJPAPLBUXkesPMeC6pHKmxNiQxAGdbNdN262P/UlRtZiCD2vN/f6cjkAXHcoPHIVEr
         s6PoYt2bxIKFshXb/jVeCrUBIwu1lXT+bZDbj9R/P83hYWGikxvqRU13ITEEoFFlQs7d
         j74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777756814; x=1778361614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kGCCWJrtrsRJ2Jme2YYckkzIP7ChzSwrrPArTaO+ixA=;
        b=iUD7qMKTuHFHmqQ/y0butnp3iU/9hhznHJrO9wvAarYnPhNOfSdPNBN2r+E/dCt9Dn
         gdl/xp4T82b8Ru96DFcA5Nn7fI5zSmCqQeZz8vOx9Cz3zX5AOFefk4vj2blRpyB4+7n1
         WMxDU5K2W/33maH3YJsjPbX28U61WdwkpQnO0xUTVD0DFtlPKzFjN4zvCTZS1zCCOD+6
         l81mXnW19zBRNnOEhD4adj3dUQTrOgzdv9yB9G3xUCI1AeoAGm8tilN8QPua6VuxbNWD
         IdYGxv+zZuU0ct64U4649E2lIcMa/z/aEzpkpfHg38sFIGElqHrJIGBF+tTBu8bHREiz
         Cpig==
X-Gm-Message-State: AOJu0Yy7KOQFl5Z0daKQKYZrZYVQKc9ACkVqIbjYLfkPevCuUEgLxPo9
	Nu0BiJcYkK57ihMfL9V5h1So1SkPwkAnWNKJlgwWAogjtTfW70rUSrgnDx1M5D4e
X-Gm-Gg: AeBDievu2flZbrTx5T0yPf1P6JSeYmmCbjHSUAuDw9g/rU4JO0oBuYQmzZHTUX0e75e
	/wKFma7hayuc8/xJN7PgYD1FPS/Ts5L2gveCGfmnMP8PgjLnb2Q8+5SDoVDPAhhOfG9xMigPQ/o
	BNY9mPFihOZm9tkOwrSOfccfgN4RYvZBk7RtSfXqjvCQOUc7XaX94S+CoHl6GA8i2FpkkQ1Q+ZB
	ehU7+QFR/pPkx83+H3sx+JrvtTzAqUpOHGl//uhqEJXECeJ0jhflbMJoqpOyQ0MHjiqtb96eYDS
	ESLsvK8iZ34SfSjomMRUvjLeo27bfcVxRJJ9c09Rmwje2EaSxUoz4+GsuzuZsLrOAHFzcPCplKK
	1gZ++CuqtBqBY3klUZMwqegyTalaYd3qNwsUsRi3SlqvW9pjnPJixZJMFADgbFOKaC137B/CYcR
	EXx6jkXcIWM+nCzbsle4+cZzYyZY/lUMlM/6RYmcK9NNmRgeF6WCxAalYHtPLwY2G+BDfFdnId5
	M7VM5od+hkc2U5fpyEawg==
X-Received: by 2002:a05:6000:2011:b0:43f:dc54:9493 with SMTP id ffacd0b85a97d-44bb5495b60mr5970054f8f.21.1777756814351;
        Sat, 02 May 2026 14:20:14 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a981defb3sm19490140f8f.20.2026.05.02.14.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 14:20:14 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v5 1/4] mptcp: sockopt: factor inet_flags propagation into a mask
Date: Sat,  2 May 2026 22:19:57 +0100
Message-ID: <2d142af0982408ad8c5749dce276503efe2c37c6.1777756707.git.devnexen@gmail.com>
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
index 0efe40be2fde..b828cdd9657c 100644
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
@@ -1536,6 +1540,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 {
 	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
 	struct sock *sk = (struct sock *)msk;
+	unsigned long mask = MPTCP_INET_FLAGS_MASK;
+	unsigned long src;
+	int b;
 	bool keep_open;
 
 	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
@@ -1582,9 +1589,11 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
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

