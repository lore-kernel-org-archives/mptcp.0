Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98F2139B
	for <mptcp@lists.linux.dev>; Sun, 17 Mar 2024 00:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710637140; cv=none; b=mrG7sUtrsKLoVrG/nI8CoG67ing36GZcjpfGnTVoua9paZHwSJqZNJ8rNnxtzy2H1n6K/cRhTtVfSLEXrzBXV8WvEsBlYLGlaMyaDT/AygoOinrEG97SXF+3GNd9d7b9awn80QisnO5vrGnVHDr9/8P4v5qQ2HMyUwbWdvaf1Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710637140; c=relaxed/simple;
	bh=HSrhdxluEY7sRvtdGo8QklFew/k/IlLrdmPfYDgAy/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BaEAbVAB7mW/10Grw6ZI2yY/eyNyE5NnAB6vVPqwO7vvleQmImMli46NIIlS4Ja3FoDupPPlfZ+pk7Z/rR/a1TuAM8PfTuqHRGnnzmL/KwS90ajmD+9XaevAv8L8nNOetJ8rmu8KQSOrZiAcvvdc3ErscTvkg+WkKSI+cHg/oWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnFRRB+o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnFRRB+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92359C433C7;
	Sun, 17 Mar 2024 00:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710637140;
	bh=HSrhdxluEY7sRvtdGo8QklFew/k/IlLrdmPfYDgAy/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WnFRRB+oj3ZJac545uKT+ZDqrfvNoFZ+c3aRrsq3aLt5BZmwva5TlEvLs6kEi+bP8
	 F4xuIyICM1Cktbf3yvjUIYM70Mt5r2LSpArDPNoffZCHYh5oRlbQrtNgr2muYB9+YD
	 hHLf53LB/mnh5+lx/gXKf0DzTFRD3l+cOTDE01/0d+Uf9WdW675yW9zz7polkqkJPD
	 Cx/vjsgeN1PPGE47Y2K7mVnigEHBB4QBTfSYMTIQS5m38QEzPIO6ZULNeO6hCJ8uKR
	 NwwMb77i+mgnGoe7aUHP2GcJ8FFecF+pWnOAAz2ofvZuUmBUfmRhA5qLRi+CPX92yH
	 AuvM6jqsidf+g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 03/12] selftests: mptcp: format limits outputs
Date: Sun, 17 Mar 2024 08:58:02 +0800
Message-Id: <e68af806417bea0a05ea4a9bd702a14024919420.1710636726.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710636726.git.tanggeliang@kylinos.cn>
References: <cover.1710636726.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The output format of 'ip mptcp limits' command is much different from
that of 'pm_nl_ctl limits' command. This patch adds format_limits()
helper to format the outputs of these two commands to hide the
difference.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 12 ++++++++++++
 tools/testing/selftests/net/mptcp/pm_netlink.sh |  8 ++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index ca01d949fad8..c402cc994902 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -520,3 +520,15 @@ mptcp_lib_set_ip_mptcp() {
 mptcp_lib_is_ip_mptcp() {
 	[ "${MPTCP_LIB_IP_MPTCP}" = "1" ]
 }
+
+mptcp_lib_format_limits() {
+	local accept="${1}"
+	local subflows="${2}"
+
+	if mptcp_lib_is_ip_mptcp; then
+		# with a space at the end
+		printf "add_addr_accepted %d subflows %d \n" "${accept}" "${subflows}"
+	else
+		printf "accept %d\nsubflows %d\n" "${accept}" "${subflows}"
+	fi
+}
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 6ab8c5d36340..02c92edca8bb 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -71,8 +71,8 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
 
 default_limits="$(ip netns exec $ns1 ./pm_nl_ctl limits)"
 if mptcp_lib_expect_all_features; then
-	check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 2" "defaults limits"
+	check "ip netns exec $ns1 ./pm_nl_ctl limits" \
+		"$(mptcp_lib_format_limits 0 2)" "defaults limits"
 fi
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
@@ -126,8 +126,8 @@ ip netns exec $ns1 ./pm_nl_ctl limits 1 9 2>/dev/null
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
-subflows 8" "set limits"
+check "ip netns exec $ns1 ./pm_nl_ctl limits" \
+	"$(mptcp_lib_format_limits 8 8)" "set limits"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
-- 
2.40.1

