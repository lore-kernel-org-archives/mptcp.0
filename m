Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7BF1E520A
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778361419; cv=none; b=LJrw1kc+rgSwebR+LxbtE7D+ZWLZL9geFGd7SdaSDVqw0gSc5aSzuOu+aVdTBB1rHOyB81Q2vLBQcZhbm52kd/jAPk+sSEw4uG776AwSjAfjfIiO3zij5bdg74c8jLJv2LI6CJ7lUrKcmYbn0RFQp8Wmkup/i5GvaN9wDiP63X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778361419; c=relaxed/simple;
	bh=Sr/T7GvcsHsaQO9riUBQ40Z8DddjgvIxd4KTbNGuNtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+Kb+SoY/siOQ6P+C8UV4WDU3qHzNS0os5E0rGv3Ao7tyH45Tfv0InKjh1aFvUPlYyErqHmecaY05CVH/Mtlrq8Aq4ckJrQ8N7hJZz0WbP1ZHRlKy8xP7BvqxLOJdIpQLPsyD2HsRDa8HZR86BmR6VXed6aRW6jsC72cb+Dq+QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVq4dL4k; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVq4dL4k"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso40023575e9.1
        for <mptcp@lists.linux.dev>; Sat, 09 May 2026 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778361416; x=1778966216; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzPsY7doH4GjtK6Hi7+WAg2sO8REMIej2hWIo24QxhE=;
        b=VVq4dL4kvw+GXNhhXxXwOrvdbX7PaW6AAh0ABTOwBEDuSD648B8M/6oxWy+afxDY6J
         5AKNE7e8hB1hixZY0W7IL0eIMPJMU6WdsqXJ1AOFIBIbGuwO98hW/tJVnav9knTrgIrv
         coJgWtKd/m33RX7iDbk+MIQ2VUwNtk6kk4Ia2q0wmLT0OovMhcf5nd7XXkazTF0h5UUF
         HFk8U6UYIOv4BxtuDjlwTaLA/cMrB+4ERENeIwECzGfFHHl6DlsTyTCxYxaJ7SAqDWjh
         gGevkWlNq1+4kgOgjAVStJyNVDTUDQGO+0jjd2JeI+MgQhQqoKsE9OF6RCDxbho4OBGX
         SfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778361416; x=1778966216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bzPsY7doH4GjtK6Hi7+WAg2sO8REMIej2hWIo24QxhE=;
        b=ikRpyVai8NfqQ037vdZkdUSb5UdsxIaRDeU8hEyHtxOKD+hUxKtezPUtNNFCyhPHom
         6ANSGGGyrGoLgtwpSwjySCgrZHgMjWGQ/9DnOSDvS89yqRRKbmnbUnfFewROeWgxf9OX
         dQALeGI15tUuZXxP7ajfda2Sn1Yuwk1nLBYgWgqNoSI5aLAtBfPdHESkqV4aeWie0NVt
         B4pNPPBDK58aDu8ApsxYdrOP1/j1xdBwEXV1fiGo3fAT4tGX5IOMIq2KNmaVcaDFna4a
         wx9PhS0uwkGLX+3Y7YwgHsQ2pJaYl5rerEMhlUvYd7Ev8OZW5PTajDUERv4z63gMfJAF
         BHmA==
X-Gm-Message-State: AOJu0YxwwMqwGx0HeDsXBlCDbFzXSBBI158rnTYzxch2iKf+QnEwi2ht
	6dF9l1Tas/8KQWlnP/hM+FbIDKRSQRuaWOFueB1fV1xoJr6wem9qqRXe5wKFWV05hR8=
X-Gm-Gg: Acq92OH48lV2U3VO1kUIX8XrNquAqUOtFU2hVaefFHfULG4n5exgK9axDHGZeOkpLJq
	lS0JsnvyzytI1zQq8b6Tl2Z7hjJTFSVXx5BdElz/Q1XRS7thNQvNLrlQBbJE8bW1gObW/bkV69R
	MjFbBtpnHoUA04ShW/yv/RSRgOMYayxONrzZqtFB6n+f+OM3sOj6FZlqEQr7NtW9yvcSMKpozP6
	WCQPs1hqVv3NRdEEQje+ui5y2BBlpMyRE6cE10wmZ66YPcwUlJBQwPVMsImsB0cgIpDnNs1xti2
	xPpemL1wGDlC4x2StP+IqKL5An+EYflA4Rp8Rl+cjJcSVhCTj4N0G81V8lXRUlyaAoTTdQiTmY8
	yEKPq/yZgU696sm9ExtP/fF0/HoFU6Z+tvnTc3fo0HrRaX146/x94SW7JQPCoJpNG0adkG8JvZs
	KkZt0Hs7/ISgvboo/GAnPqbG8hI1ooswIW0VVlJTTeGigtVyMlF3xNu+/6pbgofrDiDER6cG1nk
	x0ffNcXbI4=
X-Received: by 2002:a05:600c:3e10:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48e5e0089e0mr198478485e9.13.1778361415557;
        Sat, 09 May 2026 14:16:55 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d89af2esm30110455e9.0.2026.05.09.14.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 14:16:55 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v7 1/4] mptcp: sockopt: factor inet_flags propagation into a mask
Date: Sat,  9 May 2026 22:16:44 +0100
Message-ID: <20260509211651.104934-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509211651.104934-1-devnexen@gmail.com>
References: <20260509211651.104934-1-devnexen@gmail.com>
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
index 1544e3563852..114436d2e401 100644
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

