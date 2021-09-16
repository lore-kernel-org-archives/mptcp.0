Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E953FC5
	for <mptcp@lists.linux.dev>; Thu, 16 Sep 2021 19:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1631821964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nmkdw8wTTqs2u/2XZ3OIow9EyLZzmiLWkLf42zuLkd4=;
	b=VtrV5V/VpZPP3UQqMKQD2QpXZNsIdBOfCXkN68xy5/BmjR3snWsFuE+H94cF7r/nNdL8Oc
	Ocp3pNPfVQZIrTVzm7bZLV/YkRGlYdpssf2td7R/liArIxObRW2PVRUlXyNDDyX7GhOLSp
	tlpxSRPiuNnGLAT2sqIrm7iAUG9jR78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-zOYq-MGbMMuWwQg2687DFA-1; Thu, 16 Sep 2021 15:52:43 -0400
X-MC-Unique: zOYq-MGbMMuWwQg2687DFA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D79F824FA7;
	Thu, 16 Sep 2021 19:52:42 +0000 (UTC)
Received: from dcaratti.station (unknown [10.40.192.127])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7934E7E464;
	Thu, 16 Sep 2021 19:52:41 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: allow changing the 'backup' bit when no sockets are open
Date: Thu, 16 Sep 2021 21:52:29 +0200
Message-Id: <db472a753375c011d3dc7b810262935473e481aa.1631821658.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

current Linux refuses to change the 'backup' bit of MPTCP endpoints, i.e.
using MPTCP_PM_CMD_SET_FLAGS, unless it finds (at least) one subflow that
matches the endpoint address. There is no reason for that, so we can make
mptcp_nl_addr_backup() return without error even when 0 MPTCP sockets are
open and no MP_PRIO message is sent out.

Fixes: 0f9f696a502e ("mptcp: add set_flags command in PM netlink")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c4f9a5ce3815..8a7048c5b9b4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1678,7 +1678,7 @@ static int mptcp_nl_addr_backup(struct net *net,
 {
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
-	int ret = -EINVAL;
+	int ret = 0;
 
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
-- 
2.31.1

