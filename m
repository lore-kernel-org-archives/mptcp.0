Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187D373BEE
	for <mptcp@lists.linux.dev>; Sun, 12 Jul 2026 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783850097; cv=none; b=UY6hskXPGWMzyR8LaqkyxpcTVvPfkfNxt3otWr2rCYMMMHTm79NsiwflblJe6mne66lprPMq90+SKvFI8C8BdlUzjd8d1p+SkVVxVSuSeQjWTFeECzaiMmDa7xGU4fH3iVZKvumiYMXFIU5gLNN8lPraBCarq0MipLxPTbKm4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783850097; c=relaxed/simple;
	bh=f/OTJ1wZIi2lBl0ExyrM4Y+R2NXlZm/KkJ7806LhQOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDI1Qipr64Ef9jUbjDw3DG75Ajd4+FIkvc32c2l/Octj/vCaveAPlsvjmNK/7e+M0ar9/6/MWHULa/8gQmQt+9zoPgj6jz6Wqj1DzCSEaNSkqpS6XG6LKkA5rZDYzNNmoj266NPl1HXwMnCJx5hC4v+Xvw2Bjm0tVRN0cKHkigM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0TKWEQX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0TKWEQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23381F00A3A;
	Sun, 12 Jul 2026 09:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783850096;
	bh=gVnw1wBUekjdWq8LwtkoVpJthk5945/E//ZMIDVBUMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y0TKWEQXJ7bJL0SQXbDHPanqQ3FnNQaT1CUZHlSsQ8hz1CXSoI6hMr5rEG6z8rXn/
	 IP6IA3o9GHAulbC5CQfBUnogilDkxKLWc7B5Loi+oIXU9CLhfkR/fvqXAlpAG4Y5E+
	 i40NqffJUHs+vDT9vRFPy/32YtEXUg6tYOXHVphBqt9LmtcpvunW7jGuQ2ojl0kxM1
	 IRFJve9f6FnWCgR9phBq348BJCfNVoNgvmMcenQNi2EF4ViBqiAJUaUznH050HwyKP
	 MdYkFZQ6HHRnbuR9/AJ4XZ0GGhZi5sIYvr9s+Nh5qAiyANoyOsMoYNXkqvPopvi9Zq
	 fidRFhWD24IWA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 04/15] selftests: mptcp: sockopt: use r/w for byte counts
Date: Sun, 12 Jul 2026 17:54:10 +0800
Message-ID: <caaedf62623dba2d6b4983e6082201c2fbd39439.1783849522.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783849522.git.tanggeliang@kylinos.cn>
References: <cover.1783849522.git.tanggeliang@kylinos.cn>
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
index d4bc5d879abd..8781dfd50ba0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -641,7 +641,7 @@ static void connect_one_server(int fd, int pipefd)
 
 static void process_one_client(int fd, int pipefd)
 {
-	ssize_t ret, ret2, ret3;
+	ssize_t ret, r, w;
 	struct so_state s;
 	char buf[4096];
 
@@ -654,43 +654,46 @@ static void process_one_client(int fd, int pipefd)
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

