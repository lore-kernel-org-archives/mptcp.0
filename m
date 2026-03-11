Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC3E3BBA13
	for <mptcp@lists.linux.dev>; Wed, 11 Mar 2026 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215802; cv=none; b=kM56UaajJh9hurgwGIFDmF9BtjVm5TmuBu01d9aaF+ecu2LrwQRXNXlczVd8cvHV6Odz05Oi6JRDeh6ySOZT0ZdLojAkkNLQm7o98fHoT4tuq3ltZnBaNMz56cty9Ba8OdzH6oB4aHNI8QzxelZ2sqFwA1xgalDPWyYGpaqsVNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215802; c=relaxed/simple;
	bh=FWYsgoyKVIUupg0joGsjXBrmnww52mswGSTqsNgSq3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FXMElcB9AP5uGMdiqZnzdRTue5y4zquCA0RdJd7gNpUf1zVJDnFNJo5Lzc/UuvvYmNo4zxSSDrfVdjHIRd5jjRxqmzzE23VJLMUQOjeAPb0duDJXsawosdcOeKYuRjVY/yeSTzRs9pYluBwXc5Cto01n4S2uBn1qGpVR2efse3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXz96PMj; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXz96PMj"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-67934c83063so5252037eaf.0
        for <mptcp@lists.linux.dev>; Wed, 11 Mar 2026 00:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215795; x=1773820595; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWRaO2kk43skP87kgk2P1rc0roOMtr/hXw08wzU1czs=;
        b=QXz96PMjFl4TqonVNHrv66CPLF+/2H2tRZ74aQUmno2xM9TvlGcgMkPotk5/qtzZKk
         1lbVyeGeBwx9hXYDR7Ihog/P3uEHZGlZECTwrlHBawz9QL4OB1BCbAyx6Ix3yrxXdgKv
         WmpxqpwOxsYCSYBFmcthQ1ZZebloRcl//iTSOiRs5qavNHh5uTyFRUYCg9yUn6G44U+v
         yGDsLBY0daBtUytdvZXyAWTzBNsNr8USjvPK1tE+M4oECpMXZGDuEw4UmvR1ld21pCu6
         C5C9+J01W15JXgZVu1YBkDcLC2Sp65rphPHvhbaslc3JGNz1tvVVSMtKSCvzl4wlRbR5
         3djA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215795; x=1773820595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DWRaO2kk43skP87kgk2P1rc0roOMtr/hXw08wzU1czs=;
        b=SO1vVuEkDngYQTkZ0RXrhMzXRjeFbX0CgSvsFDo6Rw1MpD1SEYO/qm9SHInQk/ZgiB
         HD2sSmTUcgFACp1dwndzAFshwN84bFZEqR1Ndf9/JZIJ7+fMUcY9gB8WHiBUOMjs+6Vg
         X99sSL+RPTOlrltKVf5zy+b3BZ9xzMRPAymY/HCkzpDhp7nyRnTtAXHrhc5zKdWJHuRL
         GD6fsh8x5YHCm8zslI58wYbDaDCdNJgNyOWSlpjP9di7bOUCe9QILCAkthHJaCl4w5mC
         ePjn1hV/NdsD39jydPjbLpMeB6D84pH5/DqBlthF/jsmPnSfbLfOV52V4RTOKNPQYk6j
         lryA==
X-Forwarded-Encrypted: i=1; AJvYcCXkHVRewqEVhSIWGbG7jSIjfIJI0ygBHN/IOqPkU7gdsUS/N0tiAAQAUjDTPTm0+/PrCprwUg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyz9VpSFXOS2aO3Tpa8NkAXW787KLC77hIRjpMK5iNCnnWbJ4kE
	gZJtSm5g7i8OKETm5lGeLyjqYk97zJ4W86uFwASOdfzV1oo9w1OXkV3U
X-Gm-Gg: ATEYQzyBGWi7/3F2IEKFiEmyCo7q3u0a0OhOGDG4pnnKxHYViH8QSp3DHzl3PQbyXN1
	AKm/HKN6TaxYrdlYT69kx/Bx7A0LZKvYWMJpHRXK0pQuIHETG/sis0OwRKMy6X9mMYbunCSdPGl
	flEQxcEmMdpnxjnzHrN4Y3MJmYPaljuN5Zxv2i8ELnc4M+AexqVz9XOucXTPBkf/2N3260oZvwJ
	gJMzhESX8LTgJ3ipZyX/dGZ90W3Q1fINOCfp1gAhHojPEAZ3SsCuTXXzFAd9N9Azao0cGBMV5xX
	FurCnpFLPHXgVgygB3FWKOBo9/hsFwBfbToi15FcsVLiDECoLao5no6NNCYMV9xqIUAwqPQW6pj
	JR096iBGI8XQMr5/AO/1cnQ2zRg9BbgSELNZwsximN5D001kplMzW4mV1YDXQktrwNqHG/0oVTS
	b9xgt/x0X7ls/+jWyHooH9RqV7nxJFxRxTmWURTnYR+cMc0iBjwiETwVz5UPCaLR57/Izw7UlSa
	tm6qqMfFVZ1ss4kOcft043slNdduvgVGF8cQWAXiMq0bw5T
X-Received: by 2002:a05:6820:4deb:b0:679:e889:dde1 with SMTP id 006d021491bc7-67bc8877e83mr927920eaf.6.1773215795085;
        Wed, 11 Mar 2026 00:56:35 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm1568938fac.16.2026.03.11.00.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:56:34 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: kuniyu@google.com,
	horms@kernel.org,
	geliang@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	atwellwea@gmail.com
Subject: [PATCH net 4/7] tcp: extend TCP_REPAIR_WINDOW with receive-window scaling snapshot
Date: Wed, 11 Mar 2026 01:55:57 -0600
Message-Id: <20260311075600.948413-5-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311075600.948413-1-atwellwea@gmail.com>
References: <20260311075600.948413-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The paired receive-window state is now part of the live TCP socket
semantics, so repair and restore need a way to preserve it.

Extend TCP_REPAIR_WINDOW with the advertise-time scaling snapshot while
keeping old userspace working. The kernel now accepts exactly the legacy
layout and the extended layout. Legacy restore leaves the snapshot
unknown so the socket falls back safely until a fresh local window
advertisement refreshes the pair, while the extended layout restores the
exact snapshot.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 include/uapi/linux/tcp.h |  1 +
 net/ipv4/tcp.c           | 34 ++++++++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 03772dd4d399..3a799f4c0e1e 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -159,6 +159,7 @@ struct tcp_repair_window {
 
 	__u32	rcv_wnd;
 	__u32	rcv_wup;
+	__u32	rcv_wnd_scaling_ratio; /* 0 means advertise-time basis unknown */
 };
 
 enum {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index cec9ae1bf875..dd2b4fe61bd8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3551,17 +3551,25 @@ static inline bool tcp_can_repair_sock(const struct sock *sk)
 		(sk->sk_state != TCP_LISTEN);
 }
 
+/* Keep accepting the pre-extension TCP_REPAIR_WINDOW layout so legacy
+ * userspace can restore sockets without fabricating a snapshot basis.
+ */
+static inline int tcp_repair_window_legacy_size(void)
+{
+	return offsetof(struct tcp_repair_window, rcv_wnd_scaling_ratio);
+}
+
 static int tcp_repair_set_window(struct tcp_sock *tp, sockptr_t optbuf, int len)
 {
-	struct tcp_repair_window opt;
+	struct tcp_repair_window opt = {};
 
 	if (!tp->repair)
 		return -EPERM;
 
-	if (len != sizeof(opt))
+	if (len != tcp_repair_window_legacy_size() && len != sizeof(opt))
 		return -EINVAL;
 
-	if (copy_from_sockptr(&opt, optbuf, sizeof(opt)))
+	if (copy_from_sockptr(&opt, optbuf, len))
 		return -EFAULT;
 
 	if (opt.max_window < opt.snd_wnd)
@@ -3577,7 +3585,20 @@ static int tcp_repair_set_window(struct tcp_sock *tp, sockptr_t optbuf, int len)
 	tp->snd_wnd	= opt.snd_wnd;
 	tp->max_window	= opt.max_window;
 
-	tp->rcv_wnd	= opt.rcv_wnd;
+	if (len == tcp_repair_window_legacy_size()) {
+		/* Legacy repair UAPI has no advertise-time basis for tp->rcv_wnd.
+		 * Mark the snapshot unknown until a fresh local advertisement
+		 * re-establishes the pair.
+		 */
+		tcp_set_rcv_wnd_unknown(tp, opt.rcv_wnd);
+		tp->rcv_wup	= opt.rcv_wup;
+		return 0;
+	}
+
+	if (opt.rcv_wnd_scaling_ratio > U8_MAX)
+		return -EINVAL;
+
+	tcp_set_rcv_wnd_snapshot(tp, opt.rcv_wnd, opt.rcv_wnd_scaling_ratio);
 	tp->rcv_wup	= opt.rcv_wup;
 
 	return 0;
@@ -4667,12 +4688,12 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_REPAIR_WINDOW: {
-		struct tcp_repair_window opt;
+		struct tcp_repair_window opt = {};
 
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
 
-		if (len != sizeof(opt))
+		if (len != tcp_repair_window_legacy_size() && len != sizeof(opt))
 			return -EINVAL;
 
 		if (!tp->repair)
@@ -4683,6 +4704,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		opt.max_window	= tp->max_window;
 		opt.rcv_wnd	= tp->rcv_wnd;
 		opt.rcv_wup	= tp->rcv_wup;
+		opt.rcv_wnd_scaling_ratio = tp->rcv_wnd_scaling_ratio;
 
 		if (copy_to_sockptr(optval, &opt, len))
 			return -EFAULT;
-- 
2.34.1

