Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2189E22DC49
	for <mptcp@lists.linux.dev>; Tue, 14 Jan 2025 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846388; cv=none; b=XCQAXZStYijM9mGWtOMjcy+pazL9XwAjir66dX4hytuwrWdYvbDjyvjXXH2MSO8rH5CPzWnHR/YvTgY1M1s6p7B/4IS7dAFVVQ2IA6BRINB4zI/KC2e1lfxHQNCCCZ8+QJ90LV34YZw3kWSj4LdmEto4LVxhIyL9WNV6L7Bd3qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846388; c=relaxed/simple;
	bh=9IDOnBQwSAnX4N46Df3kmY8Kjah3UvuOO+PBTIeJylg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jRmZXD3h0fraR6nJgfjnOsWkAph7lFJ61AILPKiCYV2K7S4iKGrvUPLH89PVN2ZdnkTMH3YbyLodDiyugjD12ZIVjOhN4cKpfOdU3xnS/gvCtD0uFpz7PRF5/9p5FHhqOVCn07ZEJ7QDz04jSlTKISIbW0fn7xnQTgaN9EyqWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtCJODiI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtCJODiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9191DC4CEDD;
	Tue, 14 Jan 2025 09:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736846387;
	bh=9IDOnBQwSAnX4N46Df3kmY8Kjah3UvuOO+PBTIeJylg=;
	h=From:To:Cc:Subject:Date:From;
	b=ZtCJODiIqfYDMYfULGA5uv/DoXwkS5fLw44vPv6+C/2YC74zy76QdBFHoCMp7WBcL
	 2r5nuB3mqmqeMfmoxMHl/Nj/1mwV6T3gW2eMU75gWJ17IExcoFd75iMm1Of4OzvXpF
	 I2FH9aEKHz+qbtZx5sFdAWS72rMPOy7hKdhG8ItB7zGlaKtVgvbS6EfIxGcvI29aob
	 9yxkrQTIiuNU3ocLATsYEPF12m8VT+LVI4vio0bfNFGCP9MLEQ7IR+GESSChszgw3Y
	 5a9wAuvxyGQT3V/9C40J2KXkLb523m6uHAN8xwwY433NTvf8BVmAQ6ta8reYRFg9F+
	 C2r3gYJLi2YTA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/6] BPF path manager, part 3
Date: Tue, 14 Jan 2025 17:19:32 +0800
Message-ID: <cover.1736845893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop the patch "mptcp: reuse sending nlmsg code in dump_addr", add a new
helper mptcp_pm_genl_fill_addr() to save the duplicated code.

Define struct mptcp_pm_addr_id_bitmap in protocol.h, instead of defining
mptcp_pm_addr_id_bitmap_t in include/net/mptcp.h, since dump_addr()
interface of bpf userspace pm is dropped as Matt suggested.

Geliang Tang (6):
  mptcp: add mptcp_pm_genl_fill_addr helper
  mptcp: add struct mptcp_pm_addr_id_bitmap
  mptcp: drop inet6_sk in mptcp_nl_find_ssk
  mptcp: drop match in userspace_pm_append_new_local_addr
  mptcp: update address type of get_local_id
  mptcp: change is_backup interfaces as get_flags

 net/mptcp/pm.c           | 38 +++++++++++++++++++---
 net/mptcp/pm_netlink.c   | 33 ++++++-------------
 net/mptcp/pm_userspace.c | 68 +++++++++++++---------------------------
 net/mptcp/protocol.h     | 19 ++++++++---
 4 files changed, 80 insertions(+), 78 deletions(-)

-- 
2.43.0

