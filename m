Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EAC3C1D
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497081; cv=none; b=ikHIyVkQ+u3d9i6oh+j7pkJr/wNha4neYsLTQDn9p65IG2IxStJ9F4Q/ZCsmvtRSNHGPNKw3O1bQ9zoJVYHwc3Mj03Z2L33YXagCpESKE8Fqqi2fRSTisz3QuPP2jspdIIXvDw3iyzeRf5mjoIMsOBw5QK2gJQ4mprOY2+f2Ymw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497081; c=relaxed/simple;
	bh=69o7vPmSFLH+EVoSVr+QAcVxmPtvuv8tGI702BZZChY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=diHDle0T63Lw0kgfedNSVvX4++tSeycugdy0T9gu++xGQ9NNLxrjFtwXdHzLiuALhoFID2kdpALlOCXJQJLU6kQcy7wqWMjH+PggMffmeoJ+/+t0HZVQZXGZiSBZs7rdP6zlCf0XFkqav/fPzEwAdrv0/UfbhYwX7Fcd9Boj6hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTdooUlP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTdooUlP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA71AC433C7;
	Wed, 21 Feb 2024 06:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708497080;
	bh=69o7vPmSFLH+EVoSVr+QAcVxmPtvuv8tGI702BZZChY=;
	h=From:To:Cc:Subject:Date:From;
	b=OTdooUlPU+kPDOxXjkRUsWs/TPz1+v1vSwhs1AKdNrXfobzpNDHQgM+x/N/JzC3Yc
	 0vvcICEzShUl4ZzaPLkRQxnLTIPH9+jWRVb63iZKbaqtw5zwolB62mDJcfqbeEcFFe
	 JqFKhVpPRp9Q+VJP1dSv/AzdIPym3mxxQinqT3ICENPXAPD0mK1jcQUpevFiG/EG6M
	 fIQrBmNFb4ntP1AFaZIjnT7Ose33IPAsW2RxHXYHKMVn6hbYPanT1ThXVZwGgaZM9W
	 iqJXRVTcReD+oF4xpyugsbRfLGybhVuC6hD/79+shKSyk2BMR76yV1g1PJeFh1AFOR
	 UrCgI+wI2rQ2A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/8] some cleanups
Date: Wed, 21 Feb 2024 14:31:07 +0800
Message-Id: <cover.1708497039.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Depends on:
 - dump for userspace pm, v14

Geliang Tang (8):
  mptcp: make pm_remove_addrs_and_subflows static
  mptcp: drop duplicate header inclusions
  mptcp: update set_flags interfaces
  mptcp: set error messages for set_flags
  mptcp: drop lookup_by_id in lookup_addr
  mptcp: add use_id parameter for addresses_equal
  mptcp: add check_id for lookup_anno_list_by_saddr
  selftests: mptcp: flush userspace addrs list

 net/mptcp/diag.c                              |   1 -
 net/mptcp/mptcp_diag.c                        |   1 -
 net/mptcp/pm.c                                |  15 +--
 net/mptcp/pm_netlink.c                        | 120 +++++++++---------
 net/mptcp/pm_userspace.c                      |  47 +++++--
 net/mptcp/protocol.c                          |   1 -
 net/mptcp/protocol.h                          |  18 +--
 net/mptcp/subflow.c                           |   2 -
 .../testing/selftests/net/mptcp/mptcp_join.sh |  46 ++++++-
 9 files changed, 147 insertions(+), 104 deletions(-)

-- 
2.40.1

