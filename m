Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE7E3BCD1A
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395578; cv=none; b=Do14lNHxH0uOwk1O6isQDlLSvftOee5tHgIgc+WeiEwphN4qStBISnah1PCDtxAAcs9GZ5PnluOTQmxpAx9DwVW6MCBRASkcHtALddiBR0GeRTkhvvcDC0f40pC0jYe9J89KHkLeJvGiR1Z2LvJfxQV77yhvYSEDgWjJKytzefk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395578; c=relaxed/simple;
	bh=QcNVzrHJDmzDhVBtHzMTu8HUGMD/QTYlMSpRK5EIoOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqNQk5LWqY9qEYl7U3K31THoOQ17LFFl8rHnQWkKa1nYMgybHpxqWOgNdeHHrJFPQfVsfmup+L+aDSlRIFEajKQV56N18cDXERN+TECBoyxrhr3t4xNmxEPmsb4MDNLSYN8ekj4XqW7oSvNNvEWNO/rLtJUWmIJnYUGYooHCC9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiv1TQaO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiv1TQaO"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so1486413f8f.1
        for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 00:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785395571; x=1786000371; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=hiv1TQaO2YlSKdjWrLa19Hy0ljJNFCQTVPLxsnc88ofLyYTuXK7eL1FVWio5QDRmQL
         Ft7HW7KDMqIQWkomlpZkVfnaBeX6hr1QqkwrUE/XrTR6hR5Qlpxf8NqWUPiHYe2cliNy
         UGzEP1jWw0+a9rUSViaOVcbnJFPxEEJeFDWllicIUEpen6n1hpLxlmnIfuz+7omKlI7E
         2Oq0ZLeJEtpZEwx4futcACdHVx92U/6iF0VPnnNR4qiREpkT4+kG+Lzdm2qEx+nAsyyZ
         p43ZQOmYEfJLd7bTyI8zNtX8EouZu3gHwI+0JBYKNfsKZQ05Y3TF0vxrDAPu6Ou/hpeX
         Fnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785395571; x=1786000371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=IoA7Lbk0SO++hDqRUwiS1b7qj9g6cG+cMaGge9zdE3IUFMW04qZdCHjai44GOzaomH
         E42ly71NFwrSzqOJuUUnD7kRR0lG+RQpDCp2WFYLGp2CMMAD8YHLg3NgObYXT1LLKGuG
         jGCm6WME2nH+8EKMnIsMSAxLv7Rj+ojbaEJZU3DgtwoFXyqPD/ketuvfFXayQd1pprV1
         Ew3/Mypf2o7tGWN+wm4FcIwCafH4URIphYoaNnlK7mGVV0F4tMoxmXGsDz4GfnXPvLPw
         UrZHnjD1wp0Pj5cE6YB+i6yRtz02ql/nTEB7fLaITpFlOVhKgUysK0U/uV0yUkyvTW4r
         PmiQ==
X-Gm-Message-State: AOJu0Yyb7cO2jEtBt/USY/9OZE22DMjxeVMA5eCAWdGh5ejdocLwqHFf
	UstkR0cqW0l2xXR1NUacwUqVAKq4Z1OlrRmSz0i2Rg0Ixrb5WnpPoumJxmagxw==
X-Gm-Gg: AR+sD11lAzmcYyoPwDuT1lm6R4gyBUUN1ld9bZImw1wG8N7qpSEANGEXrP2WlfyMiKZ
	xwxaNRsrp44H2NfjYV222KP3NItJI+f8/fxvy1wILrTTdtQP2Atdj1d6+o4MDTqCXTevA6V7emv
	q1prUF8J0pQxnDX1Nqp4i4i6y5ld107V31ytE0Uti5H4vDcGapCJrYewSsF16VSjwOC7vsBlrCV
	PsV184WknCmVxHv/5RWbR4XiofojYXXIkTU8s/WX3mRatwS18ybbgXY5nSM4kFsKam1f5U249CR
	0eJogTgBABRbEOqZaL8aGle+E2gTpQItjtM4uFuPxjDNpGILGfsJ9N9gw8tmWBspjN3TRJsF2Ba
	acWzVqcKZ7cyoE/cjekZ3yz0Q56V0kWjICCejokLr/0UURGatPuNq+SmtKgzFYn+8vCjBC1mmBk
	GgfE7heZXKQa8HBK1bbhDvCpoYrLvoGpHwOhknKbM8wLyvylV+rfblKHcpyK4oyAEJv51rpLAh8
	ESDqpeWRdjOrCqnG8IWo5yM3ybw8QSC3Q80MP9QnzrWmG5G
X-Received: by 2002:a05:6000:2910:b0:47e:81aa:3822 with SMTP id ffacd0b85a97d-47fc8200038mr1809200f8f.42.1785395571167;
        Thu, 30 Jul 2026 00:12:51 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88d6e5bsm3821717f8f.3.2026.07.30.00.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:12:50 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v12 4/4] selftests: mptcp: cover IP_RECVERR sockopt propagation
Date: Thu, 30 Jul 2026 08:12:44 +0100
Message-ID: <20260730071244.69473-5-devnexen@gmail.com>
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

