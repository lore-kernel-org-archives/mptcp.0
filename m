Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2083.outbound.protection.outlook.com [40.107.14.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BDA7C
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 09:18:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4z7mlyV4pbUt2sADGer9s+tg3tns6iV+9kNpKIcfp1aQ0ahd445J1goSv2yUyU8ewzSON8iybxU0h2RbR/LsenAjRV5vA3JXpvAdl//6Dxj02bckgRbWtDlimGtcLZj2TptQQEO5PuOqNtQ5/+BP5ahYaevChEbjPCYk6KjZ+YLQuHPfPDl1kSJUqAyJ9oUDvqR6myFC2/hrd9OLVYUiJOlqK8WI+oa+YQR8ttahV7/75sL+4tu3RjI71QW/gMBM+G0hOIrDB3CL6E5yWdDf6ZwL9YMPHXJgPaNLysgTVHhL4bAN36LAGZ5lwavyu9rKfPg88wuD/tjXOI05JlSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAAXpxTwQ1Zi08PGAKLlb0QSz/kVoLq/lZtYIFLzxNM=;
 b=bhc42SDLrV2aeGjXs+e0YukW8UGdl3M926kW7dSpFLX84+U4eH6Fsb8nZiGMJZqMYTcmPa5fN6Rad3anI9wwi/GPNCaWNE5siuxS7VVV75JZUFETtg29VV0cTdqrVxrBFtOeoptVyzRQ7pvU/lfB+XbeLjxcsS208bshp6GDwQdmdQ1+ewUCw/xTHXNNaB8kORCjjBLpm8gazypfPMINdrlz97cAWX5rD5XfINwKAXc1VjyTOwgs6A/uEIXpGFLriuLduhnmKkNEW6kWaNhrKNqL3ZoZNVgVk4j56g0Z6569dwHT71Xmab1ut6Y/f30V7IvIfOEKT+Z6KO2Y+BWFXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAAXpxTwQ1Zi08PGAKLlb0QSz/kVoLq/lZtYIFLzxNM=;
 b=ViYv3e1wW8IkhMpB6GIc0+RgXffjdm7CNyzEXf+fYpLQ9O36YLJOiw1ZCIBHvNT79yFPvVYxQo7h1Iv/hRjR71PTgkFyjEz1HeOqUipvxVMr5pG28ZSJh1p4hA9tfvRd0Qax4tv2jk8BLIKm4Qfe6gHzYKDoazFFWxUxlIyBr/VGguXHfQ0uKm7lc1hz72/1xhGZAfJOYr4waDW7vatlklZ0j9QH3yxucOxwOCOEaQcouBeI3Lz01dob4EVV23gycQ3hZvzBM5m3tpA3idZLA5o1CZYbtg2QKcm/wc+zTvngBfy67dtu984LXxUfp4Yvc/sNYAxnzEwpc+1vj+bqIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7321.eurprd04.prod.outlook.com (2603:10a6:102:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 09:18:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Mon, 29 May 2023
 09:18:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 09/12] Squash to "selftests/bpf: Add mptcp sched structs"
Date: Mon, 29 May 2023 17:17:23 +0800
Message-Id: <bc519391a40b1b359d6c52d10a99f3b8ef83788b.1685351620.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685351620.git.geliang.tang@suse.com>
References: <cover.1685351620.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 66bd9f17-682f-45b9-d69f-08db6025b3c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IZZXG6Z5NqP1GVAfV+zj4eVqT8Vna2GD+J9qMT2xRxxdVtBcfSYl9fnYWvFwE6gdgiPyQ0tPPZeyn95twpZMafumWs0JBPHq6qOFZUpwg56qNVCvFoHaNRZOpPNT/A6DmL7UJ2EZUZ781Ryfn/KnUxn8lQfLAmjjEwj2BEvMEYL6Onu35AOKn5P8Ig5C0Dp/LbrBbpEW9l2CKdWVdDODeqJJdmiM4Eye4XKiegBBgDgs/Nmpr/Cp2A0QvMQbV4bOlcUW7NgwlFB/QLkTKqlqtB95VFaTdxS8a7+Ml9lxe8KGm8v/WuB7vfGVe0/RcoVG0pwjnIf/JDRYUVOHVu+1LLoWpyq9ZvMRQIGf2KqnmCOuD4ullba7vmUwh9LfzNxwwIj6CT1xTlBWQnT6VmX3mOrB6B0ClflpxKW7vLMOhwkiBNZTsDN7vbnL7TmJD0DAMTt+ThOq0/5MPtQvpmkcYPCuwOwKAwItbjHDsElCHQhPCBKf616MNGw24sUOHHA99ZZpryPsq6/hJDP67umhCcmoUinMT6dDiBZD1Q8Uj3kx0OOX3GrSRcWQdN+4iqE5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(66946007)(4326008)(6916009)(36756003)(66476007)(66556008)(83380400001)(5660300002)(107886003)(44832011)(86362001)(41300700001)(38100700002)(186003)(2616005)(8936002)(8676002)(6486002)(2906002)(4744005)(6512007)(6666004)(6506007)(316002)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hJ+2L0SOPbI31+9Ya1M+MTRPdwRaIznhiDIX/+TVj1W2Iqel4zQxjJaaXL6Q?=
 =?us-ascii?Q?KF0ndlTv/NxCfJENSt9hI9gOqAmZ8Fb+elxRz7YCeuY9BAMR5v1KqD4WYFtv?=
 =?us-ascii?Q?70dW0wY+xqCeYYzhAQhfYwU7QYXfbCj75QQgdD8olLgKlog6qRr6Ixc2lpcY?=
 =?us-ascii?Q?O469/Sd+pIkFWBugcyoEqkjmRNIMVerrD1S/iAw57cWEZSeAc0lGlk2FywNQ?=
 =?us-ascii?Q?7pjDIxpyYdEBU5Y894QqUj+uXJF6YkmH9QG3/s9If2POA7VQB9RK/7AigUtf?=
 =?us-ascii?Q?75ON50X56uRjHnyBwNXSXCb3lvFjGlIi9DHgppdg7SzB94i6iilScfcBXGIE?=
 =?us-ascii?Q?TuIJ26YomvSkbhZAv6GpRpfpKO1gIQhT2CG5lkSBs5o9K9r2abizh999gpQI?=
 =?us-ascii?Q?Jw6bpK1beQV8/JdO/Y7vyT+PuHA994drO+vWNi7wradWAi58yJH1L4HWuxx+?=
 =?us-ascii?Q?XTqWcKInHL7lUnBjuL2O+HTs5tyCH0Ot0zL9F+lRmxF3JuOQvsv1FhAJP8b6?=
 =?us-ascii?Q?AjbkuES9PudOTZ+EiAgzuzOn0kOAyhLHdVquWLqJYAxMpECbJNvPt2sFN4+/?=
 =?us-ascii?Q?WOvURefFi0WFxgtEq5tXvYn0+cq5JXEV3z/n4vH3Oz7FGKbUfEHI/o6EkhpI?=
 =?us-ascii?Q?r9QV1A/Vo8CwoI1uRaaI6IqVqtvH68NEG0R/py5M8ELsa6tOPRu3Il3Nt23C?=
 =?us-ascii?Q?Uyhqeb936zRYbUN8OzCdYjt69E25+CBnvnhyYVp1UPVjg0M/SOj7LxodvrvS?=
 =?us-ascii?Q?u8SQNwTYVmk3x88ZtiRL4l86Q7gvh50fQ9F/WULcFtLIfe7YmFxlbfM8gyVV?=
 =?us-ascii?Q?8opAZZTXLKkSi6pDZWDFnIxP/TpeqKb7kA13Y7rZPOOCqhV33HVqTHdgBal0?=
 =?us-ascii?Q?rf737aDrRWyjIgJ1sNFSCP//Ak/GRaDNFVI6qTPfwvcdhfDfxikJ+KUaR7W4?=
 =?us-ascii?Q?9WNUewvI2hPeEiTo4smdSZ+RYOzZEaYlDWv72w3ks7bvltF/WZ9n9xsgL/uQ?=
 =?us-ascii?Q?gTUm363NwN2+UsGIwMakMT/iMO89tuuM+CwOJez3cPwwtubnN1xQk3GJptR2?=
 =?us-ascii?Q?NK8WJJ7tY77kEgbseSumwsXzhpDb7xfIBSgvbRrMDzde+0iZMaN0mL4LVL81?=
 =?us-ascii?Q?udXbRJqxttlpAPbDCQzhPbeGRI0pjbflQCmIgjrGnyje/fIGXiMI2AlNF46G?=
 =?us-ascii?Q?K7Iv2qrbveqIT/TcW+mASaFM8tJC+Jw64QZ59czoqUEQVTyXiiLdTWaQ9dyQ?=
 =?us-ascii?Q?TH87/fpWW7l7cOY3ZXTFyzEdKuL75okxkqt/oXktxHI4bNpXgwzAg9kCRLrJ?=
 =?us-ascii?Q?qymkf2idFYccQyp8H2KhWcvyncpgnKtcI9xdy7jv1bl9cLn6y/jOa0VIus0U?=
 =?us-ascii?Q?edSy5eYsvqqdMm1zUGg1RdtNKLPgT/bslsig+tPrXLt8X1FAUCY3XnbbbE4G?=
 =?us-ascii?Q?erwf9JHIucHkvUT/B/PARj7bTr3lnGXagh9D/k49GJojF8UQl2oBjhlvEC3W?=
 =?us-ascii?Q?lIHM+gYYeXWJKUH5Ovn8k43d0HGW+vhXrd8chlE6+PtFDYM0vk2XZAe4QscS?=
 =?us-ascii?Q?rRC7aHaB5mc6mzhx1vOcG/0WZRZwpsgu0QIkpQFG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bd9f17-682f-45b9-d69f-08db6025b3c7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 09:18:45.1077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7yf8PlRhvbYV5KrA74v4TRbXPY9zo4LaLE8M2AnZK5BCAYJK5I7q31z4m+4rCuziI/9gA6tzQ0z95xyHJimXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7321

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

