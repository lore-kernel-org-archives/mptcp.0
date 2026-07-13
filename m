Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0B5314A60
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913162; cv=none; b=muJCUFtTXyW+Vcjvsz03+gd6dzQedEsguK8Nhe1jotfjv6D202mxvsfJ9kZrRhqlmXGpk3Q/oCIM5o3SKcUcM/nyQsga20m5U8dDrcc0NAbO+/qfWPSjcKp7MAxKImylY47sqz6SpfEsGcB2kxSu1XbGkP8T5WBFPStNbRusFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913162; c=relaxed/simple;
	bh=1VfAFgKbH3/Em9MBox/+sypeIvwiCtg9G3Cdl/kDSJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBZXSwJS3PZaR5dV3rgpEFZa8UwWvr2Ygmw73+XvtXxC4sBQEUC6vzpziyaJu5GaGPrjLrxV9Yw2SbS/voGw4fhdzWBfraO48DIaIkJl81/XFGql80eAWJfRQkhm3Uk4ACgP0Ubl03J0C7Yy2+dV3Rg5jh2MnhHiDoxjOlFvLL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5lrp65r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5lrp65r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1822D1F000E9;
	Mon, 13 Jul 2026 03:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783913161;
	bh=yZHv4R7YE/DBCm+C8WkqLRRdsNTz/0MTVT3TiWForTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S5lrp65rVqnQ9LLbUpXKkQVnrcKnP95NMEJq4ss+v/Q1UAq/StNSGynn+lQFSY5I+
	 lRZ7SCeGANPQxEMQ77YaOPkpATfglwKFf7XdHws5aKaebuoaZ8+1J3lbhg4nXliZGI
	 iq+o7LdpmLzvFcc/F+7nokKrEV6nf6AsF+iEjrg4HtRRJSXnmOjE1KorqxeYTTgWBN
	 mryikUxT2ufBQvTZ4i/DeHQ4YOQgmSOxCzuGnvN7eWIjZ/y6756SYEc7NCRhqRHjV1
	 baplHuvBS04F6VJ88ELjYHCzX2sm/AzkPbwSRyzGXOSTbsbC2QBqHZ7t1S2lBpMv5y
	 iZ5UaN88wMC4g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 08/12] selftests: mptcp: sockopt: use recvmsg instead of read
Date: Mon, 13 Jul 2026 11:25:32 +0800
Message-ID: <a295afb7dbf74aa175f5f07c9da7489c01c18f02.1783913010.git.tanggeliang@kylinos.cn>
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
index c7605ce5b9e1..9a8b60512f0b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -668,11 +668,41 @@ static void connect_one_server(int fd, int unixfd)
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
 	ssize_t ret, r, w;
 	struct so_state s;
-	char buf[4096];
+	struct inq_msg m;
+
+	inq_msg_init(&m, 1);
 
 	memset(&s, 0, sizeof(s));
 	do_getsockopts(&s, fd, 0, 0);
@@ -680,23 +710,31 @@ static void process_one_client(int fd, int unixfd)
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

