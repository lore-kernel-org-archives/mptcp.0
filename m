Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC4835F60E
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 01:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993278; cv=none; b=m2f9VLTi87/OnPaAaBMsH6EeQiuzPSAmw6ZLYBkkIJYkF3TGF/HcGAzGXAgdfGpkPfaSRlgFcRktE72Xldn9R8QiPnzT3XaEc8y+51N0xqmlONYP5HpbAM2i1hmAPpPi4xA/XsZehq65Fu28OzfULBrEHmqA0bSysnoYMQFMbjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993278; c=relaxed/simple;
	bh=3Cc+YiNW+6HUA05vAIurt2GqUhVGe7VyNbSZCYjuQe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jk35Pnsa8ajwQFO+a4VPKCGnRigIPUaejUNFZZwCI0ypPzV3uDkhMYw81Uhstn0o/WQxEnd7M6emaAs8ahVtYPQcIMdeGAB/naCqe+xJf+Lr5TS0au4xoq2NHeUGdXTjPsafN/HnkY2ZRk08jZ6NIZmgT2ebFqxXTpSigpO9Z94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsEQLB+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsEQLB+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F2A1F000E9;
	Tue, 14 Jul 2026 01:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783993277;
	bh=2TPldXw8XRlzhxJXDLNkWlgHzokxJKUpBsZ/5JzOufA=;
	h=From:To:Cc:Subject:Date;
	b=IsEQLB+DpOWSBfK7PQrXVwEgkgRm2Mr57c3JOym84uOl8eoojOT8PTQZ18Nt1tKdn
	 sFhGNnt/7W2wD3lnPQNN8vYyUqVpcf0syZWwIhCbBkn3sQk776h25cCVAKZc5zqlPL
	 6aD7WmC5E3QVIA2onw1ns1WHK8m7aoSBTtupuJlNQHQFIIxmVPxaZPfMwkrT2QX4Z+
	 sdwojg8WP34yE94iPg78k256b6QZ8A7accj8yXWfZB90Zuyq4ItBhSFteTGdGIOAq2
	 snDQzmeV16yXcjZeFo5UdI5vnaGeWTjWJCKkspxiSnNTdTV7bGNExCTn/eiPGzpdby
	 tSHFWFmNru/Vw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/7] mptcp: add MSG_ZEROCOPY support
Date: Tue, 14 Jul 2026 09:40:55 +0800
Message-ID: <cover.1783992745.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This series adds MSG_ZEROCOPY support for MPTCP sockets, allowing
userspace to transmit data without intermediate kernel copies, and
provides corresponding selftests to exercise the new path.

Patch 1 and patch 2 are small cleanups along the mptcp_sendmsg path.

Patch 3 implements the core MSG_ZEROCOPY support. The design
follows TCP's reference-counting model, with a single ubuf_info per
sendmsg, tracked by three reference buckets: one held by sendmsg itself,
one per MPTCP dfrag in the retransmission queue, and one per subflow SKB.
Completion is reported only after all bytes are acknowledged at both the
MPTCP and subflow levels. The feature is silently downgraded to a regular
copy in cases where zero-copy cannot be safely performed (MSG_FASTOPEN,
fallback mode, or memory pressure).

Patch 4 handles SO_ZEROCOPY in setsockopt.

Patch 5 and patch 6 add a new 'zerocopy' I/O mode to the mptcp_connect
selftest, along with a wrapper script to run it as part of the regular
test suite, ensuring the zero-copy path is exercised in CI.

Patch 7 is a small cleanup for mptcp_connect.c in the selftests.

v4:
- two more cleanups, patch 2 and patch 7.
- net/mptcp/protocol.c, mptcp_sendmsg_frag(): pull the type-mismatch
  check out of the if (can_coalesce) block and use the standard
  skb_zcopy_pure() helper; mptcp_sendmsg_zerocopy_iter() now
  calls iov_iter_revert() before put_page() in the kzalloc failure
  path so a retry starts from the same iterator offset.
- tools/testing/selftests/net/mptcp/mptcp_connect.c, copyfd_io_zc():
  reset msg_controllen each iteration of the inner reap loop using a
  do {} while block; use >= instead of > in the MPTFO size
  adjustment so file_size reaches 0 when the whole file is sent via
  fast open.

v3:
 - Force fresh skb when mixing zerocopy and kernel-copy fragments.
 - Simplify zero-copy availability check by using SOCK_ZEROCOPY flag
   directly.
 - Validate SO_ZEROCOPY value in setsockopt and avoid affecting
   fallback subflow.
 - In selftests, drain MPTFO partial data, use poll+recvmsg for completion
   notifications with timeout, and verify getsockopt round-trip.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1783913332.git.tanggeliang@kylinos.cn/

v2:
 - patch 2, never mix PURE_ZEROCOPY frags with kernel-copy frags in the
   same skb; handle fallback, return values.
 - patch 3, a new patch to handle SO_ZEROCOPY in setsockopt.
 - patch 4, set SO_ZEROCOPY, handle listen_mode, error queue.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1783821830.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1783774784.git.tanggeliang@kylinos.cn/

Geliang Tang (7):
  mptcp: use local variable tp in sendmsg_frag
  mptcp: remove redundant orig_offset in carve_data_frag
  mptcp: add MSG_ZEROCOPY support
  mptcp: handle SO_ZEROCOPY in setsockopt
  selftests: mptcp: connect: add zerocopy io mode
  selftests: mptcp: connect: cover zerocopy mode
  selftests: mptcp: connect: close listensock deterministically

 net/mptcp/protocol.c                          | 120 +++++++++++++--
 net/mptcp/protocol.h                          |   1 +
 net/mptcp/sockopt.c                           |  17 +-
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       | 145 +++++++++++++++++-
 .../net/mptcp/mptcp_connect_zerocopy.sh       |   5 +
 6 files changed, 267 insertions(+), 22 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh

-- 
2.53.0

