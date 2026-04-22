Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70CC37FF7A
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876055; cv=none; b=Ys+16vvevJU8/BO56syeJ6SjD3kp/Fgmophqf1LCH9lJD1YVpXiB0TF2gkeQ06rBpgCaB/hkexBc/fJjToDZ56Fon3jdBQGz36Fygef0ZaWVkydQ7ZBF9+I6CCGADMx17RBFHOboMnq72guwY0vtrV7G+ytEw/OIrpe6cetk8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876055; c=relaxed/simple;
	bh=+qaBdb9rEAmToN4IiTNcZrtY6yqx3a4Lvoh95OjNc1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CpNZ6xDr/oKpjpcZz1k2azKKfAEc+V2uu8LXc70VGPBirFUtDBtTzN6RMt8DtF48eizCM7/zBvQK+hYBjMg5OFYjhqPgQwVcDXS+NX39j+hwa36awaJTWdY6lg1RpgZpYa87I3IsknzmMu1h0hNQcvpV+akrzBR8/aanUhRscQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okEk9lvA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okEk9lvA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEAEC2BCAF;
	Wed, 22 Apr 2026 16:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876054;
	bh=+qaBdb9rEAmToN4IiTNcZrtY6yqx3a4Lvoh95OjNc1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=okEk9lvAvdm5ya3P2aXggkhlyVa0giePddxOjBb1wYceizVcpX/uEfBkd7zwAmEzC
	 S87MTuE5JqGy0VvHKxz5VQKAYojwvA1+pW77Hl+c9qwizaTkB1IZMGdU/o8C+yNCcl
	 UXLEuHUYs1BqmCYuGzIRTxAE2dWEIzH8fLecCG6Ok1JjnbGtPHc/PlzMsnAU1o7JW1
	 AG9NWFjZ7Rk6v6mctWRhepxjhPhMN5obqy2KGJhNsmLaeGV9jdNZ8pfLr8HE674LxJ
	 1KGxCsUiMJgW3EjDbF2h5rJXoCrZmuAeooAyOYtniEK+ZmN4AhNP1el+Q0Y+rWqXvm
	 RWMgMr9C8UePg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Apr 2026 18:40:31 +0200
Subject: [PATCH mptcp-net v6 17/19] selftests: mptcp: join: validate 8x8
 subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-mptcp-inc-limits-v6-17-903181771530@kernel.org>
References: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
In-Reply-To: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+qaBdb9rEAmToN4IiTNcZrtY6yqx3a4Lvoh95OjNc1Y=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJf/GI/YFaTfYzh4+GzrbXr81R03hXvmm1Uohf09ZKC1
 7aK5HcBHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNZyMLIsGiBu+k9tV9yU9oX
 dbne2sd112V57fG1G0+G7DMXPxf9N5Xhn/U3Ub1qfhvtZfK/dp2TODkxuFbotYZa+oXTz7Q5Nm1
 +xAgA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The limits have been recently increased, it is required to validate that
having 64 subflows is allowed.

Here, both the client and the server have 8 network interfaces. The
server has 8 endpoints marked as 'signal' to announce all its v4
addresses. The client also has 8 endpoints, but marked as 'subflow' and
'fullmesh' in order to create 8 subflows to each address announced by
the server. This means 63 additional subflows will be created after the
initial one.

If it is not possible to increase the limits to 64, it means an older
kernel version is being used, and the test is skipped.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 28da9df797ae..c6bb345d056b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -513,6 +513,19 @@ reset_with_tcp_filter()
 	fi
 }
 
+# For kernel supporting limits above 8
+# $1: title ; $2,4: addrs limit ns1,2 ; $3,5: subflows limit ns1,2
+reset_with_high_limits()
+{
+	reset "${1}" || return 1
+
+	if ! pm_nl_set_limits "${ns1}" "${2}" "${3}" 2>/dev/null ||
+	   ! pm_nl_set_limits "${ns2}" "${4}" "${5}" 2>/dev/null; then
+		mark_as_skipped "unable to set the limits to ${*:2}"
+		return 1
+	fi
+}
+
 # $1: err msg
 fail_test()
 {
@@ -3670,6 +3683,21 @@ fullmesh_tests()
 		chk_prio_nr 0 1 1 0
 		chk_rm_nr 0 1
 	fi
+
+	# fullmesh in 8x8 to create 63 additional subflows
+	if ifaces_nr=8 reset_with_high_limits "fullmesh 8x8" 64 64 64 64; then
+		# higher chance to lose ADD_ADDR: allow retransmissions
+		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
+		local i
+		for i in $(seq 1 8); do
+			pm_nl_add_endpoint $ns2 10.0.$i.2 flags subflow,fullmesh
+			pm_nl_add_endpoint $ns1 10.0.$i.1 flags signal
+		done
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 63 63 63
+	fi
+
 }
 
 fastclose_tests()

-- 
2.53.0

