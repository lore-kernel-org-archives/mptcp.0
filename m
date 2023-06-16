Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF93923C2
	for <mptcp@lists.linux.dev>; Fri, 16 Jun 2023 07:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qe+Bhm/puDCn8Ar02lteSBNy+1n5HWMb4E9vwbfSk/5+VJ3CzIwJv6WMDrhqXo7HPnerhbOk4f2sQhf+rmZDEktjsrYOIWFCh2Jf3vraP2vz5jrI3ChfHNg/eUXwpHlux8SprBOLudmwiR1r9Cu4GHglSZtvbAZS3aVCda+I3gNAQOPRYMhb8C4xJHMAX30Kf/j0+O5AyaYOIRijABalG12ci/384R4VRKTJvxlsHPG7AvNwC+nYrwTRNtYoP8yxIRRq/960GMIeioJQEVfRaR1AHDDvgO7mgy/dvSyCQlU5ypEzcT5NKJHvYFTDOw9xdDodRDbgLIjltflUmijB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcZWCY/fbXoVGBbZNNwge90JtegL8LSJiEtTdd+w/+0=;
 b=lXY8RuMgsHLCdUDJih59NTl6+GMLhMQ/fiF2Djbc+77vUqTfbgS+KV8Px661C8XbbNrMhKbrUoPzdzlTBQAOtU2FrdT1Z1g3jjhrbIPiHNKMW7gt4CPpmcpJd2AmH8cD8oVIBQq83UIFRLKW6xFuvt6qywh07lIQxwmBmaEJ/9Yj6PyygbZWjKm/578OpnAOk4X2DIHHc/IkzrmT00hQ15ePp9nZqvyMWEp3snmeNiAzKdoeivdYvRE/4EVPOkk/kwbJpjZ6QhW75TY2/vlTs7uDpkW21ofgHoNoge61uW3SYcsaZJAvevN4t0g2ZQZ0ZXac3zhzV6koU212bJbI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcZWCY/fbXoVGBbZNNwge90JtegL8LSJiEtTdd+w/+0=;
 b=B4Mt0KjBCBCW0hjHC1Qx6RrD+elgGgnzQz33iyAJDDe4/Z4pmrKocu/cH7Uus/uZ0PTEh/3rt9Wbb+1a3QIc9U9ze5fJeLfRQpvHW/V35RxhpCwIlF1Itei0I3X4xfmOdHqdC6zxiNW0BRzkvWejPST8pfLL+Es1euDFcstCxeA+N22fBbBPksZpWjkuYCHlcbPWzcClI/5VwjcjrhYj6a24tVeojiqbudKejGzE0Eu8RofhRNiRq6BGYtgXp+A+JOa1LFgIQDdYht6QFfK0G7ZP1xiTUUqTcuFvddSh/tbvologaoQsPcwhJ7ptHfTZGtohgwrxU4KVnEkk7jHHcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM9PR04MB8226.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 07:31:15 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59%4]) with mapi id 15.20.6455.039; Fri, 16 Jun 2023
 07:31:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v20 01/10] mptcp: pass addr to mptcp_pm_alloc_anno_list
Date: Fri, 16 Jun 2023 15:30:53 +0800
Message-Id: <c442dae64f5979fa1b08c6a2c042abc99d635929.1686900596.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686900596.git.geliang.tang@suse.com>
References: <cover.1686900596.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0123.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::27) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM9PR04MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bfd9654-c1d7-4d34-f215-08db6e3bab3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cGStYHR0Q9tWtRgZmhjcRaqUthHYUJRDhK2KedWmHpjdx4plMlzyw87rQTpO+/EUi1BlT1zFv83KhrIq0AwHAs9jW5kKfXeRRYz9FiW9cA0lPxcAcJFKfKhY5wLEQQuUOPB3GmK+ffKYMZS7A54fwHWxIeH/yLLOWwioFEObt/qOBumR0Ji7kG4B/7MHU7kirNyvDUdK1SabN5T1lmKy+f4cpEjRF/U2Ppz5oG6c05W+HEJjAEaoSrMGDeZMPjAs/bu954UpJQqgLlToPNXJjDRKnvgZR4QlJPAMfd7yH4QF5wTPmMLfF3MPnB7AZ5HlQ1M+aGYrpQBS4M30Al+RNHHceyPSFknbjW6sz9v/XaTTWif8GYy8APT8YmUlxr1noJVZ2935qbGVBrOfMwFKerGwu6/L0Fg+sIQQApye+xiYggYTAaKZk248wzJZZZiPmMhH5msIS7Iw6ClSpnsIpbnZLoZigYhJeqiDMTB0zcS+XAhS9s3PsiFQa12y65e8F5cdtu1Estvxl6amYDHj6HkVyKerl8QziIcBmkkuEoEowLx/msh6zq1wjQvZEnAz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(478600001)(6666004)(4326008)(8936002)(5660300002)(8676002)(6486002)(41300700001)(6512007)(6506007)(26005)(44832011)(107886003)(86362001)(66476007)(66946007)(6916009)(66556008)(316002)(186003)(83380400001)(2616005)(2906002)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rQJTuZ3jQiBcxeur38L3ac/YGDjBePtFvAuozAtmuXc0TfE2LG+DUBhsMaOg?=
 =?us-ascii?Q?LvW6dfFX5qnAQZrTJbNlCMVpGx4gIIUY8tQTtVOPAzYG8EBlYUdElnk/j9Yg?=
 =?us-ascii?Q?yg8nPUSwHCEGbbv6wOeO202wdiVb8mVC+EipSNUhWx1iMMmWlClM2Azw70aT?=
 =?us-ascii?Q?p9rdFje0SnoVgZx2IP7Ct81u3arTEVzfWjMDuFQEWmRa8QBo+c3E6ONGiahi?=
 =?us-ascii?Q?COuUMBQq+Cla6DQ2hGy6jrw3SGJGq7apkYdKfFB2Rc+m1BwMXpmN05JCjYml?=
 =?us-ascii?Q?+bEtZ2DtUWxe9ziSglGf05yPlwmBRdBBEAY9KimuaDQklVcFNPf9TNsavv4U?=
 =?us-ascii?Q?bZnpQg2VVVJ7RsnMCCeJYlKjtV7XIYo738KbDmK2kmWz0q9m3eXYLVFyaegu?=
 =?us-ascii?Q?apSCqTuR118UxLSOWX1TNNFWCP2lMkNqSj8AKEf8ihzS1aJ7WBiX69ozrHR9?=
 =?us-ascii?Q?LVTdMKSNPsnZJnPVUxYWSJcm2JykcsMbUGRF3m+HU48viPXJGLys7JeWePA3?=
 =?us-ascii?Q?lATSkBmqJxAgbFoPILSjSLEw0/cyyfJHaSeaON4vUfl6zOdMzzQSNpk0OhLF?=
 =?us-ascii?Q?8h0f1lolv6FROBLMQ0tOmrEZehxuoKuOy3mC0jPSgMBbbWH8LifyPHWbBhnJ?=
 =?us-ascii?Q?ia2PZRzpVHhevth8FzbkWZXQuVkXRQ1Y5/glLLhsQDDk5KTUjtkpNVUL+rQi?=
 =?us-ascii?Q?0keA31Kj98js+bDUGT1SjLMzObGsVMTEXQl8ghoDensEJtlJ8pnWBhxuvhUL?=
 =?us-ascii?Q?RlWBWrB+WGWyYEZaaM75SG0Aly1c5q2VDi5n0q3denbuTo17Y3GufK+o/6my?=
 =?us-ascii?Q?IsL/r4CXj0vuUWOwd559JuyKDyoIAo6XEjIFvJ9BJpHRXCzkzAjM8Elq9O2L?=
 =?us-ascii?Q?dHMNQLFtm8Lq1d2iclQHRFI/kEywxZZ4khZWpCGDbUQ5EnYP86pet/pE42kP?=
 =?us-ascii?Q?+pTf1faZzDegBXmKLvseD62ZHyMvYd56RGm1Ba8cIIeamAvpospCF1SrzPrN?=
 =?us-ascii?Q?mSZENOTS9+fjdHPWHloYwWv6P17pht3M1pfOV09ShDG2ICLW84UVOGR412HP?=
 =?us-ascii?Q?WcciioNxmLKQ7WIrJrEL0HBl5TEjWBh+1tTBrLOl3uEjSldT5zHGPqL7BByh?=
 =?us-ascii?Q?Ly+Pee6hu5Zb7WJSaemgcoZdiwSV9QML2az1bySSPMCC85l3cqvK+MwzcM/J?=
 =?us-ascii?Q?OgtJIySTGr0x42NTbuoXbj2Ztf04lYhEJ8vibOZVMYKvZ224gEAihdy1ZkCc?=
 =?us-ascii?Q?paBOD23puWxIiqxLjX8PnvLQqwGLI/W2ty//kVi28DNiEZVY3E4hncShHJwx?=
 =?us-ascii?Q?iQL709Iovss62w7ke2kLfF8rxFMsSwUyhTXaUKGl0GjvOM85aC6MieJ8D5MY?=
 =?us-ascii?Q?BMi9oHiN0t1R0JIIk5poMKX+O65i0TN1sepBstN77kWDSdw0VdDwQMobMxmC?=
 =?us-ascii?Q?aVvzJUUv/a9O6opFYsnXdxxwmQG/OXF7y+lhfBsg2bhB3NH06yj5EfqzpFWy?=
 =?us-ascii?Q?cFRRR5eBTEVbtgoV7mB4PQUuv5N5Ktx0SiYJ2GyRuSo520O0f9nx5eSB7SDr?=
 =?us-ascii?Q?+X+MIVRWhPJTEQL7g4cUG5b6D8O9Icd5pnV0y/eK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfd9654-c1d7-4d34-f215-08db6e3bab3a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:31:15.8880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjnJpTTaQ8ybJp0o6JczPG+o7uYNlZtXS91AMy4teu/sIhrR0h/nIocyhDm0gqEGh398hCZHyRyjH+wmrVJQkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8226

Pass addr parameter to mptcp_pm_alloc_anno_list() instead of entry. We
can reduce the scope, e.g. in mptcp_pm_alloc_anno_list(), we only access
"entry->addr", we can then restrict to the pointer to "addr" then.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 8 ++++----
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ba1406e601e4..724b652876cf 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -341,7 +341,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 }
 
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry)
+			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -349,7 +349,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
@@ -366,7 +366,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	list_add(&add_entry->list, &msk->pm.anno_list);
 
-	add_entry->addr = entry->addr;
+	add_entry->addr = *addr;
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
 
@@ -573,7 +573,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			return;
 
 		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, local)) {
+			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
 				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 47a883a16c11..b5a8aa4c1ebd 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -193,7 +193,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	lock_sock((struct sock *)msk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d2e59cf33f57..3ba62f1154d3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -833,7 +833,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *rem,
 				 u8 bkup);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry);
+			      const struct mptcp_addr_info *addr);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
-- 
2.35.3

