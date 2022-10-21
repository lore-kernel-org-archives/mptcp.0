Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00071.outbound.protection.outlook.com [40.107.0.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F317B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:01:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsnc36QfztaamngA41/uu1q3+Q2cdzlwdyUhsbpxKylTbJI25tyHzl50XuHtnboTVmIy8726FMOGcD1CRz5SAnrf53ALPjuuSWHKGjUvA86sgGnQISEa3U5oxFPkC2JFLOT5FuL2dS55tCofa6xFX8vs19byNtLe99MWx0HZ6cJcc0YEwvmSSgRMyDl8xdkCtdmbrgCISEQBiwJvOBrMKHGIfAEFAh1S1Muqs0M4EcIjwSxYdu5pSXEwxtCdpgqKc1bJHvn1FCCVRZekDK0BMzP4iSqjrBXpL2CJ4PRlUyMrXjYdo8iUDKZCknpme7yHFT3WNXSms5MXOrhkC+6E0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuRdzJcF64kacxCMa++KrXFRVFU7wrRXkDEToLE5QjA=;
 b=Umb2y0FCf3ECwskyj6bDDzraNPU2DRM7/6bE78RK+mB7M5I0EzOblMRnEthkX2Hri5iIRwNsHXdMq/8N5MXlSi24g2Gsmie5bEN4T7v4JNMfB85iOFM8I/9aKG5uNmP/tvBNitQ/F0AlVE6TpzSUMSHAPzWNk+xggJC8JGb60NtDES/zT5GxytBHsFzNWNlLAdhdreSg4aqAh/46kgnzQl+Xqt4BxOLPmNjLLgbgBArLrnczXBU3EhfkuYdCDCcFpHlYlrl0SApWdh8cDaXGsk7MuAfocSncVI5iS725auB9Sfx8tWgbJ70XVWnr/y14qV+k+Mkv6bMEaAivYV3Nlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuRdzJcF64kacxCMa++KrXFRVFU7wrRXkDEToLE5QjA=;
 b=DUbZSJRdvIUHmtCBIgW5voP4KWPN8x5//GX7gdDyLLuOpRsAY59UkjLbqBumy88MbmSng3Pdpltgy9kmHytEPgj7aqvaugZrIbwqAMo1wdISW9sUdVarv0kRZg+eIprdImyCL+zg8gMBEBXgV3+dTX/L1di4Tx+VemrVgySHdRoLEnNUsNdpc9EtwP5f3Q6Y1Choa59fdDIuWpX0JFoqHmv4Qn/oRh4DhVyJOo9Rjh71PowbLT1LMBO0br+nBHXdZkfDxEDRERaEhD1b3FUlRdZiBM7x1T3HpPOg7sRjcdf4LBiyCN/XPGGQmNbUeOuvZWi3Sme3cPpth9lBA3HerQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBBPR04MB7835.eurprd04.prod.outlook.com (2603:10a6:10:1ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 11:00:57 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:00:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 02/19] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Fri, 21 Oct 2022 18:59:54 +0800
Message-Id: <0c76170deffaef27e7f13ab23db61dab3c040355.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666349129.git.geliang.tang@suse.com>
References: <cover.1666349129.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0014.apcprd03.prod.outlook.com
 (2603:1096:404:14::26) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DBBPR04MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6532d1-ff6a-4954-ee77-08dab353885f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BfsuQtNGVZYHwP6X7uSIBXky75nbrtB/PI6KX1/1tBvVmfvMh/E3Rmm5JDBCNxKJn6i3tB5bOlbvanJXkEtZqVxspMIR7dOPtzqeUTCLsHBiCldEEJZshRRo7L/HcvqB2LdizLjxyUrihL4iUggOGAIeD5SXQ8FGH/p0idM7ENgEey2x7+df7zaRTSEoGw/Y/lTBhCIUbGsRh2DdHu17rtTzDddjKl2GHQIQHRZDHKTn/cEMqSXu+EMuYlCPCHbXIgnYzo80K6cjxjYtS6cOrQkCvKJ5UqVEOEJ+kWl61mJKZkRUVQNCfKWgMtxtUkUAe3mXBgxi6hJIA1wL88CRuWJs/x6l9O+CxfRHjupftLfBMB3Qv5PR6UcHrYi9D5+pI2e1ni2roX2Tzn/k6ZAAOFc2h0pXmpPdxtQhfekNaWOgp+8yoRmp1oEFAMavcleXyv+TBrxVWem9jhV1e29XwKO8NCVZ3cdVWntq3bOnWRIJzs/lSUcAF68puPPi9IzEXQcMop4EKkPNSrzpI9wOqCfQi9VW3P5nc2dxOLRRmEBFkix5g4YIucHtQ1P7pA1oySZfRmkUsnHxGYpenP1NixdqCoReoP12zPk0SFqzJT/AZiY/bS08k3UV3OLnx7blaPRENPEvQBXGeAE3ufWTuo7coAFBe19no3DT3WJzSBY1U8wh7v4X6m7RLd5zH+LbJr0Z9pyzZ9XtTVKzBLnZOsXK4LfZ4KDBL/sm5w2M0Jv/zGk1sU/xmS/Mnb3001u8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(44832011)(66476007)(86362001)(8676002)(66556008)(36756003)(66946007)(26005)(6506007)(5660300002)(41300700001)(83380400001)(6916009)(4326008)(316002)(8936002)(107886003)(6666004)(38100700002)(6512007)(6486002)(2616005)(2906002)(186003)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0x2WF/U/2kryEJjaL3UHA3xfph4KQ/rSusZnY7U8d0OpfCmpJqDZ0DvtznDo?=
 =?us-ascii?Q?InAe0ddokEnuz9VlcJzSU08Uc0mXVr/TtEuH04gv8rkPTVtp02MG8heSDdJF?=
 =?us-ascii?Q?A3ZodhFYsUWWJoKjiApJItd4thU0tSjAVJLTtqGbLg57mpG3Tr7Qdh7gIw+9?=
 =?us-ascii?Q?KihHzvlS5iSkusME3/FzS+4cU/609JFz+ubk4AGdeaIdGF22gIwHDNnF0WC4?=
 =?us-ascii?Q?p8iR41so6nOeLkrWQ+DVWUfH3y1cVV6F0CYz2viMshjslY1+z7yJrtAYPHxd?=
 =?us-ascii?Q?Qr01+OuYG+Oc5nwIkNBpgynSF9y0UMjsAxNcp+NFt2aNTuR4rHQolH+psmm8?=
 =?us-ascii?Q?UPHbXftxIhpPU3jjrE0H5eWtdINBP7hBO4j75d0QRGoWeSQROlySEeE83D6w?=
 =?us-ascii?Q?RmASpSwLAy/mQfWS9GkB+fJ98YP9GNXgsPyQ+4RAV7pxQlsI6rhLTNNs1bDy?=
 =?us-ascii?Q?Dr4RuOcRTAIxDtUvdE+1RJD9aRGbK/8QKS+3yjVgOMK29dNenCBnBAzL+v1/?=
 =?us-ascii?Q?Xr9+7aw3ZqFdhopMUWjXRYkpL5VM3+F4D/AM1NRwPv6h4GLoc0dr6KBLOkFK?=
 =?us-ascii?Q?DaT2hXf5LbTw4KW5L38ZNolPtoKsrhAzes/SJH99Or/tRFDSTMDVt+bxNeT5?=
 =?us-ascii?Q?PkrB/8Sej/sHaytMBenS3eoV62+kUAcTYIdVO7WM5UclRcNDGUoSMqjeSx+C?=
 =?us-ascii?Q?K26H/+HIdKvikQ3LhcPCloXykCY2pr+iKWR+hyYQtZEi5PtE+Dt6G+OSdM0g?=
 =?us-ascii?Q?9OMMcPN+4snjHyoOarrHs9sxSIK7iSFlZwzPVADY2GBB60l/pEUcEjZUDtBJ?=
 =?us-ascii?Q?33F5Nw2R09luTprDMVbu/aOn4NdUx8AiV1dGmKp1XAXAnHRqYNLLHRywjpGs?=
 =?us-ascii?Q?hciDOzPNbEjZfRQ6R/jr9Ci8n35QhQOHqUo8h8oyFOwkfadz3ux6nPL/Ypej?=
 =?us-ascii?Q?yOX+nD89D7U0hCRhwJG3k8OOSXTpbaQxqjGumzpjvbLAGxwKRwqr9DeVdjGA?=
 =?us-ascii?Q?ZGY4eI63Yfx5XyV4kl8jMk6YTcDCUwfPGmPhcbxuXmnUbDcDdj/QHTURyJ46?=
 =?us-ascii?Q?Tu5STt/TmnB/Jthv5yu4ebUIHmsWhRxdOINjT+SvHWs8XPa+QVrutV/W6KJO?=
 =?us-ascii?Q?YGwNye/Y4WSLXyWJDCNbLe8k9wxtN4frq4HvaahC23Dx8pE47xeUPo+BzJd4?=
 =?us-ascii?Q?Rnik20jInV+Mfn5FBmkCXyGQkKiW7e/rYyyfFiz+eA1icgJhZCjTZZkMLtXV?=
 =?us-ascii?Q?R6kfQKik3eWKJ3ULVVkyikVAdALYuztVB0wQAHD3C6imepNhMPdh3vzAKGhN?=
 =?us-ascii?Q?QdlsmxXljRpJlnMpEXUJVNDavPAzIrUIbJNyyJ06s4II5E+CJ3YqoyzidyJJ?=
 =?us-ascii?Q?6LKXBw1yU4Z6WYEeiXUce5aBMIat/zE2SvOF2HHo3y5Koo1VsfoC7gYfJwam?=
 =?us-ascii?Q?nl7LWozKJvl9h05zJzR0VQIfIoo06wLhYYBzYI4AbcqpR1VMPfl4xom0Dpkp?=
 =?us-ascii?Q?KR8B8XR14hN1OtjaIOnADjHMmTnkGECqyBHdWJF8ovNZmizt6VHPNWzkZ1jP?=
 =?us-ascii?Q?UAFYf1fvq4HG24EkIFgnInWTPpSP2lvu/oFp+0iuCbh2DQVJLxx0I3huRzdQ?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6532d1-ff6a-4954-ee77-08dab353885f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:00:57.8617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoPdWW4rK80ju4zc5aq92tX1MVYLEq1b8NzzNTF2psWsYglEelwbZiEoSC89M6GJzewRmeybSf6MPvPA/V2zGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7835

New api:
 - add new data_init
 - add an int return value for get_subflow

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 6 ++++--
 net/mptcp/sched.c   | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index c25939b2af68..0f386d805957 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -105,8 +105,10 @@ struct mptcp_sched_data {
 };
 
 struct mptcp_sched_ops {
-	void (*get_subflow)(const struct mptcp_sock *msk,
-			    struct mptcp_sched_data *data);
+	void (*data_init)(const struct mptcp_sock *msk,
+			  struct mptcp_sched_data *data);
+	int (*get_subflow)(const struct mptcp_sock *msk,
+			   struct mptcp_sched_data *data);
 
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 9b128714055a..6324a8a76382 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -33,7 +33,7 @@ struct mptcp_sched_ops *mptcp_sched_find(const char *name)
 
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 {
-	if (!sched->get_subflow)
+	if (!sched->data_init || !sched->get_subflow)
 		return -EINVAL;
 
 	spin_lock(&mptcp_sched_list_lock);
-- 
2.35.3

