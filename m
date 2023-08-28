Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2040.outbound.protection.outlook.com [40.107.249.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48494634
	for <mptcp@lists.linux.dev>; Mon, 28 Aug 2023 04:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXQ8ws1d4uXut/xTvFIuSQ3inR/3neNUOVhBCgoSW5sxRAUgqcGufoWgEwWGiNp917RI+Q9ugqFt+44cSk2c4J+Culcm3HgbQvHj56hhglXDpuOIwOvPQl1r+kpLoOamz4syGSDyz4Flu4t7eVQtrtxUzU8rKgDtq6ni5vJReB986gVTTLDGpTJlg30MStihHJz6pRbrmnXjSVfg7WkbFqFLvG02Fo5rifthlgVq3p1Bqmmtf5e5Seqfl3m31B+EY96oVsfcNFcJrBI+sUR/oP+J1KJLt1REzEDdOdmJAEkDi+5nT7hP72fFb1l95KaYt+GFtzO0de2AjqdBMQXPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSAF9pVPQMGFCRRIZ2CWkJOpmYr2QAARJNPwTMUnHq4=;
 b=JE42HeqCCzVkPm6F4wqKd92MjCAhSgtqRioLjhjrmWh5gQ7LAiz28yVKfBfvbWBz6e2NbNjTXD0CYT4D+IH4ffRxZQgJErD0oRBSeHfNeWqNihUDd+Oam0nqhRdxL7V0vcKkj/P4UKk397LmKNq8sFEX/X39cxqPQ9QHmSAp6cTcdFTB2EohCImlmm4lsiYIMCqHiCJASqkq8A0PSNmx/qT2nfDMZ8gKZfqugnUGvz6Wx/EV7fZL0taIL2SdFZm4j7NE01z5tsoUcwXzA0NA6oxRLdYsxl3QBlFFjDJa58urQ3UpEBNuAMZLDWhwDit4pk+3RzeDGCWQYgT8UcDUGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSAF9pVPQMGFCRRIZ2CWkJOpmYr2QAARJNPwTMUnHq4=;
 b=O2FBOU7/DvCJ0wNpXcfU8uL+lCD4ZczRsSVkYZtGcRs6Sqd+BnD7K6Trp9CJPpFWFi0mVyoAktwlfcPRt72UwcPM8P3HJKdFX3ct+F8VE5yW/wn83Wf/SyO6j9l5G7tN2ScT3JdGGjIhAbpRB5X4z/RLeWH3eQidLkV4X5aYUr34IaLOmI9e0/3cUr/Nf0TG5NpqnxgfT+Hi8z7KZzhvXv2D4+FN2RwA8dOsla3IUgvb4pe98ddA0w0RASQCRqH6AICWduVgKdBRScVgD2gtH4NfXk1bf8cnfCnUNwKuH3LzEV/DJzHExEOlu3D+hNRk+gvya44ynPcYKdecgwS6Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 04:35:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 04:35:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v7 4/7] mptcp: userspace pm allow creating id 0 subflow
Date: Mon, 28 Aug 2023 12:35:26 +0800
Message-Id: <dbc65a851a878378225d283a3d949976ea6839f4.1693197152.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1693197152.git.geliang.tang@suse.com>
References: <cover.1693197152.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 885414d4-e059-4c65-931d-08dba7804107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xObk0md6x7oaZH64jfEjza0zieJ6OOBldSttE2DSjV+Gy+2Vqf/YgIPktav7WxKeDQW2W+xLETFmSu2giHy2L5ndbBhbL9jh4NfOXKA59a8ShthK3/qPusdP1dZe8/uEneE/IFELVoZJ95gAJuBNr0tII0fKmZ/UI1Hw/L+9YojKPflJz9E3Hpu+BOwwpJqcRjwFCckAer8AZPysjyliDM7RuvzgniQk81d9LKmkcv4EGwiPWUmjItVeb0XyFeAvOfQOaSuxPWZC3F6NlAzgRRJrK5gVQYuFD0UB+2OacMAKJ9HITBuf7ApmYTH/sC2hFMEZP0CNzqcaJIuY4REV+hKjwJy6y3CgfNalvvPjnEOpfq1obIsmZmP/iXd3jjwHRjQpDwGgny+U9iaOAjD2Q4FhjZwcmD6FJhO07ezVUwfXgXUz4AWn2R0/Jvxz+yi69CmDyaSx2up0G/luXiS9aiAqmFkXV74rdrIrRLYOftGM+rYmfMAfngtTpnHVA0+UgTgxL2yVTpjhTR392pAs8y7KSf3xD1lJwvy9HdAP78A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39850400004)(346002)(186009)(1800799009)(451199024)(41300700001)(38100700002)(6666004)(86362001)(966005)(83380400001)(478600001)(2616005)(26005)(6512007)(6506007)(6486002)(36756003)(54906003)(2906002)(6916009)(316002)(66476007)(66556008)(66946007)(5660300002)(8676002)(8936002)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GfaFLeRBKWmwFdLGb2MyC7iJia19l0QWXn4vi8Awiq1VhhI/TKXe96qWDXM8?=
 =?us-ascii?Q?v6qhAdw8mn5YXi/HVtEL/PR1JLI/9ge1czQfTcJ0kIpk1ceCSav0ot+IRFNk?=
 =?us-ascii?Q?3OB+pbstDoOeazzoayAuDi8feHPO4Mg7NPUwTAekPbVDjP9lI19ce37OKsuC?=
 =?us-ascii?Q?thV678bt1mZohAKlUlvgiO/1DEisIf/Uq3VaaTMDsfe8/b45R3+j8HAqWlyU?=
 =?us-ascii?Q?HPyd6GmrkgqIPpayFs5Zu1mH0f05oD7qoZ43m/f1ojRI2LTOSZxeQoAmqG8M?=
 =?us-ascii?Q?SERIEmKLvjJy1wCNRggBQQP1IiUd1DjGugI1o6PSMquWlRnkNRp/JbIF/7dc?=
 =?us-ascii?Q?F0nWUj6fKLw+uUEs4I/n19LjUTLRaPZfGLfuUIn0wrN1KF+yE/uCagknl/F5?=
 =?us-ascii?Q?zY42fEiu/U7kn+gfbZXXH13hgiSqUUawAEAN/vSD5SToqS8XHTHPe/GW98Ik?=
 =?us-ascii?Q?ubBdL1Kgn3eTYs/fKkNGSXGKji90lYVnh0mTHUUd1p9ooR5ws/Gz7tZWydtK?=
 =?us-ascii?Q?ofQ1aXetTCX8dtinQeqNlPg7yFqe2Ff0ifYHgFNP08dl9CAEMxZClY9Escks?=
 =?us-ascii?Q?69WXodo8S346hAtUAYITaanGRcd64sQtAPT9sEyvymqUiY8OiGBocZ5Mp3/q?=
 =?us-ascii?Q?/PjSbxk8xeQqXBTIRpkCpnQegxIK4we8TrZS7Bqf2qG+4JXzgPzC3YjeOSxs?=
 =?us-ascii?Q?L4XatI4dQo1Ng3Hmz0fDC+eOQHi1uHy40b4/E1OMqUOl6MfFTDMxwxyMBpe/?=
 =?us-ascii?Q?UmXJfGc8W18o54OkDRpMe77wWxbC/rf1PMx0+CSHApnzZBh9nLa6DQWMkxAZ?=
 =?us-ascii?Q?bwCHjlPho3YHh5sSzNbCbw4YlY0geWZfTespGZpBYKnsPn28fgqWFgfgb9NC?=
 =?us-ascii?Q?mJAIuSxIN4NSNoDBa00u+vYOAYrdKEwGdVa5lWfCROzIpNnaBREqtJDHsbAI?=
 =?us-ascii?Q?jIz7Ntw+HA1olqEAQV8bDBJ7ef50dj2gr2Ptoo6o7/AuuAEHS87PVi1IqY2y?=
 =?us-ascii?Q?7hg7sZmIE7Pmf7PM78pjQyAKsHh/OXaB5LpHujZo4Hni+HgUw1ZZCQCGF1ks?=
 =?us-ascii?Q?JnE3eyKQrzFAPerZ4HHbLpBC/crYj9rMYMu9eA+kxc87sYB1jbhGHEwZ6Qdx?=
 =?us-ascii?Q?13MyGe8RXXFCcbV+OHNNPwp//6h3lNBfTvIJ459ULOIDq/z0ajcVwn7hgFu5?=
 =?us-ascii?Q?wrKU6AiU3Xab3ZZrBzuNbouEDryQEU7VVE/Ve+rHi60srX5KLjw9WcrDAunF?=
 =?us-ascii?Q?7NIDILxY2YnWV/DtTim4NuNqhxzRn9z+o5K4HhdGxVtPVtzfmKg9cDyfaYg+?=
 =?us-ascii?Q?ewyBTLBv9n+07+wtgfQ9ybjt85VTBsLxxQ7odKo4WVI1o1kReoCNGuACLGEq?=
 =?us-ascii?Q?4Y5imtfg+EIhZ9WuljyAKVg0L4c/wIc9TNvp3U8xJG9Z/i9usW45dWie2dRb?=
 =?us-ascii?Q?AJ+0llelmVt6dIof/ajpqP6cY19qPMDIvbIZa8rf8bZaKIVYYd4TUwfAZ1UZ?=
 =?us-ascii?Q?5hTV4yLYf/4HVM4dfAkPVNDmlAkABZmrz4iscxQGKZKv+NS5la9e2dkOtL8p?=
 =?us-ascii?Q?nFqJL7UP1bQqdmcaQOQsi3ddK4WwZRFWYZW52Rsf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885414d4-e059-4c65-931d-08dba7804107
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 04:35:49.2852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MML5DDHGkBRVRGS/3hpClWf0F2mmW73TIOVoxKpLzaPbTM1yvK433TEwJ99e3xquLRCWYY0+Gr50v2jmPCnbow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

This patch drops id 0 limitation in mptcp_nl_cmd_sf_create() to allow
creating additional subflows with the local addr ID 0.

There is no reason not to allow additional subflows from this local
address: we should be able to create new subflows from the initial
endpoint. This limitation was breaking fullmesh support from userspace.

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/391
Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b5a8aa4c1ebd..d042d32beb4d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -307,12 +307,6 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	if (addr_l.id == 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "missing local addr id");
-		err = -EINVAL;
-		goto create_err;
-	}
-
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
-- 
2.35.3

