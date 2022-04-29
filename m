Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E121852
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 16:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651248339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rnWBXwrSoA5xnKY+aLt0YB01NHwI9mtlZHuCnKUZGfs=;
	b=D54YWvzganRt5+LMvJagimHmddytNfHW0iCOegLfbJQNOcPwWFa36uXcOuADQLm0NUA3Pv
	LRRaV6/baHXQ0kPM1VNbuM1iFNIIuUm6gfuu4OTsnvDQgSxhVnVZQCFDQcWLTyRaU6GR4Y
	KDQI4pT5ir9R+igAN356eCoRwaYQJy4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-Scdc5XmJOMO3CnJCk2a0Xg-1; Fri, 29 Apr 2022 12:05:38 -0400
X-MC-Unique: Scdc5XmJOMO3CnJCk2a0Xg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7EF528070AD
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 16:05:37 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.69])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6CF62200D8D1
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 16:05:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] selftests: mptcp: fix MP_FAIL test-case
Date: Fri, 29 Apr 2022 18:04:30 +0200
Message-Id: <a4e7a052279a027da6721d59dbd293b0bb7e08cf.1651248223.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The mentioned tests sometimes fails because the data
transfer completes before any packet is sent on the 2nd
link (the failing one).

Address the issue reducing the "virtual" b/w available
on the primary link.

Fixes: bfd4cdbe7032 ("selftests: mptcp: add MP_FAIL reset testcase")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
together with the previous patch this fixes issues/265 for
good here. I'm not adding the Close tag due to the mentioned
dep, which may take a different/longer route
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a98fee834950..0d65295c1b33 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2734,7 +2734,7 @@ fail_tests()
 
 	# multiple subflows
 	if reset_with_fail "MP_FAIL MP_RST" 2; then
-		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 20mbit delay 1
+		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 10mbit delay 5
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
-- 
2.35.1

