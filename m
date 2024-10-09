Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD53728EF
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467178; cv=none; b=u0sjKCPXOz910cSoVzu/zzQXkkf/TWfOiToZXzVzDJSgDt78dtJgM2zx/fm7OLPZ+qsDQ1J3pWGKsQEzUxK1Uydz7HmuVOHTFWMkjh8vMgL/TU8v5ryjwZUOC421KFI4EomVmuxPhZxuBaKNQR3332dlou3+coGxjYJg0QOl/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467178; c=relaxed/simple;
	bh=gOqNsUvZEZDjK8CsDu5DMyfFN8Ko6EcnpPEPr+AKob8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pihWgqynJjezibzLKalfIXpsn6sVKyXbbzn0wUatC23EawAtk7Ncr5MM69EzqQgbXgOBiks4OrB2zmO45zLYfpLYW207uG+ofv+Ujz/UrI2KdwK8T1abGb1lwsA9RVpjaz/uhmbNkodNGFRuQYNiwQPt5qLvp3X5KWcCaUgvESM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NX4OPfYA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NX4OPfYA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967FFC4CECE;
	Wed,  9 Oct 2024 09:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728467178;
	bh=gOqNsUvZEZDjK8CsDu5DMyfFN8Ko6EcnpPEPr+AKob8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NX4OPfYARJX8TaDCXPb+ltDXDW6dcBMjd3p5af/qjYE5EBnNMrZkYi3YqnzDDTTVa
	 j1RB+IZofY7rGi8MEcDJ/o1HHSxLdc1IqJWITgPq3hngJ8O/vWw5oPerCsOkc7mP0C
	 RqySY9VH71FOBvhHLTx/GOa3CsR9fnhKjjnta/byuVNpjaoopRSdt0n35khBSWaV1O
	 EIF+Rfrb80uhlU96X5LKU4xiaf7cc6inBR86xjJXIycwj9JggkJA6HeQntkVvFc5XL
	 pqu7xgReVi66z08ycsmvDSjWa1X22dzS1F/0KKputXnAiXiumPSp7V7IGiq2jOlf6g
	 ezFaTWgcx3zIg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 6/7] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Wed,  9 Oct 2024 17:45:48 +0800
Message-ID: <2d6c372fb199a5ae585c16d9fffae6be7c6ade61.1728466623.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728466623.git.tanggeliang@kylinos.cn>
References: <cover.1728466623.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update endpoint_init() in sched_init().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 076903680e75..64b5ce25e1a1 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -509,7 +509,7 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		return NULL;
 
-	if (endpoint_init("subflow") < 0)
+	if (endpoint_init("subflow", 2) < 0)
 		goto fail;
 
 	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
-- 
2.43.0

