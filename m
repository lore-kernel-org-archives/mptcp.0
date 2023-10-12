Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821BC1D53E
	for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HHKGTPEi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FF0MvfsWQzf9ap2z9SJ996A/ggrq+1uuUovIn/mao1uTaIbPXgIA+nHswSVy41FoIpSykXFURSKlV/uX7b+0bcHc286TX2EbY1qgDx4HadRz8PTEBGYo4878f19MIg1dOR8Aw0G4/+wbMhiHxDIPfCxv14+yZ86X/OElaXodvND7Xmuho7a9msEkzBPQ+loIiO7SgDyz9+hBqLRvKrvKyxiFD/T6S5xbFrm+g/ue2ABejCXGAXHB8/xYtIB6KPbRYmTRFJ9O0qQe6AUQb8cQdSvFmq7Cam5V0x61wDS+RSK6y5yfHW49iHPT9N5jqvjyR8qe+xtAzFFD5rumsclsJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JF9SqZpDHJjR5kQXzGZWWiFtHP5q3yVGiq85xPy6jr8=;
 b=UkC0l91qv2ylRVWNONHm+mO2g8ZDFJavoHQP0yqshGtuv8dW/RrL/M9d5WUXisQel5NxxLWwh2wIqXOjEDJi00s78UVBaD+o6i3SAreOm5EMCzFSFsjk4mNkudbKullsEZP1INOqbV3cuDL15FmmBRkSH5Ln5nTp2Sftw+w4zMrNSB5oH0Aa1wpa53iBgT32My0f6W/ATfp8gjBEtn4AAmSicW/hqCwy/IBEWOQnA3HiX6BO0GlBuWnB1jACe6HzrlCd5sM6iRbex68AhrpvykgiVFotkwVdlfld+I1okTqmoEge8BBuGVkJp3Wva3N4MRM2szg0pWuYZgo/Env5Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF9SqZpDHJjR5kQXzGZWWiFtHP5q3yVGiq85xPy6jr8=;
 b=HHKGTPEiWSxZtfe3MG1Hf72SrAGUICBp4qOJ0O51oJsFcUBTo0jN6SMKrAPBXtDtUVZpHZmFCnc9U6Oe2aywsH88GgBPCnPDKVlzCGiAkn6nMXn+NFNo4rFHIGGDLHWMabB0ObotCyshTXr1NQCIyzf8zmgQcNJNtmk7vxcjicf52WxZrkq7+k7fmv06I43ROgl5LaizIXMNXf32LM1kaKp8bLJfX9uZ+F6alSR0oCubjkkfBUvpjA+RkFQ8ovgzqsza1yXSNI9SwjTHtiVyiEsxRywUC7yAwj0oZ2l+MJqm7/tRlOxfUUmWaOxVYDS9QEdiDA6QmBxy/9Y/Gdj8SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7923.eurprd04.prod.outlook.com (2603:10a6:20b:24b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 08:51:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 08:51:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 5/7] mptcp: userspace pm send RM_ADDR for ID 0
Date: Thu, 12 Oct 2023 16:52:03 +0800
Message-Id: <8e7bd291fb4877721cc61ef6572b579f91a87a03.1697100600.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697100600.git.geliang.tang@suse.com>
References: <cover.1697100600.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0024.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 23188a4f-672e-4a57-d744-08dbcb007b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iJDGo4YhSoxsdPCPxOehDtSG3FfxeuHmoSscGNrTYtWu2IIiDRC9/9Igrdtn+iDheG26Pvhsl2C3j1YMQeugOdMVZP0Z95Lo1lckIOP7q5tonJq6BgadnkbhVAgF0vyfUjNhKmqzzhcqbqytZJ89Ah0x9v+ozjHPue2+bqCS1CzKs7VY1SYylPjh5fJVhXp/SBY2Y14LKO9b6ypzeeQ79x8kRxjGSaNIFcJZ7/2F/zQ8Mh9qjjlYLMY82lwZhiQ1F7Xbph/WAonL2lIpQ3aobLe4+EPtUNXHiZNmUh2XAWDO0JO+u+v631VYUmCrQIRbE0gYmEiIFvGFQ2O1pgfJF7wY7E0JvTR3i0f2dTpT/WFKhKaWBvIh+5lGdGWeQ8KQ2gCLbBH1iWqE2pBNUGFiR0ckv/FOLSfK6ejxz688hHSnq35OQZUy2JPEslQQ45WkluqTRcIqQLdP2lwrFYb/+zYGMV07MHTQiuqJaQGiXWX/DiM40bwHTns8mlvfFHwgMEXCH24beCAYt40AreTvq6hWwmJy8rbHBKpNVUvqs2U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(6512007)(107886003)(2616005)(478600001)(966005)(6486002)(44832011)(5660300002)(8936002)(8676002)(4326008)(86362001)(2906002)(6916009)(316002)(66476007)(36756003)(41300700001)(66556008)(66946007)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6FFcFPO6hnh2tAu3/gObVL2bB2+uY36uLBpc8vrW3K3ikN6cR+uW9m21NfeC?=
 =?us-ascii?Q?PxlNJTORRjbYAw8f1TY1j2MZglAP4wvHJ9f8JYoISycmxNgh88jgcHMpgKiY?=
 =?us-ascii?Q?kER9PDjhMHVN9qVh/HfOrM+rMQ/YkI+UB2arAOdM2PGsvbc8lwWoj4AjY6ft?=
 =?us-ascii?Q?mQ/tir5z8l8TmhDrJiEC0vOofljICbeQB1XpdHUICvTG04897M87eYQ9HMt8?=
 =?us-ascii?Q?b5Unay4g6NZf/YDdGpulJMWLYJb1BIU7dXiOQl+VhhRPLwkCdvrKOI1sfdmE?=
 =?us-ascii?Q?i0F4K+t4Hx2xGfKn9BvkjM+dPWc72sQ/DVpeHF2soQbJJAoAr7IhYns1cAPM?=
 =?us-ascii?Q?fxqvMpN+mIuii2wRsK/qe/MhSDiPDVDDIR528swMxuqzuMFj+oGCe0tBVefk?=
 =?us-ascii?Q?dWcimR4IbMrJWL+IjpZ29dxjvC1rjo8UtouR2k/MLpc/Ra3AXvLCU3ayBMoE?=
 =?us-ascii?Q?TJdSpmfuUkC7UK3HePjxrKq8GhkaC3QTTOHxzqyJPiFfO4FApaePrraOmGk0?=
 =?us-ascii?Q?165DFjDVWb/Qdx8MmJ9k4q5fGo08thTi9DsZtBOGwZVlp5SOVzfEekPj0IR/?=
 =?us-ascii?Q?1JEyeVB3KppLBkVuZr7cquqAELZ8XNhXPWMkxATvYoWEMkDwXGSkR3apslcS?=
 =?us-ascii?Q?xA8pflB56yu+l69gE5YKV8juPqryjDLYzP9USRuQcK+b6bo7PfOPJxHU26dR?=
 =?us-ascii?Q?S1fAutvxs+J4xlpeDjPKp9ospAD4WBVJspLJrwyQdxCulISmUgzuQ3x5Mbcd?=
 =?us-ascii?Q?tccGebFjyquSUcmgQm9QyfKR6t3fH4KQxpAV2haeWnlNFaVKmUEAqmj1s8Vz?=
 =?us-ascii?Q?521G5uoIeSjtELXe6yJ0GyA9voLdgX1MfK6ZKTkC9j0zwCJMcKCMvTaLkTo2?=
 =?us-ascii?Q?1jxmGcUGIT9mqrIHjvN28hLd9lh2obPoLN/zLiJUK4qJCP2c7CdGmqxl6Mrd?=
 =?us-ascii?Q?KKoJURzD2eFoFoedL0UAA6d6963uV0QT0bbb++R5mudGVwLeHoa5hjwmwR2G?=
 =?us-ascii?Q?PvzriEDIIxPqqHDH2nCqwjTjwhk9KNVfvi2pO8X3o+n6aal6pXBRCqNg9QJ9?=
 =?us-ascii?Q?NXVXYKlzVmqG7qofZq2PhJ0E9nfGkmsX3gvAiS31u/VfAekVZhYaYfp3Lhyy?=
 =?us-ascii?Q?9/1iyNrBXdWIvwjZTQgXDXIQjCAisl5oRPzP2kHgJLxn4KRMZzq1scoRqzST?=
 =?us-ascii?Q?E+tJ3/Mxp5XB16qeZoF+0sJvmsN5ajdOb3FPgIrJUFPe8JDOv0BWYr9GMmZ/?=
 =?us-ascii?Q?svc/my8fhhO0OtAZKBWa9X8UuhHutXHCn1Gu3f3Kg16ewsvPc6SXXCysfTcJ?=
 =?us-ascii?Q?5e3kVzO0lH0lHffqKIQ7KAeUZWge1P2M2qeKP7jKsoybBXGclFMvDx5CUhPz?=
 =?us-ascii?Q?fszXULlesTEyhPyZxDQcub0CQw8cLoqX7wwNMtvZSiw2TTKZZMo7r9ubGxC3?=
 =?us-ascii?Q?INQoiwuiakm7Rj73WlEq6/kIIeXG6zCoFNUPxzMYc0i7S8j9VxPPaycsmwDo?=
 =?us-ascii?Q?6x4c5z4IDgKOp1n84s5ZfFdiVJinubK0eQIWpOzbqxC9SoFM8LnkAEhzpD2Q?=
 =?us-ascii?Q?9ow3hZxmab6ZdYs9e25QF535DkvMlddxCIixqO74koiaaQiKnnQv0DtlGB0P?=
 =?us-ascii?Q?ZZLLWRdlevrOMbRISaUw219Io5LMVoe7rOsn0a1bV5Ar?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23188a4f-672e-4a57-d744-08dbcb007b81
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 08:51:53.6991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dAgU6fmQoOZu2PPK9xzRt36awJJf/M9+9RWrzG6C3th4WG68V1jER2mGFebZy5HmodiK/IGF/8FO5yg4jkpnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7923

This patch adds the ability to send RM_ADDR for local ID 0. Check
whether id 0 address is removed, if not, put id 0 into a removing
list, pass it to mptcp_pm_remove_addr() to remove id 0 address.

There is no reason not to allow the userspace to remove the initial
address (ID 0). This special case was not taken into account not
letting the userspace to delete all addresses as announced.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6b8083650bc1..ea50e694125d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -211,6 +211,40 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+static int mptcp_userspace_remove_id_zero_address(struct mptcp_sock *msk,
+						  struct genl_info *info)
+{
+	struct mptcp_rm_list list = { .nr = 0 };
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	bool has_id_0 = false;
+	int err = -EINVAL;
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (subflow->local_id == 0) {
+			has_id_0 = true;
+			break;
+		}
+	}
+	if (!has_id_0) {
+		GENL_SET_ERR_MSG(info, "address with id 0 not found");
+		goto remove_err;
+	}
+
+	list.ids[list.nr++] = 0;
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_remove_addr(msk, &list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	err = 0;
+
+remove_err:
+	release_sock(sk);
+	return err;
+}
+
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -245,6 +279,11 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 		goto remove_err;
 	}
 
+	if (id_val == 0) {
+		err = mptcp_userspace_remove_id_zero_address(msk, info);
+		goto remove_err;
+	}
+
 	lock_sock(sk);
 
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-- 
2.35.3

