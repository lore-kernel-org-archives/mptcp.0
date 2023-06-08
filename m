Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B946B6
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 05:48:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0DHE7heSTPYvtWJeODFV0flqogjb0imsm3V3zU56hsEEEn439IsBrrUGn/RPCOO6jtlNNwzWxSxSqWq1N7+e7s5h9SQvDaB+V1uu+iduHISv3awByVzKVPAPYi1evgpf8FvMQ05FwJl5PZPCw9qF+dX7q1VUHchuxNOi38XpDdynjpb8XmlThoZ5QWV45zcMZwkSh8e8n7rmSArq302XbKgqHq1lb4aWadJJo85EgUG9z6nAj6gQLHDeDwkfaYgDZfgDMWhPGl8lW9i/6zxpybL9DHUjOyuwb0/l7LNIPcRKH9qTyKlaSyLGpVwsw1son2glKX06bC8PtuOVf72rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jFD3qSswn83oCaWVCSLbYQNfMIu4XTz1EKt3ubzvIk=;
 b=k88u5Q44QlLELEsVZ2MvoqrHWs96cgNAY3nxjEYh4PvONA7kZM+5bdnnb4wHP04GBHjV70S4Sp0lNBpisyveow46AGiL4UI5EHYCYJJmUsU/3m6OvpM5TKzeuCXAxhBQCanhJv8kS74+o7AaEgkr9IekkliOtkPSdVA1+XcYSV2MbBTMwa73p995++IsLiMR0PT6mNv7PRVj8hjEBRFOUBLTgEdkfbr4xrDDxGSQD94C1mRp+SVswQhKCjwtAHlEeZgH7XxF+JE+mBb2jBWGYLsIxPsCdCfKemo2YP8qGHJFs4eUNdMeGiPCQTxV9YOJuHza8APKu0MS0KmFUYAlyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jFD3qSswn83oCaWVCSLbYQNfMIu4XTz1EKt3ubzvIk=;
 b=wcOnmHrYVsg3qBdR34Z5DMkSlzL/BYbxRtNhseNqu7qgGnTSRMRLF4fBrU6SkkG9z1eLiCkHQGx1vo1+zK8TR3psouXjr06oSwFnCDZH7P8aiBaNJPt1gth/70m9B67eGxPDlhiPZLdGjQa2ysZ+D5AtICW0UtzMD57PHD5Vxc8boiWBXs7GnQVgoHVJA1hoaUmlMqra1Avazm+l557rv3FsldDntddGbQu1FRAojeti0N/gqIMF3gDBpggLDvvzaMQh3lQ6IOT9dHyyEWxer2zdNk6CqQuFKEVa6gjx+PVGtSvX+FyHLE1PmAzRDyl8eAtwTNGIKUE84yTtnzambg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8609.eurprd04.prod.outlook.com (2603:10a6:20b:424::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 05:47:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 05:47:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 02/17] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Thu,  8 Jun 2023 13:46:40 +0800
Message-Id: <25ae6d0074653abb94439848c2d3a4d40927a0a9.1686202841.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686202841.git.geliang.tang@suse.com>
References: <cover.1686202841.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a7e90b-cf25-4d19-f524-08db67e3ea0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KStdnNsk9YAC+QbXq7Fi/cQV4PHbIJnPsyYNgqk+wa3JvjZzR9PMqRJ/1HK7l4z7H0+zYvIIUngfjYVcqOCZyNFALeBjOeVY8DvAnKRERVqz+Au/9md56kbWtTReHeN/r/2GxGU4oHc/gzes67Jc/r9uAl6cgcSSIK9z4/SfHsiTMnmEb1CzO/pYdDC8JfnoyTpSsRNuett5KUYUL1JpQWV1Lz2VNxgswaA9MIX0VduRmEWFWluHh2MJHrsjvD/B/9HwFKie/5Bt3hvqX3qPS2EXfQDLMj7Hp60FkBLZbBDIXvwD0fzrebbgNlkGdriGnxgVYX0Di5SxniGJdCvIi6b4sOuI4w0/Dmd0GvjbUr7NfXDGzOvitH4Nvc0kJfUaGZbqCTpzYkX+RXjuGFG8nWtneBZ9Ni7wq4Jb/Q0bNPxa4FObRyfL9Ga7JU8N3nWe0+y1loNMepMmhc8UPnqdN9EeOr4B9ZB6WG7LfO6cKQ9VWSlFmUpKh+BmNWjxeHa3I/3oHWL2joM8tH4HypmKnYYIa4M8XHv/HioI9TKHvunbecKt0VrZkms8WuzNSGY9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(66476007)(66946007)(66556008)(8676002)(8936002)(36756003)(5660300002)(6666004)(4326008)(6916009)(478600001)(41300700001)(316002)(6486002)(38100700002)(186003)(26005)(44832011)(107886003)(6512007)(6506007)(83380400001)(2616005)(86362001)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GJD9f45wBBTqN71JHCWQeg96B9PuLcFxmMLg53wcUJJH0B8EOWbpVPFqWFGc?=
 =?us-ascii?Q?/jqcv668sjl2FZQfu6lTAAgeh2CfP6oDH8LzB6leljSAW2c7UP1zOf7g/sBH?=
 =?us-ascii?Q?GuPcPFfiaTx9J5RaQabCU8diizOR2iwb2kEQleVFdyrqfKU9lj9UI7Di4v5J?=
 =?us-ascii?Q?WHXXK89TOkL4E/lCuuF+BNJXi/DeqI5IeugJeZYpRi0y9zMpFN5JPbw316tq?=
 =?us-ascii?Q?96vS3meaBqSzEXyC002mt78aHKRZkdtw8N4Ur4VupvkpJPk6cOlKgqIM+8en?=
 =?us-ascii?Q?V+13e3T+HlZMYS42DInzgmT+VoZJW9ouQ7httc45jaQoGgSMMeRhq3OhEY58?=
 =?us-ascii?Q?0yZMGlUGcarMPhdec20V809k3CyNOo9jtm4d5LSYpJKW67UcJln5NO1wGUsu?=
 =?us-ascii?Q?Qlkpy5u3aRiUdk2QAoHT/W44x/8T7R83gwdoPNBLRFjvn7iWI79VN1TSOPC5?=
 =?us-ascii?Q?//JIMmMbghZ1doIZ1zNUBaDsmNWFSLLao5sAAqTfANbAF2vv6STH1+yKu/k9?=
 =?us-ascii?Q?nll/WLLKsJCItG3yAEhe/M3anlNTkjP/MZoQL/nkASHReKUaGfhzCTXzIMg0?=
 =?us-ascii?Q?Kcmvq5X/b4AMz4uMjVt1o9LlDZfF+A25OxBPSyzEPS8atXoDywQia9JjY6ix?=
 =?us-ascii?Q?ePTXsEDUCIrgf51Mzb9tFtz8NmnpI3+Q5oTgP9ikaXMctmAP712tTTqjNc5v?=
 =?us-ascii?Q?JE2mojiZr4JJfMBG8PyGkCMAaANmH3xvezPS/1i0PVyS8NGUsG0OqLC7DE+2?=
 =?us-ascii?Q?hWRJZAE+QwL7H9UR3ADu76i17KJbDRiJI3DL4zTpBfvk42fxkwsxBt0aol2n?=
 =?us-ascii?Q?ZjBFu8M1w0AltkmU/1gQmoMkJR1Chfcns3uYZHBQnGUURLgCsR5nVi+3Nf0I?=
 =?us-ascii?Q?5o+lDcINmlSrf4vYUGWQqUjZRGlh9Ezi75bjdqYDZ79Eqm18LkwSE0mV12Ea?=
 =?us-ascii?Q?/Hrnv7do7Rouce5B4e7vfsszB4HZbAZKzGOEy+2kn0Bgmi1ZMo0QJwIg7xKb?=
 =?us-ascii?Q?B3fNHLXDS5/AptIPLoPLuKSxatP1DHoC1vBRjWtNSFodVw7BkX1G3f6b+07F?=
 =?us-ascii?Q?+WNkHXthv9wlJLqt6rl1PRzQJlY9Pd3JHTrUAyelpTv278qr7z9+jSGTvlzY?=
 =?us-ascii?Q?OX3e0IiEQfdgX0/phy/uH5K1yMXe5fheh1qs4nVIcFI0dMe5UrUJ1uj1Oa9C?=
 =?us-ascii?Q?OLYkL5jIs3rKBrw5GuN358tp2X0b4JhRMEXZFrSTFiPgQE2oWin/DJ1y/io5?=
 =?us-ascii?Q?F6MhNdh4cc3My9/qS07C6pIf8DIY5qmXuxqKRCLy4z6/rDo5MLdTTYU7NIZJ?=
 =?us-ascii?Q?/GFmVdJJImdxi/KLFXfq1Zeov4S0Kvs//7OxJBzDMOXgYUYRA6KNxlVfxcUY?=
 =?us-ascii?Q?Sj722rSW3hrSm3X1aiLT0qsmKIzEWdpUanpjGYdQSTzaBEy51l4SL4FypI1F?=
 =?us-ascii?Q?SxyZ2rLqRrwFc8uLjEoiGZKZPOMq/SsLLaKPR6o7+vx6o6pOKpnYW4T7mudy?=
 =?us-ascii?Q?PrCPcdCL9uheTVSJ6/jteZADLvA39qlESovzvWUlTFRs/LuWHlE3O5f7NqxD?=
 =?us-ascii?Q?hz/QMvjiBwVFsOo8QsmlG0FAIfCF4hUBfG52dJQ2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a7e90b-cf25-4d19-f524-08db67e3ea0d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 05:47:58.6471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgQW7jLqawRQ7QBqvzr9RpcjB2D7sCJFiethklfaIC8byf99D4ss6TegrjokIR8qLmARvl5VTFbl7ALSJz4BIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8609

Use two tabs before reinject.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 828b10ddabee..4bba29c99172 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -100,7 +100,7 @@ struct mptcp_out_options {
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_sched_data {
-	bool	reinject;
+	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
-- 
2.35.3

