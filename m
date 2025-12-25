Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E21E572F
	for <mptcp@lists.linux.dev>; Thu, 25 Dec 2025 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766653240; cv=none; b=F8XHYtBV+Q2celL01UxSzAF7246OPqqaH2l1uYJ1aJKjwvTd0kBHBLjkTA9xXUZZ1kqafmYp/hNzo2ZN8eem1+auIMU0xVr/EDGw4asNmkDLGri3rl24RB4HpAjgOmc/NuwWLSbMHQdnqLnPgGXRjXSujyGmpSmM0gz5Tmt5ww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766653240; c=relaxed/simple;
	bh=5e+wGjokdw9lf/RAoaGCcvmbjc2NWW1OltWOGet5qj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jo++9sexdbEhUEHCQVEd4Imns4/QkCvbepHBBESAoVt1Vw8HP76mOFib/OuRgsFT7BepTSHgDcpCyIuCOb4ccZEZENGcv34DHemgAWVgOm4Wex7ShsnCIKrEfvnkBWEnU1IsA2aLWbhSdTQ1xsRo+nAzIspZBr6wt574XUmVSpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SF8vHmuQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SF8vHmuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5AEC4CEF1;
	Thu, 25 Dec 2025 09:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766653240;
	bh=5e+wGjokdw9lf/RAoaGCcvmbjc2NWW1OltWOGet5qj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SF8vHmuQXw4rT5aFVAShcNLCu2KS7oW1UxP4BZSNLvNbWSBtgQ0Z8suk8OKrFEcsr
	 joai9G/EyVc8PXHLQpFjGf6LsQ6O13DG+HQlla0DcGAd4I2GIJs7YTsWaCYFlDm8wS
	 JIxINddqa9qpKtwXP4v+XcMjuggsdxxEfP84EUxkrsL+XZzhvhhS/7Q45lBKqTSfu4
	 sjbIYljbgj7CFJdQ9njVuasW/0WkUVfrhImSzQQ26N0aE7DG9Wydd1n6H8EPjv5Gvd
	 fOTo2d+3hHvVvwYonoPisZwMjf05FJKI1tKg4LI2+Bt/f8APsoUd27Tnm72Zs35FNB
	 uxAcFL97/8a4w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/3] selftests/bpf: Update sockmap tests for MPTCP
Date: Thu, 25 Dec 2025 16:59:58 +0800
Message-ID: <405fb5b8444cb10f04eca8ba2753fe1065d6cf1d.1766653030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1766653030.git.tanggeliang@kylinos.cn>
References: <cover.1766653030.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update sockmap tests to reflect new MPTCP support. MPTCP sockets are now
allowed in sockmap, so test expectations are adjusted accordingly.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7f48fd9e94e1..217ecc59c8a2 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -570,13 +570,13 @@ static void test_sockmap_reject_mptcp(struct mptcp_sockmap *skel)
 	server_fd = accept(listen_fd, NULL, 0);
 	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
 				  &zero, &server_fd, BPF_NOEXIST);
-	if (!ASSERT_EQ(err, -EOPNOTSUPP, "server should be disallowed"))
+	if (!ASSERT_EQ(err, 0, "server should be allowed"))
 		goto end;
 
 	/* MPTCP client should also be disallowed */
 	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
 				  &zero, &client_fd1, BPF_NOEXIST);
-	if (!ASSERT_EQ(err, -EOPNOTSUPP, "client should be disallowed"))
+	if (!ASSERT_EQ(err, -EEXIST, "client should be allowed"))
 		goto end;
 end:
 	if (client_fd1 >= 0)
-- 
2.51.0

