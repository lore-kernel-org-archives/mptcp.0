Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A445728980F
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776798827; cv=none; b=I/TSj+Cqo8qvnqEQ4usib+V7IGJ/US1hJR9dtBmiCpOV705c5kDc6zlhJdaCmzyKGD9HA7pNeW6kjhA1B+fX5YCWmoIyc8TbPIDARyQFOXPjslPTELMciwVyKC77iOD2e2qA46AlrzVpQuzUhI6bsCjStmNJUxpDGrLT3x6nTnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776798827; c=relaxed/simple;
	bh=H8bkG9DBL9Xfb/wm1zVD5wdpScJ3eI851mJ2Uf1xggk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVcqZ1gRtSOmB7NkcscUkvORxB/SgkqS4sCVLBzLpXJQ5SHbNT4hSnOur6fRpyRMDJPV1UOofvVerGA5Ut7CTNP11B0YY4KguU+zUsOep2lit/gSs54NZpRpT6V9n01ixM8ImQqVmskVyTKLWWpCiWD3YEtyvLStzEk8TUXaSOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rivnj8ws; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rivnj8ws"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43fe62837baso2837657f8f.3
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776798824; x=1777403624; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApK1G5L+Mc6Cb2sCCSVe+Ii36gaQQarOC5kERgb3MHY=;
        b=Rivnj8wsJVEd6ZYnDOCSOhQBG8ugamnYiLNfESTR8OL9cjNkRmFglXhpFK5lww+6sj
         7ZdZpkWCtcJO1dSLwb1Tz0KP9iXuW20DsPF4YvHTLq9gjL27U/Pc8hBbS7tgcOLIfRmc
         iJxbDxwuC9wpDCuPKGl7wCvyxUNCpoGq/i8RqEwzKaLLKf54XGLnhe9mU3RMfUtTIFi8
         NLNFzIIMKaN2hX2EoMZAw7QMUSHIFWoX+wwFVnkOyi7Wt9qmsm0O27rSUOIbFV6Z/svx
         o+gNOy77vXgncf7guW11ukvAP9EJMT+TcuD1akyVZP1xHKlWDGVyJ4+aKBjw/nbbdZUT
         3VpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776798824; x=1777403624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ApK1G5L+Mc6Cb2sCCSVe+Ii36gaQQarOC5kERgb3MHY=;
        b=NSyiOtuGFSrp6Ca109J99J5yMksqRSsjy5QoF9lNMwl99q/SikiJqToyynax5Meuc6
         NfNw40HjfUJH/8aJbJqFXCNQQZnzVNq/mkIkBCNN7n3os1NoehEYHk/iRAXmDBbpAqXw
         fpAOfEfhn4jclXMcgialYWjHS7ohywtn7oOmbeDl711OiFeH/TbmpyLSJviZa+KZPlXT
         5TGPk7zugMACLyPuvRaWp7gnQfrmiw4TrwFlLvD5JDutVx4SgM/YZcOCR+fck6T5f284
         gGlcG50nTWN6QMZa68/0b2HRpo51V5xBpUhjtv/2k281qhIJDGxqNYZGTSaEGfMPbWdL
         NlSA==
X-Gm-Message-State: AOJu0YzEADWLy985zL2fvHOiBZ7WkEeUOmCId06QDabD0VqepOO2VrxR
	S5XNJ9d8XlG4Q4ArNYY5IiMfnI4YR++o6rPVqeL1d3KF7NmG9fKH9256+0s7k/1NLbk=
X-Gm-Gg: AeBDies/f7A27UTSZouep2WVBwvWBxvZhUf9oM0PJHQlDa1fn5yI5rGAvIhzKMK0iAv
	LZ9tm8QBWkW201UKafjnd3ZahSHDFWA2EAqdAd3cUTjPHRuoW37YbkJ2pmfaefzqnZGhF7hzvlu
	sUZ3RglvfTu+yTUixjDqBTS/7iSQnpveAoX2XlGNJ3ZGrd/DQEWm/dG/e1i7CKwHC8frYawUyHX
	/R+JMmcW7FEvY7lrzcvbmsPeD/CNTQsCT0NhVRC+uUZ2dzNRS2FAzMqA4jl4gif+TWEDrMx1E5v
	AtvJ1AWzUGz5DNdOdhXKvV0HTD82A/4xGiuUqDSC3rgXsy/MJA865b4OXuVgJ6uAuFum3ZVA+Si
	huM7Hpgyjh5jh772YDP7AX15qhRG5/hnN4Pv5G+O1ZIKjo+9tst5r/UlFwF6i5lPTrMOu3p0VL1
	9GuU3pD0oV+Zdjx+fmk8duuJDoja7YeDg64Icrix1lgOf5Z8LApW1EjsIHi3mskEYToem8pAhSv
	jsRv1kn4dC6eBb9qOGFhJ1MWKEL40PT
X-Received: by 2002:a05:6000:d81:b0:43f:e413:43ae with SMTP id ffacd0b85a97d-43fe41343cbmr19332130f8f.0.1776798823809;
        Tue, 21 Apr 2026 12:13:43 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d112sm43859447f8f.29.2026.04.21.12.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 12:13:43 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v2 3/3] selftests: mptcp: cover RECVERR and MSG_ERRQUEUE
Date: Tue, 21 Apr 2026 20:13:37 +0100
Message-ID: <20260421191337.58341-4-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421191337.58341-1-devnexen@gmail.com>
References: <20260421191337.58341-1-devnexen@gmail.com>
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

