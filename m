Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C52412DD90
	for <mptcp@lists.linux.dev>; Wed,  2 Oct 2024 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881325; cv=none; b=Poi32h/AwfBVOVfpKkHcbO0yd3RGZAYEOkRlA3at9jaw/ZDQo1xXGqGZj3p1TaifePr0g0ngO3iEOWd8yqmmEs0Egss7yfDc+klYvmoUMshyN8/aQV2jbfTPsg/M6tEbOQ9OfLoC2k9pf270HxmlshEOheo/aZEmnvam89577cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881325; c=relaxed/simple;
	bh=SPIuf/cKLbcFf3m3aE3wCmQOHaO0qO6fEENy7wz9lMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=juSfFGCaC34bopHorNGGtcRehf7qYPuXbDQ3FNxAEYI7qSiBG76oL9zYA/tbHNlc82Fi4aucAs0wc0kPlw4aKMglfZRpvKO62fo8/rQeIYxHD4eCgrFGGz5QLl6OnP6eW5pJkI7sFszoGA/Qmhlqim0aVUdlzFcl5Q7FavPZhoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eO7SeVFO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eO7SeVFO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4778CC4CEC2;
	Wed,  2 Oct 2024 15:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727881325;
	bh=SPIuf/cKLbcFf3m3aE3wCmQOHaO0qO6fEENy7wz9lMs=;
	h=From:To:Cc:Subject:Date:From;
	b=eO7SeVFO4+XdcsNs6ZRzxe4AuTbKq177cMpH376qTuz9ubAZqQQSgipRHT3uLS6/d
	 wX0eKJc/cIDMnhRQ3xtoYEqaB9xL59xhm6LWiNVOPTP3D9zqcfH2N22+Ow2cQFqx1l
	 x7Tvuw1p3eLgdHzut4KUTDmCeID4TQhR1McnoyASictw2GmiX43QnLkkKzOUyGmioq
	 hGrSIDU0ydnRelb2MPWIt0dc9gC/iYBg0YQFaYxR4AoBfun1xux4k6BMTfeGSxKpRE
	 AEqvFHzhEhVCmcnQAE2A4j5RYvYPaod9qik9KuDKRt3w9BEVpuIVo4kR7MsRg7Qw54
	 G6XJ8c0Mw8lNA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/9] cleanups for PM interfaces
Date: Wed,  2 Oct 2024 23:01:50 +0800
Message-ID: <cover.1727881073.git.tanggeliang@kylinos.cn>
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
 - add a new helper mptcp_userspace_pm_get_sock.

In order to implement BPF userspace path manager, it is necessary to
unify the interfaces of the path manager. This set contains some
cleanups for unify the interfaces.

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
	bool (*is_backup)(struct mptcp_sock *msk,
			  struct mptcp_addr_info *skc);
	struct mptcp_pm_addr_entry *(*get_addr)(struct mptcp_sock *msk,
						u8 id);
	int (*dump_addr)(struct mptcp_sock *msk,
			 struct mptcp_id_bitmap *bitmap);
	int (*set_flags)(struct mptcp_sock *msk,
			 struct mptcp_pm_addr_entry *local,
			 struct mptcp_addr_info *remote);

	u8			type;
	struct module		*owner;
	struct list_head	list;

	void (*init)(struct mptcp_sock *msk);
	void (*release)(struct mptcp_sock *msk);
} ____cacheline_aligned_in_smp;

Geliang Tang (9):
  mptcp: add struct mptcp_id_bitmap
  mptcp: add mptcp_userspace_pm_get_sock helper
  mptcp: use __lookup_addr in pm_netlink
  mptcp: add lookup_addr for userspace pm
  mptcp: change remote as mptcp_addr_info
  mptcp: change local as mptcp_pm_addr_entry
  mptcp: make pm wrappers static
  mptcp: drop skb parameter of get_addr
  mptcp: drop skb parameter of set_flags

 net/mptcp/pm.c           |  25 +---
 net/mptcp/pm_netlink.c   |  99 +++++++++-------
 net/mptcp/pm_userspace.c | 244 ++++++++++++++++-----------------------
 net/mptcp/protocol.h     |  18 ++-
 4 files changed, 163 insertions(+), 223 deletions(-)

-- 
2.43.0

