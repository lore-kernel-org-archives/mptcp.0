Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EBE3EEAD1
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106073; cv=none; b=p0SLugYWf7jW1q52gZndycjHq/2yFqKwfzjc9fKPLoxS5lmFNZcxFCWIESp5l1Fry0R7853lvNRu6iyIR9aRopuriRjzJHbO8a3VckSW4I9bPIs5HlmM2NaFk/wnh8k2yBYqBMYGFNyRro5JztD/xCvagwxTXs4tv3zXrP3K9s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106073; c=relaxed/simple;
	bh=9/jOwsHCNZGpItBs/fPilEq+SRJ4g0fRVjKmJNsUFjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p+0Nv8kbSvuxgkT42OeBcKLNSd197ju1CfYxLulfZQILEV1NYH+ND+A+ujB+DdI6cZHTrVKkdf0W1Ql6NUYUIMi+daHzkStICxbEUPNR471OR2eAr0gxIxpAp3R0duXY5OFTfJd5NWhsqmx19Y0Selv3bkSJtfqQsi4OGTAhgSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZrQVQEF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZrQVQEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1253C2BCB8;
	Mon, 18 May 2026 12:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779106072;
	bh=9/jOwsHCNZGpItBs/fPilEq+SRJ4g0fRVjKmJNsUFjo=;
	h=From:To:Cc:Subject:Date:From;
	b=TZrQVQEFpRwnPkQVyg1YTyP5YiQLcl5NtjjC7VgRrQDberbk44QtIhMvwEfdUacC6
	 jbe6ePOC/25tHD3OxuH1nfP1G9qIfMN3Jy6Ay3MRVQ9mTtYSAS8TCCGXHEdiyNW457
	 ZSQ7nXwxRFB7JmdW9mmTtDfVE8Tl+ExmS98tQEI00HYD3GY0fUWkJ2j6mUSvnT9lBC
	 7OWmIKeFY9hFqBu41t1RKMEhHDNh6MWzdrd0if9niqC69wZwsTa8JWELofLHmXne2E
	 EM33t2yv/v16cLiDaXEb9kmlBpRzHPFGTVgFzCMaLAF0yLGGVE7Jt2qllkYXZwXKTn
	 VpxIDtF2Hf/OA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v13 00/12] NVME over MPTCP
Date: Mon, 18 May 2026 20:07:25 +0800
Message-ID: <cover.1779104752.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v13:
 - Patch 1
   - adds kref reference counting to struct nvmet_tcp_port
 - Patch 2
   - add nvmet_tcp_done_recv_pdu to use tr_ops from nport structure
     instead of hardcoded nvmet_tcp_ops (moved from v12 Patch 1)
 - Patch 4
   - split mptcp_sock_set_tos into __mptcp_sock_set_tos (internal) and
     mptcp_sock_set_tos (get rcv_tos from first subflow)
   - add protocol validation to all MPTCP helpers
 - Patch 7
   - export __mptcp_sock_set_tos
   - add protocol validation to mptcp_sock_set_syncnt
 - Patch 12 (new)
   - fix module unload race with concurrent sysfs controller deletion

v12:
 - Patch 1 (new):
   - Add nvmet_tcp_done_recv_pdu to use tr_ops from nport structure instead
     of hardcoded nvmet_tcp_ops
 - Patch 2:
   - Remove RCU protection for proto access
   - Store proto pointer directly in struct nvmet_tcp_queue instead of
     struct nvmet_tcp_port
   - Determine proto based on port->sock->sk->sk_protocol during queue
     allocation
   - Delete port->proto field from struct nvmet_tcp_port
   - Remove RCU annotations and rcu_dereference() for proto access
 - Patch 3:
   - Add nvmet_mptcp_registered flag to track successful MPTCP transport
     registration
   - Only unregister MPTCP transport during module exit if registration
     succeeded
   - Guard MODULE_ALIAS("nvmet-transport-4") with #ifdef CONFIG_MPTCP
 - Patch 4:
   - Remove unnecessary sock_hold()/sock_put() pairs in MPTCP helpers
   - Remove redundant priority >= 0 check in sync_socket_options()
 - Patch 8:
   - Move trap cleanup EXIT before init() to ensure cleanup runs on early
     failure
   - Export variables (nqn, path, port, etc.) immediately upon definition
 - Patch 9:
   - Skip iopolicy setting gracefully when iopolicy sysfs file does not
     exist (kernel without NVMe multipath support)
 Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1779087443.git.tanggeliang@kylinos.cn/

v11:
 Patch 2 (new):
 - Add RCU protection for host_iface validation to fix a pre-existing
   use-after-free issue when validating network interface names.
 Patch 3:
 - Add RCU protection for queue->port access in nvmet_tcp_alloc_cmd
   (previously missing).
 - Cache proto pointer in nvmet_tcp_done_recv_pdu before releasing
   RCU lock.
 Patch 4:
 - Remove nvmet_unregister_transport(&nvmet_tcp_ops) on MPTCP registration
   failure (MPTCP is optional, TCP continues to work).
 Patch 5:
 - Update MPTCP helper functions to iterate over all subflows using
   mptcp_for_each_subflow().
 - Add sock_hold() with explanatory comment for concurrent subflow closure
   protection.
 - Fix priority synchronization in sync_socket_options: change condition
   from priority > 0 to priority >= 0 to allow priority 0.
 Patch 9:
 - Simplify validate_params: use regex ^[1-4]$ for path validation.
 - Remove tc_args quotes in init() to allow proper word splitting for netem
   parameters.
 Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1778997507.git.tanggeliang@kylinos.cn/

v10:
 Patch 1 (new):
 - Add Fixes tag to the commit that checks return value of
   nvmet_tcp_set_queue_sock.
 Patch 2:
 - Fix RCU read lock release issue in nvmet_tcp_done_recv_pdu:
   move rcu_read_unlock() after nvmet_req_init().
 - Fix RCU read lock release issue in nvmet_tcp_set_queue_sock:
   cache proto pointer before releasing RCU lock.
 - Add missing NULL checks for queue->port in nvmet_tcp_alloc_cmd,
   nvmet_tcp_try_peek_pdu and nvmet_tcp_tls_handshake.
 - Add __rcu annotation to queue->port in struct nvmet_tcp_queue.
 - Use rcu_access_pointer() instead of rcu_dereference() in
   nvmet_tcp_destroy_port_queues.
 - Remove redundant kfree_rcu() in nvmet_tcp_remove_port, use kfree()
   since synchronize_rcu() already guarantees safety.
 Patch 4:
 - Add lock_sock_nested(ssk, SINGLE_DEPTH_NESTING) to all MPTCP helpers
   to avoid lockdep warnings.
 - Fix mptcp_sock_no_linger to properly set linger on subflow inside the
   lock.
 Patch 8:
 - Move init before trap cleanup to prevent cleanup errors when early
   exit occurs.
 - Fix usage text: change default path value from 4 to 1 to match actual
   behavior.
 - Fix break 2 to break (only one loop level).
 Patch 9:
 - Change grep -B 5 to grep (without -B) to avoid matching host NVMe
   devices.
 Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1778919284.git.tanggeliang@kylinos.cn/

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
 Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1778837549.git.tanggeliang@kylinos.cn/

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

Cc: zhenwei pi <zhenwei.pi@linux.dev>
Cc: Hui Zhu <zhuhui@kylinos.cn>
Cc: Gang Yan <yangang@kylinos.cn>

Geliang Tang (12):
  nvmet-tcp: use tr_ops from nport and add port refcounting
  nvmet-tcp: define target tcp_proto struct
  nvmet-tcp: register target mptcp transport
  nvmet-tcp: implement target mptcp proto
  nvme-tcp: define host tcp_proto struct
  nvme-tcp: register host mptcp transport
  nvme-tcp: implement host mptcp proto
  selftests: mptcp: add nvme over mptcp test
  selftests: mptcp: nvme: add iopolicy tests
  nvmet-tcp: check return value of set_queue_sock
  nvme-tcp: add RCU protection for host_iface validation
  nvme-tcp: wait for synchronous controller deletion on module unload

 drivers/nvme/host/tcp.c                       | 122 +++++-
 drivers/nvme/target/configfs.c                |   1 +
 drivers/nvme/target/tcp.c                     | 134 +++++-
 include/linux/nvme.h                          |   1 +
 include/net/mptcp.h                           |  31 ++
 net/mptcp/sockopt.c                           | 186 ++++++++
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 tools/testing/selftests/net/mptcp/config      |   8 +
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  12 +
 .../testing/selftests/net/mptcp/mptcp_nvme.sh | 399 ++++++++++++++++++
 10 files changed, 868 insertions(+), 27 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_nvme.sh

-- 
2.53.0

