Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1099E82C60
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961951; cv=none; b=G+o7UkkOEgMi9RJqA8YKotjN+FWC4FNQxNYLPfxQfzUEY+P0/T52GrRKpaSyFkBBXlUI4bg3BDQb9sPJvtlZm89+eixP0mbRbXDvpF5mjnVCiRk1OXoDUZJTT4ZTmwjKxSdYP/n72ihLomgZ+ibUgxiuDkKc/7Q7+KQkTJ2MVyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961951; c=relaxed/simple;
	bh=0AoqE8ex8khhASB7cJ4lr1RDhG8xYTfqiWe65RUgHHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sA3KU9cCsGUppnIk/spYRqE+/5BohxR2ittdIJVBsL0BdNYFnmrD2xwqUVsI1Hcvo8jPwSwF1oOZl3qVA1AtferCviiUr1R4Bth9g943LMJe/L6LKz86+Kzi0wxGzSgpRqcMQ+34w2JywrI8iN92pir8cNmNkvdH90wyhhfMHFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSy48SrI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSy48SrI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF96C4CECC;
	Thu,  7 Nov 2024 06:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730961950;
	bh=0AoqE8ex8khhASB7cJ4lr1RDhG8xYTfqiWe65RUgHHk=;
	h=From:To:Cc:Subject:Date:From;
	b=OSy48SrIFOLDUAO3OKNkxZ0tMEmkrqnoM+bf2HqFb1mpOnRUdNYULGXiJG6iRIl/m
	 87XRbjyd5bsvsNQbACBzL+5QfJTU5Jv8D0Lbk0hDRnDgV3+zANbuaRRS0t26MyUcRH
	 vMVI/TM8VQQ2zRfUGKhwzqzeyKTMgMjhp0ZKpx9pKTTgHJnie7Cfrgcv+K3WEcG/93
	 qpwQ8g6hMrVC+tRX+2Qad0fI0juzhU0RLdK7bieUU1U5MUTwB6lZxc7qTDq8F8f7QC
	 SfxCJjudCOgCko3wHiHDDSOWDU4cCo/xqW1MyIQ/BcHdMfnkqrS+huhKU73Lkwyz3B
	 Cp5fXCi7Lwzuw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/9] BPF path manager, part 1
Date: Thu,  7 Nov 2024 14:45:34 +0800
Message-ID: <cover.1730961809.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/74

Geliang Tang (9):
  mptcp: add mptcp_userspace_pm_lookup_addr helper
  mptcp: add mptcp_for_each_userspace_pm_addr macro
  mptcp: add mptcp_userspace_pm_get_sock helper
  mptcp: move mptcp_pm_remove_addrs into pm_userspace
  mptcp: drop free_list for deleting entries
  mptcp: use mptcp_pm_local in pm_netlink only
  mptcp: drop struct mptcp_pm_add_entry
  mptcp: change local addr type of subflow_destroy
  mptcp: drop useless "err = 0" in subflow_destroy

 net/mptcp/pm_netlink.c   |  97 +++++--------
 net/mptcp/pm_userspace.c | 306 +++++++++++++++++----------------------
 net/mptcp/protocol.h     |  35 +++--
 net/mptcp/subflow.c      |   2 +-
 4 files changed, 198 insertions(+), 242 deletions(-)

-- 
2.45.2

