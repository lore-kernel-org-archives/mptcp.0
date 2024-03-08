Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36F728E2B
	for <mptcp@lists.linux.dev>; Fri,  8 Mar 2024 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709877468; cv=none; b=aOpP0bbWakF2GlvBZqU96ZUrvJEP47zwXFJ5oYSvx+HILggMsiEp1Vf2R4HKj28Pg+YEMEjZnQn3RxdO3qwGLHEsOYVoXHSH5qgjPfHg+NAOT/5RIh4t8m4NWoeML9+A0YllCqFewkAtOn6ifgpRZe5Wk+nCnCtRldbx8Gf0zes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709877468; c=relaxed/simple;
	bh=hio6xgdqPN32b2eEdu9W9KqBjgHSEbHZIBqnbl2nfiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hItwhkYVdeD2qOTCWqogXtaYDy5hNPtEXJktlnlaHrlW8+PoVSsWGKp01dd+0huSpfPAmKd5+9kMEuR3hDo/Cy22amb/XOwNEF5cxq2ydq4sga11rt8JWnhh1D643V6B1pgyduSnshopdl29KGxjv8nqqXNYuI3pJ+q90K9BuCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5g7MAMj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5g7MAMj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FB5C43390;
	Fri,  8 Mar 2024 05:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709877468;
	bh=hio6xgdqPN32b2eEdu9W9KqBjgHSEbHZIBqnbl2nfiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f5g7MAMj4vggJyJgFb8TLtnVdcbV4Y0Bnmzfl7AVWy7w9ThQ6nSTDpNjOV1Aa9Apr
	 v5OdydPYCJY7HEHxxgIQIui2xImlBxhcam2rzuztUsU21r6wlztFkXZKb8pWueTGwK
	 1MvWAeaHEm/V1eNhUG2A41HDLh/w/7gsmfLRgJpP2RIlzqJSG11zH0uD5cklT0xRfA
	 1hpsiVteX8XcWqfm9FZjNiH7zfeoQOe0bIvTMRjNd6w/NeqBjbyRpGB63qvgGMNK93
	 XeKcPef9yE1HDrLmITK43DudswD86TWiuEU6uyMFvKB6D6EDtiS3ntu4qEnyficfwD
	 cjjYGND1HH0RQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/7] selftests: mptcp: print_test out of verify_listener_events
Date: Fri,  8 Mar 2024 13:57:36 +0800
Message-Id: <2bffcdde5610631b9f3b715d83d42420996c0fc2.1709876991.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709876991.git.tanggeliang@kylinos.cn>
References: <cover.1709876991.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

verify_listener_events() helper will be exported into mptcp_lib.sh as a
public function, but print_test() is invoked in it, which is a private
function in userspace_pm.sh only. So this patch moves print_test() out of
verify_listener_events().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 6d0862a1b68d..e9aea44edee5 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -845,12 +845,6 @@ verify_listener_events()
 	local saddr
 	local sport
 
-	if [ $e_type = $LISTENER_CREATED ]; then
-		print_test "CREATE_LISTENER $e_saddr:$e_sport"
-	elif [ $e_type = $LISTENER_CLOSED ]; then
-		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
-	fi
-
 	type=$(mptcp_lib_evts_get_info type $evt $e_type)
 	family=$(mptcp_lib_evts_get_info family $evt $e_type)
 	sport=$(mptcp_lib_evts_get_info sport $evt $e_type)
@@ -882,6 +876,7 @@ test_listener()
 	local listener_pid=$!
 
 	sleep 0.5
+	print_test "CREATE_LISTENER 10.0.2.2:$client4_port"
 	verify_listener_events $client_evts $LISTENER_CREATED $AF_INET 10.0.2.2 $client4_port
 
 	# ADD_ADDR from client to server machine reusing the subflow port
@@ -898,6 +893,7 @@ test_listener()
 	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
+	print_test "CLOSE_LISTENER 10.0.2.2:$client4_port"
 	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
 }
 
-- 
2.40.1

