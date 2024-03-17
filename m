Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198B5ED9
	for <mptcp@lists.linux.dev>; Sun, 17 Mar 2024 00:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710637142; cv=none; b=WPBdGUqH7BDxbIuabnqT8ocHXWlBRJEqvzzgENQRj0bDQ1JUmfrOvRJRoiS7AATDyA1Ok9x0VaTE5u2gp0wkYwKJohIzV6Rm0PYx7VoWZOUteUndhUjtQD5AA6uizbixgtjQK5fjD+cEZ8wNuq0WO3Nie9V9LYyudVEH5DVlQfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710637142; c=relaxed/simple;
	bh=E82TAoXkFdOr7xgu7hdQz+jS4hTJv7AH6iljIQcAkHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jee4wBm0zX6by9yN5zRwsNtljBRcg0fU5TwGvT0XO/UUoirm+/s5QfiT/E/wz6Wln+grwHlNQ3/ED6VyaAT7v+9mnwV89+Dt+sEpxgYs4nQKx02v23aXSV+R6Bt7vVFK0UaAFJ8dVth0NyMQqVYoAX85HFfAtZac6zcEZh7L8i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9k7pb7+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9k7pb7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33F4C43390;
	Sun, 17 Mar 2024 00:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710637141;
	bh=E82TAoXkFdOr7xgu7hdQz+jS4hTJv7AH6iljIQcAkHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V9k7pb7+8M6nMnPNTafoz61stlvQr+KXFzr6VIu0A7PXjOt00BKgRW0Rsrc0mNRAP
	 uwYmBOFIiTosyalU+soYb9aY1Jz9RqDo4OSaZ+mjTTenQN0G+eEVwOg4Zl59utuGcv
	 YIElnYmTEo/sU/nfuPjvjrpBsB0zDHykiMyWacrJsxVH96jsObZ9StcLRDokZm3LCz
	 gNGgjEmkoH7WLOuPLiLTHI24ANcRik1vz70dCLcHBZxPD5+S/TUQ8RtM6l+QupX5Qm
	 mKy9/xocEVL/yJXvRiMsCa2nEXxEqpdeR9GJuXiNROBZzKPqsicNgJt1iXHO9USoM3
	 /FsMBkuLYVGdg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 04/12] selftests: mptcp: add get_limits helper
Date: Sun, 17 Mar 2024 08:58:03 +0800
Message-Id: <a5b75dce2b2fe8704ef40a5746a426a4bc1dd14b.1710636726.git.tanggeliang@kylinos.cn>
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

Just like set_limits() helper, this patch adds another one get_limits() to
show the limits.

Usage:
        Set limits - set_limits $ns $addrs $subflows
        Get limits - get_limits $ns

Use this new helper in pm_netlink.sh to replace all 'pm_nl_ctl limits'
commands.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 10 ++++++++++
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 10 +++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index c402cc994902..813d6406ccc3 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -532,3 +532,13 @@ mptcp_lib_format_limits() {
 		printf "accept %d\nsubflows %d\n" "${accept}" "${subflows}"
 	fi
 }
+
+mptcp_lib_pm_nl_get_limits() {
+	local ns=${1}
+
+	if mptcp_lib_is_ip_mptcp; then
+		ip -n "${ns}" mptcp limits
+	else
+		ip netns exec "${ns}" ./pm_nl_ctl limits
+	fi
+}
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 02c92edca8bb..87ea4973235d 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -69,9 +69,9 @@ check()
 
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
 
-default_limits="$(ip netns exec $ns1 ./pm_nl_ctl limits)"
+default_limits="$(mptcp_lib_pm_nl_get_limits "${ns1}")"
 if mptcp_lib_expect_all_features; then
-	check "ip netns exec $ns1 ./pm_nl_ctl limits" \
+	check "mptcp_lib_pm_nl_get_limits ${ns1}" \
 		"$(mptcp_lib_format_limits 0 2)" "defaults limits"
 fi
 
@@ -120,13 +120,13 @@ ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 9 1 2>/dev/null
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "rcv addrs above hard limit"
+check "mptcp_lib_pm_nl_get_limits ${ns1}" "${default_limits}" "rcv addrs above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 1 9 2>/dev/null
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
+check "mptcp_lib_pm_nl_get_limits ${ns1}" "${default_limits}" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
-check "ip netns exec $ns1 ./pm_nl_ctl limits" \
+check "mptcp_lib_pm_nl_get_limits ${ns1}" \
 	"$(mptcp_lib_format_limits 8 8)" "set limits"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
-- 
2.40.1

