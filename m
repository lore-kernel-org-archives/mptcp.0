Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745745EE86
	for <mptcp@lists.linux.dev>; Fri,  1 Mar 2024 06:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709273891; cv=none; b=bXZdqmildAitWFXXSg6jBbdU/aUMxMtTNurvUOL0F+kyNw3lapNn2+Hmgg+W17qir8keKQuBDP4hcM4VbnVBpucFMp3nzySNKLQsOuIrfbSVV6uAXtv5a1n3KymFbB7KzZ2H9Q955D4WjD9Q53EbaghGmHp5HCHaWtv64RP0oxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709273891; c=relaxed/simple;
	bh=CeysPUs859NGxTYkiD7yPGixmyXJEiqppZF4B17j2vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ANzzeMmM9itsG8JeRLpEl0mO0uGkC9fqmk6uL8ryIDxKOBgK2R2+LrHo4P6QaaGej8BxqVz+KWXfibj+a7OsZtVgQuQ+kiIyI5UFKUeZ7pUOY30cPRCjXXx2kyxn1t4sRBmMbjoKiP0unWh8k+2RqFYRwVR4aiy1Ln1sKJ23xBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDjinC0T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDjinC0T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFC0C433C7;
	Fri,  1 Mar 2024 06:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709273891;
	bh=CeysPUs859NGxTYkiD7yPGixmyXJEiqppZF4B17j2vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CDjinC0TJTyAFTG2CBaCx0UwpUPcHKT6vS1VxvYtaGJ4LWbq95Fcfd+TSR26wpH0D
	 tykxNDr6Nmd91MTySBDnAn++cCISnh6u+JP7gZeJhvcgM9WmNFsLw895k4d2NAITN4
	 7YZOvXfcwHKKGKLkNyXgthsCE8MCYhhbkQl05mRHwILX2644YhfE9IOqwMnapVmGoO
	 MPBk8f4RyAlkHNDXndU5LBUNiUFfPjoiBiF6pZav4xIN91q5pr5MwRDfVg6NZYbm89
	 ohPAVK0aI8crMTZgFcDlh9Hfy4supDi/u98bnUwR4jpXisR4/nGi4Y7YuezgUQzkEM
	 ChIm/PUYbYdQQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 1/6] selftests: mptcp: connect: add dedicated port counter
Date: Fri,  1 Mar 2024 14:18:00 +0800
Message-Id: <955266a35b85a42645422d3fbbb4c6f672a37495.1709273774.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709273774.git.tanggeliang@kylinos.cn>
References: <cover.1709273774.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new dedicated counter 'PORT' instead of TEST_COUNT to
increase port numbers in mptcp_connect.sh.

This can avoid outputting discontinuous test counters.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 0ca2960c9099..4f40221a86cb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -33,6 +33,7 @@ do_tcp=0
 checksum=false
 filesize=0
 connect_per_transfer=1
+PORT=0
 
 if [ $tc_loss -eq 100 ];then
 	tc_loss=1%
@@ -314,7 +315,7 @@ do_transfer()
 	local extra_args="$7"
 
 	local port
-	port=$((10000+TEST_COUNT))
+	port=$((10000+PORT++))
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
@@ -710,7 +711,7 @@ EOF
 
 	echo "INFO: test $msg"
 
-	TEST_COUNT=10000
+	PORT=10000
 	local extra_args="-o TRANSPARENT"
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
 		    ${connect_addr} ${local_addr} "${extra_args}"
-- 
2.40.1

