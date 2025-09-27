Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC272D73AD
	for <mptcp@lists.linux.dev>; Sat, 27 Sep 2025 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758976296; cv=none; b=WHY08zoRhhfF8izGK3wzAUmI6icL9Mm4wfKHjwHT/EDYv0zph2B/mP+7F9jgHaBzEGXQcBiR8CZWVO90HUZEZ1jednfCmdOWE8kqfw1i7/6mqsKiWsUBv43bnrFk+6OTESztMDSg/VRGcOIoVdaot+8A8ffJQooD7Pm81WGtK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758976296; c=relaxed/simple;
	bh=FNCAlrAzk5obcC50tT/ecicz9t+8X7FlYa4u1q/XYyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EvQj8cqcasl1WSLCGBFREkNb4vKCeMkJ5ePXGgPpI6mON/h372oNw6vUqga89nhN6jOAZVX9iDAp4ckM70ocp7uxMtmx7tkE0i3MNLwKTZR+grHwWNyCzSCA4WSzVemr8/bO75WUaxcRCo3bfeWRKNCAXUxrDRfWcnxX2hq6mBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1k/6POZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1k/6POZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E43C4CEE7;
	Sat, 27 Sep 2025 12:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758976295;
	bh=FNCAlrAzk5obcC50tT/ecicz9t+8X7FlYa4u1q/XYyQ=;
	h=From:To:Cc:Subject:Date:From;
	b=u1k/6POZ3QbOt1WW8PuSeYPv8nMTtRLTLnGn3QuxjhG2hooXUXJpssKOE96ytlWRZ
	 az/I8TVwfRLSd6Y261+8zTA9D4a9Az4iNuty7696MJ3qp2QngylWpZslNiQ7nahJGY
	 EGAQTiYXD51+0OBFIfytrwhGw4KNVAkS9Ogf4CDc1q4sOc8OeqxqPONgglZIUvX3jJ
	 WHkhwtJAd6eK9eq1RVVZA63Pvvez995BEEhEgqjFMH8dSmA52uy2McvC4s+ElBiaha
	 iarl5W8Zp5IymKCJ6GMCYCVnGEXQghhaG4MPgklLtLgpVIa4UhRgIj4nJr1OWFR5c7
	 2gCAyvN9P+J8A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 0/8] implement mptcp read_sock
Date: Sat, 27 Sep 2025 20:30:17 +0800
Message-ID: <cover.1758975929.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
  tcp: export splice_state and splice_data_recv
  tcp: add recv_should_stop helper
  mptcp: use recv_should_stop helper
  mptcp: implement .splice_read
  selftests: mptcp: add splice io mode
  selftests: mptcp: connect: cover splice mode

 include/net/tcp.h                             |  35 +++
 net/ipv4/tcp.c                                |  86 ++-----
 net/mptcp/protocol.c                          | 224 +++++++++++++++---
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       |  63 ++++-
 .../net/mptcp/mptcp_connect_splice.sh         |   5 +
 6 files changed, 304 insertions(+), 110 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh

-- 
2.43.0

