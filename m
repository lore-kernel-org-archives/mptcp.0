Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ADE10E8
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 09:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655891235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QVDcxwFosBl9KznFRwX3knXDH8xbKiMHn89A1N7ZNGo=;
	b=a7oMy1lemxHyc2F48/4uUwBshhVZos3AI+UiWI3aeiCdPklQUb1gqlQboA/7QB3B82qjD0
	kfMUdlmdwqYekZMRDa+m5rJFymXc2WWbtOhPG+38c4KbFQhELeCGjgM1ZatOBYWGYWtuvi
	s2G60kIJAH7Sxcd/vgute1IJJOrd6Ks=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-SLg5aBY8O8ujPyE3fh7jYg-1; Wed, 22 Jun 2022 05:47:14 -0400
X-MC-Unique: SLg5aBY8O8ujPyE3fh7jYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C635E29DD98E
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 09:47:13 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.233])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 585312166B29
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 09:47:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] Squash-to: "selftests: mptcp: more stable diag tests"
Date: Wed, 22 Jun 2022 11:47:05 +0200
Message-Id: <f1109179c77a14bed80be75bb297aac1ef867a49.1655891188.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The "....chk remote_key" testcase is failing quite often in debug
build. I guess the mptcp_connect completes before the script execute
this latter test, so I'm adding another large wait. It should not
impact the test run-time, as the mptcp_connect processes are terminated
just after running the check.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
this is wild guess, mostly to trigger/inspect the test results
---
 tools/testing/selftests/net/mptcp/diag.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index ee2f238255ec..515859a5168b 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -179,7 +179,7 @@ ip -n $ns link set dev lo up
 echo "a" | \
 	timeout ${timeout_test} \
 		ip netns exec $ns \
-			./mptcp_connect -p 10000 -l -t ${timeout_poll} \
+			./mptcp_connect -p 10000 -l -t ${timeout_poll} -w 20 \
 				0.0.0.0 >/dev/null &
 wait_local_port_listen $ns 10000
 chk_msk_nr 0 "no msk on netns creation"
@@ -188,7 +188,7 @@ chk_msk_listen 10000
 echo "b" | \
 	timeout ${timeout_test} \
 		ip netns exec $ns \
-			./mptcp_connect -p 10000 -r 0 -t ${timeout_poll} \
+			./mptcp_connect -p 10000 -r 0 -t ${timeout_poll} -w 20 \
 				127.0.0.1 >/dev/null &
 wait_connected $ns 10000
 chk_msk_nr 2 "after MPC handshake "
@@ -200,13 +200,13 @@ flush_pids
 echo "a" | \
 	timeout ${timeout_test} \
 		ip netns exec $ns \
-			./mptcp_connect -p 10001 -l -s TCP -t ${timeout_poll} \
+			./mptcp_connect -p 10001 -l -s TCP -t ${timeout_poll} -w 20 \
 				0.0.0.0 >/dev/null &
 wait_local_port_listen $ns 10001
 echo "b" | \
 	timeout ${timeout_test} \
 		ip netns exec $ns \
-			./mptcp_connect -p 10001 -r 0 -t ${timeout_poll} \
+			./mptcp_connect -p 10001 -r 0 -t ${timeout_poll} -w 20 \
 				127.0.0.1 >/dev/null &
 wait_connected $ns 10001
 chk_msk_fallback_nr 1 "check fallback"
-- 
2.35.3

