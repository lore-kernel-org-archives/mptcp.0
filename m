Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888513921CC
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076732; cv=none; b=bSazXz68K/H2bsr3j7gfuydA/VdlQcL/Yv49U/SISShqEAz1Nt2HBcvjGJKetYTasCCqqY+S39H+kf7hlEx2IkSgOywlvz/joxHcm8Pwn+WxRfpGNkWt2JJ4RBb8nJO2Vyd/d1ONMUcYGAVhvmOMqx7NTfeyLn5/WjGLjcWm2F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076732; c=relaxed/simple;
	bh=PJ89tchvDdk572/bznw24XqiiC6pPJVpO6DU6QBUReg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQV17/GLLpO9oRx3M4mwTXFtF9ocycMbesxOCWJh6gBhrJn8lTZ1ehYhfzXkxVGiDQCgK7YBvSTzuDXooKHttzDaW7vjNn/wzBEV39X9XKmSLnxQvDvcQYFldsnqhLRQe48FWLRYs+4m31uZ8ay6ox8VVTGU33siVMdr5kHUzys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpPylCrb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpPylCrb"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4906238c62eso57540635e9.3
        for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780076730; x=1780681530; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tEwFdlK27fIl0TDlXr3cd18aseo5fOVuIOlraFSGQU=;
        b=jpPylCrb0/zRioKjd4bOFjjXHCMQobXdm0LUXqxYTp9S+7NSf4wuRf/SsiqiLJyzzx
         FigerCLYuavU8x+pcJAIPQPKQP5wY1ierBzBWdggO73MlZ6nsBT1pd0bLD5xvfxKPRGQ
         XIrpe9e0Tsw4LxFH2mAbBM2ZOun2IjDg6eImyeGQxbP9LZdu0kzc2VvqYoA+dqw6Jw9i
         vB/mxkj64ioMEcdJ5yGoacPa4iV0y2BdOpyQ5or3/wTAfK6XnQCMVafE/iH4IDP0bsyB
         0eKwOWlYgkad/uGMZ3/ZYRL4HigghHKQ4fvOPnfw8CqVk0I/ng/xH1enQsmyxSaQf00Y
         9bvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780076730; x=1780681530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2tEwFdlK27fIl0TDlXr3cd18aseo5fOVuIOlraFSGQU=;
        b=XSkHQk+xqrI63FMFDEm6C8IOxVHkBYlW7sW9iVSS1BvjZ0oU8ZQF2Fwe3X3VMAwSeU
         uVx5/tK/kVRDMe7uq7KntIrIkXl+pk52PuJ5mZiUP23sTbBa2P2rFSTq3eAwsuzbl+0X
         ZpbZjuAFQSuSgr9IdXG3qPHZEkcD4z5GDx7NlFjQcik6gJ8s5+X1DpdpP3rQXlCgYlbw
         c4ej9Z672zeAdQaTpJqLELaQWl2k9CNAHVn4lOfj4FL8nckhhFFBYnVu54e4XOLebeQI
         +gIaWrLYzVnUnhOIg/jjgrnaMUr7MCwDKsZrsaBLQ+PEaqSCKrsoZgc+UJT0vBnbxANn
         6WJg==
X-Gm-Message-State: AOJu0YwPyaWJTTQqC5kjSLJV77KwFFL0TwJE9tGCiXp+OdACHApcuAvA
	SEQEEJSSIk7CkE1UnH4bxwLzH0IIOrqMcwOVNdA6mEW20MJze7Ubo0H35YgBjw==
X-Gm-Gg: Acq92OF5aMPkeapzECx1IHUOC894yQZNCQrzs/KHIpMedbgnxLNj2vNupqbV6bY8J03
	l473lIXLlROHQkPSrApvoKKSFhMCiQrgwVTdzjZryPJkih8YuWJG2ze2/821crlZu1pXAvHymNI
	U7L38crKNLYlGKkyeLiPQ8Maxf8ypPD9alwaVIK1TCtTvEEVizN4KJdTNLM90/WaZCvougxBl/r
	bmFyq0RakGDY+WI5MM3AdNS7x+d/PCB9rFMF2nXZFw9IOlsWURgvLpQ5uoJ4MNe9rIFsVh3ZLoy
	ZeOW5x5R8EJUKn+SRxoSlfr2FYKVHG+gI+oFWXXXeEghQ9pXRup4HaLuFRmmv73yB65StKjGZQv
	jDAwV9Z5okuPcbopIgUdXNyBhyOjSX5v8y/DBoB5+BfE6gpt1GALkzHz0jXTzHGEP/6CwjZBKm3
	YTUgxPw7LwdaH9PJM9ceWbkJpN6oeDWVRGSGCAPyu/kEtCbqgXYwrFeEI1nJjQaPLzsfAbEQCj/
	kcEiDWB/jjfA8kpoNaqfw==
X-Received: by 2002:a05:600c:8b2e:b0:490:6237:5213 with SMTP id 5b1f17b1804b1-490a2941a84mr10073385e9.23.1780076729853;
        Fri, 29 May 2026 10:45:29 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c09ab75sm18738075e9.6.2026.05.29.10.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:45:29 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v10 1/4] mptcp: sockopt: factor inet_flags propagation into a mask
Date: Fri, 29 May 2026 18:45:19 +0100
Message-ID: <20260529174524.260199-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529174524.260199-1-devnexen@gmail.com>
References: <20260529174524.260199-1-devnexen@gmail.com>
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

