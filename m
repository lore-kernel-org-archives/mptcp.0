Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744843FC5
	for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 13:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1632319024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ezdUV84TLbffOtnbSVvVLt3E9JdP6mesQWd1UglVhg8=;
	b=fde6Mryh4yZwwuf8BPJa35eqjT/B3cYZRDdoZyCFEleibY8HnKDRTk/Op8CMHqFntvdbf0
	hFUWqR/n+9MhfDhhGN+ZWxfJ876J643nvbGz00QrEPmFrwRc1w6sBZRe6MKgWPckSA7G+v
	qG5gjfkcCWqiqViyk/Jg28gyHSVfwmg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-gjj5jEMrNsyZf1rOFT09WQ-1; Wed, 22 Sep 2021 09:57:03 -0400
X-MC-Unique: gjj5jEMrNsyZf1rOFT09WQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 086EC10151E5;
	Wed, 22 Sep 2021 13:57:02 +0000 (UTC)
Received: from dcaratti.station (unknown [10.40.194.201])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1717218428;
	Wed, 22 Sep 2021 13:57:00 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev,
	Geliang Tang <geliangtang@gmail.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-net v2] mptcp: allow changing the 'backup' bit when no sockets are open
Date: Wed, 22 Sep 2021 15:56:44 +0200
Message-Id: <6fada33a17044e54f0ba5b3a5dc35987cbea3b54.1632318877.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

current Linux refuses to change the 'backup' bit of MPTCP endpoints, i.e.
using MPTCP_PM_CMD_SET_FLAGS, unless it finds (at least) one subflow that
matches the endpoint address. There is no reason for that, so we can just
ignore the return value of mptcp_nl_addr_backup(). In this way, endpoints
can reconfigure their 'backup' flag even if no MPTCP sockets are open (or
more generally, in case the MP_PRIO message is not sent out).

Fixes: 0f9f696a502e ("mptcp: add set_flags command in PM netlink")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---

Notes:
    v2:
     - ignore the return value of mptcp_nl_addr_backup() rather than just
       gixing the case of 0 open sockets, from Mat Martineau

 net/mptcp/pm_netlink.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c4f9a5ce3815..c3722eedc671 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1718,10 +1718,7 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
 		if (addresses_equal(&entry->addr, &addr.addr, true)) {
-			ret = mptcp_nl_addr_backup(net, &entry->addr, bkup);
-			if (ret)
-				return ret;
-
+			mptcp_nl_addr_backup(net, &entry->addr, bkup);
 			if (bkup)
 				entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
 			else
-- 
2.31.1

