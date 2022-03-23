Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF741391
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 09:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648026626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5J+JFDW3WmFk98WOz0b7CH7PthXG0CMVIbFQUIdGG8s=;
	b=IyejDQi1xyYspPoDpj5hRbMTytlnH6DvDt1EMAdPmKJW0/Zx7tCYh0o+Q0Cb5t/GX8wwy5
	O2by/3DD5gpDedny+PLJTXuBLeDygFzrcx4BiFx5bbDvc6LZ/PS94mnL7HD3uC7FgFTOpf
	A5L7Xod+Y+a5ldrUv0fa9H4ouBD4zhw=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2051.outbound.protection.outlook.com [104.47.8.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-t_Xp6qgHMbuHvxXKsgDG5A-2; Wed, 23 Mar 2022 10:10:25 +0100
X-MC-Unique: t_Xp6qgHMbuHvxXKsgDG5A-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5r9ZY90BV74x/keEUzajfrIpyGYei7TYqRtzbnNSbfEwcu9CtCFdVEtKyQ2YQcRRRxB6MH8o7TFmIUMU5s5kRfxiekmzyy64Iki9jNEQTYvHr50mqGmOvwBFf1q4z/4mzF5/gro+NauPKKQU3JuMooErbuOu7+PaypIbo28+tNWznE50VhTiRwpQt7bCSlv1C8c8JKad4f8cpbaQgKSXb8wdR2qlTuUTELOzrBrvm//DdCHLVklToCXJss36UBI3RhSExhqdKrZPGUOcLgFut+mpVNF04kCSFEPRYzwMtKXWEOeWhCyx0xT/RavzO83DrEEA3nQAgP5bf0MUGjeGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83wldo4NvyFFdfuIqxXUODeEETaJzNgry/zifs9EHgI=;
 b=QXw2Cn8iZkoJ8ItIlUt+qvlo0LDAs9rYB+4x1K0X9nSZ+Wg3tl6iB8yW5JxBWsi0aDAUZ3IO/MJ7tbo2I1TCh8jRuFq5C4kOrlAgPkO9sonBPVOq8YPLknKxwU3DhTMng9bP0ELzOxuHnpfAB139h/727cSAz5wGXvOWvuPrC1UzN29qjcXbjAfyuIjzwKcBJsLx4hseWQFELN5df2CBDm8qtzAwl6A23ooGrzIx0ZkjEtV73NXmnLnzk3yxXURe2LntktLFSFH5+DpyHr6k90kGR/vpsR3JCmbI8iGh3qI7LSf2MaZiDr/qqGblBbqoXCfrXsLA666FvsV4DUUCPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5988.eurprd04.prod.outlook.com (2603:10a6:208:11b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 09:10:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 09:10:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 7/7] selftests: bpf: verify first subflow of mptcp_sock
Date: Wed, 23 Mar 2022 17:09:36 +0800
Message-ID: <7cf799d1eb99a9e552fc337ab2791f1c64ef00c3.1648025308.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648025307.git.geliang.tang@suse.com>
References: <cover.1648025307.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0178.apcprd02.prod.outlook.com
 (2603:1096:201:21::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3a99024-5c64-4bb8-5314-08da0cacf6fc
X-MS-TrafficTypeDiagnostic: AM0PR04MB5988:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5988896A9D59B0A13F488F94F8189@AM0PR04MB5988.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Quc/t/ob9SED/DlYAECOwBizZpI58KuphbhCl9DrToXAatOrv/gDYAsP+VTzaF9xIxl7u6k7dxbql2McFxjhyWaiJE42VjyCxAYxIwLmBTix1baOsR3irI56Z9lNHwPupZLqxlfV20LelCxoUSsb8F03FZhLuErW37ijvjs0Vo9lVYqsdf+Ke73CHnYALchVpHqSknOpqO7gtU1Y5d+RisV8buFVc2mT2o9+9PrBjCMAsGtc1JNJXIm8UQkVT5UdWtq7XwPmRQhUcTDBmM2QTSwuxMDtc+GKfrJQ1QTavQfczfK05WoQlGsJag2s8fF0s6tgIgk4sICc6cMYCiW7OTpVi8ig92CWnets7FsFa/w7eZJd3YZXAp/dQrEEzK/nVfkrEfh68hTF+RBYC0QL5T7q5aNuYnCw9aW5Rhr6nIxwXxudM2tcswnBH/v0uaFEWj9bKIjCI5fVGwWVegi7UyKmuTgO+FmCZRIQSXh6VfRRqj15WrYXLAAc6DjZYYDCPB0YihmLz/vEXa0OWB1QZ7lIXBaUaf5xk6WcmIeRhXmdotfcWkssjHDJ67bwNerbrEF13SMIpv4dDvF44kx/R5rrSpVPYLfB6YoEnzz4dCpAQYKOeL51oKeeczdhnKLWLIyUN8znE2RzCe1Ie4B6W2+pv4ZwLYMGuHTh5rfapcw1FasoB+ABTucA1mmgAxkYEl+f85FKtYK9NJmheu6jcQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6666004)(6512007)(6506007)(508600001)(36756003)(38100700002)(6916009)(86362001)(6486002)(316002)(66946007)(15650500001)(26005)(186003)(4326008)(2906002)(66476007)(8676002)(2616005)(107886003)(5660300002)(44832011)(8936002)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7gK7odQfjM9FOGB9ffkGPTSstVszhJ/9z8Zv9qJmog30NlP417kCXvm2AxMn?=
 =?us-ascii?Q?Yz5ljl0WBSaXmI6QHXo5ZsC/NMTpMihw6bypzrCzBcRS9eUpVwVJCtOnTg1Y?=
 =?us-ascii?Q?hS9Q9rVwvfF20QRNlmgmvkLJ3g/Rkvxan3Ord6cj4i+U1SvOUNfTU0io16Og?=
 =?us-ascii?Q?BSvHNTSeOQkmEiy/Q0Y/dRuoeH11gOLtORo1YidhblvTbNO/nwb+t9I2m4k7?=
 =?us-ascii?Q?DarERRKD77ZhCf1wZUzV1VoVr/WQ/tYtAH3CVR0kQFWvVS7DCFQ3BmXwbMxB?=
 =?us-ascii?Q?maYUT6HtvMLcUq7vKrCg+lxywM54phIFdggrt+MJ/yA4tjDxMft3vFd78P8P?=
 =?us-ascii?Q?S832Al5SryW+alJWHRtyp2CQRmyIUz7VC+duGWDof5YrneJmXOolEXi3Yyns?=
 =?us-ascii?Q?NUW0M9aQBDUfv1lD8p7E81l70RsKJ14hRPKp/7MBEXIPVQ3ur/ELHNTxmp6R?=
 =?us-ascii?Q?zcIffYOscEf45CvZTUTY8i2tdad3XopCPe/Fd58UOVhrBqqGftYJpUYTl2LX?=
 =?us-ascii?Q?nnpdEesH08uDLW/JAzthssFCp7w/Qt7NXXWyKpV/8kSo3C+SbhWFHV4g4LLi?=
 =?us-ascii?Q?4aIo+Y2J1ai5CVIE3tY8f+X5S/DwoBPulW05LEg3xkWRDYZNGyoPklt+Nq9C?=
 =?us-ascii?Q?e/eImVqJy52YkAKre1Dvz4NG5HCBPgJkc5VRDP+j5Q2sCf7rKpvIjvwEyZkY?=
 =?us-ascii?Q?WXacBCYfjwcicBE2XMmwVfusmzG8rhfmLBmihfwnHA08oNTSsT5Ue34BrQrj?=
 =?us-ascii?Q?68yOMkPsmh6T/igqOx9wGxuEadknlTw87nvHSaacsqdvhXIfh+JnZIaC7THu?=
 =?us-ascii?Q?fcjonMcL1hK5xocfawWHgbbS3JktOiZ10BbfMNZg4+6u+C97ZlpV5W2FC6CU?=
 =?us-ascii?Q?SdZ6rHYjncscZnZ6tJ88NI4vuX1g1ZfPepUZB7IIYQguX0NY1Q56VZ+Y6L5o?=
 =?us-ascii?Q?tXLwgEg8Tzc3nYjycbxnrYuSlGoGEoLu9RS7XseLru5IllPdP+zhLSOkyyL5?=
 =?us-ascii?Q?FUK0JxWwKodtuBSI/JC1tswPRLlzlCxh9FRA668K+BYL6lSlgQoVgRmo9iC2?=
 =?us-ascii?Q?CAhxMAFoCwbGGjw4megAXSM0r5hwx8kZgsQN1q0RGx9Wb5tR536Rts5DgZmw?=
 =?us-ascii?Q?OSyB7rULnYDpAS5XziCunu6JZR9Ol/sjTcYx+GvBEHly4NuvT0hjDLRqNU+y?=
 =?us-ascii?Q?NSumR0OCtJYC7NgVql4sVPEbvUZKLe88Ar01r6yRJflGXg5wKjG+evY0GRTU?=
 =?us-ascii?Q?E+UE+JP9P7zU6FNcfgG7Gv4gw89MPvFNmVt/e3t5f5H8aalXgHCG+aQs0cN3?=
 =?us-ascii?Q?Ctn8FePfSoF/J3HxDxwTTwJI0AIJxwLyy7DlJ/QUZvwU9L7xNItOjYJbIXgE?=
 =?us-ascii?Q?0IcyVQ9oJUKLa8Oejq4FtZp3r/i7zcRm9rZVN9FqIEa7y+rVERj3iv9ojE6l?=
 =?us-ascii?Q?36CQHIHuTrNN8lrpWksW/QuHGbiKQ9vJOBzMHhwik/qUip0Jv4ucjg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a99024-5c64-4bb8-5314-08da0cacf6fc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:10:24.6642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLrT+UlEhlptvxfOI+XOfp6QO7AoYnxoqVs1VwJiHt5wCGKf2d50rb9ur/IRe96FHGKVLy/bzCIRCGOmikcCGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5988

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
index 0f8ced3845c9..325f8b51f621 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -12,7 +12,9 @@
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	struct sock *sk;
 	__u32 token;
+	struct sock *first;
 	char ca_name[TCP_CA_NAME_MAX];
 };
=20
@@ -134,6 +136,12 @@ static int verify_msk(int map_fd, int client_fd)
 		err++;
 	}
=20
+	if (val.first !=3D val.sk) {
+		log_err("Unexpected mptcp_sock.first %p !=3D %p",
+			val.first, val.sk);
+		err++;
+	}
+
 	if (strncmp(val.ca_name, ca_name, TCP_CA_NAME_MAX)) {
 		log_err("Unexpected mptcp_sock.ca_name %s !=3D %s",
 			val.ca_name, ca_name);
diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/self=
tests/bpf/progs/mptcp.c
index 6e7d2abf6ce3..16055f553f29 100644
--- a/tools/testing/selftests/bpf/progs/mptcp.c
+++ b/tools/testing/selftests/bpf/progs/mptcp.c
@@ -12,7 +12,9 @@ __u32 _version SEC("version") =3D 1;
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	struct sock *sk;
 	__u32 token;
+	struct sock *first;
 	char ca_name[TCP_CA_NAME_MAX];
 };
=20
@@ -51,6 +53,7 @@ int _sockops(struct bpf_sock_ops *ctx)
=20
 		storage->token =3D 0;
 		bzero(storage->ca_name, TCP_CA_NAME_MAX);
+		storage->first =3D NULL;
 	} else {
 		msk =3D bpf_skc_to_mptcp_sock(sk);
 		if (!msk)
@@ -63,9 +66,11 @@ int _sockops(struct bpf_sock_ops *ctx)
=20
 		storage->token =3D msk->token;
 		memcpy(storage->ca_name, msk->ca_name, TCP_CA_NAME_MAX);
+		storage->first =3D msk->first;
 	}
 	storage->invoked++;
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
+	storage->sk =3D (struct sock *)sk;
=20
 	return 1;
 }
--=20
2.34.1

