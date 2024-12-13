Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6C8188CC9
	for <mptcp@lists.linux.dev>; Fri, 13 Dec 2024 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075340; cv=none; b=Y1oqrZ/CruEgKQmIPKY6z5K7W5eY8GE4kqP6gQRsYqE2aIe8udDkyo99NekafmGBLBzPkUZfgtEjbh2EBwtnemhk+fsaiUTrS5gFapnEWARdorKSY4DX8N6lqCH1nNho6HCOzaQBTD2nummcxhCO//+QzfZ49fBsxutixu93+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075340; c=relaxed/simple;
	bh=HS9V7yrvNUqsqaK5mw4D+ceOSizHRo8jf+8Ufqe0Rz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KkHsPX+Q3oUKJmzqR0DientLDtmNEQWN/WYmRbcd4Cdq67YLdW2U5gRzg12bTmrzRvOqpwcU88307xb4x/V5MOZnPRA4tXEUxbRrlhTMDpOVdyQ9JF/nsecCYq+Vc1sIQdRAY/anPC+vZv3Xx/jinhP+vblYKIXSrBNXO8gJhPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMuo46P5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMuo46P5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535BCC4CED0;
	Fri, 13 Dec 2024 07:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734075339;
	bh=HS9V7yrvNUqsqaK5mw4D+ceOSizHRo8jf+8Ufqe0Rz4=;
	h=From:To:Cc:Subject:Date:From;
	b=KMuo46P52hMAlASQdpcM5qGDfGLHlEQlA4u3ZyXByD+TM6XbHT40xYSPx9rU4hOdw
	 1XZLnUN9ZZqmqpzRfE3hxP6hHRTeaFKB5YSjBl8EbrF+waqomyJyYn8qTmUMdcJveF
	 3za0Iy92eqeUK09kzavIEU8TQeLk05aDFidwwe8iAx//bMjyCQcvYemP6BkjnVE3kL
	 DRsYYlUJYheiM6//XHkYIq4KOvKvkUfgUhJ/NVi+HXCTdNEwxTRJvHF1CShv1NUDNg
	 q0vt4R5OVTwqJK18D3CFkjcr36Smo7MMcYmeFZ0aWNHYrr+kbuJyA26PWWsfvtvUkT
	 kaBigGYCa6kfA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/8] BPF path manager, part 2
Date: Fri, 13 Dec 2024 15:35:21 +0800
Message-ID: <cover.1734074788.git.tanggeliang@kylinos.cn>
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
 - split patch 7 of v1 into two.
 - patches 1-6 have no code changes, only the commit logs have been
updated.
 - more commit log to explain why mptcp_pm_addr_id_bitmap_t needs to
be defined.
 - use mptcp_pm_addr_id_bitmap_t in userspace_pm_append_new_local_addr
too.

In order to implement BPF userspace path manager, it is necessary to
unify the interfaces of the path manager. This set updates get_addr()
and dump_addr() interfaces.

Geliang Tang (8):
  mptcp: make three pm wrappers static
  mptcp: drop skb parameter of get_addr
  mptcp: add id parameter for get_addr
  mptcp: reuse sending nlmsg code in get_addr
  mptcp: change info of get_addr as const
  mptcp: add info parameter for dump_addr
  mptcp: add mptcp_pm_addr_id_bitmap_t type
  mptcp: reuse sending nlmsg code in dump_addr

 include/net/mptcp.h      |   7 +++
 net/mptcp/pm.c           | 108 ++++++++++++++++++++++++++++++++++++---
 net/mptcp/pm_netlink.c   | 105 ++++++-------------------------------
 net/mptcp/pm_userspace.c | 102 ++++++++++--------------------------
 net/mptcp/protocol.h     |  21 +++-----
 5 files changed, 157 insertions(+), 186 deletions(-)

-- 
2.45.2

