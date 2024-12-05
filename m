Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D90D1AB510
	for <mptcp@lists.linux.dev>; Thu,  5 Dec 2024 07:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382909; cv=none; b=j9qQ03iZSSUN6MEUEC8eES2qql2J3Ue8ro2v+JHVvg93P6chTLg9MGtuGPGeicShsA2Cmd/Y6Mh2CUcaGsBJ/KpQCalT44KwOQp6+hXYeS/bP1CqsShI+4kH2h+n76WrlgRvf8nhbzhwSMNXL/r3lFtg4jJxQdFMau/zPy4JKMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382909; c=relaxed/simple;
	bh=OdNHHAyBCG+G8eGB1zNRa9ydyLmQWoPOFUmiCbqzXh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IlGcT91W7Pgl2ovoYha45ODaMZkZ4ilBu569JTsV+MxdA9t4U8KLV6uDNpvjRZ14IBe9BsZgmPlToRcXi/nWZOoTukM95Q9CzPxcQL1A2+ShOnagT/NtJ2T+cI6bnBwWqNPx9swUmOHyURb+L/GcyF6Bz0nR5m0QFndBw5sUvY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n99A1pz2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n99A1pz2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1CDC4CED1;
	Thu,  5 Dec 2024 07:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733382908;
	bh=OdNHHAyBCG+G8eGB1zNRa9ydyLmQWoPOFUmiCbqzXh0=;
	h=From:To:Cc:Subject:Date:From;
	b=n99A1pz2LzjY7Vp1OD2dY1Gt4qbmAV7qIAs7Qmm+hJimcXf/gJpx0xwphmILuTbDP
	 XsejiCONf5n2uu9p1pugEriTbYlsHx+8mtXTdpSZ476se2G61SrgenPrBxz0jSVB+U
	 f8pIV1WFYGpfCg7EvR7B9kcMUh3ZS48Su0RJdkMLBQ2wv8twQIa4jfShowW/S2WB8C
	 VUJ+V9W12Pkr1ri/ojWz3pMz+4B6yGlzUxLseZIlb0rtbxkuet25xoqCMp7Depwgv/
	 2V5pxB134aONnDd6aheaX3q7HjH+N098kmWD3ETvGoogjVDZDy4VmGnQCJpXCQ1BTy
	 9KY51d2Gjay4w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/7] BPF path manager, part 1
Date: Thu,  5 Dec 2024 15:14:52 +0800
Message-ID: <cover.1733382222.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - #4 drop "/* Called from the in-kernel PM only */" commend too.
 - #5 drop 'out' label and if-statement in mptcp_pm_remove_addr_entry.
 - drop #6 and #7.
 - the last patch, add 'release_sock' label as Matt suggested.

v3:
 - address Matt's comments in v2 (thanks)
 - only include cleanups and refactoring patches in this set.

v2:
 - add BPF-related code in this set (32-36).

In order to implement BPF userspace path manager, it is necessary to
unify the interfaces of the path manager. This set contains some
cleanups and refactoring to unify the interfaces in kernel space.
Finally, define a struct mptcp_pm_ops for a userspace path manager
like this:

struct mptcp_pm_ops {
        int (*address_announce)(struct mptcp_sock *msk,
                                struct mptcp_pm_addr_entry *local);
        int (*address_remove)(struct mptcp_sock *msk, u8 id);
        int (*subflow_create)(struct mptcp_sock *msk,
                              struct mptcp_pm_addr_entry *local,
                              struct mptcp_addr_info *remote);
        int (*subflow_destroy)(struct mptcp_sock *msk,
                               struct mptcp_pm_addr_entry *local,
                               struct mptcp_addr_info *remote);
        int (*get_local_id)(struct mptcp_sock *msk,
                            struct mptcp_pm_addr_entry *local);
        u8 (*get_flags)(struct mptcp_sock *msk,
                        struct mptcp_addr_info *skc);
        struct mptcp_pm_addr_entry *(*get_addr)(struct mptcp_sock *msk,
                                                u8 id);
	int (*dump_addr)(struct mptcp_sock *msk,
			 mptcp_pm_addr_id_bitmap_t *bitmap);
        int (*set_flags)(struct mptcp_sock *msk,
                         struct mptcp_pm_addr_entry *local,
                         struct mptcp_addr_info *remote);

        u8                      type;
        struct module           *owner;
        struct list_head        list;

        void (*init)(struct mptcp_sock *msk);
        void (*release)(struct mptcp_sock *msk);
} ____cacheline_aligned_in_smp;

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/74

Geliang Tang (7):
  mptcp: add mptcp_userspace_pm_lookup_addr helper
  mptcp: add mptcp_for_each_userspace_pm_addr macro
  mptcp: add mptcp_userspace_pm_get_sock helper
  mptcp: move mptcp_pm_remove_addrs into pm_userspace
  mptcp: drop free_list for deleting entries
  mptcp: change local addr type of subflow_destroy
  mptcp: drop useless "err = 0" in subflow_destroy

 net/mptcp/pm_netlink.c   |  46 ++----
 net/mptcp/pm_userspace.c | 296 +++++++++++++++++----------------------
 net/mptcp/protocol.h     |   7 +-
 3 files changed, 146 insertions(+), 203 deletions(-)

-- 
2.45.2

