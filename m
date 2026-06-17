Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA43C1D5ADE
	for <mptcp@lists.linux.dev>; Wed, 17 Jun 2026 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707600; cv=none; b=kysOLSutUGE4PjAZwsYamdXe7XaL1oWoLKIBoCejvI6RGaFlIPARKLLtNWtCpCpiisy/eI/e72zNDE88eOL78nyelU6oy966IEoYcpVsXvFRl6hjJ6eX/aStf3hAh2YMYhYC4xA79beY4qsW6o1fEb7FlcuiFd9IFpIq9C3fVIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707600; c=relaxed/simple;
	bh=QYhjw/BbutWjzo0+pEM7YYnL4IWZRv52hANYJCpWPpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aipPTMD1o+WxBlxAQ3riWFs9bPetybHUkhcCeINlbBB/lfVGHRPb4mzL0NXQuJon8bwdPm59Ss7KxrlsjQhKT0X6bLwoNl2NXHmJT1wSm2Sr3QAFCsr/77whaUUOEOtQsUDK1iHnVTxj1v5on1aJJvrT4fJPmIRdXf5i71KIBDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DOqTbwtY; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DOqTbwtY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781707597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKdLzQbqeINFajb+iibVD6DQwWf+FO44jmisQXV3r4E=;
	b=DOqTbwtYyDNMokLGqFDwTCRyBfJFXgDMHwP7TrNupufEJy1su/TnsBkTPaaWQ7CwQ1tH+X
	jAqjEBWwdQ9r1hwMGBnKn1jKdwBa10Oh/TjtV0nAVP1KbgCEHEwEThw+DOq/j920E007h9
	xqsFEGtqbQs4n726UKprWtC70dTCr0k=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/9] selftests: mptcp: mptcp_connect.sh don't fail because of nft rules in IPV6-less kernel
Date: Wed, 17 Jun 2026 22:46:11 +0800
Message-ID: <05c44c050ed5b0ab0761bd1ca5a8d277fdb9e13e.1781707101.git.yangang@kylinos.cn>
In-Reply-To: <cover.1781707101.git.yangang@kylinos.cn>
References: <cover.1781707101.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

run_test_transparent() loads an nft "table inet mangle" ruleset to
tproxy matching traffic to the listener. "table inet" requires
CONFIG_NF_TABLES_IPV6, which in turn depends on CONFIG_IPV6=y.

In a kernel with full MPTCP IPv6 support, mptcp_lib_is_v6_enabled
returns true and the original CI hard-fail behaviour is preserved
(this is what makes a real "nft is broken on a full kernel" bug
visible to EXPECT_ALL_FEATURES CI). In a CONFIG_IPV6=m kernel the
test is reported as a SKIP and mptcp_connect.sh continues with the
rest of its v4 tests.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 0e5690d6f68c..9f93924c5d91 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -714,7 +714,11 @@ table inet mangle {
 EOF
 	then
 		mptcp_lib_pr_skip "$msg, could not load nft ruleset"
-		mptcp_lib_fail_if_expected_feature "nft rules"
+		if mptcp_lib_is_v6_enabled; then
+			mptcp_lib_fail_if_expected_feature "nft rules"
+		else
+			mptcp_lib_pr_info "nft inet table needs CONFIG_IPV6=y"
+		fi
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
-- 
2.43.0

