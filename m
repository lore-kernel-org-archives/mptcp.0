Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB6772
	for <mptcp@lists.linux.dev>; Mon, 29 Nov 2021 03:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638157238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=968loHZ/lnwAYP5AgBzItAuvKdOIk/k/uvkfcNMHjGo=;
	b=fD8naZqnJOv2ZW/BNNstjeEPeCSODU7wu6IQsGyM7DZr9FQYBQSLQWBfkNGU/AuGDrzAcM
	/IPqy4D08CiqdgZZtcsMwIoAiNjQg+N7zpj3OqorfeIzWVWkfzO65ajO/aW2SNJKVu2gXx
	HTQpWMAuKivzO4KCNbcD8Ox2Nu+vQ9g=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-PRPQnePkODy2gE6HvcGuzg-1; Mon, 29 Nov 2021 04:40:37 +0100
X-MC-Unique: PRPQnePkODy2gE6HvcGuzg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtWR/iTbhIrfT1GPuYL8KAWIuOAIbWs4QTGUYpVFGkAVQ1ZQkQLpvGk4HEDLpHOeNjxccZ2lkzIdZ0sYNs9NcsCDwNpyJ3jc1u5GSp1AtN++MortiKDmPn5ja8GS+w3gjAQ9fWPyD8kB1TJ+zGzYTfKS7Ih2HT6bYDB3P1xo6goO9B5Q+aHvryzS0Z1Ir8WXkHiGAjDskPSM8UzwF4mbu1idEiJiu8otLU1dDUKwmfRoKz1sN70SB1upKj47aHIZQ2FsQhuaomYkqI7N2v3NVYpUBMn6EQZ1aLH0/Am6P/pKSuehGeSxjH3m4CdvzBXPwj6ft+jxCpBZvcznqim16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDmDE+MONtF6VkAEM6RlOZrjw9K/2ffskb21ZIgobuc=;
 b=BN3yHyEi/HRcrSh8uCPnjSxLBPWQ4iBWqRaNIrrjztxlnMCIVxOS7ff/XTWvCwfvPsro+QwVbDLP0WUg8PFbCTSXmHfrQszG+673cdrSp0i9c8yTs7MWljXuoU4Jb+yjHENi4ZCVSysL1/U10OPlf5OHtv+GuU9W11+TFsbmx1hQYzwYPgxbGTKfC+ksuq86q4vB9m2ZwO1L7Lmr7QtjD+a6/55dT3AJWzUKrk75IGTfwFCZud43NGIrHQzw/qgp5Dm4xO16NAcT23wmeKV2Ap4jvyD8/AnK9J1NFOcotftx+QyVaCZLKMdHWF68CBZq3VHIPkqlDELpDhh6AeIl0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2507.eurprd04.prod.outlook.com (2603:10a6:3:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 03:40:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 03:40:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/2] mptcp: print out reset infos of MP_RST
Date: Mon, 29 Nov 2021 11:39:59 +0800
Message-ID: <2662899e20597fffcf4facaa91e8e285d053825a.1638156809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1638156809.git.geliang.tang@suse.com>
References: <cover.1638156809.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 29 Nov 2021 03:40:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d76066f-aeb2-46f0-bbe3-08d9b2ea0124
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2507:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB25075D25006FEB5AF8B6748EF8669@HE1PR0401MB2507.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	igLP30u+ywGfsi2VjuHVJMySbjpeGf2lTk8s6F1lon6hqdJMdF8/qRLfj/NdHM0MOFLLmHZH/flBOz943bqF9zV9NWgjCe6c2xZygIGDL8gsbojIytaX2pmwSoyPQ21jnh1FHByyVEYpv+BMVM2pq/BPGEPiGztBVN4VSn7bRSRCgc1Ud3mqIUtuLQeaDzbx5umk/aJZzu+JjB4aGn2ZqB4CPhaA/x43sJCbMtKLURKke0egJJxA7yxzO/hrv8JpVXavw6i/4UuB0EzvFgKrOAiLqNG9VwIL2V1xyEfh0cFCAQMt545tOr4q3ngjwppORXsl7B7BUOGKptEhfsKdGFj2GBJXE1ai4Gp//2c1s0OuC2J7zuna6vPTzNqUmwXhsL4WtPHLp5aPGvOOmEncYvidO42aGqRE8LRGtF9My2yPUpLNe9bhKZlTSa+xgbroNMfCtZS/AJk9UhmtDC5cWq3MJt7JRueFxbyNTWDXI3/FDRf+yMjWglMCnwVF3CUJdEQLaCEhNTZemHv2jWeiXFq+T5E/62iutECB3lHmRXK1hT/I86BtsTie5/r/3nteW0JCrZj8opKII7m+mik0u5TedUrY2TYiapRFjK4FF204RKKmVC5Ca6lMpn1Iztiz9f/SHSFq0FxwDiJW858vhQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(2906002)(4326008)(36756003)(6916009)(8936002)(6486002)(55236004)(38100700002)(26005)(2616005)(107886003)(956004)(44832011)(186003)(86362001)(66556008)(66476007)(66946007)(316002)(5660300002)(6666004)(6496006)(4744005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?znzw9Z4n1KAnFbTr6QUy2fMB2q62/O311oaZ4YDgaPJzZQIzOPqnONbhUW++?=
 =?us-ascii?Q?57FarTvwsivYXxh5zZYjYH66nhz55CF6hVW963/wtnDUKnRlKLapa8W1hWS6?=
 =?us-ascii?Q?dg1I7RlOHLqIRDsVvJmMFI+GV44jDT+rx4B6GDEFU0qPeCIv8gWR4IMrc1Hw?=
 =?us-ascii?Q?nVfWPWvPuYFf1FfcPIEbh6PanQKhUuYROxNapEgsO135MnbfaAMt0X+eNUA7?=
 =?us-ascii?Q?NnNkbMU4PNpTnE8jCkukvb01lzmNxQFiKY8B5Ny1LJGJe/4qWblk85ctF2Js?=
 =?us-ascii?Q?QS0tzNGpbxup0lzKIM0K0tXKa9rcbyeBSk5+dxjnfLOz6/Sf3jqgxq4wo8xu?=
 =?us-ascii?Q?OSG2NIC/wQJVN6ar89eGPz4X7S9o+yBo8mMZYactK6rJCX4EEWsp54iQUYj1?=
 =?us-ascii?Q?qB/cNshlgHi6Bo0Zn0HKN/Am2Ew6LUhN5uSOkNvYaq4NARzRYsxloAfMj6rz?=
 =?us-ascii?Q?qhmKNWPzuet8D1PZ5gZLwMLRYbIsDORdx2sGsQ6SpHN++wc62/xBhBmrjvMu?=
 =?us-ascii?Q?fqArjD8v7m1HC2m6hbRhFp5asnGalWT40ZjIiAgmtm3PoBD+J7FqwCJpLPQh?=
 =?us-ascii?Q?p78CE+6fIVT3zoUp7tBqCu2DC2zHxYxSmas0juc8PmxHQY/gLcrK2D0T4W0D?=
 =?us-ascii?Q?J4PJgK/UND7RF7HnO5EOE4SQ6pqgEsPmwjIKzpB3vI2mf8FzoNT2ks9SmorE?=
 =?us-ascii?Q?gIlg1ejX3HaeLd2Iir+dLZygBX/gAsck++C1P3Ug6+BwozwOL/UHX83ZULIK?=
 =?us-ascii?Q?xgulxfQrW0Ks2fSJ70WWxeA9OCD1v6HBAHbFCUrZ2v9viJXe+al3KOr3uCxD?=
 =?us-ascii?Q?K/XV97avYCBo1OEq+QkoLxZ54utztrEmrWLr+OKyBqUEC7UyCEbK36W59Y3o?=
 =?us-ascii?Q?IXl0QAunt8oxh8E+3Pm/wiXznPEUawreTg3er7TvyhbsXSEGhcTc0RUDdKWM?=
 =?us-ascii?Q?cJDE0U8FaBXeYktJvbY9pBSwgwq+vuavBFbwWWetm62dRrfGyf6DAfsW6BfI?=
 =?us-ascii?Q?KkIbaNXn9WaE6TAQjHL7ayeZUkJc/qippz37rLZzrmMcWNyYptWpVrx1QT3V?=
 =?us-ascii?Q?ZVfSM6OrL9z5eT8iTy2jRMHJFuprIpQqX7r7qpEGGgDfTWRRnWsDfwFbjJ+R?=
 =?us-ascii?Q?Iq15jIbOjXMTXixhzPCDPeG+djw+TDokG1UU6kGNAcb2goUCFNUEWYUSenyF?=
 =?us-ascii?Q?XISAr6QshX4jYTwqwo8zwG9FtReiOsNpYFmKRbSPkxDar6pX2E/rgsn1M/Fs?=
 =?us-ascii?Q?cr0xggd++qxtn8vknu2NIVFfB7bg1Uanp4eyXA19Yc+E/daVYSeiSVG8sVIY?=
 =?us-ascii?Q?ZU2eKYFMJnHk5fXtoF9b7YpHu7Ft72TPg73Kkf3JH5M44/m4Q+EeCu9JFseO?=
 =?us-ascii?Q?T+REUkTI64N9ma27JVRnOKmtmJpXIDYaagZ02otzcAj14kVlaSdupqlkZZlH?=
 =?us-ascii?Q?eQ/upLCwjTq8rnUQKzwUxMP1gBOk+IKW9kN1lvrneaXhg/woMvJENitUXyHY?=
 =?us-ascii?Q?pl5JJlcPUCMAJ/ZxY4kmyBPZuclPR7WPF2tM/fMDfarAsQhcMfNh9HKuj9Kw?=
 =?us-ascii?Q?J3EkdpjMenzg3qW+BUVpiZYdfIg8jVBFuxy1hfJdlRlQdDqAnFvkLWfGBnZr?=
 =?us-ascii?Q?oK3dvyt+2KrlR4iVtrhXArU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d76066f-aeb2-46f0-bbe3-08d9b2ea0124
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 03:40:36.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3D7R8GOrJuX61pKiEeZw6s1HGZ09mmoyMlQDqpIhSmnuEBoyBKZlRpuU7W8NUV5EQ8org4MgddO2KDZNsnnQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2507

This patch printed out the reset infos, reset_transient and reset_reason,
of MP_RST in mptcp_parse_option() to show that MP_RST is received.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index dc998a14f4cb..823a831a699c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -336,6 +336,8 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 		flags =3D *ptr++;
 		mp_opt->reset_transient =3D flags & MPTCP_RST_TRANSIENT;
 		mp_opt->reset_reason =3D *ptr;
+		pr_debug("MP_RST: transient=3D%u reason=3D%u",
+			 mp_opt->reset_transient, mp_opt->reset_reason);
 		break;
=20
 	case MPTCPOPT_MP_FAIL:
--=20
2.31.1

