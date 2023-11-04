Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2071.outbound.protection.outlook.com [40.107.247.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CA615486
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C1HC9v91"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVpSvXAq+ws0lZPnDadhCDcmr0VxI3R07uarUZfSZDDEw17IZS4KqdMbm3bypllmapN2SKVvEyTWwaaqPgk18PAOl699AhUHgTrEP/bSO6zA7F313ta13JFYyi38/Jie6zZfDqNxnZEI/q35kMK4K+7KaIJkNi/BU1yOkZ5ky+Fy3Xt31E3aFnXdVfB5Zf9qRNhpHR72V6uyC+BR/Jnpo/GU727iE2wNd0L4wwYlDT8JGeJU2WLOtFgt2FOtPGbOHb7mzu5Lo9WrmJMwupChSeAkr3ezpPyz7e6PqhIlE5pxTUCZfasb50V9j/AAc5fdiDg0pakMIPWJnBdMc7sZ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7184CWhMhJNtPnzd+4hU68eImQ5PYVkZRVpGK7CAds8=;
 b=JXfp4HkS/Oi9UVskU7+qsWvs0YpM6BCadv0DU2b3+mkKthYpmAuIOBJLRcHkSc191yQ94uGRzc5lruAl2mVRnIzxsV207piQQHNa6NJjvlnecOs4JfaheMdXtsHsmDm8BBxE8DWb1JhFs/OxZEo/51lYik22sWaBEE26fa5dTjGUcG9ybu38IzNTy1SP6FTqNXzjcaPX5LV/JvGOPE5ooom/T7xZGlr+YllwMQC9ddsxv2Mf6478hjhUDLuTyTfyhaP+atzJh9yWcRj/XMr91aF77TfRM6skhy/5mjWKGoxp1huRCMlWwJ+3jLZyc89Zwd0yKPozxVaeSC+CvYiURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7184CWhMhJNtPnzd+4hU68eImQ5PYVkZRVpGK7CAds8=;
 b=C1HC9v91W8P2BMCZ0V4JGFEgrTeSum2biUTUw5Tz3Kh+bcp1ypsZhT192wLvk37Frh+49l8AQbQaZpZcaY1u6esmhYlNOF3erFx3A5OmWh3g/506aL3G3k0YudNGDFeAYo61uNzp/0ANUoOzK7L6DylnIySgHjsP6yFqf1xpGnPgGURPCnIVikdh42LtEtyakmW8h+O1xzOFzqppXbEcV+quQnv0Va6NL1P5tCQBi+hmLtuzygirirF1VSLwQ+aHCvpkE0u8PYIWDqOtTYD47G07fpp08AcXHCxenNui5OPMTU1N+SAmyDNhjc6p2Wpq9eAyWSqTg63KQJ/Wx1N3WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6820.eurprd04.prod.outlook.com (2603:10a6:208:188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Sat, 4 Nov
 2023 14:16:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 14:16:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 02/12] mptcp: use pernet id_bitmap in userspace pm
Date: Sat,  4 Nov 2023 22:16:16 +0800
Message-Id: <8628233fd2ec134278b380f822c8319f8fa67e28.1699107275.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699107275.git.geliang.tang@suse.com>
References: <cover.1699107275.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: be1b8e79-7406-4b9d-0613-08dbdd40b01f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c/RpcggAjN4IwmaJ0Ot3uW5hu3gFFqUBc7tzALEpoKsl1SN4Krm9iUFIqH+/9X15FmBrWn/sXTD4DDVjjO5Z4VlzgtXABtt+mILFEbjl8win99c8E8ka9IIsQLAOUCTE0S/tR239rHcGBnVd6ajAFIvul2FlbXoSaOgeyxhXzy11aQhWdquP3HUnIsPAUlEmqEbGRwWqNLiLIyW5qlG+MEa3rNiQvACab8f/ygnOeiWXyQ8HjaF2demRYuGJSrzj2ygcD5HYssLzgVNADnzi3BEfjHYtc3blM+gEVg0KmCLTOSki5D7vi51Gwy37f2D2jFURQa6y+tVdjU2dS4ro/lzV0FOLIcgmPM6Sabkmk9HoRSrqH/ODUzH4ojVmboWELxnZEkOp8cqmzL2D3IKqLgkLOdRwBKHD48E9E3pszEw3R2LL6K4KOwaLnyh/EHnjMh2RUoR87NfBsT/AFk9X0crprds2PnKfO0mLKzk34H5NuRztbhF2Mr0CSGPO20ptSbsqa6h7q8J5YeOVI/GKQ8BYVfLU/2VRPCygI5wZH9mOktCpsJdmTDAwt17VecY7PCqsxkdYdVMF5gP4t8zjluP3QG5PVA5E7L4lu+pL/uw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(83380400001)(5660300002)(2906002)(6512007)(26005)(38100700002)(2616005)(36756003)(86362001)(41300700001)(6506007)(8936002)(107886003)(6666004)(66476007)(478600001)(4326008)(66556008)(8676002)(6486002)(316002)(6916009)(66946007)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cKHntutJuFCiEdXmgp+owqrn79i2aRRyVB3C5VhM3kB+5+K8s8ycIli0EHvA?=
 =?us-ascii?Q?m4a+pKvgd6w63Yyx8Qe+eoO6C/aPjWWhvlFh7611DJEa+5C6GvkFeby3IB4Y?=
 =?us-ascii?Q?+PpjU6IQMKCK7DXcLseTgjIlduwVI/vmxQeKibBOS94rU/jKyXOj8+zYe5Px?=
 =?us-ascii?Q?RCa99HAEjC7Rujk8ckSvPJuXCUJBul452uHLIusmbiG2DV5OG2eoAwgqEdYm?=
 =?us-ascii?Q?q91cON1nxilqGpIzda0dYpM/ljK8s7+Ilwjj3E9jFCDzW50zQBofg20yTqMN?=
 =?us-ascii?Q?LnqZ3Fw6G4tWVvK4pl00hrBU/xpsbEk0PR28RkvX/nSHvxWV/i4XQKZqThbT?=
 =?us-ascii?Q?dteg5D9mbPXKq29EmTIGdLPOPD7jagXPZzMSOJgpNrbxH7k7UGwlDd7BZKh3?=
 =?us-ascii?Q?c+iubHg0M0RkJGLyxjhmy29QN/uSqTm3j+yVOe4mjfYFqwpEdg7sNhdbBo98?=
 =?us-ascii?Q?aiE1hRwCZ9L3ogyO9+05UtOL1EpQ7ZDS9OkfXPLwTbsy9vRIFFC6TcB2H4qX?=
 =?us-ascii?Q?2+v4HpapmHKQOCJJDWAwcQlbamjblPeTm2qWmi9RlnoQfbswSj5rMDSh9cK4?=
 =?us-ascii?Q?hBj0fIch2dSUy4SEwrsMD5jOl7YtLAMt4MxoHA0B6CoDqpE15yjjUNi1QFDt?=
 =?us-ascii?Q?5HixUstr0VEonRQtu0YztjDhqjRMYIiV5eodZE2zzn1VGKEbLq8Fa+Dctv4z?=
 =?us-ascii?Q?h8Esjohxj9JW09BzCSiUYwb05PBbyfg/n156uKCGByNLwMruMf1moQEbTy+a?=
 =?us-ascii?Q?QnxXzR0lk/gox5gk7U7R79FoTMBUl+GwIqNuOsGnTXGh9P8Gii86Ac+gYptp?=
 =?us-ascii?Q?VD4LjWlZqylou8tlM4Fp5H6fJV5EdHehrmnDaO/YAeKEphsPr7+EcxZQ7+Av?=
 =?us-ascii?Q?QihxJ1qz46frfUznVZkQt2cn1esl4KihZq153JKY5ssQ+l0RiI30h3Cu7+yd?=
 =?us-ascii?Q?KxXErRoPQKaltliZ4lUy6QX3WcKejfp7RD2Rw2287y8UA645wl2bv4Ac4aNG?=
 =?us-ascii?Q?YAbBo30XF34VSD4fPXDMXlLiD9yyLHRi6z6dUnb/Lm6DCnx9/SqbeJFvL7z2?=
 =?us-ascii?Q?y8u7yJdlRQEoX3efvaCGDyix8iubZfbbJQS5Dm0UVjmfpCXflQsaUiPT0xh7?=
 =?us-ascii?Q?d1ykHJsoDCMXoLtNjQH9VZLDYH/9tSTsQGXPqY7nanhcSGdVLzPpRBhhaJVa?=
 =?us-ascii?Q?OHGc/mRYXeCPk+5h0zwA1rOpJqzDOccBM//2xKyuSW34cc4uAG35cmelUh8P?=
 =?us-ascii?Q?z1T0p0TU9ndpxJC+V44poJpIyyhGLY7T0EbM2qimfjf46xQWGNpSr5RAKh1w?=
 =?us-ascii?Q?zRxNI0LWpSqK+o8vWDXFeInMvrSvQYccvYca4xK+fF2lby/aK4D85cpomoMr?=
 =?us-ascii?Q?56Ei7U234RHbY9UenvbWRTm0zH4nS45yYQ0r4Bv++CnXZoZ9qFfGc6cWrsfc?=
 =?us-ascii?Q?RuRZGOHD2VD0dehKg905PF0p717HGLa20odcZ8/smHYArPEFiVLpBpLE+H8J?=
 =?us-ascii?Q?w8JeiDtrVkF9QGrCuD4uJP1yZ+zgSZhiknTiIE3OcnAA55graRCutI9YYq0/?=
 =?us-ascii?Q?DCwzQBPzj4eeyXPOOClC0bLrp96GP4W2MNyHbQu9yA8Ljgf3Lw3xB31W55Bs?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1b8e79-7406-4b9d-0613-08dbdd40b01f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 14:16:50.6679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ateWp9DXPHj3+Z00htbXqqo6dA9qL3euSDTiH5adpcUwALmnswq+YYrCJ/dNTnowEqxpdf4fZC8gMd7Bv2wag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6820

This patch uses pm_nl_get_pernet_from_msk() to get the pernet id_bitmap
instead of using a local bitmap when appending a new local address into
the userspace PM local address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index efecbe3cf415..a8e35677b6a7 100644
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
@@ -36,9 +36,8 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bool id_match = false;
 	int ret = -EINVAL;
 
-	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-
 	spin_lock_bh(&msk->pm.lock);
+
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
 		if (addr_match && entry->addr.id == 0)
@@ -50,7 +49,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		} else if (addr_match || id_match) {
 			break;
 		}
-		__set_bit(e->addr.id, id_bitmap);
 	}
 
 	if (!match && !addr_match && !id_match) {
@@ -65,9 +63,10 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
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

