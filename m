Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64662FE050
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334986; cv=none; b=YhpOaztrT+0abbar4sNwo3nxjxNcWu50NrmxFrREk09pa6X8IXZ3W0GUoIfWwLMuR2RTRhehTvmTeMJeWVgpbbqo9IblDBGKTLhVyCvcngyB0nUkdHL5qrbWmnvlx7ALNJAYJ+QuET9hAu6bphoyZgXv9cJgZhqU0JeLxvXHpnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334986; c=relaxed/simple;
	bh=NLG6q2RVoio0QdnhhLSVMij1VEN87MGAaNi2WTRX5iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P44Z+WMwX1a0mYNCoKxpNL61Rsoy+lWfD2mRema+xhgAuhgK6Y8d0pE+4sCmsh2Bi2s71ydAoqUqM8rq56Wc7FG1KKHWGN0G/QChFtx8RN/SLmC0ezcdUL3mSDArQ06szLfUpgwYIV8ABlriAifAO69cFxd2jnfxXNjc+3Q2OBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxColFUL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxColFUL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2A9C19422;
	Wed,  5 Nov 2025 09:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762334985;
	bh=NLG6q2RVoio0QdnhhLSVMij1VEN87MGAaNi2WTRX5iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jxColFULhZ11dkczFBUGvKO/kI3cj1fNknyjqEzzVnIPkjiZQV9RIVxY7fiwEtmpJ
	 eAHFA4+iLjcM5ksxiqmcmwktyjCokMFNvQBdmtvwX/kwxBIx6JwT7o3CtEixRGfman
	 4YbTB1ZIBxi2TtrZUKaKPJVdXk31bvs176ANPloRiB4jyvUdWiOh9T6GhzkGa7jVjl
	 Fw0hLkKHlSVihxSp9U0PuxrUt0Zoylq/7JnMKrYu6onQP/nE1yg4FUAF7demc3EV9m
	 3qlvUAx1VWeFT8c02exSgr3Z9r5nuleg4Gc/nPJcbqfVIkpN628N+0bL7jJ/RWNa/h
	 cWVb2M+qwia9A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 6/7] selftests: mptcp: sockopt: skip getsockopt for MD5 tests
Date: Wed,  5 Nov 2025 17:29:29 +0800
Message-ID: <f28a3580fc18f228f4fd97667213859630066c68.1762334694.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762334694.git.tanggeliang@kylinos.cn>
References: <cover.1762334694.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Skip getsockopt checks during MD5 tests since MD5 connections fallback
to TCP and MPTCP socket options are not available.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 21 ++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index e577fbec9373..9bac1494b238 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -426,7 +426,7 @@ static void do_getsockopt_mptcp_info(struct so_state *s, int fd, size_t w)
 	ret = getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &i, &olen);
 
 	if (ret < 0)
-		die_perror("getsockopt MPTCP_INFO");
+		return;
 
 	s->pkt_stats_avail = olen >= sizeof(i);
 
@@ -457,7 +457,7 @@ static void do_getsockopt_tcp_info(struct so_state *s, int fd, size_t r, size_t
 
 		ret = getsockopt(fd, SOL_MPTCP, MPTCP_TCPINFO, &ti, &olen);
 		if (ret < 0)
-			xerror("getsockopt MPTCP_TCPINFO (tries %d, %m)");
+			return;
 
 		assert(olen <= sizeof(ti));
 		assert(ti.d.size_kernel > 0);
@@ -512,7 +512,7 @@ static void do_getsockopt_subflow_addrs(struct so_state *s, int fd)
 
 	ret = getsockopt(fd, SOL_MPTCP, MPTCP_SUBFLOW_ADDRS, &addrs, &olen);
 	if (ret < 0)
-		die_perror("getsockopt MPTCP_SUBFLOW_ADDRS");
+		return;
 
 	assert(olen <= sizeof(addrs));
 	assert(addrs.d.size_kernel > 0);
@@ -582,13 +582,8 @@ static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
 	olen = data_size;
 
 	ret = getsockopt(fd, SOL_MPTCP, MPTCP_FULL_INFO, &mfi, &olen);
-	if (ret < 0) {
-		if (errno == EOPNOTSUPP) {
-			perror("MPTCP_FULL_INFO test skipped");
-			return;
-		}
-		xerror("getsockopt MPTCP_FULL_INFO");
-	}
+	if (ret < 0)
+		return;
 
 	assert(olen <= data_size);
 	assert(mfi.size_tcpinfo_kernel > 0);
@@ -692,7 +687,8 @@ static void connect_one_server(int fd, int pipefd)
 	if (eof)
 		total += 1; /* sequence advances due to FIN */
 
-	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+	if (s.mptcpi_rcv_delta)
+		assert(s.mptcpi_rcv_delta == (uint64_t)total);
 	close(fd);
 }
 
@@ -727,7 +723,8 @@ static void process_one_client(int fd, int pipefd)
 		xerror("expected EOF, got %lu", ret3);
 
 	do_getsockopts(&s, fd, ret, ret2);
-	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)
+	if (s.mptcpi_rcv_delta &&
+	    s.mptcpi_rcv_delta != (uint64_t)ret + 1)
 		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64 ", diff %" PRId64,
 		       s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - (ret + 1));
 
-- 
2.43.0

