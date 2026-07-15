Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0481334692
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113443; cv=none; b=K30nW/13UpHEaUiAgOl4PC6wTe4sJ3fog6UKbE5xMEA5WrkVtn5NKAJoaN7Dlcp3LEXSbT3HRyongViyyqOOHIu4GNKurl0Kp58rC1jzZCruGoA0H6uTz+fMN+M5BvS0DXf6DuTO7h0w+4VudzQRJ1AlE9dJ+8mXpqA+4bL2jVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113443; c=relaxed/simple;
	bh=cD7X80lkbossrkxS/z/2t9sSu3vqhebyN3ZNGs8cTAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rP+2Rvw1oMz2P9gFXP3RWykVf8tXO56nTFdNcj+e/kPh4pYWqav7RNDG5XWlzSPFnPmUqbCSnUYRGCqCNuwQ1dY4dZibUGMKS+cwOsOazIqkVOne4EJGng+n1UBPdqu6HYMINDUv9DSDEJZ5QbkeF49Cm0ac+e5PG9yZHo5rMIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC2vdj/d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC2vdj/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDDE1F000E9;
	Wed, 15 Jul 2026 11:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784113441;
	bh=kxn3Pv5p8+hFpV3OM6O8eFg2Eb4UcNWx9Dyf8equnmQ=;
	h=From:To:Cc:Subject:Date;
	b=HC2vdj/dy6KTh1DY+EmlvF3Ji/pVsyb/LM18BvbvBOt1vJ+bia1Y/hVq8QE2hGV8y
	 zNOosCsEGfoFEHDavZRseWP7K+UKDyVK+dJaQsebMGYhwamlfgjbOm2Y6dxbOQT21/
	 ahQj2U7fuiCEsZstZewRjBrYVsPbAcj77+29NyCBCl7dt993e3e+ibPnjPlgENg6bD
	 0MFEUHYd/q56vGJ0cWVrzYl2rDNCL9WNxxGEzq5//2KxFKbmZoOLSXG/ONZOUHfIeV
	 jit/CNMRaJEC1KvyqzgF3GCe0S9HCxSpFief5bslgUpvfT8rTNUWJ/eIs+tAAp8rLf
	 sD4Q3dNibN6ag==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 0/8] mptcp: add MSG_ZEROCOPY support
Date: Wed, 15 Jul 2026 19:03:45 +0800
Message-ID: <cover.1784113088.git.tanggeliang@kylinos.cn>
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

Patch 1, patch 2 and patch 3 are small cleanups along the mptcp_sendmsg
path.

Patch 4 implements the core MSG_ZEROCOPY support. The design
follows TCP's reference-counting model, with a single ubuf_info per
sendmsg, tracked by three reference buckets: one held by sendmsg itself,
one per MPTCP dfrag in the retransmission queue, and one per subflow SKB.
Completion is reported only after all bytes are acknowledged at both the
MPTCP and subflow levels. The feature is silently downgraded to a regular
copy in cases where zero-copy cannot be safely performed (MSG_FASTOPEN,
fallback mode, or memory pressure).

Patch 5 handles SO_ZEROCOPY in setsockopt.

Patch 6 and patch 7 add a new 'zerocopy' I/O mode to the mptcp_connect
selftest, along with a wrapper script to run it as part of the regular
test suite, ensuring the zero-copy path is exercised in CI.

Patch 8 is a small cleanup for mptcp_connect.c in the selftests.

v5:
- A new patch to align struct mptcp_data_frag to 8 bytes on 32-bit.
- Prevent coalescing of dfrags with different ubuf instances into the same
  subflow skb to avoid premature completion notifications.
- Return -EFAULT instead of -EAGAIN when iov_iter_get_pages2() returns 0
  to properly signal iterator exhaustion.
- Account for dfrag metadata overhead in sk_wmem_queued_add() to prevent
  bypassing socket memory limits.
- Widen data_len field from u16 to u32 to prevent truncation on 64KB-page
  kernels (ARM64, PPC64).
- In selftests, use batched polling (200ms intervals with 5s total timeout)
  to drain completion notifications for large transfers that may generate
  multiple completion events.

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
- https://patchwork.kernel.org/project/mptcp/cover/cover.1783992745.git.tanggeliang@kylinos.cn/

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

Geliang Tang (8):
  mptcp: use local variable tp in sendmsg_frag
  mptcp: align struct mptcp_data_frag to 8 bytes on 32-bit
  mptcp: remove redundant orig_offset in carve_data_frag
  mptcp: add MSG_ZEROCOPY support
  mptcp: handle SO_ZEROCOPY in setsockopt
  selftests: mptcp: connect: add zerocopy io mode
  selftests: mptcp: connect: cover zerocopy mode
  selftests: mptcp: connect: close listensock deterministically

 net/mptcp/protocol.c                          | 134 ++++++++++++++--
 net/mptcp/protocol.h                          |   3 +-
 net/mptcp/sockopt.c                           |  17 +-
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       | 146 +++++++++++++++++-
 .../net/mptcp/mptcp_connect_zerocopy.sh       |   5 +
 6 files changed, 280 insertions(+), 26 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh

-- 
2.53.0

