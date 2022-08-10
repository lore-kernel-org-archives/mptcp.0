Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286817CE
	for <mptcp@lists.linux.dev>; Wed, 10 Aug 2022 07:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1660117393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PA1iZbZfGn1+lXzDyZdvVs/eG9qxHtUO+Mk7lsjsY6k=;
	b=h4JSSY+28D3RviycYMylg7dbhivquGpwEgI5p34Ilf8N608ZJYjYSFnhk0GwDjxTZaiL3x
	5co6saOswLGF0tyY2Myfc1hECOg9/KB7xTuA0ZOTQ/Zobb/NhnfB2aPCQuMhw+rVUqmmDz
	ztIIYpOCY9wFNurYTHiSIFjhk822668=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-4icAtt9eNDu7MRshew8lnQ-1; Wed, 10 Aug 2022 03:43:10 -0400
X-MC-Unique: 4icAtt9eNDu7MRshew8lnQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92E9480231E;
	Wed, 10 Aug 2022 07:43:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.40])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BADDB1121314;
	Wed, 10 Aug 2022 07:43:07 +0000 (UTC)
From: Thomas Haller <thaller@redhat.com>
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Thomas Haller <thaller@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 1/2] mptcp: allow priviledged operations from user namespaces
Date: Wed, 10 Aug 2022 09:42:50 +0200
Message-Id: <20220810074251.31887-1-thaller@redhat.com>
In-Reply-To: <e95949bf-53cf-bdf-27c8-8cbc3eeda450@linux.intel.com>
References: <e95949bf-53cf-bdf-27c8-8cbc3eeda450@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
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

