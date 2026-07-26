Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52081DE3B7
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054628; cv=none; b=n0hd/110VjQTemi/k5YKmsKig1uvEpF4o88V3fIBwwBfVwwtVkILc05r6IGKByMBPP08JbRZz1Pu0rtgqAiQpC4ISBzRGu94azfntvq2TustJD0CX2SzxtNjyyOeuV7Scndowsg9fl5P3y4Oi8a6QNNP7+gxW3Ng30qlNXP+L/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054628; c=relaxed/simple;
	bh=54RU6yRc9qeD0tcfjyoka7QKsx1+RquwweBEULIY+Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWZJ2W0QOs2MKsQRWA8Qw9YSFhrdivXLM2kpNqBRx55NM3BQNqdF9IYX+ip6fAdE/R8Nh+Q47zjPMY3wBH24h0y9iUaN6K3XscsLg6DiM9TsIEu2QTEHYTtQwW2OyzH6K3wgCzTBkh5QcyDj09jc4VUUVxuM3WXGnoBjJrADp14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbMEKjA5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbMEKjA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897741F00A3A;
	Sun, 26 Jul 2026 08:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785054627;
	bh=QC6FRY0ncAnlonmIKXjv3a9HL6OULQy+CqRKZpH/AIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZbMEKjA5yaXWWM3+onHdBri8qcbcEC+21rnyps/s4hXgm0tVzlqbdr1ZoYtsYzo3R
	 eg5FcRDXkK8+RCxNFSXSKDcNmuK2x+FUtIKEOEYGM4UR0qwD8ydmyBRHOggPDg8CAc
	 /3o3W56AZD65R8r3ARJUsM4J5gx7zziW/mLvz8JKEkhl+HyeR1rezSQb3BSFqIPOww
	 qpjKFJwHiaoWJBD+Tq9PahUmRJR7K5vLSfNZF1rLPUF3n+nm+DdebWRUh9w8bm+j/X
	 ORDxTJBw3Sk3Mhv6jl9sWSOX+Tb8BfFa9Mj3I1yQewX8wXCrN4IDNLpPDOIu/VnFFl
	 wDysYmwuK0s0A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 04/12] selftests: mptcp: sockopt: use size_t for byte counters
Date: Sun, 26 Jul 2026 16:30:09 +0800
Message-ID: <89bb8d9e2665492d4c91dbe60fa554b7ace910cd.1785054129.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785054129.git.tanggeliang@kylinos.cn>
References: <cover.1785054129.git.tanggeliang@kylinos.cn>
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
index a68fbe13b096..3a7fcef5aa54 100644
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

