Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8650320EB
	for <mptcp@lists.linux.dev>; Sat, 27 May 2023 12:55:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJCRyDCAn3Knds2941sKRCz3Pp6jrjFXYzCiDINTCfcmHDUTvgl5gCIuuGNJY26j/bYlrKFh9G52YcvY9rVnMp5UV91QAC+5jXo/cmhqE+mbd69F1+q0t7NJAROc47LspKQgx/8agC7oWI0dGAm310KPuosyo7ofavHSZ2AmGgSQlSS2uPjGTgp2V4wyHzkKglaOBUKchnJktDxG/eC4eJo7cKUmZ8YMc/6Gk4EaKD0Jk3xdfxN/mp1xeOIWvOBKiAGb6cpsEzYkS8SQ57vRoJ9iToijfhqBZ9RM4Fljqk/gZh5qxcyv3HotTRuPcRxPdlL1RsmlWzj1ykNOrFg0Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CymOiuvSfL5wcTfwoa2xmLmU2Wyea0af6QThOQ8sUsk=;
 b=oQlJdyljgn1IpJ/ZtcCHZasDoGBB5K2yJdkmUgDmxcRI1F4UJwh8VWjc9zWvkyp7LJ1xrmYZuorPZASGz+ILCAGyZjsH6tLd2TNYwTk5oQZSc55BvzZAllNEgw3So2/Ja8SgkkWLJ5qJOcUR8EVQmPzrprPvOwt5DPLzWqe+fOKYePELHg5V+xxZM9kJ14j13ACTx+j7871BLUUc16r3sGmP1Ix5cUAPa1M5gDem6DKpQ1UZEXGiSwwAhopvDxxbMoNZP2Cq6/oPNHo6NhHvdK93JZUWE7afYaaam+7fV149PYQt1DmGn++ZcHneb+7Sx4YcL7Qe8U1CE2Yjz+4pQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CymOiuvSfL5wcTfwoa2xmLmU2Wyea0af6QThOQ8sUsk=;
 b=dN7kwlDp9EGCIODD/1tTbynZZGMOHNxVFdEIEgu2syTT7WinLuRtD3xuBmGsELyjjWZVoIhLpNG3P08hnyY3ihswTkvP9WZk80lbE5Bsj0V8rwo0Q15cdOUJyYon2rugvSbH07iiMiMv3SPf/E3Sn2nspta4k4obiU9OxuCqLb+N134iXn5ZAho9kVHC7nxcKyw0GI62Hu8Gg2PaBmWFiHYEQzp6QF0nFWd5oZIloPplEyt/O6x0oEM+SwmzhJzl2gdArLjpb0PL38pnUmcr3TGNQonduZFYYotyroK8hhkSKmWFDPoDSt2HOaecf03TCuq+1hSKlcKCbfTVHvXEIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8371.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Sat, 27 May
 2023 12:55:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Sat, 27 May 2023
 12:55:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/8] Squash to "mptcp: add sched in mptcp_sock"
Date: Sat, 27 May 2023 20:55:31 +0800
Message-Id: <1b864e2eb89ea8ffc974ff9f52340517052735b1.1685191581.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685191581.git.geliang.tang@suse.com>
References: <cover.1685191581.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::35)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 4117f3d6-e093-4476-d154-08db5eb1b579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yyd9bVH3hDDZQu8+/p4OId7cjSjYWDW3o1xk4YH5xXhj/jL3nX0+HxI2kMPeFcduZA738H42ZI47XBqI0tTOzBMuL0smnAOgXxM4jYq2W1TxEsrlHQkIByQQgVguyXPk7InoeVERAbXn5iRPoK6dLgnwrKkZ5chS1DCJzyGj51xx/HLXzutXaaXf58Ed/rMwwcCNu5IJMDfapxSiGeetUCtKT4VKmK7tRa0p3+OX2ap//n9JUIFcKriATFbG1JW17eb1YxsnwBPXebxardu7it6xhLAJuJ7f+dGAB7kZIvWx131s9M8jPHoCJLyjv+Rux6Y9A2mn/7EhUrdXToL26Bn18Q2jaz6J4hFiRX4Ywupco347uj0oSbocRt8DG1RMo6VQxAJabcdCzek+/Ue8ZyfFStk6ALwhpaBQxRxCuZqD8uiXUpZ9iH/N06XBif6g6QfDoiyQSAy53UZ7NALQp6QMwE4+6OrnzguEPhzj91eKATKK0Mc8C/m9cy+2bn6EaDNs+kVBIORMB8vu7ABuU3qnr/DWzn/NTmYs7d6on+HiUeWh6Vd+QxkLYy34BUSf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(6666004)(316002)(6506007)(26005)(6512007)(36756003)(66556008)(107886003)(44832011)(66476007)(66946007)(6916009)(4326008)(38100700002)(5660300002)(6486002)(41300700001)(8936002)(8676002)(478600001)(86362001)(186003)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bup0n6JApNlM5ajv3BaQRrF/A/DlrCALWIZSbURe2sqFWS4F/8yXv05uLPjg?=
 =?us-ascii?Q?f4YCWp2LpRlrFpGpzLySXUeLeJcyBDt9LDdNmNvq7zxSapUQ2CVsHXOUlRDe?=
 =?us-ascii?Q?AchhtRzbn5kyIPb/z6nWYojcblRYffmOMFAfBHLYqty3E2Ag8dEr/EMPjrKd?=
 =?us-ascii?Q?dj6V6Vb9GV1MJRAKL6BqYjelQSl6aGFQp2rtnb5sqSVuuh7P7qfPqzljRG3t?=
 =?us-ascii?Q?WfRKP+6J21anrdz2uN/yAshzHu/vg4UyEbJGckHPaUlLqpckowNvj6K1dWe8?=
 =?us-ascii?Q?DtlmIPRoy8hSZOAeUUpLJA9Sv3hSmh6Hep5cIejtLIu6CwyeiIHhnAdsGTBo?=
 =?us-ascii?Q?v5EOMEnuECNyzcxiorgGw8yoBSYMJzmoyJwRLyBZTMD/2xCUpdOLerDrnZOG?=
 =?us-ascii?Q?q7YvH7c8sB5AU7uCb+eNjHqRNwkscnWDbv45OSVxM4a5R9cxH+4bBA339lCZ?=
 =?us-ascii?Q?WvBVs0l/JHeFe0mBOz8wpsznVueR80NkNK+4uO3odmQbAgjyfagHdVa8P7fr?=
 =?us-ascii?Q?yjlVZufAbnXnmCKy0zvhpqlvSPaZpJURnv/nSi568G+fVFDF/wSZCsV+Is/9?=
 =?us-ascii?Q?qOspUX7ImebiJTEGR8KKOw1OwCTCG7RojDUqSFtxHIZkVE5XkQIOAH8AoSjP?=
 =?us-ascii?Q?09r/XDOdvooki7HIPEI97qanfNejkigJwVHYMl/BakCoD0pa4AkMZXoZX7qC?=
 =?us-ascii?Q?dniWCNImLrm5FuVG/qT0gntLSJEizYKzycLBgIk7+jZ8sRvlT7SfZpi0j9sr?=
 =?us-ascii?Q?qgSFSvCFSV/STeiV1waqhde7pDd38Bn0PWXsA3u3O7DTrdZxiBLJgj5aYBx5?=
 =?us-ascii?Q?YmLcneUHPzS7yulQyj5AYTE/73Gcv6fjiQpDJfJTLQu7ZnDM2fdFt+Au535i?=
 =?us-ascii?Q?Mf9P/sw1LdPdMl6k26rgS4cGC+9iICOeWmtCEQLIcceHOZQYiMmBuJZuRDVq?=
 =?us-ascii?Q?a0uWGwpbNRqzvOeTJTy2qB9DKe1Ac0MlwzFcpXH8J4i8sZXx9huiNMZ+o4y2?=
 =?us-ascii?Q?lq29TEZayATLj0vKdLJ6wOkLJW4XsTBWZvNlnB1B3o5f8eYwqzVxYimw7NVS?=
 =?us-ascii?Q?Ueiy+OroJLsGuumMewIoEBprbeTRCicHxN126lhlsIDFOgWIGYLTQL8qZFhF?=
 =?us-ascii?Q?kYU0IOLs+7DzZYAon4bAjJ+8OxGRfMm7Ug3HzGDv1Ig6J0KnyGBZhRidtg6h?=
 =?us-ascii?Q?Ejfc6z2PRTiQrwEvwtV9gcQ6H4/S1tmrgLBzNCxMalh/ya4pUP+FytPXl/pM?=
 =?us-ascii?Q?mTU22mblG8vguxYchvhFcs0mtzCm/Y/1j0HV58sxQPRDOxoMQ/bPs4ROLPgd?=
 =?us-ascii?Q?XL9wv5KM0U6Hm0d9wryDxEEnToHt7mDmdNIaUd8vkJoHkXtVf0+5kRWqiwO8?=
 =?us-ascii?Q?63V/LldjWQXJ26M1OpRFDLFMsGgoa2tdyBCNNxeukeUKIDvqU7sul7AR7xDe?=
 =?us-ascii?Q?kDBFRizcetl8vLrWFQIhFrv3VhqyowerpUjHq5tcdBSJFK4aMlDlJM9NUXM0?=
 =?us-ascii?Q?uZzbx2dAidIV6cIETXjmtbFP5/nwgoVz5V1RrNOZ+K3PQObWpmQ6Vshz3o8y?=
 =?us-ascii?Q?XbK05OBwCyJnb3NgQZa6PCeg6gqxHCPDknTTEw9Q?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4117f3d6-e093-4476-d154-08db5eb1b579
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 12:55:55.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRXrl9DDxDcj+MHYv4+nqqa+Cfzta2iurMz3/X7J9ihy2fl6HUL4O1o1+WuldromgzNDX+BHOOhSMN8qxSORRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8371

Add sched_data pointer into mptcp_sock too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h | 1 +
 net/mptcp/sched.c    | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bd3771c7d79d..09a5e23adca1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -311,6 +311,7 @@ struct mptcp_sock {
 				   */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_data *data;
 	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c7c167e48d72..fb0a5004980f 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -64,6 +64,10 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 	if (!bpf_try_module_get(sched, sched->owner))
 		return -EBUSY;
 
+	msk->data = kzalloc(sizeof(struct mptcp_sched_data), GFP_ATOMIC);
+	if (!msk->data)
+		return -ENOMEM;
+
 	msk->sched = sched;
 	if (msk->sched->init)
 		msk->sched->init(msk);
@@ -81,6 +85,8 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 	if (!sched)
 		return;
 
+	if (msk->data)
+		kfree(msk->data);
 	msk->sched = NULL;
 	if (sched->release)
 		sched->release(msk);
-- 
2.35.3

