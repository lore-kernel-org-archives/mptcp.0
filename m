Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF231691A
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913152; cv=none; b=stbIADH5zqhUtlaAe2JwmssewHJ7/TmoJBoXr6fuLVhDCQB7J0x6ecXOzP+ljiGiw7L1jiPx1moRPSoJLU3oSRs5cyXwGPY+JiEDFEOGN5goK8RpvmqquHqyII3EXY8BlDphS72JAB3oFEKJIN2e+bdYqqA6oFTB1My3iu8yifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913152; c=relaxed/simple;
	bh=DAfLqgvxTWKwYHelPPJglYTF4Tpd2Gp8qe70KI+SlIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkXMtBohWqsh+RaAlOmPRDSSyTYHwJtGTnR2ppJxfXis9VoFwwx90me3hSS8l95sAyT5tXGKUCyuRWMd3KXObBefoEzCzFauikkEN93Tc8BSqFwehThZs6vLbpLCuzwjRtgE+ZkPCgbMAHun1dWciOdaGEe/vCE2cRUHfAAicPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ms3GPDEc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ms3GPDEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDC41F000E9;
	Mon, 13 Jul 2026 03:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783913151;
	bh=FTtbw7o/KO8T79rV33JtAhR7yx6gOyY8IdmiNn2GcvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ms3GPDEc3b7+EzW+5/JPELnYoS5Rj7TSUEBv/2yftJkV9cA+Ka5qpkr0HGRPfOgs9
	 92Qex5tBksAk5tLSItd6fDY/6+BdBLv4m1zx2EaXFFbhOvrRxfu1GeFgx5ZsY9IwI5
	 rvuDU1XgdS/tCdomS9gZbN3R1ttKLStduMlkJMcaXE7XzicKjvn2DwUvUDHqOeF0V4
	 G2wFkMoAwtyvBxI/CLQcrmrea86Ib91MXASwXbFbW2OybUZ9TaFTmsanylCwVvbga1
	 0lubLW6V5FuNVwa4yEh79RAVY70eORmbNWo6uJPzivmv6NefmS0ByIGsf1ALqLBkFA
	 tVcNzozcpomfQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 02/12] selftests: mptcp: sockopt: use r/w for byte counts
Date: Mon, 13 Jul 2026 11:25:26 +0800
Message-ID: <b94a91549c52594c58a2ad52999a830fa831b2d7.1783913010.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783913010.git.tanggeliang@kylinos.cn>
References: <cover.1783913010.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Replace ret/ret2/ret3 with r (received) and w (sent) for readability.
This prepares for future updates where r will be modified via '+='.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 43 ++++++++++---------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index d4ad03ed64ef..941af179867e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -638,7 +638,7 @@ static void connect_one_server(int fd, int pipefd)
 
 static void process_one_client(int fd, int pipefd)
 {
-	ssize_t ret, ret2, ret3;
+	ssize_t ret, r, w;
 	struct so_state s;
 	char buf[4096];
 
@@ -651,43 +651,46 @@ static void process_one_client(int fd, int pipefd)
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

