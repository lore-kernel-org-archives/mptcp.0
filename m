Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2073.outbound.protection.outlook.com [40.107.15.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162BA125C0
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 09:02:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHu9lJc4B9YStBpMQf67+m1cyRQjRs5HrWTwXaVCWH+JkhT1/EoPeNjd68+aVYzZAcCu+TfQQIJJjsLnMDDSsmCASTd2ldlUhYtTrzVF0N3dwpdA6VSiu19Tx3Ir9z2fRbgyQegsW8JulAAkfcHz+O++TRVN6EUuZMac+zHjjMQwVXIidhp2xVsd6swNql0xSZAe5wlGU2kbG6zB4w+9E6R9XFhrp/HgG/rSshnRXPVb1vi28E6/PtcOn89jrqDGQzviQ/MKbiAyokeCiN+d4XItjWwmFhMKOPTURMnyA0f7LKsnxVbCm+mw+ekaZd8qWQxsY4UGnBH45iOvX/zlvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIScZCYOVQxn0NnzHdWJp/gCQ41x6fLhNYZyB/4oKo8=;
 b=U8nuqGLxDf31f6RzH/aEzAcdiiLEOwiuWFyh/6YOgbIGml5URK2RVfqL7DX6J5XMKStDMW0/2ksb67H7dCtKmFvgYmemzUa5C8FMpDq3RepYrvDhVZ41uzZXS0Z96okw6an1wSzxXqfGnQc9nG5+FpDlhqWA7evlO3YuukfEEaEowOr/gKQri6Mp7GJshXDf4rKIG5Ify62wuFiGt60TS1Q/JzPHJgdz3bhP6Jd3SSx3LtOm3NJLZWasTBy7sVOJGx0HuDsIuR00w6gd4ZNVC3mmdLg+flkdV1YvF285pfM44/giSGjwzfgCVFsRxf7itTpS0gVpzfqRUc4F6fHhxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIScZCYOVQxn0NnzHdWJp/gCQ41x6fLhNYZyB/4oKo8=;
 b=35MF6Zmuq1hcDScxULVxkNcvFiynkUpYCl06smOLU0DoTVWzf2CbpRKwYMA2cnTIf1MD7+65jIanWTEwy+clXrqSbYxWjfEA85XsH1TSVgS4SjQg1AIBg8vO+yfd4v3jaVVW9Qcunrl8YEMGN/YNkdGSqUcoOl/9LAfbL7CT7ZYc00s32x+EGfDJfJqTBfn0gbzam7wwaHtXGVD1S65e+7t+1Te8ujBgGjkNRySpdMsJ+MG2v4y27Jp3ujTEcQymP8FlV1rRMRlTR3YWZGyiZQflhFCxqvh90HI3/0HwXzEMM+sCzd7fzplAlso4Gk7Tsf6BJsnC/GBCcv5AlPrFSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB10059.eurprd04.prod.outlook.com (2603:10a6:20b:680::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Tue, 6 Jun
 2023 09:02:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:02:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 12/18] bpf: Add bpf_burst write accesses
Date: Tue,  6 Jun 2023 16:59:26 +0800
Message-Id: <972ce6e4c0f93d1fc02fa202bfac01c38c681623.1686041504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686041504.git.geliang.tang@suse.com>
References: <cover.1686041504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0205.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1af048-e18b-428a-436f-08db666cb4c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PbF02sINmyxHdisXHVwx2Av0Q/nX/mwF1DwkZdkKTD5pp1Aev78bTOFDJP9GEEf+EgND8HigDpg8LytQlkYJ3CHfUpvG9ZdO2jvMdqwQnh7fjG3MOZC1VjgucSupWD762a6Ks3frRQzwOLtO0lj+IW5E8Cpy4VrFvXDw3Qbt4YAlq1CZsGMEW2vyOcthh1QvxXYzMjjKsDGsFnurbQdiLjYbd55rwOorR+5iOcsLDMqR6ILjxzvKi4T75CX4XBZ+kPE1nss1lkmPuumpNmD8qzZWkoegxuQ7om/8T/pt+OigyLtCkRTv6UD+n2OL6yPaDiIs8uq7mTeIoT6tX03okhbau7XiTNy3AfgyFnl+1e2sTNZKQuqhfHoPF2oZr6EU/uSDs/hM2Ij/KzAtyPntM7LWHMdZDCzun2kIewBVM43+oYiTR7tkMO22+XfxY9W98PKaTIT7q1t2ZBGentcbGkF8Cw4tnH6cQcJRADmWWVes+eTzM5O55r+w8sFKJf9khdQbWdhlJaciLC90D8Gj3ccdWo7nGdn2IT9aWPF3uDC1lcGFeV0jKEjvVqaGl8To
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(6486002)(38100700002)(6512007)(26005)(186003)(5660300002)(83380400001)(6506007)(2616005)(8936002)(2906002)(107886003)(44832011)(41300700001)(8676002)(6666004)(66946007)(36756003)(478600001)(6916009)(66556008)(4326008)(66476007)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UyXtZhqHAfkHXM0caUDPzrMiBhhSzdohA/Y9qNp1Ah/Y61EdOIVqX1I053S3?=
 =?us-ascii?Q?rHRQT4Ge+SaZpXPvhkFtvWL5VsL7z0+VHkc7YyJoo3D7tdDP6GqssjjvR01S?=
 =?us-ascii?Q?dwK95oz61vutI0tunBWTxm/WQr0JogNOiDARUbx/xVIb7K5ECzBjWPmmay8P?=
 =?us-ascii?Q?j6GosqO66buKZsCb+WuosiCTL5m5jdcmdpQPQRVCsQt5ZThWt2h3M2CVaQZm?=
 =?us-ascii?Q?aPAcPeADZTf0fkUM2M9xXSuMq+7Nxs9bIZ2AVQKTITi4mj+tNjTLUCCU6wxB?=
 =?us-ascii?Q?BEr0En7ccr9x7HOkrPf8AEEF/RApUKj7KC02AHBwgfAxZ+q72tT7iJIKaMh5?=
 =?us-ascii?Q?fEO4GPRkEFvFXcUjt91xwpufTV/5AtDqfM9OJEysvfHHmgRVtywUqqJEcVyV?=
 =?us-ascii?Q?WundpEBAtF/Q2dTzk5fuUgJVTchzfGMHj0qs9d3H2hpvNmY4rl/OwLaDD0vy?=
 =?us-ascii?Q?OiVrZE04CO2enTZBwiy570LCI113q96U/y51SgmrbIoU/ZvjW9kkTwMOdbT2?=
 =?us-ascii?Q?fAhFzXYehz212XkdmRbCs2wJPj9XHwdu48mR/wevWNGxLq4h6Ij/QAeE3Z6U?=
 =?us-ascii?Q?6v5CrlmLbu5sRs/sp35Rl2ZebTBOoldXPL01G3upBgyTmrhj0q+hPlc6H6QO?=
 =?us-ascii?Q?0pGWP3FZlUQxu0hXEnKM6yanAv2PWOYSrEr5nLjzj6c2KjLSOOyBP1Qt7m/+?=
 =?us-ascii?Q?HBgHI+snLqzR5DExjjrpz7fM0kivEzjyiBkDulgBo6qyowoG0gw/k+uDR4Vj?=
 =?us-ascii?Q?804tQyGldVrnyiNFAXHIEe+Kqs84ISOl23JOXZ4DV7xc+CLvxAEvVr5fARaC?=
 =?us-ascii?Q?UTg7geB4CTVMv7C9NPyImVLxJ/6rv1OEM92uYj/RcdYCxIm2IwpyfrIOew6I?=
 =?us-ascii?Q?Ih4KcQbrlAwhr42mxQCmgP+j7f3fwf2dn3Q9MaE7k4EpMc1tZRA61mNr8dXs?=
 =?us-ascii?Q?vjNVGyDXZQ16MwkNCuo2XiP1TTpHkMWLk0vk6g332FylH1aVcq7osg0Ahr8A?=
 =?us-ascii?Q?3MhHUwyEr2qSXYeot2lKSm0PiuhfaSZOcnCfh5M2ESBGog7U65PWMi+4IRIT?=
 =?us-ascii?Q?9uHmrf66Kg064LdG2TisbGR1+NsNQWDsar8qNbBVfUXRCOAJY2jQlpLVntZE?=
 =?us-ascii?Q?HM1Rn7/AQ5FAr3tY9MR3pVnDnLvWcwhVYbZ4CjA+eJSgNj6Jrbtx7UF0gkRf?=
 =?us-ascii?Q?tt03qIeM3AiJq6Q6K9GErhDZrECdZLcQ52oYD859z/z72Misk1sCcGVo6q5Y?=
 =?us-ascii?Q?HGmoA00GusCkZeGc+PSOfU0JAyBv6nW6KSH85CD3yJ37jcTIQeb0go0zlgie?=
 =?us-ascii?Q?teHUb2loxUP+mXKm2J+ctES8JO2ef1mE3y6zkg3gBhBn/1B/heKh2w5RABAX?=
 =?us-ascii?Q?Wnbh389q06VV5dkoJW9gaBSfvWAejEYfHvUuA8dbYRS9EFYueqawTrhUjUg9?=
 =?us-ascii?Q?X68P+ogezuiH88cCNgX0fS+VwOkSfSBrV4i2tCKeF2xi/aenPgy8zCBYgRYJ?=
 =?us-ascii?Q?0LUkTLp3+F0i3AxZwqyPFr4Z2zrX7c6hXjbkCiXz3epoASgro9BmEcxiwJBm?=
 =?us-ascii?Q?1yIkaBsRyzHkQDAp6kqCQU9ktY8zDxqMCOcAab4D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1af048-e18b-428a-436f-08db666cb4c7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:02:08.3086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YANSNB/KGY3HHtCO6Vex6tBobn5Oi9CmB3zVvR7sfMMDRF9WRxQS/sZV37YCHVjGaaC7yN3tiAkd0Rltads4Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10059

Add write accesses for avg_pacing_rate of struct mptcp_subflow_context and
snd_burst of struct mptcp_sched_data in .btf_struct_access. They will be
used in the bpf_burst selftests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index cea6a8562f70..719d673ad346 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -51,6 +51,12 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct mptcp_subflow_context, scheduled):
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
+	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
+		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
+		break;
+	case offsetof(struct mptcp_sched_data, snd_burst):
+		end = offsetofend(struct mptcp_sched_data, snd_burst);
+		break;
 	default:
 		bpf_log(log, "no write support to %s at off %d\n",
 			t == mptcp_context_type ? "subflow_context" : "sched_data", off);
-- 
2.35.3

