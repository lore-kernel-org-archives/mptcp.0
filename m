Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9F02C9C
	for <mptcp@lists.linux.dev>; Tue,  4 Jan 2022 09:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641290331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ETyYHrB3CiXXbJ49/O/FXpSUcLxT9O0VdVhUplEZQyE=;
	b=f0bUsRweAivrmc31K4jtFRcwiVKl+TvSCo4BuPWRy2zLHdc40WcvaXy42hGJ8hJzId2Xin
	IikbaunW9dfDHLPWNRAaX9KWA1O0QuPcyo1xGxOfe3atHOXKuIXOJMMI3Xl94aVXfqTq79
	cvlbjPdpqLFJjX0NFjsK25DAUDgeMdg=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-EoPG2rYzOBSz4YUhR8T2bA-1; Tue, 04 Jan 2022 10:58:51 +0100
X-MC-Unique: EoPG2rYzOBSz4YUhR8T2bA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNLrYxGzEhV/ejt//LiRQgz+afPXmc4BCbP3KOQog2itrw6PJWW7Uz0//f7TD9H9UgsfYksxqEn2UVdhoNwq818xz5i24krR0JUn64mykhvVgfSOEN45Mtgv8GufqnyPpg0sdyEI5e1SJ+HXZB/u5SavjjNkHxYczf218PMLscViF+6K6qA3EbnP/0pHrlvWv149e29OUfzsyHA2BJGxj3OpWY0SL5XRkNnKX2X0BNf+UBE6rEajZWwTBUWvjBGZiYh9Xkcxv3GDzeVvwUpJjq7jWle4GuDFxMy0lzeuzW2N9o1lowjX5xItewgcVVZNzsVaL4bIZ3RNDrjHx7nAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jDYAUnIXWWCYLOoxTevDxRxEQT9o4nCVf005cfv01Y=;
 b=Z6FzcYE4W5IlXpSgQQFK8tphXC6xTACUej45GvaZ4TZAjjetAAk0vOhQPd0bzbZS7ww5iq7o6l83Us4JYG4joib9kdZTjGc3x6ScRTycikhrV3pLnCZfn0MrimO0mY3cvv4BZOHMvFk9kMCGmZl0enCAV9ylujejyPSfXfMfkAc8TzD47QKEWuU4ACNHc09pSAym8HzH1rkO85GM2yaOsa5lRRNsQkLzqwXSFLdvx+G9RZLh3MIbDNlsvuZ0c41kIPNqRKt+mjWlvJv6YOU1hheXtG6wrqipKFdgJkzEW1VPWWzpQ6uBYCmkWx32DAWBbXa7MolRydVDwtJ7yqdF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2428.eurprd04.prod.outlook.com (2603:10a6:3:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 09:58:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 09:58:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH iproute2-next 3/3] mptcp: add the backup flag setting
Date: Tue,  4 Jan 2022 17:58:18 +0800
Message-ID: <faee44620e111eea4205105974c994a5e8ef5683.1641289518.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641289518.git.geliang.tang@suse.com>
References: <cover.1641289518.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0058.apcprd04.prod.outlook.com
 (2603:1096:202:14::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 207dcad7-d054-48bf-00e0-08d9cf68ce7b
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2428:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2428B90F6E115AB5E126E1B4F84A9@HE1PR0401MB2428.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:486;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XmqTtA8EKBc3qrvcsUx3rN8K1jyXQbcM/HtkU3C2V9llAJGwdLJzW9JK6r+1g9iU3wNAGOOSji7nH1ZZA5tHE9Yl0+Hv/uV9V+QPCnVwZ6MfMpDsPrfvy31WDK0QlQFUamY7bbrFWRniM+ZRmTDz+Tb4Onb+n4/41gl8WRD8ze+b7aRlae24jhTO7ZwX+Vegc81iQU0FtkN538io3N3koGyr+WN45id/zCMuOmDvddRZVmtONEOvMhkGQL05fhSESE+FsGeOtJv2Cf/iY1ddb/QMQEX8jq1k4lEhgam2fDlmm6aElTWzEVNNrcye/zulXDysoXlWP172bhwx594+gQwIWOLheBg+mJDI8fy1U55OLIz98Kc/IK4HloLAhEzfAEzEw/puC7XrI3VM2c3LqKKsrBSy8aGKF+e2w8oCr7GSWrvLMPJOaNuBl/xUyLwb8R3Pw49HEjMUslu9BvMtjgqNgi5g2q6jfKd2p/MojslFrfWZBrnyaZxeVG9OLdP9wpOKtltnKucuscBaEjogVK8Z5SENzA+dT2441cj3LN6O282AW8suEsA76ef28U/xtoTEJ0T4MGzh6dg6ylNQFwmOOY6Ucju/09KzNZl9iy9sOUdGRMto5xp5S4a6C8sWrK6qjDsIDgkbHoCbY4Ljsw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(107886003)(508600001)(6666004)(83380400001)(186003)(8936002)(55236004)(26005)(6916009)(8676002)(5660300002)(36756003)(2616005)(6506007)(44832011)(2906002)(6512007)(38100700002)(4326008)(316002)(66556008)(66476007)(66946007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kv3+VIt5cR1QcC40ieap9f1UYY/IdrsoWjQOuMn+y5In7+c8a+DD4yg//GcG?=
 =?us-ascii?Q?Jjs5RUX5C3+0TeSQyYQIYzgr5OPncZgd3NjoqWqPuKpGBaKuN6XqRv6Py1nX?=
 =?us-ascii?Q?vWBebeY6ZJaFo38AHs276stx/doRPckEfAj5t200PEopHG6UF+mmC+/3Fbm6?=
 =?us-ascii?Q?fPOvFbIA8TjGelsaAQFKJndHmSXZxl+EOLH4JA8Rpi9Kxs2ItkEMSxAK4Ww0?=
 =?us-ascii?Q?6pwEfACrkLCUQbxXufxQuHhnTDz+W7hixC0Jnh7sB2sICy7YjOdFcRmxN8mH?=
 =?us-ascii?Q?MoySwUaAGD8za5qLoLZSZYRj/g1p8mNgHrE5uOUodytofozx0vHebmVE/Kv0?=
 =?us-ascii?Q?NMKfiN7lsby9vNcGJuurKlGYYZ7GM7zYtOeYHjHaKASW5t0o6aXbz5yYuaN+?=
 =?us-ascii?Q?d8DBt4EM+X/qimVF7BsswPaN3AZWKZ1oWbofINhGtcadsZSJPg1H/swf+8du?=
 =?us-ascii?Q?ikWUdytaVOcKNAEaCSRw/uFMQatlSpjZx0u7qGF3AzpNDEd0AJUfsuRaT1yA?=
 =?us-ascii?Q?M38hpj3o7F7C+mjwkv9haEV+jsb+tP1v2zAR1HpcqtAo5w+A0kon6F7Xk/nF?=
 =?us-ascii?Q?RecdKQLYBQhOqURI89YLOyZDb0ffSnscMSincCXbwWrrMu/1zzKilx0rdarc?=
 =?us-ascii?Q?5edsaSnppGt4Zgprhh7cKLjGwvhbxhGxonX2njsu4l/R5/rD9avMTei+OAqM?=
 =?us-ascii?Q?27L7T5F+e/lHA3n/GaekGQEs32zTmypgwOewmLzq3m8ieqx3jLpitCZLYQbJ?=
 =?us-ascii?Q?id5M4i5+dVyKIii+kZje71Bs80NkR2xdfRJp+9qQU+70W/sfSCJD3NtgirQC?=
 =?us-ascii?Q?nEa48YOvDtDkzxQSJUWE8PM5lTzWET4JJsFe2loIbOxl7cNzgHEwPOs9xATX?=
 =?us-ascii?Q?92Kc5pThkZd0Z9nxQkyLX0rxyu5adym6sYFQ0MoTBDo4MaV7nKBfrq81H6/g?=
 =?us-ascii?Q?TcQnDkuK9ouZ1q8pFj5NtDmGr7LOBfqP2V9Q1D2JNcY2rGbFpG7woOzoucUS?=
 =?us-ascii?Q?lMqI3uJWDCCbtD8+H4QquW6vNrrN+drrmMZnDNPgYnIhsojWN27jYetPckuQ?=
 =?us-ascii?Q?adyCzqo0rJEiP7Iw1tJipI/XbHNwAO+je+FuS8ee/lWzEW/Nkjbcu6aKupj9?=
 =?us-ascii?Q?lnC7VKp6NmXTCFvr1ebk8whD73Q8R047IceVcDi9Ed3+XXj4HSiToyasSd3L?=
 =?us-ascii?Q?NsDW+EsmJaSoDRGw6Pnp3CnD3U5fRyyzV/edoA7FxbW9TnaKveOm7Scgd9Uc?=
 =?us-ascii?Q?u3cQjbEdNwI59N3CICgJ3OhKh7ZPecuqQ8voWI/mG2UMrch72f5G0brEZBzj?=
 =?us-ascii?Q?OUfjP/RCjiZQ85kvbrhE1z6x4mffLSJQXPjPBF8DoLFHR+KPl5DuwpZjBqWF?=
 =?us-ascii?Q?TnYKmRSamIYzbkO3sQufuvUFXJyVFGdplF1aHKBBoiZYktxT1lNcvQx0ONV0?=
 =?us-ascii?Q?oDeXfuqmFL2WHp9x9YMdt3LCjjcB4XefAKvHKbyXMqD/VTb+jr5DhTHvM5ex?=
 =?us-ascii?Q?UfMxBmzw9b25s41hAP/o8EigmeGGgGgKxxkr9GG7AIsWctJ9iWEA70C1Wjsa?=
 =?us-ascii?Q?ziMz2HcJUw+gkFNnDgO3q5niYyXE9uziDLohYSQZ8Niyd7Vhe/Rwa+ZuizcK?=
 =?us-ascii?Q?Xh4Wo696tUWfqgMfcOGVNI0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207dcad7-d054-48bf-00e0-08d9cf68ce7b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 09:58:50.0007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtGGanLbsbdmKwCvhKPUXbRbRtxd4jIVj4RZ7wn1ImTn12oMADVn1UXEXN3HluXerqCzM+e2sDTaBwioYJz1BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2428

The address flag backup setting had been added into pm_nl_ctl.c in commit
6e8b244a3e9d ("selftests: mptcp: add set_flags command in pm_nl_ctl"). This
patch added it to 'ip mptcp' too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/uapi/linux/mptcp.h |  2 ++
 ip/ipmptcp.c               | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 957743ce..2b76e526 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -75,6 +75,8 @@ enum {
 #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
 #define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
=20
+#define MPTCP_PM_ADDR_FLAG_MAX				(1 << 8)
+
 enum {
 	MPTCP_PM_CMD_UNSPEC,
=20
diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 8c4fd18c..fc1fd5ce 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -19,6 +19,7 @@ static void usage(void)
 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
 		"				      [ port NR ] [ FLAG-LIST ]\n"
 		"	ip mptcp endpoint delete id ID [ ADDRESS ]\n"
+		"	ip mptcp endpoint set ADDRESS [ backup | nobackup ]"
 		"	ip mptcp endpoint show [ id ID ]\n"
 		"	ip mptcp endpoint flush\n"
 		"	ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]\n"
@@ -47,6 +48,7 @@ static const struct {
 	{ "signal",		MPTCP_PM_ADDR_FLAG_SIGNAL },
 	{ "subflow",		MPTCP_PM_ADDR_FLAG_SUBFLOW },
 	{ "backup",		MPTCP_PM_ADDR_FLAG_BACKUP },
+	{ "nobackup",		MPTCP_PM_ADDR_FLAG_MAX },
 	{ "fullmesh",		MPTCP_PM_ADDR_FLAG_FULLMESH },
 };
=20
@@ -91,17 +93,24 @@ static int get_flags(const char *arg, __u32 *flags)
 }
=20
 static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n,
-			 bool adding)
+			 int cmd)
 {
 	struct rtattr *attr_addr;
 	bool addr_set =3D false;
 	inet_prefix address;
 	bool id_set =3D false;
+	bool adding =3D 0;
+	bool deling =3D 0;
 	__u32 index =3D 0;
 	__u32 flags =3D 0;
 	__u16 port =3D 0;
 	__u8 id =3D 0;
=20
+	if (cmd =3D=3D MPTCP_PM_CMD_ADD_ADDR)
+		adding =3D 1;
+	else if (cmd =3D=3D MPTCP_PM_CMD_DEL_ADDR)
+		deling =3D 1;
+
 	ll_init_map(&rth);
 	while (argc > 0) {
 		if (get_flags(*argv, &flags) =3D=3D 0) {
@@ -141,9 +150,9 @@ static int mptcp_parse_opt(int argc, char **argv, struc=
t nlmsghdr *n,
 	if (!addr_set && adding)
 		missarg("ADDRESS");
=20
-	if (!id_set && !adding)
+	if (!id_set && deling)
 		missarg("ID");
-	else if (id_set && !adding) {
+	else if (id_set && deling) {
 		if (id && addr_set)
 			invarg("invalid for non-zero id address\n", "ADDRESS");
 		else if (!id && !addr_set)
@@ -183,7 +192,7 @@ static int mptcp_addr_modify(int argc, char **argv, int=
 cmd)
 	MPTCP_REQUEST(req, cmd, NLM_F_REQUEST);
 	int ret;
=20
-	ret =3D mptcp_parse_opt(argc, argv, &req.n, cmd =3D=3D MPTCP_PM_CMD_ADD_A=
DDR);
+	ret =3D mptcp_parse_opt(argc, argv, &req.n, cmd);
 	if (ret)
 		return ret;
=20
@@ -299,7 +308,7 @@ static int mptcp_addr_show(int argc, char **argv)
 	if (argc <=3D 0)
 		return mptcp_addr_dump();
=20
-	ret =3D mptcp_parse_opt(argc, argv, &req.n, false);
+	ret =3D mptcp_parse_opt(argc, argv, &req.n, MPTCP_PM_CMD_DEL_ADDR);
 	if (ret)
 		return ret;
=20
@@ -534,6 +543,9 @@ int do_mptcp(int argc, char **argv)
 		if (matches(*argv, "delete") =3D=3D 0)
 			return mptcp_addr_modify(argc-1, argv+1,
 						 MPTCP_PM_CMD_DEL_ADDR);
+		if (matches(*argv, "set") =3D=3D 0)
+			return mptcp_addr_modify(argc-1, argv+1,
+						 MPTCP_PM_CMD_SET_FLAGS);
 		if (matches(*argv, "show") =3D=3D 0)
 			return mptcp_addr_show(argc-1, argv+1);
 		if (matches(*argv, "flush") =3D=3D 0)
--=20
2.31.1

