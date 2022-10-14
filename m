Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC620F8
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 13:34:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPmIbCVBeuQA4dWIFip3A5hmTU31G6IPFwm6Tt8mbGNS3Vwqg5Sf5z+LATRhpcZtKS4dmC/eUODP/cV6tlSJ/pzZXwfzRhKaR23r6n2LHw2iC8ZCKVZr5w02hbpGyW4uvxsh9+tTJZYDJ5LKsuI7aykClqepkZ1QTqA22w4ErRfONx5gvC7FG1fhAli21jL7Kzj/Ld4A2se158gS2cMw71BWypmoDQHPwXtJzQfNYgW6GwOgKEFCJ+6eMly2GIAPyI/lzPi5+MYMJEanuBSWmTD2t/LkXk0GYrOsl0tokFYSsd5mr4QCeiFrGQRG6/axkhqV0uBgIkd4AIXpLCDbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30U1osd3bNjh6lpo4MPEY/Z2QOyeQNh0RWxy1ieaTQc=;
 b=CMArDYThhvqHBvf55EOycDr9m9Iz0WpR4TbbfjAk1XhwA+cQ2PnBg3jKm6vkiCKCfTisw8UzP0D0tqOYAscHraVQs52rKv7Tbah5Q+vO66VaEe9KTSL3OICemVloBpHRJ2JJKaEQqjOzmrxRwHiuyGQduKr/T1bVWJt/a9IDbDylh9olvgf8oSkOd/Hdj6NIwaBeEsTP3rGDlHZdu/eLIjWIHBDu+DxV9K+V6wuQblNtywiHPusmQlOoj6Fgltk4JMh/rWp4ayMm6UERhU8ok2jwaHWEiCAHqBAlPeU0JXAJ/1/Xbc4y2ZxqZRuJI/Dlxx7SZiCVvZeyew/VIkwtrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30U1osd3bNjh6lpo4MPEY/Z2QOyeQNh0RWxy1ieaTQc=;
 b=Tj9TJWV2p96Zxp0VvCGdOxg03CGQ0H/+CUHycUrAKXSJiwwcK535GC4UA34KEKbyIAJPA09cLsLsi02U4I8zq7ESx9fi3g/E/CUzGO9Fo2VCyDZJS9vKX+lpBd7HV10z4UMnDFzhNfy4UPEe3jXFjNdu/PuWyaHL8zXxX2qVnnNIstn8A/zfw6QtdOiHXiUb5TyLcmpX38Mc48giKStpIndBWxLYenw8t1eIKc0K51g57cfuXK7svQcIm217ZYvIwVZiwESyEwpsBPr9kYo9qralpOwOBqhC5msHk7TTR8AstNmKSGqsoCdSESI5Cwusamh1fbbYnlssinAZ4gDKAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 13:34:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 13:34:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 11/15] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Fri, 14 Oct 2022 21:32:18 +0800
Message-Id: <779ac12751ec7370eac345d1e1b954dfddef9763.1665753926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665753926.git.geliang.tang@suse.com>
References: <cover.1665753926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0042.apcprd06.prod.outlook.com
 (2603:1096:404:2e::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab14a87-b613-410a-0ff3-08daade8d2f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ri5+uS2n8AKTm5SqKZmTxcDXV71JmJgII+XQ1OWoB2qwv3Hrz4CWeZfCTr9EGfrb5JGcJGP3NpLLawVTlIvtv3bZyBPBKCCLIiR8ir0rCHA3WsLt4gsEVagMoq2QkleJGF98BdEQin1qwByWoKqONEodlu5fQydgDy5uMp4pkui7Lg6QEfEr7s2bQaUcgdvMm3yA0mlk2f2/fOORzbfWvahEX8OfYF/QzynbVslUmpsQR8JzwMA0fp+KRaRSRBMiNLYUFGilvjSOwpjprGQ+RoO4TrQhYXM/dv6KcczHXt1qMSANTKgmaS8oagHIWyR+WHsW1m/VxQHRzqm2dCusixtBzQSTYjnP8kYC8UMYq6onjOXbSpV+mzQF6+HYWfm8lNpxVKsvO/tyh0mFF+9rawHS4CZWzxrquiGcSKWoSyWM77SKwrzkZldlNL6CqFr6kkGdwSB5kCt8mHwAYbIrtd4r/QLPOb0nAT0n64VpnK3fuHYntyeGxvOd6F+aP+aswEBAYnAoy2M4kDVMYIq20nzTDEfGiQRnaPpLzVfASQPyJBgdHTXRi63xoXDvPqDxVfLTLlg7JakxLDyGpLoNuMsSywbY5UL+JbLL9+dazWQ5IanJ2EdF8gqqal0ZtKxyRu1gBj5dE090/+VQdEE2pRcM+G4UfAH5/pwQafvb2ccQq2tBuZ54lsVeIo/H7FHHMcsK0Edaz06C/WAhUqeRNoO+43ZwhDlRtXEQntTi/FHcljcsf5AU2+ynRmtdARSs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(6486002)(36756003)(2906002)(83380400001)(6916009)(316002)(6666004)(38100700002)(41300700001)(6506007)(186003)(8936002)(107886003)(26005)(5660300002)(2616005)(478600001)(44832011)(6512007)(66476007)(66556008)(66946007)(8676002)(86362001)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QECjt7xFJr0d5kY3eiWtEpgaQXoZ9svIyZAqw0Vvq9QA3FGvR+5IQ59zjjKG?=
 =?us-ascii?Q?80AGfMPnXAMEiI92CImJ05/lR14mUMFBzSIcv1mr+Yr1GcUNo7MiixBRJMyT?=
 =?us-ascii?Q?BoCToO1IMXl/J71zgC2tRA40Ubl7z5nyzQk36+Y/HeyQNU3g+MEhx/EYjTHI?=
 =?us-ascii?Q?/MUG+9RWYWLE2P8JKIb38wnkj/cT1XJYOCIQ6oeXyVG6ioegGZucLZlKkDgC?=
 =?us-ascii?Q?Qj6ITqRA3564bSF1sl0N6OJHU6tWNMoLPowsxumJKiuZEfs9FZFT4z0pT41K?=
 =?us-ascii?Q?1kR2Vidml9QPcvZEqGf0J35RfIaJ+3iv/Hxr9EAFW6rNCkKiaUtAA4CC4xrm?=
 =?us-ascii?Q?Ah5conRAebeRKOxfOXOx890dfN6mr1P50mUM2eRAGzEXB0brG9o9HBjXjGCF?=
 =?us-ascii?Q?veIYUbKEjMMZkib7PbM8tObNFXhXuPG7ADCgo7zzooYmDauG4acG6m7NbUsj?=
 =?us-ascii?Q?qBK4HvmSJrmD0A3ToBLTQI8gqOxgIKJqEPZoQ2NaodqwW43i3EMFVzyzE4qZ?=
 =?us-ascii?Q?qjEQhsMUnrcuf1WPvfTdkS0Z6iZlP23biUAt+CFXaJLceaeHohKu7fPs2i3l?=
 =?us-ascii?Q?ZQQ3+MY6V/qKAuhl91w5FHxbMNZWsQ9+vVPozEQX5RLZIntEQWWxoVQS8SDA?=
 =?us-ascii?Q?Al5D2ODTeypMboxgrZ65QctbUreYaDOXR9OOEbCSftjFWsyfkXarSaXBAlbW?=
 =?us-ascii?Q?EWh+3uoxn5xu7XJ9RaNvojowqn+N85eXH3eOINw7fCoYR9MoQ9RqUG1ZbTpD?=
 =?us-ascii?Q?krdd0ORBRo/qDtJkqP7ksNNWYOU58FKu/otobY06GnVfNIrbv68vvrsTWzJn?=
 =?us-ascii?Q?jRnIqpoPtEQyzVfI3lo0FDxWHnks5+/ZkPaAxhHqrsBVNNt4Pq+uXKozQ54s?=
 =?us-ascii?Q?nS0qwKlL67XtUpoKtgSs2H9UP7PJ5ZHWOSEpZNuu13ZIpcJUuuTMfkTXv35t?=
 =?us-ascii?Q?oe5ZMXcFN7o9HEJ4klChnfvNucUxO7UetDV/87xX2BxwUSz+po9i6/h/rcBy?=
 =?us-ascii?Q?ngJjnWaeu0Ufdwk4tMYGz+z4t4xcRXN/pBN18yYV54z9ZdzzpCto+vp/XT+6?=
 =?us-ascii?Q?zkJW+tp0PmXHYb63RUqtn8sF7nWD48AONl15OM84JkoZJ8UP5VNzSdHenCy0?=
 =?us-ascii?Q?0c0N1rc9doTBVOpZCkyjII+YSRBvhRu71P7sXtGaHde44q/PwRDqNGAMiIQE?=
 =?us-ascii?Q?Yq70qfVm7U1desGRJOGnHiQ8H73Tjvpm8tfdwJhoDbYIpC5iS97VsQ+PWmkw?=
 =?us-ascii?Q?BVKKgYh4+sVQcw5YeWxFWnKbl073cprN9b5C83VYcOS9cFlvjjSqRYd1SdMi?=
 =?us-ascii?Q?lr7dyYa6EgzSNqCUAsnE4QwWhW81NPFPlsSP+2qDQSbh+s4+BkqWiy0RqUCB?=
 =?us-ascii?Q?OmfVqfTr5L+oj6rLl41wpwT9V2Y6/Lx9iz1NnRMRXpObJtwNm/EAIkOFiWzE?=
 =?us-ascii?Q?xdCELnhxalALbFCCAx03D3j+lUQbIoBf2ChPqlKv1HS3Nk+vPIQeEE6QjPE0?=
 =?us-ascii?Q?1LcPL4Nl0M2JupLRUIacVSRUie7GDlQ++zMmcjHXVph6Gm1IJiNzCGaT2ZUN?=
 =?us-ascii?Q?XDZWX/tJqE8pWqHWJPsIolVcLpf19OuZguj5s5DxX7zqsQKe5C/ywPqtugf+?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab14a87-b613-410a-0ff3-08daade8d2f3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 13:34:31.1227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGCjD5J5e/YXMvyX0GwzHsJAGe43o43pCBXkh6RO9SIBu8KvJJo+cKQlLdlhqY41PihQDg+FeD9NXPQdaC721w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index c7d4a9a69cfc..701cc31359d3 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -240,6 +240,7 @@ struct mptcp_subflow_context {
 
 struct mptcp_sched_data {
 	bool	reinject;
+	int	snd_burst;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 } __attribute__((preserve_access_index));
 
@@ -249,8 +250,10 @@ struct mptcp_sched_ops {
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
 
@@ -265,5 +268,7 @@ struct mptcp_sock {
 
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
+extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
+					  struct mptcp_sched_data *data) __ksym;
 
 #endif
-- 
2.35.3

