Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C831BD4EA
	for <mptcp@lists.linux.dev>; Fri, 13 Sep 2024 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218275; cv=none; b=cgcGp7KkHeKszwEn+52OGCZsP33WeNRNagrH49Z1zY3F2GMatZuBMszQ6fxki2o2gQtY2RFry769c2/g6gKGnW9vgQoB7XHKlDuhK2VySCJwgfvsJPC13YsQZ4MCnxPp5mAqGcQV4lWmO9xB9XenbYg01pZ+bAi5cQ4TbyvjzdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218275; c=relaxed/simple;
	bh=RSY0nFkvdpl9oUOOjo+LeR4Uc72zwkiH76dZjP/9OqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pljra6ksQ0AMkvPfRN+dK9R0pIWLwINkq7EUW855iPdVVoSlrJB5GuXuym80qabppX4qjahjZ44Sgrql27WZgo9A+EClUxP1xjM/qTVJqCReIj9LaEukSvsw5bhEXareNZm5m+q/CZOWXt9B3Kgr6N71zG0YouilJ6WfCULGLoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gdnh/+S5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gdnh/+S5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306AFC4CECC;
	Fri, 13 Sep 2024 09:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726218275;
	bh=RSY0nFkvdpl9oUOOjo+LeR4Uc72zwkiH76dZjP/9OqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gdnh/+S55EuqFv5J/cs8uwiVf8tNekWJ+ttl8m77Mb8Xyywj8g7FaPng2xw1jSTOt
	 oAtNPTwffbV1DnRM8/fxc47sFluYPEDjY0IcvGO6HEg4/j06jjqM9YfWPtWhMMUnLh
	 Z6E4S4f/TByGr4aMRHu6LNQL6TzcUfGD6/3xPokMBknhz1uxaFOKCNVNV9N0kItxV2
	 URhcrVxO7C7thu0SMVxS0BQ13edOe71ryElFj1zg7Sp7zIIKqHKeVo+TDAmS038UCq
	 LBDRY8frdVsmhtru49KqgwboQ4XW5jYowGOe2KnEKrLARu5NFQG4xUWTHNvy86wXQG
	 t+YUqNQ8grl8A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Fri, 13 Sep 2024 17:04:25 +0800
Message-ID: <725eb6f8e27beaa5a07c108e84c65694e53a805c.1726217806.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726217806.git.tanggeliang@kylinos.cn>
References: <cover.1726217806.git.tanggeliang@kylinos.cn>
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
index b5fdb6dc36e0..11ab16a88369 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -498,7 +498,7 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		return NULL;
 
-	if (endpoint_init("subflow") < 0)
+	if (endpoint_init("subflow", 2) < 0)
 		goto fail;
 
 	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
-- 
2.43.0

