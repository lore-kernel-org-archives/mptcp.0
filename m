Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F13D75C5
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089534; cv=none; b=KXqRT9HIAydo7ZYl1VmAcAlzRlW11x/OdXXQoEKRTIu8xGVAACOngP4Spf6OwMpErn/EHdlCRT1/QB3F0IVZdawn+3RBboIRmbt06GOsucdzuw6XzXMJw8gKO387sdjq+bqijpuSYPT8Zqrl2tUiFlDci4j3417TPYNOutv+c3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089534; c=relaxed/simple;
	bh=J/4TSLYnn4WswjEmdMv9hBM7YG3BsYv6rruqE5u/zDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oXtzFcBcSt/mjG4AyhxO29gKYC0dMAp+fk1TKg7ZAi+OqaL63GY/xPd5d06nepoNr1u61bxgwepY7ejCf5C0/IpfWBv7xeAYIplo72teIBxBSsPxFsW6K0FFHkPt5APLhGiVnacPQyg24XlbsG3PzWzPBG7v+4agU+le99ZlQSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sD/UAlkS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sD/UAlkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D75C2BCAF;
	Mon, 13 Apr 2026 14:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089534;
	bh=J/4TSLYnn4WswjEmdMv9hBM7YG3BsYv6rruqE5u/zDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sD/UAlkS1onf6Fo8fuItjgw3t44l+MIaNHSa5WnCGv7qHL2wxw64majyMPRoGMNmF
	 oNGUF28SnU1sxFgrE046s65ED2snLhgfPjlCZwYFcoR65SfyxrjCaRjbkpSzE5NfKt
	 aCY1K2RKrTs3TbpD+bLPaicmsj3HA3sbzd0Ghwq+AGVvNLnr8x/YcTrpPT9qSDrKUK
	 GYadTL+Q1qYTYs158ZooDLGhUSrV+r1VWG6uMvLOaUwYJSJsJ9AL5mGrV2K2A2oFKk
	 jnZGlj0qasKpNM4LD4I1Mq5g7Q+2IS8Cdg7ifzPOXZiO2KJvft2FAY5IrDUPSWPA9r
	 fIyfeL5n/U1NQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 13 Apr 2026 16:11:56 +0200
Subject: [PATCH mptcp-net v3 10/19] selftests: mptcp: pm: restrict
 'unknown' check to pm_nl_ctl
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-mptcp-inc-limits-v3-10-dd36c9360432@kernel.org>
References: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
In-Reply-To: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=J/4TSLYnn4WswjEmdMv9hBM7YG3BsYv6rruqE5u/zDQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLv/Fwn/ulE3C/uO+t3/Qtzern1XunnXs7FFby32hOsV
 R+y2+uYd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzEv4WR4YjsAz1moYAq1/81
 zt6qd9cuy5y98uXSz1O4hGb8iD97i5OR4ZIM+yNV+5rkYpWi2tdcM2rOyrTMF/h9/kuaUNKPU/c
 lmAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When pm_netlink.sh is executed with '-i', 'ip mptcp' is used instead of
'pm_nl_ctl'. IPRoute2 doesn't support the 'unknown' flag, which has only
been added to 'pm_nl_ctl' for this specific check: to ensure that the
kernel ignores such unsupported flag.

No reason to add this flag to 'ip mptcp'. Then, this check should be
skipped when 'ip mptcp' is used.

Fixes: 29f4801e9c8d ("selftests: mptcp: pm: ensure unknown flags are ignored")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 123d9d7a0278..d844ee687a29 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -192,9 +192,13 @@ check "show_endpoints" \
 flush_endpoint
 check "show_endpoints" "" "flush addrs"
 
-add_endpoint 10.0.1.1 flags unknown
-check "show_endpoints" "$(format_endpoints "1,10.0.1.1")" "ignore unknown flags"
-flush_endpoint
+# "unknown" flag is only supported by pm_nl_ctl
+if ! mptcp_lib_is_ip_mptcp; then
+	add_endpoint 10.0.1.1 flags unknown
+	check "show_endpoints" "$(format_endpoints "1,10.0.1.1")" \
+	      "ignore unknown flags"
+	flush_endpoint
+fi
 
 set_limits 9 1 2>/dev/null
 check "get_limits" "${default_limits}" "rcv addrs above hard limit"

-- 
2.53.0

