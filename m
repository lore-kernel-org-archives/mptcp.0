Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AE618626
	for <mptcp@lists.linux.dev>; Fri,  3 Nov 2023 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GXCoxLAu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQ/ChitY/35EqBGxEyNyJp6IeaGbtWn69lZm+v0qTSCYhABRjqpoH7dxrTwqQkC+8SnbRiXW/rvot7mKMQ2aQSHVAXzcIUWxLNKQOWulUAFUmjbkiFbhXOJntNylQgOOXUXrcKYl5VPAR5PrUZBWyscjvY85Imtx1BXatI57gC2JonNtrJA/ndNgwtdXtA4d2Cmn9IzPV/3DuibgYE5llEL0j4gwGy2cnrCQAfM6dCHNWUGlNqkhMfzuElLSu5EHoE0PmZ4ZgQk2BEFeGlUlw7fKft2DFQQobrxJOy+fqayk5SY7RsSUfQ+98D0QTIm2BEubeAIf3otdSEawFerRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mwp4TEC4X0iHnjKVQ24NNFffhGX94QUd65y9FV1w7dM=;
 b=a0H5y69+renFB/eY25zoNvVW0yKWyrcabsHK1OjrTbw1PhTeF0M9kIHpaMkmi9eiimpHquqc+yiQ746VTRsM3u/dPIKqvk+Uz5cFqVr2n9sjJL8My84AyTYlfV3EBB9DTQZ3DkCQAYpjYD5NGWAupxl3bSF1Sc3iTKmrEM7OtOcvsitjAzSB86DYZhniBxC832kOxn2AHm+2waw+04KBDOj3/ZK+YPIYv3YuOC9Uo5iBGHgyPYXTz9rS+s11Qu2rMrOUZKggZjuRfAuokvCbPg1Xu6CLuD2dW481XIIAeGuVrdrb8SHgbjuNQVrP5cpRWfIGNdkvQ2+a1NbXcuv7yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mwp4TEC4X0iHnjKVQ24NNFffhGX94QUd65y9FV1w7dM=;
 b=GXCoxLAuNpml90cOXM5De32/5KiJyBREkqqnrgarvkpQPPVD34oDCGYyqpTS8XHSqVIw8lYOtbciGF/YJdx9VLa3V+zImbhB1VEIgd0SBRDpD76gRU/Pab1Qe6CGhtP4IeBQqNM75zIOw430eGaLxlVclZvhlP7CJwbdxBjC8mGdhSV26dz51oSqDg/f9h1f4q1mzb1m3LwR+US5sXxmWnjAu02iKKkqqWyJh+lFgktyUdK/NNNEZh9/or+itPJVsLcFOCe4mjVNlpjPi/n/ROzYKAarVQQ3xkaVPPYWO8WEuOM5aRD2ouC+itOUK83CEONOUOlfRrUdAo8mWnJlIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7331.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Fri, 3 Nov
 2023 12:31:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Fri, 3 Nov 2023
 12:31:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-net] mptcp: add validity check for sending RM_ADDR
Date: Fri,  3 Nov 2023 20:31:58 +0800
Message-Id: <02d38d6b7a98765bf516c90541d4f2a911f428ce.1699014584.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0045.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: c440e7bb-3f4a-4081-4607-08dbdc68dd40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b9WvtjWsjXOuDzOVFkdGNu6o0WscVlv86zGuv16KgoqjKjziVCRsqOFMkWp38WM6jjyQlWlt37gn11mVOLckLOhFx1oBfDGgETYrSKsJajkkdG+snBDW/lToWU8m/VH8U4WbuPYB/BGuSO/0tEg1jP+MMq5PP2KBohzjPIe+g+XW5Tf9SPC5C48asj5tr9VJpkYZFhlkJ3RR5DLrVaYKUdyzTqPOeGNd9SQfoWBNrxXBKWxiZckUZKD/PJ/++OjqjcFpQH7HWCKiLSTlCOlpCRBRl+pHSroaIJUeiZEXcn2Ocjj01R9a6Xgq77RGaBDRK8Q+riLcUVGC5M3nsXNJLoUL81/VSfV2U5rhx1fD7viE9i3EF5WMrmuWXmpzhk3BAMJZNauizflHVP/UTj2GDSiurB868+cS+rK9+tbgtMcjGdXEjN0RFsSOn2rPjwG4xMlkDmbonDoPH9fY1PDafSO9Kq4qMlJy/n5XXCxdECGcetGiclQCvYkaYs9/BVlePEzv8Nv7ZVBGHi7v/WFOrinetbkPKYdFldfHZJeH7zVuGk+IWNrPIh88oxA2PNCP8rbX74NfFsgWWhwFpCWa3ftZPRjKgyuIfwVmzd65r8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(346002)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(66476007)(316002)(26005)(83380400001)(2616005)(6916009)(38100700002)(66556008)(66946007)(5660300002)(2906002)(4326008)(6506007)(44832011)(478600001)(8936002)(8676002)(6486002)(41300700001)(4744005)(6512007)(36756003)(86362001)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DQJfRZUxsSECi/BXW5QHAX7UCfFSi6DtC1H/u5YKsGNL4tUOSpyJ8ZjUamSn?=
 =?us-ascii?Q?yfTd76Htx5W1DOAXi4SOyhmNcGsH7jtBTmNgrgoJ7OYCZ6KprJQVYlEBi/7M?=
 =?us-ascii?Q?N2RjIo9CgCW5aYFE3r8uF6V7LBaanCZqIStqEU9JmNr/2PgSAIx3DFQNE34i?=
 =?us-ascii?Q?Gz36ACArmSYlamHyTRYuaCsHJPS7ceDXQhM0zrssOAJIw+wZxLmNze8cIWMJ?=
 =?us-ascii?Q?UNbbhey+LVfVwBwtftOS/Cg4EO6boXNm0zs5dHv3h3CIVZit1En1vV6x5oqh?=
 =?us-ascii?Q?skASJ/z//06g3Mczwwxq7EwDXjb+rdpWNC+T/eHq0WNGOrkh/dULJkcuUH7/?=
 =?us-ascii?Q?WaPwFFjZqDsvF3kOdsQ4rpcEOdkkapMc2rropCvKEnEFpe85ocfVXOxVtFoL?=
 =?us-ascii?Q?LhewcVxq6KXK3wKpSqPl8m39nWYyucEpvfeZRY5fVcl8qYIRSaLQVSE0mpD6?=
 =?us-ascii?Q?JNlJMPYj8nGklROLEXsxKBgdldHkS2ye9PqKgB+xvPQByURmLXPsWHy+dWEt?=
 =?us-ascii?Q?V3apvcU7Rhh12ZIpHo9X306bCVMROI0D3BP4VjYbxmJElftOIVmwdNO2OUSX?=
 =?us-ascii?Q?6ZFBm5lE1FJWDZw3ToBmAEzRvaWU8PYZ3Mp3dBbKtX2mE4o+zv/REjpObpcr?=
 =?us-ascii?Q?R5TwFt5UqlBltzf5PlJBntlmcJDgOD/4MV9x9ofts/1WHobRswtgmhx7ZdJI?=
 =?us-ascii?Q?YxRIzxsiAnmYIxJ2HbMdolwoOCFLcfaLzOdDLLv94uyfQRRZDOInO9ERyOcr?=
 =?us-ascii?Q?goMFGOvyHRulwbd1fw8ZX+P937W2AP/Y9ogFUDIHuoLHJb7NU68PZpon9jzi?=
 =?us-ascii?Q?jPiHWkNvTtyxHU+wiVV/OaqcrD1gtw6S05OpzPHpDge/FFZ42rCIYi4XSnCA?=
 =?us-ascii?Q?clh6JnWVqPA6qhzcYfY2dACrWt9ob3mrQbsCIDhmNiqOwCaR7tSLD7aOP1Zi?=
 =?us-ascii?Q?u9IwHKuQFntrkMXP/dcr5lSw13VwcNBGT4FhCi2CD/p0+KFQy6tpq3eiRxg+?=
 =?us-ascii?Q?0fZlNerKR9WuaHhdlmLr9Xy0NjWedZAVUlIkuSJKRxs3MH/lDpCxpTvzriDa?=
 =?us-ascii?Q?lVbf5Qb7k0Ph8w5tz3cOYlSwrxwApyKcbWI8HozzfI0ccJBgvYRrCC1ntpbf?=
 =?us-ascii?Q?A3gsHkn/ntsgEoyWV6pFpxZJaE+MG/wVJTOw/tt1U7gFDeF74/XRtj2Agxpd?=
 =?us-ascii?Q?lzMYaZ1foqmoWBlrVxlKSds1DWkR5h2QNfFk54ScWcaWYK9gDyhkoafZXwVW?=
 =?us-ascii?Q?0dmjQvHTtBzcaM8mj5Qwg54RUnwFdNg4bgCgQSMz3Nmw7OZcCFW3jo8a0ayo?=
 =?us-ascii?Q?agxdkWHgXvVhugy6iTaOHkfLJrD5tdsNLM4frBxo9GwOJmYdmmjiEraOqUBQ?=
 =?us-ascii?Q?vPhmWtbNvNIdqxxGKR0iztjptNk39dXDsfhVG0+FmrjCz77WQqNB2laiRx9+?=
 =?us-ascii?Q?ujMT5p+vC+zu9+nKJKFrh6sIa5eNpcGZMquWUEZH2WCQgssEFVGY8SsxrZMF?=
 =?us-ascii?Q?cvEOte9VaRVTvM8iUXTONlh0MbUuOA8WxuxL5B45soMT4M/roFJ863aFqR2M?=
 =?us-ascii?Q?H2wG7Rke/jMPn2u4de7lWOtoxT+hosXaxZPdAE2M?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c440e7bb-3f4a-4081-4607-08dbdc68dd40
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 12:31:55.5752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pn43rmp4+e3nWrNfhcKUyn/WvLd+S0CdIZ0v9ZZ774YiKmxdfTcMYtB5gE+LXwLw8SWJI2NPQzrT/gNIMYYb1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7331

This patch adds the validity check for sending RM_ADDRs for userspace PM
in mptcp_pm_remove_addrs(), only send a RM_ADDR when the address is in the
anno_list or conn_list.

Fixes: 8b1c94da1e48 ("mptcp: only send RM_ADDR in nl_cmd_remove")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1529ec358815..bf4d96f6f99a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1515,8 +1515,9 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, rm_list, list) {
-		remove_anno_list_by_saddr(msk, &entry->addr);
-		if (alist.nr < MPTCP_RM_IDS_MAX)
+		if ((remove_anno_list_by_saddr(msk, &entry->addr) ||
+		     lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) &&
+		    alist.nr < MPTCP_RM_IDS_MAX)
 			alist.ids[alist.nr++] = entry->addr.id;
 	}
 
-- 
2.35.3

