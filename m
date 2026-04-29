Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4943EE1ED
	for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459637; cv=none; b=C+eNs5vkZeg8XOqiWfzu6LptdiEOhRdNSJVlZULrzrhZLuOJESHpefHAhZ8VjDJL9LNM6Xqqb1EiEFMVAF03MkcqzvqfoIUlsK8FMex+LeBfpMvDynwzsf5/l7QmGKxLySfzSKwkMHdQ4J9/r8oV5WvXP8qJnsQgc36SEc5jbUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459637; c=relaxed/simple;
	bh=h5QTfKNiGK2AywLpdjUykgpSmLHjmYCN+B9Xo3+9T2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c7s96VaizIjmRWE7jRij9kmcN35I5g+dKA/JGjncr/Q1po5Fj302X+LkNk5wSYEM50g1CLFTutFuDUjy6HbQVHpiy+uVgfNE3EnfX6Uf2Lg5q2Dt748/TuvXnrS1/jEn47Vheg5zdCWWMIlU2nUmtar6W6MDvUcikXHtMCvuizg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcWkUppb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcWkUppb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20493C19425;
	Wed, 29 Apr 2026 10:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777459636;
	bh=h5QTfKNiGK2AywLpdjUykgpSmLHjmYCN+B9Xo3+9T2o=;
	h=From:To:Cc:Subject:Date:From;
	b=VcWkUppbjGNK4gfI/dEyqEtLHxVZCb0sdn0kgKGwk0B5jAIG9xj/qoh5mXpcG78Uz
	 HXiNYyyYkVGsG2yw/pot57dA/i0XH4nq/VlMP0xDkueWQgroTdbTcn+Or3+vyIAugl
	 lP5WRVA+OE5YqDSb+Qsqr9DspacV1QF/ktKSe2i6lSfr2TyvGPVaY0M9UlBEQ8vuqQ
	 GrZOKP/o3AZgWtC4eoiZIpDVxAJvsNoSV0dnOqHa9bG0c+ymkUWFhRrQX+qJcbPvCP
	 1X2HDyEAn6dCpP4PSmU9rDVxkcGzxkmCOD33ddxxe0NcfR3LkhNEpCrI/osM5QyaNA
	 MPt/lBXPFUJ4A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v18 00/15] MPTCP KTLS support
Date: Wed, 29 Apr 2026 18:44:48 +0800
Message-ID: <cover.1777459066.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v18:
 - add ip_ver field to tls_proto and pass it to tls_proto_find to
   distinguish IPv4/IPv6 instances   
 - convert tls_proto_mutex to spinlock, and convert tls_proto_cleanup
   to use call_rcu and rcu_barrier for softirq context compatibility
 - add tls_proto_put() for atomic refcount decrement + list_del +
   call_rcu, and simplify tls_ctx_free and tls_init error paths to use it
 - use GFP_ATOMIC for tls_proto allocation in tls_build_proto
 - reorder tls_register cleanup labels to unwind correctly on error
 - implement new mptcp_inq

v17:
 - remove owner from tls_prot_ops since both TCP and MPTCP are
   built-in and cannot be unloaded
 - add rcu_head to tls_proto for delayed freeing
 - replace synchronize_rcu with call_rcu in tls_ctx_free
 - remove module refcounting (try_module_get / module_put) from
   tls_build_proto and tls_init
 - simplify tls_proto_cleanup to directly free all protos without
   refcnt check
 - change tls_proto refcnt from 2 to 1 (only socket reference, no
   list reference)
 - move synchronize_rcu outside spinlock in tls_unregister_prot_ops
 - use kzalloc_obj instead of kzalloc to fix the checkpatch warning
 - update commit logs
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1777026753.git.tanggeliang@kylinos.cn/

v16:
 - drop rcu_head from struct tls_proto, use refcnt for lifecycle
   management.
 - add back TLS_NUM_PROTS to handle IPv4/IPv6 separately.
 - add .owner field to tls_tcp_ops and tls_mptcp_ops (THIS_MODULE).
 - add module refcounting (try_module_get / module_put) in tls_build_proto
   and tls_init.
 - add missing NULL check for tls_ctx->proto->ops in tls_sk_poll.
 - add RCU read lock protection in tls_register_prot_ops.
 - add error handling for tls_register_prot_ops calls in tls_register
   (with rollback on failure).
 - adjust MPTCP cleanup: move tcp_cleanup_ulp from mptcp_destroy_common
   to mptcp_destroy.
 - remove increase_rlimit from selftest and fix fd check.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1776924681.git.tanggeliang@kylinos.cn/

v15:
 - patch 1: add proto parameter for tls_toe_bypass.
 - patch 1: add a proto null-check in update_sk_prot.
 - patch 1: hold mutex_lock in tls_proto_cleanup.
 - patch 14: raise the limit of file descriptor values to 4096 to avoid
   test failures.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1776469068.git.tanggeliang@kylinos.cn/

v14:
 - address review comments from sashiko
 - patch 1: add rcu for tls_proto, add tls_proto_cleanup.
 - patch 2: add unregister helper.
 - patch 3: add tls_prot_ops pointer to tls_proto, instead of
   tls_context
 - patch 5: update mptcp_get_skb_seq, using map_seq - offset, then the
   patch "tls: add skb offset check for mptcp" can be dropped.
 - patch 7: check len < 0.
 - patch 8: call tcp_cleanup_ulp in mptcp_destroy_common.
 - patch 9: replace all "tls" as "espintcp" in sock_test_tcpulp.
 - patch 10: add is_mptcp_enable helper.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1775476921.git.tanggeliang@kylinos.cn/

v13:
 - patch 1: Add new patch "add per-protocol cache" to address AI review.
 - patch 2: Hold RCU read lock in tls_prot_ops_find().
 - patch 3: Set icsk_ulp_data to NULL in error path.
 - patch 6: Use spin_is_locked() instead of lockdep_is_held() to fix
   build errors.
 - patch 9: Drop tcp_sock_set_ulp().
 - patch 11: Remove the "return" statement in ulp_sock_pair and check
   the return values of socket().
 - patch 14: Update wait_for_tcp_close().
 - patch 16: Add a max argument to init() and set it to '0' to disable
   multipath testing, so that this series does not depend on the "mptcp:
   fix stall because of data_ready" series. Multipath testing will be
   re‑enabled together with that series later, as a squash‑to patch.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1775227717.git.tanggeliang@kylinos.cn/

v12:
 - Thanks for the help from Paolo and Gang Yan, I finally solved the
   deadlock issue in read_sock. As a result, the patch "mptcp: avoid
   sleeping in read_sock path under softirq" in v11 has been dropped,
   and instead a lock_is_held interface has been added to struct
   tls_prot_ops. When MPTCP implements this interface, it not only
   checks sock_owned_by_user_nocheck(sk) as TCP does, but also needs
   to check whether the MPTCP data lock is held.
 - Update selftests to make them more stable.
 - Fix shellcheck errors for the selftests.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1775115102.git.tanggeliang@kylinos.cn/

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
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1773911536.git.tanggeliang@kylinos.cn/

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

Gang Yan (1):
  mptcp: update mptcp_check_readable

Geliang Tang (14):
  tls: add per-protocol cache to support mptcp
  tls: introduce struct tls_prot_ops
  tls: add tls_prot_ops pointer to tls_proto
  mptcp: implement tls_mptcp_ops
  tls: disable device offload for mptcp sockets
  mptcp: update ulp getsockopt for tls support
  mptcp: enable ulp setsockopt for tls support
  selftests: mptcp: connect: use espintcp for ulp test
  selftests: tls: add mptcp variant for testing
  selftests: tls: increase pollin timeouts for mptcp
  selftests: tls: increase nonblocking data size for mptcp
  selftests: tls: wait close in shutdown_reuse for mptcp
  selftests: tls: add mptcp test cases
  selftests: mptcp: cover mptcp tls tests

 include/linux/tcp.h                           |   1 +
 include/net/mptcp.h                           |   2 +
 include/net/tcp.h                             |   1 +
 include/net/tls.h                             |  37 +++
 include/net/tls_toe.h                         |   3 +-
 net/ipv4/tcp.c                                |  45 ++-
 net/mptcp/protocol.c                          | 130 +++++++-
 net/mptcp/protocol.h                          |   1 +
 net/mptcp/sockopt.c                           |  53 +++-
 net/tls/tls.h                                 |   3 +-
 net/tls/tls_device.c                          |   6 +
 net/tls/tls_main.c                            | 279 +++++++++++++++---
 net/tls/tls_strp.c                            |  32 +-
 net/tls/tls_sw.c                              |   6 +-
 net/tls/tls_toe.c                             |   5 +-
 tools/testing/selftests/net/mptcp/.gitignore  |   1 +
 tools/testing/selftests/net/mptcp/Makefile    |   2 +
 tools/testing/selftests/net/mptcp/config      |   5 +
 .../selftests/net/mptcp/mptcp_connect.c       |   4 +-
 .../testing/selftests/net/mptcp/mptcp_tls.sh  |  62 ++++
 tools/testing/selftests/net/mptcp/tls.c       |   1 +
 tools/testing/selftests/net/tls.c             | 174 ++++++++++-
 22 files changed, 756 insertions(+), 97 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_tls.sh
 create mode 120000 tools/testing/selftests/net/mptcp/tls.c

-- 
2.53.0

