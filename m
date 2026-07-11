Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B7A23B62B
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 03:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783741474; cv=none; b=nqhrZNr1qV78LNNOnPgqC56zcynpF9wWdL/BH/Gboafe1/VTzB5/JTJIJFMF3+tL1PvNPcBbrzM2ufNkrwJ8JbKLCZRYrn+aVxVGiVhvfVqliLJlUpK5ddDf+8cYcXpsDQXmf6zibS2KhKKmGgW6Apgsz1HEC63VDq82/fU0agg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783741474; c=relaxed/simple;
	bh=L4DxLdG7g88Yx5T8DYWnl8EdyGWtq+5hY+CLRKyMbsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7E+pwu3b7Ti/nsSm+iSfIlLEVDGCZbTRw7Leetq8FEgtpak7eJATGk5cEp9aqnjxtSoNxa7DdIak/WInQ7hFe6gGK46PQtPOXutRTI/hClFXNprEMeBih7dhzD9LpAJw/h306MuSij80SG4Qo8an8fxGT0lf/nyDZRrL4VIHLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNf0fp0N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNf0fp0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFAA1F00A3A;
	Sat, 11 Jul 2026 03:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783741473;
	bh=hd8JdTIpTk4hJ2MMXEYtsi9aZJFWhfHaYon8sh+S8cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cNf0fp0NzHoafjcKclCjCbnRDzQCpQJ7L7ZOOHaes/q1ZbwgeLLSqkfNUdpxLJtUB
	 hpf58v4r3Ok8wmobRusHitgqkx7PSHcPUNXLC6Tg+sV3zU67TLsVZcz/RxFjclKoF6
	 Uzuu1EWOPVKU/08480w0SNeWF6dUiUpoVoHTKx+adGb9erh3gkbTyiFZu8KxiuoPWO
	 fjfGDVZLa0gX046NBwGlTvuALsr/wn1tS1BxvvAlViS34Ii7xwHajwg+Wx6DjqQU/Z
	 fIhogGQvRyLrogb9/j0B5h11LtOxQkos8pYfkG6AvgEVsu9RXvI6O3WYyzHFcF0RSa
	 mGj+IJjaJ7fMQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 03/14] selftests: mptcp: sockopt: use r and w for byte counts
Date: Sat, 11 Jul 2026 11:43:31 +0800
Message-ID: <c61cb1405c24e1ccef18c27ded9625ba01994c19.1783740443.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783740443.git.tanggeliang@kylinos.cn>
References: <cover.1783740443.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/mptcp_sockopt.c       | 39 ++++++++++---------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index fed6aba2a176..f4c97b20a122 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -640,7 +640,7 @@ static void connect_one_server(int fd, int pipefd)
 
 static void process_one_client(int fd, int pipefd)
 {
-	ssize_t ret, ret2, ret3;
+	ssize_t ret, r, w;
 	struct so_state s;
 	char buf[4096];
 
@@ -653,43 +653,46 @@ static void process_one_client(int fd, int pipefd)
 	ret = read(fd, buf, sizeof(buf));
 	if (ret < 0)
 		die_perror("read");
+	r = ret;
 
 	assert(s.mptcpi_rcv_delta <= (uint64_t)ret);
 
 	if (s.tcpi_rcv_delta)
 		assert(s.tcpi_rcv_delta == (uint64_t)ret);
 
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
+	if (s.mptcpi_rcv_delta != (uint64_t)r + 1)
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

