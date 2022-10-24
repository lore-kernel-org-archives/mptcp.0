Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1713D6B
	for <mptcp@lists.linux.dev>; Mon, 24 Oct 2022 16:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666628852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uLShuQQJBTIze5mi5eZcQOLsMIsA3IB4JJCn8+dtM0c=;
	b=hWBiBAke/e8DG2SV8SYZPb3jpvFlDjHRbntyw59Xlm1oCzv8VoCRyY+lbONQ3bogbrEMDe
	yb2l9ncfXSug1h8z6KdJOw+sVz+oFxXJWrSk2y8B3hN79ydcVhJsKVqQf3ue3qM1O5Quwv
	BM6h4hm2xtb2BFYJUZGP+qnRWS9ybvA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-HGyWsGUfPxeMekRkPaCIsg-1; Mon, 24 Oct 2022 12:27:31 -0400
X-MC-Unique: HGyWsGUfPxeMekRkPaCIsg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DA9A3815D23
	for <mptcp@lists.linux.dev>; Mon, 24 Oct 2022 16:27:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.104])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 932F040C6FA0
	for <mptcp@lists.linux.dev>; Mon, 24 Oct 2022 16:27:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] selftests: mptcp: gives slow test-case more time
Date: Mon, 24 Oct 2022 18:27:19 +0200
Message-Id: <680973297b6995126f49732c0828ccfce8865c72.1666628806.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

On slow or busy VM, some test-cases still fail because the
data transfer completes before the endpoint manipulation
actually took effect.

Address the issue by artificially increasing the runtime for
the relevant test-cases.

Fixes: ef360019db40 ("selftests: mptcp: signal addresses testcases")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/309
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f3dd5f2a0272..2eeaf4aca644 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2152,7 +2152,7 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 speed_10
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
@@ -2165,7 +2165,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
@@ -2178,7 +2178,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
-- 
2.37.3

