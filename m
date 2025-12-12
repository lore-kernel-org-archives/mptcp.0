Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DD226A1B9
	for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 02:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765506446; cv=none; b=rJaMj8EGkzNxkYN39cakXkxXexN6pV+eWZQlh6+DHHsCCWd6DkuKH/DqpuLw2djfeDVjA4Zpwl7mBntPO8mIspN8+e/S0nc9EnN+Xo3BwqmSf/jf6YUGqeNHa8qX67+LHlbJnAgCrn+BaC/7lclQvC9Pu1tu1I1WD9wC10QSrco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765506446; c=relaxed/simple;
	bh=BZYroU2HfSC31S50ot+88O47xFRpwOF9VLx5qgxSMpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RACa1s+BJsPGTgr+hTbQbsOEpNlEy8aFVbnmrB/7QTv9fdipndh9LrvTRxZDh0BV8+3kuSreQAvQv3iR8koOUwW6P/mzMF+JYL4DtGu59j10PsNEHEsNONhGYoqeI/9ItOHkJZdVNfU3FoaqFKasMOaqP4oQ1KTZ6oEzuoz6Wa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSnYAS9O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSnYAS9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E363C4CEF7;
	Fri, 12 Dec 2025 02:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765506445;
	bh=BZYroU2HfSC31S50ot+88O47xFRpwOF9VLx5qgxSMpw=;
	h=From:To:Cc:Subject:Date:From;
	b=CSnYAS9OSONVmaWMhQN2HZbkVx2IvkorYTJVaeww1DNSjlg3U2bhK2yBXfYiXeDLs
	 yFx0cG+a602V/5BusOPd10mwiJQa95czmY2SA8VoUc7ZgBnnZH8pBYooYTbqUpNBPP
	 5ufeQT5trdka0KnJBaViRtG4BqVXGcu4q0TDKqbozfPhr4oIn0lC95JHTp40kKoKMR
	 9dh4lmtuhNWgMNlWdZvR6FDTRTmRhD7R+v+62D67OyT0gdc5AarMHnbJx2QzJz43XQ
	 KcK6yZiCcp72AOfnc2rxsUzED9cUBm3+smIvPOBkR7S11CIyiyMMQcZVO4jnWkS3HQ
	 5JKcgkFxmB2yg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v4 00/10] MPTCP KTLS support
Date: Fri, 12 Dec 2025 10:27:10 +0800
Message-ID: <cover.1765505775.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
  mptcp: add sk_is_msk helper
  tls: switch to MPTCP_SKB_CB
  tls: switch to mptcp_inq
  tls: switch to mptcp_sendmsg_locked
  tls: switch to mptcp_recv_skb
  tls: switch to mptcp_read_done
  mptcp: update ULP getsockopt
  mptcp: enable TLS setsockopt
  selftests: mptcp: connect: update sock_test_tcpulp
  selftests: mptcp: sockopt: implement MPTCP KTLS tests

 include/net/mptcp.h                           | 48 ++++++++++++
 net/mptcp/protocol.c                          | 66 ++++++++++++++--
 net/mptcp/protocol.h                          | 10 ---
 net/mptcp/sockopt.c                           | 30 +++++++-
 net/tls/tls_main.c                            |  4 +-
 net/tls/tls_strp.c                            | 24 ++++--
 net/tls/tls_sw.c                              |  8 +-
 tools/testing/selftests/net/mptcp/config      |  1 +
 .../selftests/net/mptcp/mptcp_connect.c       | 20 +++--
 .../selftests/net/mptcp/mptcp_sockopt.c       | 76 ++++++++++++++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 36 +++++++++
 11 files changed, 289 insertions(+), 34 deletions(-)

-- 
2.51.0

