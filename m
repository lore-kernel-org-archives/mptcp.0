Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB29A15AF6
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LSsvq0HZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HECxIiEDHDl4ldMieByzoAqCJG/LwxTOPnaugo9ABOZ40g55YLf+sXMJm3aWhvVRgpPuhKJoJNeweySCSP31lBbP1ifkHiz3JARrwMAYWjlsHFqEfRbY0EMCv7HtGlJUc+eyA+cmevhvwg+hMvjvonWxyBU8cyNWtn+q/YIIQeFojNUPpu3ksLef0JM8AVhixSLNbWTN4uIRQD89HcQRSlSFRuaeT4D5HMjDnXv9YgaDSbaLsmFCchFt6ccx/Ad6vm2oemBsRYLLMEhalbsxpMtT5rcURsqka236qvYPV5TcabeUC/jcsiyqnvRra3yLzCxRJpdSm+kAeyvnc825wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdUl1ixjV1bMwJiLktDaFUKI1bTI5vMYphE5VCSMZrE=;
 b=j+1u0u3Wx9OY3S1GJblvyWj0GF/ld4LNqlya39wxBBoPyokFzVFH7slGEoYr39y1AsdlTNEAYMYjyveD3ymO1wSo2P1VMen1K/0R5m+iW8gdye0yjVaokcbhEqInBtLjrQnX2CvmCtKESVQAJKkeXP+AD7MqvAZSoO80wTlMHP9v/eekH+mYrC3rbfWK+SKwCI141oZiULmLhiA5r62GSWQVMs9YYORavcxisKWfkQSbuixiXrjXKn7z/1A7ZuRQ7Hiq9456GKBXMQeOCA4PNEvL9KQknml7/DVPQ+4tXM0D+cpkY1+9J/usU7CbcfcgNkXyQ9gexMUXfqd95lT3eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdUl1ixjV1bMwJiLktDaFUKI1bTI5vMYphE5VCSMZrE=;
 b=LSsvq0HZzwmESHFKYx9CuS/18XMfXWtMs2VTyHqmUgnlqYcN75z5BNu3UMkzGc755Wx1LMdJ3fUR/NQYFxQIVbtnbrc8PGZCtqFI+7GYG7esHxIxph+APs9N6qP/Syitu+HX3CKQdxeXmtNTYShMUS34GBVqKJczAZzfMJMOt1fHWpLKZCv05XmYRmwvb0lK4GyZoWiju6PC4r1OXAABnMqJQ4cWXIYmuHCq4Bv4K9j4fEWudOputCVx/HhV2IROi4SV5ETdFbX0t6BlsDfe25UDZseZpFhPJxyuW1Dx3Ag5kjUHq01IXCTctvYAgUNM4Zl6psfcPA/4VNCoq/wK6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8896.eurprd04.prod.outlook.com (2603:10a6:102:20f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:25:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:25:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 30/33] selftests: mptcp: diag: change timeout_poll to 30
Date: Tue, 14 Nov 2023 18:22:00 +0800
Message-Id: <44092593d6250e7f036501f350358ab3c9881bcd.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0048.apcprd06.prod.outlook.com
 (2603:1096:404:2e::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: f7125a07-0006-4a45-173a-08dbe4fbfa80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W8m15tWCni6RnuGRxODdJnPzuqFyyCyYT7Fh++h5AUd6RcrhwWHFluGmRBcmEgFD/dR2OxdyzruF9sl2D0bi+zscPTxGY1XHuK8CyY+gbTsISGB/SV0WTZy9WopoCWRNRW64gM3/s3fsVaR20BGdfQBXgMN5KnKoOnITaHIj24aAE5wN2lnEDhFznQ4Ha3DoJcpRQZLsd7SXcZMcoCf1/ovfsPAGu3mOZm9900v7Ume8LO5h3J66U0f4Xty9beRnl83TAaDebwiAKNtE39nUb1sBTEl+orlDsaljiA0nm6CmDC1Y8RYuRnNV8oTJB9Vsad1wk2X206DXr/4QNxYMK9eBJlFO1uoqyA6CnAJsVH8hQXIK0SVN7z3Twq7B+W3a76O/ORrTbOqVtld+RG7mnAVvOpZvRpX7hHJ/I7RDzW8hmZaceLq0rkMRDkoXkv1EZMCJIavW5kzn3Kc2RVuVczTTDTm12nlbDCNW6XkZUabf7ao839Jd5BtMDO+PgArLCbObq+fQ4ha33limQa8obCi1Fdf/gceXyRWC8I4mQOJan9rkIYTZ+5zDkPCddAUG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(316002)(6916009)(66476007)(66556008)(66946007)(478600001)(6486002)(38100700002)(44832011)(6512007)(2616005)(5660300002)(6666004)(6506007)(4326008)(8676002)(8936002)(26005)(4744005)(107886003)(2906002)(83380400001)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cYmj+HN5qbun/LnEd/fx3Zrr4sCN2bpsRNsyO+RdRTFZj03XxlVilm6Dgt/b?=
 =?us-ascii?Q?pfCe/3F9ZOgxqANxYlSX11CTal6+6tqek50oJSrKvgJCUkpFuUdIXlnjUjdB?=
 =?us-ascii?Q?2lRQu7JeccRnstytUvQnz0P9T71K9OjWBZWH2sKfHE60TC4S0p+M6IpsxR4Y?=
 =?us-ascii?Q?xyXq+J01y+hm1ji7XrZsmSwSeDm/qfi6fu+mHVUINk7ZeawqA/LovyiSguEE?=
 =?us-ascii?Q?fySUOYa+MsJEcevnnlpHyYDkzpp2gn+KM4TQYYYIczfMVfUfxSS+YiRxFA7I?=
 =?us-ascii?Q?ZDZ1LZv73+ESQW2YfOBT9OYyx2gRR/AzkARnpQctswrGsWCNJxH2jxuR/77v?=
 =?us-ascii?Q?tUHTQe8zCTkcXbY3tyU1YWRaqC8O8ZNgvrABuw04NsPGZiowfoHPIywCi0c+?=
 =?us-ascii?Q?1np/G0LH8hVGgJvK9OwejjAB753UsPCBpGOT3hN2BF3iKuwcpy8QOooaHo36?=
 =?us-ascii?Q?RSsr84godm2FaMkDUu45kM+3wF/QydOf59B3UkmypMHu83dqJKgGC3tzhsfo?=
 =?us-ascii?Q?yUMhiUsHNI0hzKP4DV255gkjQNYhMFkSIkh20DNxRH65QyUgTuy4Mb4lTHZy?=
 =?us-ascii?Q?T6wIigxZ2mpo9f6hoo8uczq2vkp2SVwm8AhsbMLhNhDsLGFM4aa17x+QeCjc?=
 =?us-ascii?Q?oENmj3FW9h0Uv8IWr0glJTa/o1oFKZXinSRC6sj+eqTmTwc/obynUBTdQG9u?=
 =?us-ascii?Q?QgG+IfR2h7tOp7VQno/n5AfQd8FVaQOra1OVz8JPjURjX6M8UodA+p1SLF3f?=
 =?us-ascii?Q?UV8dvqxQTiiWD2zLI5tuW/O+x7eQ7M0I4BmujuIdr4nN+zHDT5I4cFKqmxi4?=
 =?us-ascii?Q?1Agcw7Sf6Hwd6RLyV/ObJHOCXBGfanTN4cLtgpi2qGMJSaw1LB9dIitmCSUv?=
 =?us-ascii?Q?u1yy2ztvd+y7rko0taZYLYWe6GD9FhbqqorvO++ULoLV8xSrU4J++wviqbSv?=
 =?us-ascii?Q?IwHUttKWnrH9mbTA6Dnvr1lPuz8zySHQdy9SRBMa16crRuwkrhfk6bkwiJBO?=
 =?us-ascii?Q?3XKrfgIgGd+e8JOP8EkSsFNT7feqKIabBdJDDGZ4XPK/x8u5f0YSO1Dw4pOR?=
 =?us-ascii?Q?vOpGkCTzQ+Yv8zjIh5KUZntpQte1GDcoyze200YCeM8lokcHOq6p4exVNGvc?=
 =?us-ascii?Q?sBMCpmLkgAqK7mu2WS52haREDUm+/9Wqo57jGYmAY9lr4XxTiYIqAcTwDeEj?=
 =?us-ascii?Q?+uawKq9BHbBnABWDfDSBniUgM372BrDArSHBBJZrEyO+n9rHYRIyuZpG8Ty4?=
 =?us-ascii?Q?34fkmTWNtZgu6QwYtwS8WgW8DaVLQMHQuCyoRP1tSWFy7POprHRUpbjLFrWE?=
 =?us-ascii?Q?EXqPC88PWDu3IjE9kdTIFH/Adhz8f1RSC3CAHviw/ef6I36GcKceVZvCgxM1?=
 =?us-ascii?Q?sgoCJkvFWZxMR9WOIOPQjh4MxBjV12ThMy8DHJSj1AKN/jtSxrbIaLXONWm6?=
 =?us-ascii?Q?F8UR3Ma7GQ1rX1gPxSneR0c6MStJ5nEfVx2EAIr1cGsN/qRvhMEVjm+9EJSJ?=
 =?us-ascii?Q?FlPytePA3QMwTe9i+m3lQ6QesSU6TFWGKgnAM07iKo97mjRT2wS+053JHaYr?=
 =?us-ascii?Q?kochEFbDO18Jg7ELNqS3gw0rdwewUhaTw6jO2dU2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7125a07-0006-4a45-173a-08dbe4fbfa80
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:25:09.4882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FS2DUL59Kaz50thJByuMECaM0cR/excHCkvqkdZ/FmXaCsrML1JlKx4hXN0MuiDuRKjemEAGNy7xCnAqR6pbtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8896

In most scripts timeout_poll is defined to 30, but in diag.sh,
it's 100. To maintain consistency with other scripts, this patch
changes it to 30.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index c7a7c0d2792c..b5a17d2b6723 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,7 +5,7 @@
 
 mptcp_lib_ns_init
 ksft_skip=4
-timeout_poll=100
+timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 
 flush_pids()
-- 
2.35.3

