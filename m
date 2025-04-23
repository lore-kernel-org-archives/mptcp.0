Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39D72701B1
	for <mptcp@lists.linux.dev>; Wed, 23 Apr 2025 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745401256; cv=none; b=mEBdUAxgOv8S7uHMxdTbRXurwgHtJgMdftWvakJZM3+F4s8GIb+kKGBVFqx9sXqe5RsKO6cFfFwy1vtKdDpwd2VAmiB3FMLZVwNIzzDaICUajNrA0AFraqArohKll2DtketomNkQQ481FQBnAVRcnh+LlDlKcXeMZealv+JjzBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745401256; c=relaxed/simple;
	bh=N1fim+dFf1Fcz3Xapnqlp34Y7CX2Cvt81omK14EyvG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhaKw+lC0rfaqfrGrTKrHNrfQTrOxuiLfRL0oSG0186BMUC7Lex65OUKfABM0aj8i+RXSloelfiUUBVJJNXZ5L8O6dR9HtdRXYZRrRsIiWXXJaZhcNxtSpnGgEDS3SoIz2Y9+bJdJzit6x8wvmsXs/Fj0KtCHKDb48sLxFSQzvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJgSfK++; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJgSfK++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60570C4CEE2;
	Wed, 23 Apr 2025 09:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745401255;
	bh=N1fim+dFf1Fcz3Xapnqlp34Y7CX2Cvt81omK14EyvG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJgSfK++1GuBrfT6cBEX95SwrQg+BWK8nsv/4y/7xkFgigHZrcJrSy4GLE5r4zmYY
	 /14h2UxIesow5a62F7bI7mGOs4UeVEzYOFf0CuN44ZCG+r5xllmozN+I8cA2lwJDRL
	 NFPVpSBnjlq0AGRj4z7hESBv6sS2qbHKsmG+FPzgJ1dWhRHysOocJvsfPGHzCsGR6X
	 lhjT5fcKu5C9xoZzaIOkDZLsgWTKPfiSU9O7nsv3wnC+cGCJaBCYFaHhiYSFZhlupP
	 6rVi7X9Ieje1VNvlg6ahI4ykRjMERNbu5/g6OwUp4z7FxmiU0Rxuy7U134JMC6Uj0B
	 4fMtNzEC571gg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/3] selftests: mptcp: sockopt: add TCP_MAXSEG sockopt tests
Date: Wed, 23 Apr 2025 17:40:42 +0800
Message-ID: <2a5c52d491de283397c9fad972350298de74d8c3.1745401025.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745401025.git.tanggeliang@kylinos.cn>
References: <cover.1745401025.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds the TCP_MAXSEG sockopt tests in mptcp_sockopt.c. Since
in getsockopt TCP_MAXSEG, the "user_mss" value can be obtained only in
the LISTEN state (see do_tcp_getsockopt in net/ipv4/tcp.c), the test
items are added to server() instead of client().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 9934a68df237..5ad1e9ed2fe6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -697,6 +697,26 @@ static int xaccept(int s)
 	return fd;
 }
 
+static void test_tcp_maxseg_sockopt(int fd)
+{
+	int maxseg = 1000;
+	socklen_t s;
+	int r;
+
+	s = sizeof(maxseg);
+	r = setsockopt(fd, IPPROTO_TCP, TCP_MAXSEG, &maxseg, s);
+	if (r != 0)
+		die_perror("setsockopt TCP_MAXSEG");
+
+	maxseg = 0;
+	r = getsockopt(fd, IPPROTO_TCP, TCP_MAXSEG, &maxseg, &s);
+	if (r != -1 && errno != EINVAL)
+		die_perror("getsockopt TCP_MAXSEG did not indicate -EINVAL");
+
+	if (maxseg != 1000)
+		xerror("maxseg=%d", maxseg);
+}
+
 static int server(int pipefd)
 {
 	int fd = -1, r;
@@ -721,6 +741,8 @@ static int server(int pipefd)
 
 	process_one_client(r, pipefd);
 
+	test_tcp_maxseg_sockopt(fd);
+
 	return 0;
 }
 
-- 
2.43.0

