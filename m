Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374F02C80
	for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 09:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1634809896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cmQXP7x2GcOTwYHKpMwNb2ehFEM+RYfw1UGVnFDIr0g=;
	b=SL6HApMLd1If1djoFbNwwXqx/wa4YiR9n0oRjntW6GHOrX4TWG1+utQ3l7XMoyKS/qACAH
	oUAFknGx7YL+pDY/HVwEo8XMypazI0PlnhpAkpiEr7AWit4tFY4SwB3U+/ySnE39+joaMT
	iUfdtXEUo3YfFMKuhUDMDWig7mm3hbI=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-4-7Mnld6XXNoKvGc5Aukt5GA-1; Thu, 21 Oct 2021 11:51:35 +0200
X-MC-Unique: 7Mnld6XXNoKvGc5Aukt5GA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bn1NJwumkfZ0RvtpikSQG8f2v2wlIYNYBJDGCP+GIZ+6HzkYXK1zh7ddFLjUwfR6LMy997ebCkuNhNnsEv9YHXaEpL1dyP/kO1QwRLiPZURJGJyLTgddM6w1uiFUvqnF4uUVkoJyPZzprq2KDK+9lFR27ClWZ0+kQVQdE+Tev5qvirciNyhTxp8srJtHhw/YHH1vbDktkgew07MeemG7AMzRPnjriuUk1E5mfcS9rWxbvwJJQnPq0F1v2YMyeVegM3b/5lqvSzG6z3BL2NQllze2Z7wARFUQ/Cu0XWL02T/+u/JeFDNXOnn1A2sz95QNkCMHBNARYnwVMZzqjmzyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOyUMRBx49xbQ70XjZlZfLvoWARlmb9baySsptdBrns=;
 b=i0M8tq6xWcopxeI+aeJMx2/xXu6SAeO2WoOrtUg1YL55zeBaLrCQxiZ1mz/BFFeifU3Qu2F3BSFf4GHbVKYbLZ8DiBR+hdvtkk/M70/PypSdjZl2DzKKCtc4wraJSxEThqNmG30pzDVOc/Abl6w2r+1LiQ2Tapeeg2beime0ynvCzsc3LuPsTERpOQ1Kc6374mVIdMAzDDF3oLHYotw5ULxze+xTbuF+1Bt4rESZh9WOW9mQv8xR2R51IZLceJra1pP+0lfX3rhX3XO0TG18X/kMusE1JwGpjuz1+44U4gMypiFACohIRIjJbc9YlJE2ZX2eKudGyYU2Y2Igdi+Cyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3514.eurprd04.prod.outlook.com (2603:10a6:7:83::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 09:51:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 09:51:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] selftests: mptcp: fix proto type in link_failure tests
Date: Thu, 21 Oct 2021 17:51:16 +0800
Message-ID: <73206a1932f3f6baab8cfe5bf210fb6fe4cc06cc.1634809754.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0217.apcprd02.prod.outlook.com
 (2603:1096:201:20::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR02CA0217.apcprd02.prod.outlook.com (2603:1096:201:20::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 09:51:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 920362b9-63c5-416b-8734-08d994785d41
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3514:
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB35140B952993BFC5769A839FF8BF9@HE1PR0402MB3514.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Mw0Ru2hgItIkHovniGBi2w+B6Q/awJ7KcJgT+YBAmgGqvpriUkpZrydzoBbfd+csJmS3liqH4z35eorQ5VRgjrgBecC8egsSQ/Vzrt1RCKT673DwHWpziCWSEfCyTmN/gUw3eEbrvLDU+F/uXiOHTSIUav5lCy82CGYkv8m2VI/wJ+Xj5AixBDBOu/EU3lC7tBmnCVE6x/IDfRm4jd3vLRln7/sV+ym5FVRP+pgxuCnx0UPxNtgduXtLmC1zcVZnXjyYIwefOHF6wetxKqy98QabXKaFiIA3L6tHkUoEkTzluDCr4VgEG1Vs8jq2qtHRTe4KS5UkqjWeyejpI9g5SegjIS0VrAfdGpiesY9aozaI+P70KTr4+Pb2qETnqG1+fLJVXmAQO1I5mmUKziaVinVnW92ShUfaJv/U0iSxBR59alz/EHk4Er5LPi20EZjuW3m9KCkYh6zM0KjWkCNLcEh+nwS/Bc01ntMbAb9I8vkKt9LVjACFuHVN8fV4pL8PNbEGJJKo7A81apJVDtWoRrmBGvYd3Eg/ngqxsBE9/tJAWdtDVJADCXn+UgfpoL1wYHL/SRZCt0zYxs2IIqfsUDXtm/yOCP8IM5i49miBbcJpbaGBYOybv3oVScN8bldzgvFejkB0UTFsxC5MHy+wQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6496006)(8936002)(2906002)(55236004)(8676002)(83380400001)(6916009)(5660300002)(44832011)(86362001)(2616005)(6486002)(107886003)(26005)(186003)(956004)(4744005)(4326008)(316002)(6666004)(36756003)(508600001)(66556008)(38100700002)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dgFIblzOZBfQFMKZNQLdtC17pA0v6ZFe5/uOXEBQdMbCbqQ01VJOX3MUs89X?=
 =?us-ascii?Q?+4NJjN6bcr+YEe7jSsKjQXZ8Kodw8SR5jzRk18HehhCElBOr5Uw3ILIau1VP?=
 =?us-ascii?Q?QXrutNKiBzSm+a8+d1T8j8H5nyGRbjwIVW3YNzdHKoXz2CsDRA3dxFm9JTyo?=
 =?us-ascii?Q?VGbxdG3vLKq1d2NXMOgi3ewspZ7dglSjhQEQjvJ6xbhj1WBcfcXc9ISvFnZ1?=
 =?us-ascii?Q?uQayFD210uxSwfLtkW/Dx08ehjZjQj7HCDWnz8mE0znXOwxPCNKRdloKp6mI?=
 =?us-ascii?Q?IJiRK5MQ2ZzCW1t2xxLCj0/sw6og0sY/6hCzGNiB0l6KREAgqTRjOoDEAQ/j?=
 =?us-ascii?Q?fCU7LTEgxBSvMkCVmOcg6ZIw2HMigIoM4FfVb4LOwkEwa2X5XtgHbNJau1b1?=
 =?us-ascii?Q?qEWseiR5V/IaSHtW/C3L3igBqEI3n1kQ8iTvX5kwccNQszM/pEI3BaRwABx1?=
 =?us-ascii?Q?Ic5zjLj8jge8jRSZYbG/MqXaSjdT3x7FhFxvAKMNm3br5pA4JgKCTXCtZXrZ?=
 =?us-ascii?Q?LaPEN0Y/4R2wMOi29fx+T7omdbtevrWpuQPgN9pdz/GB3kLo68Uy8kmzwFbE?=
 =?us-ascii?Q?Ze+2trSBSJXGVHdXhoovrqqOLFGeul18Km1RA2gQFDmRqp4ZJSmQyVumzf8r?=
 =?us-ascii?Q?3AOdXW8SlKspgj4T5vZpdmVyRL1qSIPUO/1HtIsopTvvhHHJQnaPkSRmUUh4?=
 =?us-ascii?Q?RxMm1jQlZffdSxxIGWT88g9VeJxgvTFpzw15DY/arPZOscxaA2UIcTaTBIAA?=
 =?us-ascii?Q?QFtEOCD9p4CHpjw1z9DkAFGdyJDJ4hhFLwVHm+a1IaqKIw4jF1OzRPtU5nQC?=
 =?us-ascii?Q?PyIlOjbelEY7jvcUeG5R0xJLufchqkTM1wwlIqIPzrESg2fUUARCSlc8jqu9?=
 =?us-ascii?Q?8VcGyaxe43Gwj+Hfu61qBtp5XyJqoXyL4S4XMFpIgDbwdJ+tqmxwtxoL6FB7?=
 =?us-ascii?Q?/97tLgpMtDZsskeFtB2wT1eJjhKo2dbulAXkSQVJZTQMJDacAL889OQ7gcIa?=
 =?us-ascii?Q?0Kep0zsGhqzbNAG5rqe6J3d+eUlYfpj4jo4MRcilGADAUqIE++XRgAcIR8jV?=
 =?us-ascii?Q?tA25mcFWrtBGiYIMd5z2XD1Ir5WMncsQqnqTvR+pMLbK26vz6RTd3+lQs6X2?=
 =?us-ascii?Q?r/pQMo3haXE9EWFKjXIqoXS2XXfFvzxZAl9IqugYKCqgydDyb/0OzDzgLe5k?=
 =?us-ascii?Q?4UgETan+hdn7unxu91l0Dasx24EvvrNSfpGJi/BRJjLZ2KRizAbv2I52whUx?=
 =?us-ascii?Q?X5WZEY8d+I1e79HzXbXX7wgGEyXFXHcagInBxRTHzQOeIZC5/JTU4fdRuzBi?=
 =?us-ascii?Q?XL0XCIy9asx13ZADkThhRfaxSpvz31MwEnTPb5d2aka7Pe+o9Ag0yra8UqkP?=
 =?us-ascii?Q?QQm+lq45B/5Tp7h8yMAU9M2QKJrFRBFVtebOgEKMZZzL0XQe0QN49BL8HqT5?=
 =?us-ascii?Q?l2qSctPuQc4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920362b9-63c5-416b-8734-08d994785d41
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 09:51:33.2327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geliang.tang@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3514

In listener_ns, we should pass srv_proto argument to mptcp_connect command,
not cl_proto.

Fixes: 7d1e6f1639044 ("selftests: mptcp: add testcase for active-back")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index b3b351b868f9..129c859c6e3e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -297,7 +297,7 @@ do_transfer()
 	if [ "$test_link_fail" -eq 2 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
-				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${cl_proto} \
+				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
 					${local_addr} < "$sinfail" > "$sout" &
 	else
 		timeout ${timeout_test} \
--=20
2.26.2

