Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D6F51EDF2;
	Fri, 18 Sep 2026 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789756738; cv=none; b=uiTLLm3HOoVcw01MLb0xm38l2ORTchN1j68o/JnYhE4gXkFJKxfPAPuIummFxfPJ8R70geBieB5u6q4k0ggjoxgRHGVS5y6nUl0N25XOjBVRKlqQf+29Xs+E4R23Ue3RIZcwBPorefwaGVC2ycYUTJQre71epTnWZdeYJgC6ayY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789756738; c=relaxed/simple;
	bh=g3to6dCeHn6zMM/3AMYugP+pLtURStDEBkyEbyy+1GY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jRlbR8iV3BUAB0hixukm14heNTrJQuXXsqEfX8oBGo8n/VF7bRhih6OJkn67T4NxLTkyhsGUuXvgwkvFp2bXXfdragK6uI1dLhAb4xlOtVhnwTapEDk59SNFVLaSwEc2USScDjewByEwVEIt+GjNRAHC0KGZsXWvajWC7HCdMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4c3uU5/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4c3uU5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC1B1F0089B;
	Fri, 18 Sep 2026 18:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789756728;
	bh=ab97ABeWx519BjZUlq/57k57+C5FyDQmJadIWx10vY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=O4c3uU5/gLdDxORBoMVwmzOYdl3Ugn7dGHPDY/a9mQ8UpbhgAf21TgHGCIa2s4XKB
	 nbwmNAXweQGTT4iWEucVptmgsb4ykWhQpC5r6nn9ZV4ETmYfc40RDciizxq1w9AxlL
	 H4/QaG9AGtIdL2xqc2Ie9XnJlucpdNi15t+RZY3O4MRpvhjOHq0PO27N/4ioCQNBYS
	 nNJB1nBIU8mUIg85BVk1ZqVBGYJ7D7d/Uc6uATTpZ2W29O/3HnM9ICUanH+HnzNBkQ
	 jVnPHbE4r+M2YcidPtTQuiae+l0VyjdwH7NurYC7YpWom9rXAzYG23oj4y/h0tnIVf
	 INLpOu5/rg4Sg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 18 Sep 2026 20:38:28 +0200
Subject: [PATCH net-next 4/4] selftests: mptcp: cover IP_RECVERR sockopt
 propagation
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-net-next-mptcp-msg_errqueue-v1-4-dd77e1738248@kernel.org>
References: <20260918-net-next-mptcp-msg_errqueue-v1-0-dd77e1738248@kernel.org>
In-Reply-To: <20260918-net-next-mptcp-msg_errqueue-v1-0-dd77e1738248@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 David Carlier <devnexen@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3312; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=UW1zAcPF+yaxAXuK61+P5ERyAUnUn0OOq8Dg98C2P+w=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWtmrHmnk/dFK7+PJ7+86D7DtqfacKPQlrZJ0bMP/qJ
 HEv9TT1jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInYtDMy/Pxj2rbN00/1inBz
 tlA7+1xB/uacCas6Fh7bsve1eNTVH4wMJwuiJk6SE1/dxfarT1u9Z3uPddnK3yFiLIcF1QSyQ55
 zAQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: David Carlier <devnexen@gmail.com>

Exercise setsockopt/getsockopt of IP_RECVERR and IPV6_RECVERR on the
MPTCP parent socket, including the empty-errqueue EAGAIN contract on
MSG_ERRQUEUE|MSG_DONTWAIT.

End-to-end errqueue delivery (ICMP, TX timestamps, zerocopy) depends on
subflow-side producers that are out of scope for this series and will be
covered by follow-up work.

Assisted-by: Codex:gpt-5
Signed-off-by: David Carlier <devnexen@gmail.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 70 +++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936ebe..d68515b7903b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -183,6 +183,13 @@ static void xgetaddrinfo(const char *node, const char *service,
 	}
 }
 
+static bool expect_all_features(void)
+{
+	char *env = getenv("SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES");
+
+	return env && strcmp(env, "1") == 0;
+}
+
 static int sock_listen_mptcp(const char * const listenaddr,
 			     const char * const port)
 {
@@ -769,6 +776,68 @@ static void test_ip_tos_sockopt(int fd)
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
+	if (r) {
+		/* For older kernels not supporting IP(V6)_RECVERR yet */
+		if (errno == EOPNOTSUPP && !expect_all_features()) {
+			fprintf(stderr, "IP(V6)_RECVERR not supported, SKIP\n");
+			return;
+		}
+
+		die_perror("setsockopt IP(V6)_RECVERR on");
+	}
+
+	r = getsockopt(fd, level, optname, &val, &s);
+	if (r)
+		die_perror("getsockopt IP(V6)_RECVERR on");
+	if (s != sizeof(val) || val != one)
+		xerror("IP(V6)_RECVERR on mismatch val=%d len=%u", val, s);
+
+	r = recvmsg(fd, &msg, MSG_ERRQUEUE | MSG_DONTWAIT);
+	if (r != -1 || errno != EAGAIN)
+		xerror("expected empty errqueue to return EAGAIN, r=%d err=%d",
+		       r, errno);
+
+	r = setsockopt(fd, level, optname, &zero, sizeof(zero));
+	if (r)
+		die_perror("setsockopt IP(V6)_RECVERR off");
+
+	val = -1;
+	s = sizeof(val);
+	r = getsockopt(fd, level, optname, &val, &s);
+	if (r)
+		die_perror("getsockopt IP(V6)_RECVERR off");
+	if (s != sizeof(val) || val != zero)
+		xerror("IP(V6)_RECVERR off mismatch val=%d len=%u", val, s);
+}
+
 static int client(int pipefd)
 {
 	int fd = -1;
@@ -787,6 +856,7 @@ static int client(int pipefd)
 	}
 
 	test_ip_tos_sockopt(fd);
+	test_ip_recverr_sockopt(fd);
 
 	connect_one_server(fd, pipefd);
 

-- 
2.55.0

