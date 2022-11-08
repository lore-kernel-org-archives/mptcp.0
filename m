Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2069.outbound.protection.outlook.com [40.107.104.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799EB323C
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 06:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ob+MrdTghq5nxFKrI96HQzVxhiLW6ucg1FsvTDuzaTZtSdqPajXaz1vwW0XyNKg+Z0IRjwhl2VnzJiPPqR61ScDFaFyLw6qWeaQEgOIC+8mftW9yETXI5UXPdYB8xB/lSkPeKNJoh/Tl0X7kfIDnD4U9RUSDlDvNDpzfKZF//INixLVezGAzg8klXvnDNmZYqs5syBzhjj82ZlvSedf6YTpQI8Vz3HlB7f7xwAcdXun++lm/yRJ/XIrydQeMjcO8veJefLwFirRloqvFmLAHRYN2K1uskpZ3HPJzm7lvECBEEE5HGL2b0lCKezeL/WbWc6z66TdSQTczHf4nb7Aoxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/4/JsCXP+/OKQz6jjCp+OtHk954GaICx+c/+SeaJ/8=;
 b=U2HLM+99hihFjg8ngU8I7ihFA+oX9UTKIa3i18ZjVqdwf8CZCat+ishhddhA1uI0i1wLVEpfGbjo4HhSn4rMNLseF/lqjuRdJ4H8430+qBrmpHBviuiqFv+i6yagPNzA4pqUpBtuMcz6ss7i8zdvFkdcwybsrx0CX/AqVpoC9UEgU4BMDl3CsoOC0gh0GqMHTUzlWv8OgE1MjZ1XYDIc4+uGM0OLbXbGNH2nGZ73cpMz23QZ/IGZlohRYPauiZlDQvrEuUE4Ga8ss4+ayqFWzuTkTz3hZDDf/6zL2pzeppliwrrUVDs81LRg2qEa0/yF7hhpZVpoeX2bWurkgAmGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/4/JsCXP+/OKQz6jjCp+OtHk954GaICx+c/+SeaJ/8=;
 b=PirTOplk8ZUou8HjbSjFWPlVKCM23Ps+niSIcnsnG2T8l2QCmquPr/hf6GbznpJPwMnSyFuHOtHBisG7TOcDTIQiqcblMDVWjUzfcP8VZ2iQsrNbYeGpG84wnMLDtMe7BeANsFMzBDVwJz6TTR/ZEnQ0szdkTHD2KNQ8LS7xY63l8tM/37I1I0IRWoPfNNxRsc58jXFqk2gqx71MdnjtzrjFzoRvgPsCSo9SrAYPXUK38AGMqhDrswvY/KdSksxHQPHwpfYgjpIsG2QpKLdxwVOMD/Go/IB/G/Cah4vC264wC87WmrlENUD4McxcUnRajH/X/Y+4ISfdoMFWHluOuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 06:45:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 06:45:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 03/15] mptcp: add sched_data_set_contexts helper
Date: Tue,  8 Nov 2022 14:45:02 +0800
Message-Id: <8ac0ae06e6a92c3721c22f2bec4b5c07f28a358c.1667889809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667889809.git.geliang.tang@suse.com>
References: <cover.1667889809.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd9f751-5ec9-4944-3005-08dac154cee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NOZUe9y5ZCBPoPHG+W8HpNaCFY35PUqks8U3uzbjye4qFNSCtbkeWzTugyqq+SR37pbjXNDWxGi98yh811JLEaXKsyNM3/wHc6EgAxdAFziTvpEi0WLQTOWKSfhD3K8P7dMRb5sNHzYVcNveQHmhXpwiXDgGFtWFB9RZrmv7eGYEgNBMgqpPC2udPAwWa1rAzFbKKAbYSCljwScCt63GboLISNUrk5eNWZfKj5toqBNYCSQzWwA96S+W5Iy8IdAkJtnNlkm782stSb6fZFnkcvk4L9kFSGHECsokWiC0xl13UQ4kpt1dlmPi/wKUU5FR2x9a7YAzWF2v7Sirv4qaE79zkomysTGnVe+ou7sRTypYAFKU0gvFj+xauBch+1u2411IEWzbKZ83EXkttXrXwQxPZ953FF13LK0OAolmeXUBpzKkb5v9ZZ0jtdzmkY90f+cHsERYkQorxPfwyHbH+Z1OVAaaAfrgMPqZTAagXKHk7TAWFmk/Gm0qkBDs0cCPlWNB6VMXg6s2vnHzBHBUBAvfga0T/ooYtstMIv9+nwL8sik5wl2114rZI+Zq/NnegRg67s6ZFMqj3vClVLwVMpa6whVt6yjKypSelBRU9anbec3mHjMrzw8hpsb3G+YvzjLpMGcvrtWZGSIi7KoGblV2t2j3h2Y4fqO5tmB71H6Xq3+isiazzpXhCcgCSj4w3Nie2cMYUfqINHouyBIiipbUyWcgNsK5XQywWWUU6RRGDmFuyFImSP3Cf9exEodb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(44832011)(41300700001)(2906002)(5660300002)(8936002)(86362001)(4326008)(186003)(38100700002)(2616005)(8676002)(6916009)(316002)(66476007)(66556008)(66946007)(6506007)(6512007)(478600001)(6486002)(107886003)(6666004)(36756003)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uf9lgMk7nWDkSirSb4CTRYXG7v7QtWRp659byVHhWbJaqsHUt8O8yGU2ooQU?=
 =?us-ascii?Q?Y0F5/RpSQmLMgK08XaOFEqkbZ9hc6SDgM2U3z3IFkZP/BJ90HAxzVdbzp8He?=
 =?us-ascii?Q?TCY8ksRBjY7696eDhVMTVh/vvd0LyWhIS4KikcO9J+YyMzwvGKWCW63iSdlz?=
 =?us-ascii?Q?kRXgXbNJZ8gIhw0MHa1kEssZ9a8VFFbvjxvbpfnwGUS42y/pNWpY+/rYvo6h?=
 =?us-ascii?Q?oUuk+vjiynA6Ih0ncCtM4YpbZ+aeoH7rQrZbN2h4atZBAGpFv+sMbw2FCe/0?=
 =?us-ascii?Q?wMc8FjEGsrLFOnTrqjlcOgLtub0al+uH/ByxFzrQUtxNxEFLgVO2HdylhIsB?=
 =?us-ascii?Q?Ln9oXjF3KDUuZt1ZZRJToSs181Z/gvlIbz1KFm/gwpsuyy5iIpBywwApqiY4?=
 =?us-ascii?Q?geHksdC5yjYeBB2VJSqaR4E/rPh5ae3SeLHBZ04mIayfBIExhfA+5cB1HJC/?=
 =?us-ascii?Q?vkF873d5G/MTHSbb8P4ogHcxJvjwaQJQl/Vyd/bd9JfWetraa2i9fvv7WEEp?=
 =?us-ascii?Q?lutepFOLBAuhe3zxDkXyDFqF14z0bGR1PCt40uEj+VGjgxQ/u3mwdh4gVtcj?=
 =?us-ascii?Q?UdQasYHq3ol1h7+ry3f+AlS+VqpOmsSicc6Q9bPMCQxN9szCIjLBPHZ2pAGM?=
 =?us-ascii?Q?fRKZ+Nw+6VtnJD161XRwXRl2qROsaZfymZ9WYfBIqdBqLCTnWBvkw/EaffAj?=
 =?us-ascii?Q?i3+wCE+XqqB67rR3edS2Bw+Zxmb1H+dJRH+GARJUx32DQjs5ui9U/L+FZXif?=
 =?us-ascii?Q?MICnoi74/QnR/8c4KDu9tfA9mLiRkylVBmSmR/AKCZRd78vAluQP7HWnhyXR?=
 =?us-ascii?Q?QA713giBkbAnt7SS3zyyVuJ5Ep0w1VI3NoE3GNKq4j9dkltThtqXZ/X3u9iL?=
 =?us-ascii?Q?ijKzbKRCzL70Np076uv5VzGO4lgh2Y2VxpGDiwZGZ5lcIUMNIto5U+cpfPyr?=
 =?us-ascii?Q?hARf8BKBhnRcPWLCDxOoO5AvNINxGwnGeldNp85TbWxh23tYS0mrzOP3VZsF?=
 =?us-ascii?Q?DYfrmhteyReJz6yxGcXgZ4kx3oRrPcGbCfF7gloDG/43hRwaWqH7JtiFnNZO?=
 =?us-ascii?Q?4BTY9soqSLbaQWn+GekrdQrQLzOTza2ef98fJqeDwUd/mDVtczoI10B1dHlu?=
 =?us-ascii?Q?MKrqmx/O6OTEd/WutCjdsP4LXgSZTKX6q+wSSgR2U7asSL+a1Keie1kQZ3+h?=
 =?us-ascii?Q?QEKF6P54t1h9pYzAftsaP9qgM/Bark9CrAU4d0ycpHRJXYwDyRQUHZ4oSaT1?=
 =?us-ascii?Q?kZ3QWhC7zIoNFzkeZqclplKuNsoJxLlZj5C+teG3VyO7oyLcweb1zPRJ21r/?=
 =?us-ascii?Q?PgcA94KthuVOrjJ7O98L+O00ZhDENX6TAZf9xKz/Ug8n4VeH5P9t9XjHPpE8?=
 =?us-ascii?Q?jlO+bsQ8mjefvirdqX5NrpGETiGrrE3+1sXXTzr1H00GwOQhY+c9INukLoV3?=
 =?us-ascii?Q?UMqKw4iM12d/pFbE5AWy1A2/97SWPTsBVMrqpf3WuQFOdNGw89Z23yBe/JNo?=
 =?us-ascii?Q?Lmjze1c+U2KNd5TJRSYC2G4+6+6gF52Jr659X528TZaI6fPTevFd2hsH7Ymg?=
 =?us-ascii?Q?9SD3UKOxcJ8msjulOq8CwIYNgk8Rsyzj0UcFYjm7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd9f751-5ec9-4944-3005-08dac154cee9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 06:45:22.0242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XAYhaeb2ElA1ocMV/iy/7iE6sLfzhA2tkJzRzZiuHgjQqlVO8cMgO5ZIZNWDsfziGzhsBkz8RNrzibpMRBDFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

Add a new helper mptcp_sched_data_set_contexts() to set the subflow
pointers array in struct mptcp_sched_data. It will be invoked by the
BPF schedulers to export the subflow pointers to the BPF contexts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index d295b92a5789..5a910da1452b 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -93,3 +93,22 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 {
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
+
+void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
+				   struct mptcp_sched_data *data)
+{
+	struct mptcp_subflow_context *subflow;
+	int i = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (i == MPTCP_SUBFLOWS_MAX) {
+			pr_warn_once("too many subflows");
+			break;
+		}
+		mptcp_subflow_set_scheduled(subflow, false);
+		data->contexts[i++] = subflow;
+	}
+
+	for (; i < MPTCP_SUBFLOWS_MAX; i++)
+		data->contexts[i] = NULL;
+}
-- 
2.35.3

