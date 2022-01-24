Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C51173
	for <mptcp@lists.linux.dev>; Mon, 24 Jan 2022 02:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642990163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8nHl2ibnxk7nJK9yBZk0XF5yDp7WccAsp1HBU04zHHs=;
	b=YGIivK0gj/+J2K4Wf/6i7kOS8DkzlrCsL/uqRjws5XXpkpAlrZyEVr8c2iYYzDHskUNj+S
	4uvaNk0MxVxckAmVb/W+qgilI1iQ8vdR+5H3djx441v1eLpXWOhVeWgbQ2dBUwJMYnUYD2
	4IcZ77Ha6I2lqE89JN2ZopKUBKbu2PQ=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-45yOnq60OXSV_0_LgYSmLA-1; Mon, 24 Jan 2022 03:09:22 +0100
X-MC-Unique: 45yOnq60OXSV_0_LgYSmLA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWiPSi/mQQIFNdAZWJwA2ozwUdhtLNXj6xeCKpGAGdHX20gx0WKnpI7NzXm43Hx1nm2ATPXdRR5Tnu+UIoKALO9K6LKOZ4BO/0M/jn7/JHPcaBmcTeEnFE9UbhgkXkljkc6NwiRdeMvqJprnx1bGG7AdtS9MMFIFtNVIOecL8EeZAzKBYdH8SGnSU4iMVXTL/YpCAKKsfqT+tJvVxta1gN+l9VtjUgaGoHONH0W2xXaf3m1dHzsgN5r0GthNoNm8ASX2ihilmvm1dzxep6GTZ7PvnsvG/MU+1Zdw/+kkH4MCmzaFsbYqpS4/x/Kwr7jM3tWYfLsDt/gwvy4xCODb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04YVkl+xmJhWEDUM82aCtGXbvAKX1EerHLsspzvpYrA=;
 b=UiQd0gpgY9aUdc6N9gz4NzQsW0U/432n/DxnfBE4Ieqm8UM9JIUyYnPx5ZMswIIzHR4rcp00J2sfRo98DP7k6LCWfb7zs8K2kb5LPBoR6dJZsOrgxwRDCxWquyf5meFb7C6fAMP/8SzDt7Ud3tk1ZOhtreEqJKzcPh/h842MBvGmAsGKtG2z+SMMy9camCCYQKY+50tnrOKrlEG+DfLRtNRTxbgUpa6F9aQsizMCIki/us6GsW2i4mPBtGLZZ8k55bA5j6irsUfMiconoyFWljAjSzoU2cjpbvxfl/Uv/9aDhCr7lrkpzLklx0kNhoBoP2kl5LgrIl4FszNut8czKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB3PR0402MB3660.eurprd04.prod.outlook.com (2603:10a6:8:c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Mon, 24 Jan
 2022 02:09:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 02:09:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] Squash to "selftests: mptcp: add the id argument for set_flags"
Date: Mon, 24 Jan 2022 10:09:25 +0800
Message-ID: <6e5475ee60365df2beb2c919eb3eb7a6d87b6a74.1642990037.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0012.apcprd03.prod.outlook.com
 (2603:1096:202::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ab787b2-f8e3-4b16-c8fd-08d9dede88e7
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3660:EE_
X-Microsoft-Antispam-PRVS:
	<DB3PR0402MB36600737E18E34A2C5FFA324F85E9@DB3PR0402MB3660.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SVO+zhumKShJN7KLcBdZol+wNdJ0kuYEBuJpAQEprFOthuVH+rq4RgY/cSeVxW2GmFoNFMUkKxbGsfXfO5GcQNlwXTQ14e+LsAhWXPMWu21F/FInvv/DWM4tUeanrE/zeDPhIDPyRfhsVIliJ2XSdxGsxHVmy8jmU5TVGONU4WROeEe0YwfsSvJFoHSXj23N9G+vHrspSV/aEojidtFzWV7niwB0x1HFu2ts1ZLJO7lw031R0UOTO5Czp0Uk0N+Xj5xprsG0TZ8C2gkkWWo89tguC3NP2B/eHTLS54TSks9vsW/JKT1iAKExIH7Ppo5EH7U0uVgrOyBvAtX/P/PL5o4/avScFsJWfcPUfutHW6fXz4WtAcLf0dkqZwTeGDkIL4+n7LwaOomiu0ayPBmpjABxugSITPsyks5t88b/xexAbUYGoL3kQoNjh4t8g+t+jR/yP25WSs1Io3sW3IN+Xrmt8mOBFNVW6NCRLcWKiWvPXprl3yuUMxv1AGUgjIScVM7D0ZpN6mfttT0b8HOvUK80i1cwpvppprPSI6kM+koGtXh+UpqK42HZt4RsJ0gWpaJgSQCpRggQphXOj4uz5wmUoywRotYrgq+W3Ic8AaGXYD/YPmwKaopDDR8ME4fvQDT1hhplnTTfIkcfBdrjEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(44832011)(38100700002)(8676002)(4326008)(107886003)(6506007)(2616005)(66946007)(86362001)(2906002)(6486002)(316002)(6512007)(5660300002)(508600001)(66556008)(55236004)(66476007)(186003)(6916009)(83380400001)(8936002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G9nY0v/AdKEDcDwxvNPEI5NiNB0YttVrCLY3wIQzLGvcTyEVLa0Ry8csQ2nH?=
 =?us-ascii?Q?PYJ3+qsyjS+AuM5JAh+IVuykl0WMF5b3VyiVqMLE8qx91d978V9VHBOiUsvI?=
 =?us-ascii?Q?OXVRyT33CNeJgehGmpfkQwaVb+DQQe0sllgv25FCstCiuFkGUQj0LnMLIjVl?=
 =?us-ascii?Q?HNjyEF61j6hJ6TKd/q2udyB0q8Pc5PNQXmcvO+oX7dJQNuSrms/BtcKZ4P4O?=
 =?us-ascii?Q?Ts+FuREG+VN0+jn0ZCh/Lv6R5EAEsuhd9Bxqzjy/h17Zid0FKTY/M2oKiFqI?=
 =?us-ascii?Q?wQnQ79AVHFXSkh41riIzpeOQlWq4vNLS4ucONk05JThwKHJDqEc+EfU480Xy?=
 =?us-ascii?Q?0CWJQVznrlE7P8IhZ/nKDkr8dOQYPlFwSXBC5aag1dQG3jtjMgzFUHwxPMfk?=
 =?us-ascii?Q?xifLiB1Cshtq/Jrpd8rBr5qw9adNBmp/36oSEGOn+hEturFKMTg56JWYcFNK?=
 =?us-ascii?Q?9Z5/lpOK2gTANPMKhm2VhAvcQR/9PKjSEGk48MS/TdCdNW4C38h6r6rXksJq?=
 =?us-ascii?Q?3/eU2O7clr7AHCy+oVq+jtJjgBbTyQkI9QkNfunwUed7SYYppO73zlvUElZu?=
 =?us-ascii?Q?lyYzfwWzOlBxtd80PE2MTziKKCBUKpe+SJAZXyOSNkTeUpi/Kv6cvv9F6BEr?=
 =?us-ascii?Q?lN13r4nBpTcl56C8SAMkhSY/hFexGgf9OagVyuST6H2YgqC3A6aoKiuDag4i?=
 =?us-ascii?Q?LXzO+RjCy2Dh7CIbYRsB0YfelKmwo9sCh07ST38HofgFwOu4a71lASUi0T2i?=
 =?us-ascii?Q?LBKEYfV/2fjxl8T/CWW+ZYmkfZxu3tA0XMLZcBguGRk+6L+KW6nj19zlGhOK?=
 =?us-ascii?Q?NYJAIZGUZYO24aIpRYTvU+iub5GlbJj6arLdlsLdnr704FA8TmJ+nr3RZA8u?=
 =?us-ascii?Q?rjwT1ucpwAWVvXqt8ZXNitRlOJ8qhmg5xN7RtbGijdyB3lihACY7WPfuC2BN?=
 =?us-ascii?Q?qAM4U1e5cOSRChEqPAG1MKeLyBJHDSslitZf/LIEqzPEJJEgCqTMyjAS4PDg?=
 =?us-ascii?Q?+Ibb5fvQdPIgcJSIbi+YI79RSX/phzVoU9oXR5cbppFf6bEE/nkNdBJwA3dX?=
 =?us-ascii?Q?W/HplPCCwvM6YNG4TsL2+2nb+Vx3S7UIdQH9OAlczq/O5tJXGWTp0s273079?=
 =?us-ascii?Q?vXv4u6zjGayK5zDZUrWQCDTPNGXd0PHNM1GAnVvYV83iWpW2i6szVsoMOTvh?=
 =?us-ascii?Q?3f+Y17fKsyIvh2T8gnbHV9p2fDa/evlqbvwG1Ce4yN0rFgrgbITuySKZk2Fy?=
 =?us-ascii?Q?TvE4TiEMA4lNIEWe1+xXNsHGYsG4NDkJD6Wpzh2sdKHSN5Q50dzNWwtaUi4c?=
 =?us-ascii?Q?aw2j1ZTZQNYUoiFYhk4LRqrF26Tn13u/OSnfmjRJGXMGpnXOBdso1JSK8Py0?=
 =?us-ascii?Q?Ez4tifv90FYaE9RdjQEOcscR0jXpjWby69b2W5Mj4QfG0MrfauRDEiFaeGUP?=
 =?us-ascii?Q?R6Dicw1IqtrakFthhmkQnkJl1bQ5TVdZKDL1qoduAbQBb0JBEOoolQtUhhYD?=
 =?us-ascii?Q?69YNkZVKctSfMnGDhcnEYR8xYr7g/Awcpg1WEX9yWJIRkraDOpn/qEeRD+26?=
 =?us-ascii?Q?LA1kea4xjXyb5uIkXPk8nz2EVkEdJ5oAIDsw9MVVepl3ZsDvBPUQOsv2FmWZ?=
 =?us-ascii?Q?/H6ap22JlQIuVipsh1BdPH8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab787b2-f8e3-4b16-c8fd-08d9dede88e7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 02:09:21.1570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l42Fn+GAoEv3OsjL7aqbO+Av1+ZCo6zgvAwPjrsx+ksTQllJgYbuUHfVhs5A5xiEA39Jayt7pOV608Seu1uzNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3660

Update the usage of set_flags.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 v2:
    set [<ip>] [id <nr>] flags [[no]backup|[no]fullmesh] [port <nr>]
 ->
    set [<ip>] [id <nr>] flags [no]backup|[no]fullmesh [port <nr>]
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index e554928487f8..22a5ec1e128e 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -28,8 +28,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [=
dev <name>] <ip>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
-	fprintf(stderr, "\tset [<ip>] [id <nr>] [flags backup|nobackup|fullmesh|n=
ofullmesh]\n");
-	fprintf(stderr, "\t                                                     [=
port <nr>]\n");
+	fprintf(stderr, "\tset [<ip>] [id <nr>] flags [no]backup|[no]fullmesh [po=
rt <nr>]\n");
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
--=20
2.31.1

