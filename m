Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C981813
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 06:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSco+CjYExo7kelug06e9lpTbeVFVU/dvr9ItxcKJVMnc8jX8PY8IsaRmQihmaIiiduIftyU2jDKpvYzRNVqU98N/g0nTsmEXsyoBbBLEWoR/gub/SRIe67UrmX0kkYn9K6nkSnVGB9uZwXIZBIP9HFRj2xK8iry8NPHajrERW05/kyDhUMi74QLFfhUOV3zieS6CSs/FVZxvuLVhcEpFzK31RHWaqNrimtqChEwCBhyAkKs6wgufD0dE00sApl/609JoFVn6nSNwqcrDXDf1YtDypdg+RmSSAKBUKlDSpMpGF0cq6hu6JHpHpHRBLxG74W5mLGn9lVlKKWw2eycfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzNUlyrpNg5EmO3QVHLRPy+rNpsmlueWlUnxkhTlKnw=;
 b=E+VTnYvNFSUf42B3jVucheVUog3eIMXK++Uy1ytL/EOUxaQeJtdV/vNWiMMRJ/3c4iKz+igAhEiAgMDO/E9Qc2G19AqnADChJXysTw4VLHFrV68CVcVBssfUif5mdn0EINLxE5E7AA0z768AYsAP+IHUCGABU/6U4CG/Ea7jziubLDm5ndS6DqJDcMKMjf7rbpBDao1e+NefA4k0JVhBw0pUAhg3gD9JDm2VXGr67c/rVoFOSCpbaVH1Hv1xaY01stg8m1LpNFPO42FWnGkWD97wLHzMSqRgaOYo3mbB7Y/lS1fW008oe12CM7NOtEqOyIkLEipDdO9AHRsFJI0KjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzNUlyrpNg5EmO3QVHLRPy+rNpsmlueWlUnxkhTlKnw=;
 b=M+O9WZbKuWmtCY1RavJ6qshDy7g8S1iA2a/dtJWlo/q8G5j5j9yg9Hol4OSTajX1HDLIip+HDqPZQXt5tNQ2JuYkBLBBLnZZbeQ8a3Bra1Jli1zMmNWmpbAWzIf0tNWwUqLjTSNVQf9MQUS7ykmXTicbzATZdDNcU2BLn3USx3LG4upPa8HW+lI3M43yJy7iLOPPIY2gDzf7Pf33H+3IcdtKMsBwlxnelNnd3fzUL8dFkMlMwTExlnovOEl6IrEjGeNGjRt0wuD3n5bVu+seyFEFteEjeQK5zTIT+K0mUYQ/MbMoI6GSfc0h8GKZyHlh/Ix1lYgx+MxlLSrHguJRFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7197.eurprd04.prod.outlook.com (2603:10a6:800:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:47:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:47:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 16/18] bpf: Add subflow flags write access
Date: Tue,  6 Jun 2023 14:45:15 +0800
Message-Id: <1b9b2849a2413ecfc39cc450b04643c220d63757.1686033694.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686033694.git.geliang.tang@suse.com>
References: <cover.1686033694.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0166.apcprd04.prod.outlook.com (2603:1096:4::28)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: f36616ba-8ad0-4e62-ca71-08db6659d58b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aQeEJPw4fjoMk1ocKrZ2uhQd277sl+u/GPSwjWoCob5pMrBG3TjUkF0njz0z7+YmLMueqCGb0zFkE2yJvw0SXJqM3+f2XObmN2T24ykfElr4pIp/Qj+0mVYidbVw9sNiJTZoYOag0L+TVMe09vboh869xVwTXin1ePX7Y4aD9m2H7rrSEvIlAG3iv8nTHmG1VrPk0qFHDcM4zFC57NFSlieU2SeEqbUWunoO7MJO9q1uS42nVyRYC+xAyZBGnl9/iYK8F+uUtoxSF/7mIY61/iH6tPoVTO9cEeyayhOYOjnhY7dneNhPR9lLPTRbN7r/cMfnZaMuhiVqa7mMPAbCuYeDV9LLIusqt2D1aUHrcduqKUKeG3eVwIAmMWbp3IwMyoHuaJ3kLXV+nK2Ks3OAKbp5CF5b6xgly2yfsDNbV8TSF2sw9sd2fIBwEceWGs6a+w7key4mD41Teqv/n2c4y5wsYb2nWENO88ZFMsVp0huDEaBLb0QoM8WV9VH/P6fo1hTZ8ePiPtQ7lojbS0Ps9CHbJGTtY7KnkpZwBhGP4rxP8gYaxe+dLtMMU/ND7/8i
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(366004)(136003)(396003)(376002)(346002)(451199021)(478600001)(8936002)(5660300002)(4326008)(8676002)(44832011)(36756003)(2906002)(4744005)(86362001)(66476007)(66556008)(316002)(66946007)(6916009)(6506007)(38100700002)(41300700001)(2616005)(107886003)(6512007)(186003)(26005)(83380400001)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?94D7Rvqa8KnRjzAXGxjEWAs5WSeO8/nEZPVtEilJiN4OxeCbud3BCUSsk4JE?=
 =?us-ascii?Q?Jorwe60UAloRiO1jEv8bLR65wdYwM8HmVRZJpjTctLKMmqB2w8r95ksLyoE1?=
 =?us-ascii?Q?R7zihmTlPtlV+AxlAPBPUP4U5WFI55ZwXdiBmr9yvIMkklK0BvuGSmyhPgbs?=
 =?us-ascii?Q?R6TE8t8y4UZ6NHkgP4nAeV0Wf5zJ5ZzzYm6Cf3OM33ekU2iv3xjCQPcldQ/L?=
 =?us-ascii?Q?JQtV0UtwU5k9J7EdbJh6eW74gVq8BRB75St6hmxYQZII6DyzG+Dp6fMxZ24E?=
 =?us-ascii?Q?JScpedktF76woN0qEC1IaSdMEk0X3slrRj65ycnpMRyhQVOg/8n0tHkeawzI?=
 =?us-ascii?Q?Py8+TXTUIIio+ag67f4S+H9nfWqr2TRSx6zbI/nYfNopVoLwfAFX81S6ARVQ?=
 =?us-ascii?Q?spPFYufSk4wg+A9rBxDDXXerr26zA1HNPMiS97nfpl7wgibjM9vGU1fcozoU?=
 =?us-ascii?Q?SDSXw4bROBWCt03UqEAcCEEgboA8zZQjbud7u1y5npA2M8sCiTVjM77gnpNO?=
 =?us-ascii?Q?PChc1IogiBMv0xK4jwDzSqRNDFW7DgjB6s0CJY3uNFlqm/kngg3Cx06B0Ktf?=
 =?us-ascii?Q?bYZ0DCUArxzuDtaJTkkLYjKmfSuyZW1KMkLktQUm+44Y3iwr/qUHC2icD5CP?=
 =?us-ascii?Q?1YenBSXD2zzZk4v0cfzIDLjM80ZdDkxalxAP2w/2nTxhSoe+9XG2z1sn6Hs2?=
 =?us-ascii?Q?BACJX1o0cA2Pj8UEP2jk0O4DcCyfIiP0HGmQkh2ubxPiURWtjlzoqsnkEp1l?=
 =?us-ascii?Q?JdP5CiR+cXKtxALzyt0knc+LrF5lNecoYF5jGTtToB1zy5nfwWcwTGnQuSTB?=
 =?us-ascii?Q?rWkh1Av0wBk/1PPZ7fNBLIbgeGi9TvwS800yQ0mZZ5es/5XJN0UXR97QQ2e1?=
 =?us-ascii?Q?neqdnTH6C4Bs9YPQtmx8mpOeezch8lErZk8FD3+BPyhDZ6NU6kgWtTbevoFM?=
 =?us-ascii?Q?eeKLamsVnlAdihl1RcrvnHmcNCXhMaeSEluuHWjlZnWhJsIFknZwft1IVVTL?=
 =?us-ascii?Q?uDMWFu6z2geaFBN9sBYnIYofOmshKiRWW+ylSbiJXZKdEe+DyrxwLxUrrUX5?=
 =?us-ascii?Q?2X5RL03kIWe9mauDNLw+AJRXYuFqFVp1qJJDQ2KFHT3naGaYNoHNndtbrva6?=
 =?us-ascii?Q?XEybwedRyT/iesrH5blT6cOkZdyr2RihvmpqiDd6pBmAn6KBWH8+a2aqiegY?=
 =?us-ascii?Q?6I2MjYxGSAd43MWEQySCUjUVOwGU/SynL6p7bW2T9hLGfPWmT/gqrfdO2pbP?=
 =?us-ascii?Q?jFhbVjFIJFkgIUj0oj/dVSRqLtM5y0q6DanCgXWaYo9X4BswDAOGJ1C9oxLH?=
 =?us-ascii?Q?yWejWoT4uTvckHI4/Dt5i0PjxxAfFDenZAtNw6u8UIAmrBAxFOAUZD1+big1?=
 =?us-ascii?Q?Vhc5itICZLhUKTEV0i8wLSREYgTMWMc5BuRV6AF82OHvZUt+b0o0nBtXXDyA?=
 =?us-ascii?Q?4SoZlKci25VFMpsf+egoOKmuSef2XGxeP7Qy3grbwc2jghiGMTp8ne7M42kk?=
 =?us-ascii?Q?H4e5zaLnWJrIl/IIfQFjiK2+17z1rnP51NnclaNp3naHgp/IxdHqyVYeVuTW?=
 =?us-ascii?Q?kNzPYlQEKLOeaXDy5rdVn+VNPBV74/4g2QHTNrrl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36616ba-8ad0-4e62-ca71-08db6659d58b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:47:02.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8m3xBtdiD0NGIxTKrbRlnKZgDnLZvBD6bFbXQLJ0eGQzT67bgq33nlIpLIjXfBi32JKGeTHYH7T5VUQROlImJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7197

Add write accesses for all flags of struct mptcp_subflow_context between
map_csum_len and data_avail in .btf_struct_access. The stale flag will
be used in the bpf_stale selftests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index ddcd803227d0..19872e587a53 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -51,6 +51,9 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct mptcp_subflow_context, scheduled):
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
+	case offsetofend(struct mptcp_subflow_context, map_csum_len):
+		end = offsetof(struct mptcp_subflow_context, data_avail);
+		break;
 	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
 		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
 		break;
-- 
2.35.3

