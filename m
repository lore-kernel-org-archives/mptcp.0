Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140042.outbound.protection.outlook.com [40.107.14.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D908399
	for <mptcp@lists.linux.dev>; Sun,  9 Oct 2022 08:35:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVtdvVBWz42BFKrJc/nsI5OcXfbExoeTFj0dzuuBGpAJzAaXESEIuBtNY9KXQF+KdYOqs8QeFKtoKWKXnzoNzEfxPEVdgd96TooLckeTSvqFjPqJK76Fw4G+cbnn8AU8/fGKyxEMGd84nbiF7MKs6YFyIThJseGVSvVd5hxlMi4M/VW7VcAp9wpIaD3FpZhvOf5obiqV0D2zoptG7sGhB6+8hAFcTr+uw42tK87U5/4uMHH5J9GxDuENZXQPeznPycj1teNpRJOtwO6LlWkGb5c+orhg48hzPqM2ZDKsV7FdDU1M5eIioEhIcpnIbPiMaOs54WmNGLhviY7k9C9eSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrn2h6bXiAdaHEhaB9LWt6q7blWOMYho87J71MecUrg=;
 b=NTcGDvrDVVHvMxVECXNX+y8c2qdk0w73ulJT8iHrEtxguaXKLnqdMnyDR8VMdpL6AhyqR8buUOudNftyvdCMvlPjnnZQCx9Jvi+tX0E1T2yUl9aOGNhdoR69OF4B+Z1UFBvleYBWy43mzbBnCxdKFfOeVqOrNISOCXYgNCwWC5m72g3xzbDqUj5Sj/D1rXn0KHRxmQgBc2ER4hV+e6BKUkv7oOZRAhmys2uLoNBr0fGlW74p0J/IRftl5w1uCYNdwBgBGhb4Agtesk9XPiHG6A/Ss8nq8E1UijlYDwM21zXe55TY9V3lVBaGzX0PjuTvfE6AUTcW6i2vBB9MpPw96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrn2h6bXiAdaHEhaB9LWt6q7blWOMYho87J71MecUrg=;
 b=mdar4Y8uz4iF6oPGShFzxvoyNdllOopV2CRQCWzkGtBiXQL2sp0fW/koZgIHDbnPvknu/1Deh6ojmTKl7GTDIB1lNgIhGQ9BPhWQIRT0+ggdqkPn4DGaAAnKTRhYYrehPmFEr7LYep/BGXZu66LWYW7mOzYmG4KgTWLI8OyMkRpNo8Hj6tSffFZ2zecXTe86IHOnP4uWDN54cfypGESWrOosKxz5V+bxWbGPnxB3bYsoF7tBYkFfJXS84VYWxFXTfwB83QBMj0yZO0N4x6ohi60i19Tln8MHJe6LaGqAMjuB4toVW+rrqvllWx8HpCYw4vHIIxGmtAvAj/qAo+v1PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7105.eurprd04.prod.outlook.com (2603:10a6:208:19b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Sun, 9 Oct
 2022 08:35:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5709.015; Sun, 9 Oct 2022
 08:35:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/2] Squash to "mptcp: simplify push_pending" v5
Date: Sun,  9 Oct 2022 16:36:03 +0800
Message-Id: <20221009083604.14151-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e881ce-b489-47e1-3102-08daa9d134fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uC1PAuHdObbi0FmiqQDrYFQCNGpX+UP/eoXDs30E+t2vRM+n3tBi/eeub4cSPRKxSfTHEbUzEdRksVWmiOKHJ/SDD4nnWGEYS4+J8CypRUvWXKB0qcNTkhxZludJdKzASIJijW35fHLAY+/LArJD2mCtb5VDWhK5omcG5FDj6M17idF3l/v5M7u3RbpQTD0vg8NYELpf1nmE94cGc0jiPI3FVSYDjXcbdFkiuN4WQlx4jL8/BUVInBuHkMLjhH08r37AwMWRoXpBTHgqPDFIQjHkCJa8vVaSji92YvbYp5VkeDfs1l7ahbU/OohCHg7suB8MFSaO/uBic89ISEa3zG3sCaU1bq6yEfHZOGlWvJ5sNaGCPLYGLObc0VI9jcnlqEhF5OpVaZstMjP0uPnAcK9t0x0ZzGlE2mSb/OrlAqPLqRrgr8PrOTcY2qiGpz+EygdFADAN6aC8600kZsVlhE6RoehtX8ki/v0UgZPekulOqLptdE0l2/NZ99qyDYDdLolxWfhCCwydKtyjWgnn71H5t3W+uYAt0vumsxYbtku4mouOOCPDYuDF32Z57u7k32WLp6vKgY9tDGlFU+6Y3F2xOHjM7t2cmOD3jrR27AhcifLjvRY07kFeI5ivrdWra49mWg6mA1j6GxdDp3cz0pVQf3auZJKQzkjPP4nxscZpW3hmhnkFRVHic2cBFgQ5uY8ps63legMxaZXIUEcM7ZLBEpz/ePKG3D56HY17y0A+481Di3hH99KI/MJ3fKBG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(376002)(39850400004)(451199015)(4744005)(44832011)(2906002)(5660300002)(6486002)(107886003)(36756003)(316002)(478600001)(38100700002)(66946007)(8676002)(6666004)(6916009)(83380400001)(66476007)(6506007)(4326008)(66556008)(86362001)(2616005)(41300700001)(8936002)(186003)(26005)(6512007)(1076003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4zx69IjEntWDSGn5ayVyu4Jl6kFX43Ag8E60zklkqt89Uxlqzq1yVZXsTrGq?=
 =?us-ascii?Q?N7k7hcne26rS5GYkiDmWwMrQ41kmZHcBAzX+CZHghG7tPXtE+xSzJl/aoPKD?=
 =?us-ascii?Q?N1z5Y1HEYjCbtcadQtdQMWpPxsY8ryWoPMXAZddQUn+eAVcMCwM4Kp4VwEkI?=
 =?us-ascii?Q?ymd+Atky6R8WP/LOs0kQkRV/JjXrSMplwMiZJ15a9mjBc24qtHxyKgd3lWuC?=
 =?us-ascii?Q?EQNom0cZFtKpvxSoztZh82kYszSwCCBFzwYLMxNsxT/ra2kPAkSOH2Z6nix8?=
 =?us-ascii?Q?GpASnBV5uSfxPAP+P995BrpcWR7504ZCGSfEqKWgUpDP5BvJEW/T7ZIyISkC?=
 =?us-ascii?Q?kKIqnb4pJ1a84nCTtn+Psk8x2dFLZRJOQVOU/5QF9app2C7ZLCJbQKUoJES4?=
 =?us-ascii?Q?5IW3wbdLd+wSCNr10RM/YYMxpqklf+JXJMPB4u1Ap58GJ5SdvudU+tT1hiDc?=
 =?us-ascii?Q?obKahAPQScrpDH60gHWqdhPopeGPnKfAg/2sS9A8Zw2N6EX8xHu0uIQgAwgT?=
 =?us-ascii?Q?9Ano9cp5Pr6yq7LLE+fAwLIBsH1A+NEEhwLuFHvAjgq/XJjhwX5Ptz50562F?=
 =?us-ascii?Q?NXFazhQvyAa10ygvIp30cD6u2gszSLtKQc88jxgonZZRho/nnZAZspdJ/sSF?=
 =?us-ascii?Q?+XNXjAuNzP4vzhpN6FLkvQm61JhjZR+anmRdGlvOq+nQaExG+iRBEDOJI4nF?=
 =?us-ascii?Q?4lIMo/oAFhhV5VSgI77t2FPjP6W/1WNfL3j0le4OmABoLWz6Gnm1OVhrzFgd?=
 =?us-ascii?Q?R10v57eyaZd0/dwpuNQD+2LtX+4+YnFKU1H4aTrTGBxVi04zx2fp+pl2Snuy?=
 =?us-ascii?Q?sKkLQ3Lq73KXnfQ01fHZJTYm1zHiDPp7ezY3UNqx5oS+oQgVOUAt6njP5Fs/?=
 =?us-ascii?Q?qQEiADihz/kib5ZBVoXmBxMRz7Sz3faUgv2unhy8JG6GsGkHvNZ60wLx+DKz?=
 =?us-ascii?Q?zs9dEqf9Uipk4qRrniZxRj+0o4uY74+4u+CvgYmYig3vYnsfcPh8V3x24jnV?=
 =?us-ascii?Q?Ico76O1hXOwRv2Hi/Z/rPn4XpqruAsECWwc06XzjPo2fht7cg3KAmNt17gAg?=
 =?us-ascii?Q?hdR+2Iz9A4fXc0MdOYWUNYZQ1Or3VU8jGKHAMXkWtWclXlyx09m9gd0MO61H?=
 =?us-ascii?Q?Wqzjsk7kIjrvP7ZGZgbx1PSCAT50f8IYhf5aOmOh+4Jp/jGZOILTKr0Q5R0W?=
 =?us-ascii?Q?eYTwBaM6ys+umicV+NWfRlrU//tH8ejAAQD8Pd5G1OYD40eJM/WT9n+snijh?=
 =?us-ascii?Q?/yk+sYkK9cC+KYet+6umoUJFsrKfCFY8AUoC5mEiO8doG7jy7BkuuiumyMM0?=
 =?us-ascii?Q?5SMMizqs9HjLwkaLsTuVBvgnItYRAC69sfMzKn0fExrut59oGMRrefgep9eS?=
 =?us-ascii?Q?Z33rBCHKxkTfzUEdw0wD8dX5bq8X2uYrNyHXsf5P9YIuMZyqVsMSBIUlc7Ox?=
 =?us-ascii?Q?lmPhONClVQ5IaN5t77zbdBNxf1FMS0ipRgndkigWcOBMmJDu+MwC9uB3Lh9u?=
 =?us-ascii?Q?wtZfWOewbnSpw0F27UCcKqpH1zBI1yovPjCZ7nkFIyPYn1dcFE3eVZpVs7EH?=
 =?us-ascii?Q?xyYc3YKLWI24ZpWBEs38gEg02SoLSCpnjf8wNEURfEdGFIAfSdpzr18JZ3Yw?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e881ce-b489-47e1-3102-08daa9d134fd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 08:35:23.0176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMtZ5aMT6GxDfvU6vCaLXRoPNrxlRdYxg/2Hx7Czve6S8Zf5KAzl6FwtUstNE0xd1ukzmjx7qDV7CKnNOV1MwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7105

Update return values of __subflow_push_pending.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f08c0eb0be11..ff2c1bbf4484 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1527,7 +1527,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 
 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
 			if (ret <= 0) {
-				err = ret;
+				err = copied ? : ret;
 				goto out;
 			}
 
@@ -1542,17 +1542,18 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		if (msk->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
 		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
-			err = -EAGAIN;
+			err = copied ? : -EAGAIN;
 			goto out;
 		}
+
 		mptcp_set_timeout(sk);
 	}
+	err = copied;
 
 out:
 	if (copied) {
 		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
 			 info->size_goal);
-		err = copied;
 	}
 
 	return err;
-- 
2.35.3

