Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC90336881
	for <mptcp@lists.linux.dev>; Thu,  5 Mar 2026 04:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772683542; cv=none; b=d+Hn9Hs4s1xDIsBPkULcNljXD0Xt/YVkBIBrH+WHrhe9MlZrVDMjNCCGywlbG5+kAa3u3ua52X3r6dAn92F5+LnU/n7m1INlGYNNQTIyVmQgeB3N6KDS9F5H07e4n7ODwUIbBvIp+89069T/Y1hNXV/92PoIZM9VPV3FzIoU3jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772683542; c=relaxed/simple;
	bh=ACalUme6sFIV9clOCAZEDm1vLidxICFYi7+RXctnmoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AIreTu+yFZrJbKVpPGq4KkPSRD5ls9MAPOjg5njHqjlwcbYRN/maWVvtDpmtLq7tRe4F+Ma1YDNssEx+QeiNsZ4xKxyfQ9WzfL6+urjTmWTyvimdub5qtJ+DiJzmaSL0ZfmlG1wK384/vDCU1DjL32TxwMDHIAuwXYaYtkiSN4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaIIqA4I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaIIqA4I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581ADC116C6;
	Thu,  5 Mar 2026 04:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772683541;
	bh=ACalUme6sFIV9clOCAZEDm1vLidxICFYi7+RXctnmoc=;
	h=From:To:Cc:Subject:Date:From;
	b=TaIIqA4IhVeZ0OEyxOXCk0zeXNqt6xi56Wcg/iEjf2V2oMmHXlAEURy04dc4ialYn
	 wPREaUCyP12WPRkUs0yQzPWsb2LbtZMwbswcNDIrk8HCWR2Uft8U90MI0twch+xtT2
	 Z2vB8PpWC7kHdZ0wTvqdSV20fA9fpi4EWslFuftBm3BPta5W+LKKFXiALtXe+g+M8l
	 9Eb9Ibqzo9tHQ4e153ao14qc+e8WaTbaGMaOHkofC09Roceik/+yxB7NMmxq81ysav
	 Hzq0m0tt/hpTHY5O+poCfoR2vmXvC6TA8X8oS5jdQXCf7cUF0dcrGkHcfrM/AOFnHS
	 KAjZH0eepNelQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	hare@suse.de
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v4 0/8] NVME over MPTCP
Date: Thu,  5 Mar 2026 12:05:18 +0800
Message-ID: <cover.1772683110.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - a new patch to set nvme iopolicy as Nilay suggested.
 - resend all set to trigger AI review.

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
Based-on: <20260228011511.440437-1-gang.yan@linux.dev>

Geliang Tang (8):
  mptcp: add sk_is_msk helper
  nvmet-tcp: add mptcp support
  nvme-tcp: add mptcp support
  mptcp: add sock_set_nodelay
  mptcp: add sock_set_reuseaddr
  mptcp: add sock_set_syncnt
  selftests: mptcp: add NVMe-over-MPTCP test
  selftests: mptcp: nvme: set iopolicy

 drivers/nvme/host/tcp.c                       |  26 ++-
 drivers/nvme/target/configfs.c                |   1 +
 drivers/nvme/target/tcp.c                     |  38 +++-
 include/linux/nvme.h                          |   1 +
 include/net/mptcp.h                           |  27 +++
 net/mptcp/protocol.c                          |  51 +++++
 tools/testing/selftests/net/mptcp/config      |   7 +
 .../testing/selftests/net/mptcp/mptcp_nvme.sh | 187 ++++++++++++++++++
 8 files changed, 335 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_nvme.sh

-- 
2.53.0

