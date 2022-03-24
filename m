Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710BB1FC0
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 13:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648128545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/iaE+Hkk6uf05n+lA7uOg3Uo1CA+/SZV2VvXmRmo1ns=;
	b=hVDS0JOxUjpE/fYz+rI+6bjU7WMUVi/feMSZOase2WrtHMzbZf9CsNP7/7m91N1IH/qChH
	4obrBxFOcWLBUkxxcd5LtUNfEAQSQU50a7k4ImYBeWzWwpBRtZLox7P/iccEUomZ8IBz2h
	GAB3+UsUSQmo9xHlR/HJVtIv6ItmsKI=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2050.outbound.protection.outlook.com [104.47.6.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-bZSEmwxOP7eIfP5nABblNg-1; Thu, 24 Mar 2022 14:29:04 +0100
X-MC-Unique: bZSEmwxOP7eIfP5nABblNg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njCaRk9GFbRADv/A7BKkh80svA9oUJYuNoZNhg6/aX1CleQ66mfPNM8pnWbkKo4o9AED4xyNv6Mdu+50sJ+2yUsWVVrgmpaGi5q3etSOHqNhTbqVVvI1Ge43HhQuXanK29kBqPeh1nii3FOxcIRG7MyKQhkzb0hp3GlQATWr4mUMprvj6D4o9X07kkBXlg4PoeUHvU4QchVqUuxaFszctB+AMOcZjiGcIKIcwRRHAsuVpRMHHPdeivQg9QNPusE8BlO2I/EiOmw0fZrnDodKynJShZnenvJ3yf4/8Zh1aHiuY1LZHYBpxa7yNUo8kpMoVBnF5Ayo6CEcsY4L2fs67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JG/vG7Drw/ofwsLs5xrO2V/XZXBe64laK4TIdczXt8A=;
 b=E+6TlgdZx07gKQdSEI11jsQbtwx7JgVo3Mb3GrDuOm6HBbER2eDkLX8a71aO7zwrCJ/JxZiRwg3sinqdBl1RjtFfnYjkS7Z4LtfkBNwNM4WhQPUJv8VQf+lVoUbyOKZntgvR2Xly3ZX2Cdwc+wjNFqfjOqhV6HCYl65Pme/ZeQPavsJy18cdWxncVTmuH+AB5emTXsSaO+L1OTwngKAM1BGIGLgE5rnG/+/yb3I8dVQNDjUKqbRyDYlx5IgVXMYN1MJuSFKXRQPlwdulPuRBDTQoIx812DNCAYBSstog7pP/RikNQ7DMx3jCpp9alGKjNIsgBrr2pkFMjq40PzRhUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB2782.eurprd04.prod.outlook.com (2603:10a6:800:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 24 Mar
 2022 13:29:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 13:29:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 5/5] selftests: bpf: verify first subflow of mptcp_sock
Date: Thu, 24 Mar 2022 21:28:32 +0800
Message-ID: <873b153faa28f724668185f9c3aea2c2e4bdc442.1648128255.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648128255.git.geliang.tang@suse.com>
References: <cover.1648128255.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:203:d0::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa372de8-d871-4e13-306b-08da0d9a4314
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2782:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB278293DD67D4E864FAB2315EF8199@VI1PR0402MB2782.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wiyTK7F+g1jkIYA7oEWi+iRf+IKCQjjt0D16tyOwVEcyx17eXa3gl/oxhOLsqZ6sFebnNqv2FWoF9AfaJWBS6guaEY8G+/5g6ZJQoJar2avSqwrlBB4W1e1cEdsbA3GR6Hg732nie5YCF2ywUe7oBR5NsZ6CZdvPIa1QcB5YywPmBfNUId5Axju7s9kPMuHeZ+8LkIlI2CDrU1nJux+TbZ2WvvwBcsWwXpSc+Gg5ld8/NPxVyshx6PBFK+mnbaLeKGbJNgqiNw1CBi0mAyNZ5nd7gPCTtF2/a/qPYxGprPIqJNacbeRPFCs7t7CPzYxiBP6G+9A3+CUi2uvLFYMLBI2kzgxJ1/vM1RxHeLaQfcd1pUC5rpAC4K+Te8QGYmBMtVIOSImptv6S9FaEmaHr5BGY8NdV1HVNNnn3VWI0LHLf9sxAuzyskpbZgyo2nrXphoUzn9WbVqeX3MufpVMTv4bOcd4fpLuDB3rjkDNrLQuDvPNVcf/WbHmIDp1Xq9l/Ns3IpH1e4zBGe6Hw8stba9suwFjoYUrRCjlVzYtRd4CTLDDdPop+XcJnzxr/b6dBVV9QOZ0sVVXrCe10xcho+vq2LjS9eyxkvJXTTgI/bek0uuqtaVHF9fZALGz2yIFfjeFHM6SXv87h40sXU/IYKLSWUSuUMiUgSCBK86YY2dwcnAAFon+YqCM9wIP5+150a0qrGiWCWeMjIuylbmNQXw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(15650500001)(6486002)(508600001)(2906002)(6506007)(44832011)(5660300002)(8936002)(83380400001)(26005)(2616005)(86362001)(186003)(6512007)(38100700002)(316002)(6916009)(107886003)(36756003)(4326008)(8676002)(66476007)(66556008)(66946007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8oUqTFZQJxuCSh1XxWlo/0aCnCbxxGLoWZDcGeSEI3lB/2t1PXjXgdEhYll0?=
 =?us-ascii?Q?xVhBKWNZbLj9ZOnRmtvCrswRldUKXYEwmLkWeBy5ZmpYnRh9Kr+53/8Hw424?=
 =?us-ascii?Q?9BTOGNURwGevAyqmdvujD1A5FRzb3Vy979RnW6Ah4q1MHIR984tCcKAf2iz2?=
 =?us-ascii?Q?ZFBaFJ0YVafADZfGHH0EEPxDn5l/r8s+IusFduSZMJRUbQgFxc80Z34H+Qv9?=
 =?us-ascii?Q?uuZFGXrksKtxeUwasJtyapa6vcIy+8rCJ8b5s70xrsOdoqHjpSBzp/o9XbHL?=
 =?us-ascii?Q?1HacQS4Mz0WBDD80Q69LARei2F79alsA51za2+QHIiGihOuaqdQ0MA4Xc7WK?=
 =?us-ascii?Q?Ttl0KyHjj+0pxHuiuejEroVbeHlPWt7u8LOFFYcIlcAXYVMG7IAIQIRm9rly?=
 =?us-ascii?Q?m9mQ4tV0pbuell7dwq/M7k9lWLH2dw5yuBCPr0RMglAJN+zJqtYExahWFkyN?=
 =?us-ascii?Q?sSsL4tWgGk+k2jYLpC/ugYUUGf6iOp65O3djh8RbfLT7X3L8s6NZgZWD/NgL?=
 =?us-ascii?Q?tG1ATQvpCcmX0pjo0OVdCutrwTpElisEIvPEhlTdd0O/VpvKLdGYc8DysY5p?=
 =?us-ascii?Q?lYLh0WylAfnhFPvpCkRtvXSNGmT5F8Ojiw+468eQmIFoJKb2nWZ4poeQIBnJ?=
 =?us-ascii?Q?RWtcW2hcz/j6v2J7a3dRYfriFyJdawhtPvxF+vHqIRoy9V9VuA0Us+8TjHDf?=
 =?us-ascii?Q?PiJia+0wMoHSAry8DRppfplIO19ypbDAF1IpTkTyH1YFA/ZOomgu0y3OQsDO?=
 =?us-ascii?Q?pNGPPmVK7PjPfLwEJx3xfZEmVUf7HzxJFXTqDr9XOhEE6aIW3yL4ER8kiZgu?=
 =?us-ascii?Q?ycCOicIi1PvOMba8netDINJ9312Ck3wxCC41CywH36H7I4vSc0oRl1CwNkO9?=
 =?us-ascii?Q?JJr1kV7sKlSzpQlxuzHseKphSjXN4Woj23YkaUqhr1RQNsLZbFHITqK9e0ZW?=
 =?us-ascii?Q?zhD3QEkyIqergYhn/fJDD6P9uqI8Y7zmjMh2Y67fF6h8oVc3Bp7kkECBeS/F?=
 =?us-ascii?Q?uZKs1nGRWKlZwXPS2AAt5lGEGuY4mVsUfcEJUcsvRffHvecmmUCpve5aqkFf?=
 =?us-ascii?Q?TUL/u4TkIRvssDImx84mneFaPHKy2b+aYloTrfPg37eyl6pltoGefJUHMAeF?=
 =?us-ascii?Q?+mK/WNf6TITDXskdsnv79PBlEAJ8YS//BISgF8ff27WyIjnkiHlyyVGN84J5?=
 =?us-ascii?Q?ej4xUgi7jYke4TKkVCgLhNNB+gz2DueuL77G5J1mkR7vssgmIUcHmtVctWyV?=
 =?us-ascii?Q?9piluhPMVwlvhtSl9ZDrsctQUMARwUDsci09HMeEiv/OQA2MvCJLy7bJN5OR?=
 =?us-ascii?Q?Z7/SyzPA4T7IYgNRftrij9DaWxd/bF2gglTRWXm5wwUUAgdMbeLhqgpR4CYU?=
 =?us-ascii?Q?df39T5e/WVumS397V6tWiCs6xt2vPSgCDtzigTVRFESiCpK3e0TObc8HBAE5?=
 =?us-ascii?Q?qUEpKtuTI5YJWjsgC/P5f5aCgCIv24LnAjpTPx7jRBX/wXF/LY0A/AuwBMaL?=
 =?us-ascii?Q?eePr01R5R6m3mCZ+iQfZQTiNrjfjwaq9vh3gWTs2a661oGhNWXg4GU+zlryI?=
 =?us-ascii?Q?4KXclzNfCJ6eXhPyZsn/WFDVhDleKdISAqa0Qlt7gM/QSQJZqSsTw0Y2+VcA?=
 =?us-ascii?Q?NZ30D2JikJ9rPMoW2CRa9IyjSlBX1Q9J6ctmj5VOWqHFi48UxAqOy25BKkx+?=
 =?us-ascii?Q?uZQsw1KOu6NC/FF0BxNOzmO+aORD6AYZ5x58DLsKO8MV3/QMurSMxNckTXM+?=
 =?us-ascii?Q?Yw+IKAN84Uda2z4yWhO4rZwvLPUdhNE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa372de8-d871-4e13-306b-08da0d9a4314
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 13:29:02.9273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLxNmeR+X2yc/BrsORZNhoI0Y3mNp5GHAbJu+y8vQRb7PgSRjZccsHV8l9vxWtQ16o9LPzpKtSOqUCbbHSqZeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2782

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
index 32425f9cd76c..b7c230c4efef 100644
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
@@ -133,6 +135,12 @@ static int verify_msk(int map_fd, int client_fd)
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

