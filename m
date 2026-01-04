Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46D822F772
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767519316; cv=none; b=kP6saMzAlTaj6bLPkqC4G7iq/OF9YTgoGo8U21fmhxbJCn72/6GA6pCUCM7Cye9Yqv0EZHleEtpSGSbwKEhS/8amLF2hu3MzlbOV2jrFH6sF4EyuKwU6tmUwQsnf0Hmw5VMsZvT9L1jqFcXXYr9SOc6uAGsf3LLApk5tlgZLQFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767519316; c=relaxed/simple;
	bh=cPSnmRBOcxd5n0napk6UhDdlgtRphhZ4MBxEmYCwKRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QY2iIQb+nOEy2aaITyOBbOZ3+Wt+7hJHp04MPU7FAXGP9YsURyiNAPzGGxTmeLUSMpn+vQ7Va2FmJJg5TT7GowElu25TXYN6jqH+ykjVClESWYM8epGNl3MaqkW9JNUvTF/xsfbxxWe2mK8tpoLxTIxtmjGix1VJxNiuO/xF20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtPRigl7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtPRigl7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772BCC4CEF7;
	Sun,  4 Jan 2026 09:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767519316;
	bh=cPSnmRBOcxd5n0napk6UhDdlgtRphhZ4MBxEmYCwKRU=;
	h=From:To:Cc:Subject:Date:From;
	b=FtPRigl78b8bRNdw+1sxqX8785desBSg8151C5nWM/+Mgtx/PnfNVmHmPSiqw4/EV
	 JCBAIwepSR7fUqFjOmw7KJV8g59icC18DsjusucYmgXa1NV8jD+JXh9MVBl/BwkxJj
	 p/bUrN4bFrqBtw/bpEnXWr2lQIcFokTNAIAVK5tD578V0HbYRDwn1T0K7R1CE/cOUC
	 7yVBhvz6U9ytreJfwQxdkL5gtn1UR4WsFjmrHPQ5/G+1zFKkeQbAPEE5MMkp3zID8i
	 KY19f2SdGscJc8eDMwwo6whUoAAE/jLC5r1bH1/7yMGHlMA0JtcsqEp7y4TxKlq6D9
	 o/gCDuKdrxRew==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v6 00/10] MPTCP KTLS support
Date: Sun,  4 Jan 2026 17:35:01 +0800
Message-ID: <cover.1767518836.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v6:
 - register each ops as Matt suggested.
 - drop sk_is_msk().
 - add tcp_sock_get_ulp/tcp_sock_set_ulp helpers.
 - set another ULP in sock_test_tcpulp as Matt suggested.
 - add tls tests using multiple subflows in mptcp_join.sh.

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

Geliang Tang (10):
  tls: introduce struct tls_prot_ops
  tls: add ops in tls_context
  mptcp: implement tls_mptcp_ops
  tcp: extract sock_get_ulp helper
  mptcp: update ULP getsockopt
  tcp: extract sock_set_ulp helper
  mptcp: enable TLS setsockopt
  selftests: mptcp: connect: update sock_test_tcpulp
  selftests: mptcp: connect: add tls sockopt type
  selftests: mptcp: join: add mptcp tls tests

 include/linux/tcp.h                           |   2 +
 include/net/tls.h                             |  18 ++++
 net/ipv4/tcp.c                                |  78 ++++++++------
 net/mptcp/protocol.c                          | 100 ++++++++++++++++--
 net/mptcp/sockopt.c                           |  36 ++++++-
 net/tls/tls_device.c                          |   4 +-
 net/tls/tls_main.c                            |  88 ++++++++++++++-
 net/tls/tls_strp.c                            |  28 +++--
 net/tls/tls_sw.c                              |   5 +-
 tools/testing/selftests/net/mptcp/config      |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       |  65 +++++++++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  32 ++++++
 12 files changed, 398 insertions(+), 59 deletions(-)

-- 
2.51.0

