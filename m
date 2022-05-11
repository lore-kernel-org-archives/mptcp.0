Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0518315B9
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 07:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652255830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ovFrt90TSAyXkqDWcw/fUfI6wpdTzDNMwWbCm+o74zU=;
	b=XoqqJMHP9dp6WAfvIYCgAEZA3VYQ9ZciKhPY4kfJsHBc4zYNEKZWLJ4wFanfZY5Fsu81n8
	bq/QytdPkkjLgk8SBfAEyvgPd/qQGMyFzVyOXu25ni12k2mB/pvnpx2q1Yg4s4nF87Gh95
	Biuj+GSuQ3i2XCpQOpRalxFLzzdnCZw=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2054.outbound.protection.outlook.com [104.47.2.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34--Z5r0oGpOnWRt3nN8Gvb6Q-1; Wed, 11 May 2022 09:57:09 +0200
X-MC-Unique: -Z5r0oGpOnWRt3nN8Gvb6Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiM8YQ5bgIslm6pxBxL8GHOkNsJJJWp0c/o4HuEeCIgPtKqtnRYstNolpAYsLNsqBfs48zNrYJQMRXqeRdNDQe7H4CcSTSXhcrW16W/j5NrSaCvpjSzcWcplsprpjiGrdqNOcO7uC3MyjQnbf2PfQz4POUlsG1Dp9yL9Hh0+pbzgD1CC6aJl6o1+gYNXR8wMItSba7tDJcY7QdUmLgL9XI5NESSgeXncvkY5bJ14qt1EqSeE76ojpoZmpKG4hdG5vgRQEDkyjoa9j3PdCpe9EjixzfqVM0MJZGDTTTIk7oUCY2UF57ICNNBUE5wnMTminRDV0Hf6QdW+lzL+bj3aFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1f1ZrapII9bktLVqYRqsWZ21o2EhDNgW0jfahYrpLo=;
 b=jy5SPgtE13lDf9GMTizpbzqPEwKeIWVy+hbjSUMbaPDLivnvXQzTfAnl9O5PDLQXepXyUqmgBMQIdsiTDaecqblIgV2ab4QTAvzwNCtSvganZuN4m3uhHOgSOD1kqzNdOXWVgRYmTsGvLm5Cy6dK/oR8ZkZ+NPRuXtioIZGT8aduJh6sNP8RwJVEeRBL42BADOyOSh6eRt5aQZ9gc7AagK3P3I8At00KFv+SGSNjtvbbypoLh9cvvz20toAzHnPAOa5uGXSpuDgtkBYP3h5oei+ZDcZuvbNyWMkzLKsZS8eDopM2cP1R8KmrE4nIXgR6r9sY86hrUqmRcZVkNW42Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR0401MB2653.eurprd04.prod.outlook.com (2603:10a6:800:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 07:57:08 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:57:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 07/14] selftests/bpf: verify first of struct mptcp_sock
Date: Wed, 11 May 2022 15:56:13 +0800
Message-ID: <dd8aa330cdd5d8bd8ab7c9fff86b10915811cf95.1652255616.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652255615.git.geliang.tang@suse.com>
References: <cover.1652255615.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:196::16) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fc3ed99-1768-4180-35d3-08da3323d8bd
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2653:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0401MB2653E146199655E136B32E6EF8C89@VI1PR0401MB2653.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jhv1kn20+NXLk5CFkhTlRE+V74r+01R33j5lypN2xEKgzffZPxKDOHJ8X5/9XQaxpYz5lasLqzbTZfk8k2It9Z/rJNeqh5Xb8FJs1Grdr54f8tyHsUbFNJmS7P2tWWws+776KxyiaWI5loPubb3xu3kwTwHm/iHJZ3Fgwd/6NqxxYqkeLh3i+GwNzlyMb8SZPojJh1F2ybREKjhp1HKamR89aUXNBOLkx0KzH88BCI3uTYh/lL2y9Qel6nDfIT8Ux8thjhQxRh7Dqrs0BISuOhRqCCldm+043kWK0ocfeD5/obCcS4mIU3DJ5d6EkJKOLLbeR4xK1JGPBqyw4qR/YYa8LBhfxtXTpT0iEnDlmcz038hz7KAY907DLS5JEKyD5ekD0PBQQW64G2uYTr1OZJLdZxz68Ci1a7Xm3ccRY7EW1CuTk4DAD4jsMtjWBf/Refez/ASLmqz5eEhxHWxfbHJSO0nlYPaO/EN2/adrWz+F8UlTPpoz6ClTQeVw+tJ0142o1+bGCJagfYn/4bKqjvo8feYBEZI+gY+DhbFJYSFStZ42o0IZmWyWyr2swVuh4RccDsNCJj3401ijyygu3Pmg8OSfbGUy3vPcQc0lHyQWunThMpOXXFt8Q30kN5Lz62Dt/6P0eY8oCbV8Mjl0WHoJp8oXat1YJbX0Jpfa2/xJVWANB5BgWGRNQ813DEyKF0uBlDS6AkVSLFWyEi+ASw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66946007)(66476007)(186003)(6512007)(86362001)(4326008)(8676002)(44832011)(36756003)(6506007)(26005)(2616005)(508600001)(6666004)(6486002)(316002)(6916009)(54906003)(15650500001)(83380400001)(2906002)(38100700002)(8936002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f7Oc69xK9hq6fMvP7CP/BnbD7T+wIedDWe2YWgtXDtnJtZjpc83DF1r0QH5d?=
 =?us-ascii?Q?doyZiBiBXdgCJtkr7JkE7a6Akr8YrxPzazF5TXkFk6hXL0lv6icjJltm8W8c?=
 =?us-ascii?Q?wKjUQfU2pw7d5Uo1WsMrPlu4JD5OZCUqUWwJNK65VYgPJkoho6a51BBd0sU2?=
 =?us-ascii?Q?o/P2AFUaWdfvHlG0rEMOaDmPJw6CNFAMrIoOTbHFnSK1PHDINgVsnNbymdqu?=
 =?us-ascii?Q?in2mHBvd/HDGY+HEROHP/M4VqkYZ0U+25zEQl2R6bPJHMxulwWI7CGAqXk1g?=
 =?us-ascii?Q?UCyAnHiDfzXrjewBhqD7RtiTXzrEcQPZneT3pTrgAJZfH/RKqVKiuVggVGJd?=
 =?us-ascii?Q?ij/JmfCCecjnkvV9CuidcASNblHJsW45OxdKVJlgMKG6DM2ZtlCM3ZNAeXrZ?=
 =?us-ascii?Q?VROj3F12HnrNz5sGJTqJ0QFlTGZ6ctl3Tk+4sTC0c3q8xAHVdHKi4bZrtrN6?=
 =?us-ascii?Q?3JQrn/PaTAxY5i1ejoQR1s0pzHpKpvDB9pqXS5Cxi0R4PgeciEa9jUM5EEI7?=
 =?us-ascii?Q?YWLumBX5JEmo/1YMeD+giX2E9wzrNJp0gTs7yiSfx5ZcdqP3hXuJjEzVuE9E?=
 =?us-ascii?Q?8YHaEJegPPohgAuILFobq70ZExNJ8athfM1XA6qYJNdnTdD63ZcjKQ6+OnxY?=
 =?us-ascii?Q?ikC+WUl4ztj+fG8C8FyWkMw91pv0cHBpH5tCAu/XNeS+Bny5ztgBeFRNz+Su?=
 =?us-ascii?Q?XZW/BYFAHiIh7fFQcMLOgZUB+2/Aejqwthm4s1wlcXYrBVDv0MVJVQNbcIxe?=
 =?us-ascii?Q?DAVAjtaDdK/k7UoL/ZiiBh0q5B+VggXtd/WKEh9nje9wFaQT6QdrEz/+BUmV?=
 =?us-ascii?Q?MGxoe7NHG0w8Frm2wejI5FDl++Mw6tVU0lQZNFppxEsYDVT9TvaLZ2Fh7Ltx?=
 =?us-ascii?Q?IYUR68tcFnaIEOItbIAoJ8qaG+AbHt3TDJIVtsoNkEA0I8TGyguIH07Fh+yf?=
 =?us-ascii?Q?7TbAG8VL8x0SbAWUnmjjbzuyQjXqvyL3556M7kXVMHgj35SZC0Sz5IRlmLHj?=
 =?us-ascii?Q?UcjnFMZw/1jJZDAEDOXffaPLImZ5pxY6DKIf/iDL73/MyaFHK/gG2Yai8EZZ?=
 =?us-ascii?Q?prN1vKqXAW3SkVj92mXsS0R+uip7MfxmReotyNi2H1eUOWaP23SlOPGy092F?=
 =?us-ascii?Q?Y7PI48k3b5Jtuus/kNySUnE8AdQXTZMaHLSXETZmdUyzihikY572OX7OmcDW?=
 =?us-ascii?Q?+oG9xo8LmwoadYBjBUN0Y8gQ9NdbW1IxibYVxpivC50wJmTIlKBce7M08brM?=
 =?us-ascii?Q?N8EnFsg0hXIQuUVTD5s3yQDIQF2ZjP/RfWQ+n/F5wKtsBnTeBNRnawf84jm0?=
 =?us-ascii?Q?muVhMTW9l3vU/zLsovEW816KRZRq5/RfcCdQIUMhlovqZVGpX+Nm+sO8FmDQ?=
 =?us-ascii?Q?TRg9e7sIjv1V1IUHmEnYun9cRw1VOgKu62BcGptG8yFrPtY7gFh7mhhl9YLt?=
 =?us-ascii?Q?GJqUdQjUYhiL2IXkk/QVpZ2Wz2t90IAhFU+C3S/n74oBry9XUHzdGgN6gvN4?=
 =?us-ascii?Q?AS4KcLtgabSkjQoOI9IZkKQqYZ3lrq6BIElpmazRvY98t9L5hwfHaDeuURwc?=
 =?us-ascii?Q?anH4eoPKt40x9yp5+5/1TwV4+W90zgzfA5agqdQc3cCUuaK3ectA+wMdzAAI?=
 =?us-ascii?Q?omqmf9GUuzw+dBE9zYs22NSAXkwlU5kBN1BB9Xoq5/oMX++q8aiTZDpUw0V2?=
 =?us-ascii?Q?OLtb/Ngh97vLcsxfcHY961HcnSMoQv0NH210EzdjgYNBE/PrSNcwgyVsrr6D?=
 =?us-ascii?Q?dcRPOFjoMcwOcvkZPWIY5H6EDWm6CwA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc3ed99-1768-4180-35d3-08da3323d8bd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:57:08.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfFGBOxj7VbdYZLrvRULtzoXNiGbKxel8EZeRjTAFSzPte2Tdvb2eIMuaBwTNVNYR4DIfBbuNMR6ondBYkLldA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2653

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
index c36f2f6bd2f1..ab135edf3ae3 100644
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
@@ -54,6 +56,7 @@ int _sockops(struct bpf_sock_ops *ctx)
=20
 		storage->token =3D 0;
 		bzero(storage->ca_name, TCP_CA_NAME_MAX);
+		storage->first =3D NULL;
 	} else {
 		if (!CONFIG_MPTCP)
 			return 1;
@@ -69,9 +72,11 @@ int _sockops(struct bpf_sock_ops *ctx)
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

