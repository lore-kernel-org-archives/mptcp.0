Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D85F4A08
	for <mptcp@lists.linux.dev>; Sat, 28 Jun 2025 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751093879; cv=none; b=Vwmdp3VZOqAgXBsT33YzK6ZqpNhFcrt3blO2eIZkrWH/libgSjMRh5JA89EKov8eSaSWbpQkeY1HMb53Pgvlvg6xwSI66ySJaRwGbaZpayuic9FlApWex144r3AcgggHZZ93uFBHW7057jjVTqRVwTwWHcxmB759Hd+4DaVKOH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751093879; c=relaxed/simple;
	bh=Pbr76FTTIdmfVB/gdTSKDo5A1pHhrcf0g2xvL7HcNc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jRjPJbJmhCMuB8Pa8/3MmSarjx3y4RUqBh6mbUbCQp8FvF5XZkqo0mqyeItU13CFpbxSq/a6mh+HwbeAlyImKUirAD5JYDek8X8bIsJdrkl8H4DKjL7Jal6fx1osaUqg9wz5WwkjnCEl+LsQqVEZh3lJsCwyTQS8NQ+gXFbSJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoBxtuhT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoBxtuhT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54076C4CEEA;
	Sat, 28 Jun 2025 06:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751093878;
	bh=Pbr76FTTIdmfVB/gdTSKDo5A1pHhrcf0g2xvL7HcNc0=;
	h=From:To:Cc:Subject:Date:From;
	b=RoBxtuhTFS5b1yqY3i8wtS9SDsAEuXsCNrANHixo3GsicmgHis7I414aO5JfRSHvH
	 DQArIbl9liFNi0IcA6VaMxQQuYfiLLYSQqIHwzl6u1ITpI4v/C1SD7J61MuFOf/mBb
	 rdxVl/FZQJ73ZGY+A9XAieSNH8KVqgqhVlvetiq92XjObLe2f+z27dpxZtJxpSUJJ3
	 iuNO1onCU1ujApC96udjJ00I/9S60hKRqgKeMplecnlTbYd28grhPDLRRQSq3PBK83
	 YCeg4HgZ2IfV/qiF8ukbLSIqLcA7Ey2d087o4T6OUNJNqDjztS95kJSKVaT6mumrJ4
	 ALpnQwshFx2XQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 0/5] implement mptcp read_sock
Date: Sat, 28 Jun 2025 14:57:08 +0800
Message-ID: <cover.1751093346.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Geliang Tang (5):
  mptcp: use sk_eat_skb in recvmsg_mskq
  mptcp: add recvmsg_desc helper
  mptcp: implement .read_sock
  mptcp: set .splice_read
  selftests: mptcp: add splice io mode

 net/ipv4/tcp.c                                |  4 +-
 net/mptcp/protocol.c                          | 71 +++++++++++++++++--
 .../selftests/net/mptcp/mptcp_connect.c       | 63 +++++++++++++++-
 3 files changed, 130 insertions(+), 8 deletions(-)

-- 
2.48.1

