Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468A934CC3
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:02:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIajugzpOBxiV1wGmYhma0rrXsjBQ9a2ka1Hbc+OlM3/JAdfa30ne/+F7plQQIOALxZrLmuRoB82pnNjnEUdc1a1/HOvlN0OZ6R9QEeCJ6j0zyx3uf6E2o8ZtLcX3i7Q+kAu9Egq9Ozm+OuZCWtvYupQByWx4FMO6M8vhGSZfkDz4NhsQHht85edtSGquZzriZg1QuD0yUdLVDvkyDE1LORhG1hnIKEqd/4XH/F50WQzgOW6yFpQ70diK1dZKHQw34rICW/4rnpPTFTyzXN+2dtkd7FrvMYfFp8GSl11B7SW7vwCCpCC398MFTq+lj+nDAR1weIWKSyrHwBa5LfguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldM+zhg3ZRaNH60oexri0cN4gapaj9rWMRpDBoFltN0=;
 b=mbSZ5v7prgwfjHIoiu8HTmPURP4CrPWQX4ZLHAvhkNWLRjEhZ4QFfpWoy0UgFLvQcSbggBVwc8/K/TQWOEgKqRFbvXO8IS6QBx2Ni1u43CjUVO2HMkgjsB355wOSr9eDXOGlZrgrOlig3a/tADwRnrZCvCG0+n7W8gZlQ/DlemiqXqRtxqI1pU5cOAMwwhE1UigoWWVlq3zRjFl4e8wjvNdHWsZ2upSJKNj15npL9JxzvgpTx97Pq0/zw4k8lukaMjpLpu9iEaDlsFIG+fZc5rXXKXxjcW2jEPUQtLhx0IbY5EzEGV05CgQhTZVYSLpYqwO/15jYj9UsWUJ4Oj3z/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldM+zhg3ZRaNH60oexri0cN4gapaj9rWMRpDBoFltN0=;
 b=rdcQSuAf82PRJaW9+gA4KjSg07ZKwAT12YbIXmAy3wir43J+skuWS3bfI91IXHWnUGHbyKHPMKC+G3EnxJz2zYCi5wxlHEZlsNYp9bId4G+eNGHRQAexh8BxddrIKAdeGbiU66N90CrnNBCKebFJcmasVkM7bZZM7LudF5zYtVfpDsFaKtsz/2iJXXdRoVnPjqUKdciW5Hd/4vjLQEJOU/CWiaqONHHBFT5ZCh+QqMDHKJNvDuNPCyclGNT3YX/Evafv/WV0xfLKFpvhw9MTmKD8Z0eu2O9sdqfNrO6zmW4Gx5sCgoFw7zDf9KzMikf+RalswQC8RT+Qwmogh950XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:01:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:01:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 01/30] mptcp: drop useless ssk in pm_subflow_check_next
Date: Tue, 19 Sep 2023 12:02:02 +0800
Message-Id: <4dfcd21a19adfb1d8e1b61ae2dab6cde4ed8034e.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0017.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4e001b-1098-44c2-0801-08dbb8c52bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pAg6guZrpDbpyysymtBu+wPrMxTAhqNY/U6nGsbNgar6mqaBnysb4UhODUwVf/HZB96sylnK4ZFf7OMRCqhpBNGDr9YxuzsL/tLDxNZoiNm7gt4DiRqhxPP2KOWjGHXebd6Y5ox9SqwVdeB4aSL0joRiLfR357MxJNsVqAsCIse+d8FZtvJqsDEfyiSBT+PyL0kDEc05c03gT0uiXfEY+2Xq/ryR0S8X0BfHAg6sggwzryhEYkeqUSYmTNZnysJviJRpewaclmLUX8GTGQut5xdPIX2gSYxq8RWkjkfirAedQCT9k1WGt1v/4TNtZzp/EA2zMee8s8Aw64qoTzRpxF1p0kRNv7l/0ExEvPU0uxrzYEZZ9n904uvbfg6eTO8KtI+AyvPPR5pjK0DMcQLrOzWTwvfWS4TcC8Yelo9HloKXWbEhJ4muRsA3ZBrHIRb0lSXRMDI1+ZbfYk5bMXWWW6faYb8WFQhG5kZlcDfbuZnPt15uOOwtcgMxg6jOfnucskKZl4e8kbVJFzK8htPM1eAkhQWGNlOhdawTubTkPNJ+5r3htvLEfConRgq52D8ZXfMEDNKM1h6B6mUtKQQXFl+5knX1NQJS7LLpCfT678o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(2906002)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(86362001)(26005)(478600001)(44832011)(6666004)(5660300002)(107886003)(8676002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZabLgUZ4Ow/eNDQPpfk1neoDrV8ZH6mJMsaPwpWjHHwPHh8aha78hqVj6Xgc?=
 =?us-ascii?Q?pv7FcF63LzuG6HrmaD8E/+cPLF9ll4lKwZkx59CW8zCvyyMRQn4OdRanQAIs?=
 =?us-ascii?Q?3T7+q8Ti5UeqHEhOF76IiS1mdLZHN8fsE3CGmj5q5z9cYrmQcCjXY2msBOoR?=
 =?us-ascii?Q?Q7OmvoAFeT1BnRdZg44LwpWBziyKWc8nuC3WRcHziFa4hAmYQXJSGR+LSZPa?=
 =?us-ascii?Q?+QwQCHWw3DgefWDH8TRCmwTojCK9KFHl9z60gJScxxuYrQ6wSRrqJQZj7cTt?=
 =?us-ascii?Q?+WXwEI0frzetx6Uodn8sn3CdeP26zAXDPtQkL8Yo27KZdbJUyyXOZsfkIxbw?=
 =?us-ascii?Q?YAC58Dk+XklByzPg/inmiC1v2/t00Ymda15u1NL+0sMvSBkmdMQD+EK29z+K?=
 =?us-ascii?Q?luSggwhbLHAfMMVbnA84v3lDN9XumUJHxktyle0uAZeHl3pnkEhyV63VCy5i?=
 =?us-ascii?Q?qkHmeo8LLsJzC6OcYU21R0f/pGmCsh8Fv/CjSmGu2C6wNmYVcU9J3RNc9Lk5?=
 =?us-ascii?Q?9rn2mDoyMJI1UPXSxDbVdgU7wsbm4ewKmsNUPW5QXufn7iEx+7fidyiWztdT?=
 =?us-ascii?Q?rK1or7p8/zFTDy7TibBJAsf+2U7iehB+Fdsfdiy9J5Zd38XwcZyI7d2tnH21?=
 =?us-ascii?Q?Ivt5Z/YLJ5Gfn70zppuO0xlgJHZwrQssGi2CqSBHzSkyLGosmjJtqKfGzplN?=
 =?us-ascii?Q?qZ4SlIeq7x0mBE6Ci0caaYa0uAUKAOpz3IEu1gjvUypkX/pefL2XJSCfG4qI?=
 =?us-ascii?Q?NqmALEHxVSJWJsg6OCDLut+qOoH6F6w5FCW/ABKsHjGJcTuH0rx8jMnV3vZx?=
 =?us-ascii?Q?XrBlv4JPWIJPIm8o5xgPRwt+p4TPnsNTXMzN2ojUVJORrKGplM7XctOb8O6+?=
 =?us-ascii?Q?2o4MxTYGVdou9Oo7AvPM24jemvfFZEYD9zAoQclXJwgKEMhtgPvVMWrO1+0f?=
 =?us-ascii?Q?KzmZhJIIEjWD1L9xLfc+hUme1SVjZZLoi7PYchxczRSeUWQgzQ9n2s+lhRU7?=
 =?us-ascii?Q?zbbVNP0PN619l54Z4hkMCf9IHjK6NzqY/bVWSIYj6gTV635dabWsPsKHtL3Y?=
 =?us-ascii?Q?YlSqkA9ChlNY21a12Fh3FsVmimFLh3mppwmt2BSuSGAsUFdTbP0q6p6W/5XO?=
 =?us-ascii?Q?Z28YR45bjIiSa7MDkhZ5bkZ857/2lZj3Eo/i7QatZu++cVUeM/SmaE4E9Iel?=
 =?us-ascii?Q?FX+umW1yGImTb6uIgpP2EEKD9CnlK5ChqsEw1bWQGY3AeyMDTqiJ2JQWZuy1?=
 =?us-ascii?Q?CP+yG4lWIrp4GEr+kxjMpFb7+Yz4fk284aYjvflDTsdJAfDVRehmk7VR7lbk?=
 =?us-ascii?Q?lS4TcjRd3pDVVn3ILgXZcO0AwPLVqTRL0gNj+RILcu3Uy1PBr1OFtZpwvxoi?=
 =?us-ascii?Q?SoQgd1ISRBlJjV3AZY4wEBgv0BE+izvW3VVrx7bHXAapc6BDI2mUYru4CDwv?=
 =?us-ascii?Q?PHnEEzs1CUEpf1hGLOEPaTfuyk+1sSjEYct0fDK9uu4xcxhOP5VvSn4kkg3W?=
 =?us-ascii?Q?vTyVntY/mxJ3aL1qy96rOIVhP3tCU3zxIZLWBNYi5sAtTEWkerxVLaMoFeiK?=
 =?us-ascii?Q?m3ngB4fzTWX7cH44LDv6JeXIxH9T5lm2kVFLjRm8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4e001b-1098-44c2-0801-08dbb8c52bca
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:01:58.6831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaVo6pYU8Q7TQkc/ap0X5h6lZH9ePYSOJ2S8/jce4algMm1jH6aMbxQbHQLIbOt9jfUXngwRBNkNlPnJi/GPZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

The code using 'ssk' parameter of mptcp_pm_subflow_check_next() has been
dropped in commit "95d686517884 (mptcp: fix subflow accounting on close)".
So drop this useless parameter ssk.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c       | 2 +-
 net/mptcp/protocol.c | 2 +-
 net/mptcp/protocol.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d8da5374d9e1..4ae19113b8eb 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -184,7 +184,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 	spin_unlock_bh(&pm->lock);
 }
 
-void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
+void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1a0b463f8c97..15cdcc0f03bd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2467,7 +2467,7 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	/* subflow aborted before reaching the fully_established status
 	 * attempt the creation of the next subflow
 	 */
-	mptcp_pm_subflow_check_next(mptcp_sk(sk), ssk, subflow);
+	mptcp_pm_subflow_check_next(mptcp_sk(sk), subflow);
 
 	__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_PUSH);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3c938e3560e4..f67cb5596e41 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -843,7 +843,7 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
 void mptcp_pm_connection_closed(struct mptcp_sock *msk);
 void mptcp_pm_subflow_established(struct mptcp_sock *msk);
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
-void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
+void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow);
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr);
-- 
2.35.3

