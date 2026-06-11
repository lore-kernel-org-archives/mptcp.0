Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BC733DEE9
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197710; cv=none; b=ZEaGivANFGs78LxLpXYgVjmSlp7mCQZLzIzOwBxpkv07K7qk/OUoUjhlb7GkJc3Pbsz9GUAc0K2p1mYJDnpjZtMLfmDgIRHbeHGbVCkobYgoX/GcdA32EpiF0aoCfOSsy/Vva5V7yTlMiUAG+DAtPUMllfEgbBNBB9HlFu6YQGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197710; c=relaxed/simple;
	bh=QYhjw/BbutWjzo0+pEM7YYnL4IWZRv52hANYJCpWPpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyrWQLnExOBxs/vLy44h4vX4jD+BhhIf3B0SBEpIqY7FZsPQ6/jXsBBi7+C0yiE72YGMdONzeZrCM1/0jN9FSUokUyjrwbcoB/VzCDm6UkJEOKMyNi7jQV57c9ja6uOQGf+ouNQ0fYPQnbngPfC6+SQ+kq0ViBbPWs7DQ0uzWDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DUO+LHsP; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DUO+LHsP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781197707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKdLzQbqeINFajb+iibVD6DQwWf+FO44jmisQXV3r4E=;
	b=DUO+LHsPoCdBWF1uh+wU239Ydx8ded4oxZwcQmyT3h6ty6OzTIi425Z9KRCOQkL4eY/f+g
	O4I4tQVySH4My7NS8IuQYY1YjcFovMJPGpdzzmA8gBWqBqUdr2yNOCNWsa7D21BNe0qOVg
	EC9g/xbeWhrVRR77svhSPoKRDovWhQQ=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH, mptcp-next 4/9] selftests: mptcp: mptcp_connect.sh don't fail because of nft rules in IPV6-less kernel
Date: Fri, 12 Jun 2026 01:07:54 +0800
Message-ID: <b907fea6d30ce3ecd621cf4ec68184291e540ea8.1781196828.git.yangang@kylinos.cn>
In-Reply-To: <cover.1781196828.git.yangang@kylinos.cn>
References: <cover.1781196828.git.yangang@kylinos.cn>
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

