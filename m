Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772223E325
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173665; cv=none; b=V156ycRXPk+TxUGZkE+aeBwxGzA8hNVCtgx9JzuckNeHnLzZu7cJvw5+24s/FQ+3iRKH0DLKgOvsPF5Nd7BFvHsiwjCrCfQhBv54rp9bcwh9Uq5vPO258pFCL5Jhuu5gsS8n+Eg2e+8ZmUl1YBrmp9c/NziZERIQHQc5Iu/1GiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173665; c=relaxed/simple;
	bh=ymPAk+anGD7xTu+XbCuXfPCdUlIClG6Dbxcyn5o+0b4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=auEMRS/6rdBHkRHzTtl6c0vebkOi2RL6/xgstFVyeRtU/sxOzcF3zmYjzMfLCXBDMf5+2qVRJZ8SupGlsAHBN94DUPpwvuTYqHRy/mKl1dBzxD4EURFUyg88CJ2heZE6FXoLTYDCK9iXoP73Clecp3UDE5OqWFAIjzYh/Sh2njA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orAwk3cn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orAwk3cn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33688C2BCB9;
	Tue, 14 Apr 2026 13:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173665;
	bh=ymPAk+anGD7xTu+XbCuXfPCdUlIClG6Dbxcyn5o+0b4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=orAwk3cn5kDWrN0ph8aYgUQ1TnJctUcmEZQXcHdS3W7mWLPSoDL6F22ep+zLYjadd
	 oO46O4YX0AtEESLj1egDV1S0vmI2Va+D+Y3P95W4R7ZeL9QnDXFELeou9dbnAcK4/h
	 pD6nxrZYb3No7/kpIIlJDcaKHNv1hhCXQJtSrAfKj00j5WiEZUqUbq09IUkdpIQQrR
	 BXzE45wJcuoVpxD3+NWLVwT8eaFYrrdbPkK1E5PvpzWJ1Qi7ke6zOsOcg2mW/339lp
	 Hf7IybM2VuHt0F4+yMb/i9oAZlcayLPpBoLdDp2k8rQK14K/sKhEAz847aXeLQkrG5
	 tCwbgFk8Yxvkw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Apr 2026 15:34:11 +0200
Subject: [PATCH mptcp-net v4 18/20] selftests: mptcp: pm: validate new
 limits
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-mptcp-inc-limits-v4-18-78274edda5dd@kernel.org>
References: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
In-Reply-To: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3801; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ymPAk+anGD7xTu+XbCuXfPCdUlIClG6Dbxcyn5o+0b4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvOQVuMercp63rIC3U7X7A9Wf3ngXb3jzbte6w8734g
 NknWmK/dJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEyk0ozhfxI75yzVuasOzGJn
 0eSdyNcUeZ1L6fDurz967shfe7rv3W2G/9kqR/X1Gw3VM3onz3j2K+XpMr3PG2bL/Vu4fHKYe2Z
 0BgMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These limits have been recently updated, from 8 to:

- 64 for the subflows and accepted add_addr

- 255 for the MPTCP endpoints

These modifications validate the new limits, but are also compatible
with the previous ones, to be able to continue to validate stable kernel
using the last version of the selftests. That's why new variables are
now used instead of hard-coded values.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v4: avoid using "&&" with check(), use a clearer way instead.
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 56 +++++++++++++++----------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index cb1d3cfc1104..e2e60f2cf46a 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -66,6 +66,15 @@ get_limits() {
 	fi
 }
 
+get_limits_nb() {
+	if mptcp_lib_is_ip_mptcp; then
+		ip -n "${ns1}" mptcp limits | awk '{ print $2" "$4 }'
+	else
+		ip netns exec "${ns1}" ./pm_nl_ctl limits | \
+			awk '{ printf "%s ", $2 }'
+	fi
+}
+
 format_endpoints() {
 	mptcp_lib_pm_nl_format_endpoints "${@}"
 }
@@ -164,6 +173,7 @@ check "get_endpoint 2" "" "simple del addr" 1
 check "show_endpoints" \
 	"$(format_endpoints "1,10.0.1.1" \
 			    "3,10.0.1.3,signal backup")" "dump addrs after del"
+add_endpoint 10.0.1.2 id 2
 
 add_endpoint 10.0.1.3 2>/dev/null
 check "get_endpoint 4" "" "duplicate addr" 1
@@ -171,25 +181,29 @@ check "get_endpoint 4" "" "duplicate addr" 1
 add_endpoint 10.0.1.4 flags signal
 check "get_endpoint 4" "$(format_endpoints "4,10.0.1.4,signal")" "id addr increment"
 
-for i in $(seq 5 9); do
-	add_endpoint "10.0.1.${i}" flags signal >/dev/null 2>&1
-done
-check "get_endpoint 9" "$(format_endpoints "9,10.0.1.9,signal")" "hard addr limit"
-check "get_endpoint 10" "" "above hard addr limit"
+read -r -a default_limits_nb <<< "$(get_limits_nb)"
+# limits have been increased: from 8 to 64 for subflows/add_addr & 255 for endp
+if mptcp_lib_expect_all_features || set_limits 9 9 2>/dev/null; then
+	max_endp=255
+	max_limits=64
+else
+	max_endp=8
+	max_limits=8
+fi
+set_limits "${default_limits_nb[@]}"
 
-del_endpoint 9
-for i in $(seq 10 255); do
-	add_endpoint 10.0.0.9 id "${i}"
-	del_endpoint "${i}"
+for i in $(seq 5 ${max_endp}); do
+	add_endpoint "10.0.0.${i}" id "${i}"
 done
-check "show_endpoints" \
-	"$(format_endpoints "1,10.0.1.1" \
-			    "3,10.0.1.3,signal backup" \
-			    "4,10.0.1.4,signal" \
-			    "5,10.0.1.5,signal" \
-			    "6,10.0.1.6,signal" \
-			    "7,10.0.1.7,signal" \
-			    "8,10.0.1.8,signal")" "id limit"
+check "get_endpoint ${max_endp}" \
+	"$(format_endpoints "${max_endp},10.0.0.${max_endp}")" "id limit"
+
+if add_endpoint '10.0.0.1' &>/dev/null; then
+	hardlimit="no error"
+else
+	hardlimit="error"
+fi
+check "echo ${hardlimit}" "error" "above hard addr limit"
 
 flush_endpoint
 check "show_endpoints" "" "flush addrs"
@@ -202,15 +216,15 @@ if ! mptcp_lib_is_ip_mptcp; then
 	flush_endpoint
 fi
 
-set_limits 9 1 2>/dev/null
+set_limits $((max_limits + 1)) 1 2>/dev/null
 check "get_limits" "${default_limits}" "rcv addrs above hard limit"
 
-set_limits 1 9 2>/dev/null
+set_limits 1 $((max_limits + 1)) 2>/dev/null
 check "get_limits" "${default_limits}" "subflows above hard limit"
 
-set_limits 8 8
+set_limits ${max_limits} ${max_limits}
 flush_endpoint  ## to make sure it doesn't affect the limits
-check "get_limits" "$(format_limits 8 8)" "set limits"
+check "get_limits" "$(format_limits ${max_limits} ${max_limits})" "set limits"
 
 flush_endpoint
 add_endpoint 10.0.1.1

-- 
2.53.0

