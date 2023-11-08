Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C472CCA6C
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U+0tnlE6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6fxb4micBtrYpaojDXvD20Rt+t2pDj/o5geH4ce8ghVHafRl4QAEUjIqGYnDsJ1Hxv/QAbZUzw4Ej0ti/5N2izTbWSXP7Nxl0SvoEIm5DbV9t7opgwozaUwr/S4CsLvJCjIbRrrUiGEk9Ms1JYk6Pua3OBMb8zLHp4ujq+WeSvUt24el8C8tj81Nh0uL+tBLQ2E/AQFRvHwqYxJ7XjGpAjR7Q6j9RjXkyhj7q6Crp1BQaoJXkZUhqdwdu3Jr6K6kdWq0xY2/gp7E4928Q9IuLijbyDAFalQfv6uUjA9sW5ukfeYxXI3YBqFoPd48pwDnOd4PK/kyE1SlQgzuW+bSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIHyqT6HE6SN+ei496ifxFyH6B28w5/Nfb2pvs1TXCU=;
 b=Fbl76ojbo4VT3Z7T8MZqqdJ7YseVnBKBP2Y789VMZXtq9WO9RQRZWHlQ6RSCkC2DkJWFjpYVPaunObYFvTIokNqoB9/Ta3/ogg3grYFbgFf98EFacfp199TipoCEwJarfnlk6zBxrXbo6PSaACjrpvTTaqrZ9Qc2iEGJ5O8n7kl9yfUTStbVvbVNeAn24Pl0GIo+4pvvaEhyO1I+fcIWKkzSfP4D9w3+Gf0o2ITs4zIgC0D0tG3MAq7Tcy4WkBN5T6xGxBBVr32jcJ4oUCPFIrwsX1rFIb5AZupeQaGy/XDsNidDmkMuFvcypJlcXI40r9UeTFHtvT7xh4TiYp0o8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIHyqT6HE6SN+ei496ifxFyH6B28w5/Nfb2pvs1TXCU=;
 b=U+0tnlE6l/iphdeZ6wQJfKbwM6KLeki25puzaZeuxvScHFvTP4kqdlOXbFWxgVfDfWuem/9Me3EUXEZ7/6Fd0HIEKdr3rplbYJ2w4JafLaTWW/9DtoyMY9TBPceyDx4P1ubhx7XF/1pMdCpNrhOTTn1wZTYbV+Z4viVQEdcuE39eljnFYK3HV+zz67hmUWEa85YgDdFjy1+VtSPM64gQAZ/isA5G1LE1mBFMfGPdI80GSNNvLsBtyNyXDYlrCuBmGu70PH3TWfuBMPLinjfLslwUvPCiW/5tUe/DgQYRkkUNlhVnjuGxzozrrwD43z4XuaX+/HCWuj8O9Wz82/Bbjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8803.eurprd04.prod.outlook.com (2603:10a6:20b:42e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 06:50:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:50:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 03/22] mptcp: use pernet id_bitmap in userspace pm
Date: Wed,  8 Nov 2023 14:49:33 +0800
Message-Id: <c80858daeae765746513972914ae1ba29383685f.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 3261dfde-35da-4498-901d-08dbe026f5e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2HQ2/9078xI1WSnk2q6AYg1I90F4wyVJ1fhLZeHEyhOcnN8yp1D6EXCpqYYypxQvcF5iGuzzrYvncecvFL3FLi31AgZEa5B/6qZvT6ZYey8W2xZn1uvYYENCXlEM5W+1V34c2JSPOtLTYqd/wLaD/3/0Q8QFhvfkr3tw4gBCoXBAos3j51hzKGxhxtvjcK68V/AZXSVNybLJYnEKR6jXHTWELEwQIfquH4+4vuRIiFlc3GpBiOMereg3x/Y+vR9eEGegfW4eu7lvK7UVhnx5xwTJhFb/CFXlWJoXWCLZeBeDRxf5EJC1eT8H4vU1bnkVdoBMZYxJ2SrtdwEpKO8UV7W13JChjKY0Xmzweiej4OjCbMljiY3ReHKQpS0MomV/55FJPNQcQL3b7Z/DoMuw3pHxc7ZdQwbh0vpFZCZPilxV9Qu+fjxLTHVGyfaNtY4F65r8aaMo8n6umfVsk8YviioykxdKuMRIK0wQ9bZnFgpPW3PcAZ4zGZBOwcNFLi4CgvB84Mddhkkke3S4or3PbMOR/m8EZdBGAjDXAJI06SmzvSbSDwUs7yzIpCNo+yWJmxYBXAMoewRSiy9MRwXaaGcuPRwYYUEpA1fUGKHBhwg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(6666004)(6512007)(6506007)(478600001)(6486002)(83380400001)(107886003)(2616005)(26005)(86362001)(36756003)(8936002)(44832011)(4326008)(8676002)(2906002)(41300700001)(5660300002)(316002)(6916009)(66476007)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v9Kiy7P+D/eHNy81EIW/uZav67wMfYvM0HXdeQpOf5pddV60W4PyIuuXEPRm?=
 =?us-ascii?Q?9fsuQDFXANFtFYzK/Peb8HNQzPnBLbI2oFxfbl/s/kagVNMu4jd2soS57Dko?=
 =?us-ascii?Q?2tqzyvij0mKoU5bH0EXQKcFWhShsTG1VLfq4LTgkIramxhUnGB8IBk6/er0X?=
 =?us-ascii?Q?b4oIrwdUSntEbYXsG1TRjVDVAZzTZk1wVXoOC83s7hVDuorKBiZxvMGte36B?=
 =?us-ascii?Q?HHvOY3hDQJtB4JKppOR/RW7wBDPF6MksWXfIAE2T9WnOnLqParITPnZzgbJ8?=
 =?us-ascii?Q?N30kTNEoyW8ZGQRKREvH9Ex24R8S3Guqnc7J/qkVdLYxw4MEtT75fwN9xaR/?=
 =?us-ascii?Q?SCf/JCKZCt84T7Bc5pf32P+Z/oN0/BcolVNGzPs+IrO14ds3dnwQ8KtbLyzt?=
 =?us-ascii?Q?bpb5w875e6V447yam51dLp41INhVPWtfO7MN4FwdGOFOn6jpsZkz2jPck/mt?=
 =?us-ascii?Q?SFrLFB0BET/JF3x48AnFan9H6nVvbM3dGXaqWSR7XDT/2iGL/VjeJgfjycgA?=
 =?us-ascii?Q?HSFbYuDnY03/TMdObNaqSx4kHr8dTD+ps7EcS2uH4zNmJVHeliPvdduhJu8/?=
 =?us-ascii?Q?qU2BaH6fqq3zz0aHrYu9Bh5Q0eGCzUEdHUGzoTyHuh98jhiYb6sAOvSeFHH8?=
 =?us-ascii?Q?g1KDzn7wsSIWXLB819zpn1YNvbZkhzgYYJbVExC2AV5l788nLrrp6a+TQXqf?=
 =?us-ascii?Q?TsevodDWGfqfcPIjvb6+q2dY4xel1DLNOV2O+wFKMJxGhea2dqiiFfZ2ZAH9?=
 =?us-ascii?Q?CdZJQX3YWJa0pK/CTId6o8iwdfelVxnTGjTua0sD6/iJqNv06Y2UCys9TO5Z?=
 =?us-ascii?Q?ehLjK3cn6b5ekd2hHDavA1wHnAbeLW9eqqCw151lYHivh2PC94rxiarcH1HW?=
 =?us-ascii?Q?kKOdOavS7jlcDg80IuV09kZWfA2kISXQT4WA8Oz4Spykw4BkiHmfEYIo+LPO?=
 =?us-ascii?Q?GN/2kiTFoJAG0r486diir9nvMYRAgj3Zc9ztBo6xSoYKEGGnhdSA6KRRcXeq?=
 =?us-ascii?Q?MUbVf94yYUSaTkMb+rhfLnmqtyKMIJDePU/FjXbT9ZqPCdu3WnGSpe7r3h0d?=
 =?us-ascii?Q?imSOTCwUwhdblDcGz6ybTAyANV8m4+pAxBgMfp3lbZKocP801WTmBjBg217q?=
 =?us-ascii?Q?zs1e09ecawhjExkYQX9h768WlIfFg1GcU5drZWFv0zbGNuPkLPNCccqBnYYE?=
 =?us-ascii?Q?ACJvY5g/aO717IHRq9vxZ0JZUnBCcDNIHY4TuEqXyRN2jNlPNU2XF8cMfdvM?=
 =?us-ascii?Q?jTsxwKYFgSFR/IesVRHFB7yD2/HJxP09VfEv5ipB1kT0sbr4+vGzpLX84fjL?=
 =?us-ascii?Q?GlHp6BynUK6Snw+aVUDyPmVa0ZqZVWfvjUsfLJfjUtd9tiJfoti0qhS1oP3U?=
 =?us-ascii?Q?fKCIUMJCUMmWEdIdz2wL8bctac8OVQzn5DFd0l4hyIOQ2VJX2j3ziDGE/4XP?=
 =?us-ascii?Q?BPB0GmPaISnIKNwf1wPlzDbg+yfmd5+9xLdALdpo2srTFUuKe38ywig9c3Uj?=
 =?us-ascii?Q?Zu1dZO0OZT+QAp5yn/+0w8/2g36r+NptFf1Lly4lUY1u+apy8l+PI+ysovtL?=
 =?us-ascii?Q?JmViKYI4cdFYetg6Rksu92fxINLNwKnEjEWr8GmO0XPtkL8trjZx9KFiHmBn?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3261dfde-35da-4498-901d-08dbe026f5e8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:50:14.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bk+Lc4BozxtmpWpq8R09qBNEZ41nTPmqB40VtlpbERmKRt74KoWielCEKbcq5qGK9YRIC9ZUFgObgh/GAB9OPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8803

This patch uses pm_nl_get_pernet_from_msk() to get the pernet id_bitmap
instead of using a local bitmap when appending a new local address into
the userspace PM local address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index efecbe3cf415..b3a606a5e182 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -28,7 +28,7 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
-	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
@@ -36,8 +36,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bool id_match = false;
 	int ret = -EINVAL;
 
-	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
@@ -50,7 +48,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		} else if (addr_match || id_match) {
 			break;
 		}
-		__set_bit(e->addr.id, id_bitmap);
 	}
 
 	if (!match && !addr_match && !id_match) {
@@ -65,9 +62,10 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
 		*e = *entry;
 		if (!e->addr.id)
-			e->addr.id = find_next_zero_bit(id_bitmap,
+			e->addr.id = find_next_zero_bit(pernet->id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
+		__set_bit(e->addr.id, pernet->id_bitmap);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-- 
2.35.3

