Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66192A1A5
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711713390; cv=none; b=L2OMgGGTTuwDAmnd6ZmqM9dl8WQUxZrLL9Zoaphxmgx1EenmDQMeI/t7JmeXTy05fcK5cX9M/kNMtF9vKayyCpoeGY2UWpsPNQkSk3xdY6x2LfU5XjAD04aHx/J/lduSvybwQ6F5lEw1vMAZdvtR7+5ousJc9I+mAvNZUX1025o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711713390; c=relaxed/simple;
	bh=fJWZAR3TuSmPNaqoTuLkp6L1JLX6lmP7mcADa5eAC0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uKwkP3aqecONuLESbwN0d/vfCo8d9grN37VNCnz8ypzQ2HvBmrBU3O+U8RpBD3guhhEqdY5xBiicrmbEyUxsRIHX1PCK0AbJGQh9SoK7vyiBltiXB3cylZNo2/C/pJjzOieu8TZlSLGHdFLK6OGCMX+VNREYP3frDsmpEKYMn9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6XuYArM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6XuYArM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF129C43390;
	Fri, 29 Mar 2024 11:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711713390;
	bh=fJWZAR3TuSmPNaqoTuLkp6L1JLX6lmP7mcADa5eAC0I=;
	h=From:To:Cc:Subject:Date:From;
	b=c6XuYArMjkclmbcmE1brF/o8f+uC0PK4tbd02Yc64OYiqraP3AXSe9vOotn9cQpRs
	 5sEh5Nrg28PFVSRoB3YhkXquru2m4FALFFEHC/41A3ygnmTZSuf6EmPmrALQjc5JQo
	 26QrP3GfpYzoVvg+Xf1V2Zy60XXlR2Q4x0YGO9/LjB2OZdCs2xGc26c3FmF68O4uMP
	 Sg59EtY1e9ue+o9dNqc/L5srbpi/QK/A/GOpa8JbVEyZ5RBdHLmYYDW8tbKMWihCI8
	 oxK4a0UpUFDtO6ydzAueI8cJpCOJcLGV/iLCaqzXG0T76nNh3kcEO5GIvJWu6SIpIa
	 M7Q+jVekOwL4g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add last time actions tests"
Date: Fri, 29 Mar 2024 19:56:24 +0800
Message-Id: <d177c05847edc56a2bbc56d904a18cee8011a1ef.1711713371.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update chk_msk_info with mptcp_lib_pr_fail.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 6e865f95f85e..aa1cdfb176db 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -211,12 +211,16 @@ chk_msk_info()
 		cnt2=$(ss -N ${ns} -inmHM | mptcp_lib_get_info_value "$info" "$info")
 		msg="....chk ${info:0:15}=$cnt1:$cnt2"
 		mptcp_lib_print_title "${msg}"
-		if [ "${cnt1}" -lt "${cnt2}" ]; then
+		if [ -z "${cnt1}" ] || [ -z "${cnt2}" ]; then
+			mptcp_lib_pr_skip "Feature probably not supported"
+			mptcp_lib_result_skip "${msg}"
+		elif [ "${cnt1}" -lt "${cnt2}" ]; then
 			mptcp_lib_pr_ok
 			mptcp_lib_result_pass "${msg}"
 		else
-			mptcp_lib_pr_skip
-			mptcp_lib_result_skip "${msg}"
+			mptcp_lib_pr_fail "expected $cnt1 < $cnt2"
+			mptcp_lib_result_fail "${msg}"
+			ret=${KSFT_FAIL}
 		fi
 	done
 }
-- 
2.40.1

