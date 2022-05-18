Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57CD1853
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 06:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652854334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bplI9rX0E7VQWmxEeoit1jc5FHz4R0qMqAETsk7/VM=;
	b=NjrlOH3W6vSjyynV78N2DYweQ8YbQOLVAhqmRit4TaOp4+PqGGT0BBx7olMyI5ncFvbSnk
	6pAxbigmZXL06hRzxbSsuFi/4rN+DSJG74KJshX/SmL6WFad+eD6quOXkNZLVhg7AZ+mj9
	Aut3kU6Punaqa2xOq3IrFIgQzujd2Fg=
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2175.outbound.protection.outlook.com [104.47.51.175]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-Q2XCGPbOPMSJEFWUnAIkWg-1; Wed, 18 May 2022 08:12:13 +0200
X-MC-Unique: Q2XCGPbOPMSJEFWUnAIkWg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bplf09uc7R4kIoNV7nXMsERf7qzN7RiBJGGNWG5HEnZiSwub8KaHistw/ybfJqPBEC4ZESZ1GsLO7WGaT+uyViVYPeBDgdnDQTxmKYHWSsm4a7YuJ15UQBVNiuP7KXDNagYSl1A9xfyn6z8ZzCL9VHdgmCvec4KzjsJ5+xa8HS4lX/IhniFMCdq8A+wifwmjdnlAEnyyxoNMBSuZw2YTBrEX58XZZD3qk5RtAj/Nff4zuCl0GzxQvSHCV/qERUOnvKLxBTTUbWzNPl+9TUq9bjhjxu3ubjixj0tP2613mP5lI8F7i+pvVbSCJpWkYbxyqhf37ASVDF0Mf+8ONEy5/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kldL7lnlLvgd3DBSbMJOQiL5fToXVqL9yekeasqx0t0=;
 b=UL6P6Z3BZ3RU/IhFZqTtE23Dr64cvHkRrZnAXV2iyzwOJDs4THUHyOE6xu7E3BpYWwV4LtNo7KXIYRL4iFnZK5aYcFHlSDmT6aXNaMMYSzowDNjI07P8YJQ3tmNhI06ng1R6uvdRprAeRRY9vKwAYvxV7QSvzNvoLOjuNFsOycNFqKp/v6fEFY2WK74Vl+YRYfNzJVPgRT7ajLx/QSunc5ahB9wuD+pHxYiKNmc9B83vI+nqr8WuUgHH0ilG72UsdOxxRkI/PNYR+cfKUQ5M7fbwKw3pBe8JbM/9mvWQqG4T1t2wnXhtzr5LEAtXw3+TDUVaUG2urDQuPEs50x5bpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2584.eurprd04.prod.outlook.com (2603:10a6:4:38::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 06:12:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:12:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 10/17] selftests/bpf: verify first of struct mptcp_sock
Date: Wed, 18 May 2022 14:10:48 +0800
Message-ID: <c76b91ac2e020e45d74b8d092c5e3fd13cdcac01.1652853898.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652853898.git.geliang.tang@suse.com>
References: <cover.1652853898.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:203:d0::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11b8c2ab-b08d-40ec-40d3-08da389558a3
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2584:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB2584FF1ABD10CCF61F3A1785F8D19@DB6PR0401MB2584.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JxlZipDycmeJdpfa53QedWlYVnM2quWxIhajzkg9jgmAZIEFLuEBEGJJNe1Xx+/vn8gYoo5c4ejTtaKLYGy0DLu2AFnJX2n/9gb6H6ji4SIu+50gkWT9kIoeUTye7GM7AVZZkwPZXUZ3kilef5lbnwdEEFvdyCcqrJ5oGGxH3sSJBdgJLr1A/EcTyeXYZHMJB+ugOiAv0Uzcmke0ivgx8qlQNWgRDbptUFrPXc8fRJ+847+hQNXqgJZgfpYN05nu1o/jFeCnEFw4jgsNLfq4npcHySWrim8+vhLDzrA+X+mYx1Z0R/HfOt3yX0ih14GI7Tx1YFrD0JTHqB5kPMbmytQbbx36Cv0deZJasxD4J19rDZYJU1TFZUS+r6jhWDcYZ1BdAXQOqqjIuIMnaXAes3neyp1YpNxIcAU9Xeq83rHQKfhDIHMMwQWYnzQag9VIuo3YdADLA9B4pob5PsdMse8Z3f5oZE7AiJd9XOd3OoU3G7zQ27L6bQKp0NYrPnHBBUo5wNC9jA4VlpFJFEtDmB2TvY02p6WzfWwU/odnwzkKGNrkHo0HsKQWAN7BFyXOgvJ7IwywTo5n1JA00dwZp31R5x0M+5q7z9rR5U3OwR0y1wQgie4yDvyIhHQM6/gF1PCaGHA5QTpWx7H51i8zSdQBIjGlzcRwb6y/MrTzIRT7DDDpHILd+PrebxBrQWreTHKE8uGUqCQQ9fxQt9/C2g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(66476007)(36756003)(44832011)(2906002)(8676002)(4326008)(6666004)(38100700002)(86362001)(2616005)(5660300002)(6486002)(66946007)(83380400001)(186003)(6506007)(6916009)(54906003)(6512007)(15650500001)(508600001)(8936002)(66556008)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GeiOz6YwIyzqbJ8vC+kX3zZfPwy5NT2AQ7wFZ2SX3SCgn0a/YVSQEnBxfp6g?=
 =?us-ascii?Q?3VTRc9iBJd6AatKreoaj5ThDOjGXj0nq2L3dhRQzB+xU6s6avyEeqTL5lCgw?=
 =?us-ascii?Q?YSCv5uEIhPYZd8yHv6HXQc4uQydPluGxvlJ8GqOYuAzqwTuSrXhIpuQH+3lW?=
 =?us-ascii?Q?1AUAR7BRd7mxeIRZa8+YB8AwGXJ+psh5nYhSMM7I8KwPRG9+Du/ewK4fNBAU?=
 =?us-ascii?Q?cPX/5W1si/xP7IvjSWKxB7huvCH1GCfZuGVD3svAEXQgLq3kHd+5nYLnyajw?=
 =?us-ascii?Q?t27TOBtyS0Ftf/Wlzlv3vYVsfF36L6raQ4/KZpwshzCOzqqdGCWNsX3lc1GK?=
 =?us-ascii?Q?XLrcBE4xuEMQMORsQvJw2buEhfrvK7shShaJWJDvgEQGak01yXKVtl1zb/8d?=
 =?us-ascii?Q?mMIrftmZQ1N3+SPCu7mPXrkkS63L/LqXDFtDVzCdb+X3ySWckHUum2SqpfEh?=
 =?us-ascii?Q?JrZ0p6oQ9WR2SJ6M5LHG9ZTl7TwC4O9upDKSfCZ7x6+88aLufRV2nyeIYN+7?=
 =?us-ascii?Q?r2QF0agdAkN7gLASlbtTNa+6mGWqX2x0SjRJg1epQNvWZ2rNvUM2P5Xko9gR?=
 =?us-ascii?Q?5eKXiQ52geodbZNoUYJKERDmQ3Bd3WRcMAbowtQxirrciz5gseDHyou/Hhuc?=
 =?us-ascii?Q?MYhXfAdasGidwUKo5o8Wk0rZgrvzM4CvLPu2GILAqqwZGRQlLh98+luW9vAX?=
 =?us-ascii?Q?gu7NfL7+kTkcVx7TgaDkQpsFkVjbkxj0/WT7sm6kB7RSmMU6AHiUCPgCl69h?=
 =?us-ascii?Q?BgaaG0BdCuL6cQmtnJs2lknuX/8S8rTrKK57ieWfxwL6C964RWefNeM5kWv7?=
 =?us-ascii?Q?DQfxIXlYMcAVUc5jgGikBuTb2lTGYzWI9+2pRasc2sAIIPH8aNHCRin1fh59?=
 =?us-ascii?Q?R09v0OpHcAZxh8H/Kg9AioFI5dy5P2k714DEqH/9glcUWf84jLr+LcoIGuRX?=
 =?us-ascii?Q?usuFuOIrVN2ovmBmda7O9mDkx6TEdzbikO+itqj6I8InxjLgPsZZH3xLC4MH?=
 =?us-ascii?Q?rJYQ+uEQuyimxHEgs7XWQrqJQWg9iCFlqqL6X6bSSJJycAnVLqidhzlfnDJK?=
 =?us-ascii?Q?6LYVm8imndt+ZgOratV1thg4nXR6oMh7nOex1q8v4y9wJnmdEzd5NuDBPG5y?=
 =?us-ascii?Q?HPMDwI1ROdSsOPqfvgzF9A+yBMAENzWDuDY6ZlgS/QRntj7Xp2qlpBWvmkM7?=
 =?us-ascii?Q?OBahsxAIn5Enu9yH9x+v8IChTfUQS9wTgrvPWcWoJxB71WkPPCetyEWTNa83?=
 =?us-ascii?Q?CZNT3llJuRsrGgSb0tHOnxr9+Gq28AsxlaKeA6JT3KVc/35Aj8/xpewggOiH?=
 =?us-ascii?Q?c/LHffsMB2tpqk6S7sI7XEDEJ1wv/80V2SjlLyKRSQcuPtgxbYHGcQEpTKf7?=
 =?us-ascii?Q?/ro2UuM0GNTagTbCw6T4H4IkSANEDUqe8EIQWPEGiEXao63wmh4hwA0oCB8U?=
 =?us-ascii?Q?7xXTGAr97ounzb2ZytB7BBnGmjrZyG2433EDp0CrJfGJW/Ce3pyQhYWZy4+o?=
 =?us-ascii?Q?x/YCm32ZiQO75rDQmGnSj76qvjs5pdKM6wJaFCXIrgjjvi3asRTdihXzOtw7?=
 =?us-ascii?Q?nlQCI57cbvJXp4BQvzz5uJhLPuDm4vwgN0IVVF1mgIY9DcPbL1hJu+L3DMYJ?=
 =?us-ascii?Q?UCETI5odza1VCi4wWjo4boMEDvtQ/C01wE8q7kraKxFwhss5HvhVnMWwRFzg?=
 =?us-ascii?Q?FDX339oRMWbYTC7yxIDDRB85APj8TPzetntFczI6tVpEyj6a0amxbDRa7fZT?=
 =?us-ascii?Q?i9GVHKsT/AyRJXPXrt9rf78ToesABig=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b8c2ab-b08d-40ec-40d3-08da389558a3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:12:11.7847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OkWEJcWc3CsBQW8LHm6xPbl3RJ964LDq+6QUgydxLxuBQIp1+2TkqtyfS1LvIBKoFwwl9SpTgfKJHEm0v3xkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2584

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

