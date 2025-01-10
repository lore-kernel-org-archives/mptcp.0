Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFF66EB7D
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 03:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736478172; cv=none; b=mU+W409fVbWucdI8P4fCUrYadIo8XWrZVog4MJpkW+O8ij328bJ9JadyY6XK9RfZCs3S9HxZIP0UUd2VNv/k7yADgluWFt7v6KS1fBoBWTarbmNfFoVJ9QcquX3mjLi5oaa29WI57p/esQ4g4g3/GQ1EenLL3Jgz7BkTBxrS1Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736478172; c=relaxed/simple;
	bh=7wCtg+bcP7buYu26lysQ0vEmEcK8CilYmlPsMxVAvO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uI4MFd4HtapveRIT9zwY8grdXZWADZaZUbs7iCbx7CMsj8tS/FKuiy9uUyVahbUtT1VCsrAUvjt36PMMkFIBlTgNhZpDzv9mHAmkK7FmbsIrqycmOTJNQMnkOf9LNTUMyOysgJYeE79vJGDOi9z0Qb83VX1Yla4EReGsdMrRxaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpWrkAzl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpWrkAzl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A947AC4CED6;
	Fri, 10 Jan 2025 03:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736478170;
	bh=7wCtg+bcP7buYu26lysQ0vEmEcK8CilYmlPsMxVAvO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IpWrkAzlD65tOiGw58trCmdMAiiKBdYBbMT2Hq2uZYKeyC0fTTKN3lOQGFTldCFsM
	 4UZcOlutJPt4hE+piLFX0P33NkBbxA2C1ppQ8uwK2VeHvGdjFiXPtf5Vs4hUUrBJK8
	 bAFdbRe0vvPWF2N0gN9bfQpTXlmlLATOI2LnQ+ZkkBwIDRQSrU5YaBEdMankNZDFcI
	 giig1gMuyV/dfSOqaXxikNyL/rbnlk/JtaDIYmkfoZFMn695ovV3ZmCoC4+Z4kx/1j
	 fcJyl5PPhJxiaDCtf5kG2hzCcRNffPLM3fcIQEA3o/U6t79AbCvNQCaVDTJGQsHU+/
	 STFz5YitLvT0w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: move stats info in case of errors to lib.sh"
Date: Fri, 10 Jan 2025 11:02:41 +0800
Message-ID: <ff9a10bb4359ec77fc0b7499f44b388d737abe0f.1736477907.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <5ff48cd1eed9a8b4c51a9ba5d7f9e0d0e8b0389b.1736477880.git.tanggeliang@kylinos.cn>
References: <5ff48cd1eed9a8b4c51a9ba5d7f9e0d0e8b0389b.1736477880.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop the last two arguments "lstat" and "cstat" of mptcp_lib_pr_err_stats.

Based-on: <20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 3 +--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 3 +--
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 6 ++----
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 3 +--
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 5e3c56253274..d3bf0ec25bfa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -444,8 +444,7 @@ do_transfer()
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"
-		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}" \
-			"/tmp/${listener_ns}.out" "/tmp/${connector_ns}.out"
+		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}"
 
 		echo
 		cat "$capout"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 13a3b68181ee..6365555568ec 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1039,8 +1039,7 @@ do_transfer()
 
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		fail_test "client exit code $retc, server $rets"
-		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}" \
-			"/tmp/${listener_ns}.out" "/tmp/${connector_ns}.out"
+		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}"
 		return 1
 	fi
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 1f797d5f5156..633e7d776c3d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -112,18 +112,16 @@ mptcp_lib_pr_err_stats() {
 	local lns="${1}"
 	local cns="${2}"
 	local port="${3}"
-	local lstat="${4:-}"
-	local cstat="${5:-}"
 
 	echo -en "${MPTCP_LIB_COLOR_RED}"
 	{
 		printf "\nnetns %s (listener) socket stat for %d:\n" "${lns}" "${port}"
 		ip netns exec "${lns}" ss -Menitam -o "sport = :${port}"
-		[ -s "${lstat}" ] && cat "${lstat}"
+		cat /tmp/"${lns}".out
 
 		printf "\nnetns %s (connector) socket stat for %d:\n" "${cns}" "${port}"
 		ip netns exec "${cns}" ss -Menitam -o "dport = :${port}"
-		[ "${lstat}" != "${cstat}" ] && [ -s "${cstat}" ] && cat "${cstat}"
+		[ "${lns}" != "${cns}" ] && cat /tmp/"${cns}".out
 	} 1>&2
 	echo -en "${MPTCP_LIB_COLOR_RESET}"
 }
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 9c2a415976cb..f60a27b913d0 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -204,8 +204,7 @@ do_transfer()
 	fi
 
 	mptcp_lib_pr_fail "client exit code $retc, server $rets"
-	mptcp_lib_pr_err_stats "${ns3}" "${ns1}" "${port}" \
-		"/tmp/${ns3}.out" "/tmp/${ns1}.out"
+	mptcp_lib_pr_err_stats "${ns3}" "${ns1}" "${port}"
 	ls -l $sin $cout
 	ls -l $cin $sout
 
-- 
2.45.2

