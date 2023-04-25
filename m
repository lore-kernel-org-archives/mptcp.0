Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2070.outbound.protection.outlook.com [40.107.14.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637307B
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 07:56:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Weu7vXcTOxnVh5Y3zhe/oetiOwK2tYom642fyb4hRszETPa5S6bpip9arSfPOLdSnWDohqCBQnopTBi2gEDlW8SqcoG8NWqSTmMFHMkj1M/Afsdzbq290cBEilTOLrZz4SHCER3D5KsXVwH4Hpz032UMUau+XHIsk1zKSloBhp/KHHaznPG+ERNY4fOqaKedPPe/feGV8O8YW0/7Ul11Gk1RQm5FyllX6/vTGqu2hN3h3pvIlIWgRBrGYrbGDpSPspIKP775lW14o2D19aRO/hMubrWI99MjyO3DMONdL1xdB04KL3NIl+kwdusJRINnbyEC56fxV+IjyBmm3e/8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXrnXfX6S0970Esj8M3vN3Oc33NnxMk3LvWQlPs98n8=;
 b=d9jXtTB8tap7sB5/2PCUCOF8fFnS+knSN+PnDqKkvexI5WlHVFKn3TBbDuFU26SmZNl4JqsjCLgNqsI3MhB1rU3RWIBq80pSz+2DUm3CKPZXIX0EdnEX+6JY+TU73JktEAKg6XKXlDBLlRgFyNHMrwOoD2q3WyXZuvwBxucBLrluDPWpddsJmGHbCAAqNCYtDqayzBT6m+ytUcRistU8a3BQb4r5tu8RoRF/zZg06OCQ/KSfyOfiqscHMpIjXI2hPFf3nuUfKZu6vd4D5UoU1iEpFV8WWRVCJfkFJj7/eSRhxytg38p6X/lGCJLoumq8oy4NsfhfvAXP766uG9yPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXrnXfX6S0970Esj8M3vN3Oc33NnxMk3LvWQlPs98n8=;
 b=3FmiMXGSP8KaPPn1nzfmCknXduaJqToADOtR8I1G5OUK9Z8W3HKo3h+LL1nXjHZkOg1VkzYM4LSfdCAiRDh0iZOG22/qkr3wVFWoOECy8e5xSF8C+/4dXwTUlkq1ivoW00OHvyBHACrc0CFoCTqlNopRJyWyxZfFZNXADRth9Wxcn7z1aW5N1SmJKXDvWBS92KH7/h6Cw+XbG7K2EMhpMf8b8JVRT+mdwOePn/TADxTVuhxBCqRUV579JWxIOpcf1QembB/1VUKKilQ6EKuQT3s8PDj8HiY6jVtpgO2iiJZAaDGnfUh4QHn96Ois/PGWHnKApfim3xWjpcY2rTdO9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Tue, 25 Apr
 2023 07:56:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 07:56:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 5/6] mptcp: add addr into pm anno_list
Date: Tue, 25 Apr 2023 15:55:10 +0800
Message-Id: <9bbb727d7115d7339bfa91bd61ba85386e998aaa.1682409247.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1682409247.git.geliang.tang@suse.com>
References: <cover.1682409247.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0171.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB9366:EE_
X-MS-Office365-Filtering-Correlation-Id: 69803ff1-49e1-4a14-5d31-08db4562835f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	86+4gXjB5Lf/TRU05MDl051VJH236fgJGPeH/XcQDWAbUxBIyZzbqVMOyh+RswuqcOlMNqZN5KwNcdwvOE7zDOK8JlvoPTf3C0CNB5MO8k1YI91Q924aOafnTIGQOk6RgYfhKRZiMgZ6+jeJNwAyD2Va5QTqvLZPOIKLStblWGpU7aIP9UQoFOWDxA/B4fxXVjQAbFNC4SOZIhZmCIJms4jtZj4ateB28ufAH9HnSKQxsb8O4JB5vfJeXuaZoC4/JKAqhpOcKahcUBBhRrtsvWWIKA/T7VNYsmOseTieOSDDbS4PlqRNUPxnk5HERRaVlgvXsdVQOSGItVvw+FZ7+Z8TGWJ120RoNXKYKu3O/4hYOYtWCNbyCkitlYy+pDS7mb9kxTzeWZmspPX0HSlR99Mo8Ytc4nqJObFG3sN2YqVMvZIjUGbqW87jodcg+9k91tmwJsNy9xJOJy7d+4SvlIc7n374C734c4LFvEU0laipjYayYjmPrGhL72YGxzVY6VnjDYNRiWySy+0LnOv4wgViWiFJVVb17NFpGyHu4No=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(478600001)(6666004)(38100700002)(966005)(6486002)(107886003)(6512007)(26005)(186003)(83380400001)(6506007)(2616005)(5660300002)(8936002)(8676002)(41300700001)(2906002)(316002)(44832011)(4326008)(66556008)(66946007)(66476007)(6916009)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ewrg/Uf1nURhdUfuIjl52w5wLv75E/VlK1Li86ufAZWRt62BH4kUO+4ZOREG?=
 =?us-ascii?Q?q5uCP/kvgpr6/Lg6dI7TOm6TGGU+BwgnprXahPTRw6V9wW/32cUWZHq9YBNy?=
 =?us-ascii?Q?BFliRliz/cEOzXg7pZCPAW25lL21jB4UT/MppcvaTFahJlXH6pYZ1WogYgmv?=
 =?us-ascii?Q?qiZiuX72UgYj6TDcF5q/NcgMfmMztkOl0psZpDrjWW2Jwuw8w5raQCIVX+rE?=
 =?us-ascii?Q?mjkXgi0Xn8hO2ir46p3wKIlD2wH8fYBlyiVHCbHua4oM2+aHP66zycbuFk9p?=
 =?us-ascii?Q?odHKqcHZpF/naqooXTfC4aVrq/xeBHUS4gjzikjaf4WfJ+feCVLap+Ox99z2?=
 =?us-ascii?Q?EMZcPZs9dNZ9AhcbAxtcyV8TpKcA/QuP8vO+bQEqbWo1utslsZib2kk/kbaZ?=
 =?us-ascii?Q?ogsdp0khn8tetUqifxUfMyqLUuFuVLTQWki+KqKVmmdQkWVvNr4Wr/duAhYg?=
 =?us-ascii?Q?sHoG5++FwaBV95Y2A0S9LDweat4HT1k1rtRZ2nojWNIpUU9/uuEcAmSZ7sot?=
 =?us-ascii?Q?2Sn9SoO7lhEdh/ihxVKh9vD3Hwfbv8GMQ5Lwte8LNiYWqJ3ThtPWTA2qmY++?=
 =?us-ascii?Q?OlgD/0JWKbqSUFpQQq8Y4rEesD1sJjXQ2dZOYc9ui5Byrdvx5cV24wdEhZ22?=
 =?us-ascii?Q?MILkq1nuo5IRCnLWmEb/ToAXdV/wASEfLVL/GpQ+f7/hGpvTxIG8X6WAcfW0?=
 =?us-ascii?Q?uzbqd61w31w6AGhwlFEHffbNWFtoj2xtUTaXlarGAhAdJtOefsL9Ocib9Yfk?=
 =?us-ascii?Q?KlUa3WfkdpwN6+O2jYSOmnn7yLyZLT+bPNv/FJVWQ4LZVWL2f/K7QlP2AtUU?=
 =?us-ascii?Q?17yb5yYomRbD1nAQOsZskta6zXmm8dh24LjMQZ0QiP9UF8BZ3R37Cb+4RfPV?=
 =?us-ascii?Q?YyEqVbM9RKHD8c1aGZ3OH5SJJAqaik9SLC2Lng4KT1aXxx+FCKz6mYo9GuYq?=
 =?us-ascii?Q?Q5E5Hww+aTojzNGEM+clWg9VFLeyN/lwPZbod6dwdKZPBSjD2Ld0iqAUTsBM?=
 =?us-ascii?Q?J5TUY/H46seyGlC+HDlLsiYGocZIEUt7U245O2Fwl+UoMS7Gf/Tl/Y95drdL?=
 =?us-ascii?Q?CDnunsutLpJdAVBH70Ve2S3+7zRef/8SrkY7GRemjEzd85JF9+BGAaqoiKLk?=
 =?us-ascii?Q?3pGbUdgdRWx30SXhOqVwAn13eKf9Pqj1piK9f2Mrmh7M53VMwu4EEh10Z4sh?=
 =?us-ascii?Q?Qy4/1GkeWK4/G1Ldxh5csDPeXdtLC2eHbjowZkiyQtm9gevHYnusM42O/li4?=
 =?us-ascii?Q?yxe8jOGqaqzkzBj/9/mWvA2hpc3ffrLYSGkUBQE7wnWEbZQ0/u2hlidLMZ3h?=
 =?us-ascii?Q?oTYCOPVheXQ54w6omDGLvFfMthXKaaAhrBkHehKZq3thPtqG4llORnbXEAHJ?=
 =?us-ascii?Q?ZjrFYwvdoWAMcXr5NDfZt15mX8yP+5B1sROIy6/ppvT0zBkNukd5fVbruApk?=
 =?us-ascii?Q?l4uMW/Pu7S/0mdRpqfqoOJn/nL7+cC0I9rpQfyB09/kUBIg4uFVs2lPJI/Er?=
 =?us-ascii?Q?kOx90c5/mJGxt0PaQKjf7BsL6m4AFhVj4trIOmU0T8ShxQ/pCs819poTmKyn?=
 =?us-ascii?Q?Gx8wjezEmAsIx+tq5KIeamoRItdKcvJp0XXEkCLV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69803ff1-49e1-4a14-5d31-08db4562835f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 07:56:01.7867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzOWlRYLngKrNTJirINHyCLVhika4q/Z62T/hKvmlWLqxHQ+SXLmsD2rcy+s8l9H7siJw+99pi1kbJFVhOo61w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9366

Add address into pm anno_list in mptcp_nl_cmd_sf_create(). Remove
it when connecting fails.

By doing this, the "REMOVE" command also works with subflows that have
been created via the "SUB_CREATE" command instead of restricting to
the addresses that have been announced via the "ANNOUNCE" command.

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b494c72efe2b..47aea147e334 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -327,6 +327,14 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
+	spin_lock_bh(&msk->pm.lock);
+	if (!mptcp_pm_alloc_anno_list(msk, &local)) {
+		mptcp_userspace_pm_delete_local_addr(msk, &local);
+		spin_unlock_bh(&msk->pm.lock);
+		goto create_err;
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
@@ -335,6 +343,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 
 	if (err) {
 		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_remove_anno_list_by_saddr(msk, &addr_l);
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
 		spin_unlock_bh(&msk->pm.lock);
 	}
-- 
2.35.3

