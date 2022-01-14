Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FA32C9D
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642156042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Edt1p9KSDoya75M6IGXtjEKGXl8SOfJIAkR/V+wo6XU=;
	b=YK5bt4ZstD9PFtLVST4+xCkh7EvhIryfda0QriQn0u5M/eUjNjJBFHq37ndxl18b4UAA+v
	cVmfFrjgkn5qG+eU2Z1L22H7ZgB5k4LUaJ9Q9m1VuqXG7S9LkD6V20dU0iU46iFt0TvC4X
	1S5skpg62YBTBiy1JLOiqPmABIBVDoc=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-ze8uFsgSO9KXTwRyJwGNaw-1; Fri, 14 Jan 2022 11:27:21 +0100
X-MC-Unique: ze8uFsgSO9KXTwRyJwGNaw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moh4V0Jr2AKaGId1gelwbZsZZTE9Tw/6NmVCyWp6a7vp0xBjdf7zIdAMWfvQO9ca3Vk/K7EFsLQ6tnMx9ArP10dnAiy11kAiSWTrM4bamQCstRXaYiVovIgxlwjEI3yHNUUYNVKd5SjuJAoFl7qWBk8nUraktqDt7Qmismkxn1tcGumk87yLHyZfB+e95fcitPTF9mCehHINhEBY7+FYvRJVbsW+uTMGigGlQHkly5shXYsFacY7EUc+uf0Fk5iPpQEaawjuUpFyRL9XoJbNmUe32ym080xPbdD0M3LSeXqoRUmx2uLrE/u2CxlEXZODRJ4s4fdQHk4oY8gM9hUThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2ju45BwrOeaW84wTo2BgVqr4hubXPkYYwiKW/v1dwo=;
 b=n71Fuz9oVhiGROrmTkQXBQEMmOmY1MCnkJJwPiVE7smk6dac0JD1Glun2dBlncDBeMqHwZICW+w7ojJDpHmj6hqYz7tJ/S5iv5a9HBlQ8GG3iXq48NU0ce/+CMrQBAgXXWtZHSthvTeJrtFXsC+5WUAuO8nNoffeBohX8zyrsh7IQkxxfN++WJ29qgeP3QSZhX5pc7upz9d3ue7fzelEiR/qAxLuyR867RYcmzkSeBuoZHPzuWkSnsE9gUAdo5A5tpJsSk5UrKLN7luHmdZsTLbaZeWjocDpi8XGj+Pw+V24qx8arfb1i24Px1EjJD+vbzhDMfADYv/312U8ThCMEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB4317.eurprd04.prod.outlook.com (2603:10a6:803:3f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 10:27:20 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484%4]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 10:27:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 05/11] selftests: mptcp: add the port argument for set_flags
Date: Fri, 14 Jan 2022 18:26:24 +0800
Message-ID: <a8298701ddea369b38bc54be4c48b75f0d41acf4.1642154579.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642154579.git.geliang.tang@suse.com>
References: <cover.1642154579.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:203:b0::33) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31733b5f-c98a-4afb-b9b8-08d9d7487239
X-MS-TrafficTypeDiagnostic: VI1PR04MB4317:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB43175DA4C7858786B5DD6191F8549@VI1PR04MB4317.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0tw/i1dvQnyKDAg/YYm4vYgX5H2ZAwQ35inDCpWK0YpMmsfjc6uCsP+tGQ5pdFClYNFUwIvk9vRmIlgdyQiTHfkCqG/GcZrIB94+BO3MAJ+zE6gawJFFssY+iZWiGOkMS/Z5WjM6UExki7YNq5IkAuBWrithWRmMJWAOOxQaTNfxo9hMsrgXwGi0+almlPJmCt7p6MCKmeQC1UOxVawUsOV8fhrb02F2vYptePrg6QnklZstZ4ZhfbT66mZl61WzvHurUkiPkvVqQw1uRtnj9tyIUFeA8eTDF9RUMQfOsYdi5uCP7lejg08N594bQOue8p4uZ0rx4Y3w41Oa1CTqJwVFX1Y3ng2UUQ4eEAfCAH8IV9LctuiGwCObFzbuo+unueL/vgjF5g/lOgO69tFbNLbWVHan1TSFxtMD4qD60j/HEzjQ0HE8RUTv9lQo4Zs1VBcebp88faU7eMZreuWDlBbYlv7XieE6XtUjBEIAMX5CkqEQ3z61gBegUa//sMPsCs3hmYvU9I2UhJAxwkBwEpoWBAh0y1q+ogd10nvoUg7Gpb34gMzzCOW3crHiwXj0uGJWEqP37DCa/9xTSDrIuMtPtdHyFFFMNHrKJrsnMx4TiKm5CBHc2SHEtnJD7cAwpWs4VCWqvdm+diLv9LLZMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(55236004)(66946007)(508600001)(8936002)(6512007)(6506007)(26005)(2906002)(107886003)(83380400001)(66476007)(5660300002)(36756003)(8676002)(186003)(38100700002)(6486002)(6916009)(2616005)(4326008)(66556008)(44832011)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wrTV+FncZHL9EIMAdIEoZ1BfsbrJ9sIUxNdjeD9RFErOY+49agpr1KmwlrWx?=
 =?us-ascii?Q?SwZGlEsPv+i6Q15Yq1MaJk+ia/+3mXFKgm7nWz+87NEiJJucCSZvYls3FCcX?=
 =?us-ascii?Q?Iq81zoAGZ2n4/sGGIIOuqFOQfhfs/pNCmSdvcTxSWBO9nDGWH+p/4YpXrXff?=
 =?us-ascii?Q?zLu4u6qng1zYIFHE7NjZs6P9/RY1Fz4KhpYuixdX9yDT8x/HzZHTh9XG67Wh?=
 =?us-ascii?Q?RSU+0VdmUVNifbrJgkgCG+4wrfAajEPkhwrl913Ece1/kNYBwDv0beU1la5/?=
 =?us-ascii?Q?Eg+bRk+vmYWYPlNQJiVhrH76Sq2rzQc2bFw8q6ZWy7hhJFWpmZZy/zUizIp8?=
 =?us-ascii?Q?HRUFdPofebMyP8JVwd5NqrMGzTg+/8/gstkg9hALYDfQnxPeVHE2fQh3Nb6O?=
 =?us-ascii?Q?xbyh8Nx7aB+pe9D0hfIxNb2XX9SynXim7pN5dRFN8fwKbE5f/B7xgOgklbP0?=
 =?us-ascii?Q?eO69HLAa+7CcesdPEQ2hiyFq67bEP24TEcmZxsf0xWrQbfRU55jw8PcIO8hm?=
 =?us-ascii?Q?7blYOUNHERoezWJQ4LKSSaOd8Oj1I4OydKDbp8vcoZ2xG0Ps55DWUPG/O6yJ?=
 =?us-ascii?Q?B+5C6j7nW0sCSJQevGZKv89ePQHM4LUSByIpqTh4MgoNBkmeGCryrNxT5oVF?=
 =?us-ascii?Q?PcZE0ejrdtrlUI0xJzwU4+/kHRjDbDIhtjRjgZY06lYPmCq5HSrMEPTxz1Gp?=
 =?us-ascii?Q?TWqwk8He5JvuHAaqBx5pVVDT0+2QwaNYU1vP81iCdt10Tb4a46rFkCcMOeR+?=
 =?us-ascii?Q?GsKTG+LT9/0CPK8Jdq7HVMLbusNjurIFlbvDcU8ESQF6jpryReh3ts4MsnXT?=
 =?us-ascii?Q?YLl18B7OwsH6ORBBzt+CtDAHPXlss0s/aqfBkUNbNN5ua4JQVlLlWHgeHKfE?=
 =?us-ascii?Q?zDAFEm8WEXRJ+Jv0qn8jZVw+TJMKr8sDl+me7uohTwHrIP60sC8GYtTMl/Jo?=
 =?us-ascii?Q?+Mb3J/1RibSP9/xd0Q2cqKDWZX/WQbSjifbieMkmAarkoevZaA9S5ulbpqBy?=
 =?us-ascii?Q?0bfnGBGuF5PnWD3gSp0cmf2YGIIaivOsszUQoCTxXEZqGfh9aFak5A/WXr74?=
 =?us-ascii?Q?ULktbCivcCsB3zJKEga+ABFRZXAUtVE0wtclLwOBeKRR9bh6JKz+I1u1MG8s?=
 =?us-ascii?Q?MoH3DIsxSwovMdKV1cM9eIQXXVJmalpLV48edzIGX6K6bw/1+lPrKB/k9SKY?=
 =?us-ascii?Q?GwwcxQlmfY65a2EccL8mb45l/mtCBrqfqNex65vlAh46EA2kxr+7ADPrLuz2?=
 =?us-ascii?Q?C4I7JdUi2AQF1VcYXGQL3FiV0Y/TCejyVRzwML1X9AB5gUlvCR9vd2lTjEGe?=
 =?us-ascii?Q?WiZi5tIn+um0IsuDTNOl4olNKuibuoLCcYsd4Uj37sJL/Suz5bgl6fNA3auY?=
 =?us-ascii?Q?+laH9BnpfaNjIroIKc1JLzJxjDJ+ufy1SpjqeJ8OSvNIqM2tqNC7NXdmD54d?=
 =?us-ascii?Q?ZwDMJmcrdkaVaJmcBAg19vgpFUArtm0x33FC6Neo6/tmDlL8I8hzZLMcubqX?=
 =?us-ascii?Q?mNxfTchVJUke82lMYSlzqOwNehAqRcGTcEqHPVdrr0IPzsYoLBw79mYoB3n4?=
 =?us-ascii?Q?zNEzmiDXvQeRKdbdqNV3d9YEZkVK5cGBK+MqbYTEeVM0P0+zpsfMTUMsBw/4?=
 =?us-ascii?Q?NCs0WiPN82ARDyp8HnrtpYQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31733b5f-c98a-4afb-b9b8-08d9d7487239
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 10:27:20.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBeM6GUewB0+ddUKYkwd/tMxgWO2jk/JcvG4OS0JWA0v2yrlnCD8nywOGjNeSkEz/pvFqW7sjmer5OCrqJ1RlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4317

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

