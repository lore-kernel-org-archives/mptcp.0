Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5B3D9020
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784951; cv=none; b=tunY2QfCSIozGzW5WX7yBmkjZG2bRx5k9yCw8pXGTHCYDrSbfDPi6GzvGOjPMy5/nvXJB4IAxFk7a53wfBFsOMzSFVt6iltuvZzXwbEnhphoWe1CyzJFjkgSkgtrL4Gkxwqjm6xAqCMTU0xOxa1o55ZA08CcQxtQiJwcfWXOPuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784951; c=relaxed/simple;
	bh=H8bkG9DBL9Xfb/wm1zVD5wdpScJ3eI851mJ2Uf1xggk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpMTBmFloWG9/DRROZZ5een6HIpBCpb7IxhO+KwTsSpB6yXV9QvHjsmPXCirESvLBNZnJ3marBOj9Y3uWWVyVJ0VkMGMMN9jmJy4otfB5fOOm8UpTphvEoS/Z2e7egRpjH5j46q7CFXBrB8j6SkQgtH9tsd5U1Uh4CH+p8bQxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6steckn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6steckn"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso44869085e9.1
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 08:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776784948; x=1777389748; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApK1G5L+Mc6Cb2sCCSVe+Ii36gaQQarOC5kERgb3MHY=;
        b=U6steckn7VVyHgqb7Ra5i1qWHYtnTGpp2DD+1ZS2nbmsuVFrtsUOrjYjpce53ptl+A
         6tEmlXBneY4gs1EvVorizxQOWBLkSVcrV8RikS1vTSHidAMjWs4oHWod6f8YukbhAHUJ
         +6NaCigna+RCqo2jvS3TA+l3Ey7AjhLz6nkZu8aPMFV8wLJCzCh5YDMMr1VKDGTeOx3l
         xNb8yDDkERmHVMi+/S3eiMWmg2dfOsVwKliNRj5Ep1tRLLnMEZ/U6KWfp6Rc4E0FvGta
         psgT7NUCPZFLPsa5QsP9nh/hmcei28IgUepNeRLF6MUiw6Qd4v5uuxcxF1r8AAAgKEyg
         9nqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776784948; x=1777389748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ApK1G5L+Mc6Cb2sCCSVe+Ii36gaQQarOC5kERgb3MHY=;
        b=RWP3K3X+8M6/xP0nFF5lVqtt5CDo90d+edNuD2oE9+6o36YbdRUsgomXELmWaMSL6e
         QFx8Rr8M6D9Jcr7rTUGAX8xW098uwdkC8P/aP86CoZEV7VUHXbrecLfa/RBg7ukTLtK5
         M+xYvFw+yFwZbkx+OAMsBNlEWo4PxnbG3JsR41HlAQHsZdSqvLQhkBL4SY34JoUKM2zH
         0ZyGVYt1adJbwDgZdteEznpC1ZLWNDBp+1I0VaiGjqyOsYcRZ7zi6G5i8VxMqV8ghAX3
         EPBoxd40bbSCkYAe0+ux+v+5rKYQ8JuxNK1wPfsjjYyiagBSYPmH5TzFKzNxs6CmaIEs
         ntvA==
X-Forwarded-Encrypted: i=1; AFNElJ+s6m8EUrLK3P/mgvpLugQYWG8HCryBF8U/Urx4yrT6SK3buAAvMtF/haTzeTb6Yuzg7st+9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWJbs1jjM9shbY2apJXa/J5p3hwAJ5eo1DCaUdUUfHGCD21/KA
	gP4OQuRl8DYTKiGX0sPatg0HuFa63wvhyzglN8UUsVLPRDK3Rj0JLwpt
X-Gm-Gg: AeBDieu7py5QoCdtk/PHfhcZiGOO81sFNJ6GufVSyTTCnEh4nsq2hFcPnIunkx2wLs4
	YuhTs3D6ccPGWRio6UBWs/ncB1t2idnuaj/j5TL7AbvXpMLWckc+narTWy3fIo4RH8pyt291BPF
	sO4jcmGy+xOOphX75FgXJAACh8+HcxLDiuJkCgqSWRkSv5KCeVvjfPij4aX1mPTpoy8jCGGs2/F
	OVfskg066kyhGtoNrwPlpVvi1O5tDLbWwk3HUwI2lVEAP4Std7IY2Svqld6e9r9hZ21ilyqLsva
	ot4vm7lTmNVdH4T7F1mEczdu0Wn9mTSS0fYDlOrMKZA56RlIn82Zw+vXQ0rFdzdRA019n3fIWGq
	+7sg2Q/0T1Vbz5MXg+7MpKsSfIhYwztHF/G9WRJ9sGB5/xLG1kmpKaTzlkwHYngZSIqrA0LiNfI
	ewqMjCcraqncIfEuWju3D3EHDppBWzSLbJVO9FNpJn0YNXZpQ5Jb9BJsOYhDDJ8M/XeB8ZEWI64
	GBujG6x2aKhXpgvrNIX3RWx1KAzzao1
X-Received: by 2002:a05:600c:6296:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-488fb7923a9mr250841765e9.26.1776784947890;
        Tue, 21 Apr 2026 08:22:27 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4411c9f4f03sm8975225f8f.1.2026.04.21.08.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 08:22:27 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH 3/3] selftests: mptcp: cover RECVERR and MSG_ERRQUEUE
Date: Tue, 21 Apr 2026 16:22:11 +0100
Message-ID: <20260421152216.38127-4-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421152216.38127-1-devnexen@gmail.com>
References: <20260421152216.38127-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MPTCP selftest coverage for RECVERR sockopt round-trips and
parent-socket MSG_ERRQUEUE delivery.

Enable TX software timestamping, send data over an MPTCP socket, wait
for POLLERR, and verify that recvmsg(MSG_ERRQUEUE) returns timestamping
metadata on the MPTCP parent socket.

Signed-off-by: David Carlier <devnexen@gmail.com>
Assisted-by: Codex:gpt-5
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 152 ++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936ebe..b499e7585d38 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -26,9 +26,17 @@
 
 #include <linux/tcp.h>
 #include <linux/compiler.h>
+#include <linux/errqueue.h>
+#include <linux/net_tstamp.h>
+
+#include <poll.h>
 
 static int pf = AF_INET;
 
+#ifndef SCM_TIMESTAMPING
+#define SCM_TIMESTAMPING SO_TIMESTAMPING
+#endif
+
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
 #endif
@@ -128,6 +136,9 @@ struct so_state {
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #endif
 
+static void enable_tx_timestamping(int fd);
+static void test_msg_errqueue_timestamping(int fd);
+
 static void __noreturn die_perror(const char *msg)
 {
 	perror(msg);
@@ -598,6 +609,8 @@ static void connect_one_server(int fd, int pipefd)
 
 	assert(strncmp(buf2, "xmit", 4) == 0);
 
+	enable_tx_timestamping(fd);
+
 	ret = write(fd, buf, len);
 	if (ret < 0)
 		die_perror("write");
@@ -605,6 +618,8 @@ static void connect_one_server(int fd, int pipefd)
 	if (ret != (ssize_t)len)
 		xerror("short write");
 
+	test_msg_errqueue_timestamping(fd);
+
 	total = 0;
 	do {
 		ret = read(fd, buf2 + total, sizeof(buf2) - total);
@@ -769,6 +784,142 @@ static void test_ip_tos_sockopt(int fd)
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
+static void enable_tx_timestamping(int fd)
+{
+	int val = SOF_TIMESTAMPING_SOFTWARE |
+		  SOF_TIMESTAMPING_TX_SOFTWARE |
+		  SOF_TIMESTAMPING_OPT_TSONLY;
+	int ret;
+
+	ret = setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING_OLD,
+			 &val, sizeof(val));
+	if (ret)
+		die_perror("setsockopt SO_TIMESTAMPING");
+}
+
+static void test_msg_errqueue_timestamping(int fd)
+{
+	char ctrl[512] = { 0 };
+	char data[32] = { 0 };
+	struct iovec iov = {
+		.iov_base = data,
+		.iov_len = sizeof(data),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = ctrl,
+		.msg_controllen = sizeof(ctrl),
+	};
+	struct pollfd pfd = {
+		.fd = fd,
+		.events = POLLERR,
+	};
+	struct cmsghdr *cm;
+	struct scm_timestamping *tss = NULL;
+	struct sock_extended_err *serr = NULL;
+	int ret, i;
+
+	for (i = 0; i < 10; i++) {
+		ret = poll(&pfd, 1, 1000);
+		if (ret < 0)
+			die_perror("poll errqueue");
+		if (ret == 0)
+			continue;
+		if (!(pfd.revents & POLLERR))
+			xerror("expected POLLERR, got revents %#x", pfd.revents);
+		break;
+	}
+
+	if (i == 10)
+		xerror("timed out waiting for MSG_ERRQUEUE event");
+
+	ret = recvmsg(fd, &msg, MSG_ERRQUEUE);
+	if (ret < 0)
+		die_perror("recvmsg timestamping errqueue");
+	if (!(msg.msg_flags & MSG_ERRQUEUE))
+		xerror("expected MSG_ERRQUEUE in msg_flags, got %#x",
+		       msg.msg_flags);
+
+	for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
+		if (cm->cmsg_level == SOL_SOCKET &&
+		    cm->cmsg_type == SCM_TIMESTAMPING)
+			tss = (void *)CMSG_DATA(cm);
+		if ((cm->cmsg_level == SOL_IP &&
+		     cm->cmsg_type == IP_RECVERR) ||
+		    (cm->cmsg_level == SOL_IPV6 &&
+		     cm->cmsg_type == IPV6_RECVERR))
+			serr = (void *)CMSG_DATA(cm);
+	}
+
+	if (!tss)
+		xerror("missing SCM_TIMESTAMPING cmsg");
+	if (!serr)
+		xerror("missing sock_extended_err cmsg");
+	if (serr->ee_errno != ENOMSG ||
+	    serr->ee_origin != SO_EE_ORIGIN_TIMESTAMPING)
+		xerror("unexpected timestamping err ee_errno=%u ee_origin=%u",
+		       serr->ee_errno, serr->ee_origin);
+	if (!tss->ts[0].tv_sec && !tss->ts[0].tv_nsec &&
+	    !tss->ts[1].tv_sec && !tss->ts[1].tv_nsec &&
+	    !tss->ts[2].tv_sec && !tss->ts[2].tv_nsec)
+		xerror("all timestamp slots are zero");
+}
+
 static int client(int pipefd)
 {
 	int fd = -1;
@@ -787,6 +938,7 @@ static int client(int pipefd)
 	}
 
 	test_ip_tos_sockopt(fd);
+	test_ip_recverr_sockopt(fd);
 
 	connect_one_server(fd, pipefd);
 
-- 
2.53.0

