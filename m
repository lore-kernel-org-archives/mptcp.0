Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E3133CC
	for <mptcp@lists.linux.dev>; Thu, 13 Apr 2023 09:13:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vd/DRS9z12bz7lBJNiDVp1m1Ah8U99yii9mNpHeBeAh+8VfdtV9vT4EpTw6Q2Y3qzIlcvjshNmH3cqZFc/bOjBCJxxC5/YtFNQlAmeyRC0ZpwL9RbkVpkE4ewfzdaw7XWp757F2l20uNIJGpUR5CliS03MKy5q4yx50LvZ5hJsaUVC4t2sha9A7pz+SyxkgcgSX0D2I64d9E0CJ/5/0fDm20K19xXbpKvtKm9YHhjoVMqAFpqA7r9CFkJqs2SrB+60UeaDkCOVZFZlvkXG13tGM/o0OsVWtblAJkIhC5OmuBJ/Ke8PfNFqVHPWCEhRNndZaiUryYI2mX1uJutOX60g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Stt/gmdwaCaCNey46Fj4wJE+HEtvPPRlhBozHbioAzc=;
 b=jZi1cfETRpghR3OiBy8KvOgDmqdr0byOH4ZW9dr9yE3Vi3+92ob5YrmGY5Op6A9xRpuiTHoUPBXYxPXyOm3fIKOKDM0TShinUX2p9mMvbywH1uofcLt3QtEhm0jKN+mzPBvQ3dgwG2fbRu1Xb2ZRLNufW616tb2qm2SAlfQYYlgLuK+OmC4UHdyE/c8pOYfKOhR5wME+tMLyP0VJJ48nhzb2WFSd5owISWvjZrsiaw2u8S7wWjzwQsnJiOp0sQZ0NTVQC91z0RQv5kVOSrBJs7rbdJJhKWN5/DIGJOPlHYsJw2O68n1LaRZLEYBc1P4HuSbJY5l6EUe2ne8sh351jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Stt/gmdwaCaCNey46Fj4wJE+HEtvPPRlhBozHbioAzc=;
 b=PmgXZaRLxZ3KOfdolvaZuUcTqgnXJeX7RFjpBSQAccDNodJXdd3tuteBQDXaSZpqGHTMkuw2rzo65YryaS8cwxkLT88ppXXkoAtoe8dy4io1ADrRzV3CB77o/t6npZXm7srRulHna1D3HpGr266227QTTohoMegGBqK2PZtkQztZ0jYD4xK1fFILg+37efWgkm+5dBoE31QxlgPSVZfPZGpIYpwR69qRN5iEzt6BmjGueYcjmIO7IKGhfByOGle4iI0YI5UBLmzcjQObjCvEM4W/9hwaVDGlHMyZRVwFteJ74mM4VqdciUvX8wuzP6B2UxuhpJhMViP8b1/YjiEwuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7339.eurprd04.prod.outlook.com (2603:10a6:102:8b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 09:13:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 09:13:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 5/7] mptcp: increase userspace pm add_addr_signaled
Date: Thu, 13 Apr 2023 17:12:40 +0800
Message-Id: <ffee48c5a8df8ec79f90cbbe3731c68567abf1b1.1681376983.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1681376983.git.geliang.tang@suse.com>
References: <cover.1681376983.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 20637ff8-0b08-4ccc-0c73-08db3bff5512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1TiIrhP8eOsHQGAxgJO+tp2jRcYi/pEChNDTBs6gZKczBCLoxphpvdLnWdKEi2yUZZ7GBXc1uZh+49/eyZnrCI8ihXwjNU1JEqXb/kon+py1kGin55PyUHT5QCY6+ITiwhtA3Zu0mpyk2WpcVVYqZWok7rQi4ynJg0d1svtp7pSP1/v/UlOqFIWuxuQJeOtuJhOBxkmA7saGqL9QV2qKG1W1bEJ7S2X2fQbIowy6IXkjM4mBMHE8Yh17CjfUKOcnNZqBk27cK8eKsdPI+MIrE7b8+4UgnXTREkr+4t6SSKJE42XovJioGWpdhxpmapUGWlRZpzq9tXZ/HGrHxDReDvL22HwmTSfq278gDyK3tFJDZX7vsXA2sfJDLuCqQd0PBCAJ983XDwrc/YulTeGLwEFrGNPP03xtCTqKAGp0MhuDBdmahZoAMq4ODjnnvI1iLvP/59+O+3OfAF2ygR3OXNMvKI4GSyNgRRShj3z5hbgxurvB87vyetAVIcPSvhiu3dM0BfcTxCfA3x+BOLSqLl4plbepikaeNNmQlxIbpRVaLGuaXtogtKCTmTGQ3WSi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(86362001)(478600001)(6486002)(36756003)(2616005)(83380400001)(26005)(107886003)(186003)(6512007)(6506007)(38100700002)(6666004)(316002)(6916009)(4326008)(66476007)(66556008)(66946007)(2906002)(4744005)(8676002)(8936002)(44832011)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TEcHBRHt9n2PsVEQmMMr56+IgO3YISf0n06b1LG+eRZRy2uW//rJjvuOr6Fk?=
 =?us-ascii?Q?TEZTjRFfboG13PcSre4ykSjzYxb8ATng5Zx0BqqfDeIyyxekJOSINABGnHcH?=
 =?us-ascii?Q?JwfCUYD4/FijWnBuaMZHKu2LnOPudTQpkRd2oftODzSgZ3Fu+8KhK3OyFciX?=
 =?us-ascii?Q?1TDX4ACwPZNamFT5AZLuDySSIePXL+/SlEjSgrEuVaKubDRsLrWVDDmzGorn?=
 =?us-ascii?Q?LAWZKjVdXjjt6xQZlg0EZVrScbx9b3mZgWLqXsgjfD6MuArJPkA+AoIfoBkB?=
 =?us-ascii?Q?f6Zsq/oJ/a5fXVUuECK6mhH2+hqWfm9HNFgm/ubeHkolOKNEwV+yCJXW32lP?=
 =?us-ascii?Q?IfJEELL7WnpACI83BtZvIdE1VGqaSmsCLYelmurfQriAXkDgFLxTacATG6Ti?=
 =?us-ascii?Q?y5Vcw+NAwm1ZgEzz9M2MAC2SWUF18IRkMc3fCYqGVP31PrKgyjuay5OAAP6X?=
 =?us-ascii?Q?3H3Io2wCvjFFh5gsTB77ArpC4OzqY7PFaCLaWNp+k9gje7WGszo9/nXAZKBA?=
 =?us-ascii?Q?cpv0TvNS9pY+95xZKOooI8Z6SxF7jcTF0sLQuclsHnloQdd0EHvb2ZH3tZKG?=
 =?us-ascii?Q?Yj4omGtND7LwMWNJ1G+zs+Na8mSGseXniSaYL/9Lcv46vMbyrTG5ktxK+I3x?=
 =?us-ascii?Q?neUP3R/4dDzomVrd3EK047bIJBe+jvG11pI120pPNF2PqOLrZR0i50ej08Kh?=
 =?us-ascii?Q?KJ0eGfUSL1CZT1caSDx21WN4JGWbfqCerH4nHWRoyYb3egIKtNKuG8ShwTWv?=
 =?us-ascii?Q?ID+bIQZVsm+cW2l/TeExg9pG6lmcI87uqk23KK6kfjGIzV2JzsAceqbkbonf?=
 =?us-ascii?Q?YT/nsisd3ULpxhzHlgkaM9oQ0nMzJconpmXpiaelEqblG/mJgqiFnKZOTih/?=
 =?us-ascii?Q?agN5ZbwUGwOyF4jDpFTlHtruJJjWRoVYh8ynFaV/PXt632/xu3cifN++RNuw?=
 =?us-ascii?Q?I6Vwl4zEXStlIPSA+ynU8B/MXbAjw64cRK9KhIOF4RpEUNzLSiPHYpFEP0OH?=
 =?us-ascii?Q?/qw1D5Stecy+wFnHym6o2LgJhTYLERv10C8vjLybZ9calz9oEUYnEeCovtcp?=
 =?us-ascii?Q?rIc/Yti5pqxOPd1HDmZYAYPoA5mLBrcPZazNF1dIZ3SlONEbKZjdYeKJQ1pZ?=
 =?us-ascii?Q?Vp+CAEC+C8E+g/sLPt6XzTH3Eqt83KTIoXwW33Dx7ayduShhjAKIy5aDXA7b?=
 =?us-ascii?Q?fiMKIjCpR+kW5CO+UxTxLQAPE9lZThYiYrgdGSiFW8bbxgzf4tJWAZaDH/p2?=
 =?us-ascii?Q?8l/nF0spNmk47k6cvcrkKAXyseVj8tMpFv/bfDxsBloQD4C46g2vRsMl24gU?=
 =?us-ascii?Q?gAgpCyBq5+LkWRg45aq/ghRnegZI+v6pmy1Tge5FQ89y74nwsMX1KL1+82Kx?=
 =?us-ascii?Q?w17lMgftDwAf+elZzox5phW9csSEXc/BKS6tr1tDYCffHs7oiVIN/UFaMsHu?=
 =?us-ascii?Q?hWpw2FxQejm7D2bN/hrn3cd3eyHE+sqERpn7k9zW94HsGAgkj8BdCTZnUiK+?=
 =?us-ascii?Q?//Fr8NhHMjcEdJ0oICgiqfbTy5KC/3859LvwzqOUK4DiNViq7NxihI5j1Cur?=
 =?us-ascii?Q?4dLgDZaRFF0vtA/OsswpINStId6mcWWrc2fSJRt1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20637ff8-0b08-4ccc-0c73-08db3bff5512
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 09:13:23.4286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHwsdLkLFIDdipE2uegIaogsfqzfRdl7c5owEzsnvIVxS93Uc1pqO2Ge6EvzYe9WEQLlnSxqvm+Pzc+ZXl8gLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7339

Increase add_addr_signaled counter in mptcp_nl_cmd_announce() when the
address is announced by userspace PM.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7d676daa89ba..817b6f1eb013 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -170,6 +170,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 	}
-- 
2.35.3

