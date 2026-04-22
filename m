Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7EA2E5B2A
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876049; cv=none; b=Z1H8u/xW/mMXSZgnL/1oK5Q737RiVvlEfHSWDJnJ1JhkhFo+48RpQhEab9KSn4hjjjP26kvclludslksqBDZe56g6s4Swd5XY/35P6VNWosaX9vkz8hoDKecyB+bWzeNxHJ4IwyGhV63172goZ02GcQlRG2gUSDaYRqbUCUKUcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876049; c=relaxed/simple;
	bh=4iemWZyS23XFlX1CT3kuENuF5DWJNQBzNrxo6eWgvYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qaeaqgmUVYc7pSM7KrN6XOj9gKlkvka1yqULkrnZAQ57L7p6fFgswX2nONedQyMTja5PU+kqs2ArbuhKb4W3ve05mk/FhzrVHIE2/xnDKCFe89S2vNFSTBb/B9O2yQe2WDKVTdsVwtkP/h2xeKfqjE538wiPI3iYOk2oOEx3/E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeD+OR6x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeD+OR6x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CC9C2BCAF;
	Wed, 22 Apr 2026 16:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876049;
	bh=4iemWZyS23XFlX1CT3kuENuF5DWJNQBzNrxo6eWgvYg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NeD+OR6xm+pOytO3XYZ1mjQg84LYnMkFF8MnWWNedYzyhMC5zckKNl2B2+4wTkgcX
	 ijgZ1hQJVJUmjJGrRAXWB02z1iscflBGz3NvWGyWFiDWXUdnKRCznKIY/zobJ5hlkm
	 lVbq1K2AThDe9vNuSbSjtXqdRTiWXaKq8Q0cezNAIOLqbyzgiVeYN8iaay2hL4Zvih
	 1i9LTyQ2MjVNnmM1Tb8y+xvZG+ZMTFf+cp7g4Diuqf8iEYI5HpnCBgJ4EsYo89F6rc
	 m0NUHZ3QcKJ6xN9GcvFTOzyYB5hi5mdrIIcjVDhKW0yWs+Td16SSIsm66Zb578udSC
	 5DojbV+YdLj1A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Apr 2026 18:40:24 +0200
Subject: [PATCH mptcp-net v6 10/19] selftests: mptcp: check output: catch
 cmd errors
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-mptcp-inc-limits-v6-10-903181771530@kernel.org>
References: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
In-Reply-To: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3981; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4iemWZyS23XFlX1CT3kuENuF5DWJNQBzNrxo6eWgvYg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJf/GLs/rsvcFfJia7vvqK+xfOLihtPFu9mu9D3VNGvq
 VHCaUNURykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERSpRj+iqgfOhT5PWBfqUhG
 hrjHlbmTtl83lDx3nW3eHpY/H37UPmFkuMn9wn167caCDe99slymsGv9fWawxvy2pX2/3sFdR+c
 q8QIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Using '${?}' inside the if-statement to check the returned value from
the command that was evaluated as part of the if-statement is not
correct: here, '${?}' will be linked to the previous instruction, not
the one that is expected here (${cmd}).

Instead, simply mark the error, except if an error is expected. If
that's the case, 1 can be passed as the 4th argument of this helper.
Three checks from pm_netlink.sh expect an error.

While at it, improve the error message when the command unexpectedly
fails or succeeds.

Note that we could expect a specific returned value, but the checks
currently expecting an error can be used with 'ip mptcp' or 'pm_nl_ctl',
and these two tools don't return the same error code.

Fixes: 2d0c1d27ea4e ("selftests: mptcp: add mptcp_lib_check_output helper")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v5:
 - improve err msg in mptcp_lib.sh, supporting unexpected success
 - s/no_err/exp_error/ in pm_netlink.sh
 - a 3rd check expects an error in pm_netlink.sh (removed later on)
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 16 ++++++++++------
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 10 ++++++----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 5fea7e7df628..989a5975dcea 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -474,20 +474,24 @@ mptcp_lib_wait_local_port_listen() {
 	wait_local_port_listen "${@}" "tcp"
 }
 
+# $1: error file, $2: cmd, $3: expected msg, [$4: expected error]
 mptcp_lib_check_output() {
 	local err="${1}"
 	local cmd="${2}"
 	local expected="${3}"
+	local exp_error="${4:-0}"
 	local cmd_ret=0
 	local out
 
-	if ! out=$(${cmd} 2>"${err}"); then
-		cmd_ret=${?}
-	fi
+	out=$(${cmd} 2>"${err}") || cmd_ret=1
 
-	if [ ${cmd_ret} -ne 0 ]; then
-		mptcp_lib_pr_fail "command execution '${cmd}' stderr"
-		cat "${err}"
+	if [ "${cmd_ret}" != "${exp_error}" ]; then
+		mptcp_lib_pr_fail "unexpected returned code for '${cmd}', info:"
+		if [ "${exp_error}" = 0 ]; then
+			cat "${err}"
+		else
+			echo "${out}"
+		fi
 		return 2
 	elif [ "${out}" = "${expected}" ]; then
 		return 0
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 123d9d7a0278..b69f30fcb91e 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -122,10 +122,12 @@ check()
 	local cmd="$1"
 	local expected="$2"
 	local msg="$3"
+	local exp_error="$4"
 	local rc=0
 
 	mptcp_lib_print_title "$msg"
-	mptcp_lib_check_output "${err}" "${cmd}" "${expected}" || rc=${?}
+	mptcp_lib_check_output "${err}" "${cmd}" "${expected}" "${exp_error}" ||
+		rc=${?}
 	if [ ${rc} -eq 2 ]; then
 		mptcp_lib_result_fail "${msg} # error ${rc}"
 		ret=${KSFT_FAIL}
@@ -158,13 +160,13 @@ check "show_endpoints" \
 			    "3,10.0.1.3,signal backup")" "dump addrs"
 
 del_endpoint 2
-check "get_endpoint 2" "" "simple del addr"
+check "get_endpoint 2" "" "simple del addr" 1
 check "show_endpoints" \
 	"$(format_endpoints "1,10.0.1.1" \
 			    "3,10.0.1.3,signal backup")" "dump addrs after del"
 
 add_endpoint 10.0.1.3 2>/dev/null
-check "get_endpoint 4" "" "duplicate addr"
+check "get_endpoint 4" "" "duplicate addr" 1
 
 add_endpoint 10.0.1.4 flags signal
 check "get_endpoint 4" "$(format_endpoints "4,10.0.1.4,signal")" "id addr increment"
@@ -173,7 +175,7 @@ for i in $(seq 5 9); do
 	add_endpoint "10.0.1.${i}" flags signal >/dev/null 2>&1
 done
 check "get_endpoint 9" "$(format_endpoints "9,10.0.1.9,signal")" "hard addr limit"
-check "get_endpoint 10" "" "above hard addr limit"
+check "get_endpoint 10" "" "above hard addr limit" 1
 
 del_endpoint 9
 for i in $(seq 10 255); do

-- 
2.53.0

