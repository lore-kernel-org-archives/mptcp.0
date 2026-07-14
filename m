Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1D3769FF
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 02:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994953; cv=none; b=gfuT3FAANEFejaSTrqH8PxopuIKLyaglHYpNSHBQMmWvzTaVatJPAtcWwl4TWbBHMH1EvqvyfYVHG715ZcvWbBzqtaKKIoH4Hu9zynjS60V+PF90lJHNBxHSV+eTg3jjDLLicJoOXOc1BDj25BDCKqwbZURiX1opfSAb+C+M7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994953; c=relaxed/simple;
	bh=fsFaZPrrPHTuw5B3uuawDsmw7lXY5K/Sn7eiktwRw4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLpHdlEXIX10PcemEqpFHyhrCSwugcCi0rLidHt5j020QXBJxfZEUmmzL/viQPtTScUXXdQhyRjgFil49CIZeyLNbs9d1bPkHdTEFWHwVDCQneg2dCU2gc4KY0lA22tZoMbQGt/bDm0QP+YsHa1zThQVkFIYT7TMdGS/F3chUoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=or/FpUxv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="or/FpUxv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3518E1F00A3F;
	Tue, 14 Jul 2026 02:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783994952;
	bh=cFs79TsycrRyEfcpbNzzI1ybuRr0BLKdkbm1J59x4+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=or/FpUxvS0cXBEuDnzQ8kZMQegNDIJ+EaBI4LZYueU/9uEbQTlZOxpYMMgcfByTa4
	 thDpXIHNjxC0joRMNHmQvsp1dssq2iQLwLBaJhfZo2sbpCtTWTn0pOzZWf+WQPOD8B
	 XGr927ASk+9uuC7oaBlEOExFsEuRU0qEQQsaRUm2WFFekUMe4jxATpPiPb2Zb6VKkE
	 V2lTYL/keCaAHhrUVNQJ+8ST1nATzMcNZucs/opQIAWp2xn8AO4GwBycDGyj1/ZDsh
	 ghBSPzdOljNsGIOXmn5oAMD62jZiRDKrcWzdzufg3rqDygzjweSmwhic/mYXqLp2R4
	 iMjba50qSxwFw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 03/13] selftests: mptcp: sockopt: use size_t for byte counters
Date: Tue, 14 Jul 2026 10:08:48 +0800
Message-ID: <ece28624c78819a601478b6277edb7be98f0fc63.1783994494.git.tanggeliang@kylinos.cn>
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

Rename ret/ret2/ret3 to ret (ssize_t, syscall return), r and w
(size_t, byte counters) for readability. This prepares for future
updates where r will be modified via '+='.

The byte counters were ssize_t but only ever hold non-negative
byte counts; size_t is the natural type for them and better matches
do_getsockopts(s, fd, size_t r, size_t w).

A practical reason to make the change: r and w are passed to xerror()
variadic calls with PRIu64 format specifiers. On 32-bit targets
ssize_t is 4 bytes while PRIu64 reads 8 bytes via varargs default
argument promotion, corrupting subsequent variadic arguments. size_t
is 64-bit on 64-bit platforms and at minimum 32-bit elsewhere; on the
common 64-bit case the variadic layout is now correct, and the type
documents intent.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 44 ++++++++++---------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 2eef0912a932..55929f0e851f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -638,9 +638,10 @@ static void connect_one_server(int fd, int pipefd)
 
 static void process_one_client(int fd, int pipefd)
 {
-	ssize_t ret, ret2, ret3;
 	struct so_state s;
 	char buf[4096];
+	size_t r, w;
+	ssize_t ret;
 
 	memset(&s, 0, sizeof(s));
 	do_getsockopts(&s, fd, 0, 0);
@@ -651,43 +652,46 @@ static void process_one_client(int fd, int pipefd)
 	ret = read(fd, buf, sizeof(buf));
 	if (ret < 0)
 		die_perror("read");
+	r = ret;
 
-	assert(s.mptcpi_rcv_delta <= (uint64_t)ret);
+	assert(s.mptcpi_rcv_delta <= (uint64_t)r);
 
 	if (s.tcpi_rcv_delta)
-		assert(s.tcpi_rcv_delta == (uint64_t)ret);
+		assert(s.tcpi_rcv_delta == (uint64_t)r);
 
-	ret2 = write(fd, buf, ret);
-	if (ret2 < 0)
+	ret = write(fd, buf, r);
+	if (ret < 0)
 		die_perror("write");
+	w = ret;
 
 	/* wait for hangup */
-	ret3 = read(fd, buf, 1);
-	if (ret3 != 0)
-		xerror("expected EOF, got %lu", ret3);
+	ret = read(fd, buf, 1);
+	if (ret != 0)
+		xerror("expected EOF, got %lu", ret);
+	r += ret;
 
-	do_getsockopts(&s, fd, ret, ret2);
-	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)
+	do_getsockopts(&s, fd, r, w);
+	if (s.mptcpi_rcv_delta != (uint64_t)r + 1) /* +1 for FIN */
 		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64 ", diff %" PRId64,
-		       s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - (ret + 1));
+		       s.mptcpi_rcv_delta, r + 1, s.mptcpi_rcv_delta - (r + 1));
 
 	/* be nice when running on top of older kernel */
 	if (s.pkt_stats_avail) {
-		if (s.last_sample.mptcpi_bytes_sent != ret2)
+		if (s.last_sample.mptcpi_bytes_sent != w)
 			xerror("mptcpi_bytes_sent %" PRIu64 ", expect %" PRIu64
 			       ", diff %" PRId64,
-			       s.last_sample.mptcpi_bytes_sent, ret2,
-			       s.last_sample.mptcpi_bytes_sent - ret2);
-		if (s.last_sample.mptcpi_bytes_received != ret)
+			       s.last_sample.mptcpi_bytes_sent, w,
+			       s.last_sample.mptcpi_bytes_sent - w);
+		if (s.last_sample.mptcpi_bytes_received != r)
 			xerror("mptcpi_bytes_received %" PRIu64 ", expect %" PRIu64
 			       ", diff %" PRId64,
-			       s.last_sample.mptcpi_bytes_received, ret,
-			       s.last_sample.mptcpi_bytes_received - ret);
-		if (s.last_sample.mptcpi_bytes_acked != ret2)
+			       s.last_sample.mptcpi_bytes_received, r,
+			       s.last_sample.mptcpi_bytes_received - r);
+		if (s.last_sample.mptcpi_bytes_acked != w)
 			xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64
 			       ", diff %" PRId64,
-			       s.last_sample.mptcpi_bytes_acked, ret2,
-			       s.last_sample.mptcpi_bytes_acked - ret2);
+			       s.last_sample.mptcpi_bytes_acked, w,
+			       s.last_sample.mptcpi_bytes_acked - w);
 	}
 
 	close(fd);
-- 
2.53.0

