Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1AC16F288
	for <mptcp@lists.linux.dev>; Wed,  8 Oct 2025 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932017; cv=none; b=HiWA5J2ASJM5nLRag8d3deVgjs+JCMnx7JifMDOyq5mP2Try86w7/1/G/P9Jv1XhqO49WvOvuwHcHKLHGidhs6GJAFbzh+vj3so4sV+2BPtwaovfgOY+l2Pkn231htf+0iiZES06nf5tH7Ztz0+8YM0AC0RHoMQadfac30WT5JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932017; c=relaxed/simple;
	bh=PoXiph/9okTL461HsQS/9IJY26i6/midgKe0IzkHP/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CygkLsuPLgS4LHleAQBgNn8wfcp8p/6GwNEprEgQ2fUgQi81Io9mxWd/Z44QwJ/+oPo3yKnahkD0Zg/ZB03jHFj3+woX3uLEwdZ+/Ld6NSUzM8GwodTyyVnOJfkosvssvv5yVQM96lBlHzPOLzciQ3SBIm0Y0kfdT7lteVgbD68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCYrnQbC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCYrnQbC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7D7C4CEF5;
	Wed,  8 Oct 2025 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759932017;
	bh=PoXiph/9okTL461HsQS/9IJY26i6/midgKe0IzkHP/8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZCYrnQbC+mxecasUEm2Dx4bW4SHCUuW+lteBxTOm2qzaNCAEJ84C2XUJFH7m8yte0
	 ZH6KYq4C1c7GvdC8e14RtI8TLuwBsOkTbpK17zzbEVP11CKa2GRifkwZ6JPiuufBTq
	 eCajBNagEO8uNfUtIDRunMCmK/2a3x8Kz6RhFmLH9Jw6jzBQ3lM0bZpLvIaX+Ssktf
	 ztIlPnGlTd1nExVWdRUfX8u8xgQjIy8lLZtm3JqjV/sN6+bUxLuMk4hT3xRNVRM4ev
	 YXK7KlxxRmaha+17J+sYijO03g2+rpScfQfxM207fKvPqAk+jvwhhuoST66xp7Vrtq
	 9ffnijzwyf7AQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Oct 2025 15:59:56 +0200
Subject: [PATCH mptcp-net 2/7] selftests: mptcp: join: mark 'flush re-add'
 as skipped if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-c-flag-add-addr-delay-v1-2-c624eb3bf10d@kernel.org>
References: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
In-Reply-To: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=PoXiph/9okTL461HsQS/9IJY26i6/midgKe0IzkHP/8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKe5WWErb00/410rqTrK7EpzE2c6wUOtqrlzNr+xHEqo
 yhrhffFjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlwzWdkuCJm/FbntZPgjC3h
 55SvXtsyXfdB/xSvkkvrbWUz1hWdcmf4n+n8KmfF+SzTzKrjbTsVTAp2bOTMirnxO7Lk5eFLj0+
 94QQA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The call to 'continue_if' was missing: it properly marks a subtest as
'skipped' if the attached condition is not valid.

Without that, the test is wrongly marked as passed on older kernels.

Fixes: e06959e9eebd ("selftests: mptcp: join: test for flush/re-add endpoints")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c90d8e8b95cb..deba21ca5a97 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4115,7 +4115,7 @@ endpoint_tests()
 
 	# flush and re-add
 	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 1 2
 		# broadcast IP: no packet for this address will be received on ns1

-- 
2.51.0

