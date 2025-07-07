Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B153C35949
	for <mptcp@lists.linux.dev>; Mon,  7 Jul 2025 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751880897; cv=none; b=C9Z6wl5Zgn4468yKgK/Bbluez+FeANLrxarHNs4xyK/CVzw/6lNaMd9xaHGFetOEr2WI0X22J5piMr3pdCA0wLGpbwKvYA0GjIjYwa5Fc4G6QxhPsolvT5SnaZVKp/bcVWSEzz6Jxdcod1dzFrdxiRslpTdnhxdGCMV1M20B//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751880897; c=relaxed/simple;
	bh=gbVpVzesAazSGkbx8a2JEja7IqUBfR7jCUr6K3wQsWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F+Z8f3Glbq8FIxzaPhnKHB7xx5GP8KTsfQA+gyRRJGzqk1VzG38JCDLUm2DSRJU0BAx3uvVBEvU+RTte1nI5JSSmV7tOymh0FY2Y+n+M7FQQIB/NieDy7jOmiQWdM6IGahD7S04myq7JPDPF3MoacbyFFiFNinj5IkGNPMF7KvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzaCojG4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzaCojG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061C8C4CEEF;
	Mon,  7 Jul 2025 09:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751880897;
	bh=gbVpVzesAazSGkbx8a2JEja7IqUBfR7jCUr6K3wQsWw=;
	h=From:To:Cc:Subject:Date:From;
	b=TzaCojG47x7O/Qb3ygQs7RvJKqH4sLG2CxlL2b34L1+AZsG5ZyogL4e1wPSEU+GSI
	 30Elf5dMOahuaGG3NKScBgbfh8k3dsvyWJeSy73vH5yhVJ3faE9SjL/3H+moWrmoH1
	 OazlrgvdKpJrE8uXZKqX/wI5yYuviMG+M+lZ4m29NOlWqjDJnuwRoH6tM7W5AZtLSy
	 vmsK7itqy58cCZqI6RFJ7TXHYlLQDB6SLhjKKmTe53GM0zZxyfoTFSZlyIDFB6C7Qu
	 5cy2LnCa03uNyAZgWNSVdhNyCRtk/8SlKf2OiPjESfgOqS8ZBooU88d5aWJxphuJfw
	 AaVe1adi3smbQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 0/4] implement mptcp read_sock
Date: Mon,  7 Jul 2025 17:34:46 +0800
Message-ID: <cover.1751880561.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Geliang Tang (4):
  mptcp: add eat_recv_skb helper
  mptcp: implement .read_sock
  mptcp: implement .splice_read
  selftests: mptcp: add splice io mode

 net/mptcp/protocol.c                          | 215 +++++++++++++++++-
 .../selftests/net/mptcp/mptcp_connect.c       |  63 ++++-
 2 files changed, 271 insertions(+), 7 deletions(-)

-- 
2.48.1

