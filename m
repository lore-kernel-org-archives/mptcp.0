Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE237248881
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 02:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083771; cv=none; b=JPV3eyM/C0yA2AZ8llcjAkX1tb+5qGRbD97E5ysmixUPScvX2zSu2kBsLXyZIEa75Upq8JvsfY5HuLjYEd4AIcsz34TSinJgQ+FLjw5D9D1AJhWkqBzvkh6pddO36HjjCmvd2gbm2uOTM6I5ledqNZuYWw/kdujI4O8G5JeMvow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083771; c=relaxed/simple;
	bh=AX7BHdh9dBxWm0pnakI3YetFhskIkEW+gLObRFgcNBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfO7Y0tT44MLnn8IxYEUEJH/EhV7CuxsRlk6wyiruJL9zTuOiwdXVTMTuu2gziroSDiFBBjuGg7vlN+9kwqcc/b1VTh10TRrOquJvjeGWHnNnuX3JF6mGZk0amx5X93/TLJjtv0l8hGe/h25v5x4sD6cJwytm0pMzPdbukY3UWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuddrFRu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuddrFRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECC31F000E9;
	Wed, 15 Jul 2026 02:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083770;
	bh=DPIfU3vZ6EcSD1hC/mmvo+8m/H4Ktd9KY8DvULUJMgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WuddrFRustpC78LzqIg4FLhFtrFuwYpTo5etbhw5Ktk58mH7RJliB52zmdoepoR6f
	 dKJormiTi49e1IdnqsJGSdDMkLu0U3RoBH5Wwn6QixEmSCMlL3cnhteC+P53xmFukI
	 tqPcnnKZks/CPfVoD+/l83RnBtc6JVS8YUIbfEN8WiPlVuxnCeJwvvEw06q20O5+Yj
	 p+j2xQ3lFv9JDQ5jmTuoGJD5saBnn3b58fZxYf9IEuobJrJBJan8679YZv40vB9v4Q
	 XJvXyODylmfo8qRNCwGT0tQMwMQo1tjcf4Mr41j32LfpQKV+DZ88SkefFlTwn223ap
	 eIwdHYlbIMRTg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 08/11] selftests: mptcp: sockopt: use recvmsg instead of read
Date: Wed, 15 Jul 2026 10:48:54 +0800
Message-ID: <1e33b5a8307ceeb0660f30b166ff0e29c7d9087d.1784082850.git.tanggeliang@kylinos.cn>
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
index 0d1426c11581..87a7090a68b4 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -677,36 +677,74 @@ static void check_stat_equal(const char *name, uint64_t actual,
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

