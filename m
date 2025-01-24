Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3F333998
	for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737702702; cv=none; b=OBxrj2u+JmyaG+eeAuLffT7Oy/VSQ+M4L6RJVgzMOWa8gm5Zk1sfD4rLn3BEhTUS00CZFVPJz2gHQO+R2J5hBetFP/kKH7Jx+c0pYsLqQBAjaUg7e/nCE2U/IvkgIOlMZzNk4MUrCLsZdRRDbZbGdMl55P2WXXsjdnaXQJDpVP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737702702; c=relaxed/simple;
	bh=rMxVys4eAR+ksSXp278HlioBiVye4yhDBrco2xV6zVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iiC2CIh04EsN8NprecJmIlNhAtdloe5dQmIZ0/GIKlLR07DoZZOldyMSOV1iWlkmsFZTDk3+WX5a1Kwi7gInwaDPhtG2yFTDaEreapKtHkZ2wkHCqTJ6qOj2oZvB4bZeuSWJbBi3Nzn7qjL1tgK/zFAo/0XxW9RsUJ78JoPI2H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHkjB1ix; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHkjB1ix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81FBC4CED2;
	Fri, 24 Jan 2025 07:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737702702;
	bh=rMxVys4eAR+ksSXp278HlioBiVye4yhDBrco2xV6zVU=;
	h=From:To:Cc:Subject:Date:From;
	b=dHkjB1ixXsigrbMRKfsMzd6fl1/fOkXMAKq/D/gPpodd1faS/KFf2VG3dHlazH+/t
	 Ia/ek3t1ebwujQOciQt8cm839n8DZG3idNATNv5zIVZjeSRjAi18nmHB2cMUM4N8BL
	 mBk24KJYbzqqAm1RWV3gme9TDIOMYuuEKZpWZjjTYW2c130bmNiE8UxKzquZKdIzKA
	 T49l+lFFYXouKwQmpiW1eUORCNxf+INUc82WmeIED+QEUknkE/U6aD305CAJbb9ugy
	 VkXEcDssCTQrtJ8GTM4r8CfcEdSUCkEbXzal6T8Ot4cFe3QW6UlsORq2MyN4uxaI+A
	 ma28rWe0/vxkw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 0/5] BPF path manager, part 3
Date: Fri, 24 Jan 2025 15:10:42 +0800
Message-ID: <cover.1737702298.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - drop "change is_backup interfaces as get_flags"
 - move "add struct mptcp_pm_addr_id_bitmap" and "hold msk lock before
removing id 0 address" out of this set.
 - a new patch "use ipv6_addr_equal in addresses_equal"
 - patch 4, drop inet6_sk() in mptcp_event_add_subflow() and
   mptcp_event_pm_listener() too.

v4:
 - add a new patch, "add a build check for userspace_pm_dump_addr" as
   Matt suggested.
 - patch 4, fix a warning here reported by CI:
   WARNING: line length of 84 exceeds 80 columns
   #27: FILE: net/mptcp/pm_userspace.c:468:

v3:
 - drop "mptcp: update address type of get_local_id".

v2:
 - a new patch "hold msk lock before removing id 0 address"

Drop the patch "mptcp: reuse sending nlmsg code in dump_addr", add a new
helper mptcp_pm_genl_fill_addr() to save the duplicated code.

Define struct mptcp_pm_addr_id_bitmap in protocol.h, instead of defining
mptcp_pm_addr_id_bitmap_t in include/net/mptcp.h, since get_addr() and
dump_addr() interfaces of BPF userspace pm is dropped as Matt suggested.

Geliang Tang (5):
  mptcp: add a build check for userspace_pm_dump_addr
  mptcp: add mptcp_pm_genl_fill_addr helper
  mptcp: drop match in userspace_pm_append_new_local_addr
  mptcp: drop inet6_sk after inet_sk
  mptcp: use ipv6_addr_equal in addresses_equal

 net/mptcp/pm.c           | 21 +++++++++++++++++++++
 net/mptcp/pm_netlink.c   | 22 ++++------------------
 net/mptcp/pm_userspace.c | 29 +++++++----------------------
 net/mptcp/protocol.h     |  3 +++
 4 files changed, 35 insertions(+), 40 deletions(-)

-- 
2.43.0

