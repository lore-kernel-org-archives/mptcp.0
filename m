Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2724318EE6
	for <mptcp@lists.linux.dev>; Fri, 17 Apr 2026 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467213; cv=none; b=eQX2T65bzp8hWK4PdQ7Z1Rcstf1kozGp9HKzmXCpTOSaodJ9LgOE67/lPWDgCUi8fxq2y/wAsgMu0iI6Hh7yB6T5u6bMr2hyoAjrORjxxZx51MLD9jGD5LD+uwsqif4+MdTjuqkeatPt0rnxdXgnlobYNAOhtUInycVTehozH2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467213; c=relaxed/simple;
	bh=3wV2/MjD/Za2zuJtrTsKwOBlvZmDmVcNuqk7sluPGtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfsTWgxK6mZIKrgc0X3esvUgSOz/5PXWK25ADVQK+5ik901Dmhf5W2Lz4uXhCSY9jX9jXLCJTFM58Bmz4D9vP2+yMvtdQ49gunBLgPCEP61PlhIde3MK1BVLZvSMXplgcRq0kpENIuzKcr2A1VlAO4QQP7fYouOMstaFbgrtcco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzrJxMM9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzrJxMM9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669B8C2BCB3;
	Fri, 17 Apr 2026 23:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776467213;
	bh=3wV2/MjD/Za2zuJtrTsKwOBlvZmDmVcNuqk7sluPGtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzrJxMM99FUqwZPfDg6z7ZeoUkHRDUW1cYs8PUh4uosdRUUXPg6L4733C6Fr5pUIg
	 VXKxqGrIFIbsdWRx1fXxyhG2AZ9fFIlr92F76zuvtEhKlYcQ0jSRuKhF1F4NxCEdeP
	 quj1logtLTK6Ec1jNciaWNbfMIWVV1d1Td/lhWQcMg7Ogr7mmZ9nT/TDXqZLGcG46t
	 px2ydy85gF0TiHD6WmJx6QWRYp/PDXFu6v8QNn85774DXu9vRyN1P5+v1DmA2iXBfx
	 mXCcXc8S2U8ZiW4+YsDZ7DV5v1EigEs9rH+XrtNCHx4dSMxDld5qN5g6pChzaatzLr
	 4AFjLKLiDjFZw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/3] selftests: mptcp: userspace: send RM_ADDR between server and client
Date: Sat, 18 Apr 2026 07:06:24 +0800
Message-ID: <1019210f324b665fb2e3b5c341177976c557644f.1776466833.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776466833.git.tanggeliang@kylinos.cn>
References: <cover.1776466833.git.tanggeliang@kylinos.cn>
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
index e9ae1806ab07..7490b80b3e45 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -642,6 +642,8 @@ test_subflows()
 			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
 			      "$client_addr_id" "ns1" "ns2"
 
+	# RM_ADDR from server to client machine
+	ip netns exec "$ns1" ./pm_nl_ctl rem id 23 token "$server6_token"
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
 	   "$client6_token"
@@ -680,6 +682,8 @@ test_subflows()
 	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
 			      "10.0.2.2" "$new4_port" "23" "$client_addr_id" "ns1" "ns2"
 
+	# RM_ADDR from server to client machine
+	ip netns exec "$ns1" ./pm_nl_ctl rem id 23 token "$server4_token"
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
 	   "$client4_token"
@@ -721,6 +725,8 @@ test_subflows()
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
 	   "$server4_token"
+	# RM_ADDR from client to server machine
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client4_token"
 	sleep 0.5
 
 	# Attempt to add a listener at dead:beef:2::1:<subflow-port>
@@ -760,6 +766,8 @@ test_subflows()
 	# RM_ADDR6 from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
 	   "$server6_token"
+	# RM_ADDR6 from client to server machine
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client6_token"
 	sleep 0.5
 
 	# Attempt to add a listener at 10.0.2.1:<new-port>
@@ -797,6 +805,8 @@ test_subflows()
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
 	   "$server4_token"
+	# RM_ADDR from client to server machine
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client4_token"
 }
 
 test_subflows_v4_v6_mix()
@@ -844,6 +854,8 @@ test_subflows_v4_v6_mix()
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
 	   "$server6_token"
+	# RM_ADDR from client to server machine
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client6_token"
 	sleep 0.5
 }
 
-- 
2.51.0

