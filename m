Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD100CA72
	for <mptcp@lists.linux.dev>; Tue, 15 Aug 2023 06:30:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D30bl7cHXpnm4sSN+SCPwXmb2TWfqWCk0v2pusNdfXlc8IwOs/4h2Mxil7+sVUjxfZunGLnDwmJDTdLntemu58nL9+Jt1EwYzEIT3i2k9OnPvCmOJmMXG8fd26tWGj05QjFDiD5QDwC4OoOUcrXjKSPxHGkHIxqPDb0ak8VLXy/Ziv7jdhEoc2udvA19/8FCeGQl4oHDafybaiIggPDXpJkm/wsI8piI5ss0ftqHZCXzlxvrckKWf/j3mO2lDUVVfaId+Pl+BEFiteEetM3CBnf2oFpiRrj+ytbtzvtIQBQbSvxWZyy19sRQAvNPRij1MGj3DvePxsXBDJHMMqFgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtEHpILRXNCUBDtuGrtvHBU3KV8D0jwdYNLqf+W7aog=;
 b=ZcZ9rPY7vZ1txoiibQtz8VfBtVD2CylmbAtGaPU+COQoUXfej5lbzWFHmP/Fxn11zV1xOz9t+0thT1j1TQZcKBoII7kpER6OuSpXoOU9SSXpC4OhMW9WjA0jiCpqjREJADKvOiBKZE8DA4whrTabaMFJjC5Zltz+zcvr23ojyotoupmAoZMLTiOok5/n2h/emY4zt3yipssU/QbFMfdGAmzmAE70RB7eBxn++rNzHqXZ++sor2z3di2u/AFpprSYrLYd21vCNGepjO9Kbu0zYrFzz3rg3pBFpV540+XmanveQib3zwDvcAeqPLsf3vgl94IqrG2cDSX17GRiwVtBmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtEHpILRXNCUBDtuGrtvHBU3KV8D0jwdYNLqf+W7aog=;
 b=JIZhDu5T/KtKzE0XqOuzZ0N2GDKwDzyQZ7wBZ767rSWEpV3ITpivi3aV0tVtwFAy3yBX3/HzYSdmN+97X2+s9AWVymjlyEL/DjUm1acvZFZF9pxeaJ6qcPs9+uCdI8XKw9l/beb+TYRKBlwXhcyy7iaB5iDm+xzgp1uRZ8/GgXwWzTanKgdyQEdFImkSUUSrjI94Pui5HaAPjfLtnHW82B0DyV2swz/HGyCS1s5LVFizO/X1ubmj+M0a7jC6oKAwfEFYJluPMbxBaAyyd1Ic3Bi5iU+7ZjJ2YkcH3jmLHLvXLFJs1rqDuIAEDut04utdxIVMDKNduxCd7Fsqv1yzig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7239.eurprd04.prod.outlook.com (2603:10a6:10:1a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 06:30:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 06:30:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 4/9] Squash to "selftests/bpf: Add mptcp sched structs"
Date: Tue, 15 Aug 2023 14:29:24 +0800
Message-Id: <8e58124be7cd6598bf19c5e8a507077f4e5ab716.1692080803.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692080803.git.geliang.tang@suse.com>
References: <cover.1692080803.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b95402-1f03-4529-2f69-08db9d590ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QdGcs/VToO/fcsPZyAA3lTti7MLWNDhcN8ocMUzjAL/p8E5XK8DY+MLHsrccrMXQlwCvGtxGDWr9nJubudr+vtmk44oEQUIepLowErMkKpY74KPtyuoHPEWi/JWDLRDInNAdFAGqGfdtbu/p54TILyu8r4v33wSSKESm98zEnzHhDFZ0PLKwkUHPujVNVJWcOLSGzMXaqtTMfrRMmrYvlnmWrpc6I1BfD46nTVlABQds76ACnhRiBuNZBxFRJCjpR5hdu36O3YghOGDBwZChJoYy2XuKFnIij7B6wY43Hw/Xvo3T+YnsQOwUd0ougaCzcJUfVHFCb/kLIyV+HAaOR/20FIQX33vkBwr2pYm2oLcx+pLSBiY1nBTGztHvP+ORlW2s25lEf/Vs7dFXCNGGfozqdc9zFQVOdSeSfikWAVCXoTm7S+9cu+ZFSwteTn6TdWGRKiCg4DTGJK45C9msL6yEEzo5eK4jd/hoQPq0j4lPH/AH7tWm3PTzmqA/X+2bhA5GZpFrQ9Zh2ynop5c1OOvu+SWKw8tA8Wq+yHFBBzHrgB39USuaXAKFiLQs3ShyUQ2EAfyD97Gxp3fEM+g71pbLetx6gEKNIA4pxLMkVS0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(1800799006)(186006)(6486002)(6666004)(6512007)(478600001)(2616005)(107886003)(6506007)(26005)(2906002)(44832011)(4744005)(4326008)(316002)(6916009)(66556008)(5660300002)(8936002)(66946007)(66476007)(8676002)(41300700001)(36756003)(38100700002)(86362001)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0FhJolJLGjjf/pLL/iiSbZ0D5UG5h1INz0PbLfyLCtgpSNHrxhl9droXORuS?=
 =?us-ascii?Q?5yOswCm5UG6Gel/lu0vqhA9JVpIcqm/crz7S+H2s1lVyh0kal/3Q4dKYJ+8A?=
 =?us-ascii?Q?LdBFjBzJranWpeQCRTJGbgbvIJxvZCKm3Sqq5AOOPCRm5wna5bIlIYKP4F2k?=
 =?us-ascii?Q?AsN0BMuBHreYgAMpqrzekQFSAOB896EHB9mBg4lOohi1R4ahmRkt/y+APm8b?=
 =?us-ascii?Q?lLImaRY2RuybGfq/qGCg+ZijOLGTf9HQlbDCRBv7p8pT6SN4EHk/0CG4HFtA?=
 =?us-ascii?Q?BJZJ+ih79FZ/x+ziVd7Rkj4O67JLKk4VGPqzUll5vHOFxuJt4sFyu+DlHoX2?=
 =?us-ascii?Q?p405Con1yarGvbvHypKDbF3KhZpw+sk0ICcMtBZ8pyKRHlq/HJcD2IBX2tHb?=
 =?us-ascii?Q?k2FlF0TwDWKBwneOQUhOWg3MixzJmLP4YnDxe9upgzlV4WZClQqAHe41NTz7?=
 =?us-ascii?Q?eWiUe0XuiFCrIPAf/um6RoCfxkzQG/6uNAsprTb+pMKbFPfikkcy7Kjxo7H3?=
 =?us-ascii?Q?faX9r9GXA5ov51n4E9KFbRdqbY+zPuI0r5hWJc3PcSYCU73mgLiDr3Ck8YII?=
 =?us-ascii?Q?NUefGCPIeT8UWI7HtjYvqz2RPxGW6R2TeX/UEvrptAaJ7wwvkJcysoRbCWLd?=
 =?us-ascii?Q?vyI1Oigf4qt34LDGGvonjfiNUyT76kjgqa/24LA2nc8Qr1bC3mjgpbAhL36Y?=
 =?us-ascii?Q?NHmSgXKtACe9Ch4ovspsAnJLU7hbfM5g2UkBzjbUjaF8PDT9IAPpNe+tIf5G?=
 =?us-ascii?Q?lDctX1BtxoSurRGaAPRrH1+m474aJtZCfDhj/MEdWK+JZ72sSSRi/HJnt+IU?=
 =?us-ascii?Q?CZCr6u1hiGZZebs721fyl0X4Uz7EGqgnZyDRQmqEiSYIh3IHoLX3/mgUxs1Q?=
 =?us-ascii?Q?p1mVOefmdTGRh69Wm8z5nl7XmJTZovSohMDRCQBByNpu90MMkAoRjYieXfwG?=
 =?us-ascii?Q?tkv2dPDyRLtrKmEQwsPoAh+iIEgEnOoc6KSm7IcX7DLTRDUJ619eChBVPtVd?=
 =?us-ascii?Q?Cz+li+TdKJBkNaVRFXMnwrSHEb9kx4xzSlLA4lQQhDL4UmJ6xFF99nwNWqCV?=
 =?us-ascii?Q?KJEe3neHFlONDXHNmJ0Inasd3bXIb3hV0eWQBtygVryvqC7u8tRV7NC9Z0+j?=
 =?us-ascii?Q?cYtCPXdmIVbeV+DbJfBHw94fK5vXvVfnitSzguqjpq8K8+Epj2fbxTMiK7R1?=
 =?us-ascii?Q?bFIDW7bP3f1Skiw9ABi4ihXyYD9kark8M1iymvDsBISwM9Ekh3aOP2+nlZze?=
 =?us-ascii?Q?dmwMQM92wytxQ/fVqK7e0Wo1bRZ6un8ztkKiR9nDoRrbBVyG/6m3fuwKKPke?=
 =?us-ascii?Q?8gSTpIJ9o7msoeqaud3TA227hoKe7tvDkqX8B8S8EIzyPsKnaQyWThle70zB?=
 =?us-ascii?Q?aYgoltEbaQRUBLt+so0YqeDeIvW4oiuFh/GbWL3UY/3HjIgFlVvINq0b5U5R?=
 =?us-ascii?Q?C5cWiyOOVeEbfc6VcZVvwb0t4+XqjmczBH9DOcPVgLkQLXV3DBaNZJcoLpWH?=
 =?us-ascii?Q?V0uaf7umPPoy4k+J6bWttVMFYlZA+i+PelEzpasCSYU3EG2HLHi4m8c9xlXx?=
 =?us-ascii?Q?o2+yeVXzBMxww7eRtnuVQC1/01+PHehZ8U26k6EH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b95402-1f03-4529-2f69-08db9d590ea0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:30:02.7555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJTXSMkerMSW+oTwLwBk2oz9zgQ4DeCKMssWRhGNijnnRT2x1RmQEAM1ciCLwSqKSUTBPTl+YarYubq9TwAe/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7239

Drop data_init interface.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 776c54948a4a..b687f91f2da8 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -253,10 +253,8 @@ struct mptcp_sched_ops {
 	void (*init)(struct mptcp_sock *msk);
 	void (*release)(struct mptcp_sock *msk);
 
-	void (*data_init)(struct mptcp_sock *msk,
-			  struct mptcp_sched_data *data);
 	int (*get_subflow)(struct mptcp_sock *msk,
-			   const struct mptcp_sched_data *data);
+			   struct mptcp_sched_data *data);
 	void *owner;
 };
 
-- 
2.35.3

