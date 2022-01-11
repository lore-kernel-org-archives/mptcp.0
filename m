Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD55D2C9C
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 15:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641913595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjhzF5PoEJuwwWAa22cnMbzTBhyfzDBP4zMPxwH47Yc=;
	b=ESsDRXlJ/TNHwzdZWxzuvTseo/jnYEaXfnu12bMs6B/v9NRlb/h+qhaYpLYvQEKqwFJcyb
	OT0UhUNwPIyV+BSfZTPTrnKCn3TkCUyMejnXsxG+XynsbP9nvMPYyuKnXFqBiFTh8TjBvg
	0cqnBMKK7AmlSz9xHFZ7To5Y/Kz2wTo=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-PHsdvVXNMbiTBFV4jZIjDw-1; Tue, 11 Jan 2022 16:06:34 +0100
X-MC-Unique: PHsdvVXNMbiTBFV4jZIjDw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TP1WvraoA76WuAiaS0RWgPS3Tga5wXjsSGxB2sTT8NwkDIN8h8zBf4uoRJDdfNsbbIm0rTdm6DfzFZ0OjRosskLOQvA4oy8+6tmlifYRsySUlnUvoFyakl8E8TM2Ij8NozcpCZQY7jcsC1Ze/CsgEKUq6HLPMUS+qIW6PStunAFczRvygVyyX2dyRQ1L/C6P5J2f6LPzdaA2nK4p6h3EsbnOUwnu62dePf0qH8wUERbCI741Xs6Ft1Ne4UMNkpt9Wc+QfQrFPtCbUT1JR2YCT+IrBkS8LYPOQpqeVgxwvdG279HweM1IrSPXCfp9IpSxDyLxIxxVfG6CBTSdZUTlhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07GI3ftnUr37Z1HJrB3SsxT0T9Jz3pwnTguJIgU49KY=;
 b=VVlrZ6Rhtlc1e7mGlDHLPjUPPywrhj3YvTLI8AJiqUFh9fkfBIwORtLSoZ5qnJSU9me9+n3HVF/PIVTmnyIqW9Jj/l8LnVOgAaGPyZmNh6ScxjcC6JrMWXEPUwHF30vRsNZ6ltVpvyscY7Pct+UYMrXmajXxjqoPQ+MLKbRvORc+9Be5ytdKxoR6lAudgg8kx5pHncdaD8qCKHMvZR2kbAxGh/5dOjgxA16qdnRn4oHXP0o6XoKGt1lrf2DAnqHH+Fa8nl/mjGQUiyWghepVTj31aBQuJ4ZwDA1vQwmmQD+vwoYa2rM37k/FxBfWdO8scIHiA9cqWkpDD9aZJPm2Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2458.eurprd04.prod.outlook.com (2603:10a6:3:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 15:06:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 15:06:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/3] selftests: mptcp: set fullmesh flag in pm_nl_ctl
Date: Tue, 11 Jan 2022 23:06:11 +0800
Message-ID: <c7773e93090bd0aa224687ba00057b04990cde8b.1641913113.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641913113.git.geliang.tang@suse.com>
References: <cover.1641913113.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:202:16::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da01303e-b0b0-4cc1-f2c1-08d9d513f47b
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2458:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2458EF56B005DF47462F54A1F8519@HE1PR0401MB2458.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bEu0iSc0N+MLcuZvk1k9YC1AwJQlf6lwSEX5EuQDITrSF9hZaPo6w7pFzEunOrXCo7z3R2ZdtJQI3c8DjeA2jnYE48jJGRhQOMS+u+QJnbWr5QVSt8DBw032G+x1PY0qD23Rx/8lFV0wQjOabT0nO5LgXAOR4K7gile/CkQl7OidhAyLFdNBiTNr8pkQRoqGTFrCbKDHCzb4Af1K2bizOSys/1KJHuLdbxEyZzOXjwzWknnvvgnbiVhmyQOEJXIJqevT0h++QPD8palJH35rAEUBoV0iPPK5nRwsnu0VupPAtV0I+mqEsn7QY/gwBpuFaPo/zNrDbaSrShrYFB1U/99brFONLaKIs++FtD0PwcUWQssGMdLCdF49sfWAlWAy2X2cp0PiqqKO+SGB8CON+anz8I00auKmZ5qS3bwSBDCHzqtwChSLF4wkIb0Qa1tB3JUySY1LxRVl8/RamZ3ScpcqJ5rzeGT8EcudGc3wepf8/uR0LHI+Z4JdJ4Sm1OmGJ1Fn7M9OF2Brcy9G1oF3DS3NL2lD50Dog3usfaA0bbVs/R3b7vI3I98eb9P4FxZQ9TlpJe0b3erRvlbEcGtApunP1BARddgM9RQF8iBN2o4B5RCJ4GKji7yOm6mFLuKBHGvFwK5m9+uQr9FpxniOTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(6512007)(66556008)(6486002)(2906002)(6916009)(66476007)(38100700002)(4326008)(508600001)(8936002)(5660300002)(107886003)(6666004)(8676002)(44832011)(186003)(36756003)(83380400001)(6506007)(2616005)(86362001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DeSc+gjViR+Gnl3pk3uF+WRO5Xp7mCkv/+291WdZWVDepIrZGo8Gx3jbwY9Y?=
 =?us-ascii?Q?gdmT8x+FPkeBxgCxWCc+Eh1HqiSf0Y8vGtwDgFqHrP6lmeofSNlDcDslZvy8?=
 =?us-ascii?Q?K/HW0USlbGPQDKdbMoj/w7YZMsYDNZpkwfMiptmyHD+mMXjon/vOASRRHcFX?=
 =?us-ascii?Q?hr8cIjnutMVfX1b1irx3A/eMtlRRy8O29oFBwxMXOP/Omzof+Vodr8tvn6pM?=
 =?us-ascii?Q?ZSk6DqdXSaRT7OcYWx9Qm1IclGQw7sICfZ/B4nn5urvT8SxUpeooV1w6LPw4?=
 =?us-ascii?Q?y33lCcOWVZNQAg7aEKeuRqE85L7wWFenVZNzRSaskhK2A7uT1XDhkpL38H/7?=
 =?us-ascii?Q?SO0QVsh362r/yguE+8zvi/gO9uCOS7Ell3lq+rBVkQtW7sUphRtx+Y7QXjW7?=
 =?us-ascii?Q?NCjFBCzhAXkuhkV8fnru0M7x7TJqLduy5BNJbmKi9Sv5qj8b562sfzKOQHm0?=
 =?us-ascii?Q?Ah5mFYTjHYohlsPqMimby4MHqvalJ1x8YGiE9jaSTvNyc2WVRedUTU2L8sl7?=
 =?us-ascii?Q?D9+2rWtyrZsubWlzHi6qx3Z3fokkIrKlgdJ5ZRMxVvP+vEVbW3NWL/PTd9lS?=
 =?us-ascii?Q?kCRqirtyWjOFZialB4nkVDLmS9l7FX+qKRbKth9pmXtAJVG/i5DWU9XwYOh6?=
 =?us-ascii?Q?mlxSQ9ql6Xl1fdAORjy4MgUUKw7awwo4CG3+YGOq89zqe/3kDyTyqKYpMwI+?=
 =?us-ascii?Q?I/gpm50kRIW3+MHZBF3sVDnwsELkTK8SPfsxPJQ0Vh2eUUQnlu42wtgxKXau?=
 =?us-ascii?Q?04M/QOxz5E24Lqlzaus3enwHlA5dV+vSbXefJgiAO/jQNXDZcxxZDcpTyrwo?=
 =?us-ascii?Q?5O0wv7MK0wWlH3hccCSPb6HCyX960NftpM47u2OfaySkdwomIFMDoDxbtuSN?=
 =?us-ascii?Q?LlH7i5f3x1Ft3hm97nzwJ1ct0nlWGZjb6gPcDRrx3fsp35hRHKHnSMJM8xbG?=
 =?us-ascii?Q?yU9H7F4jiOv0FYeuFpe3QnnSXTo4UjdKpioh3zuz1IF3X1WqcNueB22mOyqQ?=
 =?us-ascii?Q?CU/xoY51rjlBhB5ZKdAcH/5PR4O+oEV3OZKrrDy/lncXObdsvWE8D3D91Qns?=
 =?us-ascii?Q?vfGVpr6UdTl7UO/5UCr9QUme5Jt/8haF7gkCJ/CX//5Dbs5uDKTX2qe8rFVh?=
 =?us-ascii?Q?8lwfVGUl79Sa0dt6WwSBjIPHi2kjWvozK17DrFlpZT9Vpz4maFVA4T7/eL3w?=
 =?us-ascii?Q?DCREgxl3BrM4y9iwLUalxWEyR/fMe9RWjWjf6GbHA0KgPFcLHEDE6ilw4gRa?=
 =?us-ascii?Q?pITPNk82gt2qotfAzBTaRkt0ZF2HPpAtEh0bxd/t6RA+tIjrzQ6Ag9YEaxQJ?=
 =?us-ascii?Q?yDNUfUMig6hByBhIolm33ozFiPxeFbOw7e8slN/HLekJWmjusizx+gSKRpIn?=
 =?us-ascii?Q?PN1gQ47iDpn6A4ca0SKy3bxQQKvInhR0MPbLuEbPFunqYXOwjWMN+NpqGV8f?=
 =?us-ascii?Q?+FbWI0t4qDzqkNXgtxuUwmrjOiJZ+ZjKx9IlXOG8ifmN2dLO0GUfybcwn5ie?=
 =?us-ascii?Q?Qg6B16eb2fhGFUoNVa/L6JnFs2u1SqcHcfNvuXw4kojpjwW8/z0yE+bQW0Al?=
 =?us-ascii?Q?BBxfr/1QoYbrKyFq7nwaXq7paX6sQfxydD51kdWDGDyiwmTs+FuFBAMArDC8?=
 =?us-ascii?Q?v7pC2nBY1wDKRNKsBaEn5V0xC5oXJA1auhhKRBNylSaGemTUOl9JtJLVIXKT?=
 =?us-ascii?Q?EDP7IBAfmPPRtsQKIV/Q/io5UyY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da01303e-b0b0-4cc1-f2c1-08d9d513f47b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 15:06:33.3588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xt8neRi8duYH6mlrmbD4ymmnvRa7SA+YLJxjSUR7ixJTpCvFjfCGd3bfpObi0YjwIsOY8hnghQNTdSjEdn4i8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2458

This patch added the fullmesh flag setting and clearing support in
pm_nl_ctl:

 # pm_nl_ctl set ip flags fullmesh
 # pm_nl_ctl set ip flags nofullmesh

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index 354784512748..9b6db9d77223 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -28,7 +28,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [=
dev <name>] <ip>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
-	fprintf(stderr, "\tset <ip> [flags backup|nobackup]\n");
+	fprintf(stderr, "\tset <ip> [flags backup|nobackup|fullmesh|nofullmesh]\n=
");
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
@@ -709,7 +709,10 @@ int set_flags(int fd, int pm_family, int argc, char *a=
rgv[])
 			     str =3D NULL) {
 				if (!strcmp(tok, "backup"))
 					flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
-				else if (strcmp(tok, "nobackup"))
+				else if (!strcmp(tok, "fullmesh"))
+					flags |=3D MPTCP_PM_ADDR_FLAG_FULLMESH;
+				else if (strcmp(tok, "nobackup") &&
+					 strcmp(tok, "nofullmesh"))
 					error(1, errno,
 					      "unknown flag %s", argv[arg]);
 			}
--=20
2.31.1

