Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404DCDDC9
	for <mptcp@lists.linux.dev>; Sun, 25 Feb 2024 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708852409; cv=none; b=N9nWLKyTPW5r7uD2TcOWNgSnPAUq32VW31iKT7Z9DO64kGmUrbwPl5cA2ncL9lN1EzyHtsZCZk++Uz+YA3FwT06pY9O6ZVwrtgJbWfGCA8RWRQmivBpAblmhVGqd4RZEGRL/T/LuI7JvQGGL6H1g8VFwxiF5CbytIpcsghLONfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708852409; c=relaxed/simple;
	bh=YCRuwPv2m6CeZPP+NG6N29G4rt/80odeq0ZRthN18Do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QRaVluwGPAX/FlJCqkulONg2yexnKVtF2mQklylTq4hNaL9+ahFJE4ph58yVjEtchau2BQDX7b91hZ+jKIWZgbznUwKUdcxjXuvjdEWpFBsgFdlO2NEmchVu7zTIAn2SHBm5n2+NRHj3S82qBBoAfsBfak1O8cBQ9DwRg/12slM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNkkbBS1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNkkbBS1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F79C433C7;
	Sun, 25 Feb 2024 09:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708852409;
	bh=YCRuwPv2m6CeZPP+NG6N29G4rt/80odeq0ZRthN18Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BNkkbBS1TNklx/+k+ELPWlktsgairVIW9yo3dEi53jMHMNmmfbI7ufEdeh475PSCH
	 HHEIPFqXd86nxmqLi659wxu7w4rNxoZuvM88vIt3/HieSTVnoqrrcDc0Ruzoo5RYb6
	 x7vJmLdY3tN5kbCIsvao4ClpO+4GJWQPyQYIGH03ZO0HgCt9ubsMOMp1KDWn2YWs0k
	 wnxkRVJfu1gvZ/cPvzwEI3nhFGlmxJnb8OPcyZ0kX7D7M8528dKVhv9zFbvM0Xumgw
	 6n+iY6ulaaIJxP7XLH1AlbJOfR5xjR7L7dMLj7IN4H3KzJIkYRFK5zDTvX/GCrNBs3
	 NoQxspZXBMqqQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 06/13] selftests: mptcp: connect: print out ping tests info
Date: Sun, 25 Feb 2024 17:12:27 +0800
Message-Id: <77c1b641cefdf9832b96759e2544e41330161a7c.1708852208.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708852208.git.tanggeliang@kylinos.cn>
References: <cover.1708852208.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

'ping tests' shows in the test results of mptcp_connect.sh:

1..68
ok 1 - mptcp_connect: New MPTCP socket can be blocked via sysctl
ok 2 - mptcp_connect: ping tests
ok 3 - mptcp_connect: loopback v4: ns1 MPTCP -> ns1 (10.0.1.1:10000) MPTCP
ok 4 - mptcp_connect: loopback v4: ns1 MPTCP -> ns1 (10.0.1.1:10001) TCP

But not in the test output of this script:

New MPTCP socket can be blocked via sysctl			   [ OK ]
INFO: validating network environment with pings
INFO: Using loss of 0.01% delay 30 ms reorder 94% 9% with delay 7ms on
ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP	(duration    79ms) [ OK ]
ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP  	(duration    49ms) [ OK ]

This patch fixes this by adding ping tests in test output.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 68073b255983..06e945914ace 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -861,6 +861,9 @@ mptcp_lib_result_code "${ret}" "ping tests"
 
 stop_if_error "Could not even run ping tests"
 
+echo -e "ping tests"
+mptcp_lib_print_ok "\t\t\t\t\t\t\t\t   [ OK ]"
+
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
 echo -n "INFO: Using loss of $tc_loss "
 test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
-- 
2.40.1

