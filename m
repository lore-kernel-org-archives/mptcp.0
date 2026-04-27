Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE973373BE9
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777324217; cv=none; b=CYmLB8XLqt0t7Il46jMez/vFrN17iKkoVwSP2MRi3urohTDHLW7n/k1YACdK7S5IiRt+JZDGQHQutySRxTXKftmi3SHyGTpkP1XUQeJtPXZbXCzzF4WzmDxyHiSaxNCZDpqMRjn3o+ARMv8oEU1ycFNL4mWLCXBWquX5lVJNWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777324217; c=relaxed/simple;
	bh=QcNVzrHJDmzDhVBtHzMTu8HUGMD/QTYlMSpRK5EIoOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Omc7OO966aeQvyZ+puWVk1poii0ffEvL5Jd68G/9sdMKgiARjvvGPv6goF+ZxTtIc5A5i6qb75xL1f+Hbj5Dj7J0K4TCmGwrC3pu22xqX33KeISJr+C9Tlgroya8aUGgH5iqcwFy1yR2B/rSS3qexRYISCFxHhnV2OSRzgzEJG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxFPOlFm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxFPOlFm"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891f625344so96701865e9.0
        for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 14:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777324214; x=1777929014; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=JxFPOlFmkCxjtnpP4zTFFiSsJRHP/gIPBZ5v13pgdLi5XDFxlP5ROLEzQFnzfZV3jM
         H/1m4KaNoqZCP1KHI5Qo5Hw/vSrOEout2rBH9FLMTsvTq2D7SissdMBqyVikMS1txCA8
         04Bz47ViTRJcvO+ycxODczfT8X3uwYkIf6twR6P2TZ2sHVmNCT4LIxmzKH+Yyj7PFveV
         vHtne0arFru9VODe/24Pc5T47bG4OuD2Nw52/kbMfsdIKgUEji6QOd6fF78DzQLkoyof
         5nhlGhzHTsAb0shCM12JZv31dHmzHZk/IzDM5UmCgXtaUwYXBqnHXxNK+RngKH4mdqBX
         2+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777324214; x=1777929014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=Y573+klv6mbCID1dY0DhgF6ktSFOkWpZ2wT3hqOcuy8nptbS/COomL6Out+VMkHA8h
         xwi/4VsHc+bgFEu0kIGN3f3qeNSSzUNFuNNDNRKN+VCN48fbnWrI45+xtNNYaPukpA3T
         woHX2Z6Yj+612k+O2kAyF5Ek9RYBkJKfPEQasx8HezbMaTkW076NUDBQOCm+kG5+sYvk
         tL287WxX8hG0v0Zf9wfq2YZgRu80Vu3AzG7faA+3eMgfSDeDmSRbwardb85apqmZvnz8
         qP94yq5zfyx43Ga/bZuRHPm8xXXm0SnYfDoXFY9KnWZX1D6tr+yDjut/F3Sn58/b03tE
         u8dQ==
X-Gm-Message-State: AOJu0YyJRMKh/50MHE/9YOk0jeawe4S377YQvQaOLBCBV9B4Xf/pQppU
	z6oyZY52qONaKFmDL6wMw+O1idoXNFerUIi+vau0nZ5iktUbjy2ggTbemD8/vP88
X-Gm-Gg: AeBDievOcIB3WepuKNprgi5UChu5FdDGKPJ0w7tCiC4vIvtTOkpXmrX7rijRKXbQ8U3
	c3yNRWso+4WtAKx/JI9jyXAB7TAdNR3qYfX/HMR9qK15/j/ipF8J9e8d8BpnpAjvM0YT9b8dtF0
	1X9pkSHUPDFxYTDXagTBF0itFv/wqPjzYE9i81cH+Y1KO1r4nj9+oNaDNgjFOAWNvIMMiqiTq5N
	SQ9fSu2In55zeSgerwwPGKywPfw+Z0fyTzoeyoUHcPnJJRz6TEVlWIfQFcmF/U5ss7KuCGbvI7Z
	gHrW01RRboXxfFUnBzw18j+iIohBUZFccoU/r/H7LMjOWAuuIBwprLx7GPV5BUPdrpzOGW/cvKs
	nhp7rE7+gDKBKK+7wdSsFlN2hPzUT/zWly0mtn4U77d0CdrMzSPHd6VoUDRdInis1qOBpCIW30U
	Ith6MXd6JzBaeWPhHRNazw221pObOTPHVZN9zEHORwn0qq3IwEevy0Tu9UIpRIA4mb2fsxFnFGA
	f1s34xdju8XK2c0uPvU4w==
X-Received: by 2002:a05:600c:5741:b0:488:8be1:ca3a with SMTP id 5b1f17b1804b1-48a77b05c8emr3733855e9.15.1777324213844;
        Mon, 27 Apr 2026 14:10:13 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d5ee9ecsm1107145f8f.16.2026.04.27.14.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:10:13 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v4 4/4] selftests: mptcp: cover IP_RECVERR sockopt propagation
Date: Mon, 27 Apr 2026 22:10:06 +0100
Message-ID: <dcec46e03fee26c8d31cd6135046cff5576ec048.1777324037.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777324037.git.devnexen@gmail.com>
References: <20260421223338.52743-1-devnexen@gmail.com> <cover.1777324037.git.devnexen@gmail.com>
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

