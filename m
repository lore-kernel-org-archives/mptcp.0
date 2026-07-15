Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D68A38E133
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 02:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083774; cv=none; b=iLhqR8F3jIg9jC+br5cnxP5TyyjsxXRr0qrHxp2V3uccTjgI2PIIu75hoLIUTrn4i6VwvkIjC5rqmoNXvTqwlO24SoNWXIXWBfli7GInP4TkxsFvTCHsneh0Amas/VqZizYDJV5ZbbGxHTKX2JcO1AuzMCblPQtpYBXTBZ0eD5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083774; c=relaxed/simple;
	bh=4ucV21QcTePgwGc+xNJZM+qdrM3xiFJWUHlf0yCjIVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1PoR4RWtwpYu3VGQ8btSWLk1sl/P95Iwzb5SdYnOxmO+IkOsDCAatKZh+zs28x5UlMM2IjP1mRo5n6d9vTXoja1VxFLY3t/JavMp6QcjpNnxl18SEqN8nJGxLymZGoJK7ZNJ7oALF982Clc77/MnLgFM0oPIHWkRc1S+Xty2Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeEk2pHQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeEk2pHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED1B1F000E9;
	Wed, 15 Jul 2026 02:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083773;
	bh=t1TXxVhD2hk+bB8kKF9jPKPcmHyL7etJfB8abET5Jaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HeEk2pHQUNpzLV+Pg9ICRCfQJS/z1otxb51lNpEUdX+xmJtVBeuOE8/63ULuTM31N
	 6TZ/4pvg2gUJwoJMzjY93TicrRfjgbtXbUg4QexyRKrSVkf+dDw9EKaSevbWRGWW7R
	 Dxdp3/v3JLyDUa0sJScNSvNYTPsOVrnsX8OnNHWBMKPhiHsoFoedLFcVwIQqPsZxmb
	 k+2sGCUas+oPaflx3iw3JTKf0E03GXfgFT4VvuOu93cKFXjRYDN+WbKiObuYXNqLXh
	 G3K9CAbhJ4lq3+TLqlKpWdt9OwZL8KMvaVlnXbOvt8SGJI6CIREsbt9Vkx7Qlfbrer
	 ihFV1eOiGytCA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 10/11] selftests: mptcp: sockopt: add huge data transfer tests
Date: Wed, 15 Jul 2026 10:48:56 +0800
Message-ID: <e498cc208c2429f6bcf3a86bd2d24c8dea70a9b2.1784082850.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784082850.git.tanggeliang@kylinos.cn>
References: <cover.1784082850.git.tanggeliang@kylinos.cn>
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
index c754e6cdaa40..005779ebdabe 100644
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
@@ -598,6 +600,95 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
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
@@ -667,6 +758,10 @@ static void connect_one_server(int fd, int unixfd)
 
 	if (proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP)
 		assert(s.mptcpi_rcv_delta == (uint64_t)total);
+
+	if (inq)
+		server_huge_transfer(fd, unixfd, total);
+
 	close(fd);
 	close(unixfd);
 }
@@ -728,6 +823,79 @@ static void get_tcp_inq(struct msghdr *msgh, unsigned int *inqv)
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
@@ -808,6 +976,9 @@ static void process_one_client(int fd, int unixfd)
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

