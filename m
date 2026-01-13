Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00E3128AE
	for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768295366; cv=none; b=FyM/0a1dSblj/NcUUdps90Q1n69Y2WFvtB71MzvnjqRpowSkXLoKvkBpQ2l2hqNtyFpHqqeFjvBxY9RUKGd7G6bt2fKO5eIQz73M7mw/6NjGE4v9qFeddCzVuit3R36UQAwv5uAmaY0VwBo5wqIWA6nFQfz1Nook/kY0rYByIS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768295366; c=relaxed/simple;
	bh=T1ZUltaEFuIXBUW2QYb6KIMq+nyE3gvIRGc2A4N4Da4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSIIMY0Q8/6eL84NhpqBRC8gkIec8R4MAYku/OmhPcysP/s32hsJfpSyW4wpk1lM1Ue4coMo049YMYFn08MSgCgFK1iQCDw49wURrZ8gNuqr8VoTxOd0x8ePWenNpuZDneCy4aQX8WSqTCNdfg5THZhfmxT7BbAptcMmDaFw0IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FayppH02; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FayppH02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7A8C116C6;
	Tue, 13 Jan 2026 09:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768295365;
	bh=T1ZUltaEFuIXBUW2QYb6KIMq+nyE3gvIRGc2A4N4Da4=;
	h=From:To:Cc:Subject:Date:From;
	b=FayppH02zb2J1BDnUrzqJ2n1z7bVwgWPpkuxvOBozCsNsHe2kqCicvRjbVUbSuMdL
	 wvSoCIDlBNt3u3O1UbTZoiKDsrPw5G9FlMdwwX6YXfePZ4qC0FwkDBOHAgeRgolL5z
	 tkC8MbWw5nyGLYjHLADTT/9iMyFCvEt17gkCaGKwKTxlLGKz1cr6C0MUwZU7b+zScF
	 Bjl6L08qG6gErepR7sBkbOkoOcnMohY+g1LyDNg+jWH9FN28CF7nVItqKeFsHJySkc
	 BaYad8VMQtlWQ53h5U9JuJMD2WrP81VVGsKhJiTdwkQ1UA06eZsK1nSFF4DLVUj2Dm
	 vAMoUeLcrAnOg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v8 0/9] MPTCP KTLS support
Date: Tue, 13 Jan 2026 17:09:08 +0800
Message-ID: <cover.1768294706.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v8:
 - do not hold tls_prot_ops_lock in tls_init(); otherwise, a deadlock
   occurs.
 - change return value of mptcp_stream_is_readable() as 'bool' to fix the
   "expected restricted __poll_t" warning reported by CI.
 - fixed other CI checkpatch warnings regarding excessively long lines.

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
  mptcp: allow overridden write_space to be invoked
  mptcp: update mptcp_check_readable

Geliang Tang (7):
  selftests: mptcp: add tcp tls tests
  tls: introduce struct tls_prot_ops
  tls: add ops in tls_context
  mptcp: implement tls_mptcp_ops
  mptcp: update ULP getsockopt
  mptcp: enable TLS setsockopt
  selftests: mptcp: add mptcp tls tests

 include/linux/tcp.h                           |   2 +
 include/net/mptcp.h                           |   2 +
 include/net/tcp.h                             |   1 +
 include/net/tls.h                             |  19 +++
 net/ipv4/tcp.c                                |  78 ++++++-----
 net/ipv4/tcp_rate.c                           |   9 +-
 net/mptcp/protocol.c                          | 125 ++++++++++++++++--
 net/mptcp/protocol.h                          |   2 +-
 net/mptcp/sockopt.c                           |  37 +++++-
 net/tls/tls_main.c                            |  91 ++++++++++++-
 net/tls/tls_strp.c                            |  28 ++--
 net/tls/tls_sw.c                              |   7 +-
 tools/testing/selftests/net/mptcp/config      |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       |  53 +++++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  45 ++++++-
 15 files changed, 436 insertions(+), 64 deletions(-)

-- 
2.51.0

