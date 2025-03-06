Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C002907
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 02:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227358; cv=none; b=Crh47kkblG2qo1zq1TRLMnkzdG4xoHPPCvpD8iSXU8a88ElNmhLXWfVp8U9XhwADavPRqnmXjDPD2XyxWEcej+VszJmWpHDXg1gmXHM5XG+csPmAY+tODs3kLhw6pqqLjIBYLc9ROfL6xR1727kqbbRk4EamkT+08VA/tS+dsZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227358; c=relaxed/simple;
	bh=dmGcCMVB4j/AQQ79VZSAx4YqFpRFVduNDofgSm8MeQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuQ0zkShrFXWJKXMclo0kqjv2eeT7XSxlqlNiL5miomk5k48o4kAEBQXhHqoMtE7rB/fMSBk+B4BCZMfPCiHC0bs+pM9th43diGvgejVcx5tLGt+d1qxFrTqlzJgyjzmGA468TyPeKaL9nCkDooEglc9zmyEOrxcQnaxOY4skbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYkxyDN+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYkxyDN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1945EC4CED1;
	Thu,  6 Mar 2025 02:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741227358;
	bh=dmGcCMVB4j/AQQ79VZSAx4YqFpRFVduNDofgSm8MeQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UYkxyDN+PWKONw8QWXFabN0feoza6NCFg32OFqad++zduhlAgd7vijPdaBwAyfK9j
	 /Bzr+YaRZB2dqz5InFTGf5S6XPJGKtwfJYFPQtotV7GF/5Vpz8o0oHoIxTL/u2zDD4
	 zgDL426N03CVUZEJHayGUbvTSqiIc2TWuqi0Ezo5IcqnWonvlRjibtGy3UD/DNAR0m
	 HT/0j368mzVE6oPD1sb4Dx0dbsZrdSGaG2Q0Vv6sKOf7bo2/u/b/4fi/VNP6rN/OAv
	 N337iziAjZgL4R+atVrsOupojwE/L2dlWtpgJH4N5Me0xdNUTFkPmuK+eMlwzo+bYM
	 stItjHIf0EdHw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 7/8] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Thu,  6 Mar 2025 10:15:39 +0800
Message-ID: <84d7729d9ae1660501673772c75a92c32b4c3ee1.1741226722.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741226722.git.tanggeliang@kylinos.cn>
References: <cover.1741226722.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update test_bpf_sched().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c    | 2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index ddbf69145d22..c069c08371e4 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -720,7 +720,7 @@ static void test_red(void)
 	if (!ASSERT_OK_PTR(skel, "open_and_load: red"))
 		return;
 
-	test_bpf_sched(skel->obj, "red", WITH_DATA, WITH_DATA);
+	test_bpf_sched(skel->maps.red, "red", WITH_DATA, WITH_DATA);
 	mptcp_bpf_red__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
index b2efd6db7f8b..cbee97a6e7fc 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -27,7 +27,7 @@ int BPF_PROG(bpf_red_get_send, struct mptcp_sock *msk)
 	return 0;
 }
 
-SEC(".struct_ops")
+SEC(".struct_ops.link")
 struct mptcp_sched_ops red = {
 	.init		= (void *)mptcp_sched_red_init,
 	.release	= (void *)mptcp_sched_red_release,
-- 
2.43.0

