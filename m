Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2055.outbound.protection.outlook.com [40.107.104.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8A1525F
	for <mptcp@lists.linux.dev>; Wed,  9 Aug 2023 07:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+ZjP5QK2AJzrQYf0Tqxe7do20566s2Ow71CxLBu9BjmRaYT3Kx6QeQJ/4iUH5B7ZYr3A3J29VSg1B2WqCW6gm0DdQ5pn+yyDNZ1g/fP7yZusBb66lNbjiiduaEdwHRqGN4EYjoPjl4fK2PFiDISML1cNNC7Rj0/g+FQ71zU0lzdDdP6KSJIyvXGFzzAsmd5aezbgL1RNCES3YVhBXmk/HwpTlwdjKCFnych1OFQU0xQK8hH0Ojr1qcQKlPAfb/dH8GwWTgHVLXZ279EPezfGT/IaygcXdZNNQoTastIg5fRXw8fwW9XR6NOddhgYn8zuY7dLJW8O5U/ZNaNlIttIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2XXCJd/g3gGPFRi9FigIonSHLoLOG9WdKxj0s63yHs=;
 b=kbax/DVUU9as2rONDNGKb1+R1AHCY+76AmxSCXvuMand/x9tZJXp1HhEcbO7+zIyQNtxDij6o3ww+9GL1g1gT7BxmHXmiyMtN0tkORh5l83yRPZDrY511a9usrjNgq1yCYj63rBr3IWjCBLI4/YX+6TC8i61OPTTwqgfcadr0wMuaCORKIEiLg7JHJ2T42IidLv63qEuvFzyCDkjqsSmgTJ74TtiTucQBwdzQ0Wr1rpTsyQWWPpZ9EjB81dtd8Cd7crMoDUXkg89V4uLTmFJrTjgvdxUDxyd4Ll0qZ5oT0oIkCp5fqGyV/ubh62FNU5b1C4S/D1RmNqVtoUUPTUTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2XXCJd/g3gGPFRi9FigIonSHLoLOG9WdKxj0s63yHs=;
 b=riPt/GIeNwHxI/0+co/QEoKDNrmpwF6PujxSh3kcGCq+CiMKgjy63vio5Z50AO/MJGNgxJ8cpacAD6uScazKgNnpH0YfGyWRnqGrjFdDXMaJ4RKysxLX1GiVHQrPOQsu/m26BVrUHkcmbP5TseHvSxcrxwPdLpPGgw2aBkf+p3aXfTkydisz+Ed0zMyhnyIDFy2hlg4ZqDiPNIlZfIhTlj0weGth4rwNCdGlJ4pv6E39EfdHBg9dmi+mlcd8jt5VUmwIC8PT07E8L1+jXLKPp6Yj/EsCCY174UpvgHUsmB4/147EloX3hDpzwit0aqNfN450NYCjA5/CpvtBmKx2WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6850.eurprd04.prod.outlook.com (2603:10a6:208:180::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 07:06:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 07:06:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 1/4] mptcp: allow creating id 0 subflow
Date: Wed,  9 Aug 2023 15:06:36 +0800
Message-Id: <efb369fe0736ae4ad6feec390a22090669c4c766.1691564649.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691564649.git.geliang.tang@suse.com>
References: <cover.1691564649.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0297.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: ec782c56-d1c9-4633-2023-08db98a72f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BBQAIpAtg+TbNqvEnLL6QKb6gVrO/ks+MwBCBL1HLT5oYvy0NZFUDynEbqw9eoCylkoITy/Pey9z15kHNQVQpfjExh+nXO3YERj+ooYYGhjfEFVNhXSL/p+VO8XC26oNM4lwP/ozcS3bkYDb8ZvZufYrBw54YN6ghzWHLsvToFhWvsHH9aqZl7u7l/K7qU6SEpw0xOVly1fcfR2vNeKBhSFAI/+M076YezZyQuaEWd38ALDzVRtFU9vZtRc8JyMsfo1amCc5JQPHBu9EE/FcEQaXv2xbaKvpZzJnjrOJp2EQxB9SVcM+U9F2JX+VeCiVf0WBDTP/yE/QSjgqRkNNVNliVfdL15R5o9QQ3z6WPppcpX4g2S9iE1bNv5HMpiaqq9hGlHNq+aIRBoxX3OXb3JWsvs/m4awe7n19ZWF6FFag5+25xGk9UypJKHATJQNmj97GSnQI6SkCPsQ2ojvjoa1Ul4UH3575/Qysh9PpPs5U2YYlmsCWq5EJTphuObG2lzXApNntWKgbWT+K9Vo+oneLFZ4K/+wXn3n1UlzP+ZIESpv9+szSkpGIJ/mUdDURIbMAPc/j8ufT048q84CMgv+BA18byVKo+yczY4FV9y8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(186006)(451199021)(1800799006)(6506007)(38100700002)(26005)(2616005)(83380400001)(2906002)(36756003)(5660300002)(44832011)(54906003)(478600001)(86362001)(966005)(6512007)(6486002)(6666004)(41300700001)(316002)(8936002)(8676002)(4326008)(66946007)(6916009)(66556008)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qKJmXOqMg3IkS3WPf2osPONAaBMTQ1/DLmZt7oLeOKFINWtIMBpxFzY1Ddlb?=
 =?us-ascii?Q?pWnZiW8zF/hkyTNpyANmmYCiDoK6wtrXrlVXCoPYPYpYAHu0pqJp0+SyoVB9?=
 =?us-ascii?Q?sUy+tBYRjhazX0H381zuehBpfEh+wx9Cm0ulKpgpWpmZAQP6GikUYova2HAY?=
 =?us-ascii?Q?M4rv1gRvVJqYUCf50HXWQKm2XWLVZS3uJJ0klqUo4Aj22Ymo3YNr+L45vsEX?=
 =?us-ascii?Q?yofasMirTyikgqSfo0yE/5i5udqsr8SFGsZob6yzVh4jcI+w8Ztsp8PosQL1?=
 =?us-ascii?Q?kFEWLxHsL/JDsEZDvPPeGfI0BKjKXNxpNY3vl1KK7lPwNmznXJll4opWiIJJ?=
 =?us-ascii?Q?CQZSpq+EleQUh9CeetU5ayGU6EdNMgguGEpllnfwNjk/WBUCROzNvHvBdHmr?=
 =?us-ascii?Q?ncHdZe0kv3KTDZ0EMDHDrCSMFiAFknyMefrYzX+OrIhk/rEh49PXklDtD3ti?=
 =?us-ascii?Q?kcq6MR6ffVjKShNP7VepB+3rPd2J/v+iSDC2QiEZHHL58FUA16GANIkboead?=
 =?us-ascii?Q?IrkwYBjF9Vq9jSWgvseT0Qcp/MMKbfRZDsb0qZ4N1huinvGtyl7c2Y2BrpDa?=
 =?us-ascii?Q?1UlaSsLc9VLAnoHniOOP0eLGb6R433qSrxjrazHMF9RyIOAUfVW0W8LUS2Xe?=
 =?us-ascii?Q?YeROigrbOpxpvGvpPD270sCDXE74HFlBrOjbaYLwvsESKgOmUXnNIw4fvHHn?=
 =?us-ascii?Q?Oyh2HPohOLCvIIDcCFvPjBBnewPNOkP09VPLof0K3Q1/joNqW+CtyCmuues2?=
 =?us-ascii?Q?lW+EX5eWNbdT4XxpdMO0YJ7tE4EDuYv2c7iyt7QLy/CyEw2Qrwf375dsLI8W?=
 =?us-ascii?Q?8wf+/Ca+b9wFgGpycLRdBe/bEAiS9zs5q3x9REGiZqI5HWqyXH03DpSzqmp9?=
 =?us-ascii?Q?Xcy493fE8Xm+pWbJ1TGIgWTtscccdfm/948mcjIWGtNkOcEOO/FfFZf29c54?=
 =?us-ascii?Q?yuL5YaVzuqUKJwpbpLyiTvfQ39SpUtDdK1UyNhfXN3ag6lb1On6s+ynSmkIN?=
 =?us-ascii?Q?htIxk1/IaDDqfVzcVBGdnhMWl8Ta4bR3iYqZ0svpfbGOehZKFyxaNvUqq+7Z?=
 =?us-ascii?Q?Rm2ACs8MJxmchlHHxdpMNA03tfwcERC5HTsl/06l2awKCLELL999Pqjai1zj?=
 =?us-ascii?Q?jPdnjqBOAElon5RfC1G/T0Kr0QNxneZWDTkBWIMtS7dDJEADa2HM29d6/3tR?=
 =?us-ascii?Q?H/UanMG8AyRyLHhI3EiXggEP2wpnwMoAk/rGoHR/eSpQQ3N00kdE3pyg3DUy?=
 =?us-ascii?Q?Gr3TC720iskM5pNpCfNHjOTKVddzCTYuU/NfQFieFRrhziDz8/Op6y0Ov/eV?=
 =?us-ascii?Q?wF5CMfx7SWr7Re7IzPTTrnvfCeYkGONH8Mhq5VJQgTsrJogcrKRZqm3qImq2?=
 =?us-ascii?Q?jr2iF0Bd9D0W75DvWVunj8DkyWmvJV2fPzcJIFALh2IwVYHb2naSuAXDrLNf?=
 =?us-ascii?Q?OugTVIpPPBomPo+/DNiPeSxLwoELwfBPH87aen/MK4l+Pe7xicB+TBaLLpLu?=
 =?us-ascii?Q?OwsC7JE3MOj4gsVwjBhlwhj4OQiItHqNVJr0XEQOZTXadZadto6/b5tiucVO?=
 =?us-ascii?Q?2aNoZX+gKDbTcuIQLXiGR5vpIah0AMhjLfsvEfsi?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec782c56-d1c9-4633-2023-08db98a72f9c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 07:06:43.1272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Efbr4Q5EIdNLCi2+Zu48d2inCijzh+zeOJkz9h7G9AWHhjxEZ3kVq+I76aGQKzWkOzV1XFKAjRM4HFDDUkYH0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6850

This patch drops id 0 limitation in mptcp_nl_cmd_sf_create() to allow
creating additional subflows with the local addr ID 0.

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

