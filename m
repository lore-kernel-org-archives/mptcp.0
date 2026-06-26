Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E7E194C98
	for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782513988; cv=none; b=OGUaZoIh1buU3zFpyM+xescgD9s2C3ZKDr0OcGfF149ERUf7AIjiXm7R/8jHHfhDJ7bIWNyHSINOUJIQHAq6TLFWaNcIdlQxDBMW3HovFZ5PfBZnBceyTreRRX3VOeC8jO25+Z+4Un+nxHT0GAd1P3TAmvWoaa09avfRRfXe0HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782513988; c=relaxed/simple;
	bh=9Hi0CSsejpKb00iL2PDUHDuO39iqRBJhQ/224ioaHt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UApJLDwW4Q5pP0m9IqKhIT0K2t/vcEzE5JKKucvCKEzJidvJAXLwvoER1z4dh6rXxBgB+gHvlaKpNwFuDEVT9/f3w1V4QvQPyST8/taF8bg30QCEEqkriG4cuAjVQHcMvPFVELxJIYOyxgeHAf780cjs1VzDVSx5xufvOmc91Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glVjO3S8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glVjO3S8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22271F00A3A;
	Fri, 26 Jun 2026 22:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782513987;
	bh=JylY38C8np1DFQLHCy7vzk84a9wDc0O60w5kOo/OcQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=glVjO3S88ayPUw/G6G9dgRfikbUiDX/uhxE1HLRoQ2rEe6WjSfFiusTQuF3HnprK3
	 M2IEKD378fHn6YuhChI5AYO07Ph8tgdHADWE0bNFAGAvYqktHDqp2+0l4FoHsRiUEL
	 I6903MCQT2ayh/Yn/aUZ7LM9oS6RtGiOFyUq6h7+2LiiltMl2t9J5CKN0qoQCNRC3k
	 Hn7eMhFdCtA0m8+uKyWnuOguXfaWuvDxPiabB6qJdWQvsIak4Ssg/zo0ntovSkRSUs
	 dJ+iNj3qWcBkQLUbRhExJeNgifR0J5m72Uo2SkcK9IMj4/bKB+BuBohPAk4+QrSD8w
	 L3mYE0U1QrGeQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v6 3/3] selftests: mptcp: userspace: send RM_ADDR between server and client
Date: Sat, 27 Jun 2026 06:45:55 +0800
Message-ID: <14518c91935dd1dab033fc9a86d3f7ebfacfbe09.1782513313.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782513313.git.tanggeliang@kylinos.cn>
References: <cover.1782513313.git.tanggeliang@kylinos.cn>
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

To make the original userspace PM selftests pass, this patch adds explicit
RM_ADDR cleanups after each subflow subtest in test_subflows(): removes
the server-side local id 23 and the corresponding client-side address IDs,
and also cleans up id 23 from the client side in test_subflows_v4_v6_mix(),
ensuring that address entries are properly cleared to avoid interference
between tests.

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index e9ae1806ab07..cc6c2f3598b7 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -603,6 +603,8 @@ test_subflows()
 	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
 			      "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
 
+	# RM_ADDR from server to client machine
+	ip netns exec "$ns1" ./pm_nl_ctl rem id 23 token "$server4_token"
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
 	   "$client4_token"
@@ -642,6 +644,8 @@ test_subflows()
 			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
 			      "$client_addr_id" "ns1" "ns2"
 
+	# RM_ADDR from server to client machine
+	ip netns exec "$ns1" ./pm_nl_ctl rem id 23 token "$server6_token"
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
 	   "$client6_token"
@@ -680,6 +684,8 @@ test_subflows()
 	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
 			      "10.0.2.2" "$new4_port" "23" "$client_addr_id" "ns1" "ns2"
 
+	# RM_ADDR from server to client machine
+	ip netns exec "$ns1" ./pm_nl_ctl rem id 23 token "$server4_token"
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
 	   "$client4_token"
@@ -721,6 +727,8 @@ test_subflows()
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
 	   "$server4_token"
+	# RM_ADDR from client to server machine
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client4_token"
 	sleep 0.5
 
 	# Attempt to add a listener at dead:beef:2::1:<subflow-port>
@@ -760,6 +768,8 @@ test_subflows()
 	# RM_ADDR6 from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
 	   "$server6_token"
+	# RM_ADDR6 from client to server machine
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client6_token"
 	sleep 0.5
 
 	# Attempt to add a listener at 10.0.2.1:<new-port>
@@ -797,6 +807,8 @@ test_subflows()
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
 	   "$server4_token"
+	# RM_ADDR from client to server machine
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client4_token"
 }
 
 test_subflows_v4_v6_mix()
@@ -844,6 +856,8 @@ test_subflows_v4_v6_mix()
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
 	   "$server6_token"
+	# RM_ADDR from client to server machine
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client6_token"
 	sleep 0.5
 }
 
-- 
2.53.0

