Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C4A7F
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:22:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPsx5rPuaplYAx3vfI/MdDeh/fb35JGC9mbpk2uzGm294RG+QKB6qSVuQVA6jSORcC7V3HRd8Z4uK8STic/FtcN5vfJRO5vSsnVe26nTu/ScRiwDG8XwUkOQKVZosJhyK6EUTNebMDctlNgDRAhPslyRCI0rZvSGdoDlmnHM+eO173jP1OGn6dFunLsoWzkaoSN3zLOFVK00Oxi9Q/GCe/4QSWYn7WlVYajuJSOg1Yws0NLpww5IzaLOlfRvXIXfbM1NHzrobfHZyeFcsomfG+lNjJb8sYrRXjJGj4WQziJ2n+3lmUrIJPTjuBfEaxlwYIwT+QV5oQ7imPpW9IdmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzCvdxG2ZfR3jBpk5/LNq57vHkPEKeemvymUa2HbXL0=;
 b=XhKuIcEn0Lr02829bE/WEKqad9A+x/dFKyRm6dyFrFtMtYn43UEjjH1x7Xd0/PNtYUS7ZvbUZZmN/G1SdiNm12Pk0orruCUTLEhS4jzWt9+l7uKAscQHhb3jItoCeehAm66PttuzFO2hwAeERRCekm7ggqTcDMWeG7/eKQNfK9DHonhRhTgZUSlD+3BRorM5oWiiF+uQyqxBVXFrZZ524q7H31Uh75xJpILMAntDFrfhOnEFjYK4VCryFaq2C7grOUMAHCNtsNRYQc1Ft8A9i0gNxCjsD5FRYF1gTme7P1tuBYsQj6ZZ5dPZ19HRJptsCOt8hAx0DsCbr0OHIUvPlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzCvdxG2ZfR3jBpk5/LNq57vHkPEKeemvymUa2HbXL0=;
 b=aatVJ2Ez2ggCOoWH4gLFTd9uByh+VbnVvFS0zNd6oYqa8CGL9nyaLLn56+nLKa+Gmjzqce7Y3Ppf4xPZGi2Rn0d9HvPQElIz9IoAi/ghkkoZIIIrrOcun1qj+SKPXvHCQrap4HoE1B90KOCFLyqfG5kjtqB9mMJu2Y3Ds8Pqbce9Z3StTkw09Rvl9MN86HDc2vsMwLnaztVIxWPUhbgUVghvD+hotzTXBQgj6UCVF0R5fj7NiYIZNjZmbVpR5YoD0rxn1iL7Kz6pvXuPzBCqSzrCMpZDfVWCaNrgI+m6YEqkL2pJ85aY8CZczt/ug9LjOW22gAQsHr/0i7abr/SDrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 02:22:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:22:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 04/23] mptcp: add mptcp_subflow_ctx_by_pos helper
Date: Wed, 14 Jun 2023 10:20:51 +0800
Message-Id: <54c43d6c7020a94ec4c61745e357964c291d1700.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 283f82a6-2bb0-4224-c3ef-08db6c7e2bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4IExyWcMwJ4RHE2fWVlCWfeWyhsl/Ca+7aaTGejNyHNsedxNXoe6hcAO//xCfLYvKmn4pB6kX42A8i19BJ+HGtsUZKLgMxh8i7CQ2pf6dVHpLnHf0KU06jF8bNuHX328EtxaEblbPf4mKG/GQnuU9gNosqb+i138ZTbRaArRDCG4rMKvCfx+F2bLUTm92Ij+vYkoMkL+VdbKSSyxU/C1tUpg+6kq6ofYthMY4Fp9ud7z9yJZ31wbxoPrXD+8ii6qk5aKlm22pAhxrjnDlcHLvql2qCwIkO7TmgWfk9f9ZdtJyo3BMTJzUPNeJZpTrTE6CaJDRtir3EVfdb1P693RviU0RISVgTh2flyJgBZc8qHyALopi4ZuHMK6gSXQ29yQHGD+1lLj6hTF95m6043dZxIY5XjnUu3X4wBZ4Ub80is0xHfGWwQpu0cQBgbFdyqKJ35So5+WFjB6W08MhWS18TVw8RZK3+W1ra0CvoT0fmBwg5zNi94bezUL1oyJO900qvJpUabVkej50mUtR325w1zjoanmnmJS0PVZrZK5YGbv9mtJOq4ltIjD4VoPxpAD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(6916009)(66946007)(4326008)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(66476007)(8676002)(6666004)(316002)(41300700001)(107886003)(86362001)(6486002)(6506007)(8936002)(44832011)(26005)(5660300002)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jv/SkJ3XFtggiZkfVSlegflf5eSo+EEQYqTWMz6a9Xpu1oahEat6cIlcVcly?=
 =?us-ascii?Q?O880LdzAMB8zBXty55w0sGvv5D8xmqly1H7oFqSGNp6kBLqsGANwiUS4457f?=
 =?us-ascii?Q?4LxGSspA6m2ioD28NbORPuuUv+w/s3MhXpx72Yz4xw2O/cNEhBOdLJWp65aj?=
 =?us-ascii?Q?HLkog30KgWDTz+dxDvoYaSeu/cMccYFDgUR3ShsynTAtvwTjGgaDuEMAP7fG?=
 =?us-ascii?Q?Ii5WmULUfL2s0o3gZzWuShwFSViTYVVlAg6zac+oCn3W/NGTU0o1cg0o5lqE?=
 =?us-ascii?Q?56ccd6+JM/MEk95gHGghv/QYnry+tCIE+rk35S1rEwaiyj1lYn9Vr+JO5rh1?=
 =?us-ascii?Q?++qwjtb8d71Ll1odSlZJBpVsbhRM2HvrRXTkFEvX/Q8vmnClWKHTMeBwz+Jc?=
 =?us-ascii?Q?R6Z4Omn1r7iEQt7Kfpxv2Uo9wZnaXLcP+fChcHyexiCWgK6/T5g+mcEFMlGo?=
 =?us-ascii?Q?7Ui7O/JcVO0r+TwsOtqAaPJO04xUzd1Sv0rJd0ARmGxDKqJ1R17IuVx7avNb?=
 =?us-ascii?Q?OLfFEjFNV+YV3lIr4h/KiOd+Qis9NrWTLRPmYl6XV/pkVdo85e3Guu6rD7uV?=
 =?us-ascii?Q?DjbflA9IG7s3L5Fu9JBFsM8bnGbv5yiSyuAoKxXiGai38ULzlZzZTz78PZol?=
 =?us-ascii?Q?keEaQkH7goYB/GgarBKwmty99/HALZInUeI8+VVQXWCgc1uVnnSMVE1rK0aU?=
 =?us-ascii?Q?Tb3SwQz7DgdK/W/6Bqv03WaLS8J5fKSmDIYKJGtvHLPTjran4ZXT8Yjx/+KS?=
 =?us-ascii?Q?Ud9tfZBRUdn1rZtoNyM9HjTmB5qRTABXa3RnYaW0SwbHpZy4qsayRzrUwsPc?=
 =?us-ascii?Q?Ezz+3fxaST3Yh7O7erzSyHm9zCZM9scivy3Gl0Txe6bLrxFrJsP40LLVVryy?=
 =?us-ascii?Q?iYYFEXgTb1klhps4cbbb64HwA7Sezstrlz3D60Mv2rUeOrpD7kjywrRwkKwN?=
 =?us-ascii?Q?aGsnSlNAvoJ/ecypZdJW/MqBf24gn8X8Ef4gtTgiGtadejScvF3ALaoMry+Z?=
 =?us-ascii?Q?4pihIcYxx62DwDpyafmKR0019mTjOEhe+d6Hbuxjtz5TTnBOP9gYEp4iahXv?=
 =?us-ascii?Q?kgUHUOmrkW8HnsQtkGA0NWOU+nRhaKGep9gyMRGkX6ZerusO8PME/WmGtfNS?=
 =?us-ascii?Q?jZYu+34OhKGU6Y46rIKnQvx4YSTTi9/YSJq9EdIw3FsG6iCQO83hzuQvfOBv?=
 =?us-ascii?Q?moCVQV8//IlZQC8uCIL9U5H5V1WaL7N2LT3P3X2fsI+8oxvLhe01w7EDvLpj?=
 =?us-ascii?Q?BZETUg8dmAmUdJoX2ithiGkamihEOdxN8pTOzVb0HPbPg2KKSuwF7nIMogbs?=
 =?us-ascii?Q?Swgy44tEoJgS/1xgEN8zOqeyzwBcSF6c5HiT+agxi2PQLIyeVJ6XLVQ6lUrq?=
 =?us-ascii?Q?N9AWSA9b46iui5GwXgvBUHvmWD6I+BXgJEWhl9iQRKdkn6I1b/CT+zM1KLpa?=
 =?us-ascii?Q?//b2lYU1dKzboMnGW8AsbVIpZrot+6kzKIdYDBE0DzYVAp7Hm6YLDbRoHeoP?=
 =?us-ascii?Q?anY/jve0pI8y2mgnEAJGzF5dXwoF4dO3WRU/Fi1DB1gy7QBIcALExSLmr8qf?=
 =?us-ascii?Q?JVVQdVlxTZNVld7wEb/GJZTEap0TkVUEnFhOgFsA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283f82a6-2bb0-4224-c3ef-08db6c7e2bc2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:22:16.0262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UD+qu2Oz3kgc9ELr5KuUNFeK+X1mU+6bFsIGM0H0A+Gj+zkBmFyGeCXo39piDQ/mXy0xgx3MZhN3biqj96g6ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956

Add a new helper mptcp_subflow_ctx_by_pos() to get the given pos subflow
from the contexts array in struct mptcp_sched_data. It will be invoked by
the BPF schedulers to export the subflow context to the BPF contexts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h | 2 ++
 net/mptcp/sched.c    | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 35dd3683f735..4e42f52596d4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -666,6 +666,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
+struct mptcp_subflow_context *
+mptcp_subflow_ctx_by_pos(const struct mptcp_sock *msk, unsigned int pos);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index ea4b06322d78..a15d7632abec 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -114,6 +114,14 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 		data->contexts[i] = NULL;
 }
 
+struct mptcp_subflow_context *
+mptcp_subflow_ctx_by_pos(const struct mptcp_sock *msk, unsigned int pos)
+{
+	if (pos >= MPTCP_SUBFLOWS_MAX)
+		return NULL;
+	return msk->sched_data.contexts[pos];
+}
+
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-- 
2.35.3

