Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FBE1A3142
	for <mptcp@lists.linux.dev>; Sat,  5 Jul 2025 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751714268; cv=none; b=Pj67jzlYcPeHcwkTNuLlsQuq3UCQ9IuwIPDCwaHf1vptsPZBywScM8NUA2KzJec9s94zkEujjrCahcu+5F7hxEKSRDJejFDF4cKTTA94Aklw1kl4z+mSskV9ugvHFnFBJoijYriifPkzn8UmZ4lN7GTEIemf0WZfkuarENFHMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751714268; c=relaxed/simple;
	bh=/fJgwlzJKik/idSSAEWd/w40nliUKSNo5NW6A2gW9Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nhSVnfezeYvKbsboHW1C8iVwhGVTAPShbzoIlyeBe5bw0EiA4DRU6+aoVp5iVJCQWrs/9Kd0ADBpT+UICT0B7hn0Vh10ghBiRkA4Bh+gqLOJtINlLpph9+tpflJTNWwS9epWO3b0fsh/vnn1lWbP/N5HS9wzgDsK0BmgCN/D+sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsbOxUD8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsbOxUD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9D1C4CEE7;
	Sat,  5 Jul 2025 11:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751714268;
	bh=/fJgwlzJKik/idSSAEWd/w40nliUKSNo5NW6A2gW9Ig=;
	h=From:To:Cc:Subject:Date:From;
	b=SsbOxUD82EmfawEZSteUt535qMKCtG0j08ieImmrohP1rGXyH6g0XujdzmEbrUXfL
	 nd7GmFEZJG33bQZTlBRgBGgyrJ0sCoObLHv3sQ9xc0pBwFe+fn4oUq4OYkiOTCwCn6
	 9D/b5PrTp1+soLHNaHy6I0PG3sEjC42WN9JIRKGaDYkeVp7QEl/TjBLiihJ2YJmOks
	 uVzdgtPMHeDkf/6Yb4NpJYQdKguywQj8nPOsgDqV7MXlm2x+8JjwNwyU4UYYCh+HXk
	 ii6r+SOUASWmFmQ7pcssaytD01AyZ+dKyx6kAbiuVuOICklZAAMx5Zwnb5SDS9v9/8
	 VI4gusliUluew==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 0/4] implement mptcp read_sock
Date: Sat,  5 Jul 2025 19:17:38 +0800
Message-ID: <cover.1751714072.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
  mptcp: use sk_eat_skb in recvmsg_mskq
  mptcp: implement .read_sock
  mptcp: implement .splice_read
  selftests: mptcp: add splice io mode

 net/mptcp/protocol.c                          | 207 +++++++++++++++++-
 .../selftests/net/mptcp/mptcp_connect.c       |  63 +++++-
 2 files changed, 267 insertions(+), 3 deletions(-)

-- 
2.48.1

