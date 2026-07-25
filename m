Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F0E2D2488
	for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784983399; cv=none; b=i2LMLgPYpSv9T8z0/okBO2cI63b8pDmEA19wpI2dT1+AYgAC08BTmLbLV/liEGuwMA28503dAF9mGel4rC5ccqG+s02eakYhYz5tK4yfeLRbCR92Zm15z9uxECsoPtzEtRKuJQfXWH5WmxeU7Z+inTr/Iz4DglrowTMq+nD/BoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784983399; c=relaxed/simple;
	bh=Qh+87Mt0rcDz9zYg5rMzM8XtkLJ6SewLvW4joU9lzP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMJFjcIYHL+BQzT4pDAz+qJosi1UmwR0flFk3PmtpR88DWk+SWQTFZNhimehAnptRmFyaxAn3WKcnL7jygs39agQPQ/MW6s4oiV/imC4yn1S992qVtMP6KLU+nTps5JohOayI1mDnojh/jtWS2iM9tyCWRT+Vo4qsrnc0986Bh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSBHwfDw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSBHwfDw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3894A1F00A3A;
	Sat, 25 Jul 2026 12:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784983398;
	bh=KDQXXwcIdjWQ3Dj4Qi0zZb/cCZUw1uBTIknOz/jMa/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gSBHwfDwOyvzF5VloUAi2aq84FbDGAVoL3fCEI4ifzv2JkIxId1mf2bj7s7hHAIuM
	 /ghe0pT99IRhmPsDpb3Ks/RlJuwAzAxzWXMJBncCN8JHuYvn2/vkEzrzCCc8w2UGe3
	 Y19dgMX+RdHNzY3Ioz1YViQzzE14X/mx2vYWeVk++x4oyqsU6VBUUFHIDlJncwpLLz
	 JyilcgJtHyAePZ8b5dWjvidDJv6ocWYoZxsbCA1B3tpeXVuw7ctuVhTzF/dRLYHzMD
	 3iIsVjH21+zdGLVidvi6IkpFtm5ADhL6DDbiFY3FD1HX2VKkB8jHFhNrEzp8VxVsRk
	 sCag75ntTuZ3A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 04/12] selftests: mptcp: sockopt: use size_t for byte counters
Date: Sat, 25 Jul 2026 20:42:25 +0800
Message-ID: <ba3cf9bf760d8959d01efa00aca96a35f98def5d.1784981974.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784981974.git.tanggeliang@kylinos.cn>
References: <cover.1784981974.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Rename ret/ret2/ret3 to ret (ssize_t, for syscall return values) and
r/w (size_t, for byte counters) for better readability.

The byte counters were previously stored in ssize_t but never hold
negative values; size_t is the natural type and matches the parameter
types of do_getsockopts(s, fd, size_t r, size_t w). This also prepares
for future updates where r will be modified via '+='.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 30 +++++++++++--------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index f124850181e7..9e1d84af5268 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -650,9 +650,10 @@ static void check_stat_equal(const char *name, uint64_t actual,
 
 static void process_one_client(int fd, int pipefd)
 {
-	ssize_t ret, ret2, ret3;
 	struct so_state s;
 	char buf[4096];
+	ssize_t ret;
+	size_t r, w;
 
 	memset(&s, 0, sizeof(s));
 	do_getsockopts(&s, fd, 0, 0);
@@ -663,36 +664,39 @@ static void process_one_client(int fd, int pipefd)
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
+		xerror("expected EOF, got %zd", ret);
+	r += ret;
 
-	do_getsockopts(&s, fd, ret, ret2);
+	do_getsockopts(&s, fd, r, w);
 	check_stat_equal("mptcpi_rcv_delta", s.mptcpi_rcv_delta,
-			 (uint64_t)ret + 1); /* +1 for FIN */
+			 (uint64_t)r + 1); /* +1 for FIN */
 
 	/* be nice when running on top of older kernel */
 	if (s.pkt_stats_avail) {
 		check_stat_equal("mptcpi_bytes_sent",
 				 s.last_sample.mptcpi_bytes_sent,
-				 (uint64_t)ret2);
+				 (uint64_t)w);
 		check_stat_equal("mptcpi_bytes_received",
 				 s.last_sample.mptcpi_bytes_received,
-				 (uint64_t)ret);
+				 (uint64_t)r);
 		check_stat_equal("mptcpi_bytes_acked",
 				 s.last_sample.mptcpi_bytes_acked,
-				 (uint64_t)ret2);
+				 (uint64_t)w);
 	}
 
 	close(fd);
-- 
2.53.0

