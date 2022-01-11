Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC892CA1
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 08:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641890282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KY9tEqm2RaFuDzTiSHV3itemrLOUHCLayLoKgpAfN/Y=;
	b=iGDOP4qoOAfSKViHWJZdIzx3Bnn+Kc86gNet3PCF+SYmnqYgFPoys1HKUIUWRJlOolh6C4
	pNN2WVAb3TPKCrX8klOvZ934acJJ+nlcm6iCLoATeVzKvFp6uWAY7DXQScos3Rw6kvDPof
	z2XAGqf2Zm0Bh3nI/MYWdASYKHnryfY=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2058.outbound.protection.outlook.com [104.47.5.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-tGOA6aI7OPGS8VuS6bSS6A-1; Tue, 11 Jan 2022 09:38:01 +0100
X-MC-Unique: tGOA6aI7OPGS8VuS6bSS6A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwXe7qJvjZZ+yBAy41hlNCfxoPudfhrujqIYvhOxhA3RvJcudmANH0rigmZcTTbOEW8KOMJcKxzP2ZxUAvmboyrRcGF06rNYKXFtPtYz3iDelpwuJTFjnYuE7zG4MHVnArXt9U5Xik/BSNpfh2zhdd/HpEsvXTURRwS6ym4aO6zYa2we+PBokskKQDNRZv9JlSPSH6ZCgJR0fTra2jpZVzfzdu5R0fSEXed3W2ES7p4ja9kto+iSeTulwtnGzK4DcC2UohRWbuLIPCbLVrMS45EWZ9WSNnHKWdJJnv5606qQALZ4e/cZNUs8oJmVeRvh3EvaDf4SdsgaZdNZdfgBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EC8LaRNikucWqNobXJX0kwPBLqRdwuYQtKn9pwhphTE=;
 b=HHUtgSXkNsUdakTrRnGR4yXomKDfeXUkOb6tvK7Yw8+k61udjQfLEQWI+FiQgDD3b7k5UVm6/GQOgkxl8lTdJd0Nx2yegOoPVYTm/KiZhHLOuOXLfE0mdzcGUHnsPyA+36SeuMAX3R/SdLkdRV2FQtBgw1n8iRQYWXh99p+mjFGyv0PEE8QFg8S5nmp3qERbET9aUXlWFFBGSrEa6vitl6oOZywC8SBiq+OibZAwQjalpYQkmLhkKPLYdbjkbYuQhklCOwA7Ea0t5ZmgxrBc8rnbz8QvmwnXUggwF41ZMiMK71ZTtnlwVeHazKORPKRY0L70tI56WzFRcTjq4tYDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3275.eurprd04.prod.outlook.com (2603:10a6:7:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 08:38:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 08:38:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH iproute2-next] Squash to "mptcp: add the fullmesh flag setting support"
Date: Tue, 11 Jan 2022 16:37:35 +0800
Message-ID: <4f60e9fc96536c1625afa3d3f0e25ec155ec6d28.1641887600.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <31324a202c23ac880d391f2d38f7c59b3f348ee1.1641890078.git.geliang.tang@suse.com>
References: <31324a202c23ac880d391f2d38f7c59b3f348ee1.1641890078.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0190.apcprd02.prod.outlook.com
 (2603:1096:201:21::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2158cff-c64b-4561-cf94-08d9d4ddacd1
X-MS-TrafficTypeDiagnostic: HE1PR04MB3275:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB3275A779BE398028DEEDB98BF8519@HE1PR04MB3275.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sFW4teUYYwbevtL7JzEXCl2idWwmdBkR7pHZKTzp6Qh09DkF4nipVKntQun+BcytNh+Ajx/MGXapyIfy8bRECyTqiDcoucmtwnVkNGtzDjAI/xSueKuVG6yWe+ot1Us6Lyl44jCX+26ABKb75m2kfnmzF4Zb+cq5D9y5whWG3rYho5ZMtfckreT567HVDdLy9wqwAlJU1JiFkBCvFOGsx+PxYbMnal8efMaLdfQ37OKUo+nX+jlFNevTBKjkIu+/pyAARTIGoQVgxAVX30K9yNpwViW1Mz3uawqsi1tZig7Kloc0YWeiw9PWFwFynkt88ncX0eXc/Pa9mINFFknHQ82WZM8SyVsC/zuvHiQkSsWrRfAw6Z5LpY4OQpn7kRHvyyAJqxT5qJzT6AwHsHhUOlNKDateh0dOmfG9Njd+TsLL4r/jLf+pyg4KIip+IbDwIZaiFmWiCuXrVBHA5sbnHG8KhgpKXWmuqyYBj/VARmz5XGXvTJgQ6fRCmHyGLiapeRvi5LZhHR1PIHls/BZ8nikv+NMRseHro8q+GXRbKoEpRLEK/JUKhR73BJ9c3dCYw38VV2THa1MmRq7ED3X/VC/7OFAxws+O4GFvOTagE5rQnh9APq3TodR0ds29tfccWwr1VBfElxxHswiZARFEDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(36756003)(26005)(2616005)(6512007)(55236004)(86362001)(66556008)(66476007)(5660300002)(4326008)(6486002)(6506007)(107886003)(6916009)(8936002)(44832011)(66946007)(186003)(6666004)(316002)(508600001)(4744005)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fvqFeYQQdILhYVLiAjQz7vJXTeLmXbSGs3aIEViiac2tFfnBAkNx7F7gpNNC?=
 =?us-ascii?Q?EK1bp+f5n1TS46twYhub2lHX5NS0557bucWX6gb44tlR/BB5TCPLvNl4gjEC?=
 =?us-ascii?Q?kGhWXMX6VG9V5VzW76kobVhCxDcvBv3twZtWiLrh6Nejh/RVDEurLBN8rikR?=
 =?us-ascii?Q?YALV0ioTPlRap3PJ4zOeT0daTOauuO1V1d7Vndpkxli5gR98MLhOoOIrOlh/?=
 =?us-ascii?Q?bDLhn72AL/cDk9dLOauRwtQnSJ7X0mMoYP75D2NiB7VAorL7FZDwYuA/yBlo?=
 =?us-ascii?Q?7fIrILlP/YkZ7ZHYGBIvqlguTnqzM4yD5ucnL0Wlacy5I/Kp1r3qdIxfQ2BM?=
 =?us-ascii?Q?OhsgZv2wGEx/UsGa1bGYKzC2mArYkjnK7zvKFXdVLU7oDYRpfuHH5eiWtzXl?=
 =?us-ascii?Q?4qN/UqvUrzcra31qz4WFhFo6v+XSvhoZRCM0MjpE89CscT6Q629yiEoFvKZG?=
 =?us-ascii?Q?bgBiQO7rt7/kzOkqGzrsstJ77Srfl5bwp26A/HucaDLtjaveJViCzDmdXE/U?=
 =?us-ascii?Q?TGnVBSa9MPsohVWzMSHpmcYG3t5OTKoNXMqPgqEF8enwiBuj7zWCSLEAWf/g?=
 =?us-ascii?Q?qRPHxPuQ2yfVhv6EKHp+hRqwa/VdNRsZdUuIRQzw4kTk/xQlgn2006vR+xIL?=
 =?us-ascii?Q?3tDYVBwHHveh39tvezgYVazrmBZ5OS/CEK5KHZaNALZXbkbIKdcGxKGZ4MRO?=
 =?us-ascii?Q?uAP1DUVdFjniVOQ1gFfXrXBL06ky9lWBDBngf6Hgd3pC27m5WxdRqQhRv84j?=
 =?us-ascii?Q?xCzHBHBqc3PZR/WUFP6LZHyRth3RzDRSf0NdiSGfy7LL/E1OjbJ+AnFerHWA?=
 =?us-ascii?Q?4wgUxHLyB3JqDZ7cDfasyY4KKNTpBYXYDECKgL2QR5BAi7Uhe/r7tLdIbjus?=
 =?us-ascii?Q?qlmlP+jkGif0CuvWPNXHD5UbHxLv0ow2Keh4hlJB02nGh5LoGp40uNzBpWhf?=
 =?us-ascii?Q?QlrTC3NTMbbFtNCcOPFoaKfNmCU/0n2YCsnmlUC782YLHWPCaug15W6gxPGc?=
 =?us-ascii?Q?2pyZIHcUOP/HH4u/gtoprGTdFT93KdcPztCT07EFy16vbJy0Xa6nBN2HnpzD?=
 =?us-ascii?Q?a8Qhy/RE0T/ZQ42WCOQKZ4z3qpHiLgzOTa/Dzuw/8jz7bFwe5J+ebscdR1/I?=
 =?us-ascii?Q?+cbmqPYiAxlfA+Ec7zpqOzzCfvrlo1Mb7bCRoV4tgO+u5+cnMn827gIrEPr3?=
 =?us-ascii?Q?HhDG9Zq89wYbfAB4oLhGD866LymfVQL657QGE6dvS1vC6tQkGiYiYtSoTKE4?=
 =?us-ascii?Q?40iWTl+hxuSBytT6gse5GRriy9vmbMgw/HvbmyzrJmCG5imdaIGXgdw6vHAf?=
 =?us-ascii?Q?fY/KesiOr+Wl6FgObiEvYG0Fd3oSIRzkYGk2tbjWpfq0f8dcvE/ZgsgL53qY?=
 =?us-ascii?Q?JI1YPTt4DQbMIAx7tauqvHW8VhD+AnI/Yy/PeaVhppMW2Z6gFG2X/lRr/w/f?=
 =?us-ascii?Q?Kb/zrywxKZAj6CaUB0tqXLocd6rlAS2S20uj9KsrBM8njmkx7QkNg1Vo90zC?=
 =?us-ascii?Q?45VUfjXI1aIMkGyTQpcjqOJGpdoOAo/MgPPmlLrWOclFAdYRgd+IIlcPwGAT?=
 =?us-ascii?Q?OOBZawkW6mN22XfHnCreWibfgGh4GiPR8d6a1zma+eV9zr/VrRzETsdkl5Op?=
 =?us-ascii?Q?jDL5nckdBAs20NEn4FZxFgE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2158cff-c64b-4561-cf94-08d9d4ddacd1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 08:38:00.3021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5ZWEpAspyu+TSR9Sk8ZSUMtRIMzmPDW6mbCrCJGBRABziuhWphTr33qJeMKB8SVqkEAWCIFnNmEz7lCEX+tmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3275

Add the fullmesh flag check for the adding address too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 ip/ipmptcp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index ee786537..646e5200 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -118,6 +118,11 @@ static int mptcp_parse_opt(int argc, char **argv, stru=
ct nlmsghdr *n, int cmd)
 	ll_init_map(&rth);
 	while (argc > 0) {
 		if (get_flags(*argv, &flags) =3D=3D 0) {
+			if (adding &&
+			    (flags & MPTCP_PM_ADDR_FLAG_SIGNAL) &&
+			    (flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
+				invarg("invalid flags\n", *argv);
+
 			/* allow changing the 'backup' flag only */
 			if (cmd =3D=3D MPTCP_PM_CMD_SET_FLAGS &&
 			    (flags & ~MPTCP_PM_ADDR_FLAG_BACKUP) &&
--=20
2.31.1

