Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8F515B4
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 03:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652240424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBFdHU7SOMGVcbVv7OsaEJsj7C74mLTXe7z/+3sQLXQ=;
	b=IMahOXzG6+b9pd68s38M1wO7gbQIHpBdAhfCXJLS7YuG4yBLnKLEW3BXuNjJDfIJhxbG4h
	v/zELGvK1O+h/5RIliAhSDJV9HgCQYiillB8xan+Jvkh6kCDXinz2NdvSwvkegYr4fahLS
	WHXcPJwu7p02My8undv8oaESb331wFg=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-UIqSH9iuOlWN5KGyFYiICg-1; Wed, 11 May 2022 05:40:23 +0200
X-MC-Unique: UIqSH9iuOlWN5KGyFYiICg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDjANaoKCVS5ivC3wfY44LlvzCascwQCJKeKAbzah/oLrHsKuFOHD30SN4RcSgjbkXfGmcEdJBbinaCrWADfVXoqPGdz/AmfWNI1ZwQYZDk7GtPQvSl9dgbkoJoK785926uC7Ed2R4zsQzuP5Tg55FV1qxkJnUBnyyovLQU1qI01+BU9ln0vzuh6VEwrvDLNxNV4k72b0+01BvLay2vX64PalU0tB/C4/EFzDv74IXNG4dt6bWz/wAdAUbsz43q2rNC/VpWnDcPd5kgMqYs3j5/RrpLaixPihuoCGJJgJqLSQDaC8eloLyQ2BdfN0ohA5zgmjRCMW52//JFVeHtSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWO1GTIGI0xmFz/FXIpGrJOe+oqRO6fysUx8YfnmRKg=;
 b=d5vKO1BeaHuapgXfpdGnZ0mPpCJxT+5XIOkS4LJ73RgV6L37kWPLM3kN8/TGrg5GKDOmyQXdga+TiFMKGEeNFT7Utb0JMO5NCNZc3LPGIiy/VOuX4J6CFnHvBXuFHxJEBp8V7P6OkUeumSu1FcFwRpZvYniLYmmNo8WHyaNHWA527ygym51xqggBUmPWnZrCGCFHMJ9ccU2r3CBnAh2PD+P1S7Zk77Tp33BScUiyFFslYZ5M9vHSagEXYf3Gn6trKSd1hP7uPtKIzBMY+zwaJ0wVjMY2sFXtrHFhIQ3d3b73p96cY/Bm2teQ/Bi0aL/QhNYB6/Q3qAIYi09b273AdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Wed, 11 May
 2022 03:40:22 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 03:40:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 07/15] selftests/bpf: verify ca_name of struct mptcp_sock
Date: Wed, 11 May 2022 11:39:08 +0800
Message-ID: <5087972053f44be54c5c49f8efae7a92dde54e2e.1652239604.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652239604.git.geliang.tang@suse.com>
References: <cover.1652239604.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:202:17::32) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97f415eb-5556-4b04-5263-08da32fffa2d
X-MS-TrafficTypeDiagnostic: AM0PR04MB7156:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB7156B7E0E7C9A1F9B2C0D631F8C89@AM0PR04MB7156.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J6qLNGLbHAOacbkqx5TcN9MiHXEIo4k8BRDKTTLm/EH8tf7JAE1L0ou4PoCA86grb2m/KV7dG0AuXULFmmSLBoLyfn/z+t9EqlBH5eGa8QszalL6WFWkjzDO/edrvSWlUq/6ClEYD00kRMxCxNBJgxSNWK1bOfC1Xh/KEI1OhjemGzNMD3jcxUREk+ZQQeOSI7MFxRlyf4DVCknfTW/Rp0pSe459mVwcnAEQHDzI5mCnlpjltO41rvsBfUELoB4BnvOvmdUkq9wXlxxnq6dTtfZ3Dy6QLIma9Sg/wtuGx1QYGagijsWq6gGVqOz30Y9neDUtpE1Xj+WZj5hdUNeWTdSD0VbbbE75P2hJ3K+OafddWz/8ArI2T5+K1vs/LWw25yPpBPTitivLNb/pe+WkE2ENzZ8T82wxe4Nu3fG/wbyavdblQKTN2DDfAbmaIdDH93zp7sC3lVrXPjP7+F6qFptJOatBX29kfS69hrEwC5Iv/HtOj7XH5+THQOdhuVoh4RK6nSChbsZcSFz3El6PtSKaAFm7Tg5AWIBjjXYEsqKxvTmTDXvxqC2Kn9B2VsKQLwXpHG8tg/6lMIE9WBXaZEPbgV2F+M/nwUjArC4szZmFsK3dQRDi+ctCE3s1MkIwlV2jBy3Bt18r+hhcZ/cC8h61V15x//felpqLkOEEhVqsvC4U5laVv9SN7qOZcqRD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(86362001)(5660300002)(4326008)(2616005)(6486002)(66476007)(8676002)(8936002)(6506007)(66556008)(38100700002)(6916009)(6666004)(66946007)(54906003)(316002)(508600001)(15650500001)(36756003)(2906002)(44832011)(83380400001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pCJvdHXWjzk25sz8zKFg17tWzH8qtQ28dAMRYscttM+tk6cz0FWL0rKTKZMO?=
 =?us-ascii?Q?z/KMrfgzm/7Z3MUkB4gzysTwyopaW4vVJjcemdPYN6cvJb09gXXi5Qb4TFcz?=
 =?us-ascii?Q?iOdSIoLETfS5Py4MpAWbPNInoKgLfSRby4alNxJ/JRbrmk/9ibTLkZB4eF8A?=
 =?us-ascii?Q?oLwuUsJa2FrewCgE5GjL2qUadS1jXC9uzWzZ9KNe51e/5wDC/wfQPENp9DrS?=
 =?us-ascii?Q?c70FPVf7qmogTWWRkQQedutQNC73jQ9aqTJLHu6N/LVuH77nk0sEaTCuqwrG?=
 =?us-ascii?Q?LYKrhGklzz7emwJUhzmXN1COD/vhrdHH4m56AwqvG9Ew8EMqCvrok3ln+M3K?=
 =?us-ascii?Q?cBgIjjjAE3PEJvUpZkjuB4mwMhEByXN/Crbb8ehbiPRtvja7F1G2Vk+AhZyg?=
 =?us-ascii?Q?kEH29YJl1AQcj9M6Z38yx3js9SjMpHi+NTzYfDIY9gkLLtSwTnXTPcqdeanB?=
 =?us-ascii?Q?nwKO2Sj7rYctqJHZc83M4Y35b4DsP3267fhVG4snr51gnIZ5bfvL3EFuYx4s?=
 =?us-ascii?Q?ad/evTKqO/HbZ9r0q1W+tRm+YMePbyDEPsfM2m1k28UJXb9NoU8ewRF7+s5y?=
 =?us-ascii?Q?DlX6vANduPqJF5rRK+Lx/MMRE9zNtRVWo4aQZNA2nids7toiJ9TiZVV/b/It?=
 =?us-ascii?Q?sRI6WVXDFYdIwk4xp7iK5rihGPlKURKZ1ASXcro0K6xq5lQEahLcE6BfRXRp?=
 =?us-ascii?Q?Ia2w1sG3xBua4gybFboj1viN4VUxmpAhuIaL6Rv4fXxfkrpTY95jd5VBJBX8?=
 =?us-ascii?Q?yVXBLMWS8KJHOjhCsF+kxgIHQfDN2k9kOvEfsKdszMP2Jw2jgQy/wVspqgdI?=
 =?us-ascii?Q?eoJIUZWj2bYYojX56e9cj+m1igo0ykYM3SDaSWMucKxxkoa+V54yCcZwnl7+?=
 =?us-ascii?Q?rYyZvqT1eGMnoLFbSg/ypxPCcg3ZJy3Z1PnrzAWyzVjdshD5KS+ly85C65eh?=
 =?us-ascii?Q?hhtk5cfIgq4LtXsMxsjpdgIfL31knNVZo0Zg0Z6ffg/AMxHtThk81iatwBmS?=
 =?us-ascii?Q?UOH95/8552BfmSextbX/csdbkdIBKmy9fMNMoIqXKDntAN3tpYf4G8wiivHz?=
 =?us-ascii?Q?C+0yFUrFEAnp7LY3BRlf6C9AsKURdOuxSFAGIrIFdZPfWfSpvtP7ypfw8jHO?=
 =?us-ascii?Q?JVbh6TAVA+nTrLl/Xme+C3DrXTxkQrXo52xu6LtMdw3gLlBGRXKVjCVx0i3t?=
 =?us-ascii?Q?mrHn9+29z6nDG/ZFJk+ZuWP1uCrZOWgWzSgEXtDU+X/Fqfs7CyMeTZiGrZHK?=
 =?us-ascii?Q?ZHafYYrF+RQSUVzHPjgASh8Q79CMqRXDFhNBPfPbF/dleNbKTvoINUef2iA4?=
 =?us-ascii?Q?FnizBSeCwTcVQA7YVu0XqX9YLHPvSGq05F7w8qH0DzxW2/B5VzXKBW5cXX5q?=
 =?us-ascii?Q?0MKfPMepU59kSny+gSV7j777sP/prMNr3ipYiUfOROe/m/0MiO4If7Fye6bi?=
 =?us-ascii?Q?B/uD8c4bDpgY6uX9FCvXFgRFCQwTi8ADP9FoRgIkEUBXsqMsDbEwb5lwp+yx?=
 =?us-ascii?Q?1V8zIglmJeHl989yLHJMjHgjsIpMxUdZRQEiZhlgw9c7YkIXydUmtzCG0YVo?=
 =?us-ascii?Q?8pSI7zrLN61LhYDXYPF7xHGhCOA+8vm0LhG0qb8RbO0lUvcZIqMKmvdKnJtm?=
 =?us-ascii?Q?8PsYa726UzUvNL0KY00gF7aibXDclXH5UGxayHKkSpgBQD/ifqGP4YgRDPTI?=
 =?us-ascii?Q?NwWJiPwSDBiJRAnQTwsXsrjyuQ0EABicEOwVZ5U3l4LzDEDV0EbqxlOPkYVX?=
 =?us-ascii?Q?qSppeAH11TGOeHMwo64JOSFy6DMGfP4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f415eb-5556-4b04-5263-08da32fffa2d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 03:40:22.3544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVlg0TX8wUGlXpduAh7asMPG7LHKk6omZCLfMOY+VVdYqltHDBFXsfaPmLmqt9e5xRnji9sVZ3MHl43a/UIXQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

This patch verifies another member of struct mptcp_sock, ca_name. Add a
new function get_msk_ca_name() to read the sysctl tcp_congestion_control
and verify it in verify_msk().

v3: Access the sysctl through the filesystem to avoid compatibility
    issues with the busybox sysctl command.
v4: use ASSERT_* instead of CHECK_FAIL (Andrii)

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  5 +++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 34 +++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  4 +++
 3 files changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index eee49cca092a..f882915b2553 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -16,6 +16,10 @@ BPF_PROG(name, args)
 #define SOL_TCP 6
 #endif
=20
+#ifndef TCP_CA_NAME_MAX
+#define TCP_CA_NAME_MAX	16
+#endif
+
 #define tcp_jiffies32 ((__u32)bpf_jiffies64())
=20
 struct sock_common {
@@ -229,6 +233,7 @@ struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
 	__u32		token;
+	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index ac98aa314123..2ff7f18ea0ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,10 +6,15 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
=20
+#ifndef TCP_CA_NAME_MAX
+#define TCP_CA_NAME_MAX	16
+#endif
+
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
 	__u32 token;
+	char ca_name[TCP_CA_NAME_MAX];
 };
=20
 static char monitor_log_path[64];
@@ -75,17 +80,40 @@ static __u32 get_msk_token(void)
 	return token;
 }
=20
+void get_msk_ca_name(char ca_name[])
+{
+	size_t len;
+	int fd;
+
+	fd =3D open("/proc/sys/net/ipv4/tcp_congestion_control", O_RDONLY);
+	if (!ASSERT_GE(fd, 0, "Failed to open tcp_congestion_control"))
+		return;
+
+	len =3D read(fd, ca_name, TCP_CA_NAME_MAX);
+	if (!ASSERT_GT(len, 0, "Failed to read ca_name"))
+		goto err;
+
+	if (len > 0 && ca_name[len - 1] =3D=3D '\n')
+		ca_name[len - 1] =3D '\0';
+
+err:
+	close(fd);
+}
+
 static int verify_msk(int map_fd, int client_fd)
 {
 	char *msg =3D "MPTCP subflow socket";
 	int err, cfd =3D client_fd;
 	struct mptcp_storage val;
+	char ca_name[TCP_CA_NAME_MAX];
 	__u32 token;
=20
 	token =3D get_msk_token();
 	if (!ASSERT_GT(token, 0, "Unexpected token"))
 		return -1;
=20
+	get_msk_ca_name(ca_name);
+
 	err =3D bpf_map_lookup_elem(map_fd, &cfd, &val);
 	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
 		return err;
@@ -108,6 +136,12 @@ static int verify_msk(int map_fd, int client_fd)
 		err++;
 	}
=20
+	if (strncmp(val.ca_name, ca_name, TCP_CA_NAME_MAX)) {
+		log_err("Unexpected mptcp_sock.ca_name %s !=3D %s",
+			val.ca_name, ca_name);
+		err++;
+	}
+
 	return err;
 }
=20
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing=
/selftests/bpf/progs/mptcp_sock.c
index 2a0decd78a0d..52448912fe5d 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2020, Tessares SA. */
 /* Copyright (c) 2022, SUSE. */
=20
+#include <string.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_tcp_helpers.h"
@@ -13,6 +14,7 @@ struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
 	__u32 token;
+	char ca_name[TCP_CA_NAME_MAX];
 };
=20
 struct {
@@ -49,6 +51,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 			return 1;
=20
 		storage->token =3D 0;
+		bzero(storage->ca_name, TCP_CA_NAME_MAX);
 	} else {
 		if (!CONFIG_MPTCP)
 			return 1;
@@ -63,6 +66,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 			return 1;
=20
 		storage->token =3D msk->token;
+		memcpy(storage->ca_name, msk->ca_name, TCP_CA_NAME_MAX);
 	}
 	storage->invoked++;
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
--=20
2.34.1

