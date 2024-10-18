Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016FD18FC75
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243158; cv=none; b=YuWZVs5p1m4gHtIUCI1l1IIximt69ZFS4UEXJxaP4ZnLxfSN3e0pxFXsDZy/46pYUuUXjqgas4ilJ/L7JXcWjXipzPCjsBCFxmtR7RfUSIhZjHQDCKMI0/NGAXjvLFK5FX+XMHKW7TOiKfvwdDlXZ969QZCVxvjOy1dFmnnPhew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243158; c=relaxed/simple;
	bh=vtmI0n8XBT7iRa2qrLQje0sDS2tJxnSofErAGDdm9BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOlYG1J6mnjG5TPOnT94K2yFP6oFxWUPhbOL8qk3p6wxfq1ENBS7tXLzm4cF+zResqoDuUpQHoPNNsxMS+mkCu8m8tdjh7Cd2SE87tLKlHsjY3TzN3ZsqEng9JrGLohlbplxxBy0FfzF3NNbJuQCy1jN5/M4ckmyXpT+FhhhVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLUqKPJ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLUqKPJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6CAC4CECF;
	Fri, 18 Oct 2024 09:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729243157;
	bh=vtmI0n8XBT7iRa2qrLQje0sDS2tJxnSofErAGDdm9BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLUqKPJ662dL2QyAXjWr0H9o+IAqvHWpSWeaYyKuJK1oeVka6SD5QYhWYhDd3kqz5
	 ESh5RkQPJ8wMWbuvwFcJpVqwGfPnbEweEvFwmzGG6OGo+DIJpxC7ysnHJwiG3xq+AL
	 zZ0Oh7YlFnr44sk8AK0TEjDvj8bTrBM6h/B1VI57RLuqSk1icpGmgQWBiw4bJv4Spw
	 Cr3eZ0C/T85uO7KIykiYVX9QUjlNK+EpJkDR9jV4lx40EY2cRKTffQgnSty+z5xIm2
	 tbbLZBqVpCUP/KtkMeOJTx42p6vxNzKacoOqmeHctZ6ce0XE8Q3HyfECDOgDEGZrZR
	 rOD3ckDLXBwgA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 7/9] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Fri, 18 Oct 2024 17:18:09 +0800
Message-ID: <02aa117215d70934d4965dfb19e7a03fc1608f14.1729242644.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729242644.git.tanggeliang@kylinos.cn>
References: <cover.1729242644.git.tanggeliang@kylinos.cn>
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
index 0f00eef7aef5..5b9f29a569a6 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -584,7 +584,7 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		return NULL;
 
-	if (endpoint_init("subflow") < 0)
+	if (endpoint_init("subflow", 2) < 0)
 		goto fail;
 
 	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
-- 
2.43.0

