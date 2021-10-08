Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6E92C83
	for <mptcp@lists.linux.dev>; Fri,  8 Oct 2021 17:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1633714112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U7lGM/T3wQHkl9pAJmRO5yFW5nLgMTVyOU4yUajy6ys=;
	b=gz9Xk3ON7Ti0/DWkOI+NEno8as2sf9h4Tlg+hKsjMHkUZQXKA/pUdqeiDFEMId7V6Bm6rK
	vD65dl1kVtxQJj2QEmAx+4T5TAcNZ+mRvUA3UGcsxVkAfdhbEyJrJozNFih6+xB0wCnlYH
	JHlHmOFCTnFwRfBhzLeEnm3/3MpYmtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-NH9yfHIXNu2-YYwOwLarJw-1; Fri, 08 Oct 2021 13:28:06 -0400
X-MC-Unique: NH9yfHIXNu2-YYwOwLarJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE3A310A8E02
	for <mptcp@lists.linux.dev>; Fri,  8 Oct 2021 17:28:05 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.167])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 54FD75D9DE
	for <mptcp@lists.linux.dev>; Fri,  8 Oct 2021 17:28:05 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] mptcp: increase default max additional subflows to 2
Date: Fri,  8 Oct 2021 19:27:59 +0200
Message-Id: <b7e5c73d59113afe32eec831b620997c86b56460.1633712415.git.pabeni@redhat.com>
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

The current default does not allowing additional subflows, mostly
as a safety restriction to avoid uncontrolled resource consumption
on busy servers.

Still the system admin and/or the application have to opt-in to
MPTCP explicitly. After that, they need to change (increase) the
default maximum number of additional subflows.

Let set that to reasonable default, and make end-users life easier.

Additionally we need to update some self-tests accordingly.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c                          | 3 +++
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 ++++-
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 6 +++---
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 050eea231528..f7d33a9abd57 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2052,6 +2052,9 @@ static int __net_init pm_nl_init_net(struct net *net)
 	struct pm_nl_pernet *pernet = net_generic(net, pm_nl_pernet_id);
 
 	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
+
+	/* Cit. 2 subflows ought to be enough for anybody. */
+	pernet->subflows_max = 2;
 	pernet->next_id = 1;
 	pernet->stale_loss_cnt = 4;
 	spin_lock_init(&pernet->lock);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 255793c5ac4f..293d349e21fe 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -945,12 +945,15 @@ subflows_tests()
 
 	# subflow limited by client
 	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 0
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 0
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, limited by client" 0 0 0
 
 	# subflow limited by server
 	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 0
 	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
@@ -973,7 +976,7 @@ subflows_tests()
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows" 2 2 2
 
-	# multiple subflows limited by serverf
+	# multiple subflows limited by server
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 3c741abe034e..cbacf9f6538b 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -70,7 +70,7 @@ check()
 
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 0" "defaults limits"
+subflows 2" "defaults limits"
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
@@ -118,11 +118,11 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 9 1
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 0" "rcv addrs above hard limit"
+subflows 2" "rcv addrs above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 1 9
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 0" "subflows above hard limit"
+subflows 2" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
-- 
2.26.3

