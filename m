Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495B02CA2
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 09:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644400063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rH5USFWdLZjhEFfoKpz9D+T6Eoe4ntVi1Mzlbs2xw60=;
	b=QVLwz+A7m2DkOMCt01AFfj1ZFZglS1y/5ZOiv3ZHiVgkKXn1PvJE6NYHke3Lxrr9cfr/OU
	UjqENASCP68WlKpczvCsr3U7ZyFDH4VUkjdllcxnAhZZtkudYGW8jIqcE3pHJ4HVYuMdFy
	0xsCmJgmvDEVOMjuflmkIPuzqEeO5eM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-YoovWK5QMxedmYoohEZrDQ-1; Wed, 09 Feb 2022 04:47:42 -0500
X-MC-Unique: YoovWK5QMxedmYoohEZrDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 565DF5AB7
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 09:47:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.181])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BCB5428546
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 09:47:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v3 4/4] selftests: mptcp: more robust signal race test
Date: Wed,  9 Feb 2022 10:47:33 +0100
Message-Id: <c0b8e7977c39404938459ee58f3b5d9f41f522dd.1644399915.git.pabeni@redhat.com>
In-Reply-To: <cover.1644399915.git.pabeni@redhat.com>
References: <cover.1644399915.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The in kernel MPTCP PM implementation can process a single
incoming add address option at any given time. In the
mentioned test the server can surpas such limit. Let the
setup cope with that allowing a faster add_addr retransmission.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 90a6adc36490..66ac990415e6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -915,11 +915,17 @@ chk_add_nr()
 	local mis_ack_nr=${8:-0}
 	local count
 	local dump_stats
+	local timeout
+
+	timeout=`ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout`
 
 	printf "%-${nr_blank}s %s" " " "add"
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtAddAddr | awk '{print $2}'`
+	count=`ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}'`
 	[ -z "$count" ] && count=0
-	if [ "$count" != "$add_nr" ]; then
+
+	# if the test configured a short timeout tolerate greater then expected
+	# add addrs options, due to retransmissions
+	if [ "$count" != "$add_nr" ] && [ "$timeout" -gt 1 -o "$count" -lt "$add_nr" ]; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
 		ret=1
 		dump_stats=1
@@ -1311,6 +1317,7 @@ signal_address_tests()
 
 	# signal addresses race test
 	reset
+
 	pm_nl_set_limits $ns1 4 4
 	pm_nl_set_limits $ns2 4 4
 	pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
@@ -1321,7 +1328,10 @@ signal_address_tests()
 	pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 	pm_nl_add_endpoint $ns2 10.0.3.2 flags signal
 	pm_nl_add_endpoint $ns2 10.0.4.2 flags signal
-	run_tests $ns1 $ns2 10.0.1.1
+
+	# the peer could possibly miss some addr notification, allow retransmission
+	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "signal addresses race test" 3 3 3
 
 	# the server will not signal the address terminating
-- 
2.34.1

