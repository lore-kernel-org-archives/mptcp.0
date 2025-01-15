Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFC61EEA46
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935182; cv=none; b=hXPIFI4f1FrfI/8OcSx+WbIoyDG/xNWOvAnVq7b5yI3dv/RxumG7vfvHqPNsWW7IvhvR9WrVfLxQJVKBZz8rxIXlfUVnk8jWDIYQDhR35nASDluMdMGirJCl1OSFfQqFXaw+gb6rXnR1kqc6lDDhqNA3FnBxKr4cdj4j4e2aVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935182; c=relaxed/simple;
	bh=+dAOKtov5szKjPUqC7J5ZpSpifzDk7TtKPWdvy+npWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CY/1VzKsofTybzBgcVpL+uYc6NS6XZHgciBN+CLWp0Q7Q4mjkad3W5SoG4aTFC0PLg4pZMKTFvkKx+9Mj7Yn4gCrYgBidoKgqTnbeUcHALyaeMdEK5RdU1ze51JlW4OL4QChi2ukut+KNt7EzQiUnst+LfyOyUVH+rMrSaMAHPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKAOgfTi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKAOgfTi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB03C4CEDF;
	Wed, 15 Jan 2025 09:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736935182;
	bh=+dAOKtov5szKjPUqC7J5ZpSpifzDk7TtKPWdvy+npWo=;
	h=From:To:Cc:Subject:Date:From;
	b=ZKAOgfTiVCsloCWfBHpiQNlSZAOKFX+QZ5wjTVxZP8yGEHe7ETscMJXR6xQQpgOLi
	 +T3OZazYPZZFJecOLyVQp+PPascj/6qwGGMCNXmfPZnR/rMZEujQf6r7xkekDOREYJ
	 GdXUDRaJajpdDXR1EP0eqXzbUStr95kRm8MsGwAIzlz/kCGANngEy+pJPnsH28dtKs
	 jHpxdiNgseusnxS+jL2Hq2CZylW0vZVUXcjMAWGsMt1qTsgEQfkFbmyJjIujRam3Jx
	 Z84Mx1yfTV1lesuxyswppI0stxQxo108MJOwcxA8w1Sau3EudlFd49/mH8o+V7uCHK
	 CjPdplwrgNz2A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/6] BPF path manager, part 3
Date: Wed, 15 Jan 2025 17:59:26 +0800
Message-ID: <cover.1736935086.git.tanggeliang@kylinos.cn>
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
 - drop "mptcp: update address type of get_local_id".

v2:
 - a new patch "hold msk lock before removing id 0 address"

Drop the patch "mptcp: reuse sending nlmsg code in dump_addr", add a new
helper mptcp_pm_genl_fill_addr() to save the duplicated code.

Define struct mptcp_pm_addr_id_bitmap in protocol.h, instead of defining
mptcp_pm_addr_id_bitmap_t in include/net/mptcp.h, since get_addr() and
dump_addr() interfaces of BPF userspace pm is dropped as Matt suggested.

Geliang Tang (6):
  mptcp: add mptcp_pm_genl_fill_addr helper
  mptcp: add struct mptcp_pm_addr_id_bitmap
  mptcp: drop inet6_sk in mptcp_nl_find_ssk
  mptcp: drop match in userspace_pm_append_new_local_addr
  mptcp: hold msk lock before removing id 0 address
  mptcp: change is_backup interfaces as get_flags

 net/mptcp/pm.c           | 28 +++++++++++++++--
 net/mptcp/pm_netlink.c   | 21 ++++---------
 net/mptcp/pm_userspace.c | 67 +++++++++++++---------------------------
 net/mptcp/protocol.h     | 13 ++++++--
 4 files changed, 64 insertions(+), 65 deletions(-)

-- 
2.43.0

