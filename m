Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16827A
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 08:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652948777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bplI9rX0E7VQWmxEeoit1jc5FHz4R0qMqAETsk7/VM=;
	b=GcIVXbG0mqZLvVpKmXwJghS3ahvb5ceuNfJd1apkhJCziokxprPRH5hjTw2rauYvE42nk+
	d1F3mc/leLiqAvqEe6aThGV3Yjftbpl/i/IpV7QCULeCWI5STq7pz+JrbYWs2na94cydZL
	CddfcQctHOPHlrxmq/CoZe3GBq8XCmM=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-OugJWbMhMAmT-U2Z54LJQA-1; Thu, 19 May 2022 10:26:16 +0200
X-MC-Unique: OugJWbMhMAmT-U2Z54LJQA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bH7ovAthoBbx1EZeKpfOTTDAloK9c6RxoGJrzHyUsf/3EUgL5kjiOz7/57MuIMLmn5LhbTwqoAkQzxh0Hfn62GRoqz41gpq81lDAio8ZLRIN+FRvf2IWkkTbyo7jxpq33UnMTIaQGak4uid5ajlWufUIs0U7kvH5MMHp9OaAVaPs8vARY5a6ApQ9Zzr87P9s2uFdmGL6fSol2l6S8UGafZzenlSoeHrJhODWICqVo8B1Yc0C99L5i206TdEgY16/8YHOxAnWcCpL5L+JUB1Zeadncrt1VaKwH5A2B7wxw8hhq3u7GIZq6RgbB5T+6W3OBpTCWu/3yTEJUGrISFNMKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kldL7lnlLvgd3DBSbMJOQiL5fToXVqL9yekeasqx0t0=;
 b=UPAGHQnafHucNndTT8dPNTyfWnxig6xExS4HrWyvkS5RvQ2wotOxXpjn08HfeqXhlYbqbAz0RQh/Dt+6EsHcBbQA8u3UEnjGPxKE8M8KOwoVISpqYcZRtXXaTN6X/Si0I745JuxGSUmwX7wALg2/CbzIrHDq+eSwTm4DsaURyu7tM+QMiYTPusBzRkr5CCSPzNR24Vq7K9VWd06+kbnfTZkSXCGuK8HekSW3X94OuFi9d3in8/AuV46HKcu/nKzXCxeUG1A0T/ug1AYFQSEUR2Kd5E4rIP+0K2/QDE+QGaKcGzLiah2x98jH+QgLT7oDMgFUXDI4hiTid2DHkKzQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB6527.eurprd04.prod.outlook.com (2603:10a6:803:11f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Thu, 19 May
 2022 08:26:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Thu, 19 May 2022
 08:26:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 7/7] selftests/bpf: verify first of struct mptcp_sock
Date: Thu, 19 May 2022 16:25:18 +0800
Message-ID: <214b689e36df96b9c1ee6bdac0209debb5ced855.1652948238.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652948238.git.geliang.tang@suse.com>
References: <cover.1652948238.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:202:2e::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74acd848-6327-4ea0-8c90-08da39713c0c
X-MS-TrafficTypeDiagnostic: VE1PR04MB6527:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB652751591DF849A3B0BDB394F8D09@VE1PR04MB6527.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D3fH+p/aMF9Z2U2/j6kteFvoBjNhuve1k25cewXGYqDFe6/ztqdzFUdoVbG2uZaRVCGU8awjXR6o28dzMouqSf1sNImm6zqhIbfqb9YS/wujG1SLVCaUNPavMcTzbk70J8Zg5vSsWCu2wSjGIv8KXEnOCRU2vEm3amXz2GHMoXJx9pbJ5xArLUtgeeBLMclT3QBhhr0WIqk+w7voXoS/6IJwLWrVgSHVTTEXTcTLKnt3yD4tfPXr44T7O3ij8VUTAoxqauLW4jJwPd+Df0RRdHIvcd7znO0pyOmMsVsJC5zXy1EG3q4TN0T/ticqqRH9Xkkz3NCtAleE9YoSaHojb7XQ9mV/E86NSuDtSSH4xSyXyOAvs8Ps9wi4p0RGmHtPav3I84g8p1IO8/GuHRgodgfa/jWwPBOc5rfKxRqsFUe/NTqk7hPz7dn+lHQsIdqBBJMOfCAbOuz4BD1PDDKODc4N25MhNI3UALyUigc2O4SqH01YWYWh1bR+FzUt1XBaqUycR7vGQMvSqSXzL4NCFFNPrG/LBeT8U5h/izFKZ3sDOUue+tB78zUwulr5XyrlnQZ0r0GC9InA1VDxv68WfhYLcGo2hSSPq5qu4pk91NvSCcMSEvjpaTPUq/BmsPfTGy2og0MZi7WEDfcphd1Oofin+YtcqJ9f5jY00VU6KI9Owmjy00L+CGFIuWATaZA/BM2mSSUYBYnRK5geoPdl9w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(36756003)(186003)(2616005)(44832011)(15650500001)(2906002)(6512007)(6916009)(6506007)(316002)(54906003)(26005)(5660300002)(66946007)(8936002)(66556008)(8676002)(4326008)(38100700002)(6486002)(86362001)(508600001)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bEreOyokoFTqdhVrUYUdkX8QdtSUe7quUbA8DEUQae1zg87+o7v+lRj4N0j+?=
 =?us-ascii?Q?j7mqpK8A28VoIBLh+tgIxf/qstGSZ30+emEh2MVlNzaN0H60am3FPHpjTKdO?=
 =?us-ascii?Q?06BhOSsQ5azVTeuQeEOz/utl4FOjqQZveUiXV6LN+Lx6v84a6ly+6TZ4DU5s?=
 =?us-ascii?Q?7x5LmUZLqbasxBhsWTzgJfIiXDJL0bOIP1YK+I+u41VoNcAQB9hq1U4NKMXq?=
 =?us-ascii?Q?GZJlGLjCvFO239lo1YL0hhc+N+0WCzsDYnWiLwXJQqKlj83ZGxkiOMDIE0KJ?=
 =?us-ascii?Q?lfZHTzmwUPc3Jk/VliGcdIxlikGR8OFT6PM3nmYSmuQ89hXo+19SHgoHIYwL?=
 =?us-ascii?Q?lNY9RdPMfbdqu5mtkyLHS9pSPOSSx9i2YeH7TibpT4cPklGbWKgHIRcn5mo6?=
 =?us-ascii?Q?pPiaHOoWy/0IdnuOwqO5eXku7AzCiqrWZtqTHyzi2zIPH81oKv6rD3XCorzI?=
 =?us-ascii?Q?BI4pTBjIBTalqv0RzvmrEQu3WwocujC9b3vCZ3vU6UO1ITV5UfTLVmLoCut6?=
 =?us-ascii?Q?kzk08RLi765L/O7L1twQaS1HbIojaZqyLys5CLrz+pkLAuXm+kyCHrpauUnI?=
 =?us-ascii?Q?Ah/d+6Ovg6e0xv9212NzcRvnhnpofYg0G/FWsBQOGpMtLBdk/Bgjp+4AWCeb?=
 =?us-ascii?Q?3OOC6NunGwkt+51c1Fk8a22eut8pwZYddIbkwxCRzjN52ZADAkUkfpaBUVQK?=
 =?us-ascii?Q?ooWJv/CdI2EXn6GHw5y6hmOSPE4yRhc/MJoG6nAKLBklD9r0FYPMZAXQPr0S?=
 =?us-ascii?Q?GRsTkuSsyV39HXw8FXGRZsYhfhPCnZK4+ABgkn/FA7RPSwqGEVzvOEIJlxgE?=
 =?us-ascii?Q?trlJvRX4ATaHzjBvYn8D6mDw1ylhhfr4lj73eeCyCevNXQ9JgSYpLCgNeVT2?=
 =?us-ascii?Q?AyUIKoYgsGv3hW6p0L8z2ZSjydMrslJqR3RXqONCh5mHLMgQXIXPuDFkjQ6b?=
 =?us-ascii?Q?dNb/Q3a+mwP0hph6H2FygXNSqGetRLyW8aPMqSBFShGAlfhX30HHLFV5JvUA?=
 =?us-ascii?Q?0ePFDEoSjZ4VuWlgn4ND8gzv3REoXZQqeCjE1WX+k7Dz7jWhxM+VOfpH2qNx?=
 =?us-ascii?Q?vlhN/fgN9ooNdOJGYj5rS6MSeyxvnnnu7gYwMRDsSVVejGpYVJMuNKF3NWbd?=
 =?us-ascii?Q?2JXaIQHLhZ1oXe+pmnbMpclH/Ht9GvRB2kZt8HLrDBwwA0wFhC0s0lTtVOJu?=
 =?us-ascii?Q?1bf41NGXQn4EAAJj/TzoWM4nzBAubnKzrkARs9vdODwfzvR4GIqam3zcNPOR?=
 =?us-ascii?Q?SXdbT0Ugb8GcaFiGynAsqaiH9ZwFAf7lbi/GD1DE0icsJ3WahBxH7Ef7+qIP?=
 =?us-ascii?Q?VD/0VMtHmlcec0NS/IVXnts1eCrJaSjg209M19ChgNBBW5oXx0WdrrhMFIc7?=
 =?us-ascii?Q?Vto6aL6Jz77dGXZ1yYluTedOd4Xi5AZHM185TXr7c8fE1d2RCSeehHuz97D2?=
 =?us-ascii?Q?KxvE75cvZouFpN/5sfLCfU0k5g3mQffi+QFXRzth+D4EaCYXjmbpzXydE22O?=
 =?us-ascii?Q?ChPMpSfg9dfffKo5qgmW7LqVjjP9QSC7KK7BLORmlkxch8pXHjd1wGGi1LcI?=
 =?us-ascii?Q?PIEsvS+gDNDMVQVEXeAYYyfl9x/N0sF62D461ltm9u36AhhRJnrmS34pWnaV?=
 =?us-ascii?Q?YS10spdKkHwxAqexcnx7BKf4CN4eWjQhCExMv70cmLXjCwNYdNxIt5qrofMZ?=
 =?us-ascii?Q?G5oDTw1NLfiporvoMO6esszryu42WZNM6DKnZzNzfp2E7M3n+Vs3rNokgYbE?=
 =?us-ascii?Q?FSqa6cvO8RCxEXJTqEFCzzdcrVzWjAs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74acd848-6327-4ea0-8c90-08da39713c0c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 08:26:13.0701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0oUxxLYcqTQs64T9Jve1kyOEaFj5cc5xv2XvSE5FfWGZwH35zA5VIOYJaMUFKZ/87DS2ceN33mn5AQTtGzkSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6527

This patch verifies the 'first' struct member of struct mptcp_sock, which
points to the first subflow of msk. Save 'sk' in mptcp_storage, and verify
it with 'first' in verify_msk().

v5:
 - Use ASSERT_EQ.

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h  | 1 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 5 +++++
 tools/testing/selftests/bpf/progs/mptcp_sock.c | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index c38c66d5c1e6..82a7c9de95f9 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -234,6 +234,7 @@ struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
 	__u32		token;
+	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 17ad1cb07339..257a8668ad40 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -14,7 +14,9 @@
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	struct sock *sk;
 	__u32 token;
+	struct sock *first;
 	char ca_name[TCP_CA_NAME_MAX];
 };
=20
@@ -80,6 +82,9 @@ static int verify_msk(int map_fd, int client_fd, __u32 to=
ken)
 	if (!ASSERT_EQ(val.token, token, "unexpected token"))
 		err++;
=20
+	if (!ASSERT_EQ(val.first, val.sk, "unexpected first"))
+		err++;
+
 	if (!ASSERT_STRNEQ(val.ca_name, ca_name, TCP_CA_NAME_MAX, "unexpected ca_=
name"))
 		err++;
=20
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing=
/selftests/bpf/progs/mptcp_sock.c
index 6a78e7b754a8..f638cb876424 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -13,7 +13,9 @@ __u32 token =3D 0;
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	struct sock *sk;
 	__u32 token;
+	struct sock *first;
 	char ca_name[TCP_CA_NAME_MAX];
 };
=20
@@ -54,6 +56,7 @@ int _sockops(struct bpf_sock_ops *ctx)
=20
 		storage->token =3D 0;
 		bzero(storage->ca_name, TCP_CA_NAME_MAX);
+		storage->first =3D NULL;
 	} else {
 		msk =3D bpf_skc_to_mptcp_sock(sk);
 		if (!msk)
@@ -66,9 +69,11 @@ int _sockops(struct bpf_sock_ops *ctx)
=20
 		storage->token =3D msk->token;
 		memcpy(storage->ca_name, msk->ca_name, TCP_CA_NAME_MAX);
+		storage->first =3D msk->first;
 	}
 	storage->invoked++;
 	storage->is_mptcp =3D is_mptcp;
+	storage->sk =3D (struct sock *)sk;
=20
 	return 1;
 }
--=20
2.34.1

