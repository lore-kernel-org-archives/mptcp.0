Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6067C
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 10:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646736497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eFR1AzaJkdyrX6hIUeR7EzmTE+/JyLex4P+J9MrCAEA=;
	b=hYbl8hIgd9us0WNfWRYqkAo9eQaqByrJZ6VmrGITgdyTRA/HNfr4cOXVvjdqGCHx2p1z38
	/I/qAvXYoFNYATMivc2xuV4FI8snFN8M9TUKU9MRE1xdn0q5b2FFxv3CdN/+TdeCPnHfhT
	qJ9PWg0kpYppbYahVYFK0V4XusyFwVQ=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2054.outbound.protection.outlook.com [104.47.12.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-yFuXeKODOt2lZqpIYt0COg-1; Tue, 08 Mar 2022 11:48:16 +0100
X-MC-Unique: yFuXeKODOt2lZqpIYt0COg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b65HuXCfm3pCrZSr4UpDqm7zNpXfN8s1go+OZg4deorhZg9znlj3yH1iK+K8W22LcC8eMdcKn5fWVJkc42voD//FIqXghXoxKF8T1ohAlaXQu8/DRi0x/Ygk2ekoKzozKQq7RIP3DwYdwRYwEUTyYn4Bw44Y1I3bRVhhiGw4Yu/bsazz5U149eY3jPLCW9qXhN8VF4SKnx3bIxjXM+wFsuDSFNh1nwCXWWC2XFtsP8b6J5L/XTKLYrS0Fl777CTN5HmNlVQi1Q+aajIj4DMg1sNNbJixHYyHQPG3+e2+LxPNFthm5ZuvTMxmmHkjan9HetQKo19wUcgrGRjlwdoP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8Ik+yu4hfb2dNb+3xUwXYCW53CcuzHlJQD86QDLtWo=;
 b=BgPizzBFrI+8aXaJnR5m9pv6Pei0zisGxbKCEbgXQ2rsyVlKnHlCF62lwX2pYL4d682L896TDz4+KUbIaqvVLeK6mkgj7v0dFIVraZg7wqt9Ha4XCL3BOTD/MKgLJtZkhw3CoqtmunIZb3x3zvvxQtWoRi9rG2OU3yNAIm4hloDsuLJ0dRmx41sNKT/MuqxRCELSmusZxouJk5pfZhbaR53wbttMyKP3/LtLYLlz+rfKJCFuh+e7DDsL8MOcvh+Fz+/7FZKDsZbJ9iG18kZMQdfuKHnKNp8cQ6nGpnqXozwqKDeqLV6eTxr+YrL7v2+dkrbaQDRuM05ReW0jYQZB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7929.eurprd04.prod.outlook.com (2603:10a6:10:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 10:48:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 10:48:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v8 5/5] selftests: bpf: add skc_to_mptcp_sock test
Date: Tue,  8 Mar 2022 18:47:32 +0800
Message-ID: <9241878dc92e1768e5fdf917049a27fb2898b8fd.1646736285.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646736285.git.geliang.tang@suse.com>
References: <cover.1646736285.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c8babc2-8217-4d16-a6ed-08da00f125cc
X-MS-TrafficTypeDiagnostic: DBBPR04MB7929:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB79291D491D66E6D575C017FAF8099@DBBPR04MB7929.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FN+cFUghYsAqn9JLJSXQmDgi0I6E9g2h4MHuBVwNdk1WgiJDFyuaA4+5l5y1A3sgO4pruBGFYYPt6CL10YdLQDlxYYQ8KMfRc9taYgGeVBWC+L+gAb9uAQAKsa8kl9/hHNySCIBzAHj8K3ykwwkDVtAl9/wgltLhrIs3J/02rk+GvyTqpv1POpTU/h3mhHR97kE+27uHefH06TNOOTUYwInnsTMeQbHYLQpvawPxh+4m8yqIMQAz/xpnRuVq9HjyHHxng80j8zICDwAbJ7eIDnKx2SHrZFRLU3b4Bxjf+vPfIpy75weVtFtFuwwGmL6iVIIOVRWNNqW9juNRZPsnzok2wfc2vOCO1F+t3RGddF9K24nSU4vawmG0/S7bPes+B+H3XqE871eBRZJ7juUOT6GooLmYSjotBlT0W8TbmAwbCaIr8sk/xTOhbsx/0OXzV0cr8jnYS5TmDHj9GUfCAXUgXgzkOOUitewmvY5ES5P7qKo9RiRcUr2dMmuzBadDHt1CfgFJh3rnWkI0eCFGDiZq7VLuyrEl9DjUVMMI7NEJeDZaF5wMyYEo4bzQs4hGxsajMifQpt89gckeYzNopJBcsNoMVXDzeG5xnGoqR77vRj7ZjiQ6FFuZ6OSn7aqmi5RVxuSp/MezDCtNwjY6A0N0S6CGYrnuhtLklxzyNrH4cQdGhlF7vYKRRypxwOEZPAMCobHlBZpeK6CUv32iBjt0F9enBBAHE2AujRFhfbU1IE7VsTjd8BXkyU/K+ZLQ1z+ga9qeDVRMSj0funlXpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(186003)(6666004)(6506007)(2616005)(38100700002)(83380400001)(4326008)(66946007)(44832011)(66476007)(8936002)(8676002)(5660300002)(6512007)(66556008)(36756003)(2906002)(508600001)(6916009)(966005)(6486002)(54906003)(316002)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7jlha6WVq4zX34/DDiEEJlfCIWCPnSIumQx7PV6DyZwXCZpwNgeiPuzgkpKZ?=
 =?us-ascii?Q?3A0aCo35WeGDkFhWcnkaiE3AkXcf2DnFg/jxnCZAeAc5kOiLXhPnOhIF622U?=
 =?us-ascii?Q?GMVUsCrl6MqvCNxHqGuBk/dVob7TR5FTpl3008wA4DodzSsMzqldJDlcjLaT?=
 =?us-ascii?Q?gp8+Aq4R/GYVTI3zorv7YFwSG9D45xXEUpgZf6UroTeZ50ShDoZjhhzP/zgX?=
 =?us-ascii?Q?pGLukES6Hzqoy9QI5ogDl76ybt8WYDAwUf0IxIavF9hNuWXfcGD2+RzA9WAb?=
 =?us-ascii?Q?JtSg0Nhng+RShgdOjOI1+IvxoiueMXo01PH0Y9PjdGXNdDZ2RpInOz1phlbL?=
 =?us-ascii?Q?rqRoYojHmPGfGETSM/qKp/KtnZdZCwGbzgnJPZy1ljZEMC00ER2eFwBimw8n?=
 =?us-ascii?Q?d0mo960EAs1sPeG9BoM5JVYQHpLBX0TKNJ1D6C5gFiH+2O2GqT1O1WlRWyYH?=
 =?us-ascii?Q?KdGj3NdLFCa/BgkHfyVj1p4bFYgpG1BB4WgKu3aUAx2VbHycU3pDiQGw4s4b?=
 =?us-ascii?Q?AQAKNCrJE3TsYE5VoLg1UPd6Al5mn1sE8e1UdZ9PXDjCN5+0aA4s98uGRXtU?=
 =?us-ascii?Q?h3MpihPNVzmp7/RmRdd6olEnb3yOYI/KMGmOxscRESS4DwlnAEKcIHR2p8/f?=
 =?us-ascii?Q?mlAcq8FFdC+KM4aTcb66hWZjfBU/q4ZI8QRqVTqLdiM2vcgrVVkgNScoZUlZ?=
 =?us-ascii?Q?pUyeALHyzGBYYbImud095v7bLsn649ZAXDB3k3yaxQImcKGlYvLyugFMfFND?=
 =?us-ascii?Q?Amabq4W6ilwhd91C1OXmAjAwFrYLwOoyH7Nt+Bx0tbaGLUpiE50Thxu7rVg+?=
 =?us-ascii?Q?OjE2bzar3Uy543yRLKUb14B3LVbzOWuNkN1pFUTGTx8kVJmOfcOjYz/N8s6i?=
 =?us-ascii?Q?26OwhDfjvBWa1lLuQM9VPGiRgc9LEXng3Rbyi2yuaISTMSi4TEDsdzFGS2+k?=
 =?us-ascii?Q?3KVFu+1wHsB58DpTg+SPV6w3LbNLhZprOl7nhXWWPGawlMG1Ebjp3SSpRCGP?=
 =?us-ascii?Q?DdpW+mg76EfZaAeMFJCYgjqFK1h2Y0O706BQ2jPlViq7aBnUWWoZuAHclu3q?=
 =?us-ascii?Q?DEn3JuoJS790DquotRjm5BUcYxTIXTt1kG60av7gVZqaitJjbXPebk+70O0z?=
 =?us-ascii?Q?pWn/3v9lRA2Ur+qh2VGOg2M/NAdCX1AVFJr8MdvYTIUl/K5wguKWVwI20rtP?=
 =?us-ascii?Q?N3djA6VvhRooELNw4d/B8NYg5haxyDHtFe+yPSXKwvd8kYp+GhXcu4mxId0N?=
 =?us-ascii?Q?X+71pNgGOSs3GZlITNtxvW5JUwZQtTzW4iqnT7BUIZgBvilRzt7jiyoNzrW3?=
 =?us-ascii?Q?j7RKh3YI12pfH1yiy+RSUUY3AUVyzZICJ5HUlUTQ3QODqcyI0YZci7a78Myj?=
 =?us-ascii?Q?Ju648Jq67Xg9+oplDhCRws0a1IqfQrw/tE2Z1yR92KYDN/gKC/nPGob4uoKI?=
 =?us-ascii?Q?ACpbC1hFdJ66xpa3i2smVaY1eLztvAAV8xLKE/ufSuD5uW4SCXih4rJtGVpk?=
 =?us-ascii?Q?S/qpmdu3AmBrQ4xDQiXbSl38nA1s/Ltll+x1U/fXsZ9sob6Ky8xGEiLoHvkG?=
 =?us-ascii?Q?eJNvL2ZzjZun/fArX7O0MHLWfa8ViroCdHwoCcaSyH564PlCzACCmz9Pf/md?=
 =?us-ascii?Q?lsrMmuj2ITAzwXPoCk0Ob8Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8babc2-8217-4d16-a6ed-08da00f125cc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 10:48:14.9665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWPg7dv8Hg+ytG6CI9+x5xaQIpMZaZekaef+5LCFkF/6+88mlAvvP2A7l4mmDHhELaiWYoQMzGRjf40nrBJ4sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7929

This patch extended the MPTCP test base, to exercise the new helper
bpf_skc_to_mptcp_sock() from C test as Alexei suggested in [1].

Added a new function verify_msk() to verify the msk token, and a new
function get_msk_token() to parse the msk token from the output of the
command 'ip mptcp monitor'.

[1]
https://lore.kernel.org/netdev/20200922040830.3iis6xiavhvpfq3v@ast-mbp.dhcp=
.thefacebook.com/

Co-developed-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  6 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 94 +++++++++++++++++--
 tools/testing/selftests/bpf/progs/mptcp.c     | 22 +++++
 3 files changed, 116 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index b1ede6f0b821..05f62f81cc4d 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -83,6 +83,12 @@ struct tcp_sock {
 	__u64	tcp_mstamp;	/* most recent packet received/sent */
 } __attribute__((preserve_access_index));
=20
+struct mptcp_sock {
+	struct inet_connection_sock	sk;
+
+	__u32	token;
+} __attribute__((preserve_access_index));
+
 static __always_inline struct inet_connection_sock *inet_csk(const struct =
sock *sk)
 {
 	return (struct inet_connection_sock *)sk;
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 87ee7bd8a689..3dce2431fdf3 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -3,19 +3,20 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
=20
+char monitor_log_path[64];
+
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	__u32 token;
 };
=20
-static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_=
mptcp)
+static int verify_tsk(int map_fd, int client_fd)
 {
+	char *msg =3D "plain TCP socket";
 	int err =3D 0, cfd =3D client_fd;
 	struct mptcp_storage val;
=20
-	if (is_mptcp =3D=3D 1)
-		return 0;
-
 	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
 		perror("Failed to read socket storage");
 		return -1;
@@ -36,6 +37,77 @@ static int verify_sk(int map_fd, int client_fd, const ch=
ar *msg, __u32 is_mptcp)
 	return err;
 }
=20
+static __u32 get_msk_token(void)
+{
+	char *prefix =3D "[       CREATED] token=3D";
+	char buf[64] =3D {};
+	__u32 token =3D 0;
+	ssize_t len;
+	int fd;
+
+	fd =3D open(monitor_log_path, O_RDONLY);
+	if (CHECK_FAIL(fd < 0)) {
+		log_err("Failed to open %s", monitor_log_path);
+		goto err;
+	}
+
+	len =3D read(fd, buf, sizeof(buf));
+	if (CHECK_FAIL(len < 0)) {
+		log_err("Failed to read %s", monitor_log_path);
+		goto err;
+	}
+
+	if (strncmp(buf, prefix, strlen(prefix))) {
+		log_err("Invalid prefix %s", buf);
+		goto err;
+	}
+
+	token =3D strtol(buf + strlen(prefix), NULL, 16);
+
+err:
+	close(fd);
+	return token;
+}
+
+static int verify_msk(int map_fd, int client_fd)
+{
+	char *msg =3D "MPTCP subflow socket";
+	int err =3D 0, cfd =3D client_fd;
+	struct mptcp_storage val;
+	__u32 token;
+
+	token =3D get_msk_token();
+	if (token <=3D 0) {
+		log_err("Unexpected token %x", token);
+		return -1;
+	}
+
+	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
+		perror("Failed to read socket storage");
+		return -1;
+	}
+
+	if (val.invoked !=3D 1) {
+		log_err("%s: unexpected invoked count %d !=3D 1",
+			msg, val.invoked);
+		err++;
+	}
+
+	if (val.is_mptcp !=3D 1) {
+		log_err("%s: unexpected bpf_tcp_sock.is_mptcp %d !=3D 1",
+			msg, val.is_mptcp);
+		err++;
+	}
+
+	if (val.token !=3D token) {
+		log_err("Unexpected mptcp_sock.token %x !=3D %x",
+			val.token, token);
+		err++;
+	}
+
+	return err;
+}
+
 static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 {
 	int client_fd, prog_fd, map_fd, err;
@@ -70,8 +142,8 @@ static int run_test(int cgroup_fd, int server_fd, bool i=
s_mptcp)
 		goto close_client_fd;
 	}
=20
-	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", =
1) :
-			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
+	err +=3D is_mptcp ? verify_msk(map_fd, client_fd) :
+			  verify_tsk(map_fd, client_fd);
=20
 close_client_fd:
 	close(client_fd);
@@ -83,6 +155,7 @@ static int run_test(int cgroup_fd, int server_fd, bool i=
s_mptcp)
=20
 void test_mptcp(void)
 {
+	char cmd[256], tmp_dir[] =3D "/tmp/XXXXXX";
 	int server_fd, cgroup_fd;
=20
 	cgroup_fd =3D test__join_cgroup("/mptcp");
@@ -100,6 +173,13 @@ void test_mptcp(void)
=20
 with_mptcp:
 	/* with MPTCP */
+	if (CHECK_FAIL(!mkdtemp(tmp_dir)))
+		goto close_cgroup_fd;
+	snprintf(monitor_log_path, sizeof(monitor_log_path),
+		 "%s/ip_mptcp_monitor", tmp_dir);
+	snprintf(cmd, sizeof(cmd), "ip mptcp monitor > %s &", monitor_log_path);
+	if (CHECK_FAIL(system(cmd)))
+		goto close_cgroup_fd;
 	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
 	if (CHECK_FAIL(server_fd < 0))
 		goto close_cgroup_fd;
@@ -107,6 +187,8 @@ void test_mptcp(void)
 	CHECK_FAIL(run_test(cgroup_fd, server_fd, true));
=20
 	close(server_fd);
+	snprintf(cmd, sizeof(cmd), "rm -rf %s", tmp_dir);
+	system(cmd);
=20
 close_cgroup_fd:
 	close(cgroup_fd);
diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/self=
tests/bpf/progs/mptcp.c
index be5ee8dac2b3..bb0a9ec534b0 100644
--- a/tools/testing/selftests/bpf/progs/mptcp.c
+++ b/tools/testing/selftests/bpf/progs/mptcp.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_tcp_helpers.h"
=20
 char _license[] SEC("license") =3D "GPL";
 __u32 _version SEC("version") =3D 1;
@@ -8,6 +9,7 @@ __u32 _version SEC("version") =3D 1;
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	__u32 token;
 };
=20
 struct {
@@ -43,6 +45,26 @@ int _sockops(struct bpf_sock_ops *ctx)
=20
 	storage->invoked++;
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
+	storage->token =3D 0;
+
+	if (tcp_sk->is_mptcp) {
+		char fmt[] =3D "msk=3D%p token=3D%x\n";
+		struct mptcp_sock *msk;
+
+		msk =3D bpf_skc_to_mptcp_sock(sk);
+		if (!msk)
+			return 1;
+
+		storage =3D bpf_sk_storage_get(&socket_storage_map, msk, 0,
+					     BPF_SK_STORAGE_GET_F_CREATE);
+		if (!storage)
+			return 1;
+
+		storage->invoked++;
+		storage->is_mptcp =3D 1;
+		storage->token =3D msk->token;
+		bpf_trace_printk(fmt, sizeof(fmt), msk, storage->token);
+	}
=20
 	return 1;
 }
--=20
2.34.1

