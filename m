Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619FA289802
	for <mptcp@lists.linux.dev>; Wed,  8 Oct 2025 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932020; cv=none; b=PRKWqr1zy8PbwbXeScQOh59aPicu0l6ZqBBaOMQ6WsWYxDivM/24fDwwfrr9UFnITkPTJJfEbogMu3StVqwUy/h3T/mEVnTvnhhY9Jd479pKG/giz8CTZgprLf4tY6nTOEyBgekkH1qyTlVo72iiKPN0nzxq0j5L4vSKOQdQQVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932020; c=relaxed/simple;
	bh=i0niSexjfKRpHp1EY2h6QILI+WGKpGybqaGEebr5uc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TIYYdnUW3/lKc0V/ygr5aEX2IHbmQQ00QW/bimXLImjRmqnvtHFD8t5DhAWkAEaH5nrHtQcqUKfgFqLYqkB43j+XWrzHjAohprP4/nDFDAZd23175hNpCZxC5zL0hdn2waYsdE6+DcyzXRzYoS3W1r525gaxbAK7yocdrQ+a9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCI2+R6U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCI2+R6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78052C4CEF5;
	Wed,  8 Oct 2025 14:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759932019;
	bh=i0niSexjfKRpHp1EY2h6QILI+WGKpGybqaGEebr5uc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bCI2+R6UIkDxsyCGfKVaaE8o6CVXb1zgTFdXkU/oQDV/1oS7LdRnkX+BxrW3Vmuzm
	 9CmfgruuB5/wUphPpFF/BccugmqlS1iM5Lie7oq5PAZJoZ8eGIQxWrv5bCJBV93RTV
	 htFmZzCyZPnCww1648UcrTrQpw2rWp3N8qL0E0OhVOFSZQaNoUufl2/LG25S0J3gc9
	 EtFDc6hf01EIFlwE+O3Yb0K3OMjJvPGueRita6l9oONsnOiEvcCrpSg4idrFc7Y6vD
	 7DBbbi18CnHFqNneEYcNrrjlIA0a7SQRBNLMgt2bpYMjgzof79E2HQId+Shxytbw0y
	 qNsRwgt6WM3Tw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Oct 2025 15:59:59 +0200
Subject: [PATCH mptcp-net 5/7] selftests: mptcp: join: mark laminar tests
 as skipped if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-c-flag-add-addr-delay-v1-5-c624eb3bf10d@kernel.org>
References: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
In-Reply-To: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2902; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=i0niSexjfKRpHp1EY2h6QILI+WGKpGybqaGEebr5uc4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKe5eU8SnDcm9d3OnGPVK324VDjvZIrCkUc71puz5D0L
 LGO+n+qo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCLztBgZGllnfnu4ndtsxRKJ
 pr5Nk0Tdolbf18peGz2/IF0vIVKFmeF/2c2csOjDarrK00u2VnZ8XXhhVeaVuOhvKU+XJzJqGZW
 yAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The call to 'continue_if' was missing: it properly marks a subtest as
'skipped' if the attached condition is not valid.

Without that, the test is wrongly marked as passed on older kernels.

Fixes: c912f935a5c7 ("selftests: mptcp: join: validate new laminar endp")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b2a8c51a3969..78a1aa4ecff2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2324,7 +2324,7 @@ laminar_endp_tests()
 {
 	# no laminar endpoints: routing rules are used
 	if reset_with_tcp_filter "without a laminar endpoint" ns1 10.0.2.2 REJECT &&
-	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -2336,7 +2336,7 @@ laminar_endp_tests()
 
 	# laminar endpoints: this endpoint is used
 	if reset_with_tcp_filter "with a laminar endpoint" ns1 10.0.2.2 REJECT &&
-	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -2348,7 +2348,7 @@ laminar_endp_tests()
 
 	# laminar endpoints: these endpoints are used
 	if reset_with_tcp_filter "with multiple laminar endpoints" ns1 10.0.2.2 REJECT &&
-	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -2363,7 +2363,7 @@ laminar_endp_tests()
 
 	# laminar endpoints: only one endpoint is used
 	if reset_with_tcp_filter "single laminar endpoint" ns1 10.0.2.2 REJECT &&
-	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -2376,7 +2376,7 @@ laminar_endp_tests()
 
 	# laminar endpoints: subflow and laminar flags
 	if reset_with_tcp_filter "sublow + laminar endpoints" ns1 10.0.2.2 REJECT &&
-	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
 		pm_nl_set_limits $ns1 0 4
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal

-- 
2.51.0

