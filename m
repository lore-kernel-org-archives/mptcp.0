Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421995;
	b=2LB+sr6yxk5f21ZLDDvHbK0bGzC6sOqtZxlC00d3uTG74o6/hEsg7Q3LdByz37Vu5Aht
	 uuBCJpk/soaMKkwg2331f1stXorLlsU+jSdUuYoZH32DaF5XP3BHUThrOI3Z95HhLDE+z
	 MT+gixmRxPCWvtLmaoYlENtWkIp/GcPeCApIYc35JlIEg+SfSY4lhxvBI/OcVjVj04xsF
	 h4rlNpOVxsVATFrttnx5cqu+3LWjAGgeynvdT+jlU68i5QTCNzD4l90L8yq56giLAmFan
	 /RZds79cl+vp9/VrAlgk+JpiShuMEi6piqIzFlTn+OnyuQZatFj89/6n0Ln8ztrSHIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421995;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ORTPE55E8BukqxA3WyPCNUAQnssYPG09Uf0LE74XX3c=;
	b=sjN5Af5kPmBEDLaIuLN10ALBHprLnhFyQJdGBD9iD7eUiTgS3YtgGQyWkdciicv7vfhv
	 7P4Ag4jzFaJpXk3T/sc7uJyuTe5Rsfayw7xNH/JeYh5sEEtJfOqtMPMHrg4zLpMT8hMOC
	 xRLd/mFoKD7q4egVdS1YkfAtrtogDmehbqi6Og3PYib/aDWU4YnKziG9QWRdJ0g3T3MMp
	 gbmxTAdn7VflyhFgF9o+xjuyV9Jxe4RyMyraYPxvtf7O4l1hsIodRhKjA0GKi1fdfBYG0
	 mQsULv9Lplqd9jC/J8MT+XIOuj23tC3CSTSo+Ztegw0Juoqu/7Ya6NSI3T3JbJrRUxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNgYT3Af;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA439606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNgYT3Af
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AABB1F000CA
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795421995;
	bh=ORTPE55E8BukqxA3WyPCNUAQnssYPG09Uf0LE74XX3c=;
	h=From:To:Subject:Date;
	b=BNgYT3AfA0S3/ajVJ3tzA9INyl2fw25vgyF9zYR0sxAKNmo3pXXStjryc0O2iGW7X
	 8LxZ3GE6iLJ6M0P9HOaItmaQ2fbxu8KwGybK9Og1Uhkn+YPFv75pgOldKyR804N3rp
	 k3DhCR1Gnci+/BuTFGLJI2MEhm1njdVQVr+lWOkCfYGqbR8LcKQAOKkS/ZACcJBb0X
	 XAzDO7uoM27ZAjqp+SmfJKOo7+RvnE5DFCxJ+LuFGLP+8aOPeBEqpet0e/I7GMUcsU
	 zCvHItNBDU4I8BASyOh5weupAgdx8q2h7KcFgAIQY5OLxf8GiK7N8HMvcnHeX0JMIm
	 bHLc+CHR0vNcw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 0/7] mptcp: add MSG_ZEROCOPY support
Date: Mon, 23 Nov 2026 16:19:43 +0800
Message-ID: <cover.1795421388.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
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

Patch 3 removes the redundant orig_offset parameter from
mptcp_carve_data_frag() since it merely duplicates pfrag->offset.

Patch 4 implements the core MSG_ZEROCOPY support. The design
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

Patch 5 handles SO_ZEROCOPY in setsockopt.

Patch 6 adds a new 'zerocopy' I/O mode to the mptcp_connect selftest
to enable testing and performance validation of the zero-copy send path.

Patch 7 adds a wrapper script to run the zerocopy selftest as part of
the regular test suite, ensuring the zero-copy path is exercised in CI.

v8:
- Add pg_off + pg_len overflow check in mptcp_sendmsg_zerocopy_iter() to
  cap the sum at U16_MAX, preventing silent wraparound in dfrag->offset
  during partial ACK processing.
- Reorder kzalloc_obj() before sk_wmem_schedule() to eliminate erroneous
  sk_forward_alloc_add() on allocation failure path.
- Update caller to handle -EAGAIN/-ENOMEM by jumping to wait_for_memory,
  preserving blocking socket semantics.
- Refactor wait_for_completions_zc() to use clock_gettime(CLOCK_MONOTONIC)
  instead of loop counter, preventing premature exit when poll() returns
  immediately after shut_wr().
- Add retry loop in do_sendmsg_zc() to handle short writes from
  sendmsg(MSG_ZEROCOPY).
- Skip wait_for_completions_zc() when size is 0 to avoid 5-second stall on
  MPTFO transfers.

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
- https://patchwork.kernel.org/project/mptcp/cover/cover.1784260668.git.tanggeliang@kylinos.cn/

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

Geliang Tang (7):
  ipv4: fix uninitialized memory in zerocopy cmsg
  mptcp: use local variable tp in sendmsg_frag
  mptcp: remove redundant orig_offset in carve_data_frag
  mptcp: add MSG_ZEROCOPY support
  mptcp: handle SO_ZEROCOPY in setsockopt
  selftests: mptcp: connect: add zerocopy io mode
  selftests: mptcp: connect: cover zerocopy mode

 net/ipv4/ip_sockglue.c                        |   6 +
 net/mptcp/protocol.c                          | 165 +++++++++++++--
 net/mptcp/protocol.h                          |   1 +
 net/mptcp/sockopt.c                           |  17 +-
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       | 192 +++++++++++++++++-
 .../net/mptcp/mptcp_connect_zerocopy.sh       |   5 +
 7 files changed, 372 insertions(+), 15 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh

-- 
2.55.0

