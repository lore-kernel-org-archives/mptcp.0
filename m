Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC2868
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 11:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636628966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QA76H3/UR+er/Sas/IM41yDEj3bkLqK6/lL9hGnFK+c=;
	b=aK5Q1pTQ+kj5l0AIg5quJgw1LBMCSoofYnucjwqPwdJDGi4A6ibchSrdF2ZIwx3ylyOjuV
	c+EibXENBATN//eIJZHwh9J6ILqc5SQwyhW9Ikj45bReqj3HwRuh6vwCwKyV+jF116fq9Q
	SAHvpJX9gqwh3POpL1pK/TbFIOAjDwg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-C5AsJDUfNGGLx8v_MDBcuQ-1; Thu, 11 Nov 2021 06:09:19 -0500
X-MC-Unique: C5AsJDUfNGGLx8v_MDBcuQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A196B801B0F;
	Thu, 11 Nov 2021 11:09:17 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.40.195.43])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 677195DA61;
	Thu, 11 Nov 2021 11:09:16 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] mptcp: allow changing the "backup" bit by endpoint id
Date: Thu, 11 Nov 2021 12:09:00 +0100
Message-Id: <434d58757c972252e5af7ac2574c3791a9778441.1636628783.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

a non-zero 'id' is sufficient to identify MPTCP endpoints: allow changing
the value of 'backup' bit by simply specifying the endpoint id.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/158
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/mptcp/pm_netlink.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7b96be1e9f14..b4c647e67930 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1700,24 +1700,35 @@ static int mptcp_nl_addr_backup(struct net *net,
 	return ret;
 }
 
+static int mptcp_nl_set_flags_idzero(u8 flags)
+{
+	return -EOPNOTSUPP;
+}
+
 static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
+	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, }, *entry;
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	struct mptcp_pm_addr_entry addr, *entry;
 	struct net *net = sock_net(skb->sk);
-	u8 bkup = 0;
+	u8 bkup = 0, lookup_by_id = 0;
 	int ret;
 
-	ret = mptcp_pm_parse_addr(attr, info, true, &addr);
+	ret = mptcp_pm_parse_addr(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
 
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
+	if (addr.addr.family == AF_UNSPEC) {
+		lookup_by_id = 1;
+		if (!addr.addr.id)
+			return mptcp_nl_set_flags_idzero(addr.flags);
+	}
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if (addresses_equal(&entry->addr, &addr.addr, true)) {
+		if ((!lookup_by_id && addresses_equal(&entry->addr, &addr.addr, true)) ||
+		    (lookup_by_id && entry->addr.id == addr.addr.id)) {
 			mptcp_nl_addr_backup(net, &entry->addr, bkup);
 
 			if (bkup)
-- 
2.31.1

