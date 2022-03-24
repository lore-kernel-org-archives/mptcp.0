Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277121FC0
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 13:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648128532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1qptPduzbOgvw2prXFerI8UO72ZgQcmHcM+SWjpjn8=;
	b=icX02x87MoCNCRtSc9oRNL8cILrX59AOOSkyXV2lNxYjtl9mJMDwGKVnaaUHQu3oU2moYU
	R+2zmqReJZ5tx4T5QHG6NQbLWHQ0+exswqu5YByKG52e2QoHW6NGYzUJp2dw7zAky+pwjk
	k2IxauHxrb6nXl5IE7wDm+r6qWdROWI=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2057.outbound.protection.outlook.com [104.47.12.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-yY7Ms8jEOxmKPZAToZ28Ag-1; Thu, 24 Mar 2022 14:28:51 +0100
X-MC-Unique: yY7Ms8jEOxmKPZAToZ28Ag-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uen0k/AwuCRv3xtPN2QkEscUuvrZetmRSHzAriWK6wey8xeyPOnlADkmxhJGcUjBCX7M9/LP86nwT5Vnmv3Muv1aecqL4VkyLIpsg97nUnrVFTKuX+BBbP9kzB8LuJ3jHk6UaAGEvzfVbBvra5D5MgdKztqFkOPx3wT5A/mMIFTXazNQvPsMUoBLUN96Qdh9bvOi0m6j8QluuuARIszZq772ZQE3QxTBA4yfUynktUXB5e6rtl8IVnT/qM7jDu9SB5kk14M2JewA+5pzroIkUeHJH5gxdjoYBKPFLMH8hn+WNdXDQXfpeTQYE0OJBNwS1wOHSh0AMlMPjdQTlJvfwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBWPNQH9XYcAkak2fKKijYMljuGx39K1D3CdBfeYV5A=;
 b=Z9tvQNK4RMffGCRff0YArzcwGeqHfGAiNSQ8h/RzxeWxQkGbQP5QryxjFAB8evja2mUkIX1bpRQGZ27MeEcHlNtk/SJ00jeV7CUK72MjtYBmVOlyoJaedOaWW2VNxd0psORRnoopYZo/by/NFc5aV+mVlbatMz1PCIVPa8/SMdCy5rg4CovOFtuNvJRGlYTovN3Kq821+PNP8zr52p1Acny7LcdGP4mjWIqKcQiJZ91em52nSUAl94yvfNU8lM3fWPOdlIrCXt80VsYcpvveVszXUUU+5K+py+UN8sstVGA63/9X56R+SM7lWsPgZAkiMxJ5pvl+rCJJ8pG8Kxcx8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9133.eurprd04.prod.outlook.com (2603:10a6:150:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 13:28:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 13:28:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v12 3/5] selftests: bpf: test bpf_skc_to_mptcp_sock
Date: Thu, 24 Mar 2022 21:28:30 +0800
Message-ID: <917e5a331f69ac896547ac45e2008c962b0e990a.1648128255.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648128255.git.geliang.tang@suse.com>
References: <cover.1648128255.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bd03a07-80ff-4417-04a2-08da0d9a3b44
X-MS-TrafficTypeDiagnostic: GV1PR04MB9133:EE_
X-Microsoft-Antispam-PRVS:
	<GV1PR04MB9133346492A5E34175E5BD8BF8199@GV1PR04MB9133.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AJ27hYTBkvO/u5TyfMlck+Oub6EUjLf8zrzehgRnDWi1Qv5bAoYst5JhNxk3dNrujgXl/hhFLj/krkLaBVPu7MgBjtp3YMm8rC19CUS6AzEVfWm4AtWrqZRyfL+tWlLjjb/FKFgbTspK2zMyGttY9KcDTniqBtV3/ZQFdkeKmJREcbB+7X1TTxwx/wvWFhbaq0MhsfK9e8AuIdr3e0VEa4czYiRyyovPentj2os9rxEPBDL9up4KOm64jSxzzGpol+bbvwZ+OzfZ92a7w7qdtfFTuOkRVZevSJnzIGlz7WJ33jUKWzA8lKgTDAbwtVeUgnEZX7QusuUwxHGs89l3jjZkLD35sBwDr+L2kvO3An61tmGe1KvU3bzptyWHpeVEaAsRkDbvxIMnM7z/XGvRv77WvsJ7HJcdJIRWAFY0gBLnCd9+59okhHAUBDJpEcyqzGKAOpuIY+5tMPIMS0HHrk0hpU4A3mvUSqRZ52aeyU4os0U51ZQb6qkIAThf3ONd10dSn9okNDmWqWmuWF5GY0MeYXHRKouPJnU4HqibRr6a8jbkI7Y8FsBLcEaM824jVL/zlV+SAp4NhyzVtnn31HRHOSw7ERPN7oN/hHLjZirxe7adg6ieqJ+/1gkKizYiyDuOp86IZzVT73Y/FF2is6+MDXaYn5szveqy8nvFXq+8qFh10rYRsIX6sT/XSGOpVpwUA8k1iwg7lqF48BsLIA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(316002)(6916009)(6666004)(26005)(186003)(6512007)(6506007)(83380400001)(6486002)(2616005)(36756003)(508600001)(8936002)(44832011)(86362001)(66946007)(66556008)(66476007)(38100700002)(4326008)(5660300002)(8676002)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Z/GSNB4pKX0sVXHxMTA8b5wHZt7IHBOC/h3Qxt5+luJ+1qtLqZc73cZMGkP?=
 =?us-ascii?Q?qevdOMwA83fcmEP9+Jz3uHqQ7njgsOli5Zo4vYKm0Swe3kPPjs+Sqvdd/OG/?=
 =?us-ascii?Q?KTW7T16DTFS6PAzCU1jaUeLgK0Y5ANT9rfp58SJ/rXPVZPWaF7r3PEVvl/kq?=
 =?us-ascii?Q?X2FDmjWAwNtimyR3XPe4NVJ2TpVpLPI3K8oIj+9Ua1rMgjZmC6AB9DkIiPdP?=
 =?us-ascii?Q?NERVOqUfRaNY3VCdpGqdt5UnZh8rg532zbGeXu4xoT00/DZWxwBzL4cg4FvP?=
 =?us-ascii?Q?VRg5m8W/KnbC+N2oWftffvvJ5JRgAm3hQxlIOznapBn9fFnraegS8hcYU3Ew?=
 =?us-ascii?Q?PN57A2JtwRqupJ1dC6N15kNdg0EDZ2O8O2UfZaXrjM0RPhF7fBcuKsrD6em7?=
 =?us-ascii?Q?iISZVRcbUIlQ12GTstHxYBpaN2ElD/kPQUH5yTh9xcjMyYLO8vOnfQDoLPAq?=
 =?us-ascii?Q?LsKcoE4FPE9G6Ykzo7h8F3tFEiIC3yUrIUPJLX63YR8JLtDdRoiS2VH7/CnB?=
 =?us-ascii?Q?pbA6INs+pouA+tkYivwO3TpZS+5DIWg+97ui+EQKHug0FB8bva2KyCMoAXRZ?=
 =?us-ascii?Q?NMi60EYbrBjNATmP8WIASyvnxU153HPMUkn0xQnZcZMu5OVhGzu3GSw0D97d?=
 =?us-ascii?Q?9b2HzmNmeoQnx2Em1GE0rAry31o+JyNBh4H7C3dxU5TgCJWsq6fckgkeeMOC?=
 =?us-ascii?Q?dfFu9rbF8sMMMXO2qRZ1wyrQJPr8sVAMEVhGmYm/UmfrBmTNpHb+tx28RqqB?=
 =?us-ascii?Q?YwyGtHNHcg57dC+H48McdUUsUFBG3gJYJZtzGgy98Y75KQpvckv22tkp6OXW?=
 =?us-ascii?Q?CuEP+LBriohnAx9NIBZ2urvp2sqJ+zSvWvM9jmc7ufpLMoAKz+puEzHr+oV0?=
 =?us-ascii?Q?aG00jToTk3uSMBeo0PoRaOdQ8OR/OJgWPqQw9MyGZ4xQktwLhD3NY6R1egk0?=
 =?us-ascii?Q?NKi6HciUxsOkOBjn68ifzhMnBE1EEDP+IyBnbT6JjOMIdsDQAG6eQYxMdgBJ?=
 =?us-ascii?Q?CpVsVp9IRWgtMylUpzJUjsu5jD0K8Sw0QPEQt9Yh5W4fbMDZFQOk7RFwBPPf?=
 =?us-ascii?Q?4A6jY88zJgryU6G7GNiRxzJfDkDTb+NOStITkYXLGSIG+qnVxqSEyT3xBiED?=
 =?us-ascii?Q?uHApt06Omh9LtgVUrVr8tTUUuMqMx75JwqTxqxgzqqnkyNZuxeXF7TW2329D?=
 =?us-ascii?Q?kvOhW7oIubqnjfjWCbAKmDOHoeZmoz3MuuBEStdigwLdQbEqpe38SsUXfdmJ?=
 =?us-ascii?Q?JwlRPuSLDleRsxot3Njs5QqZNALQsxm4+lwCcFLhOp6d9IkeZIkfAJ5i5e08?=
 =?us-ascii?Q?CHzcxABtXpudGMoiYtWoSXpRbofDtE+FIUS+9EHjhHDrU1DsuL44tixK7yO+?=
 =?us-ascii?Q?bPp5Mmo8vac3tz51xmX0iK5ObzuTMJEh+qsx5axDD7nOMuauVz1kpCs4Bprm?=
 =?us-ascii?Q?asV25s13isWPwBHuQMGsK5MlL3ISG+Ql4G/EC6+DAwYLMzovMX/zTA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd03a07-80ff-4417-04a2-08da0d9a3b44
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 13:28:49.9596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0gErY1d6uJReIvImt/RGcy23eVvJANbsaQEUliZn+O3BlDHRwxwbWpNDb/CYPg1Cd2ScRGxX1UIGU8WpSOU/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9133

This patch extended the MPTCP test base, to test the new helper
bpf_skc_to_mptcp_sock().

Added a new function verify_msk() to verify the msk token, and a new
function get_msk_token() to parse the msk token from the output of the
command 'ip mptcp monitor'.

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   6 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 102 ++++++++++++++++--
 tools/testing/selftests/bpf/progs/mptcp.c     |  25 ++++-
 3 files changed, 123 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index b1ede6f0b821..9ea6687c8f4d 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -83,6 +83,12 @@ struct tcp_sock {
 	__u64	tcp_mstamp;	/* most recent packet received/sent */
 } __attribute__((preserve_access_index));
=20
+struct mptcp_sock {
+	struct inet_connection_sock	sk;
+
+	__u32		token;
+} __attribute__((preserve_access_index));
+
 static __always_inline struct inet_connection_sock *inet_csk(const struct =
sock *sk)
 {
 	return (struct inet_connection_sock *)sk;
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 5ec1cc4c2ef6..770104dc5448 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -8,16 +8,17 @@
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	__u32 token;
 };
=20
-static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_=
mptcp)
+static char monitor_log_path[64];
+
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
@@ -38,6 +39,85 @@ static int verify_sk(int map_fd, int client_fd, const ch=
ar *msg, __u32 is_mptcp)
 	return err;
 }
=20
+/*
+ * Parse the token from the output of 'ip mptcp monitor':
+ *
+ * [       CREATED] token=3D3ca933d3 remid=3D0 locid=3D0 saddr4=3D127.0.0.=
1 ...
+ * [       CREATED] token=3D2ab57040 remid=3D0 locid=3D0 saddr4=3D127.0.0.=
1 ...
+ */
+static __u32 get_msk_token(void)
+{
+	char *prefix =3D "[       CREATED] token=3D";
+	char buf[BUFSIZ] =3D {};
+	__u32 token =3D 0;
+	ssize_t len;
+	int fd;
+
+	sync();
+
+	fd =3D open(monitor_log_path, O_RDONLY);
+	if (CHECK_FAIL(fd < 0)) {
+		log_err("Failed to open %s", monitor_log_path);
+		return token;
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
 	int client_fd, prog_fd, map_fd;
@@ -90,8 +170,8 @@ static int run_test(int cgroup_fd, int server_fd, bool i=
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
@@ -103,6 +183,7 @@ static int run_test(int cgroup_fd, int server_fd, bool =
is_mptcp)
=20
 void test_base(void)
 {
+	char cmd[256], tmp_dir[] =3D "/tmp/XXXXXX";
 	int server_fd, cgroup_fd;
=20
 	cgroup_fd =3D test__join_cgroup("/mptcp");
@@ -120,6 +201,13 @@ void test_base(void)
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
@@ -127,6 +215,8 @@ void test_base(void)
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
index 0d65fb889d03..afacea5ad9ca 100644
--- a/tools/testing/selftests/bpf/progs/mptcp.c
+++ b/tools/testing/selftests/bpf/progs/mptcp.c
@@ -3,6 +3,7 @@
=20
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_tcp_helpers.h"
=20
 char _license[] SEC("license") =3D "GPL";
 __u32 _version SEC("version") =3D 1;
@@ -10,6 +11,7 @@ __u32 _version SEC("version") =3D 1;
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	__u32 token;
 };
=20
 struct {
@@ -24,6 +26,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 {
 	struct mptcp_storage *storage;
 	struct bpf_tcp_sock *tcp_sk;
+	struct mptcp_sock *msk;
 	int op =3D (int)ctx->op;
 	struct bpf_sock *sk;
=20
@@ -38,11 +41,25 @@ int _sockops(struct bpf_sock_ops *ctx)
 	if (!tcp_sk)
 		return 1;
=20
-	storage =3D bpf_sk_storage_get(&socket_storage_map, sk, 0,
-				     BPF_SK_STORAGE_GET_F_CREATE);
-	if (!storage)
-		return 1;
+	if (!tcp_sk->is_mptcp) {
+		storage =3D bpf_sk_storage_get(&socket_storage_map, sk, 0,
+					     BPF_SK_STORAGE_GET_F_CREATE);
+		if (!storage)
+			return 1;
+
+		storage->token =3D 0;
+	} else {
+		msk =3D bpf_skc_to_mptcp_sock(sk);
+		if (!msk)
+			return 1;
+
+		storage =3D bpf_sk_storage_get(&socket_storage_map, msk, 0,
+					     BPF_SK_STORAGE_GET_F_CREATE);
+		if (!storage)
+			return 1;
=20
+		storage->token =3D msk->token;
+	}
 	storage->invoked++;
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
=20
--=20
2.34.1

