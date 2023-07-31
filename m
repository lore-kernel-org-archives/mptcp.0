Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3977D79E4
	for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 11:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1Fj6lamUaNN3SVsPjn50P+9pdowpSqlLcnVhjAQpWFhL5mo+0B/1XkdXmXBsEV9aQ4cqMvH/NvLR50EuztJnP5t67A7kxXwQCsnmUVIgFlBd9BaeuUoyWtBweHIAnMc5mJeltJNtjlD78nCufgGhvGLFP0guuVdlQAaG7tVq2bDWbqVUr/W0UncPDuLzOfZmBEGoA3iL7mumffliLW6BR0PDHM2k6detjoZOIGWgwusz3hHtL1bIMPnuNDhJ0EIGVy/c5k44pgIxkH/t4FCQ1jjXQuUVVrbK4Zl6CwztQQFHG1D66ABJ0W2BMp9G6DCRLWUiy1ZxT/Qn87gHguIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lC83eWHrDL4T5Av1QA70WcReRI2ghI0PLhYyp78SSIA=;
 b=aINH9mLsNdnRBn4bNDnIiX98ocYLogvQs4/Gf1DnKRprCT6Fhck1lUH7MZhbK5kHockwkrhDaTA9GGEYJ1BvRDZiW4Eb4XrXlaPUPzjt9xtkezwgaSfnfocLdVeotcPH46Zz5XtH73JjSR85Nx4VCvM4dRFXAlaGCkFlxa+rxSkJ8DA8X75ck41bQQ3o+uqpTHn/EV/M2iTBaB4QenO/BdGJljJAjB14NadNEo1p5Mb6LeyOVbP7yIznGfXiAeo0AnkhFWJzmSm7VeRmxhpd/c2xQ01a6LQAwgyqJED3LiIQTWBOyyzA1m/aZEAd1zdHtpgpWMeEQOzKr8YEHxdAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lC83eWHrDL4T5Av1QA70WcReRI2ghI0PLhYyp78SSIA=;
 b=c0aqxRuVsCGsTBAwJ3tNmzH0Ib4sto7PeGvJaDttpWevtiedTpKQN9RMll9BvjatH4PI5sg0Hh1bEyh753OfH+6aXjcER7sb3gupBLH9YZsNYuTRzEQvOTA9rv2bpCAwA0phayQQcOVU//kYhbfaK+S0Glxmmdbaur1AbQRzO9no2UfcfPBj3/m19tclLaJ5S5alumHu+UmzwpSsNf8BlrtAuGPaFcQvWgTTF0xwuzH4avDuYktJlRlets8x/yzW8aomrklZnDvSyBWfSwB+jnb7iBrwgurZl3XrARZswNn+fS4d4wOdnxj5Qmmy55PiriIgvehpXifDt7wXF1deJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8075.eurprd04.prod.outlook.com (2603:10a6:10:25d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 11:04:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 11:04:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 4/4] Squash to "bpf: Export more bpf_burst related functions"
Date: Mon, 31 Jul 2023 19:03:18 +0800
Message-Id: <d2bc86f8116310c2f3b2931fc3565ef7cce17027.1690801329.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1690801329.git.geliang.tang@suse.com>
References: <cover.1690801329.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0021.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 4632e745-057d-4ee7-be4d-08db91b5ddc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+p0ehIDujhumO2uq0NUxsDJ7ZZH95Sjjo8ITvPHPiToISAjZFSvt8s4mU8d0h5NR0S+U5fxbU0f13OSzMk4CO0RioiFrL1a0AZVovVpI8lcTZ+XSB1GfzKDY8NvqKPf2CXcKDY0y/75pDZe6qjMxhntdLRh4kmeU/poceFHVd5qlyAS1JXHxkDr9ZT+8gtB42UebeV35QKF93LKMMWxZx1J1qJT5B9YkRH0cRgYD18n9gWHFayFZeeCPx5yJQ7GeBbE2Cv5oxDpW+ZV1Bgez0h2i5XgL5gI1tJqpctlAC0Ug6/0i3uO1XeCAB41ZwL4kOIkYMPfauaolm25T3Q0J7Y0lXhNq+Xcjqa76vtAR54U9MCZi7hIyT+Us4zBBRImN9Ld0chOOvY3x3sS3lRppCVPpGX4V4nqdm3Hjh3MG4eBwTOeQrW1zbyHpHXqSxK9WzLk/biPv2PpnM09w62pXZoDz7tdotZH/7dxNX1E2U5WAt6XYJugq3WymjWlBNC3Nv6W/JWLa3QGCwcNhQvcaPMa47ynLvmAh5oLkX5k9COPExv1OzmCk3PxpR1a1KE/C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(6486002)(478600001)(83380400001)(6512007)(107886003)(6506007)(26005)(6916009)(66556008)(66946007)(38100700002)(66476007)(2616005)(186003)(4326008)(5660300002)(44832011)(316002)(8936002)(8676002)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uuioGUDh5ezpraIAQFPftAwUuuaLhVtXcHefUz8IPGzCvrt/J0AikpfUPg57?=
 =?us-ascii?Q?ZwJGqvfA1pr4Or069o5BkqnwDoyCGP9RoAdqXODW8cZAdNggkklgANjC4jot?=
 =?us-ascii?Q?8AXvgU53AA9SWFzfMqKK6BO8s0/0pv8yjpD5PFAhdCvvs2NqMnvpi0ppHc3/?=
 =?us-ascii?Q?AZZtayGjf6H4Pi06X5gHTF+TNcj5g9249wUwI7tvBXYr3afUXfM9ri0fxrHL?=
 =?us-ascii?Q?kR08RE2uTtkmUd5WbJauMv8JyA2TERaMBwc3k7RLD3fZmFWwfIqc9DBlEhtn?=
 =?us-ascii?Q?GQgUfZse/vYKaLkjdsQHqWrlh7qczXUO/okd8JYBoDa1J6UqA7bxeS2jS+Pe?=
 =?us-ascii?Q?PUYkmWtH45IvHeTv3OVLcjiKwYekFy4QgauowzNZumHhM2TSBGFv2fsOG2YQ?=
 =?us-ascii?Q?xFYvw1MN/SBpHPRrqLO6fk1ydW/e/EEm1YJ4G1D/PR7IPydmoFzB+73dx2ln?=
 =?us-ascii?Q?zceSSXh9cXLiVYXfC59LNR0FJGGL5gi95n7nHXaBD12LhrbVkDI5JLGOTWfj?=
 =?us-ascii?Q?ZZJT5aoAFHnO1o5qcNFICRCnwEojTCOu8ub2YJljF47QsyzWi71D4jNuuM7n?=
 =?us-ascii?Q?BNuwvqVK/K7D2iMaU16I2dKrZDbShDWX1akRXLlaFtdJWtIYahHNOXH1XyRf?=
 =?us-ascii?Q?Ksv4UBPPha5zt+47ulmoGDbuB5EAioCK1afkt8mjjPnlum7UPxztoM0ufET4?=
 =?us-ascii?Q?Qwjxb1vZS2zBmFt3J8Yf/YApLiBhLo4iqyB2d+bvxq4che4504hKHb9zJ63i?=
 =?us-ascii?Q?dBatExBszvb3NJ+fhBFI7b+AwpxjGM2UkDzum2n2v+8twxMyDjlEH4m4dXrx?=
 =?us-ascii?Q?FrS48ligAmbTq1vpf/4NpHXQ0AExSejLJPPr6cW3YDKEk+MY01GRB2mmMbR8?=
 =?us-ascii?Q?Nf0C7Ag0EtxLJ+3sKIRDw/j1TivnAeOEOdWuoWxaxyqx+q5mXXGS+yOF2o/d?=
 =?us-ascii?Q?MC69O+gdR7Ksjv9ZDkvArM9HJFZhOTlHtaolANh8M1pRYtsNiNCcau6fvQoc?=
 =?us-ascii?Q?oe9BxVeRKDFSoNQGWLG2n3Q4X4dKo+2XJpTEXLSA0Kd32HMVbTXHJhjv/xyB?=
 =?us-ascii?Q?zrnheAhs5U9gt+H68+Qus7UuqqVQ8Zi0XOUkKGr04JZODzQSuF+bOqenW1jv?=
 =?us-ascii?Q?GPiEFOZf82fE60TTunyjhPPJahcvnkfwElTAEKkX3xnwIofLt2TprhoXAXyw?=
 =?us-ascii?Q?4+sVP7EHbZebe7Lr9g67rMoJ85ST4qT9cCaI4Hhg5qwvElpYAJ/9z2x99+1/?=
 =?us-ascii?Q?O68SI2GSXORXcmbbddvay7GdNQGVGw4MkBz+irjtfzmecWNclznBWO8VxcBY?=
 =?us-ascii?Q?svR/1PbplbdFtUn0gg8S9IKIfPuUGjnPBKRQABoKHOzGNQOZtAQrv5JoqGR5?=
 =?us-ascii?Q?PEpmTDu7ofwHvv+FByWAPS996Qh4P3JswC5ty7eNLn2fT+55MT2C2bevmEml?=
 =?us-ascii?Q?iZFLxsrn9RxnfAwWiqxJWwlZLj+u6lzcRntbkqSdIuev3StYN/QnlkNj/SrD?=
 =?us-ascii?Q?gOUXxrtxl60/W7Xyx0cZ4x5oENUNw+YiX6mHkkgfLVQvPPjNIk4cXHeWbXj3?=
 =?us-ascii?Q?tW08oUnOY4DgJ4bWByzpQbVT4PS2dxlGh4/46AjO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4632e745-057d-4ee7-be4d-08db91b5ddc8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 11:04:10.0615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlRS5/CM73bN9cFm2t2Y7whDeZTtK7PahE+cGQgIFbkUtsY0HFWFgHJiczs+p0CKbZFkPMC0cfPLsyyEuthPTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8075

Add "ignore -Wmissing-prototypes".

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 6 ++++++
 net/mptcp/protocol.h | 2 --
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index c33b5c7b1649..51634efe4741 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -144,6 +144,10 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 	.name		= "mptcp_sched_ops",
 };
 
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "kfuncs which will be used in BPF programs");
+
 bool bpf_mptcp_subflow_memory_free(const struct sock *sk)
 {
 	return sk_stream_memory_free(sk);
@@ -154,6 +158,8 @@ bool bpf_mptcp_subflow_queues_empty(const struct sock *sk)
 	return tcp_rtx_and_write_queues_empty(sk);
 }
 
+__diag_pop();
+
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bb7215c6b8cb..a080328a8226 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -643,8 +643,6 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
-bool bpf_mptcp_subflow_memory_free(const struct sock *sk);
-bool bpf_mptcp_subflow_queues_empty(const struct sock *sk);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
-- 
2.35.3

