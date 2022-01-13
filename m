Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C662C9C
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 09:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642065198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Edt1p9KSDoya75M6IGXtjEKGXl8SOfJIAkR/V+wo6XU=;
	b=NTAMO1PLVsWxgTWAesn90q1zeV8gmIWzLdB/u2PfYokYp6BnIfyDd83K0Zo40ejqFE/yIQ
	ZFB9fVMLLlquSz/cX2mSNJfXiF3I83gaBeYJHgdiKybU5wZXx0yykkE2HMebEVf+Rbke5Y
	1JqR9pM0GaDVoy6UFg6amfxNgrg/6ZA=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2054.outbound.protection.outlook.com [104.47.13.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-oAr3xsEqNsWL0F8y1PDoAQ-1; Thu, 13 Jan 2022 10:13:17 +0100
X-MC-Unique: oAr3xsEqNsWL0F8y1PDoAQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6CcLtx/iaGywYXMdKdhrbxhxC/d6azsKBIs2ygPW93xTrsSavUZKaEbUQjPHiasJ5m0hd7lSmz+NQD8Lbxconn2InjCko4gT73rXKBp7uUKdyZJkYbzfT375XPuRS7Ps0RAIacvEMUmOu1b926T7HsOBu6RyiyZIdc0rEnwdStQDtpUMtPyqU9n7ZXV4mLQTWePCSrD49ZQoc0p071zvpVGNR5tIRUf61eK2bxNIN5d8gGMwIisjGcBn67U8r7HQ/9zCWGcLsvztVHAb4AwhfLQzSKVLMjwO2JLawwpvRXkFxIRsvS6BH9Q5RbYtZ6n16z+G18CU4lLi2tePfe6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2ju45BwrOeaW84wTo2BgVqr4hubXPkYYwiKW/v1dwo=;
 b=JDSgL1G/6aheD73aiH7qsX8/FWSa0RvLjGXbF5XNaH4FvmMPzGjsjgoszqBArrZhBu/FZZYQw+wDkfl4Vux2MyxlSQNxb2j0axxitppXwoKes0Hd+4W1ANLrb6LmerLfTU7RfH9vVFXBu61UoBYrpMU74VwAVECs1lnFtMYfTc1dvtFP6CiyRb3q8JTvZULckDP86MWObfAtvnVuMQuv8KOJhFDIGwaTf7fRMG1/4cePUnv1nPpVVGGi29trzX3U+gm1OiM9Q7tE7HxUq/NvGcfYgL5ohWrev01suSXq2qnPmdxk7FU15TvaVgv3MQjdIZYGrgQlZUCalBqsylrnzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7178.eurprd04.prod.outlook.com (2603:10a6:10:12e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 09:13:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 09:13:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/3] selftests: mptcp: add the port argument for set_flags
Date: Thu, 13 Jan 2022 17:12:38 +0800
Message-ID: <8f87b0aa9019ae3cf91772bde09d88321e081df9.1642064550.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642064550.git.geliang.tang@suse.com>
References: <cover.1642064550.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0067.apcprd04.prod.outlook.com
 (2603:1096:202:15::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a35efe10-3989-4861-a640-08d9d674ee8f
X-MS-TrafficTypeDiagnostic: DB8PR04MB7178:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB7178387CC05A8AB18A3016F8F8539@DB8PR04MB7178.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FTGPHiP492v2twj6npS50uH2de30K0T03vN6fRZ5lre0l2xHYjFgo/Ont+Zq29fN4Nu0YFu1/foGQ8d6MiQZTJ8RqEyYyK4vUop7A7l+xn936Yd0RbKPOPYG9LvCKfjXKaHY8PwcWsrLOpSu7rcI9zy7Dfyi3n9SqZxTv7eLj6Kv1U4oDFscKTvJQiVLZjBwbEqVbR5/aDkxdALxM5s3U2PISJUMMEE0adGrFPkEpfyMNP/Vo1r+2o8Na73nppWaTuO+MlqYFqpOIqmid4Hr7g8mQKprmJPfR0Sw1kdtACAcRwwpClwJpA0m610BWtewrocD8ZsphZ2fWeTG+xq8INqoc2W8ID8pAtyZgvf9lQm1dQPfyzbGnqs9RXOBBT/gxqLuX8oS95mLj3vjK5Ug6kQTFeTpq/untFpRNaDxDkLArNSgG6WeODJFq4U8F7odJqAwL9CRd8g8X1OsOEtl2EA+wg9oHJZsxj8ItbdZlvcumM5NgjlXZC4yX/lHigzZLCOdo8kMasV7nUt7ikUBuN+vpN4El/hBxITcMh6o3/mJJ3zgrPGVN0PKxXi+hp0m/4u9KqjS0ujhv2ggGtQIQKl+izMdOzsO61x4uqbaceFenQ/sEq8MjGb1q2PINroNeSNuwuY6fW/tx6B04YDmWA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(2906002)(44832011)(36756003)(66476007)(8676002)(66556008)(66946007)(83380400001)(508600001)(26005)(6506007)(316002)(38100700002)(6666004)(8936002)(6512007)(86362001)(6486002)(6916009)(186003)(2616005)(107886003)(55236004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hixEMzJQCHSY0BVsdOgLVK4bWLY8wP5cQHxwCJLcYTUmTo1Ocofp+IMxbIC6?=
 =?us-ascii?Q?UDIu/5k5lOiG+UStlNDd7WY3+qBzJxg24boPFKKtMgwgyrKeYBvDxjUBepjf?=
 =?us-ascii?Q?h/WrZleTAD31L4elLjAMXjuIWDdWcf7kchPpbnVMWcruH0u9izSkd91AQrNw?=
 =?us-ascii?Q?QVm1h2HvgN+YZOFSvq6t2t4+mrd6UjkRSzz6h0+q7b78E0/124QsG6SPBzNS?=
 =?us-ascii?Q?/52Khh0kUQhWF4yjC+Pqfg0nfeNF2f8OK/iy3Cc5w+cOSGSbzXfVf0vCBbte?=
 =?us-ascii?Q?j3P32/1qntxTr2uTjmgsUVNaRwGde4Cfhewk/hKaUU4bMm0DOzUsifSgbbur?=
 =?us-ascii?Q?lnEGdYczgGlW0XQzrFr+lD9QzrvmKgBpOR2fK1wg4hNw2RD22RQeHW1Lzgus?=
 =?us-ascii?Q?h0LKsZfbmw04vm6Q2DRAS73IMwH2oQhxblgZs9WQ7L12IGYM5/dtirbWwGsZ?=
 =?us-ascii?Q?m63B+LSuPdpRoVWU5ruDHZXLibz4Lx9u0tTm3cmzWFhwpYI3NBVyXGPS4Pci?=
 =?us-ascii?Q?GV41xcuqothHbwrD9lqmyPr6QCtZgY58GnxdiVFncqYxE1Jttoj97hAx/dr5?=
 =?us-ascii?Q?KPPdpPfpF5XYDAjXltH8fTGVyZnzExU2XKXVjnrahNtg1fpoqU6T6yNtXSuP?=
 =?us-ascii?Q?aBwbWyvasQylzDieK9S1ez+rNw/RUGPEBXjBZS3k38wDsAFKQvXf6JrV18w7?=
 =?us-ascii?Q?9vWe5gu+7PJ5nyBjRHUPqF0N5iMraNVhDSxZUZcbx1GCnJNuW+pZM6YqvddR?=
 =?us-ascii?Q?+qWnI1iFS4nI0o8bEzb/zHKWlWD1HfO/W90ColYQjQ6rZlvmjkvxGYThRuSP?=
 =?us-ascii?Q?9q6+kXtS7HE0OgUPNaPdrXuZZRU+STfBo39u3XWtd4I7UcCZp8+aB9OdXeDm?=
 =?us-ascii?Q?rQcnRFaSQtyPRR10sTiePSZSBXcNAh6JO5rDYMbVZAU7FzqwDPzZbDgpjVT9?=
 =?us-ascii?Q?qRRf+MVOXXS0cGv+YAzx7ndnH66BAfrobqWDbvHJo2/LBFK9yjKv5n5I2I+0?=
 =?us-ascii?Q?5Xc0DHbb1vyqAhG+Rp22UFJnoIGaeUvgRFJKEtFt+fgizYauHIMmuUrkY39W?=
 =?us-ascii?Q?J05PzWTcI1z8uMQSx01qPiQO5IMxMUwqnrxHh2r6WM8saxciqXcfoVVxNzs0?=
 =?us-ascii?Q?sErkp5JNJ7g5gYpgZVZYFK0+NjMrIy6HGrk+IZe2hKYwEtXpro1uFZXgDCcl?=
 =?us-ascii?Q?Xse6kHY8pPhVYaWlIC0UM/IAGFo5H5PrfDr5sUx8VUPh2X+ITmkS7WYCzuQU?=
 =?us-ascii?Q?/ftARgcBUW65zwmgoyxRXGOdjPN2nv5Js3eBpIFHXf0rxAs0dTuILd/ZmVTH?=
 =?us-ascii?Q?rCk7LFaA6CfWUDzCjBjG5t7MvcTv3GsejRIymG4k6lwRXFE9yXTOU5xXVZaf?=
 =?us-ascii?Q?k0FQciqeD4Ur3sJ3aIknKFPT74noP+6lxUmHDlJh+i9C7QOysHFjWKrxWKLh?=
 =?us-ascii?Q?ru9joFwpzyy8oeOgyVgIgZKXJxFoa5Z0K+1loYGeSfNhFuRrakcK84gcWsLR?=
 =?us-ascii?Q?e9d5AcAHTF2r/oZr//TlGaeJhjFasQu2b9qDKdbfjTRdUtpV+a9skfwXqjQX?=
 =?us-ascii?Q?y51uWq456UqTuelkb0I1qOFFPJV349WnnX24DJjaQ52eC7+gMkxgKLRdfOxn?=
 =?us-ascii?Q?mtPA29wtSpQ4dYIBYGASKRU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35efe10-3989-4861-a640-08d9d674ee8f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 09:13:15.7359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0GGShvMfOGZFLMq9F0lSjts6FFb2FKneGq0VE0K7wMtDIVEiPQFCFJavzPWe8aDPJQQywlOTipb6Rxngv/nkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7178

This patch added the port argument for setting the address flags in
pm_nl_ctl.

Usage:

    pm_nl_ctl set 10.0.2.1 flags backup port 10100

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index 9b6db9d77223..3c449158d821 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -28,7 +28,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [=
dev <name>] <ip>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
-	fprintf(stderr, "\tset <ip> [flags backup|nobackup|fullmesh|nofullmesh]\n=
");
+	fprintf(stderr, "\tset <ip> [flags backup|nobackup|fullmesh|nofullmesh] [=
port <nr>]\n");
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
@@ -722,6 +722,18 @@ int set_flags(int fd, int pm_family, int argc, char *a=
rgv[])
 			rta->rta_len =3D RTA_LENGTH(4);
 			memcpy(RTA_DATA(rta), &flags, 4);
 			off +=3D NLMSG_ALIGN(rta->rta_len);
+		} else if (!strcmp(argv[arg], "port")) {
+			u_int16_t port;
+
+			if (++arg >=3D argc)
+				error(1, 0, " missing port value");
+
+			port =3D atoi(argv[arg]);
+			rta =3D (void *)(data + off);
+			rta->rta_type =3D MPTCP_PM_ADDR_ATTR_PORT;
+			rta->rta_len =3D RTA_LENGTH(2);
+			memcpy(RTA_DATA(rta), &port, 2);
+			off +=3D NLMSG_ALIGN(rta->rta_len);
 		} else {
 			error(1, 0, "unknown keyword %s", argv[arg]);
 		}
--=20
2.31.1

