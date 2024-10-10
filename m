Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E51917EB
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 05:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539287; cv=none; b=cxdGtJ0nH1XdptVWi0deHFpyzVIbAkurIE8/nw2H23PvbFQfGz3e/aH97XIote7hKcPaH8B5D6qHz5ssHe8TiEZlS6gD76nsVOcoJrbjNJ0kIsfXU6xO12vB3nW94ICei/2Sa8ZP8RGJ4QX/UgXNqQdZJLMohzNPpkGS9Uo311A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539287; c=relaxed/simple;
	bh=pnThZMKDcOvUKpkLZcvxXASD+uEn6TZliYzWZe6LH5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QNnDMHMY4k9K+n87K8CWyfsr9RmetK+bZU3PpAW/rkQMbySpRcubGcoHp/y4AKNPFxlgQw2iX1/4jliM1IL3ZHjkpiDqN/9daPw1hI2vpR6iG6XK0vzF6dzfA2e54GYdyEybpQfZJ4jM/cJOTwoE3i/T12cfACpYP+lUFiR+pXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGFTPbA7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGFTPbA7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03178C4CEC5;
	Thu, 10 Oct 2024 05:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728539286;
	bh=pnThZMKDcOvUKpkLZcvxXASD+uEn6TZliYzWZe6LH5I=;
	h=From:To:Cc:Subject:Date:From;
	b=gGFTPbA78mX6tXrlfYb/Oo8NCYi3V0BXirZKs4x516z/5CN4h1hyOR1do1kY4U2cF
	 AlbUQAsBkBjhhTD2jSf/wYu/Z9/KyZs7vbBonIqTyO2rdzecL6YF44D9MTs2KuXOea
	 7Dr4qxUARj/tvBC8ew8/+9/ABXvNu/P6dWxSxYURDI0+75n7S5L2VtqzTAYpE4tKtg
	 r8AlrZD9x2L0FGcUz9y9sPDZ2gP+ToqJkMz4Qc+c3Bd7HannCY5QIZrvRMxr9J8hY6
	 y+hiKvBK57D07quxDMekhwl97md3aoC0ZSzCG/KuJwmLrQ2NSeJAG02BNh8dUX0GKZ
	 OHfUcWBhR9Xfw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 00/15] refactor PM interfaces
Date: Thu, 10 Oct 2024 13:47:45 +0800
Message-ID: <cover.1728538975.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - two more patches, 14-15, drop struct mptcp_pm_local and struct
mptcp_pm_add_entry.

v2:
 - split patch 5 into two.
 - new patches 9-13.

In order to implement BPF path manager, this set refactors get_addr
and dump_addr interfaces of PM.

Depends on:
 - cleanups for PM interfaces, v3

Based-on: <cover.1728298100.git.tanggeliang@kylinos.cn>

Geliang Tang (15):
  mptcp: add id parameter for get_addr
  mptcp: add addr parameter for get_addr
  mptcp: reuse sending nlmsg code in get_addr
  mptcp: change info of get_addr as const
  mptcp: refactor dump_addr with id bitmap
  mptcp: refactor dump_addr with get_addr
  mptcp: reuse sending nlmsg code in dump_addr
  mptcp: add loc and rem for set_flags
  mptcp: update address type of get_local_id
  mptcp: change is_backup interfaces as get_flags
  mptcp: hold pm lock when deleting entry
  mptcp: rename mptcp_pm_remove_addrs
  mptcp: drop free_list for deleting entries
  mptcp: drop struct mptcp_pm_local
  mptcp: drop struct mptcp_pm_add_entry

 net/mptcp/pm.c           |  17 ++-
 net/mptcp/pm_netlink.c   | 245 ++++++++++++++++++++-------------------
 net/mptcp/pm_userspace.c | 168 ++++++++-------------------
 net/mptcp/protocol.h     |  50 ++++----
 net/mptcp/subflow.c      |   2 +-
 5 files changed, 220 insertions(+), 262 deletions(-)

-- 
2.43.0

