Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080142F851
	for <mptcp@lists.linux.dev>; Mon, 22 Dec 2025 03:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766373335; cv=none; b=FhnevTrA+hGpt7M/utEj9LNjKFVCOWjjwUknUiiVIqO3+4x30z/hm1k2Cmi+2j6RfQi88AM/8Dv845d6+mfEXCzKNWeJLBHQvSN2IpYb/bmm0oHvqllzQZgZNHFgTPGIyqT4eDrUaEUUPI7H+LhFvqXYv48sx0+PnY55HyCg6PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766373335; c=relaxed/simple;
	bh=c2i4lCIwhrhz4LKrjAHv4yujez8QzK/cL0AudHE8Rwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3tbrjWSXlt0jK0t+HUIeskirwex5ezwdS1ohMCm9qST8tBLXxlJ9g4CGfwtsEWi3HzmbuS/bQ6yGP8yvfoVujtUJOFg2cuGALugIHVfyQpiKyI6jc1WSi+L1d9wg6+szZZdNXhtZn6eQdtfAHWkZMK/TBoWKDIngrM0bWF4Rok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHLek5+F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHLek5+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F21C4CEFB;
	Mon, 22 Dec 2025 03:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766373334;
	bh=c2i4lCIwhrhz4LKrjAHv4yujez8QzK/cL0AudHE8Rwc=;
	h=From:To:Cc:Subject:Date:From;
	b=pHLek5+F1hzdyUueZYr/6gK7mcfSAJMMp/eDTObAltdqJgM5AYE/RYXl3TIJ7mw+U
	 6/EDDkj/iLila0ChnCPHj9fIdK6KHh/CdlttYkcbKOfZ6Jj8+rUmVTbnhUk0R81am0
	 2xUIoe2NJTMBlXSlqxN3HboZZXiJd5f+9RapAIOZVx9w86j5epcMsfbBYdfYANkSwN
	 iFLDmugvxjxZhupVEBZOoByTpSUW9mW2T/I/k1MgmuabFAKp7wmYBr7CSVFWlAal0L
	 stvWIQIp6IKlM7v+Ur9AkvcKV0BBB6w+dMp8EjJgVVpUg80C4cbnhbabj2dVNqk8y+
	 di4b2qGTg5D4Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v5 0/8] MPTCP KTLS support
Date: Mon, 22 Dec 2025 11:15:19 +0800
Message-ID: <cover.1766372799.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - As suggested by Mat and Matt, this set introduces struct tls_prot_ops
   for TLS.
 - Includes Gang Yan's patches to add MPTCP support to the TLS selftests.

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
  mptcp: fix the mptcp_check_readable
  selftests: tls: add a '--mptcp' test mode

Geliang Tang (6):
  tls: introduce struct tls_prot_ops
  mptcp: implement tls_mptcp_ops
  mptcp: update ULP getsockopt
  mptcp: enable TLS setsockopt
  selftests: mptcp: connect: update sock_test_tcpulp
  selftests: mptcp: sockopt: implement MPTCP KTLS tests

 include/net/mptcp.h                           |  12 ++
 include/net/tcp.h                             |   5 +
 include/net/tls.h                             |  44 ++++++++
 net/mptcp/protocol.c                          | 106 ++++++++++++++++--
 net/mptcp/sockopt.c                           |  31 ++++-
 net/tls/tls_device.c                          |   4 +-
 net/tls/tls_main.c                            |  14 ++-
 net/tls/tls_strp.c                            |  28 +++--
 net/tls/tls_sw.c                              |   5 +-
 tools/testing/selftests/net/mptcp/config      |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       |  20 ++--
 .../selftests/net/mptcp/mptcp_sockopt.c       |  76 ++++++++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  36 ++++++
 tools/testing/selftests/net/tls.c             |  56 +++++++--
 14 files changed, 393 insertions(+), 45 deletions(-)

-- 
2.51.0

