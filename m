Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E32F2EAF9
	for <mptcp@lists.linux.dev>; Thu, 23 May 2024 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451750; cv=none; b=VJXwd1rrkpBfXPQUQ3pQgp1xCUFZJuiorxe9aNPa4M3+rUJIZwF2A/+Gfh46j3JesjdDbN/zsGcV+jPibubiEFgygvtmqHfW9LfNCDRX1dTKY5ofpd5/Um6xHsF3QqwZDv4s8IjHNvjq6Y7R0OqMicneTJSHkNZuP66TtGA0+8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451750; c=relaxed/simple;
	bh=POq2KmKnHg2VDVcDcmNr753g4G8UmkQF7LiX/NzcM4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCbPh29PR+2Sti/5wYQd60/OcPkKIef3qz7I8/Zaa2MEM1YQu8xON3ifftjJyZB49SKdApR3BSvpV76S2Wurr9C+DVMmkCfw7yuV1oXvMjPwQMQH4VlFUF1t+vGLcrtbWiJeVARQQ4tsSylKdeIw4ZZuyYVMeVBIL9zVuHIggxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSHN4zRg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSHN4zRg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A604C2BD10;
	Thu, 23 May 2024 08:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716451750;
	bh=POq2KmKnHg2VDVcDcmNr753g4G8UmkQF7LiX/NzcM4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sSHN4zRgPvoHB9U2RBQv4iSOulJ5ahVdOld8r+LbCXKgvfymS6nvSFghZeRtSsICm
	 kXzS3GncWiCaxY9+XyShoLhIGvMYBCIIt138s5PadML/n+6BzU4ngg/LYta/2hxaf9
	 mNo7dxmdNceH0eHIX6qCbUpY6C1SDhauiK7UrC8KPxTr+IOAZ6sFb9GIzEVjSES3rk
	 rmCH0LtK8xclwLjj85UJqLWL/7blceWuBoncsBUDPx/ZW2NlQjLyGLDF22WNsVG3b2
	 vlE1WFsnO9niluNykHTyaDS6qflT2WPoUJYSg8yDO1ATPGtr8zWoIfR+UtBH8EWiEZ
	 pSduOtZc5Nkog==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/4] selftests: mptcp: use setup_ns helper in lib.sh
Date: Thu, 23 May 2024 16:08:58 +0800
Message-ID: <644ac151204efcd05b047d4e9b1545747ba785f1.1716451525.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716451525.git.tanggeliang@kylinos.cn>
References: <cover.1716451525.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch includes lib.sh into mptcp_lib.sh, uses setup_ns() helper
defined in lib.sh to set up namespaces in mptcp_lib_ns_init(). Then for
each namespace in NS_LIST, run all sysctl commands. This can drop some
duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index ad2ebda5cb64..59eb77e7813d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -1,6 +1,8 @@
 #! /bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/../lib.sh"
+
 readonly KSFT_PASS=0
 readonly KSFT_FAIL=1
 readonly KSFT_SKIP=4
@@ -412,20 +414,13 @@ mptcp_lib_check_tools() {
 }
 
 mptcp_lib_ns_init() {
-	local sec rndh
-
-	sec=$(date +%s)
-	rndh=$(printf %x "${sec}")-$(mktemp -u XXXXXX)
+	setup_ns "${@}"
 
 	local netns
-	for netns in "${@}"; do
-		eval "${netns}=${netns}-${rndh}"
-
-		ip netns add "${!netns}" || exit ${KSFT_SKIP}
-		ip -net "${!netns}" link set lo up
-		ip netns exec "${!netns}" sysctl -q net.mptcp.enabled=1
-		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.all.rp_filter=0
-		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.default.rp_filter=0
+	for netns in $NS_LIST; do
+		ip netns exec "${netns}" sysctl -q net.mptcp.enabled=1
+		ip netns exec "${netns}" sysctl -q net.ipv4.conf.all.rp_filter=0
+		ip netns exec "${netns}" sysctl -q net.ipv4.conf.default.rp_filter=0
 	done
 }
 
-- 
2.43.0

