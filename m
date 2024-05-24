Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD811720
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 06:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716533346; cv=none; b=JC4RsyfDO3B8I1kp2q8dO2QqleZW9/MI1AypTBvr6+KREnLVmfk9h9xiY9E2QLZbveAJwIT20rSij7YLdzSt8wOANeFkvNe6Sn81gqOLZUZ++moe2gdd4BSorh/rEN6JCEfKOXjh822eB/fmfjmnKY7g/rFHppkrrJKaIL40yNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716533346; c=relaxed/simple;
	bh=v2sGNKS/Xrx7OMlqyQZcHSY6Hy3dBAUf/3LuuWKk4WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMC7lHpg+uhfsHrrC6MnJrxaxUV4dZt0z73uZ17eRFr40N/vRfR90KndZXObXH38y0w1cR8O/2ZHYcPFZ2laW1aJqb6QnI3G1JXAZFkWGVZscES3wiEp9KVf3cNl44h2k5J1STgIlKpzf3SscceUs5gGZI4QMC08pCcZDxhchXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WczIf4yO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WczIf4yO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34652C2BD11;
	Fri, 24 May 2024 06:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716533346;
	bh=v2sGNKS/Xrx7OMlqyQZcHSY6Hy3dBAUf/3LuuWKk4WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WczIf4yOWJ4lm258DE9YKREx1vMwzsq7/ZHQJtTbbPjCeObkwC+Vt34Y6xwusEm3J
	 O2igU5O6qZemnmCdtnkQvMVEJ9X/tHOrL6jlundIgStqish3rUlGRAYPujdbEq8XuU
	 SGbA5YV99tE6uRvZnF74bs3a60ukEtFMoq4EQuMBDwibxPQYPIiepXAsNG1QaTI39x
	 267jn4/dovfyBUJN9qWEB6EjwdPdGRDaty4OBarbMny+Oyi+J2qbLD1whOd5cfJxzM
	 WLWhVMVzFmQsMyMrugPlz7cwS2eaMTw4Kff7e0EBvTgFNZogyBVcCcKgfThK2+Nh6P
	 yKaU10r9z2uPA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/6] selftests: mptcp: use setup/cleanup_ns helpers
Date: Fri, 24 May 2024 14:48:48 +0800
Message-ID: <a5da748b2c83a17df1a3b6e80dd35404842534fb.1716533107.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716533107.git.tanggeliang@kylinos.cn>
References: <cover.1716533107.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch includes lib.sh into mptcp_lib.sh, uses setup_ns helper
defined in lib.sh to set up namespaces in mptcp_lib_ns_init(), and
uses cleanup_ns to delete namespaces in mptcp_lib_ns_exit().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 3397bf511f41..60f802e808a7 100644
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
@@ -438,17 +440,13 @@ mptcp_lib_check_tools() {
 }
 
 mptcp_lib_ns_init() {
-	local sec rndh
-
-	sec=$(date +%s)
-	rndh=$(printf %x "${sec}")-$(mktemp -u XXXXXX)
+	if ! setup_ns ${@}; then
+		mptcp_lib_pr_fail "Failed to setup namespace ${@}"
+		exit ${KSFT_FAIL}
+	fi
 
 	local netns
 	for netns in "${@}"; do
-		eval "${netns}=${netns}-${rndh}"
-
-		ip netns add "${!netns}" || exit ${KSFT_SKIP}
-		ip -net "${!netns}" link set lo up
 		ip netns exec "${!netns}" sysctl -q net.mptcp.enabled=1
 		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.default.rp_filter=0
@@ -456,9 +454,10 @@ mptcp_lib_ns_init() {
 }
 
 mptcp_lib_ns_exit() {
+	cleanup_ns "${@}"
+
 	local netns
 	for netns in "${@}"; do
-		ip netns del "${netns}"
 		rm -f /tmp/"${netns}".{nstat,out}
 	done
 }
-- 
2.43.0

