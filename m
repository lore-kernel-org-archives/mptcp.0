Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7627133D6EA
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 03:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381340; cv=none; b=MwRGyIXvE/n5tKZt/8WpwTTIuMuR4u7Lf7UdlwZvXSxdF3HD4QARgxjU/1AgBX185NKly69yF2abKGAysrKHFsUTiflbXmo1sCkPjE3jHGaOBm8o1GLAW4BXDArzw9t89HCLM3W30Z/AsTZlGBK+B5qtlIyDOGJQpmHacnBN/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381340; c=relaxed/simple;
	bh=54RU6yRc9qeD0tcfjyoka7QKsx1+RquwweBEULIY+Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1VpSTzeeebnvQJfZWuRXuyTtO/J0T7rWw1ypuBSJQQKRSBzueNaLSsEkYfkHWhBqv3NP2yWh6TOEY56JOAFhzEG+Hzt2WX/i/rK77HmpFog7Zd0006jgj73Z4o4xiItg26M0X9hYGWCUDSPAOguG8mAPhBaEB4ABkQBt5gq/rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSigmhqr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSigmhqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B6F1F000E9;
	Thu, 30 Jul 2026 03:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785381339;
	bh=QC6FRY0ncAnlonmIKXjv3a9HL6OULQy+CqRKZpH/AIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dSigmhqrYvaDfNMxsEHN36jcx3kZyzWNJzbJRIXP7ysbkvb6f+vBDENYbHwuPxtIN
	 ++3fSnn7s6Y1Y2v+1HheR2v28JNOm9MCKXt8Th5H1KhTQGobj2TH4pmj6HyIuXnidB
	 zWR8da2J/8sivA+uT/mdoD/HnN6hB2594YTwTB0zJ6qft1teq3oY9MFZYYad8IbFaD
	 hOqTX2z2u2Jd5CuMeY/8K1QE0/gxuRHWmvYPxj+K2O1SDg29fL7QTH9RObgSI3ojHI
	 aBmRXzLudWotlo8CaFQOUjwhwjg9cDQlK3YDuPtV4fLRSSR6GYXyi+1nu6vF55WMkl
	 V++TLAiURdvAg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 04/12] selftests: mptcp: sockopt: use size_t for byte counters
Date: Thu, 30 Jul 2026 11:15:15 +0800
Message-ID: <1834a49a3960a167bb29e4506eb741e1764b3c38.1785380422.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785380422.git.tanggeliang@kylinos.cn>
References: <cover.1785380422.git.tanggeliang@kylinos.cn>
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

