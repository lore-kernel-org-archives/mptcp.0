Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA67FA
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pv5O0rU5teRud5CjuHgLpO6mcWuwbjYLw96DvCd629BFGGf7m6XhIGOlgBaE5tDcn+XahrDg/1gNJlpKAtqITof49T+mmUZ69ceBfrLT6jMUHRa/NmVNKuv7ZY0lthW/9TDnblAcKbImsSuYK0ZpK1IEtJInZZLCjwjY3Zemk4C/ufnn3NCp5EB/IhqTM465BJIVWJw4VX3ur2uIZ8KCes3xpnPQwoMbCAFYPTMp1ejru9myNBp0BuxJyhebWJq1S9HJCX55zuVZ604sy62Tr4xKTTL9ARbCvO3dbMJoluuCccskz2Mk/pcfn6XfUKZkgNrE/b8P5THYvGCKHWPzLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoCe9mNdYhZiYs3W7k3mdx06wExbbsoWj5FLAT/fCw4=;
 b=Zf0q7UApwG4as0x3bphT+4/S8yYR2Qat2OWGzpOyPBhwvcV9nImVhLCD/U8zxNKfhy83F0p2sJ9mZVJP0UgzzHQ56CqQAgtGgArjjr8r+F/O8DVxGVpkeHIuLmMY1+ogRVAcTmyNqsL7L2sH/Ww+wjWhMm3cSNRnPi1YO0ARXIiRgx6nqBcgls94tSQ6FWFwyIiOlkA0Wr9HBGbpzSd/0ygCzdc5GWlzDuQIdArvERKLjmWM1ayVsPwjtoNcoug9liaozSIyW2zej+zLGIChdP74VtuwqlNHkSh5ewTU3TgPjXbbzt5lkUzfztsPOfH5A7eo5MzlPC46aUn13n4WNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoCe9mNdYhZiYs3W7k3mdx06wExbbsoWj5FLAT/fCw4=;
 b=eoFZWgKb33ILib8rPiqpvpieyfxH/4stomi6ptRnupbLRglUSNJoQYcqhUZsToa6kfpezoqymkNk6e74Mnb9pzgR+c3rtzY8lUk9jRH+cpLdkjzDj/kcUeTHVbY5m5++u+Fy+S0+mtKCOMH57PGlCRvdASTmkSKZl96dhhp9+a3ZEMjDWVI3ita2bcOI0d71shhJnfL0dgob4JrR/JH1nc7Xe5lGCWv61NFDad1s5dffcNyLwwdJ723SRPkzVbEmwqLJMDWFlnplOY7TVTsOOeXs2x3EGqg9oJnb5PFIrMt5rObE6fM2Xe6MH7eOFEJsKflwr0yohlu3EPcztZhhdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB9922.eurprd04.prod.outlook.com (2603:10a6:20b:67c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:07:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:07:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 06/11] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Tue, 27 Jun 2023 09:06:49 +0800
Message-Id: <bca31955b83c2e4d11677c12a7e0e6a5d2ce5a80.1687827857.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687827857.git.geliang.tang@suse.com>
References: <cover.1687827857.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB9922:EE_
X-MS-Office365-Filtering-Correlation-Id: 13de149c-ac2a-461e-d4aa-08db76aae7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IoCo+A0/c9j/T9JVpjIbsRHEy5lxPjWM7qLvzNxZzpRcKyihbtf8dunfntEo94MyewbDO0BALh9Z8Q5XZHM4gU3cKNZvvNL/7+PyQ5x+VxmjH0DFjoykcWRfYmxOkb91lIrssvqGo4iaU80DiboL2xosK1UXa1rpBrNaZjDkyIqUYMVQVJsTlREnBUCk0dKoZw+GB//70t2XY+Krwge028egq3V4Wgm9KHB4cGfOKhRQm0rBUpCK2ldGDs+rEzqSQvvqrKm3dpdQZgiSNxacRpNooTQLo/rDwyBZsZmwbY+BWvpa5Iivlg84Io+HslHqX4TDcsv5+sE1pYBoXA12NSPbIGqYNpAWfBx/YN8H43Xczy0wUa636gUL7yw7CL/n4YzwVeX+BYUsZ0TGJvoUKuaaU/fvSO4+KL8JqRVTtU9Eo1SjxnKIVNClRbjPkm3oioGNKK5l3poZRkfGSgAaUPwbIIXj4Mr6aBxdlxJo+PwbRaJmGIDJ6NK29bHXCNWW7d/CDstGMtOVeEtgFXMGVOHGFo3v8eVvju1CzctlbbiB8Xcyn3UXB75av8vL0p2o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(186003)(6486002)(107886003)(38100700002)(2616005)(26005)(6512007)(6506007)(4744005)(41300700001)(86362001)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(6916009)(66476007)(44832011)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8pCm52BIPqAE4GqDOzfOvuLyM/YE13NGTaBHOM/nwAU9LYdIjsea5Lo6hg2y?=
 =?us-ascii?Q?tdfDjwbePyC3kPvgZUOr+XudsFdoOU493gxfPfTPM1B+WOTs8ugi1Q4jdubz?=
 =?us-ascii?Q?UBpVJOY/6CWizB7+ENl5GpZ6aGHlxjJGz4ky0v73J1IcYtHqTY2FgDfRAPRj?=
 =?us-ascii?Q?MAQg4W/KY43rN5N/G+HuBnDgHjT4IpKsiZlgWm6ool1kA3XBdbtdjtvLUBNh?=
 =?us-ascii?Q?7yasyvg569ZFXeNIXy2bS4SiwP4lsLuN//XOsG5VN320qtV4xRdc06dkfvZ3?=
 =?us-ascii?Q?aInebX5tinGuvxwvWM5H2IHqULdaG9sXTz/fG7JtFStNNC7idyLt2zs6iyLb?=
 =?us-ascii?Q?gAsBID91RfnCV4q5tyGgkdk2QwYumTWM+BNxupOjzYmSLhY2JzxoMMs1mvCw?=
 =?us-ascii?Q?fmq8OjMIBhj/JOaWqFL/42zOYx6vQIggDoB62DnTnGeKCIRghcQNzxv5L9mt?=
 =?us-ascii?Q?FwFzc7gw7ZJrWN+28xIYc7zGu8Q1erN8dz1AH7UIFnY7Q+ReswxDpWp2VgTi?=
 =?us-ascii?Q?YHPBVCjibrcU4RTFwjl68/zStlckj3cVnkF34rpECQclr710dYyhWIjra/SX?=
 =?us-ascii?Q?NbyLf4I/f6+lFlDpXVoDRk/VJnm+DV06sl9Hgj1KRRKfX9pX0hog5myaBo4c?=
 =?us-ascii?Q?0cqVjxTkFhMpe2SathTot7dHi9KI+5S/xtVlm+DX0Q3ppjLZurk0kf5IPQo5?=
 =?us-ascii?Q?e4GdNmtn2IfXcbcfHNmKYXLrrbt1dN0DiboAiA7WTrzJiwWKy9bZ6fgYBeXy?=
 =?us-ascii?Q?W8zQaMdhd5/NBu6kiA1piURa8X4ArIdZyHhUd70yDgMnqhrzldMuk1otY3M+?=
 =?us-ascii?Q?Ok3U7VXI1wQypedAW1nNGDjAKkjRQqIqxiaD1/TBuAxOsKICK/frjP+gdt4R?=
 =?us-ascii?Q?TEViWPK3eX5MFJ8zgD9kVBiK1cj2Sod7TW6wFSijlu5m3jKBf/5MhzJHEyI0?=
 =?us-ascii?Q?hgqfoghnszPkOMqU9mQu1NZVD/fFly1ZE/8QDxfwXeZMLxwzu4dpSQhjjY95?=
 =?us-ascii?Q?Ilrz10JYeR1mJWUNEJdKv5cLefXllwkFmCmyfgawAKK+a+4SbT5bP/gmHKyP?=
 =?us-ascii?Q?2nWECeY3gE+CZ8hOpR2JVr/TvPUXCYQfoZMHvPzdsAPyqUGR/Xcov7gOJTNU?=
 =?us-ascii?Q?BbTZ+QAepwxpy6wY8c/dJ9S1aHsvvQEGUw7xuNrAqWH5p4Y7MQojvVJqlykt?=
 =?us-ascii?Q?O8vZv7D6IzexddcTDf38YBws/x+to005vgmv/L1oqV8UwnB+T5yhoEmmVs2E?=
 =?us-ascii?Q?NyD3MopKYemR48l0IVTw2pCjkJmd+48lkKas+cSRc7TW3vRqGD/CLtaKESfO?=
 =?us-ascii?Q?OzaN3mLksHZtxFscjJrnCkAfdvSNnyTpn60JAhvVnLokYPc/DXvtSm5PDY32?=
 =?us-ascii?Q?9xrJg/yxfFu9CDrWk8sATzheEHwCs+ia3DlnmSAT8asWmtHMqsn2AbQwKTj6?=
 =?us-ascii?Q?T7h+t2+Uwolz0L1KoSntqA5Iq+sjzryBg6tznZKAVh3Ze60FG3LiNJdtI0UR?=
 =?us-ascii?Q?5AZmZAci7fPLvDCI3Q3TWxWGOHv0l8o+dbu1LSCrNZvo7JdAUi/+KBkBo01F?=
 =?us-ascii?Q?CZwFzKdL0t7r6PLfnX2XGN85nnOr+5GPiU5ulkmP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13de149c-ac2a-461e-d4aa-08db76aae7ef
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:07:41.1969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEilhlNWRno7W20AF82p/eB+SuguT8SfnCVfzZHUNa5J5CM9tL/V5RKyDOkS7NElHBxaCu+pOgT7bk/UjRC6Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9922

Export mptcp_subflow_ctx_by_pos too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 204dc37e31cd..c580add9c7f1 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -174,6 +174,7 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
+BTF_ID_FLAGS(func, mptcp_subflow_ctx_by_pos)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
-- 
2.35.3

