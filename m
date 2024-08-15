Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED44014E2D8
	for <mptcp@lists.linux.dev>; Thu, 15 Aug 2024 20:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754775; cv=none; b=pUOmfu8iQUdFZhaIEWJW5SKdIBh7SZbIP1/aA5gkwBmP0rDI8J7kon2xKhlJ7fZmKJmeBnf5fQlgpdrePL5h+ZD20DDiqWP/R/Urw0//Ta0xo1qQxHFx6nYONnrFCDnhjYd0PjgMmaw4NKdhvajiJrIorKUJMzC5mM38qQ9uTDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754775; c=relaxed/simple;
	bh=Wf1RCXTiAGBk18KGeZNdXyjIbjnYpfgbYHCeoTbkx7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zw55xO2y0kmq04G068FHEO02EjIOWWY5YYb10LTiQ87nAullsnXNZm+HG9G003G0WwERBgaSU9niD0/1pE7EA88qP1P7siOWnxnBP+1S6NpSz0uxJZoELfL2NGkEJ+k8h5kKugptymSSVRtXGcKihcJGHHRy0XhM8fOT1aFYhig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=of2EOt92; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="of2EOt92"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1E2C4AF09;
	Thu, 15 Aug 2024 20:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723754774;
	bh=Wf1RCXTiAGBk18KGeZNdXyjIbjnYpfgbYHCeoTbkx7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=of2EOt92ByIa1slpeAYta01fpnWPizu5SUx33HuYnoc+C5VpmCVbk4rmCSVizFdGI
	 6RKJhNb68cc3CkWEWDG8fy/Sg9FxAhc3Ijx2yINj35yaFyD4m4bGzE42uO2aCOJBsN
	 m0tAUzjMmD20tJsoy3TAQJw2cUjLQ9cyXs3wweDBbc3WYkl10CbBnFWHVJftJPCiKG
	 RYQ/XaytaPPm2g9KtaF0Fn8qUuc7cdYnuFK1xZZZLPsRICBF5ulz+G7uQzn8dncVw1
	 Q0ONmSSaCUZfIlfRO1x5AHrirZdc1JwY7WYUACPUwtNAI7F8AV/kM/OusYxAPfaLSY
	 A2ALXoGfX49kQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Aug 2024 22:45:51 +0200
Subject: [PATCH mptcp-net 10/10] selftests: mptcp: join: check re-re-adding
 ID 0 signal
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-mptcp-dup-close-evt-v1-10-5a551d3a66cc@kernel.org>
References: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
In-Reply-To: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Wf1RCXTiAGBk18KGeZNdXyjIbjnYpfgbYHCeoTbkx7Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvmkJlhLbVXHebRBl6D/SBn1o2bPDqa3zSWSs2
 MkX8QYTqJ+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr5pCQAKCRD2t4JPQmmg
 c6WaEACWka5VE7FD96GArMyi3/AZgHDXwzkIoEfpSbV6rzu28jWlWmX83hvy3FQTQYw3mABPzy4
 OYh1iiUeGETnJRbDegEjSYI7pKe5WcleYv/AID88KWMoxMiMj/3nLXwKH05fvwCHiFDErl+sdKC
 oFFOvetGagMNwQAtEbq2J62/5CRW1N9CA4hAFbw1ptY4tFomzH5mSL0OY46j0kVk9bErXFhbUnm
 LyQJyw3DMIAh8rI/ugAS/vGLLUkX2abRF4UDPuWYF8ClWcg74Tg9wryjIjjtH1UL6Yy5+9qmqKj
 OerA2zUVUi5cYLqTQe2YKpyxW9Bu4fzuPKDNnN97pxIG8/c3CIrboOCeyNQB+Zi3pyC7kmaLyfW
 RsTFWB8x4CeJ3ZVJJjX5+Nt3PULvvoIaidUyVhxjtSRXLbcMDSKmLYqYHn8uHuDni1fwGLiUidB
 bhtgcQtDcCF3EQHoZhhKYxjxa6RuUYkxFcOYr40GuIMvInIL/3s/X5fj6HEPpxLB16vL/+84om6
 BvfyOc+LpeOa49m/7JDaqm8nnjL5cKiIUmfHG9cQc//tMgMEShjf1Axl6CU2KgKfWCJaYhqKpTr
 OKqMZRtjJMzYdXTNgmLTPeASyaeKMhcl9u4k0LYXAbgr52IiyL2+FDQrQEnqpV2LVxSsZTVyJsZ
 qKwGarFAIEsl/eA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This test extends "delete re-add signal" to validate the previous
commit: when the 'signal' endpoint linked to the initial subflow (ID 0)
is re-added multiple times, it will re-send the ADD_ADDR with id 0. The
client should still be able to re-create this subflow, even if the
add_addr_accepted limit has been reached as this special address is not
considered as a new address.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 30 ++++++++++++++++---------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9e064c518fb8..9cd0130685d8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3801,7 +3801,17 @@ endpoint_tests()
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
 		wait_mpj $ns2
-		chk_subflow_nr "after re-add" 3
+		chk_subflow_nr "after re-add ID 0" 3
+		chk_mptcp_info subflows 3 subflows 3
+
+		pm_nl_del_endpoint $ns1 99 10.0.1.1
+		sleep 0.5
+		chk_subflow_nr "after re-delete ID 0" 2
+		chk_mptcp_info subflows 2 subflows 2
+
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 88 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "after re-re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
 		mptcp_lib_kill_wait $tests_pid
 
@@ -3811,20 +3821,20 @@ endpoint_tests()
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_ANNOUNCED 0
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_REMOVED 0
-		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
-		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 3
 
 		chk_evt_nr ns2 MPTCP_LIB_EVENT_CREATED 1
 		chk_evt_nr ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 5
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 3
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 6
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 4
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 3
 
 		join_connect_err=1 \
-			chk_join_nr 4 4 4
-		chk_add_nr 5 5
-		chk_rm_nr 3 2 invert
+			chk_join_nr 5 5 5
+		chk_add_nr 6 6
+		chk_rm_nr 4 3 invert
 	fi
 
 	# flush and re-add

-- 
2.45.2

