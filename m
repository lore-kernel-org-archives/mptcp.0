Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DFA1E2614
	for <mptcp@lists.linux.dev>; Mon,  9 Feb 2026 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627873; cv=none; b=YUBSRa8UpPtw/8Px5XqBr908yVLi7xtWtLSW/AU70QzCYqDEHLgkFBO3K4AMC1VlQEJkt47okcsOJ3auKTU9KDO5aiww3CHGOouumKLCatSw6OqLS8HZ76j7gQvItXe+5MCLMIrDmWyOSrnbnBu97rfIo+F6x5LaQUYNM24AKTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627873; c=relaxed/simple;
	bh=uP/vV4deiz77IXx80i+ximrF7fgEH6RD7T20iCmdNIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IgafHg+lOTVBc0FDqKFdGVdvtwkxqbjn0gsgOepitGmUtTTNJXJMVTdBcnZwH8wPT/LJ2bF4bgPqr6e4KaWCAcbJCfqnzTijmKdzCK/BhFsQ3TaEVqzVwh/ooD972qmW00Ly1IXNH8oPtF/sIBBiVWWQ+om80HnChziGj9CfrFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLcFMTxl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLcFMTxl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CD9C116C6;
	Mon,  9 Feb 2026 09:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770627873;
	bh=uP/vV4deiz77IXx80i+ximrF7fgEH6RD7T20iCmdNIU=;
	h=From:To:Cc:Subject:Date:From;
	b=BLcFMTxl08Kc2n8/FNKP0gXvUuRQ07VtaXZlcG6TBGKtBZ3XMhnv657SBw7428iUi
	 6NiCSQSa/6LoWbYYxmCI1SkoGRcRdk4xAAzDLmlqN/L/q24c8zDAhFujgq5cyjyaSu
	 +tzt65N569GHnClynfFjni6TfOx9CkpPFWVpW7becRQGdU4yiHqKFCe64WIdYTZSMV
	 S6eBh3Npwb9g0JVUA6vRBA8Hl3XeCczOH8WpMwCVRj+PcvYyyO2hpcvZMg7yLYCEGw
	 SSNw21j9K8KP5+SoVtGBhCUI9X4xltAOoc10e8wkM9APKKGQnMmutX1aAiu3dWFuWr
	 J85U2qoPnDmNg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v3 0/7] NVME over MPTCP
Date: Mon,  9 Feb 2026 17:04:15 +0800
Message-ID: <cover.1770627071.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - update the implementation of sock_set_nodelay: originally it only set
the first subflow, but now it sets every subflow.
 - use sk_is_msk helper in this set.
 - update the selftest to perform testing under a multi-interface
environment.

v2:
 - Patch 1 fixes the timeout issue reported in v1, thanks to Paolo and Gang
Yan for their help.
 - Patch 5 implements an MPTCP-specific sock_set_syncnt helper.

This series (previously named "MPTCP support to 'NVME over TCP'") had three
RFC versions sent to Hannes in May, with subsequent revisions based on his
input. Following that, I initiated the process of upstreaming the dependent
"implement mptcp read_sock" series to the main MPTCP repository, which has
been merged into net-next recently.

Depends on: mptcp: fix stall because of data_ready
Without this fix, NVMe-over-MPTCP test will probabilistically fail.
Based-on: <20260209084717.506379-1-gang.yan@linux.dev>

Geliang Tang (7):
  mptcp: add sk_is_msk helper
  nvmet-tcp: add mptcp support
  nvme-tcp: add mptcp support
  mptcp: add sock_set_nodelay
  mptcp: add sock_set_reuseaddr
  mptcp: add sock_set_syncnt
  selftests: mptcp: add NVMe-over-MPTCP test

 drivers/nvme/host/tcp.c                       |  26 ++-
 drivers/nvme/target/configfs.c                |   1 +
 drivers/nvme/target/tcp.c                     |  38 +++-
 include/linux/nvme.h                          |   1 +
 include/net/mptcp.h                           |  27 +++
 net/mptcp/protocol.c                          |  51 +++++
 tools/testing/selftests/net/mptcp/config      |   7 +
 .../testing/selftests/net/mptcp/mptcp_nvme.sh | 179 ++++++++++++++++++
 8 files changed, 327 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_nvme.sh

-- 
2.53.0

