Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4304A29CA
	for <mptcp@lists.linux.dev>; Sun, 16 Jan 2022 08:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642321078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G14sABj7Ho2VkWqLlk2rDEchycwYllh4AYbcr4LM5kc=;
	b=GZotCKKM6JlIMbB9oLzsC6DUf9jKEKf6qU6CgytTSwu0NV4t7XnxOhr9BMY6TZ3Ck5TJ4T
	L02/ssCWjHzhjd4P3baZEod/mREoYpC5lbNbeYlqzuvE1sUUbw+y7Ubg6luiKkwfJ3rxh4
	N1bbpg1n83xlVPKWdP+oui4EOojqiHk=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2055.outbound.protection.outlook.com [104.47.14.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-FKF19JAMMkm604i5ftWQ3g-1; Sun, 16 Jan 2022 09:17:57 +0100
X-MC-Unique: FKF19JAMMkm604i5ftWQ3g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoF9AdmShza3VtoODByy0+5iMf3hQNAxNzu9+CbFEBBhck9FHlmm5oHj5Z7RHnLR4SiNzgJaXrFojLbifusv9rxZMGGff+IvLySkv8vYNgRg0/Eb7czUvKslPwFmsiKK8osnwtdozuLAbKNOQp1to68Qs9RXtPwgpaNIj85Sl05icGFDJuVjFtQ8TCmFy7no1SwUrojxboxpGXKfbfoAMDveCd2frJOQD+jrS/iR1SWkB/gXlJCOB0eqEQq6rRuKn8tgdMu7rPyWf/ILxjuu3o+CJV5fGF/RwpCJdUH6zd/v8dRfYuFaRKkoOvvXWWeLEU8vDbgzTrgZoRGZ/mrhZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUYk5Z6DJlM6joeJLmUCNkva5EM+D+QY+DebRXk8VcA=;
 b=khdOgNSEs9Iz0CvzbSOJRSbKy6oOcAoJhd7x0n7hxt4kAYGOSrB3jTHvljIlobGt32vlxFKo92CKSA8xOxpWTojOSesDdj/b2PGbfzH8qj/BQ9vclvX9BV89cdoiHyikuTnjMc6lFVfYZe0DSEFG7T9B2WUOuvutTM8hePSewqOH7Kj9L4J2mVL836cRyVMRn33qWy6ymZu0nn99PbWJJvdhGc+MaiuTEaD+54KIDTTQDRhO99Ld3g9rjuJdqlUDPxEwxAyE9/dJbhu2MwgX5rphZ1NRuNClG6H0yQqt3fHp+mwbDGgFDVKfUA+UJ0Rh1EzLMZQCLoTkAkZfepepBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Sun, 16 Jan
 2022 08:17:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879%3]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 08:17:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 00/10] set flags and selftests
Date: Sun, 16 Jan 2022 16:17:30 +0800
Message-ID: <cover.1642320655.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5dc611f-3fbd-4095-507e-08d9d8c8b25f
X-MS-TrafficTypeDiagnostic: VE1PR04MB7472:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB74726009B403C596143BFBBCF8569@VE1PR04MB7472.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ofyaeIQ7kPtGMn4rmjnlAt5xwGRQAIq8+t03qE48c+1oD4n+g6+XbxHlC1C2SQtS729iSfK/uqrZly9wPr3vwQxty3UTygz//tqBqtKPnY45bkOgg42bpSNFwg7X2mnC7+Cs2/poCwDuI7Khw8Y2SJtcdN2dhAljAZQ1cFEWsutNNLJG/UGX8U0t2Y3vcQVmRXuF3H6BhcnpZ/Ednke7pERixmDW1SmzmQ60A1LqUoQvC8lUpD7MnConNkRretzyWOn7xbVNQk6smkKRSyF84uh6B8MIO7UVu/lG6mj4adUVHuhgIQ/jsbtFo6p4Mxo6EPNdS6s3yGzn7XC57Ig7+vjaauFWPXy3mk1OEWufm0EyArCY4zNtU1cViw8TlSxnMD2yTF6H4tK42FdxF7sQKFike3f+f5MMRBZcfIk1Wzd2uw58SbQAzA+VYPOD1JJ77DLUhHXR6e8Q9pDwcaDcuvH5KK0BgANew8ROYZoUZj1tGb4a8lsac+txYpx/WhtCDy8fuy184NbIDvUkgVd66y8FVDCQQEs3p7xSr33cLWncJmZ0J2Tq3BEWhPqtb4S70rWnTox+YxkytKl2T/xxMlcD1yJGuE2nSz9tLqfiwdcgZiUN9ATzkrsSWEmsZC5uVKB9vkhVqoDBGBv2UMInaW30Nw9WTebxEX70QyIWM6JBK7VnAxABGFS41fsYOiOV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(5660300002)(107886003)(6666004)(38100700002)(2616005)(44832011)(6512007)(316002)(186003)(508600001)(4744005)(66946007)(6916009)(66476007)(4326008)(6486002)(36756003)(83380400001)(8936002)(2906002)(86362001)(26005)(6506007)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eVNTZ3/c2c53BS7ZpCOO5snZK6M2Dvv/0qrDTtm43wirtqneI9uqjQ34PwAW?=
 =?us-ascii?Q?ewGcg4Rp0IhF2h26s7//cbA/m/ld4S2u5NuBHE60sXzJjl8ozjQWgV7VnMpn?=
 =?us-ascii?Q?xa4PVPGLKLgqigA9QzZEb+da9iwhTsRtl5hw1+TaXGfYl/GI4GQSyyP44lFv?=
 =?us-ascii?Q?c/XJ+J/sRQFh/RvcnxRFAUKu6cbDs0v9Gp4hz1T+9Kg8GUawMYPItbIpvQRr?=
 =?us-ascii?Q?fXmd4tciA/U01yFmSBBJQ2I8KuTW4ALTWruItWtltqKybowRnf0kSR9/tMY1?=
 =?us-ascii?Q?JZjGxOQs7mqU+MdpvPSLiBRQ8+Y0ciAu8JzWpz4IbmRKxuS8rOVJj1sFgpPL?=
 =?us-ascii?Q?4zLL1oqCIAGRofM98vYdG0LSuTWazOYeAJI1wovQxUl3hdeRcqaEqjZK0hWD?=
 =?us-ascii?Q?sBjk8CdFbFwrsyczA8+TrVYPA2NHLrRSJ1kf7iapk2weZcdHY94QSNG9I11s?=
 =?us-ascii?Q?mV92h5hCCL+jh+FhD3HyG40Yewi3rqR6yH4M5SXASAdxrN6gFQqWy3ny6y6z?=
 =?us-ascii?Q?vF/sVbqvPbSwm50/dVmAyKnsvAcWvn4RVqj+yW8Fli5ol7bzdVkqWcloLObV?=
 =?us-ascii?Q?EeCwhDmfwYydXOo6uUfyL9wGMQNkvbmaw+BzROgCGN6hS4gav4ffeDP5oicH?=
 =?us-ascii?Q?+qcJOJzeZpCOHfE7H7ET822NDIOxdQFXv0KzRbtAAfxIO9eOiUI+DFeXU/ec?=
 =?us-ascii?Q?Xn8Ib4z4wEmLWi4a4nt5MMo+fGgri1g86iFFoYEgKXpcfCgVQQ7W20lsmt5O?=
 =?us-ascii?Q?pn31yoveOum9kv7FYcN9mYTGm/h46ANg5QkgAk8dPPB51Z0xSs3v6XDAsol4?=
 =?us-ascii?Q?vKd7UtZLjfor8lmlHWCpSG5jDM+KqU2ZmYYc5rU4Q0nNmtisXXFvymIgcIhJ?=
 =?us-ascii?Q?vi9waK8+/NlG0dQoGvyLA8xkMTNbcHzzlo/+6+7wEe6fQbfdYHTzNEDUfHFO?=
 =?us-ascii?Q?f5JSwI/5aGmxFb4L0OZuY8mTbeMGGmjWttPmqizf3Vx0qRDNfvnlrQrYCJRJ?=
 =?us-ascii?Q?lUO1MUb7ZynsN40Sb9cQU2pI4WrpVgMu4clt7J2W8ax4WpZ6nTTR1k+GKz4V?=
 =?us-ascii?Q?EOUMo3Mqw1MIAkilpEw4HmRrUxIVqVfzhZ8Y77aLQyG+Elpirldx29nYhpi/?=
 =?us-ascii?Q?dZlH64Hu11Zp1+Zec9jH4X704HzstpHcgK8Lugh00ml0A4uP0PLULsbjZzKK?=
 =?us-ascii?Q?fsMbTqLC9BByVMeKMZrXJ50FPRz2fKbNf1ZpccLGF5OOkFNOSoHl4G6jn2Po?=
 =?us-ascii?Q?2buq/zxYd8KPnJSBc1TJaO8nTkfLoGaSYPlNan31H1UGe9ZKHtAP6/Focucw?=
 =?us-ascii?Q?yXsjvqBrseQI3pEcgcHzchDh5ydl1ae/hvLjmutDEO96CTyseXDWCqZ+1k/L?=
 =?us-ascii?Q?sV1+gHkQzQ0TkmfinGgKLSFVj/X3JhcbB1+alW3hCsLZ8CDJuME/NfBVrlK+?=
 =?us-ascii?Q?ogYhHPZtoGq4oTK0wd0js1RoherAAd8oJzXE0GLdiAcBpBI1AJHc0yzGJ/+I?=
 =?us-ascii?Q?ao2jts+103Y+KvDoDvT0vTg2kihZ9W7M+lcA85DZy5bWWWBSOUva8rrGCQ9P?=
 =?us-ascii?Q?v07PE01jYOqpTI9jWvgGu96NhCNLHyjgDq6iRyjJ2J5sOqRs82FTHsZIU1o4?=
 =?us-ascii?Q?u+l1ox4NJs18A9fJaqwkH34=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dc611f-3fbd-4095-507e-08d9d8c8b25f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 08:17:54.9629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moODdXTdvg62KYS+/Jwl2zoWQbJptSVtWg21eeYhPTz2/h5lLp62AE2LdiYG+z4aRHa3xdy1SUyXaK2BgS5jZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

v2:
 - use a mask of changed flags as Mat suggested.
 - squash patch 8 and patch 9 in v1 into one.

Geliang Tang (10):
  mptcp: set fullmesh flag in pm_netlink
  selftests: mptcp: set fullmesh flag in pm_nl_ctl
  selftests: mptcp: add fullmesh setting tests
  mptcp: allow to use port and non-signal in set_flags
  selftests: mptcp: add the port argument for set_flags
  selftests: mptcp: add backup with port testcase
  selftests: mptcp: add ip mptcp wrappers
  selftests: mptcp: add wrapper for showing addrs
  selftests: mptcp: add wrapper for setting flags
  selftests: mptcp: set ip_mptcp in command line

 net/mptcp/pm_netlink.c                        |  50 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 936 +++++++++++-------
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  19 +-
 3 files changed, 616 insertions(+), 389 deletions(-)

--=20
2.31.1

