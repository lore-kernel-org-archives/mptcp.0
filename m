Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0833CAE8F
	for <mptcp@lists.linux.dev>; Fri, 10 Jul 2026 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673970; cv=none; b=HnRnt0Y9elF04fgPWzniGEkOBhgJtpI0xktoHxuh/6OeNeuyKYbPgu3E8BexXcitU7SmNXby2FAzHCPyBKECAfCV0xMCxTvMJlmSZRGfuTL/KavLXFrBvI/OrrEmgIg0Har8M0/CU2EaCkHtxPfX9Rv5MGUGtVPgrblxW9Us2lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673970; c=relaxed/simple;
	bh=y+O4hutA1LCu76Wt2UuZCt+qeKP3z1WTn+2ddWbDVIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxxFzxCzCXJM7pa74YBk9T39lzIMRXi1H2FGPkQt3Ax+q4ttFtH7zSYlqeI6lfJT1ADa8gqtiIxbSuaY6MxeB1rTDFXWQAexQfvrdXSIbIDqL4BvkwrQqgAPCsR5z3KY6OaEDlDvvukfsWEqHAgqS65xXU8t1o9Gvh0pwXswlOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIrTNet+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIrTNet+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798711F000E9;
	Fri, 10 Jul 2026 08:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783673969;
	bh=XT2Fm68Nn9UY4ryLYaSauvHNaV5yHDRBI/NjPuJokbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZIrTNet+WvWmzfYMwjhYqP+XkKhm2MFqwj32ioVA7vxzAoN/7kOtC9qFL8TQFwtIM
	 u20HNZblxn8af798JLLmJ3wGk2P6IBNk3I9jZ97Tv/JuKEbhJJKT/yqd+mdqx6CXKe
	 QmBa2zHSfPOHJ5XhQ8L+2cwk7uDZ2KARXjM3g4fGAUdBm9n5OqLElLRbFvkBC5vohf
	 14oA5cdff4Fi+v2QhxYy0DSVRVivW5/ibikUhYdxzPyJUC00gwK6EmQxRHr6f7lUPQ
	 mvPELhHjFF84QCFUXVD7b2Ns40LO5QT7iRo1tIvAS99mCR+VCEMjQUCLJGHhpFcJGZ
	 Yy1PnIAd01vxg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 04/10] selftests: mptcp: sockopt: pass echo length over unixfd
Date: Fri, 10 Jul 2026 16:59:07 +0800
Message-ID: <8b8e98c1b8727ba6e88d68a770f3cb8ac5f65be2.1783673158.git.tanggeliang@kylinos.cn>
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

Pass 'len' from the client to the server over the unixfd control channel so
that the client knows the server's payload size in advance for the FIONREAD
loop and TCP_CM_INQ validation in subsequent patches.

Also keep the unixfd open for the second write by moving 'close(unixfd)' to
the end of connect_one_server().

Note: Additionally, silence a -Wstringop-overflow false positive by using
'len - total' as the read size, which lets GCC prove the destination is
large enough.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index fdc7500b79b3..5b6408f92fd6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -622,10 +622,12 @@ static void connect_one_server(int fd, int unixfd)
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
@@ -635,7 +637,7 @@ static void connect_one_server(int fd, int unixfd)
 
 	total = 0;
 	do {
-		ret = read(fd, buf2 + total, sizeof(buf2) - total);
+		ret = read(fd, buf2 + total, len - total);
 		if (ret < 0)
 			die_perror("read");
 		if (ret == 0) {
@@ -663,12 +665,14 @@ static void connect_one_server(int fd, int unixfd)
 	if (proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP)
 		assert(s.mptcpi_rcv_delta == (uint64_t)total);
 	close(fd);
+	close(unixfd);
 }
 
 static void process_one_client(int fd, int unixfd)
 {
 	ssize_t ret, ret2, ret3;
 	struct so_state s;
+	size_t expect_len;
 	char buf[4096];
 
 	memset(&s, 0, sizeof(s));
@@ -677,6 +681,12 @@ static void process_one_client(int fd, int unixfd)
 	ret = write(unixfd, "xmit", 4);
 	assert(ret == 4);
 
+	ret = read(unixfd, &expect_len, sizeof(expect_len));
+	assert(ret == (ssize_t)sizeof(expect_len));
+
+	if (expect_len > sizeof(buf))
+		xerror("expect len %zu exceeds buffer size", expect_len);
+
 	ret = read(fd, buf, sizeof(buf));
 	if (ret < 0)
 		die_perror("read");
-- 
2.53.0

