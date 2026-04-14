Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89538146D5A
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173659; cv=none; b=EELdVWs86rp/XUjI5tYy+0Vdj4VFCZj3c54if21YwV2tvFEFQgsuAT47lR5dgIYjPRUVh09pasztfyviP6BdsfzhFpIxgmn43Y4vu8uj8TMsupl4O2DoOyfW+iN2OOXGGsOrxDWAszK64QGaBuPJCW37F/fL1lOSh7ZIEOBd6Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173659; c=relaxed/simple;
	bh=JVv3n3lAs9f0iyEOxoQtxHVB4hfzJFBKq6/oFcsFMiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NBKiIR5QiCHEUBEv7XWgi/CyqCBl60mfGUydQV1S8/8sgqs4E/33VzclfTQnd2CFMkdx83qC0F9p5DVQSOopXMN6JESouDhDWpidHFMNzoWBQEK/kd4NnDpDAScU9blGwoykIh98zoSLC+qdIPLJ6yioKF89HXmhyGPiX3Ktlds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R65N1tIi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R65N1tIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF41C2BCB5;
	Tue, 14 Apr 2026 13:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173659;
	bh=JVv3n3lAs9f0iyEOxoQtxHVB4hfzJFBKq6/oFcsFMiw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R65N1tIiplxZ8k7iMUriKilnHNVwMVdvRz2W2Bz8Rc4wtsXflQ9zaQGxRqtdSx6jO
	 wR5t2gSxOiNJjXT2S58bo9tBzLo8orpzCWNyzjkWEg4UOIrEZ8EG0l6tGZzOk6j36/
	 wuRTyWfvW8JN3Z44rGQi0+Ye/q7zzBhrHalLjYsi+6wbiPsw8s1aMEnjyAMnnsCrLr
	 K66o8lCqxSA1suXRe+pjAPqp2gVwbQ/zftZDZwbQedxVB4uDNRhK0BFhb9CnNO2/KT
	 tL73WLrfqhh3NmEA4JMk5BcoicK1cLmnyF5eGoUKRrllFlnqz9JWpBmV97PRx4b9Re
	 iPi61XyHcxl+Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Apr 2026 15:34:03 +0200
Subject: [PATCH mptcp-net v4 10/20] selftests: mptcp: check output: catch
 cmd errors
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-mptcp-inc-limits-v4-10-78274edda5dd@kernel.org>
References: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
In-Reply-To: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3113; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JVv3n3lAs9f0iyEOxoQtxHVB4hfzJFBKq6/oFcsFMiw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvOflmuX2vtBKVXD1v/42z80ub2r5znfn8tcBzk+iMf
 dz/1y5v7ShlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiIxQaG/yFWhkve7Xyndon3
 9fysWau0ebr/xZQ3p+bemq53QKIhMZDhf8a5wFdBanKnci99zc0r+Z5heY6PPX6t5gSd9JYzviJ
 F3AA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Using '${?}' inside the if-statement to check the returned value from
the command that was evaluated as part of the if-statement is not
correct: here, '${?}' will be linked to the previous instruction, not
the one that is expected here (${cmd}).

Instead, simply mark the error, except if an error is expected. If
that's the case, 1 can be passed as the 4th argument of this helper. Two
checks from pm_netlink.sh expect an error.

Note that we could expect a specific returned value, but the checks
currently expecting an error can be used with 'ip mptcp' or 'pm_nl_ctl',
and these two tools don't return the same error code.

Fixes: 2d0c1d27ea4e ("selftests: mptcp: add mptcp_lib_check_output helper")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 8 ++++----
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 8 +++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 5fea7e7df628..9e0cd426845d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -474,18 +474,18 @@ mptcp_lib_wait_local_port_listen() {
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
+	if [ "${cmd_ret}" != "${exp_error}" ]; then
 		mptcp_lib_pr_fail "command execution '${cmd}' stderr"
 		cat "${err}"
 		return 2
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 123d9d7a0278..26ff4c360a77 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -122,10 +122,12 @@ check()
 	local cmd="$1"
 	local expected="$2"
 	local msg="$3"
+	local no_err="$4"
 	local rc=0
 
 	mptcp_lib_print_title "$msg"
-	mptcp_lib_check_output "${err}" "${cmd}" "${expected}" || rc=${?}
+	mptcp_lib_check_output "${err}" "${cmd}" "${expected}" "${no_err}" ||
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

-- 
2.53.0

