Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAA81A682C
	for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863935; cv=none; b=ZcU0BkCcDmhA29UklNzNthRpYZzhTB5afAvzo2PazgfWnDTEz50bvpLRJ8/q0iWjiqWVQmGQayfgj6BySH0o4dbeQKwXGhbbwG5KDRB1pHlEKYhDwI2Aae/bdc159OqIyGkOONnyn+4ing3vbPCM0nuLrFq83EKjTMREHmBdVGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863935; c=relaxed/simple;
	bh=9H8gNTqlKxNY/xNRH7D69q9hIz2AYSi71eT8VrZ+8Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lOM/gJzFGCulPG0/QtLizKt9idg3VcdSgWC/zsOHb7Y4PPvKfvSNbmO0iwV1clcGYfZeQDDKOAGu5lI2QzjAGyttLOYh1wS9DqVJ+18XtXHmwSK6Mf8Mafiun9OGAGr2lt/uYxUP9gktJ1uLHBG2CYbXc2dOeh1D0MF76aASMZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbqCX/FQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbqCX/FQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E523C4CEF7;
	Mon, 30 Mar 2026 09:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774863935;
	bh=9H8gNTqlKxNY/xNRH7D69q9hIz2AYSi71eT8VrZ+8Ws=;
	h=From:To:Cc:Subject:Date:From;
	b=TbqCX/FQ3ZGNTBClLSbezFNcHPYYO89guUvimrZ4IQwi9uUHaD4ULrwdRxXpJzJEB
	 2BHLYCZ6JBbOP3+Dnycp+hW4xIwNq/tkcJVTf5VaNay5xktOo6+fmNKJgVKMAW6cGl
	 OjDIGOzqN0TwuZ1dZYMbJ0wOmrwM6zd6P3Sbww2ZEChx3okxcrFnvDYu/7erzSeFBq
	 juRiwXe3lTrkSX+TGOFSh3fOUgnDTZoknV/b6YAFDVQvISyPpOKYVnqzrO6H3TyQCU
	 8363Or2I2HpiGubVziTfww2p4j82EmH2BRCUxXv2Ws98oXS6bULVhRx/l4FJ0dLKmp
	 QYbSffqTbKVig==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v6 0/7] NVME over MPTCP
Date: Mon, 30 Mar 2026 17:43:25 +0800
Message-ID: <cover.1774862875.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v6:
 - introduce nvmet_tcp_sockops and nvme_tcp_sockops structures
 - fix set_reuseaddr, set_nodelay and set_syncnt, add sockopt_seq_inc
 calls, only set the first subflow, and synchronize to other subflows in
 sync_socket_options
 - Add implementations for no_linger, set_priority and set_tos
 - This version no longer depends on the "mptcp: fix stall because of
 data_ready" series of fixes

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

 drivers/nvme/host/tcp.c                       |  66 +++++-
 drivers/nvme/target/configfs.c                |   1 +
 drivers/nvme/target/tcp.c                     |  79 ++++++-
 include/linux/nvme.h                          |   1 +
 include/net/mptcp.h                           |  27 +++
 net/mptcp/protocol.h                          |   1 +
 net/mptcp/sockopt.c                           | 120 ++++++++++
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 tools/testing/selftests/net/mptcp/config      |   7 +
 .../testing/selftests/net/mptcp/mptcp_nvme.sh | 205 ++++++++++++++++++
 10 files changed, 494 insertions(+), 14 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_nvme.sh

-- 
2.51.0

