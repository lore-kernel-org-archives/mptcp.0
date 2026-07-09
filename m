Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D873DE42D
	for <mptcp@lists.linux.dev>; Thu,  9 Jul 2026 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580832; cv=none; b=X+I+XAkmyPoCFnRfhEa1GL1XuuU/j6t5eKYAz0gpjjwRgxdo9ZCvRBwbp3JIkwzBP5/8qHBmtK2QJ75lw1c1g8wQzmJlByNbp7Cv3HQt3RVA/eS1srJfsgkh4vuhgNQYX3ASEcntFml/TZ22LJJBPhtNFAeVfa7DJnFiZ3QatEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580832; c=relaxed/simple;
	bh=zQeGSLgLGStC8IVm9O0o4TGAlyI5EbVglszBZ+ycC4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQyoKKGu/PPT4zA0LckzF2GAce7eKmyCWvHVHLJWiHcWCDX+RJnhOvPOcBi/OYE/xDvGo1hVtCPwpLrGGRvn1q4VGilNrc+HP3x69zVztHwq5xhl55fdD9TrsHHBCRc5eOPEtxG1IW+9xCKfJSoflj89LuYGjAzJ8ecxQz2vU3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPlUqjml; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPlUqjml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64DC1F00A3A;
	Thu,  9 Jul 2026 07:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783580829;
	bh=aX6g8Mgm+aF+xWMM3gcFzSmAb1l4mqgMNx7N39MMy68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lPlUqjmlWjuEEATTAy1oW2kFH0puRnJNWcvJQoSP5FhqG6LUTsEndaaf7r4pIKwS/
	 u7AT/2pFCkOtGV5awfNqdtIWE1m2Cxk7ji5SbmFvvuovAGusoIghXadEnKvXeC+Tj4
	 kti8Cba8LRWKR2yKfSDhAa6ELRQlKhQferzllxwS2ooilp4WaYqPhKGap24bb0Rd7z
	 0MjTnjxdpEDs5Lg0ltlrEYLesJCLd4FmwSe9SgQDViKs1mc4OWOsfqM95kQWXYDxpm
	 qP4kIwCl3gbuLy5/oEGZ1rx/JRKBmHSoTPqI0pCiPeWjovA7JLJ20p2ar/D1HJDOmw
	 +WisTvsapZsBQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 07/12] selftests: mptcp: sockopt: add huge data transfer tests
Date: Thu,  9 Jul 2026 15:06:16 +0800
Message-ID: <278d77bd30b85f28c834ce3e663e2112c2de8550.1783579976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783579976.git.tanggeliang@kylinos.cn>
References: <cover.1783579976.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Introduce huge data transfer tests (1-17 MB) to validate MPTCP socket
options under high-volume conditions, including proper EOF handling,
preparing for TCP_INQ support in subsequent patches.

These codes are from mptcp_inq.c, but here they have been placed into
two separate functions.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 1b4d94abb1c6..b4da3aa9713b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -593,6 +593,47 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 		do_getsockopt_mptcp_full_info(s, fd);
 }
 
+static void server_huge_transfer(int fd, int unixfd, size_t len)
+{
+	char buf[4096], buf2[4];
+	size_t total;
+	ssize_t ret;
+
+	ret = read(unixfd, buf2, 4);
+	assert(strncmp(buf2, "huge", 4) == 0);
+
+	total = rand() % (16 * 1024 * 1024);
+	total += (1 * 1024 * 1024);
+
+	ret = write(unixfd, &total, sizeof(total));
+	assert(ret == (ssize_t)sizeof(total));
+
+	while (total > 0) {
+		if (total > sizeof(buf))
+			len = sizeof(buf);
+		else
+			len = total;
+
+		ret = write(fd, buf, len);
+		if (ret < 0)
+			die_perror("write");
+		total -= ret;
+
+		/* we don't have to care about buf content, only
+		 * number of total bytes sent
+		 */
+	}
+
+	ret = read(unixfd, buf2, 4);
+	assert(ret == 4);
+	assert(strncmp(buf2, "shut", 4) == 0);
+
+	ret = write(fd, buf, 1);
+	assert(ret == 1);
+	ret = write(unixfd, "closed", 6);
+	assert(ret == 6);
+}
+
 static void connect_one_server(int fd, int unixfd)
 {
 	char buf[4096], buf2[4096];
@@ -661,10 +702,70 @@ static void connect_one_server(int fd, int unixfd)
 		total += 1; /* sequence advances due to FIN */
 
 	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+
+	if (inq)
+		server_huge_transfer(fd, unixfd, len);
+
 	close(fd);
 	close(unixfd);
 }
 
+static void client_huge_transfer(int fd, int unixfd)
+{
+	char msg_buf[4096];
+	size_t expect_len;
+	ssize_t ret, tot;
+	char buf[4096];
+	char tmp[16];
+	struct iovec iov = {
+		.iov_base = buf,
+		.iov_len = 1,
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = msg_buf,
+		.msg_controllen = sizeof(msg_buf),
+	};
+
+	/* request a large swath of data. */
+	ret = write(unixfd, "huge", 4);
+	assert(ret == 4);
+
+	ret = read(unixfd, &expect_len, sizeof(expect_len));
+	assert(ret == (ssize_t)sizeof(expect_len));
+
+	/* peer should send us a few mb of data */
+	if (expect_len <= sizeof(buf))
+		xerror("expect len %zu too small\n", expect_len);
+
+	tot = 0;
+	do {
+		iov.iov_len = sizeof(buf);
+		ret = recvmsg(fd, &msg, 0);
+		if (ret < 0)
+			die_perror("recvmsg");
+
+		tot += ret;
+	} while ((size_t)tot < expect_len);
+
+	ret = write(unixfd, "shut", 4);
+	assert(ret == 4);
+
+	/* wait for hangup. Should have received one more byte of data. */
+	ret = read(unixfd, tmp, sizeof(tmp));
+	assert(ret == 6);
+	assert(strncmp(tmp, "closed", 6) == 0);
+
+	sleep(1);
+
+	iov.iov_len = 1;
+	ret = recvmsg(fd, &msg, 0);
+	if (ret < 0)
+		die_perror("recvmsg");
+	assert(ret == 1);
+}
+
 static void process_one_client(int fd, int unixfd)
 {
 	ssize_t ret, ret2, ret3;
@@ -715,6 +816,9 @@ static void process_one_client(int fd, int unixfd)
 	if (ret2 < 0)
 		die_perror("write");
 
+	if (inq)
+		client_huge_transfer(fd, unixfd);
+
 	/* wait for hangup */
 	ret3 = read(fd, buf, 1);
 	if (ret3 != 0)
-- 
2.53.0

