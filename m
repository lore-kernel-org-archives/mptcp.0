Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9322D1C0DFC
	for <mptcp@lists.linux.dev>; Sat, 30 Mar 2024 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711784782; cv=none; b=TjkqTscSU2RaTk43KlmolGDk4ml6p9yhHz+V2U53ZuOsJRmq3nEz5buOCXpUIdcJWjBJjDpd25E7Seb/XCUyHSPydpAkJpDtiufFG4GnSWy2/k6HDRXkY+NyUGLukB7pPI4nZGdR7r/kMqfOsZTCPw8lRE7jAhSnR8D+d1ZzfuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711784782; c=relaxed/simple;
	bh=0/FMzjZjxcKW09mETu0Ldh1pS89sQGwxBH+0X4EMfow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nNEk4tdxmopMiWEjHz/gzacM2HxUggdTVq2rgSC2eZu+RW7ZlXSs96u2tjp56tCCv0ZeFYWVvaBnfdh/9Ni1ecCYR5O1VvqTP/Gr6w+nqAXjoKi4dopvEebgSKV/3rotbK7HRQSIcx3NmZBqhta4Q/Th1dkccCqOdgSE5erFN6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INTMg9+6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INTMg9+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F2EC43390;
	Sat, 30 Mar 2024 07:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711784782;
	bh=0/FMzjZjxcKW09mETu0Ldh1pS89sQGwxBH+0X4EMfow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=INTMg9+6V4zMdQFGcWJY7yKKWf+fZAFpHVXaSI5aPP3atnuVP/VR5C7GEZB9reZDV
	 qkTQVCFOHctU+M8YjN7fTNubbrA6QAC4RDZ+ucuY77fpEDPFdhnLTZ4bdY97Jpboa9
	 lfrBFs2NPowzVvxECtNAjKJXHnAMxdlAh4T4trzf+Cwd8SiGioar98UgeGrCYIh/rP
	 WBNDuUorslj4hkJoRZD5OjcYrALCNic4qwQcPoTVhBPWS7TivdOirdkhRyKeNklKmF
	 K0nhYItaSWhgpeer9omPkl8spOf81la+SknhkH7vKmgT/zwKcuz6oHt2UFB8NIq/qf
	 B4eMIJZnl44xQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/3] selftests: mptcp: add last time actions tests
Date: Sat, 30 Mar 2024 15:46:10 +0800
Message-Id: <b5a4e6d634ae8fd3e0710b02f57f0998a3da7df0.1711784619.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711784619.git.tanggeliang@kylinos.cn>
References: <cover.1711784619.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper chk_msk_info() to show the counters in
mptcp_info of the given infos, and check that the timestamps move
forward. Use it to show newly added last_data_sent, last_data_recv
and last_ack_recv in mptcp_info in diag.sh.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index bc97ab33a00e..2f9f734015b4 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -200,6 +200,34 @@ chk_msk_cestab()
 		 "${expected}" "${msg}" ""
 }
 
+chk_msk_info()
+{
+	local port="${1}"
+	local info
+
+	for info in "${@:2}"; do
+		local cnt1 cnt2 msg
+
+		cnt1=$(ss -N ${ns} -inHM dport ${port} | mptcp_lib_get_info_value "$info" "$info")
+		sleep 0.5
+		cnt2=$(ss -N ${ns} -inHM dport ${port} | mptcp_lib_get_info_value "$info" "$info")
+		msg="....chk ${info}"
+		mptcp_lib_print_title "${msg}"
+		if { [ -z "${cnt1}" ] || [ -z "${cnt2}" ]; } &&
+		   ! mptcp_lib_expect_all_features; then
+			mptcp_lib_pr_skip "Feature probably not supported"
+			mptcp_lib_result_skip "${msg}"
+		elif [ "$((cnt1 + 500))" -lt "${cnt2}" ]; then
+			mptcp_lib_pr_ok
+			mptcp_lib_result_pass "${msg}"
+		else
+			mptcp_lib_pr_fail "expected $((cnt1 + 500)) < $cnt2"
+			mptcp_lib_result_fail "${msg}"
+			ret=${KSFT_FAIL}
+		fi
+	done
+}
+
 wait_connected()
 {
 	local listener_ns="${1}"
@@ -233,6 +261,7 @@ echo "b" | \
 				127.0.0.1 >/dev/null &
 wait_connected $ns 10000
 chk_msk_nr 2 "after MPC handshake "
+chk_msk_info 10000 last_data_sent last_data_recv last_ack_recv
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
 chk_msk_inuse 2
-- 
2.40.1

