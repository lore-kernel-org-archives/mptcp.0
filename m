Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5832F27
	for <mptcp@lists.linux.dev>; Wed,  2 Feb 2022 18:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1643825803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eRLaX03eYOHxyB8cdtCeTsUi57Gkyna96GOrvSSbkf4=;
	b=VAODTfwx1kqcUTC8haLky7KtGvkp5azxEVs7WMr8alOIgdKqJgssgM+Ji8gIKVQ4E/jq+r
	+pR2Mlr4iKEDnjTEYZBVxVMfytaguLnpW9lMOzsQrENwm3gP5EC1L4WB6OB2OwwBzUk+h4
	CxxMxAmw5QbS1kXCLik5mh4Si4XTmWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-hIEawCOqMD6GknJ7JRMxbw-1; Wed, 02 Feb 2022 13:16:42 -0500
X-MC-Unique: hIEawCOqMD6GknJ7JRMxbw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75C45100F95F
	for <mptcp@lists.linux.dev>; Wed,  2 Feb 2022 18:15:17 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B8C197B9D3
	for <mptcp@lists.linux.dev>; Wed,  2 Feb 2022 18:15:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] selftests: mptcp: fix diag instability
Date: Wed,  2 Feb 2022 19:15:07 +0100
Message-Id: <8e7b626d99b8c28b8638f850841707c63deb0bb4.1643825648.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Increase the time waiting for mptcp sockets to get established,
to cope with very slow running host, or high jitter caused by
VMs.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
note: just to trigger the public CI, probably a better commit
message needed
---
 tools/testing/selftests/net/mptcp/diag.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 2674ba20d524..baafd36c3e0e 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -87,9 +87,9 @@ chk_msk_nr 0 "no msk on netns creation"
 echo "b" | \
 	timeout ${timeout_test} \
 		ip netns exec $ns \
-			./mptcp_connect -p 10000 -j -t ${timeout_poll} \
+			./mptcp_connect -p 10000 -r 0 -t ${timeout_poll} \
 				127.0.0.1 >/dev/null &
-sleep 0.1
+sleep 0.4
 chk_msk_nr 2 "after MPC handshake "
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
@@ -105,9 +105,9 @@ sleep 0.1
 echo "b" | \
 	timeout ${timeout_test} \
 		ip netns exec $ns \
-			./mptcp_connect -p 10001 -j -t ${timeout_poll} \
+			./mptcp_connect -p 10001 -r 0 -t ${timeout_poll} \
 				127.0.0.1 >/dev/null &
-sleep 0.1
+sleep 0.4
 chk_msk_fallback_nr 1 "check fallback"
 flush_pids
 
-- 
2.34.1

