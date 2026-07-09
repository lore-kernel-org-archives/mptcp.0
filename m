Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28643DD526
	for <mptcp@lists.linux.dev>; Thu,  9 Jul 2026 07:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580836; cv=none; b=HtNp1c1JYkhlqfxXq0vbfDqAaJO53bC0HWTd8+jaALkKZ9CuEmzrDGd3FrhQJVbOcRt5uho9/pwvPua4OLANT6NDJKzNM0qgeHoCYKGvSNHMdJE6fhcJENneK5eOapY1ygfCcNfAlkkN308LjzWlLQ6eXVnniAC5Q95pAy+08YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580836; c=relaxed/simple;
	bh=K8dkpKmzNBE+70kOk3PDpqYSBxt7PxYJFkDu++zIc5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQHJKNFTU1J10iEHwc0UOCep12p4ZCB+JKTHe2WMK9a0vCp57qgLv4kKqX6Z3dMvkdSkrAaV/IKfaLl/4i2lTqCiXyEr6B/kr3FeEq/FsNh8xBZIIeq9RnsGj2D04ezuz3hrtxOpnZ5cxaNu1xlBnqiNTn/RVQ0F10X9LI29qks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PU/jmzo0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PU/jmzo0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9843B1F000E9;
	Thu,  9 Jul 2026 07:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783580834;
	bh=O5J6jaowkeNJ242hH254q9beB+wqJ3DbHDRPc/RCIIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PU/jmzo0rShAQpn1aYWT/bBrOL+FjWXmP2VHuAw4DG87IXHVEjxVaCMh/ZVorOafz
	 a/lFQvvpVkvZNCxcvLylWB+nyKkXAta2sy31TsTGaZGAgselmM/hTzL/vmUtBccKqL
	 p2p88Lm7bmKm5deVaAkDOfWyFmm7CnFdC8Qxq1JlEW+2KPs5ai8jyGXckTPSVPNhzc
	 wAL9Gbs2t2yQe6r/bs3jkN1vc10H6A5BqrYOizDsq+WR/AzAygCJ4eCgjnBdsSYzS+
	 F5i5rM1ArHWaFIWNU3S69ZcKlKqlFTSp/oAT+yAa89j1liyigPfmdEieZMPsxgOKTq
	 rsoLXS4UUNjkw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 10/12] selftests: mptcp: sockopt: skip MPTCP opts for TCP tests
Date: Thu,  9 Jul 2026 15:06:19 +0800
Message-ID: <ee2b9f85222074d3ef2cf90c2dbcec90d070e845.1783579976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783579976.git.tanggeliang@kylinos.cn>
References: <cover.1783579976.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Enhance compatibility with TCP tests in mptcp_sockopt.c by skipping
MPTCP getsockopt checks during TCP tests since MPTCP socket options
are not available.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 1674b660848d..13d10a606501 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -584,6 +584,9 @@ static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
 
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
+	if (proto_tx != IPPROTO_MPTCP || proto_rx != IPPROTO_MPTCP)
+		return;
+
 	do_getsockopt_mptcp_info(s, fd, w);
 
 	do_getsockopt_tcp_info(s, fd, r, w);
@@ -741,7 +744,8 @@ static void connect_one_server(int fd, int unixfd)
 	if (eof)
 		total += 1; /* sequence advances due to FIN */
 
-	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+	assert(!s.mptcpi_rcv_delta ||
+	       s.mptcpi_rcv_delta == (uint64_t)total);
 
 	if (inq)
 		server_huge_transfer(fd, unixfd, len);
@@ -895,7 +899,7 @@ static void process_one_client(int fd, int unixfd)
 		xerror("expected EOF, got %lu", ret3);
 
 	do_getsockopts(&s, fd, ret, ret2);
-	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)
+	if (s.mptcpi_rcv_delta && s.mptcpi_rcv_delta != (uint64_t)ret + 1)
 		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64 ", diff %" PRId64,
 		       s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - (ret + 1));
 
-- 
2.53.0

