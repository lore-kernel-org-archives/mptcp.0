Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F1D375F76
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381349; cv=none; b=X2a2vC0gA93gRiPt5uQ6ZqQai7dk9N55vJMnqPnbWnn4D7Eno2Q8nilZM1GPahgikkUR76hGm1S6Nk+fktSWf6nsZCnNRbG/DRah+TJWCI22jAUPFIU0UroHWSYqfuCciSSNlyCLU80/A/WWFbZuNoJdSTuzAfJj/BryUZmzGAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381349; c=relaxed/simple;
	bh=Rtdz+pIuG8tLG64Ix1wmg3JNI21fkwDXRQ3e/6WPBZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kfqn1jVaXvXSVmFRms5TNK6gXqB6prp/Bn9u4UTqAu/mkNNs7GfZWUcO/WebNPQxGLTkxhjUlmRCa+5u+wF8Pu5kpn/gXbIsXeXUijRQ744AREX45jF3oYSKWabyUUBoRyGEg6yVf9u75ftJ4Vhqn+bIu75G/hE7xO9zrfuxA8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxO7ok46; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxO7ok46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E121F00A3A;
	Thu, 30 Jul 2026 03:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785381348;
	bh=zDuT2ioUuy13SG+74rWKZTH70mpMi1Quq/oIg+C7M9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CxO7ok46ka+e/Gp2vu+Fn/XpSmqHF/FoOZmMWGbL+tIiTONn1/ptBGSz+lgEWZk3J
	 FHsPWugrdPtEgiRJz9dmmCr/+vPXRCZlKO73K09SvH3XXKiw7j8lVWO1fiq8bYI5QR
	 AWbit1VJ5B3zN4pKCN8VSnWZzDHPNmb2pj7bUsjIeZPV65zJqG3v85T4ZnAyNbxkRj
	 MEJ5ETjt6wTpO90VQmdsh/iWFuEelcSHxi6RdUj74YBpAVOQwCjngq34yWZYv8zuUC
	 8H0iTNq5V/RkjIqSR4e73XD7t2Ds8cUWlLciZbvElnkHc2GOjt4XYntP9uMWLAWgN3
	 +hEG89MOouK1Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 09/12] selftests: mptcp: sockopt: use recvmsg instead of read
Date: Thu, 30 Jul 2026 11:15:20 +0800
Message-ID: <9e7fcfd11333a4faa521fed797c3328f92f4bcd9.1785380422.git.tanggeliang@kylinos.cn>
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
index e404aecc7115..080f9d9e34d5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -698,36 +698,74 @@ static void check_stat_equal(const char *name, uint64_t actual,
 	       name, actual, expected, (int64_t)(actual - expected));
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
 	ssize_t ret;
 	size_t r, w;
 
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
 		xerror("expected EOF, got %zd", ret);
 	r += ret;
-- 
2.53.0

