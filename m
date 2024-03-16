Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F324046BA
	for <mptcp@lists.linux.dev>; Sat, 16 Mar 2024 03:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710561094; cv=none; b=HkrbuvV5+ziimvLr9oDKWQYlDdoc3f9fpFO+zB85EsEbUybOWuI8dAnlzqORNxJyZv5hfNkqwqxxNjGhviEGgQ4foI0XKeNCxCUsPy3QQsO14c3ETgwUhD8f1i79c6azzEEVEVLnjCmcd0B+PT9QS7FbW0IxsWg3QIbyc9gn54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710561094; c=relaxed/simple;
	bh=b3rf+yPorr3T3Gg+1rDvWENMr5LdDfZfwBPJy5Qzk+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QQv6fRWFE1k9UkjOReijw5MVDKt94RbPe3oAY0TNjFBzs4SZFdcuAMDpir/0sPKKs50VLfFQlnwdpzo1S9CvzY1uwchIHAYsc24fTCHjz7t5OGE8X7DgtUTrUx7SxZk6Ca2cYDNHM8sGGXCKVO4Ux3q4fRuALHCqgCKhLadfp2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wu5zhg7h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wu5zhg7h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EC3C43390;
	Sat, 16 Mar 2024 03:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710561093;
	bh=b3rf+yPorr3T3Gg+1rDvWENMr5LdDfZfwBPJy5Qzk+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wu5zhg7h4bY/K/MOXCffOuXUySjSwdLid+bSNHAsH2kvgzgL+uwmWYM7CoFxxcPd3
	 nRNPiCZRLiX7vRphroXuffdJ3F0EFLj5OffOJK7njjjyJbazdHaBh8K6Dgjh0CCh+b
	 3v2ziW50LoHY8UvGoHaCGzEU3ABhFmLO+6xHoL3qbbjx0jcZrSC6UgggU3q1s+An2K
	 SICf60dxOPhRVERgkGdvmGoAW6C/jyb7idCckvVP9hixC03Xbh6+gXPNLduYOu5iL2
	 zTVlIrdqLVYD2nlsJ8nGUKguKkiYHXJCoBJD1qxRkqCpsLOnFc5BCJAaIY2zkPq48+
	 m2o669boKWMNw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 5/9] selftests: mptcp: add change_address helper
Date: Sat, 16 Mar 2024 11:50:33 +0800
Message-Id: <f8a225e013c7e47b8afb6077f5aa2bef28cbedb9.1710560839.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710560839.git.tanggeliang@kylinos.cn>
References: <cover.1710560839.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The address that needs to change flags can only be identified by an address
ID in change_endpoint() helper. This patch adds another changing flags
helper named change_address() to support for passing an IP address directly
to it.

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
index 86b8ad092611..9ba37d12d960 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -576,3 +576,16 @@ mptcp_lib_pm_nl_get_endpoint() {
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
index d349cfb8834f..2e889fbd7fcd 100755
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

