Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AB2192D8A
	for <mptcp@lists.linux.dev>; Fri, 27 Jun 2025 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751040086; cv=none; b=ISRxgWXMq/mK8Ry037C+cqLSjU80uQu+Uipud0H/z/CLA64FNhg3ngVCfCBtOXDzFH1UMg7aRi9uP9vZI0o8QWiv6MR8ZZyDBWIoTEH48c0l2jxsb8ffvNSqSA2tggFOeSQul0c2v30lX0NlZNH0VuXlZnshP1MMwPRykvNiLts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751040086; c=relaxed/simple;
	bh=ag5Alm0bYemK3pEfRJs2Q+FjT6Lrxz/IUtjn9ERGbPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=msVKKhL35vxJrgER8DwisyFle1NxH5gqU/UKL/CiV79xTo3D0HfXjclE8tobcaGRxLWpAAvnxL5wNIzVybtLPNdnE0MkrzPDALe1UajuCGkmW8I8GIFG1EGK2Rhej1BeYVqpsbbAxiwMG5o0xhc3VNq9Oa3fqxR65Fs6eZrOtOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShdTAucm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShdTAucm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DDEC4CEE3;
	Fri, 27 Jun 2025 16:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751040085;
	bh=ag5Alm0bYemK3pEfRJs2Q+FjT6Lrxz/IUtjn9ERGbPw=;
	h=From:To:Cc:Subject:Date:From;
	b=ShdTAucma7CvjDTVp9Erq5dJndHT3w7RHGsvA52KQWno/Jmw/E5ArkbQWEV3lh+Oo
	 MVDUOpkrPVGqy+hgygjGlnyhmho/R5Eqw4AlDcHsZKGyB6bD3XQeUaqZKMMaqUqaBY
	 cuMcVVeVNkJ7G+CU+IUJWO9ELM/k6hKcvM6TJxOp8kl2ojdSnGW8tkJ1n+LncK8eMN
	 Jlp+cA12fhF4rtwXNqIsKce/Eu86vvHFZe5Bp4DBZTA+BnbMmEX/AaSQE5/LONi7pj
	 Ze7x1VJyLImAIVjjgh65dz/HnjK0s+R4JxwBxnfGGsGBd4Gp5Ev5+XcBCiWR1+WHZM
	 16EcrLem0fqXw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/4] implement mptcp read_sock
Date: Fri, 27 Jun 2025 23:59:39 +0800
Message-ID: <cover.1751039657.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
  mptcp: use sk_eat_skb in recvmsg_mskq
  mptcp: implement .read_sock
  mptcp: set .splice_read
  selftests: mptcp: add splice io mode

 net/ipv4/tcp.c                                |  4 +-
 net/mptcp/protocol.c                          | 69 ++++++++++++++++++-
 .../selftests/net/mptcp/mptcp_connect.c       | 63 ++++++++++++++++-
 3 files changed, 132 insertions(+), 4 deletions(-)

-- 
2.48.1

