Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E719A271A94
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173665; cv=none; b=bdSPQegOTsoHzNhWMWsC/zK7HdBeENZ+QkBLeyPuDnWBoGYed3pfkisCrphPkENWfKy9NAbjfa+u+F574QcEMhU50WYZwf5v1qm+xnZ3PszGdbXdGkTsfDZyIloL/Etk911myjHbL01fMAbk93O0BynHMbMoS+CqMnHBK4k4jWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173665; c=relaxed/simple;
	bh=+qaBdb9rEAmToN4IiTNcZrtY6yqx3a4Lvoh95OjNc1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KqqFS1RhEdi6rWY1qjTRfCJ6IkxOonjk+HDLTCqow1ZbY1B825uPLaEzWeAcDZrUpWnpYY14jJx/hRUlr2B4kSLotU2HLaaFEirZsRwSdaHTxdXFOyjo6qYGUqCGlcl0vb4PpLzxs1j43fWkIY7yLzA9vRWNHRjuCFAUO+BCc4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBMe/hLP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBMe/hLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B515C4AF09;
	Tue, 14 Apr 2026 13:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173664;
	bh=+qaBdb9rEAmToN4IiTNcZrtY6yqx3a4Lvoh95OjNc1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OBMe/hLP5prT99yd3Xg1iYDtqg6Bjx6Ez36a6H7nhKQ4o0Y7FkIzmdD8iO0KA0KaH
	 vPm5EmibYRXX0j+OpErGOWE7Rf6v5Yi9nwdN9SWOA6471Eft2dv1yZUIOYwIOz6YYn
	 IU2N/oZvyhKOCxAwVRxhI43guI0ea9Kt4/F4CDvD33q83wb95Ig+Qf/oViuweMkzWJ
	 Weu4WLKunIpusykY5l0Q0IrMYewqXdhsf7TzBApoUL/xD7Q6N3Mn7uurNd77bH3KiL
	 yOtQIfNBffJTTaDYYTgo39+hmzyy87E8BFOekaPDZ54kLuOGCrTC4s6ZjNyozY6wrp
	 rXIbF/GN/ep9w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Apr 2026 15:34:10 +0200
Subject: [PATCH mptcp-net v4 17/20] selftests: mptcp: join: validate 8x8
 subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-mptcp-inc-limits-v4-17-78274edda5dd@kernel.org>
References: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
In-Reply-To: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+qaBdb9rEAmToN4IiTNcZrtY6yqx3a4Lvoh95OjNc1Y=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvOQVGPfz86bO+2sWyDf/TZbh0a9Lsdswzj5Pdahvx6
 W8z95OsjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImIFTIynGVR/xF649E+rQnT
 Xd/8k/i0+eDj1FcLviQ0bzl2a5Zj43KGv5KuDvOF922OazgsOCHt2hyD54Y7vmp4fys89eRLFfO
 LTdwA
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

