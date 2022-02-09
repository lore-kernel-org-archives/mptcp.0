Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946F42CA2
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 09:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644400064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjyLRsATisKMfjqiT3pKbCmM2hXi2rvfQiTVWDRgKJY=;
	b=IW6bwFyR79ZVJrV5OQSSe6EDctYmCSPRe1qh67g1e0c0qyQXtBCWl8XxoekfE5CJvkf2d9
	jsSKRudlBnZ3R9jErFJEals9wtpQKap/tAOIPO/8yhKsCjSae7a3z3uH8JakyPaRh1diWn
	o4nmBW69FNPYIZvaTD7FX+1KxKkTkZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-ExglTkV4O4WdB4_AX_3fnQ-1; Wed, 09 Feb 2022 04:47:39 -0500
X-MC-Unique: ExglTkV4O4WdB4_AX_3fnQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8527E192AB6E
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 09:47:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.181])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E8EDCE2C6
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 09:47:37 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v3 1/4] mptcp: fix race in overlapping signal events
Date: Wed,  9 Feb 2022 10:47:30 +0100
Message-Id: <fe2ee45c579ea83d5aec853c80d6088aebc6ef26.1644399915.git.pabeni@redhat.com>
In-Reply-To: <cover.1644399915.git.pabeni@redhat.com>
References: <cover.1644399915.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
 net/mptcp/pm_netlink.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

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
-- 
2.34.1

