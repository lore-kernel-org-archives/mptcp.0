Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D0E1E1C4
	for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 14:10:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4KJ8lZmuLU+24bH6s2+rTMxlxQhHxES2dpKExqYfZUcvhfhRXD6JXp1NdSGnHpVmn/PTOv83os3D2j46v6TQpn4FRSvDyb9AVaAVW4k3FlS3bfChF3sHTE1/pl7HZ0XoBNpxbEESbwEOjSyXqUh/R40JrQlNFm8Bn+Jm7GWc8bYhTNlDWotvAhT0D0UQchFJnPgOsQ4HLp4SU8aXdN9yZJOT6toBGKfcRr6mJ6d0/eb3vIDzTlwBMsDE3zO8/LPt+34PNw/ZAJsRahvUyXZqVNuY5EixwZI9rgneYYlwCNo3R6Y6nSe9rZJIfpza7F6QJLPo4yEyxoQmg4tHpWwWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXKpWf2RzO6tB9jw8C6M+1NPJmTJLtz2hEaky1EM6Uc=;
 b=ANynd5ZPhrWfI/17cdj8afb2+Gr8m/zUP65ECJF+rGRAEr+CjwIhuLgwku3QOx3pouroEoCghUM2ZfQ9U5rUd4M++su7swyyFoB7xllB99x5t43s182c+JCIFUzWG3trfL2yYFdH42GZ1Kcrr4mxI6i5+EVGqJTMNtTmoMPqUPC0Mo2izSO+ymNLaLDiHR/p8b/jzzhbG99VlOtcj5jXxGq+z+QfKfC29vdKgfEAmb0zbHfpKAT/h48XQLVs1XpdjuXleuqRN4xugG/Jx4c/BDnZOWDmaAoxlLH9hx2EDGxyLSnnsffmES+Ohv7mTeh9Pu2PSIUEiuw6DWyeF8n0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXKpWf2RzO6tB9jw8C6M+1NPJmTJLtz2hEaky1EM6Uc=;
 b=NJzHo/2PN1GvEZpv+uvQLUKVO7rN3RJOg5AZEru6HCcwWlg1BXr0g2eAwey4mLJrO2e6OkWBKWlRw8Gdb20A674nIyeaQhyKlRL8zBQtqiMDfiObRdQViHp5ndIJ3dLi6Vt1ak3Mb/LmwIx4gfHKYvVK6gQbO33AeBvK6ZR/NC8kHA9u9MNPXy7EMgZ/RfA2boFdl44XPQkKEVEBhGFnPzg9+8UX1oInZ7i6+VMqZRNXZcGBBIocZvoJasZOw9er+NBJXe+BSuL6ApOY05GDKnsu1JMJu1jg8jzkHCOvRYyAMegrUZnmiyVg8sZOfqkCniFqsExfUZMBafWmnnVM5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8993.eurprd04.prod.outlook.com (2603:10a6:20b:42c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Thu, 10 Aug
 2023 14:10:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:10:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next 04/11] Squash to "mptcp: register default scheduler"
Date: Thu, 10 Aug 2023 22:09:56 +0800
Message-Id: <8f5cbd0f133388f07f93638578c6247cf50b6e51.1691676509.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691676509.git.geliang.tang@suse.com>
References: <cover.1691676509.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:3:17::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b44275-86c4-40e3-c877-08db99ab8a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yjW+tvL6aLxzowvqY8Ph42mKqSnTVsFlCTadsyGO/8+6BpeIDp1i3GxFn3wS7wZPxJGujaKbqsDTdmkYuBrhdeQedNxgGGinP+XktvD8y7YZ6hVLusmvhyhgGYXTLd9Fg4YLzZ06gYR1hMKqy+xcf1U2SX9R0nHmDTV68AjdnLbehEyG11Lfw2iQLzPcYvvooF9uVoibWVKaWjGThpMwqcmK+iT0Tj9SOlJH+F2nSUUwWUgiuTloE/s5ZgreJMk6puiG/5EA3UngJKSyPkFZjG6HNkTstsKqmObGO23QOkDzzLBsREjoPWOt6qTvA501a1YiGjEPA4y2vdfWfPrkmyct2hcnhegBUyDW4mHS6RlS72cfDJd+UbtwcUrEPGvnGgQaVlQbbPSAw50vw8womH3dpmrfsgY2MNH/irdwsQ0LoA15IC1IGgaGc8b5vdVMscV+4SW7VgpoHL+oQVEf4l5pTgJkQrx65P84PAzIHIfN6Y6pUBGXCJDpOxRDVlH07IFnWedNnj6qv9uxs9CT9uWiElsgNA1UiMzlVG1Q31AO8PotJvvhcZ+6XQnOCWM0RvEHg5ckTjQdNww3IMnjx7AxZvEFfFn5D5kl4wHsruU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199021)(186006)(1800799006)(2616005)(6506007)(6916009)(36756003)(4326008)(6512007)(316002)(86362001)(38100700002)(478600001)(66946007)(6666004)(66476007)(6486002)(66556008)(26005)(107886003)(8936002)(41300700001)(8676002)(2906002)(44832011)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7/HWTskrsg+egdRsvBCmSQMmbTUNdxmm65pUMCvdwe+TuJmeOoje6BtYUGUm?=
 =?us-ascii?Q?ucAoqm9VOy4P9NmCMULyqPMFc9WD7V23SoM7mGX2NFmpuVcUporYgSW/F2pg?=
 =?us-ascii?Q?p6qhz5jC+6NyoYoPxAFZO0a9dsUmcuRDB14ebOo+NcUWR+ACgmcHttvozXYH?=
 =?us-ascii?Q?Hydarb2454WXKXgJijOy9poKWbVZLV5ru8uh18Q7FepDDIDTRnFMNCZOR/eF?=
 =?us-ascii?Q?qjmQZen98r1/H8PxMU7MmVAoEMAIRmpnusPsXz8GcZgBGPQU/CUs/LG4Tfqg?=
 =?us-ascii?Q?2juDh7Kjw/ENG2rE4Vq0LmB/PDgwC7v74hVfDi4eclp0Aqi7et0WPpr4hmn2?=
 =?us-ascii?Q?PsYTwDbaRLOsy7BAHtIbngiSKTescoHvZ4+0ydxsXxwZyOvC2vVYCvUPkzHl?=
 =?us-ascii?Q?nJKP9vQaKfvpyBQ7V+FwAJAoDlet0nH+U05QSbjfkIqZuafqnfD39v/W7Wou?=
 =?us-ascii?Q?NHNLAydKWnVPKkx2x0UTZP++3AaFxJC1SM3DItAtVXapsmJmvMBaUA3MrmMe?=
 =?us-ascii?Q?gAv14Q1wksHfPcCc0Iz6kSeno2KfFASrXeZKixc5kDu8vImgBiLRyDjRdw/s?=
 =?us-ascii?Q?GeiC33Efg2mlN1g/obnwfzZarVdG4YJjpuzCh7ZWZ/INi60CiIMPH+lqAXyT?=
 =?us-ascii?Q?0361gjwTfsvutQ3lARjA73i7fjG5gNUWGEbAIOEGM3bOkMOLmaTNvJ95uYyt?=
 =?us-ascii?Q?OMCP3kb5o2+KqpraL/15u3MYXnPefhaGXWcIrU0ltV0jgqwQKqGRJOmeK4Ay?=
 =?us-ascii?Q?K7C9/7lolF6PKrXz2X+gO9uLKnhaELU+Iqoa49ERi5DDQoYUFtpAuhULtRDI?=
 =?us-ascii?Q?Pa9xyIYRY0Q2B3NMtsJ7eNKMrN7q95tPDm3LA64yYEOTMzVuol9sWrqNNw7B?=
 =?us-ascii?Q?ZffRlhCWgs01SxWX2AHNGjCAnT7WKFSbcoznfgaOCnHK77+2OTipPVcC9h1K?=
 =?us-ascii?Q?qKd0giu7dAKdqS7EyQDGw5iL/NVkpABhGT72re2lR6+BApjUyVHykIgRGOUC?=
 =?us-ascii?Q?W0mozZqFRuHlPYE7NTgD5apqw0WEJ6HNy/QRh50TK4Iad2VIh95bydRYIRl/?=
 =?us-ascii?Q?0fU6ALSSO65yPO9eT8oO4Ukz06QPqaNe6ZYqNVHmAiAP+NZZBt1WAFx9Vhtf?=
 =?us-ascii?Q?AwOj5xCc/ADLAv97Kl/ye1LkCptNhTSy0KB6X/6pkvbgE5ncCU90NyuH/C4s?=
 =?us-ascii?Q?/AHF63mSs+7FRmfZyY2c++vnrS6HeBGT1e5M+fDXgh4mWFmkROKF0+A1pm60?=
 =?us-ascii?Q?jHQt8HXAqJCogcONJUM40aGusmRCsFXmFNVFYaGF+9sl2uy9Frk/Q/c8zrh9?=
 =?us-ascii?Q?qW8X2bCSyez6UDQYvcQx3W0R/sMxnHff4L5tvED333seCgBxfPmEsk112cLS?=
 =?us-ascii?Q?RIIifoecqX/15bPy555GsS4cVAOqOPhgrmK3XiyQEHbrH7m/8D4L/8xzjw3m?=
 =?us-ascii?Q?0c2nlw2FoYSiIDbpnQzY1dgLwzpzGFVRknQondgdfcws+sTA3ToiTxdsbeH2?=
 =?us-ascii?Q?nE2IkAVX+DwXxEou/KSRuLmlELlgkm2y15NMfEVrcDKfJJtSseJCj5SdNC2K?=
 =?us-ascii?Q?2P4rUd6Vgwmje+oL8sg8DJbb4XNdC/p8s7GA4naI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b44275-86c4-40e3-c877-08db99ab8a36
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:10:24.5794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iotzZZ4CRZ/P4KZiufyadwjKIb8qx7zUND75G3hr5yKbBKCaFNVl5t/gTv3DARmPWLQqPSwbmhR3h7fO+wB7vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8993

Add .get_params and .set_params.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index e96f69762071..6e07708b80d1 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -35,9 +35,26 @@ static int mptcp_sched_default_get_subflow(struct mptcp_sock *msk,
 	return 0;
 }
 
+static int mptcp_sched_default_get_params(struct mptcp_sock *msk,
+					  struct mptcp_sched_params *params)
+{
+	params->snd_burst = msk->snd_burst;
+	return 0;
+}
+
+
+static int mptcp_sched_default_set_params(struct mptcp_sock *msk,
+					  struct mptcp_sched_params *params)
+{
+	msk->snd_burst = params->snd_burst;
+	return 0;
+}
+
 static struct mptcp_sched_ops mptcp_sched_default = {
 	.data_init	= mptcp_sched_default_data_init,
 	.get_subflow	= mptcp_sched_default_get_subflow,
+	.get_params	= mptcp_sched_default_get_params,
+	.set_params	= mptcp_sched_default_set_params,
 	.name		= "default",
 	.owner		= THIS_MODULE,
 };
-- 
2.35.3

