Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A782C80
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 04:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641874890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CtYIw5SrGPE6/7KkD2ZE8pmy2g5qjjvgINpjRdi13Wk=;
	b=l3eZhZ9AzAp+FeMpY/Ent4IiiOkFJloxiHYVAWk9fv0dVot/bQRyGIuad1uqgoVrWykfCl
	og5jfi0QoD2drs5QQFYTsmPhFsRYSMvVE70Ti/57IZGEp8VLfD0iWbG03/N0whhVamC6Mi
	6RnoyaiQOVZ8Sab/M4B+VeFEUfNk7Os=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-2oZFDkQ3OQ6Ey5S27-jfNA-1; Tue, 11 Jan 2022 05:21:29 +0100
X-MC-Unique: 2oZFDkQ3OQ6Ey5S27-jfNA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+7UFA59PvnUZ5NHK+9t/blEkttnAKwEN/oKFgOTfJZQBH1TRc5DBq4fu2By9Lt+ySKRy08nx0vcRV3FADffFHBEKROuAYQ7t/e1skB+iBgmWGLqmJiygmV9TtG40bU+2SxWrtyFUeLO6g+j4CUBvXSyxKYeujbznqTwQFsZM6A3rELqg5p5j3R7fddTWL7GRYt7q4poDKMatwbE7oUlMxExW2J/ha1cNVGk5wi4PU8XmGTARe2JfubRw73Up955dsuVs8kIMtdqG1XvIUP8YOma1P1vVz6JjcVAFGHfZJgWWbZ9Nj9WG0RHHTzePs6fCLAIObFjY/GkAaJRb7OUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/5oEB50v5hPSC/qUXouC3OBI2fe4+qKUAYKmkcycYY=;
 b=h5e8MZiWMynR1ZFUnWzNJ3iMYx2KeTodS4NCynKO8f7rcNPS6ZDYqZ4ty6QIHHCoeiAp4flaTZKbbRQQ47LE+iA5JuNgysEz12b7y1UZzP/MgrIGrQx7sBzOVg7rPhxeUWj19jhvhdQWDgnkDQEiMmKmUejqqw4u1N+dfK+pCm0fJsioMme47uJnwOl7lcLW/nTEcwPLQMSV1YFFa8gawuER30s9fA0ZI1pr7BAkmZLVk1bnzUpTV7JT6Zc/3D2ePPWtnxvB6eRfRi5AWYoGSLgyoP0gUNsHf7UmadefvU8xdXM4fzQV3SofkUWnl8K5Owszl1X2+MxOPV22mBJh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2538.eurprd04.prod.outlook.com (2603:10a6:3:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 04:21:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 04:21:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH iproute2-next] mptcp: add the fullmesh flag setting support
Date: Tue, 11 Jan 2022 12:21:24 +0800
Message-ID: <486154c16da9bda2242dbca2e069e9d1a129d5ca.1641874818.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 366396c5-71c7-466d-239e-08d9d4b9d696
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2538:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB253842F3C714FA68312B9F47F8519@HE1PR0401MB2538.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DSM3krj5X8gaENBUlOs+US6BNabLz6HxR+L2vjBymlTlw0THw3aUmHniVOBc1R2R1SQ67K5Nf3dtQBo1MfI3czoHx9eov9l2g1P52WBAdEQX7h2okPEi1WFxB16b4wh4sfZ+dj+MCdjwmbl9cUZKqCtwRlwK/XnMAAKsqrpwmEMW9jFOZTqD2jtXgT6RsRLFVtqlPX/COwKEmm+0CpVXklVFDGHUEgBuNlWs6MZP0ew5+jtkisl9MGZZ/znt0J6NhsDAxxJZdAU9sn8C+Gk4Tkoj+eN4gKc6EYi4BtmWzbIn7tLo8QrZE3DKoKbDN6uZKjlCgHcZtFFYkjbQsdetSwpSyoA8UCoUi0rDQICPX6+t1qeGI4B2anDJ36DlMVRGYDHIgXx4+4sSoCVLglrg8npSmTutTrhBsuWWpE5TjOEvsA6RlSaTlcBYK/SQWpg78yyk0thQEF38L0xB3F8bn+3u8okwduqHS4OFeQ/F5IpZ9+PLF8R+gXtCW4fICYBL+Ti0FsJWgvetMMhPXWswC2XosrBBuIdS3bE2xeKRFZzaiwdy+RAej2aiPxkcTsvHdbAJdcrnvSPt961vTEXVKAzsmim8UgKJ0Ce4U/2ZxXNdSqkNofZTj2xv7zqZfoVtjtBo8nlnkXySfidyVef75A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(6666004)(86362001)(36756003)(107886003)(5660300002)(66946007)(38100700002)(2906002)(6916009)(6512007)(66476007)(6486002)(83380400001)(8936002)(66556008)(316002)(8676002)(55236004)(44832011)(508600001)(2616005)(26005)(4326008)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DEkOobr9BxGSdhliAQu0dbKR8YK6HyeNpiq/Ya80UeZAopvoysxfLf2zS8aL?=
 =?us-ascii?Q?Zi0rRF9UpI6yVJgOeL4gcvbs3WUijMQ+NXlnBlMdLsoY6BcNeTCPJmRDlNgV?=
 =?us-ascii?Q?hRf+o9oDzstcNzFqXDT50m57q4nzaC6kVCA/sjgcAeKfNbS7p2vCN4iene7M?=
 =?us-ascii?Q?484r9XPSsfkwCVQEJx9hdYd7BqKuiuuSF2lxOc2ahpsDconVQPqhYHILgI3T?=
 =?us-ascii?Q?+f64bwZ2PcaQX4bCnFB/QZiJZYum3ha3LbWiBWH9laN7VdBKdzq+SfTxLXAy?=
 =?us-ascii?Q?lWQAx0pMN1BAT+IM03lxHZlA3v+KXvHbyL08ymFO2M5VG5ZLWb9UZKBUWHvh?=
 =?us-ascii?Q?1ZnITGNG6t8nvnNB1o7fLSczNSQnzGTog32dgvWIPl25UjBb2duEj7Ook8N2?=
 =?us-ascii?Q?wwD7UnWHCqHKe02L9iqCuXAMITYla/T3j2iySc1G1Omyx2dT1pJ1lcAg4TWq?=
 =?us-ascii?Q?9YzesYoUWQDFIT5WkvOpi2hjmi4v0r+pIlyCqNyCaGxYYufvk2NHWVe4ZMWE?=
 =?us-ascii?Q?MsKX0rg1eozWpjZfososl78qJ6QEaIqm7qwW73bvf1wqED91O4pQt0MuCnRc?=
 =?us-ascii?Q?Gv4zEyIqHkNihE8YGPOkO8/ZHoEuv3Tb6U7uGE7SEKoLwpDbxVZKifjd0jkN?=
 =?us-ascii?Q?vEHHUsCh5hY+HriFbKYYuUdUV5VpM3ujdAInkQ0y39Wg/G9F29YaUHmhVSU4?=
 =?us-ascii?Q?b+uNXM0omGPJdf7plsPz/WktdLj/NGouwqcC0tH+RdCzw6gGjpvgcnkmtyWT?=
 =?us-ascii?Q?jQw/2DNv8dYJpgDc6iOeBCDyiXLSpGz6QVdQ18CGsCY/5GYLG1xTBldveQ6G?=
 =?us-ascii?Q?ZjwMXic/hLYbezeQTUp8OoYTGG3fQiCQbUrh2Gjwf7nrs/kFw63fTyvuPLIY?=
 =?us-ascii?Q?QJ/2kkAZPtf2v+SqiY+c2/gZ5EM/JnjDsDFsttqnxTWOCEDmJU34ZC3zwNS+?=
 =?us-ascii?Q?SxMs64MWWH0MDKNI6Bmqrs8eaviq8afGlkChNYUuaLkAlLNuxoffc5V3VQwy?=
 =?us-ascii?Q?TQiYkoCASfLQlYczZNymOtWCJWl3xJPCvDs+CP+F+n8PHH1kltT3C3Fbmc5M?=
 =?us-ascii?Q?F1R3S//GWwZmd0VivWZdjV+P6Xyb105i7ZMBetDp7VX+wtDq2aNQvF5Tl4NB?=
 =?us-ascii?Q?1Jt0IOQMifpPHA49TMuASt2giQWePwRdfbF3HlQP0SuoLTdZR2HLv/T10vBW?=
 =?us-ascii?Q?y6A0Tjv0VRkJp1x1UNjteO862afVUebp2NquRsGw4wbYYqtCqvxhhvd6WK+t?=
 =?us-ascii?Q?pp2e5d7iMrYEMiZ74ugDOcEK8jz9nwH87b0SyErebiYVG3lknItjzKDwbUS9?=
 =?us-ascii?Q?t9kRVrxI5eQl42gdHCgXc0pGs3N+pAYcS8t2ZiGPr/KZVe421ZC5IB26rvKA?=
 =?us-ascii?Q?Cf3cRe37lVsRx5P2zm9cQzHJxnc1K+zIzmhO1IJ7CZAMPULImBNrBClFjbRr?=
 =?us-ascii?Q?i4p233Qo+Q/mZipQfNIVlDowXagkD75C1sH+lfJTJiv5WlXh3tX8P5boUeeA?=
 =?us-ascii?Q?EXepYtD0R+ZmYhAVbLzKNjLsSCWYBfn6Z1IdfyqiPqILn7cL2W3jX8CwStjw?=
 =?us-ascii?Q?QYwMhOYdKbo7JhvSGJbhdIHdXduvB4FUQId90sE0X1WT+H1EUlTcQWp7xb7c?=
 =?us-ascii?Q?Fk2BG1lD7IILr/lLY/AMHvs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 366396c5-71c7-466d-239e-08d9d4b9d696
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 04:21:28.5556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNovShDo0XTi+VvWDex5G/WjhllQ16qY3C9p0kWjvKRzEK03toXqLDxoEYSm6uGs+/YG8sxYx8MCmY5C/24M0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2538

This patch added the fullmesh flag setting support.

 ip mptcp endpoint change id 1 fullmesh
 ip mptcp endpoint change id 1 nofullmesh

Needs to apply the patch "mptcp: add id check for deleting address"
first.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/uapi/linux/mptcp.h |  1 +
 ip/ipmptcp.c               | 10 +++++++---
 man/man8/ip-mptcp.8        |  8 ++++++--
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index cefa9a91..38e8c832 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -79,6 +79,7 @@ enum {
 #define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
 #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
 #define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
+#define MPTCP_PM_ADDR_FLAG_NOFULLMESH			(1 << 4)
=20
 enum {
 	MPTCP_PM_CMD_UNSPEC,
diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index f85c49a8..ee786537 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -25,7 +25,8 @@ static void usage(void)
 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
 		"				      [ port NR ] [ FLAG-LIST ]\n"
 		"	ip mptcp endpoint delete id ID [ ADDRESS ]\n"
-		"	ip mptcp endpoint change id ID [ backup | nobackup ]\n"
+		"	ip mptcp endpoint change id ID [ backup | nobackup |\n"
+		"					 fullmesh | nofullmesh ]\n"
 		"	ip mptcp endpoint show [ id ID ]\n"
 		"	ip mptcp endpoint flush\n"
 		"	ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]\n"
@@ -57,7 +58,8 @@ static const struct {
 	{ "subflow",		MPTCP_PM_ADDR_FLAG_SUBFLOW },
 	{ "backup",		MPTCP_PM_ADDR_FLAG_BACKUP },
 	{ "fullmesh",		MPTCP_PM_ADDR_FLAG_FULLMESH },
-	{ "nobackup",		MPTCP_PM_ADDR_FLAG_NOBACKUP }
+	{ "nobackup",		MPTCP_PM_ADDR_FLAG_NOBACKUP },
+	{ "nofullmesh",		MPTCP_PM_ADDR_FLAG_NOFULLMESH }
 };
=20
 static void print_mptcp_addr_flags(unsigned int flags)
@@ -118,7 +120,9 @@ static int mptcp_parse_opt(int argc, char **argv, struc=
t nlmsghdr *n, int cmd)
 		if (get_flags(*argv, &flags) =3D=3D 0) {
 			/* allow changing the 'backup' flag only */
 			if (cmd =3D=3D MPTCP_PM_CMD_SET_FLAGS &&
-			    (flags & ~MPTCP_PM_ADDR_FLAG_BACKUP))
+			    (flags & ~MPTCP_PM_ADDR_FLAG_BACKUP) &&
+			    (flags & ~MPTCP_PM_ADDR_FLAG_FULLMESH) &&
+			    (flags & ~MPTCP_PM_ADDR_FLAG_NOFULLMESH))
 				invarg("invalid flags\n", *argv);
=20
 		} else if (matches(*argv, "id") =3D=3D 0) {
diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 0e789225..bddbff3c 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -41,7 +41,7 @@ ip-mptcp \- MPTCP path manager configuration
 .BR "ip mptcp endpoint change id "
 .I ID
 .RB "[ "
-.I BACKUP-OPT
+.I CHANGE-OPT
 .RB "] "
=20
 .ti -8
@@ -68,10 +68,14 @@ ip-mptcp \- MPTCP path manager configuration
 .RB  "]"
=20
 .ti -8
-.IR BACKUP-OPT " :=3D ["
+.IR CHANGE-OPT " :=3D ["
 .B backup
 .RB "|"
 .B nobackup
+.RB "|"
+.B fullmesh
+.RB "|"
+.B nofullmesh
 .RB  "]"
=20
 .ti -8
--=20
2.31.1

