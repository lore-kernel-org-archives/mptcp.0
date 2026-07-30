Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA743375F76
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 03:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381352; cv=none; b=R52pI5Kt2UZyTGDmI+9AECVXR/UUvlvDTIoGNDQoCYe8MVPmGcaXX7gDfPtKxmVVBpVkuYflkFvsydmIyS85vtWeKCZFqWtIg1SrQPo7tDOEUPu6ozSa4TldUyTYASKNtOrkBoZdxXH+F+22rQh+OGmNCtXOC7Yk39qHJIy3bmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381352; c=relaxed/simple;
	bh=8mNP/jy+y4p97ppOYt8PP33shmw/WdAgMDhL4n2i+PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXvEtO/NKciF5wuhQCgTU310erFioIDCZnD6JW7b83yQblMX2iS9rTFDQ5Epmd6SkEhOVBUq4MXcg2FaftGAAHc97gxOqQVYMXc7W/dOQ2H9MUuN6cK6Yw0GDGwOEuek/4mHUpCltKBVCjsuD2Z00sgj4Ufarrr89MD66wkpIYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cS+6Rui8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cS+6Rui8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC9B1F000E9;
	Thu, 30 Jul 2026 03:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785381350;
	bh=SO7GZlPj9VEPLD5buZzNgLQwuUMpvkKwE7Vd3kWqT0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cS+6Rui8PTtdPEXp9uRh5o/ZwJpoXtongRSMTlI0JcDFdU+iCHZY99ZyULW0w6HAg
	 fcB2lEgPyPg/y5Qc6k96tUGwStFKXvXA00fl2xMyk7iRzd3Iost2svzV/LjtBQ5brM
	 WlJH4B76HqOQtiytQb/1hSlp5etqULSVJEISxkH5cJSLT+TUVI/XYmdITknyKeLKlx
	 fapfsFnsIsXuhwY84Yy+w7bEtL7DK0aQI6kQzFjwdm/Er2L37JkcNWcKgyWGikrT/P
	 DAZzXEC5Si6Ojq37kqk1iBO3y6O9Y6U/DggdPK/R7i6LLQAA0ZvVfzO8yL20ZVV4cJ
	 9UPX28fDAm9cA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 10/12] selftests: mptcp: sockopt: get and verify TCP_INQ
Date: Thu, 30 Jul 2026 11:15:21 +0800
Message-ID: <d4775df4760940cdfcdc04698ab6983d78910fec.1785380422.git.tanggeliang@kylinos.cn>
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

Implement FIONREAD ioctl checks to validate available data size, ensuring
synchronization between write and read operations with non-blocking waits.

Pass the payload length ('len') from the client to the server via the
unixfd control channel. This allows the server to know the exact amount
of data to expect, enabling precise FIONREAD loop and later TCP_CM_INQ
validation.

Add get_tcp_inq() helper to extract and verify TCP_CM_INQ values from
received control messages. Integrate it into the echo test to validate
in-queue byte counts at key stages, ensuring correct TCP_INQ behavior
with MPTCP.

Code adapted from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 72 ++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 080f9d9e34d5..a8b56f9eda13 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -20,6 +20,7 @@
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/ioctl.h>
 
 #include <netdb.h>
 #include <netinet/in.h>
@@ -645,10 +646,12 @@ static void connect_one_server(int fd, int unixfd)
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
@@ -686,6 +689,7 @@ static void connect_one_server(int fd, int unixfd)
 	if (is_mptcp_socket(fd))
 		assert(s.mptcpi_rcv_delta == (uint64_t)total);
 	close(fd);
+	close(unixfd);
 }
 
 static void check_stat_equal(const char *name, uint64_t actual,
@@ -726,9 +730,30 @@ static void inq_msg_reset(struct inq_msg *m, size_t iov_len, void *base)
 	m->hdr.msg_controllen = sizeof(m->control.msg_buf);
 }
 
+static void get_tcp_inq(struct msghdr *msgh, unsigned int *inqv)
+{
+	struct cmsghdr *cmsg;
+
+	for (cmsg = CMSG_FIRSTHDR(msgh); cmsg;
+	     cmsg = CMSG_NXTHDR(msgh, cmsg)) {
+		if (cmsg->cmsg_level == IPPROTO_TCP &&
+		    cmsg->cmsg_type == TCP_CM_INQ) {
+			if (cmsg->cmsg_len < CMSG_LEN(sizeof(*inqv)))
+				xerror("TCP_CM_INQ cmsg_len too small: %zu",
+				       cmsg->cmsg_len);
+			memcpy(inqv, CMSG_DATA(cmsg), sizeof(*inqv));
+			return;
+		}
+	}
+
+	xerror("could not find TCP_CM_INQ cmsg type");
+}
+
 static void process_one_client(int fd, int unixfd)
 {
+	unsigned int tcp_inq;
 	struct so_state s;
+	size_t expect_len;
 	struct inq_msg m;
 	ssize_t ret;
 	size_t r, w;
@@ -741,16 +766,57 @@ static void process_one_client(int fd, int unixfd)
 	ret = write(unixfd, "xmit", 4);
 	assert(ret == 4);
 
+	ret = read(unixfd, &expect_len, sizeof(expect_len));
+	assert(ret == (ssize_t)sizeof(expect_len));
+
+	if (expect_len > sizeof(m.buf))
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
 	/* read one byte */
 	ret = recvmsg(fd, &m.hdr, 0);
 	if (ret < 0)
 		die_perror("recvmsg");
+	if (inq) {
+		if (m.hdr.msg_controllen == 0)
+			xerror("msg_controllen is 0");
+
+		get_tcp_inq(&m.hdr, &tcp_inq);
+
+		/* expect cmsg to return expected - 1 */
+		assert((size_t)tcp_inq == (expect_len - 1));
+	}
 	r = ret;
 
 	inq_msg_reset(&m, sizeof(m.buf) - 1, m.buf + 1);
 	ret = recvmsg(fd, &m.hdr, 0);
 	if (ret < 0)
 		die_perror("recvmsg");
+	if (inq) {
+		/* should have gotten exact remainder of all pending data */
+		assert(ret == (ssize_t)tcp_inq);
+
+		/* should be 0, all drained */
+		get_tcp_inq(&m.hdr, &tcp_inq);
+		assert(tcp_inq == 0);
+	}
 	r += ret;
 
 	assert(s.mptcpi_rcv_delta <= (uint64_t)r);
@@ -768,6 +834,10 @@ static void process_one_client(int fd, int unixfd)
 	ret = recvmsg(fd, &m.hdr, 0);
 	if (ret != 0)
 		xerror("expected EOF, got %zd", ret);
+	if (inq) {
+		get_tcp_inq(&m.hdr, &tcp_inq);
+		assert(tcp_inq == 1);
+	}
 	r += ret;
 
 	do_getsockopts(&s, fd, r, w);
-- 
2.53.0

