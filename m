Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C552CA2
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 03:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641785437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2tc+66KT33GCVYP8G+PwNx6zoVgWOK1ifukrcVW/7Q=;
	b=EQEqn8E735s+bcvTEL+nPasRbTzGAvQdFjiyaxS2rJ3iYEHTqCGbArIh2MGv4oVx9Hf45w
	t6pPnl6gwN4waJ6zLUtx2t9vITS6eg6ogRMDMHgWBwtv9cxbv7uqkiESfu5AqqkhSP5X73
	Y4FWraxSojwWKMDb75Z4jgXBeq8Pelc=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-CJPq7SPTPDa50GnZZVmUtA-1; Mon, 10 Jan 2022 04:30:36 +0100
X-MC-Unique: CJPq7SPTPDa50GnZZVmUtA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzWB4s24bB9cytfYh6LLigr4prWGULcRQ84VAKoRzN3TFMhD3PMIkTTLxSXXnTtuB87k1yLbMudNCmZ/rH5WlM7teVsgwT/3Xd2cVixHCX7prv5DP19Oq8AatyK1NeaepeUQC0nA2saGtlUzfuRSLJh6TBQ7IWCXC4+qdfj7fZR34NEiG1P3z44L2BNg4ROQfGbM6PgqjvL9WxA5LGpEJ19wQQg9xOBT5RyCfQOEcIjUmEs5ol0NEsQpJ4M6WSeSqhcrvTohKItj3LRGuSe0ldhqfzjb1+cXJ1puNjA8+e03EwvoQ1eKpDycA5Ozvycea4sX87+eZBV16VOuzmyNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4axp9dHSMGDB6fPMaLETwbyUfpUE40ILeaW5EKXROBQ=;
 b=X73F1BPvRF2hY0RsZcYB0YzKkd5+RbzsOw8EEPlotIZa4rM7x6LqITHE/tWavXI40QFiyddj12Jx/PAPggshQI23LOmy6eCyThhLB6ITSGRmcIydQh8WW1PktymxeymnyqQxGrBQ5gIA/dO36/o3fD8e8paivFf8bgVDs478s8IEW/ojTJMAPg2TpnCcNQsf1VwkF3vmuVGpkHtj/Lue3I6uKxsYGJke6QapzWAW+6RH5HFA6uJt0vw9Esr5lGr/+EIgzcHUAzWTj4NFbHiWNvfHTABGRWT+y+wQAOgUAupa4q3Cnr3koK4hkZv1QFejyTPoPxuyCT5cI9oowWvs9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2569.eurprd04.prod.outlook.com (2603:10a6:3:7c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 03:30:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 03:30:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/7] selftests: mptcp: add clear_flags in pm_nl_ctl
Date: Mon, 10 Jan 2022 11:30:01 +0800
Message-ID: <13ad22762471ff0b8e10fb4c2eca39c106f80a0f.1641785106.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641785106.git.geliang.tang@suse.com>
References: <cover.1641785106.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:202:16::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebfc104a-03dc-425c-9c37-08d9d3e99044
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2569:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB25696D31F7500B77E6869DD7F8509@HE1PR0401MB2569.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CL9fs4YjBIP7sslOX0d5PZ1wuwnMclBapDrrvuNHaLVdmOZf1pbyh5zQgRy5a44Sk13BwEmY7RvRpnIkMiyOfz8qFSN4RbAowlPojLi2HTuKWlA5wlJABnYpiW7t7cWgBkCc6Hqen3hINmYlxamQEj83WBp4tEpodTqpbUM0BlzJp28JlSYuQBSneenc92ykSXv7F0YPGT/lxnRD0FooECQFWc7gmrLu5SPgEgWi6eaAbLrx2bZyIcvc+hDVhYRM50+uSnA0Vk3otesiGAE9C/KLf9LiAWKg3XCUQzIGQ6H0PQRWqmhiMpduDzXGIi7kcUUnC37XWlm6v1KHMbddOZzrNIoMkEKn3Ic42O/pPYK329BXSXijXaBSzhdGunQkmm4hjRnDYgkk4gw2VeWhKWNGiOY/RfgRQWfEzEK0NrUa6A3iFVvwZO6xCLl83qGybaDiSvW3DY2t3q5J7TjzlMou+27ZFEq3n/eofNfjtmWfTOTV96+zsdg/D17FIRILCmW+GvOfrrUHOhlODCf5UHXH4fD1G4KDGlo2zPwXxNz1JBmcPIJbH+02AZuTBc73TJOfSFhYZFIZ+Nbh564xJsxxQ5xXyy3spLk+vOUAgzF6jfglOFOmyo/9SUcphik31833LMnaLGgPtUBirAkHcw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6506007)(66476007)(83380400001)(66556008)(6486002)(66946007)(8676002)(107886003)(44832011)(38100700002)(6512007)(2616005)(2906002)(508600001)(8936002)(316002)(26005)(55236004)(86362001)(186003)(6666004)(36756003)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wtNDTLwLTcTRClvlriDAQ1pae0fI40NvXN24v6uQFe6tzvodfr+JWOF1vz8G?=
 =?us-ascii?Q?lO8Ga1g/7epetZWuxVHH+o+aWk6ePr5bd3Jmgo/jIgRSL9xNPvTDh0BCytvd?=
 =?us-ascii?Q?tYCN55ro/W1siTtCjmXh0aZS0pPM+RGSch5cvNVnHeN9fs81dGm/Ro19akLF?=
 =?us-ascii?Q?bzztPOF9GapAeYMwoiFt6o7UOQBWY79qMUiQFy+dYgYiX1hGhIhkHEEGuyrm?=
 =?us-ascii?Q?VwOgtuavRJkNaVZ8eFXcVcdcQT4FLh6achEZYZ/Wggly//ozntDi9okKpxQS?=
 =?us-ascii?Q?HOMSVa5kgcozah7anw6fugq4+h1dRaZJTOTopWHfcSUsyvSoVvfhucuVh2D9?=
 =?us-ascii?Q?dgILpQiywcQkOv6oZSuChGurimYxDIUJFf4B/J99ZogqPEZq4mtmaNxGSC40?=
 =?us-ascii?Q?UNQGjke6gl73eflZ9c/Sx+JdcABaegMqQ5L5NfB/WdevoGQom0124Tgw4W6C?=
 =?us-ascii?Q?wlByXF1l+EavIghYTKbH2SRwhJhmQ1v9XqBO1SFEg0lB+Fq1NAukwFP+6fjg?=
 =?us-ascii?Q?MIw1I1pYAwHeU2NQuobDZLaucOLzbh1JtNTNX87pWGNr/k4+vFtPcSTCWbVg?=
 =?us-ascii?Q?m6oOSXK8zimoif7RdI8C+GRPRuhbqBY1LX3qL9k/e5ryzVKjlciH8L0W0KSK?=
 =?us-ascii?Q?J17/mT6iCYY72gmKENtBq9JwGwLEU1rFEf3awdCFeuq+Zq9Mq4LZFgtc3zOG?=
 =?us-ascii?Q?sSbGRvttn0QqguUjNM4YahEYWDad60YVHzAe/9uKfGJAcSMFdt84vv4psqbs?=
 =?us-ascii?Q?xy14L+3KbBNs18/6mob0NvFu9bS6IfMKMqWowX19e1e+d6LC7wMFcGuUQ7Ch?=
 =?us-ascii?Q?dc7sbZbNHLDj57A42CaqhFmPBik89nVMbqPWW16XVtu7u4LKgubb5j1fhBao?=
 =?us-ascii?Q?nWM8Av1LTLrLoYdX5vqFoCAeWHvUhzoNCMjXFqc/7ILnB7vsAE6wc0/7YCkX?=
 =?us-ascii?Q?rCQzUOu6WPzrFgfFuHWWcbIVCcHR9KEEVwYExCjHT54dhUtf9nPqZORr90IH?=
 =?us-ascii?Q?drcCwcops0uhvfzU4ps2f+8002I1Mq8xNpB2hwo+QY4wHtRowZb2lGrtHmvw?=
 =?us-ascii?Q?eAr7IqAYGWzBHR0cB/jyQ4YSOJ1beX1nQiR+Uf2o50JGe/5c/6PmYq6ZAU75?=
 =?us-ascii?Q?NpEGY7WLWsf1X0JDV98Ro2YIuBdkT55uHGZNdNw3it0cqr988JzshillmuwM?=
 =?us-ascii?Q?ehTb9NuxcXecn7aw2L0uaCphOQQ8sf9Ob99bRXiwSRnn/UG0rPvQRVg8gbIH?=
 =?us-ascii?Q?cjLUVgOcmU/tyjhYFEZ+MM9hktTzHvQMANQKnbtnUYug/5rjEZ7pLu95o/G9?=
 =?us-ascii?Q?P0y/5+DiGcvCD08wpE5wKCXSermXhqIWxs2W1k+ML0aRuKrsNNHnumWsyT+3?=
 =?us-ascii?Q?I5unDL/3RCgYWVF38Cap9Gkmk3gi27Cjce8sbhCQxXWTaGYs17RkzAYrp+u/?=
 =?us-ascii?Q?cSYL3/pvcQW5dHUisFdwTWREqh+pZDVyXvtuCdLTlusjMnsz/EPnMGTEXyaq?=
 =?us-ascii?Q?yYxVZ+7yc62BxhqMfISxKLPFb13HXNQUMzb5NOmgTohpnNRBp/+ClwHj0sNz?=
 =?us-ascii?Q?Raau+p7MoqQtYINvePPhLHupsTYPmOZB0MsvMWv/09mw43e83ZlXk4b2/5YO?=
 =?us-ascii?Q?zxBjDT/ajxqVAQFXkFmPhpc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfc104a-03dc-425c-9c37-08d9d3e99044
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 03:30:35.1673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHdhfo/uSkkvnCnVHGvBx0liLwUVzvzBvi1JbsT6m0/JbEL+gu6BwJYsijxz87A+ElN3VOgsen7Y2mLZwR0Lfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2569

This patch added 'clear' command for pm_nl_ctl, to replace the command
'pm_nl_ctl set ip flags nobackup' with 'pm_nl_ctl clear ip flags backup'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index 354784512748..85ca37e4b34c 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -28,7 +28,8 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [=
dev <name>] <ip>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
-	fprintf(stderr, "\tset <ip> [flags backup|nobackup]\n");
+	fprintf(stderr, "\tset <ip> [flags backup]\n");
+	fprintf(stderr, "\tclear <ip> [flags backup]\n");
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
@@ -647,7 +648,7 @@ int get_set_limits(int fd, int pm_family, int argc, cha=
r *argv[])
 	return 0;
 }
=20
-int set_flags(int fd, int pm_family, int argc, char *argv[])
+int set_flags(int fd, int pm_family, int clear_flags, int argc, char *argv=
[])
 {
 	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
 		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
@@ -662,7 +663,8 @@ int set_flags(int fd, int pm_family, int argc, char *ar=
gv[])
=20
 	memset(data, 0, sizeof(data));
 	nh =3D (void *)data;
-	off =3D init_genl_req(data, pm_family, MPTCP_PM_CMD_SET_FLAGS,
+	off =3D init_genl_req(data, pm_family,
+			    clear_flags ? MPTCP_PM_CMD_CLEAR_FLAGS : MPTCP_PM_CMD_SET_FLAGS,
 			    MPTCP_PM_VER);
=20
 	if (argc < 3)
@@ -755,7 +757,9 @@ int main(int argc, char *argv[])
 	else if (!strcmp(argv[1], "limits"))
 		return get_set_limits(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "set"))
-		return set_flags(fd, pm_family, argc, argv);
+		return set_flags(fd, pm_family, 0, argc, argv);
+	else if (!strcmp(argv[1], "clear"))
+		return set_flags(fd, pm_family, 1, argc, argv);
=20
 	fprintf(stderr, "unknown sub-command: %s", argv[1]);
 	syntax(argv);
--=20
2.31.1

