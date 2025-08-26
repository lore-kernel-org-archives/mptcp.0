Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8A2F83C1
	for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200607; cv=none; b=mKE7eyFyGPHX1sqeXZ33+3V0Zi560jD6c7/+RZAxEu0Rq+rk9OO//5OqhzmmWg6XZsfVTQZNTISNliJqt31hTwL+0uQ1sfkv/Aoz6YLCPOjCbLinF408h9Nb+eNHbDqGpnIYwHMFlueqJBWlR4lTdRw1KRlzqI8ThdJyNkcrcGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200607; c=relaxed/simple;
	bh=zn9G0q4tgfuwbhmMWEICwzVsyAuMrbyo+0SHnIet2C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3ToQLSkorhN9UQEQ9FagLXDdEfl1nP70fBbBjvKDXThK59/+UQygb5jPwWLqv9n4c9cvWaBY9gL99N2Vy+64rdiHSJ0ufSdLO1KI4zl/ErB6Tbw0APH6HEIpC4NurJjw4t10dygqA1Q/lAxdnQX4mrZ/oVd4f643QJRPQs2OVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4FnuaXo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4FnuaXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE3CC4CEF1;
	Tue, 26 Aug 2025 09:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200606;
	bh=zn9G0q4tgfuwbhmMWEICwzVsyAuMrbyo+0SHnIet2C0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e4FnuaXoFcZ9hl+dRx7/9m1dCIjwKXijAUCkjgI+2xoprMLc14RhO95mhdxFgupL/
	 mXq1czMMwuAE3Er3d2Wy7Xk0mWXfIlE89ERd1619wMUcUScMuMzGY/HzAw/EB4OqJC
	 oAzFattUMWZ5371sDtHF5EjsASgr1P2fTTB6PZTiJjaZbR+c6er3ieK5NlRZSnwZMZ
	 g9AKmqsKzNgVqJSN0uvOKsZsHcj3c9cekSo36g4v+OH+uPK2sQ16xGqhAqc6R5cY+C
	 SenN1MIMlyKLd2mRu3wXhh8dDag0AUtTk8OU7nGz944BhVF0M0l+t/tp7KiCcU8KUV
	 Io1KlSj/8Rb/A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 13/14] selftests: mptcp: sockopt: replace mptcp_inq with sockopt
Date: Tue, 26 Aug 2025 17:29:37 +0800
Message-ID: <1b5e3a34620c8b6b44e7bb9e3ddcfee73c9b4f9b.1756200029.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756200029.git.tanggeliang@kylinos.cn>
References: <cover.1756200029.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update mptcp_sockopt.sh to use mptcp_sockopt binary instead of
mptcp_inq. This consolidates TCP_INQ testing into a single test binary
while maintaining equivalent test coverage.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 418a903c3a4d..f5150a10b064 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -305,7 +305,7 @@ run_tests()
 do_tcpinq_test()
 {
 	print_title "TCP_INQ cmsg/ioctl $*"
-	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
+	ip netns exec "$ns_sbox" ./mptcp_sockopt "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
@@ -331,19 +331,19 @@ do_tcpinq_tests()
 
 	local args
 	for args in "-t tcp" "-r tcp"; do
-		do_tcpinq_test $args
+		do_tcpinq_test $args -i
 		lret=$?
 		if [ $lret -ne 0 ] ; then
 			return $lret
 		fi
-		do_tcpinq_test -6 $args
+		do_tcpinq_test -6 $args -i
 		lret=$?
 		if [ $lret -ne 0 ] ; then
 			return $lret
 		fi
 	done
 
-	do_tcpinq_test -r tcp -t tcp
+	do_tcpinq_test -r tcp -t tcp -i
 
 	return $?
 }
-- 
2.48.1

