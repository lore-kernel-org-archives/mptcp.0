Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F161367B8E
	for <mptcp@lists.linux.dev>; Thu, 16 Jul 2026 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188287; cv=none; b=tfv0nF0unIMMOzrty2lF7UGHdXROI3qTAcGe3AN3j3fhgUM8m88Ev7d3Kn7mUZ1GNK/oHW1fBeyrb6wZbJOt9/VvfBaAQpTnkzf8LnAU5ED003KYV9imJysk/XNirF8wU1n8Omj5tFty07n9J3EKzrWAcix3+ys7pgmIyas37j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188287; c=relaxed/simple;
	bh=EWjR7+cMol+bskhDfSAyNG0H5AIEiSg05RFmaJnr5LM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cu/dqSkJ5taaknAdro3bvGn8nLpEi4Lq963lFKewHAewik4kafztMCZ7rco21jn+vt3go/c5SmqIGQOgaMn53fa5oRX0pcOl6hldCHjcHUaJVGIYgJuRbnHx1OZkDHRxZX50ZAvZPw97rHMlS/95zNEzPUbOyR92T7b/Dcq503g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UN6B3SKh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UN6B3SKh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA91F1F00A3A;
	Thu, 16 Jul 2026 07:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188285;
	bh=2hr8qdqLbhmb0x1Nq9JEuoSgytQztlK1yHmi7GlBeL4=;
	h=From:To:Cc:Subject:Date;
	b=UN6B3SKhTkBt8T1Er0TAGye2dsRxr2lS6ClzcPml/4ZVZVRmH0XEljM82Y/TMzUnh
	 VnivIqqUfXMojuuDI7RLAlRv6c0TagHXX3cNoTmK1s+qgaVqy39pJpsZDrlaodiowA
	 tZ5KENnNaAU/sLAFi5CBfZSvUzAyVLd2RkkOjWNv4x0amH5FzaKF8q2SMlQPuJO+8b
	 dQidoJSFf1SnnjSY7/UAe79OKOMsa2YHNJ4HYNFU9ru362Av3QOXqDhAW8hATPhWyk
	 BJVLtNFqQEQJjK9wPtDEF+yi3l/1es1WseyFy3kzptQ7nbJlSX7ZHkof4FPkN+SG1q
	 2VybbcZEs77GQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 00/10] mptcp: add MSG_ZEROCOPY support
Date: Thu, 16 Jul 2026 15:50:39 +0800
Message-ID: <cover.1784188064.git.tanggeliang@kylinos.cn>
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

Patch 3 widens the offset field in struct mptcp_data_frag from u16 to u32
to support page sizes up to 4GB on architectures with large page sizes
(256KB on PowerPC and Hexagon).

Patch 4 aligns struct mptcp_data_frag to 8 bytes on 32-bit architectures
to prevent unaligned 64-bit access faults on ARM, MIPS, and SPARC.

Patch 5 removes the redundant orig_offset parameter from
mptcp_carve_data_frag() since it merely duplicates pfrag->offset.

Patch 6 implements the core MSG_ZEROCOPY support. The design
follows TCP's reference-counting model, with a single ubuf_info per
sendmsg, tracked by three reference buckets: one held by sendmsg itself,
one per MPTCP dfrag in the retransmission queue, and one per subflow SKB.
Completion is reported only after all bytes are acknowledged at both the
MPTCP and subflow levels. The feature is silently downgraded to a regular
copy in cases where zero-copy cannot be safely performed (MSG_FASTOPEN,
fallback mode, or memory pressure).

Patch 7 handles SO_ZEROCOPY in setsockopt.

Patch 8 adds a new 'zerocopy' I/O mode to the mptcp_connect selftest
to enable testing and performance validation of the zero-copy send path.

Patch 9 adds a wrapper script to run the zerocopy selftest as part of
the regular test suite, ensuring the zero-copy path is exercised in CI.

Patch 10 is a cleanup for mptcp_connect.c that closes listensock
deterministically to avoid double-close or leaks across repeated
iterations.

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

Geliang Tang (10):
  ipv4: fix uninitialized memory in zerocopy cmsg
  mptcp: use local variable tp in sendmsg_frag
  mptcp: widen offset field in mptcp_data_frag to u32
  mptcp: align struct mptcp_data_frag to 8 bytes on 32-bit
  mptcp: remove redundant orig_offset in carve_data_frag
  mptcp: add MSG_ZEROCOPY support
  mptcp: handle SO_ZEROCOPY in setsockopt
  selftests: mptcp: connect: add zerocopy io mode
  selftests: mptcp: connect: cover zerocopy mode
  selftests: mptcp: connect: close listensock deterministically

 net/ipv4/ip_sockglue.c                        |   6 +
 net/mptcp/protocol.c                          | 139 ++++++++++--
 net/mptcp/protocol.h                          |   7 +-
 net/mptcp/sockopt.c                           |  17 +-
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       | 203 +++++++++++++++++-
 .../net/mptcp/mptcp_connect_zerocopy.sh       |   5 +
 7 files changed, 347 insertions(+), 31 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh

-- 
2.53.0

