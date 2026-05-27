Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EF232143D
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890851; cv=none; b=j7LZbyl9OZN9ts6iK4uhwk9dqw2hvooEz2m+UPz2SWgUc49XqUN1l0qvvy1ZBqNLawfgkjMB3dtkK3b8rhE4K/eaZ+6NgjlyvHiFyItx9WzC2Yp48W8xutrov7j9dzyQ+tSv4tjE8qCGEiG1EK2banQ/SDelDxTWXtH97WlKWdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890851; c=relaxed/simple;
	bh=PJ89tchvDdk572/bznw24XqiiC6pPJVpO6DU6QBUReg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8i+4vJcP1JeSfY196ZEXzQ+UzbHTDpjjnALjl0QeVMKQcLmu7g7HDzk5fsoMEFhE6jZxeej8iV8WZGiVA0C5NyUwertD74dp8dQDH5Bu9Fh9/bF1jGe9tbXtEeY4fO05TKJlqiYEB/qvYGqBtky6V0uAJAbSmirhXF4hvaCIO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvFN4bgW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvFN4bgW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso61014615e9.0
        for <mptcp@lists.linux.dev>; Wed, 27 May 2026 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779890848; x=1780495648; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tEwFdlK27fIl0TDlXr3cd18aseo5fOVuIOlraFSGQU=;
        b=lvFN4bgWEof0sncZ457xUdFm68WuqA05GRQeVf6em5hz8Mg3Bc14in4PM+mu8Ne9dy
         9yX3Bi7AjqdSuax7esViWjuxwdPfcsH2fwYe6JoD+ByyrdR3BByJYTACEIra6OOSYGv5
         /Dikw3ef0rjWJP0exMBfjVOEbAW0ZlCA/zrmTQLtK1qh4TXRUNzFG1JmdgACndy44qjw
         bIhnhBZOqCvyZMbr7MpNWuJ1Sy6jhdzYhwd3I8TM3IssE2NxjwozTcfK0hAFN0hbGTDl
         QStNkHlsSmFK/Ues14Z6F23kY4TPSYdC7kXSWEYDwx4AvoBan/ozvMaqFdici0oqcH4V
         X9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779890848; x=1780495648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2tEwFdlK27fIl0TDlXr3cd18aseo5fOVuIOlraFSGQU=;
        b=fkJ5Urjqr3/z+6WtZkZZZb5Ng26pVAFJe5cGE0Utc1ylAvMjRRazvHyk924WG+xFFe
         coaY9bvtEOgNKtnAuZIpE6z4zrYugsLkSWOn74tcM4k6+JW/+qcGQ+dVRMiCwtd/9MxS
         rFmau0jvigHFfiUJWg3d7GaSF8SZ2vPWVynbD8YHLJK+GhZDIeCTua5yK6dgPJCDTjp4
         rNYplUiSElz4FYB4NvTE9S7a3TbKvPBRfeY9Fn83azrsIRHZpZ4TkJIFJIanHlBGJead
         IG05RJHnVk5FyL83YmP2vBnKq7Px1A+PFaQSy0f+innJYSnw3ID805fyzXCX/P2DoSDB
         0CTA==
X-Gm-Message-State: AOJu0YxDnhTvMhA0v8tdEVoAO8mCUIAcyp/PLQNDvRDNVjdg1TkBs91/
	2ut8W1GzjVcAAFUnVozPLVpyr1Zm0NcEIpH57euvR1kPuS4hSOE516f6dBdkl0L/
X-Gm-Gg: Acq92OFwa5/ejOk2gQDrU/Ev96/j89hfpCfRlv0rquIDAWok7UHvREU5YWFhy+6h03F
	ZCmTdiQytHnxV8/VPt70iR3MAVFdpQEyShP2fFpN6hMk8scgr1XKokYJ5S6ZhZoD20aVhXKzCsb
	8Jq9zSmaH+SfOWML+MH+8exGZzlIm0+oWm3FUk+6z2d/qV0kJs6P7otPexQCTNNZz/7Qpx3rTd5
	0GGt5Ec1g64GTDYWlNAXEEFOjL+8YdSzqfb4n6rmL6dlDL5Hz4HHxXdJxI+kKRCsDAhlaPCgLBq
	KU3iaqYNpjckUuwcIIvl5RP3HW+W16doOoDc1YumyPSsdO0G/IJ0ztuF4MaRPTr4VNCwYNwk9Uq
	aq4nKu8vWKSLiQgxGZcB0LpfK7IPuKiPiFxePblxtalWWRahNgCb17JQ666EN1nNyg1xJc8qSMU
	N7HyQx+rHZcF8wQIxdHBDt8gfTTCvC6iFyNHmkAP8DDrydX83L25UXQx6qvbszSg1C1Y5fJkqCV
	1eBA+JzQpA=
X-Received: by 2002:a05:600c:8484:b0:490:3b87:be0e with SMTP id 5b1f17b1804b1-490428e3362mr398352325e9.29.1779890848423;
        Wed, 27 May 2026 07:07:28 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4907e6c7433sm19579085e9.8.2026.05.27.07.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:07:28 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v8 1/4] mptcp: sockopt: factor inet_flags propagation into a mask
Date: Wed, 27 May 2026 15:07:15 +0100
Message-ID: <711f55e31538b177ba58d7a1e29b47bcb2dd7c24.1779890764.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779890764.git.devnexen@gmail.com>
References: <cover.1779890764.git.devnexen@gmail.com>
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

