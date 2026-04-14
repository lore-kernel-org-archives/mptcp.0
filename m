Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532432D0C98
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173660; cv=none; b=L3X1GxioKG11YNcvnt6lC8LdPefj97y3X9NWg1c2FTNRCbT/LKh04JHtk3jsQtEuhYUAZQm67jOgDxwINyCeuPrj83myKDWq3En9/oRrQUG4TLODwN8eT0Mp6E+QxkI1zE7jPVhtVYQ944jdnClGI7yi7P1Ieh8sDXhdTBuK9dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173660; c=relaxed/simple;
	bh=xMzQEjABCnRo26AFJgkK2crYNoG1BurehXmPvedR64o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IyJTaNn0aOysHNk5gpIx9C/JWyefPZJi7cXgG6SWW+wO2BROo0CqPiX8KFyRRAPhlWMEL8QBS1r6tfdwv7B7fZ7D3hJuYi9k4ZA/L271+jtVrjfsR6tT2t5ROW2XQ5ibeB71u69q/QmbgxAxgmXYUjr1uKUy2hCEzoBUeReSkkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5Bolid2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5Bolid2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC93C2BCB6;
	Tue, 14 Apr 2026 13:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173660;
	bh=xMzQEjABCnRo26AFJgkK2crYNoG1BurehXmPvedR64o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g5Bolid2Y0ijclAtcT3jrpdc8THumhyPc97od47U4jlcMi8c5esVLtEjBcpNEoWMw
	 YpBxFxQZvJq9WMJI4nivMrYKl5K+f0NsIiZUsqPjN1aDcPF83lmxdaOhHUmz8vDrs9
	 l5LZhiY9KEoCguGqmpHJSgXHIi4qMMljrCsbhBQIADDh0IsGwRRDc5WkOIi/UfmOUX
	 EkwtYgtRETwT7UkvtQhVlJ7nClcMH7fA8wpbQdYPbCaPS7iV1idKaFu4DWBdHpkJvV
	 o9tM2nM2271x5AjOmDJV8Wd5rS6ilK/jnpA86WS9wixrs0hOyWavg0tftpWVoyT+VS
	 NZDoorS0s/5Bg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Apr 2026 15:34:04 +0200
Subject: [PATCH mptcp-net v4 11/20] selftests: mptcp: pm: restrict
 'unknown' check to pm_nl_ctl
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-mptcp-inc-limits-v4-11-78274edda5dd@kernel.org>
References: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
In-Reply-To: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xMzQEjABCnRo26AFJgkK2crYNoG1BurehXmPvedR64o=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvOfmV7mExXujxVHpG+ONdW/bqNOiZmTx4d2+Nw+rev
 R5vp5UydpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzESp/hn2npvjXqxYILfrWt
 6rD0uaNtK//Fs6mq+P/im1scct6WJzD807/HN3FxUIKI88T4LTnrRf/13Fy871zOAw3T7BmMrg/
 fcAEA
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
index 26ff4c360a77..cb1d3cfc1104 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -194,9 +194,13 @@ check "show_endpoints" \
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

