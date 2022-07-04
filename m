Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE25623C2
	for <mptcp@lists.linux.dev>; Mon,  4 Jul 2022 09:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656926098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00hrlLwCfHmsGG0fifYpdJ6TA4nLO6kOJy830ifafLw=;
	b=Pm+lOHorQJxSL+Oa5i1IOaJAWdPTkjy5sV9hQTSBUUDE2L1fBerffGi5QvC1b2C3v+J8Xi
	i/ioO326KsweV4rpTyz/QwCJqymMWKPd0DfTVMs2vdGrvR7MenSLToYctaGE4L7YvWYGsS
	b3wP6MLMXzGIV1yaKa6gzgu/xplPWsM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-7xfhgXZTPiWbdraQANedwg-1; Mon, 04 Jul 2022 05:14:51 -0400
X-MC-Unique: 7xfhgXZTPiWbdraQANedwg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8592A802D1C
	for <mptcp@lists.linux.dev>; Mon,  4 Jul 2022 09:14:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 171332166B26
	for <mptcp@lists.linux.dev>; Mon,  4 Jul 2022 09:14:50 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 2/5] mptcp: address lookup improvements
Date: Mon,  4 Jul 2022 11:14:33 +0200
Message-Id: <9aca8356861affca14c6e4732943f9b76c3923a1.1656925387.git.pabeni@redhat.com>
In-Reply-To: <cover.1656925387.git.pabeni@redhat.com>
References: <cover.1656925387.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
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
index e85fbced2c07..c0a4c947347b 100644
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
@@ -919,10 +920,11 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
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
@@ -968,7 +970,10 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
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

