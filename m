Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2053.outbound.protection.outlook.com [40.107.6.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16381FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="uMqYx3uA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z36ZdnX4P2oYwIRcoLUy0AoMjbvDozi1+y4pylrImoizJ6xmQiG74IPHSPKupLrZo/ktMaFeSKYoMvBPPjNRIy+hDHrj8tkvw50Io08xmcIqq+f+dxH61C2yLf0Z3L9OjN4nnyJ+iNzXGsnuZi56TnNC1bkOR/Emgqb/qZ/Zi6igz01lLfW7+onLMNQLZtELO263CmaEOVwXQJjnkrnw343gZIXpjOCXzCahH6qyVHQQuTsE1WCodBI1rSEqmxhtQcrORA07d03ODNFrMR9D4wZmxtHpdeWxRujomzBdajvnnn3pBBe6uVr4G6hNuPAqE7LMrKf5szmwJXkkJbuFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVrBafMbdc/TBfOFgyIUqPEtQCGP0Cpux+OzTVtMkJc=;
 b=NP4KFVJao451r+v53Bes7+c8f5jiOCOmusimdTPxfsI2UWD59A1bhH0LdIyTTrjukX/t3i1x+f2Vko+G8kdT7wSwnCo7jstZUY3Eio+dSUBKIqJsH+EXCCIkJzWegkCtorW9u7PAfMiU1WaqfO52adYyKzQ0djLHMj+J8labxK6qsHZ1Vl2/AG1Xm+amIOm6QwaETcwL3x8tAPV/N5yeED388BRIhy8arXeoqxCo4gc4n1aVQvcWX0CpI4Q3rzrdNhEyaQv1pjtW6nylOk9h8esQlmhQ9tSU42axAo+KEVZCwQoxds3DEkjAnLyb0JM/rBl1YfMUT9BJL2aFTIwFOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVrBafMbdc/TBfOFgyIUqPEtQCGP0Cpux+OzTVtMkJc=;
 b=uMqYx3uA5RXU6jwQxS28QLPYDoW4RK9J5bbRH4Tmu/RMWMjIT0cdwaXhjZf0A5ryDJBIdK0KOBP7Sa/2xaln/SY3FX0lObNMlaXN5KiL2JK0nwRMVuORgKdAC0JCwblfOnaWcsXHJLEupok0rBhlCU+p7mJc3CwGA9oeoBAEK5KNaG77Qcq3PJAfVZWNKiZdrtfpez3Y2K/IKh0+rvEVPuB6fKwXw49KItzJvytOapxsT5h/TbM6vkZJrqp6MUYtxtQ5xXTXtd/+9VV1FmfAUWqNkrBC/xpikmYen6pI9NalKXOnzMLNf84R9yWx1T4e+t6vYP/+EmIZKB+g0HDLdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9304.eurprd04.prod.outlook.com (2603:10a6:102:2b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 7 Nov
 2023 06:03:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:03:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 16/21] mptcp: drop addr_match and id_match
Date: Tue,  7 Nov 2023 14:02:00 +0800
Message-Id: <8223555381fe7fff0b6ae3b6410491fce96eede3.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:404:15::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a37451-2dfd-461c-2b10-08dbdf5750c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wtmJZVggGIwWv37uKGHXj96e41fxClVLWth+U5gh4Pcky8vcVcSHcnuKunFpYwQR3s+optO1WzKgMoq2C8wHSyIzTA/E/wF60mYqTkwOFR4/fY3PAAFKk6JYcj+4L2GKSTfyXE3GFIzWUN1Sgbgqyv2vfs3FwtN7nnlQJpOmlKbfCldPsI3eLXjZPg8vdC1SQ/ARww7AQleVx87svS0TaSLpxkyONTb9e6dCBr2qc3VPMUJcgtxpERddl3RCi5GT/jrdCbvSysduK5hAbmnv54q/Z25BFHzFPsxMZOBrGZrB4XQIwYVO77nNrJ2BFJC4lGHOxrbrbRw1dRqCNNd69rQBUEO7LDA5vR6hyskQtrgowe8WfzTiZFHIR5eTIgvycjQ90m/fIRsbfnGFqcz3rzlRh/z/59oEPKxcHf84FDgJFOZqRs5gGThQrPleHqym7QUaO9d7MK6EmbafvMbA/9QvTcb8fCf94e8hMLN8FbyxYDFF+zvI0asvCgkhNitRQ7d22Fd3xOnI5SEFJjbfH9x12N8/lCXPy0kOHA2Fo8gO5+nJTQbHhlmIesNBkXlL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6506007)(44832011)(41300700001)(86362001)(2906002)(5660300002)(8676002)(4326008)(8936002)(36756003)(6916009)(6512007)(26005)(107886003)(2616005)(83380400001)(6666004)(38100700002)(66476007)(316002)(66556008)(478600001)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tHaTMWT6aLIlgFcYxZgmYRK2llaZf39+KZi/VzCeqx4tJGWadPdiHCuFoa+m?=
 =?us-ascii?Q?1749dxwxpP792/mzFj6qc/krw5pV6stIiqWbgNkmugKY+KhZl55ebwAIXoI8?=
 =?us-ascii?Q?f4/uPJ/vu0Mq+CCH5DhYQuZ0D9Hjd82UTJIqd/HB/wsOuOEyDqUtMmCHBhNk?=
 =?us-ascii?Q?mW4Ni1q3ace0xGAmabEgJkKzP/p7O8iM94d39lWzVz2iK2ci3CawoZKyBAUc?=
 =?us-ascii?Q?uqgkpcokHSzEzm7o7fYnJb2t7vkLmVZV8sT1kmytI/+++xbXfqZZwT/zCCxv?=
 =?us-ascii?Q?asMfhndNi6/A84Ed+sIFThf8Sc5H22kkDoewx2tAIOZJGC9T14IJtjd0aehb?=
 =?us-ascii?Q?EUUSYEhldA9qOmNWydXb7TF8KJUBRnOx8DUQ/sLzUQjVFvJtrwozJntP60FD?=
 =?us-ascii?Q?vg8kf8fwqKAyvv89/2GufCWtJh9UjrUR3am8caoMiJYSPEzNrVmOG+KlWNcP?=
 =?us-ascii?Q?TYsX/K/SgsVG3+DXrcCPVxl5OHUjaarEYPeCwHJlRQQ2uH6/+OzsTtpzylJ2?=
 =?us-ascii?Q?5Vquks3KE5cdNcyXlBptAaWxYts3s5jMqjgn9jVoPYGtbiAZ1OEqGFpVlVBR?=
 =?us-ascii?Q?AsIuwwCKnOBDQF6sk27FH/khFnJ6CbZUOWCzFpYtaqbbaiCxVyqp/aatCzoO?=
 =?us-ascii?Q?W+buTeFEZKt6ymvFncdpy46gnsKJny3gjH5k0tHv0u22dWUEFyiwZ8xO+ref?=
 =?us-ascii?Q?zog2VwZs7ufEH6JZTYYa7HySMPwsaqlFAHkCoXjZFf3SyPM3mYSj7niASJoB?=
 =?us-ascii?Q?WvZdmrJA1bOUW6gN6jS1fItOIqZC9xWHT33nYWBpIKSXwmydYVsByMMWde1/?=
 =?us-ascii?Q?/Pmx97bub4lI9QxWyeS2+jRSTngrSgW2jN5i7JY26SdOgPs0lfHMvjKVcQFE?=
 =?us-ascii?Q?KXhWQsbYsMkJxOKVr3oq+fUgGTKWM6vH7l3FIiSqhBBlLUuXTQDVITNrCICM?=
 =?us-ascii?Q?LEfrnmkKapYyXyTdbNmws50nZQGfBKrXjpK/gZ1zn3NxMjLXHuNDmlwpnwAZ?=
 =?us-ascii?Q?UZFBd8X5pfYdKXrM4gTRAAPLDtUtkJZo2GR485hzaPj2pUyEdtmLEJyenjVh?=
 =?us-ascii?Q?9F2xlraGPZ/Rs+tHreQ95B+RXVRfM6GeOvKjN6BY95Y4lzvll/Q8eVwpQY4Y?=
 =?us-ascii?Q?+29OPu4mBf2IjKtZ+U4jZZ+D4cl4q+9V/domkNSaH7dOJk6eLrye09PBd2z2?=
 =?us-ascii?Q?1C6sZGITyXxSlXWKMjf0t8/pMbe0PMRHcherr6pYeMPXntPUs2xdF3vFcqz/?=
 =?us-ascii?Q?ip6sEY+OUpsYs4G2yx2Kvzt3tzwvYTjjlcIe896q2b0KiX95eOD5UFnAZLY2?=
 =?us-ascii?Q?CTWnxQrBLpah4czU8wethr6bs0v24L0PUYKMLhaJ0/T5laX/UhJGkhvuNdm4?=
 =?us-ascii?Q?gWupk7/+JyLA8+voMcNT+lrXaKaVoznYkSCjhh0ahW25WyOWeiqJR7fK7qZJ?=
 =?us-ascii?Q?zLIaO/SyaVPViPdHEbzNoxs+x+bJdc+q9ioM4y6Z2Bt9Yu6tVHTqN1Bk8wpS?=
 =?us-ascii?Q?6Cc8UIkdD1JlDvQ2jchJJ0ieqOWc8cd5ulhzHrUiP77e75ivINsrAqvudhsF?=
 =?us-ascii?Q?jFhhq2fcpeimLvTLBhR8JviXccxO4kH/YLMjuaji?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a37451-2dfd-461c-2b10-08dbdf5750c5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:03:51.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHblHc2/B8G+T3YOT/3g4sdmHszpbqPK9LL9ljtbgUFVE/7qKkrBG04XCKVrAGGJ9SfPjfZxhjq06iICbYSBeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9304

This patch uses the newly defined helper mptcp_userspace_pm_get_entry()
in mptcp_userspace_pm_append_new_local_addr(), and drop local variables
addr_match and id_match to simplify the code.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 465f2c208ac1..5d8130581654 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -59,26 +59,13 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *e;
-	bool addr_match = false;
-	bool id_match = false;
 	int ret = -EINVAL;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true, false);
-		if (addr_match && entry->addr.id == 0)
-			entry->addr.id = e->addr.id;
-		id_match = (e->addr.id == entry->addr.id);
-		if (addr_match && id_match) {
-			match = e;
-			break;
-		} else if (addr_match || id_match) {
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_get_entry(msk, &entry->addr, true, entry->addr.id);
+	if (!match) {
+		struct mptcp_pm_addr_entry *e;
 
-	if (!match && !addr_match && !id_match) {
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
@@ -97,10 +84,13 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-	} else if (match) {
-		ret = entry->addr.id;
+		goto append_err;
 	}
 
+	if (entry->addr.id == 0)
+		entry->addr.id = match->addr.id;
+	ret = entry->addr.id;
+
 append_err:
 	spin_unlock_bh(&msk->pm.lock);
 	return ret;
-- 
2.35.3

