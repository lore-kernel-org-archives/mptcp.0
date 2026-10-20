Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792470892;
	b=rvoIT7OBvqvev2OA1DWViouEeiUDCrwdkGiIvoyZAXcjpYcV9w8s5HvhSJcBHRCAJqAb
	 ZG/fU4qVWnMCNwqZwidypEk6ukd9pI4kR7yoMz02UTFvi8xN5SFk5539RVW0HWFCyAj/g
	 DLeHTxhvcsMLSzZNvhIkGm7UNfcxhCCB77BJtbWT6ClB4Nt8JosH8UkelDWOYGMloldlm
	 +0/PPe7jhpWVU5e7B2Gww5k1aLoc3YpblLNEgzcMElmjsCv33JeBHCoogMBlnISoeRQ/0
	 /RtLq9lLjgJ9x7KghoKl2DCIEPP3lCatCWJpSwkgxI3MDC69lJfZWw30t9uIcljOsaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792470892;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cRGLHp9YbQMgcIFWtCnZ4f65EbCPwNAfpd3a8JHlXcI=;
	b=Z3/nTi20bx7JNIVtUQTYqKl2DfNCUstpLHKtZj87EIVP+qTjOfVm8yiAqnShTZSMmPd6
	 nKQS7J8RriY6y6K3EPUL4YopvtzGY6BGkrfYbkwnEqXq0SlwjVo01s+f9D9WE3qW2622D
	 WIWZ2LTQcBCTy006u5T0/ird4FPCJqMT0LXsRDYfmBmuLvHfHmUvOxijgI8QiaTexXMs2
	 QZNaDewBF1hwnuePMyCAJtEoFJouZlJSjycTUtO32rKd9SMeUd3xPss+uVejufRopZYHz
	 EEuQmh2C7LxwYi2exT7JDlVeg/qwOFtRJKVqE7kNpVmauDysoupUY4Ff/WIsfjQIiqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hsoO7/dy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044F9606A319
	for <mptcp@lists.linux.dev>; Tue, 20 Oct 2026 04:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsoO7/dy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE031F000C4;
	Tue, 20 Oct 2026 04:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792470891;
	bh=cRGLHp9YbQMgcIFWtCnZ4f65EbCPwNAfpd3a8JHlXcI=;
	h=From:To:Cc:Subject:Date;
	b=hsoO7/dy0dP9WKgYcWfzttvz7+a6yjuvckATonQPvP2hSLn2ZV20P+HEPUxHZ2mhI
	 qeADpiFiqkNatrSoAvRNkYO/AFHWNv62zjluSrPV9cmLXSrMFjs9V32Ej74o3RknW3
	 GX4WLqBIm60qGVhOalfSN574h/T/2JrYJeoF1XvcjFRuWrSbTqRLsUYXoCkleIhfu+
	 uMumy1lRD1yKGocmx+BwwEAMDxGLqpm0I+Af35kofeYly8VJ3ErpyC5SKLlUIqxKnb
	 F9l2aTMYuaUozxrDMwg/FOFFQefSJ7rb82bYwlqgkcPhg1u5/VwYItXD691Od5xJJO
	 ivTX9r7BdDn0w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/3] add distinct lockdep class for MPTCP sockets
Date: Tue, 20 Oct 2026 12:34:42 +0800
Message-ID: <cover.1792470313.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
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

v4:
 - Include existing patch to propagate sk_reuse and sk_reuseport settings
   from MPTCP socket to subflows, and fix unconditional sk_bound_dev_if
   override in __mptcp_subflow_connect()
 - Enhanced KUnit test to cover SO_BINDTODEVICE and SO_BINDTOIFINDEX
   socket options in addition to SO_REUSEADDR
 - Refactored sockopt test into helper functions (mptcp_test_reuseaddr,
   mptcp_test_bindtodevice, mptcp_test_bindtoifindex) for better
   maintainability
 - Added proper socket cleanup using kunit_add_action_or_reset() to
   prevent resource leaks on test failures
 - Added READ_ONCE annotation for lockless access to msk->first
 - Added period to Kconfig help text

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
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1792378794.git.tanggeliang@kylinos.cn/

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

Geliang Tang (3):
  mptcp: give MPTCP sockets a distinct lockdep class
  mptcp: inherit sk_reuse and fix dev bind override
  mptcp: kunit: add sockopt test

 net/mptcp/Kconfig        |   2 +-
 net/mptcp/Makefile       |   4 +-
 net/mptcp/pm_kernel.c    |  16 ----
 net/mptcp/protocol.c     |  37 +++++++-
 net/mptcp/sockopt.c      |   5 ++
 net/mptcp/sockopt_test.c | 184 +++++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c      |   4 +-
 7 files changed, 232 insertions(+), 20 deletions(-)
 create mode 100644 net/mptcp/sockopt_test.c

-- 
2.55.0

