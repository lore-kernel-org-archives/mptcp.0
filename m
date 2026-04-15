Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB4033C536
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247104; cv=none; b=rhVGz/68TyRnT2QC1aeR/aVRYZdxSt/Ykp7k0M+Ihenn/p7HU98OXuc7gtOVpPO3IXHPN28X6TgiI7jlsvQ7TO3Z6IqUWvZshHgt7OjbXcSQh8p8Jm8H9xn0MmBIrMZN/K23W/Spfh6Wu8ukx3m8sy3QIoe8LMSQWMI6FTSx5H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247104; c=relaxed/simple;
	bh=mtYmu9sEERHRNO5FZypyYhLnpdu99tZBV46KyJVl00o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EAnvE6yi4N1/zwL26dTiZEgvriPffNI0CnxjA7aZZ3Qvdyppl3lFVVg/upSG1FFqp5JWagO8g2YG2tIy/3tCqJn/EtGXeBoDBWknfDh2DkQU/FnI3wmhLDO7xywlIHPjXHf39hIS3DUBkKZ7tLa/uIHBI9JuOiXXUFAJmRPJ9+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoNy34Cx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoNy34Cx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FD1C19424;
	Wed, 15 Apr 2026 09:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247104;
	bh=mtYmu9sEERHRNO5FZypyYhLnpdu99tZBV46KyJVl00o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XoNy34Cx5ffSfOGFQRByjHqlPfcQWiDS9P6Xjn50b0MtmcDgHuf8K1sP7ZrkL9JiG
	 gkXocVVPR25rUtUbkRXVWJeQymEC4D/hV9UF6kZe7bkk8ohRFjhsN7CgaGVInUFXjV
	 o+uAScIPXmKiwN5srGscAna6sBpCp/N3bpsUP3tXzzG0p1StrqbTG0VjLfJiZekynB
	 4CdSVgKVA1j1tLjW76jOEhrmXZsb5/D2/CIhRqye1ys+YNo2/2BEbuieFWTmdViu/c
	 92O2ZWQ+PXFuL2UorT+4B5wBN8gBk4CVx3V6kbeuFSdaeob8r2vKwqCo59NiWvJ2f/
	 MWGNz1rhdvjKA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 15 Apr 2026 11:57:06 +0200
Subject: [PATCH mptcp-net v5 18/20] selftests: mptcp: pm: validate new
 limits
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-mptcp-inc-limits-v5-18-e54c3bf80e4e@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
In-Reply-To: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3803; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mtYmu9sEERHRNO5FZypyYhLnpdu99tZBV46KyJVl00o=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvJxp4GtYu9OXcaPiYpej03a+cjXpuIss7Uvrco7c/n
 Ht1wX6ZjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkIf2f47/NUo+a09aJm/6X7
 7k0R9Y4qCS88l/nsR+CM1sboafILbzP801AKvdMRKJ2nmWp76r3gFiGurvXT1eTXhbEt11y+fvU
 mLgA=
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
index 04594dfc22b1..21bfe1311f11 100755
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
-check "get_endpoint 10" "" "above hard addr limit" 1
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

