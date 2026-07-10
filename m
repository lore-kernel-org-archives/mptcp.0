Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975073A451E
	for <mptcp@lists.linux.dev>; Fri, 10 Jul 2026 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673975; cv=none; b=NtT8ODvWEwlsqY5ZiTxgQfrlsWbdi/s9Gm4FbSKdjzixc7zoyvGLqNVCBbCng6laC2B59ikOsG6hYp7gPXGRVYn5g+yM0jUaxeIv4ljbAogTd46jR6d5e8h3Cvtm6SOaGZGgdkQ7G/4ma3UvAhOmFlOPeXO3yYWjfReGAnz2fJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673975; c=relaxed/simple;
	bh=+8N5vwlrtwG9DQ4AM8fzWYh9Pb2zp8sJ9SzcNOEtA/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOg+OjIL+2b49wQ9HJILqD0ntcfRtbvM0SMbR4I3fgNh/mRoiPQ1A6PpafpvUajZRG2QVk4Wuq5XL7qveqYBpjp0tS8apHb1Tul78TPvADOQY9lnnEpQykFYGsrZY6FPdopbtDYWC3FUA61eE8GnZrW5BrRZStYH+5Anc5sRc0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hD4fmcdd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hD4fmcdd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32FE1F000E9;
	Fri, 10 Jul 2026 08:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783673972;
	bh=2HWcyXxsgQ2XqhMb4o0HVs91veWFCFp94TkkzfEURcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hD4fmcddCKc4ZoSYO0aO81nDAZDZyxgVPGOoa8w9ruf2n8NJc09ucQqnkotKHK4lI
	 +78l5IKypoabC34wqY5f3//9z8OtuMeLlh7Ae42eAo7Si5gDslkHFvvZHjb3OJMjt3
	 ReogQlRaVZ5fPpcVPCzIGzUvVl/p/zLkVkeLohNeE9/lHEJ43X7qaiB8xcmMrori/g
	 PdNfOUWPZPD42IBpp/Z8l+mFXdRFe3QRNn6iKlDXt63RBbfzSrOEYhbsBODfkbuXtp
	 lnU/yu5Vw3wVnsrhmDRNaQOjMGCCf/2j8AUx+pZUkXPr2qaL/SQHdmj/kkolBhhwrW
	 86tZwr5qFfYXg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 06/10] selftests: mptcp: sockopt: add huge data transfer tests
Date: Fri, 10 Jul 2026 16:59:09 +0800
Message-ID: <b807f8eb4a8058832ca2cf824c298c9c7063b63d.1783673158.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783673158.git.tanggeliang@kylinos.cn>
References: <cover.1783673158.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/mptcp_sockopt.c       | 132 +++++++++++++++++-
 1 file changed, 126 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 0bd5a9c51332..16b58f6ac7b7 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -596,6 +596,55 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 		do_getsockopt_mptcp_full_info(s, fd);
 }
 
+static void server_huge_transfer(int fd, int unixfd, size_t len)
+{
+	char buf[4096], buf2[4];
+	size_t i, total;
+	ssize_t ret;
+
+	for (i = 0; i < len ; i++) {
+		buf[i] = rand() % 26;
+		buf[i] += 'A';
+	}
+
+	buf[i] = '\n';
+
+	ret = read(unixfd, buf2, 4);
+	assert(ret == 4);
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
@@ -665,16 +714,83 @@ static void connect_one_server(int fd, int unixfd)
 
 	if (proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP)
 		assert(s.mptcpi_rcv_delta == (uint64_t)total);
+
+	if (inq)
+		server_huge_transfer(fd, unixfd, len);
+
 	close(fd);
 	close(unixfd);
 }
 
+static size_t client_huge_transfer(int fd, int unixfd)
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
+		msg.msg_controllen = sizeof(msg_buf);
+		ret = recvmsg(fd, &msg, 0);
+		if (ret < 0)
+			die_perror("recvmsg");
+		if (ret == 0)
+			xerror("unexpected EOF in huge recv");
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
+	msg.msg_controllen = sizeof(msg_buf);
+	ret = recvmsg(fd, &msg, 0);
+	if (ret < 0)
+		die_perror("recvmsg");
+	assert(ret == 1);
+
+	return tot + 1;
+}
+
 static void process_one_client(int fd, int unixfd)
 {
 	ssize_t ret, ret2, ret3;
 	struct so_state s;
 	size_t expect_len;
 	char buf[4096];
+	size_t r = 0;
 
 	memset(&s, 0, sizeof(s));
 	do_getsockopts(&s, fd, 0, 0);
@@ -719,16 +835,20 @@ static void process_one_client(int fd, int unixfd)
 	if (ret2 < 0)
 		die_perror("write");
 
+	if (inq)
+		r = client_huge_transfer(fd, unixfd);
+
 	/* wait for hangup */
 	ret3 = read(fd, buf, 1);
 	if (ret3 != 0)
 		xerror("expected EOF, got %lu", ret3);
 
-	do_getsockopts(&s, fd, ret, ret2);
+	do_getsockopts(&s, fd, ret + r, ret2);
 	if (proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP &&
-	    s.mptcpi_rcv_delta != (uint64_t)ret + 1)
+	    s.mptcpi_rcv_delta != (uint64_t)ret + r + 1)
 		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64 ", diff %" PRId64,
-		       s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - (ret + 1));
+		       s.mptcpi_rcv_delta, ret + r + 1,
+		       s.mptcpi_rcv_delta - (ret + r + 1));
 
 	/* be nice when running on top of older kernel */
 	if (s.pkt_stats_avail) {
@@ -737,11 +857,11 @@ static void process_one_client(int fd, int unixfd)
 			       ", diff %" PRId64,
 			       s.last_sample.mptcpi_bytes_sent, ret2,
 			       s.last_sample.mptcpi_bytes_sent - ret2);
-		if (s.last_sample.mptcpi_bytes_received != ret)
+		if (s.last_sample.mptcpi_bytes_received != ret + r)
 			xerror("mptcpi_bytes_received %" PRIu64 ", expect %" PRIu64
 			       ", diff %" PRId64,
-			       s.last_sample.mptcpi_bytes_received, ret,
-			       s.last_sample.mptcpi_bytes_received - ret);
+			       s.last_sample.mptcpi_bytes_received, ret + r,
+			       s.last_sample.mptcpi_bytes_received - (ret + r));
 		if (s.last_sample.mptcpi_bytes_acked != ret)
 			xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64
 			       ", diff %" PRId64,
-- 
2.53.0

