Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4DE6D1AF
	for <mptcp@lists.linux.dev>; Thu, 16 May 2024 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848745; cv=none; b=SX3xhzqCezJyda/037Awlpjfj38BlKe+/3IShsz0m3EezHXIJWLmaGeK/9mC0YkL9RUNlBR1KX0gezbgnfY6zt84jY9kf6cWf23NvowqQn9IHV2BPaxEWilxiZSUme+iJpgX02x3kRNvsBHcOTfkAtDZ1pt4bLr7Ek9DRFdChBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848745; c=relaxed/simple;
	bh=udG9vWPF00neKQVSuqKavYO999fBQVr3vJjG/gBGAtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5VUk3jmskHP2YVsuA8UkH1NxJKoQ2sRs6mcT1MuVP1TTK0BWUAi4bI3plD93MjQbLIDknlM9UO5eYickbtQscl+GLu5awE/Zj6a84i19r0PHl1mEbG9/PBmzMNRWT2aRR4LkPiBIC9E8OIg93o2yv31a6vrOsUz22V7uBq9ILA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpjyL9FI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpjyL9FI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1601BC32782;
	Thu, 16 May 2024 08:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715848745;
	bh=udG9vWPF00neKQVSuqKavYO999fBQVr3vJjG/gBGAtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lpjyL9FIDpyK2DD6Cch9TlnhcIp7Qd4ho3dGUKl31Ub1eFYsRaw7AhmSbr4+/RYZY
	 KBW13stG8MOwSXr5Q+Qkz0NpIuc76X4EFUD2qubxvKOK56OlPhDpqw67ULvVPn+dIF
	 hfpMj7/v4tDA7itIxSv66Qv8dbjK6HfYa9fEBUa71HAPnDVm9gU7O/paDVroeJbNj9
	 PcRUBBKVp/mK4dAZe/09FRMDuRHjz+IkXHP86xmaEPAU+WJIKa5mlzzkv99E+bjvyQ
	 GZnAZNV6pzV04iINg/zO+Zv+Vp0+NU40OvsscwasZ1xoVVuM1IVT/IHBLm/rETouOJ
	 p1s3qi5tQ9H/g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/2] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Thu, 16 May 2024 16:38:56 +0800
Message-ID: <e301d8027ec2ed1a9e77f461680593f30c5e2ced.1715848543.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715848543.git.tanggeliang@kylinos.cn>
References: <cover.1715848543.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

create_netns() is updated in "bpf-next add netns helpers" series,
test_subflow() needs to be updated too.

That means v3 of "selftests/bpf: new MPTCP subflow subtest" cannot be sent
to bpf-next at the moment until this "bpf-next add netns helpers" series is
accepted.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index c7f61fd9e7a5..a4863328d2c7 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -418,7 +418,7 @@ static void test_subflow(void)
 	if (!ASSERT_OK(err, "prog_attach"))
 		goto skel_destroy;
 
-	nstoken = create_netns();
+	nstoken = create_netns(NS_TEST);
 	if (!ASSERT_OK_PTR(nstoken, "create_netns: mptcp_subflow"))
 		goto skel_destroy;
 
-- 
2.43.0

