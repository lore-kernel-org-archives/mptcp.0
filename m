Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5442303C8A
	for <mptcp@lists.linux.dev>; Fri, 17 Jul 2026 04:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263825; cv=none; b=I3SHgwskxsR2scwF7pZCldAlmcZ2KMMyOdh25I9UoOE29IJUdgvoA4E56m293fkjyOkDRdP92kDr5CWRTbbpnRw4lnYttb7XIV/BdJz1XPRPd16QhXQOtSTzMaEw/QEnGivNtGPBASRK2Ia6KqwKq+qc9SUFHhSj1Zkei4q/YcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263825; c=relaxed/simple;
	bh=5K1P+HrktY26CnugMAT9ItRepW8a5B/V6rX88rKEKvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T2kr8Wjl4P5kKxAJdtcVStK+yLrTr9o+sHPWR5Fv9LiC9FhKZQ2XZ2SwieJhh+dODuWXmyjWfeJvPvGsgHxb67/DX3M2IMJUp7zoFl3g+o9LtMJFAQBq8jJ60VcxrwlxaTlk42oFsJK2ITbyigIBtImozQtdBp0rBNZfJ47YtZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTvVH5Ga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTvVH5Ga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8A51F000E9;
	Fri, 17 Jul 2026 04:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784263823;
	bh=1Mp9aOjaL7+IDrrXpAwLvqWB8kyWNZ5HFmysuqAW3m0=;
	h=From:To:Cc:Subject:Date;
	b=ZTvVH5GaXJ8Tj57IUu4tinhjvDx6pP26sb5inVc2XV2DjRXDGUK1FE+Ekczck4XFn
	 aerHvjw1LYtQtxN1DU+BB0YK4+/soRNhcNdOHsoYvCDsOgKWXMMtOb1lPjq1LSvNZ4
	 ypjCANELkUvJKQneS63wfOo0dADAFpXZvEaNjXP+S/d5OZm//7/bhf+FtavBGWLGnv
	 mqMD3T9Nq7fKKFP87Jmnz6Q1NV2kZXDB87WPa+GefHknEsNzui1lemukx2fF1zqBG9
	 dDAPh3GNjOy6XCdYZlg3DJkIJdf2ztQrh98H6+08iDKT/frnoIh77IeL+jhLRxMTqg
	 7IC7+jvC0YsZA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 0/9] mptcp: add MSG_ZEROCOPY support
Date: Fri, 17 Jul 2026 12:50:09 +0800
Message-ID: <cover.1784260668.git.tanggeliang@kylinos.cn>
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

Patch 1 fixes an uninitialized memory leak in the IPv4 error queue
handling for zerocopy completion notifications by adding an early check
for SO_EE_ORIGIN_ZEROCOPY.

Patch 2 is a small cleanup along the mptcp_sendmsg path.

Patch 3 aligns struct mptcp_data_frag to 8 bytes on 32-bit architectures
to prevent unaligned 64-bit access faults on ARM, MIPS, and SPARC.

Patch 4 removes the redundant orig_offset parameter from
mptcp_carve_data_frag() since it merely duplicates pfrag->offset.

Patch 5 implements the core MSG_ZEROCOPY support. The design
follows TCP's reference-counting model, with a single ubuf_info per
sendmsg, tracked by three reference buckets: one held by sendmsg itself,
one per MPTCP dfrag in the retransmission queue, and one per subflow SKB.
Completion is reported only after all bytes are acknowledged at both the
MPTCP and subflow levels. The feature is silently downgraded to a regular
copy in cases where zero-copy cannot be safely performed (MSG_FASTOPEN,
fallback mode, or memory pressure). The new mptcp_sendmsg_zerocopy_iter()
helper caps pg_len to U16_MAX (reverting the excess from the iov_iter
on overflow) and returns -EFAULT when pg_off exceeds U16_MAX (which can
happen on 256KB-page kernels like PowerPC and Hexagon), so the u16
dfrag->data_len and dfrag->offset fields cannot wrap. The caller
accumulates the per-iteration byte count via the ssize_t return value.

Patch 6 handles SO_ZEROCOPY in setsockopt.

Patch 7 adds a new 'zerocopy' I/O mode to the mptcp_connect selftest
to enable testing and performance validation of the zero-copy send path.

Patch 8 adds a wrapper script to run the zerocopy selftest as part of
the regular test suite, ensuring the zero-copy path is exercised in CI.

Patch 9 is a cleanup for mptcp_connect.c that closes listensock
deterministically to avoid double-close or leaks across repeated
iterations.

v7:
- Add the pg_len / pg_off defensive truncation directly inside
  mptcp_sendmsg_zerocopy_iter() (the new helper in patch 5). When
  iov_iter_get_pages2() returns more than U16_MAX bytes, the excess
  is reverted from the iov_iter so the next iteration picks it up
  cleanly. When the page offset exceeds U16_MAX (on 256KB-page
  kernels like PowerPC and Hexagon), the call returns -EFAULT
  instead of silently truncating. The non-zerocopy path is left
  untouched.
- Refactor mptcp_sendmsg_zerocopy_iter() to return the per-iteration
  byte count as ssize_t so the caller can simply accumulate via
  copied += ret; this drops a ssize_t *copied out-parameter.
- Clean up and fix the zerocopy completion path in mptcp_connect.c

v6:
- Add patch 2 to widen offset field in struct mptcp_data_frag from u16 to
  u32 to support page sizes up to 4GB on architectures with large page
  sizes (256KB on PowerPC and Hexagon). This prevents offset wrap-around
  when page fragment offset exceeds 65535.
- Add patch 5 to fix uninitialized memory leak in IPv4 error queue
  handling for zerocopy completion notifications. Add early check for
  SO_EE_ORIGIN_ZEROCOPY in ipv4_datagram_support_cmsg() to prevent
  reading uninitialized memory from ip_hdr(skb)->saddr.
- Refactor zerocopy completion notification draining logic in selftests.
  Extract process_zc_cmsg() helper to process individual control messages.
  Extract drain_errqueue() helper to handle error queue draining.
  Simplify wait_for_zc_completions() main loop from 6 levels to 3 levels.
  Move variables to their actual usage scope for better maintainability.
- Use batched polling (200ms intervals with 5s total timeout) to drain
  completion notifications for large transfers that may generate multiple
  completion events.
- Parse error queue messages to verify all sent data has been ACKed before
  breaking the completion loop.
- Reset msg_controllen each iteration of the inner reap loop to prevent
  truncation of control messages.
- Use >= instead of > in the MPTFO size adjustment so file_size reaches 0
  when the whole file is sent via fast open.
- https://patchwork.kernel.org/project/mptcp/cover/cover.1784188064.git.tanggeliang@kylinos.cn/

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
- https://patchwork.kernel.org/project/mptcp/cover/cover.1784113088.git.tanggeliang@kylinos.cn/

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

Geliang Tang (9):
  ipv4: fix uninitialized memory in zerocopy cmsg
  mptcp: use local variable tp in sendmsg_frag
  mptcp: align struct mptcp_data_frag to 8 bytes on 32-bit
  mptcp: remove redundant orig_offset in carve_data_frag
  mptcp: add MSG_ZEROCOPY support
  mptcp: handle SO_ZEROCOPY in setsockopt
  selftests: mptcp: connect: add zerocopy io mode
  selftests: mptcp: connect: cover zerocopy mode
  selftests: mptcp: connect: close listensock deterministically

 net/ipv4/ip_sockglue.c                        |   6 +
 net/mptcp/protocol.c                          | 152 ++++++++++++--
 net/mptcp/protocol.h                          |   1 +
 net/mptcp/sockopt.c                           |  17 +-
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       | 186 +++++++++++++++++-
 .../net/mptcp/mptcp_connect_zerocopy.sh       |   5 +
 7 files changed, 343 insertions(+), 25 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh

-- 
2.53.0

