Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ACA2E3379
	for <mptcp@lists.linux.dev>; Fri, 14 Mar 2025 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741920342; cv=none; b=uRl37v5JlsxbXytGIBU12glSe7WQ9ihbieWBCRewsxGABpYO4sLqe/VLbOZxZ+261H8uvVo73F1g52P2FOu8ugoUO3+ETuYInQupsqCJW3ZAPcREHGB8jI55MICDx3vRiolpJe2vVh9PMhPS+3Bz6g6OqF8A4EbvNftjaCssRQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741920342; c=relaxed/simple;
	bh=ZwLMH7rBG+YrrukmXuqfK+bXsCTc5IBIqkQkwagkL6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AGcWXn41Sz6rOwQK3tJtXjTfBrR5s7274Kv0yCNdWXJrRl8fPZYrqBddZRbiNxVIafp+0xtNCV2xeB+fq6pJAgPff7nD71/dzWbuifFZT7Na1pkxTOmSA7uKyZhuQSeRnci9bbQAwdLLBtFZkIdQ8cjyjox85OW7KI8tdQGSaj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ0yB8SX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ0yB8SX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF66C4CEDD;
	Fri, 14 Mar 2025 02:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741920342;
	bh=ZwLMH7rBG+YrrukmXuqfK+bXsCTc5IBIqkQkwagkL6M=;
	h=From:To:Cc:Subject:Date:From;
	b=TQ0yB8SXFV1owNPXde77ecjDzJ7LS4ZFYGOXjMvGVVuOZFQUAt2fLYmYEBkLJRn5x
	 3ws8qWvKNXPPKXt1izlKTcBakkeHYEPaBUwFXlzXMr7WMKYQyENlvK1SP7Z7wtlSLv
	 wm+kTUlBnEtiwGw9amcGNVs8YU65gEvdrHEm7lS30DtO/AQD9ySYEOBvEQ/CeEhTxl
	 eH9H2FKnJsTD9Bz7J0RGGEsL4lbXGMhhrm+WvRVOBTPtHYkZvMUsWcaeDwyS42ak1L
	 xrdwk44mzWgtKeoWGK+HACcvIQkGyz0POBsmi0kjkAD9qVopHU7pnS70FZkbt+7LS3
	 oRaf10yohL6/w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 00/10] BPF path manager, part 6
Date: Fri, 14 Mar 2025 10:45:21 +0800
Message-ID: <cover.1741919893.git.tanggeliang@kylinos.cn>
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
- address Matt's comments in v1.
- add add_addr_received and rm_addr_received interfaces.
- drop subflow_check_next interface.
- add a "required" or "optional" comment for a group of interfaces in
  struct mptcp_pm_ops.

v1:
- https://patchwork.kernel.org/project/mptcp/cover/cover.1741685260.git.tanggeliang@kylinos.cn/

New interfaces for struct mptcp_pm_ops.

Geliang Tang (10):
  mptcp: pm: drop redundant MPTCP_MIB_ADDADDRDROP
  Squash to "mptcp: pm: add get_local_id() interface"
  mptcp: pm: add established() interface
  mptcp: pm: add subflow_established() interface
  mptcp: pm: add allow_new_subflow() interface
  mptcp: pm: add accept_new_subflow() interface
  mptcp: pm: add add_addr_received() interface
  mptcp: pm: add add_addr_echo() interface
  mptcp: pm: add rm_addr_received() interface
  mptcp: pm: drop is_userspace in subflow_check_next

 include/net/mptcp.h      |  16 ++++++
 net/mptcp/pm.c           | 112 +++++++++++++++++----------------------
 net/mptcp/pm_kernel.c    |  74 ++++++++++++++++++++++----
 net/mptcp/pm_userspace.c |  27 ++++++++++
 net/mptcp/protocol.h     |   4 ++
 net/mptcp/subflow.c      |   4 +-
 6 files changed, 161 insertions(+), 76 deletions(-)

-- 
2.45.2

