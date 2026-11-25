Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591389;
	b=sDTuXNSNelzOA2FYH8CXxcAygWCTKiAn6mq6eCqVapwWKi8YrOITfClOufc9kme1m/WP
	 OKm9mrOr6c/dMnVrk2V1O5fPNZ1bDE6X9/1mtsezo0w5tgTodjtgwniJl93RObkBK6cii
	 I4l4vIX8EBNpCmYa1xMsARin3SFyznPuIy/LZXKkBgwzKiYd3IL4BnqtZL4TKokiAUMPQ
	 wE9oJebrG+3PSPUqarjlOVkCIpmNYnSgsuE9GJbipdxxfGwfXjwlWNck1cIi/tOP9YF0L
	 XrMLFMFovmH7du6OkmPFfNC2uztuj1tz62xGqXxogGa9utHJgAmbB+HgC/ehKXLC06A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591389;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WmX6kN4rzhJg2sGs35sVRXc00lhJI4Vfsl1NFKXqaa0=;
	b=O1xJXYjnkK4KDxlr3/DqLGXpegkRPP9oB7y+nJI8H8bEtuNYLf1fXpwC7RoeOKNmxty/
	 eAF9q+f6pXqAvHJQYHf9LuDdJcyQt/9cqU20F+tcIufpmdCNhfJp/ESBRFrAUP/A+ZrLb
	 gcA+N5pNovkB0RJ1VQInSf01pk9ZSsygje8AlthVxagym26I9KivIUv2Ozg0ldQr7lwVr
	 bjLhg8wLnQg4BOwjObhaEWWgFrQUElPEnZikD3Bj/FQIUx5Nc+8KGP1Ef71VtA1K4Omio
	 Sa3d5rcUJyOHaaxHZUsN6xOpy/AZRnv8UklB8btG/eH0DS+0wDEmDV3fQ3d4AAJkLkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4NgL8J3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D43606A31E
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4NgL8J3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087121F000C0
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 07:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795591389;
	bh=WmX6kN4rzhJg2sGs35sVRXc00lhJI4Vfsl1NFKXqaa0=;
	h=From:To:Subject:Date;
	b=j4NgL8J3YRP5G1f+dNd6bDEC7Ofs3Xhe5PGdnTXQwa1cJPr6NQBD1ta3wZT5fVfVx
	 /3ZdtoAc1bs9AhP5ctPxDrxeUwXV94nIHDtZjjXQ+UFrRwgH/NMG6QOn0zU+Idtgr/
	 xSQyPaRAWnsFNp7mrBNoj7IGtxD5C2iupJodJmRMCBGYUx0LkdwX6IE+uJxupysNDp
	 KKaC0Uiv2SJFQLo1Z3V7SJa1g/65nZymWOYvNcxzyJU3exRw0qFWyczGGVzogSiIyh
	 3Iv9hOH5JkltKg8jIrYOb34NO3gpMXkixsUvKPwqIeEWshcYQqUfO6yhUFuU0YGUgN
	 z6n/dCczOlUhw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v9 0/7] mptcp: add MSG_ZEROCOPY support
Date: Wed, 25 Nov 2026 15:22:58 +0800
Message-ID: <cover.1795591278.git.tanggeliang@kylinos.cn>
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

v9:
- drop "ipv4: fix uninitialized memory in zerocopy cmsg".
- patch 3:
  The dfrag memory accounting now uses PAGE_SIZE for zerocopy dfrags
  instead of the actual data length, and sk_wmem_schedule checks are
  skipped for zerocopy paths.
  A page reference leak was fixed when iov_iter_get_pages2 returns zero.
  mptcp_sendmsg_fastopen helper now accepts and forwards the ubuf
  parameter.
  Error handling has been improved by using uarg_to_msgzc()->zerocopy = 0
  instead of net_zcopy_put_abort, and the success path now checks ubuf
  directly rather than the zc flag.
  Additionally, MSG_FASTOPEN flag clearing is handled separately from the
  SOCK_ZEROCOPY check.
- patch 4:
  mptcp_setsockopt_sol_socket_zerocopy helper now increments the setsockopt
  sequence counter and iterates through all subflows, setting SOCK_ZEROCOPY
  on each one and updating their setsockopt_seq values.
  Additionally, sync_socket_options has been updated to synchronize the
  SOCK_ZEROCOPY flag to keep subflows consistent with the msk.
- patch 5:
  Documentation has been updated to reflect MPTCP support in the
  msg_zerocopy guide.
- patch 6:
  add mptcp support for selftests msg_zerocopy.c.

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
- https://patchwork.kernel.org/project/mptcp/cover/cover.1795421388.git.tanggeliang@kylinos.cn/

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
  mptcp: use local variable tp in sendmsg_frag
  mptcp: remove redundant orig_offset in carve_data_frag
  mptcp: add MSG_ZEROCOPY support
  mptcp: handle SO_ZEROCOPY in setsockopt
  Documentation: msg_zerocopy: add MPTCP support
  selftests: net: msg_zerocopy: add MPTCP support
  selftests: mptcp: cover msg_zerocopy test

 Documentation/networking/msg_zerocopy.rst     |   4 +-
 net/mptcp/protocol.c                          | 173 ++++++++++++++++--
 net/mptcp/protocol.h                          |   1 +
 net/mptcp/sockopt.c                           |  30 ++-
 tools/testing/selftests/net/mptcp/.gitignore  |   1 +
 tools/testing/selftests/net/mptcp/Makefile    |   5 +
 .../selftests/net/mptcp/msg_zerocopy.sh       |   1 +
 tools/testing/selftests/net/msg_zerocopy.c    |   6 +
 tools/testing/selftests/net/msg_zerocopy.sh   |   8 +-
 9 files changed, 206 insertions(+), 23 deletions(-)
 create mode 120000 tools/testing/selftests/net/mptcp/msg_zerocopy.sh

-- 
2.55.0

