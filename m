Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6D82C80
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 06:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644473059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y3MHSR7jzXxqIAfaYdndyDxzqArHbB6KSOPW/nParqg=;
	b=efFkiLU4mGxLWjvK+HB089ORr7MYSj0YJgevWKCw5t5ZNRv4OXcfzM7S/ZKIrhbIN7Si3y
	P2lQBu6AMO+6r3OB3uQnGYRmjmuzi4bW0XtSQ5V4GWAHDwXWIWeOxVZsqgqGkREOQ7q0a5
	pRExFsP3Scvy44j3IRSZ/EFHOIcuGvM=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-5LeMVtJJO36anRa7zC-slQ-1; Thu, 10 Feb 2022 07:04:17 +0100
X-MC-Unique: 5LeMVtJJO36anRa7zC-slQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1QlOZT6+P892rAisZgbkSm7Ofu53fmLruzR/s2u6d8T/k4BhzXHFiq3ocSYzprEQPXHxBMyXNEVAGttJeDeAsceClfXkJGhNq/RhcIYSvgKzzIAd5O7WzZbhW7KVZQVMScR9SeQTVKyYY+Ukzm7B9YMBdaTg6xtk3eDXoIYaOkWEi5ihrdLuDa6+1IOhSuiwJsyIbd/WdfYJorTYsGv67dT9ufALaljx5GQ9kIXtBX2YorBbcbUr9ytkKNC8pwi99M1O7CsTW+e6HlRoUolYfD+KJgQIGvRCYG13FVNGqZj8RHNpuH/XlIbQpgTYMZoIP7M2psFhzrj1cxzOJwJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3MHSR7jzXxqIAfaYdndyDxzqArHbB6KSOPW/nParqg=;
 b=WMaka6DBK/piQwsMp0HuiKCS3yj0QvAHo0ybPJK4f6mw9YO7UkcUUsuo41gnuFBDlBVxkuVDAFpO3eRlIYMzzc6STgGTY7J3yE0cumt6/H0HbcdZpsaVpAvAcz3l/ti4XCb/Oo/OfY7YcG6WTWNjZamrE8IBStAc4j+E6mm1/3FhCGNxLrOWf1UHt3p4zGcYMAOYoQ9f3HjqLkOPhCmFMXh4XfrkqZn6ttM1LNLoJJtnqUKBbeG/jX/ElCYpS977znYFApRFm/6IPpwZNRLQrfAm2bdMvQFYiKD0C/cKY7HOiEodpYv7OymwkuJtbpgVK3g5A6WLGEB+x76SLu7gtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBBPR04MB6059.eurprd04.prod.outlook.com (2603:10a6:10:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Thu, 10 Feb
 2022 06:04:14 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb%3]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 06:04:14 +0000
Date: Thu, 10 Feb 2022 14:04:40 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v6 0/7] add mp_fail testcases
Message-ID: <20220210060440.GA21304@dhcp-10-157-36-190>
References: <cover.1644466570.git.geliang.tang@suse.com>
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <cover.1644466570.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2P153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096::18) To
 VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd1d50bb-5adb-4db2-7531-08d9ec5b28f2
X-MS-TrafficTypeDiagnostic: DBBPR04MB6059:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB605961D862782300E30C0A7EF82F9@DBBPR04MB6059.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N8cAalXBUACOHgMSZtY1ccrvP4pJ6yIRuIf2r3i8EYCLJSNz6Dw0EMaYDvad2q/vRWt60VgPpqksrJyxzw1HegJ79SDvI34JcaJCLuhLu4Cc0mMoOATSLeVpcprRuWLbVbJhspOkqs1KMFZLTTHkt5jL/ybpGn7yzhLI1U7YuLYUkRxCidKNI/ZhSGtlLHWm8x3Sk7Ox3w0TaRK5flcLIaqK1n7fzD+TJ64anZ38qrGvPbV5IpGqrf6Ih6lvKLk8R4xwGcrljDROxn12n8zPuKRkC8eraFg6tQIuPK74q6/U7Lw25aQ0cRGJUt8uB1OGaOmaiNTAw2co8OsQcIv0t22LXjRok0NvhXuh5DTXaMsXnZocr7yoHJFTaqCBnbctNj/m3vrJU8YjqHe9hPfopEVsXLPEQsHgTJjlI6agFEaL3A9qqhLrFkFjMBF1M4kLfUlTJITFNiU2Xd2EfzfPvrwxvAG7UkLoV1DLmeB6p3f9cjegCA8EuItK5mNVQv03VfxL5DTlKNX5gGV+mtbelPTbseRLPqy21cflEfIbFA9G+qHrRZJp6RVvLRaD0XuJjfAvwFTGfosdlLZVK742w3yIlVmYwudSdnbIw7JsfAwrQt5dUm52yetU/kzDezdL13567pJIPiL+jqoQQcmpeJcxYEI4ki2bkGKs5f8crx0NkM7hxLs0+T9IMQ9B2dIRiwJDlByimQQZo45ugPr4nA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(21480400003)(6506007)(5660300002)(55236004)(44144004)(8936002)(26005)(186003)(44832011)(1076003)(33716001)(564344004)(2906002)(6512007)(235185007)(9686003)(33656002)(508600001)(6666004)(316002)(8676002)(86362001)(66946007)(66556008)(66476007)(6486002)(6916009)(38100700002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2IHZcFSWOEs+a2TRTD4eV2dIYA3/4eTgWduKXNqCmIYEPGDTDoJi5IwyZgK+?=
 =?us-ascii?Q?KQ74id2PKtecKOThxt4RaEglrAM8XaZK37nudGkuZ9xDCKXU91xxb/4sfEvZ?=
 =?us-ascii?Q?xwygZkgIBV/2mvxngcmLHu7OcTPx40hx0HuqzuNK0JLiPryK2k9qj19scixV?=
 =?us-ascii?Q?ehGVNxLzKg7Fhak50I5W/MhD1v1lqzbBbZ36wyrbw9Xbw0ZDJs6aiBPwYHQ5?=
 =?us-ascii?Q?KNQ9ORsEf4iziom2Fzzfdqnw+8aHsBdfG1Kt5JVdigM/k5Rv2MLGXKrm20Ka?=
 =?us-ascii?Q?i1jDbCl1K2dM1sqsh+itbK9Ap16XaKfToZ6wuD772CpkEDDMS3SRJ2bOQyKv?=
 =?us-ascii?Q?Pq9a/3ewR0NMyXyKgKGJr5wUtuAIL4FUZqSW0s+5frAFC64JaueQf/y8zi3V?=
 =?us-ascii?Q?lGPKi/WRdWtw+5wkh10VCP5LdG7ZbrXIAxiqrav3iG4Vfk42CXE3W7RgSfr9?=
 =?us-ascii?Q?P+U9XEYo85FPFulRdWhDc6DlqpRTJr0JXrQENQHW/3ojUq92YbDvHr4g3ZNQ?=
 =?us-ascii?Q?1/CjIfO6ONWrdDyUH0iOol48UdpoVseIgDSn4bPQh01OuE0UF5Ezg0pXqWvG?=
 =?us-ascii?Q?h5FPmFt3X88OlCprJoCaomnev4+9lXMbesFOvxfQ70vUtLw6hF6nblOkq0Oj?=
 =?us-ascii?Q?lu1SV0+J8Ar8zUSg7NPB+px3SlS4VGX770/jo/IfBUXQMT3Tg2jcpkmbz7Ws?=
 =?us-ascii?Q?EARxaK1zjm75tWW5dkN/rUFPcvzfmNRLasjqfy1hgXOkwDvyL1/t5sP5eLHb?=
 =?us-ascii?Q?WSGbfoDPwo6K2YlK6Acl7Ni2Fl3QIC6SFSYOVARx1r/gXv82Eq3/R+uCSgyb?=
 =?us-ascii?Q?YdUQ50aK8ZBciKJF67eUAo0cw/M/FcVmI5meXjcSE1L6zX9KG9a4O6Thnwo4?=
 =?us-ascii?Q?Ah4qftwDhXYYk/bpeoNAG+Pg5827sSdjGViWdXoPkvzDS92PTntc98iXcZqt?=
 =?us-ascii?Q?7ggx93QVdmDJ5kfvOtFuYDaMKrDD4NZ3dfHI7CqxQHaz+ClPOYYILtRGS+xx?=
 =?us-ascii?Q?9xp+XP1f79kWeCFj1AMT3k+yicg71XgwX32DT3FRudYKItw+Aa7agXOpMy2p?=
 =?us-ascii?Q?gtGEKJDaRSeTK/U87aH7vH+sKY/DmWyPgpgTlQA9m6Q9OPZlgBMqbUKOtqt9?=
 =?us-ascii?Q?N3sA5fd7bAOfH/n2bGV5laxuVZESyvy1JEo/ejV2u6jBRY+y5rywSc5/Vljy?=
 =?us-ascii?Q?mRK0LF5yD6qEqHjzOiuvdUL9ybRLYnn3zZ2vsUwE+LemxtzSOhMmIEFTdU6g?=
 =?us-ascii?Q?qyGxtQ8ft/YK7tWm6w2VsIhTfwfTaRW/Nm0CPydsbY7aZ8jGMZ4P3h1Wsbp8?=
 =?us-ascii?Q?xMHErrwGSdKHO7iUrmueBQIuU3pp4eLeKXfewLN/5uIHU9+ZN67quM8ofo4I?=
 =?us-ascii?Q?P80d5zySce0Dt41ree2fIkuSp7kE2j9BPebk7xy2KqZ5kpfzdVuPE69jNKCa?=
 =?us-ascii?Q?4Fk/46ljRJtFKWMJQVup/in19dqOVns/q1ohPZIqzJKUEJoD/Z2u3xJFpJ2v?=
 =?us-ascii?Q?ebs0QkeX3ScgRS10LyT9cd0JNkw1as6IwZDoxN3Ixm/W5XTeqXdwmq2Uh4VR?=
 =?us-ascii?Q?HwAanpR/vTKNI7GQS01SajnzIlNMWVIIvqdBS1VDHkr9SrzLrNkHq6U4Fsol?=
 =?us-ascii?Q?M5mLWbY8DbHNSQv6ielW0Cg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1d50bb-5adb-4db2-7531-08d9ec5b28f2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 06:04:14.3729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOUtjufhSUgiP6JL+8xKc+ttMWnfZD/G2tSjK3Om4L+o5oxEVNjNR0yl5RPFkErchzDfLu15X/uIK2HMqfHWXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6059

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

v6-loop-500-times.log is attatched.

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="v6-loop-500-times.log"


1

Created /tmp/tmp.qlUoYG5BaN (size 1 KB) containing data sent by client
Created /tmp/tmp.nupblhaqT7 (size 1 KB) containing data sent by server
Created /tmp/tmp.8Pqa41sM3F (size 1024 KB) containing data sent by client
Created /tmp/tmp.FFe9nGtlGS (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.8Pqa41sM3F (size 128 KB) containing data sent by client
Created /tmp/tmp.FFe9nGtlGS (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

2

Created /tmp/tmp.cH6hHMMcq1 (size 1 KB) containing data sent by client
Created /tmp/tmp.sSMqQ76rPc (size 1 KB) containing data sent by server
Created /tmp/tmp.6mZpdYM1Ff (size 1024 KB) containing data sent by client
Created /tmp/tmp.LJAtY0P2uz (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.6mZpdYM1Ff (size 128 KB) containing data sent by client
Created /tmp/tmp.LJAtY0P2uz (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

3

Created /tmp/tmp.N67PlQ5zN1 (size 1 KB) containing data sent by client
Created /tmp/tmp.AqAeWnJx6f (size 1 KB) containing data sent by server
Created /tmp/tmp.Dr5Z39Cf2g (size 1024 KB) containing data sent by client
Created /tmp/tmp.6ykKJbt6pJ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Dr5Z39Cf2g (size 128 KB) containing data sent by client
Created /tmp/tmp.6ykKJbt6pJ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

4

Created /tmp/tmp.bJqvKmQbzP (size 1 KB) containing data sent by client
Created /tmp/tmp.FsssaROzB7 (size 1 KB) containing data sent by server
Created /tmp/tmp.idHQczLSQ3 (size 1024 KB) containing data sent by client
Created /tmp/tmp.Z18ExkFfZa (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.idHQczLSQ3 (size 128 KB) containing data sent by client
Created /tmp/tmp.Z18ExkFfZa (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

5

Created /tmp/tmp.BIEfNonSx2 (size 1 KB) containing data sent by client
Created /tmp/tmp.qsCmdALaL9 (size 1 KB) containing data sent by server
Created /tmp/tmp.c66hkPszUl (size 1024 KB) containing data sent by client
Created /tmp/tmp.70UpMVdS7Z (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.c66hkPszUl (size 128 KB) containing data sent by client
Created /tmp/tmp.70UpMVdS7Z (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

6

Created /tmp/tmp.x6xPDqBDP4 (size 1 KB) containing data sent by client
Created /tmp/tmp.t7ncQ0v7gt (size 1 KB) containing data sent by server
Created /tmp/tmp.mZoihjPrkE (size 1024 KB) containing data sent by client
Created /tmp/tmp.8bpgQme9B5 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.mZoihjPrkE (size 128 KB) containing data sent by client
Created /tmp/tmp.8bpgQme9B5 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

7

Created /tmp/tmp.jN9LikkA7g (size 1 KB) containing data sent by client
Created /tmp/tmp.yhEz6hmQqq (size 1 KB) containing data sent by server
Created /tmp/tmp.DxvYZLXGc7 (size 1024 KB) containing data sent by client
Created /tmp/tmp.hu66WCzoRD (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.DxvYZLXGc7 (size 128 KB) containing data sent by client
Created /tmp/tmp.hu66WCzoRD (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

8

Created /tmp/tmp.GwIPL3gD0q (size 1 KB) containing data sent by client
Created /tmp/tmp.OYc5lgfbxK (size 1 KB) containing data sent by server
Created /tmp/tmp.CbW1UDHi14 (size 1024 KB) containing data sent by client
Created /tmp/tmp.gfejMhgiIh (size 1024 KB) containing data sent by server
file received by server has inverted byte at 465921
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.CbW1UDHi14 (size 128 KB) containing data sent by client
Created /tmp/tmp.gfejMhgiIh (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

9

Created /tmp/tmp.KKhGMCtq15 (size 1 KB) containing data sent by client
Created /tmp/tmp.ZEqo7R8Xan (size 1 KB) containing data sent by server
Created /tmp/tmp.WY2qkZvANB (size 1024 KB) containing data sent by client
Created /tmp/tmp.e7ZyvaltIe (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.WY2qkZvANB (size 128 KB) containing data sent by client
Created /tmp/tmp.e7ZyvaltIe (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

10

Created /tmp/tmp.XlqDLkt1AE (size 1 KB) containing data sent by client
Created /tmp/tmp.4Zw6l9lDEE (size 1 KB) containing data sent by server
Created /tmp/tmp.4PQ6or4kkV (size 1024 KB) containing data sent by client
Created /tmp/tmp.gyZAGhdCtc (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.4PQ6or4kkV (size 128 KB) containing data sent by client
Created /tmp/tmp.gyZAGhdCtc (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

11

Created /tmp/tmp.xc2ScrhNcx (size 1 KB) containing data sent by client
Created /tmp/tmp.I6qRP1z8XY (size 1 KB) containing data sent by server
Created /tmp/tmp.ri9gU8IV9S (size 1024 KB) containing data sent by client
Created /tmp/tmp.G4pz2IIA6o (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ri9gU8IV9S (size 128 KB) containing data sent by client
Created /tmp/tmp.G4pz2IIA6o (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

12

Created /tmp/tmp.VK2lXmLThP (size 1 KB) containing data sent by client
Created /tmp/tmp.04aGPjm3Od (size 1 KB) containing data sent by server
Created /tmp/tmp.qzcd3FwLo9 (size 1024 KB) containing data sent by client
Created /tmp/tmp.dwV1JlVcpy (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qzcd3FwLo9 (size 128 KB) containing data sent by client
Created /tmp/tmp.dwV1JlVcpy (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

13

Created /tmp/tmp.C2P4PxpnZs (size 1 KB) containing data sent by client
Created /tmp/tmp.h3ikClYpLR (size 1 KB) containing data sent by server
Created /tmp/tmp.YGgeeYDNs5 (size 1024 KB) containing data sent by client
Created /tmp/tmp.C9tefi0xaX (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.YGgeeYDNs5 (size 128 KB) containing data sent by client
Created /tmp/tmp.C9tefi0xaX (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

14

Created /tmp/tmp.3CMZLWoOgp (size 1 KB) containing data sent by client
Created /tmp/tmp.wTlr0wZeI4 (size 1 KB) containing data sent by server
Created /tmp/tmp.KcmQECJN8P (size 1024 KB) containing data sent by client
Created /tmp/tmp.GV3IqTKqMb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72290
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.KcmQECJN8P (size 128 KB) containing data sent by client
Created /tmp/tmp.GV3IqTKqMb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

15

Created /tmp/tmp.DPbpMswQxI (size 1 KB) containing data sent by client
Created /tmp/tmp.J61i3YqxFg (size 1 KB) containing data sent by server
Created /tmp/tmp.6m0FyaUcGa (size 1024 KB) containing data sent by client
Created /tmp/tmp.TZWtVYKa2A (size 1024 KB) containing data sent by server
file received by server has inverted byte at 789202
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.6m0FyaUcGa (size 128 KB) containing data sent by client
Created /tmp/tmp.TZWtVYKa2A (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

16

Created /tmp/tmp.kbphpQLXWx (size 1 KB) containing data sent by client
Created /tmp/tmp.FaKJq5isMI (size 1 KB) containing data sent by server
Created /tmp/tmp.gK1IVKh1d2 (size 1024 KB) containing data sent by client
Created /tmp/tmp.biClD1SsTE (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.gK1IVKh1d2 (size 128 KB) containing data sent by client
Created /tmp/tmp.biClD1SsTE (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

17

Created /tmp/tmp.qL0ts0fX9k (size 1 KB) containing data sent by client
Created /tmp/tmp.vknhe7Jq69 (size 1 KB) containing data sent by server
Created /tmp/tmp.M9J4aLqq1b (size 1024 KB) containing data sent by client
Created /tmp/tmp.z1qkdFKJWN (size 1024 KB) containing data sent by server
file received by server has inverted byte at 400385
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.M9J4aLqq1b (size 128 KB) containing data sent by client
Created /tmp/tmp.z1qkdFKJWN (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

18

Created /tmp/tmp.SVESHTtR88 (size 1 KB) containing data sent by client
Created /tmp/tmp.t7L35Av015 (size 1 KB) containing data sent by server
Created /tmp/tmp.XdTPG35tLd (size 1024 KB) containing data sent by client
Created /tmp/tmp.g8b4Jf8F5Y (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.XdTPG35tLd (size 128 KB) containing data sent by client
Created /tmp/tmp.g8b4Jf8F5Y (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

19

Created /tmp/tmp.5lxr9xCcKU (size 1 KB) containing data sent by client
Created /tmp/tmp.ekyGpu00vM (size 1 KB) containing data sent by server
Created /tmp/tmp.9XDDV8mJQe (size 1024 KB) containing data sent by client
Created /tmp/tmp.IhodH193HH (size 1024 KB) containing data sent by server
file received by server has inverted byte at 465921
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.9XDDV8mJQe (size 128 KB) containing data sent by client
Created /tmp/tmp.IhodH193HH (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

20

Created /tmp/tmp.YYtSL42gib (size 1 KB) containing data sent by client
Created /tmp/tmp.9leBYpTeOi (size 1 KB) containing data sent by server
Created /tmp/tmp.qznl6iLoVb (size 1024 KB) containing data sent by client
Created /tmp/tmp.NnuzykqZ3J (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qznl6iLoVb (size 128 KB) containing data sent by client
Created /tmp/tmp.NnuzykqZ3J (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

21

Created /tmp/tmp.1P4h9pXv1C (size 1 KB) containing data sent by client
Created /tmp/tmp.bz1kv5CZdF (size 1 KB) containing data sent by server
Created /tmp/tmp.iRunwarxqp (size 1024 KB) containing data sent by client
Created /tmp/tmp.gvkh0Qo2jP (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.iRunwarxqp (size 128 KB) containing data sent by client
Created /tmp/tmp.gvkh0Qo2jP (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

22

Created /tmp/tmp.vuCnJTuBZo (size 1 KB) containing data sent by client
Created /tmp/tmp.vSSVKAVLCK (size 1 KB) containing data sent by server
Created /tmp/tmp.JNI257gDG4 (size 1024 KB) containing data sent by client
Created /tmp/tmp.8BEBfWHp5E (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.JNI257gDG4 (size 128 KB) containing data sent by client
Created /tmp/tmp.8BEBfWHp5E (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

23

Created /tmp/tmp.jFvQ9VtKcH (size 1 KB) containing data sent by client
Created /tmp/tmp.HIvD17HOIB (size 1 KB) containing data sent by server
Created /tmp/tmp.f2foyIcTq7 (size 1024 KB) containing data sent by client
Created /tmp/tmp.sH8qZvBOKX (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.f2foyIcTq7 (size 128 KB) containing data sent by client
Created /tmp/tmp.sH8qZvBOKX (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

24

Created /tmp/tmp.kV9V2Uz8Pn (size 1 KB) containing data sent by client
Created /tmp/tmp.nLiFkSGTQH (size 1 KB) containing data sent by server
Created /tmp/tmp.Rwsf1KkX32 (size 1024 KB) containing data sent by client
Created /tmp/tmp.73f3ro6abD (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Rwsf1KkX32 (size 128 KB) containing data sent by client
Created /tmp/tmp.73f3ro6abD (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

25

Created /tmp/tmp.BmQyEhX4Rb (size 1 KB) containing data sent by client
Created /tmp/tmp.feogWCDbYq (size 1 KB) containing data sent by server
Created /tmp/tmp.oPbFX6m84L (size 1024 KB) containing data sent by client
Created /tmp/tmp.y8kmCE601y (size 1024 KB) containing data sent by server
file received by server has inverted byte at 195585
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.oPbFX6m84L (size 128 KB) containing data sent by client
Created /tmp/tmp.y8kmCE601y (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

26

Created /tmp/tmp.JoAFYRXU4r (size 1 KB) containing data sent by client
Created /tmp/tmp.kbgyXIEP42 (size 1 KB) containing data sent by server
Created /tmp/tmp.ikOQRrRDG1 (size 1024 KB) containing data sent by client
Created /tmp/tmp.HCdCgqEWIe (size 1024 KB) containing data sent by server
file received by server has inverted byte at 596993
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ikOQRrRDG1 (size 128 KB) containing data sent by client
Created /tmp/tmp.HCdCgqEWIe (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

27

Created /tmp/tmp.nM3Eau3pvT (size 1 KB) containing data sent by client
Created /tmp/tmp.yv5qLZxjpR (size 1 KB) containing data sent by server
Created /tmp/tmp.djXKj6r6u4 (size 1024 KB) containing data sent by client
Created /tmp/tmp.M04NDGd14j (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.djXKj6r6u4 (size 128 KB) containing data sent by client
Created /tmp/tmp.M04NDGd14j (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

28

Created /tmp/tmp.bjg3UEklGp (size 1 KB) containing data sent by client
Created /tmp/tmp.DpfnvZGxMM (size 1 KB) containing data sent by server
Created /tmp/tmp.q3E3rUwhuU (size 1024 KB) containing data sent by client
Created /tmp/tmp.gPvOq2goU6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 131141
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.q3E3rUwhuU (size 128 KB) containing data sent by client
Created /tmp/tmp.gPvOq2goU6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

29

Created /tmp/tmp.nQSRY5LOsO (size 1 KB) containing data sent by client
Created /tmp/tmp.Jg4OC22B7J (size 1 KB) containing data sent by server
Created /tmp/tmp.nWIBh8AFsA (size 1024 KB) containing data sent by client
Created /tmp/tmp.hkDhIHmX9m (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.nWIBh8AFsA (size 128 KB) containing data sent by client
Created /tmp/tmp.hkDhIHmX9m (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

30

Created /tmp/tmp.ZEnufm9YS9 (size 1 KB) containing data sent by client
Created /tmp/tmp.McWEDsGYjQ (size 1 KB) containing data sent by server
Created /tmp/tmp.iQ4N6upvhm (size 1024 KB) containing data sent by client
Created /tmp/tmp.HSRjTOIPlf (size 1024 KB) containing data sent by server
file received by server has inverted byte at 793601
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.iQ4N6upvhm (size 128 KB) containing data sent by client
Created /tmp/tmp.HSRjTOIPlf (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

31

Created /tmp/tmp.kbpNnx78GH (size 1 KB) containing data sent by client
Created /tmp/tmp.7kZP1Z0ENv (size 1 KB) containing data sent by server
Created /tmp/tmp.2H2jDeHmRK (size 1024 KB) containing data sent by client
Created /tmp/tmp.aFEURX77Uo (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.2H2jDeHmRK (size 128 KB) containing data sent by client
Created /tmp/tmp.aFEURX77Uo (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

32

Created /tmp/tmp.37PtRCxqju (size 1 KB) containing data sent by client
Created /tmp/tmp.9cCajse7lF (size 1 KB) containing data sent by server
Created /tmp/tmp.bVBOrlafSm (size 1024 KB) containing data sent by client
Created /tmp/tmp.S3sw4Dn7B0 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 531457
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.bVBOrlafSm (size 128 KB) containing data sent by client
Created /tmp/tmp.S3sw4Dn7B0 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

33

Created /tmp/tmp.TX4YlsH3dN (size 1 KB) containing data sent by client
Created /tmp/tmp.4Zl7gadDdB (size 1 KB) containing data sent by server
Created /tmp/tmp.zjtC3mkpku (size 1024 KB) containing data sent by client
Created /tmp/tmp.nKq6SmivUE (size 1024 KB) containing data sent by server
file received by server has inverted byte at 261121
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.zjtC3mkpku (size 128 KB) containing data sent by client
Created /tmp/tmp.nKq6SmivUE (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

34

Created /tmp/tmp.YDfkVSyhxW (size 1 KB) containing data sent by client
Created /tmp/tmp.XE0tA1RI7m (size 1 KB) containing data sent by server
Created /tmp/tmp.zsl08Ms41S (size 1024 KB) containing data sent by client
Created /tmp/tmp.FFgqCIPKCQ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.zsl08Ms41S (size 128 KB) containing data sent by client
Created /tmp/tmp.FFgqCIPKCQ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

35

Created /tmp/tmp.7VwI5cQRxi (size 1 KB) containing data sent by client
Created /tmp/tmp.3zLooanovy (size 1 KB) containing data sent by server
Created /tmp/tmp.3gUiIusHXR (size 1024 KB) containing data sent by client
Created /tmp/tmp.RPOx1uEZAy (size 1024 KB) containing data sent by server
file received by server has inverted byte at 130049
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.3gUiIusHXR (size 128 KB) containing data sent by client
Created /tmp/tmp.RPOx1uEZAy (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

36

Created /tmp/tmp.pLH92QfaSU (size 1 KB) containing data sent by client
Created /tmp/tmp.GCvVJfCVgr (size 1 KB) containing data sent by server
Created /tmp/tmp.mHtXaUxZnL (size 1024 KB) containing data sent by client
Created /tmp/tmp.FKbifzZxNA (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.mHtXaUxZnL (size 128 KB) containing data sent by client
Created /tmp/tmp.FKbifzZxNA (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

37

Created /tmp/tmp.ev5m8lI4rs (size 1 KB) containing data sent by client
Created /tmp/tmp.GF0PUSwBla (size 1 KB) containing data sent by server
Created /tmp/tmp.jovdshWBgh (size 1024 KB) containing data sent by client
Created /tmp/tmp.LTia2IyOXI (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jovdshWBgh (size 128 KB) containing data sent by client
Created /tmp/tmp.LTia2IyOXI (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

38

Created /tmp/tmp.K9bFneIiCG (size 1 KB) containing data sent by client
Created /tmp/tmp.DLEXeuiRnP (size 1 KB) containing data sent by server
Created /tmp/tmp.rmapG0VO0Z (size 1024 KB) containing data sent by client
Created /tmp/tmp.qHxFJWbZ7N (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.rmapG0VO0Z (size 128 KB) containing data sent by client
Created /tmp/tmp.qHxFJWbZ7N (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

39

Created /tmp/tmp.UpKvwdergQ (size 1 KB) containing data sent by client
Created /tmp/tmp.9tNnWoqNhN (size 1 KB) containing data sent by server
Created /tmp/tmp.OsDR5hknzv (size 1024 KB) containing data sent by client
Created /tmp/tmp.XeagCMuA66 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 465921
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.OsDR5hknzv (size 128 KB) containing data sent by client
Created /tmp/tmp.XeagCMuA66 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

40

Created /tmp/tmp.e37FLrBvRm (size 1 KB) containing data sent by client
Created /tmp/tmp.FOfRmucSBr (size 1 KB) containing data sent by server
Created /tmp/tmp.w8cVvJAFeU (size 1024 KB) containing data sent by client
Created /tmp/tmp.QGBhFELggp (size 1024 KB) containing data sent by server
file received by server has inverted byte at 400385
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.w8cVvJAFeU (size 128 KB) containing data sent by client
Created /tmp/tmp.QGBhFELggp (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

41

Created /tmp/tmp.2fDs9tQfpb (size 1 KB) containing data sent by client
Created /tmp/tmp.YwVVzkeK1T (size 1 KB) containing data sent by server
Created /tmp/tmp.d7XTvPr8wf (size 1024 KB) containing data sent by client
Created /tmp/tmp.uelm5Vkj5x (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.d7XTvPr8wf (size 128 KB) containing data sent by client
Created /tmp/tmp.uelm5Vkj5x (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

42

Created /tmp/tmp.LqZSfXU5sa (size 1 KB) containing data sent by client
Created /tmp/tmp.6AyC1bJ2oU (size 1 KB) containing data sent by server
Created /tmp/tmp.CjEzGfj9p2 (size 1024 KB) containing data sent by client
Created /tmp/tmp.BmwBERxTfl (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.CjEzGfj9p2 (size 128 KB) containing data sent by client
Created /tmp/tmp.BmwBERxTfl (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 4 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

43

Created /tmp/tmp.BmFIiaD9Sk (size 1 KB) containing data sent by client
Created /tmp/tmp.Mtc2MFWqRv (size 1 KB) containing data sent by server
Created /tmp/tmp.hyWis042E0 (size 1024 KB) containing data sent by client
Created /tmp/tmp.U932vKQspQ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.hyWis042E0 (size 128 KB) containing data sent by client
Created /tmp/tmp.U932vKQspQ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

44

Created /tmp/tmp.JqmXBs0JPc (size 1 KB) containing data sent by client
Created /tmp/tmp.JDKUiUNIcU (size 1 KB) containing data sent by server
Created /tmp/tmp.iz0Bfw3HRX (size 1024 KB) containing data sent by client
Created /tmp/tmp.rpZyLypUXg (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.iz0Bfw3HRX (size 128 KB) containing data sent by client
Created /tmp/tmp.rpZyLypUXg (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

45

Created /tmp/tmp.6yA8kiPmgn (size 1 KB) containing data sent by client
Created /tmp/tmp.Nxtih6l9LG (size 1 KB) containing data sent by server
Created /tmp/tmp.VTrF9A4hKO (size 1024 KB) containing data sent by client
Created /tmp/tmp.onZJmuUv0X (size 1024 KB) containing data sent by server
file received by server has inverted byte at 654337
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.VTrF9A4hKO (size 128 KB) containing data sent by client
Created /tmp/tmp.onZJmuUv0X (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

46

Created /tmp/tmp.DNlskLNPEX (size 1 KB) containing data sent by client
Created /tmp/tmp.hVvQj6zT3i (size 1 KB) containing data sent by server
Created /tmp/tmp.aEzSbzcsSc (size 1024 KB) containing data sent by client
Created /tmp/tmp.NCzmzBwXhf (size 1024 KB) containing data sent by server
file received by server has inverted byte at 329505
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.aEzSbzcsSc (size 128 KB) containing data sent by client
Created /tmp/tmp.NCzmzBwXhf (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

47

Created /tmp/tmp.SJUvSSMDuO (size 1 KB) containing data sent by client
Created /tmp/tmp.kS3xv7HSzd (size 1 KB) containing data sent by server
Created /tmp/tmp.nDFnUz3lTA (size 1024 KB) containing data sent by client
Created /tmp/tmp.OscwUqOm43 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.nDFnUz3lTA (size 128 KB) containing data sent by client
Created /tmp/tmp.OscwUqOm43 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

48

Created /tmp/tmp.d1s5x2zXXn (size 1 KB) containing data sent by client
Created /tmp/tmp.YyI1hxZ33y (size 1 KB) containing data sent by server
Created /tmp/tmp.XhQ2T0koek (size 1024 KB) containing data sent by client
Created /tmp/tmp.GB1QRPuBp3 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.XhQ2T0koek (size 128 KB) containing data sent by client
Created /tmp/tmp.GB1QRPuBp3 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

49

Created /tmp/tmp.TpWwLnr4cZ (size 1 KB) containing data sent by client
Created /tmp/tmp.gayZ7DoWmw (size 1 KB) containing data sent by server
Created /tmp/tmp.hljjFioswD (size 1024 KB) containing data sent by client
Created /tmp/tmp.hFa3c8KzcD (size 1024 KB) containing data sent by server
file received by server has inverted byte at 719873
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.hljjFioswD (size 128 KB) containing data sent by client
Created /tmp/tmp.hFa3c8KzcD (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

50

Created /tmp/tmp.WmJTUuLM2e (size 1 KB) containing data sent by client
Created /tmp/tmp.Dikhm9yz5R (size 1 KB) containing data sent by server
Created /tmp/tmp.x9xvbbh9hz (size 1024 KB) containing data sent by client
Created /tmp/tmp.XyWgSNH1Mh (size 1024 KB) containing data sent by server
file received by server has inverted byte at 131141
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.x9xvbbh9hz (size 128 KB) containing data sent by client
Created /tmp/tmp.XyWgSNH1Mh (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

51

Created /tmp/tmp.FYFLnZPld3 (size 1 KB) containing data sent by client
Created /tmp/tmp.XuA2e7sp0Q (size 1 KB) containing data sent by server
Created /tmp/tmp.4iocN5wdcL (size 1024 KB) containing data sent by client
Created /tmp/tmp.sVJECqpbUX (size 1024 KB) containing data sent by server
file received by server has inverted byte at 137993
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.4iocN5wdcL (size 128 KB) containing data sent by client
Created /tmp/tmp.sVJECqpbUX (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

52

Created /tmp/tmp.CGnOO6GQRg (size 1 KB) containing data sent by client
Created /tmp/tmp.XpgnkA18Yj (size 1 KB) containing data sent by server
Created /tmp/tmp.VAofqJqDCH (size 1024 KB) containing data sent by client
Created /tmp/tmp.fQuujtDUD0 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 114757
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.VAofqJqDCH (size 128 KB) containing data sent by client
Created /tmp/tmp.fQuujtDUD0 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

53

Created /tmp/tmp.Ixgc37jX24 (size 1 KB) containing data sent by client
Created /tmp/tmp.xuJCAj6nLG (size 1 KB) containing data sent by server
Created /tmp/tmp.CQ6uPItzNE (size 1024 KB) containing data sent by client
Created /tmp/tmp.ttTwDeSxen (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.CQ6uPItzNE (size 128 KB) containing data sent by client
Created /tmp/tmp.ttTwDeSxen (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

54

Created /tmp/tmp.sQWm66dE0Y (size 1 KB) containing data sent by client
Created /tmp/tmp.tCNk1jQ7Io (size 1 KB) containing data sent by server
Created /tmp/tmp.xRx45yqdlu (size 1024 KB) containing data sent by client
Created /tmp/tmp.H5BAS7Kfbm (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.xRx45yqdlu (size 128 KB) containing data sent by client
Created /tmp/tmp.H5BAS7Kfbm (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

55

Created /tmp/tmp.ZQBr8g5Emp (size 1 KB) containing data sent by client
Created /tmp/tmp.08SZPLl1dU (size 1 KB) containing data sent by server
Created /tmp/tmp.mrYRV4y70H (size 1024 KB) containing data sent by client
Created /tmp/tmp.qapdWcpNzq (size 1024 KB) containing data sent by server
file received by server has inverted byte at 130049
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.mrYRV4y70H (size 128 KB) containing data sent by client
Created /tmp/tmp.qapdWcpNzq (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

56

Created /tmp/tmp.YdjrXNIMrR (size 1 KB) containing data sent by client
Created /tmp/tmp.qxdo9HfkQN (size 1 KB) containing data sent by server
Created /tmp/tmp.TNYKhMMqEk (size 1024 KB) containing data sent by client
Created /tmp/tmp.SIgQoLcQ21 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 400385
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.TNYKhMMqEk (size 128 KB) containing data sent by client
Created /tmp/tmp.SIgQoLcQ21 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

57

Created /tmp/tmp.l1PDP6uKXu (size 1 KB) containing data sent by client
Created /tmp/tmp.u9dWbLLduR (size 1 KB) containing data sent by server
Created /tmp/tmp.KdZpeKO9fk (size 1024 KB) containing data sent by client
Created /tmp/tmp.LrJ9hGkSCA (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.KdZpeKO9fk (size 128 KB) containing data sent by client
Created /tmp/tmp.LrJ9hGkSCA (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

58

Created /tmp/tmp.eo0WWwnSyM (size 1 KB) containing data sent by client
Created /tmp/tmp.GnDKgPR1qC (size 1 KB) containing data sent by server
Created /tmp/tmp.GjTt9WnEMq (size 1024 KB) containing data sent by client
Created /tmp/tmp.al5xcSB9AW (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.GjTt9WnEMq (size 128 KB) containing data sent by client
Created /tmp/tmp.al5xcSB9AW (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

59

Created /tmp/tmp.sP0QVwpIpo (size 1 KB) containing data sent by client
Created /tmp/tmp.ZtUSZ8DHJ8 (size 1 KB) containing data sent by server
Created /tmp/tmp.4K9L44oKBs (size 1024 KB) containing data sent by client
Created /tmp/tmp.utnnSS5sW1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.4K9L44oKBs (size 128 KB) containing data sent by client
Created /tmp/tmp.utnnSS5sW1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

60

Created /tmp/tmp.33XjZLtacF (size 1 KB) containing data sent by client
Created /tmp/tmp.95zGVQlBct (size 1 KB) containing data sent by server
Created /tmp/tmp.wcWszHbK6V (size 1024 KB) containing data sent by client
Created /tmp/tmp.i36SltwEmE (size 1024 KB) containing data sent by server
file received by server has inverted byte at 326657
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.wcWszHbK6V (size 128 KB) containing data sent by client
Created /tmp/tmp.i36SltwEmE (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

61

Created /tmp/tmp.7LhM38x79n (size 1 KB) containing data sent by client
Created /tmp/tmp.kG18qNllN8 (size 1 KB) containing data sent by server
Created /tmp/tmp.swtaRUcgWI (size 1024 KB) containing data sent by client
Created /tmp/tmp.keCfW36mR0 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.swtaRUcgWI (size 128 KB) containing data sent by client
Created /tmp/tmp.keCfW36mR0 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

62

Created /tmp/tmp.BvKMFlxGaG (size 1 KB) containing data sent by client
Created /tmp/tmp.qVQtw5On2q (size 1 KB) containing data sent by server
Created /tmp/tmp.dmTg1gcH55 (size 1024 KB) containing data sent by client
Created /tmp/tmp.u1uNsxQ0Om (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.dmTg1gcH55 (size 128 KB) containing data sent by client
Created /tmp/tmp.u1uNsxQ0Om (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

63

Created /tmp/tmp.qylQCfU2AN (size 1 KB) containing data sent by client
Created /tmp/tmp.jst0XzPOAJ (size 1 KB) containing data sent by server
Created /tmp/tmp.MlyINQRVQJ (size 1024 KB) containing data sent by client
Created /tmp/tmp.AjpxKIM2gN (size 1024 KB) containing data sent by server
file received by server has inverted byte at 924673
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.MlyINQRVQJ (size 128 KB) containing data sent by client
Created /tmp/tmp.AjpxKIM2gN (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

64

Created /tmp/tmp.tz2mFtb68b (size 1 KB) containing data sent by client
Created /tmp/tmp.Lc2PyPLpqe (size 1 KB) containing data sent by server
Created /tmp/tmp.xEzFbBNiZH (size 1024 KB) containing data sent by client
Created /tmp/tmp.jZRI47HAia (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.xEzFbBNiZH (size 128 KB) containing data sent by client
Created /tmp/tmp.jZRI47HAia (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

65

Created /tmp/tmp.dnyqbuJzA1 (size 1 KB) containing data sent by client
Created /tmp/tmp.zFZkYpXa0Y (size 1 KB) containing data sent by server
Created /tmp/tmp.seqKJ5smEE (size 1024 KB) containing data sent by client
Created /tmp/tmp.8tuwYjdXag (size 1024 KB) containing data sent by server
file received by server has inverted byte at 465921
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.seqKJ5smEE (size 128 KB) containing data sent by client
Created /tmp/tmp.8tuwYjdXag (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

66

Created /tmp/tmp.Gx2YpY6Qrj (size 1 KB) containing data sent by client
Created /tmp/tmp.7h9nKJ21eJ (size 1 KB) containing data sent by server
Created /tmp/tmp.ws6TXZ7kdU (size 1024 KB) containing data sent by client
Created /tmp/tmp.i1ETJTmDFs (size 1024 KB) containing data sent by server
file received by server has inverted byte at 592740
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ws6TXZ7kdU (size 128 KB) containing data sent by client
Created /tmp/tmp.i1ETJTmDFs (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

67

Created /tmp/tmp.CfzdwOPSc3 (size 1 KB) containing data sent by client
Created /tmp/tmp.eK0912GaBO (size 1 KB) containing data sent by server
Created /tmp/tmp.eEw51dqaOG (size 1024 KB) containing data sent by client
Created /tmp/tmp.fXOzWjo9BG (size 1024 KB) containing data sent by server
file received by server has inverted byte at 728065
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.eEw51dqaOG (size 128 KB) containing data sent by client
Created /tmp/tmp.fXOzWjo9BG (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 1 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

68

Created /tmp/tmp.sfF94CGRMM (size 1 KB) containing data sent by client
Created /tmp/tmp.XCyFv64uPz (size 1 KB) containing data sent by server
Created /tmp/tmp.ENDrCNCiZQ (size 1024 KB) containing data sent by client
Created /tmp/tmp.nsDKO4sOTI (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[fail] got 2 data checksum error[s] expected 1
 - csum  [ ok ]
Server ns stats
TcpPassiveOpens                 3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       312                0.0
TcpOutSegs                      919                0.0
TcpOutRsts                      3                  0.0
TcpExtTW                        1                  0.0
TcpExtTCPPureAcks               146                0.0
TcpExtTCPRcvCoalesce            7                  0.0
TcpExtTCPFromZeroWindowAdv      1                  0.0
TcpExtTCPToZeroWindowAdv        1                  0.0
TcpExtTCPWantZeroWindowAdv      38                 0.0
TcpExtTCPOrigDataSent           787                0.0
TcpExtTCPDelivered              787                0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             2                  0.0
MPTcpExtMPJoinAckRx             2                  0.0
MPTcpExtDataCsumErr             2                  0.0
MPTcpExtOFOQueueTail            20                 0.0
MPTcpExtOFOQueue                29                 0.0
MPTcpExtOFOMerge                18                 0.0
MPTcpExtDuplicateData           6                  0.0
MPTcpExtMPFailTx                2                  0.0
MPTcpExtMPRstTx                 2                  0.0
MPTcpExtRcvPruned               8                  0.0
Client ns stats
TcpActiveOpens                  3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       322                0.0
TcpOutSegs                      1033               0.0
TcpExtDelayedACKs               1                  0.0
TcpExtTCPPureAcks               125                0.0
TcpExtTCPBacklogCoalesce        1                  0.0
TcpExtTCPOrigDataSent           883                0.0
TcpExtTCPHystartTrainDetect     1                  0.0
TcpExtTCPHystartTrainCwnd       38                 0.0
TcpExtTCPDelivered              870                0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPTCPRetrans            1                  0.0
MPTcpExtMPJoinSynAckRx          2                  0.0
MPTcpExtMPFailRx                2                  0.0
MPTcpExtMPRstRx                 2                  0.0
                                         ftx[fail] got 2 MP_FAIL[s] TX expected 1
 - failrx[fail] got 2 MP_FAIL[s] RX expected 1
Server ns stats
TcpPassiveOpens                 3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       312                0.0
TcpOutSegs                      919                0.0
TcpOutRsts                      3                  0.0
TcpExtTW                        1                  0.0
TcpExtTCPPureAcks               146                0.0
TcpExtTCPRcvCoalesce            7                  0.0
TcpExtTCPFromZeroWindowAdv      1                  0.0
TcpExtTCPToZeroWindowAdv        1                  0.0
TcpExtTCPWantZeroWindowAdv      38                 0.0
TcpExtTCPOrigDataSent           787                0.0
TcpExtTCPDelivered              787                0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             2                  0.0
MPTcpExtMPJoinAckRx             2                  0.0
MPTcpExtDataCsumErr             2                  0.0
MPTcpExtOFOQueueTail            20                 0.0
MPTcpExtOFOQueue                29                 0.0
MPTcpExtOFOMerge                18                 0.0
MPTcpExtDuplicateData           6                  0.0
MPTcpExtMPFailTx                2                  0.0
MPTcpExtMPRstTx                 2                  0.0
MPTcpExtRcvPruned               8                  0.0
Client ns stats
TcpActiveOpens                  3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       322                0.0
TcpOutSegs                      1033               0.0
TcpExtDelayedACKs               1                  0.0
TcpExtTCPPureAcks               125                0.0
TcpExtTCPBacklogCoalesce        1                  0.0
TcpExtTCPOrigDataSent           883                0.0
TcpExtTCPHystartTrainDetect     1                  0.0
TcpExtTCPHystartTrainCwnd       38                 0.0
TcpExtTCPDelivered              870                0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPTCPRetrans            1                  0.0
MPTcpExtMPJoinSynAckRx          2                  0.0
MPTcpExtMPFailRx                2                  0.0
MPTcpExtMPRstRx                 2                  0.0
                                         rtx[fail] got 2 MP_RST[s] TX expected 1
 - rstrx [fail] got 2 MP_RST[s] RX expected 1
Server ns stats
TcpPassiveOpens                 3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       312                0.0
TcpOutSegs                      919                0.0
TcpOutRsts                      3                  0.0
TcpExtTW                        1                  0.0
TcpExtTCPPureAcks               146                0.0
TcpExtTCPRcvCoalesce            7                  0.0
TcpExtTCPFromZeroWindowAdv      1                  0.0
TcpExtTCPToZeroWindowAdv        1                  0.0
TcpExtTCPWantZeroWindowAdv      38                 0.0
TcpExtTCPOrigDataSent           787                0.0
TcpExtTCPDelivered              787                0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             2                  0.0
MPTcpExtMPJoinAckRx             2                  0.0
MPTcpExtDataCsumErr             2                  0.0
MPTcpExtOFOQueueTail            20                 0.0
MPTcpExtOFOQueue                29                 0.0
MPTcpExtOFOMerge                18                 0.0
MPTcpExtDuplicateData           6                  0.0
MPTcpExtMPFailTx                2                  0.0
MPTcpExtMPRstTx                 2                  0.0
MPTcpExtRcvPruned               8                  0.0
Client ns stats
TcpActiveOpens                  3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       322                0.0
TcpOutSegs                      1033               0.0
TcpExtDelayedACKs               1                  0.0
TcpExtTCPPureAcks               125                0.0
TcpExtTCPBacklogCoalesce        1                  0.0
TcpExtTCPOrigDataSent           883                0.0
TcpExtTCPHystartTrainDetect     1                  0.0
TcpExtTCPHystartTrainCwnd       38                 0.0
TcpExtTCPDelivered              870                0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPTCPRetrans            1                  0.0
MPTcpExtMPJoinSynAckRx          2                  0.0
MPTcpExtMPFailRx                2                  0.0
MPTcpExtMPRstRx                 2                  0.0
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ENDrCNCiZQ (size 128 KB) containing data sent by client
Created /tmp/tmp.nsDKO4sOTI (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

69

Created /tmp/tmp.G2RVAL8sqc (size 1 KB) containing data sent by client
Created /tmp/tmp.7jhu4e0GbV (size 1 KB) containing data sent by server
Created /tmp/tmp.wluxE3ARlo (size 1024 KB) containing data sent by client
Created /tmp/tmp.rdgdhfjjei (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.wluxE3ARlo (size 128 KB) containing data sent by client
Created /tmp/tmp.rdgdhfjjei (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

70

Created /tmp/tmp.xuQhh52F5V (size 1 KB) containing data sent by client
Created /tmp/tmp.JQmlXa5Dgv (size 1 KB) containing data sent by server
Created /tmp/tmp.pTfrPWY19b (size 1024 KB) containing data sent by client
Created /tmp/tmp.Kc7MAyTupP (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.pTfrPWY19b (size 128 KB) containing data sent by client
Created /tmp/tmp.Kc7MAyTupP (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

71

Created /tmp/tmp.ANayTXabfS (size 1 KB) containing data sent by client
Created /tmp/tmp.HUm0cm99BE (size 1 KB) containing data sent by server
Created /tmp/tmp.sFOLP2P6Lv (size 1024 KB) containing data sent by client
Created /tmp/tmp.UKrYdRLipW (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.sFOLP2P6Lv (size 128 KB) containing data sent by client
Created /tmp/tmp.UKrYdRLipW (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

72

Created /tmp/tmp.eZTco3H68b (size 1 KB) containing data sent by client
Created /tmp/tmp.C1bhTWj8Ab (size 1 KB) containing data sent by server
Created /tmp/tmp.mgPyqvqsms (size 1024 KB) containing data sent by client
Created /tmp/tmp.i4ULvIiT93 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.mgPyqvqsms (size 128 KB) containing data sent by client
Created /tmp/tmp.i4ULvIiT93 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

73

Created /tmp/tmp.Ro1lxYGPtX (size 1 KB) containing data sent by client
Created /tmp/tmp.s5RZmhrcg8 (size 1 KB) containing data sent by server
Created /tmp/tmp.Wv95sTlFzX (size 1024 KB) containing data sent by client
Created /tmp/tmp.GU4fu8xRUx (size 1024 KB) containing data sent by server
file received by server has inverted byte at 187393
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Wv95sTlFzX (size 128 KB) containing data sent by client
Created /tmp/tmp.GU4fu8xRUx (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

74

Created /tmp/tmp.LauSZ7Qb7B (size 1 KB) containing data sent by client
Created /tmp/tmp.1VmHPXHyys (size 1 KB) containing data sent by server
Created /tmp/tmp.m52Qlnj1fq (size 1024 KB) containing data sent by client
Created /tmp/tmp.na6NZshC6X (size 1024 KB) containing data sent by server
file received by server has inverted byte at 465921
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.m52Qlnj1fq (size 128 KB) containing data sent by client
Created /tmp/tmp.na6NZshC6X (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

75

Created /tmp/tmp.jZb159QaBo (size 1 KB) containing data sent by client
Created /tmp/tmp.SiHceCmO38 (size 1 KB) containing data sent by server
Created /tmp/tmp.bWECUlKUoQ (size 1024 KB) containing data sent by client
Created /tmp/tmp.h8MyoRTcQZ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.bWECUlKUoQ (size 128 KB) containing data sent by client
Created /tmp/tmp.h8MyoRTcQZ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

76

Created /tmp/tmp.le4sQkmYl2 (size 1 KB) containing data sent by client
Created /tmp/tmp.bFVfEz6f9H (size 1 KB) containing data sent by server
Created /tmp/tmp.7qFySIQBBj (size 1024 KB) containing data sent by client
Created /tmp/tmp.geqZt7GZEV (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.7qFySIQBBj (size 128 KB) containing data sent by client
Created /tmp/tmp.geqZt7GZEV (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

77

Created /tmp/tmp.yxmlxZKkpG (size 1 KB) containing data sent by client
Created /tmp/tmp.94JS2DcTFW (size 1 KB) containing data sent by server
Created /tmp/tmp.2sFU9nJEiF (size 1024 KB) containing data sent by client
Created /tmp/tmp.hQUzEXP7vG (size 1024 KB) containing data sent by server
file received by server has inverted byte at 263916
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [fail] got 1 data checksum error[s] expected 0
Server ns stats
TcpPassiveOpens                 3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       265                0.0
TcpOutSegs                      989                0.0
TcpRetransSegs                  1                  0.0
TcpOutRsts                      1                  0.0
TcpExtTW                        1                  0.0
TcpExtTCPPureAcks               109                0.0
TcpExtTCPLossProbes             1                  0.0
TcpExtTCPBacklogCoalesce        3                  0.0
TcpExtTCPDSACKRecv              1                  0.0
TcpExtTCPDSACKIgnoredNoUndo     1                  0.0
TcpExtTCPOrigDataSent           841                0.0
TcpExtTCPDelivered              839                0.0
TcpExtTCPDSACKRecvSegs          1                  0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPTCPRetrans            5                  0.0
MPTcpExtMPJoinSynRx             2                  0.0
MPTcpExtMPJoinAckRx             2                  0.0
MPTcpExtDataCsumErr             1                  0.0
MPTcpExtMPFailTx                1                  0.0
MPTcpExtMPFailRx                1                  0.0
MPTcpExtMPRstTx                 1                  0.0
MPTcpExtMPRstRx                 1                  0.0
Client ns stats
TcpActiveOpens                  3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       282                0.0
TcpOutSegs                      902                0.0
TcpOutRsts                      1                  0.0
TcpExtDelayedACKLost            1                  0.0
TcpExtTCPPureAcks               144                0.0
TcpExtTCPDSACKOldSent           1                  0.0
TcpExtTCPRcvCoalesce            9                  0.0
TcpExtTCPFromZeroWindowAdv      2                  0.0
TcpExtTCPToZeroWindowAdv        3                  0.0
TcpExtTCPWantZeroWindowAdv      32                 0.0
TcpExtTCPOrigDataSent           786                0.0
TcpExtTCPDelivered              784                0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPJoinSynAckRx          2                  0.0
MPTcpExtDataCsumErr             1                  0.0
MPTcpExtOFOQueueTail            19                 0.0
MPTcpExtOFOQueue                25                 0.0
MPTcpExtOFOMerge                18                 0.0
MPTcpExtDuplicateData           6                  0.0
MPTcpExtMPFailTx                1                  0.0
MPTcpExtMPFailRx                1                  0.0
MPTcpExtMPRstTx                 1                  0.0
MPTcpExtMPRstRx                 1                  0.0
MPTcpExtRcvPruned               11                 0.0
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.2sFU9nJEiF (size 128 KB) containing data sent by client
Created /tmp/tmp.hQUzEXP7vG (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

78

Created /tmp/tmp.xgumlwE4tC (size 1 KB) containing data sent by client
Created /tmp/tmp.pUfkCc0z6o (size 1 KB) containing data sent by server
Created /tmp/tmp.9dtg0QtYV6 (size 1024 KB) containing data sent by client
Created /tmp/tmp.lcm1ckKDbR (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.9dtg0QtYV6 (size 128 KB) containing data sent by client
Created /tmp/tmp.lcm1ckKDbR (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

79

Created /tmp/tmp.daKEO4SfPn (size 1 KB) containing data sent by client
Created /tmp/tmp.7nn1RuxsA8 (size 1 KB) containing data sent by server
Created /tmp/tmp.qIaSJYdmGz (size 1024 KB) containing data sent by client
Created /tmp/tmp.QEvDe1cqAu (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qIaSJYdmGz (size 128 KB) containing data sent by client
Created /tmp/tmp.QEvDe1cqAu (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

80

Created /tmp/tmp.i4nH5W2XH1 (size 1 KB) containing data sent by client
Created /tmp/tmp.yi3In46tFn (size 1 KB) containing data sent by server
Created /tmp/tmp.8vbm7BslgL (size 1024 KB) containing data sent by client
Created /tmp/tmp.gMU9u2lczC (size 1024 KB) containing data sent by server
file received by server has inverted byte at 266539
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.8vbm7BslgL (size 128 KB) containing data sent by client
Created /tmp/tmp.gMU9u2lczC (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

81

Created /tmp/tmp.wFsR7Lb34B (size 1 KB) containing data sent by client
Created /tmp/tmp.xZg7pHAAbN (size 1 KB) containing data sent by server
Created /tmp/tmp.TS032yStwM (size 1024 KB) containing data sent by client
Created /tmp/tmp.Qh6D6P349n (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.TS032yStwM (size 128 KB) containing data sent by client
Created /tmp/tmp.Qh6D6P349n (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

82

Created /tmp/tmp.MZ45fTrkjz (size 1 KB) containing data sent by client
Created /tmp/tmp.DOy1akCYnO (size 1 KB) containing data sent by server
Created /tmp/tmp.CMgjB7APNY (size 1024 KB) containing data sent by client
Created /tmp/tmp.20siDRFeyp (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.CMgjB7APNY (size 128 KB) containing data sent by client
Created /tmp/tmp.20siDRFeyp (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

83

Created /tmp/tmp.gdtJk0DTSH (size 1 KB) containing data sent by client
Created /tmp/tmp.ClV8LLWuAg (size 1 KB) containing data sent by server
Created /tmp/tmp.Iy14rFbeMV (size 1024 KB) containing data sent by client
Created /tmp/tmp.StIcUfz3wT (size 1024 KB) containing data sent by server
file received by server has inverted byte at 121857
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Iy14rFbeMV (size 128 KB) containing data sent by client
Created /tmp/tmp.StIcUfz3wT (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

84

Created /tmp/tmp.jZrBU6Ac6m (size 1 KB) containing data sent by client
Created /tmp/tmp.fTLwSt9eVo (size 1 KB) containing data sent by server
Created /tmp/tmp.gg6aVOJtfe (size 1024 KB) containing data sent by client
Created /tmp/tmp.vjZOwwWT1k (size 1024 KB) containing data sent by server
file received by server has inverted byte at 792474
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.gg6aVOJtfe (size 128 KB) containing data sent by client
Created /tmp/tmp.vjZOwwWT1k (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

85

Created /tmp/tmp.K0J8LCJ1ug (size 1 KB) containing data sent by client
Created /tmp/tmp.9WYp2zaOLJ (size 1 KB) containing data sent by server
Created /tmp/tmp.Bdix3h4o9b (size 1024 KB) containing data sent by client
Created /tmp/tmp.2y61l1xot3 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 596993
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Bdix3h4o9b (size 128 KB) containing data sent by client
Created /tmp/tmp.2y61l1xot3 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 1 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

86

Created /tmp/tmp.5ZpcaOsshD (size 1 KB) containing data sent by client
Created /tmp/tmp.Q8E1SnXN3Y (size 1 KB) containing data sent by server
Created /tmp/tmp.cpulH3ZPNq (size 1024 KB) containing data sent by client
Created /tmp/tmp.4LlcZnDokH (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.cpulH3ZPNq (size 128 KB) containing data sent by client
Created /tmp/tmp.4LlcZnDokH (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

87

Created /tmp/tmp.wHgnX2pOtU (size 1 KB) containing data sent by client
Created /tmp/tmp.2Uq0GEU9hL (size 1 KB) containing data sent by server
Created /tmp/tmp.ffNwi3NFgJ (size 1024 KB) containing data sent by client
Created /tmp/tmp.Sgps27hjwL (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ffNwi3NFgJ (size 128 KB) containing data sent by client
Created /tmp/tmp.Sgps27hjwL (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

88

Created /tmp/tmp.NOdzf9P5DF (size 1 KB) containing data sent by client
Created /tmp/tmp.U4JjKFCkEA (size 1 KB) containing data sent by server
Created /tmp/tmp.Gb39aXfpeI (size 1024 KB) containing data sent by client
Created /tmp/tmp.a0Sz3VMp4q (size 1024 KB) containing data sent by server
file received by server has inverted byte at 188654
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Gb39aXfpeI (size 128 KB) containing data sent by client
Created /tmp/tmp.a0Sz3VMp4q (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

89

Created /tmp/tmp.YXa2T2GAH1 (size 1 KB) containing data sent by client
Created /tmp/tmp.wS2KLG8kLa (size 1 KB) containing data sent by server
Created /tmp/tmp.Ct9fa8re1M (size 1024 KB) containing data sent by client
Created /tmp/tmp.0o7wN3Ve62 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Ct9fa8re1M (size 128 KB) containing data sent by client
Created /tmp/tmp.0o7wN3Ve62 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

90

Created /tmp/tmp.8MGPrNTMV0 (size 1 KB) containing data sent by client
Created /tmp/tmp.8AoBlINiQz (size 1 KB) containing data sent by server
Created /tmp/tmp.6qdAH6nG1C (size 1024 KB) containing data sent by client
Created /tmp/tmp.4To3MtfTnb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.6qdAH6nG1C (size 128 KB) containing data sent by client
Created /tmp/tmp.4To3MtfTnb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

91

Created /tmp/tmp.XDKm6AQg51 (size 1 KB) containing data sent by client
Created /tmp/tmp.frfvsBJRQz (size 1 KB) containing data sent by server
Created /tmp/tmp.ZmHjuan88M (size 1024 KB) containing data sent by client
Created /tmp/tmp.GVwU0505kO (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ZmHjuan88M (size 128 KB) containing data sent by client
Created /tmp/tmp.GVwU0505kO (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

92

Created /tmp/tmp.1x59raKrke (size 1 KB) containing data sent by client
Created /tmp/tmp.Qo4JWJ8vRe (size 1 KB) containing data sent by server
Created /tmp/tmp.73vw3j06U2 (size 1024 KB) containing data sent by client
Created /tmp/tmp.z0HoQ1Zi6p (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.73vw3j06U2 (size 128 KB) containing data sent by client
Created /tmp/tmp.z0HoQ1Zi6p (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

93

Created /tmp/tmp.Dx1eNlyhLR (size 1 KB) containing data sent by client
Created /tmp/tmp.0rQqJccQsh (size 1 KB) containing data sent by server
Created /tmp/tmp.hszB2VLEaH (size 1024 KB) containing data sent by client
Created /tmp/tmp.34r6Dy9Ihi (size 1024 KB) containing data sent by server
file received by server has inverted byte at 195585
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.hszB2VLEaH (size 128 KB) containing data sent by client
Created /tmp/tmp.34r6Dy9Ihi (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

94

Created /tmp/tmp.AZxuzCHT40 (size 1 KB) containing data sent by client
Created /tmp/tmp.fKDEklHr4n (size 1 KB) containing data sent by server
Created /tmp/tmp.KUitzfUGGI (size 1024 KB) containing data sent by client
Created /tmp/tmp.fVMxXFFsId (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.KUitzfUGGI (size 128 KB) containing data sent by client
Created /tmp/tmp.fVMxXFFsId (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

95

Created /tmp/tmp.A7BrGV4z6E (size 1 KB) containing data sent by client
Created /tmp/tmp.6nArRRsCoa (size 1 KB) containing data sent by server
Created /tmp/tmp.1f1nQLdjhM (size 1024 KB) containing data sent by client
Created /tmp/tmp.fDfL3x8SqM (size 1024 KB) containing data sent by server
file received by server has inverted byte at 596993
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.1f1nQLdjhM (size 128 KB) containing data sent by client
Created /tmp/tmp.fDfL3x8SqM (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

96

Created /tmp/tmp.7jOsm07Bfi (size 1 KB) containing data sent by client
Created /tmp/tmp.N1sf0zHedQ (size 1 KB) containing data sent by server
Created /tmp/tmp.Pf0Ny5zxqN (size 1024 KB) containing data sent by client
Created /tmp/tmp.wOdzZ8jHu7 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Pf0Ny5zxqN (size 128 KB) containing data sent by client
Created /tmp/tmp.wOdzZ8jHu7 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

97

Created /tmp/tmp.TMnvVKatDj (size 1 KB) containing data sent by client
Created /tmp/tmp.PowoWiBJAC (size 1 KB) containing data sent by server
Created /tmp/tmp.uNFOBzrURk (size 1024 KB) containing data sent by client
Created /tmp/tmp.DHDl4C18Zb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[fail] got 2 data checksum error[s] expected 1
 - csum  [ ok ]
Server ns stats
TcpPassiveOpens                 3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       371                0.0
TcpOutSegs                      943                0.0
TcpOutRsts                      4                  0.0
TcpExtDelayedACKs               1                  0.0
TcpExtTCPPureAcks               156                0.0
TcpExtTCPRcvCoalesce            3                  0.0
TcpExtTCPFromZeroWindowAdv      2                  0.0
TcpExtTCPToZeroWindowAdv        2                  0.0
TcpExtTCPWantZeroWindowAdv      20                 0.0
TcpExtTCPOrigDataSent           787                0.0
TcpExtTCPHystartTrainDetect     1                  0.0
TcpExtTCPHystartTrainCwnd       26                 0.0
TcpExtTCPDelivered              787                0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             2                  0.0
MPTcpExtMPJoinAckRx             2                  0.0
MPTcpExtDataCsumErr             2                  0.0
MPTcpExtOFOQueueTail            8                  0.0
MPTcpExtOFOQueue                14                 0.0
MPTcpExtOFOMerge                5                  0.0
MPTcpExtDuplicateData           6                  0.0
MPTcpExtMPFailTx                2                  0.0
MPTcpExtMPRstTx                 2                  0.0
MPTcpExtRcvPruned               3                  0.0
Client ns stats
TcpActiveOpens                  3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       383                0.0
TcpOutSegs                      1031               0.0
TcpExtTW                        1                  0.0
TcpExtDelayedACKs               2                  0.0
TcpExtTCPPureAcks               143                0.0
TcpExtTCPBacklogCoalesce        6                  0.0
TcpExtTCPOrigDataSent           872                0.0
TcpExtTCPHystartTrainDetect     1                  0.0
TcpExtTCPHystartTrainCwnd       27                 0.0
TcpExtTCPDelivered              861                0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPTCPRetrans            1                  0.0
MPTcpExtMPJoinSynAckRx          2                  0.0
MPTcpExtMPFailRx                2                  0.0
MPTcpExtMPRstRx                 2                  0.0
                                         ftx[fail] got 2 MP_FAIL[s] TX expected 1
 - failrx[fail] got 2 MP_FAIL[s] RX expected 1
Server ns stats
TcpPassiveOpens                 3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       371                0.0
TcpOutSegs                      943                0.0
TcpOutRsts                      4                  0.0
TcpExtDelayedACKs               1                  0.0
TcpExtTCPPureAcks               156                0.0
TcpExtTCPRcvCoalesce            3                  0.0
TcpExtTCPFromZeroWindowAdv      2                  0.0
TcpExtTCPToZeroWindowAdv        2                  0.0
TcpExtTCPWantZeroWindowAdv      20                 0.0
TcpExtTCPOrigDataSent           787                0.0
TcpExtTCPHystartTrainDetect     1                  0.0
TcpExtTCPHystartTrainCwnd       26                 0.0
TcpExtTCPDelivered              787                0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             2                  0.0
MPTcpExtMPJoinAckRx             2                  0.0
MPTcpExtDataCsumErr             2                  0.0
MPTcpExtOFOQueueTail            8                  0.0
MPTcpExtOFOQueue                14                 0.0
MPTcpExtOFOMerge                5                  0.0
MPTcpExtDuplicateData           6                  0.0
MPTcpExtMPFailTx                2                  0.0
MPTcpExtMPRstTx                 2                  0.0
MPTcpExtRcvPruned               3                  0.0
Client ns stats
TcpActiveOpens                  3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       383                0.0
TcpOutSegs                      1031               0.0
TcpExtTW                        1                  0.0
TcpExtDelayedACKs               2                  0.0
TcpExtTCPPureAcks               143                0.0
TcpExtTCPBacklogCoalesce        6                  0.0
TcpExtTCPOrigDataSent           872                0.0
TcpExtTCPHystartTrainDetect     1                  0.0
TcpExtTCPHystartTrainCwnd       27                 0.0
TcpExtTCPDelivered              861                0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPTCPRetrans            1                  0.0
MPTcpExtMPJoinSynAckRx          2                  0.0
MPTcpExtMPFailRx                2                  0.0
MPTcpExtMPRstRx                 2                  0.0
                                         rtx[fail] got 2 MP_RST[s] TX expected 1
 - rstrx [fail] got 2 MP_RST[s] RX expected 1
Server ns stats
TcpPassiveOpens                 3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       371                0.0
TcpOutSegs                      943                0.0
TcpOutRsts                      4                  0.0
TcpExtDelayedACKs               1                  0.0
TcpExtTCPPureAcks               156                0.0
TcpExtTCPRcvCoalesce            3                  0.0
TcpExtTCPFromZeroWindowAdv      2                  0.0
TcpExtTCPToZeroWindowAdv        2                  0.0
TcpExtTCPWantZeroWindowAdv      20                 0.0
TcpExtTCPOrigDataSent           787                0.0
TcpExtTCPHystartTrainDetect     1                  0.0
TcpExtTCPHystartTrainCwnd       26                 0.0
TcpExtTCPDelivered              787                0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             2                  0.0
MPTcpExtMPJoinAckRx             2                  0.0
MPTcpExtDataCsumErr             2                  0.0
MPTcpExtOFOQueueTail            8                  0.0
MPTcpExtOFOQueue                14                 0.0
MPTcpExtOFOMerge                5                  0.0
MPTcpExtDuplicateData           6                  0.0
MPTcpExtMPFailTx                2                  0.0
MPTcpExtMPRstTx                 2                  0.0
MPTcpExtRcvPruned               3                  0.0
Client ns stats
TcpActiveOpens                  3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       383                0.0
TcpOutSegs                      1031               0.0
TcpExtTW                        1                  0.0
TcpExtDelayedACKs               2                  0.0
TcpExtTCPPureAcks               143                0.0
TcpExtTCPBacklogCoalesce        6                  0.0
TcpExtTCPOrigDataSent           872                0.0
TcpExtTCPHystartTrainDetect     1                  0.0
TcpExtTCPHystartTrainCwnd       27                 0.0
TcpExtTCPDelivered              861                0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPTCPRetrans            1                  0.0
MPTcpExtMPJoinSynAckRx          2                  0.0
MPTcpExtMPFailRx                2                  0.0
MPTcpExtMPRstRx                 2                  0.0
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.uNFOBzrURk (size 128 KB) containing data sent by client
Created /tmp/tmp.DHDl4C18Zb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

98

Created /tmp/tmp.C9UMAySptn (size 1 KB) containing data sent by client
Created /tmp/tmp.yHH7Tt3MFI (size 1 KB) containing data sent by server
Created /tmp/tmp.VWPaMIvbQJ (size 1024 KB) containing data sent by client
Created /tmp/tmp.sy1yvZnzGi (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.VWPaMIvbQJ (size 128 KB) containing data sent by client
Created /tmp/tmp.sy1yvZnzGi (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

99

Created /tmp/tmp.Kg8JnbillA (size 1 KB) containing data sent by client
Created /tmp/tmp.PpdyInN5mC (size 1 KB) containing data sent by server
Created /tmp/tmp.EeVg7KqyeO (size 1024 KB) containing data sent by client
Created /tmp/tmp.ucbFmzvz48 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 199035
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.EeVg7KqyeO (size 128 KB) containing data sent by client
Created /tmp/tmp.ucbFmzvz48 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 1 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

100

Created /tmp/tmp.ZVYhsMAxTP (size 1 KB) containing data sent by client
Created /tmp/tmp.3b6XVDdUOg (size 1 KB) containing data sent by server
Created /tmp/tmp.HlFQjsJT3X (size 1024 KB) containing data sent by client
Created /tmp/tmp.dGYiDH37tO (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.HlFQjsJT3X (size 128 KB) containing data sent by client
Created /tmp/tmp.dGYiDH37tO (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

101

Created /tmp/tmp.d4qppNMWZ2 (size 1 KB) containing data sent by client
Created /tmp/tmp.31boBO8HXl (size 1 KB) containing data sent by server
Created /tmp/tmp.9W0Z0CpjeJ (size 1024 KB) containing data sent by client
Created /tmp/tmp.fr9OJdSa4g (size 1024 KB) containing data sent by server
file received by server has inverted byte at 465921
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.9W0Z0CpjeJ (size 128 KB) containing data sent by client
Created /tmp/tmp.fr9OJdSa4g (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

102

Created /tmp/tmp.Slfb5jvYAU (size 1 KB) containing data sent by client
Created /tmp/tmp.DBY2L7ZZZm (size 1 KB) containing data sent by server
Created /tmp/tmp.UNIjIKzKr4 (size 1024 KB) containing data sent by client
Created /tmp/tmp.pKvvOvAltD (size 1024 KB) containing data sent by server
file received by server has inverted byte at 400385
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.UNIjIKzKr4 (size 128 KB) containing data sent by client
Created /tmp/tmp.pKvvOvAltD (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 4 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

103

Created /tmp/tmp.jmhXJ3Lh22 (size 1 KB) containing data sent by client
Created /tmp/tmp.2X7BnKmmta (size 1 KB) containing data sent by server
Created /tmp/tmp.gLDlnkQf4x (size 1024 KB) containing data sent by client
Created /tmp/tmp.isCa2A4bd1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 465921
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.gLDlnkQf4x (size 128 KB) containing data sent by client
Created /tmp/tmp.isCa2A4bd1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

104

Created /tmp/tmp.nLacldZtC0 (size 1 KB) containing data sent by client
Created /tmp/tmp.JpB1ANRcF1 (size 1 KB) containing data sent by server
Created /tmp/tmp.Ley9bawVmf (size 1024 KB) containing data sent by client
Created /tmp/tmp.8NlQZZAALX (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Ley9bawVmf (size 128 KB) containing data sent by client
Created /tmp/tmp.8NlQZZAALX (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

105

Created /tmp/tmp.QknretRjYT (size 1 KB) containing data sent by client
Created /tmp/tmp.HkcDmmadcE (size 1 KB) containing data sent by server
Created /tmp/tmp.vTvtdNIOY4 (size 1024 KB) containing data sent by client
Created /tmp/tmp.rTBtJ00CoR (size 1024 KB) containing data sent by server
file received by server has inverted byte at 400385
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.vTvtdNIOY4 (size 128 KB) containing data sent by client
Created /tmp/tmp.rTBtJ00CoR (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

106

Created /tmp/tmp.G8nuN9oCv9 (size 1 KB) containing data sent by client
Created /tmp/tmp.3bDKPL7jpo (size 1 KB) containing data sent by server
Created /tmp/tmp.fEpYv1NbTD (size 1024 KB) containing data sent by client
Created /tmp/tmp.30ZycKk63E (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.fEpYv1NbTD (size 128 KB) containing data sent by client
Created /tmp/tmp.30ZycKk63E (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

107

Created /tmp/tmp.8axrc1rze3 (size 1 KB) containing data sent by client
Created /tmp/tmp.NEPREoThHl (size 1 KB) containing data sent by server
Created /tmp/tmp.NaUxP3Mlm1 (size 1024 KB) containing data sent by client
Created /tmp/tmp.VZJ9ULTyZp (size 1024 KB) containing data sent by server
file received by server has inverted byte at 179201
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.NaUxP3Mlm1 (size 128 KB) containing data sent by client
Created /tmp/tmp.VZJ9ULTyZp (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

108

Created /tmp/tmp.pYValRDEos (size 1 KB) containing data sent by client
Created /tmp/tmp.fu8GQatCp0 (size 1 KB) containing data sent by server
Created /tmp/tmp.kLaatcmXbQ (size 1024 KB) containing data sent by client
Created /tmp/tmp.BTtBfFq2OP (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.kLaatcmXbQ (size 128 KB) containing data sent by client
Created /tmp/tmp.BTtBfFq2OP (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

109

Created /tmp/tmp.5kQfQOPFEo (size 1 KB) containing data sent by client
Created /tmp/tmp.jB3v7Iw7L8 (size 1 KB) containing data sent by server
Created /tmp/tmp.xwyRgSQPu5 (size 1024 KB) containing data sent by client
Created /tmp/tmp.z5k8vsyOrx (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.xwyRgSQPu5 (size 128 KB) containing data sent by client
Created /tmp/tmp.z5k8vsyOrx (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

110

Created /tmp/tmp.4K9D2cYp0w (size 1 KB) containing data sent by client
Created /tmp/tmp.mKQHLAyORs (size 1 KB) containing data sent by server
Created /tmp/tmp.fzNmqWEcQM (size 1024 KB) containing data sent by client
Created /tmp/tmp.flXuCb8466 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 924673
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.fzNmqWEcQM (size 128 KB) containing data sent by client
Created /tmp/tmp.flXuCb8466 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

111

Created /tmp/tmp.9FluAbu4Qm (size 1 KB) containing data sent by client
Created /tmp/tmp.F4FwBG9GSO (size 1 KB) containing data sent by server
Created /tmp/tmp.4dy0g6B0nF (size 1024 KB) containing data sent by client
Created /tmp/tmp.7BGRs0gMgQ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 326657
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.4dy0g6B0nF (size 128 KB) containing data sent by client
Created /tmp/tmp.7BGRs0gMgQ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

112

Created /tmp/tmp.OUg9icDT98 (size 1 KB) containing data sent by client
Created /tmp/tmp.nvkFnPoyfr (size 1 KB) containing data sent by server
Created /tmp/tmp.TVRaTbBf3N (size 1024 KB) containing data sent by client
Created /tmp/tmp.vjxOXgrCil (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [fail] got 1 data checksum error[s] expected 0
Server ns stats
TcpPassiveOpens                 3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       283                0.0
TcpOutSegs                      981                0.0
TcpOutRsts                      1                  0.0
TcpExtDelayedACKs               1                  0.0
TcpExtTCPPureAcks               110                0.0
TcpExtTCPBacklogCoalesce        4                  0.0
TcpExtTCPAutoCorking            6                  0.0
TcpExtTCPOrigDataSent           835                0.0
TcpExtTCPHystartTrainDetect     1                  0.0
TcpExtTCPHystartTrainCwnd       51                 0.0
TcpExtTCPDelivered              829                0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             2                  0.0
MPTcpExtMPJoinAckRx             2                  0.0
MPTcpExtDataCsumErr             1                  0.0
MPTcpExtDuplicateData           2                  0.0
MPTcpExtMPFailTx                1                  0.0
MPTcpExtMPFailRx                1                  0.0
MPTcpExtMPRstTx                 1                  0.0
MPTcpExtMPRstRx                 1                  0.0
Client ns stats
TcpActiveOpens                  3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       350                0.0
TcpOutSegs                      914                0.0
TcpOutRsts                      1                  0.0
TcpExtTW                        1                  0.0
TcpExtTCPPureAcks               142                0.0
TcpExtTCPRcvCoalesce            2                  0.0
TcpExtTCPFromZeroWindowAdv      9                  0.0
TcpExtTCPToZeroWindowAdv        9                  0.0
TcpExtTCPWantZeroWindowAdv      28                 0.0
TcpExtTCPOrigDataSent           796                0.0
TcpExtTCPDelivered              798                0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPJoinSynAckRx          2                  0.0
MPTcpExtDataCsumErr             1                  0.0
MPTcpExtOFOQueueTail            8                  0.0
MPTcpExtOFOQueue                10                 0.0
MPTcpExtOFOMerge                7                  0.0
MPTcpExtDuplicateData           39                 0.0
MPTcpExtMPFailTx                1                  0.0
MPTcpExtMPFailRx                1                  0.0
MPTcpExtMPRstTx                 1                  0.0
MPTcpExtMPRstRx                 1                  0.0
MPTcpExtRcvPruned               6                  0.0
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.TVRaTbBf3N (size 128 KB) containing data sent by client
Created /tmp/tmp.vjxOXgrCil (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

113

Created /tmp/tmp.h6YbwJw9Fi (size 1 KB) containing data sent by client
Created /tmp/tmp.DkwpnlywXC (size 1 KB) containing data sent by server
Created /tmp/tmp.haAowA66gV (size 1024 KB) containing data sent by client
Created /tmp/tmp.EC9DmnP9fl (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.haAowA66gV (size 128 KB) containing data sent by client
Created /tmp/tmp.EC9DmnP9fl (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

114

Created /tmp/tmp.Sf6Tg0XPnu (size 1 KB) containing data sent by client
Created /tmp/tmp.bx6xtw5ZQz (size 1 KB) containing data sent by server
Created /tmp/tmp.IANnvPNFiy (size 1024 KB) containing data sent by client
Created /tmp/tmp.EvbRw75fdI (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.IANnvPNFiy (size 128 KB) containing data sent by client
Created /tmp/tmp.EvbRw75fdI (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

115

Created /tmp/tmp.ZiX3FwKS3e (size 1 KB) containing data sent by client
Created /tmp/tmp.wtT4xQW7ay (size 1 KB) containing data sent by server
Created /tmp/tmp.5XYF4l6oQv (size 1024 KB) containing data sent by client
Created /tmp/tmp.0kCAgfxlza (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.5XYF4l6oQv (size 128 KB) containing data sent by client
Created /tmp/tmp.0kCAgfxlza (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

116

Created /tmp/tmp.Ia6poGaFhV (size 1 KB) containing data sent by client
Created /tmp/tmp.WDIwtdp3uP (size 1 KB) containing data sent by server
Created /tmp/tmp.VpZhGa44FP (size 1024 KB) containing data sent by client
Created /tmp/tmp.r6mgjmSbFm (size 1024 KB) containing data sent by server
001 MP_FAIL MP_RST: retry 1
Created /tmp/tmp.VpZhGa44FP (size 1024 KB) containing data sent by client
Created /tmp/tmp.r6mgjmSbFm (size 1024 KB) containing data sent by server
file received by server has inverted byte at 465921
002 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.VpZhGa44FP (size 128 KB) containing data sent by client
Created /tmp/tmp.r6mgjmSbFm (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
003 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

117

Created /tmp/tmp.vjXz6VVgMA (size 1 KB) containing data sent by client
Created /tmp/tmp.zjftz9Zl41 (size 1 KB) containing data sent by server
Created /tmp/tmp.YgyGC3p5cb (size 1024 KB) containing data sent by client
Created /tmp/tmp.FzEELHYFW0 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 662529
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.YgyGC3p5cb (size 128 KB) containing data sent by client
Created /tmp/tmp.FzEELHYFW0 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

118

Created /tmp/tmp.nrspASqhOe (size 1 KB) containing data sent by client
Created /tmp/tmp.YuyIHYeRWJ (size 1 KB) containing data sent by server
Created /tmp/tmp.DIxCDF49S5 (size 1024 KB) containing data sent by client
Created /tmp/tmp.QDjYzjIzIv (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.DIxCDF49S5 (size 128 KB) containing data sent by client
Created /tmp/tmp.QDjYzjIzIv (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

119

Created /tmp/tmp.gLEUP2PDE8 (size 1 KB) containing data sent by client
Created /tmp/tmp.pUFR1fvfCd (size 1 KB) containing data sent by server
Created /tmp/tmp.ga8FtMlMof (size 1024 KB) containing data sent by client
Created /tmp/tmp.JTphxdj2rh (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ga8FtMlMof (size 128 KB) containing data sent by client
Created /tmp/tmp.JTphxdj2rh (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

120

Created /tmp/tmp.fbCAVb8n7d (size 1 KB) containing data sent by client
Created /tmp/tmp.9DAm1H9Amq (size 1 KB) containing data sent by server
Created /tmp/tmp.EYIXbD3Yo0 (size 1024 KB) containing data sent by client
Created /tmp/tmp.bvQXDBQD42 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.EYIXbD3Yo0 (size 128 KB) containing data sent by client
Created /tmp/tmp.bvQXDBQD42 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

121

Created /tmp/tmp.oog1v8Frwb (size 1 KB) containing data sent by client
Created /tmp/tmp.CbCx6l4m8a (size 1 KB) containing data sent by server
Created /tmp/tmp.N5wAbZ6XiB (size 1024 KB) containing data sent by client
Created /tmp/tmp.gpmtHv5q6P (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.N5wAbZ6XiB (size 128 KB) containing data sent by client
Created /tmp/tmp.gpmtHv5q6P (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

122

Created /tmp/tmp.8bVZCNcviM (size 1 KB) containing data sent by client
Created /tmp/tmp.xst4HoivjL (size 1 KB) containing data sent by server
Created /tmp/tmp.d9XUoOKlBL (size 1024 KB) containing data sent by client
Created /tmp/tmp.nG4zstJtnu (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.d9XUoOKlBL (size 128 KB) containing data sent by client
Created /tmp/tmp.nG4zstJtnu (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

123

Created /tmp/tmp.6XiAkyEdD5 (size 1 KB) containing data sent by client
Created /tmp/tmp.6gyxTBXven (size 1 KB) containing data sent by server
Created /tmp/tmp.mCd5P1BQHI (size 1024 KB) containing data sent by client
Created /tmp/tmp.MU5k2y29BK (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.mCd5P1BQHI (size 128 KB) containing data sent by client
Created /tmp/tmp.MU5k2y29BK (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

124

Created /tmp/tmp.isFR5tGzD1 (size 1 KB) containing data sent by client
Created /tmp/tmp.qYMqbA38fn (size 1 KB) containing data sent by server
Created /tmp/tmp.I6pTD39Klc (size 1024 KB) containing data sent by client
Created /tmp/tmp.Ecc8JwNrPq (size 1024 KB) containing data sent by server
file received by server has inverted byte at 132563
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.I6pTD39Klc (size 128 KB) containing data sent by client
Created /tmp/tmp.Ecc8JwNrPq (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

125

Created /tmp/tmp.VtMoQ4XJ9l (size 1 KB) containing data sent by client
Created /tmp/tmp.oLp3kRL8rR (size 1 KB) containing data sent by server
Created /tmp/tmp.DzsB620t5k (size 1024 KB) containing data sent by client
Created /tmp/tmp.QbjsUr6dXE (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.DzsB620t5k (size 128 KB) containing data sent by client
Created /tmp/tmp.QbjsUr6dXE (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

126

Created /tmp/tmp.nTux5D1rkt (size 1 KB) containing data sent by client
Created /tmp/tmp.jkeeR5Jm22 (size 1 KB) containing data sent by server
Created /tmp/tmp.tB0uZDj59U (size 1024 KB) containing data sent by client
Created /tmp/tmp.2X4QSFQQFG (size 1024 KB) containing data sent by server
file received by server has inverted byte at 990209
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.tB0uZDj59U (size 128 KB) containing data sent by client
Created /tmp/tmp.2X4QSFQQFG (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

127

Created /tmp/tmp.7ecv6b3Pxq (size 1 KB) containing data sent by client
Created /tmp/tmp.LeL9gZECAq (size 1 KB) containing data sent by server
Created /tmp/tmp.scqDJ2XMP5 (size 1024 KB) containing data sent by client
Created /tmp/tmp.yN7tvT5ffq (size 1024 KB) containing data sent by server
file received by server has inverted byte at 596993
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.scqDJ2XMP5 (size 128 KB) containing data sent by client
Created /tmp/tmp.yN7tvT5ffq (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

128

Created /tmp/tmp.byfvxdMnQ0 (size 1 KB) containing data sent by client
Created /tmp/tmp.QYSy9b1OCG (size 1 KB) containing data sent by server
Created /tmp/tmp.r90ZwpyDil (size 1024 KB) containing data sent by client
Created /tmp/tmp.4qWPVUE9gK (size 1024 KB) containing data sent by server
file received by server has inverted byte at 465921
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.r90ZwpyDil (size 128 KB) containing data sent by client
Created /tmp/tmp.4qWPVUE9gK (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

129

Created /tmp/tmp.ZEpicP4AQz (size 1 KB) containing data sent by client
Created /tmp/tmp.1aJBZ53iDP (size 1 KB) containing data sent by server
Created /tmp/tmp.Lr6Vvp17VY (size 1024 KB) containing data sent by client
Created /tmp/tmp.wPEvnbUmV2 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Lr6Vvp17VY (size 128 KB) containing data sent by client
Created /tmp/tmp.wPEvnbUmV2 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

130

Created /tmp/tmp.Z05k61Zplq (size 1 KB) containing data sent by client
Created /tmp/tmp.8MlP0KdUpu (size 1 KB) containing data sent by server
Created /tmp/tmp.aquknGqhnn (size 1024 KB) containing data sent by client
Created /tmp/tmp.yH5jnmJn0K (size 1024 KB) containing data sent by server
file received by server has inverted byte at 400385
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.aquknGqhnn (size 128 KB) containing data sent by client
Created /tmp/tmp.yH5jnmJn0K (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

131

Created /tmp/tmp.n2PxcShIHp (size 1 KB) containing data sent by client
Created /tmp/tmp.4835Qlxw6e (size 1 KB) containing data sent by server
Created /tmp/tmp.tlbjuOZT3g (size 1024 KB) containing data sent by client
Created /tmp/tmp.ytK5f9ELM0 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71867
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.tlbjuOZT3g (size 128 KB) containing data sent by client
Created /tmp/tmp.ytK5f9ELM0 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

132

Created /tmp/tmp.MXvVCvzx3S (size 1 KB) containing data sent by client
Created /tmp/tmp.aHc3aQjIgw (size 1 KB) containing data sent by server
Created /tmp/tmp.gwH3mdbRSG (size 1024 KB) containing data sent by client
Created /tmp/tmp.FbOLOWskvN (size 1024 KB) containing data sent by server
file received by server has inverted byte at 596993
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.gwH3mdbRSG (size 128 KB) containing data sent by client
Created /tmp/tmp.FbOLOWskvN (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

133

Created /tmp/tmp.m6MPhqOoMB (size 1 KB) containing data sent by client
Created /tmp/tmp.XRhpnBIQxp (size 1 KB) containing data sent by server
Created /tmp/tmp.89chbwrVDU (size 1024 KB) containing data sent by client
Created /tmp/tmp.n1Vnl07nWM (size 1024 KB) containing data sent by server
file received by server has inverted byte at 137709
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.89chbwrVDU (size 128 KB) containing data sent by client
Created /tmp/tmp.n1Vnl07nWM (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

134

Created /tmp/tmp.hNsLQb5ouv (size 1 KB) containing data sent by client
Created /tmp/tmp.ugS4YywGlE (size 1 KB) containing data sent by server
Created /tmp/tmp.JAtPu5KY1J (size 1024 KB) containing data sent by client
Created /tmp/tmp.88ev01Qymu (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.JAtPu5KY1J (size 128 KB) containing data sent by client
Created /tmp/tmp.88ev01Qymu (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

135

Created /tmp/tmp.B2CIKAoNQX (size 1 KB) containing data sent by client
Created /tmp/tmp.cvS76MX2MX (size 1 KB) containing data sent by server
Created /tmp/tmp.7UPjar0Oek (size 1024 KB) containing data sent by client
Created /tmp/tmp.xZg1tssaq6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.7UPjar0Oek (size 128 KB) containing data sent by client
Created /tmp/tmp.xZg1tssaq6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

136

Created /tmp/tmp.bUaz6kPcvL (size 1 KB) containing data sent by client
Created /tmp/tmp.J35EhEqzRU (size 1 KB) containing data sent by server
Created /tmp/tmp.qN6dm4SAxP (size 1024 KB) containing data sent by client
Created /tmp/tmp.hIr2QD5x3W (size 1024 KB) containing data sent by server
001 MP_FAIL MP_RST: retry 1
Created /tmp/tmp.qN6dm4SAxP (size 1024 KB) containing data sent by client
Created /tmp/tmp.hIr2QD5x3W (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
002 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qN6dm4SAxP (size 128 KB) containing data sent by client
Created /tmp/tmp.hIr2QD5x3W (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
003 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

137

Created /tmp/tmp.wB9evexovw (size 1 KB) containing data sent by client
Created /tmp/tmp.JV3hUPfb3w (size 1 KB) containing data sent by server
Created /tmp/tmp.3IPRK1eidQ (size 1024 KB) containing data sent by client
Created /tmp/tmp.3QpOIesyjZ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 990209
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.3IPRK1eidQ (size 128 KB) containing data sent by client
Created /tmp/tmp.3QpOIesyjZ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

138

Created /tmp/tmp.jEJ1ZJIHaq (size 1 KB) containing data sent by client
Created /tmp/tmp.UqeaGQ7J3F (size 1 KB) containing data sent by server
Created /tmp/tmp.PcZJiJDu6v (size 1024 KB) containing data sent by client
Created /tmp/tmp.YS7oejt665 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 662529
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.PcZJiJDu6v (size 128 KB) containing data sent by client
Created /tmp/tmp.YS7oejt665 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

139

Created /tmp/tmp.In7mPbz4Yd (size 1 KB) containing data sent by client
Created /tmp/tmp.g2Y9gz5aSF (size 1 KB) containing data sent by server
Created /tmp/tmp.W2DY4Az7Jr (size 1024 KB) containing data sent by client
Created /tmp/tmp.hxciiq877d (size 1024 KB) containing data sent by server
file received by server has inverted byte at 465921
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.W2DY4Az7Jr (size 128 KB) containing data sent by client
Created /tmp/tmp.hxciiq877d (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

140

Created /tmp/tmp.wfqYR6JE2K (size 1 KB) containing data sent by client
Created /tmp/tmp.6iV2xxpKyQ (size 1 KB) containing data sent by server
Created /tmp/tmp.9JBpA9U6As (size 1024 KB) containing data sent by client
Created /tmp/tmp.dJlL5uIsZc (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.9JBpA9U6As (size 128 KB) containing data sent by client
Created /tmp/tmp.dJlL5uIsZc (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

141

Created /tmp/tmp.8Asq6Vn0De (size 1 KB) containing data sent by client
Created /tmp/tmp.x6loq4HFre (size 1 KB) containing data sent by server
Created /tmp/tmp.s7csiOsdCb (size 1024 KB) containing data sent by client
Created /tmp/tmp.MONWtCj4YQ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.s7csiOsdCb (size 128 KB) containing data sent by client
Created /tmp/tmp.MONWtCj4YQ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

142

Created /tmp/tmp.YLPxLvXWGy (size 1 KB) containing data sent by client
Created /tmp/tmp.Hd5lm6Fwcw (size 1 KB) containing data sent by server
Created /tmp/tmp.DJqK5rDqGM (size 1024 KB) containing data sent by client
Created /tmp/tmp.eiWUcswUur (size 1024 KB) containing data sent by server
file received by server has inverted byte at 588801
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.DJqK5rDqGM (size 128 KB) containing data sent by client
Created /tmp/tmp.eiWUcswUur (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

143

Created /tmp/tmp.vhGB4PeJ3H (size 1 KB) containing data sent by client
Created /tmp/tmp.kJzlfpIjdu (size 1 KB) containing data sent by server
Created /tmp/tmp.sY1xRg5G1R (size 1024 KB) containing data sent by client
Created /tmp/tmp.IBF3StwJr6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.sY1xRg5G1R (size 128 KB) containing data sent by client
Created /tmp/tmp.IBF3StwJr6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

144

Created /tmp/tmp.rSkAjVZmo8 (size 1 KB) containing data sent by client
Created /tmp/tmp.ZmXdMf6uG7 (size 1 KB) containing data sent by server
Created /tmp/tmp.PXGcGUIJps (size 1024 KB) containing data sent by client
Created /tmp/tmp.VtVYSBsDsO (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.PXGcGUIJps (size 128 KB) containing data sent by client
Created /tmp/tmp.VtVYSBsDsO (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

145

Created /tmp/tmp.FlV2yfLN9i (size 1 KB) containing data sent by client
Created /tmp/tmp.QYOLRpQj88 (size 1 KB) containing data sent by server
Created /tmp/tmp.zP6ZI8JyyG (size 1024 KB) containing data sent by client
Created /tmp/tmp.JytWG05qif (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.zP6ZI8JyyG (size 128 KB) containing data sent by client
Created /tmp/tmp.JytWG05qif (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

146

Created /tmp/tmp.P05na5CJqh (size 1 KB) containing data sent by client
Created /tmp/tmp.wYW2ros9Qk (size 1 KB) containing data sent by server
Created /tmp/tmp.sBupiWdUfV (size 1024 KB) containing data sent by client
Created /tmp/tmp.LFjl5vG1mB (size 1024 KB) containing data sent by server
file received by server has inverted byte at 728065
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.sBupiWdUfV (size 128 KB) containing data sent by client
Created /tmp/tmp.LFjl5vG1mB (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

147

Created /tmp/tmp.BN0Dr2iXNf (size 1 KB) containing data sent by client
Created /tmp/tmp.MmGXfuXdTT (size 1 KB) containing data sent by server
Created /tmp/tmp.wAN1i4cquL (size 1024 KB) containing data sent by client
Created /tmp/tmp.8athqmQ7FR (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.wAN1i4cquL (size 128 KB) containing data sent by client
Created /tmp/tmp.8athqmQ7FR (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

148

Created /tmp/tmp.vOIqwVV5Zf (size 1 KB) containing data sent by client
Created /tmp/tmp.Osx68Bp6ja (size 1 KB) containing data sent by server
Created /tmp/tmp.EbyKBEfhob (size 1024 KB) containing data sent by client
Created /tmp/tmp.a2DL8m6q2B (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.EbyKBEfhob (size 128 KB) containing data sent by client
Created /tmp/tmp.a2DL8m6q2B (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 4 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

149

Created /tmp/tmp.GtgUt4exHh (size 1 KB) containing data sent by client
Created /tmp/tmp.CXFcekrDqw (size 1 KB) containing data sent by server
Created /tmp/tmp.kJxhdq5SSI (size 1024 KB) containing data sent by client
Created /tmp/tmp.LuJ4SATb7D (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.kJxhdq5SSI (size 128 KB) containing data sent by client
Created /tmp/tmp.LuJ4SATb7D (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

150

Created /tmp/tmp.6m2nSyX1im (size 1 KB) containing data sent by client
Created /tmp/tmp.hf1QbT87Dy (size 1 KB) containing data sent by server
Created /tmp/tmp.t8j5ewxcem (size 1024 KB) containing data sent by client
Created /tmp/tmp.pAH9FiMc1v (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.t8j5ewxcem (size 128 KB) containing data sent by client
Created /tmp/tmp.pAH9FiMc1v (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

151

Created /tmp/tmp.DVJ84kNTQ4 (size 1 KB) containing data sent by client
Created /tmp/tmp.zCyD0DeGXt (size 1 KB) containing data sent by server
Created /tmp/tmp.wTkYpQSbwk (size 1024 KB) containing data sent by client
Created /tmp/tmp.CViRRLGspE (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.wTkYpQSbwk (size 128 KB) containing data sent by client
Created /tmp/tmp.CViRRLGspE (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

152

Created /tmp/tmp.jmsbc5ozjO (size 1 KB) containing data sent by client
Created /tmp/tmp.tw5e2GQnvL (size 1 KB) containing data sent by server
Created /tmp/tmp.7XdfW7ClNZ (size 1024 KB) containing data sent by client
Created /tmp/tmp.DahM2asxYy (size 1024 KB) containing data sent by server
file received by server has inverted byte at 654337
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.7XdfW7ClNZ (size 128 KB) containing data sent by client
Created /tmp/tmp.DahM2asxYy (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

153

Created /tmp/tmp.mhTTTZDyni (size 1 KB) containing data sent by client
Created /tmp/tmp.W2TX1nMzAy (size 1 KB) containing data sent by server
Created /tmp/tmp.hoMsrjAfBk (size 1024 KB) containing data sent by client
Created /tmp/tmp.1RCMNVBcot (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.hoMsrjAfBk (size 128 KB) containing data sent by client
Created /tmp/tmp.1RCMNVBcot (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 1 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

154

Created /tmp/tmp.0qfhrTJRBb (size 1 KB) containing data sent by client
Created /tmp/tmp.OnI4T3w2ga (size 1 KB) containing data sent by server
Created /tmp/tmp.tObcbsT8Kf (size 1024 KB) containing data sent by client
Created /tmp/tmp.YSuEcEuEyH (size 1024 KB) containing data sent by server
file received by server has inverted byte at 328954
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.tObcbsT8Kf (size 128 KB) containing data sent by client
Created /tmp/tmp.YSuEcEuEyH (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

155

Created /tmp/tmp.QGawmwKEpi (size 1 KB) containing data sent by client
Created /tmp/tmp.FwMSaAlbL7 (size 1 KB) containing data sent by server
Created /tmp/tmp.JVjs8ptLGp (size 1024 KB) containing data sent by client
Created /tmp/tmp.MoS5IvWe0M (size 1024 KB) containing data sent by server
file received by server has inverted byte at 531457
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.JVjs8ptLGp (size 128 KB) containing data sent by client
Created /tmp/tmp.MoS5IvWe0M (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

156

Created /tmp/tmp.JytNIOEjN3 (size 1 KB) containing data sent by client
Created /tmp/tmp.rmV81MZ1eR (size 1 KB) containing data sent by server
Created /tmp/tmp.ydlkmpfyo6 (size 1024 KB) containing data sent by client
Created /tmp/tmp.Okqk5ZOoDn (size 1024 KB) containing data sent by server
file received by server has inverted byte at 114757
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ydlkmpfyo6 (size 128 KB) containing data sent by client
Created /tmp/tmp.Okqk5ZOoDn (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

157

Created /tmp/tmp.rvUtXeaZCi (size 1 KB) containing data sent by client
Created /tmp/tmp.8iHWlsP7eD (size 1 KB) containing data sent by server
Created /tmp/tmp.sc4O3BpjjI (size 1024 KB) containing data sent by client
Created /tmp/tmp.GdF7k5G2Eu (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.sc4O3BpjjI (size 128 KB) containing data sent by client
Created /tmp/tmp.GdF7k5G2Eu (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

158

Created /tmp/tmp.KyrM2VcgNu (size 1 KB) containing data sent by client
Created /tmp/tmp.0Jw4AKAEJf (size 1 KB) containing data sent by server
Created /tmp/tmp.v7aRiQZPGK (size 1024 KB) containing data sent by client
Created /tmp/tmp.AyEtYgpmVM (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.v7aRiQZPGK (size 128 KB) containing data sent by client
Created /tmp/tmp.AyEtYgpmVM (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

159

Created /tmp/tmp.ceSgk83B62 (size 1 KB) containing data sent by client
Created /tmp/tmp.aYyZt6fc5b (size 1 KB) containing data sent by server
Created /tmp/tmp.GKZvOfhDsz (size 1024 KB) containing data sent by client
Created /tmp/tmp.BfVFoTnYkb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 924673
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.GKZvOfhDsz (size 128 KB) containing data sent by client
Created /tmp/tmp.BfVFoTnYkb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

160

Created /tmp/tmp.8WhON210ye (size 1 KB) containing data sent by client
Created /tmp/tmp.IUY0srQJg7 (size 1 KB) containing data sent by server
Created /tmp/tmp.BzQhDoHw9z (size 1024 KB) containing data sent by client
Created /tmp/tmp.iIbXiIfr0L (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.BzQhDoHw9z (size 128 KB) containing data sent by client
Created /tmp/tmp.iIbXiIfr0L (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

161

Created /tmp/tmp.uM39gvhKvG (size 1 KB) containing data sent by client
Created /tmp/tmp.JdxNiAigmn (size 1 KB) containing data sent by server
Created /tmp/tmp.7DquCQjpk0 (size 1024 KB) containing data sent by client
Created /tmp/tmp.XgiCG5VUcB (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[fail] got 2 MP_RST[s] TX expected 1
 - rstrx [fail] got 2 MP_RST[s] RX expected 1
Server ns stats
TcpPassiveOpens                 3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       288                0.0
TcpOutSegs                      898                0.0
TcpOutRsts                      2                  0.0
TcpExtTCPPureAcks               148                0.0
TcpExtTCPAbortOnClose           1                  0.0
TcpExtTCPRcvCoalesce            6                  0.0
TcpExtTCPFromZeroWindowAdv      7                  0.0
TcpExtTCPToZeroWindowAdv        7                  0.0
TcpExtTCPWantZeroWindowAdv      98                 0.0
TcpExtTCPOrigDataSent           787                0.0
TcpExtTCPDelivered              787                0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             2                  0.0
MPTcpExtMPJoinAckRx             2                  0.0
MPTcpExtDataCsumErr             1                  0.0
MPTcpExtOFOQueueTail            10                 0.0
MPTcpExtOFOQueue                23                 0.0
MPTcpExtOFOMerge                7                  0.0
MPTcpExtDuplicateData           11                 0.0
MPTcpExtMPFailTx                1                  0.0
MPTcpExtMPRstTx                 2                  0.0
MPTcpExtRcvPruned               10                 0.0
Client ns stats
TcpActiveOpens                  3                  0.0
TcpEstabResets                  1                  0.0
TcpInSegs                       294                0.0
TcpOutSegs                      953                0.0
TcpExtTW                        1                  0.0
TcpExtTCPPureAcks               105                0.0
TcpExtTCPBacklogCoalesce        1                  0.0
TcpExtTCPAutoCorking            1                  0.0
TcpExtTCPOrigDataSent           802                0.0
TcpExtTCPHystartTrainDetect     1                  0.0
TcpExtTCPHystartTrainCwnd       34                 0.0
TcpExtTCPDelivered              803                0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPTCPRetrans            2                  0.0
MPTcpExtMPJoinSynAckRx          2                  0.0
MPTcpExtMPFailRx                1                  0.0
MPTcpExtMPRstRx                 2                  0.0
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.7DquCQjpk0 (size 128 KB) containing data sent by client
Created /tmp/tmp.XgiCG5VUcB (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

162

Created /tmp/tmp.zBOrr2dVUV (size 1 KB) containing data sent by client
Created /tmp/tmp.28M4aBaZoP (size 1 KB) containing data sent by server
Created /tmp/tmp.woArS7pbM0 (size 1024 KB) containing data sent by client
Created /tmp/tmp.QjSaLeWtT8 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 264485
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.woArS7pbM0 (size 128 KB) containing data sent by client
Created /tmp/tmp.QjSaLeWtT8 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 4 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

163

Created /tmp/tmp.cdAEwvm0NX (size 1 KB) containing data sent by client
Created /tmp/tmp.RdNyCQIFJW (size 1 KB) containing data sent by server
Created /tmp/tmp.oN5gnukd1Y (size 1024 KB) containing data sent by client
Created /tmp/tmp.VtMbTTCdfi (size 1024 KB) containing data sent by server
file received by server has inverted byte at 588801
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.oN5gnukd1Y (size 128 KB) containing data sent by client
Created /tmp/tmp.VtMbTTCdfi (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

164

Created /tmp/tmp.uKBG019tf2 (size 1 KB) containing data sent by client
Created /tmp/tmp.p26gzbI3Xq (size 1 KB) containing data sent by server
Created /tmp/tmp.H8LFY4GRjX (size 1024 KB) containing data sent by client
Created /tmp/tmp.mraRefRAR0 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 531457
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.H8LFY4GRjX (size 128 KB) containing data sent by client
Created /tmp/tmp.mraRefRAR0 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

165

Created /tmp/tmp.US4mrY0xRP (size 1 KB) containing data sent by client
Created /tmp/tmp.PXRH7U0gYz (size 1 KB) containing data sent by server
Created /tmp/tmp.bXGZFIsGy3 (size 1024 KB) containing data sent by client
Created /tmp/tmp.swh1L1UJpD (size 1024 KB) containing data sent by server
file received by server has inverted byte at 465921
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.bXGZFIsGy3 (size 128 KB) containing data sent by client
Created /tmp/tmp.swh1L1UJpD (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

166

Created /tmp/tmp.jsTWM9KTLp (size 1 KB) containing data sent by client
Created /tmp/tmp.1uCT10daF5 (size 1 KB) containing data sent by server
Created /tmp/tmp.5WoDH5z2tB (size 1024 KB) containing data sent by client
Created /tmp/tmp.kJcHkTuNFt (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.5WoDH5z2tB (size 128 KB) containing data sent by client
Created /tmp/tmp.kJcHkTuNFt (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

167

Created /tmp/tmp.8OpMsMvhJG (size 1 KB) containing data sent by client
Created /tmp/tmp.ZvSMI2IxbV (size 1 KB) containing data sent by server
Created /tmp/tmp.WicMioEQsE (size 1024 KB) containing data sent by client
Created /tmp/tmp.saa3hTuXKM (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.WicMioEQsE (size 128 KB) containing data sent by client
Created /tmp/tmp.saa3hTuXKM (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

168

Created /tmp/tmp.HmarvqQMXz (size 1 KB) containing data sent by client
Created /tmp/tmp.OeXhBDngV1 (size 1 KB) containing data sent by server
Created /tmp/tmp.pNpHCu8kcC (size 1024 KB) containing data sent by client
Created /tmp/tmp.H2HRhvr1Uc (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.pNpHCu8kcC (size 128 KB) containing data sent by client
Created /tmp/tmp.H2HRhvr1Uc (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

169

Created /tmp/tmp.aK4cjHVSq9 (size 1 KB) containing data sent by client
Created /tmp/tmp.365tYafYvm (size 1 KB) containing data sent by server
Created /tmp/tmp.HH98aiRpoY (size 1024 KB) containing data sent by client
Created /tmp/tmp.HDIZbgfz0M (size 1024 KB) containing data sent by server
file received by server has inverted byte at 662529
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.HH98aiRpoY (size 128 KB) containing data sent by client
Created /tmp/tmp.HDIZbgfz0M (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

170

Created /tmp/tmp.wxTVgIf9io (size 1 KB) containing data sent by client
Created /tmp/tmp.9Cmt3r17Al (size 1 KB) containing data sent by server
Created /tmp/tmp.Bj1fOIcXfs (size 1024 KB) containing data sent by client
Created /tmp/tmp.KGtHMPHSuK (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Bj1fOIcXfs (size 128 KB) containing data sent by client
Created /tmp/tmp.KGtHMPHSuK (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

171

Created /tmp/tmp.hvu3rYxNJm (size 1 KB) containing data sent by client
Created /tmp/tmp.5qe9FWNrZ6 (size 1 KB) containing data sent by server
Created /tmp/tmp.GlDCmsuIHp (size 1024 KB) containing data sent by client
Created /tmp/tmp.5irdOZzsua (size 1024 KB) containing data sent by server
file received by server has inverted byte at 596993
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.GlDCmsuIHp (size 128 KB) containing data sent by client
Created /tmp/tmp.5irdOZzsua (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

172

Created /tmp/tmp.RD82iD5wgr (size 1 KB) containing data sent by client
Created /tmp/tmp.AiLji2Oyd1 (size 1 KB) containing data sent by server
Created /tmp/tmp.mU9CS2i4oR (size 1024 KB) containing data sent by client
Created /tmp/tmp.nTWtsOe3bR (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.mU9CS2i4oR (size 128 KB) containing data sent by client
Created /tmp/tmp.nTWtsOe3bR (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

173

Created /tmp/tmp.CqTBDyzYMp (size 1 KB) containing data sent by client
Created /tmp/tmp.DqLf19f01y (size 1 KB) containing data sent by server
Created /tmp/tmp.2TQdLu3Zun (size 1024 KB) containing data sent by client
Created /tmp/tmp.yaiPAWd9l1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 525754
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.2TQdLu3Zun (size 128 KB) containing data sent by client
Created /tmp/tmp.yaiPAWd9l1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

174

Created /tmp/tmp.yTYseKp9LW (size 1 KB) containing data sent by client
Created /tmp/tmp.uJRORUheSQ (size 1 KB) containing data sent by server
Created /tmp/tmp.vNSMKWekUo (size 1024 KB) containing data sent by client
Created /tmp/tmp.gCPH1IgK8A (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.vNSMKWekUo (size 128 KB) containing data sent by client
Created /tmp/tmp.gCPH1IgK8A (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

175

Created /tmp/tmp.rOuiBhPdRA (size 1 KB) containing data sent by client
Created /tmp/tmp.WETv0vKcdT (size 1 KB) containing data sent by server
Created /tmp/tmp.PhGk16KSGa (size 1024 KB) containing data sent by client
Created /tmp/tmp.4PPClMAQqH (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.PhGk16KSGa (size 128 KB) containing data sent by client
Created /tmp/tmp.4PPClMAQqH (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

176

Created /tmp/tmp.DeZJ8TkekO (size 1 KB) containing data sent by client
Created /tmp/tmp.8ikCbW6qtO (size 1 KB) containing data sent by server
Created /tmp/tmp.5WJwUfmJrO (size 1024 KB) containing data sent by client
Created /tmp/tmp.169HhEGmam (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.5WJwUfmJrO (size 128 KB) containing data sent by client
Created /tmp/tmp.169HhEGmam (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

177

Created /tmp/tmp.UBR4fP5x42 (size 1 KB) containing data sent by client
Created /tmp/tmp.GDMrMSwcNF (size 1 KB) containing data sent by server
Created /tmp/tmp.lMQHLZS6BU (size 1024 KB) containing data sent by client
Created /tmp/tmp.6ngekRjfse (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.lMQHLZS6BU (size 128 KB) containing data sent by client
Created /tmp/tmp.6ngekRjfse (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

178

Created /tmp/tmp.hhKjeqbQXf (size 1 KB) containing data sent by client
Created /tmp/tmp.bMtflFm03s (size 1 KB) containing data sent by server
Created /tmp/tmp.DfEGEuRTqk (size 1024 KB) containing data sent by client
Created /tmp/tmp.sKtzPf3vwq (size 1024 KB) containing data sent by server
file received by server has inverted byte at 190840
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.DfEGEuRTqk (size 128 KB) containing data sent by client
Created /tmp/tmp.sKtzPf3vwq (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

179

Created /tmp/tmp.6UXq6Tk4lZ (size 1 KB) containing data sent by client
Created /tmp/tmp.MxNzVyoX5t (size 1 KB) containing data sent by server
Created /tmp/tmp.wGXwHHccXr (size 1024 KB) containing data sent by client
Created /tmp/tmp.TQIKVS3BXt (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.wGXwHHccXr (size 128 KB) containing data sent by client
Created /tmp/tmp.TQIKVS3BXt (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

180

Created /tmp/tmp.PFANGXqKBx (size 1 KB) containing data sent by client
Created /tmp/tmp.jTF6MRvIJ7 (size 1 KB) containing data sent by server
Created /tmp/tmp.fzJBxsxV2Z (size 1024 KB) containing data sent by client
Created /tmp/tmp.bYE63l2yB6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 660489
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.fzJBxsxV2Z (size 128 KB) containing data sent by client
Created /tmp/tmp.bYE63l2yB6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

181

Created /tmp/tmp.Ado2V8XDz9 (size 1 KB) containing data sent by client
Created /tmp/tmp.JtCPm2fTZe (size 1 KB) containing data sent by server
Created /tmp/tmp.OFkLDRaoia (size 1024 KB) containing data sent by client
Created /tmp/tmp.Xve1baJsfo (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.OFkLDRaoia (size 128 KB) containing data sent by client
Created /tmp/tmp.Xve1baJsfo (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

182

Created /tmp/tmp.ZhcB0PFZuH (size 1 KB) containing data sent by client
Created /tmp/tmp.XUj51ZQu27 (size 1 KB) containing data sent by server
Created /tmp/tmp.OSNU6i1Gfh (size 1024 KB) containing data sent by client
Created /tmp/tmp.RAOyFcWqof (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.OSNU6i1Gfh (size 128 KB) containing data sent by client
Created /tmp/tmp.RAOyFcWqof (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

183

Created /tmp/tmp.bF5zlvxPo3 (size 1 KB) containing data sent by client
Created /tmp/tmp.6NVbMIPQOf (size 1 KB) containing data sent by server
Created /tmp/tmp.Q8MaTZE1Uu (size 1024 KB) containing data sent by client
Created /tmp/tmp.o2JfnJwA1V (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Q8MaTZE1Uu (size 128 KB) containing data sent by client
Created /tmp/tmp.o2JfnJwA1V (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

184

Created /tmp/tmp.P1ac0mTlDE (size 1 KB) containing data sent by client
Created /tmp/tmp.hQaIeg2oPt (size 1 KB) containing data sent by server
Created /tmp/tmp.GMfiNIX0eK (size 1024 KB) containing data sent by client
Created /tmp/tmp.viEWLckwXZ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 195585
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.GMfiNIX0eK (size 128 KB) containing data sent by client
Created /tmp/tmp.viEWLckwXZ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

185

Created /tmp/tmp.1rO4OZKyCu (size 1 KB) containing data sent by client
Created /tmp/tmp.mcPIXiJnkb (size 1 KB) containing data sent by server
Created /tmp/tmp.M5poCGp8nf (size 1024 KB) containing data sent by client
Created /tmp/tmp.7ykYugndpC (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.M5poCGp8nf (size 128 KB) containing data sent by client
Created /tmp/tmp.7ykYugndpC (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

186

Created /tmp/tmp.XIODPbBrBY (size 1 KB) containing data sent by client
Created /tmp/tmp.o6GwEUXuNO (size 1 KB) containing data sent by server
Created /tmp/tmp.B7ecL5saSy (size 1024 KB) containing data sent by client
Created /tmp/tmp.7RAScbhxAv (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.B7ecL5saSy (size 128 KB) containing data sent by client
Created /tmp/tmp.7RAScbhxAv (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

187

Created /tmp/tmp.EPpoIrZvzA (size 1 KB) containing data sent by client
Created /tmp/tmp.hXfI9zH2vL (size 1 KB) containing data sent by server
Created /tmp/tmp.f68NVVDl8X (size 1024 KB) containing data sent by client
Created /tmp/tmp.HNCdSPRdTO (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.f68NVVDl8X (size 128 KB) containing data sent by client
Created /tmp/tmp.HNCdSPRdTO (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

188

Created /tmp/tmp.u3aZLBcxSc (size 1 KB) containing data sent by client
Created /tmp/tmp.fkD2X1KEW0 (size 1 KB) containing data sent by server
Created /tmp/tmp.ceCLuc5DPK (size 1024 KB) containing data sent by client
Created /tmp/tmp.hMSF5CbLRR (size 1024 KB) containing data sent by server
file received by server has inverted byte at 200193
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ceCLuc5DPK (size 128 KB) containing data sent by client
Created /tmp/tmp.hMSF5CbLRR (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

189

Created /tmp/tmp.yNOqclrsdl (size 1 KB) containing data sent by client
Created /tmp/tmp.wYnZEF59f8 (size 1 KB) containing data sent by server
Created /tmp/tmp.zsrhEzOE5Z (size 1024 KB) containing data sent by client
Created /tmp/tmp.ncqk4Wqg0q (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.zsrhEzOE5Z (size 128 KB) containing data sent by client
Created /tmp/tmp.ncqk4Wqg0q (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

190

Created /tmp/tmp.2oJcMM1nyU (size 1 KB) containing data sent by client
Created /tmp/tmp.mBnFHJgYuS (size 1 KB) containing data sent by server
Created /tmp/tmp.OG28XgEaJv (size 1024 KB) containing data sent by client
Created /tmp/tmp.hheEOAuDkp (size 1024 KB) containing data sent by server
file received by server has inverted byte at 131141
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.OG28XgEaJv (size 128 KB) containing data sent by client
Created /tmp/tmp.hheEOAuDkp (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

191

Created /tmp/tmp.LbQSdJ4nU6 (size 1 KB) containing data sent by client
Created /tmp/tmp.4R0GPEDI13 (size 1 KB) containing data sent by server
Created /tmp/tmp.FmMR6Tgdn1 (size 1024 KB) containing data sent by client
Created /tmp/tmp.rvMTjZgWRq (size 1024 KB) containing data sent by server
file received by server has inverted byte at 793601
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.FmMR6Tgdn1 (size 128 KB) containing data sent by client
Created /tmp/tmp.rvMTjZgWRq (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

192

Created /tmp/tmp.Ej2RVuLFZ5 (size 1 KB) containing data sent by client
Created /tmp/tmp.WmqoZpiCwU (size 1 KB) containing data sent by server
Created /tmp/tmp.fyeK6UaILR (size 1024 KB) containing data sent by client
Created /tmp/tmp.7zAc5bRVlX (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.fyeK6UaILR (size 128 KB) containing data sent by client
Created /tmp/tmp.7zAc5bRVlX (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

193

Created /tmp/tmp.mft8MZ8OM7 (size 1 KB) containing data sent by client
Created /tmp/tmp.FX4zGl8Ve6 (size 1 KB) containing data sent by server
Created /tmp/tmp.nYCt8Rqy0P (size 1024 KB) containing data sent by client
Created /tmp/tmp.2r0TMqmufb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.nYCt8Rqy0P (size 128 KB) containing data sent by client
Created /tmp/tmp.2r0TMqmufb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

194

Created /tmp/tmp.W499jQZ549 (size 1 KB) containing data sent by client
Created /tmp/tmp.6HRmmKbYvB (size 1 KB) containing data sent by server
Created /tmp/tmp.axNc2mMZjb (size 1024 KB) containing data sent by client
Created /tmp/tmp.V2WGyvMyEs (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.axNc2mMZjb (size 128 KB) containing data sent by client
Created /tmp/tmp.V2WGyvMyEs (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

195

Created /tmp/tmp.iILFvT7Bu1 (size 1 KB) containing data sent by client
Created /tmp/tmp.LvqfC3Ac3C (size 1 KB) containing data sent by server
Created /tmp/tmp.qUnEdNP1p5 (size 1024 KB) containing data sent by client
Created /tmp/tmp.s30TnpCmUz (size 1024 KB) containing data sent by server
file received by server has inverted byte at 465921
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qUnEdNP1p5 (size 128 KB) containing data sent by client
Created /tmp/tmp.s30TnpCmUz (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

196

Created /tmp/tmp.Zil4M0fdDV (size 1 KB) containing data sent by client
Created /tmp/tmp.xxdyg0LOZ3 (size 1 KB) containing data sent by server
Created /tmp/tmp.c0fMDPhj9z (size 1024 KB) containing data sent by client
Created /tmp/tmp.i6D0rxEGr9 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.c0fMDPhj9z (size 128 KB) containing data sent by client
Created /tmp/tmp.i6D0rxEGr9 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

197

Created /tmp/tmp.pf4vSTH7JU (size 1 KB) containing data sent by client
Created /tmp/tmp.UYKtp2mCMO (size 1 KB) containing data sent by server
Created /tmp/tmp.PEYOCbOqKL (size 1024 KB) containing data sent by client
Created /tmp/tmp.PmyP4MAJqh (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.PEYOCbOqKL (size 128 KB) containing data sent by client
Created /tmp/tmp.PmyP4MAJqh (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

198

Created /tmp/tmp.kKo587TPZ2 (size 1 KB) containing data sent by client
Created /tmp/tmp.wHXncnNDLK (size 1 KB) containing data sent by server
Created /tmp/tmp.lieNz48ddK (size 1024 KB) containing data sent by client
Created /tmp/tmp.tNOAiEHrON (size 1024 KB) containing data sent by server
file received by server has inverted byte at 326657
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.lieNz48ddK (size 128 KB) containing data sent by client
Created /tmp/tmp.tNOAiEHrON (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

199

Created /tmp/tmp.kabzDmjOXW (size 1 KB) containing data sent by client
Created /tmp/tmp.68h7J86ceH (size 1 KB) containing data sent by server
Created /tmp/tmp.CO8Epg4SqX (size 1024 KB) containing data sent by client
Created /tmp/tmp.7BxvXCcK0F (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.CO8Epg4SqX (size 128 KB) containing data sent by client
Created /tmp/tmp.7BxvXCcK0F (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

200

Created /tmp/tmp.iOpZwCZaBB (size 1 KB) containing data sent by client
Created /tmp/tmp.g349UKCVng (size 1 KB) containing data sent by server
Created /tmp/tmp.M35T52pK45 (size 1024 KB) containing data sent by client
Created /tmp/tmp.Vi0XzKtIJy (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.M35T52pK45 (size 128 KB) containing data sent by client
Created /tmp/tmp.Vi0XzKtIJy (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

201

Created /tmp/tmp.66dTZGpOTu (size 1 KB) containing data sent by client
Created /tmp/tmp.Y2wx7imElw (size 1 KB) containing data sent by server
Created /tmp/tmp.ptPvKy8iXP (size 1024 KB) containing data sent by client
Created /tmp/tmp.7G90NfWgqJ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 261121
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ptPvKy8iXP (size 128 KB) containing data sent by client
Created /tmp/tmp.7G90NfWgqJ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

202

Created /tmp/tmp.xrEwciltFT (size 1 KB) containing data sent by client
Created /tmp/tmp.Dmv2MZAvdp (size 1 KB) containing data sent by server
Created /tmp/tmp.z5bTCVAqcV (size 1024 KB) containing data sent by client
Created /tmp/tmp.2NfANglHFy (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.z5bTCVAqcV (size 128 KB) containing data sent by client
Created /tmp/tmp.2NfANglHFy (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

203

Created /tmp/tmp.Arn3PXXEKT (size 1 KB) containing data sent by client
Created /tmp/tmp.bEWPRT99oT (size 1 KB) containing data sent by server
Created /tmp/tmp.M0YdqRmVRx (size 1024 KB) containing data sent by client
Created /tmp/tmp.ASaoIExAWy (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.M0YdqRmVRx (size 128 KB) containing data sent by client
Created /tmp/tmp.ASaoIExAWy (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

204

Created /tmp/tmp.6ojwAouNRS (size 1 KB) containing data sent by client
Created /tmp/tmp.29Bd0tO506 (size 1 KB) containing data sent by server
Created /tmp/tmp.pHG9pQWqs8 (size 1024 KB) containing data sent by client
Created /tmp/tmp.LiYWk3urF2 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.pHG9pQWqs8 (size 128 KB) containing data sent by client
Created /tmp/tmp.LiYWk3urF2 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

205

Created /tmp/tmp.CVlC53Y3t1 (size 1 KB) containing data sent by client
Created /tmp/tmp.F5pBKk1z7r (size 1 KB) containing data sent by server
Created /tmp/tmp.sSjwXMxaV3 (size 1024 KB) containing data sent by client
Created /tmp/tmp.vvFifZlbCW (size 1024 KB) containing data sent by server
file received by server has inverted byte at 400385
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.sSjwXMxaV3 (size 128 KB) containing data sent by client
Created /tmp/tmp.vvFifZlbCW (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

206

Created /tmp/tmp.vZJiv0io3n (size 1 KB) containing data sent by client
Created /tmp/tmp.7TBAJNUWWr (size 1 KB) containing data sent by server
Created /tmp/tmp.VLWanJJMfe (size 1024 KB) containing data sent by client
Created /tmp/tmp.KnaxBFg3Oy (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.VLWanJJMfe (size 128 KB) containing data sent by client
Created /tmp/tmp.KnaxBFg3Oy (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

207

Created /tmp/tmp.uJVI9mTlf9 (size 1 KB) containing data sent by client
Created /tmp/tmp.py2ZYMwZEe (size 1 KB) containing data sent by server
Created /tmp/tmp.RBYjgeHDjf (size 1024 KB) containing data sent by client
Created /tmp/tmp.vUZFBK0lMO (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.RBYjgeHDjf (size 128 KB) containing data sent by client
Created /tmp/tmp.vUZFBK0lMO (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

208

Created /tmp/tmp.Kl5hbRqm9q (size 1 KB) containing data sent by client
Created /tmp/tmp.AgsrqZ6qu8 (size 1 KB) containing data sent by server
Created /tmp/tmp.2sTb5vBDRl (size 1024 KB) containing data sent by client
Created /tmp/tmp.JThE5UEJ8Y (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.2sTb5vBDRl (size 128 KB) containing data sent by client
Created /tmp/tmp.JThE5UEJ8Y (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

209

Created /tmp/tmp.AGRnw0IILU (size 1 KB) containing data sent by client
Created /tmp/tmp.DBxme1DIfA (size 1 KB) containing data sent by server
Created /tmp/tmp.ULiUn1Z12C (size 1024 KB) containing data sent by client
Created /tmp/tmp.tawaFqAY5b (size 1024 KB) containing data sent by server
file received by server has inverted byte at 924673
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ULiUn1Z12C (size 128 KB) containing data sent by client
Created /tmp/tmp.tawaFqAY5b (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 1 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

210

Created /tmp/tmp.MBOsMYsomu (size 1 KB) containing data sent by client
Created /tmp/tmp.e5PmSj69EI (size 1 KB) containing data sent by server
Created /tmp/tmp.qkfkRHAuTm (size 1024 KB) containing data sent by client
Created /tmp/tmp.25mDa6XM2q (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qkfkRHAuTm (size 128 KB) containing data sent by client
Created /tmp/tmp.25mDa6XM2q (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

211

Created /tmp/tmp.qE2Mznh1X8 (size 1 KB) containing data sent by client
Created /tmp/tmp.1AtcbMLEpR (size 1 KB) containing data sent by server
Created /tmp/tmp.s7q665xcIv (size 1024 KB) containing data sent by client
Created /tmp/tmp.CHr7KnFafl (size 1024 KB) containing data sent by server
file received by server has inverted byte at 531457
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.s7q665xcIv (size 128 KB) containing data sent by client
Created /tmp/tmp.CHr7KnFafl (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

212

Created /tmp/tmp.Oo620zkh8j (size 1 KB) containing data sent by client
Created /tmp/tmp.zrkKslt2QZ (size 1 KB) containing data sent by server
Created /tmp/tmp.9sl5mShewr (size 1024 KB) containing data sent by client
Created /tmp/tmp.5h51NrUJNb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.9sl5mShewr (size 128 KB) containing data sent by client
Created /tmp/tmp.5h51NrUJNb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

213

Created /tmp/tmp.GIzy1CwF9b (size 1 KB) containing data sent by client
Created /tmp/tmp.LkTi6elBhG (size 1 KB) containing data sent by server
Created /tmp/tmp.i1ampRf6Nk (size 1024 KB) containing data sent by client
Created /tmp/tmp.ubcvRBleKs (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.i1ampRf6Nk (size 128 KB) containing data sent by client
Created /tmp/tmp.ubcvRBleKs (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

214

Created /tmp/tmp.aLXiFNUcPT (size 1 KB) containing data sent by client
Created /tmp/tmp.f31G8VcoQC (size 1 KB) containing data sent by server
Created /tmp/tmp.6VQzlXpPMS (size 1024 KB) containing data sent by client
Created /tmp/tmp.MkNvOdztSS (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.6VQzlXpPMS (size 128 KB) containing data sent by client
Created /tmp/tmp.MkNvOdztSS (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

215

Created /tmp/tmp.sCdEZDh6OC (size 1 KB) containing data sent by client
Created /tmp/tmp.McGSPHn4Y5 (size 1 KB) containing data sent by server
Created /tmp/tmp.ArHmyytGg6 (size 1024 KB) containing data sent by client
Created /tmp/tmp.h8ABPoQ0vb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ArHmyytGg6 (size 128 KB) containing data sent by client
Created /tmp/tmp.h8ABPoQ0vb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

216

Created /tmp/tmp.7t9CK8wTMh (size 1 KB) containing data sent by client
Created /tmp/tmp.jjFwmCHWBG (size 1 KB) containing data sent by server
Created /tmp/tmp.W3zOuARfaU (size 1024 KB) containing data sent by client
Created /tmp/tmp.L16lAbHt9Q (size 1024 KB) containing data sent by server
file received by server has inverted byte at 662529
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.W3zOuARfaU (size 128 KB) containing data sent by client
Created /tmp/tmp.L16lAbHt9Q (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

217

Created /tmp/tmp.spejtDVDQs (size 1 KB) containing data sent by client
Created /tmp/tmp.MVkBnvWZqo (size 1 KB) containing data sent by server
Created /tmp/tmp.2aS0Jb4r2B (size 1024 KB) containing data sent by client
Created /tmp/tmp.EspLU4a8SV (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.2aS0Jb4r2B (size 128 KB) containing data sent by client
Created /tmp/tmp.EspLU4a8SV (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

218

Created /tmp/tmp.Ed0bOc4Z4e (size 1 KB) containing data sent by client
Created /tmp/tmp.Bx45hBdRnB (size 1 KB) containing data sent by server
Created /tmp/tmp.af3owapA8Y (size 1024 KB) containing data sent by client
Created /tmp/tmp.FT0cZWviJk (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.af3owapA8Y (size 128 KB) containing data sent by client
Created /tmp/tmp.FT0cZWviJk (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

219

Created /tmp/tmp.JwH17vI9Cj (size 1 KB) containing data sent by client
Created /tmp/tmp.FxZ8LsgZ3D (size 1 KB) containing data sent by server
Created /tmp/tmp.fe1kV9UUsv (size 1024 KB) containing data sent by client
Created /tmp/tmp.zvu9oNaYD0 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.fe1kV9UUsv (size 128 KB) containing data sent by client
Created /tmp/tmp.zvu9oNaYD0 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

220

Created /tmp/tmp.MM7VEqpPea (size 1 KB) containing data sent by client
Created /tmp/tmp.GwcgjlNH3B (size 1 KB) containing data sent by server
Created /tmp/tmp.tCtVrMFGWb (size 1024 KB) containing data sent by client
Created /tmp/tmp.9eTgtstI3R (size 1024 KB) containing data sent by server
file received by server has inverted byte at 465921
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.tCtVrMFGWb (size 128 KB) containing data sent by client
Created /tmp/tmp.9eTgtstI3R (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

221

Created /tmp/tmp.vqyBiNDbm4 (size 1 KB) containing data sent by client
Created /tmp/tmp.QUX6fsApR2 (size 1 KB) containing data sent by server
Created /tmp/tmp.o7dgXjCU4r (size 1024 KB) containing data sent by client
Created /tmp/tmp.hgho5gxRTx (size 1024 KB) containing data sent by server
file received by server has inverted byte at 859137
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.o7dgXjCU4r (size 128 KB) containing data sent by client
Created /tmp/tmp.hgho5gxRTx (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

222

Created /tmp/tmp.cRTQpW7poq (size 1 KB) containing data sent by client
Created /tmp/tmp.6tofHI6QBW (size 1 KB) containing data sent by server
Created /tmp/tmp.pOtquGGoMY (size 1024 KB) containing data sent by client
Created /tmp/tmp.twTmVCp8G1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 121857
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.pOtquGGoMY (size 128 KB) containing data sent by client
Created /tmp/tmp.twTmVCp8G1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

223

Created /tmp/tmp.w36ezUUTQC (size 1 KB) containing data sent by client
Created /tmp/tmp.WQXfiEANBG (size 1 KB) containing data sent by server
Created /tmp/tmp.jF9nnrVZpf (size 1024 KB) containing data sent by client
Created /tmp/tmp.lCk9TFwEEr (size 1024 KB) containing data sent by server
file received by server has inverted byte at 392193
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jF9nnrVZpf (size 128 KB) containing data sent by client
Created /tmp/tmp.lCk9TFwEEr (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

224

Created /tmp/tmp.H2eAki7cnh (size 1 KB) containing data sent by client
Created /tmp/tmp.smSGJ6mHOo (size 1 KB) containing data sent by server
Created /tmp/tmp.LzqLqjDyEJ (size 1024 KB) containing data sent by client
Created /tmp/tmp.5E8v5hZzF5 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.LzqLqjDyEJ (size 128 KB) containing data sent by client
Created /tmp/tmp.5E8v5hZzF5 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

225

Created /tmp/tmp.poUprnpPXk (size 1 KB) containing data sent by client
Created /tmp/tmp.hUXGAdAojc (size 1 KB) containing data sent by server
Created /tmp/tmp.eNJ3I60tN3 (size 1024 KB) containing data sent by client
Created /tmp/tmp.NOm7L5mgrs (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.eNJ3I60tN3 (size 128 KB) containing data sent by client
Created /tmp/tmp.NOm7L5mgrs (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

226

Created /tmp/tmp.4WdG5L43rj (size 1 KB) containing data sent by client
Created /tmp/tmp.Ib8k1PZCOy (size 1 KB) containing data sent by server
Created /tmp/tmp.NEea9cnm2a (size 1024 KB) containing data sent by client
Created /tmp/tmp.MposUbeaKW (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.NEea9cnm2a (size 128 KB) containing data sent by client
Created /tmp/tmp.MposUbeaKW (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

227

Created /tmp/tmp.u3Cn1o6ZOO (size 1 KB) containing data sent by client
Created /tmp/tmp.qSOujymlrl (size 1 KB) containing data sent by server
Created /tmp/tmp.Iq76AVzp3m (size 1024 KB) containing data sent by client
Created /tmp/tmp.DOmKmaxx1q (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Iq76AVzp3m (size 128 KB) containing data sent by client
Created /tmp/tmp.DOmKmaxx1q (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

228

Created /tmp/tmp.QFOCB4wPxR (size 1 KB) containing data sent by client
Created /tmp/tmp.VflozqAZp0 (size 1 KB) containing data sent by server
Created /tmp/tmp.2dPeQ5hf9y (size 1024 KB) containing data sent by client
Created /tmp/tmp.tkrcIGIxu1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.2dPeQ5hf9y (size 128 KB) containing data sent by client
Created /tmp/tmp.tkrcIGIxu1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

229

Created /tmp/tmp.ySQSdotDan (size 1 KB) containing data sent by client
Created /tmp/tmp.sYgOhxVNcb (size 1 KB) containing data sent by server
Created /tmp/tmp.9sjOM67nSr (size 1024 KB) containing data sent by client
Created /tmp/tmp.IG9LWnfbqR (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.9sjOM67nSr (size 128 KB) containing data sent by client
Created /tmp/tmp.IG9LWnfbqR (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

230

Created /tmp/tmp.c1M7iU8Fw0 (size 1 KB) containing data sent by client
Created /tmp/tmp.9Dvuy2qNiK (size 1 KB) containing data sent by server
Created /tmp/tmp.abw2obHxaL (size 1024 KB) containing data sent by client
Created /tmp/tmp.jqf7PzCD6b (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.abw2obHxaL (size 128 KB) containing data sent by client
Created /tmp/tmp.jqf7PzCD6b (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

231

Created /tmp/tmp.D3GuqIhON8 (size 1 KB) containing data sent by client
Created /tmp/tmp.iNfURBCSBi (size 1 KB) containing data sent by server
Created /tmp/tmp.AX5ajIHsFt (size 1024 KB) containing data sent by client
Created /tmp/tmp.qTLiBc8ocE (size 1024 KB) containing data sent by server
file received by server has inverted byte at 400385
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.AX5ajIHsFt (size 128 KB) containing data sent by client
Created /tmp/tmp.qTLiBc8ocE (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

232

Created /tmp/tmp.FM0fTkQ0yv (size 1 KB) containing data sent by client
Created /tmp/tmp.9FE2DjqVh8 (size 1 KB) containing data sent by server
Created /tmp/tmp.FAqHpIpFIg (size 1024 KB) containing data sent by client
Created /tmp/tmp.yFfgs15dRN (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.FAqHpIpFIg (size 128 KB) containing data sent by client
Created /tmp/tmp.yFfgs15dRN (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

233

Created /tmp/tmp.n863MOYum6 (size 1 KB) containing data sent by client
Created /tmp/tmp.K56c7FKNCz (size 1 KB) containing data sent by server
Created /tmp/tmp.IhITJ9c97r (size 1024 KB) containing data sent by client
Created /tmp/tmp.L9CqT3cId7 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 728065
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.IhITJ9c97r (size 128 KB) containing data sent by client
Created /tmp/tmp.L9CqT3cId7 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

234

Created /tmp/tmp.8rZ3RDJGkY (size 1 KB) containing data sent by client
Created /tmp/tmp.PLl151YT0X (size 1 KB) containing data sent by server
Created /tmp/tmp.zvzP8T0M8r (size 1024 KB) containing data sent by client
Created /tmp/tmp.eHrh6re8nn (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.zvzP8T0M8r (size 128 KB) containing data sent by client
Created /tmp/tmp.eHrh6re8nn (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

235

Created /tmp/tmp.xWwYEfUkmv (size 1 KB) containing data sent by client
Created /tmp/tmp.giuYA00pAo (size 1 KB) containing data sent by server
Created /tmp/tmp.ifcIcmMFWe (size 1024 KB) containing data sent by client
Created /tmp/tmp.CQRM6IolYS (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ifcIcmMFWe (size 128 KB) containing data sent by client
Created /tmp/tmp.CQRM6IolYS (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

236

Created /tmp/tmp.UA9yplaeYE (size 1 KB) containing data sent by client
Created /tmp/tmp.xA5HIecpnw (size 1 KB) containing data sent by server
Created /tmp/tmp.aQ57ju4bXw (size 1024 KB) containing data sent by client
Created /tmp/tmp.nX17AVMiPF (size 1024 KB) containing data sent by server
001 MP_FAIL MP_RST: retry 1
Created /tmp/tmp.aQ57ju4bXw (size 1024 KB) containing data sent by client
Created /tmp/tmp.nX17AVMiPF (size 1024 KB) containing data sent by server
002 MP_FAIL MP_RST: retry 2
Created /tmp/tmp.aQ57ju4bXw (size 1024 KB) containing data sent by client
Created /tmp/tmp.nX17AVMiPF (size 1024 KB) containing data sent by server
file received by server has inverted byte at 726627
003 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.aQ57ju4bXw (size 128 KB) containing data sent by client
Created /tmp/tmp.nX17AVMiPF (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
004 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

237

Created /tmp/tmp.8yTaxJccv4 (size 1 KB) containing data sent by client
Created /tmp/tmp.9uiE3ipxlR (size 1 KB) containing data sent by server
Created /tmp/tmp.7LYPXYQ5Pn (size 1024 KB) containing data sent by client
Created /tmp/tmp.taIxQW5djB (size 1024 KB) containing data sent by server
file received by server has inverted byte at 728065
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.7LYPXYQ5Pn (size 128 KB) containing data sent by client
Created /tmp/tmp.taIxQW5djB (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

238

Created /tmp/tmp.xAryncUvjD (size 1 KB) containing data sent by client
Created /tmp/tmp.TBicary9gC (size 1 KB) containing data sent by server
Created /tmp/tmp.kX8HNy5hAX (size 1024 KB) containing data sent by client
Created /tmp/tmp.xXeHdWyHq1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 132310
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.kX8HNy5hAX (size 128 KB) containing data sent by client
Created /tmp/tmp.xXeHdWyHq1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

239

Created /tmp/tmp.VKS7IIbQu2 (size 1 KB) containing data sent by client
Created /tmp/tmp.udZcYICudF (size 1 KB) containing data sent by server
Created /tmp/tmp.EoIHgiWZzI (size 1024 KB) containing data sent by client
Created /tmp/tmp.vOpkjdc5Ft (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.EoIHgiWZzI (size 128 KB) containing data sent by client
Created /tmp/tmp.vOpkjdc5Ft (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

240

Created /tmp/tmp.KHkmDe3uae (size 1 KB) containing data sent by client
Created /tmp/tmp.cpmAr4E3XX (size 1 KB) containing data sent by server
Created /tmp/tmp.bD6azgNudw (size 1024 KB) containing data sent by client
Created /tmp/tmp.lzDpDJ2fOx (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.bD6azgNudw (size 128 KB) containing data sent by client
Created /tmp/tmp.lzDpDJ2fOx (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

241

Created /tmp/tmp.drPbRzRvbl (size 1 KB) containing data sent by client
Created /tmp/tmp.Styt7tno9J (size 1 KB) containing data sent by server
Created /tmp/tmp.WBqH35XSJ6 (size 1024 KB) containing data sent by client
Created /tmp/tmp.sTF6DuIfP9 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.WBqH35XSJ6 (size 128 KB) containing data sent by client
Created /tmp/tmp.sTF6DuIfP9 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

242

Created /tmp/tmp.Dh2oWFSXYG (size 1 KB) containing data sent by client
Created /tmp/tmp.Fi3Q8lJlGj (size 1 KB) containing data sent by server
Created /tmp/tmp.Pw3eHX7xX4 (size 1024 KB) containing data sent by client
Created /tmp/tmp.73HvhuChdg (size 1024 KB) containing data sent by server
file received by server has inverted byte at 465921
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Pw3eHX7xX4 (size 128 KB) containing data sent by client
Created /tmp/tmp.73HvhuChdg (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

243

Created /tmp/tmp.Z3LIFhHPm7 (size 1 KB) containing data sent by client
Created /tmp/tmp.RXK5pw4Wwc (size 1 KB) containing data sent by server
Created /tmp/tmp.m5dxaG3Kiu (size 1024 KB) containing data sent by client
Created /tmp/tmp.az8MclgM2C (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[fail] got 2 data checksum error[s] expected 1
 - csum  [ ok ]
Server ns stats
TcpPassiveOpens                 3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       289                0.0
TcpOutSegs                      888                0.0
TcpOutRsts                      2                  0.0
TcpExtTW                        1                  0.0
TcpExtTCPPureAcks               146                0.0
TcpExtTCPRcvCoalesce            2                  0.0
TcpExtTCPFromZeroWindowAdv      10                 0.0
TcpExtTCPToZeroWindowAdv        10                 0.0
TcpExtTCPWantZeroWindowAdv      35                 0.0
TcpExtTCPOrigDataSent           782                0.0
TcpExtTCPDelivered              782                0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             2                  0.0
MPTcpExtMPJoinAckRx             2                  0.0
MPTcpExtDataCsumErr             2                  0.0
MPTcpExtOFOQueueTail            3                  0.0
MPTcpExtOFOQueue                7                  0.0
MPTcpExtOFOMerge                3                  0.0
MPTcpExtDuplicateData           33                 0.0
MPTcpExtMPFailTx                2                  0.0
MPTcpExtMPRstTx                 2                  0.0
MPTcpExtRcvPruned               6                  0.0
Client ns stats
TcpActiveOpens                  3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       291                0.0
TcpOutSegs                      1001               0.0
TcpExtDelayedACKs               1                  0.0
TcpExtTCPPureAcks               100                0.0
TcpExtTCPBacklogCoalesce        1                  0.0
TcpExtTCPAutoCorking            2                  0.0
TcpExtTCPOrigDataSent           852                0.0
TcpExtTCPHystartTrainDetect     1                  0.0
TcpExtTCPHystartTrainCwnd       92                 0.0
TcpExtTCPDelivered              845                0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPJoinSynAckRx          2                  0.0
MPTcpExtMPFailRx                2                  0.0
MPTcpExtMPRstRx                 2                  0.0
                                         ftx[fail] got 2 MP_FAIL[s] TX expected 1
 - failrx[fail] got 2 MP_FAIL[s] RX expected 1
Server ns stats
TcpPassiveOpens                 3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       289                0.0
TcpOutSegs                      888                0.0
TcpOutRsts                      2                  0.0
TcpExtTW                        1                  0.0
TcpExtTCPPureAcks               146                0.0
TcpExtTCPRcvCoalesce            2                  0.0
TcpExtTCPFromZeroWindowAdv      10                 0.0
TcpExtTCPToZeroWindowAdv        10                 0.0
TcpExtTCPWantZeroWindowAdv      35                 0.0
TcpExtTCPOrigDataSent           782                0.0
TcpExtTCPDelivered              782                0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             2                  0.0
MPTcpExtMPJoinAckRx             2                  0.0
MPTcpExtDataCsumErr             2                  0.0
MPTcpExtOFOQueueTail            3                  0.0
MPTcpExtOFOQueue                7                  0.0
MPTcpExtOFOMerge                3                  0.0
MPTcpExtDuplicateData           33                 0.0
MPTcpExtMPFailTx                2                  0.0
MPTcpExtMPRstTx                 2                  0.0
MPTcpExtRcvPruned               6                  0.0
Client ns stats
TcpActiveOpens                  3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       291                0.0
TcpOutSegs                      1001               0.0
TcpExtDelayedACKs               1                  0.0
TcpExtTCPPureAcks               100                0.0
TcpExtTCPBacklogCoalesce        1                  0.0
TcpExtTCPAutoCorking            2                  0.0
TcpExtTCPOrigDataSent           852                0.0
TcpExtTCPHystartTrainDetect     1                  0.0
TcpExtTCPHystartTrainCwnd       92                 0.0
TcpExtTCPDelivered              845                0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPJoinSynAckRx          2                  0.0
MPTcpExtMPFailRx                2                  0.0
MPTcpExtMPRstRx                 2                  0.0
                                         rtx[fail] got 2 MP_RST[s] TX expected 1
 - rstrx [fail] got 2 MP_RST[s] RX expected 1
Server ns stats
TcpPassiveOpens                 3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       289                0.0
TcpOutSegs                      888                0.0
TcpOutRsts                      2                  0.0
TcpExtTW                        1                  0.0
TcpExtTCPPureAcks               146                0.0
TcpExtTCPRcvCoalesce            2                  0.0
TcpExtTCPFromZeroWindowAdv      10                 0.0
TcpExtTCPToZeroWindowAdv        10                 0.0
TcpExtTCPWantZeroWindowAdv      35                 0.0
TcpExtTCPOrigDataSent           782                0.0
TcpExtTCPDelivered              782                0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             2                  0.0
MPTcpExtMPJoinAckRx             2                  0.0
MPTcpExtDataCsumErr             2                  0.0
MPTcpExtOFOQueueTail            3                  0.0
MPTcpExtOFOQueue                7                  0.0
MPTcpExtOFOMerge                3                  0.0
MPTcpExtDuplicateData           33                 0.0
MPTcpExtMPFailTx                2                  0.0
MPTcpExtMPRstTx                 2                  0.0
MPTcpExtRcvPruned               6                  0.0
Client ns stats
TcpActiveOpens                  3                  0.0
TcpEstabResets                  2                  0.0
TcpInSegs                       291                0.0
TcpOutSegs                      1001               0.0
TcpExtDelayedACKs               1                  0.0
TcpExtTCPPureAcks               100                0.0
TcpExtTCPBacklogCoalesce        1                  0.0
TcpExtTCPAutoCorking            2                  0.0
TcpExtTCPOrigDataSent           852                0.0
TcpExtTCPHystartTrainDetect     1                  0.0
TcpExtTCPHystartTrainCwnd       92                 0.0
TcpExtTCPDelivered              845                0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPJoinSynAckRx          2                  0.0
MPTcpExtMPFailRx                2                  0.0
MPTcpExtMPRstRx                 2                  0.0
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.m5dxaG3Kiu (size 128 KB) containing data sent by client
Created /tmp/tmp.az8MclgM2C (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

244

Created /tmp/tmp.cGkCtTWkKh (size 1 KB) containing data sent by client
Created /tmp/tmp.NMrlRGq7I5 (size 1 KB) containing data sent by server
Created /tmp/tmp.N7uQ70w6d1 (size 1024 KB) containing data sent by client
Created /tmp/tmp.NFKa174KjI (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.N7uQ70w6d1 (size 128 KB) containing data sent by client
Created /tmp/tmp.NFKa174KjI (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

245

Created /tmp/tmp.B8a1PiuDNN (size 1 KB) containing data sent by client
Created /tmp/tmp.AAb20QxmR6 (size 1 KB) containing data sent by server
Created /tmp/tmp.lAbyIo5OGU (size 1024 KB) containing data sent by client
Created /tmp/tmp.lHAQpYq5BI (size 1024 KB) containing data sent by server
file received by server has inverted byte at 195585
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.lAbyIo5OGU (size 128 KB) containing data sent by client
Created /tmp/tmp.lHAQpYq5BI (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

246

Created /tmp/tmp.Dw4HNuW6aR (size 1 KB) containing data sent by client
Created /tmp/tmp.tlWmXPYCUn (size 1 KB) containing data sent by server
Created /tmp/tmp.ezS8wGoS3X (size 1024 KB) containing data sent by client
Created /tmp/tmp.yBtosM9fgx (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ezS8wGoS3X (size 128 KB) containing data sent by client
Created /tmp/tmp.yBtosM9fgx (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

247

Created /tmp/tmp.wuSAg6l9M1 (size 1 KB) containing data sent by client
Created /tmp/tmp.4ToRUJMmes (size 1 KB) containing data sent by server
Created /tmp/tmp.bIxrEw0x1Z (size 1024 KB) containing data sent by client
Created /tmp/tmp.ESNW8etXwM (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.bIxrEw0x1Z (size 128 KB) containing data sent by client
Created /tmp/tmp.ESNW8etXwM (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 1 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

248

Created /tmp/tmp.JG2YoYmS1m (size 1 KB) containing data sent by client
Created /tmp/tmp.VEPcKWrFL5 (size 1 KB) containing data sent by server
Created /tmp/tmp.1sBc0QUIP9 (size 1024 KB) containing data sent by client
Created /tmp/tmp.YehK5olcUe (size 1024 KB) containing data sent by server
file received by server has inverted byte at 990209
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.1sBc0QUIP9 (size 128 KB) containing data sent by client
Created /tmp/tmp.YehK5olcUe (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

249

Created /tmp/tmp.dsnf0Z93dP (size 1 KB) containing data sent by client
Created /tmp/tmp.CuYlmhiHwX (size 1 KB) containing data sent by server
Created /tmp/tmp.KEhXiUuPBP (size 1024 KB) containing data sent by client
Created /tmp/tmp.NIMPTImBDt (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.KEhXiUuPBP (size 128 KB) containing data sent by client
Created /tmp/tmp.NIMPTImBDt (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

250

Created /tmp/tmp.AQf8CEOa22 (size 1 KB) containing data sent by client
Created /tmp/tmp.GTfvrdKEsc (size 1 KB) containing data sent by server
Created /tmp/tmp.cZwlCfwoFu (size 1024 KB) containing data sent by client
Created /tmp/tmp.CaY8djEjWc (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.cZwlCfwoFu (size 128 KB) containing data sent by client
Created /tmp/tmp.CaY8djEjWc (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

251

Created /tmp/tmp.KegO6WxivP (size 1 KB) containing data sent by client
Created /tmp/tmp.BgCHpKOYSF (size 1 KB) containing data sent by server
Created /tmp/tmp.qkUn4XzeCp (size 1024 KB) containing data sent by client
Created /tmp/tmp.0fxqK11qlw (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qkUn4XzeCp (size 128 KB) containing data sent by client
Created /tmp/tmp.0fxqK11qlw (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

252

Created /tmp/tmp.LbtcD4OqPN (size 1 KB) containing data sent by client
Created /tmp/tmp.ADENIozvVK (size 1 KB) containing data sent by server
Created /tmp/tmp.ZvnRnirViY (size 1024 KB) containing data sent by client
Created /tmp/tmp.SOvaYDeEJa (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ZvnRnirViY (size 128 KB) containing data sent by client
Created /tmp/tmp.SOvaYDeEJa (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

253

Created /tmp/tmp.kJKxoO4Cf3 (size 1 KB) containing data sent by client
Created /tmp/tmp.bqIWUGaDSz (size 1 KB) containing data sent by server
Created /tmp/tmp.UeuRTBWjhh (size 1024 KB) containing data sent by client
Created /tmp/tmp.XCgqHcrE3M (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.UeuRTBWjhh (size 128 KB) containing data sent by client
Created /tmp/tmp.XCgqHcrE3M (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

254

Created /tmp/tmp.Pu6N56IlaQ (size 1 KB) containing data sent by client
Created /tmp/tmp.DU88NnKdZ4 (size 1 KB) containing data sent by server
Created /tmp/tmp.Hm41WYJAP5 (size 1024 KB) containing data sent by client
Created /tmp/tmp.ABujDBw9XC (size 1024 KB) containing data sent by server
file received by server has inverted byte at 195585
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Hm41WYJAP5 (size 128 KB) containing data sent by client
Created /tmp/tmp.ABujDBw9XC (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

255

Created /tmp/tmp.TxIV196NAD (size 1 KB) containing data sent by client
Created /tmp/tmp.IM7T6ttYDq (size 1 KB) containing data sent by server
Created /tmp/tmp.X8tHxdZWh8 (size 1024 KB) containing data sent by client
Created /tmp/tmp.wMIeqeQSGI (size 1024 KB) containing data sent by server
file received by server has inverted byte at 728065
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.X8tHxdZWh8 (size 128 KB) containing data sent by client
Created /tmp/tmp.wMIeqeQSGI (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

256

Created /tmp/tmp.UxNERWXoTZ (size 1 KB) containing data sent by client
Created /tmp/tmp.IFM9BNrySQ (size 1 KB) containing data sent by server
Created /tmp/tmp.vE6EXILcoi (size 1024 KB) containing data sent by client
Created /tmp/tmp.iCmyOQJzVT (size 1024 KB) containing data sent by server
file received by server has inverted byte at 68638
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.vE6EXILcoi (size 128 KB) containing data sent by client
Created /tmp/tmp.iCmyOQJzVT (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

257

Created /tmp/tmp.hhAZ4mbYMi (size 1 KB) containing data sent by client
Created /tmp/tmp.jUNxFLN7Zl (size 1 KB) containing data sent by server
Created /tmp/tmp.9GWFYcZSfq (size 1024 KB) containing data sent by client
Created /tmp/tmp.8nuv4vIieK (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.9GWFYcZSfq (size 128 KB) containing data sent by client
Created /tmp/tmp.8nuv4vIieK (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

258

Created /tmp/tmp.BPmK4cNUwP (size 1 KB) containing data sent by client
Created /tmp/tmp.gVx7aV6iQS (size 1 KB) containing data sent by server
Created /tmp/tmp.50z4Y0aw2S (size 1024 KB) containing data sent by client
Created /tmp/tmp.ToeLpxcFug (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.50z4Y0aw2S (size 128 KB) containing data sent by client
Created /tmp/tmp.ToeLpxcFug (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

259

Created /tmp/tmp.yHj1FfaN4d (size 1 KB) containing data sent by client
Created /tmp/tmp.WEvYRZfEOq (size 1 KB) containing data sent by server
Created /tmp/tmp.jvEpVskxpe (size 1024 KB) containing data sent by client
Created /tmp/tmp.zUdbAzxowH (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jvEpVskxpe (size 128 KB) containing data sent by client
Created /tmp/tmp.zUdbAzxowH (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

260

Created /tmp/tmp.UiLo9M4KDP (size 1 KB) containing data sent by client
Created /tmp/tmp.NDTTmC4bpt (size 1 KB) containing data sent by server
Created /tmp/tmp.QGp03lTb0E (size 1024 KB) containing data sent by client
Created /tmp/tmp.kJ4sOWHXBm (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.QGp03lTb0E (size 128 KB) containing data sent by client
Created /tmp/tmp.kJ4sOWHXBm (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

261

Created /tmp/tmp.nkbAYc1E1L (size 1 KB) containing data sent by client
Created /tmp/tmp.bx83Guvczo (size 1 KB) containing data sent by server
Created /tmp/tmp.PicuMLwN41 (size 1024 KB) containing data sent by client
Created /tmp/tmp.DVmShsRiAG (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.PicuMLwN41 (size 128 KB) containing data sent by client
Created /tmp/tmp.DVmShsRiAG (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

262

Created /tmp/tmp.p6YpZtlpgi (size 1 KB) containing data sent by client
Created /tmp/tmp.P1soqmkAB4 (size 1 KB) containing data sent by server
Created /tmp/tmp.AYcIXiaKjb (size 1024 KB) containing data sent by client
Created /tmp/tmp.K45TWfh8DD (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.AYcIXiaKjb (size 128 KB) containing data sent by client
Created /tmp/tmp.K45TWfh8DD (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

263

Created /tmp/tmp.IAp4kUL0fE (size 1 KB) containing data sent by client
Created /tmp/tmp.YuXJiOdLX1 (size 1 KB) containing data sent by server
Created /tmp/tmp.J1DyGAfu6Y (size 1024 KB) containing data sent by client
Created /tmp/tmp.WTc9QakfaK (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.J1DyGAfu6Y (size 128 KB) containing data sent by client
Created /tmp/tmp.WTc9QakfaK (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

264

Created /tmp/tmp.nmS92lCYnq (size 1 KB) containing data sent by client
Created /tmp/tmp.ufvcwABHhH (size 1 KB) containing data sent by server
Created /tmp/tmp.4voeecsDr1 (size 1024 KB) containing data sent by client
Created /tmp/tmp.Z7EHYAaRlb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.4voeecsDr1 (size 128 KB) containing data sent by client
Created /tmp/tmp.Z7EHYAaRlb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

265

Created /tmp/tmp.KdH0EPGwBz (size 1 KB) containing data sent by client
Created /tmp/tmp.mLi6nQ1dRf (size 1 KB) containing data sent by server
Created /tmp/tmp.rforcknNTs (size 1024 KB) containing data sent by client
Created /tmp/tmp.6ZLQekjw6O (size 1024 KB) containing data sent by server
file received by server has inverted byte at 400385
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.rforcknNTs (size 128 KB) containing data sent by client
Created /tmp/tmp.6ZLQekjw6O (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

266

Created /tmp/tmp.ZdCP68gy2x (size 1 KB) containing data sent by client
Created /tmp/tmp.jIvcMuRBDV (size 1 KB) containing data sent by server
Created /tmp/tmp.8ohKQCU86h (size 1024 KB) containing data sent by client
Created /tmp/tmp.QIO2menLRo (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.8ohKQCU86h (size 128 KB) containing data sent by client
Created /tmp/tmp.QIO2menLRo (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

267

Created /tmp/tmp.hvWYDOtDOn (size 1 KB) containing data sent by client
Created /tmp/tmp.wVSY8Fhq7W (size 1 KB) containing data sent by server
Created /tmp/tmp.ZEv5rWivfZ (size 1024 KB) containing data sent by client
Created /tmp/tmp.c01gKYHdgi (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ZEv5rWivfZ (size 128 KB) containing data sent by client
Created /tmp/tmp.c01gKYHdgi (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 1 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

268

Created /tmp/tmp.cvkhmJmXkw (size 1 KB) containing data sent by client
Created /tmp/tmp.PuNEKCqhDk (size 1 KB) containing data sent by server
Created /tmp/tmp.R15rlfmpSO (size 1024 KB) containing data sent by client
Created /tmp/tmp.ZPwgocJaKA (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.R15rlfmpSO (size 128 KB) containing data sent by client
Created /tmp/tmp.ZPwgocJaKA (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

269

Created /tmp/tmp.s30wGfP6cb (size 1 KB) containing data sent by client
Created /tmp/tmp.wdrgXFKAMf (size 1 KB) containing data sent by server
Created /tmp/tmp.HMbDV5gH9C (size 1024 KB) containing data sent by client
Created /tmp/tmp.xSfuF5FsUH (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.HMbDV5gH9C (size 128 KB) containing data sent by client
Created /tmp/tmp.xSfuF5FsUH (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

270

Created /tmp/tmp.3RnJ6mHrWA (size 1 KB) containing data sent by client
Created /tmp/tmp.JlNYbtYtqH (size 1 KB) containing data sent by server
Created /tmp/tmp.KXoR5Cejz3 (size 1024 KB) containing data sent by client
Created /tmp/tmp.zW24TNYnHT (size 1024 KB) containing data sent by server
file received by server has inverted byte at 261121
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.KXoR5Cejz3 (size 128 KB) containing data sent by client
Created /tmp/tmp.zW24TNYnHT (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

271

Created /tmp/tmp.MIl0qLcMMZ (size 1 KB) containing data sent by client
Created /tmp/tmp.ij283Bo8TP (size 1 KB) containing data sent by server
Created /tmp/tmp.zynJLVtelz (size 1024 KB) containing data sent by client
Created /tmp/tmp.bUtPxAwrg6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.zynJLVtelz (size 128 KB) containing data sent by client
Created /tmp/tmp.bUtPxAwrg6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

272

Created /tmp/tmp.DSCqjdQRaK (size 1 KB) containing data sent by client
Created /tmp/tmp.MosMbIpwuZ (size 1 KB) containing data sent by server
Created /tmp/tmp.rT62w9MqWO (size 1024 KB) containing data sent by client
Created /tmp/tmp.ZJnDEejDid (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.rT62w9MqWO (size 128 KB) containing data sent by client
Created /tmp/tmp.ZJnDEejDid (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

273

Created /tmp/tmp.wEUNAoJOQ4 (size 1 KB) containing data sent by client
Created /tmp/tmp.Tmk7jeHzt2 (size 1 KB) containing data sent by server
Created /tmp/tmp.tltAftojJp (size 1024 KB) containing data sent by client
Created /tmp/tmp.8wYug3NCx6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.tltAftojJp (size 128 KB) containing data sent by client
Created /tmp/tmp.8wYug3NCx6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

274

Created /tmp/tmp.m9xbKuBNaH (size 1 KB) containing data sent by client
Created /tmp/tmp.kBwkrcNy8s (size 1 KB) containing data sent by server
Created /tmp/tmp.pfDT10DG2z (size 1024 KB) containing data sent by client
Created /tmp/tmp.ZgEobRU7n8 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.pfDT10DG2z (size 128 KB) containing data sent by client
Created /tmp/tmp.ZgEobRU7n8 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

275

Created /tmp/tmp.xAGQKXMb2I (size 1 KB) containing data sent by client
Created /tmp/tmp.ejSPdTk9EG (size 1 KB) containing data sent by server
Created /tmp/tmp.mxBDZHWTZD (size 1024 KB) containing data sent by client
Created /tmp/tmp.h5fJ5NCwpI (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.mxBDZHWTZD (size 128 KB) containing data sent by client
Created /tmp/tmp.h5fJ5NCwpI (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

276

Created /tmp/tmp.Xn1RbKWgsn (size 1 KB) containing data sent by client
Created /tmp/tmp.aOVg437Z4M (size 1 KB) containing data sent by server
Created /tmp/tmp.fekSgQNrEO (size 1024 KB) containing data sent by client
Created /tmp/tmp.vRu3J9apdE (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.fekSgQNrEO (size 128 KB) containing data sent by client
Created /tmp/tmp.vRu3J9apdE (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

277

Created /tmp/tmp.aHJSPwhhdA (size 1 KB) containing data sent by client
Created /tmp/tmp.pjOpFcHVSp (size 1 KB) containing data sent by server
Created /tmp/tmp.wyYkhe1inB (size 1024 KB) containing data sent by client
Created /tmp/tmp.nnu1RC3TGx (size 1024 KB) containing data sent by server
file received by server has inverted byte at 525686
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.wyYkhe1inB (size 128 KB) containing data sent by client
Created /tmp/tmp.nnu1RC3TGx (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

278

Created /tmp/tmp.HmsEVZFKnD (size 1 KB) containing data sent by client
Created /tmp/tmp.j62Aq0W0q3 (size 1 KB) containing data sent by server
Created /tmp/tmp.3hgVXhtior (size 1024 KB) containing data sent by client
Created /tmp/tmp.pyD1bQLzdu (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.3hgVXhtior (size 128 KB) containing data sent by client
Created /tmp/tmp.pyD1bQLzdu (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

279

Created /tmp/tmp.5xpHk2rx59 (size 1 KB) containing data sent by client
Created /tmp/tmp.TJ5aRSKtu9 (size 1 KB) containing data sent by server
Created /tmp/tmp.oZSmfPjTQV (size 1024 KB) containing data sent by client
Created /tmp/tmp.gSV8rSfS8i (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.oZSmfPjTQV (size 128 KB) containing data sent by client
Created /tmp/tmp.gSV8rSfS8i (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

280

Created /tmp/tmp.9pDlKSbgHf (size 1 KB) containing data sent by client
Created /tmp/tmp.tEUrd6E0VV (size 1 KB) containing data sent by server
Created /tmp/tmp.TmJ5Jxu5RS (size 1024 KB) containing data sent by client
Created /tmp/tmp.UqN6aIXQIq (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.TmJ5Jxu5RS (size 128 KB) containing data sent by client
Created /tmp/tmp.UqN6aIXQIq (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

281

Created /tmp/tmp.aajr1oil85 (size 1 KB) containing data sent by client
Created /tmp/tmp.krbKbfFTbw (size 1 KB) containing data sent by server
Created /tmp/tmp.1SYiXQAyXx (size 1024 KB) containing data sent by client
Created /tmp/tmp.XzkCBNBJES (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.1SYiXQAyXx (size 128 KB) containing data sent by client
Created /tmp/tmp.XzkCBNBJES (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

282

Created /tmp/tmp.00oodG2pVy (size 1 KB) containing data sent by client
Created /tmp/tmp.8JeiYfqC72 (size 1 KB) containing data sent by server
Created /tmp/tmp.D7YeUr2qcQ (size 1024 KB) containing data sent by client
Created /tmp/tmp.sFYaFyXkwv (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.D7YeUr2qcQ (size 128 KB) containing data sent by client
Created /tmp/tmp.sFYaFyXkwv (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

283

Created /tmp/tmp.HJ1coQdqii (size 1 KB) containing data sent by client
Created /tmp/tmp.qI9KprjsZ3 (size 1 KB) containing data sent by server
Created /tmp/tmp.LwNZ5dubtU (size 1024 KB) containing data sent by client
Created /tmp/tmp.0oBYQMYwDc (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.LwNZ5dubtU (size 128 KB) containing data sent by client
Created /tmp/tmp.0oBYQMYwDc (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

284

Created /tmp/tmp.Ocx3myDxbe (size 1 KB) containing data sent by client
Created /tmp/tmp.h2GJ3fxS3k (size 1 KB) containing data sent by server
Created /tmp/tmp.82yCRlkWOg (size 1024 KB) containing data sent by client
Created /tmp/tmp.4d5cTOdsyL (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.82yCRlkWOg (size 128 KB) containing data sent by client
Created /tmp/tmp.4d5cTOdsyL (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

285

Created /tmp/tmp.bEbyPuhV6O (size 1 KB) containing data sent by client
Created /tmp/tmp.WYNMDM40no (size 1 KB) containing data sent by server
Created /tmp/tmp.s7zGkfALxy (size 1024 KB) containing data sent by client
Created /tmp/tmp.x71ETIbp5q (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.s7zGkfALxy (size 128 KB) containing data sent by client
Created /tmp/tmp.x71ETIbp5q (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

286

Created /tmp/tmp.q0fs06rq3n (size 1 KB) containing data sent by client
Created /tmp/tmp.QUuthFn1X1 (size 1 KB) containing data sent by server
Created /tmp/tmp.Y1uok9kO6U (size 1024 KB) containing data sent by client
Created /tmp/tmp.gxZ3nXemhT (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Y1uok9kO6U (size 128 KB) containing data sent by client
Created /tmp/tmp.gxZ3nXemhT (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

287

Created /tmp/tmp.ZiHaf3BJE4 (size 1 KB) containing data sent by client
Created /tmp/tmp.LNvdwXGMXi (size 1 KB) containing data sent by server
Created /tmp/tmp.7cunHndnmh (size 1024 KB) containing data sent by client
Created /tmp/tmp.du2VG6am2t (size 1024 KB) containing data sent by server
file received by server has inverted byte at 122949
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.7cunHndnmh (size 128 KB) containing data sent by client
Created /tmp/tmp.du2VG6am2t (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

288

Created /tmp/tmp.od4HnHpzoM (size 1 KB) containing data sent by client
Created /tmp/tmp.tBINcHagJG (size 1 KB) containing data sent by server
Created /tmp/tmp.SkuL3S1LjN (size 1024 KB) containing data sent by client
Created /tmp/tmp.cF1bblWxKe (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.SkuL3S1LjN (size 128 KB) containing data sent by client
Created /tmp/tmp.cF1bblWxKe (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

289

Created /tmp/tmp.jAyb4zocYR (size 1 KB) containing data sent by client
Created /tmp/tmp.eHD1UJ8S0h (size 1 KB) containing data sent by server
Created /tmp/tmp.FjINuVPJu5 (size 1024 KB) containing data sent by client
Created /tmp/tmp.bcvdSUCcf0 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 662529
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.FjINuVPJu5 (size 128 KB) containing data sent by client
Created /tmp/tmp.bcvdSUCcf0 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

290

Created /tmp/tmp.b5UG8tUDe1 (size 1 KB) containing data sent by client
Created /tmp/tmp.QZeWGqTH0I (size 1 KB) containing data sent by server
Created /tmp/tmp.YL7ifFLNra (size 1024 KB) containing data sent by client
Created /tmp/tmp.xA8QYMJXG0 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.YL7ifFLNra (size 128 KB) containing data sent by client
Created /tmp/tmp.xA8QYMJXG0 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

291

Created /tmp/tmp.gXAzdRnOUK (size 1 KB) containing data sent by client
Created /tmp/tmp.HZDnBBbNQy (size 1 KB) containing data sent by server
Created /tmp/tmp.fxV5dGVrFP (size 1024 KB) containing data sent by client
Created /tmp/tmp.AWLihK2UXV (size 1024 KB) containing data sent by server
file received by server has inverted byte at 129803
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.fxV5dGVrFP (size 128 KB) containing data sent by client
Created /tmp/tmp.AWLihK2UXV (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 4 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

292

Created /tmp/tmp.xGVGjcd9YE (size 1 KB) containing data sent by client
Created /tmp/tmp.8ZuLv2KXzc (size 1 KB) containing data sent by server
Created /tmp/tmp.Yd9CE1bihO (size 1024 KB) containing data sent by client
Created /tmp/tmp.M8w9l592yl (size 1024 KB) containing data sent by server
file received by server has inverted byte at 531457
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Yd9CE1bihO (size 128 KB) containing data sent by client
Created /tmp/tmp.M8w9l592yl (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

293

Created /tmp/tmp.Lx4f08LjfW (size 1 KB) containing data sent by client
Created /tmp/tmp.QWS8ayU9hV (size 1 KB) containing data sent by server
Created /tmp/tmp.zjNBu9mHIm (size 1024 KB) containing data sent by client
Created /tmp/tmp.8w462AgktG (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.zjNBu9mHIm (size 128 KB) containing data sent by client
Created /tmp/tmp.8w462AgktG (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

294

Created /tmp/tmp.6Y5AR7VcvY (size 1 KB) containing data sent by client
Created /tmp/tmp.kQjPBL6985 (size 1 KB) containing data sent by server
Created /tmp/tmp.knPo6twAIc (size 1024 KB) containing data sent by client
Created /tmp/tmp.EIvoA4bPyC (size 1024 KB) containing data sent by server
file received by server has inverted byte at 531457
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.knPo6twAIc (size 128 KB) containing data sent by client
Created /tmp/tmp.EIvoA4bPyC (size 128 KB) containing data sent by server
file received by server has inverted byte at 149
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

295

Created /tmp/tmp.4vRP4SVxbH (size 1 KB) containing data sent by client
Created /tmp/tmp.T5hzYAX6Yi (size 1 KB) containing data sent by server
Created /tmp/tmp.8YyzEx4scg (size 1024 KB) containing data sent by client
Created /tmp/tmp.wxNbrJrBFW (size 1024 KB) containing data sent by server
001 MP_FAIL MP_RST: retry 1
Created /tmp/tmp.8YyzEx4scg (size 1024 KB) containing data sent by client
Created /tmp/tmp.wxNbrJrBFW (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
002 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.8YyzEx4scg (size 128 KB) containing data sent by client
Created /tmp/tmp.wxNbrJrBFW (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
003 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

296

Created /tmp/tmp.l67K0njGa4 (size 1 KB) containing data sent by client
Created /tmp/tmp.4Azn4scmm7 (size 1 KB) containing data sent by server
Created /tmp/tmp.jGYNqZ4XJc (size 1024 KB) containing data sent by client
Created /tmp/tmp.vtznzfhk9p (size 1024 KB) containing data sent by server
file received by server has inverted byte at 793601
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jGYNqZ4XJc (size 128 KB) containing data sent by client
Created /tmp/tmp.vtznzfhk9p (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

297

Created /tmp/tmp.BQLiIdrNaJ (size 1 KB) containing data sent by client
Created /tmp/tmp.vHSDfqjirl (size 1 KB) containing data sent by server
Created /tmp/tmp.jkEPzfWJp2 (size 1024 KB) containing data sent by client
Created /tmp/tmp.1b06b7WAev (size 1024 KB) containing data sent by server
001 MP_FAIL MP_RST: retry 1
Created /tmp/tmp.jkEPzfWJp2 (size 1024 KB) containing data sent by client
Created /tmp/tmp.1b06b7WAev (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
002 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jkEPzfWJp2 (size 128 KB) containing data sent by client
Created /tmp/tmp.1b06b7WAev (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
003 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

298

Created /tmp/tmp.MmRKZbRABh (size 1 KB) containing data sent by client
Created /tmp/tmp.6SypEkzXOX (size 1 KB) containing data sent by server
Created /tmp/tmp.Ib68iJJbST (size 1024 KB) containing data sent by client
Created /tmp/tmp.0USjfwrAws (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Ib68iJJbST (size 128 KB) containing data sent by client
Created /tmp/tmp.0USjfwrAws (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

299

Created /tmp/tmp.5noH5v9JDm (size 1 KB) containing data sent by client
Created /tmp/tmp.mYxoOWDJh7 (size 1 KB) containing data sent by server
Created /tmp/tmp.mdx0dsM34Z (size 1024 KB) containing data sent by client
Created /tmp/tmp.SzsvuRfh5E (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.mdx0dsM34Z (size 128 KB) containing data sent by client
Created /tmp/tmp.SzsvuRfh5E (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

300

Created /tmp/tmp.pXmEHmIt1C (size 1 KB) containing data sent by client
Created /tmp/tmp.uaWcwkOB4H (size 1 KB) containing data sent by server
Created /tmp/tmp.Wi0KWv7oQC (size 1024 KB) containing data sent by client
Created /tmp/tmp.5pVXTGeRaH (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Wi0KWv7oQC (size 128 KB) containing data sent by client
Created /tmp/tmp.5pVXTGeRaH (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

301

Created /tmp/tmp.DZ06yXTywz (size 1 KB) containing data sent by client
Created /tmp/tmp.Ol8Wkrq9yG (size 1 KB) containing data sent by server
Created /tmp/tmp.nzlHy9voY7 (size 1024 KB) containing data sent by client
Created /tmp/tmp.v31quHY3VF (size 1024 KB) containing data sent by server
file received by server has inverted byte at 465921
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.nzlHy9voY7 (size 128 KB) containing data sent by client
Created /tmp/tmp.v31quHY3VF (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

302

Created /tmp/tmp.kPyLDEmFRH (size 1 KB) containing data sent by client
Created /tmp/tmp.lUdKcjPM1K (size 1 KB) containing data sent by server
Created /tmp/tmp.AAcaMmgQpt (size 1024 KB) containing data sent by client
Created /tmp/tmp.0ygc7rrGAR (size 1024 KB) containing data sent by server
file received by server has inverted byte at 130049
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.AAcaMmgQpt (size 128 KB) containing data sent by client
Created /tmp/tmp.0ygc7rrGAR (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

303

Created /tmp/tmp.7Pg7oRKJ2a (size 1 KB) containing data sent by client
Created /tmp/tmp.t4IPMgR1b2 (size 1 KB) containing data sent by server
Created /tmp/tmp.HFsiVEF1s4 (size 1024 KB) containing data sent by client
Created /tmp/tmp.Pq7TKPVeAY (size 1024 KB) containing data sent by server
file received by server has inverted byte at 261121
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.HFsiVEF1s4 (size 128 KB) containing data sent by client
Created /tmp/tmp.Pq7TKPVeAY (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

304

Created /tmp/tmp.SrfTJ2yE5U (size 1 KB) containing data sent by client
Created /tmp/tmp.OhGBgVuQSp (size 1 KB) containing data sent by server
Created /tmp/tmp.MSRhOX7FE0 (size 1024 KB) containing data sent by client
Created /tmp/tmp.hq1jeH1h1m (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.MSRhOX7FE0 (size 128 KB) containing data sent by client
Created /tmp/tmp.hq1jeH1h1m (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

305

Created /tmp/tmp.WLo3XhuSn1 (size 1 KB) containing data sent by client
Created /tmp/tmp.DEl0WAEdSW (size 1 KB) containing data sent by server
Created /tmp/tmp.xHgyzBgPIw (size 1024 KB) containing data sent by client
Created /tmp/tmp.kDlaQz5Pl3 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.xHgyzBgPIw (size 128 KB) containing data sent by client
Created /tmp/tmp.kDlaQz5Pl3 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

306

Created /tmp/tmp.6n8TuhkeNF (size 1 KB) containing data sent by client
Created /tmp/tmp.d3KAwUSlBx (size 1 KB) containing data sent by server
Created /tmp/tmp.fdkba4qPgw (size 1024 KB) containing data sent by client
Created /tmp/tmp.k6Y2eYkpRh (size 1024 KB) containing data sent by server
file received by server has inverted byte at 68857
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.fdkba4qPgw (size 128 KB) containing data sent by client
Created /tmp/tmp.k6Y2eYkpRh (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

307

Created /tmp/tmp.3BlwOlPC5S (size 1 KB) containing data sent by client
Created /tmp/tmp.fgDLSpfdTY (size 1 KB) containing data sent by server
Created /tmp/tmp.Dq7UJcKlAe (size 1024 KB) containing data sent by client
Created /tmp/tmp.0jvl98f5Ga (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Dq7UJcKlAe (size 128 KB) containing data sent by client
Created /tmp/tmp.0jvl98f5Ga (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

308

Created /tmp/tmp.AGPu6GGq2n (size 1 KB) containing data sent by client
Created /tmp/tmp.6OBgdBDWXT (size 1 KB) containing data sent by server
Created /tmp/tmp.LVOQHp7mQK (size 1024 KB) containing data sent by client
Created /tmp/tmp.RWV3UyDj30 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 261121
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.LVOQHp7mQK (size 128 KB) containing data sent by client
Created /tmp/tmp.RWV3UyDj30 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

309

Created /tmp/tmp.olu1sD33YN (size 1 KB) containing data sent by client
Created /tmp/tmp.AZrV1WbIHq (size 1 KB) containing data sent by server
Created /tmp/tmp.LLUfgF4RhS (size 1024 KB) containing data sent by client
Created /tmp/tmp.VGlkhbjSaQ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 596993
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.LLUfgF4RhS (size 128 KB) containing data sent by client
Created /tmp/tmp.VGlkhbjSaQ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

310

Created /tmp/tmp.UPnqtmryDQ (size 1 KB) containing data sent by client
Created /tmp/tmp.BLdqqlgQRk (size 1 KB) containing data sent by server
Created /tmp/tmp.waPvpXuj18 (size 1024 KB) containing data sent by client
Created /tmp/tmp.gxt7fh8KZS (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.waPvpXuj18 (size 128 KB) containing data sent by client
Created /tmp/tmp.gxt7fh8KZS (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

311

Created /tmp/tmp.CiqgIZfFbt (size 1 KB) containing data sent by client
Created /tmp/tmp.jtunxMpElN (size 1 KB) containing data sent by server
Created /tmp/tmp.TCdFqAD8G8 (size 1024 KB) containing data sent by client
Created /tmp/tmp.K0DJRGvErq (size 1024 KB) containing data sent by server
file received by server has inverted byte at 263387
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.TCdFqAD8G8 (size 128 KB) containing data sent by client
Created /tmp/tmp.K0DJRGvErq (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

312

Created /tmp/tmp.Mr5WTwlkpQ (size 1 KB) containing data sent by client
Created /tmp/tmp.E8Rgkb3GQw (size 1 KB) containing data sent by server
Created /tmp/tmp.KbRdtOKabl (size 1024 KB) containing data sent by client
Created /tmp/tmp.XOaonQha7D (size 1024 KB) containing data sent by server
file received by server has inverted byte at 393572
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.KbRdtOKabl (size 128 KB) containing data sent by client
Created /tmp/tmp.XOaonQha7D (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

313

Created /tmp/tmp.2Tmid31PgP (size 1 KB) containing data sent by client
Created /tmp/tmp.tFBCFzMJq6 (size 1 KB) containing data sent by server
Created /tmp/tmp.XfACaRTQao (size 1024 KB) containing data sent by client
Created /tmp/tmp.3McS37w1Kt (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.XfACaRTQao (size 128 KB) containing data sent by client
Created /tmp/tmp.3McS37w1Kt (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

314

Created /tmp/tmp.rwyVIZgRdy (size 1 KB) containing data sent by client
Created /tmp/tmp.eX4Y4o0Z5F (size 1 KB) containing data sent by server
Created /tmp/tmp.419Rdql640 (size 1024 KB) containing data sent by client
Created /tmp/tmp.JSS6Mm6VXv (size 1024 KB) containing data sent by server
file received by server has inverted byte at 130049
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.419Rdql640 (size 128 KB) containing data sent by client
Created /tmp/tmp.JSS6Mm6VXv (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

315

Created /tmp/tmp.TFV7bFpVYB (size 1 KB) containing data sent by client
Created /tmp/tmp.gLg7yIjsUh (size 1 KB) containing data sent by server
Created /tmp/tmp.THNpRWivIW (size 1024 KB) containing data sent by client
Created /tmp/tmp.yN4b5Ujzga (size 1024 KB) containing data sent by server
file received by server has inverted byte at 185200
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.THNpRWivIW (size 128 KB) containing data sent by client
Created /tmp/tmp.yN4b5Ujzga (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

316

Created /tmp/tmp.0KtyWKW1Sn (size 1 KB) containing data sent by client
Created /tmp/tmp.TX1fqaUBPr (size 1 KB) containing data sent by server
Created /tmp/tmp.EWUGOLym82 (size 1024 KB) containing data sent by client
Created /tmp/tmp.YwnBDVFDwu (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.EWUGOLym82 (size 128 KB) containing data sent by client
Created /tmp/tmp.YwnBDVFDwu (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

317

Created /tmp/tmp.qLcBtKsOaJ (size 1 KB) containing data sent by client
Created /tmp/tmp.k2U2QXa7tR (size 1 KB) containing data sent by server
Created /tmp/tmp.GNtk97cxbM (size 1024 KB) containing data sent by client
Created /tmp/tmp.a65nkSTS4A (size 1024 KB) containing data sent by server
file received by server has inverted byte at 854187
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.GNtk97cxbM (size 128 KB) containing data sent by client
Created /tmp/tmp.a65nkSTS4A (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

318

Created /tmp/tmp.DwM4xs0QK9 (size 1 KB) containing data sent by client
Created /tmp/tmp.H7v5PAHdM0 (size 1 KB) containing data sent by server
Created /tmp/tmp.4JAX8JAIma (size 1024 KB) containing data sent by client
Created /tmp/tmp.WBr6wJD5tK (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.4JAX8JAIma (size 128 KB) containing data sent by client
Created /tmp/tmp.WBr6wJD5tK (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

319

Created /tmp/tmp.rjO3bzfeie (size 1 KB) containing data sent by client
Created /tmp/tmp.uQTehfEjAz (size 1 KB) containing data sent by server
Created /tmp/tmp.exrVQ8BXms (size 1024 KB) containing data sent by client
Created /tmp/tmp.qxoMwk2Iij (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.exrVQ8BXms (size 128 KB) containing data sent by client
Created /tmp/tmp.qxoMwk2Iij (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

320

Created /tmp/tmp.BcBF0qX0xb (size 1 KB) containing data sent by client
Created /tmp/tmp.54I1XOJvSK (size 1 KB) containing data sent by server
Created /tmp/tmp.cnataf496s (size 1024 KB) containing data sent by client
Created /tmp/tmp.r3buixW7OW (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.cnataf496s (size 128 KB) containing data sent by client
Created /tmp/tmp.r3buixW7OW (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

321

Created /tmp/tmp.cxwvK8bURm (size 1 KB) containing data sent by client
Created /tmp/tmp.KJRJL9BICD (size 1 KB) containing data sent by server
Created /tmp/tmp.ZofAhRhmdc (size 1024 KB) containing data sent by client
Created /tmp/tmp.eAE6HnXljP (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ZofAhRhmdc (size 128 KB) containing data sent by client
Created /tmp/tmp.eAE6HnXljP (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

322

Created /tmp/tmp.IzOPVRbx9Z (size 1 KB) containing data sent by client
Created /tmp/tmp.imXtyksmFJ (size 1 KB) containing data sent by server
Created /tmp/tmp.MEttmovBGD (size 1024 KB) containing data sent by client
Created /tmp/tmp.MbNjAOgH7k (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.MEttmovBGD (size 128 KB) containing data sent by client
Created /tmp/tmp.MbNjAOgH7k (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

323

Created /tmp/tmp.vQxOUovepS (size 1 KB) containing data sent by client
Created /tmp/tmp.pHtRs27A7g (size 1 KB) containing data sent by server
Created /tmp/tmp.QUkQ3Yfm39 (size 1024 KB) containing data sent by client
Created /tmp/tmp.r8gazw7pCv (size 1024 KB) containing data sent by server
file received by server has inverted byte at 326657
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.QUkQ3Yfm39 (size 128 KB) containing data sent by client
Created /tmp/tmp.r8gazw7pCv (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

324

Created /tmp/tmp.IMcns0cDtV (size 1 KB) containing data sent by client
Created /tmp/tmp.lby84t97Ke (size 1 KB) containing data sent by server
Created /tmp/tmp.Bs2RZ1SKe8 (size 1024 KB) containing data sent by client
Created /tmp/tmp.N3Vu0ivLiL (size 1024 KB) containing data sent by server
file received by server has inverted byte at 134263
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Bs2RZ1SKe8 (size 128 KB) containing data sent by client
Created /tmp/tmp.N3Vu0ivLiL (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

325

Created /tmp/tmp.Ps9OJylOrW (size 1 KB) containing data sent by client
Created /tmp/tmp.k8baX6kV0X (size 1 KB) containing data sent by server
Created /tmp/tmp.jwePS2cc6M (size 1024 KB) containing data sent by client
Created /tmp/tmp.o74SML5fMw (size 1024 KB) containing data sent by server
file received by server has inverted byte at 596993
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jwePS2cc6M (size 128 KB) containing data sent by client
Created /tmp/tmp.o74SML5fMw (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

326

Created /tmp/tmp.MFfuloKpiP (size 1 KB) containing data sent by client
Created /tmp/tmp.ab3c482fkd (size 1 KB) containing data sent by server
Created /tmp/tmp.vBYAit4FCI (size 1024 KB) containing data sent by client
Created /tmp/tmp.Q7JZ7FrtU5 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.vBYAit4FCI (size 128 KB) containing data sent by client
Created /tmp/tmp.Q7JZ7FrtU5 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

327

Created /tmp/tmp.bIeGk5oCcC (size 1 KB) containing data sent by client
Created /tmp/tmp.qaRKdROtmN (size 1 KB) containing data sent by server
Created /tmp/tmp.QTA16jh2rY (size 1024 KB) containing data sent by client
Created /tmp/tmp.24lFl0kYVr (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.QTA16jh2rY (size 128 KB) containing data sent by client
Created /tmp/tmp.24lFl0kYVr (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

328

Created /tmp/tmp.8CKt5CPVoO (size 1 KB) containing data sent by client
Created /tmp/tmp.C6suK3NVDi (size 1 KB) containing data sent by server
Created /tmp/tmp.RwCERnqPeU (size 1024 KB) containing data sent by client
Created /tmp/tmp.lakXSCxivu (size 1024 KB) containing data sent by server
file received by server has inverted byte at 728065
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.RwCERnqPeU (size 128 KB) containing data sent by client
Created /tmp/tmp.lakXSCxivu (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

329

Created /tmp/tmp.xanfWCcHK4 (size 1 KB) containing data sent by client
Created /tmp/tmp.B7RrYUc8DS (size 1 KB) containing data sent by server
Created /tmp/tmp.67jdPH0MBe (size 1024 KB) containing data sent by client
Created /tmp/tmp.AGlhVp7aOe (size 1024 KB) containing data sent by server
file received by server has inverted byte at 728065
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.67jdPH0MBe (size 128 KB) containing data sent by client
Created /tmp/tmp.AGlhVp7aOe (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

330

Created /tmp/tmp.SMAK1K9IUC (size 1 KB) containing data sent by client
Created /tmp/tmp.H9i5MToiUv (size 1 KB) containing data sent by server
Created /tmp/tmp.JjrcWUSY3K (size 1024 KB) containing data sent by client
Created /tmp/tmp.jCsc8oayzu (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.JjrcWUSY3K (size 128 KB) containing data sent by client
Created /tmp/tmp.jCsc8oayzu (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 4 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

331

Created /tmp/tmp.TJ5ReQD1XS (size 1 KB) containing data sent by client
Created /tmp/tmp.CihWcOBynr (size 1 KB) containing data sent by server
Created /tmp/tmp.WIUCMsiWKK (size 1024 KB) containing data sent by client
Created /tmp/tmp.0oM821nj9R (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.WIUCMsiWKK (size 128 KB) containing data sent by client
Created /tmp/tmp.0oM821nj9R (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

332

Created /tmp/tmp.MjM4shmCGK (size 1 KB) containing data sent by client
Created /tmp/tmp.Dmha0qGD1Q (size 1 KB) containing data sent by server
Created /tmp/tmp.d82WHIYRKH (size 1024 KB) containing data sent by client
Created /tmp/tmp.EwpEE89BzM (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.d82WHIYRKH (size 128 KB) containing data sent by client
Created /tmp/tmp.EwpEE89BzM (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 4 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

333

Created /tmp/tmp.9NLeHOWv2p (size 1 KB) containing data sent by client
Created /tmp/tmp.auK51EgFLP (size 1 KB) containing data sent by server
Created /tmp/tmp.Wx0VXKzwO7 (size 1024 KB) containing data sent by client
Created /tmp/tmp.pCRQayrxme (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Wx0VXKzwO7 (size 128 KB) containing data sent by client
Created /tmp/tmp.pCRQayrxme (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

334

Created /tmp/tmp.8yq7DaBSZd (size 1 KB) containing data sent by client
Created /tmp/tmp.5dynIIA43I (size 1 KB) containing data sent by server
Created /tmp/tmp.0fsMQ4xIbX (size 1024 KB) containing data sent by client
Created /tmp/tmp.bThIkN1Xeh (size 1024 KB) containing data sent by server
file received by server has inverted byte at 130049
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.0fsMQ4xIbX (size 128 KB) containing data sent by client
Created /tmp/tmp.bThIkN1Xeh (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

335

Created /tmp/tmp.NfFp2uAmOD (size 1 KB) containing data sent by client
Created /tmp/tmp.96QnsflbbT (size 1 KB) containing data sent by server
Created /tmp/tmp.K09kW24r6u (size 1024 KB) containing data sent by client
Created /tmp/tmp.3alpKvfEhV (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.K09kW24r6u (size 128 KB) containing data sent by client
Created /tmp/tmp.3alpKvfEhV (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

336

Created /tmp/tmp.XmhWA8okCp (size 1 KB) containing data sent by client
Created /tmp/tmp.u21fsEytCL (size 1 KB) containing data sent by server
Created /tmp/tmp.s3OboaVipo (size 1024 KB) containing data sent by client
Created /tmp/tmp.lZRAVq9hx2 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 131141
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.s3OboaVipo (size 128 KB) containing data sent by client
Created /tmp/tmp.lZRAVq9hx2 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

337

Created /tmp/tmp.qZrhiq2unN (size 1 KB) containing data sent by client
Created /tmp/tmp.Huo4Hx4YSP (size 1 KB) containing data sent by server
Created /tmp/tmp.PtHfSw6HJZ (size 1024 KB) containing data sent by client
Created /tmp/tmp.8DVPQS9TSX (size 1024 KB) containing data sent by server
file received by server has inverted byte at 261121
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.PtHfSw6HJZ (size 128 KB) containing data sent by client
Created /tmp/tmp.8DVPQS9TSX (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

338

Created /tmp/tmp.EVPiu97KAK (size 1 KB) containing data sent by client
Created /tmp/tmp.zt5ULUvDr3 (size 1 KB) containing data sent by server
Created /tmp/tmp.uCCS9bVgZH (size 1024 KB) containing data sent by client
Created /tmp/tmp.FmUA7uteiu (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.uCCS9bVgZH (size 128 KB) containing data sent by client
Created /tmp/tmp.FmUA7uteiu (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

339

Created /tmp/tmp.rQmDl4bXi5 (size 1 KB) containing data sent by client
Created /tmp/tmp.shY6EqwcEx (size 1 KB) containing data sent by server
Created /tmp/tmp.WRRwffshxF (size 1024 KB) containing data sent by client
Created /tmp/tmp.lU0vGUmG8j (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.WRRwffshxF (size 128 KB) containing data sent by client
Created /tmp/tmp.lU0vGUmG8j (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

340

Created /tmp/tmp.opLVQWtTgj (size 1 KB) containing data sent by client
Created /tmp/tmp.tMGfb3xC9l (size 1 KB) containing data sent by server
Created /tmp/tmp.3V9I18BEoi (size 1024 KB) containing data sent by client
Created /tmp/tmp.lyWKGyRcdJ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 400385
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.3V9I18BEoi (size 128 KB) containing data sent by client
Created /tmp/tmp.lyWKGyRcdJ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

341

Created /tmp/tmp.gpyXhx7L8g (size 1 KB) containing data sent by client
Created /tmp/tmp.rQtntclw5v (size 1 KB) containing data sent by server
Created /tmp/tmp.AOVrZX4APh (size 1024 KB) containing data sent by client
Created /tmp/tmp.aMSkNZa56f (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.AOVrZX4APh (size 128 KB) containing data sent by client
Created /tmp/tmp.aMSkNZa56f (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

342

Created /tmp/tmp.oH46i971xq (size 1 KB) containing data sent by client
Created /tmp/tmp.iSYW9P94Jk (size 1 KB) containing data sent by server
Created /tmp/tmp.TShmLInehi (size 1024 KB) containing data sent by client
Created /tmp/tmp.211DSrvYJM (size 1024 KB) containing data sent by server
file received by server has inverted byte at 400385
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.TShmLInehi (size 128 KB) containing data sent by client
Created /tmp/tmp.211DSrvYJM (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

343

Created /tmp/tmp.LLPqschK9E (size 1 KB) containing data sent by client
Created /tmp/tmp.mpcsshFuAL (size 1 KB) containing data sent by server
Created /tmp/tmp.feDo6SMJtI (size 1024 KB) containing data sent by client
Created /tmp/tmp.jfnQlpov7S (size 1024 KB) containing data sent by server
file received by server has inverted byte at 859137
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.feDo6SMJtI (size 128 KB) containing data sent by client
Created /tmp/tmp.jfnQlpov7S (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

344

Created /tmp/tmp.xfB4xxwbpO (size 1 KB) containing data sent by client
Created /tmp/tmp.HvCgQoBZUy (size 1 KB) containing data sent by server
Created /tmp/tmp.t3Be1o0l1O (size 1024 KB) containing data sent by client
Created /tmp/tmp.4YNhGmkdQB (size 1024 KB) containing data sent by server
file received by server has inverted byte at 106565
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.t3Be1o0l1O (size 128 KB) containing data sent by client
Created /tmp/tmp.4YNhGmkdQB (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

345

Created /tmp/tmp.FWM9xrJYKJ (size 1 KB) containing data sent by client
Created /tmp/tmp.hpCwlyZULo (size 1 KB) containing data sent by server
Created /tmp/tmp.CaTBWswGbm (size 1024 KB) containing data sent by client
Created /tmp/tmp.i9lHL1xx6t (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.CaTBWswGbm (size 128 KB) containing data sent by client
Created /tmp/tmp.i9lHL1xx6t (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

346

Created /tmp/tmp.Tx2gbuf5UB (size 1 KB) containing data sent by client
Created /tmp/tmp.MyxNGKNzPl (size 1 KB) containing data sent by server
Created /tmp/tmp.DJB65iuM6r (size 1024 KB) containing data sent by client
Created /tmp/tmp.siMttaiDfN (size 1024 KB) containing data sent by server
file received by server has inverted byte at 121857
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.DJB65iuM6r (size 128 KB) containing data sent by client
Created /tmp/tmp.siMttaiDfN (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

347

Created /tmp/tmp.hiG929C9Fl (size 1 KB) containing data sent by client
Created /tmp/tmp.zn6TFuP8E9 (size 1 KB) containing data sent by server
Created /tmp/tmp.ajv6LZiXsF (size 1024 KB) containing data sent by client
Created /tmp/tmp.ipAIlvIEDV (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ajv6LZiXsF (size 128 KB) containing data sent by client
Created /tmp/tmp.ipAIlvIEDV (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

348

Created /tmp/tmp.DmWab2Xsqi (size 1 KB) containing data sent by client
Created /tmp/tmp.L5Wq76ruCw (size 1 KB) containing data sent by server
Created /tmp/tmp.eDimpB2cSA (size 1024 KB) containing data sent by client
Created /tmp/tmp.PdeBBg22HM (size 1024 KB) containing data sent by server
file received by server has inverted byte at 268689
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.eDimpB2cSA (size 128 KB) containing data sent by client
Created /tmp/tmp.PdeBBg22HM (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

349

Created /tmp/tmp.lirpc39uB1 (size 1 KB) containing data sent by client
Created /tmp/tmp.T6QUsZqZkt (size 1 KB) containing data sent by server
Created /tmp/tmp.gq5K7j2nsT (size 1024 KB) containing data sent by client
Created /tmp/tmp.QCr2vM0e9L (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.gq5K7j2nsT (size 128 KB) containing data sent by client
Created /tmp/tmp.QCr2vM0e9L (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

350

Created /tmp/tmp.W5Qfwsok7C (size 1 KB) containing data sent by client
Created /tmp/tmp.X1cQbFRT41 (size 1 KB) containing data sent by server
Created /tmp/tmp.LduNbPVfj6 (size 1024 KB) containing data sent by client
Created /tmp/tmp.0jURgYncLo (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.LduNbPVfj6 (size 128 KB) containing data sent by client
Created /tmp/tmp.0jURgYncLo (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

351

Created /tmp/tmp.TX5OpP225k (size 1 KB) containing data sent by client
Created /tmp/tmp.C7T1s9gszb (size 1 KB) containing data sent by server
Created /tmp/tmp.783etEdgTv (size 1024 KB) containing data sent by client
Created /tmp/tmp.XCAx1ukBxB (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.783etEdgTv (size 128 KB) containing data sent by client
Created /tmp/tmp.XCAx1ukBxB (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

352

Created /tmp/tmp.Pme7wY8Wtp (size 1 KB) containing data sent by client
Created /tmp/tmp.Si0CkiuD68 (size 1 KB) containing data sent by server
Created /tmp/tmp.SJ3XKadW3L (size 1024 KB) containing data sent by client
Created /tmp/tmp.UULDzxE2YJ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.SJ3XKadW3L (size 128 KB) containing data sent by client
Created /tmp/tmp.UULDzxE2YJ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

353

Created /tmp/tmp.niibmQRhcr (size 1 KB) containing data sent by client
Created /tmp/tmp.LSTlVdmLej (size 1 KB) containing data sent by server
Created /tmp/tmp.ImPbsV6jw0 (size 1024 KB) containing data sent by client
Created /tmp/tmp.dfBEqvUY0o (size 1024 KB) containing data sent by server
file received by server has inverted byte at 261121
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ImPbsV6jw0 (size 128 KB) containing data sent by client
Created /tmp/tmp.dfBEqvUY0o (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

354

Created /tmp/tmp.Yh5sgyPi0R (size 1 KB) containing data sent by client
Created /tmp/tmp.KwHUzJDqpz (size 1 KB) containing data sent by server
Created /tmp/tmp.ikvKQCThih (size 1024 KB) containing data sent by client
Created /tmp/tmp.4h9R65oBaj (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ikvKQCThih (size 128 KB) containing data sent by client
Created /tmp/tmp.4h9R65oBaj (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

355

Created /tmp/tmp.foSH7K6FAf (size 1 KB) containing data sent by client
Created /tmp/tmp.JwAEda0fMw (size 1 KB) containing data sent by server
Created /tmp/tmp.vqcqEbkF27 (size 1024 KB) containing data sent by client
Created /tmp/tmp.MKVtjXAEqm (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.vqcqEbkF27 (size 128 KB) containing data sent by client
Created /tmp/tmp.MKVtjXAEqm (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

356

Created /tmp/tmp.KmEwT0Ud6g (size 1 KB) containing data sent by client
Created /tmp/tmp.fyHf7FkwBG (size 1 KB) containing data sent by server
Created /tmp/tmp.9Fce67rW41 (size 1024 KB) containing data sent by client
Created /tmp/tmp.r62NfeSwgb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 396655
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.9Fce67rW41 (size 128 KB) containing data sent by client
Created /tmp/tmp.r62NfeSwgb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

357

Created /tmp/tmp.f9jg8C11XR (size 1 KB) containing data sent by client
Created /tmp/tmp.VX1fsxOzPi (size 1 KB) containing data sent by server
Created /tmp/tmp.wQYR8MCj4d (size 1024 KB) containing data sent by client
Created /tmp/tmp.rVZg2ifW6Y (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.wQYR8MCj4d (size 128 KB) containing data sent by client
Created /tmp/tmp.rVZg2ifW6Y (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

358

Created /tmp/tmp.3iB3OWyIv7 (size 1 KB) containing data sent by client
Created /tmp/tmp.bMDicUNhqR (size 1 KB) containing data sent by server
Created /tmp/tmp.xOtsffabVW (size 1024 KB) containing data sent by client
Created /tmp/tmp.4ptRM9J804 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.xOtsffabVW (size 128 KB) containing data sent by client
Created /tmp/tmp.4ptRM9J804 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

359

Created /tmp/tmp.UgbKZVLzvj (size 1 KB) containing data sent by client
Created /tmp/tmp.cp4L83E7fe (size 1 KB) containing data sent by server
Created /tmp/tmp.Z9vHcqiTOh (size 1024 KB) containing data sent by client
Created /tmp/tmp.z57pwiwgGM (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Z9vHcqiTOh (size 128 KB) containing data sent by client
Created /tmp/tmp.z57pwiwgGM (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

360

Created /tmp/tmp.TRe8xKGLKP (size 1 KB) containing data sent by client
Created /tmp/tmp.YuGnuJTWaQ (size 1 KB) containing data sent by server
Created /tmp/tmp.qbTQIxaLcH (size 1024 KB) containing data sent by client
Created /tmp/tmp.E168nkmKmx (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qbTQIxaLcH (size 128 KB) containing data sent by client
Created /tmp/tmp.E168nkmKmx (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

361

Created /tmp/tmp.3Z8EPwQOgG (size 1 KB) containing data sent by client
Created /tmp/tmp.57EGYuIZFz (size 1 KB) containing data sent by server
Created /tmp/tmp.VSE5XY6WkL (size 1024 KB) containing data sent by client
Created /tmp/tmp.tIr5pQNt3l (size 1024 KB) containing data sent by server
file received by server has inverted byte at 457729
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.VSE5XY6WkL (size 128 KB) containing data sent by client
Created /tmp/tmp.tIr5pQNt3l (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

362

Created /tmp/tmp.mNijunA6O5 (size 1 KB) containing data sent by client
Created /tmp/tmp.qtxfEovu9e (size 1 KB) containing data sent by server
Created /tmp/tmp.BAc7lZV8AD (size 1024 KB) containing data sent by client
Created /tmp/tmp.0IDPwO2vk6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71966
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.BAc7lZV8AD (size 128 KB) containing data sent by client
Created /tmp/tmp.0IDPwO2vk6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

363

Created /tmp/tmp.53w1mDKiXK (size 1 KB) containing data sent by client
Created /tmp/tmp.Qiptt7woAZ (size 1 KB) containing data sent by server
Created /tmp/tmp.eGxRdbNnvu (size 1024 KB) containing data sent by client
Created /tmp/tmp.zDPZU0cBpE (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.eGxRdbNnvu (size 128 KB) containing data sent by client
Created /tmp/tmp.zDPZU0cBpE (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

364

Created /tmp/tmp.Kyx83hZuHB (size 1 KB) containing data sent by client
Created /tmp/tmp.c5nWTJHVoJ (size 1 KB) containing data sent by server
Created /tmp/tmp.Ci4liewtOa (size 1024 KB) containing data sent by client
Created /tmp/tmp.xYTbFa8Wnw (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Ci4liewtOa (size 128 KB) containing data sent by client
Created /tmp/tmp.xYTbFa8Wnw (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

365

Created /tmp/tmp.vBc1qPAseV (size 1 KB) containing data sent by client
Created /tmp/tmp.Q4Chtun18n (size 1 KB) containing data sent by server
Created /tmp/tmp.WmQmf2STWD (size 1024 KB) containing data sent by client
Created /tmp/tmp.aHuWwOQvsb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.WmQmf2STWD (size 128 KB) containing data sent by client
Created /tmp/tmp.aHuWwOQvsb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

366

Created /tmp/tmp.UEUaDcVsR9 (size 1 KB) containing data sent by client
Created /tmp/tmp.Mp0xluDc83 (size 1 KB) containing data sent by server
Created /tmp/tmp.4jVKX0Pa46 (size 1024 KB) containing data sent by client
Created /tmp/tmp.Lo1tuPo2q4 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.4jVKX0Pa46 (size 128 KB) containing data sent by client
Created /tmp/tmp.Lo1tuPo2q4 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

367

Created /tmp/tmp.tLJ1G3Jnli (size 1 KB) containing data sent by client
Created /tmp/tmp.VI4WSLMXxA (size 1 KB) containing data sent by server
Created /tmp/tmp.IlDCt5kFhc (size 1024 KB) containing data sent by client
Created /tmp/tmp.jRTn0bWO2E (size 1024 KB) containing data sent by server
file received by server has inverted byte at 318465
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.IlDCt5kFhc (size 128 KB) containing data sent by client
Created /tmp/tmp.jRTn0bWO2E (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

368

Created /tmp/tmp.PanqOds2Im (size 1 KB) containing data sent by client
Created /tmp/tmp.AEan1MPU0Y (size 1 KB) containing data sent by server
Created /tmp/tmp.YPM5o1aFHI (size 1024 KB) containing data sent by client
Created /tmp/tmp.Xl6pou7xjd (size 1024 KB) containing data sent by server
file received by server has inverted byte at 793601
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.YPM5o1aFHI (size 128 KB) containing data sent by client
Created /tmp/tmp.Xl6pou7xjd (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

369

Created /tmp/tmp.TPRb7UXzKj (size 1 KB) containing data sent by client
Created /tmp/tmp.Si96mSGnUP (size 1 KB) containing data sent by server
Created /tmp/tmp.TIxj7REBeM (size 1024 KB) containing data sent by client
Created /tmp/tmp.ADLzHgzQ30 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 785409
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.TIxj7REBeM (size 128 KB) containing data sent by client
Created /tmp/tmp.ADLzHgzQ30 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

370

Created /tmp/tmp.yv1u5Laikt (size 1 KB) containing data sent by client
Created /tmp/tmp.nIAuxPfdZN (size 1 KB) containing data sent by server
Created /tmp/tmp.vFHzXt9TlR (size 1024 KB) containing data sent by client
Created /tmp/tmp.Pk5DvHi7yx (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.vFHzXt9TlR (size 128 KB) containing data sent by client
Created /tmp/tmp.Pk5DvHi7yx (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

371

Created /tmp/tmp.ty5cHzEb9b (size 1 KB) containing data sent by client
Created /tmp/tmp.21lhGub8QI (size 1 KB) containing data sent by server
Created /tmp/tmp.34c3I2Dt1x (size 1024 KB) containing data sent by client
Created /tmp/tmp.cit3OqvNMf (size 1024 KB) containing data sent by server
file received by server has inverted byte at 195585
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.34c3I2Dt1x (size 128 KB) containing data sent by client
Created /tmp/tmp.cit3OqvNMf (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

372

Created /tmp/tmp.91mCMh8uYC (size 1 KB) containing data sent by client
Created /tmp/tmp.Plngiugt7k (size 1 KB) containing data sent by server
Created /tmp/tmp.YC5kkf6pcf (size 1024 KB) containing data sent by client
Created /tmp/tmp.ackWjjXyr4 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.YC5kkf6pcf (size 128 KB) containing data sent by client
Created /tmp/tmp.ackWjjXyr4 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 1 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

373

Created /tmp/tmp.EyThvFmUq2 (size 1 KB) containing data sent by client
Created /tmp/tmp.NXlySbsWRf (size 1 KB) containing data sent by server
Created /tmp/tmp.w12iCHD5Lv (size 1024 KB) containing data sent by client
Created /tmp/tmp.oZoqJg733X (size 1024 KB) containing data sent by server
file received by server has inverted byte at 396753
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.w12iCHD5Lv (size 128 KB) containing data sent by client
Created /tmp/tmp.oZoqJg733X (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

374

Created /tmp/tmp.Njbw3bfNMY (size 1 KB) containing data sent by client
Created /tmp/tmp.RUCPgwhUdO (size 1 KB) containing data sent by server
Created /tmp/tmp.ZCxEqQB23l (size 1024 KB) containing data sent by client
Created /tmp/tmp.UUAo6PHZ93 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ZCxEqQB23l (size 128 KB) containing data sent by client
Created /tmp/tmp.UUAo6PHZ93 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

375

Created /tmp/tmp.jmp1QC2Hrd (size 1 KB) containing data sent by client
Created /tmp/tmp.sJPnzaTAbH (size 1 KB) containing data sent by server
Created /tmp/tmp.NuzKsE4v4i (size 1024 KB) containing data sent by client
Created /tmp/tmp.ozwVif7E32 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 121857
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.NuzKsE4v4i (size 128 KB) containing data sent by client
Created /tmp/tmp.ozwVif7E32 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

376

Created /tmp/tmp.ekMdnyfzxK (size 1 KB) containing data sent by client
Created /tmp/tmp.gyuVXzdO4W (size 1 KB) containing data sent by server
Created /tmp/tmp.X1vUPp6h9l (size 1024 KB) containing data sent by client
Created /tmp/tmp.lCk6B1L7kQ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 191975
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.X1vUPp6h9l (size 128 KB) containing data sent by client
Created /tmp/tmp.lCk6B1L7kQ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

377

Created /tmp/tmp.9pnAyE4kk0 (size 1 KB) containing data sent by client
Created /tmp/tmp.GOPwOz9cT6 (size 1 KB) containing data sent by server
Created /tmp/tmp.u9f24lmisK (size 1024 KB) containing data sent by client
Created /tmp/tmp.zopCc2Pior (size 1024 KB) containing data sent by server
file received by server has inverted byte at 127173
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.u9f24lmisK (size 128 KB) containing data sent by client
Created /tmp/tmp.zopCc2Pior (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

378

Created /tmp/tmp.yIhyPGFySs (size 1 KB) containing data sent by client
Created /tmp/tmp.TknnkRLKTY (size 1 KB) containing data sent by server
Created /tmp/tmp.2JVz4IeYoA (size 1024 KB) containing data sent by client
Created /tmp/tmp.FlwZz3jQ7F (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.2JVz4IeYoA (size 128 KB) containing data sent by client
Created /tmp/tmp.FlwZz3jQ7F (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

379

Created /tmp/tmp.u7WqHTja2P (size 1 KB) containing data sent by client
Created /tmp/tmp.sT3YKJqTXF (size 1 KB) containing data sent by server
Created /tmp/tmp.GRr2UNWLQV (size 1024 KB) containing data sent by client
Created /tmp/tmp.CkVSiKAAXG (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.GRr2UNWLQV (size 128 KB) containing data sent by client
Created /tmp/tmp.CkVSiKAAXG (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

380

Created /tmp/tmp.WMITkEGpWR (size 1 KB) containing data sent by client
Created /tmp/tmp.rKUBGFhiZf (size 1 KB) containing data sent by server
Created /tmp/tmp.QwSAkuM6mh (size 1024 KB) containing data sent by client
Created /tmp/tmp.nTq2jIbC1Y (size 1024 KB) containing data sent by server
file received by server has inverted byte at 465921
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.QwSAkuM6mh (size 128 KB) containing data sent by client
Created /tmp/tmp.nTq2jIbC1Y (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

381

Created /tmp/tmp.cEB7h9BYep (size 1 KB) containing data sent by client
Created /tmp/tmp.W3YPyIWGdL (size 1 KB) containing data sent by server
Created /tmp/tmp.BvcRgvryXt (size 1024 KB) containing data sent by client
Created /tmp/tmp.2A8QVeqhWg (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.BvcRgvryXt (size 128 KB) containing data sent by client
Created /tmp/tmp.2A8QVeqhWg (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

382

Created /tmp/tmp.GEQ8rnoynf (size 1 KB) containing data sent by client
Created /tmp/tmp.jG5Sk4dKUI (size 1 KB) containing data sent by server
Created /tmp/tmp.z3AAlGnxUV (size 1024 KB) containing data sent by client
Created /tmp/tmp.S2vu5IeAW9 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 793601
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.z3AAlGnxUV (size 128 KB) containing data sent by client
Created /tmp/tmp.S2vu5IeAW9 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

383

Created /tmp/tmp.k9SlVeGuxZ (size 1 KB) containing data sent by client
Created /tmp/tmp.JnWOTApDad (size 1 KB) containing data sent by server
Created /tmp/tmp.YV7ZhKXlqg (size 1024 KB) containing data sent by client
Created /tmp/tmp.wHVvY2DKUS (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.YV7ZhKXlqg (size 128 KB) containing data sent by client
Created /tmp/tmp.wHVvY2DKUS (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

384

Created /tmp/tmp.F8yHdylLuk (size 1 KB) containing data sent by client
Created /tmp/tmp.UJ8BuvodxE (size 1 KB) containing data sent by server
Created /tmp/tmp.Mb8r3Qouor (size 1024 KB) containing data sent by client
Created /tmp/tmp.ywFvxjlwtK (size 1024 KB) containing data sent by server
file received by server has inverted byte at 523265
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Mb8r3Qouor (size 128 KB) containing data sent by client
Created /tmp/tmp.ywFvxjlwtK (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

385

Created /tmp/tmp.BWhVZHMGIx (size 1 KB) containing data sent by client
Created /tmp/tmp.sVn5dgbPHu (size 1 KB) containing data sent by server
Created /tmp/tmp.kKnhJj23bm (size 1024 KB) containing data sent by client
Created /tmp/tmp.mS6C10D5JV (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.kKnhJj23bm (size 128 KB) containing data sent by client
Created /tmp/tmp.mS6C10D5JV (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

386

Created /tmp/tmp.1tMV8COMCd (size 1 KB) containing data sent by client
Created /tmp/tmp.P83JdXD3El (size 1 KB) containing data sent by server
Created /tmp/tmp.lB9Jhta4T1 (size 1024 KB) containing data sent by client
Created /tmp/tmp.cVlTafqCLZ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 198609
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.lB9Jhta4T1 (size 128 KB) containing data sent by client
Created /tmp/tmp.cVlTafqCLZ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

387

Created /tmp/tmp.Y4EwmH9JCo (size 1 KB) containing data sent by client
Created /tmp/tmp.SD54B6E2zE (size 1 KB) containing data sent by server
Created /tmp/tmp.50lT6cfZAz (size 1024 KB) containing data sent by client
Created /tmp/tmp.MtfuawtNeJ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 531457
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.50lT6cfZAz (size 128 KB) containing data sent by client
Created /tmp/tmp.MtfuawtNeJ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

388

Created /tmp/tmp.a6Rzsw54DI (size 1 KB) containing data sent by client
Created /tmp/tmp.xGrhw0oWaA (size 1 KB) containing data sent by server
Created /tmp/tmp.qrARq8W31F (size 1024 KB) containing data sent by client
Created /tmp/tmp.efuRw3rQis (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65707
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qrARq8W31F (size 128 KB) containing data sent by client
Created /tmp/tmp.efuRw3rQis (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

389

Created /tmp/tmp.fOM12PXNyx (size 1 KB) containing data sent by client
Created /tmp/tmp.hFS5DVi77V (size 1 KB) containing data sent by server
Created /tmp/tmp.86O3nNsk3Q (size 1024 KB) containing data sent by client
Created /tmp/tmp.CEzGVibV4A (size 1024 KB) containing data sent by server
file received by server has inverted byte at 523265
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.86O3nNsk3Q (size 128 KB) containing data sent by client
Created /tmp/tmp.CEzGVibV4A (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

390

Created /tmp/tmp.mI7TCfIxUf (size 1 KB) containing data sent by client
Created /tmp/tmp.GyfDDYjo2p (size 1 KB) containing data sent by server
Created /tmp/tmp.UfWhIWuave (size 1024 KB) containing data sent by client
Created /tmp/tmp.JOzSkUywLB (size 1024 KB) containing data sent by server
file received by server has inverted byte at 924673
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.UfWhIWuave (size 128 KB) containing data sent by client
Created /tmp/tmp.JOzSkUywLB (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

391

Created /tmp/tmp.MSaLPA81J4 (size 1 KB) containing data sent by client
Created /tmp/tmp.JJpPNAtJPM (size 1 KB) containing data sent by server
Created /tmp/tmp.bZubxHJKVP (size 1024 KB) containing data sent by client
Created /tmp/tmp.fveds79xsG (size 1024 KB) containing data sent by server
file received by server has inverted byte at 195585
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.bZubxHJKVP (size 128 KB) containing data sent by client
Created /tmp/tmp.fveds79xsG (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

392

Created /tmp/tmp.QKT6dgil8U (size 1 KB) containing data sent by client
Created /tmp/tmp.mFoel6kdWr (size 1 KB) containing data sent by server
Created /tmp/tmp.jcUQSucfDm (size 1024 KB) containing data sent by client
Created /tmp/tmp.fbXvBL0C3e (size 1024 KB) containing data sent by server
file received by server has inverted byte at 122949
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jcUQSucfDm (size 128 KB) containing data sent by client
Created /tmp/tmp.fbXvBL0C3e (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

393

Created /tmp/tmp.0JaXwIvQRm (size 1 KB) containing data sent by client
Created /tmp/tmp.BUt9lk2GEe (size 1 KB) containing data sent by server
Created /tmp/tmp.fL5VBLN52w (size 1024 KB) containing data sent by client
Created /tmp/tmp.jgd5mwW43b (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.fL5VBLN52w (size 128 KB) containing data sent by client
Created /tmp/tmp.jgd5mwW43b (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

394

Created /tmp/tmp.SO5kZ55LV4 (size 1 KB) containing data sent by client
Created /tmp/tmp.vzalurM2vA (size 1 KB) containing data sent by server
Created /tmp/tmp.zJKwr5QOOC (size 1024 KB) containing data sent by client
Created /tmp/tmp.gaNs5oQNBF (size 1024 KB) containing data sent by server
file received by server has inverted byte at 596993
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.zJKwr5QOOC (size 128 KB) containing data sent by client
Created /tmp/tmp.gaNs5oQNBF (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

395

Created /tmp/tmp.kKatExrv9Q (size 1 KB) containing data sent by client
Created /tmp/tmp.Enur506hfh (size 1 KB) containing data sent by server
Created /tmp/tmp.U2WWX92BJr (size 1024 KB) containing data sent by client
Created /tmp/tmp.c9LyZkjZMR (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.U2WWX92BJr (size 128 KB) containing data sent by client
Created /tmp/tmp.c9LyZkjZMR (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

396

Created /tmp/tmp.QW8lcxdUGS (size 1 KB) containing data sent by client
Created /tmp/tmp.B6Jjzxh7Lx (size 1 KB) containing data sent by server
Created /tmp/tmp.hLQwsTghRE (size 1024 KB) containing data sent by client
Created /tmp/tmp.V4tHxwNVml (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.hLQwsTghRE (size 128 KB) containing data sent by client
Created /tmp/tmp.V4tHxwNVml (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

397

Created /tmp/tmp.u7xcCon2oW (size 1 KB) containing data sent by client
Created /tmp/tmp.Ep6t7qr1Ww (size 1 KB) containing data sent by server
Created /tmp/tmp.QFAlAjtK2o (size 1024 KB) containing data sent by client
Created /tmp/tmp.TnVX8RJrc7 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.QFAlAjtK2o (size 128 KB) containing data sent by client
Created /tmp/tmp.TnVX8RJrc7 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

398

Created /tmp/tmp.iWcNEyZ4Mx (size 1 KB) containing data sent by client
Created /tmp/tmp.YQKZluDLBW (size 1 KB) containing data sent by server
Created /tmp/tmp.rgoEQvtlL5 (size 1024 KB) containing data sent by client
Created /tmp/tmp.noei6OFNax (size 1024 KB) containing data sent by server
file received by server has inverted byte at 596993
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.rgoEQvtlL5 (size 128 KB) containing data sent by client
Created /tmp/tmp.noei6OFNax (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

399

Created /tmp/tmp.mgfrr4wlpF (size 1 KB) containing data sent by client
Created /tmp/tmp.WSrkaAbpPP (size 1 KB) containing data sent by server
Created /tmp/tmp.Cts4fUDQBx (size 1024 KB) containing data sent by client
Created /tmp/tmp.OYraMWGKuM (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Cts4fUDQBx (size 128 KB) containing data sent by client
Created /tmp/tmp.OYraMWGKuM (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

400

Created /tmp/tmp.qmWANEf44P (size 1 KB) containing data sent by client
Created /tmp/tmp.IxpOyTTz4F (size 1 KB) containing data sent by server
Created /tmp/tmp.kVlbxCJ1Lq (size 1024 KB) containing data sent by client
Created /tmp/tmp.eoKuTa6hKo (size 1024 KB) containing data sent by server
file received by server has inverted byte at 114757
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.kVlbxCJ1Lq (size 128 KB) containing data sent by client
Created /tmp/tmp.eoKuTa6hKo (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

401

Created /tmp/tmp.I0QQvUn40W (size 1 KB) containing data sent by client
Created /tmp/tmp.329XeGRsbH (size 1 KB) containing data sent by server
Created /tmp/tmp.XGILXpSmqp (size 1024 KB) containing data sent by client
Created /tmp/tmp.f1YKlsgYwr (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.XGILXpSmqp (size 128 KB) containing data sent by client
Created /tmp/tmp.f1YKlsgYwr (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

402

Created /tmp/tmp.kD4PM9e2xJ (size 1 KB) containing data sent by client
Created /tmp/tmp.vEG4f8MLvQ (size 1 KB) containing data sent by server
Created /tmp/tmp.LLP3nr964H (size 1024 KB) containing data sent by client
Created /tmp/tmp.GUY0ozRup6 (size 1024 KB) containing data sent by server
001 MP_FAIL MP_RST: retry 1
Created /tmp/tmp.LLP3nr964H (size 1024 KB) containing data sent by client
Created /tmp/tmp.GUY0ozRup6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 120512
002 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.LLP3nr964H (size 128 KB) containing data sent by client
Created /tmp/tmp.GUY0ozRup6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
003 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

403

Created /tmp/tmp.NK4Btvjvyt (size 1 KB) containing data sent by client
Created /tmp/tmp.2ye0FDIuFw (size 1 KB) containing data sent by server
Created /tmp/tmp.JVICOfpaQD (size 1024 KB) containing data sent by client
Created /tmp/tmp.oQLJlKdmNK (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.JVICOfpaQD (size 128 KB) containing data sent by client
Created /tmp/tmp.oQLJlKdmNK (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

404

Created /tmp/tmp.ohYCDQXNMC (size 1 KB) containing data sent by client
Created /tmp/tmp.Ipi1IWQr2H (size 1 KB) containing data sent by server
Created /tmp/tmp.Z6S8Db5yw4 (size 1024 KB) containing data sent by client
Created /tmp/tmp.pEAXhcaQkn (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Z6S8Db5yw4 (size 128 KB) containing data sent by client
Created /tmp/tmp.pEAXhcaQkn (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

405

Created /tmp/tmp.vy5VjzY2pE (size 1 KB) containing data sent by client
Created /tmp/tmp.uVEoLTbgUf (size 1 KB) containing data sent by server
Created /tmp/tmp.CVwErnHiOV (size 1024 KB) containing data sent by client
Created /tmp/tmp.GRTRKDk7X7 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.CVwErnHiOV (size 128 KB) containing data sent by client
Created /tmp/tmp.GRTRKDk7X7 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

406

Created /tmp/tmp.ZxCji9bdyq (size 1 KB) containing data sent by client
Created /tmp/tmp.ZbDGyqfeVi (size 1 KB) containing data sent by server
Created /tmp/tmp.zAy35h0VlM (size 1024 KB) containing data sent by client
Created /tmp/tmp.KEd2fAZr3E (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.zAy35h0VlM (size 128 KB) containing data sent by client
Created /tmp/tmp.KEd2fAZr3E (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

407

Created /tmp/tmp.VdyAZqGe2z (size 1 KB) containing data sent by client
Created /tmp/tmp.YGIV73anlr (size 1 KB) containing data sent by server
Created /tmp/tmp.Dn95F8cYEQ (size 1024 KB) containing data sent by client
Created /tmp/tmp.LbYOD1vkdF (size 1024 KB) containing data sent by server
file received by server has inverted byte at 400385
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Dn95F8cYEQ (size 128 KB) containing data sent by client
Created /tmp/tmp.LbYOD1vkdF (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

408

Created /tmp/tmp.K4PScQWQvj (size 1 KB) containing data sent by client
Created /tmp/tmp.9X21SOMMd2 (size 1 KB) containing data sent by server
Created /tmp/tmp.VU1gZBMPlx (size 1024 KB) containing data sent by client
Created /tmp/tmp.HC5gyAXi4Q (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.VU1gZBMPlx (size 128 KB) containing data sent by client
Created /tmp/tmp.HC5gyAXi4Q (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 4 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

409

Created /tmp/tmp.rHof44YjUh (size 1 KB) containing data sent by client
Created /tmp/tmp.sS0bwKFQBA (size 1 KB) containing data sent by server
Created /tmp/tmp.ux3uVtHwU1 (size 1024 KB) containing data sent by client
Created /tmp/tmp.uqmghMqych (size 1024 KB) containing data sent by server
file received by server has inverted byte at 131141
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ux3uVtHwU1 (size 128 KB) containing data sent by client
Created /tmp/tmp.uqmghMqych (size 128 KB) containing data sent by server
file received by server has inverted byte at 235
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

410

Created /tmp/tmp.gBZwc05BUH (size 1 KB) containing data sent by client
Created /tmp/tmp.WumOkZLrrS (size 1 KB) containing data sent by server
Created /tmp/tmp.UcS9ucDzMm (size 1024 KB) containing data sent by client
Created /tmp/tmp.aY07HrNMA9 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 531457
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.UcS9ucDzMm (size 128 KB) containing data sent by client
Created /tmp/tmp.aY07HrNMA9 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

411

Created /tmp/tmp.rWtFKfJkJM (size 1 KB) containing data sent by client
Created /tmp/tmp.G8oz0SecAk (size 1 KB) containing data sent by server
Created /tmp/tmp.mEei55pfnA (size 1024 KB) containing data sent by client
Created /tmp/tmp.MQfYmJBAEe (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.mEei55pfnA (size 128 KB) containing data sent by client
Created /tmp/tmp.MQfYmJBAEe (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

412

Created /tmp/tmp.Zcj9BQO9dk (size 1 KB) containing data sent by client
Created /tmp/tmp.6RoiBS38z5 (size 1 KB) containing data sent by server
Created /tmp/tmp.4YTNUu9RId (size 1024 KB) containing data sent by client
Created /tmp/tmp.NMCzOC94mr (size 1024 KB) containing data sent by server
file received by server has inverted byte at 859137
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.4YTNUu9RId (size 128 KB) containing data sent by client
Created /tmp/tmp.NMCzOC94mr (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

413

Created /tmp/tmp.BNnv4ZAjlt (size 1 KB) containing data sent by client
Created /tmp/tmp.YmwFyFrF0Y (size 1 KB) containing data sent by server
Created /tmp/tmp.X7FmKJRx0n (size 1024 KB) containing data sent by client
Created /tmp/tmp.ZTaPvkZxFr (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.X7FmKJRx0n (size 128 KB) containing data sent by client
Created /tmp/tmp.ZTaPvkZxFr (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

414

Created /tmp/tmp.Mhrq7KPKzK (size 1 KB) containing data sent by client
Created /tmp/tmp.lX3P1z9mvs (size 1 KB) containing data sent by server
Created /tmp/tmp.7tYjX1vTl7 (size 1024 KB) containing data sent by client
Created /tmp/tmp.XoJZFsGdmT (size 1024 KB) containing data sent by server
file received by server has inverted byte at 728065
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.7tYjX1vTl7 (size 128 KB) containing data sent by client
Created /tmp/tmp.XoJZFsGdmT (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

415

Created /tmp/tmp.NQfkUhQkR0 (size 1 KB) containing data sent by client
Created /tmp/tmp.fxFcdvx6Q6 (size 1 KB) containing data sent by server
Created /tmp/tmp.8vQ6oWjHHC (size 1024 KB) containing data sent by client
Created /tmp/tmp.cHSwQD1agW (size 1024 KB) containing data sent by server
file received by server has inverted byte at 318465
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.8vQ6oWjHHC (size 128 KB) containing data sent by client
Created /tmp/tmp.cHSwQD1agW (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 1 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

416

Created /tmp/tmp.MlhAEfMpOs (size 1 KB) containing data sent by client
Created /tmp/tmp.0QVLvi0l6n (size 1 KB) containing data sent by server
Created /tmp/tmp.k4EHk2IwRD (size 1024 KB) containing data sent by client
Created /tmp/tmp.jRm5HWRuAF (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.k4EHk2IwRD (size 128 KB) containing data sent by client
Created /tmp/tmp.jRm5HWRuAF (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

417

Created /tmp/tmp.CRGTfHOiGL (size 1 KB) containing data sent by client
Created /tmp/tmp.NOtpvJUPix (size 1 KB) containing data sent by server
Created /tmp/tmp.5Da3ez76kC (size 1024 KB) containing data sent by client
Created /tmp/tmp.nBKWvLZP9P (size 1024 KB) containing data sent by server
file received by server has inverted byte at 195585
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.5Da3ez76kC (size 128 KB) containing data sent by client
Created /tmp/tmp.nBKWvLZP9P (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 1 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

418

Created /tmp/tmp.zWsF1cFoh2 (size 1 KB) containing data sent by client
Created /tmp/tmp.W65v3KPUKw (size 1 KB) containing data sent by server
Created /tmp/tmp.0BvHbjckzL (size 1024 KB) containing data sent by client
Created /tmp/tmp.kb88rHC5Ec (size 1024 KB) containing data sent by server
file received by server has inverted byte at 121857
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.0BvHbjckzL (size 128 KB) containing data sent by client
Created /tmp/tmp.kb88rHC5Ec (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 3 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

419

Created /tmp/tmp.ulotHlEdER (size 1 KB) containing data sent by client
Created /tmp/tmp.JqrJCrhsWQ (size 1 KB) containing data sent by server
Created /tmp/tmp.aiYkYKvTL9 (size 1024 KB) containing data sent by client
Created /tmp/tmp.adl9XeH6Kw (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.aiYkYKvTL9 (size 128 KB) containing data sent by client
Created /tmp/tmp.adl9XeH6Kw (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

420

Created /tmp/tmp.JgvGLpRndz (size 1 KB) containing data sent by client
Created /tmp/tmp.Bn2w4KRg8o (size 1 KB) containing data sent by server
Created /tmp/tmp.nHIJ3wajCh (size 1024 KB) containing data sent by client
Created /tmp/tmp.FLfdCA9uze (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.nHIJ3wajCh (size 128 KB) containing data sent by client
Created /tmp/tmp.FLfdCA9uze (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

421

Created /tmp/tmp.8D9TBncu7F (size 1 KB) containing data sent by client
Created /tmp/tmp.KgR4bZyHtu (size 1 KB) containing data sent by server
Created /tmp/tmp.QccPlG69x7 (size 1024 KB) containing data sent by client
Created /tmp/tmp.iW6PCU2AKJ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.QccPlG69x7 (size 128 KB) containing data sent by client
Created /tmp/tmp.iW6PCU2AKJ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

422

Created /tmp/tmp.86GqtA0bYP (size 1 KB) containing data sent by client
Created /tmp/tmp.kOFXx1pMxE (size 1 KB) containing data sent by server
Created /tmp/tmp.wZNhAvuDpS (size 1024 KB) containing data sent by client
Created /tmp/tmp.3lfwNzsbQl (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.wZNhAvuDpS (size 128 KB) containing data sent by client
Created /tmp/tmp.3lfwNzsbQl (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

423

Created /tmp/tmp.umkR42xVmi (size 1 KB) containing data sent by client
Created /tmp/tmp.EpufhNCd21 (size 1 KB) containing data sent by server
Created /tmp/tmp.zix4y2gyGb (size 1024 KB) containing data sent by client
Created /tmp/tmp.lYWQqTfre9 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 329610
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.zix4y2gyGb (size 128 KB) containing data sent by client
Created /tmp/tmp.lYWQqTfre9 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

424

Created /tmp/tmp.maTLzNlEiY (size 1 KB) containing data sent by client
Created /tmp/tmp.yxg10e7mNh (size 1 KB) containing data sent by server
Created /tmp/tmp.OzmKmH779i (size 1024 KB) containing data sent by client
Created /tmp/tmp.TCE6bv7ypu (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.OzmKmH779i (size 128 KB) containing data sent by client
Created /tmp/tmp.TCE6bv7ypu (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

425

Created /tmp/tmp.njvCRljHnZ (size 1 KB) containing data sent by client
Created /tmp/tmp.TVPB5TPLRH (size 1 KB) containing data sent by server
Created /tmp/tmp.5yQ38LwIJd (size 1024 KB) containing data sent by client
Created /tmp/tmp.mSUw0CPAKn (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.5yQ38LwIJd (size 128 KB) containing data sent by client
Created /tmp/tmp.mSUw0CPAKn (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

426

Created /tmp/tmp.NUGMYsrWeD (size 1 KB) containing data sent by client
Created /tmp/tmp.DsLbgOBpzy (size 1 KB) containing data sent by server
Created /tmp/tmp.k8FkNZPEus (size 1024 KB) containing data sent by client
Created /tmp/tmp.y6kf8uTPP1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.k8FkNZPEus (size 128 KB) containing data sent by client
Created /tmp/tmp.y6kf8uTPP1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

427

Created /tmp/tmp.H5RBuHTcEa (size 1 KB) containing data sent by client
Created /tmp/tmp.TUrgF51EuY (size 1 KB) containing data sent by server
Created /tmp/tmp.s7nYVvbr4f (size 1024 KB) containing data sent by client
Created /tmp/tmp.VaXAXAlk6W (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.s7nYVvbr4f (size 128 KB) containing data sent by client
Created /tmp/tmp.VaXAXAlk6W (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 4 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

428

Created /tmp/tmp.2nuEpBE1lt (size 1 KB) containing data sent by client
Created /tmp/tmp.Awyc6WDvmE (size 1 KB) containing data sent by server
Created /tmp/tmp.ZN7j6QSOii (size 1024 KB) containing data sent by client
Created /tmp/tmp.mN4qGcw3r6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 465921
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ZN7j6QSOii (size 128 KB) containing data sent by client
Created /tmp/tmp.mN4qGcw3r6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

429

Created /tmp/tmp.QOjO3PZYhk (size 1 KB) containing data sent by client
Created /tmp/tmp.mxkqjoQht3 (size 1 KB) containing data sent by server
Created /tmp/tmp.BWvG5nISzb (size 1024 KB) containing data sent by client
Created /tmp/tmp.qdJVxI2sfJ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 195585
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.BWvG5nISzb (size 128 KB) containing data sent by client
Created /tmp/tmp.qdJVxI2sfJ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

430

Created /tmp/tmp.wgDSKPzhVe (size 1 KB) containing data sent by client
Created /tmp/tmp.8WMsKSKDkw (size 1 KB) containing data sent by server
Created /tmp/tmp.2rI05KcdpM (size 1024 KB) containing data sent by client
Created /tmp/tmp.2gz8nYTtcM (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.2rI05KcdpM (size 128 KB) containing data sent by client
Created /tmp/tmp.2gz8nYTtcM (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

431

Created /tmp/tmp.3TVchbOQce (size 1 KB) containing data sent by client
Created /tmp/tmp.GzBPuKhW29 (size 1 KB) containing data sent by server
Created /tmp/tmp.geCu0O7u9B (size 1024 KB) containing data sent by client
Created /tmp/tmp.GPUFGZ72Zg (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.geCu0O7u9B (size 128 KB) containing data sent by client
Created /tmp/tmp.GPUFGZ72Zg (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 4 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

432

Created /tmp/tmp.JOKBhmUT3Q (size 1 KB) containing data sent by client
Created /tmp/tmp.wReVOoSGHV (size 1 KB) containing data sent by server
Created /tmp/tmp.BljbUADGIH (size 1024 KB) containing data sent by client
Created /tmp/tmp.2qc7kXeRd8 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.BljbUADGIH (size 128 KB) containing data sent by client
Created /tmp/tmp.2qc7kXeRd8 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

433

Created /tmp/tmp.07w5gho24N (size 1 KB) containing data sent by client
Created /tmp/tmp.TsZYLnZGlm (size 1 KB) containing data sent by server
Created /tmp/tmp.bLPlIvGYWu (size 1024 KB) containing data sent by client
Created /tmp/tmp.qOVZWk8RXi (size 1024 KB) containing data sent by server
file received by server has inverted byte at 121857
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.bLPlIvGYWu (size 128 KB) containing data sent by client
Created /tmp/tmp.qOVZWk8RXi (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

434

Created /tmp/tmp.aTji7WgGEf (size 1 KB) containing data sent by client
Created /tmp/tmp.cdxBk0itVh (size 1 KB) containing data sent by server
Created /tmp/tmp.5gjTAu40hu (size 1024 KB) containing data sent by client
Created /tmp/tmp.iiL9Rl77B5 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 326657
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.5gjTAu40hu (size 128 KB) containing data sent by client
Created /tmp/tmp.iiL9Rl77B5 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

435

Created /tmp/tmp.PLSSRTez4R (size 1 KB) containing data sent by client
Created /tmp/tmp.2MBS2rKUR7 (size 1 KB) containing data sent by server
Created /tmp/tmp.qzXSBz45we (size 1024 KB) containing data sent by client
Created /tmp/tmp.A48LKkQGs7 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qzXSBz45we (size 128 KB) containing data sent by client
Created /tmp/tmp.A48LKkQGs7 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

436

Created /tmp/tmp.ZF10tz1VzD (size 1 KB) containing data sent by client
Created /tmp/tmp.otOea0I8u4 (size 1 KB) containing data sent by server
Created /tmp/tmp.J8A3vYH8af (size 1024 KB) containing data sent by client
Created /tmp/tmp.NOKP8IicWP (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.J8A3vYH8af (size 128 KB) containing data sent by client
Created /tmp/tmp.NOKP8IicWP (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

437

Created /tmp/tmp.BSDvIcvq7w (size 1 KB) containing data sent by client
Created /tmp/tmp.zZMlOONrzh (size 1 KB) containing data sent by server
Created /tmp/tmp.gXFtAMuaOC (size 1024 KB) containing data sent by client
Created /tmp/tmp.V9xPshAgg0 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 596993
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.gXFtAMuaOC (size 128 KB) containing data sent by client
Created /tmp/tmp.V9xPshAgg0 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

438

Created /tmp/tmp.oYtFXplhU2 (size 1 KB) containing data sent by client
Created /tmp/tmp.OfIDFbQfCi (size 1 KB) containing data sent by server
Created /tmp/tmp.wArE6fGWCk (size 1024 KB) containing data sent by client
Created /tmp/tmp.eimTj7qsYn (size 1024 KB) containing data sent by server
file received by server has inverted byte at 719873
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.wArE6fGWCk (size 128 KB) containing data sent by client
Created /tmp/tmp.eimTj7qsYn (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

439

Created /tmp/tmp.LcCaMFObPb (size 1 KB) containing data sent by client
Created /tmp/tmp.GXIMKNgZUh (size 1 KB) containing data sent by server
Created /tmp/tmp.sOva5BLrKt (size 1024 KB) containing data sent by client
Created /tmp/tmp.OIO6aN6c09 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.sOva5BLrKt (size 128 KB) containing data sent by client
Created /tmp/tmp.OIO6aN6c09 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

440

Created /tmp/tmp.MBnCScTuCb (size 1 KB) containing data sent by client
Created /tmp/tmp.0My8TQD9Pb (size 1 KB) containing data sent by server
Created /tmp/tmp.3ZsEtx7zOy (size 1024 KB) containing data sent by client
Created /tmp/tmp.5aPZCxh0uN (size 1024 KB) containing data sent by server
file received by server has inverted byte at 318465
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.3ZsEtx7zOy (size 128 KB) containing data sent by client
Created /tmp/tmp.5aPZCxh0uN (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

441

Created /tmp/tmp.CaPrke0zOk (size 1 KB) containing data sent by client
Created /tmp/tmp.dCqiNTJlXI (size 1 KB) containing data sent by server
Created /tmp/tmp.uZBjGP1qO9 (size 1024 KB) containing data sent by client
Created /tmp/tmp.TuHDcsOhSI (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.uZBjGP1qO9 (size 128 KB) containing data sent by client
Created /tmp/tmp.TuHDcsOhSI (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

442

Created /tmp/tmp.ud0k9p8tzL (size 1 KB) containing data sent by client
Created /tmp/tmp.IEEXbRda4y (size 1 KB) containing data sent by server
Created /tmp/tmp.bRxRiwWZOt (size 1024 KB) containing data sent by client
Created /tmp/tmp.mbBusf47Zu (size 1024 KB) containing data sent by server
file received by server has inverted byte at 990209
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.bRxRiwWZOt (size 128 KB) containing data sent by client
Created /tmp/tmp.mbBusf47Zu (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

443

Created /tmp/tmp.ao4FjBaAjh (size 1 KB) containing data sent by client
Created /tmp/tmp.M6GduZBIqt (size 1 KB) containing data sent by server
Created /tmp/tmp.fOvga0Rjnc (size 1024 KB) containing data sent by client
Created /tmp/tmp.6Ntit5VmFD (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.fOvga0Rjnc (size 128 KB) containing data sent by client
Created /tmp/tmp.6Ntit5VmFD (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

444

Created /tmp/tmp.fSbenTt1BY (size 1 KB) containing data sent by client
Created /tmp/tmp.EFJUwRBXte (size 1 KB) containing data sent by server
Created /tmp/tmp.BgI9lhjZLc (size 1024 KB) containing data sent by client
Created /tmp/tmp.EtnJb96Gx9 (size 1024 KB) containing data sent by server
001 MP_FAIL MP_RST: retry 1
Created /tmp/tmp.BgI9lhjZLc (size 1024 KB) containing data sent by client
Created /tmp/tmp.EtnJb96Gx9 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
002 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.BgI9lhjZLc (size 128 KB) containing data sent by client
Created /tmp/tmp.EtnJb96Gx9 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
003 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

445

Created /tmp/tmp.TLX8JMWD7K (size 1 KB) containing data sent by client
Created /tmp/tmp.Xf1Wro9jpQ (size 1 KB) containing data sent by server
Created /tmp/tmp.30zo9GmcGC (size 1024 KB) containing data sent by client
Created /tmp/tmp.1cosHh02Fu (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.30zo9GmcGC (size 128 KB) containing data sent by client
Created /tmp/tmp.1cosHh02Fu (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

446

Created /tmp/tmp.vHGBx9ePFP (size 1 KB) containing data sent by client
Created /tmp/tmp.XsdM5VGEWu (size 1 KB) containing data sent by server
Created /tmp/tmp.xqHcjhNZxV (size 1024 KB) containing data sent by client
Created /tmp/tmp.Dux7aLoGDV (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.xqHcjhNZxV (size 128 KB) containing data sent by client
Created /tmp/tmp.Dux7aLoGDV (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

447

Created /tmp/tmp.msEHlAwdVF (size 1 KB) containing data sent by client
Created /tmp/tmp.xLsbuph4kT (size 1 KB) containing data sent by server
Created /tmp/tmp.j8oyRQlsCb (size 1024 KB) containing data sent by client
Created /tmp/tmp.MdKlcAZKxl (size 1024 KB) containing data sent by server
file received by server has inverted byte at 531457
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.j8oyRQlsCb (size 128 KB) containing data sent by client
Created /tmp/tmp.MdKlcAZKxl (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

448

Created /tmp/tmp.64nnquRmwI (size 1 KB) containing data sent by client
Created /tmp/tmp.fcyOaaNHAk (size 1 KB) containing data sent by server
Created /tmp/tmp.HN79oiv5Wa (size 1024 KB) containing data sent by client
Created /tmp/tmp.yF9wffZsJs (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.HN79oiv5Wa (size 128 KB) containing data sent by client
Created /tmp/tmp.yF9wffZsJs (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

449

Created /tmp/tmp.W3TZEptgJq (size 1 KB) containing data sent by client
Created /tmp/tmp.PGq5j6fB0v (size 1 KB) containing data sent by server
Created /tmp/tmp.07ZZojgJv4 (size 1024 KB) containing data sent by client
Created /tmp/tmp.Tww9YhwQOo (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.07ZZojgJv4 (size 128 KB) containing data sent by client
Created /tmp/tmp.Tww9YhwQOo (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

450

Created /tmp/tmp.cP6thstrUe (size 1 KB) containing data sent by client
Created /tmp/tmp.B3ssNQZt5F (size 1 KB) containing data sent by server
Created /tmp/tmp.dd4kxWYzO2 (size 1024 KB) containing data sent by client
Created /tmp/tmp.JFxOkXvHsh (size 1024 KB) containing data sent by server
file received by server has inverted byte at 261121
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.dd4kxWYzO2 (size 128 KB) containing data sent by client
Created /tmp/tmp.JFxOkXvHsh (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

451

Created /tmp/tmp.eIRJnYPBME (size 1 KB) containing data sent by client
Created /tmp/tmp.TpdHtMMR01 (size 1 KB) containing data sent by server
Created /tmp/tmp.2KOW8B7SVZ (size 1024 KB) containing data sent by client
Created /tmp/tmp.oxoecQV84a (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.2KOW8B7SVZ (size 128 KB) containing data sent by client
Created /tmp/tmp.oxoecQV84a (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 1 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

452

Created /tmp/tmp.QCr2UI9HBR (size 1 KB) containing data sent by client
Created /tmp/tmp.Rs6fpQ56ll (size 1 KB) containing data sent by server
Created /tmp/tmp.ZTlhRbvo1o (size 1024 KB) containing data sent by client
Created /tmp/tmp.7s1EBUzyOT (size 1024 KB) containing data sent by server
file received by server has inverted byte at 198018
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ZTlhRbvo1o (size 128 KB) containing data sent by client
Created /tmp/tmp.7s1EBUzyOT (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

453

Created /tmp/tmp.5FCnr2Z8pa (size 1 KB) containing data sent by client
Created /tmp/tmp.K87cavbgHz (size 1 KB) containing data sent by server
Created /tmp/tmp.sC0NMcLf9p (size 1024 KB) containing data sent by client
Created /tmp/tmp.f2pe4pPQPH (size 1024 KB) containing data sent by server
file received by server has inverted byte at 396549
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.sC0NMcLf9p (size 128 KB) containing data sent by client
Created /tmp/tmp.f2pe4pPQPH (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

454

Created /tmp/tmp.lQhr2G9bWl (size 1 KB) containing data sent by client
Created /tmp/tmp.uW0JuZVOhk (size 1 KB) containing data sent by server
Created /tmp/tmp.bbRCRGO79s (size 1024 KB) containing data sent by client
Created /tmp/tmp.VI0ut7yLaI (size 1024 KB) containing data sent by server
file received by server has inverted byte at 859137
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.bbRCRGO79s (size 128 KB) containing data sent by client
Created /tmp/tmp.VI0ut7yLaI (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

455

Created /tmp/tmp.2ZMHUg3JCv (size 1 KB) containing data sent by client
Created /tmp/tmp.qjSGan6XOO (size 1 KB) containing data sent by server
Created /tmp/tmp.VukxCl76cD (size 1024 KB) containing data sent by client
Created /tmp/tmp.MGYRpIVxyy (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.VukxCl76cD (size 128 KB) containing data sent by client
Created /tmp/tmp.MGYRpIVxyy (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

456

Created /tmp/tmp.LlW1aV4DSH (size 1 KB) containing data sent by client
Created /tmp/tmp.HMxXQPFWO4 (size 1 KB) containing data sent by server
Created /tmp/tmp.1RHDkr56Q3 (size 1024 KB) containing data sent by client
Created /tmp/tmp.rZLvt7Yloo (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.1RHDkr56Q3 (size 128 KB) containing data sent by client
Created /tmp/tmp.rZLvt7Yloo (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

457

Created /tmp/tmp.eRQhMrIfAJ (size 1 KB) containing data sent by client
Created /tmp/tmp.mtmgkY6s5u (size 1 KB) containing data sent by server
Created /tmp/tmp.3FP9xdcneN (size 1024 KB) containing data sent by client
Created /tmp/tmp.Zjlg73jtvb (size 1024 KB) containing data sent by server
001 MP_FAIL MP_RST: retry 1
Created /tmp/tmp.3FP9xdcneN (size 1024 KB) containing data sent by client
Created /tmp/tmp.Zjlg73jtvb (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
002 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.3FP9xdcneN (size 128 KB) containing data sent by client
Created /tmp/tmp.Zjlg73jtvb (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
003 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

458

Created /tmp/tmp.EpZwhP4Bne (size 1 KB) containing data sent by client
Created /tmp/tmp.DpHCv29oLK (size 1 KB) containing data sent by server
Created /tmp/tmp.CG8UJFWKao (size 1024 KB) containing data sent by client
Created /tmp/tmp.mqa5rQiu8d (size 1024 KB) containing data sent by server
file received by server has inverted byte at 662529
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.CG8UJFWKao (size 128 KB) containing data sent by client
Created /tmp/tmp.mqa5rQiu8d (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

459

Created /tmp/tmp.01vOCXKbHQ (size 1 KB) containing data sent by client
Created /tmp/tmp.Zw7gkKZB4I (size 1 KB) containing data sent by server
Created /tmp/tmp.dpdjDTpwJJ (size 1024 KB) containing data sent by client
Created /tmp/tmp.p9n9Q3QSGg (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.dpdjDTpwJJ (size 128 KB) containing data sent by client
Created /tmp/tmp.p9n9Q3QSGg (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

460

Created /tmp/tmp.h6p2rgXafc (size 1 KB) containing data sent by client
Created /tmp/tmp.PFCtrXL7ks (size 1 KB) containing data sent by server
Created /tmp/tmp.ieLYhakxIa (size 1024 KB) containing data sent by client
Created /tmp/tmp.fKNnp5avut (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 4 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ieLYhakxIa (size 128 KB) containing data sent by client
Created /tmp/tmp.fKNnp5avut (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

461

Created /tmp/tmp.NINFkZRnBd (size 1 KB) containing data sent by client
Created /tmp/tmp.MEIfZEQFLW (size 1 KB) containing data sent by server
Created /tmp/tmp.TqDrEMKB9d (size 1024 KB) containing data sent by client
Created /tmp/tmp.xvAxGiJ3t2 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.TqDrEMKB9d (size 128 KB) containing data sent by client
Created /tmp/tmp.xvAxGiJ3t2 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

462

Created /tmp/tmp.xi6lLgTgNA (size 1 KB) containing data sent by client
Created /tmp/tmp.Qn53LWXtdg (size 1 KB) containing data sent by server
Created /tmp/tmp.MqC8mTPX1h (size 1024 KB) containing data sent by client
Created /tmp/tmp.DfON5PeQ6C (size 1024 KB) containing data sent by server
file received by server has inverted byte at 859137
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.MqC8mTPX1h (size 128 KB) containing data sent by client
Created /tmp/tmp.DfON5PeQ6C (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

463

Created /tmp/tmp.ytEDlvAaEj (size 1 KB) containing data sent by client
Created /tmp/tmp.coehNRuyx5 (size 1 KB) containing data sent by server
Created /tmp/tmp.gdUzUDDuZp (size 1024 KB) containing data sent by client
Created /tmp/tmp.6P8hoegVu6 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 3 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.gdUzUDDuZp (size 128 KB) containing data sent by client
Created /tmp/tmp.6P8hoegVu6 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

464

Created /tmp/tmp.NhcEEbIVGc (size 1 KB) containing data sent by client
Created /tmp/tmp.EqImzWGNXi (size 1 KB) containing data sent by server
Created /tmp/tmp.moW9oplzKV (size 1024 KB) containing data sent by client
Created /tmp/tmp.I3ZOownRhR (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.moW9oplzKV (size 128 KB) containing data sent by client
Created /tmp/tmp.I3ZOownRhR (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

465

Created /tmp/tmp.ergRomNCWi (size 1 KB) containing data sent by client
Created /tmp/tmp.oJPd1Uf9Ww (size 1 KB) containing data sent by server
Created /tmp/tmp.Ikt3w6w3oc (size 1024 KB) containing data sent by client
Created /tmp/tmp.MSJaRHnK2W (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Ikt3w6w3oc (size 128 KB) containing data sent by client
Created /tmp/tmp.MSJaRHnK2W (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

466

Created /tmp/tmp.yVyPY3TtFQ (size 1 KB) containing data sent by client
Created /tmp/tmp.qYf2Dfh7Ou (size 1 KB) containing data sent by server
Created /tmp/tmp.oqGWQGcZPV (size 1024 KB) containing data sent by client
Created /tmp/tmp.SAoYicpkJx (size 1024 KB) containing data sent by server
file received by server has inverted byte at 400385
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.oqGWQGcZPV (size 128 KB) containing data sent by client
Created /tmp/tmp.SAoYicpkJx (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

467

Created /tmp/tmp.AyxAi7ZSa5 (size 1 KB) containing data sent by client
Created /tmp/tmp.hEAV3LCDwg (size 1 KB) containing data sent by server
Created /tmp/tmp.31qVS7wH6N (size 1024 KB) containing data sent by client
Created /tmp/tmp.nclcnloBWv (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.31qVS7wH6N (size 128 KB) containing data sent by client
Created /tmp/tmp.nclcnloBWv (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

468

Created /tmp/tmp.23iVlA4R6z (size 1 KB) containing data sent by client
Created /tmp/tmp.IZW3XWGH99 (size 1 KB) containing data sent by server
Created /tmp/tmp.sNp8NHerSi (size 1024 KB) containing data sent by client
Created /tmp/tmp.dzNKPLY0Pt (size 1024 KB) containing data sent by server
file received by server has inverted byte at 181784
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.sNp8NHerSi (size 128 KB) containing data sent by client
Created /tmp/tmp.dzNKPLY0Pt (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

469

Created /tmp/tmp.38rpXRmvpj (size 1 KB) containing data sent by client
Created /tmp/tmp.ltNPBBWYXX (size 1 KB) containing data sent by server
Created /tmp/tmp.RvXEoyQqcQ (size 1024 KB) containing data sent by client
Created /tmp/tmp.3lyorHhi6n (size 1024 KB) containing data sent by server
file received by server has inverted byte at 728065
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.RvXEoyQqcQ (size 128 KB) containing data sent by client
Created /tmp/tmp.3lyorHhi6n (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

470

Created /tmp/tmp.PYJ6duiyhh (size 1 KB) containing data sent by client
Created /tmp/tmp.HO5ksVSjJX (size 1 KB) containing data sent by server
Created /tmp/tmp.cLwuBZpHch (size 1024 KB) containing data sent by client
Created /tmp/tmp.jAD3XRzTZc (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.cLwuBZpHch (size 128 KB) containing data sent by client
Created /tmp/tmp.jAD3XRzTZc (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

471

Created /tmp/tmp.ZinvezC23J (size 1 KB) containing data sent by client
Created /tmp/tmp.hjr4End6WV (size 1 KB) containing data sent by server
Created /tmp/tmp.HQSK6ntwmt (size 1024 KB) containing data sent by client
Created /tmp/tmp.W0Kr3HcWBW (size 1024 KB) containing data sent by server
file received by server has inverted byte at 596856
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.HQSK6ntwmt (size 128 KB) containing data sent by client
Created /tmp/tmp.W0Kr3HcWBW (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

472

Created /tmp/tmp.a8a2IP89F2 (size 1 KB) containing data sent by client
Created /tmp/tmp.FZYmSCfIHq (size 1 KB) containing data sent by server
Created /tmp/tmp.c8XHdmT1VY (size 1024 KB) containing data sent by client
Created /tmp/tmp.S68vjy4kfT (size 1024 KB) containing data sent by server
file received by server has inverted byte at 122949
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.c8XHdmT1VY (size 128 KB) containing data sent by client
Created /tmp/tmp.S68vjy4kfT (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

473

Created /tmp/tmp.mKyuvtdp4Y (size 1 KB) containing data sent by client
Created /tmp/tmp.6sel1jkHLN (size 1 KB) containing data sent by server
Created /tmp/tmp.7pulB99TuR (size 1024 KB) containing data sent by client
Created /tmp/tmp.hO1WLWbqZq (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.7pulB99TuR (size 128 KB) containing data sent by client
Created /tmp/tmp.hO1WLWbqZq (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

474

Created /tmp/tmp.0G4icpwtTY (size 1 KB) containing data sent by client
Created /tmp/tmp.haXiB83K1r (size 1 KB) containing data sent by server
Created /tmp/tmp.8H5oWoCzg3 (size 1024 KB) containing data sent by client
Created /tmp/tmp.OmwFjVyIft (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.8H5oWoCzg3 (size 128 KB) containing data sent by client
Created /tmp/tmp.OmwFjVyIft (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

475

Created /tmp/tmp.yWGiok8cdX (size 1 KB) containing data sent by client
Created /tmp/tmp.hQ0n9GYVNP (size 1 KB) containing data sent by server
Created /tmp/tmp.xIhDvt5CLB (size 1024 KB) containing data sent by client
Created /tmp/tmp.TbXfeTcNgl (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.xIhDvt5CLB (size 128 KB) containing data sent by client
Created /tmp/tmp.TbXfeTcNgl (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

476

Created /tmp/tmp.L0ONavHz4h (size 1 KB) containing data sent by client
Created /tmp/tmp.WkKdWwiRuE (size 1 KB) containing data sent by server
Created /tmp/tmp.s9b4lMVnVV (size 1024 KB) containing data sent by client
Created /tmp/tmp.gRs9nyyt4s (size 1024 KB) containing data sent by server
file received by server has inverted byte at 196972
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.s9b4lMVnVV (size 128 KB) containing data sent by client
Created /tmp/tmp.gRs9nyyt4s (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

477

Created /tmp/tmp.GZ4tlm7YAR (size 1 KB) containing data sent by client
Created /tmp/tmp.3jTKCTde2j (size 1 KB) containing data sent by server
Created /tmp/tmp.jtFMff6FHf (size 1024 KB) containing data sent by client
Created /tmp/tmp.H44gRN5RDB (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jtFMff6FHf (size 128 KB) containing data sent by client
Created /tmp/tmp.H44gRN5RDB (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

478

Created /tmp/tmp.uof9yZbPrT (size 1 KB) containing data sent by client
Created /tmp/tmp.VdcxIYtlqd (size 1 KB) containing data sent by server
Created /tmp/tmp.DFwAu0XXq1 (size 1024 KB) containing data sent by client
Created /tmp/tmp.8GULOtyUY1 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.DFwAu0XXq1 (size 128 KB) containing data sent by client
Created /tmp/tmp.8GULOtyUY1 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

479

Created /tmp/tmp.jYGGgxaWBV (size 1 KB) containing data sent by client
Created /tmp/tmp.IorihmdBlI (size 1 KB) containing data sent by server
Created /tmp/tmp.wwDmur9zru (size 1024 KB) containing data sent by client
Created /tmp/tmp.tHzDDSmT6K (size 1024 KB) containing data sent by server
file received by server has inverted byte at 400385
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.wwDmur9zru (size 128 KB) containing data sent by client
Created /tmp/tmp.tHzDDSmT6K (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

480

Created /tmp/tmp.tQriPd4rv9 (size 1 KB) containing data sent by client
Created /tmp/tmp.3k9z0ZSq26 (size 1 KB) containing data sent by server
Created /tmp/tmp.RgXiC93pkF (size 1024 KB) containing data sent by client
Created /tmp/tmp.fg860jMPUV (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.RgXiC93pkF (size 128 KB) containing data sent by client
Created /tmp/tmp.fg860jMPUV (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

481

Created /tmp/tmp.rZqP2VQCkb (size 1 KB) containing data sent by client
Created /tmp/tmp.GewTzdlKsf (size 1 KB) containing data sent by server
Created /tmp/tmp.ZUwbSC6myk (size 1024 KB) containing data sent by client
Created /tmp/tmp.UqNfDsALwJ (size 1024 KB) containing data sent by server
file received by server has inverted byte at 203777
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ZUwbSC6myk (size 128 KB) containing data sent by client
Created /tmp/tmp.UqNfDsALwJ (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 1 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

482

Created /tmp/tmp.Eulgx7WpgX (size 1 KB) containing data sent by client
Created /tmp/tmp.JtS3JABdVB (size 1 KB) containing data sent by server
Created /tmp/tmp.HCErjrr9RQ (size 1024 KB) containing data sent by client
Created /tmp/tmp.JekTUkp90K (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.HCErjrr9RQ (size 128 KB) containing data sent by client
Created /tmp/tmp.JekTUkp90K (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

483

Created /tmp/tmp.KOYqsxXpMR (size 1 KB) containing data sent by client
Created /tmp/tmp.mdBV34RMKp (size 1 KB) containing data sent by server
Created /tmp/tmp.ZnbfyhGPQH (size 1024 KB) containing data sent by client
Created /tmp/tmp.W3dG2KBQ0i (size 1024 KB) containing data sent by server
file received by server has inverted byte at 859137
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.ZnbfyhGPQH (size 128 KB) containing data sent by client
Created /tmp/tmp.W3dG2KBQ0i (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

484

Created /tmp/tmp.eNuiBPxE8g (size 1 KB) containing data sent by client
Created /tmp/tmp.Be6MOsO7CG (size 1 KB) containing data sent by server
Created /tmp/tmp.siCJg0uCzl (size 1024 KB) containing data sent by client
Created /tmp/tmp.XEO3skQ0RO (size 1024 KB) containing data sent by server
file received by server has inverted byte at 465921
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.siCJg0uCzl (size 128 KB) containing data sent by client
Created /tmp/tmp.XEO3skQ0RO (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

485

Created /tmp/tmp.rloENEjZjZ (size 1 KB) containing data sent by client
Created /tmp/tmp.HnSsJoRYcZ (size 1 KB) containing data sent by server
Created /tmp/tmp.VpSWIkKtmA (size 1024 KB) containing data sent by client
Created /tmp/tmp.RPpBYwqEjc (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.VpSWIkKtmA (size 128 KB) containing data sent by client
Created /tmp/tmp.RPpBYwqEjc (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

486

Created /tmp/tmp.tQaN9G8wqv (size 1 KB) containing data sent by client
Created /tmp/tmp.DgPfGnkA6E (size 1 KB) containing data sent by server
Created /tmp/tmp.aYbzISZRbA (size 1024 KB) containing data sent by client
Created /tmp/tmp.eXZ5IUsRrI (size 1024 KB) containing data sent by server
file received by server has inverted byte at 122949
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.aYbzISZRbA (size 128 KB) containing data sent by client
Created /tmp/tmp.eXZ5IUsRrI (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

487

Created /tmp/tmp.ewFPNLGI5q (size 1 KB) containing data sent by client
Created /tmp/tmp.FIrNCUKsGS (size 1 KB) containing data sent by server
Created /tmp/tmp.e0P96OfHcx (size 1024 KB) containing data sent by client
Created /tmp/tmp.pZvjitaMlx (size 1024 KB) containing data sent by server
file received by server has inverted byte at 122949
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.e0P96OfHcx (size 128 KB) containing data sent by client
Created /tmp/tmp.pZvjitaMlx (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

488

Created /tmp/tmp.hEOnF1eCu0 (size 1 KB) containing data sent by client
Created /tmp/tmp.jMVSB5Z2JU (size 1 KB) containing data sent by server
Created /tmp/tmp.LMN5VVJMe9 (size 1024 KB) containing data sent by client
Created /tmp/tmp.QrMxGVjQos (size 1024 KB) containing data sent by server
file received by server has inverted byte at 122949
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.LMN5VVJMe9 (size 128 KB) containing data sent by client
Created /tmp/tmp.QrMxGVjQos (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

489

Created /tmp/tmp.1azln5NxZG (size 1 KB) containing data sent by client
Created /tmp/tmp.qbVuycxgsT (size 1 KB) containing data sent by server
Created /tmp/tmp.jGDN7RQQEC (size 1024 KB) containing data sent by client
Created /tmp/tmp.WbCZeOmAX7 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.jGDN7RQQEC (size 128 KB) containing data sent by client
Created /tmp/tmp.WbCZeOmAX7 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

490

Created /tmp/tmp.HeTLU9jbb0 (size 1 KB) containing data sent by client
Created /tmp/tmp.FG90AndrTr (size 1 KB) containing data sent by server
Created /tmp/tmp.wvfkBRdSnq (size 1024 KB) containing data sent by client
Created /tmp/tmp.lanlUKtFuY (size 1024 KB) containing data sent by server
file received by server has inverted byte at 65605
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.wvfkBRdSnq (size 128 KB) containing data sent by client
Created /tmp/tmp.lanlUKtFuY (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

491

Created /tmp/tmp.UcvPebZuOE (size 1 KB) containing data sent by client
Created /tmp/tmp.zb6OqxIurx (size 1 KB) containing data sent by server
Created /tmp/tmp.pxLzxhEt0B (size 1024 KB) containing data sent by client
Created /tmp/tmp.douH0DeQZz (size 1024 KB) containing data sent by server
file received by server has inverted byte at 465921
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.pxLzxhEt0B (size 128 KB) containing data sent by client
Created /tmp/tmp.douH0DeQZz (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

492

Created /tmp/tmp.I3yJcGFUYp (size 1 KB) containing data sent by client
Created /tmp/tmp.4Kec5jEI3i (size 1 KB) containing data sent by server
Created /tmp/tmp.qMYCawA3zT (size 1024 KB) containing data sent by client
Created /tmp/tmp.FatqxRZG64 (size 1024 KB) containing data sent by server
file received by server has inverted byte at 334849
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.qMYCawA3zT (size 128 KB) containing data sent by client
Created /tmp/tmp.FatqxRZG64 (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

493

Created /tmp/tmp.N47MDFy6cY (size 1 KB) containing data sent by client
Created /tmp/tmp.hNNWW2s7cB (size 1 KB) containing data sent by server
Created /tmp/tmp.yF0EtQyYdK (size 1024 KB) containing data sent by client
Created /tmp/tmp.4djGnPnLGp (size 1024 KB) containing data sent by server
file received by server has inverted byte at 138241
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.yF0EtQyYdK (size 128 KB) containing data sent by client
Created /tmp/tmp.4djGnPnLGp (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

494

Created /tmp/tmp.iIg8LAC5Ct (size 1 KB) containing data sent by client
Created /tmp/tmp.c4iA4j4jpj (size 1 KB) containing data sent by server
Created /tmp/tmp.Y64ZmniExA (size 1024 KB) containing data sent by client
Created /tmp/tmp.7IK3RW2Ykf (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.Y64ZmniExA (size 128 KB) containing data sent by client
Created /tmp/tmp.7IK3RW2Ykf (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 2 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

495

Created /tmp/tmp.kv85Zf4XJF (size 1 KB) containing data sent by client
Created /tmp/tmp.Jfk7u5OKeI (size 1 KB) containing data sent by server
Created /tmp/tmp.6q5dLKShP3 (size 1024 KB) containing data sent by client
Created /tmp/tmp.i1OQWVdjPl (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.6q5dLKShP3 (size 128 KB) containing data sent by client
Created /tmp/tmp.i1OQWVdjPl (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

496

Created /tmp/tmp.IHa5k6fyM7 (size 1 KB) containing data sent by client
Created /tmp/tmp.3zt8t2IMW1 (size 1 KB) containing data sent by server
Created /tmp/tmp.vO6ITmqJPx (size 1024 KB) containing data sent by client
Created /tmp/tmp.tAHoYXQ1nU (size 1024 KB) containing data sent by server
file received by server has inverted byte at 114757
001 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.vO6ITmqJPx (size 128 KB) containing data sent by client
Created /tmp/tmp.tAHoYXQ1nU (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

497

Created /tmp/tmp.LZ0q3rlVZi (size 1 KB) containing data sent by client
Created /tmp/tmp.lpnVtTMI4y (size 1 KB) containing data sent by server
Created /tmp/tmp.84NQUUzP5M (size 1024 KB) containing data sent by client
Created /tmp/tmp.BD9wQtr5MK (size 1024 KB) containing data sent by server
file received by server has inverted byte at 72705
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.84NQUUzP5M (size 128 KB) containing data sent by client
Created /tmp/tmp.BD9wQtr5MK (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

498

Created /tmp/tmp.v5xqfMoePw (size 1 KB) containing data sent by client
Created /tmp/tmp.i4kevwYJ55 (size 1 KB) containing data sent by server
Created /tmp/tmp.wA5QyTlrqE (size 1024 KB) containing data sent by client
Created /tmp/tmp.dPRnLLFCYw (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.wA5QyTlrqE (size 128 KB) containing data sent by client
Created /tmp/tmp.dPRnLLFCYw (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

499

Created /tmp/tmp.ejlFrreKBM (size 1 KB) containing data sent by client
Created /tmp/tmp.hv7beZHNU7 (size 1 KB) containing data sent by server
Created /tmp/tmp.p1k8SLME5r (size 1024 KB) containing data sent by client
Created /tmp/tmp.UtsmTgI5Uk (size 1024 KB) containing data sent by server
file received by server has inverted byte at 71710
001 MP_FAIL MP_RST: 2 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.p1k8SLME5r (size 128 KB) containing data sent by client
Created /tmp/tmp.UtsmTgI5Uk (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

500

Created /tmp/tmp.HKGvSCkIUS (size 1 KB) containing data sent by client
Created /tmp/tmp.UBYrMytQGK (size 1 KB) containing data sent by server
Created /tmp/tmp.mRV0h3fIKc (size 1024 KB) containing data sent by client
Created /tmp/tmp.NmwD4EeGHI (size 1024 KB) containing data sent by server
file received by server has inverted byte at 269313
001 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]
Created /tmp/tmp.mRV0h3fIKc (size 128 KB) containing data sent by client
Created /tmp/tmp.NmwD4EeGHI (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
002 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

--dDRMvlgZJXvWKvBx--

