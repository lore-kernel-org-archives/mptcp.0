Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A0314A86
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 03:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913165; cv=none; b=K9WoZjt0J71ZX6dxEBufPvzb2PZKS/pU84QgKUVmmUKjauVuPtbO6gevkjI91oeiS6TukgwwOhNPM1ZLyjjs/S48u8bouodTaOmvSgol2+U0dBD2WR05Wfn7wtFJTcdPo4lYTSPBmO4HGNs4V9k31yOdGjKeQ8U6j9gFkR6h4LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913165; c=relaxed/simple;
	bh=gTWr4jPMb35j1q02i8QXgX+hyGCCjDLi2DRdAxF5ELA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsZhLRLq7eCwvIkYb70sceADYsJNXzU8LVrgT7x42C2GiCw/arRewqkrkYMyoJniWW7c42b2YtHL5WyLrfg/GgOVAdv6hdOGmXzi662oQAS11aAsvlF0rOmx5wJOgFapfnHjcRvOErPrcEfzS9bTuazGLG5jJyPWYfjOK1RFl5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/vt+FOb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/vt+FOb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613E91F000E9;
	Mon, 13 Jul 2026 03:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783913164;
	bh=eDAPUFlDWN0uYTqvgKRFNx5Kw1crICTqnOJwgfZE7qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L/vt+FObdB6X1fUtewsAjoODXeXCI4H+4yOsWFFncdQkKXIZ8/vG4PjwfwfxTLdia
	 Xvf2ZIiC0kR2pCwpYpqO7Oj3M9D8B/kmzbjsWeS55UcgzovmsRzezpr3Pd+d2Rj9aC
	 UOf9oXA/nMdE1Pf7ZVLRCT3JTW1D6x35g+IWs7A6HDKO7vIYuhNdBPAZr0wtqfoOqz
	 LJyVoX6YghOVdWq5PXwypBh+bKJCAtbxaaQdH3a4zLicpu1s1NDIHt8iFQwn44L/vO
	 LJWQP3NNbn8Xi5skmA1FyrHS45soiIFHDelrP4v3eA66bCOe+a4HcL4SIJ3Ya1+4JS
	 GmRlngE5kNR9w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 10/12] selftests: mptcp: sockopt: get and verify TCP_INQ
Date: Mon, 13 Jul 2026 11:25:34 +0800
Message-ID: <aebafd0483dc9e71650fc1ba2984b36931445276.1783913010.git.tanggeliang@kylinos.cn>
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
index 2540516fccee..eed6e2b548be 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -21,6 +21,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/random.h>
+#include <sys/ioctl.h>
 
 #include <netdb.h>
 #include <netinet/in.h>
@@ -625,10 +626,12 @@ static void connect_one_server(int fd, int unixfd)
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
@@ -666,6 +669,7 @@ static void connect_one_server(int fd, int unixfd)
 	if (proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP)
 		assert(s.mptcpi_rcv_delta == (uint64_t)total);
 	close(fd);
+	close(unixfd);
 }
 
 struct inq_msg {
@@ -696,10 +700,31 @@ static void inq_msg_reset(struct inq_msg *m, size_t iov_len, void *base)
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
+				xerror("TCP_CM_INQ cmsg_len too small: %u",
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
 	ssize_t ret, r, w;
 	struct so_state s;
+	size_t expect_len;
 	struct inq_msg m;
 
 	inq_msg_init(&m, 1);
@@ -710,16 +735,57 @@ static void process_one_client(int fd, int unixfd)
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
@@ -737,6 +803,10 @@ static void process_one_client(int fd, int unixfd)
 	ret = recvmsg(fd, &m.hdr, 0);
 	if (ret != 0)
 		xerror("expected EOF, got %lu", ret);
+	if (inq) {
+		get_tcp_inq(&m.hdr, &tcp_inq);
+		assert(tcp_inq == 1);
+	}
 	r += ret;
 
 	do_getsockopts(&s, fd, r, w);
-- 
2.53.0

