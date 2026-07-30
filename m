Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9873BD64D
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395576; cv=none; b=bnXgxY8kqOK367LPSpgkMgfPltdXY6kMCTsk8RuVWWdtfjFxb2IeR8J8DZgiqkKugR5mqRxe5l05Q4RmXe5oYgoxU/3fg1QXCQhMBJIwJfXOg0/x0QkvxWpjeugQS7zL5dgz5QN4L9w7uGhqNeYhy8Nc25bF4Qp++vFnZU+//YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395576; c=relaxed/simple;
	bh=Vdq51RVUF1oQq0L2xdAL1r37YbnTayVtpjjYKl9BPPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSzeCd2+wzi4Q0GS0PblU2yflfib0uWdZL7gmCR1I1MMl4vXFtrTZ/w0Us1ZLx7g4/xc4V5ibI19MazEO1Cd97aD//j7oG8m99FMpidmienTsepSFG6ue+m4MPY+aZZHKtnGvILgvEXqI0AvQcTc7+i4huX6PDhYJP6EX+Wt51c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flQ/x1FV; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flQ/x1FV"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47df43bfb07so671715f8f.1
        for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 00:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785395569; x=1786000369; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=riAP+ewYVwhw0rJlj7JyI87rScGwTcKhqzJ8HeBg2uw=;
        b=flQ/x1FVOaqsr//fCAwFPpXc3xZFDqjxUVKILDsM/Poi44unaH3cDM0YoIUYQhLytf
         d9R+vLy5CfJqGchZhDciIjhN4F/WCOTMMCLJEzEv52TEhD4JANxq1VDFF51ccw4OLBeZ
         OgqMvst4LgfMmHh1NNDf6n2MAp4v03WhDXrWXaKU/u/9HQB/ZmK1EVG2ryyoz1xzB5Vk
         EsDo1T/FlbD9fFKUtKuiZAVgUL2sLaIy+jX9WXTDkEeJIQF2E6h+QxK9JWZSKbYIDl9/
         vepM9rkgyDWU+fDGO6yS3mDs+iuE8hgiVQ1EGjnXT/ODnIz8W7/IsI3cYtR460fvfdm+
         LjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785395569; x=1786000369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=riAP+ewYVwhw0rJlj7JyI87rScGwTcKhqzJ8HeBg2uw=;
        b=NzMtktZkGwktz8MSX3SnHe1uFMKMzDvwdOPu941rsdGKmaS0aEkragzTeDeRU74jhS
         DPf5cLojR2FopRtH6iZcpiDcaMIE/OWhSApNqFYEnSzaU7qIGmbkrwz+bDpzUeXwR85L
         6Oc54R+fqVopDJpstoxQ3EUNeudMafkVufoSSBek9KW9JpUEA5M33WdhBpv7rul8xJKp
         uIkFBpgOW+VwP5EnyzSHVUX7E7VjS67IS1u9DbASp8A61uOk0sJJ/HiALhI52Lw9m52f
         B2UgUX2/GFRPBACBfympIRfmNRrf/yvEwZUUenfYkS2x0AyNibAZNzfwHWSgI2aqrHl8
         FzFQ==
X-Gm-Message-State: AOJu0YzVQ/yusz3SAVGuS+Q/FIqTFPeKHejpUpqnmgvPwHebw9Q+czEF
	gLHOITILrIBnM13D8IL6HZkXGAB6E4jzgWnzmVcTP3lk0OzmSz/47aCGVjshDQ==
X-Gm-Gg: AR+sD12SKsFw7NafGO2S9JjIIzkQ1oqnVBa3XYN79Xd+LuxRg1mFfXqNa9UYLICrkh2
	BbauJ7QOrrhHj0DPOjz9uiTNhK2JtbPcA0O9idA7vhcg+i5y2QFALrElE8sahwZnDjH2FTFYGAo
	/uRp72WTXoJrIjhGLCNMmgOwoWEi78vC+4XdEAK5C2QyI/avxSz/Fv6SNEUSdQ/PRJSk8YoM0De
	VTTPqZJignJJAW2UlBaZNy7zuI12he/oilqHfnr8gyQTM15dDdUCUGV+X/yP/mW9kbq2F0Ew+J1
	r6q/G2qxNsisNbwlrk1MpTcwYHIXC3dSy/ORv4l3HDAUt3/ELtf3HdK0CXeWCfMFQqoQ3r9ge4J
	n6SA2PtipDtRaoby1+GHIwAFxPy99m38t269eU6xJFlD/3KQGbacFbiW4987v99Jxb+QxCp+wR5
	n5df96ugtc40UAfMLI5M0fiz7NaZ54C9wGPwhJ90jSKzOMAV2cbLN8lN33YgVWbEP/92bvbjlcL
	bOqkpsTXd9RNfj9Bv6gk/Szz8AhDU/G5039hSxvxN+svZRw
X-Received: by 2002:a5d:588a:0:b0:478:77c1:787c with SMTP id ffacd0b85a97d-47fc8212e7dmr1780819f8f.56.1785395569297;
        Thu, 30 Jul 2026 00:12:49 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88d6e5bsm3821717f8f.3.2026.07.30.00.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:12:48 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v12 2/4] mptcp: sockopt: factor inet_flags propagation into a mask
Date: Thu, 30 Jul 2026 08:12:42 +0100
Message-ID: <20260730071244.69473-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730071244.69473-1-devnexen@gmail.com>
References: <20260730071244.69473-1-devnexen@gmail.com>
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

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/sockopt.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index fcf6feb2a9eb..2ba56832587e 100644
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
@@ -1550,8 +1554,11 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 {
 	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
+	unsigned long mask = MPTCP_INET_FLAGS_MASK;
 	struct sock *sk = (struct sock *)msk;
+	unsigned long src;
 	bool keep_open;
+	int b;
 
 	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
 	if (ssk->sk_prot->keepalive)
@@ -1597,9 +1604,11 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
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

