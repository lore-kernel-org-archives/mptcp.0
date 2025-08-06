Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6E338D
	for <mptcp@lists.linux.dev>; Wed,  6 Aug 2025 03:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754450266; cv=none; b=cVrIrhb4SPpeWOxgdMTNi45n0iitS83y16prW1aaXbssb66qFVWwKxXzmY6OOvMtHIUp3zmN6bXFyqUdHVMBuCRgK181+Zy2+bWGn2LURDuKglOTz0kbo9hKAy22/ZLeWXrnX6cxTYlck9SSMSmhp6mrwwZiHXia66tRKLTKuQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754450266; c=relaxed/simple;
	bh=rNeKOBloX0+u0nLEaPssQWu3Y8SM9sXyE1RTeqyV/EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nj463ffjmkGwMDUGqN5Nu1nv+QmIClCg5PZvQia0HYbkfZdG96AkB4r/TGiCAta0RY0ARXqoH4lDMRoSfbDJaQhVoMod55IwhTsI0oRfse0ieU24CrcFD+/riy0967LDYhxzSvcqel+sAkAfEgtH+rJXBwYqKAYIRaISer3bwYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZL1nQAaz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZL1nQAaz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0653EC4CEF0;
	Wed,  6 Aug 2025 03:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754450266;
	bh=rNeKOBloX0+u0nLEaPssQWu3Y8SM9sXyE1RTeqyV/EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZL1nQAazNv0ww4rcDyvdV/i6mTO2lcyZ2rQL6lwS+AJQ1guHCgA4Xu44fyieqHFOn
	 ItN6EGJaQJiObk6hp4r69u9ke1jC5PJvZ/CY1V6rBgMD3gtH8N8HmeueFiDMn8y6Jf
	 JtKK9PIR1a15HGt143s7xK5es5zSrCPCD8d1CQTkBBgSfmBXCJIiMoY/2QhrFWN1EF
	 16m8hc+s+E2GMT19tTh2e2nUZZ2cB8tB1zpdCdXccpZOMbEPz9jdslD7DpYahQ+8Ld
	 c1l9ej5MJY/OJS71xIB8WvzfY6P9pDBZH0fvtlO7ffDqiZIqdl2fZXBSMtwioJgBYp
	 cs5GXgxXvmUew==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/3] selftests: mptcp: remove add_addr_timeout settings
Date: Wed,  6 Aug 2025 11:17:36 +0800
Message-ID: <0854497e0779fc311f91c42018c55e849c89d322.1754449947.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754449947.git.tanggeliang@kylinos.cn>
References: <cover.1754449947.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now that add_addr_timeout can be dynamically adjusted, there is no need
to set specific timeout values in the mptcp_join.sh tests. This patch
removes the explicit sysctl settings for net.mptcp.add_addr_timeout
from the test scripts.

The change simplifies the test setup and ensures the tests work with
the default or dynamically adjusted timeout values.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 82cae37d9c20..e85bb62046e0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -347,8 +347,6 @@ reset_with_add_addr_timeout()
 		tables="${ip6tables}"
 	fi
 
-	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-
 	if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
 			-m tcp --tcp-option 30 \
 			-m bpf --bytecode \
@@ -2183,7 +2181,6 @@ signal_address_tests()
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags signal
 
 		# the peer could possibly miss some addr notification, allow retransmission
-		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 
-- 
2.48.1

