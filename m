Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2224D217736
	for <mptcp@lists.linux.dev>; Sat, 22 Nov 2025 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763801136; cv=none; b=iHt76VXZLfxUKP9dDIY16I7x4JrZ+XuVoJCHR9uxNUtX3dJX4a2mhdJ0kh8n8JuCFnQH16ShysQrscjNc0ghI2sZiqZ7ftF0PAU+ut+oGXukiNrcJuxdG+l7laCGYRlbk8NgrNmLxWQpHNgFcFyHl/R5UPz3oKSZ8dZOoU4MZgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763801136; c=relaxed/simple;
	bh=VXXhMIWRk75Y+wF6TeqPMxrdMOAbO+YPNhwyoipvOE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGK2moTpwMlIsqi3Ru8Lc85S7kA5Z3MBAIo0qbiGb9P/hhfz+fq2QMBWYDfTHhm9+AfFhA0BjUlA2mjhnc/aRXcWSWbWZ6UwUTiN65VMIO4azaW7velgeOUzPaEMKCPrOR81w1OQB3sMv8Z9PlAjgtIzP7rm0jmMvL7ePKne7xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijO/ldmR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijO/ldmR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0349C4CEF5;
	Sat, 22 Nov 2025 08:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763801136;
	bh=VXXhMIWRk75Y+wF6TeqPMxrdMOAbO+YPNhwyoipvOE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijO/ldmRfzcBqV2jupMatlqJBCyHcgxdNl57A2PEqGQ9GJ1yv1DuPbi5wj3cPm2V8
	 tDq1u0bk8NnnKJhzBl9FiRe4k7QGxJ4pzq1FK5+3tGqiuqu50se62EBGilBBmWXe+j
	 mAFwrwQv6kARrpnHPeFPpsn8Mflt5V0eBOvui/uMHHFf9LLLN1zxxCymlwSFY5RCQC
	 zMiwD9mG1bXuyvfkjIyHcqMoVGk2arkD4ciekG+0M+Q4SlFTWdE91POjCuNbylfb6b
	 ZoDmukCA5jUDVhKW1DRlkvt+0qapOoUIpZKmkq2fMpSz9ItS0y27eQYEaCP2jKF0R9
	 mNOEbitbtWyyA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v3 2/8] selftests: mptcp: sockopt: enhance compatibility with TCP tests
Date: Sat, 22 Nov 2025 16:45:21 +0800
Message-ID: <6202d8db428d857b42a565bdf5908b87c5fc9969.1763800601.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763800601.git.tanggeliang@kylinos.cn>
References: <cover.1763800601.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Enhance compatibility with TCP tests in mptcp_sockopt.c, skip mptcp
getsockopt checks during tcp tests since MPTCP socket options are not
available for them.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index e4752f848f08..8fb04c19af5c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -383,8 +383,11 @@ static void do_getsockopt_mptcp_info(struct so_state *s, int fd, size_t w)
 	olen = sizeof(i);
 	ret = getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &i, &olen);
 
-	if (ret < 0)
+	if (ret < 0) {
+		if (errno == EOPNOTSUPP || errno == ENOPROTOOPT)
+			return;
 		die_perror("getsockopt MPTCP_INFO");
+	}
 
 	s->pkt_stats_avail = olen >= sizeof(i);
 
@@ -414,8 +417,11 @@ static void do_getsockopt_tcp_info(struct so_state *s, int fd, size_t r, size_t
 		olen = sizeof(ti);
 
 		ret = getsockopt(fd, SOL_MPTCP, MPTCP_TCPINFO, &ti, &olen);
-		if (ret < 0)
+		if (ret < 0) {
+			if (errno == EOPNOTSUPP || errno == ENOPROTOOPT)
+				return;
 			xerror("getsockopt MPTCP_TCPINFO (tries %d, %m)");
+		}
 
 		assert(olen <= sizeof(ti));
 		assert(ti.d.size_kernel > 0);
@@ -469,8 +475,11 @@ static void do_getsockopt_subflow_addrs(struct so_state *s, int fd)
 	olen = sizeof(addrs);
 
 	ret = getsockopt(fd, SOL_MPTCP, MPTCP_SUBFLOW_ADDRS, &addrs, &olen);
-	if (ret < 0)
+	if (ret < 0) {
+		if (errno == EOPNOTSUPP || errno == ENOPROTOOPT)
+			return;
 		die_perror("getsockopt MPTCP_SUBFLOW_ADDRS");
+	}
 
 	assert(olen <= sizeof(addrs));
 	assert(addrs.d.size_kernel > 0);
@@ -541,10 +550,8 @@ static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
 
 	ret = getsockopt(fd, SOL_MPTCP, MPTCP_FULL_INFO, &mfi, &olen);
 	if (ret < 0) {
-		if (errno == EOPNOTSUPP) {
-			perror("MPTCP_FULL_INFO test skipped");
+		if (errno == EOPNOTSUPP || errno == ENOPROTOOPT)
 			return;
-		}
 		xerror("getsockopt MPTCP_FULL_INFO");
 	}
 
@@ -650,7 +657,8 @@ static void connect_one_server(int fd, int pipefd)
 	if (eof)
 		total += 1; /* sequence advances due to FIN */
 
-	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+	if (s.mptcpi_rcv_delta)
+		assert(s.mptcpi_rcv_delta == (uint64_t)total);
 	close(fd);
 }
 
@@ -685,7 +693,8 @@ static void process_one_client(int fd, int pipefd)
 		xerror("expected EOF, got %lu", ret3);
 
 	do_getsockopts(&s, fd, ret, ret2);
-	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)
+	if (s.mptcpi_rcv_delta &&
+	    s.mptcpi_rcv_delta != (uint64_t)ret + 1)
 		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64 ", diff %" PRId64,
 		       s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - (ret + 1));
 
-- 
2.51.0

