Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B12C80
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 06:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644300262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTJmlug858Ny+o9wrPr0z+7nlGtaFe7v+gDuSrgb1to=;
	b=FGyaM9U807yGvlnmf5HHEmWDEGFzbVtuvGo5CxHJLnDXmPZdUBZ9W3CCt5EwZvuSmcsGCT
	JlULRGGxvISEc88c11ApbhKpi9QGE8bBTDfjKa8ShCW76OzARGb8ictlZUYztbmXSWRWqE
	1VIhwI5bABDYMErFAUIo1COSJGEsMPE=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2051.outbound.protection.outlook.com [104.47.8.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-9AaNKKFuMRO4Z_Rx4NokVQ-1; Tue, 08 Feb 2022 07:04:21 +0100
X-MC-Unique: 9AaNKKFuMRO4Z_Rx4NokVQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HN78gbjaVgLH7C6V8HZvunIbTvljzZQfzWQ+xo4m4FTtA7t3Lz/if+4niOpLujQUE326rotrcH9L9oDGASPMO4XsD4hc9z+IUjWNTgoKX8Fgq12zsqDqSJWEM3AkkztBjIrGE6Eph1UrIMyG3Om7kTOgUPfbxB0N5Jbh6Mj9IhAYK3RCs2qpBnbKPOR7gtwOP4ga6fACabeJ02fTxVZghBOJpaUjX0MBB1VUB1JoAh+PEO5Y2LD0fIKZIG6+MkIu14ddM/K5e2pCtirmbEyMHWkCa0IQ4a0u8uyYiSX6OozTBVqziDxhjetzPLRpqXBdU9WtmorNUU7SRCGF/Jqz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bphWHRw+OxAjtNZUqZ+k2pjJWv5HHWsr9EjkU9pBpk0=;
 b=T/7tA7uHJPFew9M04043yBGvyhYQdODbLCnwvuonrhypTtyR3IVOTq0h28WF9xjGGhqz4CiJUqPuSgssyjSu0S6jPwlHF4trMooAcjzdj3oQwO21NofKMkozds3EH+fV7ucfK8r1utPzBTF+aDHG1oX4RsDdq/ZhF1WvCplfCtFmund8AsFnFcYbfi2CUXRdAskLkHlbJrWrDamXgO1HoXtAIyzQuBqNiVo8kTVrxlei5iim7BWIISMys5q++w5z85yHiWm+0sd8gVtiuFOJA/e9dC8kWUKkQsNzAfA9YDY77U3moGLyybyQFKD8a0/B+gpmqgS47sgHZITwAPKD5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5569.eurprd04.prod.outlook.com (2603:10a6:208:115::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 06:04:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 06:04:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/2] mptcp: add SNDTIMEO setsockopt support
Date: Tue,  8 Feb 2022 14:04:24 +0800
Message-ID: <34f61a836e720760512cdb44a72a3b8afd0d64b8.1644300192.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644300192.git.geliang.tang@suse.com>
References: <cover.1644300192.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0005.apcprd03.prod.outlook.com
 (2603:1096:202::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb42cefc-f215-433c-937e-08d9eac8d932
X-MS-TrafficTypeDiagnostic: AM0PR04MB5569:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB55699137054F212979C95D35F82D9@AM0PR04MB5569.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0Osrws4rCgPCiNt1pihG+8a6habDz35TiJoeUwKnz/d9H/ba4bmpi0gndRLCvChXIOjeOYspyR43ssJ0sFf3+a/4k7o1G40CvjAwhZM/+MRqKI5fKFai7TqBbJhmxLaZF6dYJLTxRHlNUYvKy7/ij5DdzOizJQu3EJWAjE7iR0B7oQHgoKP1c+MD0j7Z7P0AKqWpgtWxC7Xl0T6nilgSUdiiOL37wPLZia8hl2Jn+ZVjOZg5TCD5vw+XNUH0cMuwrBSVQt8621VEsokJpLLZOuiIA2exfKbFitFwKCEP/RZBGyccjgKw9OXNLdWgPOnBtWT5wx5oHDpZOKDfakN2W8okodMpHBBJVb2XTK1g32dWkjiu4i0Y717TaJ2tVYx22Wl7ucME2KwIai3XVrpNzyMKk6UDVa/Nq5kSxWYQQou6G70c/9K7hZ1hRyedhCdqn8xedZ5VoRB0nuQB5xdw8jhpJ4teUwuvY3Ne10CEHpXOfTX8RelITJuAKQ+LijzuySBHZ9VZ2/yy7hbAk1cx3AGoNwxDRyXGPoj3q92clvpqPIRERvVimRqLYoU75pIREHjkkcMWy/ExWkgPqZc7S/qGbJoVpApcmWclqIHm7gWVeXT9N5TrOSCTEoAl3x5ULnoNPeF/deNqZnIdNCrb9Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(83380400001)(5660300002)(4744005)(6486002)(44832011)(55236004)(2616005)(186003)(26005)(36756003)(6512007)(6506007)(508600001)(2906002)(86362001)(66556008)(6916009)(316002)(66476007)(66946007)(38100700002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8FNzFkOpZSBmQU0UJnIpX/sulSUAvIHgDYk6yXdZZOLGDz3DW0bB62m8WkAM?=
 =?us-ascii?Q?U/pKyVSqcwtWmpdVdCRE8RdtpyyzQK+AIHQ81AB6y0G5UIj2QQtkMVDwSSVL?=
 =?us-ascii?Q?4JGxR8OV7rhezafCWZn2uT5K5uqvdGixxz+rHivWtl7jOUoKkbScT3kgznAa?=
 =?us-ascii?Q?fqfb82j7iZHYE8vqfAEKVFEPoOtCSSIIwaMin+VuFl7THYOk8r0EHkQZzCQ8?=
 =?us-ascii?Q?kabBLOQ2udPx5+qSOaEYKY/IoNxVio4LuuEJl6B2xKymBCGftcR1SkbmGy/0?=
 =?us-ascii?Q?XQ7J2RyU5mG4NggZ4uhSvDULqw1E0J44BItq8QGkm9OQf55nYpJ+QMTa5Mrj?=
 =?us-ascii?Q?+reSXzCnnGofLc4ttYraZ2WFOzg81IaI3a5BjuGQevqCIvP0UxpgoUbFUZAX?=
 =?us-ascii?Q?XmfJgOZ3qUODbvjJY/jltT7go4GUpWJCbZ2ndbCjBx6LCuZ1l7/rH6hbbvwN?=
 =?us-ascii?Q?chBeciZHzCWZAYryyOLAubemONlzLZuZdJGX4b7fw9sxLMIE0LMKTvkaXIAm?=
 =?us-ascii?Q?LJ1hKYMIerYCFmOw3LW07jpBGwlU3GssYtpnm9dmh6G08Zziqx7ucHC4YL6r?=
 =?us-ascii?Q?XpohhTwyS+TZak5IhWZzOV0ySzsky+GbkHauQUuym+KxOcVpN9gKurXU3qV7?=
 =?us-ascii?Q?F8ky1hjQZVT/po2GKwITHuwr/cXScWZ2jyl1HGekudHOarVTRiA/EuaeDEXl?=
 =?us-ascii?Q?sewTBAwTATSZv4qjmvWVdL8kR3qtvBGEFMMMjSGAURUEmYU+57wsyGOqjeH8?=
 =?us-ascii?Q?QFE/8HN65I6QFvd9t2t1q+Z4Evz1T3H+R8wCt4MG8c0Z+7y48+L/LZTwsj5f?=
 =?us-ascii?Q?F+0Y8q5CiLhiOxMtNVdJwp6AeTnn7rVid98+XRuf1LsYaMrNwgNcD4XQgyyF?=
 =?us-ascii?Q?LKnKVJ09eDqogZ8fcP1uL1Sl17SRpWCbsF+5hzwJrSfZOMN2ILtbX+FFb+Lc?=
 =?us-ascii?Q?NigdN70XEg6hDL4dcVXs8/nbFEJOUQ3k9PK2J4++RvoI6kdDT2lZ0ctZPOmr?=
 =?us-ascii?Q?irRQmvBZ6knXBygKov5z8m1nZQsxXOF/LDjlnATOjxE1iz8ijUZvKGSmGxkV?=
 =?us-ascii?Q?j/KY+NBcXXEJilnzu0ug1tlOApq4SscDNVmx74T9SdEicUn/Tv4npSqapAKH?=
 =?us-ascii?Q?pA6om2IZfh7CmxW/CY52y1rUWxCQzms+DSrWHpgC4Zb5a0yE9FxxcbqEqLP3?=
 =?us-ascii?Q?cFiRrAPi8XIXZrjPnRGRBHH14Gmb1KsSQ/oOs9xAG+RobtuWJCQ4ZfI32pJt?=
 =?us-ascii?Q?Hcu0h5tTmPnU2Ewt9BNcobnfQ6O8sT6zyFHcBvchG2Cskkrw4qgJ2lo9WIni?=
 =?us-ascii?Q?gD1dbav1rKRr6QYvQoeb1N1A8+GE41AIltgQi1sq6C+Tm7wMe+otvUYB4l9q?=
 =?us-ascii?Q?jf5fPOkomgJ8Yan6k8xzr1qE+a+e8xDNHtYI0n9M3BiSJocM0ceYnUojNWi6?=
 =?us-ascii?Q?iDgasGigEQ7HcnzC4ThsNwykHPYW6JHZszfgspXqnV/+GOHSYifNzZUf22PO?=
 =?us-ascii?Q?Vf3VW9YBHPsm5HVBwJgAf34UmymuyjNYfDowutFK4Qe3YPO/ZEEicaKlCw/e?=
 =?us-ascii?Q?VxteyvS+NKhVullisXzPEjQKYjpJl9CH7YEX79o8S78tQAYxK/apscN1KS1C?=
 =?us-ascii?Q?impUkIv3LGxwSB2XvjNOrDg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb42cefc-f215-433c-937e-08d9eac8d932
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 06:04:20.8590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpf+xBRLfLsVQO9vqateQ02arqBopR4kN4xXeykyOiCtR3NP3aXo3UcgmQvyMqgrh6wApDFYiX9f8uIoL5wZ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5569

Add setsockopt support for SO_SNDTIMEO_OLD and SO_SNDTIMEO_NEW to fix this
error reported by the mptcp bpf selftest:

 (network_helpers.c:64: errno: Operation not supported) Failed to set SO_SN=
DTIMEO
 test_mptcp:FAIL:115

 All error logs:

 (network_helpers.c:64: errno: Operation not supported) Failed to set SO_SN=
DTIMEO
 test_mptcp:FAIL:115
 Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sockopt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index dacf3cee0027..f949d22f52bd 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -343,6 +343,8 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_soc=
k *msk, int optname,
 	case SO_RCVLOWAT:
 	case SO_RCVTIMEO_OLD:
 	case SO_RCVTIMEO_NEW:
+	case SO_SNDTIMEO_OLD:
+	case SO_SNDTIMEO_NEW:
 	case SO_BUSY_POLL:
 	case SO_PREFER_BUSY_POLL:
 	case SO_BUSY_POLL_BUDGET:
--=20
2.34.1

