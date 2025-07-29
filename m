Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DF8275AFE
	for <mptcp@lists.linux.dev>; Tue, 29 Jul 2025 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777366; cv=none; b=um+t8mIQLsG8pwmVosT9D9Ex/SVxZZioadEK366kGH1HJdS+yxnPzbGphDF/uxno2axlgT5+TSPvLbRDG+WUQSS7ib8OXAiLb5hRmq9RXBg94mXEM5UmtrjPaYzzwE6lVFj80vuXN6FTorPm8MPo3eqLtT9pDDxthSt4Octb0gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777366; c=relaxed/simple;
	bh=6oW+0A/uAO7NsCyzcDFGyC2ob2sXRVzK4f0lgzQyeZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awSnVvJKpiXPLlX3RaZ9b7hkyAYNpCfnok0FYRf+QOb6y+k9sszz8pk2Rev+m6fLAWaTWRc7AzaFv2vHQibnPXFm1SP4D2UJIv598GK3BSP4F5mcpBCqHnL5fK9HoNZjO28xvvircg7YTRnoOD540dxR1JjwKwiQ+tM1mjYO1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWusjyAM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWusjyAM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B273C4CEF9;
	Tue, 29 Jul 2025 08:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753777366;
	bh=6oW+0A/uAO7NsCyzcDFGyC2ob2sXRVzK4f0lgzQyeZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fWusjyAMCAKTRXpJLF2PmcdodnadPhW16jnzm0VI6UDWTE2oSUWTpMtdaCgqTJjq+
	 szWeBg/bNk+Fu+EzTL2f71PATG3Q6Dz7ESndM09ubbLn/vcBnlvpdmiAXZPf+WO3Pj
	 dgwIL6XpnIbPcsIBwNVhiXYiAewL+OuwD/HzDFPKymYXjT7nUML2WMIktL0dLHiMG4
	 efyIIdBc2FqMmg0zmLo3QSMhkwH+/aNzUj+a/UmTEco6dHld6H5GO75VlXhiirqNaj
	 cqWY4nbq5VaT7COg7PrLVNol6coFUtBDrQYN8DLq1jSxKC/SdZ2tEK/stJOqgCK+FO
	 XsZB7kYaRn2ZA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/3] selftests: mptcp: update for add_addr_timeout_max rename
Date: Tue, 29 Jul 2025 16:22:33 +0800
Message-ID: <3b138f3ba5f4aaa354a5df678218b47cd7aace8a.1753777199.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1753777199.git.tanggeliang@kylinos.cn>
References: <cover.1753777199.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update MPTCP selftests to use the renamed sysctl variable
add_addr_timeout_max. This aligns tests with the kernel change.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b8af65373b3a..fec9dda192be 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -347,7 +347,7 @@ reset_with_add_addr_timeout()
 		tables="${ip6tables}"
 	fi
 
-	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
+	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout_max=1
 
 	if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
 			-m tcp --tcp-option 30 \
@@ -1556,7 +1556,7 @@ chk_add_nr()
 		rx=" server"
 	fi
 
-	timeout=$(ip netns exec ${ns_tx} sysctl -n net.mptcp.add_addr_timeout)
+	timeout=$(ip netns exec ${ns_tx} sysctl -n net.mptcp.add_addr_timeout_max)
 
 	print_check "add addr rx${rx}"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtAddAddr")
@@ -1655,7 +1655,7 @@ chk_add_tx_nr()
 	local timeout
 	local count
 
-	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
+	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout_max)
 
 	print_check "add addr tx"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTx")
@@ -2183,7 +2183,7 @@ signal_address_tests()
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags signal
 
 		# the peer could possibly miss some addr notification, allow retransmission
-		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
+		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout_max=1
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 
-- 
2.48.1

