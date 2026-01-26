Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7292F283FF5
	for <mptcp@lists.linux.dev>; Mon, 26 Jan 2026 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455494; cv=none; b=GjKRZ8EUyPVRxLHrDEZI/WbOYFPR8DA9p5jUcq8z66jBpNbiSdbdbfcaBbbtlkoYf/f2UfljpeUl+Ff0Ug4j/7blkeZsgdR8BvqkVkU/Py3BCW5VqgZ1GZLxPe2rhmbATsy6b3nafoOx2xHT3DAbmNT39L10Wox+AqOjbqw093s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455494; c=relaxed/simple;
	bh=8FEOMEoWj+2MMl4Rxoa/W2/GoF/YNd19VazBontGtFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TyAC+U6oNyWbmcbMXS405NiLgVqUa7cHKmMDXxsvGxyJ/0jGDErdoDNZxXcN9dl453Y8mbYaFpI+hM3cvCTf8/YZ+VNaXWhmAQD4PRXl5IdaeuxgmduTTzZrsfA4b/mzmN8mWz2ho7XSQrRiuuZQtV6SiRZ11nh7PazVDw57ZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6UFuPqW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6UFuPqW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFABDC19422;
	Mon, 26 Jan 2026 19:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455494;
	bh=8FEOMEoWj+2MMl4Rxoa/W2/GoF/YNd19VazBontGtFQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L6UFuPqWI3iSyt5uRnlj8ZvplSDKZgUTS+4vla5xPpc0HX2OmdRZXKkG5wbebaQxS
	 a3+isj2fYrPQyxcBOpr/tEqzZi1Jc5CHE19/vWIT++bAvMWm1VDB7q2CXBOcrPrh37
	 uKC5oy5HRz3BtxR8qkyOvXDxsgvh9xKEy/IvFhlM1CwHJ08yIIJfeny3KVTwUTB3vi
	 7kV4FlozV/blKgnXys3uXUOe8oPP1FnfUclfoXa7ofhkdKrOsQI5agLKQ/FZ4pnEof
	 O/EtUE+3BcJXfAX1eilw3nRh0arqe/tYv1LI4OlDP1VN2st9hAaai/5eWEj+oAAr8v
	 IW9sTSou/mGGw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Jan 2026 20:18:44 +0100
Subject: [PATCH mptcp-net v2 07/11] selftests: mptcp: join: userspace: wait
 for new events
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-mptcp-issue-603-v2-7-8393e7840b9e@kernel.org>
References: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
In-Reply-To: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3035; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8FEOMEoWj+2MMl4Rxoa/W2/GoF/YNd19VazBontGtFQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLL99faRu2yeDZZQuTMvBSObok3yb1GgtP+7b6dc661p
 P1xrsC9jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImoFTH8ZjHOzn85+/mBdR8S
 NxRoSLLuu2wz8eqbTuHI7T8DPmtbCDIyTDj0XFzrzpOIs3VKb1qmKirc1CxfVJb4sEg+4o/21MS
 vHAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Instead of waiting for a random amount of time (1 second), wait for an
event to be received on the other side.

To do that, when an address is announced (userspace_pm_add_addr), the
ANNOUNCED is expected. When a new subflow is created
(userspace_pm_add_sf), the SUB_ESTABLISHED event is expected.

With this, the tests can finish quicker.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6ab568d6b856..4977e6ff17b4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3716,7 +3716,6 @@ userspace_pm_add_addr()
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 
 	ip netns exec $1 ./pm_nl_ctl ann $2 token $tk id $3
-	sleep 1
 }
 
 # $1: ns ; $2: id
@@ -3747,7 +3746,6 @@ userspace_pm_add_sf()
 
 	ip netns exec $1 ./pm_nl_ctl csf lip $2 lid $3 \
 				rip $da rport $dp token $tk
-	sleep 1
 }
 
 # $1: ns ; $2: addr $3: event type
@@ -3999,7 +3997,9 @@ userspace_tests()
 		local tests_pid=$!
 		wait_event ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
+		wait_event ns2 MPTCP_LIB_EVENT_ANNOUNCED 1
 		userspace_pm_add_addr $ns1 10.0.3.1 20
+		wait_event ns2 MPTCP_LIB_EVENT_ANNOUNCED 2
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
 		chk_mptcp_info subflows 2 subflows 2
@@ -4032,6 +4032,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_sf $ns2 10.0.3.2 20
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
@@ -4062,6 +4063,7 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		userspace_pm_add_sf $ns2 10.0.3.2 0
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
 		userspace_pm_chk_dump_addr "${ns2}" \
 			"id 0 flags subflow 10.0.3.2" "id 0 subflow"
 		chk_join_nr 1 1 1
@@ -4081,6 +4083,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_sf $ns2 10.0.3.2 20
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
@@ -4105,6 +4108,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_event ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
+		wait_event ns2 MPTCP_LIB_EVENT_ANNOUNCED 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
@@ -4131,6 +4135,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_sf $ns2 10.0.3.2 20
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 

-- 
2.51.0

