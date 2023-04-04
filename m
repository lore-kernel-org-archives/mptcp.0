Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C136AA7
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 11:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680608482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCVT/8sWXl9/u7NK+BsAoGBwBLEPTZoY7L0y0uDzQ6A=;
	b=jJAqVFGvu8jZjlrNrhiiuimn7A7yfXt8ZmMGEi8UtBJMi9uLDHYhn6M+CYiH03FOgNVqfm
	Ckhe59ypcWGS9ytmL69pmCi5huySQew6vBUmeav0XedJTIcXIYSjuqjTegKmySi2U6A5DP
	3USc0rUsYDsQcr3kND/k9/d2Ejghvzk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-IiKup15fNUmjRI0dfm9vKw-1; Tue, 04 Apr 2023 07:41:21 -0400
X-MC-Unique: IiKup15fNUmjRI0dfm9vKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41A1588B7A0
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 11:41:21 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CF3B1440BC
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 11:41:20 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/3] selftests: mptcp: add explicit check for new mibs
Date: Tue,  4 Apr 2023 13:41:03 +0200
Message-Id: <6359825ee830b746fcd738c23063609b9dea3124.1680544063.git.pabeni@redhat.com>
In-Reply-To: <cover.1680544063.git.pabeni@redhat.com>
References: <cover.1680544063.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Instead of duplicating the all existing TX check with
the TX side, add the new ones on selected test cases.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 095ddd747ffc..14728c81777f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1579,6 +1579,44 @@ chk_add_nr()
 	[ "${dump_stats}" = 1 ] && dump_stats
 }
 
+chk_add_tx_nr()
+{
+	local add_tx_nr=$1
+	local echo_tx_nr=$2
+	local dump_stats
+	local timeout
+	local count
+
+	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
+
+	printf "%-${nr_blank}s %s" " " "add TX"
+	count=$(ip netns exec $ns1 nstat -as MPTcpExtAddAddrTx | grep MPTcpExtAddAddrTx | awk '{print $2}')
+	[ -z "$count" ] && count=0
+
+	# if the test configured a short timeout tolerate greater then expected
+	# add addrs options, due to retransmissions
+	if [ "$count" != "$add_tx_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_tx_nr" ]; }; then
+		echo "[fail] got $count ADD_ADDR[s] TX, expected $add_tx_nr"
+		fail_test
+		dump_stats=1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - echo TX "
+	count=$(ip netns exec $ns2 nstat -as MPTcpExtEchoAddTx | grep MPTcpExtEchoAddTx | awk '{print $2}')
+	[ -z "$count" ] && count=0
+	if [ "$count" != "$echo_tx_nr" ]; then
+		echo "[fail] got $count ADD_ADDR echo[s] TX, expected $echo_tx_nr"
+		fail_test
+		dump_stats=1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	[ "${dump_stats}" = 1 ] && dump_stats
+}
+
 chk_rm_nr()
 {
 	local rm_addr_nr=$1
@@ -1654,6 +1692,26 @@ chk_rm_nr()
 	echo "$extra_msg"
 }
 
+chk_rm_tx_nr()
+{
+	local rm_addr_tx_nr=$1
+
+	printf "%-${nr_blank}s %s" " " "rm TX "
+	count=$(ip netns exec $ns2 nstat -as MPTcpExtRmAddrTx | grep MPTcpExtRmAddrTx | awk '{print $2}')
+	[ -z "$count" ] && count=0
+	if [ "$count" != "$rm_addr_nr" ]; then
+		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
+		fail_test
+		dump_stats=1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	[ "${dump_stats}" = 1 ] && dump_stats
+
+	echo "$extra_msg"
+}
+
 chk_prio_nr()
 {
 	local mp_prio_nr_tx=$1
@@ -1933,6 +1991,7 @@ signal_address_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
+		chk_add_tx_nr 1 1
 		chk_add_nr 1 1
 	fi
 
@@ -2114,6 +2173,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 1 1 1
+		chk_add_tx_nr 4 0
 		chk_add_nr 4 0
 	fi
 
@@ -2159,6 +2219,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
 		chk_join_nr 1 1 1
+		chk_rm_tx_nr 1 1
 		chk_rm_nr 1 1
 	fi
 
@@ -2257,6 +2318,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 		chk_join_nr 3 3 3
+		chk_rm_tx_nr 0
 		chk_rm_nr 0 3 simult
 	fi
 
-- 
2.39.2

