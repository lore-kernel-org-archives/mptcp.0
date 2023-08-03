Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FE28F60
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 06:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9GOM9DdSsy3UMS81r9FDdlZcHYEW10ZSft23o/LHnaa8f5gfViJAtuChj+rlxUVkLya/tj/vVUfLghLxoNwlBlSJOgb1G9pwU6lF22HZvdobeng1mVdrQF8kQD74xHn2bIjT4Fnzoia4lsEX3SmOhVBKLSwKK8iAkTXgFUi13rNhP/kohzCXJ9jBrV+p5KwPfGrDytvYPbnlMmnyEpUpBKMm+zFIm5EeOYbQQe8dlu/X/CwBGVZamT7YD5Mvsqq3Hn19+5mIxstDEsMS9p25ypeGrd9GC7QUW7In0C+ZwOFoNEPgNv9+YsogYxVHeWoicdLalusIuxfMfHQqmumGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1c3y5ipm3C0JtSDE/Ui9KvUzrK2dT4w5VnODRFz7AU4=;
 b=DmEqsHC1NgPcsQWSWXVy4k8wDQK+8BMnOtm5iNsIMxNIgXZSnNQljOTUYApICyy8AsqFzlVIy2ZV+ZXQJUNwJMInpV2zaI0wYlV5xvYpIj8NHJ2PqqePM7gC898VTTlnyQTjAdJXIzljfh9cmaOybfo+tlJ6Gj9KbmhROL7U5XyisHH+jfIitYuxF/AjSR50RzsQVuMyVUBrqkodeIRoncjmAWIYAJ3RjB2xTMRkpqQjh+h6bYgI5EheHxEYB65kv0wGpp6rvYlN88ks/NuVMDZvfYb/hLpETRuh67G1PgVZJKPneHKphPARYu9tATFKZgo1REXgvSOOGdbepruw6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c3y5ipm3C0JtSDE/Ui9KvUzrK2dT4w5VnODRFz7AU4=;
 b=3KPtqA9HpIuEcf9sfLfX8XYnf+EOsrp5jmXmkCm7mPpEjlfXvFr33Z/ZWqAbRMtD0Vl+z/7THDiTI+kjf/6V7/SXR0SBTEhXTrWim6e0+i1NgEtwCUkDPk9iGMmoAF6/PhVjcrHeqDKPegIBWL7Iko3nktx/hF6/2CjIy1Y0lA3mvMU0W4+qqqqQGCKKRFlwqDUrq15D0sn/l6G+aqyhaJdhQNeqDTolv0DuP1BnBmwyMO/wtwyCua3MgU+/hhUwz3XuvJuEzeFXLNfN79qEU945ZW0AeOP9bGUat5DbarcDfA5qp3mqV2YrJjUM34AaQeQXQVQiqMWCeHbO13HpIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7014.eurprd04.prod.outlook.com (2603:10a6:20b:121::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 06:51:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 06:51:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/2] add bpf_stale scheduler
Date: Thu,  3 Aug 2023 14:51:37 +0800
Message-Id: <cover.1691045340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 972ed101-7bf2-4eaa-08a9-08db93ee1198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pb8BQs8gkPLcV1lFqvDw0HT2rMX3XIVbhF0mVUs13VB87DBqZK7/Qa2Efhuunou3J0J7pQ7vI0V7+YM3oKj9ElsJmAKet61WxDno2d+d4xWP6/78xrK81st02IruTVmhhpQnBhKlAGPFa6qtXH+ErJwEV/aw9zIDofF9S/fnYWKZZB8syUn/RQ8YwLcCaYt3ii8fk04K+yei8qHOydOJMRVIG0R+khVwZOfEYe3n28qJS2LGYqxF56/C9OXdChg+gG32iaTtlGPU2SCY1kawUjm49+cpI8y3COKea/obOEQDs6ujJ4umGXSi95bZN+KTOXCPmEhP99TKRCF9Fh48MtOnoO56ATC091BtcZ+3CP1dQeYzIIBa0MfnQQMf1QTOPKR9GrSiBb7w4rT5y1rmclBrdwi5LwFoXK49fQE5Y8G9kEFZWiTWgwQCNH1viYO56DoeED35ULkxohy8FGDcWPa1N8xU58xTDA/iGiq2xY9gkVoMlSGRJLA9thNWYPdE/8pWQxGPif2sbpoA7eYhvNH3JFxI75u6tr4mhsourq9Fh1z63UZrpQGAdySeu3xJ10KYxF/pgeqpT852wO5lxs+26zmo1hKzjTmWwROQXio=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(2616005)(107886003)(6506007)(26005)(186003)(4744005)(316002)(2906002)(66946007)(4326008)(6916009)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6486002)(6512007)(478600001)(38100700002)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DTxF8m573WlDpx8GWJ8lpJgt88s9Y2t1Pzou3D/myKebiBzOdJrUrQ1AsULw?=
 =?us-ascii?Q?sQYxyMkBnJxyTKb0O5p5dyeoNle/41QxaXKXH47FHb9rk2ogWjr8OOIho3u1?=
 =?us-ascii?Q?qFh+gKDt1GM6dEN1c18v60XHgTA+1Q3b4eXJfd7uHlp0g0kLCMgHqGo8sgsD?=
 =?us-ascii?Q?IUgaxYZqmhvCXQxJA2qkoNffnCgTjq0JlWR42sgOgyngEEeSbVAzsYg7gjmW?=
 =?us-ascii?Q?sV9KriXeimeMC1rM8Nk1oNOPkMpUZa4dhwfxlcwnZsFVGExFTBur6Rh1BQ8n?=
 =?us-ascii?Q?b60dSRiQ+TCmYaF/GkyeLGs+ramzXIK/ZAyiPCPk9LZ8mM7mrjbPRzEtE9OA?=
 =?us-ascii?Q?g2txY6/A/z/gdsiMzs9NW+Ly1JoQLeJy1PFHj8A9OYTlySLbJ+2WqqGB0AVm?=
 =?us-ascii?Q?TD9cQXLopyNIy6sP85CWaguplAepvqq+twd0+XAydbzJCS55j/v3zT/6fY5u?=
 =?us-ascii?Q?+262s5rCaS8vsHNnAPkbdnH3pYnSVt4LfC/uZx0EFrRnZlw33UR/6kCMfP8g?=
 =?us-ascii?Q?QSc1jDUMP31jkMnwptUIeIT4bVIjT7hjbAAeqr85tzPswscwuIOVDIptzNzO?=
 =?us-ascii?Q?hOs7CUJK/EI5X8xREkswqlbhIVimp+VneX7FnFL/ZuN1bULcw0lVsSpmn4uY?=
 =?us-ascii?Q?8z6lBSOcXkraekNzfCPMIUXbT3Fa+h2Z15pnvXbga6wzdsPA266nhD4bFHwx?=
 =?us-ascii?Q?2N3eK6rrVkQpWenzutXkom2e4um3CJp8tNNFHN/xKAiYG+nFl1UkZXd5KtfV?=
 =?us-ascii?Q?oWpdLwQwZ6xiw7+LF9/hNE1lkm2OCOxdKPWHTs4RrTOZyPWpmLLlpSmaTFff?=
 =?us-ascii?Q?Ee7+UqBIqg/KDoKqtlmjQSA7nMET5WDp35k8da9QkqBobjtsfyDjwNRZUJ3E?=
 =?us-ascii?Q?aLIv+RPSVGBTq7iyUnvpEulG0yOo8yyDnHX1A9PmWqZvBBiNG2HPK5KJtTXd?=
 =?us-ascii?Q?ngHcPmVIcYSgDYSjGBVc5vZWR9Ovir7AFA/8ksnOwJxJL2Hu0uPcWrIESeyO?=
 =?us-ascii?Q?mjB4BwOHgoZx16aX5lGG+R2l34dolY0yOeNuYmlj3QBVNkchFE4HHMykNWkJ?=
 =?us-ascii?Q?rOKKfBO/fiVrfNFXd8er2N7i+RE3hhe1qdTbKCWZSSX/GBS+WY48I/J7ezB8?=
 =?us-ascii?Q?m6TQ+X8abI1i9t1Q234c61Umh+tuBeIflDQY2VSl4dGl/d2dcN7jAjTZCt8N?=
 =?us-ascii?Q?e4cAaYXqmLRGaY3AqaN8FrzcXy/cMXHMZ8ZeXL5YQ1lnkA+7kmywfo551mMD?=
 =?us-ascii?Q?XNf6iUV5UKGy3iEq0xB6G6BDyZuD6H/XElzlgeeqQSGxSM5Gte0e3tCwGfvQ?=
 =?us-ascii?Q?tBdPxXSNdUNCWhlafMLPyJptzWguxS7nxdfTYystqfwUMOcuU/ZgFrklRyD+?=
 =?us-ascii?Q?WPNhqULzfAaaEBU4n/qi6xAtqBcUpc4Ue1RL6NmEX/saLH/KBqwQ1Ck8zaaX?=
 =?us-ascii?Q?YQhgdec3pDYm4mQGlayIutEcVamti3SHEEWAqCGY6JfaZtdi7M+NhP9g3X2G?=
 =?us-ascii?Q?i00ronnoRz7XwyW0NbLLiKmJAVUAxy94l4KoD8YZOOGhsknrdl5X5IxoaUU7?=
 =?us-ascii?Q?Np75k80BwVzl9TnRK511plzaASRJN37pJDQIHzkQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972ed101-7bf2-4eaa-08a9-08db93ee1198
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 06:51:31.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5m9biSoLoiZmDIPh8MTQE+7PBPCdp5hHjddd/D3cIsKXLvzfHZoP93dK1WZkXUvwEQYtd1OvkgkzW2Sbj8xZwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7014

v2:
 - store subflow ids instead of storing subflow pointers in sk_storage.

v1:
- This patchset adds the new bpf_stale scheduler. Use sk_storage to save
the stale map instead of using subflow->stale flag to manage it.

Geliang Tang (2):
  selftests/bpf: Add bpf_stale scheduler
  selftests/bpf: Add bpf_stale test

 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  38 +++++
 .../selftests/bpf/progs/mptcp_bpf_stale.c     | 161 ++++++++++++++++++
 3 files changed, 200 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

-- 
2.35.3

