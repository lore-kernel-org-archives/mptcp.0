Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EA53D2FF5
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831538; cv=none; b=KGSH49oFHAKNj7CMzczxpplfbd1A8uViNYo6qX4/1bPy7p4s2bzx78EI5UcGPxvJibqscCf6SPdfXNZamiOYeMKrq1QH7hTtn8DRXuJP4py0m4SXRRKRfJp7R9eUYla673YP4YPXv6/dOLtKu8Trhlc6wNYMnyyN4S3V/5OYyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831538; c=relaxed/simple;
	bh=8PZLLeOwVPMc3bpT7xW7wYZklUFV3vxacK3H8M3nvfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vFTV4TLRypGf7DgX8j2oqSUNi5qNMy+l5HJS1k5IcNU/0pc2YWLCNFS4AB0NcbbK7m1YZU07mpKUfSQ4xQR9ljf+cjxbtNRKoSHOD3Ak8/yqY8HVTQZ53kkVFFZSspWNZ7d8rgfW6TirTyQxFEa7YWcl+h+ktvxk/YtSaSTf4WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kz7WfRgo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kz7WfRgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F290AC19421;
	Fri, 10 Apr 2026 14:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775831538;
	bh=8PZLLeOwVPMc3bpT7xW7wYZklUFV3vxacK3H8M3nvfg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kz7WfRgo5r04OtqbpdPFY1P+/OegRuoB6IxOH4uZ848NLv0OiXkg8lAQDqGO3E+u5
	 lkDw2SWi92CpoWKDAneyxdLj0e8Dlz3+ligFTlPed9jJcUEIcrn6AkLHep8LQkLj/z
	 lEo8Pn/gRALny1V0JcG2fekfKohGxbaAr3l3T4vYc0Z7qcOWrUrFi+CCytKg2fIost
	 1U5kIIzqcfksIKD2b7Y71K+lBEV1KypkXLN1PqhrHRTzy8fbo7kVBWrQExmdVrUTTx
	 NbJBAa4aWM/XE3i6lTyIMKOhgKYzJCUNIOS6gdbnU/Dmy5y2FNU7BrNhajjIHoBCfM
	 cx9hPCabimW4g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Apr 2026 16:31:53 +0200
Subject: [PATCH mptcp-next v2 15/17] selftests: mptcp: pm: validate new
 limits
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-mptcp-inc-limits-v2-15-5402209f05d3@kernel.org>
References: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
In-Reply-To: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3660; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8PZLLeOwVPMc3bpT7xW7wYZklUFV3vxacK3H8M3nvfg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvcj4x/RXS+vyaxFn7roqwluzru5kNJ3DO5nntGpHQp
 hvc/Na5o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCIMbowM89T7K9oual7jjff9
 9tEkJO93Dn+NutyZJ5z7F+UweZRWMzK8aLP8vTN5T/+C7PnZ27fPtPs8f+7PeaFSHgHqG18vmGv
 GBgA=
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
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 52 +++++++++++++++----------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index d844ee687a29..1ce5903c89c0 100755
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
@@ -162,6 +171,7 @@ check "get_endpoint 2" "" "simple del addr"
 check "show_endpoints" \
 	"$(format_endpoints "1,10.0.1.1" \
 			    "3,10.0.1.3,signal backup")" "dump addrs after del"
+add_endpoint 10.0.1.2 id 2
 
 add_endpoint 10.0.1.3 2>/dev/null
 check "get_endpoint 4" "" "duplicate addr"
@@ -169,25 +179,25 @@ check "get_endpoint 4" "" "duplicate addr"
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
+check "add_endpoint '10.0.1.1' &>/dev/null && echo 'no error'" "" \
+	"above hard addr limit"
 
 flush_endpoint
 check "show_endpoints" "" "flush addrs"
@@ -200,15 +210,15 @@ if ! mptcp_lib_is_ip_mptcp; then
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

