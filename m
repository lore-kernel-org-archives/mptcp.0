Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA613191DC
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153622; cv=none; b=AfI0oG1iSPP4poqwD002/3O6KPCrz9kbCFlbO9wC+7K9N/b0QzP4ePKJZZygIU/Ii1MzAjhzw09C41CaFRPbogJgNHoPUs7GtLhfU4UgBZLMdznlhsXoDfcEZJOwJXkQTutl5k4+5NTHuziMM2PUCdbk8DIf10tlb1ygne+P7ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153622; c=relaxed/simple;
	bh=DRWGYrH/rt+emImgxVuAzfpb63gnubeRjS/TNUw6Iqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dTELiG5Cx2FVwcXWP/pi29r+Nu8eJIfdzpoITPdWbT6kG+QRhc7Ix/pj6b/tpZ5DvqlywETa7GZXM+LW6jdXanaOqsv7x/vEQ8P79usOUQ24lE7gWZbsSE/hpjpTQK4xk9Y19lNuBoBsvDXbxwahBGkoaOB9qb6YbEESlB4tlZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CH62t8y+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CH62t8y+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0467DC113D0;
	Wed, 26 Nov 2025 10:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764153620;
	bh=DRWGYrH/rt+emImgxVuAzfpb63gnubeRjS/TNUw6Iqs=;
	h=From:To:Cc:Subject:Date:From;
	b=CH62t8y+HnuL6WbBtKJDrytimYhqItnKEeji7/IktmqFY1SV/My0bfTmA2cR+H89t
	 +N8ELU+XjUG0zVel0iI6dHp63JJyLOAdnnEjLoHcblH59ZPJPG96Iq/1u4yOLJgmFy
	 wi29KywxSG1vGkbTZWnTY6w9a/O/wwfkyvqV4Jwwhi92OhyxenGCHZ1c1gaNWidJtO
	 QvNrs4VR9A/ryHEkYQEnogD9l3uBY1g0Ktoe1x4YJsb1v9tQTw8+1YTtTBmdX0kNOX
	 Ywd7+4o22r2GTJxay8eS7w4KjBanIn3vnQbizKeR0C0tr8IBFC0KR3ODY3ZfrVc7Ig
	 a18V/57TmhU9w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@suse.de,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v2 0/7] NVME over MPTCP
Date: Wed, 26 Nov 2025 18:39:57 +0800
Message-ID: <cover.1764152990.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - Patch 1 fixes the timeout issue reported in v1, thanks to Paolo and Gang
Yan for their help.
 - Patch 5 implements an MPTCP-specific sock_set_syncnt helper.

This series (previously named "MPTCP support to 'NVME over TCP'") had three
RFC versions sent to Hannes in May, with subsequent revisions based on his
input. Following that, I initiated the process of upstreaming the dependent
"implement mptcp read_sock" series to the main MPTCP repository, which has
now largely taken shape.

Depends on: implement mptcp read_sock, v14
Based-on: <cover.1763974740.git.tanggeliang@kylinos.cn>

Geliang Tang (7):
  mptcp: allow overridden write_space to be invoked
  mptcp: add sock_set_reuseaddr
  mptcp: add sock_set_nodelay
  nvmet-tcp: add mptcp support
  mptcp: add sock_set_syncnt
  nvme-tcp: add mptcp support
  selftests: mptcp: add NVMe-over-MPTCP test

 drivers/nvme/host/tcp.c                       |  28 +++-
 drivers/nvme/target/configfs.c                |   1 +
 drivers/nvme/target/tcp.c                     |  38 +++++-
 include/linux/nvme.h                          |   1 +
 include/net/mptcp.h                           |  15 +++
 net/mptcp/protocol.c                          |  52 ++++++++
 net/mptcp/protocol.h                          |   2 +-
 tools/testing/selftests/net/mptcp/config      |   7 +
 .../testing/selftests/net/mptcp/mptcp_nvme.sh | 120 ++++++++++++++++++
 9 files changed, 260 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_nvme.sh

-- 
2.51.0

