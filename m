Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D126119CC0C
	for <mptcp@lists.linux.dev>; Tue,  3 Feb 2026 03:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770090477; cv=none; b=ifBO5zN1MRiTB6qdh/xz9g7mOlyxE8F2cvN9mjhkPxn40vNd35E1df/+MrTSbV/3dZl8OwA58W2fZQequqvnhQfCqy671qMcHvThyARDYdZOer4glT+cIBUuaNYuOkLbKJBXmigx+5cul+bovrjuGXMzYcapPh1ZX61BBfAVBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770090477; c=relaxed/simple;
	bh=aHVkJ0B2O/py3xbFCeH/AsCT8pLoXhupQ4Gi7JdfFPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jKHw5VsUG9buLiHE2KGB6mYHfg6+R8T/555FMVI7lEsZCFoSofXjDx/WFrvCghDyX0L+FAOqSbOi6XTJMnbK3iomhdkhOrCA41AVIc2uuRu7gn16OwlUAiV8azvyN3IOBHJxMU1JOaiaNkC9RkGBgtVCPrk2/FNb3w3Uk9O1WOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbfLRaUR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbfLRaUR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB04C116D0;
	Tue,  3 Feb 2026 03:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770090477;
	bh=aHVkJ0B2O/py3xbFCeH/AsCT8pLoXhupQ4Gi7JdfFPc=;
	h=From:To:Cc:Subject:Date:From;
	b=PbfLRaURE3ptoAhj0fpRupFtd0sIfmbY5V425FfoyPJbtPeNQz42KuzyvHT8LTxI/
	 IgSQUVzFGgUrN1ERSwqL0eOVCqsSVaCtpTjUrdT1UEyotiubCycRk68UEQVJJfIwG2
	 kvjmdUmtlyT1s2WnwVD6wnNN73nhIy1HyYfFd8pQ12k9YSQnlWs66kJ7zU8ZBwz8S1
	 /qfC56RCQRSfXmFXUL3y6fyG2e7GudgBi4CNv+liWrbbcUSAQhqo0AYpuhqHDP12sc
	 imMkAsAk8OsUyRKYucGIMEJkRDumIEBFP9x/ojH1p7bcl0bSruM04fMCj/GFv4GNn7
	 KDwjtme85u+5Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/2] add tcp_recv_should_stop helper
Date: Tue,  3 Feb 2026 11:47:43 +0800
Message-ID: <cover.1770089761.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Two cleanups for "implement read_sock" series.

v2:
 - v1 changed the original behavior when replacing tcp_recv_should_stop.
   This version preserves the behavior unchanged.
 - add a cleanup patch for read_sock into this set.

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1765607485.git.tanggeliang@kylinos.cn/

Gang Yan (1):
  mptcp: check desc->count in read_sock

Geliang Tang (1):
  tcp: add recv_should_stop helper

 include/net/tcp.h    |  9 +++++++++
 net/ipv4/tcp.c       | 10 ++--------
 net/mptcp/protocol.c | 12 ++++--------
 3 files changed, 15 insertions(+), 16 deletions(-)

-- 
2.52.0

