Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9245379C40
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054637; cv=none; b=McbUSl1ef4dN7ibOln6HANUJvooBwKDAMyTrzcLRp9M13doyaKV976gbE8X3HoeB9/q4T7tuRgrBmfQbB1QkPY1Ur27SDobmAm2zYwFbEYKv9DbkMRtn8wxCkY+HUaOSSsVxE3ye4z5DGFm/JEZWTHPaCZcCdtdI1HBDgQ8BZBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054637; c=relaxed/simple;
	bh=51bRHJ5A1CWgZoS6m8QK5GOIZmiq4TVxXFk9a+Pn5QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzcnUm18jfiLfqBovUNtXEEG4JxeRrYLxD85uPCQV8OGeQ72RyK6BDvn0ujbi22QAuEJXfgtmXXSPUB0kugz+oh9GSmsHYiKGMcYe107bGIB14LVNqrpFndKzxf17nWXYL30J/9gyxdAhrQ3/UwPFelSTIRpLNODzvoJNzgpms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXY6ofPG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXY6ofPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8231F00A3E;
	Sun, 26 Jul 2026 08:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785054635;
	bh=Lfc1Dle7sXpSBmoxKuqrBvAbiUVX5SJcB370LIzuPwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UXY6ofPG66o2uisUjwJJ5RckHs430TVAo77XC0icsqjp6H6ws6F/sO82o2rCvOSHW
	 c8jexCBfftlwnEGAHK1EsaEaTQbdm7K7e14tqFJtZQeljylYbXz91DZt72cjOhm5cQ
	 n7VTqVtTtsABMjbn4bFh5l3M9WA6EqwJFAlBE1FAP7t4qTHL1VRqVeOPEFds86LKNN
	 0lHqTAZswQa0+BZio21tn8ScP9YI0cLleh0rsbAJUS1SLKKnM1ZC07faObTD8TfA1W
	 x+tYZT0oX5ehIwvs7KeqWaAGxnUEB9h0J/gklX0RRdFuQ98WZ7vxcZSgcyEhAcYNmm
	 VIgYUvZmSzLmA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 10/12] selftests: mptcp: sockopt: get and verify TCP_INQ
Date: Sun, 26 Jul 2026 16:30:15 +0800
Message-ID: <46cd973771858cc3232e37c208f70f7cf01df8ce.1785054129.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785054129.git.tanggeliang@kylinos.cn>
References: <cover.1785054129.git.tanggeliang@kylinos.cn>
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
index f4c5c063469a..9ae0f2c00810 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -20,6 +20,7 @@
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/ioctl.h>
 
 #include <netdb.h>
 #include <netinet/in.h>
@@ -636,10 +637,12 @@ static void connect_one_server(int fd, int unixfd)
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
@@ -677,6 +680,7 @@ static void connect_one_server(int fd, int unixfd)
 	if (is_mptcp_socket(fd) > 0)
 		assert(s.mptcpi_rcv_delta == (uint64_t)total);
 	close(fd);
+	close(unixfd);
 }
 
 static void check_stat_equal(const char *name, uint64_t actual,
@@ -717,9 +721,30 @@ static void inq_msg_reset(struct inq_msg *m, size_t iov_len, void *base)
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
@@ -732,16 +757,57 @@ static void process_one_client(int fd, int unixfd)
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
@@ -759,6 +825,10 @@ static void process_one_client(int fd, int unixfd)
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

