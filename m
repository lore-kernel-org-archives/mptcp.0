Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754FE1A57C1
	for <mptcp@lists.linux.dev>; Thu,  1 Aug 2024 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517246; cv=none; b=P3dZOQl69E2kfXSa5PuGR0eDMVEPyL7ik2gWbUCj8FzC3FRqatGBapV9SUxqm7OQbZ0aV9SCuRVrgbWiwBmdLnHi/BPy0FdzwGrKytits8gCpPGrAT4Q3H9MjLg6l1+mqoOTGTlUryszuLgzG5TWvDYW/j5dAEVpIfnJRVq4w38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517246; c=relaxed/simple;
	bh=wEJMaXrxeUFqr+/3AtoOOk4eTAqNIMg6qXT3WsMwoJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izI6VP26rw8BFPEOz4LNOb0bLMva0dKjDEyX5ATzmUSiyh6skbXVNQpXq48XOrRiakYbfbE7b+ioC/n1TrmqO7zl06lSQCwG+DUOy2Qqw5JaMXVmNC9lgBgCTyq+IF7p9cHMtUsC6FD0+Q0iGQai7uxPd8D21FZ5yIl0RTG2uHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1vn5PnC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1vn5PnC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6A5C4AF09;
	Thu,  1 Aug 2024 13:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517246;
	bh=wEJMaXrxeUFqr+/3AtoOOk4eTAqNIMg6qXT3WsMwoJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L1vn5PnCfsoKXvU1bbGLdGliDwiLkHKG8utCAabzviVjytkPgfTGtInTWsqFz8gNz
	 reyp9LgDdMY4Sfvs8CNAqnuZgFzBRfi519heoFe2Xp2yxRHdogrcbDRqwLQKjvHGkY
	 4frheCwzjlG10zNEU/JnAvqY3tBXRLih2YP2nHMQbUKCGkrSieY4JBSnUZvpF+X9w7
	 VPDw2nqCxgsgVnE/0+Ci5UBAkB7U62mEUYt3gZIunGjDBh+DNVc4gOWEmeBmMNXKYg
	 sLR7Wze+ElSmBusIUOu8V2drAN8+0oYCx+BjBdsic4eP4VcTJjjNeikHipwl6Kze0h
	 DqpmCrsXLUNYg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/3] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Thu,  1 Aug 2024 21:00:37 +0800
Message-ID: <dddeda2c49bbb5fc7317a6e8beff5ed8ae9b1d4d.1722517019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722517019.git.tanggeliang@kylinos.cn>
References: <cover.1722517019.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop ASSERT_OK() and ASSERT_OK_PTR() since endpoint_init() or
sched_init() may fail.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index a6afced3ca82..91bad33b0c72 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -457,7 +457,7 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		return NULL;
 
-	if (!ASSERT_OK(endpoint_init("subflow"), "endpoint_init"))
+	if (endpoint_init("subflow"))
 		goto fail;
 
 	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
@@ -519,7 +519,7 @@ static void test_default(void)
 	struct nstoken *nstoken;
 
 	nstoken = sched_init("subflow", "default");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
+	if (!nstoken)
 		goto fail;
 
 	send_data_and_verify("default", WITH_DATA, WITH_DATA);
-- 
2.43.0

