Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA2EC2D1
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 02:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780526; cv=none; b=oszPhVkHCz88JGCnh60nPh0PoZjuS8vWhjyVTSOM97ivzTlY+WjwSc+6U+ugVQccHIRQbd2Hya28baHwwqsf99yLTa38dKkRGv+hxYVD1gk+bTJRQr5ufPrOxW1KUNB+J8Xw4trZfNs0RVPmP2ORGONVrJhjYO0cZzhraDL4YG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780526; c=relaxed/simple;
	bh=W1TrNXyK3baNrw+Eky2FBKNJsJGOe6HbIPXU5mFXflU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHqExETa8+22BOsgjLwmF8gG6/Bff4GLd1lksVPZVDhtJBW5ROyWdEDy7kXC15U5qpFn2V/1xOqE5XB4W6sZdmbkaXeRVY5XTyg0TXHdPf51RcLKavSM4Ly9wmTRIZifK8/RtfFZ1zk+RyYnjEUS54raxF/HsO45GBIoRgQkImU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stYORrNc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stYORrNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6966BC4CEF1;
	Tue,  2 Sep 2025 02:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756780525;
	bh=W1TrNXyK3baNrw+Eky2FBKNJsJGOe6HbIPXU5mFXflU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=stYORrNcPQ69ID6iN1Ni8I4WLC+yMn1EBfQD5rwSmNpavBvzshtXmQtS5DqZAKMrW
	 rHzrUiwf8+RcNFVZjrGEpkjUqriy1QdDTPxHjlADWdbpHG0Dg/7uU3p5a3bLhdnwY9
	 ABiBOuuulKVozS4NNIfwXDlycmgrTMxHOQ5UAUqwgSer/LJIOyGM09F7o+cwbDeK5e
	 LperhBv7izyKV3S492wEGQQNEKalHsDTe48X2+r3NA7X/KRjfCv2dkMLeR648Q+GLv
	 Kdb47z/cUGU/B9bcSW8sRYIfKte5VBidN5b578809h4CUC05Kk2YBWKNtbDY2jBNZD
	 EUzE0gV60oXBA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v10 9/9] selftests: mptcp: connect: cover splice mode
Date: Tue,  2 Sep 2025 10:35:00 +0800
Message-ID: <d2c279f57c0bf240ed758db364f9b79c569ddb28.1756780274.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756780274.git.tanggeliang@kylinos.cn>
References: <cover.1756780274.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The "splice" alternate mode for mptcp_connect.sh/.c is available now,
this patch adds mptcp_connect_splice.sh to test it in the MPTCP CI by
default.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/Makefile                | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 4c7e51336ab2..83c1602fb6bd 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -5,7 +5,7 @@ top_srcdir = ../../../../..
 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
 TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh mptcp_connect_sendfile.sh \
-	      mptcp_connect_checksum.sh pm_netlink.sh mptcp_join.sh diag.sh \
+	      mptcp_connect_splice.sh mptcp_connect_checksum.sh pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
new file mode 100755
index 000000000000..241254a966c9
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -m splice "${@}"
-- 
2.48.1

