Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A07B
	for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 08:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648714502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xjp3j/LNML+J++ulw1MX2hTyNIiOBgY7ZoCkWLle59w=;
	b=ZXkQfcGhgeGfKzuQQMZ2N399nJw0paSFBYCOaMeoWZ0vCwR8QZhkXdjEaFU9DUrZItAZNy
	OuM98f8KkXKBEvUNVeoBXiHMUtvjkSxaKDGeFqT3bbp/5/HifqbSPr5JAzKJaAhYr39GKH
	f+nP5c3cW0Kk2AG25pKKXZF0nMl92jc=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2053.outbound.protection.outlook.com [104.47.8.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-OWEA2CFWNi--7-_6frR-Ig-1; Thu, 31 Mar 2022 10:15:00 +0200
X-MC-Unique: OWEA2CFWNi--7-_6frR-Ig-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fus1FV3bPIdzy0UD/x4F1qIofV8RuNuyaM0xSXVdkQ3oZxVP0SEfpJLJT2YxfJJc/C5HJ/vHWm3sbaf0+FKOXDbSjZPZm6fyGK4foCakvxEBEhFmF5YWkkW9ZmRyxhyQIndvW2pXtlKA9F/s0P8bqHTyjelPFPpDVFlPYbjJ7+ve416uAob5EDpUtydN1SvmkzKOVshydzUjgX+Kd8E9E6NuweXzSk7iq5b9WyF0svfZmRR+ER1rhcL5kpAzHQBmno/FsDEEHmqHZQHt/kBqVmlHIRwB+mRQCiDO/m6J2E5hjdVNlFviP4fCfOX8NZeWcDpJimRn6OPzOZ1hZOIVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVu36Kmoiw6iEt66cITk6nd0E8K0Bt6v7NUB2025RMk=;
 b=B0aB7/GlKHKBkf+9DG1nDwffumrdjTtEZylzncJu52gm0BUtNF/aNsNvICRht5ulsSwOfNJiFmkpbTsNAn1UqKLP2MaYEAb3ZhzZy+6ZTJciWSAanVX8CFz54/cixf6b4PzOpx0FhjaQgi3e2/5Zrp8NY8uZFguP59NInHRQ+Ar7WzwfKbApbLMbIPFjhnagQF1rJ6sEP/XSXI74FFyf6nO1ueebeN1AyNYXJ7Z7NKKdY0WXlWIUciLsxgi3yH0AjkhttpjNXhYS5qqPB7/ijVVoDao/xTE33ASJoO8nkU8MOsvTSJxKexd0JemG+xx0ws8cjO/p1C/9xqi8ZFobkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8966.eurprd04.prod.outlook.com (2603:10a6:10:2e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 08:14:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.023; Thu, 31 Mar 2022
 08:14:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: bpf: add MPTCP test base"
Date: Thu, 31 Mar 2022 16:14:58 +0800
Message-ID: <edcb9bcf557a7205a8301f755688dcbc22b279e6.1648714427.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:403:a::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65049515-8dec-4100-17cc-08da12ee8be4
X-MS-TrafficTypeDiagnostic: DU2PR04MB8966:EE_
X-Microsoft-Antispam-PRVS:
	<DU2PR04MB896688D5598DE1DBD22CE4B3F8E19@DU2PR04MB8966.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tQxZXeCR4BCW0RgjZHxuzJiuChtydcqT7eTo4uydRbNx07MtcllULkFdf8QzU6iElqBaPe4EJ0QybBZ7UsCdAbFikXWZB1FCARXwpu1E7lWR95ssWEDQVrhjbET91ca7YW5Jryss9xl7kSBXx3IjGeStBjiUuLC7ggOmd8Xl1xQcALtANdooxphd36r4Qgudh7n1+yAklU9xKVCbVipnQdczYgUQ8ysqgYVRjUeXtXnXvWlt2pR5MpRUt7SVIjeXpkQIO4OTu4nNGYYtBBBLpUkuizd0ml0sk4smoRR12Fiy5IHV7qSBnBEhXEBtjkz32FjPgohoNZSWS5UW/M0Gi58KzwrvSO28MqswwljIL2/ns187IC0Rb+m1miPAifp4bUuWhrf7h2u+f0Nnqb+hOVI5PoYXDi9VYEbZbtQSJBy2ifRtl4A+DwTslcJkrENWnoGdlFyrlKw7bPPUpCpcgbaSLOS9BfSHSpV0sRS+rnoqfeApbxXrQbiF3WfOvODk4sip4HeIQcLzNgQPKp3yNn0VhkbOquNAW3WnWIlsna5HLEmyT16WWq4PghTXFAQX8LeAvI6eDxUyQutjT6Ri3ZEEXlk6wQTnDg7nOSuhlKs+GWgpYMx+NzJEszAYHNd23PSeXKIPT41/TMEJaNXx3D31HzX8An2Tzug7vDYDAUzr6FEy1Fqe+TGuCsgPzm+0fC1G6X6w5AmqErXhBOYJNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(8676002)(66476007)(83380400001)(66556008)(66946007)(107886003)(2616005)(4326008)(186003)(26005)(6512007)(8936002)(44832011)(36756003)(6916009)(316002)(86362001)(2906002)(6506007)(5660300002)(4744005)(508600001)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pvF8PR0UrQ8G6muuZVCOmuNTtdLbeT2jCQ2rCunrzrAUXAVd89GKilWSOuCU?=
 =?us-ascii?Q?OPHQ0luRwM6h4yvWwvZHv4nIwkoxF6XXBRV4KeYfItwSTy9rSXTPB4HxlErZ?=
 =?us-ascii?Q?1rHXY/uni9FE6RpYK3WKm1Pr4nwcCn5Shukg7yGWQtUrum1r3hfshRagF3oX?=
 =?us-ascii?Q?TXctWmZt3r8DIsPos7AdNY9H6VC4Ru0DLMIA+wfXlGpTNVHqw9h865zG9elN?=
 =?us-ascii?Q?HgC3zWf+WhZrer35f53WrPs469HMhdw1U7XoUjki8X8QnwcXQrsK7SW+lrff?=
 =?us-ascii?Q?jTa/wrdp2XFyyExBVBCuGYTc0rTsCsmxEaeisBcLJYk9e5Yal3uw1Qyf21qn?=
 =?us-ascii?Q?Tl8ziNZ9ENpp+J1FTg64aBPVXZ6cAOnZaBcWsk4rDxKVCcNVQvJS/RMFN9+H?=
 =?us-ascii?Q?0idpVSdhWPv/kMwpavTKXRWD8RfWBGpXrh8ge/P+zXSLZJ8oaQZumBDhwcD+?=
 =?us-ascii?Q?4auEo9QzEoLIuMMN7iaTPd1qwOgPKt1xNCNAMw50ESjqa//NPl5hP6jEYHnJ?=
 =?us-ascii?Q?cEhgZNwxu+ySGJJ2XmNgZa92G8ADC2Ew0G1YiLxJ+VQ5g6l1aRcG3zH6JUMd?=
 =?us-ascii?Q?guAp+6Aqwc9ngKH1xkocfqh+Nlg3NP/6bhGHWdCXHIScB861nLinGxbH3u0z?=
 =?us-ascii?Q?XYpYjgDZc6+LJbHIQFBmEBqPFf1meoS1Uv8QMBAH7Fib1ZyoogsABL5xnNu4?=
 =?us-ascii?Q?nuwH7xp5e2+V+cSPG4SxM6mmwrUTrPKBFtX/Vc/ScShNZDLTpyA1Qcdz5tY9?=
 =?us-ascii?Q?AdzALwdvlGyPIadTc+fkn9odNQG+WioaYRNG6IwRTsvyow+DrYrZOrWsRLQV?=
 =?us-ascii?Q?k0juVtA8FKMrOZlBxap+XgCiaOID0e+Fk+EIuQ7+44PdQHM8geZ1YhzPXMHd?=
 =?us-ascii?Q?fmS2UN7p0nwvznOXL2gfjnwHdE5Hh0yoPxKTHP84w8VCDXzC+g7RBSW1o1Vk?=
 =?us-ascii?Q?c0QfSrjnQwkzDO7wlG5IVrJolEtFMmBvWQaMI+YR24CPtcNJJLKWL16d1ACa?=
 =?us-ascii?Q?MpTOngi+c77Cwl5472AsG8hsP2lfR1qM09cwYE1MraASDSXRhHDLw0SP2Dcc?=
 =?us-ascii?Q?enQm/KYjmRjE8PK/szDrttWGsgwkMXvky2p3+HLXY2TQH+RQgA05Cz4FrUXk?=
 =?us-ascii?Q?cFcH/ypsSWgD0qufPiprk1G+6SLCG/sKUzbjCPcfPd4mXPUyVXo6H3vF0+/9?=
 =?us-ascii?Q?DhiuS71kxy3/JZuPfxGN4bAtqMknixrSLeDyo4VsTM82CNY80z5G8KbnMb2P?=
 =?us-ascii?Q?rREgcqamUkzRFkDptZ44wbAatG1g+6ERCgtuVIc7n4gOuwhaWYNem1TAprWN?=
 =?us-ascii?Q?VrH2M83RQcmpxjSVkI5RzJvpSdZxpcOta8O7g2O4Sjxr92bZjTw0oA28P1nz?=
 =?us-ascii?Q?Q7x6/MEHTJaxSIdxc0JP18ZOOzVkuo+QzkevOQ//STOtTPIX1+3LHBNyPP0x?=
 =?us-ascii?Q?w6zHEb/2k2PqU2oQYZsjHYGx4rbV2Ojs5aSs7eMb7v4O+u8KEZfSv55iwjDb?=
 =?us-ascii?Q?P+E0WEUarTyheSlSDHCwl+StyU2sCUjGTo5l8DldklZpDQkyqwnBxTDk9xbC?=
 =?us-ascii?Q?tS1Za5b51mzW6LGQRB3xGuv9EgRdOYCb3GAoUUbEE7OdhtTOFwIMBGjtsD31?=
 =?us-ascii?Q?w8LRBllDq3txb+lMGbYxwkEEGD4t+D9TnsMz84U2oMtZ5wkPkyTPDmUxKG99?=
 =?us-ascii?Q?H9XRxklrcDawz0O9JFth0R5ZyLaPI1ysAKi6cjwzzyBIhnfqMsJUpRBkz7hm?=
 =?us-ascii?Q?vZ3wD3J0xcNIkeVzcrQOx4HucStPxcA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65049515-8dec-4100-17cc-08da12ee8be4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 08:14:58.7812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Abo3/+L6JNohh7xmOr9t1bZGkn07dAW9GG1IV+M+fKkVOef11yR13i+XltFa39SGIDLPc2EQFib/yrGUy8BMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8966

Update newly added files in MAINTAINERS.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d91f6c6e3d3b..778cbf7c5a3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13745,6 +13745,8 @@ F:	include/net/mptcp.h
 F:	include/trace/events/mptcp.h
 F:	include/uapi/linux/mptcp.h
 F:	net/mptcp/
+F:	tools/testing/selftests/bpf/progs/mptcp_sock.c
+F:	tools/testing/selftests/bpf/prog_tests/mptcp.c
 F:	tools/testing/selftests/net/mptcp/
=20
 NETWORKING [TCP]
--=20
2.34.1

