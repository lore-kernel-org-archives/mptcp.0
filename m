Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C82CA8
	for <mptcp@lists.linux.dev>; Wed, 26 Jan 2022 02:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643164539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6sHYfyWf8tjWVT6SDEGMtgsMaZEJHaxPqtDLskH+Io=;
	b=Kiq2sTzxHxKO/+KIW2defpPT0TfQ3FHw6k/X7bUj1eE7mt6PjdCpwas9ynVqZpEdj8Mwbe
	4Sm5NrnU4sr3MKzIV9kEcmnTjkH3QfJSUmhoSytyPx5+Y4YO4NZbDU/K5JN/PoXl8spLVA
	mEqRvaxtD6nyCV4p3Ol1lwKZPCQZJtY=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-fZUnbd1dMFaEBZnnmD3DQA-1; Wed, 26 Jan 2022 03:35:38 +0100
X-MC-Unique: fZUnbd1dMFaEBZnnmD3DQA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRdkmGN/TbQGhKpaSVkrKK0CvwXpqEwXi0HreE01jdFemvV1ILHTc1dILwRrvrPotujOQrfCqOdv/zqqbwhf/alZkh9aZSP6+PJSU3YsaxTyuvvWRJeD6C5J93hRf3CbAPT56pBSfpMfmry2WcabdJ/8mymGwIH8bMDVSLrYnRCQY70z04to+RrJ8o6OBX7XP94XQAuOfpL2NSXOt9BxU/FOZUyeMRuoW5tra+YSPFj67E7vFo/Erfrh5M9BjYNRJWtjMYj1WUwurGNGn+9bVrvPUahA1GSwIMR5FOpKMAGzzZaPYTMsQ400rrZRWvHQV7afQd97TCP5tTabA9BA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6iOarGqnp1ZnmWdX0Zi6E95MtbMc3Wcara/iQhDnXw=;
 b=hzUvyAtK26DeG2zVQNbXtQ/dqExpeG407xSJrbL1bvro0fxVq415k7q4bOmjlznxzzqEOpfQus3Fdqg73wp/PEDgnLAYqcXUpueNc8m2Nqkx2JUsJ7ZwCwlfr3ui9DT2GhesRp81a/axlPvpxMeXYP0C4PySxLe3NMJ+9LC3CjoeQ5UB0DIFKOiijkHOlD8vgEcrqyfjsCBHkd/KunIIEGAedvCbN5NBPRqCCNnSpZsYORGWIIYnezV2S7jPAd5zYEntuxFcPWehFmFpxtEH0V34E+zBHtb2hC8mIoqhJzr8jOH3kLbG1s8VkEL5IhHFDjqTEa31x2D7ZVgONv4YFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4942.eurprd04.prod.outlook.com (2603:10a6:803:59::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 02:35:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 02:35:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 2/2] selftests: mptcp: add set_flags tests in pm_netlink.sh
Date: Wed, 26 Jan 2022 10:35:28 +0800
Message-ID: <231ad46ea1333915880d890e3e0cf9de86b7485e.1643163993.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643163993.git.geliang.tang@suse.com>
References: <cover.1643163993.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e3ff4cf-93a5-4e56-1833-08d9e074893d
X-MS-TrafficTypeDiagnostic: VI1PR04MB4942:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB494204D7D54BB3AA8605B412F8209@VI1PR04MB4942.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1iGULdXMzLLttn2zUe2hbbKw/2eKqy+tPEgDBFLXy+JEsc0K8BbulN+FhH7GH1q/Hrj6fYHSuVdN++lQBIes8ocyUdn9aAyNYOjGe2CXimiVz357oIvXRF8O3NbiA9vv/872JZVdBTvA+IXyD/riFBTrkzm1uiX/nwqiSUYdOORrk3BDbGn9jkQN9i4hCbo+HYhebk41Mm9mukhQgOKEbr3J9T9SqnZD4JNUYOjHd50Rd9yGEnJ07o2dDugiiN2j6WTmfZeDPNn4T0jWO/WlcWd+TlODc4omaCouXNKFBk5xCWPYF1e7AJEP6QQl1sr2ZahKqWEQUa2Q6gyeTEObHqpVc9zJEGFqRAQB1TxtYvqh36+tO8i76dfey9gU6QK7YZySXJLSlspBY3gxOrWe/fiiwLhm3s94ljZts0Cp2D/66HM3YHfv1hn7xXigLBDAPRAZ1R7BU/HZhmq435XFwoQz+wzZ9VcWI9yFAoRfbbMjND7NodiOKrVoc0EYlMHBZFlJsVeIaVNyZwoVSm8b8bCx4ALaBVxwdi8is3BBk8Nfo8B30ocGZGTP0m9bCop9vjCRjt2yFKYp3D8KBRt/4RSdNXEUdRCJtP9u/6s8xEqHsmjWjiaH0w5oq+o9jQyK2S33aoH4zbkQQ53hsyjh+g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(66946007)(66556008)(66476007)(8936002)(8676002)(6506007)(55236004)(2616005)(2906002)(36756003)(38100700002)(86362001)(5660300002)(508600001)(316002)(6512007)(107886003)(26005)(6486002)(186003)(44832011)(6666004)(6916009)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7CCJEfJVoFhpqWxkbaQoYcaXYjVXGRDZBgpPHZZSD6Hd9TtaQdJuedfA48Bx?=
 =?us-ascii?Q?tkrK0LD2iI3LfL7+KEbDOCzC/2lGiEEm4qqHYiGxSwBosgox1jMFs3WIiE/q?=
 =?us-ascii?Q?tO7Z3i/L/VZOvbiDUcejNnY8JjNQv59NM0S/ucx5b1x/AGgvVzO02SgiOJWw?=
 =?us-ascii?Q?DNspENgBxMIy+fJXqHsJ69ghoCP2W8AiMt2PHsY93YTpH2P1PfSU1iFBSMtw?=
 =?us-ascii?Q?+da0yQ5OmqKYNV5VUTKc6REnhfGKUzML9QU1+DY4H+l9FxK91ydWYrO/gr8h?=
 =?us-ascii?Q?5ogTchHNAiT+euNo7Na1pBAS4XvkefDaJdzx7lqxHjk2hOvFRgWtonoaS2GV?=
 =?us-ascii?Q?BXQYtvjN+tpmAezcyxKScDcXss+VxRm8mL3ZS4+OdB/JZzZtkJmEfU7q7Tib?=
 =?us-ascii?Q?1xHZzo91oaWBC5KMXFTBd0v8snyF/bLcLZ5ekvF52nATpzkTnYpS8rswRtra?=
 =?us-ascii?Q?Gv6SUs8U1124dyiULXuuRoWRS+Bks81RKkOQAEFjLWr17jlrgHFGfRWV23UB?=
 =?us-ascii?Q?n2fr5Aa4/OwxYFXqyZK75keZnBA/Dphzwlt49lnUjaELOc/o66pxSYMkLkRi?=
 =?us-ascii?Q?750NBmLtS6jSYh4QzfndqwwDxbq/l8M51cgnCJ7YMtLEZferohC5AW9l5g/b?=
 =?us-ascii?Q?JtSPffxnKLf4RMxrEXYpDfzVXBeuQTT05F39drJPpiSRRdfBvE3EVVal1yGm?=
 =?us-ascii?Q?MXsivKGq7dnamcC8N4CYL0gvmCJzfU30J4utEMkXWViyMbOxnMOTU5Iqqkxp?=
 =?us-ascii?Q?31RnvHxPM+f3dotz31SwhwBMxgdaSoHwy2/NuFzgsI2WyQEmT8ouiRG2fNTE?=
 =?us-ascii?Q?XyJTwQmXgQ7/xnZ8oMecMXYgAZDR3FCIiAKmNgBE77zWwcRXmOBG4WF0kPv/?=
 =?us-ascii?Q?VS5QOFe5aI41U0f8baER77v0ypmV0IqMYG5E3XmgKBigp5ONAiFlbBst+gyR?=
 =?us-ascii?Q?eMwISLT1v751DuXvK+WC80kqRd8OuDK8AZKdCgByTrDp9R+fB6vUfDHJ/P+8?=
 =?us-ascii?Q?dobs/xQGANvIzY3Rnlul4nzMq8L+vldZT8FleTy0AAUQAr1Y5JqKztDfKqS+?=
 =?us-ascii?Q?bAibTml3tsGgks9RJ54xWd67uh2KfTRWPba0HnTBbr5nsQ9vK1gBpoUkpmQc?=
 =?us-ascii?Q?Ex0MYUvDCFvphTbzg4SUuZcaZa8o3fobx+PhnTj4smQ7V+bOBdKAhG7z1BUL?=
 =?us-ascii?Q?hicxjtszhwwUstPphc8aOqM3CptVZfDzSqRH7QOFfI+ntY4WZa72fPAT1ECf?=
 =?us-ascii?Q?9gDSNbOYFMDXkhA0fHq9/8ce6u7nuAuV3UGvkvT86JRxpQxp26po6Aoi5YJW?=
 =?us-ascii?Q?vS7DRGmk0fDBVlqRdgogLf/VDshTMcHz7uyB5Mz1bRvFog5M8UgHdVMj+Bd4?=
 =?us-ascii?Q?CYd+a97YZulf2br72UAEDHqKfLZjflFrVPdmanq2hJDLEGrGm6kn5f+38ecs?=
 =?us-ascii?Q?3Wr6cC318aKaswpK852tQTGMJyXnE3/aRcDUSn4Q5z3R94W+9294BBXulRMJ?=
 =?us-ascii?Q?rh/GSFGntw8b3y31yFhDFHavbIX9FsZPSNufSyyD41phHe8BEX0JGM00yC/l?=
 =?us-ascii?Q?M+aGLcTc1IKb3nxzPizY+m7fVJXol7kqyoKaS2ufeXWRUFvnQ4joGhdsJfw3?=
 =?us-ascii?Q?KOrfo6P7a7TC51B4T531lsE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3ff4cf-93a5-4e56-1833-08d9e074893d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 02:35:37.3727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3MwV/88GGU9n4qBE0WITXhU0u2ea8IHLXUqxcZA9B7qLM4IhjdRh/c3QswY/Mk9J+5Cn6BT4khXcOgi2hNUKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4942

This patch added the setting flags test cases, using both addr-based and
id-based lookups for the setting address.

The output looks like this:

 set flags (backup)                                 [ OK ]
 set flags (nobackup)                               [ OK ]
 set flags (fullmesh)                               [ OK ]
 set flags (nofullmesh)                             [ OK ]
 set flags (backup,fullmesh)                        [ OK ]

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/pm_netlink.sh  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testin=
g/selftests/net/mptcp/pm_netlink.sh
index cbacf9f6538b..82c056a7ae8f 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -164,4 +164,22 @@ id 253 flags  10.0.0.5
 id 254 flags  10.0.0.2
 id 255 flags  10.0.0.3" "wrap-around ids"
=20
+ip netns exec $ns1 ./pm_nl_ctl flush
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
+ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags backup
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+subflow,backup 10.0.1.1" "set flags (backup)"
+ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+subflow 10.0.1.1" "set flags (nobackup)"
+ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+subflow,fullmesh 10.0.1.1" "set flags (fullmesh)"
+ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+subflow 10.0.1.1" "set flags (nofullmesh)"
+ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+subflow,backup,fullmesh 10.0.1.1" "set flags (backup,fullmesh)"
+
 exit $ret
--=20
2.31.1

