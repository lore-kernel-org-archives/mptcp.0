Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B631314A60
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 03:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913167; cv=none; b=GsWxQbgXzTqo5uHIW/Tvj0Zp+s39HMCScf0aUcZHvm589zSd895Y1yEv/hS+MvFIHBxnooKkMUOGBtHaeoOOWgxgUrLKRMfw+x/r76R5T/dOe9I/vIdKQwreXUMGOHfDKkp7FM5a6JWEhxs7FJpxtG6HYta82CLA54XXDJ7NbBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913167; c=relaxed/simple;
	bh=4B5pbeEuh6aWzWKWYCy2LnX0LkPW3tvS52XnhKQ+928=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCnmmLxy4FHbTHQ5obW+flV9WrwQHAj27cBiSKAkpwUz5Y4/F+8KDQvREOo1EpqndUTpt4/SB61Ob1nZ8VEIUh/l71WRkgbfDDwJgrKNrn8a5SPORwDkfP3vvnoYWa4HA0+EJqpG9NNTV5vzwR+AW4Lmvn8+HNTTFG4EjaoSbgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+pH0rAF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+pH0rAF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF9F1F00A3A;
	Mon, 13 Jul 2026 03:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783913166;
	bh=aHaMmJ+mTw5PTnnQ/VAGNJ2QPPRlL3fyrEgBW9O0jU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P+pH0rAFgcIFMF4mnPPeHMcEOi1eyi70Ss0D4iSpyvJoAjmWlwVhAz6c4tyqZnYhs
	 8FEVo7iO8rs0IeLDH8kLgRlqN4+eMhpDPd9oCmy4dtjX2gbQf4R+uULJV/M9G1OzGj
	 YTV7xaB7bsfe13snkJket6KuIBpKgQkubXtDZnJjOcYBw9Vu/WQ/aJzY2km9eNx9gt
	 7iKJ9+/KCflgwGtjXRvIw9eyoUtpR5QRwhCel0JNnlNSYIc40yPvQ6opoLv1e07FxR
	 4NOKRJCL1zF9CLNUJePr9UovFYroFU4Vqmq7Z60la9AlN6zxg/c1M7OZwWlbnjWENZ
	 mBZIIaX//V4sg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 11/12] selftests: mptcp: sockopt: add huge data transfer tests
Date: Mon, 13 Jul 2026 11:25:35 +0800
Message-ID: <7438a373fb2145612cd6605c684b5f1028678411.1783913010.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783913010.git.tanggeliang@kylinos.cn>
References: <cover.1783913010.git.tanggeliang@kylinos.cn>
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
two separate functions.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 162 ++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index eed6e2b548be..61547d70576b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -27,6 +27,7 @@
 #include <netinet/in.h>
 
 #include <linux/tcp.h>
+#include <linux/sockios.h>
 #include <linux/compiler.h>
 
 static int pf = AF_INET;
@@ -599,6 +600,95 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
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
+static void server_huge_transfer(int fd, int unixfd, size_t len)
+{
+	char buf[4096], buf2[4];
+	size_t i, total;
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
+	wait_for_ack(fd, 5000, len);
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
@@ -668,6 +758,10 @@ static void connect_one_server(int fd, int unixfd)
 
 	if (proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP)
 		assert(s.mptcpi_rcv_delta == (uint64_t)total);
+
+	if (inq)
+		server_huge_transfer(fd, unixfd, len);
+
 	close(fd);
 	close(unixfd);
 }
@@ -719,6 +813,71 @@ static void get_tcp_inq(struct msghdr *msgh, unsigned int *inqv)
 	xerror("could not find TCP_CM_INQ cmsg type");
 }
 
+static size_t client_huge_transfer(int fd, int unixfd)
+{
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
+	/* wait for hangup. Should have received one more byte of data. */
+	ret = read(unixfd, tmp, sizeof(tmp));
+	assert(ret == 6);
+	assert(strncmp(tmp, "closed", 6) == 0);
+
+	sleep(1);
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
@@ -798,6 +957,9 @@ static void process_one_client(int fd, int unixfd)
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

