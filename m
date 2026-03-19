Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAAA3B8BCA
	for <mptcp@lists.linux.dev>; Thu, 19 Mar 2026 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914938; cv=none; b=iNTuH8KVp9ISs2gV6Kx/1yVjUxo0o0tOvcp44Q+J81O/DmzVDIwU9YdeCvWRWGEt6RiTFGi93sTU+gF6KUhSpwsLn8Ur2rYNc9RB0ueazfsHRTmzUM13gMN7wcgLvj9J7XYDmr/HnebHg+tPmSoqcqY6v3rjTQz6E6b7LwTGDKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914938; c=relaxed/simple;
	bh=ivGo11FJLzVXLCfjDRfu/utjOcPZgskvnCUtF3F+nGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZXyC18OguEkbYROu0RK6pXcQR/5AjOQiJJkmR9uD18DLgMIZFhJfI8i6H22uDPRf8/yiSoPyVt+cSI+VfjvNtexiGw0nq4wdlKMR/dSf1YD//lnT87XpEKqYH5qaM+EhNHSVerjeJdm/vH6v3Cvz6vIs2r8gpOrSNdw5CccfNwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkKg9Acn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkKg9Acn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BA8C2BC87;
	Thu, 19 Mar 2026 10:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773914937;
	bh=ivGo11FJLzVXLCfjDRfu/utjOcPZgskvnCUtF3F+nGE=;
	h=From:To:Cc:Subject:Date:From;
	b=WkKg9AcnW2vv1PWTKJwOvDXJJqdFCCw9fbxvW3iop/7JAHbgCs8i4NifVfau9/H+8
	 mZ7DucdlnLsLLAicZKlWqfwAgZjj7v26O4f+7ArMwGnFBbrpuVMsCNaJbHFER66dpC
	 ZwdOsKGLxr3cACXsHBvWE2ljQbf2OBI9Fkl241G2fdBl9DgAt1fQPx/AyYfRHQVH+8
	 dM83DE/wxuFOJMRduvEuFh3L9qaCrRivQB25nd5BpL4GgO4KorQBr4huyqt+2fh4n/
	 VVEPHfyf7cxp4eZw2m6jv2M/NIx2nDHPCr8HugRqf9bi24D9xD1TNcLZzzQK3/bXIc
	 mXK5+M7EojBRg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v11 00/15] MPTCP KTLS support
Date: Thu, 19 Mar 2026 18:08:33 +0800
Message-ID: <cover.1773911536.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v11:
 - Fix memory leak errors reported by CI. In v10, these occurred in
   the shutdown_reuse test and "usleep(500000)" caused the memory
   leaks. In v11, a dedicated helper wait_for_tcp_close() has been
   added to provide an appropriate delay.
 - Drop the code that used mptcp_data_trylock() in mptcp_move_skbs()
   to fix a deadlock issue, as that deadlock no longer occurs in v11.
 - Do not add "mptcp" variable for the "tls_err" tests, adding it for
   the "tls" tests is sufficient.
 - No longer increase timeout values for poll/epoll tests, as they
   are no longer needed.
 - Add ns1 definition in mptcp_tls.sh to fix "ns1 is referenced but
   not assigned" error.

Based-on: <cover.1773735950.git.yangang@kylinos.cn>

v10:
 - Address comments by ai review:
   - patch 2: call tls_ctx_free(sk, ctx) and clear icsk_ulp_data before
     goto out.
   - patch 3: update commit log as "validate each SKB's offset except
     the first".
   - patch 5: add sock_owned_by_user() checks.
   - patch 7: disable device offload for MPTCP sockets.
   - patch 9: use TCP_ULP_NAME_MAX in mptcp_setsockopt_tcp_ulp(), drop
     SOL_TLS in mptcp_supported_sockopt().
 - Make .get_skb_off optional instead of mandatory, TCP does not need
   to define it.
 - Test "espintcp" ULP instead of "smc" in patch 10. "smc" ULP is
   removed recently.
 - With Gang Yan's "mptcp: fix stall because of data_ready" v3, mptcp
   tls selftests can run without failures. Now add them in this set.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1773737371.git.tanggeliang@kylinos.cn/

v9:
 - add a new patch to "add MPTCP SKB offset check in strp queue walk",
   thanks to Gang Yan for the fix.
 - add a new patch to "avoid deadlocks in read_sock path", replacing the
   "in_softirq()" check used in v8.
 - update the selftests.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1773365606.git.tanggeliang@kylinos.cn/

v8:
 - do not hold tls_prot_ops_lock in tls_init(); otherwise, a deadlock
   occurs.
 - change return value of mptcp_stream_is_readable() as 'bool' to fix the
   "expected restricted __poll_t" warning reported by CI.
 - fixed other CI checkpatch warnings regarding excessively long lines.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1768294706.git.tanggeliang@kylinos.cn/

v7:
 - Passing an MPTCP socket to tcp_sock_rate_check_app_limited() causes a
   crash. In v7, an MPTCP version of check_app_limited() is implemented,
   which calls tcp_sock_rate_check_app_limited() for each subflow.
 - Register tls_tcp_ops and tls_mptcp_ops in tls_register() rather than in
   tls_init().
 - Set ctx->ops in tls_init() instead of in do_tls_setsockopt_conf().
 - Keep tls_device.c unchanged. MPTCP TLS_HW mode has not been implemented
   yet, so EOPNOTSUPP is returned in this case.
 - Also add TCP TLS tests in mptcp_join.sh.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1768284047.git.tanggeliang@kylinos.cn/

v6:
 - register each ops as Matt suggested.
 - drop sk_is_msk().
 - add tcp_sock_get_ulp/tcp_sock_set_ulp helpers.
 - set another ULP in sock_test_tcpulp as Matt suggested.
 - add tls tests using multiple subflows in mptcp_join.sh.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1767518836.git.tanggeliang@kylinos.cn/

v5:
 - As suggested by Mat and Matt, this set introduces struct tls_prot_ops
   for TLS.
 - Includes Gang Yan's patches to add MPTCP support to the TLS selftests.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1766372799.git.tanggeliang@kylinos.cn/

v4:
 - split "tls: add MPTCP protocol support" into smaller, more
   focused patches.
 - a new mptcp_inq helper has been implemented instead of directly
   using mptcp_inq_hint to fix the issue mentioned in [1].
 - add sk_is_msk helper.
 - the 'expect' parameter will no longer be added to sock_test_tcpulp.
   Instead, SOCK_TEST_TCPULP items causing the tests failure will be
   directly removed.
 - remove the "TCP KTLS" tests, keeping only the MPTCP-related ones.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1765505775.git.tanggeliang@kylinos.cn/

[1]
https://patchwork.kernel.org/project/mptcp/patch/ce74452f4c095a1761ef493b767b4bd9f9c14359.1764333805.git.tanggeliang@kylinos.cn/

v3:
 - mptcp_read_sock() and mptcp_poll() are not exported, as mptcp_sockopt
   test does not use read_sock/poll interfaces. They will be exported when
   new tests are added in the future.
 - call mptcp_inq_hint in tls_device_rx_resync_new_rec(),
   tls_device_core_ctrl_rx_resync() and tls_read_flush_backlog() too.
 - update selftests.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1763800601.git.tanggeliang@kylinos.cn/

v2:
 - fix disconnect.
 - update selftests.

This series adds KTLS support for MPTCP. Since the ULP of msk is not being
used, ULP KTLS can be directly configured onto msk without affecting its
communication.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/480

Gang Yan (2):
  tls: add MPTCP SKB offset check in strp queue walk
  mptcp: update mptcp_check_readable for TLS use

Geliang Tang (13):
  tls: introduce struct tls_prot_ops for protocol ops
  tls: add tls_prot_ops pointer to tls_context
  mptcp: avoid sleeping in read_sock path under softirq
  mptcp: implement tls_mptcp_ops for MPTCP TLS
  tls: disable device offload for MPTCP sockets
  mptcp: update ULP getsockopt for TLS support
  mptcp: enable ULP setsockopt for TLS support
  selftests: mptcp: connect: use espintcp for ULP test
  selftests: tls: add mptcp variant for testing
  selftests: tls: increase nonblocking data size for MPTCP
  selftests: tls: wait TCP_CLOSE in shutdown_reuse for MPTCP
  selftests: tls: add MPTCP test cases
  selftests: mptcp: cover mptcp tls tests

 include/linux/tcp.h                           |   2 +
 include/net/mptcp.h                           |   2 +
 include/net/tcp.h                             |   1 +
 include/net/tls.h                             |  20 +++
 net/ipv4/tcp.c                                |  87 ++++++----
 net/mptcp/protocol.c                          | 133 +++++++++++++--
 net/mptcp/sockopt.c                           |  39 ++++-
 net/tls/tls_device.c                          |   6 +
 net/tls/tls_main.c                            | 100 ++++++++++-
 net/tls/tls_strp.c                            |  32 ++--
 net/tls/tls_sw.c                              |   7 +-
 tools/testing/selftests/net/mptcp/Makefile    |   2 +
 tools/testing/selftests/net/mptcp/config      |   4 +
 .../selftests/net/mptcp/mptcp_connect.c       |   2 +-
 .../testing/selftests/net/mptcp/mptcp_tls.sh  |  53 ++++++
 tools/testing/selftests/net/mptcp/tls.c       |   1 +
 tools/testing/selftests/net/tls.c             | 157 ++++++++++++++++--
 17 files changed, 566 insertions(+), 82 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_tls.sh
 create mode 120000 tools/testing/selftests/net/mptcp/tls.c

-- 
2.53.0

