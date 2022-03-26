Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13434322E
	for <mptcp@lists.linux.dev>; Sat, 26 Mar 2022 16:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648311911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxecItEqaHRqPkSjaehv012GbF94O1r8zqUsIyHDLyE=;
	b=EsgAHPE0IkJL13Jzldf0qJgYnFBF696/heTM4UixoYx5Z9VfAOke0nbOAJxhEyZsTYASQH
	aw+hzge9/eI0TjsymFdIo32tokBhiQdGvSwV9ca/mhGa7/FiWJyDeectQtEtZ0MVj52kfp
	Lx29nm5YyKT5kvm/1/rI4VrFcEtRFZc=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2054.outbound.protection.outlook.com [104.47.13.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-_l25fbvbNniWqFjl7O1CxA-2; Sat, 26 Mar 2022 17:25:09 +0100
X-MC-Unique: _l25fbvbNniWqFjl7O1CxA-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgiEf3PP+GYzy8OTEOnB0Xsi+bST7HF1v/9uBH3uGY5QMdytaJL61rc5pa7NtxmsCyuKzgQZex8dnuT3ABunf2/D0cveiR80BbM3MzyWNTqvJ1pNYhwGd+OzOAKY7faqQGw+h/81ten8wyLzxmZQ67Oos+Y981cR1gTkQIh1CWBT4/QyZ7/9lOIQYBrWHy1PBpOKLx18unPGofvWsMgsERVtS/DLq0ll3oYq/6R+DpvLGBjCXqqAMHxo3Ml7WuhJuVGBs31uWclVF01JoER+rv/Ftw7OtkR2yqROe8/Ru2PCf1J7NwM0nh7v9cdYls1KcATEbEH8JHzwxEDdUOHJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRIN6lj8uObzTcrzhwJczA2Xp6t2aDarhFeJe1tI99A=;
 b=MjKvQXRnj4yzPNjPZYXBYK1U4qMZ17D+J1Scnag3QPv+sd5IhZxoYRtMj5xmJfsHpmPsmy0wOxWZMGciSiSmcjyaMKMP9Gr+FJbJS8V9g93miughf4IOHAaEuebsW6p655lOZHfH5AiLpZ7Bs9ZJv8916z6Ka3V/ympCYqAJGhRdhdItiFhGyndzhkT2HfEYR6Ruqra2IbF0UXEUeoa8kVt3dJZmw+sgkFRSUp3Qltp9DRuPTuy5AeKFUYB9gmYwMQRINlFHj1LZyWTA1qyNp/lfs+crkHjeURjJVn+m/gRGEf+eFfKxcGFIJKP78dt6Y3tO+PjVwFc6A6eV7ReMaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3067.eurprd04.prod.outlook.com (2603:10a6:7:18::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Sat, 26 Mar
 2022 16:25:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Sat, 26 Mar 2022
 16:25:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 6/6] selftests: bpf: verify first of struct mptcp_sock
Date: Sun, 27 Mar 2022 00:24:33 +0800
Message-ID: <b6ff3d2d672cfd487f19ad7d2c61b65406abe43b.1648311457.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648311457.git.geliang.tang@suse.com>
References: <cover.1648311457.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0175.apcprd02.prod.outlook.com
 (2603:1096:201:21::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcafe986-9ed3-4195-94a6-08da0f4531b1
X-MS-TrafficTypeDiagnostic: HE1PR04MB3067:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB3067CBA58AA1FC9F337562F4F81B9@HE1PR04MB3067.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NB24Uf28bYMKgqXP0qKLNrXvLMoQSu+H4GI4NUyGy6KaqXadOCVFUP5l/12ywjMoflJJlC16Md7V1bxlsimgH0T1GLplQDdy3VZCODZGnk27gbvDvbHBOi7CkunvTUMuKvPO9//6LFyO/Nj3gHFJgx15CCLU/GS7DYSWJi1M7ImZWKPiyxv8LYoftHatIZmgr7qGEqhCBqFeoZXv039o+iExxs7ADVxWh4UXr0BGwc/6i4ASStLj/jN93agbib0ftWqRyFXGi960ZsIF/hFzCzFgOWS8cHfWC9j3J8F4N/6RGdMyh49j2s+AR4i3nthtr/wyPv66Skfd4i/NTN//+nSuMVLGO4eYYv58MyJykXhTgKj0SxfgpklPbFYZxJchImauhXbAa3i1GbPlOGYO6Bh6FxXJUVo/KwfYB8RtV5mEmNReovn9SLybP/0v85srXpdZFxq6lak/opgt+lEYy0MEXqYWtzrkEuxHdNodhUMGLL58HOajb/oXfXasb6zs68/9jvGpt+phy4VVRYI2cUTqqne2y5OfdPG+84eA6ArnbFD5Qi00MnBzEVpesHTyf7fqnHuUcXHZKIb8q7R2zbgbLulIP2vbagF+PiXu7qF3U7BgHHhirbkqyvgHrNuITu0Fp1O/JybBDIlt+3lBO6zcE2VM9/X7wzSGzhA8qBVK434kMYmZBTeiN+iDcZxM6vpQpc8eN1o3cRvHKiDVIA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(5660300002)(66476007)(186003)(107886003)(15650500001)(6512007)(4326008)(8676002)(38100700002)(86362001)(26005)(6506007)(66556008)(8936002)(6916009)(44832011)(36756003)(508600001)(6486002)(83380400001)(6666004)(2616005)(2906002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VZiaJUznVmOM06e4XpkhwwGDWgn0LfaPcVPhIxJFQC/dEJzqqPR1OppQpRQB?=
 =?us-ascii?Q?SA8bSOkKERkk1B4p7MW9RN9bvBe2mj2Zbgq5Kv9i7eHWqvcnz8HdptG9lnkl?=
 =?us-ascii?Q?3sJdeAj8FXKfhCmlYJdAnFXpqCV4v/FyLWFG2FnSkWdlu1Gd6Y2+F4F1Jf3+?=
 =?us-ascii?Q?ibUcoVfIcPEqqGrRXMu7pjvauzzg1rjIfhCuTnzBf/lF8k5xY4/1OnpkEwf+?=
 =?us-ascii?Q?hPexrU8Wi5Dnk+RmWBJ5/xkXP5P+vjVf31Us6JGddBC5W03cRn2Y6QLliXYE?=
 =?us-ascii?Q?IgBBYhLRsNJwS3UWVXYYuMO8fB3dHzvDTAlDhjgWNbW+dFVFkyKYc68qaCo8?=
 =?us-ascii?Q?PCJhanVcPrkWZz+UzAmkXf0lOJAQSyT7v6gVeZeF/Ec12MB2alZeQR5NvbFK?=
 =?us-ascii?Q?hXRx1Kq0KOA9Uj00fHrHc4tD7DUJLtlDYEU00IliUiF/8x74rg8TkEzf23Y6?=
 =?us-ascii?Q?jg1i6jYCpb6rwBfLVG1A3EhT7i+NkxVOISoYDQ1HROuJvkNaLZUvdKdOV5lV?=
 =?us-ascii?Q?m/rhSzvjXmrHbbllC6MOE2vjqHW1fRmImNBo7GjtIIhLbV3WFINZW7azJoqZ?=
 =?us-ascii?Q?ykgs7brSJ1UnSAQlEC7HPiKnRHM/NlbMoyIi2HzfBSZ7mj9KneKisr/HGCIn?=
 =?us-ascii?Q?ozrLjDAlCqeGskcImxc0SE6Nd0g7xrZuPmXUoK4taUl5udtvkjCn4yW0NDSh?=
 =?us-ascii?Q?SBKJpa86VK+DAZ+R1DkGmSCa4WotKBvoi2k8D8agvwG4ZdRamLOWKZC9y7Z/?=
 =?us-ascii?Q?nqlatM+JUF+aivieI0pEon3Zf1efIOExz8EUWB6TzATcoGhWUgTH1PWSwKkX?=
 =?us-ascii?Q?Apg5B40TVmF+zU/lnF4790tD8y2ITKpMFq15BtJFPQWgEZpjC4ypzS6TwUP9?=
 =?us-ascii?Q?uOAs6JKonrfZhTSNj5bRyiPRBNmPYe3HxmdYfcsrE0Qgto9MxJCieTAcAWKy?=
 =?us-ascii?Q?BOWgIuc9/MccBAuui2dKLUEIwEh4GH/DNl2qggr55zY5yimvev5O3U0VuAzU?=
 =?us-ascii?Q?MfqRLTRir4624APftn9OT9s62H1wXQGbJy/Ka+/VAlIExjKjpShaklbIJo0X?=
 =?us-ascii?Q?65pB+94g4c2xxQHzms9K9VuACRqSzeDXbnL+M+W5QlAn0RDaEf0WTFlaVu52?=
 =?us-ascii?Q?ygYrxFItPq/P5Xm5qMeZzG4KWvz+W+6a9inZt9EgCcJlOvvGOdUKOf6g8FG8?=
 =?us-ascii?Q?aGwGlmdT0XpvsEdCWR4tPdUIq8bNzYUpm2AViav4/ZR1Y7BWQuXtAkz3940+?=
 =?us-ascii?Q?U3QsFG5MTSXRIil/mjo76arWKlITbkqt6f8zaHTkHu9vigPzgXtzluYhwjxg?=
 =?us-ascii?Q?kOgGW8+u5IFzLlzftkh7tPjN8QelwJGK0Dk43jd0c/FnRHELnzUDTUOEQeLN?=
 =?us-ascii?Q?16H2nfAZd82VN1GDcckbOMinzAR+/LoW7lRSTGuRKtJuG+G+BPNXq0MxnDHm?=
 =?us-ascii?Q?sUu5JoiyTXvI0RUgR3sFkjGYuHHTaE436rJU2aqP4iJCNYmCSgqaiA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcafe986-9ed3-4195-94a6-08da0f4531b1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2022 16:25:08.9884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r19ytDzGZx40QNuTbuBXQVAYZQ8SFXO62ldP5s/4sCGO7+mjYsyTPlM0p2WrV/JnXjd0sMfYhprcbRP4ElXXJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3067

This patch verifies the 'first' struct member of struct mptcp_sock, which
points to the first subflow of msk. Save 'sk' in mptcp_storage, and verify
it with 'first' in verify_msk().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h  | 1 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 8 ++++++++
 tools/testing/selftests/bpf/progs/mptcp_sock.c | 5 +++++
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
index c6bdd9c5f126..9b73ef62ee74 100644
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
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing=
/selftests/bpf/progs/mptcp_sock.c
index 6e7d2abf6ce3..16055f553f29 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
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

