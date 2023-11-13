Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2042.outbound.protection.outlook.com [40.107.14.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A09E8483
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="i1l0yD6E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZVaPmKSCQ2+yr0C7c3wp4XIqXPIsgoE5TdqDmvO6RGtGWYIahJ0EOHLKglLpaBW1XbeuWhmB6jBC0wda/kPi9XqQsA/GR5yEPdDMYCjFCgWfQXhXaMNhMes82k7U9sdZhu2MDwy+awMwH7NkESVLCJKNbURZBXYDd01nG03ecj4ldz1OzC08ObJCEm6rYBmxgJIlJboWcpXqFbHxfLbF8aPVkYdscSMwo2cl+CpLGzNf5w4semIvcgqZQwJIqiPqikVZTT0V9a4m7hXH3nEZdWIExQUJsyjX8WLsaakRt0o9BT3HzII72hVBdwUx1HJYemNgMBHH7AOokAgYjURyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cF+z6uN5edzwJWV7abOzpoi0PldDrgYlJA7x5/etgv8=;
 b=QtUajWtvCW1HSWRLstPp9OLWpZZrpcTyN7dlpBIM9rNV4MRInJmcOV7+DTIJC3IkpQF9Yuvfc1xb2iNmXIcvgMS97j5+aS0UC7qstT69BEhriLsvAkh3Pm+3+fSCESoJjfgQNnh7CCEU1CHcUlSCJGPGJwz++eV/MZDY7MxqRJublsS/tSCOroJ3tKHrDf/mQAb+W7TFH1z53qLsH0hN5GXNXNR5pwkx8Eh4VewVm0UvzGLlRsGNN6voYTAy+GLmZjdKRKw0Dvvb84daovRsLa6JDepG6q3I1xKcSEN7zUnbygNNrw5aMj+NPU7kph+WsfaPP4eWLCE0IBgo3oh3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF+z6uN5edzwJWV7abOzpoi0PldDrgYlJA7x5/etgv8=;
 b=i1l0yD6EOcZJbS6nilnrIOyofyvBvV7fJIXnKLONbjQL8hHWoaoSs5b847Jmzly0tXndfx0vfRx3WqM3h76YgdllChGZkw8wsKcJVnQtz0N94QefvqoW8+9X+4lSy029E68LV+eG/KlZXmrjEnH3VcDTKqHWtBwpSghLMgeiutT5EpsB/dmEpkhs7ElFXML2pF21A97pSGRghEMekFHCL9s5mykdNy/o5HKlWCO7X8ANIiNbPt+ZhozIp0zIa0LyO/FEDqQAB/Spnh+nROMDq6aCD9yffVv/Iy1jqqvQkzVsQxPKtKPHAnZWXTayW4WR5HqIWLBHSFQCfu4Orny/ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8895.eurprd04.prod.outlook.com (2603:10a6:102:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Mon, 13 Nov
 2023 02:50:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:50:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 19/22] mptcp: drop addr_match and id_match
Date: Mon, 13 Nov 2023 10:49:03 +0800
Message-Id: <1462d4acc967850a2b553c34786ef89f45361b7f.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af87504-5f9e-4bfa-6699-08dbe3f35583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dWumjQRijxZaPZH6nHxMtPp2gpAHbH7mctvnWWm8KZkinh2GGkBTdkyMFEUYAxJBiolgC9aXUFL8lXnOc7FNDcuBDxNfbZQZKLMo8liA2jbwL4F6HPFsM+qAnHQpKZSEf3kJu20mO1WtTHqgANPbkCncKbbATnVfFO0zgT8Io/l0q3UuB2eXlcn0TSRNCtsxTMaFzUTTQPy7a9HmqlrkozDGi3BwAh+rSq3cUtRJ7eO9e46ywnlv7BOLH30xJkSHiD2tTJtWUeLgtE70IRav4Cz3Mk7uKIGT/pN25NNOZCYBk3n39c74H79+f6Seg6zyCHK4+n3G6MDNCcWyA5YcfGtpHGDhb80l6gJeWP1BnfKf0Tp7DpR0iUAqkJCKIVcQU2tzcLxdpShHWJjECYWsV1K5rp+GQO9HHWqmyFKGkYdHvus7esfVx3/53BS7Dx1WEpMqUsZPLvYLv3ANHOopf7OIPHDDvA3dMsN7m5T8Ids1LCFiLfs0yktm3cf1LabDSxou4B7nurDnpJctBHQcqEMdz5X3fk7FcIkwfQjBDGxMiDVlws2jkOoTPlGxVCP2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(4326008)(8936002)(8676002)(44832011)(38100700002)(66946007)(6506007)(6666004)(66556008)(66476007)(478600001)(6486002)(26005)(83380400001)(6512007)(6916009)(316002)(107886003)(2616005)(36756003)(41300700001)(5660300002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E+AxKvLdEmL4Ses7TaxzgXoOMGWmPvovCKYNRuLmBVB5K3l2VnXryHq7+0dg?=
 =?us-ascii?Q?ksbSqPtXgYXfcH1uRQEXS/JtOE7mpHF9MGNjjR8cYTWdW9S3N2Dzp3ysIlKR?=
 =?us-ascii?Q?dA8tGJduO4IgfTZLepRb2Xk3MN3bgURzhbuaR2DfTIYBWfU5yC/KQNQ8nUiA?=
 =?us-ascii?Q?H//pIpnYMj8TOEP8wDHw2pPFyfpLfXbVrpIIxkKfLoDcHCmCXdPr3yMVz0Le?=
 =?us-ascii?Q?DtyYfXpAMeJrokHX6B3xSpSp4i/OwNXKIbRga7uFwceizB0AbLz/DY2cOvTj?=
 =?us-ascii?Q?MvgETVy9ZRocD0W2Xzh8uo77yCYOczmgXlyKzTK/JxMFsqW4zyw81pmYWp7G?=
 =?us-ascii?Q?L1B3XOQhpF2G/Uu1LdfQuRzwCdznTzDa/YGw8UONHMA0BiCVEWG2u6fjg6YU?=
 =?us-ascii?Q?HGvTzOldrCvshqs6OCmp37o8NSSoFDaZEphtPyqnyWmfVkAqSRgI88lZIvRL?=
 =?us-ascii?Q?Xcrg5k9a6l/GBmx7sagSfymB9WPLuq4c/IQlEA2iPl1zjoTXcOMeG5qjX7oW?=
 =?us-ascii?Q?2hC7UERM+YCtBhGEoaDHkQFiZG8nHVkqUCT4TB0bsOy7P0kcDQ34VSXYCk0I?=
 =?us-ascii?Q?bJ00tTxIwqTx7r0PCdZQdrN7oYRTzH8w8+xvdf4EoRHdgz7PrcSmPvsC1dnu?=
 =?us-ascii?Q?MgmP/9hb9WJX7cOAKeFxZ2VTR24pVPUyOQVG2+RoPe2DG4PdgQaaQKBbOuUK?=
 =?us-ascii?Q?lAT4EXhnhsAn/RxMlpQWYb695E6PxGiAcs4J4lHzr4GcfAZUBe9hmSKZ6/tS?=
 =?us-ascii?Q?TQRKDkX7ebetWp4pZdII6DZC5fxTx7GvGd3+XYNhW0qmlIlqpvtUUYIvDDK+?=
 =?us-ascii?Q?TUBV6NmvSL3Dyl5C5jbgKcHhG7xkqJSRCmpzO96dExMNttupJBhNsbDgc/N8?=
 =?us-ascii?Q?QlxFi3pRLRN5hZwMUzMua1xVVR1WT5V7TLEO/at8V7sfctugMdzB5qt9XakE?=
 =?us-ascii?Q?1FRqdE7GlZulN/zSLx7SaA8U/rn8UcBeBDoR9YMvHYK9u0ZwJ+j2IPKswm5Y?=
 =?us-ascii?Q?HNr7hkwjaa0irFqOeclsNo8ksDGdZSKYruD1kQxtjGCfuZlUa40bpFbpZK+e?=
 =?us-ascii?Q?htDOlbPS61W1uo24KiKNsMHcVGn5ijkbdMRYlSVJCj/u3ndl0M7x8IedFFhy?=
 =?us-ascii?Q?PLNHLY/QIwRvpRHJEdVTQuY1C38hfewjMdr/6uLhp3qC9PrsbKAfh/MR/lXH?=
 =?us-ascii?Q?nrujA+XptQoNrKulixAPGzm7JBz13cIwY0bQOnAny2fl0Jq9LMRKx7ksoucN?=
 =?us-ascii?Q?BSLECz5TMPTPk95U6OWaIL3qs4efIlP80zjKLonQWErRNpgCrGSune6yfyKW?=
 =?us-ascii?Q?GVveczD9V5En6BrRGWFpwHy88KAqL48KZdcHSWj5BdtDEq+o32cFUCt0jS7v?=
 =?us-ascii?Q?bgJgcI6cR3jtFICCmLLbHnuhgUPsI00AjjPXV9kKepr1/ntt2QfvmlN36wQI?=
 =?us-ascii?Q?SgU8yMCtAvf6pHyE3LGTe+LfN5uTtMCAhNF7PbLLAKyX4QL0N+IEji3F+QCb?=
 =?us-ascii?Q?vktB11OwF2apDofTto91OLLC/irSn7y6hJzxpEiHsjaZO7XZS+pKlvZHp9FZ?=
 =?us-ascii?Q?3wiup7CO+0YFK2BPq8wWevMdF+B3qbzBUYsyG+fM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af87504-5f9e-4bfa-6699-08dbe3f35583
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:50:45.5520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOe5qpSX7toat7G4nz6xKtRbUEs2TItvPrZEGpwY5xfQOOCQvA2NF7953eyYDx5EWdseXYgIVhMW+p9SO9UPjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8895

This patch uses the newly defined helper mptcp_userspace_pm_get_entry()
in mptcp_userspace_pm_append_new_local_addr(), and drop local variables
addr_match and id_match to simplify the code.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 71c47fca375c..994f2bfd74be 100644
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

