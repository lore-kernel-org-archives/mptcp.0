Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3A6210C
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 09:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651655215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RRtGGflumDbG73bvkOBuq/donOwcIYR0prX/WpRC3ao=;
	b=Bn0jYWHsioVFTx/PSSvBSnon4ayv/NEos62iyUUWyaY1m5+rTctWI8mPaGTJIAFhoAqUeX
	RYMVKd8WxFNYehz6zi4RvmuCYEqednx/f/slIoeHxYD0/jj4ZNh5NtIOx2SSUM/pYMplAl
	fhAyHAgQkggkfLhWjEUIvMfbjnp9RYU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-ButyMb6PNQOAud5RbM3eEg-1; Wed, 04 May 2022 05:06:54 -0400
X-MC-Unique: ButyMb6PNQOAud5RbM3eEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51D0C1C08961
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 09:06:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D6191C4C7A8
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 09:06:53 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2] selftests: mptcp: fix MP_FAIL test-case
Date: Wed,  4 May 2022 11:06:48 +0200
Message-Id: <613074c6f6136ebb652df581fbb3d7de02fb8e33.1651655175.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
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
v1 -> v2:
 - slow the transfer even more (Mat)
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b703b61562bf..c4121a721b54 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2707,7 +2707,7 @@ fail_tests()
 
 	# multiple subflows
 	if reset_with_fail "MP_FAIL MP_RST" 2; then
-		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 20mbit delay 1
+		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 1mbit delay 5
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
-- 
2.35.1

