Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C228543E485
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838394; cv=none; b=N2eSz2P9PM4k6ZVSbof4fcuImYhBna/tdFNhN9C2VDqxEJkVBPDMyiCyPpo+CgXkHHWNtOCVve6ekK0OC9h8yh6Zr0pWaQT3oVLw6uexPQG56A8lcHKP+4Hh8knUz8MtIaISDPaf5aRBfayIEneKJzo17M8sGWwaYygVougE90M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838394; c=relaxed/simple;
	bh=cg4zQYRohERR7Yl0ilHX7iNAwS4siebBrwI9PmKH94o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LCb0hMUYNThH4OArp91hRacs64uDMdhtMK0a3597mY1/BSwI81K2PzPyXzcp2cYxsm4HBdkuBxk8DggDw7kTU0EEmUIH4LvnVg5FsTRlJ5uqy8s3l2qSH2iJOAjcT9a66YmUtDQrcCr3hHWQPH7r2nBtq8r8kIOy5SLvB9pzYB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfBEBWtg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfBEBWtg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3549DC2BCB0;
	Fri, 15 May 2026 09:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778838394;
	bh=cg4zQYRohERR7Yl0ilHX7iNAwS4siebBrwI9PmKH94o=;
	h=From:To:Cc:Subject:Date:From;
	b=jfBEBWtg6Svq5mn64mSmzXsGBcF4LmBC0sLt28QEAN0/vs3XgxMtJLMjKzJeWFCnE
	 OPXmNNAdPryF03o7Hy1H05U57vWrdg4Ke+lYApTwvM4S2jrMyHpNnv+SKOR3oScWij
	 oaWPtIwPMdTQ2rq3Gd3FBiqzEpAqSIwBwIRdn0Ra8/HuOogCd1Qsf89ioiwx/ZaR5E
	 0lAACp2LGKmAqb9GZSLcgn3JghoZlE2NDwQa/sLV9MQTdXSpURAJxqtGhwfWxPS/N6
	 oTZDUp2BnA8orxBKZmxH8Dl5gtC4oB3cG2Yj36jnYr2Tf+9VesNrq+I/k+/0WWMIx5
	 Xw0bn2zGUVH8A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v9 0/8] NVME over MPTCP
Date: Fri, 15 May 2026 17:46:14 +0800
Message-ID: <cover.1778837549.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v9:
 Patch 1:
  - add NULL pointer checks for RCU dereference in nvmet_tcp_done_recv_pdu
  and nvmet_tcp_set_queue_sock.
  - clear queue->port using rcu_assign_pointer and add synchronize_rcu in
  nvmet_tcp_destroy_port_queues.
  - use kfree_rcu for port structure in nvmet_tcp_remove_port.
 Patch 2:
  - change module init order, make MPTCP registration optional to prevent
  UAF.
 Patch 3:
  - fix mptcp_sock_set_priority to save config on main socket first, use
  READ_ONCE and sock_hold.
  - fix mptcp_sock_no_linger to use READ_ONCE and sock_hold, call
  sock_no_linger on ssk.
  - fix mptcp_sock_set_tos to use READ_ONCE and sock_hold.
 Patch 4:
  - remove unnecessary RCU protection for ctrl->proto (points to static
  data).
  - remove rcu_head from nvme_tcp_ctrl, use kfree instead of kfree_rcu.
 Patch 6:
  - add msk->icsk_syn_retries check before calling tcp_sock_set_syncnt in
  sync_socket_options.
  - fix mptcp_sock_set_syncnt to always return 0 after saving config.
 Patch 7:
  - split selftests into two patches.
  - fix tool check order (call mptcp_lib_check_tools before temp_file
  creation).
  - add unshare -m in cleanup to prevent configfs mount leakage.
  - improve device name parsing from nvme connect output.
 Patch 8:
  - add iopolicy tests with set_io_policy function and error checking.
  - add loss parameter for packet loss simulation (delay 5ms loss 0.5%).

Cc: Hannes Reinecke <hare@suse.de>
Cc: zhenwei pi <zhenwei.pi@linux.dev>
Cc: Hui Zhu <zhuhui@kylinos.cn>
Cc: Gang Yan <yangang@kylinos.cn>

v8:
 - address comments reported by ai-review for v7.
 - add RCU protection for queue->port on target side.
 - add RCU protection ctrl->proto on host side.
 - check !msk->first instead of "IS_ERR(msk->first)".
 - fix return value of mptcp_sock_set_syncnt.
 - update selftest.
 - fix CI error: "[SKIP] Could not run all tests without nvme".
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1775047736.git.tanggeliang@kylinos.cn/

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

Geliang Tang (8):
  nvmet-tcp: define target tcp_proto struct
  nvmet-tcp: register target mptcp transport
  nvmet-tcp: implement target mptcp proto
  nvme-tcp: define host tcp_proto struct
  nvme-tcp: register host mptcp transport
  nvme-tcp: implement host mptcp proto
  selftests: mptcp: add nvme over mptcp test
  selftests: mptcp: nvme: add iopolicy tests

 drivers/nvme/host/tcp.c                       |  99 ++++-
 drivers/nvme/target/configfs.c                |   1 +
 drivers/nvme/target/tcp.c                     | 120 +++++-
 include/linux/nvme.h                          |   1 +
 include/net/mptcp.h                           |  27 ++
 net/mptcp/protocol.h                          |   1 +
 net/mptcp/sockopt.c                           | 120 ++++++
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 tools/testing/selftests/net/mptcp/config      |   7 +
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  12 +
 .../testing/selftests/net/mptcp/mptcp_nvme.sh | 370 ++++++++++++++++++
 11 files changed, 741 insertions(+), 18 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_nvme.sh

-- 
2.53.0

