Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838847A
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 08:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652948758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8zg3YY5mfyQ/ku7nm/1A4gLPIVoe0s14JEdN5al1YI=;
	b=cmze/RsV3XxcteFeTQsxqAKzWhccMhItkYkrI3Y23iOhML3viIHQfgzAv57w2i+RG+4T5P
	YZf8I/lV2JbC9ESs8Iz6+RW6A70Cck/GaMaTkWyuwEJa9/lj5OiEKZ7PoFufDSAs+eATck
	4pIRSBVRp7wcQTOWvnSjKhAkvdc0zjU=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-qJNd5V3OOgmAnH2-QEyi0Q-1; Thu, 19 May 2022 10:25:57 +0200
X-MC-Unique: qJNd5V3OOgmAnH2-QEyi0Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnxBL/fFdgzfYx9dJwLwZ833DZArA2xjgOXgjGA5P6S9PZY5fC8HtvzaPrU1GHsAj/nZNsNd7pfY41nk8XGbbyDSDf7C67gzIQev3sKMuF3saP6eVM94BFra6UjnJ5dmJaqRalaekPiCiE8GjEsk1cjOD+5fF3nm/3kiSlbSuI0EsRK4H/fVWSHbvBkVmzUGm/R6DXc1k3Jqj0b7uCxAEH8MLU55c0E9gc37DQANUYckzxDqqYFgVkFDNCh2nSKdaendwri93Pu8SiWQjiMH7/kfWbkpfbofdBhYmExdCQGJHSvNapzVRcNpfYdruHWhHcf3Mpt5OW0jzT48S6ifTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEp3QBiFPz+ifQHU8zVnCYkvGVE1sze0xMGWUaoBSPc=;
 b=AnPsLv8o1yexqTFc5dR6I+2GX00e2NJEPXuq/VTLOHE9xzD1IM+krFQHfozmeQl2nNC1QIL0F7ZIAvLfXQFI6uK/2rHuyIpcZZ0bQ11t2ldLVXjLZkwpeIBZfUEsOZuoOsYyljK39sacRX09iAo6G5lmz5q17IiM1jpz5wR5nGWzZZG9/sN86WZp4NzH+Li8XVSFqqU47k4I2RlngcirYhC1YsxvB4PSzt1CKDbCkOdqREI4XaBj9q1AWTARBJjpXGHKGvWGOnQpH4ojZfE6Q0yk03dGxJEW8njZCPZtsYIIiypCnBpP+kQ2yWYg127QSxJumB3F7CyPGrmwZNoNKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6652.eurprd04.prod.outlook.com (2603:10a6:10:109::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 08:25:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Thu, 19 May 2022
 08:25:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v2 5/7] selftests/bpf: verify token of struct mptcp_sock
Date: Thu, 19 May 2022 16:25:16 +0800
Message-ID: <a1525444fcd318aba7c9adfada109977dbe8e4fd.1652948238.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652948238.git.geliang.tang@suse.com>
References: <cover.1652948238.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 588c8f77-9543-41d2-235b-08da3971320c
X-MS-TrafficTypeDiagnostic: DB8PR04MB6652:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB665230C0069C255FC8CDE927F8D09@DB8PR04MB6652.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pJpYEInc6B+o4bdvGrQfLH813AJVFWKZ/PN5TqIbbHN6xYN+TyT3woLmVZg/yDywdfb2+jcyYzQKhtZ/EnCMaJcyze4KzCE9rdu8/6GZXCQScieSa4gbiN6lSnQB65KpLpObhcIFUIbrCuHJfMVoOzYJ4yYSG7tJxQvoQVZ2Xurq4W99aAwxnhqgqt+vVRlB6rlIOqO5Lwq86YEmdOKmV9UUF7XS/trmpmahunkXXXl98/4ddrFMKCDs+7BQqce8YMDZK5ij2vLnbzhHxJ5HfblQVZwB5uyF3hThKrrYze77KheyTPfc/ugRQemzEn8uT/U1KQJu8aO9WG6LAxB6HjMtph4xIceOKJi+S6ShpUBfSY1J886f2/kOFlQ8x1G3KWq/nZO9/PRkkilVFY/10PtB/PDCPZcinJa5g8pAfG7QPhzbK8SYYYiEFg6i0Nir61uyOH5ARtXP0UHzQlt35Qv49uEILy59yuPbEa/FKjQmub3LnWc4/XoMAxoxkztC40Co0EUY8FwE2vO1oow5LcYb+oVhUw1Q87AeK17mzKC2Y7xNg9SopOdF50pgZ/Y6UkH70ERNvpUo3KtR/jNZ7invNXRgVptg04yE2jIvZNf8MgHn8MvivVB0ixG8DTR50aCgNuwec+/5ipjPFrMrY1Kk9o8ciKhqlYMXtkzfK3puZkzLcsC/NgLBTFmB2nWq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(2906002)(6666004)(38100700002)(186003)(6512007)(15650500001)(86362001)(316002)(6916009)(54906003)(8676002)(6486002)(2616005)(44832011)(66476007)(66556008)(36756003)(5660300002)(508600001)(6506007)(26005)(8936002)(66946007)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tk5A52I8IBjTAXbFNnv2asTGXk0DIMEywH+hVbbPvCQSIxXa/0R2qRxvngVS?=
 =?us-ascii?Q?E+7rXgGcXadbsvH5KDy9aKzhRxjCZ1YWkAorLgDPGC/Uqk6fvcq4Z5x1n7Ir?=
 =?us-ascii?Q?0RNs6MpcUYokOBLqsadnvssaPVtz9wEtc45wkBFJDwD4QiDJd7S+mhYCLCsV?=
 =?us-ascii?Q?zy2j/RRk1g2Qij465A99tTfwvDuhN2uv2pV5U0bJVlqTqdW2wIceOwt+JudU?=
 =?us-ascii?Q?g9bReDD6S1LjtkFxxBtpRKJIGNsgOa6QTuOHQtYpXEaFMgF3/MyMVHlK0lgu?=
 =?us-ascii?Q?VbD8/6KdktYIyp9uGKN7wZZCcEYSXizGGMwPQZmjMF+ASSIWN28G/KZYgs8D?=
 =?us-ascii?Q?kieIJw56PadI1C45Csh9ieUq3io075BcZqmy7QLcRMvyYbDfhJrOEjhIC0sF?=
 =?us-ascii?Q?Vofw5Mui2cbdF7sgQ2yrEwx6yaD543WHPe4WFD/jpX277VDHOj1fVKH30r82?=
 =?us-ascii?Q?1X9kDDi27ncbRFt+0D+QuazDlyE+p/QWb7GMWo34eH1eFF7LAW51Xkfh1CJ+?=
 =?us-ascii?Q?ephrjdcu472IiamwtfhOm9frBGi8137YOat5pmJjq/kfQCZfN6Sakqk5ATTc?=
 =?us-ascii?Q?VcQbma6W+2uHx5VVTbIxIjxqRzrvbMDKSmadlTx/NtzINogGWh9ZjaTkBA2M?=
 =?us-ascii?Q?4pSjVpNx2ByjsYEZNL+8csMjDUH+Q+pn6XHp+Xh6OVrC2kHss3cWI++3fH6O?=
 =?us-ascii?Q?BXBjYIB6DceZv3fCx+ut2CQvV7xsf8mBSy7/0aZ2OkoA/tEHfUem4EpGkeF4?=
 =?us-ascii?Q?TWD49jSmAHHx3Plsui7o1it++N7OZVNdtZIq3uSs7Y4URUKdU2PNqHazr1OF?=
 =?us-ascii?Q?q658oNNc7TL273bQaLbY5pajqREYlY0/631GHBIXZmNDOiU9fbQQoqidI9mv?=
 =?us-ascii?Q?YWSU/pMLEUDTARO810oDQETdcvZzKXWBoLn5ZjVu6cFrvlj4sK/yFgq2Uhcs?=
 =?us-ascii?Q?OKX19ixWnMNNWuew2zVjOqK65Re5pYJNiTftJg1qbvKavTCCU6PWXln1F/DR?=
 =?us-ascii?Q?dfrd5cA6Id0Mr/m1uJ9hfKeDHltFLs+qT73wlVtUxCRW3oC8aP4scVSvCamY?=
 =?us-ascii?Q?BwmhQXODB0293Ro6o28UljjrkTbA3MFFSAXr9sD5SS3exL+dJb6tf55oQov+?=
 =?us-ascii?Q?HAJUSCHApz8tSdVAJUi2sQLUZVL9ZzMasUVo/YPjdzTTFJ+DWQtzCeC2M134?=
 =?us-ascii?Q?GVd60RK8DbelAlu0JH7gDGV2aaEjC/qJ8jGb257FmbOZYFgkjhnH9TEflkSk?=
 =?us-ascii?Q?lv4MQyGktbedmSs3HyasBL9ntdBpm2lRRZbzzlMyicxNrFcIEbnl3JK6VJf3?=
 =?us-ascii?Q?ixOTjjLi2CoiKGNp8WZejMOU0znsPnSJE92x+dT6CYE9JDKpNpBqU0pGMUMO?=
 =?us-ascii?Q?9a7dh4/NTD7e+h4Ld8ChwDtu8aV1zh0PM0oP/dtIYfLeSXmJHVtvLMAzFkwR?=
 =?us-ascii?Q?1/k1Fu8L0JL597CoHwJzxV2L1o8CnpfGfb0GhN6U/amjFPFwC5PBrYa/ia4a?=
 =?us-ascii?Q?mo2/Ryv2yCY7okq+MPY3hftsu36TemygVMcgU4Y19pQYK5QCUIsyb4J3ZtTh?=
 =?us-ascii?Q?tDTmwFJ0VFSbcFN67CaYHI5RHVHodOBGrDOw2aXv9BeVKiiFuLo1GJ1GX8uD?=
 =?us-ascii?Q?lWl7SEZp4ke01FnVjZkvr+nD7ct0FdNh1z5S1SigHVgFQG9nBQdBh8p1GGh+?=
 =?us-ascii?Q?rIM9cFRP9xcwwfIr17s3JY2WDoA4l7aIBtIv2dJe017pJeSUwBBsiEl9QuPM?=
 =?us-ascii?Q?PIv2iH71eqIHj8EsZNaEqNibG1xfiQM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588c8f77-9543-41d2-235b-08da3971320c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 08:25:56.2746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRHzxbuLoPCHGdyS5MQ6F3GKK2IwiIWR3A3j9QhMhCkWFt3/A6kHN4YLSuK6ZNDOx03oz7rmwUs/I6m8+VY/Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6652

This patch verifies the struct member token of struct mptcp_sock. Add a
new member token in struct mptcp_storage to store the token value of the
msk socket got by bpf_skc_to_mptcp_sock(). Trace the kernel function
mptcp_pm_new_connection() by using bpf fentry prog to obtain the msk token
and save it in a global bpf variable. Pass the variable to verify_msk() to
verify it with the token saved in socket_storage_map.

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

