Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02140277C88
	for <mptcp@lists.linux.dev>; Sat,  2 May 2026 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777756821; cv=none; b=cX5I+lFAb+AnXn17DCIl1roIt0RueuEFwtf+t6YfrEeckgV1Vg++v1et98StKDZny14Rb1cFmLqxk8XJh2TKs7W69eloUqityx4x/GBmK5CqD5iFUDs5TxYrNmYJj5mfNrn7J83nqZUbYYJqvi2BvIk9H3Tka5hg7vYkDjPhbFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777756821; c=relaxed/simple;
	bh=QcNVzrHJDmzDhVBtHzMTu8HUGMD/QTYlMSpRK5EIoOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfJn8JmnwdpoZrblgQ4vu3CX8X16NMXkrX44Jw76J8M3aKA2XOOw23ELuqXTEWFVC4DSHnXVFA0/vLwl8HlXYKzCc3snEX8no3eIiRVr0Z+JVN+x5l2LH8S/eg4Fgpi+mc0PiR/eynC9imKy24X76S1uomNn57w3lii4825QBtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9y1w7yP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9y1w7yP"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso35651315e9.1
        for <mptcp@lists.linux.dev>; Sat, 02 May 2026 14:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777756818; x=1778361618; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=Z9y1w7yPMCPOzF3kVs4FEQq/J4OGNy/EL5nEuPUAMqQEs7/XUVmsaM9TSg5j0mw7KB
         pd1nJxyrbwbCHwlSxV7tXH8qCbVClg+55ITUyL40OhaOPsGS0vTHXE8a1SiwubCwbpgS
         p24wTNa0qL+lyHBroHtCrQ3GgOxR7/2flH2BiceiqBDRKLnXEMs1DQw+TS05MoBS1RjD
         9Iwtcl8DFHJVrRMvkXQweL2AKpYuc5wuv6AZP3CZI5bP/+gVFBYcrBsiWHch/uyvzLlE
         pOq0WE47h41IECJrqOhuqRAhaPJJm3/hO/gCIvBmACnHXKwza3O+JO+l4slm5or8CBz1
         t/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777756818; x=1778361618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=cECd8hHm0sUBrOB010+K5TrFgcAHnuo5DMXgt3NoWESCbD1Mnyy3HoMBbsN2O8eoyn
         GZ+FoEk5yj7zViPcqIEHgSt+LxRRdgutLncP2rZ0q+A+/mXtEWU2RP/gdfqaEupTyDCY
         2Jk9g0JdEUGPaWzrWa1g6eByEQioG9ZKxAREh/uEoyzDNZIYhIkc+6jXv9atUorGqUv+
         KOYS3Jp6go/ik7l+hT0DQIUnxsB8m9pVrl8t+vWUS6j9UakbQSZuj0rH+Zb9MuyawPtF
         dQaF+yoxw0hzQ3XBzEcQH6+PFeVvRYkaLlVbhrBemEEEEgpqSrvklAIYIpAuzxUr48sb
         oJZg==
X-Gm-Message-State: AOJu0Yw3+IWYwt0kMIdIsKGFYD++yw6SVcWPg5ka3MyzhoZdC50BK5Nk
	IcEuUsDeAKo5dzlMHaS2MEKJEuc4coyN0DNgvSMk2nVcJnM2DNdUdmylmrZyUPvP
X-Gm-Gg: AeBDietQTfnElYfoY2O8wHT63FUvOTdCUmQZs+drlnA+EjrL344HGcL7m+eOlXEmSqL
	3FmO/MT3pNvMpnFRFB2pNl7bighbulUmQkya59gWUgM5p5TOHf66e6UkJp0HEjCVHsTRuAMY8T5
	RxlCg7xbWfVt1X2qerWqQ69u1eLaGCpY3ayWRfPRcNpm4xD5DXSbGmhpVAvRBP3xVRI6021JL9F
	VTotgJjtEDf64y+IQQxVZPcNxxA2eAgZP/kopR1tXDW7Z+sNlxmA/8QVmm6L3l0yhr347qr8L7e
	yqE2bdUZ0rvVb2yPbsTorUfvc7NdHlbsoyopn3JmesIf83gmGuYPjfL7PtZfEdToNrV29UPrqlU
	fZ6LJecQc4omF0iCqAXG9XcNvDaBfvbp1CVyIJXFYTSWPIKsKtu02sOIGWihgwlG4I5te6DFmHc
	9ReBgBOyCjO05JYTCLSC9Q7sjsHdGsPLDL4M5ndIdJfGZZLx8iHyKsSOAaoVwSjwLD3W3t84TQI
	i5gbBJBVOUT3KBwPI+tXg==
X-Received: by 2002:a05:600c:c1d7:10b0:489:1c0d:c9cb with SMTP id 5b1f17b1804b1-48a85e1fa62mr133732595e9.5.1777756818184;
        Sat, 02 May 2026 14:20:18 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a981defb3sm19490140f8f.20.2026.05.02.14.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 14:20:17 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v5 4/4] selftests: mptcp: cover IP_RECVERR sockopt propagation
Date: Sat,  2 May 2026 22:20:00 +0100
Message-ID: <bd780ccbfb92be9023998a850c021b28b03a35fe.1777756707.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777756707.git.devnexen@gmail.com>
References: <cover.1777756707.git.devnexen@gmail.com>
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

