Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139F715B4
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 03:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652240432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tu235g8IKJ0G4DD1eVUxgajDzMCkYQ6WvGC+CcZhN6w=;
	b=Yk1bAhWJJheLMRbFZ4OD+9v3lOKPQdO1zs67WxoZPVJldODQMBLZ66ZAeAi2UTQYCTrbgO
	RfnTJ1rwznInlGTNBSjSLm6cg6YfztSfJnks+NYeHoQA7aDwCmhYxiPQYE8rJdqw8KdZPC
	t7kbjybWSSiLyUjXy9obTV+cDU2r2O4=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-RlxQJaeuO1umQANbflClVw-1; Wed, 11 May 2022 05:40:31 +0200
X-MC-Unique: RlxQJaeuO1umQANbflClVw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxECshCNiVdPbLhsVGsIWaDHcQ+BOVB5og9uGMTNSgD40AXbkr9WPbFhwMTTfP5F6MBM5NQmBCqyM9q8+GFXVe5ZXA5st4dwnCscfj7/lisfy16MkfENfBghp5qxoLDKRNkWuQyQEUL+yCH3KivWOVkU4uuomBPF7Pn853t6B5U94xvXfHFx40oqGoFhGTFNq3AaW8Jur3qmD7SbvEfGx2L+SQ5BwPQNlkCQusFsn+yDTvsRzhaKUEtQnveyAgloWpdqFjCG2yfNANsMSkt+bQ/pmSTwC95sHHkhc07oKy0+W2m6qRhhepa9cSqjHnA7cSg9+2J5tGTeS6V1flAG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/07qtSQrkARiXUKIBKQDzFegku/tzjLCEH3k8JCFzY=;
 b=b3HUUFhip1TFglCo7FugiosGEf2g8L2nK4ite6S9APr6dV7aAsSjitpdvGgpBzVHcUbgkPsxvZU1LjghFGg1aef60OMKv7cO5hb73tmqtlnPbi+W/o0O7JRGzedtsRb76Dwr3NYVKjM44xDlB31pFIrY4tVWxgrpJL15DwH3NT5INoDh1tLQfWHjyOGv5+jfmDVwGNMrXiXb9zxW3Dt28GGpLQKbdbJnIVSK2jDbfu4+S2o1LW4XAdWH1kZlLPr91EWcXrkv6tQc+RTdAi75NYT7oOt6MeXX+7u3/Ad8dxXJ0O2r1f0tAOmqVYIkm60jcXbX4yzWfoDC2EwQQ4UqnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Wed, 11 May
 2022 03:40:30 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 03:40:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 08/15] selftests/bpf: verify first of struct mptcp_sock
Date: Wed, 11 May 2022 11:39:09 +0800
Message-ID: <eca59e999837fd26d938de2a3e2365220590e497.1652239604.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652239604.git.geliang.tang@suse.com>
References: <cover.1652239604.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0021.apcprd06.prod.outlook.com
 (2603:1096:202:2e::33) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7dcd027-951f-4588-68bd-08da32fffee8
X-MS-TrafficTypeDiagnostic: AM0PR04MB7156:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB7156BAE6942A08E9D9AF3B56F8C89@AM0PR04MB7156.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qyB3DEXnr7EDD/e8qExuu9HGrIrSacGpG27g1IvRJpMndH2n8chJpp5cpmu/Pcp4OlPlGsUeKjcJsmlS/NClAg/OXnMS5H8A1KU5sXa0aQDq4UEFpinnJ5FtctY6967XK4J4Iz9MQ135flahDg6xHCtyzpYADXSqa7OlqYyDsg8R5CsvnEuHa3RjWY5EZu5/2BAvt3lwmB4h4KhrXKR0pcQTYhx/Y97d7alpmUo7xd1jZ4iLKP7qwWfzFxJs9pUlVrIZWVDdeBczLyGua9mSIIud9Q0Bgggtf07PtPhpafPQNDVQIlme6amNbRlwCplkFmgTQw62pBHWVrrKpAJpuEFOtghSwOYTkq1Rk+6Us5fFfnm95TxmiIrX4kV1q8pGEcElL6XzbIIrIwpmC9DtkcP3X8xFsaRYxYQOWNpRGXmQN8xCJQMizQLA9OhGV416IsPmHow3w5q1Sw6KZ+8NZScGDxpXLKHSpceJngwXJj9NgZ6/SBUFgYAtIUlVeHCWcTVMozrzK2sk5ZL0e8hdd3Xp1Gc/r0IU5hNhrfspW9i9R4rDOrR70hTYABWj/UxLz30ecNgLasB3hRdsL06HDxN9wn+//oTnurgy6wj8EwPOrTL/ue8oFrDgL1JE+hbQmrMSVHnROs/xv+2L7LXuWe6bXRIr3+/ZVBAD03chiwTEFut6E62SsOJp9rqHEUcp5s/qh5o/08xC8SsfVCM06Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(86362001)(5660300002)(4326008)(2616005)(6486002)(66476007)(8676002)(8936002)(6506007)(66556008)(38100700002)(6916009)(6666004)(66946007)(54906003)(316002)(508600001)(15650500001)(36756003)(2906002)(44832011)(83380400001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/FyVu1LdpZ1pQT6cxmsD8F0YxSjLicG5WkvrBhvKriUamo/7JSpKW7u38cjc?=
 =?us-ascii?Q?RKBJFEtcqABtwUgX4CaG3WpZoMlSwiTRWgEauyj54lzo/WxnQ8W8mDx1aY/v?=
 =?us-ascii?Q?GKz/p4i7YCCk3BzQWAiZN8xhfLHaZi8FNJstoUdrrJn4QaywveK1bq8H0pgW?=
 =?us-ascii?Q?Lx8Rglrxr0+gxGIVP372/ZkRzGuHlghr4dRwYXEEz/KoJ+WWQOsVlm3VUEkU?=
 =?us-ascii?Q?X8Fl2/kPnYu/bU8h6cHsrcziFzPitQpafOk2gwjvnZj++IuWjGGISrgO2vGy?=
 =?us-ascii?Q?e1+JpKbhwQdhacs+/HAt+sH3UrIiuZ3218GrU2qwfqRUGw5dMi3kkz2rPXH/?=
 =?us-ascii?Q?quh9BuCa3sVBpkmkObDeGh7QbFyaZx4IINiX6Q2h5ZuMTEcjLSBkbXHn4gqd?=
 =?us-ascii?Q?Pa279nbcsaqLOxBOt5Sztj7JMPbOixfyG/YstzWUEnj3z6oeQIGhtEMWDNUP?=
 =?us-ascii?Q?GlZFMoRdDeSVGZw1NUYyhiShEfVLPTpwi7ipPp6KyM5MB0td2eRIt4EDDswC?=
 =?us-ascii?Q?KQgXzVMVPmDPR/4VzMFCjvmpiv6IeacwZ/wvTrNPIjabywaOl6pYJE/nnevL?=
 =?us-ascii?Q?mS3H2e5/1AzFBXR8g4Hn1aucaF7N1d0lZzNpNkbYycxzvhJwWfsFUhrpsPSf?=
 =?us-ascii?Q?LbAgVJHdAGheMWc1QFb0v9sDzzEoMph6XxOEDtnq+zEHW1zljIwT+v358htY?=
 =?us-ascii?Q?DKlPjAx+or59zcuxVbm6HYelVPGZKW3v3Soh7N+LuiEbqcIEPAXVIjnZtQmM?=
 =?us-ascii?Q?HSWzrv/Xw6UWdCRAywAca8hZ+t8HKz+NnlY6kndl7hupFEkxVU64rd5r6tgk?=
 =?us-ascii?Q?9zaxZZB/n1WOaNdS6ljRaaGkYhH8EoY+Jvbzk8XKf86r/4nYX2HJfOZeIROr?=
 =?us-ascii?Q?SnnsFafyOFh/eAWpC1bMFkpSeQl36GvyUn7WrvoMw5XLNUiC3frFQrODCpI0?=
 =?us-ascii?Q?kfRzCdO9z15KxRu0UZ3kzn6FRGw4RlZDtXqyvx02a55gpT5A6vSkjvkNGj4/?=
 =?us-ascii?Q?vUdAJvlik/dB5Z/l0HUj6nQO4+peFMWVLZe20zdR89a7ObfXVm7JUyuwJU0i?=
 =?us-ascii?Q?QTNljEUdEQ3pSqeJwNGQ+gHZmQC+s62zXUVYsYOzaF5hQYp1vnePV3K9On5G?=
 =?us-ascii?Q?GkrVJg93y4IBsFQ/lbBtpHZMBChCkRpKhPabetNNN6BARtLZSUs5p7ZWg/3D?=
 =?us-ascii?Q?kmPxx7dBJGPCnC4IkjOscfPQov9h0ErtUjaJPdaBUqUK8N3TCihfIwKrCkJg?=
 =?us-ascii?Q?64tXFVT6bUKiolbeoCeguFF7znUzHhzKKFJgYyiKqTS2S4Mm4cTpp0BnRNfo?=
 =?us-ascii?Q?SBIxhrTkt1wlbyi9h7YfYHiRd+YudBjMZlqMwysXztakokFjFS+T2b2kSRKY?=
 =?us-ascii?Q?pI/y4L506JFfD1MGLR5eh8RFuQk2PFP3tytxIKLMJ3kbTz04tabiY5fLtwJz?=
 =?us-ascii?Q?eiiOmZdny6Tdw0K1GYuMyv2ZySh7oHKgP3BTUibIyQ+JMH6+XKkxpTMWXNyt?=
 =?us-ascii?Q?VDMoR/ddjEhRWebX1OnMoqr3ldDbTO4Syad1WIkm6kODmSeojr+epA+BouHP?=
 =?us-ascii?Q?cOWThmHf7lrS7jj7S9T9MvHsKkObnYMnyWtU982e913smgXMmDOKX7j9ZBIw?=
 =?us-ascii?Q?0bxyZ1BjfV5JgeGCV+gCphI40SN83hPIyRT6a2wEczJ/eRpXuOHX40335Ium?=
 =?us-ascii?Q?4gyiwvW6MjOUPDteZlk708d2fl2rhHyrshXeTSkLDmCK/24zk0D/B9urrEMi?=
 =?us-ascii?Q?yvKzCWnitHg17AImLIvagbJcYrD2MD8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7dcd027-951f-4588-68bd-08da32fffee8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 03:40:30.3852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwTLlA5w4hVItRx/yXOfNijj+gcArPeNl+oJ33C/mzwiCvedSUM1lGzLzmdaWy0sEr0vYHJWisoQ0CMGySNSWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

This patch verifies the 'first' struct member of struct mptcp_sock, which
points to the first subflow of msk. Save 'sk' in mptcp_storage, and verify
it with 'first' in verify_msk().

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h  | 1 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 8 ++++++++
 tools/testing/selftests/bpf/progs/mptcp_sock.c | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index f882915b2553..f1044778455b 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -233,6 +233,7 @@ struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
 	__u32		token;
+	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 2ff7f18ea0ce..51a3e17acb9e 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -13,7 +13,9 @@
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	struct sock *sk;
 	__u32 token;
+	struct sock *first;
 	char ca_name[TCP_CA_NAME_MAX];
 };
=20
@@ -136,6 +138,12 @@ static int verify_msk(int map_fd, int client_fd)
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
index 52448912fe5d..4c939e04b391 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -13,7 +13,9 @@ extern bool CONFIG_MPTCP __kconfig;
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	struct sock *sk;
 	__u32 token;
+	struct sock *first;
 	char ca_name[TCP_CA_NAME_MAX];
 };
=20
@@ -52,6 +54,7 @@ int _sockops(struct bpf_sock_ops *ctx)
=20
 		storage->token =3D 0;
 		bzero(storage->ca_name, TCP_CA_NAME_MAX);
+		storage->first =3D NULL;
 	} else {
 		if (!CONFIG_MPTCP)
 			return 1;
@@ -67,9 +70,11 @@ int _sockops(struct bpf_sock_ops *ctx)
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

