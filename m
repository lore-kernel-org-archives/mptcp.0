Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033B2239E97
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 05:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199020; cv=none; b=C+6nq2wIy14RHnT5cWxdKJsk7Mep4hFVXjQuwlYAiLh+qqgEyNBeiPqLv/0aXC5aIx3C6jWBtkXcwlMbp6yL5K2GaiPk2wh8DpvgshjSc25e/Xl3Zb7Y5ne7IMIjo79P7CG/TBBFUGggrPkpCoCE6cAsLp9C+zh0frJL32dQ/z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199020; c=relaxed/simple;
	bh=3QW879QuVHgMUD+nuur+MgcS+jWWyt6rxRHBBNMPV3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FuFndpd5eW1mmMSN0n4ngd0DbAm1PIkaxF5DcKS3Nw/1FZ9HInQGdUEt851ActFBkVa/wmqIpEaCaks3JstGgdgMMPozAeldarGYBdB6NWp6mcIMgcMw4b1oRR6JkaCnjE2bBnXcIOABUZzfxTxwu49amhkqPk/CUjM3B3bySg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmhYN1Gn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmhYN1Gn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244D6C4CEE7;
	Thu, 23 Oct 2025 05:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761199019;
	bh=3QW879QuVHgMUD+nuur+MgcS+jWWyt6rxRHBBNMPV3M=;
	h=From:To:Cc:Subject:Date:From;
	b=PmhYN1Gng/JOos308b4MntvwDMaZEMRkfLoNoVZZviXdHVxFi5hSZ6rd0vb7b/Y0m
	 3OkMHuEz2W6vMahAUabkXT43QbSJ5TwOhFz9OiNExZsaANvhX6nIhm4PqUBFFBqrN8
	 G9C9Ha2KStoiUYKIwLbKIkKsX+HhFTSsTFGT4DNOfRpI5M2oZzMp+1lh5inn3Jl8Fx
	 8A8A7ioFuVPAJ5xdbcz6nqHP2FUKvMP7RKg19PQAwwWA1m12rdLyEzKtaAVrOdYrcA
	 azlyBj77Q9mFUuoEuhRg6Rm+UWAxUjxJlRFfPCyOCfqZWB+ozug4FX0AUcGueNZCvH
	 hBzY0FJQjbdbA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v13 0/8] implement mptcp read_sock
Date: Thu, 23 Oct 2025 13:56:43 +0800
Message-ID: <cover.1761198660.git.geliang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v13:
 - rebase on "mptcp: introduce backlog processing" v6

Based-on: <cover.1761142784.git.pabeni@redhat.com>

v12:
 - rebase on "mptcp: receive path improvement" 1-7.
 - some cleanups.

v11:
 - drop "tcp: drop release and lock again in splice_read", and add this
   release and lock again in mptcp_splice_read too. (Thanks Mat, I didn't
   understand the intent of this code before.)
 - call mptcp_rps_record_subflows() in mptcp_splice_read as Mat
   suggested.

v10:
 - add an offset parameter for mptcp_recv_skb and make it more like
tcp_recv_skb.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1756780274.git.tanggeliang@kylinos.cn/

v9:
 - merge the squash-to patches.
 - a new patch "drop release and lock again in splice_read".
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1752399660.git.tanggeliang@kylinos.cn/

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

Geliang Tang (8):
  mptcp: add eat_recv_skb helper
  mptcp: implement .read_sock
  tcp: add recv_should_stop helper
  mptcp: use recv_should_stop helper
  tcp: export tcp_splice_state
  mptcp: implement .splice_read
  selftests: mptcp: add splice io mode
  selftests: mptcp: connect: cover splice mode

 include/net/tcp.h                             |  32 +++
 net/ipv4/tcp.c                                |  82 +-----
 net/mptcp/protocol.c                          | 238 +++++++++++++++---
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       |  63 ++++-
 .../net/mptcp/mptcp_connect_splice.sh         |   5 +
 6 files changed, 313 insertions(+), 108 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh

-- 
2.43.0

