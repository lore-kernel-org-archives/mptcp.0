Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6838A2D
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 10:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBmjQDfnRu/14suB1kAq/jID/D924zK+LwTwEezKl7eHUB0O5e5VzO5knx5esHHNpWrSUfJRY6zVzK1ao3K1ZyqaTRYWVqZ0W7xlnv4007CRZn1hve6n+ADAZI6vJdx4jAj8KoW3NOyrWO2MbGQaBUafqJLHU8DPUxJ+iZF5hAdJxSUoO4Hs6M6CWZLHDhbpo2dTL9oV7l76w6dDZHuf2uI5YRHY6nPjM0K1/O/4FvXmEJG4FBof4zgN9+qHAkFCC0Fz39PwgzBYMr2uJ9OMteD9n7qd0tisD8WwyEiEmvl0tmk1X/dhYwNOjOhnzLTzRGVLzmH2XekzoTcHukIh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3bl3W2DePJSR+A5CQupDySYUYnnndOVDynmbOw3Eb0=;
 b=XCb/Opwc/eanY8NQH/jTnvAsisa19uEINbpDnBDjiLU6ela0CoqZPqigx9Yz76KS4ug69+Ifx2DSPpeFT4b4NXJ09vJjrDElp7c4o/LcRNqtv2eED6NKBLgBfrHWb9/5Rv7eiRY+1JPZbDsACEka9wHZ7HQ3gDWH0jDT3fPN/VstN1mIFYkOPeXEcuGOiKM9fqE1Ha/eK3wU95FAr3u1e0nlk9YbSEL3a7H7JLVgIGW4e/6/DIbu+UPqCWq7EQfPsXURs4XdDcSbtKpF+6LvX1GhFsM6LyWo/vcQNhRP/EluFgOhk7lrz1IGTtiFXCZbDj6q/1CzjI+izfnBh7Lq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3bl3W2DePJSR+A5CQupDySYUYnnndOVDynmbOw3Eb0=;
 b=LqGifWHEpR/pFBBEEOeowm+Z9NXUeBfIMIDmd8a7Rz0URT4agOqzDORyYqCjbT1QBl7c1LEI2bN7HmZXl6o8u0/DRczhJq7IqIpDdvchdGkpyWBhns8BUwy3FObIIzNAJQB5sn875gcjM6k7Jf5N8NErSdhrw1woL9Iu6OpEAVVx+N1bcrLQymGPnEQk/pi1MC0y+nIMNCB4uVVXrp8cDRcBBNtfZAy5kp44tMUMIl3einBpZMCAeV4s2f/76Nuapskp593UeLS+hjp7mKsJYaJUi/pe4gAYBwz/AZ1XcU2AW/zELqx7CormxKWbC6NoiXRgaXBEJy60/cLIkXpnvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8908.eurprd04.prod.outlook.com (2603:10a6:20b:40b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 10:20:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Thu, 4 May 2023
 10:20:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 01/12] mptcp: only send RM_ADDR in nl_cmd_remove
Date: Thu,  4 May 2023 18:20:06 +0800
Message-Id: <30c7eccf75e15d3a5a4c90398578c0fac9984dc5.1683195386.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683195386.git.geliang.tang@suse.com>
References: <cover.1683195386.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:4:91::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: a60d69f6-94f9-48d5-6467-08db4c892e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dpM0IBrj+8jqVLuAkW8hMo2Z2hbiDO8zXbgGa5Pgr39VZv1XUlzQfU5aTcOMUskpjz/hVuNk4Z45dxGgFEjGnt+Dik69SmnsMHBvQIioaQFFGjLZCIbUFeZ8Cn/jJQtMHv5TZfz07XX8kAY6YYP+0wllwgpsY7fT4mBgx1yDaEhqzRERzAu1tOXvclEdHJFUfrjC9PgVPmWc64OtQW9eYIbUlaCujhsacGOEwnNR7dzJk1URb7LvuYe0bbjBv6h0miZ8KrGSF+BzztK8mUA3LjUZ2+kaG8yJ9H7TvAFK6BXQy0JlIJM1DDRkNvJjS/BgIf9JIIXr6GHsn1pBVb4t39gmSMsipzqyBnejMAwXGwdmWTEJDgPpQuiEJhaLyqzVn0dyw7Z5uGufqw1sPqhKIYNQi00YW7AMI0uN//8f7NwD/Y0Jdr8XtbyxOyxIyQ/T+oWtgHtq9ICSG0kYS86VRJZWsif7WfQ+Pj7K1APfrPnD21s5z9qxukd0AmpVdU97VUpSJYOEdvST9E4kA502wcEDWUhdYU4QsLwkyJHOnIM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(44832011)(5660300002)(8676002)(478600001)(966005)(38100700002)(8936002)(2616005)(6916009)(86362001)(6512007)(6506007)(26005)(6666004)(66476007)(66556008)(66946007)(107886003)(83380400001)(6486002)(4326008)(36756003)(316002)(186003)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a3mPPqRTGBZJYTCrvPObwT3iCzIgoeHdiK9mLEX+W4yvRhOW+r/iC7gqJpQT?=
 =?us-ascii?Q?mZfmL0odmjSM/RwBnZhzTpVXwA+iSd2F+/NFCDKCLgLsThucRhxwpM7km3JE?=
 =?us-ascii?Q?3P9A4V3qS3AX4tHnasSGTuBHGSyYMVF2SL/64Pv3sz6172A6utB3vjpcjmzq?=
 =?us-ascii?Q?v7+NSJikNG9aZNKqXXmevl8YSJsTmUeZBOCMzOEP4fokcHt4WornRd2giwFj?=
 =?us-ascii?Q?SkJq6p19P2q8JSVvOIH1zJ1tiV9il5MnK7QvboIMsrY2jfn1F19nY9+bV+gB?=
 =?us-ascii?Q?H6DzgTf6qT1LtXlPisbdTEpytpdcZxX5FNellei0dLWHZp7GkkvdErsaTH88?=
 =?us-ascii?Q?pPVBzBbGxLgjETk4IIQuRW8K+ht64j4S88rKuSnu8+59fwrmDgM5WXo1BSMA?=
 =?us-ascii?Q?QTdChyN60l7QScSZ9b3WbC5ap5u+RBrx4oN/Me3biSTTfaKBafGnU+mwliky?=
 =?us-ascii?Q?j+B2LR3EjiH5hOOk3D5IMw2cYQBNqTlscXoG8PeFKStdhxistjgYTjROIy7g?=
 =?us-ascii?Q?ezADNDqilQmBUsDl/npFyTVJ1Ajcc2boW7UQe05q542xLIZ8jdWCj5pZ+uqv?=
 =?us-ascii?Q?qOnC/zfQGtqVu9ity/wa1iVihzqYKfyGcKNVvYpRAJbZPV27FH4SUmi22DIZ?=
 =?us-ascii?Q?w5lqR3Rk8T9CQZMhXtcwFhTHhRw/LQrBuWm54O6+Yz+u2wLvpkpVhft2JPFb?=
 =?us-ascii?Q?Gnu3Ukbv5p2U9GRt7wLSvEjE8KzTDoPAbqRT0/oKeOyRa4Av9CUPyvGPWqTk?=
 =?us-ascii?Q?cA1jmvnAZnhxkqp+m0s+eua6dk2qYyn47XsVbpkBWAhyaxdrr2vz6gqTRX6E?=
 =?us-ascii?Q?i93iMIz9Ji93S7WaNqNfbg+mNZzMxx+mZm/jgotYIhsQbn+yxXIvDEnQrSGN?=
 =?us-ascii?Q?8Onlg11qA7MWJeJkOt7zumORqcC1kax0wNOsECcS2753o4YflWbblxT9lsQD?=
 =?us-ascii?Q?3A0LADwK2XWUm8mzunF7TFeLX1lzgzNeq03XsJEKjvPbVxNcRCP6JN17uo67?=
 =?us-ascii?Q?KCu3X+ZQIg0aAua3ACfg5+Et2DBnJMzo7IHPLBEZynVgQcPXmlPsiXbpvPiz?=
 =?us-ascii?Q?491Tb6EOuWO3Dhoib6JBmRL890uZMyYFuPzBZckqQyx9iAQjF6ubHSvegawG?=
 =?us-ascii?Q?hYZKfouFzSgMwWwKGIEbOv5NjZGNvtNvCfV1j6ZkuNMS1O/uQL2weC73crXk?=
 =?us-ascii?Q?6Xau9E/IaT7ZEjUt7ptRLEFV0w/Mg3pUUDJ6/Th6/+HsjXqrxRrwRrDhaZy7?=
 =?us-ascii?Q?UX/VI1NoZH9K9LqovptucZg7taU6wRiGyZ9EcmKeTyr47QdSzUHMKedpnMzo?=
 =?us-ascii?Q?yGXRS5MMVGi7e/9OqRyWZKUl3QvDNJt0bncsqFSOBRecYHIyLEuPqdBYdEKL?=
 =?us-ascii?Q?5ZVXLLtiZb9XOhQKv6c8Pm2THVUpf/g10I+K4kKMulL7imw5yPf+COqJToRO?=
 =?us-ascii?Q?8FKmUpzMvFKwCmAZpk66oJQm9b7j0JAro0uKy1vAMZAfY8t9wqHpky6Hr+jF?=
 =?us-ascii?Q?ET8hOeSHMDtjRAjyl+KNNDNAMMorXd2wf69VyhgYXKqCBoh5QARZaj5wM8KT?=
 =?us-ascii?Q?gAyJ7Q1AUKyP42GHaXodPdjt+BNfZTUmtCHUOfEj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60d69f6-94f9-48d5-6467-08db4c892e06
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 10:20:27.1812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itKkKdwt9V+zjRSjPbWJVVC9H3fIT26YfcUrJC5prPy+x40m1sakKJzctqb4UUgl0okSlIQXnuD56x2AY1FM6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8908

The specifications from [1] about the "REMOVE" command say:

    Announce that an address has been lost to the peer

It was then only supposed to send a RM_ADDR and not trying to delete
associated subflows.

A new helper mptcp_pm_remove_addrs() is then introduced to do just
that, compared to mptcp_pm_remove_addrs_and_subflows() also removing
subflows.

To delete a subflow, the userspace daemon can use the "SUB_DESTROY"
command, see mptcp_nl_cmd_sf_destroy().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Link: https://github.com/multipath-tcp/mptcp/blob/mptcp_v0.96/include/uapi/linux/mptcp.h [1]
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 18 ++++++++++++++++++
 net/mptcp/pm_userspace.c |  2 +-
 net/mptcp/protocol.h     |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e8336b8bd30e..784145e6a314 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1555,6 +1555,24 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
+{
+	struct mptcp_rm_list alist = { .nr = 0 };
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, rm_list, list) {
+		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
+		    alist.nr < MPTCP_RM_IDS_MAX)
+			alist.ids[alist.nr++] = entry->addr.id;
+	}
+
+	if (alist.nr) {
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_remove_addr(msk, &alist);
+		spin_unlock_bh(&msk->pm.lock);
+	}
+}
+
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list)
 {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 27a275805c06..6beadea8c67d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -232,7 +232,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	list_move(&match->list, &free_list);
 
-	mptcp_pm_remove_addrs_and_subflows(msk, &free_list);
+	mptcp_pm_remove_addrs(msk, &free_list);
 
 	release_sock((struct sock *)msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c39e172c95db..1a2772902e9d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -845,6 +845,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
-- 
2.35.3

