Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2057.outbound.protection.outlook.com [40.107.15.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820A6363
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 03:34:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg3pXrLLTguNiB0RpdeA2xjQx28B4I2n0KWSo4pW3/j6Ts22ObGh4mTHqwpJYHrjKi6Q1IIVEPjEko6Q1UQvFJfZIXLCpr0aGdnwvsOSWuEc/RYgkDVf303uzk5XxiVaZ+5jN/hcaJtCR3qUZ3BXdubw9Bk3Rl6s0iOKAZhxIvppobIGxVY6A4DqrsJh8T7qrC87v9QHRoBBMwlnq44TkrF9PM/av6IrVgqTcZZnUs8R6HFB3vlAMTZrE4whXfFH8WIwhMhiH7cX0iUnEu4QXtokRBDQ6UzxNnV1YDqcELOKa6iwmrvKS5/IqgEFFRMBv3J4AoAz4G2TvBS1OAfwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHd8dI7CpQCS2uIvUnBDyckRk+CIsnDoLCwOw9KUFTU=;
 b=bRVDsZubExzQoTu42QqprFQ7vJzB377mpLd+SeKcWgEMsHpmD5BKtInnLOg9Sp/4Lffr2hPKFVwhNJUL3kIPUilp4la591cy7n64lMM+93jAqYVqFJ2Jxgv52wCHp3nPNF+88Iaa36nalFMCT6JX87/Vx6t7panWNy8k68nkUyFt4c/nPfwfOZkfIl80V5NXFiNsjbuBcjjw0fwnKnC88CKsQEQTY5O/dAn2KqnUe43+fTItVokYutE0UfAdfq3YGudGy/Ebxw1lCf/FqiA+g+QvY8djO4xwyIc0uFYxfyVsVldVFMfapsEZ/3Mpjinp8DujJo67/+OSOR7AAwi1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHd8dI7CpQCS2uIvUnBDyckRk+CIsnDoLCwOw9KUFTU=;
 b=f2IdYnpcLt3EBNezZErE8XQ8Szzu9nJ4m96+2vFLnXrJq5uMBLBjfIZCMpMkjqWSLEwy3ybVU6TzzGvYxXkETzVjSJoo/PXLELo2bdV5FZuhOk71Jhr25SyxFz3PAmpl92Hb8yqmCsZr9jfZx/dxWDyEZ6izLbj8hgn99rp1VLgJPqXOkMMMgMSKXEJxwZIf8ggE2/8DUgatvv3ebnTXU7JbkfcGufKXe7qJTod59GhXZV/q6HYLP+GQG9MqpsLDPYh3CkUkn3azFpWcO2roiQ3vdGBZRvJrJEe2I3oiTel54+wtYm/CxgDGZCLxuSDKev16sTaK3h/MVilARApUew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB9189.eurprd04.prod.outlook.com (2603:10a6:20b:44c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Wed, 14 Jun
 2023 03:34:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 03:34:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: add mptcp_subflow_ctx_by_pos helper"
Date: Wed, 14 Jun 2023 11:34:20 +0800
Message-Id: <cadb420a03c98ac7099fd2228745262626f8ec9c.1686713645.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB9189:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f82630e-95ab-441a-34cf-08db6c8842d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TIXWIScheoKpzTCyFcIELUmTJxfnW9nM0MrspLAOEfu0ra54VgphGhENozQ24QktOMWLBTPJsW39ovbVL+k6qMvH1REmu6Gz9hx0TxoIKJ0zmqweMyBHOJB5/KoApHDAkV0PlaVcVYL5mcIWejB8g0GP5NerU4KUWEETcXepfZI+bIj0AlzNklYMd4UrlDTu4kPyZFPgwuFC/K8Cn8iyYt+AkHrQW9k4tnZDUrivniiBmw1am06w0huFnNq7x+kBj6YlviFdqzuOYaGS9e1tX7gufadCU2SOEEnAdNpsj5T1zykT8p6UDNvTT3O9aXa7T1g3RYKHuA4lylGsYYKG+m3UJueJ5eqjBfbJQzUsqNmFokS/2ziBYLFhBysPZcbnexd7nilHydjw5BVkfufv61Yizr7vzJ3u1+8It9PGtVLIstn6P7DhhNmDQvndeqigIF43z7LtlgHr9J/NFZ2VroW2rfa+2OCCoaBLtQ511fpN+bTOBYg2vUgX3YGDSnD/bXVPUtxr2YqJwaD3MYgRoYGB59WAuhekS9ifN/vPhtcI87bKB3z99nCgQUZdCOKq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199021)(36756003)(6506007)(26005)(6512007)(186003)(107886003)(41300700001)(5660300002)(316002)(478600001)(83380400001)(8676002)(6666004)(4326008)(66476007)(66946007)(8936002)(66556008)(2616005)(38100700002)(2906002)(6486002)(6916009)(86362001)(4744005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xf91XPKaBj/3XYlP0HxAuMKXVr66jWd+K4wfqNhWnoMu/mYV/ExlioJuKBnh?=
 =?us-ascii?Q?z7b8wdi6XCGLnUgnxnjq2WkyG9zpnFI+HcjSiLJzA4IQl054s4xJcde2srsX?=
 =?us-ascii?Q?P2tE0q4oZuud22WPoIh47sjJD56WbdDwgoZ8ZW8d9ljFNBxUz7n/qd9eERRK?=
 =?us-ascii?Q?VIdFGeXdETWRKy2mCZ1pKPJl8H+InszN6Kf2HOgHE6+TrcuU5ooBwq3I0+CQ?=
 =?us-ascii?Q?unMN4frxqJw5/yAjGDNTUIfZIcHMNlp+N0ElGxrQRkRizhZXqzxOb7F4kycd?=
 =?us-ascii?Q?k6iPFEQU9VFlhNx+r+vQrwRrd6tBMt8aoEfVQO2yd8kyrMC9ziAKcV8hGSos?=
 =?us-ascii?Q?CmkpalU8IQxEYFiR7cpPV65vxMg5bMkP0Q5flrhqHy9xCeb3L6UMc2pz22ZW?=
 =?us-ascii?Q?aovIoARECl/yWJ1KmlM3pZtZyUz3GDrHEOu4133tMnqWUkE7hpxBg89AMwcT?=
 =?us-ascii?Q?8SRZBVNL46TNafZZo8bC4zuFgc00jttg0pV/IGoafYecSqYlEeBHBJncyVU3?=
 =?us-ascii?Q?pRHdNmnEM2r/wpc3v+8mFK1847Lpu901qiosm5ajJ1cEQiCv0jzpWzKqr21P?=
 =?us-ascii?Q?oGsza+stmuxdqmw/dEUiwdatOhBdkA0M64NRdC2HQBybG/U32fv6vIXaPyrE?=
 =?us-ascii?Q?MJAz/dfUZokl+c1N+NNDw5zj/Hds2597eKQOSqtr3XRBLQ/G2mJXwq0BPYja?=
 =?us-ascii?Q?pR+q+5yNjHOY8Uj+N88s+KmEuRqEWthfWIskkvT7lRK6OrvwNMHgk0Cqrulc?=
 =?us-ascii?Q?KOEjYibqdPeCZq/dZey8Av/WoS6sX+ymtZ/HwoJSOdh/dNnwxQgYJgy6gq+3?=
 =?us-ascii?Q?5C2IY+qBDO1VYiNzWrWZXZDGa+M/WbFw9r8WbJNkxpwkvtH9D7MhGKTNCARD?=
 =?us-ascii?Q?JdJhcDiqg60bH8ErHRd3C1LjDLeSOYV2UOozW9VfxcgS/q7Z60FH8ckA4imy?=
 =?us-ascii?Q?5FsqhIqiUbJMZ9UX+MOmbcV4aBFJh5kMiJ3WiVn7vPU6FWY2xDuAH9Ti280a?=
 =?us-ascii?Q?P0C7I1M9ZYj/0/RISv3CxIfIqtpz6PNmZHOMBepBU1jNgN7+CxOuPHyhPtkZ?=
 =?us-ascii?Q?gyYDAemXR109ID4iB752KTarCl/1AxkE3f76ZoyHbTOYhRj/8LrGw5Zex70P?=
 =?us-ascii?Q?YMoVDo0yl8lqM3t58KnXgySsoKbyyGIGkIdxSjG8/msThQwv6OVyxOcxMfPi?=
 =?us-ascii?Q?lv4hgWtRriwkdTme8zwK1+zuWsqYzLGUSc5QasSAYt8CEjIi4vBpc1n+jTGY?=
 =?us-ascii?Q?Z10TMiB45c7SJIw8cwsXvB8e41bLDEoBIWAN7JRawWvqE9zjmDu0Lk1uIW/J?=
 =?us-ascii?Q?vHVAx9abu1oaAXiZuiu7bpt2fJlubzANdEGo3mi2O7btRAiBNJIQyMw7mWNr?=
 =?us-ascii?Q?1bPspca0xO8pqfsRx0FobYAiJG/qrmZhzcu7jI7FZHWSHYLMWcTdnqroZ5tz?=
 =?us-ascii?Q?qdVXLmM6PzBHyIatkMtBw8tiRU1GzxZUDGTjw98xKjQWHfenJWcRJ3NfV4AD?=
 =?us-ascii?Q?o8peu9CcCKRTyvoprJwqRh072ZMjBXDjNIwSMSY2GwPV3wcFMISORk0frRvd?=
 =?us-ascii?Q?O/p+NbqhEkKvCyM4I3otu2xCtrboV2QJ2IZUtiiJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f82630e-95ab-441a-34cf-08db6c8842d4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 03:34:29.7381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkEzTumN1P24xFAz3rHmBosWAN7pw10Xx6+K+5JUv2H/fLXx68R/9OMkTw4SWTGH1cH0MNPBzCi0MI9Q4i64sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9189

Move this block from 'Squash to "mptcp: add scheduler wrappers"' into
'mptcp: add mptcp_subflow_ctx_by_pos helper' to fix the following error
reported by CI:

  net/mptcp/sched.c: In function 'mptcp_subflow_ctx_by_pos':
  net/mptcp/sched.c:122:19: error: 'const struct mptcp_sock' has no member named 'sched_data'
    122 |         return msk->sched_data.contexts[pos];
        |                   ^~
  net/mptcp/sched.c:123:1: error: control reaches end of non-void function [-Werror=return-type]
    123 | }
        | ^

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4e42f52596d4..bda91399be49 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -314,6 +314,7 @@ struct mptcp_sock {
 				   */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_data sched_data;
 	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
-- 
2.35.3

