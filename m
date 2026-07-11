Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B95255F2C
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 03:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783741486; cv=none; b=aKVZksJRGi7jGo3LSE9OjrBD6h5dCquGrLtmQfpm85xBFrX6goSy8mAuAkr4hwHOVBF4P1rOu8HQX/6W1o72qB31Cp0iIz1N19g1kUVf1y3VeH4YzUpIFPJm+jtkRcTH9fV18F9Hj4g0d7NhVhIA3+6vI9iXtgI2/ETDRA7iBAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783741486; c=relaxed/simple;
	bh=BX1tzfO84ZBU0Fe3B+qadOtzgKwQAxSAwE2eo55NA+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EaMGBFTTPDjK0P7dx6zkPRLgymRlXkhiQvfSBWa3M983cdJ0m/wtMkVXsIdW4ofr6xPIoebcz/QsbfhBtHOUPAcikaf4F8/eHmX1ICB6wp2fVaQ7Wa0ZX4GH2YS+RhB+/3sqGuDU4JO7ds97cX2yVCNrcHlb6bCCaemWp7ustM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmrI3BJz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmrI3BJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B851F000E9;
	Sat, 11 Jul 2026 03:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783741484;
	bh=BwqbJMc8g8KhJPX30BxmNuq1FvOXGCntO+bZkDbL2xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KmrI3BJzElAx7ViMTQXl+ljBDPio8MQtybwXX/RRAeS5O2jS64C2vMqxuIiCux+1V
	 WBrtLVK/8nzuqvu0SqPYkbpgS6SxlbOsoG4Sbf76jgLmJRJpvEKEHxABvD1e9gcgdG
	 FWGV5hMWnSx7mntf8A+wxinAwWANtIvgMotiejgEU/fY03Zfb0MscXIS9GazXDWS1E
	 uypR8RS3cgEK7IAydkoUtekipGV/RMEwUMxuF8y0oyjln5ad1dZBJze5b1d6rLZQ7I
	 TVtdr6pvsL9moJ+Cmkp0fYHnrfDSnqoXzuQFO6Et1UTAFgOoakztRWnnxkb78qRrRe
	 rzWHPLjCg1Emg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 12/14] selftests: mptcp: sockopt: use recvmsg instead of read
Date: Sat, 11 Jul 2026 11:43:40 +0800
Message-ID: <dd66b711872ae4bc0102f52fcd8a7dceb084a803.1783740443.git.tanggeliang@kylinos.cn>
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

Replace read() with recvmsg() in process_one_client() to enable control
message (CMSG) handling. The original read(fd, buf, sizeof(buf)) is split
into two recvmsg() calls: the first reads exactly one byte, and the second
reads the remaining bytes. This allows the code to access CMSG data for
each received segment, facilitating the upcoming TCP_INQ validation.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 1a5a7f25ae8b..1ae63434d5f4 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -849,7 +849,9 @@ static void process_one_client(int fd, int unixfd)
 	ssize_t ret, r, w;
 	struct so_state s;
 	size_t expect_len;
-	char buf[4096];
+	struct inq_msg m;
+
+	inq_msg_init(&m, 1);
 
 	memset(&s, 0, sizeof(s));
 	do_getsockopts(&s, fd, 0, 0);
@@ -860,7 +862,7 @@ static void process_one_client(int fd, int unixfd)
 	ret = read(unixfd, &expect_len, sizeof(expect_len));
 	assert(ret == (ssize_t)sizeof(expect_len));
 
-	if (expect_len > sizeof(buf))
+	if (expect_len > sizeof(m.buf))
 		xerror("expect len %zu exceeds buffer size", expect_len);
 
 	for (;;) {
@@ -881,17 +883,24 @@ static void process_one_client(int fd, int unixfd)
 		nanosleep(&req, NULL);
 	}
 
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
 	assert(s.mptcpi_rcv_delta <= (uint64_t)ret);
 
 	if (s.tcpi_rcv_delta)
 		assert(s.tcpi_rcv_delta == (uint64_t)ret);
 
-	ret = write(fd, buf, r);
+	ret = write(fd, m.buf, r);
 	if (ret < 0)
 		die_perror("write");
 	w = ret;
@@ -900,7 +909,8 @@ static void process_one_client(int fd, int unixfd)
 		r += client_huge_transfer(fd, unixfd);
 
 	/* wait for hangup */
-	ret = read(fd, buf, 1);
+	inq_msg_reset(&m, 1, m.buf);
+	ret = recvmsg(fd, &m.hdr, 0);
 	if (ret != 0)
 		xerror("expected EOF, got %lu", ret);
 	r += ret;
-- 
2.53.0

