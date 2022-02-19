Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28DC57D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9LSFGkSoS1RhgCwjbvln2X8anN/c6C/6z0rIvqjNBI=;
	b=bsaXZIXWsISGsAb5f8w9GZhflUm6ySKRX6YY1QZTdD9beQS4jyD0CGvDqKBPtN3obuQL5h
	Wud9pukIErm9X62hcSlQt+DapRfByW5io1kf+tj/w7W54Q0flnEP3xUmwjXooXxIgrZ56s
	ifUqCOaxkYdYcfP9B4IGE6MLANjgUNE=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2054.outbound.protection.outlook.com [104.47.10.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-HpQsb6v8NvSXUaiVHTyLfg-1; Sun, 20 Feb 2022 00:18:16 +0100
X-MC-Unique: HpQsb6v8NvSXUaiVHTyLfg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtvzOu9/cC0jM87yP57xinG0LzeLOAhVDh+QOED4kyBl9TzafPTdwBnaEnGmHlax3fkRtUQJ73MQ5KntTlknl9xcEUoRUgBCpViH+e66TTrKy+JHuNyjoEeFEZUtgOgW5h0lgRTzAoxh1t4OgsS7jA+7sAtgsyM1iBFmC2ZRfHtIw3AGQGCeh+w5rltkqLV2wvfX854uWyyzlXUnIGv1NZLBUGGDmpTbJf3N6/zJPisIMD1gQJY67EXx9i7FQuLJ8vmEgoU5gQ/JBuNKypTewk9WzDlUdrK0K3keKmpFfCq6uAzemHTvwEgBXF7/FHR51s2/cA5awCP+H8k4hLE1Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIGD1FL3QhBx17LhpwRYhyRkF1R9LFmHQ0YuVeRYeXs=;
 b=WAaNiNKmtq3fauWO/1SfuW72fuIITyMHGagfm2dakN8g+Su5dSwummIUDnj78nA9qWXN2va2XlQPJWZbIzhG6px53GDLcXYaslp2wXUYgZNv3ZraanFZ65NDtJgoJFPgdkSWddJHyUHRpJ5ihHY1Ti9Y5YhcmP9gN7hs+DK0OIqt3hNJb+XRb6eglxR9hEscaGMdJK7D+5xsJEFJQTLE53gVoP3lcoVvIKIsBOOZOWZzuFISGYKlEvDcgtpA6I7G+bZ5OizcQQEu67DnVfr7KucUrtuZRbXaylsQDGf4dwm8RMGzZmhA1jwokVV+9eSEOJgPpBbSgXf+C+CZbWXwsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8812.eurprd04.prod.outlook.com (2603:10a6:20b:40b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Sat, 19 Feb
 2022 23:18:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:18:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next 07/19] mptcp: add the mib for infinite map sending
Date: Sun, 20 Feb 2022 07:17:51 +0800
Message-ID: <3270a9d71e0a19f37958e188560732f43d2bf342.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645311956.git.geliang.tang@suse.com>
References: <cover.1645311956.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:203:d0::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c00237a4-f336-4c3b-edcd-08d9f3fe1af6
X-MS-TrafficTypeDiagnostic: AM9PR04MB8812:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB88129996F43B6EDA78ED39B1F8389@AM9PR04MB8812.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HT2zZ4gToJhJQdjZ7JCgDO+BMqKaeXGnbENvXcFdyrqG4gJo01I8wuWrFAlHI/dkx0LM43HbxS2hRLissaBfbsyRYlVvCy1RsAJM2JvMSN3NQXPHMT58xswuAvVrGcXW5iWmi8UzfyWlM/KycS+EYnNU/r2jP/SiajJ1fuBwfdTxcS5tYDRZpUwxS/8+2LZ+oyyvie9apj1zlHeg3rz72N4Y0UVoxyCSXJQAdFDJsnESjFI3jyEbvcuW21sLZ9byF6QrPDG9E9HMG7OUUkqGKPsxRLK//98/R7lbWpM64K3oYNFCWZ02QuZ9vcj/KT2q5D/HZl40Z5YycMoudGOtpRK4oDSw9LHRjaz6CuDAV/ZCi7PEBr0Ru5ZOyOxgt5dtA8BwehjvbV2TOPxbWsNXm5J99AyR54cTKRxDEoLZl37x0k2fDRVGBaaNziMycNwG3f7o5CgzKfEo2KkAZmW6H/s9yrdv4VPYNZTNholfJARgK+jQ4ze79DyzXkYwUhRdtK6FXh2KV3yIlrtC8tK3Y53zc2rHJR0t8H1f9OT5GmGkB+K39HbGevKDW/YPsABt6NJMS3CClBWI6e37QqolNlz93SaUvPn1U0xh/k0FXe7hCzn2WLnDgSj7ngIF2PCRMrfX70EA3k82quWQNiArNw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(66476007)(6486002)(66946007)(66556008)(4326008)(86362001)(8676002)(5660300002)(54906003)(186003)(8936002)(508600001)(6666004)(2616005)(38100700002)(6916009)(36756003)(6506007)(2906002)(316002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IfjDhuk0H4w90ymyLGhP2JHtUajY4m6/uHEuG4mQwE5EFTDoIL+Is3HBO3nU?=
 =?us-ascii?Q?eoi8bSglHxYr0VFHYMhQELI2ZyEwIkZR346/q2NQtOPXWgDeIWFBNZ7cIeNe?=
 =?us-ascii?Q?Vg6gmuhYgU7eOzp45d1OjVCoLw8MGn0nXSskC2dYed0m8qCHrrLq6lbkdAcK?=
 =?us-ascii?Q?9cVHRiULgKKHuAR5t1xCNG4h3ZVmSyIi8alhneFodzS48/vq+9fdhr8XmjW0?=
 =?us-ascii?Q?LgtTJsNTTPldZLqo7a/+YrZeQ1J0EFa/pQ0JOZNmCtuVPcuud6kzaCBaXBAo?=
 =?us-ascii?Q?suBVJ8kO03tWD4Stp1VVtOc5fzA2Pt3HLdCbjAcpVvZyg3Wwxb7cnCPUjld4?=
 =?us-ascii?Q?DibRjvoJDFB5n/Ns8J6orU/Y1X5eofjU8GLWrDtqBxvVaU4rSOIaZqYnchir?=
 =?us-ascii?Q?WOxGVhf9YaFSzJCjIJfskT16nL2HhjJjjko8S5oO6S+b5Xa6KP8eJRMl9YHt?=
 =?us-ascii?Q?mBbgjoklUbwpDpgIUkwqD29wiWI5edB9QMUnlIZbSLtZOkMO+kZm0tVJ3cT3?=
 =?us-ascii?Q?hCtNKJMFxyUtQ8+28gZh4WyzLA+cXHB8eBYXludyER5McO6PTIWAgoSZ1F27?=
 =?us-ascii?Q?1RmEFnwJBAFmc1c2jZNu6MfEG1p6kzoSFBgyj0Mmd3WoAdqOrBPWFTEkFRQX?=
 =?us-ascii?Q?A791qQqfo3Q2m1yIGQoe3L6ROX2zLWJM4+Pkah4PWXPKOb7gXmwTJuexrozC?=
 =?us-ascii?Q?c703O56tKg7Vcju6FBERK2rEn2FWht1sZz6QmWTYPadzBuJv9UJlrJl9tgTS?=
 =?us-ascii?Q?ILDxXeSj8YhNLP/GbTDYK9lzde8Fy5dbEESW8BWdLqH9MvgqXg22X6C3S0/H?=
 =?us-ascii?Q?x1mp+dAvmMt134vxyXLkd0WPyzKQ31MqCiuCYSUCKZuuZXm0wQx6Juz5OwUU?=
 =?us-ascii?Q?tcN0bLUxm4A5LCmJ9qQmNycKFe1uTezSUL8xcz/0zO6GYVtfR53SJ3pS2tkK?=
 =?us-ascii?Q?M1ULeoYWYH2BKZtNdHDW5q5BuUuz+J+SoOdo0nGi1AC0kpo1+OGjGszdSPA5?=
 =?us-ascii?Q?ujMN+laSuL6Ze1LQZ0VOK7A218Kk7sJ/VrLDun6rhO7DsQ6pnxpD3DIIG2ja?=
 =?us-ascii?Q?vz7ZjvvEfgnn7KXBp1ZsIWeQOTS/PRIv0UJ9AUwR1FYT9SIUBNJbn5mYStrc?=
 =?us-ascii?Q?wA5scUrIbkBPRMWsvEriGrNkuqSBerFsnNxMfcR2IjCjuuSFvAe4bsNC4p++?=
 =?us-ascii?Q?4xyM5SXu8YHlHgoP6lx7VtW6Fmy7wn36kxj1R6rnEsxIEnp8Hh1ysSs+Oi1W?=
 =?us-ascii?Q?j/8/qQI/xTUUclcH0asOU1UyjT6WkJzy0X0G9dystIXEKHgk/Rygqzp0RfRQ?=
 =?us-ascii?Q?IBCFjVhzLRla2LWazJaVh96h+rSYp+GnKhcqDZV4SkjXP5EP5d+vwg4YjSA6?=
 =?us-ascii?Q?7RA6hLqOpI90uu+SCtvBW39WRFv0jZ8DjtODNxPOMmFBa7oqYbwcJjLi/He6?=
 =?us-ascii?Q?cko1wLqLf6YhkZirGlomiTPQgqD/xf192Rsx1hh58Ad23V6LV2PstXeyktiz?=
 =?us-ascii?Q?RbnIxW+cTKzpoZCnPVeuv1JpQOE06AYg30OUGQJbdhAKcstR1k8kmkq8d+9X?=
 =?us-ascii?Q?gkdxnST/+L0BNGhu/XoyUK4ewGPK/+FX5xEnaHDU4k85OGdhv3CamLDtXkxq?=
 =?us-ascii?Q?a+e0brOSgFD/Gyj2y1E7MwYnvZ6/Rtjts1LHi2SqKK84LWvPkv9DO7BTxkKA?=
 =?us-ascii?Q?oLJkHZCnEIydDa+vEIdaW/BolLo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00237a4-f336-4c3b-edcd-08d9f3fe1af6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:18:15.2237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CF8GZ7R7K+p4oD3p/YqLQ1vxIlxO1s58dNnAxFlBh8bEBuELcl4FiziEOGsrXDbLDjMO+O6j+wu7hf9eVZ/nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8812

This patch added a new mib named MPTCP_MIB_INFINITEMAPTX, increase it
when a infinite mapping has been sent out.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/mib.c      | 1 +
 net/mptcp/mib.h      | 1 +
 net/mptcp/protocol.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 7558802a1435..7cef7409e300 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -24,6 +24,7 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
+	SNMP_MIB_ITEM("InfiniteMapTx", MPTCP_MIB_INFINITEMAPTX),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
 	SNMP_MIB_ITEM("DSSNoMatchTCP", MPTCP_MIB_DSSTCPMISMATCH),
 	SNMP_MIB_ITEM("DataCsumErr", MPTCP_MIB_DATACSUMERR),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 2966fcb6548b..785cf751e5c0 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -17,6 +17,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the p=
revious one */
+	MPTCP_MIB_INFINITEMAPTX,	/* Sent an infinite mapping */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
 	MPTCP_MIB_DSSTCPMISMATCH,	/* DSS-mapping did not map with TCP's sequence =
numbers */
 	MPTCP_MIB_DATACSUMERR,		/* The data checksum fail */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fecf4c36b55b..3cb975227d12 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1238,6 +1238,7 @@ static void mptcp_update_infinite_map(struct mptcp_so=
ck *msk,
 	mpext->infinite_map =3D 1;
 	mpext->data_len =3D 0;
=20
+	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map =3D 0;
 	pr_fallback(msk);
 	__mptcp_do_fallback(msk);
--=20
2.34.1

