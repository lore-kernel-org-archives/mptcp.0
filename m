Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6F1852
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 06:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652854319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWTaedwQvr0SxBey0vAuLwwi2xBbDwT0bGJ2Oe2nsWc=;
	b=ghezD/ZR5xz25h/pnKI1i1ZVSq5AIIVz/4ibn1ybisRh6xJ0SC+8mH8cCzZT9lvFsgVamS
	lEIA0azkwVHwqMprvaOPqIDXkNrl9WVuAz0tEEL6xRY3aShw4DXjmooGOy9HiEuNJLLvr4
	wIB5TLGw4G9gyf74rUET/zrD/GzYwQY=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2050.outbound.protection.outlook.com [104.47.9.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-MA0Gw4CiNnW2qRi3OJYAwg-1; Wed, 18 May 2022 08:11:58 +0200
X-MC-Unique: MA0Gw4CiNnW2qRi3OJYAwg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJy5lhuPTYZHLn0eCKXP9p42bpqkKo9LnIFF4L/KE2SlWb+K1U9byC7Srg1XitqzsNLQxGD2VszSMQh2AT8y5AtQcyifLip80NUw5HZCHuFXfeqQZMts+p461fborWfkvnlXbH/HhCUEP8Lx1nhsh/qEYexCuQLJy/RvhmkLqCrjDlyL6EdmiFQFWFsIxf/c1B5y5apk26+nt4YmrRk7hF1iSpYS2ruPFV55VjLWt7Nbw1H8Zaj49hZ5jdnlW+SbM9AJdQF4wdAtVADEjzfvKjZhdvqK4Ash4f9NVdYhmsfVBiWlKB5tlHqwXP3ODQZGIbIM2pIN7tDpi0UmLbZ0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWqVJOlJVhMDZlOasJXM+CVcH99g2/50uQTOM7gXcgI=;
 b=Bale2Mpxi41KOaaSNMQXhfXAEjHCXiLc86xTQpGCT3/KE2/Oh5CKdoG915HluKoxM3emIuETPerk/pbX5A/xGDn+Nl1FkCJnW0ex/MQ6u4Hx2t2N2I7OOu96XMyeyXQBaty4fDztQg7d7W80t07avJLzxXT4j60EtDrMaH5CV6zf00NtO2jBWW+9TwIAFfz4xStvsL8//L3WzPBnNkpQOPxSGx1L7Y1HHoxdZO2kYN2vSEjwM5QYFo2F6algzsOXtNjAXHe2Iljv34hXl17E9mImZrkdKWNoGYe8GmkF+WJV/AaUzgXD0IT2BK4X/0JLi0IAk3k1yStCVdDIFKw4SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB6583.eurprd04.prod.outlook.com (2603:10a6:20b:fd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 06:11:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:11:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 08/17] selftests/bpf: verify token of struct mptcp_sock
Date: Wed, 18 May 2022 14:10:46 +0800
Message-ID: <b77ecd506fbc88292a699905b5cb9b27dad65f6d.1652853898.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652853898.git.geliang.tang@suse.com>
References: <cover.1652853898.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0053.apcprd03.prod.outlook.com
 (2603:1096:202:17::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ff693a6-af64-4ef6-2712-08da38954fbc
X-MS-TrafficTypeDiagnostic: AM6PR04MB6583:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB658341EB4AD8ACD8C7D6BF10F8D19@AM6PR04MB6583.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pKRKAtpClhp5ykQAORurRUpVz7A6J2xR0joFS9SLY31ETPv1sxbdiS6nR//2RmloBTvUeSNAcIzmlvQOA8lpzbpd250v34SND/qeaQJ4q1+6C1OdfZND1ZM+8pMqspuJGy2h5ohGFGKVKbcIkOIjE3J56uSf16y7qAlCAw9wxZbO/5E7vn0G+HTKB0GHkF0nkLcDwQVbuyatXiMbEEYPuULKQwE2+IJrS5ClcnqSROTSjqy1GsV3tzNNVnOVjsgYch21vRLSbn1+Wy6K2erOsSscFbBn6VhmURlEVdaNO501eF1zjD6q5HNQOLx3bKOo5Idy04H0SsyM6bqJ1c7oAghw3rSqQ5OZ/Pu3pXwERtMglkoe9f58b0dRjC0XODcPmG2SNy6+aG66h1mpg8alo3zpI4zXRg35x4ZVXJuhq2/AoWg8W+skSZGI2VmuUmqvlXev80h6mKPfy/JLITTb8voJg9l9jyb3xu0UUMbvQL/j0Y01ZqdxJ2Tezd3ealM0L1JHF2MD6IJaXIpOPN77K550yNirx0e9/fsKCPoZ6BYvhnxVkAznN2gxyCZzXO+SZemNIktIPXmyw71AqclIXWH3Odt0MZm6kl0VYo9HpinSM1NHa+xMiqfF7BDmS7KgZ2EgncljOfFidJAi5S65lvYxGk8RLO116V1eVWAV4Q38S8DbDc8OP72KaCLeh9r0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(26005)(508600001)(2906002)(86362001)(66946007)(15650500001)(44832011)(316002)(6486002)(6512007)(36756003)(6916009)(54906003)(66556008)(2616005)(66476007)(4326008)(83380400001)(8676002)(38100700002)(6666004)(186003)(8936002)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Ciq9jz3Lb5v8+piASTAiJGIZChoUrqrYufWPL3OZPF5vhuE5e240XlqXHBP?=
 =?us-ascii?Q?McVV0dqL5BvvJyr7oIcCJoENbt2R5U0fTxtgpHlVhpnNiWa/5+px8lha+os9?=
 =?us-ascii?Q?vtSPtfvi3JXBiZgV7Z+3+fpZ0NSUo5dgvgKGTf5XS5yAxd3+FTQbrm4gVANR?=
 =?us-ascii?Q?AzsKOlMklM5OoeDBALmrXN4ksTT3uUX4cbcn3bbMsvtlZJgPLcXgQQb2aZGe?=
 =?us-ascii?Q?X5d9+AdxKNRZOh8d99IUV2kVOFdTPrscZL+iaT2QYISSPZQThSTXZ2+21FEf?=
 =?us-ascii?Q?bjzAGT3sGmCI/sH0AneAJx3Sp6L2xpudlREqUSSlPyAqLnhtbMKOS7vNG34A?=
 =?us-ascii?Q?F99bd3tEpK6X+uKKwvz6OjZPSEvDSLq70YdMf/PTdVhX19VHnR4d8FGBDPmX?=
 =?us-ascii?Q?ZUtqHIkpmh+A2R5WQoOyTqhvw6ZS1hxrizh2idZyyqQFyQJJqc2Q/Ckmxjyp?=
 =?us-ascii?Q?VDu7j5XNf+6zPNnsYvyTjkJK22X4ykVhXZxMa+QWKQRjm3tD78M6U2po6lMD?=
 =?us-ascii?Q?ItIzAumj9liontse7h1qlhxQJCRvW09Gcsxk7rnoGzxAi5qkTo6JNjzfwc3b?=
 =?us-ascii?Q?vOe5lKhzyn2PEiHZtdutqeFi/1Znsb+nBbI16SP0jCU9Q5X1TJgT9L0kMlBm?=
 =?us-ascii?Q?OAp5Gb+44F6zfprGVet2VYnpIy5c7yVXFITssRiUU+IPMa7UP4AkqZPXl+LW?=
 =?us-ascii?Q?txQk+HhQstOO8UPGrZorjABG+3yywSb4/mxSwkVGnEYn1FBkfmKqwxsqgUx2?=
 =?us-ascii?Q?Sw0xsSXBLWVcT55j2UvJcapYlqJEmm6ax5dJjFX4BdvhVCNV6rhw9A57ulaS?=
 =?us-ascii?Q?u1N62X4TueopE8QOOmQ3k8V/g4D+4RVjTV3fHJTa8LmKmTHZlU+itpHHFPUq?=
 =?us-ascii?Q?pjtAAOhC/thQ7XZ4+xqJZMNBxZq4ZTvYpd1kyNxqTmHMYIhXGw4W7WHmk41N?=
 =?us-ascii?Q?HCgMr1yEporT+Ew8Sq2O94X2uJm59u304APJK0j1WbJgKhPQ7QifImvFwWE+?=
 =?us-ascii?Q?ZCFgSH42vWeEe5xgmSTVEKSe5qn57MA4On5PsNI1aG09/YBT5tjHy8P9bMaH?=
 =?us-ascii?Q?Etx7450yFagGoynWyoDrjFVoGIySaQ5xCQjmn5Le+ijB/Ct6VZb4TL6Byh5e?=
 =?us-ascii?Q?fIeNmt251K8vAvNiDqEGDHw+vb+n+F8KEMs7vjodN8iol4slEQqPkxRMW2gs?=
 =?us-ascii?Q?c024C8/Hycu6Ikk3CQHBioJ2CJzJFAmJRgdRiZs3+r9WUMXvruo4V2NnOGEx?=
 =?us-ascii?Q?7uKZ2Be51LdfFYR6UZHJUg0YvZVseoqeZ+9hIBMlWy9h4p936SQ9MHJQmXzN?=
 =?us-ascii?Q?EZOUJlLOE0uR/iz493unmEnB6dU2D8fkN+Skqt8DXUDnThdCnAXQdsTy+uBX?=
 =?us-ascii?Q?mpxc5UgIDi5LVK72kDDTI8uKOwGopfeWHkQa2CAYn9D3loeE7JqQBe0pWlgm?=
 =?us-ascii?Q?5TR3yx6WztLntxJ60hIGZ5k+qANqAscYoAO3sRXg92T0RbiymxGhI60xVa2/?=
 =?us-ascii?Q?UNWrc5CTEoXc0bCVv4GLcHpir8QQZ2+TlHtxyNCJJXa95S+bnvTK+mUss2an?=
 =?us-ascii?Q?NWTDo7/5+UNPQI9hQ76XRA13v7eR6fmS5jebrXM9NfFZ4HV010hAcTq+At4i?=
 =?us-ascii?Q?qGbRSceXliO14liFbwT7g7t5go3B7k40zcV2s6LCPBwiQoWdBDTj145bCiNf?=
 =?us-ascii?Q?hhi/25jvDo4By755Aic64oWdVtNyzTQuJpBmdopYmliXquDGgkJFMT/w32/B?=
 =?us-ascii?Q?C7M/V3+J2wFpiUDA+C06UWBYl7XVpYY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff693a6-af64-4ef6-2712-08da38954fbc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:11:56.8640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkbPLi7rtZl7TzEIAUvWaGtMcPyx3BKHAVyqR+NdI5TQrqX1ngR+s4gYLUYj/zMowLZ1xqJFg7e3EKedTHrSBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6583

This patch verifies the struct member token of struct mptcp_sock. Add a
new function get_msk_token() to parse the msk token from the output of
the command 'ip mptcp monitor', and verify it in verify_msk().

v4:
 - use ASSERT_* instead of CHECK_FAIL (Andrii)
 - skip the test if 'ip mptcp monitor' is not supported (Mat)

v5:
 - Drop 'ip mptcp monitor', trace mptcp_pm_new_connection instead(Martin)
 - Use ASSERT_EQ (Andrii)

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h  |  1 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 15 +++++++++++++--
 tools/testing/selftests/bpf/progs/mptcp_sock.c | 16 ++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 90fecafc493d..422491872619 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -229,6 +229,7 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u3=
2 w, __u32 acked) __ksym;
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
+	__u32		token;
 } __attribute__((preserve_access_index));
=20
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 6f333e3aba9c..138bcc80ab9e 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -10,6 +10,7 @@
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	__u32 token;
 };
=20
 static int verify_tsk(int map_fd, int client_fd)
@@ -30,11 +31,14 @@ static int verify_tsk(int map_fd, int client_fd)
 	return err;
 }
=20
-static int verify_msk(int map_fd, int client_fd)
+static int verify_msk(int map_fd, int client_fd, __u32 token)
 {
 	int err, cfd =3D client_fd;
 	struct mptcp_storage val;
=20
+	if (!ASSERT_GT(token, 0, "invalid token"))
+		return -1;
+
 	err =3D bpf_map_lookup_elem(map_fd, &cfd, &val);
 	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
 		return err;
@@ -45,6 +49,9 @@ static int verify_msk(int map_fd, int client_fd)
 	if (!ASSERT_EQ(val.is_mptcp, 1, "unexpected is_mptcp"))
 		err++;
=20
+	if (!ASSERT_EQ(val.token, token, "unexpected token"))
+		err++;
+
 	return err;
 }
=20
@@ -57,6 +64,10 @@ static int run_test(int cgroup_fd, int server_fd, bool i=
s_mptcp)
 	if (!ASSERT_OK_PTR(sock_skel, "skel_open_load"))
 		return -EIO;
=20
+	err =3D mptcp_sock__attach(sock_skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
 	prog_fd =3D bpf_program__fd(sock_skel->progs._sockops);
 	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd")) {
 		err =3D -EIO;
@@ -79,7 +90,7 @@ static int run_test(int cgroup_fd, int server_fd, bool is=
_mptcp)
 		goto out;
 	}
=20
-	err +=3D is_mptcp ? verify_msk(map_fd, client_fd) :
+	err +=3D is_mptcp ? verify_msk(map_fd, client_fd, sock_skel->bss->token) =
:
 			  verify_tsk(map_fd, client_fd);
=20
 	close(client_fd);
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing=
/selftests/bpf/progs/mptcp_sock.c
index dc73b3fbb50b..f038b0e699a2 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -7,10 +7,12 @@
 #include "bpf_tcp_helpers.h"
=20
 char _license[] SEC("license") =3D "GPL";
+__u32 token =3D 0;
=20
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	__u32 token;
 };
=20
 struct {
@@ -47,6 +49,8 @@ int _sockops(struct bpf_sock_ops *ctx)
 					     BPF_SK_STORAGE_GET_F_CREATE);
 		if (!storage)
 			return 1;
+
+		storage->token =3D 0;
 	} else {
 		msk =3D bpf_skc_to_mptcp_sock(sk);
 		if (!msk)
@@ -56,9 +60,21 @@ int _sockops(struct bpf_sock_ops *ctx)
 					     BPF_SK_STORAGE_GET_F_CREATE);
 		if (!storage)
 			return 1;
+
+		storage->token =3D msk->token;
 	}
 	storage->invoked++;
 	storage->is_mptcp =3D is_mptcp;
=20
 	return 1;
 }
+
+SEC("fentry/mptcp_pm_new_connection")
+int BPF_PROG(trace_mptcp_pm_new_connection, struct mptcp_sock *msk,
+	     const struct sock *ssk, int server_side)
+{
+	if (!server_side)
+		token =3D msk->token;
+
+	return 0;
+}
--=20
2.34.1

