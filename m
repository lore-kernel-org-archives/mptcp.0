Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C3D2C82
	for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 16:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637685457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPsqPmUhjdtr+Ypa7O1h7KtrXKdXWPHMHE/CBn+qgTw=;
	b=dxMngdmZ1cUZH90Bc/140tNgc0viKrXjj0N5YpOtTGSMfeLT8qJ5f1xv+LK8T83gNw5YVv
	RkRcMg2bYBYOQMWG+zjFoc8T8F6HiV65PejUNuhvnQYScZoAZP+oj+gwbRypwGHPFHPe6Q
	Rk2AR4QpBDGUcGi4aH+LYETzFcGYj78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-sPMZ4IYQP8-4hdTunXjCmQ-1; Tue, 23 Nov 2021 11:37:35 -0500
X-MC-Unique: sPMZ4IYQP8-4hdTunXjCmQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A25FD425C8;
	Tue, 23 Nov 2021 16:37:34 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.149])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DA7D557CAD;
	Tue, 23 Nov 2021 16:37:33 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Phil Greenland <phil@quantulum.co.uk>
Subject: [PATCH mptcp-next 3/3] selftests: mptcp: add tests for subflow creation failure
Date: Tue, 23 Nov 2021 17:37:12 +0100
Message-Id: <425cdb61dc939d86534843617150634869778909.1637684792.git.pabeni@redhat.com>
In-Reply-To: <cover.1637684792.git.pabeni@redhat.com>
References: <cover.1637684792.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Verify that, when multiple endpoints are available, subflows
creation proceed even when the first additional subflow creation
fails - due to packet drop on the relevant link

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2684ef9c0d42..dd4488746151 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1023,6 +1023,16 @@ subflows_tests()
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows, limited by server" 2 2 1
 
+	# multiple subflows, with subflow creation error
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "multiple subflows, with failing subflow" 1 1 1
+
 	# single subflow, dev
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-- 
2.33.1

