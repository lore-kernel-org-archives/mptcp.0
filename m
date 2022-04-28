Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A589B136B
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 16:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651165114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/jg3+WJuWIJlkiMbVFNQziYfESj2A3tSjLcWt6LM/M=;
	b=VLGr/vlkze/wsnKK3t6SGtLbcQNOZZFstNgJ7DYqt67In+xwE9gYs4Qcl52xQBqOQjuMGp
	Xfe5XJoNKtfvRxWBzVLeFap/N/28U8tB0Ru3WVEUT4iisj+JIPJNCGHTsjFNIieQ1yn49V
	iL2j2MzESY9mSAP9H4NyyJSuvlOB7bc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-eFriXE0cMpCXhMVANBpaag-1; Thu, 28 Apr 2022 12:58:32 -0400
X-MC-Unique: eFriXE0cMpCXhMVANBpaag-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E826804195
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 16:58:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.120])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1A94357354B
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 16:58:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 2/2] selftests: mptcp: add subflow limits test-cases
Date: Thu, 28 Apr 2022 18:58:24 +0200
Message-Id: <df068e913873450bfbcabe98f4d4461178278264.1651165091.git.pabeni@redhat.com>
In-Reply-To: <84bfd492fa6e4a5ca5c90201283c48ed07318aa9.1651165091.git.pabeni@redhat.com>
References: <84bfd492fa6e4a5ca5c90201283c48ed07318aa9.1651165091.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Add and deletes a bunch of endpoints and verify the
respect of configured limits.

This covers the codepath intersted by the previous patch.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 48 ++++++++++++++++++-
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b703b61562bf..a98fee834950 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1571,6 +1571,33 @@ chk_prio_nr()
 	[ "${dump_stats}" = 1 ] && dump_stats
 }
 
+chk_subflow_nr()
+{
+	local need_title="$1"
+	local msg="$2"
+	local subflow_nr=$3
+	local cnt1
+	local cnt2
+
+	if [ -n "${need_title}" ]; then
+		printf "%03u %-36s %s" "${TEST_COUNT}" "${TEST_NAME}" "${msg}"
+	else
+		printf "%-${nr_blank}s %s" " " "${msg}"
+	fi
+
+	cnt1=$(ss -N $ns1 -tOni | grep -c token)
+	cnt2=$(ss -N $ns2 -tOni | grep -c token)
+	if [ "$cnt1" != "$subflow_nr" -o "$cnt2" != "$subflow_nr" ]; then
+		echo "[fail] got $cnt1:$cnt2 subflows expected $subflow_nr"
+		fail_test
+		dump_stats=1
+	else
+		echo "[ ok ]"
+	fi
+
+	[ "${dump_stats}" = 1 ] && ( ss -N $ns1 -tOni ; ss -N $ns1 -tOni | grep token; ip -n $ns1 mptcp endpoint )
+}
+
 chk_link_usage()
 {
 	local ns=$1
@@ -2784,7 +2811,7 @@ userspace_tests()
 	fi
 }
 
-implicit_tests()
+endpoint_tests()
 {
 	# userspace pm type prevents add_addr
 	if reset "implicit EP"; then
@@ -2806,6 +2833,23 @@ implicit_tests()
 			$ns2 10.0.2.2 id 1 flags signal
 		wait
 	fi
+
+	if reset "delete and re-add"; then
+		pm_nl_set_limits $ns1 1 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
+
+		wait_mpj $ns2
+		pm_nl_del_endpoint $ns2 2 10.0.2.2
+		sleep 0.5
+		chk_subflow_nr needtitle "after delete" 1
+
+		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+		wait_mpj $ns2
+		chk_subflow_nr "" "after re-add" 2
+		wait
+	fi
 }
 
 # [$1: error message]
@@ -2854,7 +2898,7 @@ all_tests_sorted=(
 	z@fastclose_tests
 	F@fail_tests
 	u@userspace_tests
-	I@implicit_tests
+	I@endpoint_tests
 )
 
 all_tests_args=""
-- 
2.35.1

