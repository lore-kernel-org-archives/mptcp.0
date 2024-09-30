Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FA8F9F8
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 02:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727662480; cv=none; b=CGT8Ry0gBhcRaPsPh0M+4R1ir05KnrTU92ccDvTQYZ3VZndQJQGclEbESnzDPBwsiJiRf67oKY/+kX+y9zAmH4m8M4B4Vh8md3+AvvgS16q7UTQIvC1DKrhoHtKPfZBDoba3XT9PG85fjZKeVCWS0AT7hTqAySF7pX1UfJ+GeTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727662480; c=relaxed/simple;
	bh=0HJ+0V2DCR5/qsrn0UTxIZWjkUbSyB753hVtL0ZDrfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IZUU7BM1+h/U35oUSAI0mlMY8IbO0m8SY6ux3Om1ylwcPOf6f+U+tfi9uw71PQGqAIwHMlT2wB9UZeHrc5U9E0lo9/VXYTt7Q2QkznnA9i5IJf83lpRu0QFFrIJWGWVk+U/LuoktUq0a10I/AtK9hB2GfAbRGzQY5MOjvtoV73M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XF8kckGm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XF8kckGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C4EC4CEC5;
	Mon, 30 Sep 2024 02:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727662479;
	bh=0HJ+0V2DCR5/qsrn0UTxIZWjkUbSyB753hVtL0ZDrfc=;
	h=From:To:Cc:Subject:Date:From;
	b=XF8kckGmaf1MBwm+2RwMexDM2+yMSTIJ3WkUofb2gh/LFNbmsR0ih7RtmwJaeqN5/
	 OhbTJXQGAC/EreE3OQSZaAS0Gh59EtpUBRh+QxyAl3Is9i1d7hp2hpAHm8Sznw3Pk2
	 MStdNmZT3cdWqN220aA3wa5DRW41GujwaJzQu4DQ7zHOI6pKoVJKR+PsWtRE/8gbaq
	 gcJ2KDHOE4k2e4bfjugETr+AtWPCIwHxGvGpCWK4Mg/3bLNAneq1doBO5HqwE3k7MW
	 bZRY5iXlvvExP9Vi2JXrH7Eri3j/ZrdZGD13jbIuK4Leszg3dRw542pByjvnKcjrgf
	 h8SJXvIizEgDA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/8] cleanups for PM interfaces
Date: Mon, 30 Sep 2024 10:14:25 +0800
Message-ID: <cover.1727662123.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In order to implement BPF path manager, it is necessary to unify the
interfaces of the path manager. This set contains some cleanups for
unify the interfaces.

Geliang Tang (8):
  mptcp: add struct mptcp_id_bitmap
  mptcp: use __lookup_addr in pm_netlink
  mptcp: add lookup_addr for userspace pm
  mptcp: change remote as mptcp_addr_info
  mptcp: change local as mptcp_pm_addr_entry
  mptcp: make pm wrappers static
  mptcp: drop skb parameter of get_addr
  mptcp: drop skb parameter of set_flags

 net/mptcp/pm.c           |  25 +--------
 net/mptcp/pm_netlink.c   |  99 ++++++++++++++++++++---------------
 net/mptcp/pm_userspace.c | 110 +++++++++++++++++++--------------------
 net/mptcp/protocol.h     |  18 +++----
 4 files changed, 120 insertions(+), 132 deletions(-)

-- 
2.43.0

