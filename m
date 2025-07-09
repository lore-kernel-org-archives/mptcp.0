Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB1D26B955
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 07:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045943; cv=none; b=DOeJplI3CxZZSxIZ6qlhMbYDqN2nJAcEt0T51hyCAeqMNnGw60y73ZYF9vf/6cT0XDpCyEj8OjwIerPGvfRtiCQX2i6xeneszT5ZPvaSfOdN2QTu3YnUOJMR3bAcWUOTCExQHO2v0kYFOqSEjLQtG2IzSBIyYDja3qzCjJeJhyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045943; c=relaxed/simple;
	bh=LjS331OfS2s3s5BJ+ZQJ4JQV8h4/3zykg33klOb8Ox0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lSsJUX6rLvQoG0lREaAzgXleqKBO3yZxBq3SsRgR6+mkuC/z8G8VwZobDVh965vrB1RASAQ2swZDrTm5xvme1cAZLQZ8u4ewue1ufLLgQiS/cZBF77fSm9w0R192AvsxxAyA4nQzkt87jcfmQ5gAah2aHQVDWzGOAi8L63tctHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JshOSxDs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JshOSxDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D54C4CEF0;
	Wed,  9 Jul 2025 07:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752045942;
	bh=LjS331OfS2s3s5BJ+ZQJ4JQV8h4/3zykg33klOb8Ox0=;
	h=From:To:Cc:Subject:Date:From;
	b=JshOSxDsODVASm6qn0742jhIwnwtoI3RnXzaE8k5ZWUQpr85R1mEy503z56D3vMYX
	 V6NpZGKrAhKtamCjU903t+2sRigN1Du2YxDoKgkSlVOGF5xjgCDObNpVTLEOoq0cY3
	 BR16ZOPN/xt/n8rbNkwJjL3PfbIIHDdhdq+2Bnlo7Ereq6LFMzOQI9SpZqBDf/IQFj
	 CQQuDM9haoLWOMxk+tEQZ9kh1SMrvaT6d8H7Ut5fFUEBsxq/ObbSe+4w2ybAaQXf3W
	 SBU2q7o17YNLRKa0i9agTAxMpDDz0kJPw+zYpqexHwcdJjWy69wV1WZJ3dAEXNpbor
	 XqZMOsDpbp0FA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	hare@kernel.org,
	pabeni@redhat.com
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 0/7] implement mptcp read_sock
Date: Wed,  9 Jul 2025 15:25:27 +0800
Message-ID: <cover.1752045499.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v8:
 - export struct tcp_splice_state and tcp_splice_data_recv() in net/tcp.h.
 - add a new helper mptcp_recv_should_stop.
 - add mptcp_connect_splice.sh.
 - update commit logs.

Based-on: <20250708-selftests-mptcp-connect-modes-v1-0-f8e6f9828fd8@kernel.org>

v7:
 - only patch 1 and patch 2 changed.
 - add a new helper mptcp_eat_recv_skb.
 - invoke skb_peek in mptcp_recv_skb().
 - use while ((skb = mptcp_recv_skb(sk)) != NULL) instead of
 skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp).

v6:
 - address Paolo's comment for v4, v5 (thanks)

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

Geliang Tang (7):
  mptcp: add eat_recv_skb helper
  mptcp: implement .read_sock
  tcp: export tcp_splice_state
  mptcp: add recv_should_stop helper
  mptcp: implement .splice_read
  selftests: mptcp: add splice io mode
  selftests: mptcp: connect: cover splice mode

 include/net/tcp.h                             |  12 +
 net/ipv4/tcp.c                                |  13 +-
 net/mptcp/protocol.c                          | 237 +++++++++++++++---
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 .../selftests/net/mptcp/mptcp_connect.c       |  63 ++++-
 .../net/mptcp/mptcp_connect_splice.sh         |   4 +
 6 files changed, 285 insertions(+), 46 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh

-- 
2.48.1

