Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAD3274658
	for <mptcp@lists.linux.dev>; Tue, 15 Jul 2025 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572965; cv=none; b=I3a6mearMYGv9qIpTV4I8CUEPXs5/565Ah/gSdHzWY+jJ7fWDmWzqFZY/7CY5MxahH+n4aNYmHb021wrkaoXVUNqsSq8hnlY2pyt3rJR1N/7Q9FQqxKud9+3CunXBZUU5bu+0/d0aUXhXz27JQb9mMVR+ajOuh4fYV3ukbkKFCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572965; c=relaxed/simple;
	bh=L5gV2EiuBHuH/gTmg1slrYX0Bkr3/TbD954wv2X5lvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=efIt3j95KJTJ8hwHUKdInlgjzMtTzvSxFDjQCuYlygEBRBCeL6paq2K8z3CRgXoKGJqEQJyEIYuwzCfMS2XEj2AmrUdFQ1PZPtR0+yscJzwERC61nWmNU94wN10TEfS0iORwoPFJIJY1W2aGTACSp7N7aTiopOy0L0vWy+UNv/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJBqyGXf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJBqyGXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AF3C4CEE3;
	Tue, 15 Jul 2025 09:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752572965;
	bh=L5gV2EiuBHuH/gTmg1slrYX0Bkr3/TbD954wv2X5lvY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mJBqyGXf7Kqr3puqlwAWyyP35RB2UNJ3B9g3sj9XUQsmydLLVQeFIJHhRE0dtRA87
	 fh3HTAU2CrTMjBqemOZPUbxFfXoGSri1+HE5d9lqD3rbypjK1lbQlNakxMJK69zTLR
	 kEo93ZS3+Rs74MjWuIxheNlTF5c/YNNq/xbDb8Cj2jBbh4CQwUHksGOH8CiXYSZB41
	 LAa9cnMcvMPauOUPffMWKZ7yWDcyP1yiaOTkrzvtBmsTVYIbCXWX8Rq/ONvtxg92IF
	 MraVdzpBUZxCCQYosR/IGIQ0Fg5W4O02y+MMnlPxe1xGQmJxs578qMqXpTIq11pa0a
	 AdSV0wp251xJg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 15 Jul 2025 11:49:09 +0200
Subject: [PATCH mptcp-net 2/2] Squash to "selftests: mptcp: connect: also
 cover checksum"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-selftests-mptcp-connect-modes-fixes-v1-2-58fc475d9397@kernel.org>
References: <20250715-selftests-mptcp-connect-modes-fixes-v1-0-58fc475d9397@kernel.org>
In-Reply-To: <20250715-selftests-mptcp-connect-modes-fixes-v1-0-58fc475d9397@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=L5gV2EiuBHuH/gTmg1slrYX0Bkr3/TbD954wv2X5lvY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLKVJSWH41OmD0//F2RyvLcMwlP6zmjjA7zHng4VXndV
 kvhaT4FHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABN5YsrIcGG72RG36qWfRR1U
 ppnc0HVP+HverPV53acIm3s3I579tWdk6Ih1dww+FsMnlvJ2m9r7NxKHLu2w8zpYI/7c5EfzEUt
 7bgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Without that, all mptcp_connect*.sh subtests have the same name, e.g.

  mptcp_connect: ping tests  ## from mptcp_connect.sh
  mptcp_connect: ping tests  ## from mptcp_connect_checksum.sh
  mptcp_connect: ping tests  ## from mptcp_connect_mmap.sh
  mptcp_connect: ping tests  ## from mptcp_connect_sendfile.sh

In such case, the CI will only see one subtest, not 4 different ones.

To fix that, MPTCP_LIB_KSFT_TEST env var can simply be set.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
index 569340d4f00ae2e4655b30220bcfce695549a686..ce93ec2f107fba2a699387188932a2680bc9ded7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
@@ -1,4 +1,5 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-"$(dirname "${0}")/mptcp_connect.sh" -C "${@}"
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -C "${@}"

-- 
2.48.1

