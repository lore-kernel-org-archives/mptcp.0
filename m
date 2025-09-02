Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D127467B
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 02:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780509; cv=none; b=DYdc4pwVXuw4VcfHOeCtwG/je/4sA7nk25a6mIPRjLrbhyV3jklBRzzMOSUbwCTti5yOzwSKiGUHiOlttYGXAoHE7d3GsX24b9uddK1uzrdTnPw55+ncICnAnSzRmJRk2JNG1aVGmr/70cinN+NI+bdcExaTcFCY9/wsS6u9Lf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780509; c=relaxed/simple;
	bh=1sHBVJJ5geQgQv7JgU3IHN0qIAfuxT5WPb7Mi5gLk/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=saH4KEXQEyCP+AqooAQVh0EQtRTLEznWGTsNc+6j7hD1KYjiEQl6Wm1Hlh45dMXvB60+L9jxt1HU/tWmtNMSufrdUh8xfHscsBQfNYb3JlYO/nYpxiAGPyWWM6BHN83okZZ2NNeQ+iZahpm9PL9zW68xeX80OYJaY3lI4iDT+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB+p8DZ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hB+p8DZ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E137C4CEF0;
	Tue,  2 Sep 2025 02:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756780509;
	bh=1sHBVJJ5geQgQv7JgU3IHN0qIAfuxT5WPb7Mi5gLk/I=;
	h=From:To:Cc:Subject:Date:From;
	b=hB+p8DZ5QbvWXQ/XKjsDAy4gyOyksPhlVu+QfiD/yhoREcaCGfN8lEzNKWk1xx16G
	 l85npJh9k1Sl+YxwHdQiH6WTRoXYGT/+hJMuIVsTAwadMz+rF05bl62xIRZ3NVgtxx
	 JI4QRxpyr6szDFJryuYqp9igANtzDkLw1kMdL5jTcY9Fpq6zbsEpKHmYqLnSb3gwpN
	 7/1AFbHfav0ycI4OuRFXd2YfcDiBrLkcSnzc1bblkQorZR8MbYar+QXluO8edNfcbx
	 1NcNHmJJqKJKNk87dVhEObib408/dHxR72VOZFDLclbuCgEHaZ8B82LNe6Ak8bOjSA
	 rTbeiNMEiu3Sg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 0/9] implement mptcp read_sock
Date: Tue,  2 Sep 2025 10:34:51 +0800
Message-ID: <cover.1756780274.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v10:
 - add an offset parameter for mptcp_recv_skb and make it more like
tcp_recv_skb.
 - merge the squash-to patches in
https://patchwork.kernel.org/project/mptcp/patch/e14c5f597e17e6410c639811f44dbd7588667888.1756458375.git.tanggeliang@kylinos.cn/ 

v9:
 - merge the squash-to patches.
 - a new patch "drop release and lock again in splice_read".
https://patchwork.kernel.org/project/mptcp/cover/cover.1752399660.git.tanggeliang@kylinos.cn/

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
 net/mptcp/protocol.c                          | 216 +++++++++++++++---
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 .../selftests/net/mptcp/mptcp_connect.c       |  63 ++++-
 .../net/mptcp/mptcp_connect_splice.sh         |   5 +
 6 files changed, 301 insertions(+), 110 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh

-- 
2.48.1

