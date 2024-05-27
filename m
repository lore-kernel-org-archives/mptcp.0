Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A05613B780
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807527; cv=none; b=tse9RNCnM3FLALkNbR9C+gbjfAhGZjrR87J568Fo70Rp6KzevytH3ZwA2yLSrDuwnMztzfjNOLKT5O2soD03YK2p0XUZdyiX1hvqmgrqs/9AeHYxSO2IrJOZmmsho13Ox5IM0GScWhWDNqSqCPAAdv/pLeAhy9rdPx0sviOloZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807527; c=relaxed/simple;
	bh=CRkpD64FtxDqs5tvTLqLkgdEkfYYf7WaDTjqEk5a6Nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WqV7FEmMiup7+3f1GUOEm1rf3Ehp7LaBK2q5qfNidEH/Ye0yYez/yGVP9XtE3uLgKu5gcAFMTtKs0JZW15y5xwLhKtAwt75XWE7tWVtxtT3pHqbLF063F1XJyoiWgRA0FzxLSKRfRaSMP1qCaJbj5EpXNnTgrxFQ+6rclg0R25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrylMWPg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrylMWPg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF66C32786;
	Mon, 27 May 2024 10:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716807527;
	bh=CRkpD64FtxDqs5tvTLqLkgdEkfYYf7WaDTjqEk5a6Nw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BrylMWPgdhpoKmTj4FDLKLdfCkm1cKBa5a78VfdLzZq+0wc9xNfs1bMKCSeN/0z67
	 XSbaawzAisCsp13M09LogGgmmCWPWh6sRBrPPOja/QhabiWhSsMYDm8lDW4Vx9RSfP
	 ZNbDeE3ClhPnYaIG3ttFtEpVOtVWHlw24Oawr3+rhfSCGd/Ihg/46/xt9GFII6FYaJ
	 voYAiQa7B3GYp3z25L5AqKmxOt4kafD1YljLHE3RptPrSDF6c18RvU7GyP6p8dItqF
	 AHLgC+WCLN8amyljbDYpt135KEttDc2Bnhw42pxVwxt13mi/ZgXN3/X1cGQSEXl/ee
	 MSW/2L1r8bZBQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 May 2024 12:58:30 +0200
Subject: [PATCH mptcp-next v6 3/9] selftests: net: lib: avoid error
 removing empty netns name
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-selftests-net-lib-fixes-v6-3-72411ff2460e@kernel.org>
References: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
In-Reply-To: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CRkpD64FtxDqs5tvTLqLkgdEkfYYf7WaDTjqEk5a6Nw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVGdiUkKjQ/zfAhIkamDLx9jU+UrszVGY4YwE/
 ejhV/Rjbi2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlRnYgAKCRD2t4JPQmmg
 c1rZD/9qjiNX2P5ZpgwFI6d+DMqF79MGP0TO5LNQXBY8ljkNZc4/p9x7s1sPDe80Jle7tipzV5f
 Hcl0iF8t/mkUJAGSOTYrt/WMenSHQ83Xuk+0J3AvWZ4zwRN0VajsnLcNPifav2vu/Um643pGkdf
 h/ZO4qiPJVsoXl+9GzekUj2anca4xfQlwbCht/fzGn0OwKSFqqVHYN0FYhqiI5kqSjHQ8U6usfF
 LbybTybJ4Gd4oYE/QzXGBtCXNs8FZxbg9odpXwRL8YPzPJIlXrLPF9mNEc9n3hjFWPXOvhCDgKE
 zGi4PBhfwgM/pMvTHKbQ+HxbSG5H8adhaSi0UeGcAn6gaI8k4leH4OuBPH+3uIX2UJLYYniWJ9R
 VEwRlX4+13zdrV/DB5AkpisvfySH58s1qOBAwUVN/xVGrifdNHUWFQdcHEX7wDym0Rp1t3BmFyN
 jbfJREo9nBa9JrdhWyc2rGtvvCxxZ52TLQShxwUKInIKNI0OZDGI5gblK0KgoMo9x/SyYDZtKaw
 zttW5a+19sxzHxk7QtKbw7soKbI8kcG62n/RYT1rnBfLLjvemS+iiXtZmQFIlYHzcEvl24BPk+H
 I0whSLYHnLNhEQMAIaOlDNz/lCcsaCNxPuhxd583bPs0mz5fsGpkYmXtAuFEj1SsOjNZT1hGNuO
 hpp3DY/Z7FCzsqg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If there is an error to create the first netns with 'setup_ns()',
'cleanup_ns()' will be called with an empty string as first parameter.

The consequences is that 'cleanup_ns()' will try to delete an invalid
netns, and wait 20 seconds if the netns list is empty.

Instead of just checking if the name is not empty, convert the string
separated by spaces to an array. Manipulating the array is cleaner, and
calling 'cleanup_ns()' with an empty array will be a no-op.

Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 2fbc01003b0f..9155c914c064 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -15,7 +15,7 @@ ksft_xfail=2
 ksft_skip=4
 
 # namespace list created by setup_ns
-NS_LIST=""
+NS_LIST=()
 
 ##############################################################################
 # Helpers
@@ -138,6 +138,7 @@ cleanup_ns()
 	fi
 
 	for ns in "$@"; do
+		[ -z "${ns}" ] && continue
 		ip netns delete "${ns}" &> /dev/null
 		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
 			echo "Warn: Failed to remove namespace $ns"
@@ -151,7 +152,7 @@ cleanup_ns()
 
 cleanup_all_ns()
 {
-	cleanup_ns $NS_LIST
+	cleanup_ns "${NS_LIST[@]}"
 }
 
 # setup netns with given names as prefix. e.g
@@ -160,7 +161,7 @@ setup_ns()
 {
 	local ns=""
 	local ns_name=""
-	local ns_list=""
+	local ns_list=()
 	local ns_exist=
 	for ns_name in "$@"; do
 		# Some test may setup/remove same netns multi times
@@ -176,13 +177,13 @@ setup_ns()
 
 		if ! ip netns add "$ns"; then
 			echo "Failed to create namespace $ns_name"
-			cleanup_ns "$ns_list"
+			cleanup_ns "${ns_list[@]}"
 			return $ksft_skip
 		fi
 		ip -n "$ns" link set lo up
-		! $ns_exist && ns_list="$ns_list $ns"
+		! $ns_exist && ns_list+=("$ns")
 	done
-	NS_LIST="$NS_LIST $ns_list"
+	NS_LIST+=("${ns_list[@]}")
 }
 
 tc_rule_stats_get()

-- 
2.43.0

