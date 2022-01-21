Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8901C2CA7
	for <mptcp@lists.linux.dev>; Fri, 21 Jan 2022 07:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642749756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mh1+GJ41YH03m+peXJAiwF4P970//Da90uex/FQWffo=;
	b=JiNDTGCHR03SkiMQwYMeGDIDIQTcwoKa7hzbMYYGvFNHUUk//X18Vgu3ea6xjVtV7AxLkB
	47q3PkF/5CYD8tNet2152GT6fq8GsVQXXViCVPbI8M144dMkR/20iq2B0zvwC73KeTvvlC
	ht7kZorz3D6gWrxYAVHF9fzDFA3UACo=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-Ce6y-HVsN9mYGWttMs3fZw-1; Fri, 21 Jan 2022 08:22:35 +0100
X-MC-Unique: Ce6y-HVsN9mYGWttMs3fZw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvniApXPOXJxx+L2BOHftYRNurW8dWEs+imHqSjpWk9MGw45C4VuoMku/djQRdTJ1dwVtP7lfRM/DaEemk3e71ygEFjrmcPFDoxTGPCNm6U9mPw82DQoaJGhkgZyh9M7B5awgm41bJ80nh51IzTmVBGQZcIdmzHxE9PpOZagQL800sm6lB15LffcynmBchx9a9WyVN8MVURVV2P2GkKUbDKRqyxxFx8G3wWvxQ7hNi02t+SqEAYoHDSa4sA71SMjYmTdRgF/bp5sd10lY/xKna7GiNXKREG5xbp0I7XPcrlqlFReBtccdcZWaP/jfCzRpz+4c+r4kXQu9om8oGJqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IimvkTFKHlLnRc95wzbXmOuJUlHEnCL21rKjbNB41lw=;
 b=AAbSgLyrJlglNyAXS+dZjgFJixgAoKr3H0pKSieTYHVNSBVCJYXW627ICcGvd50EXoSlK9RV7w2NPMg64YeXQ4lTvSzta4CaIu1oDG8c49ZRZfeE9oWnUbqmviRDizLhV8xt9EIsRKEsb+j6Lb2UsmWMaAxBEcDhcrh7hX35Uk0Dy0AxI4suJzR+RcFGrEeGnhNDTyKr1fBOjSkFcgGvzFcE1Fwbeit1PPa9uRUu4ihDz0Ho0V5bblB60g1ChK+IAK0jZMhGXITSFoyWt5gEXk0mC7RHAyxN9XZXehfSIdEkOFltag946oI6aofVbr3b007W3wVb2kvGGTjGpqkaoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5396.eurprd04.prod.outlook.com (2603:10a6:208:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 07:22:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%6]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 07:22:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/2] Squash to "selftests: mptcp: add the port argument for set_flags"
Date: Fri, 21 Jan 2022 15:22:30 +0800
Message-ID: <60ecb78f43a5f09341742ac6ed8bcfb4d48d0750.1642749049.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642749049.git.geliang.tang@suse.com>
References: <cover.1642749049.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0021.apcprd06.prod.outlook.com
 (2603:1096:202:2e::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2867de7-1de4-402a-70a2-08d9dcaecb2f
X-MS-TrafficTypeDiagnostic: AM0PR04MB5396:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB539683B4FC0E5ADE560AE761F85B9@AM0PR04MB5396.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:65;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KCviAMLW1lLao2CzySC6U3C55n3AIVJzZBRa6/jbP9zP+N0PzyTmQot5/eVRuGBImT6RVEMn5ns3fv/H7+dZJ40qhaaXMPfh6v0s6y1Wy2aJXRxP1yL1EwUn7pTH1dnDUHMfc/P51auLDlduQjmY6VFkff9jrhMORAabtHxGV4ePcgS5wjKWt0+criB5VhEkynebrsqBJMs79RId7pUPUVhN1UBteyI6NmOIc78slgkdAdX304S0Nk5DfOYtZOhuSUV/qkC7tY3AA7lXM7FyiqptS8KY1NP/7PXBqpW1xIQVunHm0/lMDinrB7y0vEsc11ZKGfYPh8mixETrIoh7ft3LteZr3ickEofbu2F1CZRWVobx5k+XU3p6FUkkFDNaUYJClkj9YYJEakoFUDkJqcvaUOckTlbLOnVvpUGyoIQSW6ne9+dKNtU2EA9v0sJ6JQ46P4x8y+R1kZ+u7yNxPGYHdKnlJQtFYk8g8GQHV5UJ/X6hmC9srv4AMvvgBK3ZW7dW+7OViCV8VyUB0/LHhbcM4gl1t6jF4jAgj1Z4xLj8l+tGyynH6UOCoMSAos+pDYXR5eUwjlsN0ZlNJS40NXdWk6geKVrAqYxy/QWitbXNEEw1jX4qQ8ksjoFo6xIsoIP5+zy90KoJZ458aYTZoA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(6916009)(8676002)(38100700002)(26005)(6666004)(107886003)(2616005)(86362001)(66946007)(6486002)(55236004)(5660300002)(2906002)(83380400001)(8936002)(6506007)(508600001)(66476007)(44832011)(186003)(4326008)(6512007)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OHkmCjwzoZgC+tk93NT3XdVWxz/vjOlUxRMnrKhUuyYaq5H92x+KLv0Esblg?=
 =?us-ascii?Q?I/Qslxm3Ygjt9cw4iVk7Pwjx/snGg5JCZ707Z2vcX/uQilnJ9R7seOC1tJe9?=
 =?us-ascii?Q?5qkzT4RO3MuCs9Vps6uxxdbZvaTr70obd35MfsZ8xfaXDLxmOXBEqJHcg9ev?=
 =?us-ascii?Q?lnRqXWCuCYAGsP2aLktr9BdrIl5/wBrp1JnxZYKfoAnVdH7R8SFouOGy/f+n?=
 =?us-ascii?Q?+cqDI42Fw1cGZd3wetV2yEY71/Pe/Vf+wRo+hJHkaJOIMNuVWFVSD/aJHm6G?=
 =?us-ascii?Q?AFARgyBuugZJ4jkGCG4Ev9LyV2AbGRGqgA09HovpOy4nYTNiPkBxjEo5OvyK?=
 =?us-ascii?Q?MAWy4SWtvXGjfX7/vOr4HkV5IchuhJdHKrv061KuF55ivKlP8tsWmDwy5jfx?=
 =?us-ascii?Q?Y/PieNAAoVeNW6CqRNbVkuI7zAjw2kGUBU9fcZRhS65aRyPaMaR6BKNo12Fk?=
 =?us-ascii?Q?FOIXy/gNIKkToGRuiByE98l/jWD/XCQVLkSC+g8ine+GVEz1Ecc5ubhUaFj+?=
 =?us-ascii?Q?UJc9xlU6bf0/coWUJgiskka/kcXXnWUaZ7gZotayGOBlGlAtaf8bJTwAsOv/?=
 =?us-ascii?Q?Dx76XrFwiuJiW8DoqU5po2a1ikQnkHhaPeEKZXmnU5BA0j4LNFlzKbvUHX8c?=
 =?us-ascii?Q?CJb/HLRPKMUAejjRRBxMHQWBmzkIHzce+s/BC6P1oK/teBXQeFGPkVDNANtc?=
 =?us-ascii?Q?paRcsbK7wLqBsplIU0uoA16/5JGqMQgFu1q5s7Glww2iGupr3kZ+h0SQYmI2?=
 =?us-ascii?Q?62fJ7F/4AHy05Hip+I6K2IBMRvlUdxyC5fmIuhVcT4++BW+2ODre7ZGfagqu?=
 =?us-ascii?Q?/2to7PxAk3E+vunGuLwvFmH7M1xfvhqvvJTfQfIe65CI8mZqMtG1NQ1WfS+f?=
 =?us-ascii?Q?Km18CjJCqICSuszq9nEAnqY5Jo23hdn11cdhvC8DnIhfS93qgt100x/lAiyN?=
 =?us-ascii?Q?dd/O7lr4jIW6QWxkaXk8iDnmmh9DhRjNNkkYfzRuQErqN2+ryZEuz1MofdTV?=
 =?us-ascii?Q?tjm7e9xb0CWh9SmZ2qUy+tlCpkr54Gl1w7fvs38uG45VnZPfnlUHRgEiWW6d?=
 =?us-ascii?Q?qSSNxt97h81BkpwEwEan/on1XIJZxRGodjDgK1g9CM5GaPu1Wh7fyZyDVxMJ?=
 =?us-ascii?Q?v3aIwNqfVLePkGHhoei45PvZh54r34sXA8k0YzOxjs2zooBwR/HmJd1KMZWP?=
 =?us-ascii?Q?LhwUoAh+GPhzmZUOuMjyIcRsb+i2dZJgywWt/sNn3/CJZiz1m4Jd0NhXuAWD?=
 =?us-ascii?Q?0Yvoo55xZJY8r/l2xYuSTysUGZ7ZxNWoBQo8bsePEqWeZ02JFECiYfLmKqKV?=
 =?us-ascii?Q?mkb1g+4csInQysNoPYl1Rav7gzuxg3pOxDPxoPQ75ibI0UzVVQWKj8VcgxXn?=
 =?us-ascii?Q?1berd3Y0eJrRPrT0BVLNR6aQlEnExgllX5fqK+6wz/Vqe+yXgbomghRy/Vec?=
 =?us-ascii?Q?M1o4p/FDhLglR7LvjZWsmJxrOQiJrFE0JN8PXP6mMWrOcgBnHlxSu6doVU03?=
 =?us-ascii?Q?WD/OIUdBOLMLqjlAAim4qBDo34ecCwOHoZK8wRDTHPVCmocETHdtcby6VSAA?=
 =?us-ascii?Q?+J9O6nCMhQg3qLnzEe8IkM3uf8uNYV+hEAhkxS2A5C30OeiuD2wvR8bPzfX6?=
 =?us-ascii?Q?ykcTGYZHKCgwms6IhjzPeeg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2867de7-1de4-402a-70a2-08d9dcaecb2f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 07:22:34.4689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/K2yg/2Mz7fFnYe2ejkptX/dr+ZIekgVIQuDfHq6FsWMMRrCWnCzLW3qZF8LPkfE29MACSnmm1LejBQNzfAOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5396

Please update the subject and the commit message:

'''
selftests: mptcp: add port and id for set_flags

This patch added the port and id arguments for setting the address flags
in pm_nl_ctl.

Usage:

    pm_nl_ctl set 10.0.2.1 flags backup port 10100
    pm_nl_ctl set id 1 flags backup
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 64 +++++++++++++------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index 2a57462764d0..e554928487f8 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -28,7 +28,8 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [=
dev <name>] <ip>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
-	fprintf(stderr, "\tset <ip> [flags backup|nobackup|fullmesh|nofullmesh] [=
port <nr>]\n");
+	fprintf(stderr, "\tset [<ip>] [id <nr>] [flags backup|nobackup|fullmesh|n=
ofullmesh]\n");
+	fprintf(stderr, "\t                                                     [=
port <nr>]\n");
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
@@ -657,8 +658,10 @@ int set_flags(int fd, int pm_family, int argc, char *a=
rgv[])
 	u_int32_t flags =3D 0;
 	u_int16_t family;
 	int nest_start;
+	int use_id =3D 0;
+	u_int8_t id;
 	int off =3D 0;
-	int arg;
+	int arg =3D 2;
=20
 	memset(data, 0, sizeof(data));
 	nh =3D (void *)data;
@@ -674,29 +677,45 @@ int set_flags(int fd, int pm_family, int argc, char *=
argv[])
 	nest->rta_len =3D RTA_LENGTH(0);
 	off +=3D NLMSG_ALIGN(nest->rta_len);
=20
-	/* addr data */
-	rta =3D (void *)(data + off);
-	if (inet_pton(AF_INET, argv[2], RTA_DATA(rta))) {
-		family =3D AF_INET;
-		rta->rta_type =3D MPTCP_PM_ADDR_ATTR_ADDR4;
-		rta->rta_len =3D RTA_LENGTH(4);
-	} else if (inet_pton(AF_INET6, argv[2], RTA_DATA(rta))) {
-		family =3D AF_INET6;
-		rta->rta_type =3D MPTCP_PM_ADDR_ATTR_ADDR6;
-		rta->rta_len =3D RTA_LENGTH(16);
+	if (!strcmp(argv[arg], "id")) {
+		if (++arg >=3D argc)
+			error(1, 0, " missing id value");
+
+		use_id =3D 1;
+		id =3D atoi(argv[arg]);
+		rta =3D (void *)(data + off);
+		rta->rta_type =3D MPTCP_PM_ADDR_ATTR_ID;
+		rta->rta_len =3D RTA_LENGTH(1);
+		memcpy(RTA_DATA(rta), &id, 1);
+		off +=3D NLMSG_ALIGN(rta->rta_len);
 	} else {
-		error(1, errno, "can't parse ip %s", argv[2]);
+		/* addr data */
+		rta =3D (void *)(data + off);
+		if (inet_pton(AF_INET, argv[arg], RTA_DATA(rta))) {
+			family =3D AF_INET;
+			rta->rta_type =3D MPTCP_PM_ADDR_ATTR_ADDR4;
+			rta->rta_len =3D RTA_LENGTH(4);
+		} else if (inet_pton(AF_INET6, argv[arg], RTA_DATA(rta))) {
+			family =3D AF_INET6;
+			rta->rta_type =3D MPTCP_PM_ADDR_ATTR_ADDR6;
+			rta->rta_len =3D RTA_LENGTH(16);
+		} else {
+			error(1, errno, "can't parse ip %s", argv[arg]);
+		}
+		off +=3D NLMSG_ALIGN(rta->rta_len);
+
+		/* family */
+		rta =3D (void *)(data + off);
+		rta->rta_type =3D MPTCP_PM_ADDR_ATTR_FAMILY;
+		rta->rta_len =3D RTA_LENGTH(2);
+		memcpy(RTA_DATA(rta), &family, 2);
+		off +=3D NLMSG_ALIGN(rta->rta_len);
 	}
-	off +=3D NLMSG_ALIGN(rta->rta_len);
=20
-	/* family */
-	rta =3D (void *)(data + off);
-	rta->rta_type =3D MPTCP_PM_ADDR_ATTR_FAMILY;
-	rta->rta_len =3D RTA_LENGTH(2);
-	memcpy(RTA_DATA(rta), &family, 2);
-	off +=3D NLMSG_ALIGN(rta->rta_len);
+	if (++arg >=3D argc)
+		error(1, 0, " missing flags keyword");
=20
-	for (arg =3D 3; arg < argc; arg++) {
+	for (; arg < argc; arg++) {
 		if (!strcmp(argv[arg], "flags")) {
 			char *tok, *str;
=20
@@ -724,6 +743,9 @@ int set_flags(int fd, int pm_family, int argc, char *ar=
gv[])
 		} else if (!strcmp(argv[arg], "port")) {
 			u_int16_t port;
=20
+			if (use_id)
+				error(1, 0, " port can't be used with id");
+
 			if (++arg >=3D argc)
 				error(1, 0, " missing port value");
=20
--=20
2.31.1

