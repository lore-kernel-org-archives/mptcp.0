Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3972CCAD
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589043; cv=none; b=PsjnB2B6+wzzGZASAJAAw2+EKGY54JdaG5wmFoEhJQI4lvH8fc1OPT19IoJ+FalGH/o3qTIXi1K3NGwA7Vh+0K3IR7W6KsI78v7mQgCKDuGduX+rwU0qHoEh3zLAcd/lpx+LqfGMZsM/3g5imFwcFsHbcWy4/ML8vUcH063Dj2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589043; c=relaxed/simple;
	bh=oPfbibCpCDcVlkaizKN8iHGZBFcV/WxunKXnSWGeZFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GLdZm2/j3LjVUfAum3rxcSTyE6TRhUBVhVQF3INY1sAPalmr3M7weHkwN5jdMFLT/voRalDJnHOj8t6nn6OCkPko/WvLhvKxMEHCgPsxdopKRrwvX09mxS6RBsJaf8g8eN7DCWKMz8BqrHxGyNcb1imEALV9OfLrYQhqqlHv3O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxA67Zcg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxA67Zcg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AEBC433F1;
	Thu, 22 Feb 2024 08:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708589043;
	bh=oPfbibCpCDcVlkaizKN8iHGZBFcV/WxunKXnSWGeZFw=;
	h=From:To:Cc:Subject:Date:From;
	b=WxA67ZcgFN+tZX5AYfTUbV674N2BFGiTAyb9gO40ZDd0PO8RokwS+Xxg0KyLwX4Ce
	 Etif2CtZ3JLUOZdm2MFKiGzmrmum9KIcdb/VzCgaurda2xWXebO8YTxvqllOrmblH4
	 Lh2eoLVk6wUsN6Zy16IWh9qV2F6U72Dy6hVNh6Gf5QZE79eidB0GMcyWKt3iITMkjT
	 y9LAJ/mhQT9/vXr1noymf2dvLeno68IT4ByBqWJ2y75p7/CBQldbh7BarzSqcMINBL
	 RIgXgxqcnnWXal1j8SvyiAWmz6J1vEbAJ2bZ6e+mjRYwiIJM857CcSuw28jUrjsHQr
	 ahD/zpXpCEZyg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/7] some cleanups
Date: Thu, 22 Feb 2024 16:03:51 +0800
Message-Id: <cover.1708588977.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - address Matt's comments in v1

Geliang Tang (7):
  mptcp: make pm_remove_addrs_and_subflows static
  mptcp: drop duplicate header inclusions
  mptcp: update set_flags interfaces
  mptcp: set error messages for set_flags
  mptcp: drop lookup_by_id in lookup_addr
  mptcp: add check_id for lookup_anno_list_by_saddr
  selftests: mptcp: flush userspace addrs list

 net/mptcp/diag.c                              |  1 -
 net/mptcp/mptcp_diag.c                        |  1 -
 net/mptcp/pm.c                                | 13 +--
 net/mptcp/pm_netlink.c                        | 92 +++++++++----------
 net/mptcp/pm_userspace.c                      | 41 +++++++--
 net/mptcp/protocol.c                          |  1 -
 net/mptcp/protocol.h                          | 22 +++--
 net/mptcp/subflow.c                           |  2 -
 .../testing/selftests/net/mptcp/mptcp_join.sh | 41 +++++++--
 9 files changed, 124 insertions(+), 90 deletions(-)

-- 
2.40.1

