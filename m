Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7FB22F392
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924921; cv=none; b=CCcyBUyz5vXNjCkt1FG3ZUyP9sxuothPKLWzuNyiwy2hGkTQeqy709cLUwF9oit9aXBlj1Xa/umHqr3Ge97zSHSlo75DMqUKebkTgsAnTEOP3dFm1i70svhgJ5xQ6x/9ruffP8nJ1XAsAQE+xdj789Y6LEz+8uZ4xNGetyJxBOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924921; c=relaxed/simple;
	bh=fc6QrIkmIhxv2ZbseVaBtH7kjCoibav6EEY5+3TEK5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ChyArim4dcq+z0mXFGnXyO+dbG/qqc+5YhFdd/9KZl34SXhBsxHzTNQzzGhea9/x8zUGJFrkOwJ++4ey/YBWn3czaMe5nN3qwKPFMxgzuw63O8VyRcIGM9KYlK/kYTK/U9CfwFjM+V5nbMn2qDP3owLSplc521+Dakqxrqvzh4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SN0DYfy+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SN0DYfy+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F015BC4CEDF;
	Wed, 15 Jan 2025 07:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736924921;
	bh=fc6QrIkmIhxv2ZbseVaBtH7kjCoibav6EEY5+3TEK5I=;
	h=From:To:Cc:Subject:Date:From;
	b=SN0DYfy+yGOYPfGF08tBaYvG3WZuwIWaYRo0QZX6b8nv6Kt5AVo2tHLYh401al4bo
	 ml+JnkuSDuT3dyuJALRQbMdDq/49slh723Rry1nI2TKgnw9LPIjfbRRTQyTROY/6iH
	 /rkM6NRcYi3coZ1Hkcu6IFwfsJu9pK0jBT0wsxqjnkLdFzYjoZUoTxTGuJppEYXeyJ
	 Fz4J0jKVzsrRQfje9HKlXC1+EJJA9Bo9m/izbaPDpuUorYoYOXowHCvTzEg+n9i0N8
	 MA5lI/R60OLXVs/Y8Jn28tulXnp/L6y2wu9FbdcH82WFasYMre6mixZGhU8ohOly4l
	 Lz2Chg1+ideBA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/3] BPF path manager, part 4
Date: Wed, 15 Jan 2025 15:08:31 +0800
Message-ID: <cover.1736924549.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

get_addr() and dump_addr() interfaces of BPF userspace pm are dropped
as Matt suggested.

Based-on: <cover.1736924314.git.tanggeliang@kylinos.cn>

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
 net/mptcp/pm_userspace.c | 362 ++++++++++++++++++++++++++++-----------
 net/mptcp/protocol.c     |   1 +
 net/mptcp/protocol.h     |   9 +
 5 files changed, 309 insertions(+), 98 deletions(-)

-- 
2.43.0

