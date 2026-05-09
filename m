Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3899332907
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778361423; cv=none; b=TZ3P5zzy4y+nhJi3byvSkjb6bhaXnhU/0f5J/9YvowzgKZPcs0mdZLyckw7tKtCxzA0R2buvY2xtaK0ZCKyo/UNqoMFuKO2cRNytg9e0eAMo+R9Vr+3zAXMdZS0BZ6yTtrHrdy5A7oH/a9MnhIOA8KXZb1U8AcuijT3Onc9TUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778361423; c=relaxed/simple;
	bh=QcNVzrHJDmzDhVBtHzMTu8HUGMD/QTYlMSpRK5EIoOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrAArkM2Bf3cFlYGHsTH5Rc2P2m4FFIL5jNLAWEQTgGL2bzQE+VtDZCnViRCsPAAil2IKGGF8uaLYKPD5NuYHcF1gtHR4jAMIDSJV+fWcW1Frpg8paMD271RcqrmCQpQ8PgNSnRqUfl7cnl4jMXgOkRF6HG+Zhqnw3xK0A5bmQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zb4zUXIF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zb4zUXIF"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso18097215e9.3
        for <mptcp@lists.linux.dev>; Sat, 09 May 2026 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778361420; x=1778966220; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=Zb4zUXIFbG367XrK3T4vS1m5QW/IPgZT072LywgQ1Ps+Mgt1jfg5iT+sk5KQtHE5Bb
         nZOQWNKWrjRxWt7b02TDnR6nI87wNJgP4uadkxPo/NGPfLzUvA4Wmz37di++/bBNU4iR
         zkajg/FrXiaFEBqvfhMa51WGUuXY0m/UYcB4kuMFrbGZxzdsxsfpS9B63QpP3s6eJESA
         g5OlpJeEbQ6xN1805IBFkzGE+7FjHJk+OUHDD0+bYKdVIZxh2QffztPXL2/AWIkXIsCX
         3LVQeK+miUKWSTpDtYkiX0YyMEj4ma5+TZ+lnC92VNEgXMfat/HbW+Ge34UaFAf+fwwO
         YQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778361420; x=1778966220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=BDwfcc45n31ZaEqFO9GartQrlEowG0DKoOv0UcM9KOw0BjDGjgFP2TMFnddBcoHvfm
         G4cVeEQtWa75T2nCm+xYtxMQFDCTeivtTo+8U+Yjs0uOQHWdx+BMdc9K80Wq6iGaVkJE
         +FL9mJmf7etByZaPLU3KhQcNaE0RL+oFvxUau0l+pKK1dv7vzc4xPAI4QEChGvrjTRVz
         K9XZPS86Qxcb6NAh3txr9LDqtP0UWFn/ujEQkaLzuQTcpetJzLSZ0xAGUxmOI53p/lkx
         p3xl27tkwBnSbjNJ8QPxaJcmTVc2ZZX7os2i9Twe+0mzLYCj6ldYQXUNREtTzZzpqMcu
         Fhjg==
X-Gm-Message-State: AOJu0YwdlzMvN5t5XW7QAcjWIFyKsAvTZFgYC4g73YNk6tZfWACaFnEm
	BBbD4ez4m+qz03TLbf3VPYVjL33z7XwM6FI9WXl1Pjk6UF7CzCTd9g4hnVjtqMQIkeQ=
X-Gm-Gg: Acq92OETFZsD8ed3knmUwtRjlZyF6FS0IZ1JD8xXJblB+npFOYIDGukcXx+Dv9fmyL4
	7wUu+6hSwZewLspxxWFgvV51awjfDYXt4KC3gTAw7troyKOvDPU764C1ParvfrP+KhH7wm1TnU1
	8HFwkUgy0nzeF3sNV4nlo7YTWLuyQA1ANTRTJcxHlBGvRyO95psBb05SBUh1pVHrSMcYTo/e3eD
	g5puFiwdJZgJgZuhr9NENZS2m+7FtkolQgcVyf7K84CKbExlNGJmBj3NeHw9/Sr1s7Isj1IfU+K
	0WxJOSyiPJe8JzoTNdiTvG4FIqV1li07nIfGMubs+DOl7Af5xLk8tUW6Gat1z5UUPpTE7iWeWo3
	0fUqM9OBbF3i0ArPWB2u+WlIwepJxgpD9yk8qjmwhYLUCSWBkvJHWvflr30kLecjVRITqILuyOt
	CwQFrUhPKXqnGbCPiEXTvfCN7qxZlBPXjoPZ8f1zsgmNmj/sLPPDFdfr4qBQUbC2txbGSxK9fM7
	hsGctmwdQk=
X-Received: by 2002:a05:600c:c107:b0:48a:52d4:888c with SMTP id 5b1f17b1804b1-48e51e0bb23mr209403535e9.3.1778361420019;
        Sat, 09 May 2026 14:17:00 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d89af2esm30110455e9.0.2026.05.09.14.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 14:16:59 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v7 4/4] selftests: mptcp: cover IP_RECVERR sockopt propagation
Date: Sat,  9 May 2026 22:16:47 +0100
Message-ID: <20260509211651.104934-5-devnexen@gmail.com>
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

