Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D20F194AFE
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588492; cv=none; b=t7eIu9lLPmjaIu5G3/LkiIm1Twhx8pXjZvr1NHGbsv4ikXRcWYPt1rwdvMczJjf117iF6kfdzbGT1czhhaBae4df0JNZ61Lug+qPdR65Y+zHDYFL658QixkAjVvz0H+aJuQLbA8WiDxU9eX5av9O7F69kJZYXwSZRc91BZTBHWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588492; c=relaxed/simple;
	bh=JLC6iH4cdDwdCsgrzU7sQ0pJJnMC+JyI6/EkNUSf1zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HNMscDVdcQnpqXc2gD6dPEekUPWVgFLOAs6sPDMMawyEqGzrhgkmOwJ7Fpg7Gl7UPuH0eCuCC3VB99W4Qi9xVorZdDWJ+sdJh+Bdqc37BevddRpQ5tyt8ZTrUNm5OQeBr21IuEhcEUhI9+AI3bvm0a2c46kPWO2y/O6KGfFjAIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdpjUqGP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdpjUqGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6ECC4CEEB;
	Tue, 22 Oct 2024 09:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588492;
	bh=JLC6iH4cdDwdCsgrzU7sQ0pJJnMC+JyI6/EkNUSf1zo=;
	h=From:To:Cc:Subject:Date:From;
	b=mdpjUqGP03F4DT4q4tNW9awLpTYfYxzhDnhAPgWNucZpfoM/zRC9+n4nKDO5GfALA
	 p0fCPZOJOrJPRzEWV8fUqQoOy+bUaT35uB0emwGKXR7Tv55Bzq2NkKs9QE81/8j4E4
	 Ds64Bg0WyoWtLf2Bvf8r3+FhifQHOP8E/vgrSBjgIMGroLP1p2HqKz6PZHrntX34K4
	 JBJxR938UgoDbFpD2nJwhJAOcjdBpDNQ4ypsh9MnRM348zr2nnPUaUneLDxOdB2hgv
	 mEWf6VKgSAxztbD8X5yJqPwn4AEHf/WvkKdFB2CHENg2966u3y8UzABRYXBmP/rHcW
	 ipmw5pRpDJ3Mg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 00/36] BPF path manager
Date: Tue, 22 Oct 2024 17:14:08 +0800
Message-ID: <cover.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
                         struct mptcp_id_bitmap *bitmap);
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

Depends on:
 - "add mptcp_address bpf_iter" v2

Based-on: <cover.1729582332.git.tanggeliang@kylinos.cn>

Geliang Tang (36):
  mptcp: drop else in mptcp_pm_addr_families_match
  mptcp: use __lookup_addr in pm_netlink
  mptcp: add mptcp_for_each_address macros
  mptcp: use sock_kfree_s instead of kfree
  mptcp: add lookup_addr for userspace pm
  mptcp: add mptcp_userspace_pm_get_sock helper
  mptcp: make three pm wrappers static
  mptcp: drop skb parameter of get_addr
  mptcp: add id parameter for get_addr
  mptcp: add addr parameter for get_addr
  mptcp: reuse sending nlmsg code in get_addr
  mptcp: change info of get_addr as const
  mptcp: add struct mptcp_id_bitmap
  mptcp: refactor dump_addr with id bitmap
  mptcp: refactor dump_addr with get_addr
  mptcp: reuse sending nlmsg code in dump_addr
  mptcp: update local address flags when setting it
  mptcp: change rem type of set_flags
  mptcp: drop skb parameter of set_flags
  mptcp: add loc and rem for set_flags
  mptcp: update address type of get_local_id
  mptcp: change is_backup interfaces as get_flags
  mptcp: drop struct mptcp_pm_local
  mptcp: drop struct mptcp_pm_add_entry
  mptcp: change local type of subflow_destroy
  mptcp: hold pm lock when deleting entry
  mptcp: rename mptcp_pm_remove_addrs
  mptcp: drop free_list for deleting entries
  mptcp: define struct mptcp_pm_ops
  mptcp: implement userspace pm interfaces
  mptcp: register default userspace pm
  bpf: Add mptcp path manager struct_ops
  bpf: Register mptcp struct_ops kfunc set
  Squash to "bpf: Export mptcp packet scheduler helpers"
  selftests/bpf: Add mptcp userspace pm subtest
  selftests/bpf: Add mptcp bpf path manager subtest

 include/net/mptcp.h                           |  32 +
 net/mptcp/bpf.c                               | 377 ++++++++-
 net/mptcp/pm.c                                |  53 +-
 net/mptcp/pm_netlink.c                        | 313 +++----
 net/mptcp/pm_userspace.c                      | 777 ++++++++++--------
 net/mptcp/protocol.c                          |   1 +
 net/mptcp/protocol.h                          |  81 +-
 net/mptcp/subflow.c                           |   2 +-
 tools/testing/selftests/bpf/config            |   1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 305 +++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  71 ++
 .../bpf/progs/mptcp_bpf_userspace_pm.c        | 409 +++++++++
 12 files changed, 1855 insertions(+), 567 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_userspace_pm.c

-- 
2.45.2

