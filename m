Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06F395AED
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 03:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792379085; cv=none; b=VVwFRnVaV5MJlKFOyglaYDs+k+kg1XWsgyGRLyu3YY+faIsPWYpPT5mOfh56F+0gSiygZAWnYjPRr83GE6T2q39xVxr1CAhxZEFjjb36a8WVlZ2q9LrVD2ZESD98fQLP8lyv1RX4U5L44PE1jECaSCZeC1iRIwx99/XZfW4yB7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792379085; c=relaxed/simple;
	bh=2VCoojVe6BCAWb3DuPrd5zSisny/nEbEhlv5kGNV8z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z652xY89KoYT1lgYAdXfE9dqrF38l6eECGoJH270gmbvxy+EvE4iSxbEsJpG/WWpgyyvzNEXhq/rO4x8O3CS0sSol/hEAFxL+Xf1n4/AsHNUl+zf/nUgYty/uTRLuWe58/52SKC5mOHpauksUy410m3qk8phQuJn4feVBAb5tUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK57X6G8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK57X6G8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E84A1F000C4;
	Mon, 19 Oct 2026 03:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792379082;
	bh=GtmyjWLPxvLqFNcUZlAFTqbZxA3JBcpDiolorMdMuDg=;
	h=From:To:Cc:Subject:Date;
	b=BK57X6G80TBER0PLGfN8oRAB8TTEe2L1pY6QuqrnY+jYdjFuLOonz9KQhuU5WVo8k
	 gO+dqRpAT99YFg1/3tPItDOso6ig1L/6q/6Mt0ltiAZjdsNneuI/bXsVzQWZDx81Tl
	 Qv1N4xtTGpwXe30XqYC+xABaCKARFsx23LHREzdRPqVZWsZ4h58H9I0zhuXV/zZAqu
	 HXOBEHO9f2oHo7deww30Qq5tLNZP0r2QGE/Jzgn1VYZSk1KchbLJKvzwI0GfIQGZJd
	 J9u+5Ak0UmntpXDMOKSGLJm1QBEwNusREW2WaHnrpP4d0pcBMKVqMntR4PyMTn1BY3
	 KsqdV8EVH4RQQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/2] add distinct lockdep class for MPTCP sockets
Date: Mon, 19 Oct 2026 11:04:32 +0800
Message-ID: <cover.1792378794.git.tanggeliang@kylinos.cn>
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

v3:
 - Assign separate lock classes for kernel and user MPTCP sockets to
   prevent lockdep from conflating their usage patterns (kernel sockets
   may nest with fs/storage locks, user sockets record mmap_lock
   dependencies through page faults)
 - Call mptcp_reclassify_socket() from mptcp_init_sock() for active sockets
   and from mptcp_sk_clone_init() before bh_lock_sock() for passive sockets
 - Remove duplicate lock reclassification from pm_kernel.c (PM listener
   sockets are now reclassified through mptcp_init_sock() path)
 - Enhanced KUnit test to cover both IPv4/IPv6 and active/passive sockets,
   with direct lockdep key comparison when CONFIG_PROVE_LOCKING is enabled
 - Update Kconfig help text to mention sockopt tests

v2:
 - Move reclassification to __mptcp_init_sock() to cover cloned sockets,
   as Matt suggested
 - Extract mptcp_reclassify_socket() helper for reuse in PM listener socket
   creation
 - Remove #ifdef CONFIG_DEBUG_LOCK_ALLOC wrapper as suggested by Matt
 - Update lock class names to msk_lock-AF_INET/msk_lock-AF_INET6
 - Note: checkpatch.pl warns about line length > 80 columns in pm_kernel.c,
   but kept for consistency with existing code style
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1792114102.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1792060837.git.tanggeliang@kylinos.cn/

Geliang Tang (2):
  mptcp: give MPTCP sockets a distinct lockdep class
  mptcp: kunit: add sockopt test

 net/mptcp/Kconfig        |   2 +-
 net/mptcp/Makefile       |   4 +-
 net/mptcp/pm_kernel.c    |  16 -----
 net/mptcp/protocol.c     |  37 +++++++++-
 net/mptcp/sockopt_test.c | 145 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 185 insertions(+), 19 deletions(-)
 create mode 100644 net/mptcp/sockopt_test.c

-- 
2.55.0

