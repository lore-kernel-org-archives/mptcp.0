Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80079.outbound.protection.outlook.com [40.107.8.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52797652
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 07:48:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOFc26rBkWIiMWuv9CcZirJ9/srZVgm3ChLn9nXYckFdc7iXwqETRAW8y5l+jC6cvB7J+3Wlh3jLfnf1CIQIb6Tx/DEkZX5eM7+brgzLE+VXvc+3NDQjDvTZgod436gyLfanRiS0UxpugYWNqfmXCZMOANxADcZEmZtS+XmWZf+MwhhFngZsn08cdTB5Zeld8cr2/sc79mE3gGNInTMAz+9iseSFYUh66cfLr/I4rl001elRDNftLMOpIz4/jXTPEzmzBvq8uS55Kk1k4vNfEtACkTZO6+FR9HesmjqVxFqlK+m+TQLSriW9H+GKFXBY4sFUqPyhlTPMTv7JyvZIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY9QF5iAszTFM/Lu7fkcGRgrUl4rViwkU7dZc8Hf2XA=;
 b=E2QS5543se/J0aZJ/yoT2omhaU7U17jYGOKRrJdles7OfMFB65x+sYC5uVPWWBM8yYMDen66LmyJzrJLadpQDBVGB7s0fKMM5phxBgkhnDLNJT0aeY++U50s9LYorurcxpfNJqmLTzlPRCfkwrfC3YbHUEAlDYdMOP3kpAhYNRMvWHQ+m+NuxOqLdpJJQchLvtHPJIg66GwlLQXXBVwfoPnC/k+6z3t3QpR063b/PwmQw3lTMRzGriZUuz7VdQkCi2lTiyH0QVTg+wxApcA+YdKzfzbD0zQUR5Nh9I1uJwLIs8/xyGAUv+MGXAtlIJTEODTk5zFV8W+c4fTHaHJy7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY9QF5iAszTFM/Lu7fkcGRgrUl4rViwkU7dZc8Hf2XA=;
 b=LHfHOG/zJ5QlBnUM5iYTyxOUQpjhkLXbqoVLrHYbRh833nm1tIxnJVMdk1sAzAyBLRntdRps9+VLE54IT0hn9osq2McaG6PWeL8ZDHrgekTt5K5InCk7wB6Fx2Ktq2ccaPUzAsOF6BP6sb1FyprUs8Hb1aU+6Z9WVPmrSyt997ajBt0I3KG0gDNjFMOkE5cjfKlRvpTSXUf2RhuhvWZ5+poU5IGESqhCMIzWTapBio/iR+euHjGGHMvwe6W6ZnpsqZwA+Pct4BcP5XK2JiyScp0uoN5Wi8BLtdG9OgE8oRPGxceZ1H2FrKID/kGtPp6gwZkBn6MSWStsx1KGghzE0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7214.eurprd04.prod.outlook.com (2603:10a6:800:1a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 07:48:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 07:48:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 4/9] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Fri, 11 Nov 2022 15:47:59 +0800
Message-Id: <b17a729eab46191d721c9fca70ef809c85f6438d.1668151131.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668151131.git.geliang.tang@suse.com>
References: <cover.1668151131.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VE1PR04MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c42173a-403f-46a3-04b1-08dac3b921cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kxCPcHgB97ZHCs+0EtUi0qOHwetXCrDkh5I46E/73IH2/jNW4vxRA9nNlIM4lgUe82CCLRmqH2lMPK2QErerjcfYHfxM7Ln8sg73InQdizkMmRzVw8OqPsTtPB1CCbGXacQczWF0eezInzahxom5x60F0xSF0m+nGchuzGv1UYbdtlp4AmHlhLhAksJLNiWHqI6A2d8EASwKyHPWXv9//8st2X7uY+mGkKAWeiiNSoKMxCwAN08Y3lLLlskRBNu+K2TsdA1cw8WvH6QjKuA85BYkp7eVwBZbLkFKxTzgRhjTJjMiJ5KW0U1Mg7SGpdX6An70oSp0J/kr83eFaQR8rfWoHMXWojdN2NTsFlKHAticoIecro2e7LFA9QnIKfD/C031oV6YmkAsIW2zsgW/xcmFSfbUv4mjVN+mcbym8hjuXDIytyswJEbdpulST7eMaFj2NjuJqd/rijHNFQ+9ozjW2bQmXF45pHhPUWTkHcJjT2ds4oJCG9mQPl7/eVypooxXh2vYeRuFLId5joVX328jIcYuYxKk8tWA7/Plv1TGYcUx20yUFgLeJDI7UxMfQyilOTt67Sj83aqvpvDjB81eT4dUh695vG7/3WCgyTBq4tz4mBfz8bYS87BeJ+qB5TzWO/jnq59W2c7/8OVO8/XocXUmZeBpmTo6EeY0FEEA9Dp6E/zYpqo4RWZnK6t6QO5SIhNU9dmHFu0tvHBdkg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199015)(44832011)(5660300002)(66946007)(8676002)(66556008)(4326008)(2906002)(8936002)(41300700001)(36756003)(107886003)(86362001)(66476007)(6512007)(26005)(6666004)(6506007)(83380400001)(186003)(316002)(6916009)(38100700002)(6486002)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H34hmt3mYC53SlKea1cks2zi857u3g4Ibo8+ZH2DEgKe9skMCwxCC0AvjHAU?=
 =?us-ascii?Q?rk63j84ZCUmfqz22ix5Ah+V4TgiVywnewFuE04zHkD44scvdIwnU1/PPtSAw?=
 =?us-ascii?Q?qo78cThEUJHXgq+HzRYiLHhh7FBh3a8KIhaxImoqrMeQAuCNadmARfZh/TGg?=
 =?us-ascii?Q?dsn8ppSnWABHykZ0OP7DkaZXh010kmo6LVEbldzeYfrem7inophPDBf/cQut?=
 =?us-ascii?Q?LsdXdzr7NJp6a+ShW9wvsdWRZ3ek7k+vXsNa3E55WiTEQKrs7wcy1fv1GGjW?=
 =?us-ascii?Q?M03zFB0/38yLY7UmS7BO+5L5WEvdjp73bP3+eakYlKLBG9zhDT3k5MS1aioz?=
 =?us-ascii?Q?MgeaJuqqUjGFI08pQjW4vGwP8xsJUZFWtc9PJKqXP677NYl19T74O7BMjPKg?=
 =?us-ascii?Q?GR61KfSW4VKNtOML7OoYDxfUemjtj6FMZPrC0mVfPUEkoL4G7Db6/56yIHmQ?=
 =?us-ascii?Q?/iBtMZvNR9iza3Sub0L69Vo3M6kdEMXidEyEAJJQQmpqMH/cmWSgKd2+phXV?=
 =?us-ascii?Q?Q/2GlKu4Skc79gsxNxMeh71ydyl1xg0wnwLLuCKM+69+RtGOz0jdwOfZTuyh?=
 =?us-ascii?Q?P5esA9NxbgX+8dlCaq+YKX8ZqOpC0Owp1PhWTYlSjLocN/aJpbugvjT9nn8T?=
 =?us-ascii?Q?ziVY57XnufqNfpRPsSneQXJe5rP2VHhuBJyAVEGh73QyoLhrx5SA6XwnXl+K?=
 =?us-ascii?Q?XZXpshhKNSf7gOfq10nQdVnbPtUESISPjN+Q0g1zDzxs2muKCjfigSbV4sqm?=
 =?us-ascii?Q?JJL01siGTWW79wL9iPn8Qh2HtUklMb/a/wLumYK1eiymwRWF1SRk6uw1Wshc?=
 =?us-ascii?Q?GyNyMMExmyCAdZ0Yo0Q68Pz9HJANZ85gTezEtMf8FHB/EdrJHh4fqMQ9gxzq?=
 =?us-ascii?Q?YVVV7Oj4bjMiCicdWd9IfwHVzk1XFUbLGluVyWKp2XAhZFYJ3wL7ersiO8mt?=
 =?us-ascii?Q?xezmyiAbg+8LjevFo1wJSSYMRRGs3itQtdDhvlKkOAYRHjWIH7sQ+cbC9cwA?=
 =?us-ascii?Q?Sp9ONgvBzIE07NOx8yDbBezJymA1VoLXSQg6umwSWnL7VoHB8E1XmjHrwFQz?=
 =?us-ascii?Q?WYToMWyaWaMHdye1SxIFe6D097n4r3TigraRrlsQKGL71dmj1wXUl2e5Cl0l?=
 =?us-ascii?Q?cHeHP8pSgBI/iBZ5rPj69oZFXAA7ZQ+Qc5QGO/lwVAkvXt9lse6W4UsOcIgK?=
 =?us-ascii?Q?qNqU+xzPm7ckel5rIwAJjNofJhmEBMhq/0omdiSEeJ6/cx2Ya5f8zBukIr7p?=
 =?us-ascii?Q?8ThWWVUnEzEVt9k5OBDiKJcNouaaX6uICfgMKJpJhIADhBKg5qYIBfcSRXz+?=
 =?us-ascii?Q?sCBG46LsxQnKVXuXQS7679792utgSzYr1B/rt8IWV6OozDseYRX1hcnbIDq6?=
 =?us-ascii?Q?G6WLXics9rRUkf6g+FVQyfakZK43f5+ZiuTf6vEt89q/YyVVXXMWqz0mE/Ms?=
 =?us-ascii?Q?fgx59pda3XP7WWA0rDyAnRsRBSTRfKFEfAfzDEdOUrdHhNDkYemdqY+CPcPg?=
 =?us-ascii?Q?Er313ykb+lPCcF6gB+VbEoVqkZ3FDf6a++MWUk7Ksu2zx2lH0Fw3eoaCcQV7?=
 =?us-ascii?Q?PdHvmLCVGRQDCLTGXqsiL0F8oW5aOt/5fBR0ovRbepQ7qDjRdltXsD3ULvyt?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c42173a-403f-46a3-04b1-08dac3b921cb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 07:48:33.0603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTlh54C1i1kjQQV9hcj3x2iTbe6/LZGF6uosJCgvyX9egI1froswrbUtzbiZbKGcx/FvYueyNnM08y/KYBfCxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7214

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

