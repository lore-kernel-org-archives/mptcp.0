Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74A42C80
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 06:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641796428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1u2C/6PObR0kL/zuwUHKtsuYJI9Wkbcc2D8PBe/scoI=;
	b=NPhzkvPmAxAVgGG8pal2fR3nZhDe8IH/ce099lUPr49ZLLoT2UzQR6bK54O1YC2kLvnUIP
	VpmmszULXwK4o6Lu3mDhC8XLri8IsZ57K/rur6zdqILU7f2hI7CsU6Q9ae28DfMSyCowMy
	JiXipCaW9xW0YbUX26uUJrk+e9VM9xY=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2054.outbound.protection.outlook.com [104.47.14.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-EqGoBZjLN3CCJKZGn1Ltmg-1; Mon, 10 Jan 2022 07:33:47 +0100
X-MC-Unique: EqGoBZjLN3CCJKZGn1Ltmg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsSEHoAtMXYfsR3WMO0QEks3JoklF5MEAB9WJX3TgcOS6bu2fp7qLfK386/Bs6HoiAhorKg2bsy2GH1xMk02xzGZgkFp1hMoYVfgY98WfZuKBPIjEv9kstTn1jOshTSr3XvTrJ+gMbzrz7XzCAzzIgZwlFOHNhXJicadOLW1dVXpSOI9hKuvNmaIgtBV1Sykt0hNaX6NSzbijJx7tEzCrMsHDGpHJ0g0j9ucQw2hLR31ulLdgY6gJNjgbs3eu9yJgjRSa2Jo/uHC+2DwvschTcgf37AHX4XhCiSS4gr+qggAr8s5MXUuz7zNmEgupbM93rDtR/9e/pYO7bltC5o8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGneEOzFeqnCUuwGaslqJ/jKz10I36sAUUyzuiaTUM8=;
 b=hdGB5cVedK8Q8MY5RSHWJ95aV5boUSYGZIEZumQyhkAN69OBrHY1Fo8NGjesFMTVintDSUjPX0W+6pEkQNhMZ4IW0SrJGH/oy9Zu6PyQy+/I+y5notz2Tq1dnksqIZhPNTaDmG+EIZ1RABcQMtfy40qknwC+hOMKJkplmNZjz/v9CszzoM1kFWqlAINBMYXscb/CR9JsKSg1YpM6SVlSRI1yI5vToCXNm+YRCqIKI4az0m/kV7y36TuyhFqU7/JA5lA9dg9OTGlPvYqB2ckGAeqjgWEXvXJdXxMHI8Xax3n/EdAj4e1Ma6yJsoQ3GQxFHUISVGKVyHmzp762jN19fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2300.eurprd04.prod.outlook.com (2603:10a6:3:29::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 06:33:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 06:33:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH iproute2-next v2] mptcp: add id check for deleting address
Date: Mon, 10 Jan 2022 14:33:40 +0800
Message-ID: <7ea43a885391f9d5bc3fe207d1cb2168c14fcf4e.1641796124.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0049.apcprd04.prod.outlook.com
 (2603:1096:202:14::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 031c54d5-dc33-4234-e423-08d9d4032624
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2300:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB23003932CFF43F4A1CC980FDF8509@HE1PR0401MB2300.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pHKxeeQKm2l448GChQZ6SqpGF9A4eEmW+JuNZWSVZ6pkajYhib7Kb8ji0nhbgGjt6kfuTOYDDXXMLc3cKK0HnIZPQMPgSo5jtX4Z/1C8SGuTyWNlx2RRXuyWEIiVNMzEdqOM95gegKo055ffY1O1AJ9877ytvye17MwRIhCoepDCSAIDvc1+SuB79LwQPTakIVjdUGu4kXBHqf3uywUY71/1D1+IMyIlfc8ZFSxHxE3HL5VksvLkxer2+llTMc6aJ+TjJFU8kNuZkv7RM5kD09WLRGqMSrzJYsE+TSqdyVt0C73lLartcSxKmLwRqsFDWFZWCVqDRLAnv3DSRwvNV63d05wizRadof/KiYqb9UwDgw8VpqytOdhq/gKxUSqfjm5gr+TYeG9GayEaMrPIBHn5Qo6GHI+/7xNWl9FsgEEi0ewPQ3pvEqOajOXe7gjci6PFSyD9xEGPhcL/xM3ULY/DuxIFcXIT8vDeAD2I0tEtarLlQ/Xn6wUwWAyOBhhEKlaRkL+U4R3rG5EeUpj0mGgEKmkqcts1UzNasHSR9LUrur0EbM3OzJXwqESYBTdP8gPiGOwROa15RpVQbCZZMJP2x/h9JtNU7eK7+vSOtq89izFpNOtig+jVTLi9m1QnnyMoK0aCIDgL4oaQ87+QvDi6f24nHEzOCeQYgOw2fUNwLtfilbe6LlDjfrvjdi2siMtSFzne+9DMTDMKaboODAIXJ3v7fxcVv1bleFmRcM8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(966005)(66556008)(316002)(6916009)(6512007)(86362001)(5660300002)(66476007)(2906002)(66946007)(508600001)(107886003)(55236004)(8676002)(26005)(36756003)(83380400001)(38100700002)(6486002)(8936002)(186003)(4326008)(2616005)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?84hOfl1B/MKKC/7FmHfIBQeDM8a4lOZ/RTRkynjQ+oc7Xu1s0IwyFXqE3qQB?=
 =?us-ascii?Q?n4zGUD9nb/cM6BT+jBumvn4/d4tfYVT1MdE0Uw98MCEBQcV4p1vmBqRSfgNZ?=
 =?us-ascii?Q?nyc/20LyNGIfUUU3PW6nfzd5F11i1ZRqhp9uLrg40zC7Yc+LfXXU0cxMvI0j?=
 =?us-ascii?Q?6JViteJsNiO7KA65YkX3dHmDzz+pvP+jLUue14qMwZdDZ4o05y+bZpNXRP7G?=
 =?us-ascii?Q?/kYYL5EG0i+Ts1Mmc+7e7suF79pHFXGsvZMOjsWDOURW/kEcK4o0xvPATJr5?=
 =?us-ascii?Q?eWE5BQkA4GsvIwi9xqQchnMgK4J3VlkGmmINBENx8/Dv1Mo4V8Y7GAQm0Hab?=
 =?us-ascii?Q?7BOTU9Oet+e1sJob54UNvtc8d5pTsq63HLLL/tQ8J6w5cUeD3Y9wcGIwfpA6?=
 =?us-ascii?Q?/cUA9QQniJn880BHlS0e0RCY/o/hdsoUffqfxBP/uQsfQWUFXrfrGI0ynT5Q?=
 =?us-ascii?Q?EGhZuyNUrFK73s9WGAqy70gSkHhHaeditW+90fSdDbIft6AAm4QykrRq0CNC?=
 =?us-ascii?Q?v80eUjrR5NK2YODxc0OqYJDFdWEWwajtxz/e0XsL/0Kp5MYFS0fmfbGPjz5y?=
 =?us-ascii?Q?ZMh593cxvjSF8ySc19LG8s/YTXR5KCjohCKtNpV5CXsldU6p7rBrbAF8rcVz?=
 =?us-ascii?Q?yOn0DFRzxSDyxNPvYWc3E3wK8BRD8TtzFr0gTYjJ9hDHMfhO0DcZxKqu+BKd?=
 =?us-ascii?Q?hU68Td7uQRBbGt5VfzjEOARoGrzpowiFQZdoP0+X4W/DO5ZRBkpZse0UO4sD?=
 =?us-ascii?Q?t/oGvbz4bgGNTaJVaH/zh8jI0w+UBjxREFxLr9jx4MulW3S1hIfTs+k+33Dv?=
 =?us-ascii?Q?K7Nf5LuFvpOVVqkX7H8sTYgAjAyTYnFH9Gz0wK8uynowei29+5z9MRMUAgLX?=
 =?us-ascii?Q?nx6ECn42bdHor4XIGu1IQI1e57b5yccm0zXKOmM+iYYwv1uqnOfT9Xe5rQw4?=
 =?us-ascii?Q?nIExX9BgqWi6AwJ+uqvISPPf2NHw4rvboYnfwwqj8a8ShxfYXc6RSh28Nx9y?=
 =?us-ascii?Q?v0BowZs8hgTohj/ODYceHCHOzzi0KYGoA8HkDErFjhiduQopZ23vi0wxO+7U?=
 =?us-ascii?Q?O5J1FcNM+yFEkB6h8LhhG8urDwucTsCccivMTnD2KO4LZ6IkEvtyIQIEE3w9?=
 =?us-ascii?Q?LEoo3pkOiUVPIIh5oBPuQGDGfeydii1wHWVK4NeHISDUvjFSZVrwx8/i6lHn?=
 =?us-ascii?Q?ZyZQ7xoTBRxsQyquRhqqpdxvZpqq+LoKg/t1KyKenuDL6OlGb6dP3S6M0VBh?=
 =?us-ascii?Q?uGaw2sfO0gews7rNbyc1Kc5Hi4D4Ri5fRkaTjC4vhRu9GH92LNrhQO8f/DqE?=
 =?us-ascii?Q?fszzTi4w0fcb10aGFS7KFnD2gj9y0J3Syi0Ocn+kh4tIt04HhWQoK55WGaxx?=
 =?us-ascii?Q?zUAC7b/xYZTVou0UyvF5OBNGy9jGjYJZWTyXsu3DKSnKC2UwPv//cRJKCq7d?=
 =?us-ascii?Q?P6J36UGIfKMsKOZ8fJyr63PDSODJ/P4gcsDZ6HCMGYZHoAvlzm/NCe/hmoVI?=
 =?us-ascii?Q?yXU5r7JSkVM+fnjcfCpzBHZAcY6OoiqCvnEwvfRkQY1/OtrE2d2eiv+9Ccy9?=
 =?us-ascii?Q?Plb8Fu7xeJ3WMs8/MWxvfEp6Mi8U16VMP+IoJJF6L1LVTKT/KzO8rlUvqwXm?=
 =?us-ascii?Q?sd97FYA0pLp5R0Kd74xcudI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031c54d5-dc33-4234-e423-08d9d4032624
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 06:33:44.3327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gbl+urkX0zaOvQWWXeDuphFwq0aenbQWUNTkdRXiCtfkFivWWlhzWPSuhGBDRqFah/9HXGcW+iAxOTcvTE0N8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2300

This patch added the id check for deleting address in mptcp_parse_opt().
The ADDRESS argument is invalid for the non-zero id address, only needed
for the id 0 address.

 # ip mptcp endpoint delete id 1
 # ip mptcp endpoint delete id 0 10.0.1.1

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/171
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 v2:
 - rebase for iproute2-next.git
 - drop patch 2 & 3 in v1.
 - change ip-mptcp.8 too.
---
 ip/ipmptcp.c        | 11 +++++++++--
 man/man8/ip-mptcp.8 |  5 ++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 10dcb1ea..f85c49a8 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -24,7 +24,7 @@ static void usage(void)
 	fprintf(stderr,
 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
 		"				      [ port NR ] [ FLAG-LIST ]\n"
-		"	ip mptcp endpoint delete id ID\n"
+		"	ip mptcp endpoint delete id ID [ ADDRESS ]\n"
 		"	ip mptcp endpoint change id ID [ backup | nobackup ]\n"
 		"	ip mptcp endpoint show [ id ID ]\n"
 		"	ip mptcp endpoint flush\n"
@@ -103,6 +103,7 @@ static int get_flags(const char *arg, __u32 *flags)
 static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int =
cmd)
 {
 	bool adding =3D cmd =3D=3D MPTCP_PM_CMD_ADD_ADDR;
+	bool deling =3D cmd =3D=3D MPTCP_PM_CMD_DEL_ADDR;
 	struct rtattr *attr_addr;
 	bool addr_set =3D false;
 	inet_prefix address;
@@ -156,8 +157,14 @@ static int mptcp_parse_opt(int argc, char **argv, stru=
ct nlmsghdr *n, int cmd)
 	if (!addr_set && adding)
 		missarg("ADDRESS");
=20
-	if (!id_set && !adding)
+	if (!id_set && deling)
 		missarg("ID");
+	else if (id_set && deling) {
+		if (id && addr_set)
+			invarg("invalid for non-zero id address\n", "ADDRESS");
+		else if (!id && !addr_set)
+			invarg("address is needed for deleting id 0 address\n", "ID");
+	}
=20
 	if (port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 		invarg("flags must have signal when using port", "port");
diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 0e6e1532..1b8b8c7c 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -31,8 +31,11 @@ ip-mptcp \- MPTCP path manager configuration
 .RB "] "
=20
 .ti -8
-.BR "ip mptcp endpoint del id "
+.BR "ip mptcp endpoint delete id "
 .I ID
+.RB "[ "
+.I ADDRESS
+.RB "] "
=20
 .ti -8
 .BR "ip mptcp endpoint change id "
--=20
2.31.1

