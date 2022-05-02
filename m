Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E64B2F29
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 23:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651534132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t5O0tQdFpm9d21DJgHGWqZNtnlIBDBtLii3zBDTXjYw=;
	b=fMmAWBR0L4udRi2EEm9p8/yKyYd25i47CLl0uw9pGo4ZTer27jVK/cptmSd754jIxMsMzG
	W9UkRouYdEAYeWMIZUOUCpTDTNPH+1fhML/fnpekRPDUtC06Zn11yfp2E2Vlk9jfQFJbhL
	0oZrl41HjFhDfOEr0qN9Hla5ysdJNa8=
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2173.outbound.protection.outlook.com [104.47.51.173]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-zSw3tUSkNqCiTFwoHRD6kw-1; Tue, 03 May 2022 01:28:51 +0200
X-MC-Unique: zSw3tUSkNqCiTFwoHRD6kw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5O+cOS+jPurdRukjQsceyBQf5vhgJliz2mtKdFF2WKXZAvnZF4+0KLYoZU5Dw0Hi2aThRaaGUg74Q5CUKrr9XmVnH7TOf03FhPGpD7U4508N4Hii5xFPLnxXry3ppRVp0vXcPk0uWOvRVQmWRs4mKJuyb5uZAXbgLQ89CDEqLccM6rybmAUX7RwoiURBtmjH3w7VXQH1SunvzO+w6R5xmetg9GCBI9KjpSjgwe9ryf2+bwE0GgTX5yYHaBkVU/iXmV6Lmi7K8xR/luVC376bEuTwdi3Huy5H0+eVucn5JU4YUKMBcanpco+H4Hkqn+u72LygqDpGmEs7n6Oa23btw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YXUL/nkOb53UekC4xg3OxLVGmdkzKY6JOF5gCiufO4=;
 b=ZoOSJL1v3+8OTYWSxzESVcXlqiAcjytOB946cWnHEGIlHxTGd43zeR77vxHnS3RcA3HuRjvAz6chhI2Evdv2i+KEvgHoag1ysrTdhqct/82L1uKeiSmxEQFQ3Sfsm26xq9K0/58W9ZcmTDzS02EjlT7OiFCBESm0FQyY1KlIyB68Bcxb0rD0LrWe5eXsXBhHl319p/wmQba/pjj8TvF8B09NkZ43ylqFjUWWJ82O4OJ1Hmn5rY50EzTx4Hr5Ha/dnQjybS1QPq4mP17frQ8A3e17r75pN+03JcY7UJYr4ldjE60sDkLghb6lt13R0PuBajqAfQgNHeARMR/U7phBcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9256.eurprd04.prod.outlook.com (2603:10a6:102:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Mon, 2 May
 2022 23:28:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 23:28:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: add struct mptcp_sched_ops v18"
Date: Tue,  3 May 2022 07:28:29 +0800
Message-ID: <8a90b97be579a420d37c45012bbf1075db5a81eb.1651533987.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0163.apcprd02.prod.outlook.com
 (2603:1096:201:1f::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd1be8ec-e8b0-4208-7550-08da2c93828f
X-MS-TrafficTypeDiagnostic: PAXPR04MB9256:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB9256F45A43DBD94D79D5DBCCF8C19@PAXPR04MB9256.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pBH/YExxHez86BBDMDBj+zO4V2XcM+gQkJrjDuAphog+XH6wjA44EHJLJTPnO2+6Nl15jz3QNCcJjgHTuMp0x5WTzv9cm+Tsd1jNrLK+qfFHDlfJwQfGaGd1A6DzwPKX1HKReIxXreEZ6B1G9REkRrSFq3Jy66kruE64fnECQyrLd0Sb7jVlbmEbcYf3jS68kiuwNI+XBSjNJ5IBjUzZuyrB4it8jIbfNnL04fLWoYYvaez5bsgS11w4puoRVY/HzkCsHojWkTTmZVh98T85o3xutr5vPGZbqjAuMDQgEb071tpWt5TDx9j4y6j4W25XWuSg33hBhSH+wSmZZfY2XTniJeBnB7mSv5VSPg8C/xVMqji69bBfcHxQiLysJbUaW3DPYBYB+Q98jtX2Bt8m1B7ENMCJdVth+NeoRGUsfxsaPBoaGs+G3+bURevMIV0cugaRUVkunqf0/LSXDj40t1BORlKf4UTKwuaG1bx5miRdZMw6tAVx2y1kLMVY6JJaVDybnnLEiPkkxRdcOIE0qq2uc0TiQLLq8lOVFhOlihLB7UCOWcUHidpsCXhEnoDcXVne7/aXuuzryvVm+tiLkYq8MrWLrl5+ADL8J1BqOTDeOv0M09dcMUOEDLL1DAVJAZzlrv/y+8gv1B/75Nx/fHRXmYxqSsalRUiWP22vQ1XIPxHOQWpsNqz8wvRZ/eaY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(107886003)(186003)(5660300002)(44832011)(6916009)(83380400001)(6506007)(6666004)(36756003)(2616005)(6512007)(26005)(6486002)(86362001)(2906002)(316002)(508600001)(4326008)(8676002)(66476007)(38100700002)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p1eC/kA+F3g175jkbNVvxXWlUOREUKFlujfY1aGZP3FExYpirTKRppPRI1Ro?=
 =?us-ascii?Q?MbXzuFi1g1IRSOaJOFa2oz7X4Sb6M5LGWNqDCRxikVRUQDQoOK8uIaTa/s/V?=
 =?us-ascii?Q?kjTHAzUbQLTb0jAsPxTpAcMlhHAettYwG9saCpfaYUOUBA4XBamRYEcaP5X2?=
 =?us-ascii?Q?0q+96NlvncKKTW4Uz9q7n1hFXDDirS1V1uaYgVCLrO/0NayfiQNKNnxtQSvq?=
 =?us-ascii?Q?xEqZqbyH30x1bfuw+BM0w2o3vVZo1y/j06tBVZQl9Ui4m7+yOpqxCGyIIrMo?=
 =?us-ascii?Q?cm1OOwn9v1jX/xVRvXAVtVcDaxT50E7FwVd7hjOhyIBj7VMD7Roc+6k/vr9O?=
 =?us-ascii?Q?uKNxJrV01gTyQzWanoaeK/4XEk9c/a073OpLglHzyD73HAquxPVvePX1bhaV?=
 =?us-ascii?Q?akudBWgHxUZm5SqxZ131s/A6TMUX8nHQHfFxFF/6gGcad/38yBW3pTkYbgVg?=
 =?us-ascii?Q?LxYsKgbClQ0A9/N8G0nWLYlkE780ichqJlhB3euImymmqQthZ4XRywq72zkL?=
 =?us-ascii?Q?1LGjfSMw9WbLyc7UcMMEdjMN24cvpMYktaefj5ApRyM74hdYHW3XXrxm1hby?=
 =?us-ascii?Q?kPrK65o4P+klm5X6yVaA0vM2p2q7V2foJtFE5pZ+a8cMy3Zrh/TPxR3qUZrF?=
 =?us-ascii?Q?zqOr03Bu0w9UebSy7kwXADTKqwlEgE35vZd7lADRjf9RJazBsgCuby2fyGp0?=
 =?us-ascii?Q?oRPIZGxzebMcB+dRci351N2ZeUCKxcYSnbI+gDbcQrh5dlxltNUVkWUkX8K8?=
 =?us-ascii?Q?SRl3p3ZBNeBkMbhewLurZuurvFLLT5a/sPuWVOo6dXskDf43x6Sro7z9pGbT?=
 =?us-ascii?Q?BjB3qQVGKT9/m1pt0sfGp2ikPIhTkLO8zO+QCo9fWsnUpnmjYeGDq5dfl0o4?=
 =?us-ascii?Q?MjawxdJeqPdkEAnQt6XAoTrdiuVhjriLSr67pWyZ4OTTT8LAERwYl5Sai4Sk?=
 =?us-ascii?Q?Kpt7KJt1W2efJUt9EUODVi0RMwJ84I93FK+1g2Q4MWetLlWMg8aAT70Z6QTN?=
 =?us-ascii?Q?peeFhSYiHZb+6J/Q74zxaYX9hAJrFLHIV1eg0ASWxzDmyW5/lj1NBC5wZQfQ?=
 =?us-ascii?Q?j0n5w1yFun9dJclgieNQRFSd0sRlQhirK/scrzEv2N71Kq57mw9v2RqQnlyF?=
 =?us-ascii?Q?/lc1qarlCgi+4sS7t8VmCH1HUfiXB96zXiBC/Dhk0QuMF+8FNv8MPOe9zx9j?=
 =?us-ascii?Q?dvULBTw+xR52J2jMtww4lM1gEiYNeVBZ6C4NNw8AlgPG1GjKZRrefBHtysGq?=
 =?us-ascii?Q?ilZpo6bdAU36u9Hizg4MGk6lAcbE0iG4hj8j/sSQejSIELh5hvd+RaoS+cX1?=
 =?us-ascii?Q?pVojGHaaAmH5yM5L4r4BcnJ6vrT/PCgSMJ2GfJP4ZdUpZnBTTnAZ5qIfN4KZ?=
 =?us-ascii?Q?lYKcodqJSU5U6VAiAMBycE35QUkZ1FiWr+cOMA8NbFlwLc4x459X+Df2zH65?=
 =?us-ascii?Q?dskEaUt7tAoZ591pnKdw/dcfna/k+HdtH0y3KahLL/M0pj7WWO+3WM6hhrFG?=
 =?us-ascii?Q?QBB0KnY9OexGApN+sAtBfTbxDXZlwKqoQ6T/I0hICy2CUIbim8NgytedE9K5?=
 =?us-ascii?Q?bGFTqXhtUMPoQyXthCLZmegOaldxt1ay8ZLuUjUmIEjTaznD157uE7c5ZxNB?=
 =?us-ascii?Q?Fkn2YNEYiDdjxprxL6a30vZiAMsEZj9bbQz+mD/5+RRGC6+sEk6jyKmjdi2j?=
 =?us-ascii?Q?MgIW36U6r+KX16zdOU2mSTwtj5AVzdFsUP7fUkKz87R4UT8SdSPTfTVJRHcb?=
 =?us-ascii?Q?L+oA9bBZe0Ng/nuRAW3dMsRuQaJ15jo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1be8ec-e8b0-4208-7550-08da2c93828f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 23:28:48.9694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CP1xA4FsmmpFjUNqQEp7mtNMSSAFVfUWqKpWfCaCifOtDgS0RRn9p1s78GEPOgt1A+1WgeycaXDHbLDwVlzbUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9256

Add const for all msks in mptcp_sched_ops.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                             | 6 +++---
 tools/testing/selftests/bpf/bpf_mptcp_helpers.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index bea7608d72d3..b596ba7a8494 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -103,15 +103,15 @@ struct mptcp_sched_data {
 };
=20
 struct mptcp_sched_ops {
-	void (*get_subflow)(struct mptcp_sock *msk, bool reinject,
+	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
 			    struct mptcp_sched_data *data);
=20
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
=20
-	void (*init)(struct mptcp_sock *msk);
-	void (*release)(struct mptcp_sock *msk);
+	void (*init)(const struct mptcp_sock *msk);
+	void (*release)(const struct mptcp_sock *msk);
 } ____cacheline_aligned_in_smp;
=20
 #ifdef CONFIG_MPTCP
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index 5b8eef4f1b4e..fd54708f6227 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -16,10 +16,10 @@ struct mptcp_sched_data {
 struct mptcp_sched_ops {
 	char name[MPTCP_SCHED_NAME_MAX];
=20
-	void (*init)(struct mptcp_sock *msk);
-	void (*release)(struct mptcp_sock *msk);
+	void (*init)(const struct mptcp_sock *msk);
+	void (*release)(const struct mptcp_sock *msk);
=20
-	void (*get_subflow)(struct mptcp_sock *msk, bool reinject,
+	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
 			    struct mptcp_sched_data *data);
 	void *owner;
 };
--=20
2.34.1

