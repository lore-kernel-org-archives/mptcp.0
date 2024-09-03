Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C25205E10
	for <mptcp@lists.linux.dev>; Tue,  3 Sep 2024 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350710; cv=none; b=dXcyJXEzTPBSpqrzQ299oN2p08rd2DFAiifqQLd1X6jEYkzQ6t0JF1EEIBYyFPSBi/brTHmA2r3zN+TGi/MorEjPqENG7zxL+t60ckfrBOmbMQvHlkyYPJpU3B9RltZ+LZmWPEnBL2eAyb47/RunOsgRZL0mKk/BaujCeVHj+DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350710; c=relaxed/simple;
	bh=vTfiggft06llAFuz4f3D8JufNjpczNfklpupNrDDF5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzuoGXkzWNzxyoXSMpTABEZl6t3oZaJWbwzGzIlIMdd2SmHgS0hR3fx9HMB+86bUCsbfYxDnnprGi7hXU/lGGDfd7UeNKVNyisdZVEOga2srt4jGY/38K6+xwex3ahOaVPHRk1OVgnI6o/lOFCE/5CsTOcbahuKj1wa7DkuYHqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnvmljg4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnvmljg4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F2BC4CEC6;
	Tue,  3 Sep 2024 08:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725350709;
	bh=vTfiggft06llAFuz4f3D8JufNjpczNfklpupNrDDF5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lnvmljg4Rw6HY6aZb6PzrHY9CQXwPH3uhkFcgxhejGpZZpaz0kMi54cx+BMVDuhQW
	 YaqkUBQTxj7OZjJNGeTuEVC4vJPbh7FO80vjZ+y6EIEVm3r52+OnEdXbq5ni33casU
	 yhR7eKjzmLjrylFRBx5hjuAD4JTUUXR6e2mtTDlvV+VQDWCyRpsKYhmgL0bh4xmhvR
	 1MFJTv9BPSF9KX3zxfat4BDM54GHTcKR5iMFCl9BQ9WFARiNzanylbc7huJWPHacYy
	 LGPm420FrSOi7ekNmxCub1SlTOy0DUtiXF/u315Iph5/BHcxFqX59ucTg84kIguLmH
	 ErAjOahJyqScA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 1/4] Squash to "selftests/bpf: Add mptcp subflow example"
Date: Tue,  3 Sep 2024 16:04:57 +0800
Message-ID: <6a84f693164d2e496cf5d5498abab43821e66ce9.1725350462.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725350462.git.tanggeliang@kylinos.cn>
References: <cover.1725350462.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

For easier verification of cc, set cc of the second subflow as "reno",
instead of the first one.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
index bc572e1d6df8..2e28f4a215b5 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
@@ -52,7 +52,7 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
 	err = bpf_setsockopt(skops, SOL_SOCKET, SO_MARK, &mark, sizeof(mark));
 	if (err < 0)
 		return 1;
-	if (mark == 1)
+	if (mark == 2)
 		err = bpf_setsockopt(skops, SOL_TCP, TCP_CONGESTION, cc, TCP_CA_NAME_MAX);
 
 	return 1;
-- 
2.43.0

