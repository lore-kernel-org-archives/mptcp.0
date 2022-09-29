Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357D31C3F
	for <mptcp@lists.linux.dev>; Thu, 29 Sep 2022 15:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aISTIzpXJAimZDz1WbWFIslA9LxFh5qS7WtRK8OLLiWgXsWw0uY5nOEp2Z//qRWgL7nim4K/Ue7EazAs+kwZtbO/iLaaUQXR5+qvzHtrzS1f7jU0mGM892/LDN8QZ9KQ5Knv8AvfezwbLEqs5FovAkw/QJYNBKOGdP9+zg+fLhbXdHwVenIbgi9dHSpBoTbKV+KLSzPnWS4B+YrM8fVMrEReOB2nPQhjrM05JMVw47WDwl/7UerMG/QX5+dv5Gj7YA1wM/xovn5uLoB15yNWbii+Xall/r68pkaArRzkhYuoIPhkjEqOitQK+aY1Uckzz7IDIVzCCJJUzbXS+y5vpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xi3IW2tgNuFEWgFk25HHuXjCNJgxVZI+vFfnnlUA740=;
 b=DmyEPYO8O4Bxk7sVFm2oiPmDphdFitTQNXTkD4E5qlI1jHoeMbzhn2CfGY9bzKNc2vOzAkC8XwTTg0oL+tTvKbFS48hGJNBwYder+JYFZ54g5KGsy3MmawWdbsNKcJaKqh0+J+yhDp4jms3bf37J8VJCjPMVeq3f7lHPMF58ZTLbqQLI4zqgAvKpZEXSB4zok61+XAmN1Otw8wO7Kb+i6hdvQOY62mPsOKmuGXvHRVSkZbDlDWb9yE7/474ct3tUOEsDvi7A5njsX28caPTe+SVBrG9PSTuUV81R5hFu6LWd48shlDoLpDnp+MtES67Jsa9pZxhGSOAU5a//b4MBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xi3IW2tgNuFEWgFk25HHuXjCNJgxVZI+vFfnnlUA740=;
 b=5oP9gugb7nXwkvC4/FO0puaxRNis452k3vY752VdzIgoZ4GGl9DhOLOZi5Lt05yZgXad2EU5SGhpGulFddKIemP9gktnxWd6fRFrQBix5zzDBjCNaqvpegAbpdeqy/ORKeszfbPbRSJsi1dNvESTaG3KW7fz1EL4TOn/4wQ9YReStc2uBgV2FOepZB6joU8BQhb2ZGpTVOPdfH2xF/Rr6BWxwEsutWKoSLVu2fT2eumeyXIrWZ3xooTVlKA8QMmhqhR2e/DmB3s1J/qtsFRkuPo1iop4JQNpCTAlOUTxhrJIJalhbYShKopO22uH+ae+sw8vFSI+I5h/DYdvGrIOWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9362.eurprd04.prod.outlook.com (2603:10a6:20b:4e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Thu, 29 Sep
 2022 15:02:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 15:02:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/4] refactor push pending
Date: Thu, 29 Sep 2022 23:03:14 +0800
Message-Id: <cover.1664463491.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9362:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3a5d48-0332-4601-e2db-08daa22ba9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lCBHfYiYyj3ar0iTt2fizj+MMvQZLIH+wlcMJvGYbxnCzy5XAWZu91/Ur3gy5dksegOApUQ8ec3k8NlLQm+7+r5oz1l3Dv/ucIx7h31Nd6JCkRyXWTl7duqJ5QCPZFeHOdlAqKMwMva5ubY3dS1h5leTQTCwzMnWpEpKZmXlok+6v04r/HZ2lhplqeOfMfyLdGX5ZtVEQ80W9OhmJEkkeym0KakCdtxpMkden+sM7Ee3EIOfuXAmE9D+pBYK+jcX3ieDNNFGqOs3j7OcB/FyaPuxAnNV37uzANlHhq5pcBqO+zNrc3CLG+GQC7MawatoZ0j4mMbnXCPDsZtrVJha4WAnOdaOoKMuxJdDlisBaaO8AdjSJs/qKi2qqiLWVXud0GTCdiOYfFFKjyOm9pCs+VAmbebm1G5O37mB+ZvOPTV+LgO9F9sed4TiUdLiWUthKO8UXZIXUmbwdiITop+ZOWTzhm4YssxQKBC3DTxMMHuJYe8KKBYZoTg9Y2HK1I0OuMnUkH/sdsNwY/2LbikDX/3WoaBPjU98l+D1sW8rZMEHgR5ASi5RJBgPYvO5jhOBZZne6/R4t6OVGYSDhb841D2h0p5DGKOIyqImlXncnEkuGHQAek34xvphfEPlx8CF4eH01KGLkav4k/EcmwvnB07X8bNtpqk4kfiITwXAn3du6rLdYkwqCMZL8a5WFzUdbqKSWTrUbqM/+XIZtFTqws2bm0hyMwNNJpPbio+qz11BeAlZJ0wPV0zTHiX00yx6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199015)(4326008)(36756003)(6512007)(86362001)(8676002)(66476007)(26005)(38100700002)(66946007)(6506007)(66556008)(41300700001)(8936002)(478600001)(6486002)(316002)(6666004)(107886003)(6916009)(2616005)(186003)(44832011)(4744005)(5660300002)(83380400001)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4HE1z5NPa+7S4mxWGS43+3VGMgo+Pvkvy76M2hGR9BOHqYXAFM1SC0RA0159?=
 =?us-ascii?Q?/kk8WONYI8bxxQ1MUcWDLkz2DGkCH2oDV/ptyLlVsKfGQ6/Oe3STTWLdAop1?=
 =?us-ascii?Q?dPqIE5izUhEH93WbWi736iW2bHeAH2Zpeh+KyZduD4JB06CR4wP7j6ORyqKD?=
 =?us-ascii?Q?uqJve2I6gloqQQSACX5lxeXRWq3NylPaC4zW/zx1dJTmk5yRefNvjie7eV06?=
 =?us-ascii?Q?Q9WgxLBNFePsyL07Nju6Mh4wnhJOMHfFNplcbnIPCAl4T3M2v0yXfYMivtqQ?=
 =?us-ascii?Q?qsgBEbiO+oOCp/U/vCFgiVvEk4q5aRcHOIZ2z4LT2hXkJAHfo/y69kAx20DT?=
 =?us-ascii?Q?xQIfFVqa55A5KKMbtXumv+7YjBxKbkTqpTZ+OBcC1kqNOuVfMM0FPLDW9t/O?=
 =?us-ascii?Q?rAj6X3Kw/YjCBl2Ass/0HhEhALZSNqrTnduxbLFd7DdpBPngEA7prRB+LGth?=
 =?us-ascii?Q?sHJTg7Gbq9bNPE5TIMOEJT24drfB9K+EpPdpNxxkyN96IBHU8cwCWAI7veDy?=
 =?us-ascii?Q?63nKRrc+eZ6T1u3Di076RMic6kMlMowEPTb+oERYywuW+XjGKScXdevdkwMj?=
 =?us-ascii?Q?FeAXaOKAr6GiWku98vndQS3MVbPcAmcQAgc8Ffd4xGtniUusWsHrDt3HN0Pn?=
 =?us-ascii?Q?Kkq1SQlVZ8C3uefkJKPMpRqdzu9I2bgMuYaZkaKVvDOztBJgd9E6tqnp5Gvi?=
 =?us-ascii?Q?/h5+IposrDaRubHvX1XsONRB/nCJyxtFpVFTPEcOiSTxclgX2egKbRxKRKhO?=
 =?us-ascii?Q?/j20C1b3seTHoiiaV6ljwcHfb+qGPW2q9gXQuo+IYjzMuZxrOyXQoL4LVWwl?=
 =?us-ascii?Q?eDiKAp9z9CdOonY+IHwK3jFvru/ypNNp4WLJASNvZDmHoTE3W6N8G84HuE5i?=
 =?us-ascii?Q?GZp4gRUmdVgMcw7kIs/Ouh1MckiHGaa+JkcsrMUmi4T9GPUEZJQDfVSR42M1?=
 =?us-ascii?Q?AaQShI/fMtWF9G23aOiAqyk7N3kQEQbdgbY5FEmai44/RKYApJD4dnxpemmL?=
 =?us-ascii?Q?3VHKWFiKLKjVr78MJ2bVJmjSMbA+jf2i0+vpkWu/i3eMofBDe8GOEUbx0tn1?=
 =?us-ascii?Q?+SrtrU9NhD5K/nqzesCk3drpYOi3fO2H6nWkm2hSFnrsXQ3KLFsdHw+nHmZ+?=
 =?us-ascii?Q?drSjsn0YknmPkGBh5zrdBYIZT+Mj/5fB6TNSOzPFJeDdxVshHNb2MVyJYkcp?=
 =?us-ascii?Q?XZLtqlyd3wpb+LJfRruvO04vRiMXgUMWWTWydpeDhQqjj4a2v2EPLBpcm5Ha?=
 =?us-ascii?Q?QgVLSN+ZNyKoOD+9LRqvA+2NPDrmMQXNVw16Bn2mqlL62nBlw+qwQ406Z4WG?=
 =?us-ascii?Q?ywumKcA2VfrnbBMedWsZ+j2loHF8yY6/OPH6KWoJdyki3XMtnpzSBMM/GVhh?=
 =?us-ascii?Q?6i+Knbe06j+YmADZ3b7roYMf1LsvCzpBaHpSyoNCT3382ABHJ5/ty5gISlFA?=
 =?us-ascii?Q?hYGGJpElE1B+KTFZ63d7RraETeOwZTsqrF7MMKsLuilStwkGn/iFyseB+VJ+?=
 =?us-ascii?Q?NViGjnQKbs3ay4shCGWylRHt1YDFkeUcZ1ytHxhTrkZLwg4LeOsFEHgZfVZY?=
 =?us-ascii?Q?crbj3RjbriMMBucOe1heUT8bm0lHGKLkWcpxTvex?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3a5d48-0332-4601-e2db-08daa22ba9e5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 15:02:44.5930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qw61YQunQYb4QeXmc0PjQeyzpux/n/8a+DeKXcwMZZoPcO/S0QMz3BIEcd+LbF/jHf6JV+3jApG3qg+SaAEgRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9362

v2:
- add snd_burst check in dfrags loop as Mat suggested.

Refactor __mptcp_push_pending() and __mptcp_subflow_push_pending() to
remove duplicate code and support redundant scheduler more easily in
__mptcp_subflow_push_pending().

Geliang Tang (4):
  mptcp: update __mptcp_push_pending
  mptcp: add do_push_pending helper
  mptcp: update __mptcp_subflow_push_pending
  mptcp: simplify __mptcp_subflow_push_pending

 net/mptcp/protocol.c | 153 ++++++++++++++++---------------------------
 1 file changed, 58 insertions(+), 95 deletions(-)

-- 
2.35.3

