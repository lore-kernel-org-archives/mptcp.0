Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E005D8476
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671799935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmTeTVSvc0OuOA+0/+7/RlDQ31R39bxHVXEn9q42CYU=;
	b=HEwa6nOX89QRR1xRKi29B3voTJGGSHOrPbjQTckGeyYm9cVR7pUYAMQRhtWlP2NFJ94WhM
	lOFCqiGVzgtdQY1qv8S9Qwu/wRgcuZ1iOHr3SInGAu1J4NcTIVLLGU7rXKd1JUuMnWJGsX
	jHOEzehFWKvL8joSr5jv3VHyGXC0IVU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-B59-gSMhO2S5GJjr5dFLDA-1; Fri, 23 Dec 2022 07:52:14 -0500
X-MC-Unique: B59-gSMhO2S5GJjr5dFLDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19D4E1875041
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 12:52:14 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A116C2026D2A
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 12:52:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 3/3] selftests: mptcp: add test-cases for mixed v4/v6 subflows
Date: Fri, 23 Dec 2022 13:51:31 +0100
Message-Id: <c2b08053101c90d85634c95840e3a8a637fa8346.1671799401.git.pabeni@redhat.com>
In-Reply-To: <cover.1671799401.git.pabeni@redhat.com>
References: <cover.1671799401.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Note that we can't guess anymore the listener family based on the
client target address; use always IPv6.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 51 +++++++++++++++----
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d11d3d566608..6ef4787ad244 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -774,24 +774,17 @@ do_transfer()
 		addr_nr_ns2=${addr_nr_ns2:9}
 	fi
 
-	local local_addr
-	if is_v6 "${connect_addr}"; then
-		local_addr="::"
-	else
-		local_addr="0.0.0.0"
-	fi
-
 	extra_srv_args="$extra_args $extra_srv_args"
 	if [ "$test_link_fail" -gt 1 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					$extra_srv_args ${local_addr} < "$sinfail" > "$sout" &
+					$extra_srv_args "::" < "$sinfail" > "$sout" &
 	else
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					$extra_srv_args ${local_addr} < "$sin" > "$sout" &
+					$extra_srv_args "::" < "$sin" > "$sout" &
 	fi
 	local spid=$!
 
@@ -2448,6 +2441,45 @@ v4mapped_tests()
 	fi
 }
 
+mixed_tests()
+{
+	# subflow IPv4-mapped to IPv4-mapped
+	if reset "simult IPv4 and IPv6 subflows, first is IPv4"; then
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		chk_join_nr 1 1 1
+	fi
+
+	# subflow IPv4-mapped to IPv4-mapped
+	if reset "simult IPv4 and IPv6 subflows, first is IPv6"; then
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
+		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
+		chk_join_nr 1 1 1
+	fi
+
+	if reset "simult IPv4 and IPv6 subflows, fullmesh 1x1"; then
+		pm_nl_set_limits $ns1 0 4
+		pm_nl_set_limits $ns2 1 4
+		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
+		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
+		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
+		chk_join_nr 1 1 1
+	fi
+
+	if reset "simult IPv4 and IPv6 subflows, fullmesh 2x2"; then
+		pm_nl_set_limits $ns1 0 4
+		pm_nl_set_limits $ns2 2 4
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
+		run_tests $ns1 $ns2 dead:beef:1::1 0 0 fullmesh_1 slow
+		chk_join_nr 4 4 4
+	fi
+}
+
 backup_tests()
 {
 	# single subflow, backup
@@ -3120,6 +3152,7 @@ all_tests_sorted=(
 	a@add_tests
 	6@ipv6_tests
 	4@v4mapped_tests
+	M@mixed_tests
 	b@backup_tests
 	p@add_addr_ports_tests
 	k@syncookies_tests
-- 
2.38.1

