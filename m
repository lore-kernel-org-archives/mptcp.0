Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E933F8C3
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247103; cv=none; b=ZUbYLZd3x/p2g07AEiaXrdh4JuKXJAj8MKAG5fbnPLWDbs7xAxYi4Jb+72HwH/54H1vY1rCMPbn6jmFvgj1UiUHK21nIaXKSJg0OpzWhHEAakK/9T7XEICO0FNJF5FRTtRf8DIPRb4WOH679dfgNVrL3Hvl3NdNDI9CqtaazwFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247103; c=relaxed/simple;
	bh=+qaBdb9rEAmToN4IiTNcZrtY6yqx3a4Lvoh95OjNc1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MZduz/PTrtw1/YMBK0hTpkvwnZO0SsxHT+20z/pKgos0hlwAvmhaTGl6v8KY+b1fpZwZHt6THX06uTWoqIUseBBjnAVZ1wis4NvCjd2cE3IxL20OR3n/nq+sl/DDJNBmiDIqgN8OOtq4u1vzUKufwrzJ4fhn/6vUmk2pUvU+ypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ba36bNnV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba36bNnV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8A0C19424;
	Wed, 15 Apr 2026 09:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247103;
	bh=+qaBdb9rEAmToN4IiTNcZrtY6yqx3a4Lvoh95OjNc1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ba36bNnV1t5wTp691n+TdrRNkk3/OULbhB6ec5eocsNuBntQlGzeJlevhnKP3Dwg3
	 0OftnWa3czmJJvT3HoaEDpGW9skw2wpFxMLNdTOaUgP/3XyAMclH21M4KgzmL5C8f9
	 fAtJO5IPvkPhS6iv+ehJM/cl3/Lb+RDd7W2XgITGpiIKiFuo/ONiFap7qRXAC1QFAF
	 FRsX3e8UvClgC/TSp/IVelruL+AuEAg7p1q2Bt9NZj6jVE43CsrKkvbA1Tny7CfuA1
	 VE3pfDAUUmvn+53xmRAGqqBfDm7cqhg66gfPM2jZjWzXH210STdiHLPEm7pYF5QAUR
	 xez5TrApPJh8A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 15 Apr 2026 11:57:05 +0200
Subject: [PATCH mptcp-net v5 17/20] selftests: mptcp: join: validate 8x8
 subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-mptcp-inc-limits-v5-17-e54c3bf80e4e@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
In-Reply-To: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+qaBdb9rEAmToN4IiTNcZrtY6yqx3a4Lvoh95OjNc1Y=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvJ+rL/GmSvuneUx37puHrB0ZX1oNe+sd3PXYLjN3z1
 2TBvy8TO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbyx4rhr1zHv5JfDs3X56Rc
 +ns9X+nvzBtboqq3tuXcK63WefIrtZaR4QS/QQPz87S5wZvCT+bt3f5CsNindRHvtYBDs9YliCp
 G8gMA
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

