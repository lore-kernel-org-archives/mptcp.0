Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3181D29CA
	for <mptcp@lists.linux.dev>; Fri,  5 Nov 2021 10:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636109371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJW7TKXEvDg7nk3jz00uUquoHRDCJzAWq+2MM86W64w=;
	b=Rp6vH4N0Rgzq7QpGZa00F846nel8BWcpzpK5QfHJTb8+AzyyrBrVtaOcEzel2BdQuySWhx
	QUWM2hTWtNZSpVCjSLzp9o7CuNKuNPHw+Z62hoJT31DghHbW3tBkavaMi4Qz3TFX4Vf1a2
	qvjcP7AtYOuIGOUKSCCwIqUo3QahMLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-gJKSDdYfOrC7LRqFluN6rw-1; Fri, 05 Nov 2021 06:49:30 -0400
X-MC-Unique: gJKSDdYfOrC7LRqFluN6rw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28B68101AFA7
	for <mptcp@lists.linux.dev>; Fri,  5 Nov 2021 10:49:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.132])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8EC815D9D3
	for <mptcp@lists.linux.dev>; Fri,  5 Nov 2021 10:49:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [RFC PATCH 1/3] mptcp: never allow the PM to close a listener subflow
Date: Fri,  5 Nov 2021 11:49:10 +0100
Message-Id: <f9e8db7159b3e0db8dc5b642abdfa9019ada435b.1636107361.git.pabeni@redhat.com>
In-Reply-To: <cover.1636107361.git.pabeni@redhat.com>
References: <cover.1636107361.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
2.26.3

