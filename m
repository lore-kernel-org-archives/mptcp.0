Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF9A1C862F
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053256; cv=none; b=KNv0xoy604GOp9kuaZ0w+islbsy3DuCyQanhLT67qiiXpMsMyS2MwVND5k8VN7ZCOHIi8pjwzB//uyf/26O5WW/xybBxV0V4n7WDPbL/nYZgP8sHAyzKSb5X31J09YH1SYOPoP+RhmNGVd2vXyu4c0KMXxFDcFoy3TD1gLUa2C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053256; c=relaxed/simple;
	bh=Cnf6QQRVnBceHKxkSxRMAhzA498qLzhY2u6XrIigjpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hoKmfm9uyZfZbSrwx8pGI1M3m4EDCpHJK++gHxRF3VwLyC/g1k27z/GsaEpRvXCiAkUhxytev3prqOxAWVnKhZu9XFsxFRDQg8B/rKiS7tBLR/QEjxwclQEhFocIjZ0vbQ/0dt6MQkgPD409yxL0JF8UKaJy7eEYkrT6yNcKvig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWBUXfFC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWBUXfFC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103971F00893;
	Fri, 29 May 2026 11:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780053255;
	bh=b68s6U/nqAMYRLEv2oa9wxmIAyjTnGBDAEtgGmA4S30=;
	h=From:To:Cc:Subject:Date;
	b=VWBUXfFC5uEUzj8toQ9U3xpKJn8rLaBW+iKe0rnusywcVx1r7aXXXAQEhZA6CxIhn
	 QfJylUjoLo7korD183sWHRYY0zgXSrf+cr0Lu4w1Obp4QM8ckyZ4JUxaATnTccNDZ5
	 zRSU0vELSOZTDbwoOJZ2dxtBXQ1v7laDg1EFpTwPDzBoSQfLIQolxkkKsb93HoeqOU
	 BL+XqrM3cpzbdz6BEgKHKO4dw2v/x1c9YSzYODL5aK2ZKErux4rudjrLsKAgZUQLt0
	 vFOO4uShQUNPGgHH4PzStk/WCGGhpWwx/7x/kNjTIi9MHSUXIvO0zG0mlueeneqavT
	 EN8V6ly4bDnxg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v22 00/20] MPTCP KTLS support
Date: Fri, 29 May 2026 19:13:42 +0800
Message-ID: <cover.1780052851.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v22:
- patches 1-4 (new):
  - Add standalone fixes for TLS/TCP ULP issues, according to Sashiko
    comments on the previous version, and placed at the beginning of
    the series.
- patch 5 (merge of v21 01+02+05):
  - Add sk->sk_socket NULL check in tls_build_proto()
  - Update update_sk_prot() to use smp_store_release() for both sk->sk_prot
    and sk->sk_socket->ops
- patch 6 (was v21 03):
  - "tls: introduce tls protocol ops structure"
  - Add skb_copy_bits callback to struct tls_prot_ops, and initialize it in
    tls_tcp_ops as skb_copy_bits
- patch 9:
  - Add mptcp_skb_copy_bits(), implemented by Gang Yan, to handle
    fragmented MPTCP skbs when copying TLS record headers
- patch 20:
  - Enable multipath testing.
  - Depends on: mptcp: address stall under memory pressure, v10

Based-on: <cover.1780049797.git.pabeni@redhat.com>

v21:
- patch 1:
  - Rename struct tls_proto to struct tls_prot (including all related
    functions and variables) for clarity
  - Add missing rcu_barrier() in tls_prot_cleanup() to ensure all RCU
    callbacks complete before module unload
  - Fix module reference leak by adding module_put(prot->ops->owner)
    in the cleanup loop of tls_prot_cleanup()
- patch 2 (new):
  - split from patch 1.
- patch 5 (new):
  - Add memory barriers in tls_sk_poll() and tls_sw_sock_is_readable()
    to pair with smp_store_release() in update_sk_prot()
  - Replace direct tcp_poll() call with indirect call via
    tls_ctx->prot->ops->poll for proper MPTCP support
- patch 11:
  - Expand kernel config: add CONFIG_INET_ESP, CONFIG_INET_ESPINTCP,
    CONFIG_INET6_ESP, CONFIG_INET6_ESPINTCP to support espintcp ULP testing
- patch 12:
  - In ulp_sock_pair(), accept EOPNOTSUPP (in addition to ENOENT) when
    setting TCP_ULP fails, as MPTCP sockets may return this error
- patch 16 (new):
  - Add TEST_F_TIMEOUT(tls, multi_chunk_sendfile, 240) to prevent timeout
    failures on MPTCP configurations
-Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1779959644.git.tanggeliang@kylinos.cn/

v20:
- patch 1:
  - Use kfree_rcu() instead of synchronous kfree() in tls_proto_cleanup()
    and tls_proto_put() to prevent use-after-free for RCU readers
  - Add duplicate check under tls_proto_lock before inserting new tls_proto
    to list to prevent race condition
  - Fix reference counting: drop the initial reference from tls_build_proto()
    after successful tls_ctx_create() to prevent refcount leak
- patch 2:
  - Replace spin_lock() with spin_lock_bh() in tls_register_prot_ops()
    and tls_unregister_prot_ops() to avoid Lockdep splat (softirq context
    usage)
- patch 3:
  - Add memory barrier ordering in tls_sk_poll() to prevent NULL pointer
    dereference during concurrent setsockopt(TCP_ULP)
  - Move try_module_get() inside tls_prot_ops_find() while holding the lock
    to prevent ops structure from being freed before module reference is
    acquired
- patch 8:
  - Add missing fallback check __mptcp_check_fallback(msk) before calling
    mptcp_setsockopt_tcp_ulp() to prevent TLS being attached to fallback
    sockets
  - Re-check fallback status inside mptcp_setsockopt_tcp_ulp() after acquiring
    socket lock to eliminate TOCTOU race
- patch 10:
  - Remove unused _metadata parameter from is_mptcp_enable()
-Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1779788090.git.tanggeliang@kylinos.cn/

v19:
- Remove RCU from tls_proto and tls_prot_ops management
  Replace RCU with spinlock (tls_proto_lock) for all list operations.
  Remove rcu_head from struct tls_proto, eliminate call_rcu() and
  synchronize_rcu() calls. Use list_del + kfree directly in
  tls_proto_cleanup() and tls_proto_put().
- Add memory barrier in update_sk_prot()
  Use smp_store_release() when setting sk->sk_socket->ops to ensure it is
  not visible before icsk_ulp_data. Add explanatory comment to prevent
  NULL pointer dereference in concurrent tls_sk_poll() due to CPU
  reordering.
- Add module owner field to tls_prot_ops
  Add .owner = THIS_MODULE to tls_tcp_ops (and tls_mptcp_ops in MPTCP
  side). Add try_module_get(ops->owner) in tls_build_proto() before
  caching ops pointer. Add module_put(proto->ops->owner) in
  tls_proto_put() when releasing proto.
- Fix tls_toe_sk_destruct use-after-free
  Restore sk->sk_prot before calling original destructor to prevent UAF
  when __sk_destruct() accesses sk->sk_prot->destroy.
- Optimize indirect call performance
  Delay inq and get_skb_seq indirect calls in tls_read_flush_backlog()
  and tls_rx_msg_size() to avoid unnecessary retpoline overhead on fast
  path.
- Fix shutdown_reuse test flakiness
  Replace MPTCP-specific wait with generic bind retry loop. Retry bind()
  on EINVAL up to 1000 times (1 second) to handle asynchronous state
  transitions for both TCP and MPTCP.
- Remove redundant tls_ctx->proto->ops NULL checks
  Rely on memory barrier to guarantee ordering, eliminate unnecessary
  NULL checks that could introduce other issues.
- Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1779355169.git.tanggeliang@kylinos.cn/

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
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1777459066.git.tanggeliang@kylinos.cn/

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
   re-enabled together with that series later, as a squash-to patch.
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
  mptcp: update mptcp_check_readable helper

Geliang Tang (19):
  tls: add clone callback to prevent NULL accept crash
  tls: init mixed SW/TOE proto to prevent NULL call
  tls: add ESTABLISHED state check for TOE bypass
  tcp: add socket lock to TCP_ULP getsockopt
  tls: add per-protocol cache for MPTCP support
  tls: introduce tls protocol ops structure
  tls: store protocol ops pointer in tls_proto
  mptcp: implement mptcp-specific tls protocol ops
  tls: disable device offload for mptcp sockets
  mptcp: update ulp getsockopt for tls support
  mptcp: enable ulp setsockopt for tls support
  selftests: mptcp: connect: use espintcp for ulp test
  selftests: tls: add mptcp variant for testing
  selftests: tls: increase pollin timeouts for mptcp
  selftests: tls: increase nonblocking data size for mptcp
  selftests: tls: retry bind on EINVAL in shutdown_reuse
  selftests: tls: set timeout for multi_chunk_sendfile
  selftests: tls: add mptcp test cases
  selftests: mptcp: cover mptcp tls tests

 include/linux/tcp.h                           |   2 +
 include/net/mptcp.h                           |   2 +
 include/net/tcp.h                             |   1 +
 include/net/tls.h                             |  35 ++
 include/net/tls_toe.h                         |   2 +-
 net/ipv4/tcp.c                                |  53 ++-
 net/mptcp/protocol.c                          | 161 ++++++++-
 net/mptcp/protocol.h                          |   1 +
 net/mptcp/sockopt.c                           |  60 +++-
 net/tls/tls.h                                 |   2 +-
 net/tls/tls_device.c                          |   6 +
 net/tls/tls_main.c                            | 317 +++++++++++++++---
 net/tls/tls_strp.c                            |  33 +-
 net/tls/tls_sw.c                              |  27 +-
 net/tls/tls_toe.c                             |   6 +-
 tools/testing/selftests/net/mptcp/.gitignore  |   1 +
 tools/testing/selftests/net/mptcp/Makefile    |   2 +
 tools/testing/selftests/net/mptcp/config      |   9 +
 .../selftests/net/mptcp/mptcp_connect.c       |   4 +-
 .../testing/selftests/net/mptcp/mptcp_tls.sh  |  61 ++++
 tools/testing/selftests/net/mptcp/tls.c       |   1 +
 tools/testing/selftests/net/tls.c             | 159 ++++++++-
 22 files changed, 840 insertions(+), 105 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_tls.sh
 create mode 120000 tools/testing/selftests/net/mptcp/tls.c

-- 
2.53.0

