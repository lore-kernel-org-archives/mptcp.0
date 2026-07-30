Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B23B433AD
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 03:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381353; cv=none; b=d2mQc56m0ohM9neO44fgi1z+iBcAQu/b7nSYhl6XLEcp9wbDWL1TwQ4AYbiw0fQeJzyYWJrk5X//C/xbxov6XYVjRz0wJpPPq6lODUnWE4dHLNgRezsi8eamuKjiOf2LJoWyzEeyCWvsEdfU5ttLbqzq9a+fF3Ie4v0HIoWad+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381353; c=relaxed/simple;
	bh=0HfHs55p0mg/8N5KhBbnCFHQlSJphsu+Xql37p2YwB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njevZmvTSFnUWBdpbFC8YBRB23SiSjG57H2NdBCQmhXZZaKhSJWRM3V8lv8J6bJwGglLa81YwgNsKPrCnkMsEJNy7Hxr51mnWvlvprzMx3DBX/cP1/53+cM3MapRaQd5RT8x8HV7LhRBM8xcjIUj5eLKhjl4lA8YLzA47PNCIh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hI9QtMTh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hI9QtMTh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415251F00A3A;
	Thu, 30 Jul 2026 03:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785381352;
	bh=7zc9ErYJYSGH7bVBWiQVyY8os1E83McpoPIdU2Uj6OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hI9QtMThXTkodqeXBHHPgpEpk3hAT8K3Z96VAJ9tpAoqg/kTxSQcErt38t/IdBn7M
	 2oTVdtQVIqYBWPq1BBnMs0HVJhF/ya88xmqSwqpfVu7MQIFbLLQP0efbKA+d+3lKHV
	 0hhfRKtU1SYHmMsdZ8crjlkndWVDauwhjb3d/czJ4YsO6PvEDZtYb4LPU5rdWiVXQq
	 ss6XTQ5ZyF42lRYnKdbDbtUiS2y4O89dC6Pxm0UPHV0Z+NvRzkykeJWJr76VuOvPLm
	 J3HrW/fCAIHjShJPbhY6MkwOfAvmrJTO2de2KNmVn7TPtmdcd1vGu6Qsxht0jEuFKD
	 4BJJUEPqLn7zA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 11/12] selftests: mptcp: sockopt: add huge data transfer tests
Date: Thu, 30 Jul 2026 11:15:22 +0800
Message-ID: <fc44bd2bac959e7edcdb2b3bfb7d34e4bf8c6bbd.1785380422.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785380422.git.tanggeliang@kylinos.cn>
References: <cover.1785380422.git.tanggeliang@kylinos.cn>
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

Add wait_for_ack() helper to synchronize test steps by waiting until the
send queue is drained (all data ACKed). Used in server_huge_transfer()
to ensure reliable TCP_INQ validation.

These codes are from mptcp_inq.c, but here they have been placed into
two separate functions. And in client_huge_transfer(), do a blocking read
for EOF on unixfd instead of sleeping, and poll with POLLRDHUP to wait for
FIN arrival before reading the final byte, preventing flaky EOF detection.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 171 ++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index a8b56f9eda13..cbc594ff7792 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -16,6 +16,7 @@
 #include <strings.h>
 #include <time.h>
 #include <unistd.h>
+#include <poll.h>
 
 #include <sys/socket.h>
 #include <sys/types.h>
@@ -26,6 +27,7 @@
 #include <netinet/in.h>
 
 #include <linux/tcp.h>
+#include <linux/sockios.h>
 #include <linux/compiler.h>
 
 static int pf = AF_INET;
@@ -619,6 +621,95 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 		do_getsockopt_mptcp_full_info(s, fd);
 }
 
+/* wait up to timeout milliseconds */
+static void wait_for_ack(int fd, int timeout, size_t total)
+{
+	int i;
+
+	for (i = 0; i < timeout; i++) {
+		int nsd, ret, queued = -1;
+		struct timespec req;
+
+		ret = ioctl(fd, TIOCOUTQ, &queued);
+		if (ret < 0)
+			die_perror("TIOCOUTQ");
+
+		ret = ioctl(fd, SIOCOUTQNSD, &nsd);
+		if (ret < 0)
+			die_perror("SIOCOUTQNSD");
+
+		if ((size_t)queued > total)
+			xerror("TIOCOUTQ %u, but only %zu expected\n",
+			       queued, total);
+		assert(nsd <= queued);
+
+		if (queued == 0)
+			return;
+
+		/* wait for peer to ack rx of all data */
+		req.tv_sec = 0;
+		req.tv_nsec = 1 * 1000 * 1000ul; /* 1ms */
+		nanosleep(&req, NULL);
+	}
+
+	xerror("still tx data queued after %u ms\n", timeout);
+}
+
+static void server_huge_transfer(int fd, int unixfd, size_t echo)
+{
+	char buf[4096], buf2[4];
+	size_t len, i, total;
+	size_t sent;
+	ssize_t ret;
+
+	for (i = 0; i < sizeof(buf) - 1; i++) {
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
+	sent = total;
+
+	ret = write(unixfd, &total, sizeof(total));
+	assert(ret == (ssize_t)sizeof(total));
+
+	wait_for_ack(fd, 5000, echo);
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
+	wait_for_ack(fd, 5000, sent);
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
@@ -688,6 +779,10 @@ static void connect_one_server(int fd, int unixfd)
 
 	if (is_mptcp_socket(fd))
 		assert(s.mptcpi_rcv_delta == (uint64_t)total);
+
+	if (inq)
+		server_huge_transfer(fd, unixfd, total);
+
 	close(fd);
 	close(unixfd);
 }
@@ -749,6 +844,79 @@ static void get_tcp_inq(struct msghdr *msgh, unsigned int *inqv)
 	xerror("could not find TCP_CM_INQ cmsg type");
 }
 
+static size_t client_huge_transfer(int fd, int unixfd)
+{
+	struct pollfd pfd = { .fd = fd, .events = POLLRDHUP };
+	unsigned int tcp_inq;
+	size_t expect_len;
+	ssize_t ret, tot;
+	struct inq_msg m;
+	char tmp[16];
+
+	inq_msg_init(&m, 1);
+
+	/* request a large swath of data. */
+	ret = write(unixfd, "huge", 4);
+	assert(ret == 4);
+
+	ret = read(unixfd, &expect_len, sizeof(expect_len));
+	assert(ret == (ssize_t)sizeof(expect_len));
+
+	/* peer should send us a few mb of data */
+	if (expect_len <= sizeof(m.buf))
+		xerror("expect len %zu too small\n", expect_len);
+
+	tot = 0;
+	do {
+		inq_msg_reset(&m, sizeof(m.buf), m.buf);
+		ret = recvmsg(fd, &m.hdr, 0);
+		if (ret < 0)
+			die_perror("recvmsg");
+		if (ret == 0)
+			xerror("unexpected EOF in huge recv");
+
+		tot += ret;
+
+		get_tcp_inq(&m.hdr, &tcp_inq);
+
+		if (tcp_inq > expect_len - tot)
+			xerror("inq %d, remaining %zu total_len %d\n",
+			       tcp_inq, expect_len - tot, (int)expect_len);
+
+		assert(tcp_inq <= expect_len - tot);
+	} while ((size_t)tot < expect_len);
+
+	ret = write(unixfd, "shut", 4);
+	assert(ret == 4);
+
+	/* wait for "closed"; server did final write on fd */
+	ret = read(unixfd, tmp, sizeof(tmp));
+	assert(ret == 6);
+	assert(strncmp(tmp, "closed", 6) == 0);
+
+	/* block on EOF: server close(fd) precedes close(unixfd) */
+	ret = read(unixfd, tmp, sizeof(tmp));
+	assert(ret == 0);
+
+	/* Wait for the TCP FIN to actually arrive. */
+	ret = poll(&pfd, 1, 5000);
+	assert(ret == 1);
+	assert(pfd.revents & POLLRDHUP);
+
+	inq_msg_reset(&m, 1, m.buf);
+	ret = recvmsg(fd, &m.hdr, 0);
+	if (ret < 0)
+		die_perror("recvmsg");
+	assert(ret == 1);
+
+	get_tcp_inq(&m.hdr, &tcp_inq);
+
+	/* tcp_inq should be 1 due to received fin. */
+	assert(tcp_inq == 1);
+
+	return tot + 1;
+}
+
 static void process_one_client(int fd, int unixfd)
 {
 	unsigned int tcp_inq;
@@ -829,6 +997,9 @@ static void process_one_client(int fd, int unixfd)
 		die_perror("write");
 	w = ret;
 
+	if (inq)
+		r += client_huge_transfer(fd, unixfd);
+
 	/* wait for hangup */
 	inq_msg_reset(&m, 1, m.buf);
 	ret = recvmsg(fd, &m.hdr, 0);
-- 
2.53.0

