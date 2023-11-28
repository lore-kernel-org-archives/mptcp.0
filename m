Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2076.outbound.protection.outlook.com [40.107.104.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86238584FB
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YBJ/P1qj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juixdkM2saBf94gGmChE/MT/ib/axjgi3c1fXliB4IfwyPvicSfRt/rQh8zwrxeX0L4a0PEPDpkyjHpWjml0JQBvjfRlkCpkIfpjPlTSgpfOv1MQLpOrCJGG4YU5V3gDjZefhNLIjHytb6ilLvcfAUp0lK7hBXlhbbDypAiRMeFYu0/204ddbvtiocMA3olcjvbojZRboiy63J6F/LuTzWXqj+gaZoVUaFR00fZzDdKwRv5p6LDzytBpwCEuYUxfci2EWfXl+3PktQD9qn6Ue/wmXJVwPBCnmZcw/nvIxjDYm+fU9mmNE04sGqinKH2yCXWowKyOvBghW+N4lMbgsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+W/0yUoZ1wnZFt80IkvapzV5PXq/PasaOPYw4JO1yqA=;
 b=DKn2qZ98KGurWwpdDmCSScQ5HpWSAmFDfR46S6l7vfhx/V+N2AekrVrTeEoOKCSHB/eFOzrt/XbrS4YIxFVJZ0TDQtt14Ok3/qQB1fb8kp1BwxMf/9+myTbd1WXfCs+3roEgoBDMeHng4cjT7PyG9638PSsc4rKdLerrZ6q1Mc4E3bZ6CE3r7waOjalEmG1wB9vBoJ2uceqzXjAEAcVehNji8FgIQraohb5PFZDH2laEqA3s8Guww66Kpla8zfg+/6pT8iT9vDovzSzTEKNIIzlwvAxwL/N00p7MQixH2+0czTSvRyTZ7ABv9bhmbjSFr1dGs9Qo1RnU18aFcxd4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+W/0yUoZ1wnZFt80IkvapzV5PXq/PasaOPYw4JO1yqA=;
 b=YBJ/P1qji48U0IioPHTtBwL0sq2OgnXyecU6mnIjo5dLj6GAuO4gy7TJg2BcGbOJL+EI1jH7a52hqBzSFvoNF6d7gxWxC7bkLOx6+2J9n+d32qyoPxiT7ili/hZ7CtHhuxFJjijfNYk3d4Rpr0E1M769hRx5FpL1E0r8mFqLY1hBWr2IOXQIU+swzVrlb/uQbq7BCnhVZ+f3je1zkgnHGs0hqYMCThtbgaprr1lh/K8SCbIvWYRfeVT5pE65qnC2gJ8JPBMk1WCjiO0sZu7gUvItsJ6gM+aMLSKntWzmm3S/wOiLgbKUSakU0aB4cDVcByh29InYd8jLP0iPrgTUZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7045.eurprd04.prod.outlook.com (2603:10a6:20b:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:23:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:23:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 16/32] mptcp: check addrs list in userspace_pm_get_local_id
Date: Tue, 28 Nov 2023 22:22:09 +0800
Message-Id: <079ceef62d67b91b32aa67e38f026f5ed9f21956.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e8a765f-bc94-4f2b-743c-08dbf01da184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3gbm5vnm5ZIR+LjNk/ZWkwwo519zHg2wHFmVAUOagoqFQ9on5SadTqySqpR7SkjLLpivUW3QgSk1MXjiNZXZkxtm0TptM2i8xHvzeD4vhpCPbCmkBtDf9wjJHRDK4V732SzO2p2Gk4tOX7YuqBy5qxaqlyrUOkG4rubkU//cbhlk7/4Dc/NUbuFWprmpt74QozeBUnCJ2Ug67taXWQo3Ov7uJhwREMxXaO5y/4AErLfxV4+2j0Gj75PWnbXFojJjGNSBza9aF6nYZKFKqegdcwUxcoi6LSo0Kab09VT9fvSdwG5qU6eJ3XomFbEqvDjOdiyinHD3u/a5ckMiB1dU8cQchgHbvqrtp70vGAsxKDcLFPTHfcOdv3Q3e1GLpzeqtJ/SMwC09u5K9zLpPvsKgekt2CS286Jy0qvXwY+fk2o1V58utKtQCvhbXhh2PY9lddm9smwXLDhZATle2SoTcjPyc1trz8vC1wJ8i01pTKGxJUd7jIvWH6fCOx2MomZJ4mHgr4q1RG7pt+6ynFD8AL13JeDVmwCSvC3tPLyu2TjGl4se+UB7hYgry1L+/BiM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6916009)(66476007)(316002)(66946007)(4326008)(66556008)(8936002)(8676002)(478600001)(6486002)(36756003)(44832011)(86362001)(5660300002)(2906002)(38100700002)(26005)(107886003)(2616005)(6506007)(41300700001)(6666004)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RVFDdZ1gfqEA6J0uInJ4Ok1AdZFel4EchO+nTOnUBhVLTN7/mu9uzbm4DX31?=
 =?us-ascii?Q?6QuD7nyKBEPFaLDjFvhy2bRKJ6WvPcAYNdEPZ6GbQGp4WsmD7Pn7W8GG50JI?=
 =?us-ascii?Q?7tckhe8ArZs0moND2LDqYMCDcnkv0BhNi2a1Lf/ZI6+NLbwUTrVIxzP5Jehn?=
 =?us-ascii?Q?PY57N3elg1Y5i2S/czr02ZR5xzhxBRUg++bLXdmzBH5GFz+gqor6Qejzj0FC?=
 =?us-ascii?Q?IgaKmGT8MyImuKt+nezRaYcQq4xfYNddhlRJp/lmQAdUMg98m112lGAdlI2b?=
 =?us-ascii?Q?wAUdUAttxkhpdjxJbvW/3th1jqBcrQCqZ8BXyK6DvvB1u2Yl5hxg6+VWyLXe?=
 =?us-ascii?Q?/6o6GKvXKesVqseBjsNEPxzEA0J1uGvFuie6EgZwRAGs0L3iuxZAVtLM7tBQ?=
 =?us-ascii?Q?t2VIS1vGftzHdEVSfmT12EDDkvxZ8oyOKx/4dbNOx78rdsmn53lcX45melpj?=
 =?us-ascii?Q?mp6zGqHvM/EUY+w/GARzXghMWzyPtHxPfeSIKCIteA+ZIILUnG7Bpb1uhl8s?=
 =?us-ascii?Q?cYA3ebDKM7VUBvhqsHEb8zDHASRlzDQa2fE55+RpW4MQin2AJF5s6ZQJrqKc?=
 =?us-ascii?Q?7mwDjctDGjTpQ29ixLb1UHWSa5Df1qKcnMQTwFcS4bdodq76LEn7mr1nLDki?=
 =?us-ascii?Q?IZm/aKHXVD7lLDA61rQZoYZOnjUDa5YbUxSLllhMmJ8gLhz5t1sG388ter9H?=
 =?us-ascii?Q?msXe753a2GFPJss3+MEPR9PH3ooP7MVWJjdrYyflTMNlddT77M9bsBAt5qkk?=
 =?us-ascii?Q?Jr2JWNltxEqcLBHqhumsYciBkhLFaBlQhKahWAp7MKQ6Et3Tu/wLedUxdrmX?=
 =?us-ascii?Q?7DTxe7SK4U7FZXgoan90LFOSDOMhY0q3V1Hp7EcUepkLNlj0vVZWK28/bU72?=
 =?us-ascii?Q?UAOOcSiaZQA5enRwtm+uk3bthCz//h1HAUu8LCZYqJPGJC9zsp5ToIo6wEVx?=
 =?us-ascii?Q?OKt2hKTPTO/aqTljK9ye9s6BhpM3KT7GRVj7M96AnPv+lWpSg89mrt9lBlgc?=
 =?us-ascii?Q?mgVCedGYtIjh1iMABzcGHwkgFazJ2yBOnteisSgbvb2L1I01WdS0bj3vnx4D?=
 =?us-ascii?Q?owdNnAj/1BAXTpi22UwKarTqqgzt8ryoSd8LtFXMGC5Px9qDfiPE59+2jqgC?=
 =?us-ascii?Q?iMjhQv4OAmK63UTtOInX7FNTcatHRJatetGl5F9Pw7Ai1CZjuvmebP+p1fa/?=
 =?us-ascii?Q?sIwG3zqV1K/qQiQwnDm6kFuhwaFHBr1j6bDc5slqNq76Ty3Cwr0E9AraXvYi?=
 =?us-ascii?Q?WvnrzFTarOA2dB/J5DNHKV6X68A6YJbcV3a4FzZuZFuR+6syi+3z0DPoCwqL?=
 =?us-ascii?Q?dJQe0wj40w0YLrF1F5ua5jAHqgNihsf+fFgOOMDJyoEYxVl2hZsS/dFp8u0p?=
 =?us-ascii?Q?vc6Gn2KMmM4LUt/j3VR0fW05diHeOy6lwnjWnpOOoSGVx/JOlkqch0gf9Ncw?=
 =?us-ascii?Q?kaPbRR5BfuHb2CFEbcbt3q5doPn1BdKpyaFRNTE4Qa4DTKEEaAza9qHEMFqo?=
 =?us-ascii?Q?448ebLbut9cAAftlMLqC00PNkhm71nmdcE5PxK9GsIU8xYUNKtg88LCzryFl?=
 =?us-ascii?Q?t/WHgzcTEcO2zhzR13TOlL5Kvlm+jGNO16OCaHFg?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8a765f-bc94-4f2b-743c-08dbf01da184
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:23:45.9195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pYzvccNQwJD3T/06bgPYLfuCjFkiJJSGgf+rPyGg4opJI5eDC96HEVKpCQcXv3LvAQHDMY24WKcrMaHuZJqAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7045

Before adding a new entry in mptcp_userspace_pm_get_local_id(), it's
better to check whether this address is already in userspace pm local
address list. If it's in the list, no need to add a new entry, just
return it's address ID and use this address.

Fixes: 8b20137012d9 ("mptcp: read attributes of addr entries managed by userspace PMs")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index c9dc25fa8540..489bb0e61118 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -136,10 +136,21 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 				    struct mptcp_addr_info *skc)
 {
-	struct mptcp_pm_addr_entry new_entry;
+	struct mptcp_pm_addr_entry *entry = NULL, *e, new_entry;
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
 
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&e->addr, skc, false)) {
+			entry = e;
+			break;
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+	if (entry)
+		return entry->addr.id;
+
 	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
 	new_entry.addr = *skc;
 	new_entry.addr.id = 0;
-- 
2.35.3

