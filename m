Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160D06089C
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200288; cv=none; b=sJIfrPl1wZsx00XmbXx/rc1A1Uhqe7o+/EvisUJrb7m8jATpVUJdPcRaqVPVHpSjFyLAqDydXQOx8Yul5iyrLCIgZiuqxWB9L7wsW/936qQJw4oiVdwfLiWDLlqlLETlDOWpPiqI8ZOWSLfSRZYSowqphyqdWoJ4YsY2ePjlnVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200288; c=relaxed/simple;
	bh=efqIyCCvvu+OGLhmZPAwZ5uVwcc9WjfA5yvSi3SkUFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YHWAbhdel+sWjjS3r06X6vdhIocxVA8XRmdkNuoR/iVhsuvMT+0pHV6AEHa3YFA8/zU6ZLVF214ZM47iU5yKIgEg4fzqYZIwaZVyxdXNFvzj3GK7W7GRVFgaRZoHGfeUkMLH6CYtUNJiwcbVIUnxf7jAqI4oUlHzQpT5GRzr2Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SC20Dyxa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SC20Dyxa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D2BC433A6;
	Thu, 29 Feb 2024 09:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709200287;
	bh=efqIyCCvvu+OGLhmZPAwZ5uVwcc9WjfA5yvSi3SkUFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SC20DyxaJ48bO+QpzRfuSjFuDD20OI6J5OVB096H3sxiQPEUfKf2VZMFnjyATTYbU
	 /XNW9EKsgFartv+F7wmAxOGZBHnYW0QOZelP4zHeQ8h/cPw1nycuU4zk6td+oo+4jw
	 crSfdx6vqs9TFeZ81NwION7I4GDwq3IBCDt4QjzKOueChnQTSPtRalgInRdKAKF69w
	 GS1P2AdOp3G9XN865sQeKQwghPMyabncsPkYiRyHvZfar0Q2327MLRPpC3C2eWjMZ8
	 l/mPSJgl35Z+Kt3h8tZgu0thayKuli/0gZVZUpyv9baim/mgRryrY6v3xs0bNSRUIs
	 CsdDO0ir8ihuw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 5/8] selftests: mptcp: sockopt: unify ipv4/ipv6 as v4/v6
Date: Thu, 29 Feb 2024 17:51:08 +0800
Message-Id: <80749c1dfc741ca14090559c5a2364b253c03a5a.1709200070.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709200070.git.tanggeliang@kylinos.cn>
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

ipv4/ipv6 and v4/v6 are mixed in the output of mptcp_sockopt.sh, this patch
unifies them as v4/v6.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 6ed4aa32222f..ae59136b5bb4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -130,10 +130,10 @@ do_transfer()
 	local local_addr ip
 	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
-		ip=ipv6
+		ip=v6
 	else
 		local_addr="0.0.0.0"
-		ip=ipv4
+		ip=v4
 	fi
 
 	cmsg="TIMESTAMPNS"
@@ -232,7 +232,7 @@ do_mptcp_sockopt_tests()
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
+		echo "FAIL: SOL_MPTCP getsockopt (v6)" 1>&2
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
-- 
2.40.1

