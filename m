Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C52D17C6
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 03:00:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tgtc2PBS+WCPjcX9bMKP6dD91WQ4RzCbJs9LEs1qyky4a6pvZP4GS/6MSed0T5AWqZyl37gC2UaKGWKe7blnEcKjsOTb4xPKTHcE5dCgMXmeUkeZ0UVZJgW2XlOyXcrzWz6eYCpJzXPKYFWhOgXMNEsmVm+xJaSn/JU4VCpAyo0gRP+xzvgZD3aqgG4PGzjXaKM2XJ04yVan5+nYF4zOLHZmb7AdFo0hezInEAaM+V9aL+YUPsQBYI6vw73RT72dtiJckrcpYOPhPc+phOxTKslKNgUCi+ZIeMNu+8FmQGPumkmPeB4RTWjeBfFUDlcBDx5bWnfzJ/JO5IdEvcfx5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuFJgbTEAPvsiFVhkcDU8nf3lgsgsmz7+0gD6qPjqNc=;
 b=Idx1sDYXm1m8MtvAKrrI5uADeq2QWEmH060FdIZLeqGoxNTlZ0RfeRsLPmR5+M2pJeu260viv3uLdSjcGPBhExSu2Wp7k5jwNHBR1qr5VXotCcqeVy6X0pnv+Rq5cgWQZdDtJLrOnqSBvEVlw//M6lVYaTgXb38jw2glxCVDvLj3N/nkxwEQcF7656Px6QmlB+C2BW+VGAiqLC7dxIO3mgpUsefStk4fpH5iaLqAecgVxpMgh7Z3wSH1cSBls+bBfGJ+JWEttkA9P80ndC1s53r8jyXyA8i9aMRIzXn7Wm3dD+hA6kVVsrfzbnJLwMMqEnSa0XqI/CEbgtVfw+5yKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuFJgbTEAPvsiFVhkcDU8nf3lgsgsmz7+0gD6qPjqNc=;
 b=2UVVobenMuaMV8jxVIh0yGZvUqu7hswBCt0SIsL7r5BxMsp8DayZgf1B0C6PhuqzClOu/uVOISEhGjLaJvnawT00MG1JrSD9hrOoxTiT/2EQPT4174j0NOSiICTyIcBwRjtXFfunG8MOTVCOo5bocgObSTpAm+0eqFI2PNkvOrd9/XWtwR8f9eVcDncF0l1DCkRX4vCs7asCgYNHiM7JhP5zJaelW9IhwN0j+9spSVqnxZbszgNTfIGy/y3eUEbCUSNv+AwDQch7AAWJJ6WAaca70uY57KvnYLv3ZW2KrVbrohxgMHYV4rWI50RmNU47yoCOy/74kyNpWtTbflcM2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8838.eurprd04.prod.outlook.com (2603:10a6:10:2e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 03:00:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 03:00:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 3/7] mptcp: close remote subflow when destroying it
Date: Tue, 14 Mar 2023 11:01:42 +0800
Message-Id: <18ab65a89848d11d9cec95049b47481577906b21.1678762832.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1678762832.git.geliang.tang@suse.com>
References: <cover.1678762832.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a853343-1b0d-4fde-679a-08db24385083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d3Xj4h4PZ/SSnlpMfFK6a5nch/ib8YsKYIkAJFbiD0ob4RG0DSjqr8y+CURpgJ3b3/90VkDWGf3TKARMuF1dwJUtntlRiShLP2QCfX9rRtyxVcoW7Bhi8jzosWMtWO4QA/iGGnRHa4mzM9LOSIapb+DmXN4YYyfX13F2jMdXvnTBfAo/J9g/ocfkI4pPqyQqBPl/ng8q9LHSjVxw3lc2ctqVPU94yHVLiPMVA5Nofpw4MfFK0EziMKI6V61+1HLAe2BAQTdl7sKJ0BZ3rJ8grY2BuZvSyw6MigkdrZpEe6xyxVmTLyk29pkxAmPj0f9z8i8mbWcpdTbmR+ImS0CJGNF9NKP+CxCiuyjaX6ylqaaEkkbI11UipqkU5Nmg4S5gjB1nEDDW27YjBNigGMrXqpPz7Uld4+WPdMK9aYNTJIgKuY8RU7YFV+WX5q+4oCQ/VHy8jfQx7+pw1gpdQkqUxtv5pCzSoO5338FoYNgio3dp9wdC7psYMrs3RMgpXHzY9PRW0poGkkyxdZVlvMDmcq4CfyuBjOqsHtP6PE09/ueWdoj6jQV14M7q/RugeQeAgzE/0AUajzouylloo2s+qJ4iQvjSIVGU1vZepcrfSnXPCXQlABdx+6/lP/dfAlX41zZRvnqhfyPrbotrKqwm9khgT0c9rBtw/n5xjnlhwGS55wsffg97efxte3//fcqE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199018)(36756003)(44832011)(5660300002)(83380400001)(186003)(478600001)(6666004)(107886003)(6506007)(6486002)(6512007)(26005)(2616005)(6916009)(4326008)(66946007)(8936002)(8676002)(66556008)(66476007)(41300700001)(316002)(86362001)(38100700002)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5jvCwMxbAD2YBXmH2n29D6x8PZpPKBf6NjKnLmH0RSFuplfFJdUhzCwD3Wp/?=
 =?us-ascii?Q?eT+2RKIRh2Mzut5RMQTDK9k0lAkmXO9uS7LWVW/I1AGdkLVTI/zlmz7Dos+/?=
 =?us-ascii?Q?2RhfYRl5bwymG4puPkooRaWnZ6vTxqyFYWQ1kLzh+gQi+lZc8nRkCVhXsLPx?=
 =?us-ascii?Q?/qNkRK0WAafl62/vYjKbMYgsWyskfn8yf0ECljlNstDhduuzRoJf3puhH5OZ?=
 =?us-ascii?Q?PnFDPBdLgFWiiJYRknZ4iFJd+deIvtYN2rvVPPq4pFGdSb/76heR6a5P0LFn?=
 =?us-ascii?Q?ye1kIDG8KZUaOSZm7Z8WQjEnfGX6KSwZSj43ezo8T+UTr04UErRYFGqIfgIk?=
 =?us-ascii?Q?dzhYDzIKoV0w3svoPWfm00eHAU01d3lYdq8NQoTYGm5bkJ8pUjVx970as6kI?=
 =?us-ascii?Q?KbeMhHoId0y0HZkKFA+fa2uMxFc7fQiHz/dvObYokEPYAaoDrIqjQfziFuoc?=
 =?us-ascii?Q?HLPflznn+32p/SevZPwoCxuQQ7/RpkacTSrvbBDQaoWYxeTvyoSE/8MYX/+r?=
 =?us-ascii?Q?/ctKz1AQ3OT47pMyAMW11kos31XuEwEwA24v8OpURuVkqJYz3zsXcz0KJo8v?=
 =?us-ascii?Q?/H7TD9XZGHnEjlsxWpqPbC4QOfrJGRNKBnkZ4wSDSPYo3OjnhNzFkqYu65Ci?=
 =?us-ascii?Q?wa6axvtOOa7sXlwudiUiP9HvNuj0oR+Da8XgzE+fHzLwcm6XWmfR8OFlTChP?=
 =?us-ascii?Q?alCRHHYUKycO+CbAxVymCdtOQdrDtnz7NsgLEAy6LmViHvB2pvrQg3cYOTOB?=
 =?us-ascii?Q?UIeD55as6bwJT/EEg6n540UcKlGH4ryf3FAx1BqYneq6BiiSFlToPxLBCKMf?=
 =?us-ascii?Q?Sm9F9zlyjFkzXItgyD63thNWzADkNom30oHtHISKpdNw0CDhz4kUU7dgdeDC?=
 =?us-ascii?Q?INQegkHiAN4ef1aM301VWNSHJolCJmQj5Bd9lTG6T9BNLe7VDsRw60qlXXw+?=
 =?us-ascii?Q?IdZdh5dfXZKV9rOzFY7Rv5SLu4qp6jqDJs/UoaU9ExKBXnOsNVdaIGWHL56M?=
 =?us-ascii?Q?SF7KL7cF6/ejPRvhURIjToiVP1Q+DADWvFrhWBZHzi7SoyZrABXLH/iRLaDm?=
 =?us-ascii?Q?+5YS0BMBHw3NGB37kMfYblSe8Mej134bupwVnIyLq4Q01QaccOwZvEfAQsrF?=
 =?us-ascii?Q?m/9Zk+/vAUK+o7wJiTHD0XRHDt8ctzj2Bc4i1T/Vyr739uY/aSDMOJUThILu?=
 =?us-ascii?Q?dj+r3sk82VD8PsMAqldqyWL2hUs9G/Q9pzXrOafKbEhunRDP/7iUy/NGcsLp?=
 =?us-ascii?Q?wF7rEJc2xmb+qcj7EvLPKvw1RSyb/71+wmYhh5286Yblj6Bfuz0eFxT3+GTh?=
 =?us-ascii?Q?mG1MTQ+3khnPBGcp7lcT0JjkvOMWfE9NZi8OAjiITaTcP9JMt/gGMR7uLrqa?=
 =?us-ascii?Q?K22FEfKO8Bx7fBSMyFmlL/eaLhi8oC18ec+NGOIOINj074OsKumxVp0pJe1H?=
 =?us-ascii?Q?n10VCPX77CDHnSAtYNOA0LXIMYNvvdbpqyqSzB7LI8kNXfC1x/WUG9z+7RZI?=
 =?us-ascii?Q?5xe73DunwRrczvoU2dvzcNzQjQsqUlvKrLTFXfcvb2xrQuAmMQ/jGy4tcpfi?=
 =?us-ascii?Q?CJQbVqThxuRV7yHEA9/ofdeRJjnM+I1lXq3Sb0mF7vU1EgppBzNbnqxXGWT5?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a853343-1b0d-4fde-679a-08db24385083
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 03:00:49.2177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxgA+5kDCTST/U0klF9TJ3mBxuhmR2tdGkCHhZJIzx9nbxJWQh3VWKloYjv4S96io/7L9U6CzJAhhnru/MZDPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8838

Not only close the local subflow but also send RM_ADDR by invoking
mptcp_pm_remove_addr() to close the remote subflow when a subflow is
destroyed by userspace PM.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c                        | 15 +++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 49f41a040485..ebadfafaa203 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -429,6 +429,21 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+		struct mptcp_pm_addr_entry *entry, *tmp;
+
+		spin_lock_bh(&msk->pm.lock);
+		list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
+			if (mptcp_addresses_equal(&entry->addr, &addr_l, false)) {
+				struct mptcp_rm_list list = { .nr = 0 };
+
+				list.ids[list.nr++] = entry->addr.id;
+				mptcp_pm_remove_addr(msk, &list);
+				list_del_rcu(&entry->list);
+				msk->pm.local_addr_used--;
+				break;
+			}
+		}
+		spin_unlock_bh(&msk->pm.lock);
 
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fafd19ec7e1f..506120401abe 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3123,7 +3123,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
 		chk_join_nr 1 1 1
-		chk_rm_nr 0 1
+		chk_rm_nr 1 1
 		kill_events_pids
 	fi
 }
-- 
2.35.3

