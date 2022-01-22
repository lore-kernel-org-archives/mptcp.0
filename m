Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16765168
	for <mptcp@lists.linux.dev>; Sat, 22 Jan 2022 11:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642849867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hZORcm92Trxua+/m9+1Eh0skiKpEMGWvHn8qG7MFkzk=;
	b=i/si0L/1ircGjbQY9Jizmlxc+9MdxuvfZgbV2sufKJ2wnjkM5EayGgheG+PXdPxwn8CUQq
	P+YiKW7UQdG8gihUTbD9kke9bj6/0zZhgi9DjZrUwrLKYcMjGdTfoLQ+rfDz81jFE3QoPf
	Dr6YDKV+MHKTfjpB36yONhK2DTTZyuQ=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-obm-dCsmNT-rPpSdRQcnpg-1; Sat, 22 Jan 2022 12:11:06 +0100
X-MC-Unique: obm-dCsmNT-rPpSdRQcnpg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gK4uB6Bpkx/BSL4xK/DivjSPVGulD+AHeBZJc7gE8/ucve4hI5uNGGHQWREKoEtkAegiZ+iQ+G/o0xdBuY8XiWCIHHYAeuPFCFIjk5CdEU3j24/ScGo4Gy33dnJF6TlQnqnNqt3SNMG2uEEyWcbaVp0BzDrJ9bUW7KB+Fy4JgsAnIglw1h/sPP6/66KVxjmHI/5bN1WqiUPh7f3o1XF6m+v7ymHIX3KgDbEYSrishsXCsvDoQhQBfxZyw/xPuJeMERCTJYQ6POTGx2HlNR5RVkkXPoV5JC4qpdGddYhAIIzthI1tcXOAWJ2cuzNMHefk23SH2nvUJXk0vv18NpUn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddAOS1T+acQUupS77rk6f8cmmL97pDqsjLSqjGeS8o8=;
 b=fL1pJKq3qOVogNEwW2YJ5jb/BS8lVbAe7Gobrmujxk/LwGOpMVxWKN15CvByI1zkJpD1J3rtE5/+gHxL7feOKKvZPe7K2aK8ds6V4goAZndQWZ8CsfzS9OSqRTkT9lqfRdHkHma+IjV++G1dNKF/gee6VOr4jxAph0EVHS4r58amIY5S9KAfBpsX/u0HSR8kzOiWoi0hG/IANo1KZsJ3D4V77tIKQLPxl3DyMweKXSWrcI2YtbasBptJs58/6AG5SI8BlxYfeXdogIGAjhK6TzvE8oeNR4/jDKja/N2kgWwz2bD2beSe7SPiooO6/hlLLB44aoil36avC4/pKgQLIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4574.eurprd04.prod.outlook.com (2603:10a6:803:6f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Sat, 22 Jan
 2022 11:11:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%6]) with mapi id 15.20.4909.013; Sat, 22 Jan 2022
 11:11:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add the id argument for set_flags"
Date: Sat, 22 Jan 2022 19:10:59 +0800
Message-ID: <b5580a51aaac444143261ddfc98ce48917ca67b9.1642849685.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:202:16::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf56b8ab-d0e2-407a-0d27-08d9dd97e158
X-MS-TrafficTypeDiagnostic: VI1PR04MB4574:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB45741D5FB8A4B6295601A843F85C9@VI1PR04MB4574.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yRwIbc3XLnHf1gYGEOrfPSKl2RLL6b1mYv3OEqCaaa9vusnYKGudVdnbkT+3ca7Of5cUBusoY8F14Pp4URpNs7Z11t8o0NbOpoYv/qWxfSA9kupRbBxAS29gJwRvdIWTWS+iq7Rl+OEMGKsuy3WcUX7i1UDRMBgoQHSeMuCkLe5lzgEnU1chDsdOawAta686IFKmHLcImUcu+YannXWzcBd3n3VB/KUXBMVPw4L+44/lNv1PKIqPaDU3Xehp4RtvcEX+64dVOSJSQ941vV0tNdVf+Gbl+kziXnNsOSNFABv0J7GesDrwnqQ8YmS69zQ+zFHd64lzVig0pSojurmxvs8hKG8ce9Q95LufAv2nlzw6t5XMh6uXGr2YVmQ1laqZcq6npgsDo1h5n07HX/1+Q7z2SgM0AUzErjt6W2rOwDpssd9opzMxiqfSu/UrPC60b/Os6PcoBbW36gdAeRTo4TRHLQsN7qJsp4e9QowEQqkevYBtY+cCcXY5nPjUBuB60JEZJHTK2G60BDmvLo418Ob19IsiDEVjm8KrgKcXFHYb4Q2TJ1C6DuzM3Ngvr5/YdfoZH61tUH/j1RN0r4X9DveX3/pZnuu/RTWrTECb5n9m2vyiKqggPjhMt10TzdSrJOUbRbXeMIWxjHm7gxOOY9rPZdbzD5fsOx8CVml5WFgy9eoFb6be4cl5hpJhhQt7jIQK3I+vksuHg6dQi5gC8Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(26005)(38100700002)(186003)(6486002)(66476007)(66946007)(66556008)(6512007)(5660300002)(8676002)(316002)(6506007)(6916009)(86362001)(107886003)(508600001)(44832011)(36756003)(6666004)(8936002)(83380400001)(2906002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BMBM3YsMQJRc+c38k9zXXosbUPN0e/LNlbZlfLZwEYGAsGh+3qPWMnmWawhn?=
 =?us-ascii?Q?jpkq1pjIw3SKQkjCwM8EXmUNL8ljxzR+vg02sJVWQilHIE6gSdM9JMSz4rls?=
 =?us-ascii?Q?PeggI2UnuFgj+z87YUHzmpAUTuh6SYTxZknR2l/Mx66CSFaBJ9qPAXj7bxMx?=
 =?us-ascii?Q?QBlU0pty3Md03plKyIzQKqw+D5e+kz/DT4vavqTsjNfWzJXYxeYnJkcSFY/F?=
 =?us-ascii?Q?cv0NurrrhJ4fwBZxDIGvjMoIduM5PGyW/XQSOFYCp/y+uDGMjPfumBBmKIFf?=
 =?us-ascii?Q?I/S6yoqKPm5qMQNxpqzskl18NE3EHKl8Qazy75/1oXKNFCOrbu6SPFPYHHUv?=
 =?us-ascii?Q?AaGophzpphuG8SY2Dvqq0+Y7Ntcjk3ytoVehwMge19JEtqrFKLujmlM95Flj?=
 =?us-ascii?Q?7xMvbAziV1YgdiPruBokmy3UuX1QCoPOmtvSVtmTmLgh87vOOYOG0D8RV/+n?=
 =?us-ascii?Q?RXn+Uz68HLoww2PDqdxwPms1/82okm1dbgle6c3AcnAHERj13A7OyrZNzEzz?=
 =?us-ascii?Q?8ghrdknBTjz/LHO+IZAN1JQMAmDwArf7yuwTVGMhaKrbaltD/IkMfjHs9KxL?=
 =?us-ascii?Q?r8xsQt1Viqcz0AyX0RJ4I+1UIPTsaTAZcfLj892ibYSWMSqFb+mLzD00614q?=
 =?us-ascii?Q?xX+ZKAIuz109yzwfSC/ETzObcAFa72+ADdD1SdtCtNHZdoZT1TQ+HHaBiaco?=
 =?us-ascii?Q?LGmmoRgmG82+Lu/1ZXq3DjvA0NFrcdffeSbd2Ubh939q6OI4upRCSy5Suh+7?=
 =?us-ascii?Q?yUrNUC5GIzhSU7IX/vRvOOoaPnke6fJ7H5MCqkj7oHuZg7dSvBp3/+39piXz?=
 =?us-ascii?Q?pO7XApzlD6BYa6myDK4H3cnDli+unAFNQwzNlkc98vBUsYrRoSnjZh8YCBcn?=
 =?us-ascii?Q?rxFq+dIgSQrTbYqBJB+2eLlPkY7vN1F+NCv1i08yLqn1IdiVhulQt/WUpcxk?=
 =?us-ascii?Q?r+YZ6gxPA54LNKtmxqpr6KLqIgyUlvbkWrqj9oYyBbq+y3/jnzPLog7ccuwS?=
 =?us-ascii?Q?Gp+Ey/zx44TdX2Qu8188R+wL3eefBmYYR9r0i6izWahgF/fmj3wQ9l0blhqR?=
 =?us-ascii?Q?3J5HR/0K/jbL+DfHLqgcECrbNoV4cHQleR2ZGvqt9n/LpNjQw4B6aa2jldV2?=
 =?us-ascii?Q?/5vYa2HCFl326eCxZ8aMOtThYItbXFuanulq49gyv65jEaAoibTLrtdCRhRO?=
 =?us-ascii?Q?nIdXHCIPnvhgo7FID7G2E8/C4p9ENxsQqyj9RF5/6ltgPWSYNaD0CZfVsNT+?=
 =?us-ascii?Q?ja3NMR2dfiHapFxHwu5oPGB99xruU0amxd7t259ruTBqb69IfER5DVNttENG?=
 =?us-ascii?Q?5Skx9Fn1m+lQCenpEdFWWYOCL+wsBsmhwkPJLWJVXYKyFgsYwQLk3rbEm16G?=
 =?us-ascii?Q?wvbLdZk21B6uxiDyCeer0Dwkw024ZtyNSBqshhcPavA52X8nwkze+r+aJQNK?=
 =?us-ascii?Q?txGpTBDYG8xneNxr182+sV93Ngheqyqa5nY1Tk7wQUSv5axtRWDgVRGKYOVt?=
 =?us-ascii?Q?bykzX2Jci1d9atecnWMtUlCqY/VFUxG1MYIk4hQKWpuyxsiT4fkzUzK8NsO8?=
 =?us-ascii?Q?xl/QMt5mOjcFVlmwkrzBTDvMzvnb8fGUdg1mPthuuxzVlGLAKaeuYft5yUob?=
 =?us-ascii?Q?1k2MRG8UIjGx0wZ0XMMYGO8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf56b8ab-d0e2-407a-0d27-08d9dd97e158
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2022 11:11:04.2736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzzp1YIT0SODgvn1vt1BLrXMsTLBEZEA5xQ+aJfO7IQC1ol0c5dRvOjAsxwST4VXHjdkgRujVcY9UAUtv+wr1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4574

Update the usage of set_flags.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index e554928487f8..32a7213052bd 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -28,8 +28,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [=
dev <name>] <ip>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
-	fprintf(stderr, "\tset [<ip>] [id <nr>] [flags backup|nobackup|fullmesh|n=
ofullmesh]\n");
-	fprintf(stderr, "\t                                                     [=
port <nr>]\n");
+	fprintf(stderr, "\tset [<ip>] [id <nr>] flags [[no]backup|[no]fullmesh] [=
port <nr>]\n");
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
--=20
2.31.1

