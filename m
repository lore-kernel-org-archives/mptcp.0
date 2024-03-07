Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3DE256A
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 05:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709791115; cv=none; b=liTJLa3BSpp3HaUTltZyLaDHOhrTJvry/cBy7lFbHfVrSXGpX3lfQV9JHY5v6jAOJUcs4WlnYDCB0zAvKaxCjO0xpcb9YV0A3xwg1GkeKaU7HqhrFs+lhwaCYwG6Xv+LPxWKKJBw6tgNrVgWQAH3xkBEBGpKBbIKQR375CuuEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709791115; c=relaxed/simple;
	bh=tJ9FakZ2oMNYED+TaDww7YvIh69TFIz/ln+Td0Mj3Xo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=prhrCRTj0TMDsNkDJj8iLmTVFrW7m1o45uFuRK7Ra63JbsGm1Zhn3T8atSKMdh/LYLx6tD+XSH1EsSnp/eKZ9IsvHsGXmvGagIF88xhJWiHEuLjwLQZ2VlTdNv1d+OLgVjQEedehe3mXtLBSYK0r7LmR/JDwsuaReqrzJ2vaYAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWfpDZSR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWfpDZSR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03E0C433F1;
	Thu,  7 Mar 2024 05:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709791114;
	bh=tJ9FakZ2oMNYED+TaDww7YvIh69TFIz/ln+Td0Mj3Xo=;
	h=From:To:Cc:Subject:Date:From;
	b=iWfpDZSRfAzFhve5zDu06mhKahavBZhBbCEn68MRcELyH4kgml205i9QNEKXHsNBt
	 3cRMdWLK+Cy3Grq2RQvOg4oHGKxLVFC20jFo70yRJaNrt/fhWHrHwN2mfeixdEk9aD
	 iV7S9oOzn0vmrNCbZ0wcka9lMTYtxcqr8um1NomaIoHQCgXF3N890oR1mFjTHzUsPR
	 jZrMucNms1KsFz24pIwReMy8Ul+l9U2YD/J8sGlU0XlyV4I4RF8uoyu2uMon5JbVej
	 kNa9Iu+7MckhxwTPLC62tOyMpq5jymZhBI7G9VxDkUpQ177+OjEFYVM+F/BrAupL/E
	 IR+z3bsifqHVg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: print test results with colors"
Date: Thu,  7 Mar 2024 13:58:28 +0800
Message-Id: <6f47bafed58fcc6fd3236b12134b23ff012d5643.1709791100.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

_printf is dropped now, use mptcp_lib_pr_fail instead.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 9fc9e574bc27..30652a1c548b 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -242,8 +242,7 @@ check_expected_one()
 		test_fail
 	fi
 
-	_printf "\tExpected value for '%s': '%s', got '%s'.\n" \
-		"${var}" "${!exp}" "${!var}"
+	mptcp_lib_pr_fail "Expected value for '${var}': '${!exp}', got '${!var}'."
 	return 1
 }
 
-- 
2.40.1

