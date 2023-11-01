Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB16D7FE
	for <mptcp@lists.linux.dev>; Wed,  1 Nov 2023 04:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Clix3GHn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tn0swn2p1KGgo/f6L8yGV4p3JJD5IMGd5ji2MLEF0jg4etWTs3qN6NV6S2JKFhbxmsn0m7F0Ekrll0tx35a8Iy/zCLpnyqxRc2IAhPjhapFii6Zcj8jpNUdE9LqZQFKw0jKx5TbC91kyt8pPBJTvO6PUSIgPn80j51D8IJEfQdY+jIRNn+Js9vFDZ0vaHAEkf64lRyPvCD6XYrKZ1Ree9OmfMHX3tnuoquZNT/mzOiqeriGEbomxfeZiTftrzcc+4sPZRcr8Uenla0XiuqeevgY2zmSuZnEb+ulOPhbM3dK+y/SE36Aw+OFkjl7Ll32XLxoof/aJgsEEYaohpkJUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3QQt1ENstyDjjL3wZwxX4It8/XNcCi1gxx1Z7bqJD0=;
 b=mhWNKr5d4YpycVZIbJfzzPh0zGI01rtFkFUJ5aZycKeR61ryErqjUW5zYGvpz3g3GSiO3htqLO+t8U4fzmlC/214s6aE/2THF0a3JX2jkFxdKAotFyq41W80WQO5jE9UIC96VRU2AsfsLxmopR2iNMaXT3JK9rljqDqPfrdFzXOv3GOzY7IJYrdx2LiruUHTAVPqveg3NOaZXY5JVMZMQz6J9+X0PfONWMSxxZQw7EamHigneWUwAOocT8uOp7jvzyHSWe0/fZ315clhbZO5c6X4mY2IdA2pBdWO29RMxumQuuuIMPjOSs1XDf0BUafPVy4bFyWN15PqhdZ9nmdLng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3QQt1ENstyDjjL3wZwxX4It8/XNcCi1gxx1Z7bqJD0=;
 b=Clix3GHn2gNjm+N3YonBizEJPLUTKxWQIlYXaFYZCjVjWGeMrONqz2NtF3/xi8nkLLR+KaYWaKop/od2EoBrp156vLUZ2N+GFsD0j6L5m42vf/WrmRbTOgbfM0NjkjM+mpoxlsJZ1EMjdjPXUhHwLd97hqbs7YQG0EVYqLp2Gral0ZKl8qdMENl0hv20q9HZjLrLsJyj0yo6iYa7ZIsYPRkQ39+HzQIaT2NaqnhrODckmro590riuzVqOeCFPNzdX2IAKaxDADyGL9oKeu4c8loCnpsw2jKhrccP8Ev/F62vJasH4JHu2wIp3ZrDDXaQhNFmmL1tVDDIkB9DtDksig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7070.eurprd04.prod.outlook.com (2603:10a6:800:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18; Wed, 1 Nov
 2023 04:38:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Wed, 1 Nov 2023
 04:38:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/9] mptcp: dup an entry when removing it
Date: Wed,  1 Nov 2023 12:38:18 +0800
Message-Id: <966dfc2b9e81e8f788e4e63eecff1b1b05d0056a.1698813419.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698813419.git.geliang.tang@suse.com>
References: <cover.1698813419.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: d120f94e-efd7-4e02-1bfc-08dbda94699a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wDZFSGBdUmCV7XVo+FVQS3g6ivsvtm/LLS1V1A27/MYx2FTV0e/Ec/fQKVdxqbYDKggO7OXo7lb+yFPnygA+8i/+APvah5f6VzKL5FhTZTusebPLZ8S48wFrQ4FFa2LygfnTETkkXNrNWd4tX2eyZt67af/hobmVP76tc1bUwhVdFOwuTymNb+58rxCY5TN3YAzLhhgrcWbaxlVtoOwtup/3q2bXwWqcjkLyAHk4/WYPwAwLe+EWAF4segzjWkS10kAsbZY/BUi59i5YoazOp0EE1txxQADF0BiPkEqHkKGLv0spTUcAU5CYyZZ8O36nqzZeeonl2pkU6PtX/lgElI7UPzBmuGgSCbanwx3IYZU9/dq0FG3LH5pB+WctGpvJvikINk8eC0yX6SgXdJ4MTB2JEeDGVme45G7VsEM3Sf8+8hdo2eiqI1Rw/7Fa5WvcH1gAyFBXwFSIMCQfeRbb40w0B8qwmEY/HOdYzyWfz1al7VoMdI65aN/UspFt4RfhtI//Ya/yBU3DVzYBblNrC2PnRuFNvKLCulGLwZAn6LV7ilzrkbuG+eSnkXFmJN5h5bRAg4vCaFFvgXjLVafiWECwihXwD0Z8jhImRzqnIl4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(44832011)(38100700002)(66556008)(66946007)(66476007)(36756003)(2906002)(6916009)(41300700001)(316002)(8676002)(8936002)(83380400001)(4326008)(6512007)(26005)(86362001)(107886003)(5660300002)(2616005)(4744005)(6666004)(478600001)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9vw9t5IaH4TAdQcsjn/bHS1gf9LUhWia1lTeLKYa70UsZQlQ+X+EAW67D4mQ?=
 =?us-ascii?Q?s2VKgiJYYc6QieEoW96zeAYPpomeAh2SI6Q0OsI756sN4YS+aAIGuL8aiEjy?=
 =?us-ascii?Q?MeL0iSpcbIGI2J0FcQdHfKchPRNI3SNKXCAiB/27yL52CujeJ4Em8EHgzYmt?=
 =?us-ascii?Q?9vr1u2dlcDBBNiCYJgDBMCZPcR3wXE07Vxmjr8LY/RXcXpASBIY9fHB6Jx6F?=
 =?us-ascii?Q?vMxmpGeIswqLkHV3PO1bPuySlVMxnIApRnncsYRPmJZUqnB54PuW7TNGk6rY?=
 =?us-ascii?Q?lrfHz7hDgJFTQIObWnrn2n0zaqfCc2peEHYfzjPxs4NZSzBgelvmHH36mpGE?=
 =?us-ascii?Q?63y4h640afH+QxnFRaeVYYFBJlGKGCWGJHBPBG8tFqowsC9O4b5Io9UHuP5Z?=
 =?us-ascii?Q?HZYDqbyeiB5YR1KJOcwn8VtEjfZBQuVgOY+0c0izrUrjpTPfr16U71blRbIW?=
 =?us-ascii?Q?8wHRFxMTr+yVQF4QjlB3KcOg2Qvc212PRSrKzjfBbca9vDaIFmOpySDw+YSk?=
 =?us-ascii?Q?cvncRZ224EqPKp4kWPU80EjG4aVzUDSzzSxp3EbGWMJ2AOE2rt9wup25jy7q?=
 =?us-ascii?Q?PzwYIIcMTiJf579GonN2o1JR7lomUkYMEDgxClLzFU9UDZfURyt12SqOssJ5?=
 =?us-ascii?Q?WF6pc0wg7CLU+bFCHEykFGcEF23mVyZYzpflvTlpX0BOJmjVLeE808bCaHMN?=
 =?us-ascii?Q?WTqGZ3zIefwFthE+nkdhdzEhugXNrqFz2wjBKjFy1vVLxXkYdzg1ChXG+VJ9?=
 =?us-ascii?Q?dnIAfClFigO34Df3PfJEsWgolPzBqyjdOCteVaJAThR3wyqIFBY+LG1KSbEz?=
 =?us-ascii?Q?bwXyRUxeYX1CLZPQlQCJ1sKr6CDh+CBHbIfaWgSN48BA0X6K4a0GYML8CpeA?=
 =?us-ascii?Q?kymR6pnLj9foxU6uqoaCJ+CqBliLzy4GsUFycA6XzBAJPJUV4wcdNJ2fM2HU?=
 =?us-ascii?Q?/TJCe0qlj5Z/cht7qxrxI2JP2ZMU32KPEye+jm5cDTO8gFdrwj/Gcqzl00kK?=
 =?us-ascii?Q?jOf3w3R/QY5NIKh3D2dKzx8AauHPXBNH4USOh+6Kf99gumdbHwkSIYB7lrHO?=
 =?us-ascii?Q?ztZ81p3rWlgJLY3e61IkOM+0Se5++lGVa9Lsvqiqf76QTixO05ynXh97X4JH?=
 =?us-ascii?Q?wu0TD352hVHTN3q7Q9HR6gMk5I/JeEtiMskMfpD9lr5p3yzZ2lNkNHCwjd7/?=
 =?us-ascii?Q?OWsDE4++dsyO1hAFTPo03C9FRaHqYTCcrNrJt5+SE+d5vI3jgbgfbWKXBL1I?=
 =?us-ascii?Q?sLCrPmjieT+aryiwF8wUAep5yoK4NoSfmfWZOUWtMF/IovRIlwfjd/vI5hQ5?=
 =?us-ascii?Q?/VM0nfDwKeZcBWFth9JFKAkc8W23SYvOK9odRSBK/Gy71R/RnWS4ntxI3ADJ?=
 =?us-ascii?Q?yPB+ocAqSq8ikA1IMyCYTosFfBt34mbweaNgFpS5FMY/EWwlK6bQPIB5Z241?=
 =?us-ascii?Q?SwUDkTpDQZp06rHM2g+j4SemPiWi/9JswScRCRxU93S4CkZqrbkg0PvjlIk0?=
 =?us-ascii?Q?bPaVG9ABgLcbgDH/ZaKkck14knoZ30IMd5eRzYP462W467WvKfXa94ZmTp4y?=
 =?us-ascii?Q?ruZ729e1a51dKTMGZ1pcrPS9ByOVm06WS4axhZh/?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d120f94e-efd7-4e02-1bfc-08dbda94699a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 04:38:36.6049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xefpCjXXfjm1eWblLgthh4yE/cZvO7cPNe4qGBzzy4wsKOrDXBMBdvaqFARpLbZjp47AnD3VNkFytAjNYp8Gtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7070

In some cases, the address entry does not require free. This patch dups
an entry to separate the deleted address from the free address, so that
the refcounts can be added later.

Squash to "mptcp: userspace_pm_delete_local_addr"

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index efecbe3cf415..7227198fe689 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -299,10 +299,18 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
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

