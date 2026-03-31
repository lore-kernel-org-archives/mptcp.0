Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD723EF66B
	for <mptcp@lists.linux.dev>; Tue, 31 Mar 2026 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952918; cv=none; b=OUnP/OciW8BP41JBWTjWiY4rX5vVN58IqvVWiT2BSY56K6DEgTcbJeuZHfvSJRa/W+AZz7uBk7rAYXIKyqBI197/6NnJwd7O45eEsefb3OZq7UmrhAIxzKvtZvkkdO5NDAK/CEJB0upR2+DK6TsJXxyVGz++WP7NiXLB1f//IQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952918; c=relaxed/simple;
	bh=D4I21vkU2eNw6AvErkhj91+kx9K+W0FEkBpbu/kKaDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M0J1d4j/I5ZnaXpP2ubpy8fFEC9U2r+dcbsecsuRxVUdaPzXOABDhcrYc5etxVeqlltmnJHsueyQ2NCfyU1sKejqenJsbg4CacXhJRmygqAqa0NA2aojtRnn8pxiFtMfiWbdPoPUN4O81MMgTbSKDlu9q5n7KYOUfhhs3yf7q6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buSYdHeA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buSYdHeA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5A9C19423;
	Tue, 31 Mar 2026 10:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774952917;
	bh=D4I21vkU2eNw6AvErkhj91+kx9K+W0FEkBpbu/kKaDk=;
	h=From:To:Cc:Subject:Date:From;
	b=buSYdHeAG98/Os/dVhnVMWTj1+DJp2X2868ZQysjDUSJs2JRe2ndQg2CHKwR1rnrV
	 ddESgch8Y5qROLtsqH4aNlT2pzNzClJ+LWUNrs9I62I4CFnUX9eue1FUj7tq5s8ghm
	 PSsTZpSOgLSja1BR5AR+FGfyL6DxrYcodFlOlrJm5lxXHvxfk5uxndcSowH68s0epl
	 RGBFoYQ/bK/NhLCONfJGvGn/9pwZmzFTLCUzmEMMArNPSFnFCA/SQNcD9z0n46f4j1
	 OLfbgFHNiS4ygI/oMw/7lhLdIKVcDHIW+4E2QHV5voGDMPGTHWg88x43FaXiQ9ihOU
	 1in9qma944WAg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v7 0/7] NVME over MPTCP
Date: Tue, 31 Mar 2026 18:28:24 +0800
Message-ID: <cover.1774952107.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v7:
 - address comments reported by ai-review.
 - change sockops in nvmet_tcp_port and nvme_tcp_ctrl as a pointer.
 - add null checks for queue->port->sockops in nvmet_tcp_set_queue_sock.
 - add inline for mptcp_sock_set_priority and mptcp_sock_set_tos in
   mptcp.h
 - use "ssk = msk->first" instead of "ssk = __mptcp_nmpc_sk(msk)" in
   mptcp_sock_set_priority, mptcp_sock_no_linger and mptcp_sock_set_tos.
 - drop sk_is_tcp in nvmet_tcp_done_recv_pdu
 - move ctrl->sockops setting before nvme_init_ctrl in
   nvme_tcp_alloc_ctrl
 - define nvme_mptcp_ctrl_ops
 - add MODULE_ALIAS("nvme-mptcp")
 - add more CONFIG_MPTCP checks
 - update selftest

v6:
 - introduce nvmet_tcp_sockops and nvme_tcp_sockops structures
 - fix set_reuseaddr, set_nodelay and set_syncnt, add sockopt_seq_inc
 calls, only set the first subflow, and synchronize to other subflows in
 sync_socket_options
 - Add implementations for no_linger, set_priority and set_tos
 - This version no longer depends on the "mptcp: fix stall because of
 data_ready" series of fixes
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1774862875.git.tanggeliang@kylinos.cn/

v5:
 - address comments reported by ai-review: set msk->nodelay to true in
   mptcp_sock_set_nodelay, set sk->sk_reuse to ssk->sk_reuse in
   mptcp_sock_set_reuseaddr, add mptcp_nvme.sh to TEST_PROGS, and adjust
   the order of patches.
 - remove TLS-related options from .allowed_opts of
   nvme_mptcp_transport.
 - some cleanups for selftest.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1773374342.git.tanggeliang@kylinos.cn/

v4:
 - a new patch to set nvme iopolicy as Nilay suggested.
 - resend all set to trigger AI review.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1772683110.git.tanggeliang@kylinos.cn/

v3:
 - update the implementation of sock_set_nodelay: originally it only set
the first subflow, but now it sets every subflow.
 - use sk_is_msk helper in this set.
 - update the selftest to perform testing under a multi-interface
environment.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1770627071.git.tanggeliang@kylinos.cn/

v2:
 - Patch 1 fixes the timeout issue reported in v1, thanks to Paolo and Gang
Yan for their help.
 - Patch 5 implements an MPTCP-specific sock_set_syncnt helper.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1764152990.git.tanggeliang@kylinos.cn/

This series (previously named "MPTCP support to 'NVME over TCP'") had three
RFC versions sent to Hannes in May, with subsequent revisions based on his
input. Following that, I initiated the process of upstreaming the dependent
"implement mptcp read_sock" series to the main MPTCP repository, which has
been merged into net-next recently.

Geliang Tang (7):
  nvmet-tcp: define target tcp_sockops struct
  nvmet-tcp: implement target mptcp sockops
  nvmet-tcp: register target mptcp transport
  nvme-tcp: define host tcp_sockops struct
  nvme-tcp: implement host mptcp sockops
  nvme-tcp: register host mptcp transport
  selftests: mptcp: add NVMe over MPTCP test

 drivers/nvme/host/tcp.c                       |  98 +++++++-
 drivers/nvme/target/configfs.c                |   1 +
 drivers/nvme/target/tcp.c                     |  99 +++++++-
 include/linux/nvme.h                          |   1 +
 include/net/mptcp.h                           |  27 +++
 net/mptcp/protocol.h                          |   1 +
 net/mptcp/sockopt.c                           | 120 ++++++++++
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 tools/testing/selftests/net/mptcp/config      |   7 +
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  12 +
 .../testing/selftests/net/mptcp/mptcp_nvme.sh | 220 ++++++++++++++++++
 11 files changed, 572 insertions(+), 15 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_nvme.sh

-- 
2.51.0

