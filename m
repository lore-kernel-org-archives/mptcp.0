Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521FC2C80
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 15:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642086553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Edt1p9KSDoya75M6IGXtjEKGXl8SOfJIAkR/V+wo6XU=;
	b=WCfdGZxMZYp8HwrMbRzY381VUd9tMWjTPKfoC3dc8aRFuJikJ8v0K2p0X2uKOS0Pp/Tl28
	4ZmuzR3SvXVgVZ2yc4qGC9SeKQ9f5+/AwfhnZ35TfMd8AOQb2syTjMVFgh3gRVzIklOjGM
	O53xTS1Fi9kM3MbLdfqJCK3NKxdpajQ=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-iSxxtJMqNz-zMY8R8p8NBw-1; Thu, 13 Jan 2022 16:09:12 +0100
X-MC-Unique: iSxxtJMqNz-zMY8R8p8NBw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kw58pDeD5Hzoom4a8C8rWiv/+29Z2itxbn64V57oUP71xtruDuMzj2Z2D6F1Df6xpvZ5Y4ImSwgYifwkNAhvC5F56jPuKpzGfU6FqJenRtzgWqBBj27FXykdIflC+oIjCKuiOAjbjvf5xC2PphcSAFDDH5ZBH/ispGvu+pTSOfGqxQKJDJIbuRcJsgBy/0qmmsfmeBZNEdIM7xkvjriJb8brKIByKuNidAvyUoVpsgdnr5OoabvICzT9YlQza0aRRbQZ2Uh0mYXYQ80DY8zNerbNXT7Y+tiGic3Jv6cpYQAOgdw51jamZtkfFAA90670WPVLqmQNMgY8UbGNqgnvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2ju45BwrOeaW84wTo2BgVqr4hubXPkYYwiKW/v1dwo=;
 b=Gl2F50OjJ0YbkrM1kmVFyqXxfxuTyf8PQXQNzwZVAElWnSoBChQonOoY9g3fml01PE/h2illW2P2TWHpLnXD8RCllG8oXnlGslpTSRz4XktBhXWLJAPG8mW0rKRpMe5kkywtdp1rbDJ0XBUdBcgo+RbQI05wpOBfc4PDsuhgTz5cr2sEwzVAGV1wiAxEzINsnmnwukEkzVFxgJVRn50xloSTrTQlLavu1n87+CIiKB/IBUH2o11ouX3qGYD9LOxwdAOOjOtRmST2pfF7Mc7b/KnIjzGCjrvyXGJhwk3DIKPz+zBPJzzsCUXul4+Q+mGXbmXS26DlRXYSq5VIWda65Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2489.eurprd04.prod.outlook.com (2603:10a6:3:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 13 Jan
 2022 15:09:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 15:09:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/3] selftests: mptcp: add the port argument for set_flags
Date: Thu, 13 Jan 2022 23:08:32 +0800
Message-ID: <3a30b5a11c8a7a5b510d99ba65e473344d61ffd2.1642085750.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642085750.git.geliang.tang@suse.com>
References: <cover.1642085750.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:202:16::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eec366c-707b-47a6-d228-08d9d6a6a7df
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2489:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2489FF4DDB2D1D60032726DCF8539@HE1PR0401MB2489.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P0lhNMDTRe7+B01HNY8KLNrx1RE+9RJ2hKdIndLWRou4CFVJ7paL6ev+xB/rlPDXHidfG07IXfp5oUaDPHE1J53CazA3Zxxur1VeR6cpHloAAFPoPLtZK4L8DpsxV9lfvoIc9j387QVY7xsSu/rOl3SEotoZO7uAAPSxkNhGTznll88D/cLpJ2FMQRSy5M4iYthem+K7mGLyi+Tg3ylQfVZAJRA9usMEhRmEzzyqsLjNl/KDJ7p+x/q5C49YXl1Etsm2U25fbq9fGmVZwNIzYt6I19kXLqNWPCHvcwXyFftFsoMIDtYS20NuBkLgSZBwnyGNHuvJE6T5h1QrwfdBYQ66DuHfSlJx9TuswUrhI3wjwT8HGR4WveSJ0ZaZkPjz+TAA/zfAZkLCiGVHOs5sfrLjt1sV/N8KY2VAm8vvseKXWn/W35EM0vuVU9QAwdKrDG9OSCyRzB/aYhz20WVTrbdZhjeOwMujT9ocYCufRp7rLONUnG1ufclCkbQJazcrHRzuhaZrjs4JX+2k19skxThwoVOM6FIsHN8HE2issbLG7XvLOgRys9yky+8zdby19KDE9BEGFotE9RyvM8e/4rhc0pfBCuXZutERXY1/PWU2HIklF4DVY9Xnkxwhi6YpmXKAEXKXF7kUUDVBijMu2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(8936002)(2906002)(6666004)(2616005)(86362001)(44832011)(186003)(4326008)(36756003)(66946007)(316002)(83380400001)(6916009)(66556008)(508600001)(5660300002)(8676002)(107886003)(6512007)(38100700002)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IyDNeNuXNrnZkuWVzQE0CBQwJ0v3ZbPiqI+8A8/YFIjksQZRCwOEip/YUaBK?=
 =?us-ascii?Q?GFeTlltb97i/9530TsFbnkNm3hPpBeC4RWgqt5GhMi4vvWb8WSGCfOrSCQf9?=
 =?us-ascii?Q?b/hyFj1m0tw8E/6fmckPwjcgi012Exn0CZrWk8zYKh/P/JoK4s7GvmC4M9Us?=
 =?us-ascii?Q?oVPeRXfElZCJbqoM6kLxYje4P73e8MDQWDMk8eGajxBMO441S754ELWURuwI?=
 =?us-ascii?Q?d1VNJahgHpQLV2haSyqtrDRquuYjwsqqSl///JlTc3Zp08i08BY+VBDG5pdM?=
 =?us-ascii?Q?UYeyDVaLkf9JatDN0os2W4BoOHJXQkTys70shbjF+U+lY8lQdolxIFgOidfy?=
 =?us-ascii?Q?spaKuT9KMvhJrEuATs5OJHhwOa8faf35KLt7dPrc4jfEujyQg7mqTCL5TaEb?=
 =?us-ascii?Q?oFi+r5e6LtJX8a5PLsciTSCPDtOX9jlGmPdzMUB9jHdkg8sx7SHbyjeD054e?=
 =?us-ascii?Q?7YU0Cx60rNCgQKSjANcjSejg/0Hgw/EFBUtnHOn6j9vTjzSiDARbBfe3FC0U?=
 =?us-ascii?Q?jG0B/kmyXpafsuOf2jpUp99vDmbNxW14lx9QPJkNHM/KGSqvExDA1Id5EBm6?=
 =?us-ascii?Q?QqBfJHkS8J4l3bb+4O/Qpxq6AZ9wUlItyq55iefTNenOMA5AyP2bca815YU2?=
 =?us-ascii?Q?S7+B0xsL8yNzCBBx60ZcCuI/IZ7llvhWIV5/qgUP0n95j2xcXWDDIId3Lqef?=
 =?us-ascii?Q?HiyChq6RO50gAs7a3nLjRrJO6xE1ZKHce/kbdKB2RxcHPAOhT0zEr+oIzydw?=
 =?us-ascii?Q?IONaM3VbpjLB8sGNBW49BxLnJ9XSZM5u2bXJkVh3H2v0jeLMBuHshSuQaQCA?=
 =?us-ascii?Q?TdYdZKLcZiKWIbWagOYp15HhpthAboqQgoLt187L7YzYFzpl8FijS+f6d7jK?=
 =?us-ascii?Q?aUbu/JuAQ1GjnvxTc+H/g9KOeGJR+dr7OW1HE6p7HR26AjKzXtCESI3CI93A?=
 =?us-ascii?Q?wnM9vpnrFdbSlbB9sz9yR4w6iNozZsFoWotrv8rIoN6vTY9ooRcq+A/oC+Fn?=
 =?us-ascii?Q?4YkXE735ftByR85iOTQAasJ5sFOYrsVRkWKhoJ9txM1rpOVaxdoM9ezjfvom?=
 =?us-ascii?Q?Lw5ohqWP8ec8BvzJqJv6B/l0FTo6krVPtIhqjqjlFU9b/RWerFBgmdQ7Hwq5?=
 =?us-ascii?Q?B7tFfVQALykN3JErCKLUZ3p7PPrlqaz3FLe6qoy72K7gEBVaza5rfiYTNhUA?=
 =?us-ascii?Q?H32V4YTMb3E6hYD7kfCGPctv4xuUGp3a8QJFw1DAI+JW2Qv2eyrdrhyHUmX3?=
 =?us-ascii?Q?4ZfsCswwRzYBQqn2YX+N4xOgDf80nOxbvLhCqwwGnlPqXYBbKzvyell/x1vx?=
 =?us-ascii?Q?9GnhCaq1+VcUBHguV6d6FcWGR9TWAmEWY4vVo0dZjdqi7Hk5Jlu11iSuy01n?=
 =?us-ascii?Q?PZSuEwoiA8EeU7PXHg9q428fUhhAetslYDuJxgfyAnSVMiznTxbKbiq0kH0q?=
 =?us-ascii?Q?DgtyA/AJewHkutBMv9SBl+V3AIB4N23BO2KXMXEcGXElSuJpmp0noGUC8JCM?=
 =?us-ascii?Q?eOCSNVMA/lpF0e9PDTS531kcfNO5hPbTJIMSvWc9TSG1Z0W3kG4rpU7TwSWE?=
 =?us-ascii?Q?w03bSQT9UNpvPcbmbPijLBAmAy2nGDPo/mHAmt7MVnUlvWywS+grNdBiy2zF?=
 =?us-ascii?Q?lit79Xf7aXyaiTcJmSrgXwbMD1+53r+FXAQVwJCrt9zwXm90Hk/B1WNmbQrf?=
 =?us-ascii?Q?2GkvaS8bvYJo130lowWWBM2051I=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eec366c-707b-47a6-d228-08d9d6a6a7df
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 15:09:12.0108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpOrgaPb5dmmaKLpdP8K34mkD62pHlWNBJhFvykAtGD8JtSuGDIkVEzjWzkRWxo4DuQbFFnmQgBBWPsS1teFZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2489

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

