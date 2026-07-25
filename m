Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ADA2D2488
	for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784983398; cv=none; b=jPGPktpFNbxK2j9sEOURd+cva4sDbbzYdV1ZXU5MQwbRNAFj2aqYk/eRgPpXd3UWplJWhn5flOfN8XZk/XGu4+kyxTmPTmhVVUzWIDgPTfUdtiF6EjOS1zCJFk/TzOBp2TO9ACmKdi0LdK8mgsB4jjR2yluoWL08zx2MRCZwf7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784983398; c=relaxed/simple;
	bh=HbPQf7nkpxWXfcaTydKAJTjP7ZGbeqiNjhqT4WoYnxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ofku3LHeZYXV6rcFryHHvGpiGh4fhzkOdK3dBZiEOPMQonELnDcLKuTYeaRQME0lUsutq569QMy0yJ2qtsYAedXcTVOB5IVk6utNWerWPZPXOpu0XN/5/0mMy2cL8gzllx2bHTSJCAPLh/8XoW9NEGGXxg3aZnc2cxTy6fjeh/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTENbLrs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTENbLrs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDCE1F000E9;
	Sat, 25 Jul 2026 12:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784983396;
	bh=84NzaoGM2h/OIt9jvjUb6+UAU1prRYzoY4u3b+8BvkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YTENbLrsJCpbr/AYwcgnQQZ7/ToeK6KHLySJ+txLREOAfjGx5Y9+YRVfYpH1rTAOE
	 b8OZyObkcBUfvrJjmSwABS27acXyMCtg6/NPqUg3qX4pjY//hhUSH6tmxLIwYo/kb6
	 owctJUmvq+Qx16nfBonn6I+KLalBgBWz1DKqfDJEhYHim68jck/Vor9laJS2G1qvhY
	 nY7eE1EwCwqYzXkD5ik4P/5krf/dP/MU59lxuL1NDRdKICBERjRu+YqCxkhNROa6Wg
	 h88/zIzZ7mIJZajvQynfNMPHBGfpnN3CiRQCxOB/ZoLgDfBCPTBcdssHc2yzmYyc4G
	 0vcdPg5BqSS4w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 03/12] selftests: mptcp: sockopt: add check_stat_equal helper
Date: Sat, 25 Jul 2026 20:42:24 +0800
Message-ID: <fe9b2c13d480e5362e0f5b608dda863ff0c88794.1784981974.git.tanggeliang@kylinos.cn>
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
index 9588a25ac6b2..f124850181e7 100644
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

