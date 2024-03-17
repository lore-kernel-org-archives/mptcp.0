Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B15C7F6
	for <mptcp@lists.linux.dev>; Sun, 17 Mar 2024 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710637147; cv=none; b=BafJKbmZ37TrOQx5GCwVhOzAZCY8++iJV2i1tvafv65siDBPWdIQ0LgRp+U3p7Imr31Qev1h3pNAIhcU5FIvAgaCJAFNXNlbjKpb+y80iaGqK9lGnRnj6I7sErrYqA8xPp1AXNC1OCBctkueCz1kh/CjvwSCE/qx2C1yUI+4C90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710637147; c=relaxed/simple;
	bh=iBuE5PFHAhempNLhZElySC3uCzFVcmKs85JSCMnT5Fc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZZjo1cv217RwPeIbIIFVJXhl0xfilkYqf9qDakcOjF3TaOazmxrwC+t0ECwd0YxGQXxUah11ElEHdQ7Bc4tkjmmSdqUkoJad9K+2LIcmfmrMHRTaXM9x67JgZaT62dxNH9SbZ8jQnATV2893aJmJTiMt9NQy6g98REUJWCRhMX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1k6tatO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1k6tatO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407BFC433C7;
	Sun, 17 Mar 2024 00:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710637147;
	bh=iBuE5PFHAhempNLhZElySC3uCzFVcmKs85JSCMnT5Fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P1k6tatOeJQq1+i/raTv2Cjs9psbN57wwnov5CRgpHaWkQhU+X7dt9tmI5tDI9n4R
	 Lv7J9LuXzRYHctAFhit0oyu69ddYHo39+U8uS/JG/9kCr5aVpfkdIGFpvDp0OqM/pJ
	 TFVFV5XnJ/Ki4DG+L6bqndZ5fYKnc/10HdLtPAPTPZEqX2sJz5+liK1pFLlf83PQ36
	 g1hRiqWsVWz0aeHOxq4AeZqUv14sno/5PITbS3fWthlCi4MeqdGWJilx8KfkzbQMAq
	 fJwIEnJv6G0nzB/vjgtAJ7j39/1PL0T2JrYQ5TmWY08vBp3Gi35IgxxsQStTpTw2+A
	 JNkiLtUKitp0Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 08/12] selftests: mptcp: add change_address helper
Date: Sun, 17 Mar 2024 08:58:07 +0800
Message-Id: <565780415a0be17de9118113b586cd49f841265a.1710636726.git.tanggeliang@kylinos.cn>
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

The address that needs to change flags can only be identified by an address
ID in change_endpoint() helper. This patch adds another helper named
change_address(), its 2nd parameter is an IP address.

Usage:
	Address ID - change_endpoint $ns id $id $flags
	IP address - change_address $ns $addr $flags

Use this new helper in pm_netlink.sh to replace all 'pm_nl_ctl set'
commands.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 13 +++++++++++++
 tools/testing/selftests/net/mptcp/pm_netlink.sh |  4 ++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index d83a67922b17..e26ef67e4ef1 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -588,3 +588,16 @@ mptcp_lib_pm_nl_get_endpoint() {
                ip netns exec "${ns}" ./pm_nl_ctl get "${id}"
        fi
 }
+
+mptcp_lib_pm_nl_change_address() {
+	local ns=${1}
+	local addr=${2}
+	local flags=${3}
+
+	if mptcp_lib_is_ip_mptcp; then
+		# shellcheck disable=SC2086 # blanks in flags, no double quote
+		ip -n "${ns}" mptcp endpoint change "${addr}" ${flags//","/" "}
+	else
+		ip netns exec "${ns}" ./pm_nl_ctl set "${addr}" flags "${flags}"
+	fi
+}
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 28c89b576d1f..a42490885d88 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -178,11 +178,11 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
-ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags backup
+mptcp_lib_pm_nl_change_address "${ns1}" 10.0.1.1 backup
 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 	"$(mptcp_lib_format_endpoints "1,10.0.1.1,subflow backup")" \
 	"set flags (backup)"
-ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
+mptcp_lib_pm_nl_change_address "${ns1}" 10.0.1.1 nobackup
 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 	"$(mptcp_lib_format_endpoints "1,10.0.1.1,subflow")" \
 	"          (nobackup)"
-- 
2.40.1

