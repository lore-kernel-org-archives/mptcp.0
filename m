Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C072CB2
	for <mptcp@lists.linux.dev>; Thu,  9 Dec 2021 17:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639071057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUbHfEkBVZFqyfcVCTKPBzllnLy+pacN825Gg+lW4E8=;
	b=GJJaH4VcCbgtfjsJqH+XL9mwrkO3VOncEcsdWI+2b3IWy2U56o7XT7kZZaje0wleQ6wgGt
	Et6dokTuNNGyMPUj/ZtCEydTZY3uv5bAiLCZeHDbsOYgxIWI4uljl7aq3LbmyrRA0UJGRL
	EyhvhR0HRFGY55eWuPu32KOlRyRvR0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-VeUaO0LTN4uK6IM-aMj3Zw-1; Thu, 09 Dec 2021 12:30:53 -0500
X-MC-Unique: VeUaO0LTN4uK6IM-aMj3Zw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4A52190A7A0
	for <mptcp@lists.linux.dev>; Thu,  9 Dec 2021 17:30:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 352A55E26C
	for <mptcp@lists.linux.dev>; Thu,  9 Dec 2021 17:30:52 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v5 5/5] selftests: mptcp: add tests for subflow creation failure
Date: Thu,  9 Dec 2021 18:30:42 +0100
Message-Id: <bb1dc0bcbce70153d37c89969b82d3e9695acf4a.1639070864.git.pabeni@redhat.com>
In-Reply-To: <cover.1639070864.git.pabeni@redhat.com>
References: <cover.1639070864.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Verify that, when multiple endpoints are available, subflows
creation proceed even when the first additional subflow creation
fails - due to packet drop on the relevant link

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
 - new test checking for wrong MPC reuse

v3 -> v4:
 - use $() where applicable - Matt
 - fix typo in help() - Matt

v1 -> v2:
 - add missing NF kconfig
 - add more test-cases (drop, later subflow creation)
---
 tools/testing/selftests/net/mptcp/config      |  1 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 74 ++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 419e71560fd1..41e94e004bdc 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -18,4 +18,5 @@ CONFIG_NFT_TPROXY=m
 CONFIG_NFT_SOCKET=m
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 526b05771d08..8f49bbd4a201 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -975,6 +975,22 @@ chk_link_usage()
 	fi
 }
 
+wait_for_tw()
+{
+	local timeout_ms=$((timeout_poll * 1000))
+	local time=0
+	local ns=$1
+
+	while [ $time -lt $timeout_ms ]; do
+		local cnt=$(ip netns exec $ns ss -t state time-wait |wc -l)
+
+		[ "$cnt" = 1 ] && return 1
+		time=$((time + 100))
+		sleep 0.1
+	done
+	return 1
+}
+
 subflows_tests()
 {
 	reset
@@ -1032,6 +1048,57 @@ subflows_tests()
 	chk_join_nr "single subflow, dev" 1 1 1
 }
 
+subflows_error_tests()
+{
+	# If a single subflow is configured, and matches the MPC src
+	# address, no additional subflow should be created
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+	chk_join_nr "no MPC address reuse with single endpoint" 0 0 0
+
+	# multiple subflows, with subflow creation error
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+	chk_join_nr "multiple subflows, with failing subflow" 1 1 1
+
+	# multiple subflows, with subflow timeout on MPJ
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+	chk_join_nr "multiple subflows, with subflow timeout" 1 1 1
+
+	# multiple subflows, check that the endpoint corresponding to
+	# closed subflow (due to reset) is not reused if additional
+	# subflows are added later
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
+
+	# mpj subflow will be in TW after the reset
+	wait_for_tw $ns2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	wait
+
+	# additional subflow could be created only if the PM select
+	# the later endpoint, skipping the already used one
+	chk_join_nr "multiple subflows, fair usage on close" 1 1 1
+}
+
 signal_address_tests()
 {
 	# add_address, unused
@@ -1843,6 +1910,7 @@ fullmesh_tests()
 all_tests()
 {
 	subflows_tests
+	subflows_error_tests
 	signal_address_tests
 	link_failure_tests
 	add_addr_timeout_tests
@@ -1862,6 +1930,7 @@ usage()
 {
 	echo "mptcp_join usage:"
 	echo "  -f subflows_tests"
+	echo "  -e subflows_error_tests"
 	echo "  -s signal_address_tests"
 	echo "  -l link_failure_tests"
 	echo "  -t add_addr_timeout_tests"
@@ -1910,11 +1979,14 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fsltra64bpkdmchCS' opt; do
+while getopts 'fesltra64bpkdmchCS' opt; do
 	case $opt in
 		f)
 			subflows_tests
 			;;
+		e)
+			subflows_error_tests
+			;;
 		s)
 			signal_address_tests
 			;;
-- 
2.33.1

