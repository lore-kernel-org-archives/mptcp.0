Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73237F
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 02:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651543670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAOcRHBZSD3mIP8jzONRIcRhQktjxIa6D2q6pe75Fu4=;
	b=bvkxTJ+EjblLuG+xS60MwUyUwUwHhzEEBOBm5XzZAsKkzmu9F1mkfYDkLo5tqGtc6qex8J
	sI8Xg3KO8robWAunuyjCjoV+JnohmPWGSC9eoZt1yzUetb/1LsJX560yqjutyi11VY5Jtg
	0RJ9WC/tNnqZZtf8BD3R6ZiCwaNzSrI=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-KjVcEim6NNq3zePWVYlVPw-1; Tue, 03 May 2022 04:07:49 +0200
X-MC-Unique: KjVcEim6NNq3zePWVYlVPw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWuQrPWoWW3Uroh4NtuNvA0nwA826u1Hb6HUl6DvgJhFfm9kXn6A0uTs9BLCsv1j5DTwiWGKHIOAmkWxzYkD/CWaY6vCvtFg7Q++F50of8/QJudi2iCvRnWJf72F44gb+y5WCLsAU6S0PRXMixdxgA9ojF3Ymfi/M/6ejuELNOBsybrCTPVhe9wVK9EymmW+m/WzlLh+2ueQhkgqdOxmzqnCdi4Rq6FFhBfnMv1NhbTt11400pN0H1/1zTtfma2QH8/nNqRrIfuBdyVf9xGZWkJP9VdtUDvmGK+3oOJgZ+r57ATeV2UyX3gdePuDnmV4SXUULxFCIdJ+iaXqfoARtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPjGpUakFCHz9R6BAcFh42FQD/PR+k4t3tmFfXHrJG4=;
 b=RKzApPgoK2j9N6AVP6t8eIdUF0BOEavN7lG89dd/szsJQBTpkEogpYUDphm+188TvO2F99oPsAHIU41LWj936nAGhpG3k9xRJQbBEs2LcDO7FEW7JcVNG5zMi+7/M6WAhux+1E7OYT8ySU8RID+WI/gpo30WOAATLfBzVWHQ/outXemzcR1RCvkxRJVnrtafkg6EKRULEhQOmLKOfafrynp94D73rnqtjrLxhJqK8jocRcuqa8T4Ru172vw1qexEt10QKWyiXch49CWFMHhpkrpm1T8lwx2HSvqoFL5GnL9cwLH4eakrB6o1fCheGkCIQj4uP90syeD/nsVDBNui9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6364.eurprd04.prod.outlook.com (2603:10a6:10:10c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 02:07:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 02:07:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 1/3] mptcp: add subflows array in sched data
Date: Tue,  3 May 2022 10:07:25 +0800
Message-ID: <43d0c99ab50fc0edce0de7d410ee40f93c194d17.1651543362.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651543362.git.geliang.tang@suse.com>
References: <cover.1651543362.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0175.apcprd02.prod.outlook.com
 (2603:1096:201:21::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 920dd500-344f-4af7-6efa-08da2ca9b825
X-MS-TrafficTypeDiagnostic: DB8PR04MB6364:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB63641C7110A69139193BE1F6F8C09@DB8PR04MB6364.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hy4/DbLVH/F5VmkwCsmmiMvGCq8Rd/kAF8eCQ1UJFduEHqUJaymCqIQ7NcmVP7/zfi2XTfPcP6wFTLz4urH8Lgll1toWiJ3SUvqUbx4NR+hPwsGdn6zPlFF9TNaK5WyzcncnTZeR9N0fuNce5+M3AWTHYf0Y05uArVIQS7E2w9Ub7kpy7cSJdO0Qy9ORxluYSC5As0rMhXf5EeOhtvRucr4YonWW5uT/EWxy72IgTOpAgV3f7DdYAOnq3Fqs1TVO0cK0WtMVfsOmw803P9pa8Rtr+2wFDJE5yZPKyV+eu4NuYwlZKmuLp94arzuVL8d2OTyn3SSAscpqS0niiw1htqBiUzPTGc7fezwfRSUtqX+fXEO879ESW3RcJVZxrBy9bj9LycByLnGhX4E47/ZMOVgbkBpkHdCn2xVUQD+VwX1zW8IL0GZlg3KoW2MiamgJ5ZCAObZs4C2XztguVH7Vt1VxGCj7V1hkrj0nM31Y1AquTpFYD3zrgXoDnyBxFKyP4jplPWGAWTFJw1LzpJOAozoDW80SXzDNR5RRVXty60EknZS7zzkNS9P1G/9jsvHg51ssWPxvpYkzBKXgpBAINLgxgjWAvRpFdwcMotPjJT8cd6uLcLaLAlIwOS6hjXBwVqIt2jJLpgdEbrDf9NgS08w3o993K4ENE+JHtTj9R5KQbisuCPIHP3DcGYlNpU6W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(508600001)(86362001)(2906002)(6486002)(38100700002)(66476007)(8676002)(4326008)(66556008)(66946007)(44832011)(6916009)(5660300002)(8936002)(186003)(107886003)(6666004)(36756003)(2616005)(6512007)(26005)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S3amUYMZ5ALdEr0H+wx2VhH8mAm1fPImN/BByMxgRCz2pnaEfV5OBwtYyuzr?=
 =?us-ascii?Q?Hr+IetW5SDUJIA/yoO3GpxdoyZJak68Glh8IWIxO3SyXcyuizkna65xqOctv?=
 =?us-ascii?Q?++gFo+V3A10RPqKd0zD1a+ZhqPl+YNZvza1PRzEmefxCDyXsI4e39+hkbUHQ?=
 =?us-ascii?Q?FfECfe5OofKHi3VokdPCMgg+zad3jWv4zWHTwasjHupz8SYVXPsPKTVxZPLC?=
 =?us-ascii?Q?4WdMaFTAE6yF5f2Yw/dFDT4nrLFYFwq5DLv9agwxvpwn5M9Af5EDvtzmHPHw?=
 =?us-ascii?Q?aNa1qJ3EQigfCWAiD42SCiJf507PP3AYyKF1xzX7ey1JKh+at3KWRir+TtyE?=
 =?us-ascii?Q?atm6yOivKsN7hxwmtWROljdcQnlUrxDTWGlFNXSFzhgZ62vLGl2RrK65kKEY?=
 =?us-ascii?Q?iA8Kwu7p80vBeSVsz4cBn+xgsLbEohDIcbsmUiyGAMt9rnNu/1Qghz/ElvSV?=
 =?us-ascii?Q?3GmFXQYNvBIcu7QhYOJp6XxoMnAtm2ZkY7Idw/rbR+sYrPAu0K6iiJsfGzKq?=
 =?us-ascii?Q?vk7fgyv32iRf5rdpJdu6KS2rBPG5/+qJQyRIlsco2v3PuDAGkla7vjZQOF/j?=
 =?us-ascii?Q?U0QlY31FAJmj2ZLOFZfN5574JOHMIakJ3BN/6Q83FLaLuo41ekjOXB0Am1hS?=
 =?us-ascii?Q?csXnwYUAmRgoexJkkVIlDRrZRcMOH0HP+xdtJeN7zNRJ+lzEKG0Wekl+JJrD?=
 =?us-ascii?Q?gIIbUBrbXSnwMrIBu5PDP6mKKIOi+7x0jF5bVLoAzuWSgn5qEcyUNi/g9kab?=
 =?us-ascii?Q?kQGJ68O21m16qbmrsf06nINMn4q2OEi6X/npjPcHBiuxbhBbpYlFFK6PKHOa?=
 =?us-ascii?Q?MI98feLfSUKmgkjZsLvPWDrCI9saHyVT9YA/OhE66AwIfk0Li6NWrkvWpnN7?=
 =?us-ascii?Q?9DhIEUHX/5SCP5EchEwfyTna/DxYPK6VQzdtKydgW9ULPE1OVMFcISonDFPY?=
 =?us-ascii?Q?GKNTfP9LCQokQsnUsIwJVDxH04PtAUWk+tsfGnxu5SGbdIvfF8Em9dalsHs0?=
 =?us-ascii?Q?NrnJ3Z6Q2SK3Oiug31scKnPDh7WshXDU2euCKDkWMPAoOV5lNayX7YlxxPGJ?=
 =?us-ascii?Q?q3tZMhQnwsFdDBP7VhPzWkzh3XXuFiHpcB5CDXv7C01a2gT2JpOg5PD986tu?=
 =?us-ascii?Q?nZmtgcCMx4oTmikEtn0gSXdy3+mxLGoz6+4Ec7qbECNUm/CO+Zz+G9JFhfaj?=
 =?us-ascii?Q?mnMtlYzmfxRvlgrV/McT25mWtooDn63SqOiiEU58DPoN6TJXM88nTD9J/Ddw?=
 =?us-ascii?Q?B+GPTJUGbY2dN6s/EBtb0BPoCTqU42hATpdrXXcaASMKjAg9FVIQJmelTbKV?=
 =?us-ascii?Q?9HrhIyAUELkUtViiU5q8sJsufjY2bhj02N7iOyEKaU507YrWVbMLnwaVrqNR?=
 =?us-ascii?Q?otxwEW+Va7B/ZodrS49fFICh8T/yi4JFbTYMXFqIevbYvcmv/st6VayN0Wea?=
 =?us-ascii?Q?imeEwlaLvrFM3Pjoh4aGOrD57OphF+raLsPraJR5ZUvK1IaQUVjZuwMt3LJt?=
 =?us-ascii?Q?LdC5DEIRIEz4SzDuf7SMzG/cksX18fw6wZRjpaCElaZ3k0S4sGGeO9mW7Qcs?=
 =?us-ascii?Q?hKHyyqvVgqs0lm+JXynSZgYW7t78oRnJabojcXbR4/SnyF0PoX/Fy/Eqelhu?=
 =?us-ascii?Q?Mgmv5KpeKJu2MAogs9F4AXZKyvLylci5627FywpJDN6cqSxWIOmCbmJWkIe6?=
 =?us-ascii?Q?ApW4zz8QyP6h2i/YRg553s0eaPbqExBJ84bFKj1COyVHgZtfHBaE6waYrkkO?=
 =?us-ascii?Q?f8Oh/NZcWbSCzt7GYPlKpLzk9CfwkcA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920dd500-344f-4af7-6efa-08da2ca9b825
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 02:07:47.9714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ucy5ME1saqmz8JUbHIdp06yUQRg0AjJd5pkyz6g6NUwp4dVV7goRnOLtZ++9dw13IKE6Buo6dtbxq2SOW4u5XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6364

This patch adds a subflow pointers array in struct mptcp_sched_data. Set
the array before invoking get_subflow(), then get it in get_subflow() in
the BPF contexts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                             |  2 ++
 net/mptcp/sched.c                               | 14 ++++++++++++++
 tools/testing/selftests/bpf/bpf_mptcp_helpers.h |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index b596ba7a8494..345f27a68eaa 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -96,10 +96,12 @@ struct mptcp_out_options {
 };
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_sched_data {
 	struct sock	*sock;
 	bool		call_again;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 3ceb721e6489..9ee2d30a6f19 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -91,9 +91,23 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 static int mptcp_sched_data_init(struct mptcp_sock *msk,
 				 struct mptcp_sched_data *data)
 {
+	struct mptcp_subflow_context *subflow;
+	int i =3D 0;
+
 	data->sock =3D NULL;
 	data->call_again =3D 0;
=20
+	mptcp_for_each_subflow(msk, subflow) {
+		if (i =3D=3D MPTCP_SUBFLOWS_MAX) {
+			pr_warn_once("too many subflows");
+			break;
+		}
+		data->contexts[i++] =3D subflow;
+	}
+
+	for (; i < MPTCP_SUBFLOWS_MAX; i++)
+		data->contexts[i++] =3D NULL;
+
 	return 0;
 }
=20
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index 4b7812c335fc..7ecd0b14666a 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -7,10 +7,12 @@
 #include "bpf_tcp_helpers.h"
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_sched_data {
 	struct sock	*sock;
 	bool		call_again;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
--=20
2.34.1

