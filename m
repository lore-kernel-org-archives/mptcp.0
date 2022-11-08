Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA5A323C
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 06:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H68LwAGajBtGdorytKH1AYFbBkDw2CZdro3mlJ7WLonjtIB8R/QRTNKVb4nlpAy5tLFlTZ1gfiOwBs7hI8B+6bLr0aQlUTqpv7ukkDpqM5cV5wHha7DgR3eIVYszu3kSoY5YAWYPAVDGUUo15i3dGEy0+q4q4ClOz5j4VjXmLOEJsFJqRhhmNzhA77BKQn9Rq1APIwCYU0zu/c4mJHXWIHV9VonvDC9zHhTAMJ74UzYBmHonG9CiBZY6NtPWgft2DDEHTPzghieUlXhRsUiA+BRlYQu73XyPBwaqsH6BT8bhSVCAhpA9Ach0s7wbE+1r+4IAMuDEkp60asqR8MA93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY9QF5iAszTFM/Lu7fkcGRgrUl4rViwkU7dZc8Hf2XA=;
 b=EabEFtMKwSFkhZ4llHtO7PMvz8acpeXOuxgP1+BlEm5JFqoEDW2MGkmcso8HKklQQVG/Mvjy0ue2UBpKgT3NTMxT5s2b7vZbWM9nN2Zhgb0F78kEfA+2Fl0Rj9dBNc0XUqt084iUgmIQ6skkQAg/cVAVrjeuoRwFUI+5PIRVBeB8J64RthIWqGT2saTOG4y1Mwgjd1XceSC3kiXCcfEU4eo1g1P5Zj3O19Gv5byCdEXkqepaqV2x5CC8dJH1vraN+MswsafjVJ3hOpNBxtETYZlEa6v+soidzuQWo3FOnIuOWRtM4uJxQRKR6fkQtbM9jB69PAxqT0qJqW8WbOz60Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY9QF5iAszTFM/Lu7fkcGRgrUl4rViwkU7dZc8Hf2XA=;
 b=5G8nSCSxQC6XWMrrYxEzxh+G18XY1N/BSgqJiYGWrV4GQDEzzMwDeLSrH9NnaaW+vV1qm8EnRpv6s6DhJvgPEVxQpaILF9zTf1CV1dgxUfFE1UeK5dQZlve4nGnwJEKrWJn4PB6jAiX4D+IAG0sPxFRF3Xtt2ndwd2eUy5HPWzpbwUP0FADemYA0019z8t9pcFE/sHlZulJqxfcfe9kcsWbq1SR2t0jgfSPIGJhg9pYv8kR1Q1T8cuPcX2l2KUO/KXEfqaLBKi74W+dYDPEnA/gNxP6JrBQPtE2R3CVq/ATzHl7ZRi5nM/lUcKbcuNDxNWOKMQi0JuvpKCQnyNQw6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 06:45:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 06:45:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 04/15] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Tue,  8 Nov 2022 14:45:03 +0800
Message-Id: <2aa42fe530bc719478cc9b214d38c9838fe5451e.1667889809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667889809.git.geliang.tang@suse.com>
References: <cover.1667889809.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ae26ec-fb27-4275-b3c3-08dac154d2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o3h44gELf1B7OnCoGs4rS2g5CnUgYIVC8/bLZSx3flCzw5UUJKGzu1L3el5W0rSN9OR8CYynjPkiv3wjFLnre96E0Abrf0CsDL9ZRClnJFmceHG6aiV+Uip+05h0NCcwPEzwLjgyAe/ryy7hVJrkGIkIv/G/O5+FE9l0OQMJgoQ5gCVhcrML1nqBKxm/O2NFkMTbnlabN5JT1cka0Jc81+mN5hTmZEghfKEJNHCIiwtWKT6Yp2Hu01lwg1vTf/jod3egytukUAS2iCdsjntTZNJg6t4hiafAMdcTpyvoigszabIcnsZtQjbWipTQyUHtgukW0ZHzHCbMtT3GMt0WIkN6mP6g8Zkf2Y1A8ury0lqlRKk8q1H42iLMXToRHA6giKxsEVLmgGZC8DtD+X4NC2IHXxVJRIcKDXaAvU8P1/Y3x/QO4ISFZN6JpIj2JNaE5lDPJGPyTjV4wU38cMf3CW1w2oC5Qb7S5Qgn7DYfiruvBLO13smCZu+BaW9S9EZ62Z77gDQFiiTPWhLlGS7u96fiSuGtrXzTnVxEbE99OwT8+1Zmp32CM1benPt+hqViYh9OS5vhGe1g3f3TryW0ccB2yvGO92SbnbP3H4cW5CvnmWamQzEcj0wy6YlFbMW4lsf/y0eoHNgWzhoBmN7XvkBXfRPhi9a9rSbVMfj1KfgYNAkJYKJkJjaMLOAmIJ2gh/0Z7qktAFjhBdawKyHOr7H753KYIoVFWHruJukcOGFMKrLHAb0Ky2U84qW2i+C7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(44832011)(41300700001)(2906002)(5660300002)(8936002)(86362001)(4326008)(186003)(38100700002)(2616005)(83380400001)(8676002)(6916009)(316002)(66476007)(66556008)(66946007)(6506007)(6512007)(478600001)(6486002)(107886003)(6666004)(36756003)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GKxQ6cVjUQhJPfgO9rM5cN9Y30q57yYNiCJByFOVW9JvQKfJ/C7OwJuNu1HO?=
 =?us-ascii?Q?IA5fT5aIpRVEmvsLjK7lgqEq1+oHboum6x+MIFqB367yAvpehcBm9GrLyKi8?=
 =?us-ascii?Q?1Fa8d8vAdMSd/fnGyGpUoM6dRaWlBS2pqlvAaOI73jvQd3/ZOr2lxwK2XRUt?=
 =?us-ascii?Q?wjvh0EI/yeqa2FIOrZL71rhBgLJfZbtLwEnoEqtGygxWl6w2+PhrwVAFJCVM?=
 =?us-ascii?Q?bQevzzlF8AdIW5DblWDiKkKkrGZ6Z7nkaKgL0nBdvqZrEZBoNuS+Qy3N73JZ?=
 =?us-ascii?Q?AttPQsluHS+fXz0oBmN3Xx4eWpzuMdGQGbCzfTZ5AriGWCR8oHDobxSfI+jy?=
 =?us-ascii?Q?m2BeC32q4QC8Ae8jpDK31tyGL5D7dzvJz1AGfE/hFFIoj3ka2g4zNuZjvrDt?=
 =?us-ascii?Q?aQPS0lZsZdRwuOicRHxL7/NcLBYKrgyOrtbSCqzq7nxBGMADWkWkgYvh7/3J?=
 =?us-ascii?Q?Vp0P9cwbLdebjGUtV9aC11Yvlui3F3784hoJtmZN89H/T+VPYLiKIseKD4pE?=
 =?us-ascii?Q?41NW+OqsGSMz9pHx/nSZwhZl3BEC0uG/BgnnuxirUcMnuC7Kbtfp2QrxblpI?=
 =?us-ascii?Q?LAcjOjWf7Myw8pyBdhuf4Dt5aDavGO91C8QVLIy1dGwfBwBBmHZXP8tb0sLJ?=
 =?us-ascii?Q?rh9w0dtI5m2wDadSQBPEVqjX77m7/kESaK8/mlUV8X/eaecC3iqXL3iTHDdh?=
 =?us-ascii?Q?MrXo9nZa1bfDvjIfgcY8938WPCnVR2AX/UBSlJyzhxs/Sqbdf2N+7B7Np1uV?=
 =?us-ascii?Q?pIdtIFYxeCECvQPYwLit8sRaynCipmNQKg1TFZR/SUsgMM/KUp+km1HI0px3?=
 =?us-ascii?Q?fJUIw53byEugjgeINchCtQE+s1PEBBI4OjsJR2tYQhnT5AXbVZp0FB9oqvnr?=
 =?us-ascii?Q?swPRl+ZUYDLnG5OKeoFgOa2/uPixakyhO9FJVGK6BtbPZ+04D8fEYtXgxFiH?=
 =?us-ascii?Q?FPWbP+p4RWgLirI0OwQ7pUPSlsq4XHhm2pytaEl/0AqRaomYlfRIoRz58f87?=
 =?us-ascii?Q?3FsVd/VsHzKKDOPPf/kx8+2FOxajBvjDiO1+ezdQch5vUp6PwBehW+XgN1H2?=
 =?us-ascii?Q?qiizsOTAYy/+6W+nwLGiJ1jzSWgrduC9EakRuyzpuOqpFLhz/S9ccfuvTg2L?=
 =?us-ascii?Q?xQ4dg3DvoGQIwP/ZtZSZpcHMpH2CgdwPTkpqsOT4I/Vblm32bhqKm8pPJzV+?=
 =?us-ascii?Q?nwZmJVWcl2m7ksrQ4K6LHgS2u5oOXyTzrEoADExlO2ySJ4xQKtK/afXy06wT?=
 =?us-ascii?Q?LVXm+ESLq3dS2ydLf9qkDGysMc4+jtRNolibS/I4/gFC+zexm6cTeeOES85v?=
 =?us-ascii?Q?F30Wtc2HXihVmivrrE21bJBsTDzUCxrI99padernM8Kpa/mqPdF3IxPIN/bW?=
 =?us-ascii?Q?hDrrXUKls4Ob+rgxH2vELE2vIwsahUTb7Z2fqiv73DjTqeYI78Mk8Nct0h4D?=
 =?us-ascii?Q?Ez+bcmjkHpKQEVTj3u4Nj0Z9kDlRAvVZrvhZ/642JTn6fMV/SKElOPQ8xDzq?=
 =?us-ascii?Q?xvtuEAIUPzdwqthUlyfUPNhkJ5fCNAHzD/Yks/FVGZ/XtmjYHftyq9JChb6I?=
 =?us-ascii?Q?1OM339XFelTMz5m/2YtrX10x5893mWPd6GjpWAli?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ae26ec-fb27-4275-b3c3-08dac154d2cd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 06:45:28.5708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43nZyqd0xFgTvRWpNZTMAmi/7cbfb5mfQxUILuPTp5fY+oCiAhhZc8YX49TEMRyA1kvo2JOAHHqTpvKmkgiYaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

New api:
 - add new data_init
 - add an int return value for get_subflow

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 6 ++++--
 net/mptcp/sched.c   | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index c25939b2af68..0f386d805957 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -105,8 +105,10 @@ struct mptcp_sched_data {
 };
 
 struct mptcp_sched_ops {
-	void (*get_subflow)(const struct mptcp_sock *msk,
-			    struct mptcp_sched_data *data);
+	void (*data_init)(const struct mptcp_sock *msk,
+			  struct mptcp_sched_data *data);
+	int (*get_subflow)(const struct mptcp_sock *msk,
+			   struct mptcp_sched_data *data);
 
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 5a910da1452b..0d7c73e9562e 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -33,7 +33,7 @@ struct mptcp_sched_ops *mptcp_sched_find(const char *name)
 
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 {
-	if (!sched->get_subflow)
+	if (!sched->data_init || !sched->get_subflow)
 		return -EINVAL;
 
 	spin_lock(&mptcp_sched_list_lock);
-- 
2.35.3

