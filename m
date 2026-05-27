Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3984B3264E4
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890854; cv=none; b=Svqd3yBLGVVMl7C+Yy0f6HHxZ8BF1ZB1jwmwu/6ZoTkI1/a6mRwjyCnmMbF6mN+etdR9Ft2r+lcoKYDqC11W7c4ns69pO+AUzn7OLDBPvUlcH3nB5M0tV20b5giTMqNsZXcE4x0lP30zjGIjjrdUSBdEIPORCY46oCq23jdwSbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890854; c=relaxed/simple;
	bh=QcNVzrHJDmzDhVBtHzMTu8HUGMD/QTYlMSpRK5EIoOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUultlXOg+AGajd7NabjhvlYfu2Gqi5kDoFOp/UCE6YGZavVjXgEzbhAqUYhgUWqzyOKb2DFmjdJsfWEP9yWoP9v6hDsq+q3ntfCud2UFuUpkjghGWzqCYrBWNn69zaGbYMQPaxtZ1PTO3tpU68G5XYlLz7FUOyKjR3kG7VLd84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVGhCFVn; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVGhCFVn"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48d146705b4so124828045e9.3
        for <mptcp@lists.linux.dev>; Wed, 27 May 2026 07:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779890852; x=1780495652; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=BVGhCFVnjjHr1MA80DmxUtUBdxngcxhC4tQavCipxE6Kk9feQqtYf7DmOFIJ05jatH
         tr67wi27m838UGzwpqZIIg8xnOCKoKC6/IU2oGY4dT9Y8zrLgjzzwaju98kDLTnFO7Ic
         E/TzhMwCu/UR9fAoDyXrr2DdHMYMEkitzCrSCQHqee091jq4p38euhiXOyYXIqydVt+z
         1cD8kwMIDUpGGdjR70PMKD0rLkebL4ZtuWU+cTg+/g8tIEA4LB8gVibU8hysqjTOinpP
         qFiUMvXdaNRAG5MSOkWjc3mhjLYYWnbxCbFDonNc+FrXIPGysbciew7qoEpgUUI9iC3N
         83bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779890852; x=1780495652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=QJ0gGgN5rn3Jik4J8GPJb4NYGKa1ZmrZGc6zhiz7auW7adNL4A8AGNkx6hgrEWoSjz
         tp4k1bvvsbZGgiaXDHikPJoQfcc5OTxph3dU0XSln4ZAZImvuvrXwqJAEUPXhLgqP7OF
         VW5Dampg4rnEh3vHssPq9lyfQOZ1MwW5HSGyX/UU3BgCRytPJRl4QgGICie6yzI1zPSc
         c8VmDg2fRRJaGyW/SfT4NT9OZg5mcJAN3hrNlxkKgZdI3jfW11Wb64eyiVhdeNDe+cUL
         mfon01XDyEEjRcKGUpcb3V/v6tv6j2GmELy/n3AaPWyDYztqT/5DJeHlSugBj6Qy3N1I
         z+0A==
X-Gm-Message-State: AOJu0YzRZ5gDQaTCutilaV+8fItog7ngxrb7p3pNwn9rDgq8oH86+jxz
	Wo1Phf0GBTIGZC4IF3e2xB8PxrxZBa8xNjNWQDmYmGGPREZbVmfSrcpbmzJm36fi
X-Gm-Gg: Acq92OGsvBWCunRlKA2MgZ1rUnZ9qVqC8Y3atEVzQSNRs0GcntNDBpRyyb23BEGCg16
	3u/cZKF/vuEQ2L/1F30xph9EpodsrNQmJQIhacup/OvhoHfAKpg7wleVoI99UYAg1egZBUnDaH3
	rH4Hm5xm8czxFRJ27C6fpahMWoWzYMiAlhrcbe4wBLb3G1h7hEL32MboHwzJgmUyn/BnyghABLp
	YURJ8mnD/8Y71mYK4Ga8l+n41H32hfjNO568BkG20i3xs6z/ev0B9EOsaIHy9A7ibhQwWVJBcDk
	khJA+qTIgFgFOfhdpi+egUq5bAAONhoOyO8fOcafdZ/E9FyHH/MlK1OUThZ0ctKDo5wcpoUyGxk
	afU47QbYUm37SrdnhNCx5Dov/2dmj49WY356gv31w3plazYBm0YmC11/yWYa6PwMFPFrV1V+wWK
	5cvOOsXje1e0QA6Cin4P9c/zpdZXOaAkYfpmnEshhxJlOH/eZxMLXx0s3lCrpotgyCpSXHYVZS1
	NzhSZTO2sPpMLXKhe7R7Q==
X-Received: by 2002:a05:600c:674a:b0:490:5057:f5f7 with SMTP id 5b1f17b1804b1-49050580a91mr324361225e9.11.1779890851509;
        Wed, 27 May 2026 07:07:31 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4907e6c7433sm19579085e9.8.2026.05.27.07.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:07:31 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v8 4/4] selftests: mptcp: cover IP_RECVERR sockopt propagation
Date: Wed, 27 May 2026 15:07:18 +0100
Message-ID: <61996570b8f75c902c19c94fb0edfe146adb0ae1.1779890764.git.devnexen@gmail.com>
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

