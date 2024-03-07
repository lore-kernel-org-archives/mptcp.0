Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388BD46AF
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 01:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709774065; cv=none; b=kTStFt8IOBdaMBAKOH+/TlAFVX/X0AhUszanzAi7PzY9YELUHFeDRrVRgUEb5Rbh2/8hZSTe16sQX6qpAYCg26j3AVd6DwaFAx7iKqG3LQ4J90qgXgUaoSsypw2D5KEtexhGRVnHmHdsPYihMHn2W3TU3UTCol0EQld1r/Q4o3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709774065; c=relaxed/simple;
	bh=VVWmC214Oce0NYU+QGtxHZPqqb+WA5wGGr0i/rqFWLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D2G1L4rStepAO2fVjyvJKuzYSV+Jm7PfHUM9oNJFEzEcQZExM0mf1okJhGZ9MxKyMWrWxlpGbR49kfk+I8DS0Oq+tmDjS6XiG0aBZUQv4c8WuD6EC+phxkcd36V6V02P2rrircEutOvxa5T9DBmAn291Ak/Fpxj9jxq9/daQ5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5p1V62/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5p1V62/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D40EC433F1;
	Thu,  7 Mar 2024 01:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709774064;
	bh=VVWmC214Oce0NYU+QGtxHZPqqb+WA5wGGr0i/rqFWLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B5p1V62/TGBLJjj5Xj+jdKoHAkSZYoIRA4k316tL9Dl5bDl+Bn4RvQ1G7ikFZ/uWp
	 hMDPCHMvLbvfatUn9VJfmyjiCbBWEL4E2b6Zzyao9MeRHho8SpQZTJ7xLDPixrpS2g
	 CfPzAbxfMBRJnFqee0uZh0Bd+W7Bx7XkyXeAI5vVXkz9A9DX7rObjomCFZAcGfbokr
	 R7+hLJclWLP97rr4do/96/4Ih4CPfwY1tfraIelKNlmFXvxfFsGxALH8VQLxezLeUH
	 KkFQPg0POhYslDBzao676WgjN+JsncBNLWnpxW2z53qgyI/cElbXpPqP2Skx8dGDKC
	 pcAt5x01bFt9Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] Squash to "selftests: mptcp: connect: add dedicated port counter"
Date: Thu,  7 Mar 2024 09:14:11 +0800
Message-Id: <17e1c8e1f7e8a30585c3b8d2b0711f3d8f4e460d.1709773913.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709773913.git.tanggeliang@kylinos.cn>
References: <cover.1709773913.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Move port++ from the beginning of do_transfer to the end of it, then
9999 can be set to 10000, the same as 19999.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 5942256857a5..8feb4eef0931 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -33,7 +33,7 @@ do_tcp=0
 checksum=false
 filesize=0
 connect_per_transfer=1
-port=$((10000 - 1))
+port=10000
 
 if [ $tc_loss -eq 100 ];then
 	tc_loss=1%
@@ -320,8 +320,6 @@ do_transfer()
 	local local_addr="$6"
 	local extra_args="$7"
 
-	port=$((port + 1))
-
 	if [ "$rcvbuf" -gt 0 ]; then
 		extra_args+=" -R $rcvbuf"
 	fi
@@ -446,6 +444,8 @@ do_transfer()
 		return 1
 	fi
 
+	port=$((port+1))
+
 	mptcp_lib_check_transfer $sin $cout "file received by client"
 	retc=$?
 	mptcp_lib_check_transfer $cin $sout "file received by server"
@@ -719,7 +719,7 @@ EOF
 
 	mptcp_lib_pr_info "test $msg"
 
-	port=$((20000 - 1))
+	port=20000
 	local extra_args="-o TRANSPARENT"
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
 		    ${connect_addr} ${local_addr} "${extra_args}"
-- 
2.40.1

