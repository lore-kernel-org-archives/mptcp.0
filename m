Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741C94A1391
	for <mptcp@lists.linux.dev>; Wed,  6 May 2026 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086572; cv=none; b=cubZOW48PlZ9oG6i+WW6MBOkUtuPPscHe1Slxxg7PDUd4TYqu++1aVxCmFXxpvWwUMdPbuKc+dChJoEwyjggxE3C7txyxpZH4eoX8EpXFd02kw/EFrHN4Cm7MY0U7AGBq4jqZTbTyaqf+GpdeYwclZu4qLCgZAed+JDAQp2tuTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086572; c=relaxed/simple;
	bh=QcNVzrHJDmzDhVBtHzMTu8HUGMD/QTYlMSpRK5EIoOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgvKlTrSh3y/aGPAo34hgb/oN8aQmoYZkqMJ1p3s+dDpDSr620uIB4DH2nrIcNJ5phb9MeWze56CEp2ZDj8XsuFHzZOe8F47nPsQUYTG0zts8YWbxcCDKFJHEUN8jb91kAl6AVSYVUloW1zLcX7LQ2agcnSsse9ZZJ0G4DQWhrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ju5G1RRD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ju5G1RRD"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so65990255e9.2
        for <mptcp@lists.linux.dev>; Wed, 06 May 2026 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778086570; x=1778691370; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=ju5G1RRDJGOY9B8ABU4/MN/bYeEeb0NSL0iKATjIm53FKzkvpvUfuTlTWWN0VGsALa
         FJXEP/dqCeFfc8NQYHHqwbnT2cp2bOT31gKsQKobHH449n3iIfb+Z+H5y1CVD0THEvkq
         WlGyjdp22PgX+V7cQUIy8WKA2rJRSvhq+ZeZvNvIu4XX4tms2f3f9EjPID/Iv2InRBMd
         eiNCXnJ2OscgbXCyrQ3V6d/MxZTKJ0Qh+ykNC4umXq49mm5F9t0qcSzhWZm9CsPXBz0N
         Wmnz1DPnaGaaAO0huwrS+/jcgG68bfSlGT9mqlHNVCOttFOFGHvFIC3Qr5RhA0zu+i9u
         5xWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778086570; x=1778691370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=l0Rwm3SD1nT0ynmIBKproqlkEGPsPEvo8HXF0Qvq+KnoIB+jVbVnNIs5BjZIdZhED4
         EASajEAk3qX51Amfzg55CWAOFhAcNOeCBZZBtJqskG7wuhNxROdLWGPXdDa0wu84KId7
         NI8Ox8hL91OXSMjRAiNF0eBpiwUoywFoYmtxOVH2C8QaWfG6dspuzxFFTAEWhgvsh7j1
         fAHv97FuB2ZQXOZ5xWbtByjkGR6bBdhCP7ox/Hj6ZlzsUvqfeRAdjyAhveJkuCj3acF/
         BLHJ1QK4D+lXnfXnhMHOLB9kJ7hPyUiTEer2O58ATiGHE4V8PBQy19ipDcy4Gp8q9n84
         TLAw==
X-Gm-Message-State: AOJu0YwbZhbw5CMX7DaCn88q6jOyx7vkhppDKkRmmAB5x/30d8mEuAIz
	HIjIDALYFjdYnLcwxNV0vku43kxTURsm1z9NeKgfymYrJN86Qu5cs8cdHGV2o5k77gw=
X-Gm-Gg: AeBDieunyJpX+Z+fDCvjCHeLWo2P84P70DrdvptUrohK0uHSgjV5GJmvZr+hAcWmnku
	iUkYUxKX3gRjScJd1QxzNUbC9zXNZenK4YiSoTS+0HDcLZnpW3tu+MguSXn2+H0uxtdQHpYGkNw
	EKZdfKRcHoR6VxawlOpZhjlfJwDkgQ4eN89Pei7H4pDCs9MSONoFbzGcLdX8GIO8zkHcpijU/5U
	bgMCFnTNhMrzxjkcGRESfHzEplScXlVlXx3zmDi3/ptEuJmlulHihWKx/+uBwAd8kLsIDzUF3n+
	0t30IU8gY3y0PntM+LXHn0VRalo5e0F97ubcM75YrjCpzCiV0xdqyULNygxtVpTtxIcIbX3qDnW
	ZosSp1A7iahiXnnni6c4lIb5/pJaJDHPYNgQbw+xKNxv1Wnxczb0dpRWxhyiYx93r5SeQrbxQUb
	MtF/LgTTbF4nZn5qFwzOwdV4nDudrE21F/IP7fyo79qaMVgmXUgIYg3VgupX/YwuAVi8s5teyci
	/VLvETjA6LsNkkImLWH2g==
X-Received: by 2002:a05:600c:1c26:b0:488:9439:880d with SMTP id 5b1f17b1804b1-48e51f5c282mr75087035e9.29.1778086569660;
        Wed, 06 May 2026 09:56:09 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538d2878sm94586715e9.15.2026.05.06.09.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:56:09 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v6 4/4] selftests: mptcp: cover IP_RECVERR sockopt propagation
Date: Wed,  6 May 2026 17:55:56 +0100
Message-ID: <2ca2480bd48417c6074f07728323a63862fa59e0.1778086500.git.devnexen@gmail.com>
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

Exercise setsockopt/getsockopt of IP_RECVERR and IPV6_RECVERR on the
MPTCP parent socket, including the empty-errqueue EAGAIN contract on
MSG_ERRQUEUE|MSG_DONTWAIT.

End-to-end errqueue delivery (ICMP, TX timestamps, zerocopy) depends on
subflow-side producers that are out of scope for this series and will be
covered by follow-up work.

Assisted-by: Codex:gpt-5
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936ebe..95bb2cc8e2ff 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -769,6 +769,60 @@ static void test_ip_tos_sockopt(int fd)
 		xerror("expect socklen_t == -1");
 }
 
+static void test_ip_recverr_sockopt(int fd)
+{
+	struct iovec iov = {
+		.iov_base = &(char){ 0 },
+		.iov_len = 1,
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	int one = 1, zero = 0, val = -1;
+	socklen_t s = sizeof(val);
+	int level, optname, r;
+
+	switch (pf) {
+	case AF_INET:
+		level = SOL_IP;
+		optname = IP_RECVERR;
+		break;
+	case AF_INET6:
+		level = SOL_IPV6;
+		optname = IPV6_RECVERR;
+		break;
+	default:
+		xerror("Unknown pf %d\n", pf);
+	}
+
+	r = setsockopt(fd, level, optname, &one, sizeof(one));
+	if (r)
+		die_perror("setsockopt recverr on");
+
+	r = getsockopt(fd, level, optname, &val, &s);
+	if (r)
+		die_perror("getsockopt recverr on");
+	if (s != sizeof(val) || val != one)
+		xerror("recverr on mismatch val=%d len=%u", val, s);
+
+	r = recvmsg(fd, &msg, MSG_ERRQUEUE | MSG_DONTWAIT);
+	if (r != -1 || errno != EAGAIN)
+		xerror("expected empty errqueue to return EAGAIN, ret=%d errno=%d", r, errno);
+
+	r = setsockopt(fd, level, optname, &zero, sizeof(zero));
+	if (r)
+		die_perror("setsockopt recverr off");
+
+	val = -1;
+	s = sizeof(val);
+	r = getsockopt(fd, level, optname, &val, &s);
+	if (r)
+		die_perror("getsockopt recverr off");
+	if (s != sizeof(val) || val != zero)
+		xerror("recverr off mismatch val=%d len=%u", val, s);
+}
+
 static int client(int pipefd)
 {
 	int fd = -1;
@@ -787,6 +841,7 @@ static int client(int pipefd)
 	}
 
 	test_ip_tos_sockopt(fd);
+	test_ip_recverr_sockopt(fd);
 
 	connect_one_server(fd, pipefd);
 
-- 
2.53.0

