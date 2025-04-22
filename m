Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A73213E81
	for <mptcp@lists.linux.dev>; Tue, 22 Apr 2025 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745314323; cv=none; b=VvB0zZLmwS3t0Z0TCfprU2w4bt+bm1mpZr+Yld1KAmqduR+tHXGVcXubOthppTwDPau6z57lRxGhvYYB2myb3zDofK0rEr7w/cXjMU5yVnKSPizI5CbKEbxE0sxT8mI+4fajCNSlIk7EWbgFjpqdd9jyUlL9mT18shF9tba9AO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745314323; c=relaxed/simple;
	bh=Bc9cVFlP7WAckeyj3zH/rJTllQferZWpDiIg/KEgUQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqWKqFMU2qjW5A55Sd5P8pBvYktHNMk+eFp8z/YWQUKYq94Kyh1284wefRMPyKXUyyFBhdkL/11lDycYSOjzKyUhcL86on8H42D2gZvFItN425VNe8ANt480F++1URm0+2MEczUmum90Ge2URHF8vo/8A98Gm+3ff1+agnmc5wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPBfpRWX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPBfpRWX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596B0C4CEEA;
	Tue, 22 Apr 2025 09:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745314322;
	bh=Bc9cVFlP7WAckeyj3zH/rJTllQferZWpDiIg/KEgUQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TPBfpRWXXP9xrQ0JKYSJIfPcOWyH55g19vp34PMnmS4ERVoGjF+VlMaliCQlLp0Fn
	 TgYX8vCUO6PGgRycWdU4DqoaC7mhfcEly3CKTHAFeBrtZA5skZRXypb7mve3S25PnH
	 CXHGkr/zQIeW1alCJmLXxTq2aNFGpe8+PFXcadfe0SVp60xaBqUEyVoPEOvj9cuDcd
	 23rYAvjTH3fM0E483WzQcnx9q6/yByLPer/HZGbqpr40vLzGFfTDs+gKkpMwGrU9Hr
	 P2L3ZAWzCMPv7MxYlmZB3HyCGbpZZ7/hEgbRER1CekdwGUvucvtnByuvg/IiJg8e4n
	 HCek350qLUxIQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 2/2] selftests: mptcp: sockopt: add TCP_MAXSEG sockopt tests
Date: Tue, 22 Apr 2025 17:30:45 +0800
Message-ID: <98b1b574823f8447f8418b5567800ec01faba529.1745314165.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745314165.git.tanggeliang@kylinos.cn>
References: <cover.1745314165.git.tanggeliang@kylinos.cn>
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
index 926b0be87c99..e2043c0261bd 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -689,6 +689,26 @@ static int xaccept(int s)
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
@@ -713,6 +733,8 @@ static int server(int pipefd)
 
 	process_one_client(r, pipefd);
 
+	test_tcp_maxseg_sockopt(fd);
+
 	return 0;
 }
 
-- 
2.43.0

