Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA3942AB1
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381505; cv=none; b=RG+HTOuCI9bZeizbt8cBa/sSdiOr4uUoWOKBFpcQ74e8ZuahNPPdr9fxFH/sKa8ZOjXorD0M3dPZ3o8LRap+zSbZmZzn2pi4r9rX9xDuFNje37vw/oBsz4mEhUVH+9+H39esvtxd4ttQQ/UCSEkZc3QrtJIU6dSNk6bXIVLISRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381505; c=relaxed/simple;
	bh=bMySuav/9OW0w18igKj1oHeEE0D1+LqgmGlp32g/b34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7GNp1vyYdkFtv3LIpsl7cm0bIP1BZeLQUAwzGynpaeJEsD0geR2+avU5s9EeQMJNFoDI/US5ppNf38UpAMJDnHE3xaieQUV99aSHLLmUFPdoLWRZU0aUF/RFsKQIPNbKgXEvNwpxXaS/w91I6xcaJtHH/4sXkgsYfCY+E3OnBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLUQ982b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLUQ982b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212FFC4CEC7;
	Tue,  8 Oct 2024 09:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728381505;
	bh=bMySuav/9OW0w18igKj1oHeEE0D1+LqgmGlp32g/b34=;
	h=From:To:Cc:Subject:Date:From;
	b=dLUQ982bDtmkswMr8w4nJcOgCZQlGdWPjdSu/SAAOcGQJGN2VN5z5g7tNoSQFk73p
	 lEjSxac07U0rtFtRttrispZ5ye8n2uw3a6SpgbFobMOIKJqjKlcxbtyHWR+bVMKUpC
	 RgaCyzkBm3fNIG7IgJ1nTp+Dq4oxWm4EsFn7K5ufyl4VHbCh7gfLkzeAJ1/uunUixC
	 /HBUr9Oc4hAEQdj89lxgnjWMrhe8Hor8J54KomNgkltUlprztvOOryf1+Q57IcRUYz
	 Co++z6R2DourIYZfk/F6Nbgbt7AQ7pRLeWxICg/aO/OyVGkgO4j7zBFio7dn+BpTAQ
	 YubEeOqycf1/Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 00/13] refactor PM interfaces
Date: Tue,  8 Oct 2024 17:58:04 +0800
Message-ID: <cover.1728381245.git.tanggeliang@kylinos.cn>
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
 - split patch 5 into two.
 - new patches 9-13.

In order to implement BPF path manager, this set refactors get_addr
and dump_addr interfaces of PM.

Depends on:
 - cleanups for PM interfaces, v3

Geliang Tang (13):
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

 net/mptcp/pm.c           |  17 +++-
 net/mptcp/pm_netlink.c   | 197 ++++++++++++++++++++++-----------------
 net/mptcp/pm_userspace.c | 161 ++++++++++----------------------
 net/mptcp/protocol.h     |  22 +++--
 4 files changed, 185 insertions(+), 212 deletions(-)

-- 
2.43.0

