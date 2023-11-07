Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADEE2595
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lcw3/jm5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsVMBtaFJnJ0PyvQoYmeOE1v+iHfRh6em6bjGageevodEgvC1m5W7R08wnMo0PuwiAh3x1ZREll4iXGtDeXE5sDnqLB7KEwvqe9kSsv+aCQLXIZFN4H9uO+U+FkX/jhgQu9cTr7YLZhVZRjtNn9aumaO8LNVBWMITAkS/K630+buPaTooFCr2vRUhCnxSDNaxeVOm/3LoUu1g/NnT37F/P7gHmIhWkhP5yyfUNhhj5veuJiU8r4TzIqISKtrrdgp6xK2wHZM8fPDMIrTEcwyeMUw/r/qlrZUCT8584FiRZEMHn/sX9es+z/idJmmOKXaItWwcSRTaLFxvLFOPOaGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVrBafMbdc/TBfOFgyIUqPEtQCGP0Cpux+OzTVtMkJc=;
 b=OpV+aS8woa3fmyc6bWMVg+qNR9dHpTKQvIixbnJc1NWgcW2XQDNRunYXEUrcbAACKhyvIvo0wi2UryzEnqoCJQjW+1Gsq62KCSEw0P9Z4gF6+siUU9VqIi3EIageGJHd7e2Xf9BPqf9Lt4Em6M/2OAW6IAs4K8DGgTJV4HUraDsQTnOUOXH1j/QHreHPrahxarlag2HsKJrBPEifCwxDNCrgsNM3RjJbqbZOK+7iYNBhBe1GWm1XPMA168S1iN304T1dqlza6bxjKUUgGTCvwPP6bhp0d5IVs327gbc6sdJZ1UUux1iJB5BlIvu6/ubB2SL5L5aaBeINNWpa/kYWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVrBafMbdc/TBfOFgyIUqPEtQCGP0Cpux+OzTVtMkJc=;
 b=Lcw3/jm5jC6N9HFAC8j8kAEnt0pttnI4o4Hrf0FftK3axi4JoAMtCmRdRKQfJVQekf+vk+r7XGCm8C/GZNtRar2jvVBmcEw1DIBtmnWSeW947HDDoJ5aaWjx0XAzEiMVQlUUhltfile6fktHidFujuBTrmi7iNXoIw+oOPCYfjRTNP54w8spLGwhiiXDHAj7/rGV90q2/Y1nbi8DB/xzNB8cRixrQcrYDydxhlJCxBQlr6L5qC2G6pxusvOntD1NgvGhEM4aJsRdh+LjkhkWU1Y+L/+n339lD5fGG6cyOu0MmiJbSPAjbtYGE09Siw/aBVd+C8EJaU1GZaAEVs+ORQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 08:16:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:16:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 16/20] mptcp: drop addr_match and id_match
Date: Tue,  7 Nov 2023 16:14:22 +0800
Message-Id: <56ff8eaccaa98f2911e2ebc2c7bb8a6fba13b4a4.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0208.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d18b62a-5e51-4ee6-ac68-08dbdf69cf6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Rc4JdAfX41vU9KoMyr+vGHTmGkYYItpnIgMQzhAwz6xxE1+t3A4D2lFZkVDirJkvQJyZJjz6QeEw6oc4pkSjinorqZPYml5mCa6pA2r4oMf6aiDthMnK6ICTzhUPVUb7SCZbgm/2qy0FLzHBmL5iZjunjGFAGcFTCv0rZrO+qStDFncKTdUg0l3zdCMEnYt8nEhe3rm5dkW7oEEKLdYLYmp52zdxWaW/GtZ59kwt1CDPL0I34+EVrJZ5pknliy5eG58SakvrkDhGn2BmF8pRBq0uGvUHAG7M/JPHUIvfBEvQG0/psLFnJPRogla6PrHciKRtC87NroNXE0sC/rbmla4I0TK1wWABhqvNmUQNS9mTRtAdGTwNF7a2NOh8LKJRqqgPAYbwMtXgt9yGgU3Bl4eM41wX6aRAiJm616Q+jRJqA0p/oTWlHTeoToHkYHKlZYkVFRz0IUpeJixek45prOgAFFZQOjaW5F+URBej1tS1TYk9m7H2hVYPwUKPu/DZ7EoLADGitGFIEgGXa6vsXDpD3pdbdyj5pyr8Qmck0ikWuS83rk+msYYXB5tKGrMH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(2906002)(83380400001)(41300700001)(38100700002)(8936002)(478600001)(4326008)(6666004)(6486002)(86362001)(44832011)(8676002)(66556008)(66946007)(6916009)(316002)(66476007)(107886003)(2616005)(5660300002)(6506007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yehd+N+pInvy+C/cXc7WFnrEIHom9zr4bXJ7MuIcqslQzhjE1Btal2ml5KJz?=
 =?us-ascii?Q?7dkpzaweFnJ0AlnvzDweBwYYRv78tqT7X0V6hq4VEvMbIEQLaVeFZDmJuxn7?=
 =?us-ascii?Q?elNXAq2xbR2M2lv/LC9Ic2Zz2i3XB+V4723edZl8Cv7ES/U6+aCuzBnivsSC?=
 =?us-ascii?Q?jZYJ+GddvdUZ1rTju1VzOfZaOtiqZf60zwg61c3sikH3U41MNV/CzjMvxAaV?=
 =?us-ascii?Q?cHAUDBTHJatq1dDFaM7ZrfQQLRMxNPSialzc7i5zv5nJCq9nl388oFh2dcVI?=
 =?us-ascii?Q?atJJXi7aoscbyIjXwuPacGhPweEgtoWUdiRFTNXXskoMiM3CYL379nZxyGLs?=
 =?us-ascii?Q?anuSKC3MB+bkwxd/BBxRqbC+sPzFUYzC39ji7Y+6No70uVgxzbqFWEuv6vT6?=
 =?us-ascii?Q?wTuJkcq8xeD3bXaZe2JpPf4aZC1z/jOj28c7N1AKvgMvJHsbJsujzu9DTfzy?=
 =?us-ascii?Q?Z8v1SZIAw6Clm/CN5WIwIOW0t9EBew3WohgEhsiqHsMoone3TuXCZKUJbGqm?=
 =?us-ascii?Q?xFCxDvjdO6yIxVsY6DTzSplNoi66/gBro1SRNnooRYJGqUMh3BQUeUL/rbHu?=
 =?us-ascii?Q?d6qMDNo9lX/YaNcTGa5dWA2mwDpFIKG2vPc4TcsS9O48IQELvUrlG3zjlWKh?=
 =?us-ascii?Q?dx+Ie5U0pl4y/3k09Mc/jdrx/t6xemRTm/tDaFDv4xUNiSfn7Vjpg/MhHYp+?=
 =?us-ascii?Q?pERhs9YJuARTu7r3KshOW//z5rW20nqH/271EnM1G7SkzXU/j7i4elIl4mhg?=
 =?us-ascii?Q?axBYIcXezFShwTMewlUo/79Ap146fIoddWksgPdzuEv8g3h3n7No9mzIlMLK?=
 =?us-ascii?Q?PocuUlL4Kum04IqUh3LZCt1hx3ioVxz4vxZEqlNIsWVBDrZ8EhYK4kQYzyfF?=
 =?us-ascii?Q?xX6sk7dhUfBY44s0JcFnedspG4i3sI1oFIO5hHdDpsvd2+ghphwcR+vZZsfc?=
 =?us-ascii?Q?s6MexkORcSfGL1UmuaHg9dD0sh1J1ISeVXNgY+H50ZiRlyi25zP4cNsCsmkU?=
 =?us-ascii?Q?zaGJkBMLiGTnQPmRktVJSwEJ7ypecp/LCxPhv75g/WAqGVwpGg9axJrMlb0q?=
 =?us-ascii?Q?lwBh8P9Q2xj4DwzeQ1F90BhevPDwKemjtIz9VJ5XKTuAKpAEsHhFdqbdmbbm?=
 =?us-ascii?Q?KCUgkvbn9AwxDbtza6wZbGUSG0zMJn+/RsjgAzjgYY7qq/zIv3stKm68pKdA?=
 =?us-ascii?Q?LEyJtDyR1rVft/p0Jq3GP8+7PNjuwc2HRcdRZFXZcAEvt4SP+1wBSer9MlkE?=
 =?us-ascii?Q?/aBpYaGI9ZVmrSbhIGUyET+NFOKLOah/tc8uN4ffvAguR/kD78VAlFckATHo?=
 =?us-ascii?Q?4zSedAeSBXakdiMgNvhV9QJ9EdZIaZKzPLkIQ+wzVcwIRv3jczUPaGAiy4hp?=
 =?us-ascii?Q?vSSszDZRcnK7IfCyPrhZVud+yeM67QvjzQW6f+z8sQHF8nRTYQTJrKzheioR?=
 =?us-ascii?Q?dpRiLullIoSXY/Agtl9cRHjU1AbgrE9UTivMf4AsyxzUWE733doXj1ItiirB?=
 =?us-ascii?Q?iVgRAzn6TqAPcJQqvdCYqntK/dv6yCxU92pg6SCHFMuQAJCLctdkPyvQF3iG?=
 =?us-ascii?Q?Ncl2q0eTsh2FF40jupUfLevCO856XY9hEcf/w6H+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d18b62a-5e51-4ee6-ac68-08dbdf69cf6e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:16:14.8878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XpUfAAjb67iXy1ncgxBOBhnJvto6fac30Hm6h0t0IeI392GWoGIv6SqDdbcc6KRoKaqyo4Ank96jUClMVEe1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663

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

