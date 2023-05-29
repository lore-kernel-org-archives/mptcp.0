Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2040.outbound.protection.outlook.com [40.107.14.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BB57C
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 09:17:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+rjHSDUJYvkid4LdM7zOxqi48PFTBk5ve2VqXwL7Gc0u4e8KWxv4r3qSUI73cFsBap7FTIAg8wG0irnNwECN21tEKlOvEo93LMpzwjaifT7z7EVHqqbtjQ9SxYjxhJpZuCh9bHxpbcfrQ6LDKGIDvYgcSZjZE/a/AtWzcvuf/WRIJQ5+7m5+flbCWq0w5eL3XKIoksoqN/8L2pQLnGKFccTJPHFAFwJCw9RUauKh+lO9dRabv7yc2Ofnu9kcTE5MnfA28LmTI0GRh/WLSBmAvinyf9mHHs/yyWjCPNpyQf4Rwm9vfhuBRWrHzSijLxyiSMZlC/ZqS4uiROxPG6v3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUlnD295plBxDuoJTPtPZK3WnS9s9ed3DBYVrkCBqJY=;
 b=UTgMrkIOn7qc8BsoSUVl4eG6Gpsv7KJATsvrKGqGBDAYNXkj5FCKhNZczY5+yynRYR/AdERZE7btSYZoMzf0NDgd9/lVkBKFLBgG3QKmy7TOj3eUQCzXwNRn4Rp0r4oGp/OSqg7BgJpcZ1H7wqVjMdAgbshEaub/hfqYACSbcRr/6NaNw0teKpMqNyk80wbSiCfqEC9xTsarzIH6ux37t93TEAeh6/5G7ySy5DSwiYFAnms78TRXgt5+nT2B4bCydpaEGocd2xcu9hUXSFA5JPhImwsI9NqsEEB2ZqgdEjCne/jIFi7hIEBVP190NRUz+h2++N3bJ88y2KjjALWvgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUlnD295plBxDuoJTPtPZK3WnS9s9ed3DBYVrkCBqJY=;
 b=ZBFOYfpZsxP916j+IX9zybnj+YJvbY3qpITmWuBALJ6rdB+8G8GjNsrZcpoWBsODZiFN+iGdyXUlyizoGv/peo0DhU7Vnm/oerA+pJhfMq+zORQOWrBF/asmHUxrvVQ7rl5WCEHm+oRONJbDGTkJEZ9lCwiL9nQq4FRIqlcK16YdOTnvEJv64eOQ83qYVgx94Zz/xqClAl4h/BwzoIpahPDo6YoNYdRl/g8yAwsvJOU2VTYHc6uQW7/z0wks3zr4Qn4yBBkGy9UqSCEiYGLjH12o59/riuD//dhpFaMgJAxvMPWlcPwg4g91j2brSNxBxhbEQx18RoDn+IL730bS7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7321.eurprd04.prod.outlook.com (2603:10a6:102:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 09:17:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Mon, 29 May 2023
 09:17:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 03/12] Squash to "mptcp: add scheduler wrappers"
Date: Mon, 29 May 2023 17:17:17 +0800
Message-Id: <4aa227561e4f9d1862cbffd8eed3610eeea2785e.1685351620.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685351620.git.geliang.tang@suse.com>
References: <cover.1685351620.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:4:7c::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 261543eb-0f9c-4556-e645-08db602595f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	URO5y6GYyXiNjsFn3BMs55lfEueFWryLOEJBxif2BBYCiyqLv7/JP7ybgV/qip30W3AjRmwi3o72p73VevkrpWxAzt1j3a6/NGILFmo0mME5XVZbeEKMZNUkWXDFs3KdLudefDjNRwUr5AuNTG9HlpI12cH0ziuTgVsevY8h4+wGqCKxJtcmncPtFhtEylez8+1QZGZRam3FsUIOx8yEbNKZd83HgAEoUij596yHue85OTQtWDJNMbVIKZ+7PU9Pr0TqmYph2THvFRx7P/Tr3mN9Ee9uRpV/VmfQbGMMqyUSLSmFEg7g96BUCwYpXeWz84rnGNulWYuvmIAa23UBc3uusftCZDDnA89MEE5QAacJSo6sKEvLJOXPY3qy9aT+HhQz8AIPJq6k1FjcZTsp/6U2bVD0+2kCLUqoXqQe1tbToztMu7I9aYBmpmEi4b3lLu8InMHmF/0Rdtte6535X25mLimBQmAnE59lVhWyhWtVDEFF4wCNELYt7tzGYfmzwt55pbIOacJ+y3M2TCN3HSLQMHGkFnn44JHEPBsZAuL4H1Kz1TUMds3pziJIPota
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(66946007)(4326008)(6916009)(36756003)(66476007)(66556008)(83380400001)(5660300002)(107886003)(44832011)(86362001)(41300700001)(38100700002)(186003)(2616005)(8936002)(8676002)(6486002)(2906002)(6512007)(6666004)(6506007)(316002)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5QAjL6pLocRB+mM+FWtQPtMmavSt8ozesCqipRjxUdk54nKbszxLxx7gyKn+?=
 =?us-ascii?Q?ye3hXFwkoXYAQHhtgJQJ881v6KF+ap3FAKjNpAtMIdhQsPdhOsDUNnBFwNw/?=
 =?us-ascii?Q?4rawmFVM55fJa8BqBRl81xGbaQsP1JvjnexjlMg5bJKYDxGofjyCIQOhO0zY?=
 =?us-ascii?Q?k7zbb2+G5F56OPH7TQUbjv+mguytl08pdswtfmRPNAU9FydPHsaBajVoPd82?=
 =?us-ascii?Q?tesGl8WgJHwReu9EIRWIn7EekxyqLYGU67PE2+Hb0o1XU8DaMntgUMLtvKjt?=
 =?us-ascii?Q?xEsY0tVmmKB/RsVE9+oWBVTMmSDXkQI4WUXefcwAR8qocE5O07ctiXAXYy6e?=
 =?us-ascii?Q?xj5Y3phD72q6yKJqk1r2RxgztMA8SGGVTvq78RZ08/m9y3XjLGk6gFALxHgN?=
 =?us-ascii?Q?2jmgZen9urmp/4K+Wd8yDzx1eWOzsOYtcb96GeDZ9F3TBfBsShM/G1YqgkZC?=
 =?us-ascii?Q?QtpVM4a5Zp63Q/b5S3p1ucAxF5MTIF34ImGA9PJ01CujZhc/g0OfuHLfve6M?=
 =?us-ascii?Q?UWduMrbMYbW5l7IHcbpJgkHOwb4HG+ju4MZefC2GfPNIEYP20ow6QgVfGoU9?=
 =?us-ascii?Q?86J9R8iXWMdBPDvUirvDm6uBNnfuqMFAKDF4JGiYU7qxjbh8RdYFhiNOLS4q?=
 =?us-ascii?Q?X3I8mC94H+1UpEQqmQpGncqreQGhG8Dkdt0xpP49GMNHDymNVUE0mj+baeur?=
 =?us-ascii?Q?js+WN5r6DFnKEAnPXQg/+m4bSa2rvfTDWwThSB2Cj9OmYnxRvfn/Wy6Vp1RO?=
 =?us-ascii?Q?u9cqLCdFpmvTYTmqeFF945AeewfLpBzcvKGW5yb9lAC3BtQmODmS+fJqCR0/?=
 =?us-ascii?Q?zIvbJrBeLscoaRbDjaahFHceuKtYTAg9HyWFbCMRXgT29sTXu33frrfyMDaw?=
 =?us-ascii?Q?LcTcpA2Is2XqbgYvdzuR2iewbHu9z8DG1/YO6ACyqPxfe6aYWb12HikDV5VU?=
 =?us-ascii?Q?mOzzLaV763krJjWp1nXf7oxob+GJorGRr6udxNjz4b3MKFjxXGc2Oo7hJxUx?=
 =?us-ascii?Q?1JzbEr6xzyNppAW16oIJAuNcF637oG2oLm5o6zVikmqUG4FyCW53Q0noxQnY?=
 =?us-ascii?Q?5ichNF9Cfry/vK9WC2GKznfYbW/6pXeyfpYGFA8LCYoxeA9hX5lpemWlBKyS?=
 =?us-ascii?Q?NptbLSQxflnwqnSXHHqlu1MVFpMZNU3VHLf4dy3aQ/fFUYsX/YtOboe4rguE?=
 =?us-ascii?Q?R/qsx6A3AD++q0NgMi+gBWvY79gOhfSeeU8nwX7A5dtwFaGqoRqbli6++Sy5?=
 =?us-ascii?Q?LbnB7WlsRhLc36vc/tGINDvmX8ugLAtQSmobYCdwyoM0wQp1FNtwPBmsNo8n?=
 =?us-ascii?Q?tJSKtyvhcvwSxHivB6ocLeIGrp1tZG2qxXFmedrTq5h+AFsLoaIvzm/XcOx+?=
 =?us-ascii?Q?9chkvaRqi+d6IoOjnlNxyjPwxTfzvHr2I1u7m5MPtKB5SOHwhjomGVIYoeUb?=
 =?us-ascii?Q?UYc9PzVL/gF2DXhCg9eijnnWVWogO+UGJM52O06Rc7xZvpEzAE8GQ+O6qw5d?=
 =?us-ascii?Q?6RrmgVqDlq7yVwdSMvyeBoImIHCJMB1D/YSgt0e9xC73KMjnaI5/94A+XW9j?=
 =?us-ascii?Q?7bx7Wpx3alakfDwFPw5/96nBpyLWeY+XpqS60MIr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261543eb-0f9c-4556-e645-08db602595f3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 09:17:55.0457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ga+nt/Y4NmiNDaK19ZLYPGaxxH2mzS7wmcLPC5jnF0xnBRNvdR9agb8SQxjSPRuakg3hr6j55GtWGUENihBgfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7321

Use msk->data instead of the local variable data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index edd7c92f4ffe..af5996a1d3e8 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -124,7 +124,6 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -154,15 +153,14 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = false;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	msk->data->reinject = false;
+	msk->sched->data_init(msk, msk->data);
+	return msk->sched->get_subflow(msk, msk->data);
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -185,7 +183,7 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = true;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	msk->data->reinject = true;
+	msk->sched->data_init(msk, msk->data);
+	return msk->sched->get_subflow(msk, msk->data);
 }
-- 
2.35.3

