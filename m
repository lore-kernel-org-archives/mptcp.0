Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6BF1869
	for <mptcp@lists.linux.dev>; Fri,  1 Jul 2022 10:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656669942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xzXC6+q0xBZj4f+7N9q0nm16YAyDGWcwUnsmOjuFUQc=;
	b=VW4B+6dhxqPmu9/a9uGTkCxQuw+vsJC4VubDpJyh+Gl/i+PbmH1BANSJmq+7N6w7t6U+vt
	TQaiw2GCcl3Q034xQUk7iyzBqdoBDvMOWLE9TKMEC+ny8F9ouTw1G//jcF7Pq+q9WuvHC/
	DhylJj92AjfNpD69g27rHSCXaJUgm1g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-jHb127gFPF-7L_DK-aqpgw-1; Fri, 01 Jul 2022 06:05:41 -0400
X-MC-Unique: jHb127gFPF-7L_DK-aqpgw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 504EF802D1C
	for <mptcp@lists.linux.dev>; Fri,  1 Jul 2022 10:05:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.185])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D40A7400DFD0
	for <mptcp@lists.linux.dev>; Fri,  1 Jul 2022 10:05:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 3/6] mptcp: address lookup improvements
Date: Fri,  1 Jul 2022 12:05:23 +0200
Message-Id: <6439c41c08c91be16239b686ddb6ea3f2c871d16.1656669391.git.pabeni@redhat.com>
In-Reply-To: <cover.1656669391.git.pabeni@redhat.com>
References: <cover.1656669391.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

When looking-up a socket address in the endpoint list, we
must prefer port-based matches over address only match.

Ensure that port-based endpoints are listed first, using
head insertion for them. Additionally be sure that only
port-based endpoints carry a non zero port number.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8dc7ff9953b9..d6180b34a2c9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -413,7 +413,7 @@ static bool lookup_address_in_vec(const struct mptcp_addr_info *addrs, unsigned
 	int i;
 
 	for (i = 0; i < nr; i++) {
-		if (mptcp_addresses_equal(&addrs[i], addr, addr->port))
+		if (addrs[i].id == addr->id)
 			return true;
 	}
 
@@ -449,7 +449,8 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
 		mptcp_for_each_subflow(msk, subflow) {
 			ssk = mptcp_subflow_tcp_sock(subflow);
 			remote_address((struct sock_common *)ssk, &addrs[i]);
-			if (deny_id0 && mptcp_addresses_equal(&addrs[i], &remote, false))
+			addrs[i].id = subflow->remote_id;
+			if (deny_id0 && !addrs[i].id)
 				continue;
 
 			if (!lookup_address_in_vec(addrs, i, &addrs[i]) &&
@@ -912,10 +913,11 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	/* do not insert duplicate address, differentiate on port only
 	 * singled addresses
 	 */
+	if (!address_use_port(entry))
+		entry->addr.port = 0;
 	list_for_each_entry(cur, &pernet->local_addr_list, list) {
 		if (mptcp_addresses_equal(&cur->addr, &entry->addr,
-					  address_use_port(entry) &&
-					  address_use_port(cur))) {
+					  cur->addr.port || entry->addr.port)) {
 			/* allow replacing the exiting endpoint only if such
 			 * endpoint is an implicit one and the user-space
 			 * did not provide an endpoint id
@@ -961,7 +963,10 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	}
 
 	pernet->addrs++;
-	list_add_tail_rcu(&entry->list, &pernet->local_addr_list);
+	if (!entry->addr.port)
+		list_add_tail_rcu(&entry->list, &pernet->local_addr_list);
+	else
+		list_add_rcu(&entry->list, &pernet->local_addr_list);
 	ret = entry->addr.id;
 
 out:
-- 
2.35.3

