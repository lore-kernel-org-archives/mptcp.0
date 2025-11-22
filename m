Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B39212F98
	for <mptcp@lists.linux.dev>; Sat, 22 Nov 2025 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763801133; cv=none; b=stNRzEuDg6z7KTkV2JNG1xZWbrnhRmcZk37N/CVSCwB+237RYOcEmQbZG4oMnShABRiylfCsqS1XqzMHxRHgw5mDvZbtiAsoobjCZOiLbraRpe4a1AfbqHQMzhsjiHuixkOcS/h3NHXmb4yqwB1hgQXVXmx+s6VGHamSKeRMUYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763801133; c=relaxed/simple;
	bh=3aQchSjbK7clPUxleNN0Sf7pMw17q2hngEMpAWx/7s8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LxXtDN8om/kx1S1P5lE/2gVcx3Vj+rsmCnA8TSdmhkEHhdDwjLBjj2HptGYODfjqkCalWkP1c/3+blt4/mwT2su7f6U6OR9G5E6k64AVQAH3ZoecCvxLtysfLb2yQT4xa/nGKqxNhNGBC/WEc73IBz/rFM2FNUCmy8j83V4RB20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fqua7Ib0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fqua7Ib0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F343C4CEF5;
	Sat, 22 Nov 2025 08:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763801132;
	bh=3aQchSjbK7clPUxleNN0Sf7pMw17q2hngEMpAWx/7s8=;
	h=From:To:Cc:Subject:Date:From;
	b=Fqua7Ib0GkfjiJbMXYARbgPnnF9tVgIcKny/1uL6u08oHCmf+03QtzbSCEbvnXoxH
	 KIYyKbeLuIFCGsHhVcso2HYObs9JIbVKAbeBRf1X6awJotXjxWHSlc1FNp0nbxv5zg
	 fZLod1ieHjGfKDXQ6qPaBtK5/cPRvttq+lFzqLa+V2JqIQwqzUufLfemZYq0SeRu85
	 I2sP7pQISq4b2lYe10hYIam+ZBWtK3w6iXsShC9DXrESCg8o4AyANshMxOroAW2MXb
	 HeTYPkQiRWtFrNeCmO9z/z3hFOU0JyBSKe/Y9eSiGU0qzDL+rCjJZyjicKp9tB6HFv
	 G0xXPheHBT2eA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v3 0/8] MPTCP KTLS support
Date: Sat, 22 Nov 2025 16:45:19 +0800
Message-ID: <cover.1763800601.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - mptcp_read_sock() and mptcp_poll() are not exported, as mptcp_sockopt
   test does not use read_sock/poll interfaces. They will be exported when
   new tests are added in the future.
 - call mptcp_inq_hint in tls_device_rx_resync_new_rec(),
   tls_device_core_ctrl_rx_resync() and tls_read_flush_backlog() too.
 - update selftests. 

v2:
 - fix disconnect.
 - update selftests.

This series adds KTLS support for MPTCP. Since the ULP of msk is not being
used, ULP KTLS can be directly configured onto msk without affecting its
communication.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/480

Depends on: implement mptcp read_sock, v13
Based-on: <cover.1761198660.git.geliang@kernel.org>

Geliang Tang (8):
  selftests: mptcp: sockopt: add protocol arguments
  selftests: mptcp: sockopt: enhance compatibility with TCP tests
  selftests: mptcp: sockopt: implement TCP TLS tests
  tls: add MPTCP protocol support
  mptcp: update ULP getsockopt
  mptcp: enable TLS setsockopt
  selftests: mptcp: connect: update sock_test_tcpulp
  selftests: mptcp: sockopt: cover MPTCP KTLS test cases

 include/net/mptcp.h                           |  33 +++++
 net/mptcp/protocol.c                          |  62 +++++++--
 net/mptcp/sockopt.c                           |  30 ++++-
 net/tls/tls_device.c                          |   8 +-
 net/tls/tls_main.c                            |   6 +-
 net/tls/tls_strp.c                            |  16 ++-
 net/tls/tls_sw.c                              |   4 +-
 tools/testing/selftests/net/mptcp/config      |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       |  36 +++--
 .../selftests/net/mptcp/mptcp_sockopt.c       | 125 ++++++++++++++++--
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  36 +++++
 11 files changed, 315 insertions(+), 42 deletions(-)

-- 
2.51.0

