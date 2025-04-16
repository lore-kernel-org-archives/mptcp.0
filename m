Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F5A21D594
	for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744787994; cv=none; b=V8QPMJOnwyYuNUw2Iy4VjtuovfRt4tvphEfT1WPlh0YkWoPCzknvJJguNl4ZHpeaRvkq9GIY/T6dqzZTLi8kMPmzjU/1T2RDkFA+b2S+4a/IvNKWGgp6QQCkSU057bmM1Z6hYIhbPR+Rl3TJN/8t9WQuGz85bG2RDHLvQneVcSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744787994; c=relaxed/simple;
	bh=xzD1tiXM2ywhlsCTxcShighhDVOuHN2Sj5vNm9JsaBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SR+UZVZ8UjGEHmoNPJDBICAAKFPXUZXd3QIlMA0/Dp/gRmAPPtbCgUxw3Mvr7yEi23Ql1qywXTAuindlr542dR1V22h5zQP5xQsJrlBHzxRpW0GgmB+qE15biw818E3sX7bpUXonwZf8yp97jX2Ikd1m8c+cKx+KL7qaJ8ygs2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlqII210; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlqII210"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE732C4CEE2;
	Wed, 16 Apr 2025 07:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744787993;
	bh=xzD1tiXM2ywhlsCTxcShighhDVOuHN2Sj5vNm9JsaBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RlqII210oKQ1FbgCgkDmchfgBZhjEx/n8UmYqzAv3z4yBAdBJbucYPQrCY6b8Ubn4
	 2OfEEybX9Dts+n6sEmjNRMHIyxsqEFZ+Go60Oi+Gr1bcX1LopeLCVfKvh/CUAjnnlX
	 a3fivO5XYn8iEBdnzYJPl34vPYa62QDqVEg6UtzKDY2dwPJsSpAYXdQ6D3mSxtl8jg
	 9Z4wlsfqFQw0BlSUt3UKAGn4VQPTpOjGhn4whMG2JQbMIyKRNlDU6rUQISU3DY9ng3
	 2qPUEU/K71eL31OqaBEYjx/aTpRjSGhKkE/GwdOt6vpVfqu/IXUrtXyzqJjB1E3Osh
	 M6rlSbU+rxp3g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/3] selftests: mptcp: userspace: send RM_ADDR between server and client
Date: Wed, 16 Apr 2025 15:17:09 +0800
Message-ID: <90e496e8e2df3d5cf11c319cddbbfc958f15a97f.1744787273.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744787273.git.tanggeliang@kylinos.cn>
References: <cover.1744787273.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now address entries only be removed from local_addr_list when sending a
REMOVE_ADDR by the userspace PM, they're no longer removed when a subflow
is deleted.

To make the original userspace PM selftests pass, this patch sends RM_ADDR
from server to client machine at the end of each test, and always sends
RM_ADDR from client to server machine to cleanup address IDs for the next
new test.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 333064b0b5ac..b756ff80bf8c 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -633,6 +633,8 @@ test_subflows()
 			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
 			      "$client_addr_id" "ns1" "ns2"
 
+	# RM_ADDR from server to client machine
+	ip netns exec "$ns1" ./pm_nl_ctl rem id 23 token "$server6_token"
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
 	   "$client6_token"
@@ -671,6 +673,8 @@ test_subflows()
 	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
 			      "10.0.2.2" "$new4_port" "23" "$client_addr_id" "ns1" "ns2"
 
+	# RM_ADDR from server to client machine
+	ip netns exec "$ns1" ./pm_nl_ctl rem id 23 token "$server4_token"
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
 	   "$client4_token"
@@ -712,6 +716,8 @@ test_subflows()
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
 	   "$server4_token"
+	# RM_ADDR from client to server machine
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client4_token"
 	sleep 0.5
 
 	# Attempt to add a listener at dead:beef:2::1:<subflow-port>
@@ -751,6 +757,8 @@ test_subflows()
 	# RM_ADDR6 from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
 	   "$server6_token"
+	# RM_ADDR6 from client to server machine
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client6_token"
 	sleep 0.5
 
 	# Attempt to add a listener at 10.0.2.1:<new-port>
@@ -788,6 +796,8 @@ test_subflows()
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
 	   "$server4_token"
+	# RM_ADDR from client to server machine
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client4_token"
 }
 
 test_subflows_v4_v6_mix()
@@ -835,6 +845,8 @@ test_subflows_v4_v6_mix()
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
 	   "$server6_token"
+	# RM_ADDR from client to server machine
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client6_token"
 	sleep 0.5
 }
 
-- 
2.43.0

