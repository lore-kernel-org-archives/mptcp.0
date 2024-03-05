Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0510E10A1B
	for <mptcp@lists.linux.dev>; Tue,  5 Mar 2024 05:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709616137; cv=none; b=DPt9FlmEEuJwDKr2U+45oLr7NAvixulzbPvmLYIUBwPCXq50cNojXl+ucKCLznxEbIb4khnMyayWlHFhDVnKJI+d0ueCdwCZUET95ee22j3Y9nEkJgBb1Qz7qlw39jgSaU3elJmeHA5FceW3u7XE04KLrAg/nXEV1gVEbLAOKII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709616137; c=relaxed/simple;
	bh=lRvyJQ4n8mZ4DG2sxqKIHcdRZJy2sdYu/xFPhRZroCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CNlIXk6SthWcp1A6iHlCd1aeSjeo/g4hdu1HNzLYygT9ibmYkqb+7gcAfQpTw01gbmKGV/i5FdiuhjV1r7ILk3s39vt2Fc44//U/Up2LKF5v/kryp7XFrKH1uxfQ6tBa/1vW2ol2ICJj5V21IjDtlazNDy6rsY4h1Z7w6v3kq7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQ5yYsuk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQ5yYsuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBA8C43390;
	Tue,  5 Mar 2024 05:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709616136;
	bh=lRvyJQ4n8mZ4DG2sxqKIHcdRZJy2sdYu/xFPhRZroCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQ5yYsuk9b1izUU81iW2jhFe3u5yPLrq1aFXI6eF26Qkghp9thJ6oZ4WjER5iSOyz
	 mrWQzKw+cFBM9IVJbKBES4MUXhF/INwNQlW5A3N0dvwF/IWMDwhGCH8nG3d8slnFph
	 EXNin8DWOIetjbaLFVIl7s89TxTw6cjUw6JUlpN1tqMCkKXJlcI+OXHXMfi+llrUK2
	 ryEwlzIT1EsOjkd+llTI0jJ647t3j8jfALXxNlzwsK871XLucaId1U04tv/sr52h8h
	 bLkUZEiWKBkK0SH225czIdUGSWOFOWzWQQPuQB3g5K4czQQggEroFf2ATk8JiS9tRN
	 9bWwnEmEd8epA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 2/9] selftests: mptcp: connect: add dedicated port counter
Date: Tue,  5 Mar 2024 13:22:00 +0800
Message-Id: <f6e5241dd67e898b0eee815467256051f8099fbe.1709615883.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709615883.git.tanggeliang@kylinos.cn>
References: <cover.1709615883.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new dedicated counter 'prot_base' instead of TEST_COUNT
to increase port numbers in mptcp_connect.sh.

This can avoid outputting discontinuous test counters.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---

Notes:
    use port_base instead of PORT

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 679e366c8f6b..c47ea779145d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -33,6 +33,7 @@ do_tcp=0
 checksum=false
 filesize=0
 connect_per_transfer=1
+port_base=10000
 
 if [ $tc_loss -eq 100 ];then
 	tc_loss=1%
@@ -314,7 +315,7 @@ do_transfer()
 	local extra_args="$7"
 
 	local port
-	port=$((10000+TEST_COUNT))
+	port=$((port_base++))
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
@@ -710,7 +711,7 @@ EOF
 
 	echo "INFO: test $msg"
 
-	TEST_COUNT=10000
+	port_base=20000
 	local extra_args="-o TRANSPARENT"
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
 		    ${connect_addr} ${local_addr} "${extra_args}"
-- 
2.40.1

