Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BCC125DC
	for <mptcp@lists.linux.dev>; Sat, 25 May 2024 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716642137; cv=none; b=IEG5lb5UsCDm8ZnxIZOSv7ANGlkLgWR2FdwbmvwmjOMN3lxIRVizUyJDRKxdSik3GNjZqOqsG9S5lKZ1NdvZo/NCX0MzoVeeEOMsBSFVISsn90wCD5kB6KGikhaIIskx1NZA3THqRgKO+OFeOsybSuMypv5Cz3ZEKPVKkIezUvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716642137; c=relaxed/simple;
	bh=g4vEoRgIauKGF2wSD/mzFF7iLo5kG0VWs5K7Jn5oY7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q21+kWWwEaLZ3FNh4F7knQnNOpKueO98D4ze0ilMA80oDjS7gxkJ5hSzJmfy1eBG6r7mS0UGiXK2zuBIXfzBfytGJNpkW/8tLn1zn20/6/1O80TyCZmfYbgHyUnVWk5THyvm+Ym8vUMrgMem0O9bK2387cm9vcwHGkTfRQYfOUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npF9XjSD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npF9XjSD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13752C3277B;
	Sat, 25 May 2024 13:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716642136;
	bh=g4vEoRgIauKGF2wSD/mzFF7iLo5kG0VWs5K7Jn5oY7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=npF9XjSDZkH43/AE2DeGKV8uiTloQ3yHUkmIzYzrjKOMYrokfu6AteCuLd/Er+a/c
	 FL2HXnInP7m1Yt4Et2kATORqXwqTCY0n0Kl/x9h1Uzuppw0f3xdMfM6R0Vk+/vM8p8
	 nDxNe4m1NrJ0BLWR8kMj7PYX8uEhzh/OhstniHx8gZAIeYP9A3zTxdQe+4XAFKtgeO
	 JX5il5nbQ9EA10/ln4mSi4CvJidf5OpxHUH+tuZYblpQSzOVVne93dCoHwsfYTEwgp
	 4d5FW7qpjNgNvrgCn8rfEioPHS5iVUhD5niJGetCJYt83s0A9q+pHl8FBUl8BheVZs
	 PpkG//RFInIkg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/4] Squash to "selftests: net: lib: rename ns in setup_ns"
Date: Sat, 25 May 2024 21:01:22 +0800
Message-ID: <a6c019fd6e47ba0c98fd03e9a4723df0075ad269.1716641976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716641976.git.tanggeliang@kylinos.cn>
References: <cover.1716641976.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

I think "ns_temp" is a better name than "_ns" here.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/lib.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index b883289ec4a1..97f3d7d6b913 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -167,11 +167,11 @@ cleanup_all_ns()
 # setup_ns local remote
 setup_ns()
 {
-	local _ns=""
+	local ns_temp=""
 	local ns_name=""
 	local ns_list=()
 	for ns_name in "$@"; do
-		if [ "${ns_name}" = "_ns" ]; then
+		if [ "${ns_name}" = "ns_temp" ]; then
 			echo "Failed to setup namespace '${ns_name}': invalid name"
 			cleanup_ns "${ns_list[@]}"
 			exit $ksft_fail
@@ -179,20 +179,20 @@ setup_ns()
 
 		# Some test may setup/remove same netns multi times
 		if [ -z "${!ns_name}" ]; then
-			_ns="${ns_name,,}-$(mktemp -u XXXXXX)"
-			eval "${ns_name}=${_ns}"
+			ns_temp="${ns_name,,}-$(mktemp -u XXXXXX)"
+			eval "${ns_name}=${ns_temp}"
 		else
-			_ns="${!ns_name}"
-			cleanup_ns "${_ns}"
+			ns_temp="${!ns_name}"
+			cleanup_ns "${ns_temp}"
 		fi
 
-		if ! ip netns add "${_ns}"; then
+		if ! ip netns add "${ns_temp}"; then
 			echo "Failed to create namespace $ns_name"
 			cleanup_ns "${ns_list[@]}"
 			return $ksft_skip
 		fi
-		ip -n "${_ns}" link set lo up
-		ns_list+=("${_ns}")
+		ip -n "${ns_temp}" link set lo up
+		ns_list+=("${ns_temp}")
 	done
 	NS_LIST+=("${ns_list[@]}")
 }
-- 
2.43.0

