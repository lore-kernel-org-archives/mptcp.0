Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2EB1E7C22
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935776; cv=none; b=NXmVmwQj/r4efkK2UNMaDYeqMOtzAunmSgt6niOdEmHXv13q4YTvQEwLZUEkCSGKI6xZkvb+PV7/t8sjp4WK2V0JNArcNekRy9gqgqUEwHWvKfPK544y9qNpK4RZkCAi2LSd8+TXPTz1XrdTBwtxX5DvhDh7ZoRhD4eGeSuTiNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935776; c=relaxed/simple;
	bh=9ER6ZuV/c9gvglJe32WsO5hEdTesh8P9DcUnIa9jEBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLV5Ec/7srYLXDnCK96nXoyKhwzvkGIVQG3ze48M7+gM2SrWrYfRseZAZU32HEqKs5tNQ9Ga9dib17WqXGhzTgn7rrXsFotXAjcz4UXWnNilw/LCQ2YnLoYBK4bL5H8hTaFrLnFqoaa9wgcPa7H01wWgblyrZB2kXZ7RvHdHcS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyWaOnnb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyWaOnnb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993D9C4CEE1;
	Wed, 15 Jan 2025 10:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736935775;
	bh=9ER6ZuV/c9gvglJe32WsO5hEdTesh8P9DcUnIa9jEBY=;
	h=From:To:Cc:Subject:Date:From;
	b=oyWaOnnbiIYqiHjLs4mZy3d4o2lZkmu7C4plylo9LaiwASChBGG6N7Co7rlX7VSba
	 siHqfveQuzn5+0Cb5cAhfRMOWIAQway6h+VAppl29lKsRr0GrHTE9jXROmWSkin/fS
	 Aywg0L083CSI6Vvsz3K9ulT0PRu98mBYT0VGtnDYAx1AXO9QZhoXOEvDoGoM7xrPV6
	 Myin/RR7soy87Lz1ueFY47d0CxTVFv5R8+rcaqxnhpJoOXHF1xvQlzR2aIR3EBv4DX
	 JH6SkAHnLFJctK241xCHcpLsOeEApimuZtTKhAHC39hr/cVMO//kZ9CoTMmc9eXs9n
	 6CDwUm8Huc7aA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/3] BPF path manager, part 4
Date: Wed, 15 Jan 2025 18:09:25 +0800
Message-ID: <cover.1736935433.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:

- update get_local_id interface in patch 2.

Depends on: "BPF path manager, part 3" v3

Based-on: <cover.1736935086.git.tanggeliang@kylinos.cn>

get_addr() and dump_addr() interfaces of BPF userspace pm are dropped
as Matt suggested.

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
	int (*set_flags)(struct mptcp_sock *msk,
			 struct mptcp_pm_addr_entry *local,
			 struct mptcp_addr_info *remote);

	u8			type;
	struct module		*owner;
	struct list_head	list;

	void (*init)(struct mptcp_sock *msk);
	void (*release)(struct mptcp_sock *msk);
} ____cacheline_aligned_in_smp;

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/74

Geliang Tang (3):
  mptcp: define struct mptcp_pm_ops
  mptcp: register default userspace pm
  mptcp: init and release mptcp_pm_ops

 include/net/mptcp.h      |  27 +++
 net/mptcp/pm.c           |   8 +
 net/mptcp/pm_userspace.c | 376 ++++++++++++++++++++++++++++-----------
 net/mptcp/protocol.c     |   1 +
 net/mptcp/protocol.h     |   9 +
 5 files changed, 317 insertions(+), 104 deletions(-)

-- 
2.43.0

