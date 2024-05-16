Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C5FEBB
	for <mptcp@lists.linux.dev>; Thu, 16 May 2024 01:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715822788; cv=none; b=SHA3zm/l2DhD7lzdkkrAC7bnGiXZe9Ed+c6FVoMwYOqEyA4d9QWfCOX76/0wUnsj4X/ZxWEj5Wcp+RfulJ+OOeyNQga2UNlpqj6QG26XkyL3xs/kFuWV9O/76SBk5OAPgTdEF+xpDC7FWpsq2Nn1YFgJQuL7y+SOC49zSse/O7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715822788; c=relaxed/simple;
	bh=udG9vWPF00neKQVSuqKavYO999fBQVr3vJjG/gBGAtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSyJ5T+WR+82EH3KU3btIY/J45QTWlaozNZACFbRT5Dfk9vjemxPHqdhgVKgOl5ERX7T7gXHUh9C11kUjJhCIU35KqG5ZNpV6mainrlSwBUjD+1imGWkbfisWEa70kZS/RIrcrAZiFE7DZgmnty1U6mp8VHgekxXExzlUlY+9tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuyIvMJQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuyIvMJQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B1AC32786;
	Thu, 16 May 2024 01:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715822787;
	bh=udG9vWPF00neKQVSuqKavYO999fBQVr3vJjG/gBGAtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nuyIvMJQNvyYzO4ZElb6EbkPYsrK6fYdIP34qsg19+9VveUCSOZOlfUHbUkxZuL34
	 HvnPVq0eZNgLrVHE2fqbt/ztDuskOQNHcK0CsFI/Guo98XDl4zza6xXjofkv2cfb43
	 TtuHYLlwNAyTlvFXZU5qVcdBSwo7pXw162wyQZlIv55IZTJQEeZC4WnP0vwH3ep+Go
	 0LXGihdbHCMDtKKh2xlppDyDq2QhIj3rdZ6WThXZ4b75xWEOmpJIXc8934+xp0yvZH
	 0y0Fy/8P2Q6l7shP+PTpR4nMz3viziJmB/54dsyni8J1+3ED2RAsP3pgCo3f/h4EUH
	 0hf67rp1NkKUw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/2] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Thu, 16 May 2024 09:26:17 +0800
Message-ID: <4c821f09e1bcee97604c817a4b8100f1752283de.1715822527.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715822527.git.tanggeliang@kylinos.cn>
References: <cover.1715822527.git.tanggeliang@kylinos.cn>
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

