Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74CD68
	for <mptcp@lists.linux.dev>; Thu, 18 Nov 2021 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637244015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2joO8jS3Ie5xpyBkZ2g+0qXY750ulN41DKRAm1lQerQ=;
	b=TJwF2jvpNmgc1Bm8CNxpTkzi+MyFDqv71dMnuuXgEx2uZeHihzwmte0nzoVg7bk/QyKxe5
	xysOLFHlXRo4dVPxFhIa/0hH63AikeCuob/3oPF+TUA6VyFahgPrbukY+NXtc9jf/qg6ft
	VnyQ/P+Nw266xvBEBlMJIZ3vYcYsG4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-Kyk_iGlsMpO38Od1Up-t0g-1; Thu, 18 Nov 2021 09:00:10 -0500
X-MC-Unique: Kyk_iGlsMpO38Od1Up-t0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92B8F10247A8;
	Thu, 18 Nov 2021 14:00:09 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.40.194.144])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 616F560CC4;
	Thu, 18 Nov 2021 14:00:08 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2] mptcp: allow changing the "backup" bit by endpoint id
Date: Thu, 18 Nov 2021 15:00:02 +0100
Message-Id: <bc909f9556f6696220611f4691913329624f0edc.1637243913.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Notes:
    v2:
     - remove poltergeist that handles id zero

 net/mptcp/pm_netlink.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7b96be1e9f14..4ff8d55cbe82 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1702,22 +1702,28 @@ static int mptcp_nl_addr_backup(struct net *net,
 
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
+			return -EOPNOTSUPP;
+	}
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if (addresses_equal(&entry->addr, &addr.addr, true)) {
+		if ((!lookup_by_id && addresses_equal(&entry->addr, &addr.addr, true)) ||
+		    (lookup_by_id && entry->addr.id == addr.addr.id)) {
 			mptcp_nl_addr_backup(net, &entry->addr, bkup);
 
 			if (bkup)
-- 
2.31.1

