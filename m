Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FEF28643A
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810829; cv=none; b=Vefx6D0pSPXz/cbsyG1j4iiSrhg/7Te0LnIhrn11OXKM37Miipzy3cmhOv0zZyRdWDXpPWEKw1uu1yZR0hY2TxLN6sgtP86rsSbFx4TNhwakxVey8Zi8G2Bw286bWbxmHJ2RlkyH3q3BPHya7PDaRPfK/F1whucT1dAtk5AgWWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810829; c=relaxed/simple;
	bh=QcNVzrHJDmzDhVBtHzMTu8HUGMD/QTYlMSpRK5EIoOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUNzAF6GCYQj02qwrcPJfZVavoDi172mnRhyrt8OEXZoAbiQYSzXNtuiYH8OaBbvvFhcfhFB37E3ynvIguTFgPGlHet84W5lnFVSSo+uqI9B/8bJUAGBNUGaUEnIlF3rMxTG/0VEwcdBJpkBwsLGUORLJbRfT4VXLd62eQgKo40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPQEnwSZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPQEnwSZ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so33604675e9.3
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 15:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776810826; x=1777415626; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=cPQEnwSZhFlB9JpsNHgf1uzLVuHKCpLgDMH28QKmZVxZjs+fOOq1qzx14E8hPzRZx3
         FpjJmcF1s1MwMlC2kv+kscawijffRX5JnetNVvRaxgtNj29nEmfuAN7dvuRoNtRTfPPo
         AgieZETg6F8i4sU57n7DDyFoSVRcRCxu2ryeUeY6uHK7JdQSMSkX+7CtGEaZMnqEU6UT
         6uPPWzaKcH5zg3W+iksHKjHa24gqlSrp1cL/ia9/xJ3/05V4YoU338Q9EiEGfoxr16PX
         OD2/FiOYe+PJceVQUzGeH+KMm+1p+QLnztVJvIPPArnUlaee7+WJpolwG86E4ZQVp9/X
         Kefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810826; x=1777415626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=MFlCGAOPZoE4Y3npz/cvnCTICnIO2JoZljkSuqqV0i4PAO3YVPTeH+2IZrC8TIKUCD
         pgWJAKhiPPa1YstK7ufku8SpwHRtoq99ZBLU1sn0DC02O422+15i7+EOcejsJSphRz/X
         F2AGO11PmJnqOwLwNBJqxolwJw+OLx8mVABHjnHj5h8bonhXY/AIMoxg135m1K38VjBv
         6sVPOjTp0v4wGhcS9ROFkWdq0jqnWD5LOyhZaCk9C2EzY8B+/8OUollBjd7A8PTqGdGW
         vo/ez51KD/xN0gC9nWqeA2KOqQEhh20r1N4ppYQtrgs2wvRIA3ozwZWJFaVOmtMN3Q+2
         w+JQ==
X-Gm-Message-State: AOJu0Yz2nIKF8B158b704lfNjWCAUPRD/wifZROX7d2PalpzzG4iLXr3
	8/0pdln4UWYUagFBXilnaWABR+ELbojOdvmKILZ39FcZ51hwOls/vP78CH2hVsGB
X-Gm-Gg: AeBDiesYlC1u6sXL+mKRzbO+0FvLPRx/qObnBWyg/fdC842dc4Dy8tZqOu0CHBJHtzW
	g4/Z+sjNVnU+JFdYjeDbFj3yBt92n9+vqqY8XMCRgNCzyJkAQLGdqpvEi8nfYos31CLuSZN5lmR
	JJf9tr/SeImeOBsuzPYwR9iuvnjmDpI9XpaaIoEAHKiakWPbibzhiPt4CBuVklAfERFqA/xc5+d
	d9cZzOsXrE9p/bUBsWei88RyTB7oLrbvXjsF6XH49FKtqZ9zMMXSv65BXz1cVqEaIMzwBCsAW4A
	h73gPVAiyNCTV3mCAKn89sWk4Fhzl6xlOlStPLD3VISqQUcN2XOPBJO2E8abOv0R5dN46D/9Bzx
	1OA6UJa3VLHT0ki8nX4VmxFaidxqm8x+2gX5aA59VoWlhr14P/m2yHiQd3F+iWwr7lEOnsfSpiB
	wvO+p8020km6w7TMT8peFM7a7rOy8w2TBi2GyOho1N0gmpAsHNCt+LkCqWaJ0ZStiuHTkhyrTg1
	UV0m/ADLnwDc2iM1TrV6g==
X-Received: by 2002:a05:600c:42cc:b0:488:ffb1:494c with SMTP id 5b1f17b1804b1-488ffb14a0cmr134853055e9.12.1776810825879;
        Tue, 21 Apr 2026 15:33:45 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c01cfsm413350505e9.10.2026.04.21.15.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:33:45 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v3 3/3] selftests: mptcp: cover IP_RECVERR sockopt propagation
Date: Tue, 21 Apr 2026 23:33:38 +0100
Message-ID: <20260421223338.52743-4-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421223338.52743-1-devnexen@gmail.com>
References: <20260421223338.52743-1-devnexen@gmail.com>
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

