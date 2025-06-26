Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84B4293C73
	for <mptcp@lists.linux.dev>; Thu, 26 Jun 2025 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927322; cv=none; b=GdC4Gqg2WqCJnKNfYQvXk0ocjBuNgrHOq+xKGQQFpHcKGgxRZGBG6jNxAOwEb/PC4Fv6UWTRG0GgE9NUhU1/leMrZfgMD8kYVK/00obmbiXlxx6aP2KQtnoje70DxaD6HILDUd7FiPMsj3hVtMWes5sHhPwW2Aw/JhqWsVs+Rzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927322; c=relaxed/simple;
	bh=WUjsypHTfp2blKXuDOmsVMFcMzsEatnf43ODXsS4nMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eA0hjFjndi0KylGuaFSP1w3NVwnp+lnXfQAK2FBHH9XgfITzn5V8FAy/yfiWUNtgqXudIsIQh3TBgY9ZblKZU6LtB6pgEvmzZJSDLvuvgk0yfAZUbAUoexhoXfOkzmqCowcRHKT1jQbwzDyserjZWjumbm5JBu5pQoqt/lcosMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/7UjjUl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/7UjjUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22789C4CEEB;
	Thu, 26 Jun 2025 08:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750927322;
	bh=WUjsypHTfp2blKXuDOmsVMFcMzsEatnf43ODXsS4nMw=;
	h=From:To:Cc:Subject:Date:From;
	b=s/7UjjUlE7T6aydvyxk3HsX5svsXhBMAPHl11TU4yPgfhT3j81g/W9pHrm6UdrkSo
	 IfJxviJ6hpfwv70vpxV1yEK/sx1F37YKicFnF2EXh/HiwQ62rvhvtwvZAbZEyKxcBR
	 RmGjSrFy3oMilPMemUKils8Js2GoCwNNJG5F5BmHaHcbzRL4EU6YN6caEnEm4T/i/H
	 iAI2zLKeuc3Pnp0s00WkyNrhwbbelCCtpA/cfeeI00r2NXvlEqadquzYhVhe5pvlDz
	 v0yjtPGhU2qTImN9jPSr7non4H1odYo0sfl0VD1NCeOFm8J3zTIrddPAmZSl5fslfA
	 qcvuskDLwM4jA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v3 0/4] implement mptcp read_sock
Date: Thu, 26 Jun 2025 16:41:49 +0800
Message-ID: <cover.1750926916.git.geliang@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
 - merge the two squash-to patchs.
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

Geliang Tang (4):
  mptcp: use sk_eat_skb in recvmsg_mskq
  mptcp: implement .read_sock
  mptcp: set .splice_read
  selftests: mptcp: add splice io mode

 net/ipv4/tcp.c                                |  6 ++
 net/mptcp/protocol.c                          | 66 ++++++++++++++++++-
 .../selftests/net/mptcp/mptcp_connect.c       | 61 ++++++++++++++++-
 .../selftests/net/mptcp/mptcp_connect.sh      |  9 ++-
 4 files changed, 138 insertions(+), 4 deletions(-)

-- 
2.48.1

