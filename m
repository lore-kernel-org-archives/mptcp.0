Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20302F532F
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 01:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773366192; cv=none; b=LlbknJbMXqkGwkywlPT53VVi1r2BGFZAlzv+C1H8kRf4zJMEErU0s1+erVXcaSI142F/osvQtgZ2XhR6eVKqFitn8PG0T+TOUd7oruJFp18sn358PrOdYwj9vlR+91Catri02NRHs0BRnLqE+deOz1E1pCrgtF1ISuvR5FS9INg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773366192; c=relaxed/simple;
	bh=0Hwb0y/9ikSiaqMo0Wle9GoEe3xiJNlAU5kjr7+Lz+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oEJzHpHZXbr91swMPC72n/GY3+lyQq0ett0Vfz+nopC/qhueKI0EZI863LI/ixD0GLwxgZePcpvXpKC93Mr9koJWT+q1ZRJywRVyqtAf1zrckcP/dt9+hjeGkEHgmqzJAf9LWMokqSH3RIlD70SBTF+gmK7vMFNcpoiSC1KVMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/GePR5v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/GePR5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EAAC4CEF7;
	Fri, 13 Mar 2026 01:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773366192;
	bh=0Hwb0y/9ikSiaqMo0Wle9GoEe3xiJNlAU5kjr7+Lz+4=;
	h=From:To:Cc:Subject:Date:From;
	b=Z/GePR5vAVShdB7HTY2Ggkl3Tib0VezoLIIxUGIukD9Edp9cuUV7eIX8s/tqrhz3F
	 MUlDiCV9Vtemb1mJ6hC9XGwFCQYl10pXTWDgaPkl7GT1gXYcjWT60KqmWO+rGfWvmc
	 cKpciokmW+gHCpVWBW2pbYYPv8sF4yhRtP+ReuT9t3FyHzshC5QElKlacxWW0qxpq6
	 VlTaxWfW6TO9hMxld1phq+9je4FG0Y3oyidlvyF4c0UrJ/YPgGTv2wzpc7QJVJL/GR
	 BWq/R+iGwX2SZcfm479YCj/OJdwccV3Wuh8BCpuNpoDLT1x1m+669LuSEK7kS16bVw
	 1dePCih/Bz9zg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v9 00/10] MPTCP KTLS support
Date: Fri, 13 Mar 2026 09:42:42 +0800
Message-ID: <cover.1773365606.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v9:
 - add a new patch to "add MPTCP SKB offset check in strp queue walk",
   thanks to Gang Yan for the fix.
 - add a new patch to "avoid deadlocks in read_sock path", replacing the
   "in_softirq()" check used in v8.
 - update the selftests.

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
  mptcp: update mptcp_check_readable

Geliang Tang (8):
  tls: introduce struct tls_prot_ops
  tls: add ops in tls_context
  mptcp: avoid deadlocks in read_sock path
  mptcp: implement tls_mptcp_ops
  mptcp: update ULP getsockopt
  mptcp: enable TLS setsockopt
  selftests: mptcp: connect: set smc instead of tls
  selftests: mptcp: connect: add TLS tests

 include/linux/tcp.h                           |   2 +
 include/net/mptcp.h                           |   2 +
 include/net/tcp.h                             |   1 +
 include/net/tls.h                             |  20 +++
 net/ipv4/tcp.c                                |  87 +++++++-----
 net/mptcp/protocol.c                          | 131 +++++++++++++++---
 net/mptcp/protocol.h                          |   1 +
 net/mptcp/sockopt.c                           |  37 ++++-
 net/tls/tls_main.c                            | 107 +++++++++++++-
 net/tls/tls_strp.c                            |  31 +++--
 net/tls/tls_sw.c                              |   7 +-
 tools/testing/selftests/net/mptcp/config      |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       |  49 ++++++-
 .../selftests/net/mptcp/mptcp_connect.sh      |  33 +++++
 14 files changed, 438 insertions(+), 71 deletions(-)

-- 
2.53.0

