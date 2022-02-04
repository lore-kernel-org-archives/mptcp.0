Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69BA2C9C
	for <mptcp@lists.linux.dev>; Fri,  4 Feb 2022 18:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1643999622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uy30Kkwc28iiD0JcRveTF38kw/ho6PTLSdspXkHHDfE=;
	b=hBIB/93Ufhm23Vv/Cd8mJ9b81t1g/hlWSvL61976FG1FAHM5k+f+SIzJ7xU0eQAzKIuVhI
	AaSAVfeo/zB9xkToGLiIe3sPPCoIj/quRUCz3sjw+S0NBoQp8cBnrGRBfpK9Wt88et92ZY
	sE1pLJhx20SmF3v/hsi8Ng9k67L52Ak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-hkjtrz_kMnO4VYE3PlazJQ-1; Fri, 04 Feb 2022 13:33:39 -0500
X-MC-Unique: hkjtrz_kMnO4VYE3PlazJQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE066593BC
	for <mptcp@lists.linux.dev>; Fri,  4 Feb 2022 18:33:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.120])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2C248838CC
	for <mptcp@lists.linux.dev>; Fri,  4 Feb 2022 18:33:37 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] selftests: mptcp: improve 'fair usage on close' stability
Date: Fri,  4 Feb 2022 19:33:26 +0100
Message-Id: <eb310fd3bdfe3315ff17ebb865fd2f1e2957fd02.1643999595.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The mentioned tests has to wait for a subflow creation failure.
The current code looks for TCP sockets in TW state and sometimes
misses the relevant event. Switch to a more stable check, looking
for the associated mib counter.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/257
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 67be3e1215d7..556da9481730 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1137,14 +1137,14 @@ chk_link_usage()
 	fi
 }
 
-wait_for_tw()
+wait_attempt_fail()
 {
 	local timeout_ms=$((timeout_poll * 1000))
 	local time=0
 	local ns=$1
 
 	while [ $time -lt $timeout_ms ]; do
-		local cnt=$(ip netns exec $ns ss -t state time-wait |wc -l)
+		local cnt=$(ip netns exec $ns nstat -as TcpAttemptFails | grep TcpAttemptFails | awk '{print $2}')
 
 		[ "$cnt" = 1 ] && return 1
 		time=$((time + 100))
@@ -1256,7 +1256,7 @@ subflows_error_tests()
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	# mpj subflow will be in TW after the reset
-	wait_for_tw $ns2
+	wait_attempt_fail $ns2
 	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	wait
 
-- 
2.34.1

