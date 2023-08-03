Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24CA846A
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 04:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8hdJR5lYvUOSX7nULmVkXiq71WqeVZxM/8RxLzoAA7GyRkHuAojVAWWH5PWAywWSjPUFZavm6r2awY0BQmkBJMXdzJGY7UCC6Uz47BAhEW+wNIeISJtU8MIYPaeZGu5h6qUCzeUvkawsUDizUa8z7oYgebSHZONL0Z7TouAjlXsBIBwRmPVm4CDkVs22PJV6ORepuVdzf9lGuxfO32Wt871ILSmvJ8Y/SzdBwDEi4gyyPd6mwhBBntsxxTQl5bpIH5AGT+p2+2N0ulA0zPOrZKr1L/T0jIAdZIGMfwHMoykUtdNCgRRFl64rgAMyAuzYGWblxopONdVxBMfbDElXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlMSJSl1AdTlEePwCG4ZfhTYFeYrTAC3Ejsf63nVfYA=;
 b=fXrLwousuYDWSP8e4UMtqt5lokiA3bY5Mo89OBsy0TccmJ9fFYT+ZtO0pm0hQyOH4hU+aLlEzu9q3Je+7b77YCFxVCj2GhBEovqlD3+Q4QS32zPqL01C5+Nm6LI/EAWnY+/6wJZ12gxoDwOBXjEQQ4ZUN6acuq/QA7tdKnhuWueOhqFzbukRoYhyl+5T7pCNQjOWEh2dIMtPzTR552VYUnmkNwJw/2aL6uRMVwu32uYEPNOpmhdyyG8Qpp31uHWlDhQ1P0F45PBKbDZRMeTaWNz88GarI5VBk7veAPJgrKHLZ4+NfKS4JquNCdW0djiV+OIC+DDLIRdNNoJpLtNOKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlMSJSl1AdTlEePwCG4ZfhTYFeYrTAC3Ejsf63nVfYA=;
 b=29EJL15Q8krnDCnaPOXl+nPro+iBRW5OYRPpZZ3nPRjo5DrCHx2aCNp9IM/i+Kn0EAWC39G5fHBTJYJQLz0oLCfmRTadUbLQl8XMINt+lq59E763M9FVjdM434yLCNuCcxe4iFfjtj4KH+darIkq/x238TT1yuShh4joQw/6zswJg1ESdkEyByHAw2JYzCgdCA4ft7btVgXRk7jJ5z20s1/cicOjT9h+F+yI1jxRWlPBE8pj8hFyGeY6z+4POslZyyMr/6dlWewyBbG/phrqOpSSn8BlUQzTrXxG42ZB9woa0BBTzqtA05+AP7lNMqlcrbi+S7SQYZrmWzPK0TLsHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7909.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 3 Aug
 2023 04:27:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 04:27:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 5/6] Squash to "bpf: Export more bpf_burst related functions"
Date: Thu,  3 Aug 2023 12:27:21 +0800
Message-Id: <644d34afc1b3b8d72b7c87baf099417d0be561ec.1691036765.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691036765.git.geliang.tang@suse.com>
References: <cover.1691036765.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0122.apcprd02.prod.outlook.com
 (2603:1096:4:188::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 9522990e-a1da-4b64-03f5-08db93da02ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t6kEoptCXOGzaIAHqgVNLIOyDTKI0h0o46ZOmUQuBIdz13J+prqICDEtaJFEr+0szOrTVObIWvVr8PObxICZWYFutpnsNxIEcGTu6FK8e4hiTMoTevHg6ztyJwRM89jlLg1VmIHKbgUEev+capRfgA4VzYbJtuZygPVxiVfJtoBQeaLMRTZHXK2nRJLPX7ulqDhOx0K1vrL3opZPxn3NwZd7crkpg69HJ6leEFvKjT85XFP1cC4KrknfjuBm8tS/NC7nvvqzmL3PBRFZK/KtfBYJ5vcBLIqjxFxGVRNNguzH36NCjSeZSFulkKBC0bIcIyK/r7EtaTBLa1qUbdTXj76JFu1jOBO4gR4oSOUxOW50JKVUgSnerHjqIUJ+iGFkWx4soYj5Hea1BvCzzqTtsOOqnZVuhf8G2pFLUkqXD3EigUGS7pXsoSb0aL33mwwz19xUXzK1VNQeX/0rRssGbbqhqbd6jO+C06okmREVKGzdxa5zP+O16QgMz3o8axG6ytcN6m0s1UIOR4+zbnjuyX7oD+Tc63RgWE8/HNm9RLZuLilw640RGAYbXafLo+OuNDNuVuNgWEVfwXCYUXpPSi2fh7orxGv/tBzztk3IQPM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(2906002)(478600001)(6666004)(6486002)(6512007)(36756003)(83380400001)(2616005)(86362001)(316002)(4326008)(6916009)(66556008)(66946007)(66476007)(8936002)(8676002)(186003)(38100700002)(26005)(107886003)(5660300002)(44832011)(41300700001)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fg6927WPCTXKye/brdoP/zSZa0qIj9Lc4LlgkkyVAkjliVDAWHYtqfjbCyoT?=
 =?us-ascii?Q?ZAW7HHxd8zDgBlHbxaxi95VowoSFwi6cyLjOv3GqdqD6CrQmZDAX1Ged4IsG?=
 =?us-ascii?Q?3wsy5jfeisVG5X5wP7k039BPINYQQ3vjeuPI7eSQgviCbCNyA7JMd+8Fy1gS?=
 =?us-ascii?Q?oSre85jjMkHKHR32luxelc14+6zNB2VIMvUCxuXVEWLuU5TSZriBU5c4lYxK?=
 =?us-ascii?Q?KVFrE9Rqd/xYZwOoPL8xhfRGjSfTe2HxfkyC3xjAoh4pmSNEZsq6tDgNmRdA?=
 =?us-ascii?Q?b34jWWxj3T967o2hoI+l1jjQX2NG8+gCqgfs0XFsoL1FfJBRi0GOtr/KSr/T?=
 =?us-ascii?Q?YK+UQ2E9/u04LZ9o9z//AQpsIpPj6D1hkAmmYkHpWz3jYUImUpUAnTQUGemI?=
 =?us-ascii?Q?jeZYu4gXe6GIryAhDKyZb1mAQdO6fEpkmZ4Y5IR8XPZSQnDj5EKPfHJffSiu?=
 =?us-ascii?Q?vyhd2LonX7fKmLQ2iuZzfcY9gJvye8NYth5bf8dzTuy49t1O4VQbsbB+UG3Z?=
 =?us-ascii?Q?2xH26Um5cFsPiTxW1sykL23q794vpi2CBjOJcKlRYu9iUXmDpqV9DgHrWKtS?=
 =?us-ascii?Q?p9xvVFCs/dTo9/QVS+03MXiWsv8iFcQyrnyYeJU9ebSzxMmpk/Mr6oSaZo17?=
 =?us-ascii?Q?eYVXVU4VoJ0RYaoIUTSbku6vRcLPlzUrokkDdAV01by+gARQU5sjTakRM/v4?=
 =?us-ascii?Q?SjqlG1kFmtS92Yvp2xYNJoY2dtxOnc8RV9dJBnyZMXg1HdHIcYvW9hM3cJyq?=
 =?us-ascii?Q?5+duTOjQ533O+8KVbjKlakcP/aySxxCcwP39B717588KkhTBjx5+JR2PZ1Vc?=
 =?us-ascii?Q?rRO6eCt71k45X12CPaWRtL5Wuy0X3HCJlIvhIay6Qo1D1RNDEZmi8PRRxj2i?=
 =?us-ascii?Q?71q+wvQMSeOR2loFxqHR4xoU/O2DU/bmXSMASO3EI6COMEgJA6IeCO0j4ywd?=
 =?us-ascii?Q?E35NrGc6//fEx5U2f9GZ1vUMo1u2BgEAGLR5RXpOjspyswM3D2+midZJEaVs?=
 =?us-ascii?Q?QznVB5o1x9ePew6TsgZA2gPMZ3Te/dVViewXkO4Oxq8Ickt+q12cDSjqwZcd?=
 =?us-ascii?Q?exSdbKodC3hdfltgezLkELMy0fnjtboAAFGgWfKM0kCakX60u1glfHWVi06J?=
 =?us-ascii?Q?4uQOr9qzmldYjamEgUC6jB0k5knJn0il1Ig4o6g7ro3Cap32cOhhlv/rDAJn?=
 =?us-ascii?Q?nJzrS1BQ3yQYqN72PFU7a/odJpahv/mchlUECzRakTvqQHOyBpFynYwJcN8h?=
 =?us-ascii?Q?aeBOGR4bILaB+kuaTW28dRUWfs4rNBJRwnvGlJnpZvjh3F/xHAjVsCXpJvcm?=
 =?us-ascii?Q?2auCMoGG1GlSdO+zSXy39UZ3PIHSnAUFbgUS8dCoz43dAucR7heyZ8HJ4n/L?=
 =?us-ascii?Q?xAB8fzO+t4G4WXwsfoWyzgom2vK/CRVa2tfgJcwQHdd3F5jqmaI3Z90OQjG2?=
 =?us-ascii?Q?twhVgx8EihP1hVRIZJQgNuiOf4DZpKpay7g1qTviI2zsOI1T89R6ZWh1Yz9L?=
 =?us-ascii?Q?iZUF/8tJScZszWSU7UP+BWLpdTdG289H1DJSjiBOGuF9KKuHnp9wCRrNoksz?=
 =?us-ascii?Q?4UoLns3wzb8tK5Vvd0CO7htdL7uzY1TxQURL9ciuoodabDc3mVT1Q2s9Eg7u?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9522990e-a1da-4b64-03f5-08db93da02ce
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 04:27:56.5292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8M8LbZKt6TNTRKeW3NfSsbjjc+aYw9fEbGy2Fs/0N+/kkPxax7iAUihL/rqrNE02DB0SGPTWPx/yPAoSYFcveg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7909

Add "ignore -Wmissing-prototypes" for bpf_mptcp_subflow_queues_empty(),
drop the declarations in protocol.h.

Drop bpf_mptcp_subflow_memory_free(), it will be defined in BPF context.

Update bpf_mptcp_subflow_queues_empty().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 15 ++++++++-------
 net/mptcp/protocol.h |  2 --
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 2e1a228a2ab4..a48ca9ea55cd 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -145,16 +145,17 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 	.name		= "mptcp_sched_ops",
 };
 
-bool bpf_mptcp_subflow_memory_free(const struct sock *sk)
-{
-	return sk_stream_memory_free(sk);
-}
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "kfuncs which will be used in BPF programs");
 
-bool bpf_mptcp_subflow_queues_empty(const struct sock *sk)
+bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 {
-	return tcp_rtx_and_write_queues_empty(sk);
+	return tcp_rtx_queue_empty(sk);
 }
 
+__diag_pop();
+
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
@@ -162,7 +163,7 @@ BTF_ID_FLAGS(func, mptcp_subflow_ctx_by_pos)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_memory_free)
+BTF_ID_FLAGS(func, tcp_stream_memory_free)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
 BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ba6a63e6d39c..4572f01b978d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -642,8 +642,6 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
-bool bpf_mptcp_subflow_memory_free(const struct sock *sk);
-bool bpf_mptcp_subflow_queues_empty(const struct sock *sk);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
-- 
2.35.3

