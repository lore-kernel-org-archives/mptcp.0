Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C84639
	for <mptcp@lists.linux.dev>; Tue,  8 Aug 2023 05:38:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obAXKdX+A7RrVXL6o/HAx95pcpibZ0xDbcw7EtD5JWxCo/PQMBYifG9ib28d7mGE7tf5FYpjOVzE1n4YmkCPzHvkBlMhiZIGYli13IUWuTpGooE4M6nPtraFr0Riaof7kHxxLP3PcupGPXp0DzxZmoOcxX53vOxc3lHIAqIo96Gs/5bWua8WIGLJdUVFvDlkaXJl+ETdA8T4k40cTiuPNLtrMmaeDD2Uc/k0Vbcqfgket0fATSRYY6qPxtLoUry8fBFfeA6+1/nOx+gNGP6fnXBRuOL6vz8E0spBv7tInXzdhdOPS8ZB3vVQstIjRv3drhiwLwuS03y3GIHzBknZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrSQCl+0KIb6OgFOrrFpfx+pj7N7aQ7WH75UPzpXLj0=;
 b=jJiNVKznl7+iwuxEjePZkF+6D8NZx/4wHtQVnZ9MQIeGEErb5xLRZnQnYpUB+ekjTL/og8cyh33+TMUH9F5wU8BSwKXOCmr+OYUfcWR95tCuYCw0Sro40OdP7BAqRjFH1+yeqxZ2s4HzJkjD93xrBDJnTqdeLOrA1eoAJ9SnkaqLXxgR7VsIy+qntTvHNlbFY0UPdd/oX7kbGkgNbYGE1Uek0gz8qtQTNLy1ho7Lex+BEZvmBHdloTyQoBecrkw4sDrCeLFbWktNP/O6cCKspdXw+rK33Bdpmv8Tq5BukjVk7trfrKbXRX1Mj5V+W/xOQRVjWKoUu/1OLke39sosVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrSQCl+0KIb6OgFOrrFpfx+pj7N7aQ7WH75UPzpXLj0=;
 b=CTb1OdvFevzCOgpwBwwlLFh/6O3RPFp5E+nvGFiLfNcsX2zsRV6bhr+u4G4odXXWidsBMyyEGzbde5ZzpmGpbIJ15961eO03qw77VcgHAK2Fu2kWdSf1fuby3cFP/GUTFEqXo8b3pPbA4uGSq41AnC2mIuSb41FdPz32ZNmTMK7i9ne2CLRLhQlhmivSpii8wYetx8UY2J9q+xRk7DzOyaY0MmHUdCfYj2lh0U+Drj8586sJFPZy8pJ/Kbyz/AZp/3L7Aew62aPuBo51/+i2kvhAdGDCA7BA1mH/rp3pFwgjN0mOyHI6qR4TKZt/5TLaLkUEVqnSi6Dfgufyk33bvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by PAWPR04MB9864.eurprd04.prod.outlook.com (2603:10a6:102:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 05:38:27 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797%5]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 05:38:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/4] mptcp: remove id 0 subflow & address
Date: Tue,  8 Aug 2023 13:38:25 +0800
Message-Id: <c0ac2580256a3eb29d62998f9c3161a1cbf3688e.1691472939.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691472939.git.geliang.tang@suse.com>
References: <cover.1691472939.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|PAWPR04MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2e068e-f250-4cd4-605a-08db97d1b091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3S7ehOvuvtxvXcKxZ5fjWivt04MuMyU7eJxMxnlCu6L/3srKzqc9Wy2V/4MKyaYtE2CYnoKDL1mzReR4KniOIhlgq8lgUmOGM0BIgqJSgzaCZAYfyUrYZLsI+y57rYp0shehXB7CYpb0uQB2qlvBtRMVK59yDqPh5C4k35BEplLanFkPbFISwdTw7LEpvnht0qcqx2m2FSajxT+N3eZkuRYmQcQxsexQoN4We2MqODHCw7oL6J1izTZ8ZqQ03vQjggZ5tCBYDEeqi99Zt40+mykYumJ7O597w7Qqrsyshlew3jpVLToGNKlqnK7uFkJPE0P6FWUqQjICFqx3VMzU285gR0blZ33AP0sRb7vjRYc/UF2ZEhk10JjcyX4/JgNR54IDCu25RGq1XM042Syrrcpw1itUGxUfXb/vNF1RyW2ovK15fWu8oriomEL6xUDsjimm701jyIFJ6LqQvxD3xUWAJMqxLlJ9SH8k7GRY1XQLiyq6lws/g2tWIn3/VzJFsJdEslp41dIZxBUmNYEokd7I0qt7Y/Umc8QBQtXifcsBw+dnm99CKoICF0SEaqGV+hQ/vJQLjdRchQBBTePy0taAWiEzljFcl8IaoA9If3iSD2cyWdzsYff82Frazh6WQZzsMjQfZ+vKVNybxzY3VJQcNCb4yhQB/+Wdl45iEMQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(39860400002)(366004)(396003)(90011799007)(451199021)(90021799007)(1800799003)(186006)(2616005)(6486002)(86362001)(478600001)(966005)(6512007)(26005)(36756003)(6506007)(107886003)(41300700001)(5660300002)(8936002)(316002)(8676002)(44832011)(2906002)(4326008)(6916009)(66946007)(66556008)(66476007)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xd/c2lTCuunTcGX/9yRF6sFOM5rcSAt+b6QTJLpcLhiYqBSPp+OgccUSnAHn?=
 =?us-ascii?Q?5L30daOdWZWo7Hh3M+s5fq83QcGZnDrQXVyjmnRvqWWitj8zuz4yFtb+bfwL?=
 =?us-ascii?Q?ROVTg9llLgykLV0e5leNTNutPqBuUuffGjochR34KYAWkIFV3frB/1U6Mv7l?=
 =?us-ascii?Q?JGeOOVJHR1xhgCc0qnD17Dxlh0WANaqliZTiaYKX6oSaRpRVxp+i96cMfv02?=
 =?us-ascii?Q?5NqpSE02AYC7gsFC6qm6ywK3UWbkUtU91ZWdvsStqZfDlKDjDMQPUIu2l6Mq?=
 =?us-ascii?Q?mzppLW7aqgm9ZV5546AcgbYrohpJNyEodpS60wC2BejQdOqM8G+fZUxUaQ1F?=
 =?us-ascii?Q?c3xnwlYjw8XM45YxXb6RWF+zxcJqWj6fOpHnGjX+u6N5I9HXFaUhiVwoQiDH?=
 =?us-ascii?Q?70tolZX4m/t1ehwYaCtJLS3wPgdkya0jalb177LOv7jrKHY9V/bLLSJBbCgD?=
 =?us-ascii?Q?JSxUGO2t/gZlUKADbNF++/07Tlgjw242Q3Xka3x8l7pz5nDvqn6niDUy2Q1R?=
 =?us-ascii?Q?VpKyqX9N1B3BlYI6Ow7VPR4lmCesOpqmQbPZ9+b1Tiznv5F19AoKK2Qk+J21?=
 =?us-ascii?Q?zM57Mw4N5WCS2NWIkHSOTUtS0NJXhwdlDMHcsSRYyUdowO1Y5jYgjp8z+s1i?=
 =?us-ascii?Q?ozyks68syOn4NhfsqGaAdMe6Ad0q/i3TUMfhOIKOxQugx0fei009g/jFphY6?=
 =?us-ascii?Q?Xa6CKtW9b+fE+6kn/nWfFZ8NtD4oG2br4JVtkAV16cVoG5A0rEni/LBD//tD?=
 =?us-ascii?Q?KbRpqXZg8e+fVyDdfEc3bASyhStlefqUfxwLoOj1Yb34thqtWkT+HjJ6j5E+?=
 =?us-ascii?Q?iHb8l4lhiaEgt/98ptOES9caSKIr8A3Hr7mdcTr2k7AIvCpEccFuiUqob0t5?=
 =?us-ascii?Q?k0qjnFzff2/DRjWdOxqMu23vbhDTq2vt2uhQMR4nAhjUYTAihMhpTIhn92Tg?=
 =?us-ascii?Q?4PbDQtsRh7V32ZQuckeK6hp94ZfTrGCyoPNjxHNwXmC06FrGtfngqb5jVMWw?=
 =?us-ascii?Q?76Z6SPLhtw9nbNof912FqxUKtOk05+OpY2hcWBBt8FNtloA4Trni9iBsxbJw?=
 =?us-ascii?Q?Y+anzDYlTg5FTJUucCR4Vg6Z3242Y0pL9sqOXyBvza8PUMUKJ7UCiUQMVW2A?=
 =?us-ascii?Q?jPMXsJDqlUiiZLQO+xmJgLt0+K4LlKvV853e4FlN9w6EWKp0taxwwrkTz9eo?=
 =?us-ascii?Q?Z+mNIHv/aSmUxYLhnHV3jJqnjr+IeS46KYY5yuGWR8RS+02JOOe8AN/PcHyN?=
 =?us-ascii?Q?h3nCxra3aJcxJAjv585HzfhcBGBXXYPHR4UVidA9d13tk8y/F83iuJwcGC+q?=
 =?us-ascii?Q?nFFp1hq32KYb2v9OcqRCWeI32Txx3BTovJpEN9tsPt7Nu7dc2H9OtvXyFPay?=
 =?us-ascii?Q?xpswhmd9cHIcrMVj03J/mpjEdYckFQAwx3JycLMixG1ULFohQgAjB9BJ6Lwt?=
 =?us-ascii?Q?+BGO0u2st1d/tuPiyfa1dRclQ7j+JrYG4GOobTDb4fpiBPTCkk+LTBYbuJak?=
 =?us-ascii?Q?mytQHCClSRg+/vvUU+BbOVcInBJLNW7ka9MmdXumoM5+RyFHcF+2e/Rmwvln?=
 =?us-ascii?Q?F/yWCzsN2ZptQKvOx5g+G3btXB1p4mirtWWSBmDN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2e068e-f250-4cd4-605a-08db97d1b091
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 05:38:27.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vb/lifdWdIY5U5eTROyumFkp5rB6rMRN0x/j9+BGaUHL/Oy3z5OLO1ZNWoFLQ2rMYvaFhCrWmTcKbenj1e0K3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9864

This patch adds the ability to send RM_ADDR for local ID 0 and the
ability to remove id 0 subflow.

Put id 0 into a removing list, pass it to mptcp_pm_remove_addr() to
remve id 0 address and pass it to mptcp_pm_nl_rm_subflow_received() to
remove id 0 subflow.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d042d32beb4d..90472cd62342 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -241,6 +241,19 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock((struct sock *)msk);
 
+	if (id_val == 0) {
+		struct mptcp_rm_list list = { .nr = 0 };
+
+		list.ids[list.nr++] = 0;
+
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_remove_addr(msk, &list);
+		spin_unlock_bh(&msk->pm.lock);
+		release_sock((struct sock *)msk);
+		err = 0;
+		goto remove_err;
+	}
+
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
 		if (entry->addr.id == id_val) {
 			match = entry;
@@ -399,14 +412,16 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	struct mptcp_addr_info addr_l;
 	struct mptcp_addr_info addr_r;
 	struct mptcp_sock *msk;
 	struct sock *sk, *ssk;
 	int err = -EINVAL;
 	u32 token_val;
+	u8 id_val;
 
-	if (!laddr || !raddr || !token) {
+	if (((!laddr || !raddr) && !id) || !token) {
 		GENL_SET_ERR_MSG(info, "missing required inputs");
 		return err;
 	}
@@ -424,6 +439,24 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 		goto destroy_err;
 	}
 
+	if (id) {
+		id_val = nla_get_u8(id);
+		if (id_val == 0) {
+			struct mptcp_rm_list list = { .nr = 0 };
+
+			list.ids[list.nr++] = 0;
+
+			sk = (struct sock *)msk;
+			lock_sock(sk);
+			spin_lock_bh(&msk->pm.lock);
+			mptcp_pm_nl_rm_subflow_received(msk, &list);
+			spin_unlock_bh(&msk->pm.lock);
+			release_sock(sk);
+			err = 0;
+			goto destroy_err;
+		}
+	}
+
 	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
-- 
2.35.3

