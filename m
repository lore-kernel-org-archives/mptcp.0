Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA6AEBE
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:02:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3idN+BY0+yRQen8M54gTLLPzUdb2TNVw90ropr6ZhXFz8c1k8vN9spNbVFDhu5FhXextG/rqw7ZwXRaH+8sxjqC49vZELpMVNYERDOxhJan8AFZyCLxH/vuiTUpxqKfPifXnss7tUnKoxxueuRfNGJ09GprQXxZYpZDyZ9FQcYFkO31Y5eHsbBATPus9vFn/6ifS5Tghka0p5A9X9sSjY8L9uZikbeaGRZx7O4dfQVxX1Th/TqP/ezVfGIcJi/BABxGG17CE4xfvNoKrBT2LCV2HhJgWUZVIspQfBD+6KMVXlmuSb95hyh6F+f+5b+UYRxYyO1GVWJ3aNZQN8TpGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxJoP65w/SR8UJ8c/cl5Nvzh7Nzpvhdk7YlZORSm580=;
 b=kny/9DQJKJEmFVT9ISyYayiRHHNzdUi+t1ftFJnr1sNvQ31ZxyqbkVNDaenKtxFFH9STIsF3k3cARPF587+XVDIm0vMhhTOk9zFvZyeC2AXyAIb6mrai3JKUN/Q+PZN9IpSPct7I6HKB+odsf5rgUKxyOFbpU+Vm2bCjvIkgli2B2/Iq5+5YPojaDBP1PEUnY5s8KQsNtzWwcLB9/asx6ldVBbpelvEEmkmAAxu5Fcg8DTaqlB+YkfPVzrq2a7qJEcvy+AZ8R0ET8NuqQOTz5j2/gPY5fcu+bpGPa39OltiOH2mWX926zuOYyOcQ5VrK1wS+AjAR19R1ZlmnR6q89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxJoP65w/SR8UJ8c/cl5Nvzh7Nzpvhdk7YlZORSm580=;
 b=NDM2QJrs5A5XqNsNfMBPxlSkBTwcwT/KYrGMffoGTlRlAMbPIzpAGSCuAanphtfyhCn8dQnFiaejrTjvVa+de23dg4loPtPJaC9OTAob70ThKQy6je/8RiE24J8wCR70zUoY3LgWe66OMeKZKhS0f2rDHHO9yPJhnnfw+foqnnSX1wJG18HIH833PiGvZwgq30NrM9jR+bviTyW3Z6Yx1NBoD2cs1ybeSchPposc1uM7YDaTFnuuELUd0k+0whhnoHCJAEqk7uGjsx8Zz8czPaf8AOtIpbarLwiaVNmhPIYWULC528cqFyqK63M977uzbVfTn0KEwAiocI1pRLstdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:02:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:02:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 04/30] mptcp: use mptcp_wnd_end helper
Date: Tue, 19 Sep 2023 12:02:05 +0800
Message-Id: <61179b15016da6055cc5a33dfdaacdaa30883cfb.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a9fcc5-7ef9-43aa-dc8e-08dbb8c53c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8JIQEVuZa/tVxpElUjKm9/EhhDJuLJszHO46jT1JpO4Z34XKKJbpZrxvf6rMe1DYP1Jvw7sNDC567IGUYUjrzaZV7s+6y89uEgJpTAPKB6ac2+UPdyMJwX6G79wIsOWnIRsGrBU0JxfRdhO8cXHcHiAMidg2qwsRe823EF/tElo1xE43qnjz+vL4KBQ5/ypafIo/gWVVicF8RKbrLK/mt3A2QwqhqK3sQAyIvnyDPrh9SsDEuJu+uwmn+qkRjS7sKC1s6hGRX/jBu86embboBwV5t7268oXme96V9pI7kAdEsCbZXzGlkCpKP7M1UxZGvnhj92aeTNgJPDkSp2NbH8C/Pg1b9taZ827NLWWMNYf7zQCAZxLh7oC4jOntpz+SkFjfZ1poMMDh9SSUeyrIdndZrmcZ7iedeLE/425M1OxITZgrrMIF/DsWAPjEfRFcNFBZxT8mKiuZmiC+RhH0YdIq6r0mPtJK+6kiE9zKXd9q0u7KDmSBeFXi31tcZyUzrPV5jqJ32St1dxHsj5TRvywkuXb9j/qKISeJ0sY/XZqfe4/TOJlTkg/pfhCcbYRYdSBeLhQML7SFWnzgbeDZa5o8K5aXIo9eTqf4vwOQH94=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(2906002)(4744005)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(86362001)(26005)(478600001)(44832011)(6666004)(5660300002)(107886003)(8676002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g8ykrMAfypdPuRTIpUeTfaoNzOfCGc+pf4PPOnxV9COC+hqZna9tjJ5o0CwF?=
 =?us-ascii?Q?J6cKo+DkmV4IkiAziRhZpANqVs8ie5Lu222opCguTE/OO6Vin0A5h97Klc5w?=
 =?us-ascii?Q?hT9Nn6ubzTtxHuyOl3O3Ml2yeJJSftecZplhN32MGdEQ6QqBAW08ZAKCYy93?=
 =?us-ascii?Q?m1NiNNXtW9/VDiC3++Ri/5mYmMYOVIU2PUwopXr0O6XyxL50Rvheyt4pmngX?=
 =?us-ascii?Q?UYMbdL3Hu0shE/ln7RNtZtEOp4h9iHG6OZe3aY1XFQ50orNV2zevKFFINp7f?=
 =?us-ascii?Q?fpVIDb28bXfweZW63A4/NtXBIGkwRtMm6d/zHu0vEV1BXHlv72wDQS0hWM/l?=
 =?us-ascii?Q?+6OP8Pa0qMvkm3MwEdW/tJay9YQ7W6zj0pAFK8HQ3L+uMCLj9KlSHd6P0jC9?=
 =?us-ascii?Q?pjaM/tReLByOnrlQ8DsiPNZdF7BEzA71zpiIniFwn+UOClAkj3ETMFovEe20?=
 =?us-ascii?Q?8kXM3/jeti3VII1YIhxmnuwOZrs0Dl2Z5IxjTRmp+/gDfQnEh0CViX0z3ZWv?=
 =?us-ascii?Q?T1sYHMuMGvsM5KOvJz50aklo1+bbvtLL0ou2tXPhpPZqF2/f2aLerjTdzcTS?=
 =?us-ascii?Q?cbYof0rvVJmtnMb9EQaC4oy2aQ8QKFgovZuKR4QkSNksn5KQRLKMtRTPDprp?=
 =?us-ascii?Q?Njw3ge2niG70ApZV/TNdTlJm6MMRA98ZAwUrexKaovd63QOepRqmTgogx6rC?=
 =?us-ascii?Q?5neNELT2iW5HEeNnrUGlyK2484GdWtr/XtPHh46TmsJcJ0W52hF4vJLxVhSb?=
 =?us-ascii?Q?6hJku0YBxznNuplOHief7MshExFy5bV82qAR+OrAEJ79NY9RL/WatiutOLxj?=
 =?us-ascii?Q?58B+m2j8CX0wOnIIOIrpWCw8orAwpDnpmv44hpOjUrvqEz/yyGkHU66KSIys?=
 =?us-ascii?Q?9iecS8Qx88sXlasaDIDz1jMbEW7S1bl//kvyP0a2sR+Pudt9jQ/QdQdj9ZmO?=
 =?us-ascii?Q?kf2XFOw7YwWnUHleQfy2mitbA9jbih3U+Bo+NT99vF0Q2XSeWeLcn5tqUuup?=
 =?us-ascii?Q?jit0BQ9NCiUmY8MY2IRX+XWYBf6CoVL6FwgiRp1IUpL9nqoowjL/IaaYm+G/?=
 =?us-ascii?Q?rCVcghUJDqGfRXb60UvfNOnzmIcoQNgADIF5m5IQlMN98mSB4P2U1naaxlo7?=
 =?us-ascii?Q?/k0/mdt+8pIQdcQ3kN+/mOMCCBuPPLZuN4FhdqO6zkQAGRUARHgHnFvt9bn1?=
 =?us-ascii?Q?q7btc8cbVQHKGoEzWW5icveRX8llKprgt25IXMQf5Tl/IxhOcuyWaalhcXS4?=
 =?us-ascii?Q?z87r3/ooVVwCcO4Ns0WoIcYIbtzO73dtI40PH7Zvpoeuj1LVVulkcSVUcN1w?=
 =?us-ascii?Q?mbLGYBGvn5uDlLEx2Rld+EjBguqi4qppmMNOZNip2EnC6oMXix6hRLkE1+wQ?=
 =?us-ascii?Q?HzpFKvWR9kZeRzN3zPAyL/XqgAkiez7G187cUNgtZg+vUYQLUo3GgZzSTb/S?=
 =?us-ascii?Q?EYZ/n7bBX1LUc6Ug4W+FXciaE8IigGLXVSse6uzdmZnzZxPw99YDCgwx2yKZ?=
 =?us-ascii?Q?jhkW+ZGhNzXtIqknjSBLX2SeLNLjEocK+CvBDGd+Ltntl1dA5vymz/D60WGJ?=
 =?us-ascii?Q?ddVwYKa4Bt1SeFuSbGHP3DrPjCLc4Ct/VDgs7Tvl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a9fcc5-7ef9-43aa-dc8e-08dbb8c53c4c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:02:26.3957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmTiUx283TH+lvOMx1U43nFrQwtS4kyjLopUSbsjscLnAvKzlZ3UbfPd0alrrBrZTpeY0PYax6/Qh6vRQWFWMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

Use mptcp_wnd_end() helper defined in net/mptcp/protocol.c, instead of
open-coding it in ack_update_msk().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cd15ec73073e..f40381557788 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1059,7 +1059,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 		msk->wnd_end = new_wnd_end;
 
 	/* this assumes mptcp_incoming_options() is invoked after tcp_ack() */
-	if (after64(msk->wnd_end, READ_ONCE(msk->snd_nxt)))
+	if (after64(mptcp_wnd_end(msk), READ_ONCE(msk->snd_nxt)))
 		__mptcp_check_push(sk, ssk);
 
 	if (after64(new_snd_una, old_snd_una)) {
-- 
2.35.3

