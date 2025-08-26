Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEB23090D7
	for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200595; cv=none; b=hPM2sWhVkp/fHuCBDfxiq8dukPBGwEqQraKoRkO2kRM4HTlZ+oZiBiUWvCgVUo+SGixEeXRwSmn5SmjIxiftpdzqSbc42myqPZ47ISOF3/qykn9IQ4Hg5koi/pQnHR1h7MBvQxOQ5P11/AmxHA34jHTBdXfWJK0dJkEgykk74so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200595; c=relaxed/simple;
	bh=qTPS7RLs53GHo22sjn1NyiUD2hAXnI4BGhqoo++z5lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4vH7hGMKibe4VhbH5P61k3GoAXrtzfwiP94YZhEEpipMjskf2ZorOqYwBD4F5sBNe6PTA0dO/BqyCGcddN+isJNM+rN3IiJWaW81L7NGI/4PXZvtpJ7+WkH6T0MHlrK7FzugG/SZnwPgeAI1FxBJhchLPdCfxbaRZkNUUq5H7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/tRWPBa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/tRWPBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BF1C116C6;
	Tue, 26 Aug 2025 09:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200594;
	bh=qTPS7RLs53GHo22sjn1NyiUD2hAXnI4BGhqoo++z5lM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/tRWPBaTO1nowQdU0hcJQtCoFJl2Jd25qOuZebIqTSnEmQxQNFFLHiP2T0u4w1jF
	 bzsWNaFIahe/OK1dEFPic5pwFaf9mFSfA49X5v+icEJ4UQkNBm5ESPxFhsViliwUDD
	 9Ho67dd/Kz0DeacEILVGZiQhd7MMXErn1+Fmk/cwBUrjjZhs/HfnU0yCUg88hPwgQ2
	 +a76Z/NDzNcUCGnm+uvkTCU312B+BQlyEhhiUO4QEJCQCKnbxYzkKv8gFhLt/Jj8Ek
	 rxhgAbNxoz4zkD+Z9+xBGVN9RC2K7t8I2NQABKIKIWsNJ+woyxYuFNfT+YNJPnTilG
	 3tlXH8tQzryOg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 06/14] selftests: mptcp: sockopt: read eof at the end of process_one_client
Date: Tue, 26 Aug 2025 17:29:30 +0800
Message-ID: <fcd62fb6d5d5498ac4ee48d08207053f5c66cd78.1756200029.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756200029.git.tanggeliang@kylinos.cn>
References: <cover.1756200029.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Moves EOF read handling to the end of process_one_client to ensure proper
synchronization after processing all data transfers, preparing for TCP_INQ
support in subsequent patches.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index add29bdda9e5..d69b10d2dbe3 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -687,14 +687,9 @@ static void process_one_client(int fd, int unixfd)
 	if (ret2 < 0)
 		die_perror("write");
 
-	/* wait for hangup */
-	ret3 = read(fd, buf, 1);
-	if (ret3 != 0)
-		xerror("expected EOF, got %lu", ret3);
-
 	do_getsockopts(&s, fd, ret, ret2);
-	if (s.mptcpi_rcv_delta && s.mptcpi_rcv_delta != (uint64_t)ret + 1)
-		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64, s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - ret);
+	if (s.mptcpi_rcv_delta && s.mptcpi_rcv_delta != (uint64_t)ret)
+		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64, s.mptcpi_rcv_delta, ret, s.mptcpi_rcv_delta - ret);
 
 	/* be nice when running on top of older kernel */
 	if (s.pkt_stats_avail) {
@@ -712,6 +707,11 @@ static void process_one_client(int fd, int unixfd)
 			       s.last_sample.mptcpi_bytes_acked - ret2);
 	}
 
+	/* wait for hangup */
+	ret3 = read(fd, buf, 1);
+	if (ret3 != 0)
+		xerror("expected EOF, got %lu", ret3);
+
 	close(fd);
 }
 
-- 
2.48.1

