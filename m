Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9C313D891
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 03:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486677; cv=none; b=HQw4EIH32wAFb1Ruhju1peP46shHSHX6JwUhU9okg7bxTuoY2Zf3CcK8kqWD1l1CrkJKNdeysLOqrYyfE7BdhFdoXMVLeTKw4TcTEpcgYulu4x5j1RtIOj3Pred4RZuq30PfMsJcl7jq/A5BDjfDYzRjGk1Q8BJVxpJeubepJUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486677; c=relaxed/simple;
	bh=1eezk0zZU3IPAs5k9pPX3CQtQ3x+KS6ldVWKTA+h3yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f4ocFO8LdvGp/iPikfyMAp0k3x8f0QMYo3k4EogNKVB9Z/JSumDEhiwC1Fbt6fe6ZxHU6G4CW5w4fwyfWWJ+HMaCn5nTBT/83OJUoNPTf8mucZ1uPvcgKhDnwsH2W324mmow8F3UbEEJ5YA18ZxtY4rTMSN+53CjtETUyHf5alg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnH9+9en; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnH9+9en"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5014AC116C6;
	Fri,  7 Nov 2025 03:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762486677;
	bh=1eezk0zZU3IPAs5k9pPX3CQtQ3x+KS6ldVWKTA+h3yg=;
	h=From:To:Cc:Subject:Date:From;
	b=AnH9+9en7K099cjFnozPqu2UvQw77K710DpOIiCmADpzoeiJSzEietvSCjrhvbiRT
	 Qr7Q1sscpqSgH15fpOQ8repgs56iTKyKGIAX/aPoQ4IJIoijxr27EuE4jT2vC+SVV6
	 eR5A+6dcJJK4nxfSdtKjukqViZeH8rqAGVdSHH/PVr+d78nGPYcKE/375CZbQMWDs0
	 6qh2+2v4+WP+/lZhz4kzwUPJ/k84XNBgc3vgfiZpN08fIHvoLUTnSLshhWPfVISLe7
	 Oa0Ll4Rcj4X0nuVWRGnVox4clJ0PklZnsh48EX7RAPuUYmZuVIEz5xwlan2E76PBIb
	 ATNnm7FkYiPAw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@suse.de,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next 0/6] NVME over MPTCP
Date: Fri,  7 Nov 2025 11:37:31 +0800
Message-ID: <cover.1762485513.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This series (previously named "MPTCP support to 'NVME over TCP'") had three
RFC versions sent to Hannes in May, with subsequent revisions based on his
input. Following that, I initiated the process of upstreaming the dependent
"implement mptcp read_sock" series to the main MPTCP repository, which has
now largely taken shape.

Currently, the biggest problem I'm facing is in Patch 6, where I'm unsure how
to handle MSG_DONTWAIT. That's why I've sent this RFC version to get your
opinions.

Based-on: <cover.1761198660.git.geliang@kernel.org>

Geliang Tang (6):
  mptcp: add sock_set_nodelay
  nvmet-tcp: add mptcp support
  mptcp: add sock_set_reuseaddr
  nvme-tcp: add mptcp support
  selftests: mptcp: add NVMe-over-MPTCP test
  nvmet-tcp: clear MSG_DONTWAIT for MPTCP (TODO: HELP WANTED)

 drivers/nvme/host/tcp.c                       | 27 ++++++++-
 drivers/nvme/target/configfs.c                |  1 +
 drivers/nvme/target/tcp.c                     | 54 ++++++++++++++++--
 include/linux/nvme.h                          |  1 +
 include/net/mptcp.h                           |  8 +++
 net/mptcp/protocol.c                          | 33 +++++++++++
 tools/testing/selftests/net/mptcp/config      |  7 +++
 .../testing/selftests/net/mptcp/mptcp_nvme.sh | 57 +++++++++++++++++++
 8 files changed, 180 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_nvme.sh

-- 
2.43.0

