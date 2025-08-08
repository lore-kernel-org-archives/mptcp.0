Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4941684AC
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 02:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754621128; cv=none; b=f8NqCZJzkk+897uIzVjRY2KzZ+/6TkhNK6pz2bt5F2PkKG8vFV2bRFwsUTSzmpdTAJD7kj7q4WHNh8hiSJ+NUC8NI+fQKAEFtk3MJn91e+fw43gRv85Q1RD4PBWHTWt89r6MVqz7t6jlyHsLCQNk5on+CetcZAIx9NijpdaPS98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754621128; c=relaxed/simple;
	bh=GlTXWNex+oZ5YxaE/dM0qkUjTNEm0qmafNpl5FjKtN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHBpG9er5uIikaFh52T30gIsjZw5J5h1EA4X824G/cqpG6Locjcfm+cXoeJcF13X7MN7e4meSJyDsi0q1c0IxLSUve+OpcJAJAjO+ygenaC0e7PAHscaLLLa3Vdm4NUnhMTHYmCdMJ+ryP7Ia4BAoRQC58MqSXzqWONicGklOXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGFRHciY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGFRHciY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21B1C4CEEB;
	Fri,  8 Aug 2025 02:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754621127;
	bh=GlTXWNex+oZ5YxaE/dM0qkUjTNEm0qmafNpl5FjKtN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGFRHciYhGdAUQntoaIB7W79m8vRT0bwPZIXOQ1mFGifpx8yRc817QUAH0ifdlO2c
	 ueFKmWh7fnyJ8ogaPRUTqKXKp5EP8VOyIdRrzbNZyOaFkhzYZMrwvVOsslqA7unDJU
	 STV4hTZNeZzsL9Ax6HiUO5M7fGACbelMoUXrp9rouVwG8ZjX/G2dWRYNaZ5jJx/aK8
	 r+vWN+CVKq9j0V4s2TO6cB2JyZteuNrWoE3GfqbauLc7KYGPDlogIIuPlNSSkS75YZ
	 ZrdMWaMv4zPwg1T2FMy4mDchjxUZV8hLgorrS3Xy3/SaHW5iUHuzuF0nVsabMLyMr3
	 9pKwf4mYBgQ6g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 5/8] selftests: mptcp: sockopt: add TCP_INQ client processing
Date: Fri,  8 Aug 2025 10:45:06 +0800
Message-ID: <dafd8d4d93bd4aa531b13ffa9c021721c24abad2.1754620968.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754620968.git.tanggeliang@kylinos.cn>
References: <cover.1754620968.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Implement process_one_client_inq() to handle TCP_INQ-specific client
logic including:
- Setting TCP_INQ sockopt
- Validating INQ values via cmsg
- Handling large data transfers with INQ checks
- Verifying FIN sequence INQ semantics

These codes are from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 157 +++++++++++++++++-
 1 file changed, 156 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index f767caa55a0a..d68db3f0d5f5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -21,6 +21,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/random.h>
+#include <sys/ioctl.h>
 
 #include <netdb.h>
 #include <netinet/in.h>
@@ -712,6 +713,157 @@ static void process_one_client(int fd, int pipefd)
 	close(fd);
 }
 
+static void get_tcp_inq(struct msghdr *msgh, unsigned int *inqv)
+{
+	struct cmsghdr *cmsg;
+
+	for (cmsg = CMSG_FIRSTHDR(msgh); cmsg ; cmsg = CMSG_NXTHDR(msgh, cmsg)) {
+		if (cmsg->cmsg_level == IPPROTO_TCP && cmsg->cmsg_type == TCP_CM_INQ) {
+			memcpy(inqv, CMSG_DATA(cmsg), sizeof(*inqv));
+			return;
+		}
+	}
+
+	xerror("could not find TCP_CM_INQ cmsg type");
+}
+
+static void process_one_client_inq(int fd, int unixfd)
+{
+	unsigned int tcp_inq;
+	size_t expect_len;
+	char msg_buf[4096];
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
+	ssize_t ret, tot;
+	int on = 1;
+
+	if (-1 == setsockopt(fd, IPPROTO_TCP, TCP_INQ, &on, sizeof(on)))
+		die_perror("setsockopt");
+
+	ret = write(unixfd, "xmit", 4);
+	assert(ret == 4);
+
+	ret = read(unixfd, &expect_len, sizeof(expect_len));
+	assert(ret == (ssize_t)sizeof(expect_len));
+
+	if (expect_len > sizeof(buf))
+		xerror("expect len %zu exceeds buffer size", expect_len);
+
+	for (;;) {
+		struct timespec req;
+		unsigned int queued;
+
+		ret = ioctl(fd, FIONREAD, &queued);
+		if (ret < 0)
+			die_perror("FIONREAD");
+		if (queued > expect_len)
+			xerror("FIONREAD returned %u, but only %zu expected\n",
+			       queued, expect_len);
+		if (queued == expect_len)
+			break;
+
+		req.tv_sec = 0;
+		req.tv_nsec = 1000 * 1000ul;
+		nanosleep(&req, NULL);
+	}
+
+	/* read one byte, expect cmsg to return expected - 1 */
+	ret = recvmsg(fd, &msg, 0);
+	if (ret < 0)
+		die_perror("recvmsg");
+
+	if (msg.msg_controllen == 0)
+		xerror("msg_controllen is 0");
+
+	get_tcp_inq(&msg, &tcp_inq);
+
+	assert((size_t)tcp_inq == (expect_len - 1));
+
+	iov.iov_len = sizeof(buf);
+	ret = recvmsg(fd, &msg, 0);
+	if (ret < 0)
+		die_perror("recvmsg");
+
+	/* should have gotten exact remainder of all pending data */
+	assert(ret == (ssize_t)tcp_inq);
+
+	/* should be 0, all drained */
+	get_tcp_inq(&msg, &tcp_inq);
+	assert(tcp_inq == 0);
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
+
+		get_tcp_inq(&msg, &tcp_inq);
+
+		if (tcp_inq > expect_len - tot)
+			xerror("inq %d, remaining %d total_len %d\n",
+			       tcp_inq, expect_len - tot, (int)expect_len);
+
+		assert(tcp_inq <= expect_len - tot);
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
+	get_tcp_inq(&msg, &tcp_inq);
+
+	/* tcp_inq should be 1 due to received fin. */
+	assert(tcp_inq == 1);
+
+	iov.iov_len = 1;
+	ret = recvmsg(fd, &msg, 0);
+	if (ret < 0)
+		die_perror("recvmsg");
+
+	/* expect EOF */
+	assert(ret == 0);
+	get_tcp_inq(&msg, &tcp_inq);
+	assert(tcp_inq == 1);
+
+	close(fd);
+}
+
 static int xaccept(int s)
 {
 	int fd = accept(s, NULL, 0);
@@ -744,7 +896,10 @@ static int server(int ipcfd)
 	alarm(15);
 	r = xaccept(fd);
 
-	process_one_client(r, ipcfd);
+	if (inq)
+		process_one_client_inq(r, ipcfd);
+	else
+		process_one_client(r, ipcfd);
 
 	return 0;
 }
-- 
2.48.1

