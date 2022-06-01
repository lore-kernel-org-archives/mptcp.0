Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7728362
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 06:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654065999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKYwwAFuD/CZ5STa1JcvR/nAIsy72hPRxpox+rLu9oo=;
	b=EWrQRlfmVIDGiwFjurwP7bl2LFnGGUIuf2A4P2CwUVRhTSe6Arpi4KO+2LYewtZhXDWhbG
	Q2pGm8prcbg6nTg7ELyRG8ZW7ePUBU4aL/c88VyNZrWKVwD8nvJZWb3yAB+knXfGUdoJjN
	EjYPL49SEMqY/i5TRpy29jRe4D0DJCs=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2057.outbound.protection.outlook.com [104.47.2.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-JpoJ33jtPJW__afB9hOKVw-1; Wed, 01 Jun 2022 08:46:39 +0200
X-MC-Unique: JpoJ33jtPJW__afB9hOKVw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0NNCw/k7BAkyy3YM+T0ZwSPI9p8m1zAYQwLVMtk9f2dG6Ha7hZ5AOXkIkJRQZ2CyUBQY06MMYO3R6iJiKn1WthzU6xSF7xFHmBGnrupTPbm8zs+PYSjY5sOqBh/DMXAI1b4BC4Hfmt5xr1dVqIUIwiGATWJ97N3N27iCauPqT1BXZg/lr6ylk3Nr+rSBK3ybLs0jesDlEVzWcFuZKllezepBL6S09OzRYZB0GnTX6AxOK79qs5PdMx9ZN1ohaM9DN399SBl9i4nQZLA9DPTjQmNlT9RJjeRWvZ+Oj9CWUmxFPej3YkIOc+k9vabRhzCGcSPulOd2TckoLNNZF67lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NdWQrnUPkVITSPWjEtbwj7tBNbDQlN1Ogq4UP4bFDw=;
 b=ROFTLUqX/IHwNiEbtRCCcs/wEs6cvqYRINwTWIMNh6j5zvOIt0Pg83lzJ4D9HORqO0NbORtrVCcggmBVy0BZ1fZSehfjSWd+Ob6nQixrckMHgcpGsywzLPY/O5NiqhdZVaxiaddRJMvkuL2BVPpobXuOlvQgAbUoo2CQjyOqnCOl6IewKvDaH9191ZASIg3/UKxG7tYjyrDOSAmOiBnFs4N8hBd/PXEWag/C5rQCUctrz5zJn3gwkbtg3b50kndaHz2BJB3H+E4JlMBtuCTHr0c4kVUAv3iDGoX01CyaSRidMhVIFdhRb0g5N3HjOs3+MG9VeQXG9gb2pvdbQmyssA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR0401MB2434.eurprd04.prod.outlook.com (2603:10a6:203:35::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 06:46:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 06:46:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 05/11] mptcp: add bpf set scheduled helper
Date: Wed,  1 Jun 2022 14:45:54 +0800
Message-ID: <af10cde0bfec857862b84ac9e2624a544ccd4795.1654065674.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654065674.git.geliang.tang@suse.com>
References: <cover.1654065674.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:202:2e::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ada62ed-af6b-46ec-639d-08da439a79f5
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2434:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR0401MB2434D9F59575DA1CB9311162F8DF9@AM5PR0401MB2434.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	69Ke+1XMupESZUK5HDrvwe6BFUhfGAwee/5lZKk3fBUm+h0jRBdMfiv7bWhUCZE5CI5TnrKE1akmm1N5Kjhvt3WMJKIruz3pbLZcgE9fBO8EVRnnRW+L3o1GCfEeR8hMcptytluFgQW5wYXWm8E+jQL+gIu42O5c/ylVIalF3vT6gnaCOi1Qs2S96hKFJ55kkRPp81LHCx3Em6IQhDQCveNjW5+8hy3Av7h2Ls1kQz90qR93eEhy3/gwRtT2tqaWvymqt6IK+ZWDdPcNVZ8PQJEoydQcoK2e/MpGZkoutrik5Vro368WrkJbHdrDeYsrr8E2oTU0pyN0ymhdO1XiybYPNdEguLO5pn1zo5ovEkT/PHh4txjHgJggWrxOlVzHBYCUKBLnSBgUeIEEbk5rIkgeB3ZaqkIITL2z2dNi08FANRdPhU/MCIV1vQcIPTRSRJUMzn54DP/UBlSrBHXDCbQf6Hg7Bng7Gj+E/WS4oEs+J22EJGj4vo35HQlYF7sIQCvZenMZgzuH7EtHvVyBc1rD2D1uWYNP3JhiKuO8uH/umtxmyRfW/N5NBy/zsQ76zk0cnyV9Nsdq3i39W8AnCvXx5UH/Nmv4hqAdep2RU+5G7fsk7uDtM8vu/acXQtrPxSvg04uWEpzR20TJCdMnuVj057NYX1VpPm2jtf0dcCQDMmTRknFue6U9ly4Zt8gJL48DE56NiErA6Wu8PpPAzQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(6506007)(44832011)(508600001)(6666004)(186003)(6512007)(2616005)(107886003)(26005)(38100700002)(2906002)(83380400001)(66476007)(66556008)(66946007)(36756003)(5660300002)(8676002)(4326008)(6916009)(316002)(8936002)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nqyPd9/iqDKF8+uy9TJdB/yDDj7kqccJNgp6EVqWg3DO2Ycl38MQ8nIpSwSa?=
 =?us-ascii?Q?cze8d4dyESs39pUJ48bIxIz8KhyPPewmAYGuNzwW9ME+V3nIeDfd22I3b1AU?=
 =?us-ascii?Q?50ScwsjJ8hJbPN80Y02oe4lROXMAD49ufaBV55077QZ7dLRqOUjGliLra+V/?=
 =?us-ascii?Q?ttHrd4xhNLSOwm5VA9OOW3aI/3ZfGwr8yJol+xHbL6UtL76ok7pHQ0cOqbWy?=
 =?us-ascii?Q?W6z1r5u7C73OsOTB2egBZIf4DDMyeMALHnZJuu+i24awTSoPyGyvN2uLj4o8?=
 =?us-ascii?Q?2i5njDivEVtM13QdgoV+PH0ZZZkmQni40x3tKHB1WMBDjCLYfNCRwIYQ9gZp?=
 =?us-ascii?Q?8t9rMgbJFTTZ4lD+RkWwiELblYiAfo066ZtERmf2te0HHwwmIniNOqxu1nGt?=
 =?us-ascii?Q?/jymurTwotYzw8nFWGQ48czitf7XeUTBV8Ih/xrGD235I7sTnOrud7iuLCgr?=
 =?us-ascii?Q?2yxCqlz9Wx39e8NL5W05JGJgtwlVNJZi45/KI4Di6W09B3oWnk9NJ7C1JHbV?=
 =?us-ascii?Q?aQbEfP8wZKgqkMPiCCvBUwg3utKkjydTfP8MWttCoSeFJ0PTQDgO+0wtbign?=
 =?us-ascii?Q?bbSkKSpw5Vi12fsFDVtUZKflVK7BQ8tR81h+5ID074NklEuRTfN653TXa2kd?=
 =?us-ascii?Q?SI4vR2xR6tHYzwq9Z82/WJUUcws6Wah3EaTGE+mAYhSvRsjG7revcrowotFn?=
 =?us-ascii?Q?xeteXe9A26V8/ordQiUlqVHEWCk5HTLZDj6XnF0rnYP+hnTC6dXfWPItIXsW?=
 =?us-ascii?Q?epUw4qPaMyMzgKGGoOy2CDrXtclZ0HzLamDaO+w/WJBk6tZXQNzI18pzwMc2?=
 =?us-ascii?Q?ItAF2w0IzUShhIkmPsYDPsMrBvIEhilrmWxsWRe/lP3z2R23jWgs1rLm9ahP?=
 =?us-ascii?Q?Q+BwwljEiS2Gl9izniI+dlAqD2LIZqawYphIruPzSjKLn1dcj9hKbAArzOP9?=
 =?us-ascii?Q?mYTO/S9v4cc7BQXshA/eiELO3mEBUCAyACDDfm1CrYUH5gHj9g9AX6apOYl2?=
 =?us-ascii?Q?GommTZGVKNdJza9Wow01ulkrYz19DJ7i16FI07nA/mHazO8eMSC8/SURVIXi?=
 =?us-ascii?Q?JxdjJQ6hgCJHpoYxyyFzaVvdYqjp3I1wDJ1zH+deU0NL/kUyL2s3V4orwj9+?=
 =?us-ascii?Q?Is1RWh1eAuiXcypOYI8D7Y5/oIc0pAe6gU8gG8a7OcxMlGzbD2TsyzfWLes1?=
 =?us-ascii?Q?s4O8tGAAyXaorL7dpC6/Y9uVWjKm9S40+i7gpclv+WVsy7fUP9hJmuFsIUme?=
 =?us-ascii?Q?Ynb9jj1EdFwfg465inTHFT7BdhozzDgUP4ApnwoYrT06cEiWFA8WGdd9ofH4?=
 =?us-ascii?Q?y94vIzHMknxPRa53UKYGc+anqtCd1j2coyJmzydhBWTmUKmR6X3vA3zgBIkp?=
 =?us-ascii?Q?U1buSncjEhMWfKCEauv/k0D/JLjbufLyPHqC5olG4sPh1zqsm/eoRrqfzKh9?=
 =?us-ascii?Q?sWjgxdi29OblZBOdjov/+jYhovYGYMCSNWHbJ++XWTYEb/dT0fefgHh+Jcth?=
 =?us-ascii?Q?pkVXAAFpKq/w+5yZuUpDHCQnb3K9FNWwRvTUTztwFKXf1u5JcaINCuASa/D/?=
 =?us-ascii?Q?4LbWapE6nq0cyk46yjr1SiEQQFBmV76FKvgrKomEMymgZf1XWrtZWjgMii2N?=
 =?us-ascii?Q?IsEzYIQo8Me0LJM05zL9N1pqo9NcjpuZiuRu45idzH98waQptdtKq1h/SZB7?=
 =?us-ascii?Q?XjoCMieoNNq0umoFGmMtOE1jqRxWBNVOu+iN/7XigPdhjA28dH3g/2A6BjwF?=
 =?us-ascii?Q?Gi3kPO/e7/jypcJEAFwAMkO5Ja9gJWg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ada62ed-af6b-46ec-639d-08da439a79f5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 06:46:37.9933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bs+NroMeT1cl3LY0GueBrgwZksRs2mo6bTSrMEGa/9Pj0sL2RQPF9qY2TOmMBUsPdIilwgsMKFcnR15DtGMu1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2434

This patch adds a new helper bpf_mptcp_subflow_set_scheduled() to set the
scheduled flag of struct mptcp_subflow_context using WRITE_ONCE().
Register this helper in bpf_mptcp_sched_kfunc_init() to make sure it can
be accessed from the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c                               | 22 +++++++++++++++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 0529e70d53b1..23c2776bb989 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -161,6 +161,28 @@ struct bpf_struct_ops bpf_mptcp_sched_ops =3D {
 	.init		=3D bpf_mptcp_sched_init,
 	.name		=3D "mptcp_sched_ops",
 };
+
+void bpf_mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow=
)
+{
+	WRITE_ONCE(subflow->scheduled, true);
+}
+EXPORT_SYMBOL(bpf_mptcp_subflow_set_scheduled);
+
+BTF_SET_START(bpf_mptcp_sched_kfunc_ids)
+BTF_ID(func, bpf_mptcp_subflow_set_scheduled)
+BTF_SET_END(bpf_mptcp_sched_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set =3D {
+	.owner		=3D THIS_MODULE,
+	.check_set	=3D &bpf_mptcp_sched_kfunc_ids,
+};
+
+static int __init bpf_mptcp_sched_kfunc_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					 &bpf_mptcp_sched_kfunc_set);
+}
+late_initcall(bpf_mptcp_sched_kfunc_init);
 #endif /* CONFIG_BPF_JIT */
=20
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 5f6a7fa2269b..488de4b920ef 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -261,4 +261,6 @@ struct mptcp_sock {
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
+extern void bpf_mptcp_subflow_set_scheduled(struct mptcp_subflow_context *=
subflow) __ksym;
+
 #endif
--=20
2.34.1

