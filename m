Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6269F2F29
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c/Gfz/sr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ne+CfpBamF5qio5BWBg0ZHZcXUuHKIgoUqePl9aLX8Qjm4d260mqThaL+mllJ5zD2gznPLuLO1jr7aDzy4/o64CC8owgwIxIzrfc0vIprQvpqYUNcfofuccXkr1Sx0ISdjglN0Tj9F7w/JCxret2vP3Llwi920Mevz/DlM4HeWFw6T4uSDYhTRDO7iVFtM1VM8KkrwLERcsokqdoxElefr0JktcX5lH9xXGPm6ZS4JIjelnA1jVIVvNMZJO7iUh6frFoNhA0kJrudKw37B/ClBj6SMGDQF9DHNeaqAu8OU4aVPF7cYorHcKbCPQVr/3ozDc0tpZKZ2uenM54HN9Hpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FRJW596KuE3kK6nsuBea0qCL2kAKwvASr4MD+Yxncs=;
 b=Spmftc2iwGLAJjM7m3zrBTZo0MCV31lt5r1HH3OaKIDiA5mI/KiuwLphWzbCNkWyr6jHlHBnQ+2D4gH4ndqAiBepZVx/NRzk6OqQR9bXBKy2WzbkdXwr1m41Z40zxdmOWnDMWBv2ToGGU228fqV39MtMBxxeub/4jKHuHfWt39XFTzpabv5Z/rOA5vC7h6KXeaB+A+0tEMZlUFqDRFMrF62sCi0BeEL3zNRgOSfdfCO7bzGYKWfn2shWpgKODHAxQgMLaRgyW86JMCqDV3dBDPhWKjSbNPgg2L6E21h9A3sZFvZnbpmJRgJk5cpG56ndUK7kVm+DAyz45G+HvyIRBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FRJW596KuE3kK6nsuBea0qCL2kAKwvASr4MD+Yxncs=;
 b=c/Gfz/srEK2joTS8o5/WT/nMKBgNvggp1d9bEa5je3Po/rsEzm5COJPAgNb8JFLfrH1ZyYZGHBuXH4xql9YvWIk0Z2aLKsD86oKui9F/WJb2E/cCj2vp5ik74DT2GINfDMVyFxfz4npFX1/WEktPhcUrnmggfRyn1eZDKVpTUrwR67OxgpVyjyM2UZd929tVVDJZqWXl4ICbHJ7x69kK1RcE0h7n33Gyek9j7piFX8qBuAovYwOVZXe1bx4pGIWPsLu5DFdlJbgQ91CkwxzFS77V5m2oELM4gwOV71Sr+k6UzA4MYH8QBCo+F8OCJVHNJWaGLbina0/ScRdcA0qwYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7451.eurprd04.prod.outlook.com (2603:10a6:102:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:37:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:37:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 19/21] mptcp: dup an entry when removing it
Date: Tue, 14 Nov 2023 14:35:16 +0800
Message-Id: <3a1d48502952af9f393071543744f0f08e69bb4e.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e14e412-edf1-42a8-4601-08dbe4dc32af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	onKPnxCRTyL3nbc89844XGypJi2bXslFJNXVaWykVNRKdRib59imfporE7l+vFcgx5TmXkGKsHBay3loP9SET0rdw+sTiPqByBGmN05xrjdbI0xkGmQ3EmTw1bLC1xTW3p2vN2v0NA4TQb95srMqN9ot21irpE0hI4oKDgGvD+g0A5jUT7KJKT/FndZtOlUJD+CSp1108DALIYNLcDpJS9LxrwNlySgANqTKSTLfZCSAL4OhPNf9dBl3eA4susGvPhzZMQNNHXK9irxwklTkx94j0RfCDturK+0PtN5NZ8ZK6u2Y3H9K5b6hekGBhu7Od3Osws4ydoJQM9UsEE9ZPx0rucDsyxllxSLJcyoIhJDdN02uu27txLUC6LNVqZ36M9EzDmFYiPKcMw51/MjN2ffA+XyGThe1QZbW5M1bOLsUXYnq4XsCBMaYGc/8BnLgdFEk79UrwqiVdsgOAIc9N5QD6hMfvSp5nwqrIy44sD7tFCqZaf9TX4YGro6SOCYImcdYORUFiyAtodbguiAOFMFiI2ReA9v61FdmT7D5kwBQ3Tod6bla7S299jopf0fi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(41300700001)(4744005)(2906002)(44832011)(36756003)(8936002)(4326008)(8676002)(316002)(66946007)(6916009)(66476007)(66556008)(86362001)(5660300002)(6486002)(478600001)(6666004)(83380400001)(6506007)(26005)(38100700002)(6512007)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WjLwGTGgZLUt2XSppZNgSFLa5s3SHO2T+52KA8hFa3o19Rz1IcXbRla+PFxy?=
 =?us-ascii?Q?qTmxEUJP5rkn+ZwK+gAmwz41CD2wavL2joaugobuT1M/T0RI4QCf0/Xzm8/C?=
 =?us-ascii?Q?ioLEd3rmeIHgfGj7FaT1BgxOf1xUXUUffVaHGy39oabZ81Aa/ummena4NAGB?=
 =?us-ascii?Q?UUQpxvcZ+PNHfR6PmWypHy7hEIsa5T+EUp8QyPSAnLJFY2iZLIZx12v95qzE?=
 =?us-ascii?Q?oY2n+WXPcQrascgL4bCXYiTvklese1AZGzQvsM4tCz5JhOMAyoq+RhunbL9j?=
 =?us-ascii?Q?9N2GsCqsv7xfsrzIk/8jBWXFR6K0V9aLGLZT+CUaMKGkdJkgQWs3ebXulKJ8?=
 =?us-ascii?Q?muKH5miZ2Dp8At7U/ysITE18ulyssSiDNBTo74h3WYaoP25FPlEty08A+Rm0?=
 =?us-ascii?Q?pAf0xXO68KHU885KwFHvwRd5wonH8+9MzVzhVyL3rk405z6Xy9cCCRRllwiK?=
 =?us-ascii?Q?PxDzWZUnD4tfE/51rfv8bgPCYVScARKcGbm4UJyhNGFemCr1Ot8owVKA52Zi?=
 =?us-ascii?Q?YfZ4bJPuhcDaCh3zOXikp/osSDItsWbrGY0ID9+X+ZN3C5OG2RadzRt+cYB9?=
 =?us-ascii?Q?7P8oFeitV3qGp5cJ+O1u2Xkr0x/ug4rPLxAecA5iVEO7itN4mlzm0ok9Pv4T?=
 =?us-ascii?Q?Ev86W8xC5ryzclaQHi/nwkYCRkCxT0yRA+qzdjCLTzWLQ+hLYRw1GQMB80+T?=
 =?us-ascii?Q?199/xi/xkZ2+/QgXFniVrBM0xoKIkYGOexvDyeyrAh3oBZCjTlPxPfoUUxJg?=
 =?us-ascii?Q?UhgYXPjdrOabDw/iSeg4zGm/i9rTuYO5K3tw7fcEpvdakx8f1sbd/E3OO0jB?=
 =?us-ascii?Q?9wKkfDK4NbzMA+T8ywZTWHnuMwAnuUBwK/hrQD0UPI4cuKXLndJth2eQS9AK?=
 =?us-ascii?Q?4tXOQPbnm++JfKOaZJKu/Tf2WWMP4CMMsNKip7PeMItvr1tJ+6CX0gUb18/W?=
 =?us-ascii?Q?acazYeFjki/OXzAdk+Dvy6ZVpuR+Vk4kW7Ae5TKUls8w4uhrT3LT4MpvxWxk?=
 =?us-ascii?Q?9PrVVf5WZjeQc3TN3LDFieYoJKBDTFraAWXOEw/TJ5JY6kYrKdObvvnmDTrZ?=
 =?us-ascii?Q?xaMSVpe3tXjHodfyHk7x5shgzdW9nS4l/ih6vMm5NvafO7eSfHrAJ3OLHFvr?=
 =?us-ascii?Q?JmI5lhkpwki4JRdhVYxmkJMsGd3sc8gOEevhG35JnI8qBdZrsdfadEAQkJ/W?=
 =?us-ascii?Q?TTjsV2iS+rQCweQlVVMBgaK08PUtsXpSA8vmecOTY/+7QOpA/WrviUtpeOwe?=
 =?us-ascii?Q?Af8hIT47Hnkk49GCO8vLdkuBZNEh/3Nwy7VeAZK69nRm1BBegooIoPN8Pc7D?=
 =?us-ascii?Q?MVccyBcnno2jdbOMHAwgIOHrecRYnI23+2rreHG1uC4p5933PhVnNhaoIWOe?=
 =?us-ascii?Q?H9JiKmIMKOWaNIfdtSz4wdwAAQspsWL40XGZTU6fLQZU3YrPgvpbyUy1KE8K?=
 =?us-ascii?Q?xiIUdz4k3JHiUePVAsNKhyQk3h3PJHR4pA0PtFjvSPw4O5VHwpCoQRqJ3uPs?=
 =?us-ascii?Q?qvFnv3Sqtno6RRMmEL6HyGsXf7jCxRnDQGZSUHY5yrxUDt+aIGqWqQkYp/8F?=
 =?us-ascii?Q?yvBILFCqb9eHiivExEyBUMKwaXSrWlkNf0e8379NS/O5Mh4lOPM1TB+xIQq3?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e14e412-edf1-42a8-4601-08dbe4dc32af
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:37:39.8439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kts3gUmftMnAUFbSqPDOHj9l1qMtyA7RDR6Cq0/16dETylbrY9QZ/RxFU7wwa/xVthSFc98UEex/RfMjgEjYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7451

In some cases, the address entry doesn't need to be freed. This patch dups
an entry into the free_list to separate removing an address from freeing
an entry, so that the refcount of address entry can be added later.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 994f2bfd74be..e2f11e821214 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -303,10 +303,18 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	list_move(&match->list, &free_list);
+	entry = kmemdup(match, sizeof(*match), GFP_ATOMIC);
+	if (!entry) {
+		err = -ENOMEM;
+		goto out;
+	}
+	list_add(&entry->list, &free_list);
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
+	list_del_rcu(&match->list);
+	kfree(match);
+
 	release_sock(sk);
 
 	list_for_each_entry_safe(match, entry, &free_list, list) {
-- 
2.35.3

