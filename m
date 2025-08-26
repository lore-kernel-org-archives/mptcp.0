Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBC52D6625
	for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200596; cv=none; b=DZsjJWGc8ume7wCKwdvXOqzDot4ZFCyQPkC647sOnqJJ3xGRJEyL/EqOMuhhBPrmjcrW+yxe8zs+SignCj0JT6Zknw0bqNco8OX1mSwN/DTLDdC0i2LejEPhmO5pNQNxjFAPBY+vQxqYFNahmbAKTDa8HSS4TYgYZv/0PayoRYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200596; c=relaxed/simple;
	bh=9ZQPBMYQn0YNJAGbvgPTRLd+BttN17ECglWS9wogAYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jls5GNYfUGuxMwRLWdRdpfpVx/2qLl+IarJAtxyBvbRpM+Zs7Z5gzMUA583KRZhdj8r8+45JXEiMmRiDN36+J6vFh2Lu3AtEeS46aREL1Dkmrs4cIXLFfYenD9wneeSrJBKyDq4MgB5hMOjyZnFULjkL5YQXAUW82vVxU1QWXA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRgEi+s3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRgEi+s3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD0CC116B1;
	Tue, 26 Aug 2025 09:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200596;
	bh=9ZQPBMYQn0YNJAGbvgPTRLd+BttN17ECglWS9wogAYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRgEi+s3LePDznkM2KimKN6wOhEw+3eWB+LjsICN2dGNKDcc8SCN+LwBkkos9pXdb
	 6rVMKuu/Tsb0YmH91aojAvxV2gbd6zRvMSKJRBut1fmbeZNQC15eTbiN8Yxa+L5Bpc
	 bxHLvgC9k/cd4PVmVdBkPgBchBGfjtOAQw97+ky7QevQGOZaAs0/HLeK7xjoDl9q+W
	 KQv31epIkqRsb31NdNekvcVW0kF5ji2K6LvLcAnqZXjq4CDaPskHkQ0hVJ4TmYKlLV
	 E87WYVt+zTiP3NOXwI3w/9wGSUAL6SaQlCxLypsIDc1upaekafR6/0YJT2UHwWTQSy
	 1CC23cGcRaAww==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 07/14] selftests: mptcp: sockopt: use recvmsg instead of read
Date: Tue, 26 Aug 2025 17:29:31 +0800
Message-ID: <9617a818fb66acbe37d4323b2453cfbcd14b30bf.1756200029.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756200029.git.tanggeliang@kylinos.cn>
References: <cover.1756200029.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Replaces read() with recvmsg() to enable control message (CMSG) handling,
preparing for TCP_INQ support in subsequent patches.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index d69b10d2dbe3..71cb311fcc50 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -665,8 +665,19 @@ static void connect_one_server(int fd, int unixfd)
 static void process_one_client(int fd, int unixfd)
 {
 	ssize_t ret, ret2, ret3;
+	char msg_buf[4096];
 	struct so_state s;
 	char buf[4096];
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
@@ -674,9 +685,10 @@ static void process_one_client(int fd, int unixfd)
 	ret = write(unixfd, "xmit", 4);
 	assert(ret == 4);
 
-	ret = read(fd, buf, sizeof(buf));
+	iov.iov_len = sizeof(buf);
+	ret = recvmsg(fd, &msg, 0);
 	if (ret < 0)
-		die_perror("read");
+		die_perror("recvmsg");
 
 	assert(s.mptcpi_rcv_delta <= (uint64_t)ret);
 
@@ -708,7 +720,8 @@ static void process_one_client(int fd, int unixfd)
 	}
 
 	/* wait for hangup */
-	ret3 = read(fd, buf, 1);
+	iov.iov_len = 1;
+	ret3 = recvmsg(fd, &msg, 0);
 	if (ret3 != 0)
 		xerror("expected EOF, got %lu", ret3);
 
-- 
2.48.1

