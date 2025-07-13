Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7061DF26B
	for <mptcp@lists.linux.dev>; Sun, 13 Jul 2025 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752399835; cv=none; b=RImC4NKwHHWFHDL53vdKzgLBEeWyUNanlvkH884RISYfKTvL/hIbZIfxEJAqxSfgyeBdQ8OjWmj0r+V7mVT5lNT2R4Qahs4eFWgg/bac6tkCeYd4YIO3m08JwKFBgtWhHa/mUsa6iuQK0ZqQBHGjxKbNdqMdpMgW6OnSUtLYYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752399835; c=relaxed/simple;
	bh=J0HagOcu4gQex/Td+LmF4yo1IfH8RbZ0Hqx3eKbuc+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l26+CLkL0yOom96TGi6RU6FYe3i08MhQ83C1womDpTN3M+KiUVQ4v8M7MuX4EKgCT0LlovsBTr1TUxFF9ql14u2SWAmqK+QcwjnTeoYEFnsKzzs3F6FRm6NtRkBo1VAPR2AXxLOjmGEvr+YQzJdFGeLcAyxvqWHNleqBQjl3Nos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIvhn/lU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIvhn/lU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8C6C4CEE3;
	Sun, 13 Jul 2025 09:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752399834;
	bh=J0HagOcu4gQex/Td+LmF4yo1IfH8RbZ0Hqx3eKbuc+I=;
	h=From:To:Cc:Subject:Date:From;
	b=SIvhn/lUVk4hxIY1AsMF3bbythqFXcI2rZanMygVlzwynKx8iWIwnjvC1cWDz4vpr
	 4oNgqQ1d9idrIEQcL1/sorQGYDcWs3u5SIUXtffNOqR7N8LwTiCfcnmsLFfOE/Na0b
	 MR083gjgI4a9ZeHEeaBAZ39MnqgI7cOdYQcTgApDbNRatvyZ4FXYIlf2fC8pto09k+
	 aeJPVpaItE4pXodLTQC1UI293jvcejq9K3NQE3VZa2uw07ZL4bqT3JSMvPxouxXlc3
	 2PrTtZsYOdclWxTIkukG2Xa0JLix7JMpbfaBPV0g6Ozpv3Ov/0snBZcgszyHdPlRYX
	 dlt0p4rKYZ+sg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 0/9] implement mptcp read_sock
Date: Sun, 13 Jul 2025 17:43:40 +0800
Message-ID: <cover.1752399660.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v9:
 - merge the squash-to patches.
 - a new patch "drop release and lock again in splice_read".

v8:
 - export struct tcp_splice_state and tcp_splice_data_recv() in net/tcp.h.
 - add a new helper mptcp_recv_should_stop.
 - add mptcp_connect_splice.sh.
 - update commit logs.

v7:
 - only patch 1 and patch 2 changed.
 - add a new helper mptcp_eat_recv_skb.
 - invoke skb_peek in mptcp_recv_skb().
 - use while ((skb = mptcp_recv_skb(sk)) != NULL) instead of
 skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp).

v6:
 - address Paolo's comments for v4, v5 (thanks)

v5:
 - extract the common code of __mptcp_recvmsg_mskq() and mptcp_read_sock()
 into a new helper __mptcp_recvmsg_desc() to reduce duplication code.

v4:
 - v3 doesn't work for MPTCP fallback tests in mptcp_connect.sh, this
   set fix it.
 - invoke __mptcp_move_skbs in mptcp_read_sock.
 - use INDIRECT_CALL_INET_1 in __tcp_splice_read.

v3:
 - merge the two squash-to patches.
 - use sk->sk_rcvbuf instead of INT_MAX as the max len in
 mptcp_read_sock().
 - add splice io mode for mptcp_connect and drop mptcp_splice.c test.
 - the splice test for packetdrill is also added here:
https://github.com/multipath-tcp/packetdrill/pull/162

v2:
 - set splice_read of mptcp
 - add a splice selftest.

I have good news! I recently added MPTCP support to "NVME over TCP".
And my RFC patches are under review by NVME maintainer Hannes.

Replacing "NVME over TCP" with MPTCP is very simple. I used IPPROTO_MPTCP
instead of IPPROTO_TCP to create MPTCP sockets on both target and host
sides, these sockets are created in Kernel space.

nvmet_tcp_add_port:

	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
				IPPROTO_MPTCP, &port->sock);

nvme_tcp_alloc_queue:

	ret = sock_create_kern(current->nsproxy->net_ns,
			ctrl->addr.ss_family, SOCK_STREAM,
			IPPROTO_MPTCP, &queue->sock);

nvme_tcp_try_recv() needs to call .read_sock interface of struct
proto_ops, but it is not implemented in MPTCP. So I implemented it
with reference to __mptcp_recvmsg_mskq().

Since the NVME part patches are still under reviewing, I only send the
MPTCP part patches in this set to MPTCP ML for your opinions.

Geliang Tang (9):
  mptcp: add eat_recv_skb helper
  mptcp: implement .read_sock
  tcp: drop release and lock again in splice_read
  tcp: export splice_state and splice_data_recv
  tcp: add recv_should_stop helper
  mptcp: use recv_should_stop helper
  mptcp: implement .splice_read
  selftests: mptcp: add splice io mode
  selftests: mptcp: connect: cover splice mode

 include/net/tcp.h                             |  35 +++
 net/ipv4/tcp.c                                |  90 ++------
 net/mptcp/protocol.c                          | 204 +++++++++++++++---
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 .../selftests/net/mptcp/mptcp_connect.c       |  63 +++++-
 .../net/mptcp/mptcp_connect_splice.sh         |   4 +
 6 files changed, 288 insertions(+), 110 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh

-- 
2.48.1

