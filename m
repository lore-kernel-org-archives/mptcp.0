Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD09327FD51
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994962; cv=none; b=TxZkI3NEvjTw0VMZrkYbrS3i8BM3RU9qbisIC3I3zTAy8slyrMWlDHrWZpMMcP3gMuVkuBN0ww29wHJmraMpEwSTiM0E/HuoqokMfpqb8j80HiFOjsoZyKt+9zhXZTHf4GXKFyZHRCVMt3m4LXzq5jchzd2L5FJFVeWMCcuyFw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994962; c=relaxed/simple;
	bh=1lToBpP4v6Pt+zkWkiaD8y3VY/ItDN2sjMSY7TyyC1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0LWLLl1UiLDmtUCwFTSbnddHD+Pe5yv7aCrpEzcyET0BVCb5b0jxMQ0Y2iguGe6mvcGcBZbQ8vz3k6ARwSOyZ2nGBmG4V5YwomFygjcl6F4DNgY3CcdW2wOJ5PL0mxqgYMiMPvYLBjzIw0yrhL0JdghnBdI7a9saPBWF/UXQGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bExDVOMN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bExDVOMN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB8F1F00A3A;
	Tue, 14 Jul 2026 02:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783994961;
	bh=YN8mkl9xwkJthpi3jXgkzEDo9ltUOsgPjbcsf0TA8PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bExDVOMN7jbciZsIwtuw6CpvHEsBgnNf3VyYiz+30P1RqXoZ7ax+rLjadYYDKjHKj
	 VHGqB0zFhdBEW99HMPobYRM1QFtXFEwJhPWrthOL8JQjrxNsmFIQOnR22ET426FDjM
	 lhiTiPbAVn26PcM42EAoVNMrFi4ObTjHhCFnPPBHDQwJZXTbEiq4+88gTXxd02DdI7
	 Tjbwbqqy7uaHDh+y4lQquasPDftS+9A4OVPzMcyLPOz0zgs0tmo9znbn2w9nyVsvcv
	 J4xFj3o7WMg4hmESeFDE+l+84ZC4OU4zsFxLZ6zpbYHaGwO2m2wUmaDGmeunYM1rqj
	 iWRIhxBUC5RDg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 09/13] selftests: mptcp: sockopt: use recvmsg instead of read
Date: Tue, 14 Jul 2026 10:08:54 +0800
Message-ID: <d4299c7af784b68aaac535c3cb190675b7133f51.1783994494.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783994494.git.tanggeliang@kylinos.cn>
References: <cover.1783994494.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Replace read() with recvmsg() in process_one_client() to enable control
message (CMSG) handling. The original read(fd, buf, sizeof(buf)) is split
into two recvmsg() calls: the first reads exactly one byte, and the second
reads the remaining bytes. This allows the code to access CMSG data for
each received segment, facilitating the upcoming TCP_INQ validation.

Introduce inq_msg_init() and inq_msg_reset() helpers to manage the
struct inq_msg control buffer and iovec, enabling reuse of the same
msghdr across multiple recvmsg() calls with different payload buffers.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 48 +++++++++++++++++--
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index e4fc9f12f164..cc1d45e85fb2 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -668,36 +668,74 @@ static void connect_one_server(int fd, int unixfd)
 	close(fd);
 }
 
+struct inq_msg {
+	char buf[4096];
+	union {
+		struct cmsghdr cmsg;
+		char msg_buf[4096];
+	} control;
+	struct iovec iov;
+	struct msghdr hdr;
+};
+
+static void inq_msg_init(struct inq_msg *m, size_t iov_len)
+{
+	memset(m, 0, sizeof(*m));
+	m->iov.iov_base = m->buf;
+	m->iov.iov_len = iov_len;
+	m->hdr.msg_iov = &m->iov;
+	m->hdr.msg_iovlen = 1;
+	m->hdr.msg_control = m->control.msg_buf;
+	m->hdr.msg_controllen = sizeof(m->control.msg_buf);
+}
+
+static void inq_msg_reset(struct inq_msg *m, size_t iov_len, void *base)
+{
+	m->iov.iov_base = base;
+	m->iov.iov_len = iov_len;
+	m->hdr.msg_controllen = sizeof(m->control.msg_buf);
+}
+
 static void process_one_client(int fd, int unixfd)
 {
 	struct so_state s;
-	char buf[4096];
+	struct inq_msg m;
 	size_t r, w;
 	ssize_t ret;
 
+	inq_msg_init(&m, 1);
+
 	memset(&s, 0, sizeof(s));
 	do_getsockopts(&s, fd, 0, 0);
 
 	ret = write(unixfd, "xmit", 4);
 	assert(ret == 4);
 
-	ret = read(fd, buf, sizeof(buf));
+	/* read one byte */
+	ret = recvmsg(fd, &m.hdr, 0);
 	if (ret < 0)
-		die_perror("read");
+		die_perror("recvmsg");
 	r = ret;
 
+	inq_msg_reset(&m, sizeof(m.buf) - 1, m.buf + 1);
+	ret = recvmsg(fd, &m.hdr, 0);
+	if (ret < 0)
+		die_perror("recvmsg");
+	r += ret;
+
 	assert(s.mptcpi_rcv_delta <= (uint64_t)r);
 
 	if (s.tcpi_rcv_delta)
 		assert(s.tcpi_rcv_delta == (uint64_t)r);
 
-	ret = write(fd, buf, r);
+	ret = write(fd, m.buf, r);
 	if (ret < 0)
 		die_perror("write");
 	w = ret;
 
 	/* wait for hangup */
-	ret = read(fd, buf, 1);
+	inq_msg_reset(&m, 1, m.buf);
+	ret = recvmsg(fd, &m.hdr, 0);
 	if (ret != 0)
 		xerror("expected EOF, got %lu", ret);
 	r += ret;
-- 
2.53.0

