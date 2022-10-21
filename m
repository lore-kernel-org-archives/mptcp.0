Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00064.outbound.protection.outlook.com [40.107.0.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26FD7B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:01:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jdi1ene53RWVAfHRJFjtBeYK8+rWE4wQZE1NSuWeRWTd+e/Erl606+okxs78Y2gWYNSrRAf0QsfekZ9UettEHFS8ihLqhNTNicz7aFBouHXIdug1a7PwCqfnoShZjedKn4MGUYzAXJJXdV6X6YZ7SAEh+AdfXyoZBmnJU06uu/3Lk4cXXG01BB5ucwmXbdYLowGeih3LVfLej4KdT9l/1T5PBCrIBZtuZfNrtG17dQLBV2yO4HAcmIy19ftyO85Qs0zeB1mquQU9R0W0IQJa8h6i8hvYZn7Gi0L5kkksjsf+1c5DJPm22rnXtf3G4LFP4oYjnjLyi+L4GmcElkzv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJlUEnYR923SbjEr8XhmdDc1WVaYv794/wZoe7ly3L0=;
 b=EmiMLlW81f19z2O+woaFOu5J+wTddFR71/QViCxun+/L3DPUR1Y5IIu6IJtl7RdO1e1XYlXHcJ1sTwOUSN6HuZ5SGU9LAVIPskhpnzf0I0JSWGV74NSrXhCM6B5xFirlVO+p/9Vv8lObe2S7AY9PTUiVk8FXz79yfWdedTewNaDNmycSd+kW39oXHWjGjxGtLsaOlJou8elK31OhKogl66Wi4XhTqylHRFRPhdEH6qfJsl2CzgCqKJJ9rhUs7B9oOie2MPR8a24KgGbhVDHrRKYeEXTpsItSXIn4b9BjuprH19k8VCejVwU1+osJqvt8yRkEc6dbNdu71hp+stRV1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJlUEnYR923SbjEr8XhmdDc1WVaYv794/wZoe7ly3L0=;
 b=KgFH2K0aNcaQdZiUG8zofSjzMBWbHFgiPMqCPaMUh6ShuqErsON1NlQu+eZceayocu5ZgR9suboPZUDGDrc2BlJLs3yP8rF5fzATwctbietZ3VXOp8qdJmzgNc0lTduY80z5AcQo6nH7Y/nAPkkf0kerwl2Okn+vHh4cagR3r5LnNt3OLAJvvNz+7wDMYSjVvllAvHxOV5wax9xHUzQVXNkcLGrIQ4387Z1vUgjAS81Q5sS1gEJcaePu35UxPrZTsxoidEmkdcPPgUBTZDmB5+mNk4oN6Yv2oS+4YEt0O8+QolUCMHHiJIVApw8fqURupRRq4ueOT8KfI0FJlbnHKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBBPR04MB7835.eurprd04.prod.outlook.com (2603:10a6:10:1ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 11:01:47 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:01:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 07/19] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Fri, 21 Oct 2022 18:59:59 +0800
Message-Id: <9bf109af534527fb9afe33ffa0f63257c721c0f3.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666349129.git.geliang.tang@suse.com>
References: <cover.1666349129.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0102.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::18) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DBBPR04MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: e51883bb-1225-4515-b48b-08dab353a5e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/dIojgeXr1OH8MYPc7wpYzkK4G+HTX9YzNbZeEHxlV9CAtAhUcOxjVKpgm2zYg+Duwa8Rj+um2tAvgUJInin1yEF8hEOqob+d7dN3XAp52Nl04Y1dvcjO2/2UtlZjrQtuAkMc8j9dgz7WfCYEVzQyXUZsSIzDlO7u9LMLqCk9+Dhl43we/e2GpsRjg+50XHTrNHnITGbfAvCJbtUVrOdxQpXNlxFiv3cdFWC+ttOM5pReRKa8Qmkwf9AW0VS2XJpJyA/reA1yYBR/od4VqVkC+cBhfvBKx+Gq4HuFLFP9e/BCEuaEr8N5UDAIRaKnD9gGSwc7Q+R3CNYqqeLd8iZBRkTtZA2QB3MQS6rWq6qpT+cgCa6/dGijDxbgYFG5SVdEmFGd7GoAQgB+VWfiVWHEiSqVRHf4sQc2A3meyWB6Xa1oRqhqL97qr0MWJ7jCDpRmMAMP7c5LvNyt4AiGoGwWUEvsfRvnBue1j8LU2OztozuIl9J8/gpHlhTNI2Cr+BV/HZQ+xkHJtRKAZ9JaCpz+6k+WtyOAm2SrRWNipkbDyrKKFViYfTg9B3U0Jf7Q+Sej0+bqwMHPtqAujiOmuysTlib4TfCVUfbKz7FiRxMRezsK1LheBNgwzxt1AmlUf9ldJoIH3o+PYzNCpNW/JIFovL4q0DD2yCAItndKrzZwxXPhVsfME6de3Bu9Reqzmk0EIUROx+cmmxcxbByl3O7hzWKQF7kQWBoyQLquARXJKUA7m4fHpi0755tIGq5qOgy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(44832011)(66476007)(86362001)(8676002)(66556008)(36756003)(66946007)(26005)(6506007)(5660300002)(41300700001)(83380400001)(6916009)(4326008)(316002)(8936002)(107886003)(6666004)(38100700002)(6512007)(6486002)(2616005)(2906002)(186003)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UuQE2TL19KBW+WpzaRVh5YPzVgCRU2+NupMcmnXHtebpEeZiZWn88GlPuGOu?=
 =?us-ascii?Q?vbQw+VMjbiXi9IGmEUh7Za7I/nNWuO+tshWXKxpkZ6fseT3xDHKUWhx0XuIn?=
 =?us-ascii?Q?1rdd36iY/SwfaELeeruY/vbDUMdZQrAxHfwFXawXb2rQSuEQGRbliD08mkqI?=
 =?us-ascii?Q?yEFwLR7FQ42HOP1nnyFMgsxl6rzE3mzKVfN8LHdNMlQ9jDyR+LWTsfUt4Qg9?=
 =?us-ascii?Q?WiRXRH8Fd0MhwKpZwIp/9XTm6XOZymfROhkYbHvwbsZeLznmMvotDGFwl0gh?=
 =?us-ascii?Q?YTekZgZqZvlvzuyB9TPcQH5q1Wo52ZgSZVm9BSn2Sada+2l1yFsQjRvAuAEa?=
 =?us-ascii?Q?HZ1naMCMSWVMkAKZ9h2MkciB3DNsBW2OYsf38ZFJLUgDdP0F2Fo24PMRnPoB?=
 =?us-ascii?Q?7PeVNKuTwS7ueeMr8sfl/IkYWbv+l3ePYJETb1GPHAk2MnBO6WqLRhYXVZK4?=
 =?us-ascii?Q?ade1ysY5Tq85dxYBxpfRq7RbFQ20PZta0gocewPZ3KQJH5X7/AfMyR42CCj2?=
 =?us-ascii?Q?i6P9X8skuQlcUBui+2pGa5PG4SOr4RV0iQqZDdllLFTBxGN2K6gqiiptxEn0?=
 =?us-ascii?Q?GieS43FDsRUEcX1dYfV0JFYXoWr8o3MbSMiBU4gr4JjS2rjp4+lv0joQTsID?=
 =?us-ascii?Q?5emoprtqmE/5dOCRwjbgDBTlKTyTudgOIuCUnQpWs0QQEAio0H2oNRiE6hbt?=
 =?us-ascii?Q?EJyDVF8tLVSpXVDHWy4eItxa71fxqqWdIo/xbqYUl+6SLQrtA3Z0SClppX+q?=
 =?us-ascii?Q?JqwDRRQ6bdvpqte4abvzUdDDrQf6l6WLHDPo47oJCDps95/cpUhGPSeVWlJY?=
 =?us-ascii?Q?tFtNh8Kgu+OLA4D4OpIvNaBiK2l01RPExIHhm2YSTNG4VOGeJA0pKcUfnJhf?=
 =?us-ascii?Q?F8NEVXalrsStgc6Cw95vF11kNdkaRuCLE+GpvBZuCCAYlp/WuDf4lrGN9w7j?=
 =?us-ascii?Q?obdyRdhN5nftmM6EMwm4UTmhE4ZCWf8LdoVxRiwhiWmgPvirEMJXZsziOFYF?=
 =?us-ascii?Q?JxKtTdQpcTLfsrRkHnehJEy33EAoMNs4WeF+mxRCgv473AVBnZWFmdkVdvv1?=
 =?us-ascii?Q?lsu0sS+2+eMBKoeS2tTxxOM6FutAINX/sbUD6a7HTg5X8IA9TYfEGZOfOKa9?=
 =?us-ascii?Q?EYac7Zl7Gb1fsgNt9XPuUFlA0976IzArVsm6an1d1FFdrsxb1pOmV8NL6DSC?=
 =?us-ascii?Q?t/QPlMfKRNhSOMiTtAQ7SES2Rh4rLBYQ4EB0P9wbTu4auIUYcz/kKKhZgGCs?=
 =?us-ascii?Q?VZQJ5MA7CLApm9ZAIx/bdM742CiX+XgBN64y2jm0Z70fWxMXaZX/4qPrOceN?=
 =?us-ascii?Q?B3FVycKQVbYIuN+fGRBVRMNYQNA3PC7gIEDew5XIo7KSGY9EEWjcwzF5Zu+d?=
 =?us-ascii?Q?TO8DL8slO9YriHF/FiELTvNq51EltXuaX0TUMeIotPseCDl/teD9DMewf0aN?=
 =?us-ascii?Q?N/SzDKRSX0q0+/duLT71gS8n6fIsvqpyYNsRH1G1P05x08ngCOpxjl786tbk?=
 =?us-ascii?Q?gLhd9AtNeyXFY51PGvaKNGWOWdJvEoeLc1Uv/bU9L1R7+vBdIzNm2jnkwtC0?=
 =?us-ascii?Q?I+R0PlygYv5KEnptHgrKxUaQ1fQNUe1XczuQV6B5Z98t1GkRe9LkmXy8psrV?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51883bb-1225-4515-b48b-08dab353a5e7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:01:47.5773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iu54PKm7txAmRcQMZwL0t93DbdZkOKKlzuCsfNTz5SCLd6ND3ARMd2cj0xCCZll6ze4/sbne/6E4dMaeP/cLyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7835

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index c7d4a9a69cfc..2a7a613f87e8 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -246,11 +246,18 @@ struct mptcp_sched_data {
 struct mptcp_sched_ops {
 	char name[MPTCP_SCHED_NAME_MAX];
 
+	/* burst scheduler */
+	int		snd_burst;
+	/* round-robin scheduler */
+	struct sock	*last_snd;
+
 	void (*init)(const struct mptcp_sock *msk);
 	void (*release)(const struct mptcp_sock *msk);
 
-	void (*get_subflow)(const struct mptcp_sock *msk,
-			    struct mptcp_sched_data *data);
+	void (*data_init)(const struct mptcp_sock *msk,
+			  struct mptcp_sched_data *data);
+	int (*get_subflow)(const struct mptcp_sock *msk,
+			   struct mptcp_sched_data *data);
 	void *owner;
 };
 
@@ -260,10 +267,13 @@ struct mptcp_sock {
 	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
+	struct mptcp_sched_ops	*sched;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
 
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
+extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
+					  struct mptcp_sched_data *data) __ksym;
 
 #endif
-- 
2.35.3

