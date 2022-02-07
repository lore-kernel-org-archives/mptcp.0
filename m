Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7FC2F25
	for <mptcp@lists.linux.dev>; Mon,  7 Feb 2022 20:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644266398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kKEnrjIVAYGeLAO9DikDPixTa5gigsiEuDD5Sm8ad6Y=;
	b=YInI8qGQX/WKvUUM7MQi6D2fsI8iyPMQKcwR7DcLFrwA17lQLPzB/c/l5onS7GNGBU5CUt
	7Fi3nmVdh/h8fgY8DBqvURVqynSTo80mkcZrrQ9zN4mVbDcQ695Wky8RQQKddOORIYu5ru
	EIPrNyYkMyPd1+zp+WqSugrSqZLMRbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-mt7ZJNLcOza21wV0SVJoMg-1; Mon, 07 Feb 2022 15:39:56 -0500
X-MC-Unique: mt7ZJNLcOza21wV0SVJoMg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC299108087A
	for <mptcp@lists.linux.dev>; Mon,  7 Feb 2022 20:39:55 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3F5583AF4
	for <mptcp@lists.linux.dev>; Mon,  7 Feb 2022 20:39:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: fix race in overlapping signal events
Date: Mon,  7 Feb 2022 21:39:49 +0100
Message-Id: <c5d17a37b8ad315e72dd8551e148017a66987f7f.1644266387.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

After commit a88c9e496937 ("mptcp: do not block subflows
creation on errors"), if a signal address races with a failing
subflow creation, the subflow creation failure control path
can trigger the selection of the next address to be announced
while the current announced is still pending.

The above will cause the unintended suppression of the ADD_ADDR
announce.

Fix the issue skipping the to-be-suppressed announce before it
will mark an endpoint as already used. The relevant announce
will be triggered again when the current one will complete.

Fixes: a88c9e496937 ("mptcp: do not block subflows creation on errors")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c                          | 10 ++++++++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 93800f32fcb6..fb8d4bfcfbd6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -546,6 +546,16 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
 		local = select_signal_address(pernet, msk);
 
+		/* due to racing events on both ends we can reach here while
+		 * previous add address is still running: if we invoke now
+		 * mptcp_pm_announce_addr(), that will fail and the
+		 * corresponding id will be marked as used.
+		 * Instead let the PM machinery reschedule us when the
+		 * current address announce will be completed.
+		 */
+		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
+			return;
+
 		if (local) {
 			if (mptcp_pm_alloc_anno_list(msk, local)) {
 				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 007223364718..ba32ea616206 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1341,7 +1341,7 @@ signal_address_tests()
 	pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 	pm_nl_add_endpoint $ns2 10.0.3.2 flags signal
 	pm_nl_add_endpoint $ns2 10.0.4.2 flags signal
-	run_tests $ns1 $ns2 10.0.1.1
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "signal addresses race test" 3 3 3
 
 	# the server will not signal the address terminating
-- 
2.34.1

