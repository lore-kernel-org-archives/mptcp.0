Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04793C457D
	for <mptcp@lists.linux.dev>; Wed,  1 Apr 2026 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775048052; cv=none; b=KCx0o1NwBGGpQzNOlctgKFLeV3tc6QuxMkj3qUjOF5aRH8KoRopYptOtZbTqAGqAN6QGUQN42dVBYXCLK80d26LgDlTcnWYtaMUPEK1hTskkLm+rZvVVs6//SZairM4Pogd+VXuoA4btqELiBuHsILvfcme85PGmMPLivhpySKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775048052; c=relaxed/simple;
	bh=3tyYBW/sJ5pXTVW1SQTUW+cl4FUKAixVszevYTTIglc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VdQa+1GW1UrIgk6Hgq1bjpIMBJ6c4PCTioSF1VMLMnJJ0ibvnh4qk1O0ovgKJJzifgZdLaKjZcbtYZN/vEujZuaLUO4LO86BBj6WehH1zGKaJA8AtO67/cgrfJC+pvWzedKsxZAsVQbyD4NY1eE/nz2JEyu0hG2SjJVZKMHjnlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PG5XrBuR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PG5XrBuR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADE1C4CEF7;
	Wed,  1 Apr 2026 12:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775048052;
	bh=3tyYBW/sJ5pXTVW1SQTUW+cl4FUKAixVszevYTTIglc=;
	h=From:To:Cc:Subject:Date:From;
	b=PG5XrBuRAPTundLOgE/tSV7JF0MiQATx1QLsWBK0/ALjxNdAKBy94XmElGFFZASwK
	 evG6bgSXfbjwQ/bFXT08Mq5lvPXfspXZU8YLUAsMRhOkqlGqdkUZeHtgG5l/+5ltcu
	 x0vuvdMPrNDwnJRZa56nA+RoLGRA9asIewS+xW8s73e2bE+UK1ilW1lUqCp4slr2l5
	 pcAG+0CIRb4r7oZawZUoT1LuyHVl6KDw+R379HYsJCeA297i8tuxSX+qiYQMlEA74X
	 aOP7fY68A9nxNM8DAgwEKTjI6r60RIU7erNm3RhoLxYXIpf3tbAZV8cZ0g64Wuy3gT
	 blmdk9GjCzCDw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v8 0/7] NVME over MPTCP
Date: Wed,  1 Apr 2026 20:53:38 +0800
Message-ID: <cover.1775047736.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v8:
 - address comments reported by ai-review for v7.
 - add RCU protection for queue->port on target side.
 - add RCU protection ctrl->proto on host side.
 - check !msk->first instead of "IS_ERR(msk->first)".
 - fix return value of mptcp_sock_set_syncnt.
 - update selftest.
 - fix CI error: "[SKIP] Could not run all tests without nvme".

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
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1774952107.git.tanggeliang@kylinos.cn/

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
  nvmet-tcp: define target tcp_proto struct
  nvmet-tcp: register target mptcp transport
  nvmet-tcp: implement target mptcp proto
  nvme-tcp: define host tcp_proto struct
  nvme-tcp: register host mptcp transport
  nvme-tcp: implement host mptcp proto
  selftests: mptcp: add NVMe over MPTCP test

 drivers/nvme/host/tcp.c                       | 108 +++++++-
 drivers/nvme/target/configfs.c                |   1 +
 drivers/nvme/target/tcp.c                     | 112 +++++++-
 include/linux/nvme.h                          |   1 +
 include/net/mptcp.h                           |  27 ++
 net/mptcp/protocol.h                          |   1 +
 net/mptcp/sockopt.c                           | 116 +++++++++
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 tools/testing/selftests/net/mptcp/config      |   7 +
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  12 +
 .../testing/selftests/net/mptcp/mptcp_nvme.sh | 240 ++++++++++++++++++
 11 files changed, 607 insertions(+), 19 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_nvme.sh

-- 
2.51.0

