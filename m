Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2BE248881
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083773; cv=none; b=DMSgqwOgR5V/WycNDlJvAo7NefRvjDHyXRtEnj3C2fvT7neLw0oiORV9HqBidtDv/Hbh3o7iz8xnwEinI5DoXhTxGaOL+GeUnKprJz/odzaQUnWqxG4LBu0J6fcn1Ekc3GJv6oZ2W3oSEK6kY6a9jWeGqyq9zIBuRfBcrcuoMyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083773; c=relaxed/simple;
	bh=ApM38Q7JNGeM9ba67/VBMno8H+btiPtGItLLEDvFQ+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFidroYLzIUzynLmGNFB7KPvJ8URicuUDAKULhvswqy3lOupefLygT8g3L6v9UOH9YuD1MdDpQI9I59oKpVgkfa5RR13Ou+chjlBvhV55LPzJqSNn3btcKAU7Pz7kIH5s+4C5Z8EoYIHiri5uyu3F+QBXthECDIEPErEA5tEn64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6AShgm7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6AShgm7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48C71F00A3A;
	Wed, 15 Jul 2026 02:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083771;
	bh=0gZMfqUro0MIUzXwTIQ/Nv0JJ/zuMxz5sCQ08jETAlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N6AShgm78DD5C8hLinmSuSr2knvGOgXSSZHs7wHc9Y4QAe/fqupuNsM5LteeBi8DJ
	 s8kOrVLcVeDQGfT9qbo+0dD+UoQo8ujWDa3zJExLRPvxP3hueVXfy5RnpyoaXqJyjG
	 Apcfsgneh/5XRD6ogvP7keSeoEIYSsqI76ccMPii4q+TTc82NiayxXxe6BhwKa08La
	 uK2EWjD25AXfcUQv95F7fAOtSJI5gZH/yPWCGdsYePcIPTk3ZcXf/hYc7c7DVrT2gN
	 l7eThiqDbWQV1dB2nzVf1G46+FkBzrHodw5B6/qD/8E40j95ZvZH8vRCp1Czkxods5
	 QGdflP1CML21A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 09/11] selftests: mptcp: sockopt: get and verify TCP_INQ
Date: Wed, 15 Jul 2026 10:48:55 +0800
Message-ID: <a53d078365dbe02d534a61eac491fe32618aa657.1784082850.git.tanggeliang@kylinos.cn>
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
index 87a7090a68b4..c754e6cdaa40 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -20,6 +20,7 @@
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/ioctl.h>
 
 #include <netdb.h>
 #include <netinet/in.h>
@@ -624,10 +625,12 @@ static void connect_one_server(int fd, int unixfd)
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
@@ -665,6 +668,7 @@ static void connect_one_server(int fd, int unixfd)
 	if (proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP)
 		assert(s.mptcpi_rcv_delta == (uint64_t)total);
 	close(fd);
+	close(unixfd);
 }
 
 static void check_stat_equal(const char *name, uint64_t actual,
@@ -705,9 +709,30 @@ static void inq_msg_reset(struct inq_msg *m, size_t iov_len, void *base)
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
@@ -720,16 +745,57 @@ static void process_one_client(int fd, int unixfd)
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
@@ -747,6 +813,10 @@ static void process_one_client(int fd, int unixfd)
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

