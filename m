Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021CF2E859
	for <mptcp@lists.linux.dev>; Tue, 21 May 2024 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716287866; cv=none; b=atq7aw94PW1wvHNqa9wyEo9fyeJepQxalE+PJInecvhEBbBFBbRrIBXHY7fbGG7TzfV78P19O/qRCz6S4bbutqaphFbfZ7Esu4/EwRcfZH4qMBSJ+1WqSYpaFUsOTlU/GgDPhlNJJJO+VZPmwnGV2bMnioW4HsBEgb8jdqkdjpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716287866; c=relaxed/simple;
	bh=dRt+igbFLxhKxnJsp0pIww5OKE1VOkVIot2yxWZHy/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOQY3F1CL3cdgAo32ZaCUn+4sttD+GF5ATVNXtTmv6EISxNxnWB4d5jyD6413HG6DpGgfsqLZSdSkMcSjmGfRbJtXONKGm94/XpvVDpxlAWqKwZScGWRDX4PNo4IRClHLgHy4TTxt5Mz16sXBtpnaO9lXLVy09mdpCWTqK4ZIqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryTo73XH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryTo73XH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2080C32782;
	Tue, 21 May 2024 10:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716287865;
	bh=dRt+igbFLxhKxnJsp0pIww5OKE1VOkVIot2yxWZHy/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ryTo73XHYKZkz9y6/3CyN7lbmCA0f9IdK4PieONtr0LMatpeguJP+BJ+KCz6e91zh
	 RuljRhz8oqLasohZak4xoD29V/INIvORs2rzEO4MRjOcUxc5D+OialOCGQhYxtgTrS
	 f6a0ECh0pcU8CoSqpWDz87PZTpOR2hSlXgEKaDUHFkiFTwEUjNUa74xKNVvhsYmJoC
	 YAEXXo/IYshYGusFWEdA+5b+DN8ZU25mNlk5JGjv7ohMxD5XeryQDXM9MhGapkDl4a
	 X5ZvomvRQ65v03zqZA9phYET3nvwnVUaNRxbYNS+AZOZjdZH+QGyS9DicfGrG5IHUj
	 HYqKDpRFLfLDQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/4] selftests: mptcp: use wait_local_port_listen helper
Date: Tue, 21 May 2024 18:37:31 +0800
Message-ID: <b86b55c1172a723b9a77efbedafb34a858e5ab85.1716287732.git.tanggeliang@kylinos.cn>
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

This patch includes net_helper.sh into mptcp_lib.sh, uses the helper
wait_local_port_listen() in it to implement the similar mptcp helper.
This can drop some duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index bd7d78e4aa83..e039c88a64ed 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 . "$(dirname "${0}")/../lib.sh"
+. "$(dirname "${0}")/../net_helper.sh"
 
 readonly KSFT_PASS=0
 readonly KSFT_FAIL=1
@@ -337,20 +338,7 @@ mptcp_lib_check_transfer() {
 
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

