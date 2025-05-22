Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06258264A7C
	for <mptcp@lists.linux.dev>; Thu, 22 May 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747905802; cv=none; b=C/g3Fa0ASP9NjsrnX1YiQC9KQukp7TUyapM+V6a20IG2QB/1LFvJUhzuUVPz8e0rvARjr6aoPmHE+tOnpBhph0szYzr2irhoxdcazORj35vd11JPHFNjrrY+3Wkn/3hKtzm7xpfgnVUCjNXqNd2/wsPe+5uksSIRhZpDLj+4w/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747905802; c=relaxed/simple;
	bh=q7qCAOMB12D61HHytPAXVwCrWmKe9BvN+6pjJeQ8WwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tchYycILrPw53dQoN7U5vXUlmhH+AhKaC/Lw4ouMl9Udek8qdEFWXG/6H6+Iibn0O54B87mK9PavLF10I94mWyGfKRswE3FSvyA3Xg7hhTvueM2cTpyD5Ar1upFL409VGK6O97FY53Wzpy32xGX6dnmjO0qkREph0GKij6QxkWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5PYKA12; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5PYKA12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C951C4CEE4;
	Thu, 22 May 2025 09:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747905798;
	bh=q7qCAOMB12D61HHytPAXVwCrWmKe9BvN+6pjJeQ8WwE=;
	h=From:To:Cc:Subject:Date:From;
	b=B5PYKA12bjj3N2icggASjwLShr7LwlXWUfQlJV3RnVpJyPD6Cx5rTjaw9uNnwnTK2
	 4oFYIGsNZiANF24JqVFINKFm+HvaemfWNxs9QWd2qSyA+cKtJRskLOk0nfxj9Tgyny
	 gVd5+89F/pvvaeEck36y8lCKh++pMvfQOVhppbpwvJwQJhVSRJO1DaIMxKgVhyGBHU
	 9R5O5Da41dgcaCOX/lIkBPx2qtclGOeh/0O2t/R5YkmS/Nn3x9imoejFdtclWwzBVn
	 EzMCFRBrQtG1/qytPLcg7+2oV/NzdSePdBVJ/JNo76jQ/lflX9Q4dD29B1FVJpJVIa
	 fhfXvGtFYToMw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: hare@kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] implement mptcp read_sock
Date: Thu, 22 May 2025 17:21:31 +0800
Message-ID: <cover.1747904572.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Thanks,
-Geliang

Geliang Tang (2):
  mptcp: use sk_eat_skb in recvmsg_mskq
  mptcp: implement .read_sock

 net/mptcp/protocol.c | 57 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

-- 
2.43.0

