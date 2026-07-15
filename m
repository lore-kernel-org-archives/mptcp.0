Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D5A248881
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083761; cv=none; b=NxxxOmX0HjyYl4OQgvmJIwDGJKrJj9C1ocsV2wriBVv6Tq6Od/YZ5uNrYigch3YL6dZ+IcSQbNOqhGq4t/+0hTwX0F8qKWSGMEIqf30LAeApDDhbNCaHNtLxYlZP2Xrd1x4OxmKNjGkYCLriOz4NzL8sUWduuE3bZBbQ+LtSUBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083761; c=relaxed/simple;
	bh=HbPQf7nkpxWXfcaTydKAJTjP7ZGbeqiNjhqT4WoYnxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEYvMIN170zVKzMKILRMyfY8bdELYE0FqIARmZvwzBybiCqM14gvGUi18Uy4m+XeJ9ZXlFNTUr1ubr5wZkq4X+HigXrhipGZ76cNRrHPObBOYbAizdlS+wDcQSq+dQiNlY1qU0ol5pLjlg9j4IjT+PGttQ14wYe+bJDwQ0/mY9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nkai+SKV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nkai+SKV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F9B1F00A3A;
	Wed, 15 Jul 2026 02:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083760;
	bh=84NzaoGM2h/OIt9jvjUb6+UAU1prRYzoY4u3b+8BvkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nkai+SKVIhAZxvtnf5asPo7UVSb77sM8mUkPqwTm1qL0XGlYnyfph8dh0kguxysrc
	 txU8NRDSK/1eZXAEp5JVvxK2V/0tOedvE8lE5UkUbQmsQsFDeWh9Y0Wmo8g9WCmIiy
	 ccL6rAFR8QNg1OyZIQSzs5zpw0PWVEnaQRra/mmUMGTXIZZxe1+SwcrGM4tLPlThWo
	 63Z+SzNtI/gnvOTQ13Ll2osKt1MFEtX0Ctr0MCv/OozwxfD4hATWS6+djcew95GvTh
	 XfAc40LL1bevcQp32Bvpz5Y8IXDP8/lFS/0XNApCNoflffBU8el76hzDn12DUTWPMY
	 rfCx1Vhx55Dag==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 03/11] selftests: mptcp: sockopt: add check_stat_equal helper
Date: Wed, 15 Jul 2026 10:48:49 +0800
Message-ID: <a345edbf8bfdcbf65bab7c81050467b25ed0e237.1784082850.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784082850.git.tanggeliang@kylinos.cn>
References: <cover.1784082850.git.tanggeliang@kylinos.cn>
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

