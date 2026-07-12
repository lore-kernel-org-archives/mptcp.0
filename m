Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0D5374182
	for <mptcp@lists.linux.dev>; Sun, 12 Jul 2026 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783850107; cv=none; b=hFtoGtK+s/CoKxGBFpl52WNj7xM1y/XSNCwoa2gGgJfraOURY2C0mzMSs+kD/52DCTNOYK9EGBZePJoxqEnJphj7C+m3bsGqMxpKDDpO8h5qtvGHL1yvDPlnBgX1pQjf7cFU0Vh5Kk8y5h+FyiI2VBbet097lDPwYThx/xE77Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783850107; c=relaxed/simple;
	bh=qtI8Ow6B6xaCaiUpMuYw67eeEAK4bxfXYA2K6UOwwYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=og8403oO08Vu1slVxebqOoPNWmRV2nPNXA6IKUpMIGQWApXxH/Jlt4HjVzk3cZSEfINTac+knL4cpSkNp9vYR/vObEvYUWM95nkLOxCsvlFXNdRhnv687IyiKIOfr339LxtN2NjwppKkZPgkquuH0pEVFeBaf5YC4UKKV0QJIyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecDGs1Ap; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecDGs1Ap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CF61F00A3A;
	Sun, 12 Jul 2026 09:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783850106;
	bh=5yMh8KCFOB0Gv/PLBvuEBWFVkNQEaPys3r/p/W76QeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ecDGs1ApcigI7JWJbHnQQz+XvuiJYVfvqR5qhKECbm4+jNPIF1rcRh/1wHhb/diFE
	 loc9nv84pRehUYLnIGrezB0tfB7TbYuGH4uSO7k5rtX7HuiB2GEjkfNgpEackN/XlV
	 2qwWF7xWZe5OrAvBipNJGTCxcl2JySP/DJx6owjsKwra509fxGxHexuu0E4P5dzITJ
	 Uz3X/8Q6aPU5HjxXBcmyeuu6Y4Xme+fcoyRC5DfxXZ/i/aiWAmnGzwsLRhYCHHVNHy
	 D2l1jzMGkKMlvSFYoYJZRIQ9ADX3deIM4cIPWRs8huQuWu1sxEyUEyVWkWPSPwE4pA
	 psQjl8op6XImw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 13/15] selftests: mptcp: sockopt: use recvmsg instead of read
Date: Sun, 12 Jul 2026 17:54:19 +0800
Message-ID: <5ea792547b1e7e39b1a2115d9761fb6281582d13.1783849522.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783849522.git.tanggeliang@kylinos.cn>
References: <cover.1783849522.git.tanggeliang@kylinos.cn>
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
index dbf13ef02298..09136b34468c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -850,7 +850,9 @@ static void process_one_client(int fd, int unixfd)
 	ssize_t ret, r, w;
 	struct so_state s;
 	size_t expect_len;
-	char buf[4096];
+	struct inq_msg m;
+
+	inq_msg_init(&m, 1);
 
 	memset(&s, 0, sizeof(s));
 	do_getsockopts(&s, fd, 0, 0);
@@ -861,7 +863,7 @@ static void process_one_client(int fd, int unixfd)
 	ret = read(unixfd, &expect_len, sizeof(expect_len));
 	assert(ret == (ssize_t)sizeof(expect_len));
 
-	if (expect_len > sizeof(buf))
+	if (expect_len > sizeof(m.buf))
 		xerror("expect len %zu exceeds buffer size", expect_len);
 
 	for (;;) {
@@ -882,17 +884,24 @@ static void process_one_client(int fd, int unixfd)
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
 	assert(s.mptcpi_rcv_delta <= (uint64_t)r);
 
 	if (s.tcpi_rcv_delta)
 		assert(s.tcpi_rcv_delta == (uint64_t)r);
 
-	ret = write(fd, buf, r);
+	ret = write(fd, m.buf, r);
 	if (ret < 0)
 		die_perror("write");
 	w = ret;
@@ -901,7 +910,8 @@ static void process_one_client(int fd, int unixfd)
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

