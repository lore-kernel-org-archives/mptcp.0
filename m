Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B54F3955FF
	for <mptcp@lists.linux.dev>; Fri, 10 Jul 2026 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673977; cv=none; b=QRFkdfM8WzXHUCS39+nydCdB/fpLgaLXGcOShewsyLX+oeIBhqh+V1gzq7n5JfwbYcemRbGRAHGS+TipRe93SErWrP3byXR+iSyEpNPQ18obaBBPTN0zZyTUiNj97lLjAybbVLfhOHGudUn6iI4oGFpoqrlas4HZ1aIjsGa5/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673977; c=relaxed/simple;
	bh=nbu9tbCCvcdWYQakc4RgLYYU/XEwbCUUQ2XVlkUd1ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r45aKwMNfcESdS5OlccOvYQqX9J4RrglhmmbCwwdxz/cjEzJLl5QowTRb9anLmM9HaUWjsechpyLdLCt2xIJgEZvQsW0xQCWOnwU9WaccJVNcWc6H3H4NPRm35zTz6TRZ1hxycuLWNi3Glqf5rsWKgUdQe6OJz4wJikdlQynmns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ev5cKVoB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ev5cKVoB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD7D1F000E9;
	Fri, 10 Jul 2026 08:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783673976;
	bh=vCL+PChNIQgknZgQo9Zf8mMHqnA7rRQocx3VDAipCDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ev5cKVoBDX+iV3LTdTl+jkyRMz3UcljoCfF7zJHLDT4fQkmVxE+g20mx/K08zPr3k
	 JEO61HMcucinBDgVkEvktR7Py6NaFEIDFiYfxBZYY9SWHdWB1/1JlhCcEeFVoyk0EL
	 oirKrqyaZiThDuQvNrDry2C7Zbt7QExITCmDEfOAujf+MirDLzKktlkPSxeIAyJ+u1
	 eb/eycb9Y+rT0Im7ZnZsXBUwwZlnjLkdOZBwv2Ed0RbjhVbbZcd9sQWwIRdg+ZFsr0
	 G2suvMuod1XAtmV+GwneD3yESi3uSfoqSDiVos5elFsUjf4SpkOFX7IAvgcmIyn/0d
	 nsNG2zCbz3OVA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 08/10] selftests: mptcp: sockopt: use recvmsg instead of read
Date: Fri, 10 Jul 2026 16:59:11 +0800
Message-ID: <d5ea61b6a1db44bcf8fee2016338db0dcdead1de.1783673158.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783673158.git.tanggeliang@kylinos.cn>
References: <cover.1783673158.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/mptcp_sockopt.c       | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index bc2cb3db3264..53852b44cfeb 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -827,10 +827,21 @@ static size_t client_huge_transfer(int fd, int unixfd)
 static void process_one_client(int fd, int unixfd)
 {
 	ssize_t ret, ret2, ret3;
+	char msg_buf[4096];
 	struct so_state s;
 	size_t expect_len;
 	char buf[4096];
 	size_t r = 0;
+	struct iovec iov = {
+		.iov_base = buf,
+		.iov_len = 1,
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = msg_buf,
+		.msg_controllen = sizeof(msg_buf),
+	};
 
 	memset(&s, 0, sizeof(s));
 	do_getsockopts(&s, fd, 0, 0);
@@ -862,9 +873,20 @@ static void process_one_client(int fd, int unixfd)
 		nanosleep(&req, NULL);
 	}
 
-	ret = read(fd, buf, sizeof(buf));
+	/* read one byte */
+	ret = recvmsg(fd, &msg, 0);
+	if (ret < 0)
+		die_perror("recvmsg");
+
+	iov.iov_base = buf + 1;
+	iov.iov_len = sizeof(buf) - 1;
+	msg.msg_controllen = sizeof(msg_buf);
+	ret = recvmsg(fd, &msg, 0);
 	if (ret < 0)
-		die_perror("read");
+		die_perror("recvmsg");
+
+	/* add the first byte */
+	ret += 1;
 
 	assert(s.mptcpi_rcv_delta <= (uint64_t)ret);
 
@@ -879,7 +901,9 @@ static void process_one_client(int fd, int unixfd)
 		r = client_huge_transfer(fd, unixfd);
 
 	/* wait for hangup */
-	ret3 = read(fd, buf, 1);
+	iov.iov_len = 1;
+	msg.msg_controllen = sizeof(msg_buf);
+	ret3 = recvmsg(fd, &msg, 0);
 	if (ret3 != 0)
 		xerror("expected EOF, got %lu", ret3);
 
-- 
2.53.0

