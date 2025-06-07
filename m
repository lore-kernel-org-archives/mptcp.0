Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A151F1F1315
	for <mptcp@lists.linux.dev>; Sat,  7 Jun 2025 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749286506; cv=none; b=qM1zj6F8DLSVkStsQFRUtg3bvHTE0wyOVSma072nOfaw3Ndm96N8g9I2AnjjRrVkEiQc7xlDfsbA3VqAb25VtflcvTC5fq7nkIe+O007h3jljKv+xk5GBrXrQYis7cpKMaQo+6wxDrotBUrIp5yOGkAhOvX3tUCTffVfrydiYuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749286506; c=relaxed/simple;
	bh=wgpqa5Tiz9iJwau02xqYe6D7lN5SnGIxxpB3x2vHGO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D21BsrqH5UjZyfvGmGWIzlxK7wvb61C//9xpw6EdEh/mid0L5dmgahGuKNZ1C91DscBXRrAMKhSipO+FbzlM0xl/x0MPKJDDWq2/vX9dBY4KkGl8eIlTuGw54LJFbaBIXJo8f7iX4v0Y6h4tVRVhmQ76/KzjldIMurvRetigcJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOGawinl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOGawinl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9ECC4CEE4;
	Sat,  7 Jun 2025 08:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749286506;
	bh=wgpqa5Tiz9iJwau02xqYe6D7lN5SnGIxxpB3x2vHGO4=;
	h=From:To:Cc:Subject:Date:From;
	b=mOGawinlxbzTuI22p1pCpnnF7t4fVCQ/OzE1vDznolP+O+y81jUNUEF60Lsh9Kvlm
	 s+zgfUtmy25e37H6yM/GA8oCnGWRwGULyAJ7ljgr/CD8xSozJUaOmgco9QzDGtZhKz
	 WMEd2oJ12aPmDD8gVUdkcHm5F7jmggIyITU5i/yRFdUr0GTwIVLQ+RmppJji4giCCv
	 m0y1Lf10Revur1560jNQq8afgulUob7YQnN/Y+8yO654+A+usAZPiC1rJs0IR3I+eT
	 gHAszTxgRXqD/q+6YCIXF+Vh026P4TBmJUpZiYBa2TFd6B8Ow/fCWRy0rcwy1IBfyG
	 XV0BuvKFHvdlw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/4] implement mptcp read_sock
Date: Sat,  7 Jun 2025 08:54:15 +0000
Message-ID: <cover.1749286212.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
  selftests: mptcp: add splice test

 net/ipv4/tcp.c                                |   6 +
 net/mptcp/protocol.c                          |  66 +++++-
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  20 ++
 .../selftests/net/mptcp/mptcp_splice.c        | 201 ++++++++++++++++++
 5 files changed, 292 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/net/mptcp/mptcp_splice.c

-- 
2.43.0

