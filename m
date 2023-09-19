Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969BE34CDC
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFNgRQAB388iKY8GlQpX1ULCCiMDA2/7XFieFYJrsjOM89EBKNj7/v65qQhN9YMRMThpOH+MUEV1XugAbkEyv2XlvJOiv3kgQPeZYpUheuD7el2YJVWesf9MLGeQdGpLGVgxnL4hGF9GDpy9WTgzlslXhrLoX2vjuVXQiHYYF44Bqa1adty0qSTL6wjyCAnq7ATg6ec0EhgisO2sHgQDYw6J7KP0vICr+ztoFhfjSbxjxmDbL75no490NWa2XK1fiCt+61pN3mkIicnaQ/HplryAlGdtOrv8UQO2r2Gp0oOzIQtnArOccqBUJQ+GlzFnvZ1AIXx+IeialRq1Aa5pCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GuXRKU0kGKFBbQTCAFpBu1DJOiuIku/r1Uosa55Oc4=;
 b=aRn9L//sNR0qUk+lDjiBQISOzwMDn7V7tBQmoIg5EHvz0rtGyQsrmxJrfWai4OoMLNDWqOV+RUNIlu1GeHcUNzwzi1u/VVVzNT0jOvtFXcxPPzfvNxrdAWIlkY30TBsGWAA2h/MzYAXqAj+WRSbIacFB7R4h/BM6BdvTkDyMIP1UiSwIq9YeVe9F0gK2NpeVcVJdXS/VU1/iup5FN3QAPfzvy//xcG0lZL9Dd0znS7BlZ+guBuCQAxniAlaYLvfZfoXguknQLjviqHLFzIgsXSA3VXbD8+VBajGNlct0FDCoMb3cpocyDI0siqvpkJXBCP14uov5GonDTPC+4mq9bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GuXRKU0kGKFBbQTCAFpBu1DJOiuIku/r1Uosa55Oc4=;
 b=lD6X94ldEGJJBy6l0wWNLcY7R1K3OyEu5rM2OXNnCrAqhrbVMqM8db12WATP0OQ1X3zzwU72VL3xPjHtF7wYU9ATCTJyvWRs/+ZS8FKj7y76FoB4uAnLZbDQtRjRjGW+mr6KeikZFeoWtEGKl9KzAfNd3lHBiv0ECWCft63zK8FK+nJew0N+oLv0Rl2oGkhXV3bwCpRHNSVUDNq/Rm3/V2mZpM8oP1D8m01Tgb8a9T2j9OFmxt5KfSDucuvHev+2N0vWxlk8zTUfN2tR4YKpAeH9vn0s5tku7Oc6GiEb8lvMdHop2xSruTGAgFmixPl9xsosKP7gnjYg861dciOByQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:03:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:03:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 09/30] mptcp: add mptcpi_subflows_total counter
Date: Tue, 19 Sep 2023 12:02:10 +0800
Message-Id: <b717b226e7e65472fdc8784f872aee886db401c8.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 55205c88-fef9-4203-3a46-08dbb8c553d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iClIp9G/x7X+zX4AaC89VNZoFpslGXbwWXeeH0ngti0T29EGUVD3+ik0kYTquSCXdzo4vbctqsq3QIwnnwSgVeoD1oz/ZgeX0A5bYRCD4GfUGFi1BSUxB0M+UxtSd18t1Cb06MDWZKqyPR43Pzqf6sj4r72rQgb+wqFYUB0BfMcGODot+zo2msdTNtd2hHxyY/KarJKeKe/JQA4cyGbOUHeEQk6crlwMNin0bIpEUJlHWG6oJxcuH/05Aj05e7ZC+Ov/U2Ir4SRTQPRFEF1rD0220KH2zD8PapVDcbyTtz359QnykHjVmpoFXQuOMLNiXb+H5CQhK21zGrMVupHYY2mh+OxdU5Ufw+hmpNRqG7rFp8w5N7uU9TXZAb+nr4YicPWsy4CDfPxX5iK4JuOL4yumHBrPjZcZSZvnpA57BWy7NZXrgUUbEvAu8YTp5yrdp9tAlguwWHhv82h5gFnMQwPehsN8xUjIcbr0Tw3Eb+nJl45ZDmNfGyjtdzpdE6oegRP8WzYJ0qgfUMar/6bd0IcD0QOpCiZ6tKFwIrEjTNhRjSCvWzGUds7Fs3WqQf9u1OYw9JRvq3vDpTucOFOjgED7gO6KwLF0zDZxojIji4A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(2906002)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(86362001)(26005)(478600001)(44832011)(6666004)(5660300002)(107886003)(966005)(8676002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rUro7I4rI6NeNWIYX2i8QzCFQuvru8nntCkJm9u/RzdRDJ+ZgeXU/8o4Jid7?=
 =?us-ascii?Q?S+AhtqnhWh3w6kwVPAam54FUyEiM6KJRl0J4o4a24lH8UYVxdHJ+ew6KsdRx?=
 =?us-ascii?Q?oZ2pW6pjuGCzB1zsxyM4XsVDBniSKwyeqPA1Q4ZP4ggJzyHvIBVzhlU3gJBT?=
 =?us-ascii?Q?S1w6nvhj3OfPbeSNXDNcZ25uIzxZ83K0ni81EYfNqPUcjz15koJRwj039eU+?=
 =?us-ascii?Q?FXFZu2465PAI+2kiB196qOgBlBblNo9hFkRAh+8r3Tp5bnd2Xb4Pp6hDzmZL?=
 =?us-ascii?Q?M2N5COq4yu28u2skI5iCYpZQ84iMD+S0tfQfpWz3MMQ7JFCcI/3SjY55+cM3?=
 =?us-ascii?Q?CYbcRltY5PstiyuBTsT6jtGsM+WXIBoG+zmXEoVKlmUMZrSMX3i0vBha2M4B?=
 =?us-ascii?Q?yk/3f+emYyguKn6hKnZfLM9lhrMHW0mmBIwpl5gZKwrfQRTNkV+1QPqerQFC?=
 =?us-ascii?Q?3+dpgZw9QtixJIDygHwO6jXQzY2SKHL6P8f7MLKPyhBpWnI0cpcVG6BPg8jT?=
 =?us-ascii?Q?W1hhQewxosecJ/hIlZ3TorZZ1Pp09txvhDqQo8Ad4dvsq/8BS7C6H8sCIZa8?=
 =?us-ascii?Q?1ogoKjdWVuvSJvkaac803GrJPrHdXXWaFq2J+ffS4MzKJVAOD7f0iUi7Msyb?=
 =?us-ascii?Q?bTHgsx4bfqR47WB5WOjQkaGF37kPrSWTDswYQd/b2o0r9wBQs884Pzz9PZv+?=
 =?us-ascii?Q?yeCS3+nP/Ng/klYbakj14xaNupRoTA5VFsaqteLx78H3nsB3o5pPDC/Yaalr?=
 =?us-ascii?Q?cTH+NvV3SjW5EqbhO7vRPjseDDzOcA96k+hrTu+1la3zrhax2rqE2u1u4Y6c?=
 =?us-ascii?Q?sFrhDZajnfZThb3QrojI/xdGjET7q93x95UwegNJpMNGLPkMf3km9kaRAdn4?=
 =?us-ascii?Q?Vkv42/1xzWiVCKB6umDxF7w3QDKAtsYobSBXTgLHK6VM+AQ/3r+reGVhRibu?=
 =?us-ascii?Q?XE4ttydiFfWHcru6n9egURkIuDuVqo3QYDgCmab474ibC/RDLcehbuZx7WP/?=
 =?us-ascii?Q?KYUew2dmvYFiTn/+BqfEumQBmME+h3/si54GuV7Sy5sBJKnxeTl3TPMgb6VB?=
 =?us-ascii?Q?bciKeJ/2aZSqZErXSKOp1YxpYjGCwjKhhaQ33JPviFspM4B1FqXOtRRvacbp?=
 =?us-ascii?Q?GgDyQshLXmABt5jQA8EXTuC4CwT4TSzLFHFQYtOxtVqCQsMvW0w4vqk/K8xe?=
 =?us-ascii?Q?pieMWzicHQsgWUHVYiyuVUG6c68h/ndlLhqyfVVgbkV1OM/6kzrEIRqHExYv?=
 =?us-ascii?Q?087fZoKOv9b0VBy/NMD6yBGEdK90IPA3kQdAbF3gBd4nUt7el6qlIKo+nfVP?=
 =?us-ascii?Q?tcVCvH876GkIOycCemlkCckp1XsWO/Q5LEYb5xpIj+/hnJ8auOkFGrq5lV/g?=
 =?us-ascii?Q?6i842EZOx6OVHU8TQvsVH7NFf6KoiA+PmKOLyiCWqy7Y3uqRqHBUo90xrv10?=
 =?us-ascii?Q?wrYWraDT1WndgFG3PWn1wsFRs55DfKT4I/FMq38quL4rflA74WPao0wRWSoJ?=
 =?us-ascii?Q?myquiE1cRJNM0FzXM46kf5BRA2pWvZio0Js86I7fKeUE2xf3Wf66wVYrbKO1?=
 =?us-ascii?Q?vQKTEtTwRfE9xlgjFfx5kMgIy1gXmq3QCNp/eUhA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55205c88-fef9-4203-3a46-08dbb8c553d5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:03:05.8754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChleWEWWKkqJks8ereOSh/LClwEB31hkRGXQMkBMOT1GKRhgnk3BNY11WbzwKo8ds8ppw7olDTZGbndGuIDcsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

If the initial subflow has been removed, we cannot know without checking
other counters, e.g. ss -ti <filter> | grep -c tcp-ulp-mptcp or
getsockopt(SOL_MPTCP, MPTCP_FULL_INFO, ...) (or others except MPTCP_INFO
of course) and then check mptcp_subflow_data->num_subflows to get the
total amount of subflows.

This patch adds a new counter mptcpi_subflows_total in mptcpi_flags to
store the total amount of subflows, including the initial one. A new
helper __mptcp_has_initial_subflow() is added to check whether the
initial subflow has been removed or not. With this helper, we can then
compute the total amount of subflows from mptcp_info by doing something
like:

    mptcpi_subflows_total = mptcpi_subflows +
            __mptcp_has_initial_subflow(msk).

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/428
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/uapi/linux/mptcp.h | 1 +
 net/mptcp/protocol.h       | 7 +++++++
 net/mptcp/sockopt.c        | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index ee9c49f949a2..f89aaa67f10d 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -128,6 +128,7 @@ struct mptcp_info {
 	__u64	mptcpi_bytes_sent;
 	__u64	mptcpi_bytes_received;
 	__u64	mptcpi_bytes_acked;
+	__u8	mptcpi_subflows_total;
 };
 
 /*
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fc041763dcb0..6ec1d967f22c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1031,6 +1031,13 @@ static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 
+static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
+{
+	struct sock *ssk = READ_ONCE(msk->first);
+
+	return ssk && inet_sk_state_load(ssk) != TCP_CLOSE;
+}
+
 static inline void mptcp_do_fallback(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1ae9fb6fabf1..d380575bbe69 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -934,6 +934,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_bytes_sent = msk->bytes_sent;
 	info->mptcpi_bytes_received = msk->bytes_received;
 	info->mptcpi_bytes_retrans = msk->bytes_retrans;
+	info->mptcpi_subflows_total = info->mptcpi_subflows +
+		__mptcp_has_initial_subflow(msk);
 	unlock_sock_fast(sk, slow);
 }
 EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
-- 
2.35.3

