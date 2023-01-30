Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D6C6AA3
	for <mptcp@lists.linux.dev>; Mon, 30 Jan 2023 18:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675101973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BbGG6tOcuiy8dZcBaTsQPxqJsfDizh+6Z142lxBPDDo=;
	b=CZ4FeW8SBgCCCI5SQE1vebHBy5nW2i8Wm0e7CUTbVlQ/IvIe9/mMa0JbPeXT7MOKYK8KrV
	4aQoTDsEg6niX7a3rd9w+1/mouxdHaxXB86Yz+R0Y9JZHFa6iEIJJwBGxI/9pIoTEWghCi
	1iKhqaZxctGK6VWILsQIvQMLPkWBD2s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-_uiuLKSpP2i9e0sLNxXBxQ-1; Mon, 30 Jan 2023 13:06:12 -0500
X-MC-Unique: _uiuLKSpP2i9e0sLNxXBxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07E61101A521
	for <mptcp@lists.linux.dev>; Mon, 30 Jan 2023 18:06:12 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.233])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8AF07C15BAD
	for <mptcp@lists.linux.dev>; Mon, 30 Jan 2023 18:06:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] selftests: mptcp: allow more slack for slow test-case
Date: Mon, 30 Jan 2023 19:06:01 +0100
Message-Id: <9da09e4407af3ccd51489686c71a3c07c2cb6d3b.1675101940.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

A test-case is frequently failing on some extremelly slow VMs.
The mptcp transfer completes before the script is able to do
all the required PM manipulation.

Address the issue in the simplest possible way, making the
transfer even more slow.

Additionally dump more info in case of failures, to help debugging
similar problems in the future.

Fixes: e274f7154008 ("selftests: mptcp: add subflow limits test-cases")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
this is just a wild guess, since I can't repro the issue at all. Ideally
it would be great to have a loop with mpj 115 to validate this
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 387abdcec011..4e428871f961 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1704,7 +1704,12 @@ chk_subflow_nr()
 		echo "[ ok ]"
 	fi
 
-	[ "${dump_stats}" = 1 ] && ( ss -N $ns1 -tOni ; ss -N $ns1 -tOni | grep token; ip -n $ns1 mptcp endpoint )
+	if [ "${dump_stats}" = 1 ]; then
+		ss -N $ns1 -tOni
+		ss -N $ns1 -tOni | grep token
+		ip -n $ns1 mptcp endpoint
+		dump_stats
+	fi
 }
 
 chk_link_usage()
@@ -3103,7 +3108,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 slow &
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 &
 
 		wait_mpj $ns2
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
-- 
2.39.1

