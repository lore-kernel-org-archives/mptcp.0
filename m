Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428FC628
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 05:49:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYlq6y/a+xtOTbWsnY1SPrxTRJIE6YUB6A3tJsthdjOGRCOPv3YzTQjPp6M75CBIWShiIVs4ouOQFXXHTipD/xQOZ6ZbEfa48P7ol9av9tpdJVvHBHe6E0Kz5wM4hRFSdmcvzfn7g8uX92KWcDNMCkKs40rU+YBk1eKGJ8CaGYcSJ/Crm8Y+eetoJgUXthxXzBjdcE7tnL5p+4U/dCzZF3Hyf9lwrW7pbQ/JL9x0K7k0Fc1FlfQ2rSoMFTBMJRr9y/IYOdZoJVfMHCNMVUPVhJLcyYKQCVW+YXLCK+JBnqmbTmLdlA6cn4bQiE1ldXXZNU9fCdkdWv9RmAYwU0sGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXpptcw33x18TrU9F9XFHKwWzNwMokvaFf+Ujo8czss=;
 b=RZ/xJH7xzwu23vs9aNWz+e0E5z0PIQiezW/LBZzzsVdlCFnVXziOvBwk2ejs5arJPjSZPfGP+VqHOK0VaAazdXRHU+RkYx2g8Dmd+U3iZmHmaG/cHszmfWxUJ6q5Kj0HgGdlSxtvaQliZgSFE2Rk89fYLI1hVfz6jzQ3la8ewQgCTApuJdlYke2LpwX4+av6Z1/RDAvw7vYeo8Sww1uRP9GB5rdpdE81lOQhNE0aKmUgaM7VesQEN4B9FdGxe/GaKtF1IyiN71LPF4KVgE0GWs7lCdkpnI60cVN81h1wVCMEsenWM9ei7mVi+1p2ot1/3J9r63B9voCZs9VL92PC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXpptcw33x18TrU9F9XFHKwWzNwMokvaFf+Ujo8czss=;
 b=crHBZmY0urqbCLn5XAE3zbK5cR18qozDqVYgVL1roqFG34yxnth9xH93apKdPETSPOc+Li5Zx5zmN9m5oO4Yjtn3q34SN/lkf9MrWVRsGwVdoRg5lRcPEGPZYQhAJtSw/kFPz2k802is2Sylyi2qgnCHSp6eTrDRMf9HwEGVckYO0qiYWysysjwNtn3FodhWntlb2WUnV4sxdoeqC0KSVWcYehFGxVWLd21sW1ERTGTbGLRNyiGVin7dYjKcs66OPU799Eiapmwf/TBe/Unq05StuD5fVxvFvt4cnsyDKfx0jMg0MtW+ZygWLEuHqp72KUgSGVK0cHa/pI6kJ9Q8aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7600.eurprd04.prod.outlook.com (2603:10a6:102:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 05:49:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 05:49:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 11/17] bpf: Add bpf_burst write accesses
Date: Thu,  8 Jun 2023 13:46:49 +0800
Message-Id: <79e68ed3fc20d62e541e74b1c97d1c834e625b58.1686202841.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686202841.git.geliang.tang@suse.com>
References: <cover.1686202841.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: c4342252-1d8e-40fb-08fa-08db67e4100f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5bXNTjK+3vMJyDhsQ2c3Sf+c65XgfTGhRaYb3wRruVrh3Lrgeunzb2ipMCw8GKsl3ycI4BwFvnaKqyWsLUvFIts2zB7IpRpkhTn8UEW9zvjype3T7rM3Rn/DTLZrOvLoUtGi/jEI+4p2ghFjaa5AMcsyHBDlMXYRDYmBj+t9BWM53+ld1Jk/m+CYgQKobZ0AYqKegKwqvfUdrpAnzJJr0x5kTJ4XNkdzrcQA/1h8cjcY2HdSrPqRNyc3ZBvevmhEAs+Xasvaolm3f9A02he0QRTS0dfvnWbCIKchhKHlCaME7nXtBHpcsuKQyO4VnwpV5p1mm7EvBvdNJsMJbmOVNatddA/ezQ4SurZC9TNEg4NeiOIJzrNSEgFMkHkGf79g4gi12jRJ+9loNI8li70G8GiJbi1+4OVEx0h63cGTWV3/ao/9R66THM6rIrjoZ3QWPJeLdLEjT8g1gvSe/xZ6xT3pUga25+Jnhxosf58fnknAXEwoCv04DXlW9XMWiramml/7s2DcSdR5dE7VVBM4xvtV6YVjc8S5uMIu/mDkg5738WZBcFoIkCXczOZpTS/o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(6506007)(6512007)(26005)(107886003)(36756003)(83380400001)(86362001)(38100700002)(2616005)(186003)(41300700001)(44832011)(6916009)(478600001)(66946007)(66476007)(4326008)(2906002)(8936002)(8676002)(316002)(5660300002)(6486002)(66556008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D6aldpSPb1KmuZxd8YaA3BTOOj6CO2w1YtWYOG+k6F8LJ1ty2hzdGOerbBs/?=
 =?us-ascii?Q?QUu8/RxSBUsMv7KGNlZin992UpXkM7/DFngLcldRZQPKSgoUEOB5gvXvu1sb?=
 =?us-ascii?Q?KQkB3ee93BXf8YYK3/hOEX3rSSDt+KjcsCWHtD6l0TICS73xMv/GTsM5xHBx?=
 =?us-ascii?Q?XOSyTVFLyCsRss257Nwt86NC0pnpd1PJYYl/RV74RsF7gSaLFi8Lmjr9uIvn?=
 =?us-ascii?Q?0hoDyLFecdylMwGJZuWSXzl1zPctTF6KvDcWTzWjF7LxJCM1qb4yoLk7f0nI?=
 =?us-ascii?Q?Ms4E2KYvw2H8GDH/Ffi0RUiAXE46pbfBRQVr65wk/RFS7hwFXQsuLPDs4QcX?=
 =?us-ascii?Q?tMOsuRZdQsR3i2rETjOcGJi3LbLxtEk55gUjJ3w0MPKRvaLG7Kph/wKUBrVz?=
 =?us-ascii?Q?JRBfsudc6B6JulozxmJM5Ns1eVQQpmyMLnUOU2k6dIm92HFmkTjYdI5WDZWX?=
 =?us-ascii?Q?38ggmMFW0MZ+m1Ht9xwepfrId0g1iC/Y1AG4l0udaunRmbu1jP6sHaHIIUKq?=
 =?us-ascii?Q?WPcJVSp7AJVUJCWyXMUKgFxku3Rx7MZ8mYK9kW9SB1NHEl73RKyGFXf7MKsT?=
 =?us-ascii?Q?3go/YYaSZb30CW1NVo7id9eeQlxEYrfDBaqF7VKeMXUt5poUk3MAJdIF6ubd?=
 =?us-ascii?Q?/YKi7Ok6T9ZQzegoWTMonLq1J2fQ1CA14pVOX5nQZw9gli9TI2igzF60QfzV?=
 =?us-ascii?Q?0ENMKaEzEYpwVABGlc7c3POYjyzrlRD07vNL8atUybWxoP1wSM05wR4ahynJ?=
 =?us-ascii?Q?cM+DpqYt4o8GgWXCv1HH9ZwpBHNkMXVrd2/D/EXehQeG4ESlmdulgwIkDJGf?=
 =?us-ascii?Q?+tm4lGgiMBogg4P+cAOYZNamr7KkI5p48If8LW+7jv52QvZfV7EgEgOi6DPm?=
 =?us-ascii?Q?dVBSJH9FRSv3Ic2gPUC25/xvvZupZUczEcFrr2ugsPSwkN+yG/wi9PZ+QhTv?=
 =?us-ascii?Q?aBL/ZRpWRcizSL2aC+R2texw27FclwkqrwmBJTkMHIkK6joNqE3wReJZ8oNL?=
 =?us-ascii?Q?x5YvdC4kCCqkk8bpD1z4v3kusgmjc+RZqtut21tFIzU/S0thlOe+pqpQgrCI?=
 =?us-ascii?Q?bATF/rrEAmL5DAOU11Fx7qiGgPuhRy8ETbjfV+e62uLqEWJY3DuVSiFf8XNR?=
 =?us-ascii?Q?vrBJmGf9OFWoiz/sRQh1/n/nBLFG0Jej8mfUkAqCEdWM501j19UqPTOIyo3Z?=
 =?us-ascii?Q?Ts6+0hob//XZoiSpoU/IklujEZaDHJLhVlzO6PpdyR3h3eqOwPy2r8fVXvqC?=
 =?us-ascii?Q?iXhoc+Owt32ptsd8dCsqkSFnk34IeWm/r09ZpoFIxxp1tDBYL4C8xqR72swC?=
 =?us-ascii?Q?q55e7Gc/hsYtU8+r6U5sOTZ2ZY2H5K0gCELDonee1Iv+N9T5l0hhFhZa7qqQ?=
 =?us-ascii?Q?9iLLyvZimiLWggxoiyS0RdMKl8SnUV1imSJc/g/jppyx1Hor4namNlN1PxXF?=
 =?us-ascii?Q?qDp6WMNQo7kbyC0IPKzXPYuYBJ3Nt7GMJpT9V80VH0vq3DbGqPQMBPHPqkAZ?=
 =?us-ascii?Q?9pH8vIOTQVb5UWe5oOf4qib8NKWNTuHFSxofDCJlV7hPLiQCmp1jhyNRIwU4?=
 =?us-ascii?Q?TusZP9pg63xhLAAQ/J89jojMgpWmstMH46RSPANe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4342252-1d8e-40fb-08fa-08db67e4100f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 05:49:02.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQJAaxMEdTs8P7mVNi+ZD74NT1/hMJJilyWb5jgM1rtpjekboT60n1soz2JV9WEm4m9aT2nzvP8a+LZdCvNO7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7600

Add write accesses for avg_pacing_rate of struct mptcp_subflow_context and
snd_burst of struct mptcp_sched_data in .btf_struct_access. They will be
used in the bpf_burst selftests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 14de8f46b5fe..9c52b2d4e609 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -51,9 +51,15 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct mptcp_subflow_context, scheduled):
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
+	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
+		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
+		break;
 	case offsetof(struct mptcp_sched_data, last_snd):
 		end = offsetofend(struct mptcp_sched_data, last_snd);
 		break;
+	case offsetof(struct mptcp_sched_data, snd_burst):
+		end = offsetofend(struct mptcp_sched_data, snd_burst);
+		break;
 	default:
 		bpf_log(log, "no write support to %s at off %d\n",
 			t == mptcp_context_type ? "subflow_context" : "sched_data", off);
-- 
2.35.3

