Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7457C
	for <mptcp@lists.linux.dev>; Fri,  5 Aug 2022 11:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659700232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PA1iZbZfGn1+lXzDyZdvVs/eG9qxHtUO+Mk7lsjsY6k=;
	b=JyukVIvW1rpFJqM3HtKqxt4gaTC7AC6FonVLvHFuroOEnYYlAE5vqkqpTyrskhvQ8ntI7e
	xA04Ra84YtKMkYP34OJZKvATIFw5k0v5wKSnU0xnmpDQFH7lP751LHUxhQvhjD4bxWcB+i
	0o0NAwEGI9ZXGZkood/TjZvnfxnDRbM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-axumRqx-PIKHg_TR9BVsaQ-1; Fri, 05 Aug 2022 07:50:31 -0400
X-MC-Unique: axumRqx-PIKHg_TR9BVsaQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A27085A585
	for <mptcp@lists.linux.dev>; Fri,  5 Aug 2022 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.11])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 98E1B909FE;
	Fri,  5 Aug 2022 11:50:29 +0000 (UTC)
From: Thomas Haller <thaller@redhat.com>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Thomas Haller <thaller@redhat.com>
Subject: [PATCH] mptcp: allow priviledged operations from user namespaces
Date: Fri,  5 Aug 2022 13:50:20 +0200
Message-Id: <20220805115020.525181-1-thaller@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

GENL_ADMIN_PERM checks that the user has CAP_NET_ADMIN in the initial
namespace by calling netlink_capable(). Instead, use GENL_UNS_ADMIN_PERM
which uses netlink_ns_capable(). This checks that the caller has
CAP_NET_ADMIN in the current user namespace.

See also commit 4a92602aa1cd ('openvswitch: allow management from inside
user namespaces') which introduced this mechanism. See also commit
5617c6cd6f84 ('nl80211: Allow privileged operations from user
namespaces'), which introduced this for nl80211.

Signed-off-by: Thomas Haller <thaller@redhat.com>
---
 net/mptcp/pm_netlink.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 291b5da42fdb..2c145cdc7bdc 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2218,17 +2218,17 @@ static const struct genl_small_ops mptcp_pm_ops[] = {
 	{
 		.cmd    = MPTCP_PM_CMD_ADD_ADDR,
 		.doit   = mptcp_nl_cmd_add_addr,
-		.flags  = GENL_ADMIN_PERM,
+		.flags  = GENL_UNS_ADMIN_PERM,
 	},
 	{
 		.cmd    = MPTCP_PM_CMD_DEL_ADDR,
 		.doit   = mptcp_nl_cmd_del_addr,
-		.flags  = GENL_ADMIN_PERM,
+		.flags  = GENL_UNS_ADMIN_PERM,
 	},
 	{
 		.cmd    = MPTCP_PM_CMD_FLUSH_ADDRS,
 		.doit   = mptcp_nl_cmd_flush_addrs,
-		.flags  = GENL_ADMIN_PERM,
+		.flags  = GENL_UNS_ADMIN_PERM,
 	},
 	{
 		.cmd    = MPTCP_PM_CMD_GET_ADDR,
@@ -2238,7 +2238,7 @@ static const struct genl_small_ops mptcp_pm_ops[] = {
 	{
 		.cmd    = MPTCP_PM_CMD_SET_LIMITS,
 		.doit   = mptcp_nl_cmd_set_limits,
-		.flags  = GENL_ADMIN_PERM,
+		.flags  = GENL_UNS_ADMIN_PERM,
 	},
 	{
 		.cmd    = MPTCP_PM_CMD_GET_LIMITS,
@@ -2247,27 +2247,27 @@ static const struct genl_small_ops mptcp_pm_ops[] = {
 	{
 		.cmd    = MPTCP_PM_CMD_SET_FLAGS,
 		.doit   = mptcp_nl_cmd_set_flags,
-		.flags  = GENL_ADMIN_PERM,
+		.flags  = GENL_UNS_ADMIN_PERM,
 	},
 	{
 		.cmd    = MPTCP_PM_CMD_ANNOUNCE,
 		.doit   = mptcp_nl_cmd_announce,
-		.flags  = GENL_ADMIN_PERM,
+		.flags  = GENL_UNS_ADMIN_PERM,
 	},
 	{
 		.cmd    = MPTCP_PM_CMD_REMOVE,
 		.doit   = mptcp_nl_cmd_remove,
-		.flags  = GENL_ADMIN_PERM,
+		.flags  = GENL_UNS_ADMIN_PERM,
 	},
 	{
 		.cmd    = MPTCP_PM_CMD_SUBFLOW_CREATE,
 		.doit   = mptcp_nl_cmd_sf_create,
-		.flags  = GENL_ADMIN_PERM,
+		.flags  = GENL_UNS_ADMIN_PERM,
 	},
 	{
 		.cmd    = MPTCP_PM_CMD_SUBFLOW_DESTROY,
 		.doit   = mptcp_nl_cmd_sf_destroy,
-		.flags  = GENL_ADMIN_PERM,
+		.flags  = GENL_UNS_ADMIN_PERM,
 	},
 };
 
-- 
2.37.1

