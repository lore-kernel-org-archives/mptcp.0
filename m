Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A48314B72
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 05:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779947709; cv=none; b=MsXAlYiTKWYpJWFgL5VFo7b/Ucsy6pLWQkZf4vllV76ln78eTIbN5h5xeljUa7Z0u0B0bGg1MFsrIp5dpLRPwIdsznWNvYzG57SqnRZXi7lbCxzuRvMsB0HrCZUKFYoeZz05Nof1+Qj+xZz6pKbmQ68iqEd8APH+4+1P8xMFb60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779947709; c=relaxed/simple;
	bh=QcNVzrHJDmzDhVBtHzMTu8HUGMD/QTYlMSpRK5EIoOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erEiC61C7ZBfL7NUer4supBZ2YF61newT6f86ZWKTeVODkcAwPR0gLCqw3Gx7sFJqDCFBu42UmkiUhPBbusER5xRfllhli/YhI2vXY5/cjgAiXmjruTluUjDMQnj5XqSwwDmE5qkghZxFSqQQNdfTPObDxaa+rqCWpytkqhg5+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2xKHY9h; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2xKHY9h"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso67327965e9.0
        for <mptcp@lists.linux.dev>; Wed, 27 May 2026 22:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779947706; x=1780552506; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=O2xKHY9hgBpVOtLRpLOn4pcfMYRCYsRR4d1OvuGESCzZ/2tz6firUrwO9kBZc1n4CP
         Se5B+sw0iZrZAE1QjedK0b3e7uapBiKUxFw+ONxkFgVkum7dgLhac1/VQsrSZ1j52P16
         oCK5DI8r+YUXcA6akIVidau1e4wfX6Mr+3bk93c9urFuGZ00XIFT31BHDG5flI4tok8y
         kBowPjkXjup33BurV0ygtocbO5eBw1Qv9GmqLlid75d9xarBpJshvXoit1AzyobpMWiP
         jFYUAsBuLcCpCsO8jg5d0s/H7DW9rF2Oc9+saufNqnZvNjBagPdpHYuJzYtP1lYrHgt2
         I46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779947706; x=1780552506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=G1exN2o9PsxnAmGV+bEbUs2JrIaQletxsa46MR/vgteSPYEr9wstuEitzVGcLceSUb
         3Ci3p1TAZwfk81fEx4fvgUQPC9Q6mRhKmBcUCqZ1A1mv8hSahdNyBaPxUvAFR/3Sr6WA
         5/zIeKf3P+b35wVBz64gD0b1SuKrhIcfLaWMT+KNfNb3twz2oAB8Kv094tyfHIYjqJOB
         I6isJIb0B26D7RkEbnaU/ON2E+van+qpcO3EwWq81PdP7Rwf5DMTLissD48vbJxrk4Gm
         mMW2rq2SHSteQe9ELU//e1btCtVvjZlxDqhNLqbTiJ+r5M5kjGDz37e4iOnGH2QvE1zi
         iUzg==
X-Gm-Message-State: AOJu0Yx4zwySjI05LesQmbbUpQuq1gl8/mLzqTgV3fIUIqlyRhbd/axI
	cZuGyWw6dxjbFEx7TA5ycoyBYT1rxcXvMW69mUiKNeAyDBjEiqWDeo1cErleTYOE
X-Gm-Gg: Acq92OEbGnDPeh5pNQpwqxhXWtKg0AVJLYSw06i5RtCoCLey7VQkkkbeJJPNaKz0INJ
	Xd88h5gOpgJ87C5MabEm+d9o8vNBPEKtVFAWbkJW2FBp9Li2WhMV2M93jnChaLkwH09nRKmXdDM
	o4dopbxqSsZrn3miyVxU50BlH0lhJn7mmQx9e5BpczzxK1X0gO4cVBVym6c/rcM32of8+/oKoiO
	+KSWrR3gLAnk/XXTiMio5GceTeO2iP8znuYhM6lWAm9Stq1I0swxiVhEzBdCHu7RwBQZPuphmEP
	Nzvsn4NrHAWeR9ztlogPLy2oyU9GGPNWGiyRDWi/RdiUpSGjT0TNlpK4ZY3gx7+NmqaoCAj41Jc
	eln8Ff6Pfp553xeK2+OLo2iioWlVV20GUa1dNHaMwrGHW+HuodY7ddcl648KEDJpNcGYOnMekyC
	QqWYuFiXjddQ2rAyc22qZIFYbK5XeD5EIh2ijobph6SozzXrb8Pb612bc+LoPlw1zQ29393ldHe
	7+PKymb1Wq3zlF2sFs77w==
X-Received: by 2002:a05:600c:3541:b0:490:6e12:542c with SMTP id 5b1f17b1804b1-4906e125469mr213722635e9.23.1779947705820;
        Wed, 27 May 2026 22:55:05 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a2c87sm11002245f8f.17.2026.05.27.22.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:55:05 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v9 4/4] selftests: mptcp: cover IP_RECVERR sockopt propagation
Date: Thu, 28 May 2026 06:54:58 +0100
Message-ID: <20260528055459.55133-5-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528055459.55133-1-devnexen@gmail.com>
References: <20260528055459.55133-1-devnexen@gmail.com>
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

