Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6741B2DB795
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 03:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381338; cv=none; b=KBmSPGpTJ2WUSc5ehFXB07xCtveVMwdveajM3NCQvZEEUFKxVrQuiR8vWoWtf1fS9GvwXgbec9769iWsJSQcLWG5b/8lsoRTT8fxUCZ7McSysni5adQP6SrGS5HlI2LZrOmg5HPYb9N8fhxCHHoUbIpxO8tadOZmUCZU4qnYU0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381338; c=relaxed/simple;
	bh=ueP1imoXOc+NytGOTzyA5tXXy2JV/JYY7hOAPA0sARk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEwpwNiDkLctW/qXeQ3yVtvF3yt6YvLyel2LCvuMm1f+jpk1qnCtEryaBw8EmLrDM5mFHCqdfKWDn+f0+MyV1kGCyy67F/drQoRbPaAbTp4xl8WDzdEkXbaXQyss7d3VEJvOgYPYG0PIBAGKWFAWFbhewHNLQPBtjUQBcmnHSZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/guzOHS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/guzOHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4196C1F00A3A;
	Thu, 30 Jul 2026 03:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785381337;
	bh=W1NabytxOtzXfAt74Uq1mHRW7TcBXBLpkjn3gvvJPUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P/guzOHSRawASk4rTniEIs8GUaptHZFLY+oTOe/dJa52hPjLqfEFaGfRAmxbtRjZW
	 ++TNi4io9Yod0fcnYiL9P7AaYP0Z9V+TIfKJKlTzu9gPlP5vfrxLMKqc8Gr5/J9th3
	 7sm9Xu892dOz3IKYvZqlWlk3WoycZev1PFX0a8z0Hy4nRjrOmMHht+uF1F9j5H3rYm
	 G40RlVYZrLf8zBHNuj0AImMDN91iaG9Ufmzpz+LFc/Qks86rml7BEFxP7nYuS5Kqkd
	 7qLANFecpnSs1IbkxTdfNAHCCTXyfnVjezBzMGVU11iSy33NSYvlPUgGAXxm5rXLGq
	 qrPt+jAihJKEw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 03/12] selftests: mptcp: sockopt: add check_stat_equal helper
Date: Thu, 30 Jul 2026 11:15:14 +0800
Message-ID: <b28a7c36a33ece04214fbaf0bdd2d3a8ab910532.1785380422.git.tanggeliang@kylinos.cn>
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

Add check_stat_equal() helper to reduce repetitive error reporting code
when validating MPTCP statistics values in process_one_client().

Also fix bytes_acked validation: compare it against the amount of data
written (ret2) instead of the amount read (ret), as bytes_acked tracks
sent and acknowledged data.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 39 ++++++++++---------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 469384823dc6..a68fbe13b096 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -638,6 +638,16 @@ static void connect_one_server(int fd, int pipefd)
 	close(fd);
 }
 
+static void check_stat_equal(const char *name, uint64_t actual,
+			     uint64_t expected)
+{
+	if (actual == expected)
+		return;
+
+	xerror("%s %" PRIu64 ", expect %" PRIu64 ", diff %" PRId64,
+	       name, actual, expected, (int64_t)(actual - expected));
+}
+
 static void process_one_client(int fd, int pipefd)
 {
 	ssize_t ret, ret2, ret3;
@@ -669,27 +679,20 @@ static void process_one_client(int fd, int pipefd)
 		xerror("expected EOF, got %lu", ret3);
 
 	do_getsockopts(&s, fd, ret, ret2);
-	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)
-		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64 ", diff %" PRId64,
-		       s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - (ret + 1));
+	check_stat_equal("mptcpi_rcv_delta", s.mptcpi_rcv_delta,
+			 (uint64_t)ret + 1); /* +1 for FIN */
 
 	/* be nice when running on top of older kernel */
 	if (s.pkt_stats_avail) {
-		if (s.last_sample.mptcpi_bytes_sent != ret2)
-			xerror("mptcpi_bytes_sent %" PRIu64 ", expect %" PRIu64
-			       ", diff %" PRId64,
-			       s.last_sample.mptcpi_bytes_sent, ret2,
-			       s.last_sample.mptcpi_bytes_sent - ret2);
-		if (s.last_sample.mptcpi_bytes_received != ret)
-			xerror("mptcpi_bytes_received %" PRIu64 ", expect %" PRIu64
-			       ", diff %" PRId64,
-			       s.last_sample.mptcpi_bytes_received, ret,
-			       s.last_sample.mptcpi_bytes_received - ret);
-		if (s.last_sample.mptcpi_bytes_acked != ret)
-			xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64
-			       ", diff %" PRId64,
-			       s.last_sample.mptcpi_bytes_acked, ret,
-			       s.last_sample.mptcpi_bytes_acked - ret);
+		check_stat_equal("mptcpi_bytes_sent",
+				 s.last_sample.mptcpi_bytes_sent,
+				 (uint64_t)ret2);
+		check_stat_equal("mptcpi_bytes_received",
+				 s.last_sample.mptcpi_bytes_received,
+				 (uint64_t)ret);
+		check_stat_equal("mptcpi_bytes_acked",
+				 s.last_sample.mptcpi_bytes_acked,
+				 (uint64_t)ret2);
 	}
 
 	close(fd);
-- 
2.53.0

