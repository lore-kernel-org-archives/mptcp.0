Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D04190698
	for <mptcp@lists.linux.dev>; Sun, 22 Sep 2024 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726966836; cv=none; b=ufxZ5Y7RX0y/zuEXpXXpX+6vd2g+HyDw2qy+S2Y7Mf6TIuXZzJhBi2pRnm8ftASQBVJ46hFrOMPU/IIHwe13ue5+fH8H4GAd7KagCxZ3KRsvYDJFu26/WbxuB/HeAfLAMjrqF6I3+4V1XZyVa9s+rKknlEXjwpCc5mmr/HiJIA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726966836; c=relaxed/simple;
	bh=VQkYMAg6fPp0mqgu9jr2BbIZlBVoYwxDaG6eJp/GiQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mK/XNw2hFE6ifG2D0F2W3iQYGwzwPyyb0JCdUaRKhCCxOTtf3mTNp3HT4itCdtgXf0MkmdqrhmdwSXPk6HEMnExpcPcq6u6+xTtLOsBZnY2xbg292olPiQSSk7zjldMVemL/akb/jnzU75w+XILfSVlu+jegdFDFgKne3Uvl//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpEAQ/1z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpEAQ/1z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC82C4CECD;
	Sun, 22 Sep 2024 01:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726966836;
	bh=VQkYMAg6fPp0mqgu9jr2BbIZlBVoYwxDaG6eJp/GiQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WpEAQ/1zNyP9dhobLsXdHSjipJTY5h2dcZOSadRsvi6rvCVKHu5K3zXi9Ma30+V10
	 HkHsfUDKQR0SaH/qz2nv1h1lbaAxjK8hYwakGPFX7vTmfCO5LPner72XjXxj7p0Jmr
	 ZrIBVfwK482fnqq7Jm5HOIJFvVyWmA0vrYKdfAXNfMJ/I+JFv6IeC58ZjTXmacmLxe
	 LCkWkCM3mrq01pGqsw7aJ7NrtjwL1LQ2EAPuPVhq6Ha1e0CdWD4Y6JKqlekRauAWCX
	 kwyTsTaM9VSCwILgHERJT//rtn7S6dqS1xH1XAxCaRfzughef32+mI/3L2nMcYNnh8
	 8+WoEPC8mvq0Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/3] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Sun, 22 Sep 2024 09:00:26 +0800
Message-ID: <ad4f9023ffdc2a438ff81cb197e542e13028c63d.1726966638.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726966638.git.tanggeliang@kylinos.cn>
References: <cover.1726966638.git.tanggeliang@kylinos.cn>
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
index 167fd9b190ee..ce18da1a6330 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -499,7 +499,7 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		return NULL;
 
-	if (endpoint_init("subflow") < 0)
+	if (endpoint_init("subflow", 2) < 0)
 		goto fail;
 
 	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
-- 
2.43.0

