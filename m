Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759802F8E8E
	for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782458195; cv=none; b=HJFzdw0FreXz5QVzsHkypxxdkf+RSscjXf2mzVmWR8ibftYSK8mJkfTZRTlUnDa1HN6jpsP7pOpcGbebehxLaKyrs/9q8gSo/L9iualgO5725/nUiFigOla63KbbaV5FosGfITeCXtbt34IF0B445NFu7Tgkj0La1zUHKmuMgOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782458195; c=relaxed/simple;
	bh=RmCjhSaYNUO5tzmFTUtFswKYJ/N6E1dETYD33uC7WxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHXI/cr0as6q3RD0DmcZA1guPMf9m37LWheM69xze56fxOSaPFMR9jM3wek5cAAtJkZs7n+I9VDt2hYXwYrrZLYyEYLQtYPs08MiiBnWpzHs7+henSMRk/7pYv7lmH/xNwjxIUlgbYuFEJB86pT1bawz/5X7a0qtpfkAzRvsmPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FK69Ri2p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK69Ri2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B5C1F00A3A;
	Fri, 26 Jun 2026 07:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782458194;
	bh=7fs8QjxTki/YzECO2GuouXWjshIqqMtfZTWwUjhWwwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FK69Ri2pK/lrPVtqiUiyAubmGMXII8K9s9U1vfMQSMt1TGgxiPKlUgCyLWNuRQ9cD
	 2TeveNyda0oPQ1LvPtGQv6TYi6cyV+krWxhtYhTuziKHhmHVK3d+w/dew/oxFHDR3M
	 KFb7ERUHMCAuH/J2ueMnOr31OBMXGGBcCZVgBv0uFJNKVfXMZNDzRY828GVYfw7zad
	 zcnDDssmTyjgpWhxs26w89XhHpphCtPaBulZhmVNFmNAcS4AoqFRNgOYfwQ8sgJl3A
	 4NzbG9YuTQeb223zDG19h/MlW1jVAIIZSSGy3VuUK/y6ipeC+YpFaW1hvHNW4MGeag
	 G5+C8/8ftUGPQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v5 3/3] selftests: mptcp: userspace: send RM_ADDR between server and client
Date: Fri, 26 Jun 2026 15:16:18 +0800
Message-ID: <c709287f80267b5b91f272481c050629932570a4.1782457962.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782457962.git.tanggeliang@kylinos.cn>
References: <cover.1782457962.git.tanggeliang@kylinos.cn>
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

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/userspace_pm.sh  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index e9ae1806ab07..3e7e2a633448 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -608,6 +608,10 @@ test_subflows()
 	   "$client4_token"
 	sleep 0.5
 
+	# RM_ADDR from server to client machine
+	ip netns exec "$ns1" ./pm_nl_ctl rem id 23 token "$server4_token"
+	sleep 0.5
+
 	# Attempt to add a listener at dead:beef:2::2:<subflow-port>
 	ip netns exec "$ns2" ./pm_nl_ctl listen dead:beef:2::2\
 	   "$client6_port" &
@@ -642,6 +646,8 @@ test_subflows()
 			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
 			      "$client_addr_id" "ns1" "ns2"
 
+	# RM_ADDR from server to client machine
+	ip netns exec "$ns1" ./pm_nl_ctl rem id 23 token "$server6_token"
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
 	   "$client6_token"
@@ -680,6 +686,8 @@ test_subflows()
 	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
 			      "10.0.2.2" "$new4_port" "23" "$client_addr_id" "ns1" "ns2"
 
+	# RM_ADDR from server to client machine
+	ip netns exec "$ns1" ./pm_nl_ctl rem id 23 token "$server4_token"
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
 	   "$client4_token"
@@ -721,6 +729,8 @@ test_subflows()
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
 	   "$server4_token"
+	# RM_ADDR from client to server machine
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client4_token"
 	sleep 0.5
 
 	# Attempt to add a listener at dead:beef:2::1:<subflow-port>
@@ -760,6 +770,8 @@ test_subflows()
 	# RM_ADDR6 from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
 	   "$server6_token"
+	# RM_ADDR6 from client to server machine
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client6_token"
 	sleep 0.5
 
 	# Attempt to add a listener at 10.0.2.1:<new-port>
@@ -797,6 +809,8 @@ test_subflows()
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
 	   "$server4_token"
+	# RM_ADDR from client to server machine
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client4_token"
 }
 
 test_subflows_v4_v6_mix()
@@ -844,6 +858,8 @@ test_subflows_v4_v6_mix()
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
 	   "$server6_token"
+	# RM_ADDR from client to server machine
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client6_token"
 	sleep 0.5
 }
 
-- 
2.53.0

