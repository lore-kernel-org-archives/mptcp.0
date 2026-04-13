Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92B23CBE63
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089539; cv=none; b=WJ2EnSodXoKauuA7B14tqX3T2TyI3Uw6qnm+EeRwIOvZc3D+E+qog5C/cgiy3TeBDe8INorR0Z9ZBNPMRu2MqsSOFHgfTj/imA634iJEL2IjTvCnGmDELOtUt226h07WkJ+CjlMswmGsT/k0CyD+KQMc8OfvKw8lp0t4A2yMWVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089539; c=relaxed/simple;
	bh=8PZLLeOwVPMc3bpT7xW7wYZklUFV3vxacK3H8M3nvfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Abo1Uh8GdSYw9+9defCYYhQb0UVIgliqhwPspnLrU4E2uO7FvJA/rK2Gj1/v0ceXl+UfcRusR6V1MXG6qcZp+SvS2XL/mNUHmCWsxV3mYuHsiVy/16SCA5QNnl9stFquPUBAxeeRlJYDU958l0xlnblJ/93Ec7JdWlJe3UJGFx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caqrhBaq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caqrhBaq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17637C2BCC4;
	Mon, 13 Apr 2026 14:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089539;
	bh=8PZLLeOwVPMc3bpT7xW7wYZklUFV3vxacK3H8M3nvfg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=caqrhBaq+qJ/OfOchEAc+6/1hoATyO/F+RLVqUJ+1W8MnlGHl+2Tzi+kTYjnsfsMS
	 nzXHQ+x7l9t6jV6etkLYUwcUfaxQgt73HcfqiucxU5hdkKEHuJcFmz/Cv/ht9sxVBG
	 5lTaQOi8xsn3mzEd9lHIg0Q0Q9oULr1d3H9lHuKVSHEndojNniydk+IV0Om9ooVyME
	 OdxzuOAWbubk3FK2JZ3tnac4/EeicroThJTPSvoskQcnRG4K7xdJvT34ETKFJnj/A+
	 LRAWV57Xp+UzzkK4H9NO89bllIjMJOROpA89pOOK2Z2gepnSM5UZeeTq/jA7ykuabO
	 ORkVbleVPQ/Gw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 13 Apr 2026 16:12:03 +0200
Subject: [PATCH mptcp-net v3 17/19] selftests: mptcp: pm: validate new
 limits
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-mptcp-inc-limits-v3-17-dd36c9360432@kernel.org>
References: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
In-Reply-To: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3660; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8PZLLeOwVPMc3bpT7xW7wYZklUFV3vxacK3H8M3nvfg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLv/NzCuyVjZcXr2KaaL5nPxU57n/0r+jD03U7BRdpPL
 Y2iWFw5O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbC0s/I0KDnUXh7l+WVTmH3
 R05lGbGzkv7N3L51RYPp36N6bW+euTD89/rV/FPQpKHnrdRspZ/zZohGcClzX5phYBHO7+O03Ww
 nCwA=
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

