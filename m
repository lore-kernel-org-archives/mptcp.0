Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4CDDC5
	for <mptcp@lists.linux.dev>; Sat,  6 Dec 2025 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765024466; cv=none; b=s8ME881EGT98EU9LsrTlJjd/CH+bxYKV8BKoZeqvQm1E6879nEIwA6BPG9KYr320OjYXqn9uw8DXjrIaxxQeAqSzJ2sPni4DPI6NDYYdQCDInmpS8LVcCl7Jr3x8Y/klyBM+1arMS1dEmlBcmeyDpEuOOiAJxz+845Yei4Rn6Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765024466; c=relaxed/simple;
	bh=CQMpx30JAGBU0HF/RUnhDtdtDfroZxx0GmdVv/mGvVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XirnYJowSRtPi20X3wo5sZrt5D99oWKPPk/TQ2NTPzhrMz0X0OCRlzz+BsneLLZNo5DakVwo6WiuEwm3hlbg7fnbxBcxNCl27Va2oaScEDyHphuhnpK5SyG3K2ZKx0Z49LtAaRIgBZ68SyhjJz9nPC0q3j5PBIB7DKnrqOVc7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmNGTTnx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmNGTTnx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDAEC4CEF5;
	Sat,  6 Dec 2025 12:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765024466;
	bh=CQMpx30JAGBU0HF/RUnhDtdtDfroZxx0GmdVv/mGvVw=;
	h=From:To:Cc:Subject:Date:From;
	b=rmNGTTnxTRimvq0X5AjZz0HElFs5q3GIpcqRAW/F67RAn8U3MjJM1hwxE+vtoic2G
	 OsR2H4nOBsxSzdzvs9THkd4RhSkrA46f6eWMYPQQE3Z0klp9SPy1U24pF1wvATFmpD
	 ZyY6qQhmGDeYKYftfV7nPLSWPP2jSEqc+GESROHlMc+qJYWPqGXOJ2jiiO1ePTqYs5
	 OLu3pwW3pAkuoJC9MmpO2zg18He7bpqOexSSgYdUmMH17+FWz93kU6PeoQvPUAIMm6
	 yjkJgrQGC36ebf4DbfxN0Y4t8G6taEYhTAnep31sG4TfDGHeD4PtXWYQdsQxVbnSII
	 bYYjtqG7RUWsw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v15 0/6] implement mptcp read_sock
Date: Sat,  6 Dec 2025 20:33:50 +0800
Message-ID: <cover.1765023923.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v15:
 - Patch 2, remove the maximum length limit as Mat suggested.
 - Move tcp_recv_should_stop() helper out of the series as Mat
   suggested.

v14:
 - Patch 2, new helper __mptcp_read_sock() with noack parameter,
 this makes it more similar to __tcp_read_sock() and also prepares
 for the use of mptcp_read_sock_noack() in MPTCP KTLS support. Also
 invoke msk_owned_by_me() in it to make sure socket was locked.
 - Patch 5, export tcp_splice_data_recv() as Paolo suggested in v7.
 - Patch 6, drop mptcp_splice_data_recv().
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1763974740.git.tanggeliang@kylinos.cn/

v13:
 - rebase on "mptcp: introduce backlog processing" v6
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1761198660.git.geliang@kernel.org/

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

Geliang Tang (6):
  mptcp: add eat_recv_skb helper
  mptcp: implement .read_sock
  tcp: export tcp_splice_state
  mptcp: implement .splice_read
  selftests: mptcp: add splice io mode
  selftests: mptcp: connect: cover splice mode

 include/net/tcp.h                             |  11 +
 net/ipv4/tcp.c                                |  13 +-
 net/mptcp/protocol.c                          | 215 +++++++++++++++++-
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       |  63 ++++-
 .../net/mptcp/mptcp_connect_splice.sh         |   5 +
 6 files changed, 289 insertions(+), 19 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh

-- 
2.51.0

