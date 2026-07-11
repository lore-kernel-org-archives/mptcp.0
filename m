Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825E8273D6D
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 03:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783741483; cv=none; b=Gg8U3k0AI8E1FZfGv/o6bxv7BA3x5tq7dKlwuUjPI2Pxk4sXr9V7fa377Ixsn2et/fguOZvnfhM9Yu0qS39xG6qahVkQzost4elqwEQVKHYRrcj78Xs0/r1bF6XfLsp6RBQBeQwqvwiN/Y2IWGBS5o8O2V9wpRDxBTaJrOIq6Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783741483; c=relaxed/simple;
	bh=x1CbtPVwQguICKzAUnm76U7+tE2g9/Uv9nLEOdW2V7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nO9WYsBfrJUHzwayarrDmukI+WDnVS3i7xZPj12UF/pHaTwDOyAqj5X5Us6Ey6XoXphL9PiCCl/TWFmU7KX0R4Lx/UM2mACGr5aVLT5FC/EpAA5w29gJHNii1pL8Jpe3gJtK8gpDu0GfxPnSPk0AWIN50ASObzOKsxcOXM75Jww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2o/V70T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2o/V70T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EDB1F000E9;
	Sat, 11 Jul 2026 03:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783741482;
	bh=oUxSFupqP1UC4EwCPJdtIgzg3BH7U4VHifdRcePvlks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M2o/V70TcLqeds82E7j3nQG7RKF7OLwLTArMzgH/jsPMdZrSxWzU9agT6VSGkfacl
	 7hODaHK2uYi/N492OwQ2Em97V95O0sqnrL3EVONq36iZhqsWY1KcKvKY8wTeHOGAcW
	 rV9K8oghALLStbEWpZVzCWVYIMBE1fUpUF5wjuz60DUcmp5ps00+Q5hEhubapkNaWQ
	 5pHesYV0RgdBqxR/w3VBg68Afj04ZkFMu+17VGnQG/tZWdnkHE3pOqBXRw5VUwz4W6
	 Kv/0lKjWvRHLZe3dxtwBDygUpWYZ+0Rey+0Xg0hmpZcf4boPcmLJUyTWEyCdtRFM6e
	 jWh3Itzb4a8Lw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 10/14] selftests: mptcp: sockopt: add huge data transfer tests
Date: Sat, 11 Jul 2026 11:43:38 +0800
Message-ID: <ed8d5bcef2a2ba92c55ae23d821197c729f1c6ef.1783740443.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783740443.git.tanggeliang@kylinos.cn>
References: <cover.1783740443.git.tanggeliang@kylinos.cn>
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

These codes are from mptcp_inq.c, but here they have been placed into
two separate functions.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 6bccb206181f..aebf22337b8c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -598,6 +598,55 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 		do_getsockopt_mptcp_full_info(s, fd);
 }
 
+static void server_huge_transfer(int fd, int unixfd, size_t len)
+{
+	char buf[4096], buf2[4];
+	size_t i, total;
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
+
+	ret = write(unixfd, &total, sizeof(total));
+	assert(ret == (ssize_t)sizeof(total));
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
+	ret = write(fd, buf, 1);
+	assert(ret == 1);
+	ret = write(unixfd, "closed", 6);
+	assert(ret == 6);
+}
+
 static void connect_one_server(int fd, int unixfd)
 {
 	char buf[4096], buf2[4096];
@@ -667,10 +716,93 @@ static void connect_one_server(int fd, int unixfd)
 
 	if (proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP)
 		assert(s.mptcpi_rcv_delta == (uint64_t)total);
+
+	if (inq)
+		server_huge_transfer(fd, unixfd, len);
+
 	close(fd);
 	close(unixfd);
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
+static size_t client_huge_transfer(int fd, int unixfd)
+{
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
+	return tot + 1;
+}
+
 static void process_one_client(int fd, int unixfd)
 {
 	ssize_t ret, r, w;
@@ -723,6 +855,9 @@ static void process_one_client(int fd, int unixfd)
 		die_perror("write");
 	w = ret;
 
+	if (inq)
+		r += client_huge_transfer(fd, unixfd);
+
 	/* wait for hangup */
 	ret = read(fd, buf, 1);
 	if (ret != 0)
-- 
2.53.0

