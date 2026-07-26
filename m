Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472581DE3B7
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054627; cv=none; b=bGqQFimA5jcpXogUqFHB26n2UKeM7H/a65UFStEtgDhndbUUf4iHvv4tOaSL22kEtGUKW0SmxmqxStKD2Vsh4j7a4qk4QLbqRABGXzqBH+o7FqOZeVcuwfvvqAp8/bE3twJ+0YvS5+jgbzc6R//4Wcwq1FGfxiRLmep4RAO3bgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054627; c=relaxed/simple;
	bh=ueP1imoXOc+NytGOTzyA5tXXy2JV/JYY7hOAPA0sARk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ak04UuzhDZrXUH7ElmVrnNwjzIrwiCdwl7WaVuuoPvaY5W/8LATz7XaqEPqLrblHnNsUPrehkQk6T1qSi0uwkMSFXd/+jXvzY6fHEIfmj8u3JNaFNEepBWLs18wTvUfeudxlDHs3k26FOlylFVSqH4krvRX0BES+JFGeyaEK2RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUohnRwY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUohnRwY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EF41F00A3E;
	Sun, 26 Jul 2026 08:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785054626;
	bh=W1NabytxOtzXfAt74Uq1mHRW7TcBXBLpkjn3gvvJPUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fUohnRwYV3KWbQscpfy+Vh03l+/tOfCybcjXvdarRg2pK/9MLEZK+REGGVO5ZxdkK
	 qf7sqegugMx8kifhK7n5su/hgHwYMuLeb+8tUXUzKYzlGuj96Y/0j4Wg/AU6+qhAxk
	 C0gl7MeUlz2gscQks0/EFNWxypHI3fbL7x5NnGhYZmqQdXrWEXxsL5CeUmCTS+5CQh
	 5use2bBostJBHmTS17h6TKzxuOkLPwAOCKzduCUF9YYRSYR6xxzz5E7eaEJfqH8ZCs
	 h0Y25G73rj2500qQwRPa2VLLE5R53WplbaXsC14RVwQPh8IWL4UeE4fXQYIt7mpNfH
	 YIjHZPl+fn1tA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 03/12] selftests: mptcp: sockopt: add check_stat_equal helper
Date: Sun, 26 Jul 2026 16:30:08 +0800
Message-ID: <43789c8b18c33a8a2343ba375c895576bc36acf9.1785054129.git.tanggeliang@kylinos.cn>
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

