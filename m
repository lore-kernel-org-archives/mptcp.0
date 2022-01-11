Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9BA2C80
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 02:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641868979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMew4l9xscdYs9c5jqlser1+toKnZknXvPNc6InxP7A=;
	b=WuGszmcPSLhFq/n+Yhwxm/dxtNNzNyoZOHKsOyR1Q5k6BTcnAeTOAsgpPDY8GftdiafKJS
	4I6zsS6+v3f7eUfgEw9AU74fI02df1LpyYvVmcRA+3rtJQnQ62Ff0H3Ue3jcY8sE6d8ywS
	IEQyMKT4WWJCTrWHo5Cy82NxaPhhfnI=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2054.outbound.protection.outlook.com [104.47.1.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-y532ymbGNi6jOBnj4jMDoQ-1; Tue, 11 Jan 2022 03:42:58 +0100
X-MC-Unique: y532ymbGNi6jOBnj4jMDoQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pn7TruO+EpgJqqKTHkhSBvwI/Zhaf7Gsd5Ljk5a1GmFPZHgbPdkxdjW5cs/p/D3xwzgyPLU/qtpqwFfUDY5ok3b0j3YJELLyxuHrsqIhTI5hSNTj26rwY+EM0O0T6EHrjJxWbTvqPzmOvGR0zf0mBxmqeNXybhvvCTHrzr8J3EX/tR7Fjk6LURi7hxMBdDWRRI/V+9KZ334LCdRoTYZMfNdK2S8gBLqR73D/aD+yxxqOiM+YG5JjjPU0nkNTUCusuU1MindAYiTnyWIRgLxZHuX6h6VZbIx8GTCw1Z3zsb4nRA/l0a8O87s30EnEtnB2OGtRZZjSZWA27aFr8J7GLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQUnpYbEoHF2zMRA3wOV1YN0EjnOifmoS8HNOZxvHNU=;
 b=IUJo1dKUNYQfJE1TnUWavH5TenF9vpFBZOH6HTN/5Hprq628LxGloSZa/i/kwASwuex9GV+1PC1MD5Nihbz6ZYj1cd2jRLvqACVrOEV9LfvlRoBuiom9th4dcsEf4Y0HN+hz+iLC58jh2Qkk63voxk7Z79IlzrMWVa/zZHp1xm+kHTvBBcCNKA5+AAc7UYYUj5CEYzzVBeLC2JzsgJhz9iq5Lgoiharqwt8IV9amLnWg3526kfS2Nm2bOYg+eMLbbjmdC6eMMD84Umpfnco0WtI2y0iEGhG59JwegXReiJn+YhjVQwjuazcOls5w2XN1LnQX4bv+h3uxn75wYMWRiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3435.eurprd04.prod.outlook.com (2603:10a6:7:8a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 02:42:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 02:42:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/3] mptcp: set fullmesh flag in pm_netlink
Date: Tue, 11 Jan 2022 10:42:45 +0800
Message-ID: <503652e15fb983e53f4b20a95eb24dbde773e12e.1641868545.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641868545.git.geliang.tang@suse.com>
References: <cover.1641868545.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:202:17::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32b625e2-29cc-4009-62df-08d9d4ac1319
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3435:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB34353B81B5C4D947AEF1C013F8519@HE1PR0402MB3435.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BtUEUY+Hf+yHdHPOPIsoDj2FYVhjZssMLRX3w9BG2na3CQDrKdgR0tqClrP8AdRobMPQJGB12Cm+0TcGz5VNGJKZCR1mK10DdAi3MVK7Jh/95/Iulm11v0m5QaBO1HhZrLNTqa9DShudSdes4JEnOOiFNfjK5sj8z1Rxd0BQj2robmb4V5NlPUSxI747IvImKDQcVCI4yaQR2H5I7bVTGJkFDJhvKljpxm+XDlUmMjWLimCtElKIb6Vmax/P+jyvc7isY3pYnbrYNZSXnomZ7chq2nxkJ0Ry4mWUMl5iByn4CNPMsBZEuA8y/hc0wrgmwsMVXKVdpjGo5eukCIvLtudC0fjUSFtnl2fhZtCbW7KtyKmhIu32swsIYcLvfBv243070mVVSuhQYFtrkQt6h0ac0QJe7c9hWHsmzYjO2pmJ7T4fm7TsN9b8/7zEf9BbQ6BhwbfLcwEAVo3Y3YCUAg5ZNILLRgE7yvoqbZickxKEPfKtSK5NF/QF9aez5pSuHUkCGu2JPCJmfItPgY1Fmz0Az0YTHJFNfDYF+xGEVf5wqGpGlYUjQkpV5eRHW2Y9uC/28znyb9hBWtdnr3TbzRadeLF1ZF42qG3p5PogdRF+jx9g7uSWJxi/eX46kdJU9JVO1LQirPt+l3Z1xKVZsQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(2616005)(8936002)(6512007)(6506007)(508600001)(8676002)(86362001)(107886003)(38100700002)(2906002)(316002)(83380400001)(6916009)(44832011)(66556008)(66946007)(5660300002)(4326008)(66476007)(6486002)(6666004)(186003)(26005)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A0Gn48oeiOFRPHGBtmLh/2rvs4hHkn91pgBGVjJwcUumu78ISNRTIkRmmkSd?=
 =?us-ascii?Q?rLrNq3VIF+vrPg/9CXPM/qxOTW5BrAlTWDvOPdDBE0qmel8da0uE9hQQsh+0?=
 =?us-ascii?Q?nuNnHmwbbDC2+k9tnh8D0BAodhqZrqE82u0g2CfAehlaHq77ggpfmuMdjCvZ?=
 =?us-ascii?Q?AaNrbqV6A/iCk7OQTlEYUF+/cN1n4AWt9lF60jNMV2dsOWtQj2LmiLvdQkIn?=
 =?us-ascii?Q?Z6IVnGXMnJXTvHjaR1uNp+gwxDQpNX9C2owj4j60D5MO3aGMSVsMD2ctKvIW?=
 =?us-ascii?Q?vgeC/uWdTQh8nMJyFcBsd1RqddZYH1Rn5CATxcG/n/5a2+iamCMRhOcWnA4t?=
 =?us-ascii?Q?zqTiRU0SMoHoL8R037LnT4IXByHrRxoMePgAbogWbx2lsjvuQjLinzavXvoL?=
 =?us-ascii?Q?vKqyMG7vF+lEcGXFAbndX1Pgd0M6El9rnKviqmu6eNsycPQTv6zT47ZcupVf?=
 =?us-ascii?Q?M4xuv7XqQXW6S6vwpBa3H8ayHHJBbPY/ONTQfmSDNh0D5CwAFbf2fksTRhQf?=
 =?us-ascii?Q?IBEIJXeh7hub9TdpHXGKvwEf2F75WuY9ErgducIEayflpLy3Gx9BDOVsJ0FA?=
 =?us-ascii?Q?blYEB9j8y4G6ua4sJOwo6L8kc75CVsPXKZQTlwtiCSYIaOzI7D2zf63bGJjP?=
 =?us-ascii?Q?3yfMa8uSW+eF+xNDFS/GyAcbctOkaErAK/WLssOD9+4Aw6jYVKqK/ELB+DCK?=
 =?us-ascii?Q?Igak6QomcV4IH22MGI+GdkJBC4c4/J/xCNJ5mU+lpYVKszQqHqdu3/HdHwH0?=
 =?us-ascii?Q?nETz/NYkrkxdhNI821asBWo7HUWAJeLEVIBhuhZ7/8gJWg1jYbx+o1KZMvSB?=
 =?us-ascii?Q?SUgt8f21VFbQ161ZUc289vza8ZI1WETbQGgvTiZ0uurM1zxfonhQoWk0VnZE?=
 =?us-ascii?Q?zQIfwbsSLcvjHBxBE3bFSADUBzGvM4a6tbGAys02OsWAeSx2Y0fk9qxPQ1zv?=
 =?us-ascii?Q?neTkwxO5K8ZWMh/YBvOiom5of1Kv7viO9+QSYRwrOkfI1uKbrzrPlFZ+djNV?=
 =?us-ascii?Q?rAlse9ZG0wc3qLME5xn3YZg2tnqENIXoAB1bY9tqUxn5lG1sqHwg+cWx99IN?=
 =?us-ascii?Q?FFxIvt952fh6at9th7V4bEwLV1Pv9/L3upUUBayzj4wVfmaBpuTMvrWRYjYN?=
 =?us-ascii?Q?X74+uMt4/Wv2KpxMEttIJscZT96/kad0SzAJr4E2TmxgFzY3akRU2tZGpeAl?=
 =?us-ascii?Q?0S/ug4yQvwNvgjNFiVa6mvsDTq4tmNkdgUUxwerqB/v4kjZtaOq6LFKitB6v?=
 =?us-ascii?Q?BF4iA6CLkkLmevJMcRyfImWFf/VEMR+AqTgs+YWcWxtxUcPYLT99SKl9281u?=
 =?us-ascii?Q?/nhU9GTyqK6aQgFFPygyGmayDr+Vry+RdIXNJWR+T19q8azzOFg6KkKcnZPV?=
 =?us-ascii?Q?lZRKIx4QLkI/ip5O4UIAxNOoHuAmQqYkg5fNQ45YaIWHZtvPAUjG2irpUgGs?=
 =?us-ascii?Q?A1DYfdMbx7j1Gj/wAgB8pQz/PPRzYXSkN4yf/WcaR62L6YFUIbczQTGWKxuq?=
 =?us-ascii?Q?jIrezN2VKevPprj1ylZg2tQNJFRU4A14AhOlb0Cf8pULeXbBrSIr7dVkvibn?=
 =?us-ascii?Q?U0jw4gWFvI/C7HVPSWc5GhGmPQdqHm1Fzc8bSaRfdVagqRG20vBilWJUeCah?=
 =?us-ascii?Q?mOX8RTHq6+NmZWvBe1/B+5s=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b625e2-29cc-4009-62df-08d9d4ac1319
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 02:42:57.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uG7DvCTvHO2HkPPXH/6TFwBw8vHP3+V0ZFT/77pyfa0qSUIyy3NTuqZpbKlgv0IKhIjI9I/mECqJB2CpDkyPlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3435

This patch added the fullmesh flag setting support in pm_netlink.

If the fullmesh flag of the address is changed, remove all the related
subflows, update the fullmesh flag and create subflows again.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm_netlink.c     | 27 ++++++++++++++++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index f106a3941cdf..16758e124e51 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -81,6 +81,7 @@ enum {
 #define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
 #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
 #define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
+#define MPTCP_PM_ADDR_FLAG_NOFULLMESH			(1 << 4)
=20
 enum {
 	MPTCP_PM_CMD_UNSPEC,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 47ad00d01cf2..1cdaa774cafc 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1743,13 +1743,17 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *s=
kb, struct genl_info *info)
 	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
 	struct net *net =3D sock_net(skb->sk);
 	u8 bkup =3D 0, lookup_by_id =3D 0;
+	u8 fullmesh =3D 0;
 	int ret;
=20
 	ret =3D mptcp_pm_parse_addr(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
=20
-	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+	if (addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH ||
+	    addr.flags & MPTCP_PM_ADDR_FLAG_NOFULLMESH)
+		fullmesh =3D 1;
+	else if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup =3D 1;
 	if (addr.addr.family =3D=3D AF_UNSPEC) {
 		lookup_by_id =3D 1;
@@ -1760,12 +1764,21 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *s=
kb, struct genl_info *info)
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
 		if ((!lookup_by_id && addresses_equal(&entry->addr, &addr.addr, true)) |=
|
 		    (lookup_by_id && entry->addr.id =3D=3D addr.addr.id)) {
-			mptcp_nl_addr_backup(net, &entry->addr, bkup);
-
-			if (bkup)
-				entry->flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
-			else
-				entry->flags &=3D ~MPTCP_PM_ADDR_FLAG_BACKUP;
+			if (fullmesh) {
+				mptcp_nl_remove_subflow_and_signal_addr(net, &entry->addr);
+				if (addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH)
+					entry->flags |=3D MPTCP_PM_ADDR_FLAG_FULLMESH;
+				else
+					entry->flags &=3D ~MPTCP_PM_ADDR_FLAG_FULLMESH;
+				mptcp_nl_add_subflow_or_signal_addr(net);
+			} else {
+				mptcp_nl_addr_backup(net, &entry->addr, bkup);
+
+				if (bkup)
+					entry->flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
+				else
+					entry->flags &=3D ~MPTCP_PM_ADDR_FLAG_BACKUP;
+			}
 		}
 	}
=20
--=20
2.31.1

