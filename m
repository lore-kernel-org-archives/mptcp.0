Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05BA2C9C
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 19:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644347197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjyLRsATisKMfjqiT3pKbCmM2hXi2rvfQiTVWDRgKJY=;
	b=cCklNAb1FWOfQkxloZ6XP/QtISoZi+8U9TMDO5x746TgFAmb64Gj/cqoZBuSsA/Hin6uMr
	LREinI3xOhWwaLkabQeZeV/Bigm56CgejTRoPP+wikkjgZ7TT2b4S92prZ41zBnkS2Sevp
	r/Xr+TzV/0WHP3uiE3al7kHVOvHzx3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-KO2RnX64N16yvFL2ewiJtg-1; Tue, 08 Feb 2022 14:06:33 -0500
X-MC-Unique: KO2RnX64N16yvFL2ewiJtg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3DBD1DDE9
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 19:06:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.58])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 23D9360BF4
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 19:06:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 1/4] mptcp: fix race in overlapping signal events
Date: Tue,  8 Feb 2022 20:06:15 +0100
Message-Id: <fe2ee45c579ea83d5aec853c80d6088aebc6ef26.1644346664.git.pabeni@redhat.com>
In-Reply-To: <cover.1644346664.git.pabeni@redhat.com>
References: <cover.1644346664.git.pabeni@redhat.com>
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

