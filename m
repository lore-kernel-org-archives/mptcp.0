Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4452E859
	for <mptcp@lists.linux.dev>; Tue, 21 May 2024 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716287863; cv=none; b=H6kThfvnq6QjmCybVQhX9YqwwcKAhKhI25YO6fxB8fBSdbe4wqOZNHw5QKY9eoQCpV7yA/vdAVLkzQFudmYr2mKuXcMjJDqYZiNDwK5kMxvfyBaY/PFqvSAlgkMKDTtxb43fH2cO4DMVnt7NmVbaAbA8keQ3glxeSZZV6ZNBC9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716287863; c=relaxed/simple;
	bh=t7dNN7oUpUAAhL5yG+86eMlr7+Pa6Uzn4hJENRvo+v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaHk7nAvKEjWSdE/GYNcBGrg47zyds0WpUdHwNbzQIsK3J/TSXVfJijlShto70OvTqkmOyDHGxOc+PU7ev44daJJlTehUwUc4s44xgafhobg+xUISvxseQ60HbLVpnpyy6SDB5aKO9keBklRuou9Hc6kjhnk0uDHu40euw0mHnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7FhRXwf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7FhRXwf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23077C32782;
	Tue, 21 May 2024 10:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716287862;
	bh=t7dNN7oUpUAAhL5yG+86eMlr7+Pa6Uzn4hJENRvo+v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V7FhRXwfpcP2pQpXw0PJVztCBdwcmvjKz2pfMVQ7X5f1ReJ+CmOQvEzW5AiT5INNb
	 ATVSmHYOA5KL0kqJBMAvU+w+4qXObvg5iBYta9bB23hGM3otWjpGFbe3pdBcuEeTXb
	 aH2vaO6oG3K73PjKDFk9fZ4TZyQ12i4SL75EtFQAmRmtIv3ZM0YZPXG+gTZH8PCHIC
	 EJa4IajPQZB5RMhsCxpJ+HWvmCl+4ICfykFR3Y8Oo+ieaybUrnDp//UiNd2CMa3oki
	 fBEPKIZyEc0CGkdIvXMAP0hY2oGsEbqtVj88BB1dACbHiEh2LT3vJn7kq4fN0AjfoE
	 2M+q9AJtEZ3VQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/4] selftests: mptcp: use setup_ns helper in lib.sh
Date: Tue, 21 May 2024 18:37:29 +0800
Message-ID: <0828a3f6c183655b7c6c56b203273f433fb92244.1716287732.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716287732.git.tanggeliang@kylinos.cn>
References: <cover.1716287732.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch includes lib.sh into mptcp_lib.sh, uses setup_ns() helper in
lib.sh to set up namespaces in mptcp_lib_ns_init(). Then for each namespace
in NS_LIST, run all sysctl commands. This can drop some duplicate code.

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

