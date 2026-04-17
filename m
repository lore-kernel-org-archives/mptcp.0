Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9796E30AAD8
	for <mptcp@lists.linux.dev>; Fri, 17 Apr 2026 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776469700; cv=none; b=XGbq+Qsj/re+h6wy6ekD1wzNY9BAVzYMEcwyxzqqs4IMgI5YeNQXquz9QY31ESXhxHYmxfW2tVx48Jg3LA9w50FNAff/9dIFX1gI46vpijujCgMbYquvGKzqkhsAM03rf0ouv5+gvvjIkKL1TBOYSE9s1yWLv4F34iPPY8qSzKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776469700; c=relaxed/simple;
	bh=7VuirBzz4P5wTWsQpLcIA/AbG+iihhDryydHldLBM94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j5u398YfC6jc6jZit8k/rq2QSyDXcxpbxg+DUpGFAk0QAI6f2O1F786HudX6yYmvYxFn/TNWLJOcTjmUNzgxZAG9G3TKbwKmcZgcCXnm8CTpa4LtcyISDdLNXDL1MmBvbN1lHabk1QKVDz0ZgEkzabka9guB5FN0XlUibNI0eHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaEf5+hn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaEf5+hn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED87C19425;
	Fri, 17 Apr 2026 23:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776469700;
	bh=7VuirBzz4P5wTWsQpLcIA/AbG+iihhDryydHldLBM94=;
	h=From:To:Cc:Subject:Date:From;
	b=iaEf5+hnI/8EiY4RfRB8VcYJZpJfgnS7O/2jYoGDdyhb+6p5Syzp4G5uj8Qy/3lCG
	 FrhEhRE9TDd8+nBKmeZSy3zx/1WgZiGszkJlyaxB+Z9SGZX4B9U/khCGRuTmSFIHRI
	 GR5LkiPlpiwDcLHHtqMUbQteAPvRpMHg1z/D+nLIplWOHyiLQscuQJi75D3IaKf41k
	 PAJm+F7iZbt0Mq/msnXd21wdmiIuouHu+iLMWKbNs6KyGd9QVJW4VseQws9IHL86lL
	 7b/XjTWmgwn8dqrWJWL42yhINMFhjYgiIQCjG2X14fO3vgGDILEEN3Wl/cssIjh0H8
	 hUlLTLxIKICgA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v15 00/15] MPTCP KTLS support
Date: Sat, 18 Apr 2026 07:47:39 +0800
Message-ID: <cover.1776469068.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v15:
 - patch 1: add proto parameter for tls_toe_bypass.
 - patch 1: add a proto null-check in update_sk_prot.
 - patch 1: hold mutex_lock in tls_proto_cleanup.
 - patch 14: raise the limit of file descriptor values to 4096 to avoid test failures.

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
 include/net/tls.h                             |  30 +++
 include/net/tls_toe.h                         |   3 +-
 net/ipv4/tcp.c                                |  45 ++--
 net/mptcp/protocol.c                          | 117 ++++++++-
 net/mptcp/protocol.h                          |   1 +
 net/mptcp/sockopt.c                           |  53 +++-
 net/tls/tls.h                                 |   3 +-
 net/tls/tls_device.c                          |   6 +
 net/tls/tls_main.c                            | 231 ++++++++++++++----
 net/tls/tls_strp.c                            |  33 ++-
 net/tls/tls_sw.c                              |   7 +-
 net/tls/tls_toe.c                             |   5 +-
 tools/testing/selftests/net/mptcp/.gitignore  |   1 +
 tools/testing/selftests/net/mptcp/Makefile    |   2 +
 tools/testing/selftests/net/mptcp/config      |   5 +
 .../selftests/net/mptcp/mptcp_connect.c       |   4 +-
 .../testing/selftests/net/mptcp/mptcp_tls.sh  |  62 +++++
 tools/testing/selftests/net/mptcp/tls.c       |   1 +
 tools/testing/selftests/net/tls.c             | 184 +++++++++++++-
 22 files changed, 699 insertions(+), 98 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_tls.sh
 create mode 120000 tools/testing/selftests/net/mptcp/tls.c

-- 
2.51.0

