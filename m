Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D8F28E4
	for <mptcp@lists.linux.dev>; Sat, 28 May 2022 15:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653750725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F94bbBQqav01y46FcWNW8AZ0bSY1KTGOtSCpOwX6AZ0=;
	b=GkyxKifcW08ytzPo/DC6ax7nXRywusmf6EYSIwa8y/BUi8z4jsAZTpcMC5b0GaRcP1qWyv
	nRSbAzgaUSzLrBMUlNyGhjYPUOPKDgQ8UyPJZkkhVIgmLMYWbPzB3RzZ3+P+zuYuTOur7d
	T0pP5wpbX8wWOKd5kUxUgr//3JZXf0Q=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2054.outbound.protection.outlook.com [104.47.1.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-tEipPv-nPbSnB3o6_sEi3Q-1; Sat, 28 May 2022 17:12:04 +0200
X-MC-Unique: tEipPv-nPbSnB3o6_sEi3Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhE9jAbAZrBz1Lj4GkX02AbvW3c7yHgXzPVE9IK+WGgyylyFvAlATNu0xUSs+2E6qvhu2SSni6IEcDoWKyMT9CHRiAYRGdXgblE6lcYPHEqF8y4E6hKtt/EZhzLGEm3z9WQ4Sezrv7nAdUfpMEoIaHK34c6Uqr2VWqofawyhklFe0k4MKza/NBCGIsGNnnvl/NGWw1KYdrpjQOFKQry6ZdmuGt2zU2Sn4cTXgfIO0UzjkVSpt18v7NWTwOBta+9J86cX2qpLeEgqxHmmT8V4DLHGrPRwjVVIVZWST7oEblMprvdFer2iposXAtY6alkOIcVH+n29A2ywImHqKIcxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUcV8ehEOZYXzjbV0nJnZ3mL7erfNv4JI0kDOIFRiO0=;
 b=CT0DG/A/867q/03LUsvn+2Awdc+XEIbLlSH14ZN/l9H6+/GEq1sprrwydk+ObsSxwPwBoJPsO+Db2uxGKMnX8qSXfA+V2wNW0OlLruShFFVibis6mzETbG3TOsy44ut67gkqpSkipvj1w4aF2KKzJyvk7Jm3axyuXbXHEoKYqPbok+wflLfDmPLOXVqGptqi0obp6x5r+QBygu/+3b1UCa8cYluxFm6QNR3WdZMFvz/gDKFBmKDLMj12ykmYyrN83Q2YlCaZs8j6+jlKJjnd2IjNzNt483X7aXV0woATxE5W3IyV0ZBrv3SkJO+pc5VaD+UHx4d8N+m4DkO+weIgbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8485.eurprd04.prod.outlook.com (2603:10a6:20b:418::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Sat, 28 May
 2022 15:12:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.017; Sat, 28 May 2022
 15:12:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 02/10] Squash to "mptcp: add sched in mptcp_sock"
Date: Sat, 28 May 2022 23:11:44 +0800
Message-ID: <fe3878a751dceb263ae35c847ee02c2691b9f3f8.1653750351.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653750351.git.geliang.tang@suse.com>
References: <cover.1653750351.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0086.apcprd04.prod.outlook.com
 (2603:1096:202:15::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32535f4d-c00a-4681-8afd-08da40bc6bbd
X-MS-TrafficTypeDiagnostic: AM9PR04MB8485:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8485CB33210BBDBCB8894771F8DB9@AM9PR04MB8485.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lrNTCoz5Y+eAw+AhYFhOXRCI3plwluozoGe9pWxUgLf4sQgG+uhT/Ig9HBh9HHJ17FZ27w8t3MF2pzCdTKdrc5cbXaXUonKkcIQVB+E4xLXEhbkoPqYOCyq/yrsjOOTiQudV9plNvEc58++b0rMd0Xf8LT9H6CAqEwvTi2CQBOFmyEpz2oqX+pb/BrKr+SP2QjBJyYBNuTdhSxQRZrf0mrtrIKB19xT9M/PnQZ//apcYuTp/1OnNcq3RLaJnzjnrkIUctAx1p+uyj+jhq5M4WaWbp26mIHeGr0CO6C4VXmBVeuB5DR/Glj3nZdJCnvp/KPNvyd0RBGJKo4Q+dnABBrnnNj8Z3ynLi1bglwYJvKcSGS8tDV8UNG/yySbceSsbQyktw9HlNFtW/oE7WhRE27KzbRa5ZXpEywelO8G6pMIFfE/eVnqFG16pfUGKqCa0XWaOZD9CPRPtw4HVi9xGdfbwP9Q6gKtqYjg4lR8avZR9mV/pOXzo12zh3s8/BjkFcFJwMc41NZ5jArlH51m9Tqyad0Bt/QNti3BKtpLGHP7KXGxE+su+AbBNgaWhbmaDxE5gNTuNyIErIYQtLjO7Cir+IeUFvidraUGPKwS0p9MzljxS7dSdpQsjjwSwcK4irSJK1DQdl4p5FPtpi+iF01rSaDjcrEKzVgEmtF6cPwDUVE1N8Smn1q5+kxr/9oaI+BoFVsgUAO/mJ667LLujbA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(66476007)(38100700002)(4326008)(66556008)(8676002)(86362001)(186003)(107886003)(2616005)(66946007)(6486002)(5660300002)(4744005)(2906002)(6916009)(44832011)(6512007)(316002)(8936002)(6506007)(6666004)(26005)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?we/bGKNtH179Scv5zeAjI40EjD4NVmiALa2/HgbR9Mv3qUWcuXaW772PBut8?=
 =?us-ascii?Q?XgW0fmmB2SY+XvGR+4xOw92isUFLrxsx0lTyqmPY9zlJc8khwwW0arlFRksc?=
 =?us-ascii?Q?Gjv7usRQp1qoxZYp7Y0xHha8FUN78vsrCPLyncmK63PvF5L3Ter0tQDQdMLr?=
 =?us-ascii?Q?iBGD6dj+wCLYsT924+xp7T16NlXnrPB8tzvQffBDp/o4Svs+n5+BhZT0GlOt?=
 =?us-ascii?Q?nZJ7+GDGB+QhWWAOhqUV+vlfEH6xmzAKn0UD0DrQNY6l5N8RQBgxaviSXxUO?=
 =?us-ascii?Q?rYi+iqBZbG0f+4h/NbBaWD8DXsOu5NR3b9Ikta66ewm2Pvqat0QDSQbBIiEf?=
 =?us-ascii?Q?Zx1rjGKIsA/lYsIZsj/wpmI+/HuUC0t3ww13+p1yo6DwhJNDZRZbYKUPIu/p?=
 =?us-ascii?Q?vG+iYbXgdvbgG9kvMRyRaayamH0XU9MjtETcBsUVux8o1wV1f1eSvG2qoTcg?=
 =?us-ascii?Q?0yHrlPwfyKr/uotJiFrHiEjYvviDj/xN/nzKRJuSWkb+Rez6DkRghDfAe6H1?=
 =?us-ascii?Q?WzEhzAZtXgG9dFbJ/n0gCJvesIiXryejmtoapGjRUPcG7F/CZrzXqf5NTE14?=
 =?us-ascii?Q?JYBpGqcC3SoO99E7s0jvRxxvu/D7fUxkKMa/PTSH5fhw60QrpmzIBKZF51hv?=
 =?us-ascii?Q?JmJQrg0FTVqMRnWFt0vr3pjbkTFiWjNMIYhk1Sf3L/EysblgzGRl2nTBdew1?=
 =?us-ascii?Q?cjyqArV7iUB6xePHyeQPAvw+EA07ucsYfmlB7iOBVgFkua2My+DSXM+sQ8Xs?=
 =?us-ascii?Q?6QhImwKGUAcuekeNAsR2MrWnceStsvcEsR/YA6lNJy7Og7JPxosaKDOKYBPu?=
 =?us-ascii?Q?YZVx5ILgsQOxGZHpSbBP6L15WCLFvHOxZkbfOQTHWeSxnYwDcKRddZW+1MXK?=
 =?us-ascii?Q?O6eR7jnpVPSk5TKuwULM5lxFXfICf13Fu550nfPuuIfmYkDXWyiEEXBI/GqX?=
 =?us-ascii?Q?qj4EDxa+CMCajE3I1Wi0meBUzKo1b1+KLx0vfQqyMcDkEqBfMDwIsm4+GSTK?=
 =?us-ascii?Q?agKqft1mzsFm52ov/nhJmQTyzchlndXxbHLGKQ11POxJLldTU1J/LInxJV25?=
 =?us-ascii?Q?dDmKFSyjiPsBxcQn4YvDsw5G7v52te2xHIMyMfeNcdrsRIGcsjtA/RJa1gbP?=
 =?us-ascii?Q?cMKxjBRtuPzoEzks0Ux6/SRcmNbskkEnhWmqYzMabuXSziGxDKM4R26mPRzP?=
 =?us-ascii?Q?iSlhodF6dh5xsF9dwfmgn5w1jFRJ0nRPA+FIEpyrJGOqK52s8l0hWyguT6S7?=
 =?us-ascii?Q?M3BNaINg3f9PO1gX6gl2KBiy0k+2iL+Nr2ufZoZgDjYxwRdAS4ArLPPzzVa7?=
 =?us-ascii?Q?LjZ9JhGUPNTlCoIjmvfS2LYvWR3YaGFwO8fXtBXHcZ7RPodDwuNm82+KU9K7?=
 =?us-ascii?Q?E5sKtx2FG+s/G9pnsQIssicRWimjSVuYPR/w8iCFPKKg/mOi5o8T728rV0qs?=
 =?us-ascii?Q?LvwcLjuwyzpQKulgjYufw2tY1adgoq6YMrsCHjkcyyiT/Sz9it45o4FGnH8w?=
 =?us-ascii?Q?5C6RESt4s1ETITpAavc0MLbGiNxAfLWSzVBiR2J5wJbaY3lWLj8YFTiBcmsp?=
 =?us-ascii?Q?kCCE81XAwvPSGE7dCEuZ3QGpOywLVBAHsL4IT5Qfqpdozg3qR6f49JJnkY64?=
 =?us-ascii?Q?IuwHr/fZx0YikpPZXT94AzvpFDjykpZXC6aA5oxo8Q7y3VhSqPmkYSobVRJ/?=
 =?us-ascii?Q?TuO54X54LOMyWv2kB1U44IP83JiyQOwhxOCNX62trArYwUN5nf3475G0e1oL?=
 =?us-ascii?Q?021Im3lpFwULynmh8Awbh/+yJIAlcuQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32535f4d-c00a-4681-8afd-08da40bc6bbd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2022 15:12:03.2740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQasKD/uzGkpoZAkQp+tkWYhOVzKFLP9tqgGNxQkA7/J5TQ7IrAVFS81DwZqJDS3zMxUmtGdxBiVdZyzcHmXYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8485

No need to export sched in bpf_tcp_helpers.h, drop it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 91900f2f047a..988dbeeac040 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -263,7 +263,6 @@ struct mptcp_sock {
=20
 	__u32		token;
 	struct sock	*first;
-	struct mptcp_sched_ops	*sched;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
--=20
2.34.1

