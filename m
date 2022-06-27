Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DAA2586
	for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 09:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656323936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QJIHIDe8qvUxSDwvrXVxSuiQfQ9jc6019RPqRJmD/iM=;
	b=azY9wAEPqHdeYfYf9vrfMZqmlW7iL1mlrXnsyUe4ASNIcHUNqzDOnBOGu/+af1Vnl8yV6Y
	Z+pQpduSV8c+r8jff/hV4hwhIJQOhyfWGswiwKIKW57zFtbWLnuvpuWtlnX4n1BWYbebF/
	abw8iQUIFz2rXEPcCg289E+KttRNfeU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-h_SiL52QMuWrBWsExHUDsQ-1; Mon, 27 Jun 2022 05:58:55 -0400
X-MC-Unique: h_SiL52QMuWrBWsExHUDsQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B780C3815D3C;
	Mon, 27 Jun 2022 09:58:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.148])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E5CA140F06D;
	Mon, 27 Jun 2022 09:58:53 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-net] mptcp: fix locking in mptcp_nl_cmd_sf_destroy()
Date: Mon, 27 Jun 2022 11:58:14 +0200
Message-Id: <886e059dc9096dcc9e1daa1eb1a07ec34d72aa74.1656323519.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The user-space PM subflow removal path uses a couple of helpers
that must be called under the msk socket lock and the current
code lacks such requirement.

Change the existing lock scope so that the relevant code is under
its protection.

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
It should close issues/287, let's see what the CI says
---
 net/mptcp/pm_userspace.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3d1d365e9c6f..33be79f0e9c2 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -307,15 +307,11 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *local,
 				      const struct mptcp_addr_info *remote)
 {
-	struct sock *sk = &msk->sk.icsk_inet.sk;
 	struct mptcp_subflow_context *subflow;
-	struct sock *found = NULL;
 
 	if (local->family != remote->family)
 		return NULL;
 
-	lock_sock(sk);
-
 	mptcp_for_each_subflow(msk, subflow) {
 		const struct inet_sock *issk;
 		struct sock *ssk;
@@ -348,16 +344,11 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 		}
 
 		if (issk->inet_sport == local->port &&
-		    issk->inet_dport == remote->port) {
-			found = ssk;
-			goto found;
-		}
+		    issk->inet_dport == remote->port)
+			return ssk;
 	}
 
-found:
-	release_sock(sk);
-
-	return found;
+	return NULL;
 }
 
 int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
@@ -413,6 +404,7 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	sk = &msk->sk.icsk_inet.sk;
+	lock_sock(sk);
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
@@ -424,8 +416,9 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	} else {
 		err = -ESRCH;
 	}
+	release_sock(sk);
 
- destroy_err:
+destroy_err:
 	sock_put((struct sock *)msk);
 	return err;
 }
-- 
2.35.3

