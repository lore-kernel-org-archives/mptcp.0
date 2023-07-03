Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E816803
	for <mptcp@lists.linux.dev>; Mon,  3 Jul 2023 06:40:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alWD3lEsU2cy5xXspaZh7AI601GkZ5VfK7bfFA4ZGEJjn/4jX7kxBk01ZTpy4EGnG0d8cOeZeAEB2qwJU6NkniS/xA9w5SfGAcV9dL4q6gAbG8bN/ifQs/vdGYx/mRtnQcbZs9FBQAjQnYfjzU8EJu9uBfVWGt8pq08lbGIC31LUZyJl/IvoLxZoITDiGMseeRDKxFhif3E/bhw3YDvbKNK95U2Ghh4M2MlBl5flbwwCQb243SjNBdnzlZI3SPR0CyO40W1B97LDOPMpfIdKb4JPxFils7gCTU843fSTeto4mp8v0Kkswb50in8IukEqonoCDq/ZoHLKfKA/hRH+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xEsJ44QoGeXEls40BuZ+NbWQ4erG/BFXRl1iTFWXEc=;
 b=lR8pt43q4fBfglKguRH1CHDsGgFxLE8KBD2UjYhBJHmkcv8lmXtv7agZ9opQuu3/Nzcxfx+uvmCFq5c3luGjR+KmlGSG0PuK2kEYCpHv3SkiXZLY9ASSxBmH3TM7nbCM3CU5MqQpwbEgmrt2HtGnLcrZZvibFhlyjYF/a4UcTxPnnFYKqiruPVh3LmEalWrCtLRx4xHBhCqzjLqxeNBf2Jft5dGCKC+dGvOxFcQQTNmJ7rDolx3OAdQfjR5fzSdYJAqPbXokF2HGgCfFNmOLlwy/lLeAE+oXd9rZRofu206OpqQEiovoS9K8/VMdRTifUtprMJv9SzHVUlEvxLQDOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xEsJ44QoGeXEls40BuZ+NbWQ4erG/BFXRl1iTFWXEc=;
 b=DYSiaU7e4RfV/LpMKKqOWQxabWMJHrUmM1a8+EAgu1K7LjWb8bjYzDOosjzFPFGReHu6Fm2xbznz5Gwhwz+U7dxS7MlLcnem3uqCArAs84fz/tKeqOk+0GQrVwGJN148uCsaxDSE4rmDMhUuzTtirYhF7d/LIDWPOouwCr35jusOqe5HPy/yji9rE+AUYpUe7GmnnG+Uuwv+wC6731E+6/REKerz5xvpqYMjd0FZlBCzlHW7gaz3zEjNH85wGejB3Yyq49Pl1UIiKmtI7hORtalISLqzJzNEkzHuYruND8dfjrUfVborljDEdvbeelwjfKRpRVgz/04iWbXgGxw+0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9524.eurprd04.prod.outlook.com (2603:10a6:10:2f7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 06:40:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 06:40:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/5] net: socket: add socket_create wrapper
Date: Mon,  3 Jul 2023 14:39:57 +0800
Message-Id: <bf1cd56ede55306b3272c6b3069830ea6a189c97.1688366249.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688366249.git.geliang.tang@suse.com>
References: <cover.1688366249.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::30)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 69aae49d-56e2-4539-6a07-08db7b9059a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9nDPRY2Yqn5U2d/FVIJdNwyxEhgL0zS+xTDAnWamtoafqx/aPMoHrnk3sgdT6bN4o4urTXdXd7CSB3DbM+zmtuOF8734wGkxs9ho6QF9MpM5jyJufp/QYtBilPC3KTJ8e9IgAkt2yC0m+v6yXU7bytlyzKR6iqGmkneJOVmoijITcQeEg4iOFFpLtsjon9CwCKhrnnxeFmRLNPQD/XZyBR1DXwE7DsGqcMUoZQnyPJvyxVOayr8qYVAPrcQKqU27RStiKK4BRcn2jqXvp2CPGuwhvF/MunPm0uzJbdcqtNp1K8S+e7Rp0JDJineKEiNWhKNfOvPzW0rYTIahDdmnPLzlOK+Zh+lV+QSaaGNGN37o7JKB8/XeoCZlU481mjAyD1LMWVe3tTwRZGBFo8osZL/zs6+P7UCehtMz6FdFDRoRdhWhczDQxM8HgB+4T97t2qoHnPHsYYF18QIWerimKAvQX+SxWXLTLr518TbWQpfgujrhvAJGB8JHszepKUt0wybZ9u19yPVbkOrBKVJQS9uYKPIb2EhqWTTP2yYnosOsZhlFNGYnbIy+dimkRc8a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(396003)(376002)(39850400004)(451199021)(6506007)(6512007)(316002)(66556008)(66476007)(38100700002)(66946007)(6916009)(4326008)(107886003)(2616005)(83380400001)(186003)(26005)(478600001)(2906002)(8676002)(8936002)(36756003)(44832011)(5660300002)(86362001)(6486002)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C7tzrqX14AK+/bXzITchy58mbNJMNbr2fE//HM/6VusjY3sBwtxZ0D1Gu6U5?=
 =?us-ascii?Q?12Y2LkEOvnxB37UIeHUz61N3vV198yanoTjch4E5RGbf/34+U2KmEyHKL85a?=
 =?us-ascii?Q?goOlbJ7AYSjpsw0mKe1imGpK7KH2Hd1KMI01oOYoFjJf7UCHiUlHrTiHebu+?=
 =?us-ascii?Q?ghFKo4ZHqUXTfABdKiPkZomESbkrR7Hqy5nT19Poc6T6a1fMlXcZCcH3rnBZ?=
 =?us-ascii?Q?ehLIkQTuK8Ad9tnSmBgONlkwqnPEeheFBvNDBMN8UN4DbE5PbUbYTYyKjjdb?=
 =?us-ascii?Q?vHNaFr823zZICMAutVdmOibILjG2DdkwkkwkDTp7B5ng4AR1/O6B98lNzU9J?=
 =?us-ascii?Q?cn/nJV03GNSlqqBR9rJkRBZNd7RdmglONPUtdEJC5W92IPJLCVJDuX7L1pYk?=
 =?us-ascii?Q?wxyi3URoPAXtmrA3vnbEQdDIGeJ3LS1ML7d5nvyOxxemPeBtYPWsZp+s8+qV?=
 =?us-ascii?Q?JJCBV/4JYFO7XgpXFF1iXMylPza1/jcg2uXExlkbio4kzpyJxZMxlele4/Ry?=
 =?us-ascii?Q?HDkO1rDiPjnigVll3/qwhFk6LkYQaGXljdJSO31G+Y09wtYLHVkOeK+9D3VK?=
 =?us-ascii?Q?FrNIZbG2z6Aqa83Sn1UFqM8vcJ7K4+Xkfo+dPuR5r2nLbXNekW6UWdBJnXnT?=
 =?us-ascii?Q?BoYp/T2gkKjhEruHNVAmoYpClSWZwzgKPvQpsUintz9hOKHbq0Yzp6OVJlaH?=
 =?us-ascii?Q?c+ClOEVZ5G2Sa3Ww7CpWcrOteEG8L7k8ikfx5wNjRsWXkQO5KlI4JMp0ueH3?=
 =?us-ascii?Q?ibwakf1ho3J+O0GxsILvHWvUlWBfUBFA4hrEhgrrAGT7wLpg8ywgFh3FqNa7?=
 =?us-ascii?Q?xSc47oCWiZMPfabgosycFS7TbaQh18IXrleLSGd3axmcAC6Fcm/xc0Z2IOV0?=
 =?us-ascii?Q?px3vdjvrFn/at0mzkiTFLiTRSWUb0+vGY2Wx0gX9pGgzgC60BtOHnTW0hAaE?=
 =?us-ascii?Q?azySNxtiv7rpzHfc40Udhr/PuBBrZN2FaYp2SmtfIRdANnEroh76Np6RZMa5?=
 =?us-ascii?Q?PZug7kM2Zq/1XHnu5opTmikKaoZ7AV7rfgNBfd5Lyliuh5CR3rtft60+AoJn?=
 =?us-ascii?Q?OzLtRyF3HncF8VqGz0Daao9yJ2/fVQDFaD7g2c3HsoCijs85puZjMSU/qQBB?=
 =?us-ascii?Q?A7t9EUj3GMxbdT3qATPhrEyfFMgumBExgYmrqdyXXz7dVWhclHMPnSqYpG3q?=
 =?us-ascii?Q?WjMb27secYY/Eyxkq22ZAJIPKpw4fhYhnremXuGzs5LgHoxb3TbyWLriruIa?=
 =?us-ascii?Q?queWarhcV6+SbMTBgKxDv8OSaCw95iCFEZgpVcb1ffSLNYJmJXXwPxbTVcqr?=
 =?us-ascii?Q?2kvbhFiH8oYIS5zAPlfWMHVKN+lxDYdJ3hlitxDX7lxPucjHFJSXQQQWGvIe?=
 =?us-ascii?Q?/fPHmFesMojjvL99kK1jwfQErXnWMzLbtUzyOV8MeB5CAhdLTxTVUNjtx1gF?=
 =?us-ascii?Q?IgwT4xCdQ10uq7CiHbouu/nCfkRDLpiMOCE7BgklVgIW3lkczLP7ViAYijH7?=
 =?us-ascii?Q?+pYhPnZ8dQrDs8mf067OQVPCEAgSs4G7sXeEZW8Sq+rFjL4Kmv50Llt5DdpP?=
 =?us-ascii?Q?ref6IMo0qzNYuYaF4h7ciPfnDWxtt2wTBn8Calk5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69aae49d-56e2-4539-6a07-08db7b9059a2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 06:40:11.5539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1OPBVAZ15WASYmdU8ta80ve/khDdPOUpzO2bg7b3mFt3fmkJQWbvqtFgTAH41QJMHYKhJ1rsvUQIAsQNlUxjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9524

The arguments of socket() need to be changed sometimes like the MPTCP
case in the next commits.

It's too late to add the BPF hooks in BPF_CGROUP_RUN_PROG_INET_SOCK()
in inet_create(). So this patch adds a new wrapper socket_create().

The arguments of the wrapper need be changed through the BPF traces.
So add a new struct socket_args to put together all arguments, and pass
a pointer of this struct to the wrapper.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/net.h |  6 ++++++
 net/socket.c        | 12 +++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 41c608c1b02c..81f6a85512ea 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -84,6 +84,12 @@ enum sock_type {
 
 #endif /* ARCH_HAS_SOCKET_TYPES */
 
+struct socket_args {
+	int	family;
+	int	type;
+	int	protocol;
+};
+
 /**
  * enum sock_shutdown_cmd - Shutdown types
  * @SHUT_RD: shutdown receptions
diff --git a/net/socket.c b/net/socket.c
index 2b0e54b2405c..72fc8701ce69 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1588,6 +1588,12 @@ int sock_create(int family, int type, int protocol, struct socket **res)
 }
 EXPORT_SYMBOL(sock_create);
 
+int socket_create(struct socket_args *args, struct socket **res)
+{
+	return sock_create(args->family, args->type, args->protocol, res);
+}
+EXPORT_SYMBOL(socket_create);
+
 /**
  *	sock_create_kern - creates a socket (kernel space)
  *	@net: net namespace
@@ -1608,6 +1614,7 @@ EXPORT_SYMBOL(sock_create_kern);
 
 static struct socket *__sys_socket_create(int family, int type, int protocol)
 {
+	struct socket_args args = { 0 };
 	struct socket *sock;
 	int retval;
 
@@ -1621,7 +1628,10 @@ static struct socket *__sys_socket_create(int family, int type, int protocol)
 		return ERR_PTR(-EINVAL);
 	type &= SOCK_TYPE_MASK;
 
-	retval = sock_create(family, type, protocol, &sock);
+	args.family = family;
+	args.type = type;
+	args.protocol = protocol;
+	retval = socket_create(&args, &sock);
 	if (retval < 0)
 		return ERR_PTR(retval);
 
-- 
2.35.3

