Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51AD7A
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 04:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650430679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQoDnLcJCXbPD4I92hufzsOd5mkRS7q81TpG7C7wpC4=;
	b=gif0wZVXJNKezWtHcWrVWTsYOdwbQ2sI59YfAFz8GlVE4TdxXPoZlgRkpRSyxslwM2xTjA
	RIJMrTEC4XlT3D81hKIygWHDSdJbf5Vpf05wAR1RdwFIzKBkrmBB69glf2eaJXwOK2EdrD
	q/2yuF1N8wLbYsBGNoRHmWFcN9/wOgM=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2058.outbound.protection.outlook.com [104.47.2.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-dSAWL_X8NnqGvVTFU4lmJw-1; Wed, 20 Apr 2022 06:57:58 +0200
X-MC-Unique: dSAWL_X8NnqGvVTFU4lmJw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiQaqEt1GQ4Nc0wyAaMBlP5WwSh+gZtvpnFLOzigLKuvsIVtrATVPMyOC3igb9V4HKtcUWsCkcw/gTm6nzu1nvbOPlV2vwIcydDUM22u6H6+fbI1KNVMSxebGrkm2dryEzUSpWdDfvc3SJWK7pJNrF0Gj9Ilkdt1JDtytoWrc7V1+K/jqvDv2TURwUFyU0ggaQnHECZ/L2BihLUIbd/YT9x0wwMsIxTsIRsJ015L+Omc1j/vh78adew2IApNm9IpxD3TAcAcyeckIif+B8vtV668Wco5i1Qb/Xf2GH/OpM6wp1lqQ8Y0ibDytBrkFNNvmyKlV+HIKOQglyNDeCU80g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+FgTwXgEjAjg/NHrPCTwby3r1P+vIgim2QSZjWNhug=;
 b=abVZCLP2BARPjhY0+owPwI7YLOmzZhY1vcADxguOsFguk1SvP5QT9GRC5mvU8T4pVlISMFV6OmZWLpGqcEAhNLDRMsphpdMFRJRK0OBEZayQm0P2bfpsWWRJQZDRzafGXwh+yy2C9DVznJos67op0TcAveVpmthxByM6Ts7vNNae4SPfvFgTm9i1GPBYCvQB9gMa+TNyQJDzQn+yWcmlk2VaV/Ep0LTaSnAPM3T6Mq05WzC5UGuHr1nVdpUBCoVqS88DEGReUKun8zC2eqhtaFdR+KNXbFXxhK1sWlmxVmAZtfeC0BPtwHFA93ELhTKBiETohPv+O3BKT/umtZAhsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB6504.eurprd04.prod.outlook.com (2603:10a6:20b:f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 04:57:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 04:57:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 08/10] mptcp: add call_me_again flag
Date: Wed, 20 Apr 2022 12:57:07 +0800
Message-ID: <68fa62e5d0ba5fe88f89f6be7923eb952fe3b817.1650430389.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650430388.git.geliang.tang@suse.com>
References: <cover.1650430388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0181.apcprd02.prod.outlook.com
 (2603:1096:201:21::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b57c28f5-c283-4a05-b720-08da228a5509
X-MS-TrafficTypeDiagnostic: AM6PR04MB6504:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB650422ED595D4377A77F4569F8F59@AM6PR04MB6504.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xVa2eBPTpntIbumzjw3QDnCAkFF9emry5UC5F1221wFBHhFPpqOvwEF+HGBcahmgedsh306GJe4iluwvtL/qEelUjOkJ4RUYS1qmAVlxaO/CM4LNFyYr3KiAs87MjzAUG0costvV3bWdFKksMZ7nhqPdEoMZN5fAALG+ouKA0fQobotseGMiMSwsq2UQSqBNV7/wbKrrXh9IxyryPVz7ntenIhlAVucN/DeauclczJUbObKrLG3A4WBniw8k1dRVjsl+D4Ed2uVAgR3itJN1y9JDntTe5zjK8o6TitKjL6L4y402VWG/vjz3sAIFfopPKaDi6WBaYz4hn7VF/ZCxh/L90hTvFvn5RslMLDeuzhU53pcw1NWPqr3PCGGWNnPsc8i7SMZcVHqAWV3yJILBlBeccnFRgtrgxXqeZpSO259LQmiiKIpzrz5g0hojiaUdqGxuruyBpSiR6Mb3lbcRh46VmrG1FtadKlvB31XBD6bwZ3cVofmIH5UWMmiJkFYjWT9Ka5GnHdo2/SJWuGGUOcN6EWp+b7FF1US64Wf5lkD/ZHeWmpNFrdouzIdO5G3I0F8Lek5PtXpogG8+amoBR/F8qydRG26YKMRpi9l+1h1BmsuEHR4CXhnfwg2lCLJmaHfMZYKrVLeFI2aOXHl57bkM8qxeaZOc6KvQQMHp4Y0wMj8agAjDkVcGETwwNB1w+rbCkdTM9sm9auMw62K4Kw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(44832011)(2616005)(6512007)(26005)(186003)(38100700002)(6666004)(83380400001)(6916009)(107886003)(508600001)(66556008)(66946007)(66476007)(316002)(2906002)(8936002)(86362001)(8676002)(4326008)(5660300002)(6486002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3nYeouYHqaOrcYry/9LdN5/Q0ikq9oEUxsA0Y/QIwWAn6QJG/Rc9Q3VThcoi?=
 =?us-ascii?Q?2N6dPZ+2JQAP2+J0/DIi4ghzUqZ9prl+ucqbFxm8aemATtfcwsZWfq50nQ0V?=
 =?us-ascii?Q?DL7WEyyNrkhuZAmso8yYKRkTEAza62DZHrhMVRyrzzx7LSKFGITlcI2UN1ic?=
 =?us-ascii?Q?mXr8Ajt9xGBMZO5JtfFBVPT+dwJP4DJDWQv3p4BDFPb7bjjWkMcOjwYq/XTq?=
 =?us-ascii?Q?nhRbXUSLcqCs8OiJcDbo3Gutgw0I3luDsongJ6M1unHIng+6aV3mXchB0QzK?=
 =?us-ascii?Q?RaIz96tXUK3V+n7TFvwCPvGiJlYQgUygsC6RzBxNoT4PmvWL/UEUXZM7Vo6y?=
 =?us-ascii?Q?6WhXpT/bCpZMe5TS4Y9TR3H1lAHWu+PD4zAoiYiLp6TpxMrwvfJr6K4moruh?=
 =?us-ascii?Q?2H71XYlG/aEjimQ5XVpsfQ08mtT1t4LF8/lB77mejWKoKYIoKUMJgOtKTVNU?=
 =?us-ascii?Q?TsxROvXSUALCTYeicYsfxwt7kM2pNGB9/efETMGtRDLZZM9DPDdaUd3KpCza?=
 =?us-ascii?Q?BHd0Z+s7arXtR2SNXiB1dWUVcQnN3mb3cIZ0LVmUasP9NBjlSAI6bVs/XY3e?=
 =?us-ascii?Q?Mw/vPAvwpVh3QConF8o5a8xAQL7sNrhLcRhv9s2K66jgBm3efu8kuwwDB2+9?=
 =?us-ascii?Q?hkMT3j5FXDPgcrm6aiIdzlEn8g5vUojiPEyotY4J54Oa2fCGuYHQX6vChSIc?=
 =?us-ascii?Q?NIE2t2fyqExpvU8IFS2HefJ0DSvuZa90zO4VC2EN/VYjzj4J9WahPX1thsZs?=
 =?us-ascii?Q?6qDXUtBNNivw1M5FxBx6KmeMMXRe/I1vDPUyqjVHBRPuIEvn5/rh4e40jdDz?=
 =?us-ascii?Q?fZOONHS1pT9Za5CEx9V24tmp9+xqA+A0svXONV/cRnfWTQ8o/Xe/4cLTorcN?=
 =?us-ascii?Q?3IBN7tQVhwcHXrjF9NpmwyrZS1fkqtbxLxXPFnDa2+VQdhaMu3AZLHRsr4IY?=
 =?us-ascii?Q?KqmjDX3BWyxqrpDSoxlmMYZPR+rTuDV6aFNZ+CV+gWr79axs2Dlnxymvf6ju?=
 =?us-ascii?Q?QAFyODc70xl8dtJ0yddVcaotB7ODroG3UHNYe47e3ZT6VdVCLZZG2kh0fSeQ?=
 =?us-ascii?Q?8b7+OMu0WCrQIpcHO+BaJ6x9myBA3gfvvsJBVep+TJEWngH2yOwgCsPoB4LQ?=
 =?us-ascii?Q?y6CbFJbCr7CDQOxOyuyzu/yAKxLH3Z32HMyadm0XXKx/zBmfob4DHipiVah9?=
 =?us-ascii?Q?vIOZw/OBV0M3VVCaFV1MnfGzKC+CkwEgNdTkryGltSDwSNG2rHrE26NRMiI6?=
 =?us-ascii?Q?zcImA8p4aZAj+XpSP3KOzW8fIQV0k3Y6+tmsV8uOXUPXKCyI9chxVoeKFVyC?=
 =?us-ascii?Q?cAC9VTI3Ul5I8c1ypnHJ4Qn9/cEzPie6Hj60ae7h+DRL864osr+O4uw5GwQk?=
 =?us-ascii?Q?2z/gFUPYEowYzDz5dCq+dbyuSW//1RI9hhZ0nGt4LVwhlbCUnSrScI3/3oun?=
 =?us-ascii?Q?CZqgQaXt8/XiLGzM0vTYBdmsZAciTzXH3/lh3N3mqKN2w9kHQxU3Iex6Tva2?=
 =?us-ascii?Q?vX9ZosAxoYmmIB7IJbng5kLgievcWzEscvzO5QM7888j4QBzpX6uxXYACl9m?=
 =?us-ascii?Q?gjj2MJ/VxnxSSrdZdJh3VBL/HmdDRuc7v+R/hjKeat5aESDthXqR1TbCGwNm?=
 =?us-ascii?Q?piTre/dxKdIVUhraCZ7b/qdohjBa/Z/nAYxXT1AGUy7Gubz95wnugIBL/hx7?=
 =?us-ascii?Q?pKMwMqYuwqIw2iMQ/CREo/il/N+RfF06Lro98fNWPrGLJZiYhYoGlh6lXT5L?=
 =?us-ascii?Q?iLm9dX/ma9CKYLYaifYqA12mK/eqr+s=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57c28f5-c283-4a05-b720-08da228a5509
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 04:57:55.7002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXgRB8bJMavLtaGJ86Z6lFrCDNXPzbzQNBrs+3euYt9K7oBz6G+NgEUGCliGUQcAs+neTMg6RNoUBh2dwYqFUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6504

For supporting a "redundant" packet scheduler in the future, this patch
adds a flag named call_me_again to indicate that get_subflow() function
needs to be called again.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c                                 | 3 +++
 net/mptcp/protocol.h                            | 1 +
 net/mptcp/sched.c                               | 1 +
 tools/testing/selftests/bpf/bpf_mptcp_helpers.h | 1 +
 4 files changed, 6 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index bd3c50b07ab2..e203653860fa 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -60,6 +60,9 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_v=
erifier_log *log,
 	case offsetof(struct mptcp_sock, last_snd):
 		end =3D offsetofend(struct mptcp_sock, last_snd);
 		break;
+	case offsetofend(struct mptcp_sock, sched):
+		end =3D offsetofend(struct mptcp_sock, sched) + sizeof(u8);
+		break;
 	default:
 		bpf_log(log, "no write support to mptcp_sock at off %d\n", off);
 		return -EACCES;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d831effe2dfe..58b980660d20 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -299,6 +299,7 @@ struct mptcp_sock {
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
 	struct mptcp_sched_ops	*sched;
+	u8		call_me_again:1;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
 		u32	copied; /* bytes copied in this measurement window */
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 8025dc51fbe9..05ab45505f88 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -83,6 +83,7 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 	msk->sched =3D sched_init;
 	if (msk->sched->init)
 		msk->sched->init(msk);
+	msk->call_me_again =3D 0;
=20
 	pr_debug("sched=3D%s", msk->sched->name);
=20
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index 90accd94e947..f02d75f91e37 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -25,6 +25,7 @@ struct mptcp_sock {
 	__u32		token;
 	struct sock	*first;
 	struct mptcp_sched_ops *sched;
+	__u8		call_me_again:1;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
--=20
2.34.1

