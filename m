Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B9A301461
	for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200600; cv=none; b=Hj3KhJoh5A/p6JS6+ri9u4bw2+8MJoMdL62R78KZMNnSnaQol08IFonafTdqLsNC01TaHhcvtash1uMJNXbc4Tx6OewGCxHXDKDvXTbPvCGrenj326af0j4tFMCv7fZE4DHVjnaKlvev2tkOZ1B/n3Ds3aVdF8l8WJQQCaF22Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200600; c=relaxed/simple;
	bh=1JKAgF3adNToiZlKgOw2VSPvIYOIgDY9GzF5zcvyzrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKbfyuSgzcG9Cpc7Lhbg2Cd5x78ezphQbUaT0X997+E9qs3EbgOG+yl9uC259keDQCIBA0Vq8WtwH+nY0fBr1JfMY9CLQogi+g5L/kEEgg2jMRDxA7DNRj3YJq/j8hbjP/rrkkt9JV5F7YCLBze36oO0IDtnshGKinrTCXHcwDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvKAHI+r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvKAHI+r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D07EC4CEF1;
	Tue, 26 Aug 2025 09:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200600;
	bh=1JKAgF3adNToiZlKgOw2VSPvIYOIgDY9GzF5zcvyzrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UvKAHI+r64kob1/hsZxlOESf8Pzj7iNg8A090UCB4dEAseEzpQhdRHXUHtB7fHcla
	 dn53oNQkWicg8lrJ2NL0LdVlYk0the4ekUj1dWV3MlxJm8MQhQ01P51rL9YDLqP+HL
	 xzBj061mWVEZKIe7EBd+Kzn2MPk4m/910FkbuFkvXDmKGD9l/CbDORD87ecNeP4cB4
	 huYkaZAXnHQWraAbO3QtR8llceZ1BynPYbQJgTsRTQFRniIxbKQherkhrBoDX9TFaB
	 tcszINSXP3w7u2/ioqgfZqhdWahkM0mZ2sEFLGByZ7701IF6wIdjcUGAfANalAdzFF
	 nqOrZseCg5jvw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 09/14] selftests: mptcp: sockopt: add large data transfer tests
Date: Tue, 26 Aug 2025 17:29:33 +0800
Message-ID: <c10d0d21605a4358fdc905042a6e0c4158e2cc3f.1756200029.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756200029.git.tanggeliang@kylinos.cn>
References: <cover.1756200029.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Introduces large data transfer tests (1-17 MB) to validate MPTCP socket
options under high-volume conditions, including proper EOF handling,
preparing for TCP_INQ support in subsequent patches.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 90 ++++++++++++++++++-
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 675ed2dcee9f..fc65157a41ee 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -620,10 +620,12 @@ static void connect_one_server(int fd, int unixfd)
 	/* un-block server */
 	ret = read(unixfd, buf2, 4);
 	assert(ret == 4);
-	close(unixfd);
 
 	assert(strncmp(buf2, "xmit", 4) == 0);
 
+	ret = write(unixfd, &len, sizeof(len));
+	assert(ret == (ssize_t)sizeof(len));
+
 	ret = write(fd, buf, len);
 	if (ret < 0)
 		die_perror("write");
@@ -659,14 +661,51 @@ static void connect_one_server(int fd, int unixfd)
 		total += 1; /* sequence advances due to FIN */
 
 	assert(s.mptcpi_rcv_delta ? s.mptcpi_rcv_delta == (uint64_t)total : true);
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
 	close(fd);
+	ret = write(unixfd, "closed", 6);
+	assert(ret == 6);
+
+	close(unixfd);
 }
 
 static void process_one_client(int fd, int unixfd)
 {
-	ssize_t ret, ret2, ret3;
+	ssize_t ret, ret2, ret3, tot;
 	char msg_buf[4096];
 	struct so_state s;
+	size_t expect_len;
 	char buf[4096];
 	struct iovec iov = {
 		.iov_base = buf,
@@ -678,6 +717,7 @@ static void process_one_client(int fd, int unixfd)
 		.msg_control = msg_buf,
 		.msg_controllen = sizeof(msg_buf),
 	};
+	char tmp[16];
 
 	memset(&s, 0, sizeof(s));
 	do_getsockopts(&s, fd, 0, 0);
@@ -685,6 +725,12 @@ static void process_one_client(int fd, int unixfd)
 	ret = write(unixfd, "xmit", 4);
 	assert(ret == 4);
 
+	ret = read(unixfd, &expect_len, sizeof(expect_len));
+	assert(ret == (ssize_t)sizeof(expect_len));
+
+	if (expect_len > sizeof(buf))
+		xerror("expect len %zu exceeds buffer size", expect_len);
+
 	/* read one byte, expect cmsg to return expected - 1 */
 	ret = recvmsg(fd, &msg, 0);
 	if (ret < 0)
@@ -703,6 +749,9 @@ static void process_one_client(int fd, int unixfd)
 	if (s.tcpi_rcv_delta)
 		assert(s.tcpi_rcv_delta == (uint64_t)ret);
 
+	/* should have gotten exact remainder of all pending data */
+	assert(ret == (ssize_t)expect_len - 1);
+
 	ret2 = write(fd, buf, ret);
 	if (ret2 < 0)
 		die_perror("write");
@@ -727,6 +776,43 @@ static void process_one_client(int fd, int unixfd)
 			       s.last_sample.mptcpi_bytes_acked - ret2);
 	}
 
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
+
 	/* wait for hangup */
 	iov.iov_len = 1;
 	ret3 = recvmsg(fd, &msg, 0);
-- 
2.48.1

