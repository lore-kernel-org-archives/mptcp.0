Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C002C83
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636647713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whhtw1wtO2TwCb5lOlSeMmrnWekTycE0TPNqmlGOwCo=;
	b=bIQDdpxuJysJXRIERo3C9v8m2IAVtzmc3yoxgs+9Z8ejAQD9UG8rfcnLk7yvIsyJXwk8b4
	zsmhyhp89mMhXvE0CcfC0AIlom4aMI7tPHqaP/LEz+gE/yQ0bJDBqP1tHkhLaaQh1rcLbE
	dM0yE8ygrH1WcN2nGUz+EndNnZ5rwsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-XAfjWAFHNsy2SYQnu3cJVw-1; Thu, 11 Nov 2021 11:21:52 -0500
X-MC-Unique: XAfjWAFHNsy2SYQnu3cJVw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8452081C85D
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:51 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E6C1A5D6B1
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:50 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 2/7] mptcp: never allow the PM to close a listener subflow
Date: Thu, 11 Nov 2021 17:21:37 +0100
Message-Id: <fc4d6cf65d2dc7f52c130e86d466f811e030a494.1636647623.git.pabeni@redhat.com>
In-Reply-To: <cover.1636647623.git.pabeni@redhat.com>
References: <cover.1636647623.git.pabeni@redhat.com>
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

Currently, when deleting an endpoint the netlink PM treverses
all the local MPTCP sockets, regardless of their status.

If an MPTCP listener socket is bound to the IP matching the
delete endpoint, the listener TCP socket will be closed.
That is unexpected, the PM should only affect data subflows.

Fix the issue explicitly skipping MPTCP socket in TCP_LISTEN
status.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7b96be1e9f14..f523051f5aef 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -700,6 +700,9 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 
 	msk_owned_by_me(msk);
 
+	if (sk->sk_state == TCP_LISTEN)
+		return;
+
 	if (!rm_list->nr)
 		return;
 
-- 
2.33.1

