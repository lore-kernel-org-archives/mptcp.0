Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADD233D3
	for <mptcp@lists.linux.dev>; Sun, 20 Mar 2022 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647784540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RK7cm3H/SBDHltZ+tru+BOeQWl/ZaEs4hYi1mE82ecc=;
	b=VF6upuWPzrBM0xki7jX9ZuWJytMD5yuqLDESnhSJL166B9A79Bo7GJPaqzr7Lbq5bbWAMe
	VNW5whnlDDLkvFDjZg4o7Ujkymhppi8gQTZvr70lWnN1VLV5mfwx6Y5H0SEtjCXkwk4bmq
	d1yZvR5fm5MYHD0KXN6H9T+8Sc5YsR4=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2057.outbound.protection.outlook.com [104.47.8.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-g3TGXexeMIibkbaLlWnqAg-1; Sun, 20 Mar 2022 14:55:39 +0100
X-MC-Unique: g3TGXexeMIibkbaLlWnqAg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSeO44OZCEiKTx4XiTeQNxFRAdKxjTErOXDffENQnIZrMQpqx4sZBXbSOQPRRl+FTq7/DBcdVnjRZBpBYVRiI+7VWjRM+DSlymH2aAHDA4DV+4CUGMZR7OaR2fp17rfyfGWcxtkez2gr840jfRDJ15555kQzYwiiEMRh6fKbM/9xvuiZlHbjlR6tnAGRki2bYV0fmcUBPPJowseQ4cESdIVVW2z+qjRphaPUB06JRxv5vvGVW/O3FLtyRxRqxEW7nKbBiUAj4LW9PrHFeqG6CZ6lVq8GZGqT6nLKu2SdAqxP+aGJGgVNOAzDPhhBucHPJKWyzROvgVRtoUV6Qy/cpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mo9QNc9etpu2tjlfMxmgJASLNliQGq43rMOouD90sc4=;
 b=TcaZo8WSNDRslWjbMUAUUGA7z79bRi3YMyWe29KXOTnQxIPbhqh4jwePkueZXkq7RoOnDnP+MveL7N0XzgvB+JtcPwiekMl207Z4+oPThufiZxRkHU2nyQT3V16ePiEytF7fBC1SA4fenEYTuIEs4UdMngg90x2siXDC2X6xFsEw9biHjTcNvJcUM0HGgkJysf/iL9TTgGmAgHiK1a0zg0yI1i6rBmuaPqG/uYo655j9NaRmsGZizCKVOovrGNe5wZyeIUZgbHcDh7gK793L9/P/91QUDR7hlTIH4c1inNmzOBoHmyM7WKTbc61Sf+ivdKsp2LE9eVW+JKQGaOP4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4558.eurprd04.prod.outlook.com (2603:10a6:803:6f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Sun, 20 Mar
 2022 13:55:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 13:55:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/3] selftests: bpf: verify first subflow of mptcp_sock
Date: Sun, 20 Mar 2022 21:55:11 +0800
Message-ID: <742b69b5863afd354a4bba013363935f6d7f5a33.1647783989.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647783989.git.geliang.tang@suse.com>
References: <cover.1647783989.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0024.apcprd04.prod.outlook.com
 (2603:1096:202:2::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef0f5256-a979-42e8-2b93-08da0a794fc4
X-MS-TrafficTypeDiagnostic: VI1PR04MB4558:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB45580C312F405464F707126DF8159@VI1PR04MB4558.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E360pD8Et2rWv8dfEgJ1vFJbXmj8L3A5hoKzIjKYko5Tdy9qaUJ441w6CeuV3//NfIM4yVXVrZO2D8qyzefJ9gB7xl15bfIOdtiP7nq3F7EWseEw8H6hbFfRshRnLuEyH9ecQaZnUDySfQ4nvNbJXZM++rnhR72RCf7R66MvBVKMi64T0tSvX+3hKxplLn/xNSkRpE1Z/cVIIRFQ0o8dZlf3HlZpBE2ApjLeGa9BRNXTqfo2wvJvLQiIJ814fkyuzWCZXdS/U+E79HO9xc09nqqqZRTBnO0nw1VYVULxOJ9IxbfqciJsEFTlvD5DfntCFASDuYY8MK//bm55noDOFjI9mOqalugkxZA4aSuNDb8MB9Nk6LiYMkLtpifov9XDB5J6pQjxv6UP2agHiZdHCTCK5t8ECP69AaVQYfRA4Qmdjos5OaHoj54XfmFaBtIDV5mj+1dFbuhA+KIBarNbO1OvxLANWfOm/yFfgkkrWwKrbL0edKa4cfH/FyHbPcAdxjfRQ4Qq8lfE0NoZptxEn/7j3BkgKU7WlZCCHSuCRVI4QAL1QZSCE9UgXY0RMjH2Rpjvm2M+ANXHR9yqHOrMJK62+EzU5gfqwRvaHJxj1xFim8EY39QeMM75nzxNrw3p5LLB+lpA0EcuLsblLMARKB5YkSgJ3H3k0aFfszN/auU11lTiuytJl3FrpE8ysoQr1WPmSj7vnRUbelUw+gjbeA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(15650500001)(6916009)(5660300002)(316002)(26005)(186003)(6486002)(6506007)(38100700002)(44832011)(86362001)(107886003)(6512007)(6666004)(2906002)(508600001)(8676002)(36756003)(4326008)(2616005)(8936002)(66946007)(66476007)(66556008)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JzKGm40EYyWPKOy+s8vNZOY6h8IKjjtidaz1mMGja6Gu7gh+x4DnVZ0n6+sy?=
 =?us-ascii?Q?fH8lDjcKAT+qdD/RNzzcWia1uZ6S/fyTbReo8qRHgTqDahOudeoIdgEYrJng?=
 =?us-ascii?Q?mGp3oJ58tSS/DN8rb23ZMh1A62h9DbOA8qvA1eQaxHG1WcFyVKUHVw/5xQPE?=
 =?us-ascii?Q?0tX5I6UjhlCTNGvqI3NYnIPQHQvewsCgYySCbWTFpEJ5qr8XdUQooR3b+MKp?=
 =?us-ascii?Q?Zh7GuSIGzKbi4ED31BU3ycwNbJKQwyQY3kwypzBOJ/anHgLyp72dojpOBON8?=
 =?us-ascii?Q?YRwtImnkjbz5s8xWGV+nlavW9daC+nz4RhZJD9KGV+eKJg5nnvLDBFQ7JJOY?=
 =?us-ascii?Q?mX09YeLdyy1KddsKilxy3aynyBB79krS+lZePxQvjqSsMZ86cfBu+7yl7fA/?=
 =?us-ascii?Q?gbvSwnJE5BuIc9XzH2+lmMUomhKTo6YtJAQnzrXCDEjP8QyUn2Yb8dByVtTs?=
 =?us-ascii?Q?iEc11DoDKPsl9hZGgBhir1vgTzFT6tKSQ+50qiyYApzPAGWHqNRzeYnjocRU?=
 =?us-ascii?Q?V5kKjqw8K7im5+EXu02VrzPiYvJy0Gv6X9vyn1DCOsS0Mpqrqu5Q6Xzio50Z?=
 =?us-ascii?Q?kAel2Q1xR8voNCXEq7LS0Bj/IVud0yS2QpAIHJoiiywYCq9qwJ/+s2Xezczs?=
 =?us-ascii?Q?lvzAdn86PljidFoT8mC0+4Dfdb9J8fkqJolyQFsXwbB9ipzmjhbDAuBLnErT?=
 =?us-ascii?Q?7rgRbRkdfiTi0HyGV1/GBp6lEORZ6SsVx1dZsxpwyMoz6k9PL7ocgnRX3t+w?=
 =?us-ascii?Q?AKnTAvxQKWadO83o/yxfolekDl2JVJdCMrwC/u3lFjMNef6UOcDXnHilS6o9?=
 =?us-ascii?Q?/jM9e12V3MmYb/GQB0unZ/yIQ/atn+qSjjpicQCrDQOumySHtOJYysYekgfC?=
 =?us-ascii?Q?u9AftzHwXwMZgboeNaBfk8PjILGSgEB8/Jp6lhEd1quUTJHiRvcoy6fLQ9aY?=
 =?us-ascii?Q?Kedlol5dnKml9OjSFy8WrhBVoxqSO19OqOlsfAaLLwNGAh360OPQrh1ZYAwy?=
 =?us-ascii?Q?i3jAWdMIGPhvf1JMOJu5ScO154raBYYW9K4ivLi2nRMaVeLIRbRdCLVu/VLU?=
 =?us-ascii?Q?kWjXSJhR6ghEy2hh1egHwuH8n5z+vwMlgHVatri2tPAoClGIpqALPAbz6w30?=
 =?us-ascii?Q?ViZj837kucsprftu/1O5kdm6oXkGdn6w9smslvKy6U3f1F4gMenui2gCJBQi?=
 =?us-ascii?Q?6tIxzI/l3x1FOKwlNIfAB9jxKMc1M0ni7NZHtVGVqJGqtaoomGNzDuYQlTQC?=
 =?us-ascii?Q?kNdXscWzqgIPvu7v752sZ8cYH3phtiJqFv6meJef5GBl7A+k37ZAvMG+zXuP?=
 =?us-ascii?Q?vztoq/8z/BAuJ+g4QBZIzlEZtj8dAwWtw+hY2hvaJwmwbRFW4Cvq4ddq7YQ4?=
 =?us-ascii?Q?hkIJoypxAh9++2fVZuelCmLIUB8NCWA/NcNe6qquAwvT22VvyXLg1IcbIQD/?=
 =?us-ascii?Q?zX2Q9XkKiEut6Stc5O75CY/paUS0BVwwPBJF/QjIu9HEgThXRH3F5g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0f5256-a979-42e8-2b93-08da0a794fc4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 13:55:37.3016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYufv0So8wL/dViOVIv5ZaI4qtwUHHnl6fWAcJlSs9P4gshTsmItH+nvqZ3gfFCxjVBZXWmbhd0Hj4gS1cOueA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4558

This patch verified the 'first' struct member of struct mptcp_sock, which
pointed to the first subflow of msk. Saved 'sk' in mptcp_storage, and
verified it with 'first' in verify_msk().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h  | 1 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 8 ++++++++
 tools/testing/selftests/bpf/progs/mptcp.c      | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index bebe382bcc7a..f92357597e63 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -91,6 +91,7 @@ struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
 	__u32		token;
+	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index d2941fbc686c..030188b8b13c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -14,7 +14,9 @@ char monitor_log_path[64];
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	struct sock *sk;
 	__u32 token;
+	struct sock *first;
 	char ca_name[TCP_CA_NAME_MAX];
 };
=20
@@ -140,6 +142,12 @@ static int verify_msk(int map_fd, int client_fd)
 		err++;
 	}
=20
+	if (val.first !=3D val.sk) {
+		log_err("Unexpected mptcp_sock.first %p !=3D %p",
+			val.first, val.sk);
+		err++;
+	}
+
 	if (strncmp(val.ca_name, ca_name, strlen(val.ca_name))) {
 		log_err("Unexpected mptcp_sock.ca_name %s !=3D %s",
 			val.ca_name, ca_name);
diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/self=
tests/bpf/progs/mptcp.c
index 99718f20c5f8..ec3fde560e29 100644
--- a/tools/testing/selftests/bpf/progs/mptcp.c
+++ b/tools/testing/selftests/bpf/progs/mptcp.c
@@ -10,7 +10,9 @@ __u32 _version SEC("version") =3D 1;
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	struct sock *sk;
 	__u32 token;
+	struct sock *first;
 	char ca_name[TCP_CA_NAME_MAX];
 };
=20
@@ -50,6 +52,7 @@ int _sockops(struct bpf_sock_ops *ctx)
=20
 		storage->token =3D 0;
 		bzero(storage->ca_name, TCP_CA_NAME_MAX);
+		storage->first =3D NULL;
 	} else {
 		msk =3D bpf_skc_to_mptcp_sock(sk);
 		if (!msk)
@@ -62,9 +65,11 @@ int _sockops(struct bpf_sock_ops *ctx)
=20
 		storage->token =3D msk->token;
 		memcpy(storage->ca_name, msk->ca_name, TCP_CA_NAME_MAX);
+		storage->first =3D msk->first;
 	}
 	storage->invoked++;
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
+	storage->sk =3D (struct sock *)sk;
 	bpf_trace_printk(fmt, sizeof(fmt),
 			 storage->invoked, storage->is_mptcp, storage->token);
=20
--=20
2.34.1

