Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612881FF1AD
	for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 01:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764206778; cv=none; b=CwgJnGrJK/E+8IZWwyYtGU6glHFFdW5AR8rLNde2vM5FpG2GW8uE9SxBkmP5+Fh3CKqvnPV+G7yQf4AtzLpuQht7ybwhZLU8PiJddEFqcgTZUXCrX9PC47VqhgOqNbUiJVU62yfu2eAKCdGpynQTTxD9MRXkO2wyDQoAKah/x2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764206778; c=relaxed/simple;
	bh=3X0qAQ4qof7pCTD5hYQ06paEBzl/LU/NHzX08lmGSRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cO0fT+yJR1foYKKZe8e4PkKk20J0pjhJ1B854I3CkYnlVPjctBrLnbUHe218hamGv3xUdQtg2DPHnf5lu83qNvVvEyWAviqfzzOQpylZ9+YuShHjHaJuH6MAWkoOP1BYGGHtQNde0C1+MiOUJJ78m39S0+pgkesZvZMNdlTmxew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJKP7QZi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJKP7QZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8001AC4CEF7;
	Thu, 27 Nov 2025 01:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764206777;
	bh=3X0qAQ4qof7pCTD5hYQ06paEBzl/LU/NHzX08lmGSRg=;
	h=From:To:Cc:Subject:Date:From;
	b=BJKP7QZiYbG8YycwA83MWVAzBYAKGqoXISmOTogO1pdd6Hx35bhh6+9i7OkPM288z
	 uercMmA8m3I5LKbcfHm/G4XGJrRJ/6eI8VYzP47S/qbNGQTHba0o2N6kWOMp/NMyhI
	 rlL33WL7o5yFdbykCc4GK16Xc3tKpcCL968sE9B9pMxNfhwVeKhw928eHv7VfIF6Cu
	 L7KP0P43edRY/iz+lYMyveQx0SvQH0H1IPd/Cxz7vzcCeEPuT0NQQN1aY9ycHOq2mr
	 Ht/v4UE2B0QtZF5xHGHUnyXqXbDKdzXOCZEV/sd2kcTwnPR56iVRkqjL9bCwPSyV2N
	 vWJc29EphO1Hg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] libnvme: add mptcp trtype
Date: Thu, 27 Nov 2025 09:26:09 +0800
Message-ID: <99f6e63b5c9677f29a9bc8cdd87b2064b258435f.1764206766.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new NVMe target transport type NVMF_TRTYPE_MPTCP is defined for MPTCP in
the kernel. Add it to libnvme as well.

Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 src/nvme/fabrics.c | 1 +
 src/nvme/types.h   | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index b0821e96..d3a1c033 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -73,6 +73,7 @@ const char * const trtypes[] = {
 	[NVMF_TRTYPE_RDMA]	= "rdma",
 	[NVMF_TRTYPE_FC]	= "fc",
 	[NVMF_TRTYPE_TCP]	= "tcp",
+	[NVMF_TRTYPE_MPTCP]	= "mptcp",
 	[NVMF_TRTYPE_LOOP]	= "loop",
 };
 
diff --git a/src/nvme/types.h b/src/nvme/types.h
index 4943e00f..2aa81938 100644
--- a/src/nvme/types.h
+++ b/src/nvme/types.h
@@ -6823,6 +6823,7 @@ struct nvmf_disc_log_entry {
  * @NVMF_TRTYPE_RDMA:		RDMA
  * @NVMF_TRTYPE_FC:		Fibre Channel
  * @NVMF_TRTYPE_TCP:		TCP
+ * @NVMF_TRTYPE_MPTCP:		MPTCP
  * @NVMF_TRTYPE_LOOP:		Intra-host Transport (i.e., loopback), reserved
  *				for host usage.
  * @NVMF_TRTYPE_MAX:		Maximum value for &enum nvmf_trtype
@@ -6832,6 +6833,7 @@ enum nvmf_trtype {
 	NVMF_TRTYPE_RDMA	= 1,
 	NVMF_TRTYPE_FC		= 2,
 	NVMF_TRTYPE_TCP		= 3,
+	NVMF_TRTYPE_MPTCP	= 4,
 	NVMF_TRTYPE_LOOP	= 254,
 	NVMF_TRTYPE_MAX,
 };
-- 
2.51.0

