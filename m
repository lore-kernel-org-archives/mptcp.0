Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2078.outbound.protection.outlook.com [40.107.105.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0BA20EB
	for <mptcp@lists.linux.dev>; Sat, 27 May 2023 12:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaQkgFLtIyiJwT76MzxgMnGL0zwW3vAzSW9Im2+3H9Is7ut5H5oiFQNDMZfHrFYtgAGqxIxcJAJ9mkBLOqyx0gkGCSW2GbZe+0oEjNYMHeV2TiBXmdHv45F8ntq4KFeL+66Q9AzvlSrnYE/hZ8PJegEjnRjsqUO/meT/HZb8YYf2m3XzMYP/dwEcjLBEMlt0pBEzzApRpvIJeRu8QyMsyPMEpg6hhhpzHYKDxVD/ZHXVOwk3FerYyYcBom7jFuAUw4P5deC3/KhdWo+CvRBEgQnW9CZZDv0AAZY7yzNqzfPU6h/TpW3iSjYert+VrQUvEzK8w/TYjMSUr8v/IKUEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAAXpxTwQ1Zi08PGAKLlb0QSz/kVoLq/lZtYIFLzxNM=;
 b=RmK02unA0Elnsliad1N4jMZd2QxNCUEt2nriHqSr3n04DaENEifKNlneC1ZDCKX7+Sn40V03fa1R/ATn3HuRJ5j9IVDmPeYzfXmsWiRIfYttUWFY0fLf+3koIYmrjWfPCzl7cKFGNli80lFSWBOMmpW6K4hb+5Xu5JqbBg6WXtvRX2Dx2Ut+KhRFpdo27LoSWR0/94qjEW0n7rQWrs7cJeegUNpDXX7ugWM3iaKmumCfziDvMemJePs0xUMP1+PtkbHA2myf4wW5oRiB5rEqcjq3QKxFjMMxONP+QqCBxPD5Wp1ANGWYzVCtJGHT2OIqdMqvIG5Y6liVZpPaep3Pdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAAXpxTwQ1Zi08PGAKLlb0QSz/kVoLq/lZtYIFLzxNM=;
 b=eypVjJnwUVB8hTq76+dK9iagz6rwFvNnYMlDza3UyPQVxvtvbrxddb9eJXTbF7D5csNYF5El7foOIS1WHSDD2TRYBOvebyf3jzmEUubG+MZIazKyqEUvtZB4o4wJCW8XHLk82H3yXGHOn/9DWAdHAZUNGNHwrJdjorjblEX0/DDuVQr585RqxsET3+N1uhsPZFlaqtzXeBGPcimhefx5bp3emcSGZgW4OewsvYRIJhSlZJBFldpgmS7XrdMLsMD4jmCEy8xPT7Sm7tMK4AeUG25FsyDQqZ7Kl8Q46eOvuudgMTmmouJ7HhRL4aJ9+5s2kXaGyJMK23EFH3ud2Xnj2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8371.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Sat, 27 May
 2023 12:56:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Sat, 27 May 2023
 12:56:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 7/8] Squash to "selftests/bpf: Add mptcp sched structs"
Date: Sat, 27 May 2023 20:55:36 +0800
Message-Id: <4a33b191343c7714c92c0ea7b7fe406b80f9a978.1685191581.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685191581.git.geliang.tang@suse.com>
References: <cover.1685191581.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0206.apcprd04.prod.outlook.com
 (2603:1096:4:187::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: acf3a0d1-cd0a-4316-69d4-08db5eb1cbb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Rp+NOJRVC5jD6Bh43gbY8qzAvT1CHBvt/wo6OyeWZ/mkMJxNR9tO+CBYKBNDjLiG929ZTJLymE92fOWfDx9GXx+TCKya5JK1sHWQNkDa3jp2zL9K4+LbqkUjBhNEz5ld7R0CgwchoPF7y7iy0snrhn2mQXQUt7Bd9gP+VOGrfi03pUuIiR3CAdqjDR0N1WeugYuhoNri8TxA3PYcH00XYH4hk81DOHz09RbrtoAMulmZCN9tA4Fye0ATcUmULFP1prHJnw7gX0F6PBlJdNrKHMYeijY1v3hxE5SrGUWELuqqbk/SKnAJgKdHgAlNzDxVT0oAzvqFyJOzs5H8ODl+7gQKPlelbMoRtTb7+2h1B47kqXvoVmflGtf3/+tnrtelE9mBd9wsk6uWgxM1npu01TTZwc8VxeNaS2RgFDqjX259RmVRHRntsDTsHaF0XZgMrGUmYMfr4TZoLZ/PtpMhw6ljh0EC9vDT8kCXF28tpQN6ULfUdf/VqSE5rkp+RYmx7aCvEMNklfTg6PiqLxA6WTtcoyH/JdsUBEb3XZYWlPMHPaqZwZ5l9pZ8fTKtgTRE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(316002)(6506007)(26005)(6512007)(36756003)(66556008)(107886003)(44832011)(66476007)(66946007)(6916009)(4326008)(38100700002)(5660300002)(6486002)(41300700001)(8936002)(8676002)(83380400001)(478600001)(86362001)(186003)(4744005)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wEzPfZ0Am3c4SE2sShjRBGks88yPtnpnqRvJ4YIYzAzPiCsk15ZrhBJhNzr6?=
 =?us-ascii?Q?lf+2ShbjYvDGFQEov/p+bfW9ej71gunD+B0SiidG0kP8wK3WnrUOW4Sdu/hY?=
 =?us-ascii?Q?zZnao9/s7lnUIoXmCcGMRXMQU2PagrJ51gjEPscULu7WiKJJ9Ik18vxp70q7?=
 =?us-ascii?Q?liIiGUCy+Ph3uN/eTyrhOYvdEI/pMVN+YxT85Bos0io0TfGI6TZefuTI8+Tb?=
 =?us-ascii?Q?mhmZg+0f/C8C2jMT/Pv2Itl66guHDD5P22ZU7VWaxg4Ajub/0vj2ODQvqMfK?=
 =?us-ascii?Q?jDXXBFDXyVOoMNCeWprWENA3ghTZmzR27h/e00Rv1F85iVrJXajK0icVFGq4?=
 =?us-ascii?Q?H6v47Mb+aJEUfaL00N3bzm5QwQRgcuBGO+NbBPztP+Z2e58iHsFgIm82lpUv?=
 =?us-ascii?Q?UjNdK/vEDvVdtU5nFxNFedjysKRHTQ4vrqYZLr2GF9KeoDXkGS80mJTkc1dn?=
 =?us-ascii?Q?msXaPta094OeS/bw/CUA3KLtyu2oOrmgYRlpIU8nwXIZqiUX4DtSwsoPJB7Z?=
 =?us-ascii?Q?FT5GLNjR7zYj090Ot/pCWJGPi5wkP0p+ZvxXaSxNyt5p7k1ylUBoF1D/s7Jf?=
 =?us-ascii?Q?qJpV4pW4xcv2PNsYoW1CRuc2yjYbpSZ82jumqNatfc4eHq3KI5c+e9gjZiwJ?=
 =?us-ascii?Q?slkU1WP5SJPtrokSZvFS1pCjMJCKLev1WJJ3I/+AI+mXuAcHtbAuoklyp795?=
 =?us-ascii?Q?Z2tFc1DqkAnW3pqt5lROU7fLLSiuDF0CKe71XbJyRYeg9qHN2hGXWi9RuoqR?=
 =?us-ascii?Q?zLvj0hvzM7jWl5OZE6RChj1Si/4U3YQ+f+hI3n2WJmkOTpFzuuXNpWqxYVpS?=
 =?us-ascii?Q?frV3yeub3P4wNzxEUioPxiG6uo+4juRYGSOzoUHO0xqLGAxespLhp8zdTVxm?=
 =?us-ascii?Q?grXlXZNX0Gv41gkRp7sprllPYZJAWHsNEl8f1HKMHqVzHn9L21OOGN6mWGJG?=
 =?us-ascii?Q?+mLvHFm6bpNBP0w6WKD6KTTr1/jJPxVwhwAFP0+ZAtpRD2CwgDb/F4nxrMFA?=
 =?us-ascii?Q?M9MNSFV6v0zIx7Q+a6beZN5tTRDs7gi/u8Z3D9LvBhUQSBEZjSY6lBodnmB8?=
 =?us-ascii?Q?7hn1w2q0s547TKFOEbNC9Q2faxP4CB19R4GFTod8Q9RUq7LGYRVDqwUiv/Xk?=
 =?us-ascii?Q?y1M5gP/iHvNnZtGR7XvhtyRsGhGrKXTmIRnObJ4cVn+em7WPEuOEXbl8Y11R?=
 =?us-ascii?Q?xO+9bAH6fsaPkx34H1tX10kRNMKTyelZD7WDFeQQGEAgPB/l/3J1XIo+smgo?=
 =?us-ascii?Q?F1/VHYMHKlHxtwQ3WBQ6ZNY6i332VhQmuIvHuorqN+TwBfJXdB8YBj5svTSI?=
 =?us-ascii?Q?0oakD0CGqJNCppTl9BUn0W6OU/koVFSkGB2UJgoac4jPMa2l3+Vj/SvIcnt/?=
 =?us-ascii?Q?5CFPZJy7qVg6Me7baKVQ1TmrWj+OGEhOsXm9NEkFarcHbhXLM7txC5+Ah7fy?=
 =?us-ascii?Q?mOyEIrVB9XFiOQ5XU5uoaob9fVrgXvqi24Vunt4Dsv94VE9vwce/puccD3iK?=
 =?us-ascii?Q?yydiDuLS5S73vLl44f9Lnsjwlrd841ZUDxS91iSBuh4bKF8qFgoABxi2yL2N?=
 =?us-ascii?Q?Cl5yhIY2nmoUC99sT+YlU1usoS1WPgKBSVN2rF/N?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf3a0d1-cd0a-4316-69d4-08db5eb1cbb4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 12:56:32.4521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qut7t7tIPLcykUnI5jPXF5vYF5L3QQh71lH3TihriAjD+mqPZjoJ/YMgCQm9YydD1w2JBrpg5YZiFhgtfxDy3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8371

Use two tabs.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 72c618037386..fcb023a749ad 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -239,7 +239,7 @@ struct mptcp_subflow_context {
 } __attribute__((preserve_access_index));
 
 struct mptcp_sched_data {
-	bool	reinject;
+	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 } __attribute__((preserve_access_index));
 
-- 
2.35.3

