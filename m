Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB260612D
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="lgiiDbDq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgzuX4LlQgGvfCVbyyv3zJtF2uqMe682lMlmrpRCnltMh3t7BOgMnyq+mzG9NjBnTuIuryDYZjPMXiYVwZeJa+yFeKjiHtunkT9yL7TzBH+PkcUCh/PLxXPEP61Mt1SC5cXhYyYiDFQWW7D4Rd+dR6DTynl9G1v+xp+tKHZxitgtlDaOaikbU4C3nHQKx+wLpHp0nz8tziTFY3/F2VEKDXmiSuyDhBm/NYFoX7qfk62z7rIOYI1UvPevqGpPqNeNEgA752TItb0O+55JNW40oBJR5WfWIgaqLUwvb0CIwnpjbIlilIIicSBAzh81R5YyK19w/xtLqGchUlZbQvBqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzmTKhFmeUjuR7SBC+ajnYVfIvQLnrE1PPtUf08YSiM=;
 b=LBiCHmvAdmp++xANqmEMMe6Dfh2KeK7I9QXWtw6X97MEK3JXt6DJmfcUD1RhA08rfzeyar0Zm1nWJ9FEdLCBi92OnM80b87jVfCDEKGszDPEyFDwfeQrHozMAO6pCm8oPsHdfqIUNRR5d/FG40VhTejBvhv8cDvKLpaFP+X0GBSDclojy30rxJPQpw1ojKUgD7gTHEpvieMri1ielLILZr4wYe/AbWlc2tS+W7TlfOctF67MpIqhIHsI/VfibYR7yRqmQN43ohERm8WeJ3JcSbRBWRWvSEK59YeVExPnVrlWR4hjqgCYPwOs7ElAwXmriPe6YBvKoV8y7s2hRjEK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzmTKhFmeUjuR7SBC+ajnYVfIvQLnrE1PPtUf08YSiM=;
 b=lgiiDbDqaKpXlVgCXN63CmGASbXYuj5vKEG1FEGA5Gd90Cjy8uIrBS39ehkITfFRW+NMdCfU6IR+NFlDmTmi/ZrnQGKcFfGtwi8io87iEQkqXxZiz2ULz7rBoKm5WdWJXAMoD/KLyv8sVkMpTtoWXPgmbsejIw3YETP0bC9n31ugrUaisY37G9SALsqoti5mZHDM19UZ7HLsBFWeddHdR+bbvwPLZLUpUERwuXn0jUWZQTLgb/WMHsXoZ2cRpLeQxPCogz1kIOswN/nnSMPZZEVsnncuFi1hv1pml/nYc8bn9A9IG2SR6sP7Cn5BJaSBCYnMp5Z74yY/8YRanNqz4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7451.eurprd04.prod.outlook.com (2603:10a6:102:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:37:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:37:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 20/21] mptcp: add userspace pm addr entry refcount
Date: Tue, 14 Nov 2023 14:35:17 +0800
Message-Id: <209a60eda39e57ec039e4eac424c50e79eda55f6.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: c529a181-ea19-40bb-9061-08dbe4dc3628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CVOppMTCus9fPBoxayroqIdBcrKYr8cppAOTVBI+7QU/2tCzGNy3HanA39VnjAzOg2LgipFUMakZgxc0i8CQudS7RXrs1119dFZrgJzno9lstDRgwADjVJOAjk91Jew2WFKpk9iafn4mvOGNiiHes8nIiKhHt3g3CCX23PN/4TpKgY4VhKqMVyIFNdWqWvcWHooCyYx7Qx5ITk5w45EUvZ9np7AcVolX6gObOodPmUL1tf3osBwJcIIki9SKZ8YZAi0F1zKxcVh6fIOfA713i1XYtzF+41zvNFj/JC5S0tStk+VjS2j8MtQPd23lJ64RBFTpak4vKKGPzz9YipGw4RECRCQzJeQtdM90U8zEInfKfqPg7F7k1WMYibZnKs8XbId3OR8/vj77sG1j4Kplr/OApgzqIM8TjY9/yYkCDBcc/jFp9SbbJtQPZwQ6AotHLnqL9CajWfexQWFFl92PqvQpVfKfF2K06UwxXBwb1AMTMlFbK3P+Q+V5sMM73q/JMJ1oHZRtGAm5GuhVHw8x7JtzDP0cq4egVUD4ziDKxo4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(41300700001)(2906002)(44832011)(36756003)(8936002)(4326008)(8676002)(316002)(66946007)(6916009)(66476007)(66556008)(86362001)(5660300002)(966005)(6486002)(478600001)(6666004)(83380400001)(6506007)(26005)(38100700002)(6512007)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lRD0izGQJHY0VnMHZfa+uayy/wiSrIn1z6lSe1//VG2g5E1cjLj+obHXlMx6?=
 =?us-ascii?Q?CwSwkz759juAKsX0FQ4q/FU1j81Q+D2+o9LH1+3TkeYCw7HRqGMAG0kBA1ES?=
 =?us-ascii?Q?9jIY+FAR0OWptlz8jUK+3+6FhpHA+ZqMmfu14Rb1pMfeUVDoZYezt85u4tJe?=
 =?us-ascii?Q?vztyclGB8xOfpzgatbZK2b6ixv2ToGbbw3y07UBHCekpHQKMQPu8nKyvuVn7?=
 =?us-ascii?Q?LKFxy2JrOHct3m+xrai2byh7NGzlONoa0bdZjPRe+q7dt95YSP+zwiD0ZupL?=
 =?us-ascii?Q?x2IWrTMSjgXToUbWRjxsDrne2ayWwJln2PmLXnLNZZ9H5+rHmMIcPNO6mTnI?=
 =?us-ascii?Q?m5vF7B/h78XrRs4F4PXznhEhKGIL9xmYz2jxRT9Wy0GY1EknvgdXbI4yH84+?=
 =?us-ascii?Q?NF1XyhuBnxELtJyoL1tj+Er3GFgKd5GHY1pphaOOXc13IWuT9c8WRTBLc1Sr?=
 =?us-ascii?Q?rej7a1CHIV51yk1HG0nmsBa2CN7FLS5oqXtNv41VLgGDqflAxBCKOn44iyZm?=
 =?us-ascii?Q?rZ6AacTMxcVsZk5+55v4ntUK5OpOL3Ie0E2YS88g8GzdDhvXpt8nb4oEzPoJ?=
 =?us-ascii?Q?vFEyBqrRrfQ/5RU3qaLi86inTsmBwZcILamy6cCAIhfnBc6Xoe1D5gRkGSWj?=
 =?us-ascii?Q?xDOpeJaNLArjvG/cUL6CkT6+8Z4vFgu6SpzSPubo5+LuDN1IpwfP/3TFk7Q1?=
 =?us-ascii?Q?jKeLbxtGbZ0nLnMS7QFTXumeAgmY6uJtyJWkBM9Phpmpste71U+O8oHF0oUn?=
 =?us-ascii?Q?/RxWHUCI9Kj7Tq9hKyQlidt6LJe6SYNDh7dfFFuaez5TNK4YGsUSQ3A7xLV1?=
 =?us-ascii?Q?FlWqAtad2PMdON3vfyKn+5J29hTHtZiHslJRuWXh9W+T2VDuTtT8biR4bOYD?=
 =?us-ascii?Q?7fqBMiYccjnI2QG46ev3fqOozWqVSQS2rGNvN0WBkWjmvhE5f3+Va7k9XfOS?=
 =?us-ascii?Q?/yMh8DuTtkxjAyNqM6dh9TYs7HUhbcn/gFyREoEJVxcKrjiywtVP5Ndjx5/U?=
 =?us-ascii?Q?kgEir0XSaou5F7ooBCr6zY2CA+f6U8RwEz53PV0a4VknZFREdfHRmxD7rqFC?=
 =?us-ascii?Q?2H5bM0ZpIxs9YUyGRu9i+ca4qpRjU/APW33pCJ9PQiCWs3bLKZR5SF00JlR/?=
 =?us-ascii?Q?hiYh2pblcoZ9PObu7CXWUAIOnjKeL76MAQ3K+lVgXzj8FpJbe+oU3zqPhlMW?=
 =?us-ascii?Q?grf/gZAPBrMj8CnRgFLDkncY/AJW3NdC83wJEM5M8g4jgTDFfZFRIGjToRbe?=
 =?us-ascii?Q?KB3b3ibZ2mifQ2SqCQTXbx5X7uSvZHZ4SQiEi69LVXELWdsd2rWbGLHdAUvK?=
 =?us-ascii?Q?Wdi8WJSHmJUpidt1qDIY9RQcj5G1yiWXlFCnSfHKCZdSM4jE/cX0Yskx2FBH?=
 =?us-ascii?Q?azGgmDRN+/KXeHDKPxCBozzvgA/rebwVN5QNz8LC8uv09OWjbgD9CvFiIVIu?=
 =?us-ascii?Q?VEDBkRFuhBgBS4q0RtoqmOLtKADvmNOvW0Rro9TJbMSJomLJCPSVACcsNtPU?=
 =?us-ascii?Q?MvOUCfSAcY3Q3bf3mO5dEbs89hYaOwGLIjp0RB1qC97I25j7+YMftt31UJSC?=
 =?us-ascii?Q?ll0i+56KE40UJF7QiJjP+O8hIkCJBOnzdfobm2NxXtMrIeTpjOLqSLrBbkBi?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c529a181-ea19-40bb-9061-08dbe4dc3628
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:37:46.0309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHXhQmRczLCA29/ScmZD3kqfuQC1s0j8nANFUEtW+Ut4/TZFxBlUMf6ijwZ3+sn3jWLqkIrL0FrV/bAP/SERrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7451

This patch adds the refcount of addree entry in userspace PM. Add a new
counter 'refcnt' in struct mptcp_pm_addr_entry, initiated to 1.

Increase this counter when an address is announced or a subflow is created
in mptcp_pm_nl_announce_doit() and mptcp_pm_nl_subflow_create_doit(). And
decrease it when an address is removed or a subflow is closed in
mptcp_pm_nl_remove_doit() and mptcp_userspace_pm_delete_local_addr(). If
the counter reaches to 1, free this entry.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 33 +++++++++++++++++++++++----------
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index e2f11e821214..65b99c9f2a57 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -83,6 +83,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		__set_bit(e->addr.id, pernet->id_bitmap);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
+		refcount_set(&e->refcnt, 1);
 		ret = e->addr.id;
 		goto append_err;
 	}
@@ -108,12 +109,11 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 
 	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr, false, false);
 	if (entry) {
-		/* TODO: a refcount is needed because the entry can
-		 * be used multiple times (e.g. fullmesh mode).
-		 */
-		list_del_rcu(&entry->list);
-		kfree(entry);
-		msk->pm.local_addr_used--;
+		if (!refcount_dec_not_one(&entry->refcnt)) {
+			list_del_rcu(&entry->list);
+			kfree(entry);
+			msk->pm.local_addr_used--;
+		}
 		return 0;
 	}
 
@@ -207,6 +207,11 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_val.addr, false, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace pm uninitialized entry");
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
@@ -312,8 +317,10 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-	list_del_rcu(&match->list);
-	kfree(match);
+	if (!refcount_dec_not_one(&match->refcnt)) {
+		list_del_rcu(&match->list);
+		kfree(match);
+	}
 
 	release_sock(sk);
 
@@ -398,10 +405,16 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	release_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);
-	if (err)
+	if (err) {
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
-	else
+	} else {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_l, false, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace pm uninitialized entry");
 		msk->pm.subflows++;
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d0eb7b84a262..3093766dd224 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -8,6 +8,7 @@
 #define __MPTCP_PROTOCOL_H
 
 #include <linux/random.h>
+#include <linux/refcount.h>
 #include <net/tcp.h>
 #include <net/inet_connection_sock.h>
 #include <uapi/linux/mptcp.h>
@@ -244,6 +245,7 @@ struct mptcp_pm_addr_entry {
 	u8			flags;
 	int			ifindex;
 	struct socket		*lsk;
+	refcount_t		refcnt;
 };
 
 struct mptcp_data_frag {
-- 
2.35.3

