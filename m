Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A829299959
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792114518; cv=none; b=Z3sprLr3Lgn0qg/akzR3oX2aqoGi46rvXbv972LKiKCD0SrXVzrylTbnTfDpszRlFD7neFnBDHRwz0YurKNVVsT/XZLXb9u3C4m59/mCs5yas9YBfeS99nMnMTkltf5rYl+i5LxLRqqJrhzbj8uXenK/9/OxudFAItkgP4tRxNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792114518; c=relaxed/simple;
	bh=AkkUWqbRRjG+vrCv74SVdUBwk3WG0tjQqLtKktnmdwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oIBF9Vi1h0C6Mg6eqf1B1AKs+PrVpw501iJXcnxP0+M0Yaq6r37pP8E69C3Bg4aBNuVC4h3AV1aiCDSCKbuUOOmcLl9c0SR7SyC1ayn21o574miuxYlAROyoWX3hlTv5xdrGpqPAQtPqLNsE33mBG8MV+Dp5JIogpoo6EtatAQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLthfivv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLthfivv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC9B1F000C4;
	Fri, 16 Oct 2026 01:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792114516;
	bh=5ZH1MQ1oFYBegGZnY7E/oAmLTau67x6j8tupPjXFUg8=;
	h=From:To:Cc:Subject:Date;
	b=NLthfivvXeHJyFqJKi8cxZ2DDIQJJ3sJTFR373fMJXafBg9vO1rVMXJTS3pUkdbiN
	 zPiZJV0BBtrI31TiqZuwhed40Ex73C7t63S9CDYl9XyvZ1p8Xu8U/2gebCCWgfg/wM
	 f1pFjCymSjSuY1pntF20L+ujs3Wwkmnk6dVrgJ9PCdNCESBa9kaBOvgiliBqvo044T
	 tw++tnMqIsSL2Ck1LjWDR2jpWLy277kbGu0O3gCoeIUHdNEe58QgxYPRkf0Fht/0b3
	 gV1NzShwvVqJorJCZGFhFxRjvb6rirLFP2DySaPKdHHqD8CiTe/UJmSbM6iyuv3e/B
	 yeoEJsA2XZ1Zw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/2] add distinct lockdep class for MPTCP sockets
Date: Fri, 16 Oct 2026 09:35:08 +0800
Message-ID: <cover.1792114102.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The mptcp_nvme.sh selftest reports lockdep "possible recursive locking"
warnings when running NVMe over MPTCP. The issue occurs because MPTCP
sockets and their subflows share the same k-sk_lock-AF_INET lockdep class,
causing lockdep to flag false warnings in paths that hold the MPTCP socket
lock and then lock a subflow (setsockopt, connect, bind, worker send-ack).

This series fixes the issue by giving MPTCP sockets their own distinct
lockdep class (sk_lock-AF_INET-MPTCP for IPv4, sk_lock-AF_INET6-MPTCP for
IPv6), similar to how nvme-tcp handles it. This approach is more efficient
than reclassifying each subflow individually, properly supports IPv6, and
follows existing kernel patterns.

A KUnit test is included to verify the fix works correctly.

v2:
 - Move reclassification to __mptcp_init_sock() to cover cloned sockets,
   as Matt suggested
 - Extract mptcp_reclassify_socket() helper for reuse in PM listener socket
   creation
 - Remove #ifdef CONFIG_DEBUG_LOCK_ALLOC wrapper as suggested by Matt
 - Update lock class names to msk_lock-AF_INET/msk_lock-AF_INET6
 - Note: checkpatch.pl warns about line length > 80 columns in pm_kernel.c,
   but kept for consistency with existing code style

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1792060837.git.tanggeliang@kylinos.cn/

Geliang Tang (2):
  mptcp: give MPTCP sockets a distinct lockdep class
  mptcp: kunit: add sockopt test for subflow socket locking

 net/mptcp/Makefile       |  4 +++-
 net/mptcp/pm_kernel.c    | 18 ++++++++++++------
 net/mptcp/protocol.c     |  3 +++
 net/mptcp/protocol.h     |  2 ++
 net/mptcp/sockopt_test.c | 37 +++++++++++++++++++++++++++++++++++++
 5 files changed, 57 insertions(+), 7 deletions(-)
 create mode 100644 net/mptcp/sockopt_test.c

-- 
2.55.0

