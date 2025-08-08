Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E034527FB2D
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664231; cv=none; b=FW8HoUP4Cr5eEFG9LNxnNOV0riIwjBvw6pTBmOridX9Uv6juc7ypP/UYT9ibN4PAr47pefWRHj9JBxJ0PZpMuocChyH6X5JkAaBnVDlOs4QvOHhovaAgibr4eJEtE5IK2llYbGSYaUsXT8GONY08HVxSBMAvlv44Bn0EQ7PeCqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664231; c=relaxed/simple;
	bh=vPnu0/PvHSB1HAFqB+VcS7SCYWciLpt0wmtXOIoJrXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuifgANPn05srffY1UdF56dvcIGZDun38h+OvgeFfkZp7klT7ViXrIDafLMFAKAuYndBtK35BkmihuvsLvInpNRMfGnHHgK/HJm2RuSyZZOfA//lPdRoikhBO0A9fL9tY4tv8VRutHi9vmt4rELgYzKPkR6FQgyXdUTlVLYlMrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUsGYCO6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUsGYCO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F6DC4CEF4;
	Fri,  8 Aug 2025 14:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754664230;
	bh=vPnu0/PvHSB1HAFqB+VcS7SCYWciLpt0wmtXOIoJrXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XUsGYCO62QNKu+Y7KxQZBr0SpUgP6QV2601pyUvmzOtzmtG/538XdwQa3OzsUIeNJ
	 fMRPtMvN/vS0S5cTLByBe2ZklTgjLJPBq5xaK2V6lRT5LAPnaIdylsiyW76ajsgLzU
	 jLVhj1wYgNRj2dLHV8BRbjeeP2kzU2FaIoUbrizJwZHg3fb+O3WUu2rFqnwlNocPRz
	 kRr5CuCYSE5Ta1xVxtgVDfNhg2pcXWe1Iifzbqt0aYqltHnJtMzNsVVlIbcOkE9a6D
	 JDj3hj/TJSoO+DxmHNXagAohsO2TkHPHQZFQUvJ3LHg2edZsa6RP5F3B17SxUucg2Z
	 iCIPTOnjr7qaw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 6/9] selftests: mptcp: sockopt: add TCP_INQ client processing
Date: Fri,  8 Aug 2025 22:42:51 +0800
Message-ID: <84bf786dd175a375450941289c2c58c4d0bd24ca.1754664106.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754664106.git.tanggeliang@kylinos.cn>
References: <cover.1754664106.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/mptcp_sockopt.c       | 153 +++++++++++++++++-
 1 file changed, 152 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 79370df1d89d..0a85d7b3efe8 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -21,6 +21,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/random.h>
+#include <sys/ioctl.h>
 
 #include <netdb.h>
 #include <netinet/in.h>
@@ -712,6 +713,153 @@ static void process_one_client(int fd, int pipefd)
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
 static void do_setsockopt_inq(int fd)
 {
 	int on = 1;
@@ -760,7 +908,10 @@ static int server(int ipcfd)
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

