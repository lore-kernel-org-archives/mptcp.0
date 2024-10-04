Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7D29422
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046273; cv=none; b=ftTTf+rqszjw5J3Cqxm7Wlcu9iimjws4XjUAbp8TotkYHKF+rxl6Sy4fTzP7BDI9U/KfQHCBAbyVGY4NdCxBmh3WyBGBzMeJTylxuL4CPf69rOaCzkKtfIPIkOH9xahkozKH+/Euq9P03UfLkOsgSa7xO2PBBL9L39vH2DZy+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046273; c=relaxed/simple;
	bh=gOqNsUvZEZDjK8CsDu5DMyfFN8Ko6EcnpPEPr+AKob8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVHperbjZcDbd1+4gIGqCbc6QmKST2BzbMVs2l/zuJOm/UPMwTWLQTeeN7R8it5nn9EADRmhUOn+39gqJTm45LvuxUHh0WWDJqYE00Jewe9KohXtAIwO4sRI8zV/ApCaStLCClDCgtazAOZIGeIzt+a39ewPF/3yzghdlGJH3wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQt2c0Sc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQt2c0Sc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41217C4E693;
	Fri,  4 Oct 2024 12:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728046272;
	bh=gOqNsUvZEZDjK8CsDu5DMyfFN8Ko6EcnpPEPr+AKob8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQt2c0ScXFfIot9c8GrdqJjtjZCtgsw/bnQLMelkuVAcdyJQ5YF+w9eds1mivmEVK
	 /7Xm2EOQaD0lZ5GkC2+4RZVv/pHMC4YoeiIhA+MUNBMYvi9ENjK+HTJ7Vi73CSQsBN
	 oe1mBcL0raCAzi6aHg5h/Ecvv+FPpN5ZOcJrcZt29W4e9eGV1X1lSXeItdHgHsSn97
	 cOlA8NLke/xfLBTFx9XYVSLVzIgWQB+47JcL0f7U04mfReR2fGeMEQ+33W9TR0pVAo
	 owqaBf1ST9Xv+sBAn4Bh8a39tvTUoVZv4RLqiP58IkoQOLvQDcl77cEDP6P5y3xjq2
	 HQqxm2r3qTmaQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 6/7] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Fri,  4 Oct 2024 20:50:52 +0800
Message-ID: <c7fa4439038d53332b7d87e0b465a8f7f93f7e48.1728046021.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728046021.git.tanggeliang@kylinos.cn>
References: <cover.1728046021.git.tanggeliang@kylinos.cn>
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

