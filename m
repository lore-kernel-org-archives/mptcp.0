Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2048.outbound.protection.outlook.com [40.107.14.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30353B663
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y8lHm50+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcQz5h284Z/hGVeEVsQQP75WKa+ywnh1NEAtQ4l3IAEMjL1vS4pyEsiJ3Xen3KzQZWhmQyom5qOknAxl6ayeeyv+L8Te/IxBU9hSYkbnD/rJnFdMIMaKZv9epvoK9Y7qxi1GulaOUO6t0W1RuULt7ftNcrqfGwOa+IDbQ1t3O2sqSg8kA5N0ipy6YBtXGhvrDgFwpxw4No49K8fGzrCrZaCaNwiNcrfo+C7kh+L6666eLwTVBTTnSYb29UuwOK/tJ1LOhU8zP3lJAWEF8yzOk8uemOdoJoaB5DMZHNIucSak9YxI52VhjW6IEi/wEZiyGWFYH4m0Xl/DFI2aVQGs1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zlpRtOb6cXcRyRmO3+sPK75wO2mXDT276iMzTwIwyY=;
 b=glnpUR5tGEMlwf5qaXOtmmshhIuGgtiEHeZB0OEPa7VJ75OnDRKHtAYMDhb/mJkxzk0R/xmj7r3rTkwflpNiQQhniTfLJs1JadTKmfKhxol4elxKVTevf/R6EaS+tJt2zjjuE7XPhtLDcFj9qfsF30aWch7o3npTyiOqrZZpWzVqVVepY/MQSfQkXe2H4r37+iPmbTpOdlMTrnOJIaZ/zrPjOZlrxBM4iJqclMwoK1u2SGowQVzQjB1G71W4uXpbYrZxTrIHVp4Wn51aeWKSbxDBgO/tK5qqjf+9wyXbuOtopXhPLwB375VekisA20I5MAXGsqRleaGDAC97oMmZQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zlpRtOb6cXcRyRmO3+sPK75wO2mXDT276iMzTwIwyY=;
 b=Y8lHm50+2j3JPaY/hjl8OpvbIRndv2lDIC7HVmTX0iCixWLagLibbqcLON5SOnqDudwIrkZL2VIrkA/4uBqkgz0tTJPt9SGLV8f3QUh7wmZgLgj3Nhj/IyKa3Gw6Gcur7Jxk080qTAFYzcoZ9iqAPbabdiIx4D/n1KlEP3Pe4PKeiMMK+xjBEkotaBPGl2V0DWuuiwhdAIXHz9PB310ukW9ITceazcdkE85BJSqXfT3eSVHi93uq6F3yXeCL+NSojB86puULYgNkFDFz4bEuKRZsGfYgoHexKlW9WlyYEsSISm9zDR5VXl1/C4x3/gD+DP6VF+t4cWkkYPfaLTfNmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9975.eurprd04.prod.outlook.com (2603:10a6:150:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 08:58:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:58:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 17/26] mptcp: remove addrs when freeing userspace pm list
Date: Fri, 17 Nov 2023 16:56:10 +0800
Message-Id: <271ee77b8f1be4ede01fbeefc622f81b43b96285.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0189.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9975:EE_
X-MS-Office365-Filtering-Correlation-Id: af915889-8478-48be-2b1e-08dbe74b4f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2TG3YtWOtvWPX4tINGs8En/wLdxYzsZ7YN49eKMOGT630HIfC+6DEW974sfELeyLqxaUqOZCKFuD8wjAB8tIUWPX3SH1MECH6dhfOEyeY07F2Pq8gxhSJ3WAzJ32BTVpHftCiermtt/jIsLVnyhb34hA+QIoc542Tx9WFGBRq+B3QfhELVgCeYkQcbsYN+p8r0tiH8P91/j7JBMwh8ALiFpCMiP5rOuQs4fTKfWLaEOFeQEAOES2+RQrjSLYeo96zmEKwS0AkvCCw6vj76o6pYdZs8nKQE631mkhElk8jNHrb4MwzRUSlfHY8PMGxe+tVti9l05iHX4QGfuH3lxpMNO33ptP5jIbp6UnJuZ7iX5G3kywSfzUmH5fa2t9G3kVy3FhxlK7GFMf3Jerbfn4n7DCiBd7nkTEgpPUQBsfx8wL9xwLSjSBh2uGUQ7uD+QvucoMsP4yjDSQGogLda8Jds4+RpM2olMsF/eU4EVtJiht9XnkDRDjofMpLNPBn+Iv6eyIZRCUqnKdwxDOI0nuTLsPjTmXBD+FMy8e0M/jlfHvspOLQWGSTwFriCFPEbA6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(5660300002)(2906002)(4744005)(36756003)(86362001)(6666004)(41300700001)(316002)(6486002)(26005)(66556008)(6916009)(107886003)(66946007)(66476007)(4326008)(8676002)(8936002)(83380400001)(6506007)(6512007)(478600001)(2616005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?guxUgedudaGPRCKF0LmzCNg/QT2YkFus5WJaUqF2xMXgs8FhJq9Mha55rAhG?=
 =?us-ascii?Q?jxXPCYoQ2dOv5CBCA4AM3N54q1m5SSV3LRAgM2OY+R3pZBCGN0F3nUASwEgd?=
 =?us-ascii?Q?rCQU9VZ/TMtZbaeGG3yiJVwet7jRu+ncpw9/OLL+jo75AYhKAhm8E4M7kmYv?=
 =?us-ascii?Q?1yMrqWHSXtvk67MQ1dI934JBJV/MmYFxicCRuT61AMq+NlOEGFQ0fs+7xzvj?=
 =?us-ascii?Q?0PAnzMQ9sXlhG+S1nbCDDHYnO8m4Fxk1D2lOLL30YMqhgoPIcq+hySiQSc62?=
 =?us-ascii?Q?PbfT35xMRAiJbRcPyNEvIaa2Z40xwX6RB8C3bzhK1PhmZSGtJk3NZuJUgFBm?=
 =?us-ascii?Q?llXvWTcew64gvuyRYIIGbzfNF0ezkNpvIFRm+/LMPk3H7EkWqYGLv2HRxgsO?=
 =?us-ascii?Q?Hbsb5OAx1ronYx7495L7AkX8EUXYe0omgeurLUuPbdbxo9I5NtpBINvuopdx?=
 =?us-ascii?Q?H24+RuMGliH6M82a2bQucBhPWM0smcYjAT2B62WCnNXUG2l1jT4FPkbJg/Sg?=
 =?us-ascii?Q?1fA5UcloFd5z6WgKgeFyiA7mQ3p+AkOwLHeA9Rrj7nZiqpeLYiXYXy8EM0Ar?=
 =?us-ascii?Q?SXVmKsHeUEIr/NNIPZgyRehX73V6DYTp/+QLhEW+MBqxsGBz5LeuqgLCHDHb?=
 =?us-ascii?Q?JSCGjZ65wqReM7Dlmak/aPuqqLqL9weaK3wMg4RTM9TP6EznJlfBSmjskRKH?=
 =?us-ascii?Q?2hj/RGOC8F03uOStmhQsd/vEmmIWZuaLi6P8BBBtMK/ROI8uq+4mtVsvgFQY?=
 =?us-ascii?Q?ZsiaWOzKpV6IA9lm5c+MPGlfDxMvFH+VwrIbf9JnXxQqkNSf5CBGsdIRI7N8?=
 =?us-ascii?Q?i19IyfH2hcFi06nS+suNFNGNPAlQ2Ei+JZAodzyUSz2orHL4pomXbqNuehKt?=
 =?us-ascii?Q?3PalGj6w+Fbt1YGWrofYULyASg+I4B0Y/UMP3y1YivDLq8zksgjhnFjup54P?=
 =?us-ascii?Q?eq7gId/Ks0qIqx3baYt5WpGhAovC17DknZ2YkeyJvcbOSn225HunjKoIP22I?=
 =?us-ascii?Q?M36yGRlbsD2ohe3QWU3DHcY/Qh3DrIjKFxKiUGTUyqV+1JPaSi2zzqw7DqdT?=
 =?us-ascii?Q?j94T4BHVPbQC4qyormRGdK5Lw9fRu8QB6u1fSfVy4K4TXCcH4uQEbYce2SnO?=
 =?us-ascii?Q?n3WFh28lOEjsbTO0/RlY/Wn+jOYGezCLFxIOHrWbAtC4hKT9CrXLedk4c6Xl?=
 =?us-ascii?Q?Gb5HPYxDoON5/7Gv+vdZR9d9IAGZhuVB93etrGj4GIJuhDbgH/wOB7GPCzQH?=
 =?us-ascii?Q?e4XgId/l89KCjlUS11M8Xsf9lGjlIPYwEFxNmjErBd3T+RC5nb7u0g9bgU1D?=
 =?us-ascii?Q?AHw5OvCs0gElIbQFA3KCWtIFPT+c1aNG2QOtTK8iTOoYdkB4BG0pl5jFieQE?=
 =?us-ascii?Q?snCkivSW4OaceK12Z5ooTEFcHKwenLsDvDk9yKlLw722a8gjUdI9D0nyjWkM?=
 =?us-ascii?Q?brYONvW5jAqxIKHFkIdztuVaEtG/BNEpRRs5tGys37hVtUnNKEbBCniCMnxE?=
 =?us-ascii?Q?73ZYG+1JOEOZEB0X6YRoK88ClviZrzwHqwGF58hEHLydfchW6g3V06VTV40J?=
 =?us-ascii?Q?NDWTS7hTlDu+Q8IfJFsma3BH8hllaWnEaCxdl/IBy54p9g9J0eS58rAO+/2+?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af915889-8478-48be-2b1e-08dbe74b4f9b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:58:04.8808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVPvaaSafDqcTeVEznXpM8k0ddr+3qpGF031Hi0y5aw5PVVxFW39Plex6ezFxdGDTJgLRmvmq4IzwchojmcWZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9975

Before freeing addresses in userspace_pm_local_addr_list, RM_ADDRs for
the addresses should be sent and the subflows established with these
addresses should be deleted.

This patch invokes mptcp_pm_remove_addrs_and_subflows() in
mptcp_userspace_pm_free_local_addr_list() to remove the related
addresses and subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 87cf27dc1d0a..9fc5dbd346db 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -20,6 +20,8 @@ void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 	list_splice_init(&msk->pm.userspace_pm_local_addr_list, &free_list);
 	spin_unlock_bh(&msk->pm.lock);
 
+	mptcp_pm_remove_addrs_and_subflows(msk, &free_list);
+
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
 		sock_kfree_s(sk, entry, sizeof(*entry));
 	}
-- 
2.35.3

