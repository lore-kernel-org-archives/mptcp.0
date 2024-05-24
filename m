Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BF011720
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716533351; cv=none; b=Zk7vlmhEqxrpqoFOzTKb6PG9iaCb0EBqj/PWBY6IJYD4do47fImEC6/u9WXY8w71stymr4DcJRXPn1d+jXV2sdD7HtHOWKVlnWRc/22ZwImgEYaC9zAAEaMqNTbiOcnF0WfY5BLiyapRLIExAbRyFWQ6syIQn+ymQZAE5UYr8pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716533351; c=relaxed/simple;
	bh=dfl2sjKyu7D/KM7JDBNVtwKtibJ3MddGG4AT+iVWvC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGd1RYmd6d1mBJA52U/8W+wS+v126MnOG5X0zZX5MkBSBoHajlqc/HKpQBJbIrECtb98FxolFESJeFsXBoXuj7hdbJPv0rT2hGjs6tXUADp2YeWRgFMNROzLJN2gAyJMXjJgUyc4bfnpqRF67noTG9thEJ6WB7EKEdwz/pUJrCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmEqdH+F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmEqdH+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C8CC2BD11;
	Fri, 24 May 2024 06:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716533351;
	bh=dfl2sjKyu7D/KM7JDBNVtwKtibJ3MddGG4AT+iVWvC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MmEqdH+FOBabc2/iqh8MbM0b0m0b9bZsEV3XpMRBq6S6fYY+mgE3yYs2oj79zgJ9F
	 TPWb6JEsE2JYX6jScieseflEoxnACov4P4uR05OCvf22QNzg3NodU+R/JdJ8v7hpZr
	 b9Eq/gAqN7hYh38o31I+krK3vbsL62YxZx37+ZUFlI/ydFGhV0ylWjjBLgLiZ+L94j
	 3Kv51at/1QOM3WlC1k30nbwr0MavskdPkkYSZ4DSuAKMXiTNv12jWNWEuRLSP4DKcL
	 jXG51wjuxO2c2dEQN5OJIgt2r+gAlxGIhK+A40GeuN6d088x+XGZkjOJY87Eihk5Qm
	 yreviysUkjzJw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 6/6] selftests: mptcp: use wait_local_port_listen helper
Date: Fri, 24 May 2024 14:48:51 +0800
Message-ID: <d34eea618a39ddc4a928d44a38f966c953253f85.1716533107.git.tanggeliang@kylinos.cn>
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

This patch includes net_helper.sh into mptcp_lib.sh, uses the helper
wait_local_port_listen() defined in it to implement the similar mptcp
helper. This can drop some duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 60f802e808a7..b539a5436560 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 . "$(dirname "${0}")/../lib.sh"
+. "$(dirname "${0}")/../net_helper.sh"
 
 readonly KSFT_PASS=0
 readonly KSFT_FAIL=1
@@ -363,20 +364,7 @@ mptcp_lib_check_transfer() {
 
 # $1: ns, $2: port
 mptcp_lib_wait_local_port_listen() {
-	local listener_ns="${1}"
-	local port="${2}"
-
-	local port_hex
-	port_hex="$(printf "%04X" "${port}")"
-
-	local _
-	for _ in $(seq 10); do
-		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
-			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) \
-			     {rc=0; exit}} END {exit rc}" &&
-			break
-		sleep 0.1
-	done
+	wait_local_port_listen "${@}" "tcp"
 }
 
 mptcp_lib_check_output() {
-- 
2.43.0

