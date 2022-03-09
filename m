Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FDA15A3
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 03:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646797008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JRSfvmr2rahVaKaBCv874QorpD22zdBn0eMfKuehRaM=;
	b=n1xHX1C8sOqKMLfgcXRllWNes4KLdJbt/5OTQti37X/AjFhkF57CPR9Fu+SZ9VnHJc48LD
	yeo0qs640JEJu4b4qayFxCS0L03+EAXVS0AOgEMFJg850URuJF2b/I+qA2dMyyZcUqI7yv
	N1l5cnjt1PMn/t7g3994WGSV+wyWmjw=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2057.outbound.protection.outlook.com [104.47.2.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-M6nN2-GrMAqyawzU_dr3lQ-1; Wed, 09 Mar 2022 04:36:47 +0100
X-MC-Unique: M6nN2-GrMAqyawzU_dr3lQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUod6F/JszpVw3ovCXQ4e6tsGluIkhkOTs12jgxmZUh39nBzwPttXTx4NgZ1XRsAkTVnBWfq0mmmCjsj9AqCWQO7KcICO/CQNG4pOxjv6Bb2YIhb4oq8ZRuWoraOpQU8YgiaUst1e+po5HcuF6gAvfphNy5rvpw5DA4iEepPfQCsqwFZMXktDRZmilcWkEBiweV/JUSXYajQZ3vR/3HDB+GS4tJl0vDvQ+91vuuxtrYINeZFqq/9aReBeabPhLmXWtkJYQJAqoJkqh/5tWeywUY2uASYm6R35s1y6o2J8hlYCOJHUTn8WfdMtMybcmjLgzhm6mmcn8sDFdbWcRs+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBDJXYzBZyal9Y+EvAYpQBdA2LlZmF5M4pf5PYVMiU8=;
 b=VV1w+rjsfWxMxKAWtEJDjhSN2BmSD5eNeXn0N8s83+qk6TEIh+CRmoQsPB4eR4a1zkwiaC8iiq6/SwoESXY/R8Wd29UdgOh/D7gDcSgPAuKKWq6jabJfKORAn8GnCHCxrXd3btJ80tobZ7tgitwbTucCIfZXNWKQT44FxNBYIxanL+RduVk7jz/mqfPgf0c6Ceg5rv5WZFAwSaTlWEfejzr/KyesadaCsVXApO5q6Ov2PuRxpzrL1d/i9GhNCXIZeb5cDdcpBS5PKtkqOG+QV/TG5a9aDf7ObyFYN8I6Tyrp1SnufuQnjazbqjcMV2m4V/51s8w6BKPKyrmwE68y8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6333.eurprd04.prod.outlook.com (2603:10a6:803:fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 03:36:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 03:36:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v10 5/5] selftests: bpf: test bpf_skc_to_mptcp_sock
Date: Wed,  9 Mar 2022 11:36:01 +0800
Message-ID: <0d5df55864d6714df55af8b281d1c4540f0a9678.1646796538.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646796538.git.geliang.tang@suse.com>
References: <cover.1646796538.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0082.apcprd04.prod.outlook.com
 (2603:1096:202:15::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 606b1027-224f-45b3-0c2b-08da017e0973
X-MS-TrafficTypeDiagnostic: VI1PR04MB6333:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB63330D0C2DDACCE7B513C07EF80A9@VI1PR04MB6333.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XY8+6bHiwIh/AmY3HAhVweHtN92llcDAUc2WjuURknFkoTILyKUMIbZp8Ar6tFsietkyvr7rDjySvo3sKN/FsSKmdhtGH/V/aAMJ1Q2STGO72bjibJtViLLj6TYo7UQTaz0u3Ua4T3E1YgHCIUclRW2oTC7Vjb1YioWAYmeeyYPHYYL+bYmo1FfPlDDXhdPl7y54aQQL93q1Tf20l1ptY8DKzO26sumsZ0hrDOzK5oD45Z+gz3dRreObivjd2C6Q8t01VLHdgbItIA2nZbB8wQQHPr6gNCMHE1FGwSQl/xZ02eKdJPBFOXlFrztSvkWnHFIDhCT14pmaFTN1ts71cj5/rFK5QZ0rAy3cRVF1mouezaBVNO5D4qKEWdSmaBVANgAFlqjAao3hfooWSRMTmNNvX8q/BWrcz7vn76QrdSOoCfn9zJDv1AfStThM+ZT0QnQwD+4EEle1dPIgciGWmtlh/kzxv+tEQsRXbRGnVSBmfUOoJ4n42zPApATWQsC8zYTPSD9Y7nDu7SMe6KbjnN5oacZuE8X2eIqA/n/ORwmwQF2MLfp5Ds6AgWim8HJAITCAPqvcQKXI7u6RmvnMFbiIx/iYpMUpjSTOjJYlGokU+M/QxkE+3CEA8WuddK5V3iiHRn9MP32owF+lT5oM+xAk2QisEG+6tUaKxTKrjs236Mbril94n5u7qwMb930m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(508600001)(2616005)(316002)(83380400001)(54906003)(6916009)(66556008)(6512007)(86362001)(44832011)(66946007)(66476007)(6506007)(8676002)(4326008)(36756003)(2906002)(5660300002)(6666004)(38100700002)(6486002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+AvsRrAjJpbvIJRn13JnFSrs4Be2pTvvaPXy5i5WAQg/9LXRCn1sCEl5of/k?=
 =?us-ascii?Q?hBpnIp56/pHoVFJ3RnV7fxxtYMo2k6YefwW7o+Xh5FWxw4yqA92LB8SakXOv?=
 =?us-ascii?Q?vz/ZnYCxmFfZfNsXYTJoCY7iDMIYSFYtboqKmhy9r1g+P7RlwnHX85GqFyl3?=
 =?us-ascii?Q?CFrXecrEq+p7NXvDl2KB4LreJgyfrKE08ZkbwgX/OYmNtwk769JpPNE04pJe?=
 =?us-ascii?Q?Bq25Gg9iyfYhOfwYMEtbCa7ImVZYX2qV2pQQx8ixB7sx2n7cxlzSxmLY3I8l?=
 =?us-ascii?Q?VqMlqgh7c+8FzQfisHIeiBwtVDIYyVUUiWeE/K7NaUH1gb79veXj4nd8pP9J?=
 =?us-ascii?Q?wiGiNUsaXGDuAGjKRDtPIGobvnozr1Dpm+OIAh/Qs1dy/P+aPOniwk8FE7Jk?=
 =?us-ascii?Q?su9P0vbK3VD6M97RCrYWErtBn7xBTD+4TfL5VIkOkeqGJxl6e9hRNaUhAedf?=
 =?us-ascii?Q?hILjUvuRxTPnGs8/XhrfMv0Z/3wRxvmmHzEii0vhmOJx5x79/1BQvk06Zx8f?=
 =?us-ascii?Q?R/l6qXrMRbpIY7YrzgTeCHCawC49itvEIPqzZoHLJne/mawHvo0d+CSUWTf2?=
 =?us-ascii?Q?xBe9qgyNRNzrnlGYryL+KRbf9ncaNQdZ7NEu96fsqJFiYt6jCFy/8K32MD0B?=
 =?us-ascii?Q?ah/V02GotGA7QeAJTmJ9WLvqqLNbCMyKdLnmD2xwvVExsxC0j14QnqUrsihL?=
 =?us-ascii?Q?bCTYBvJyB5Zlk7iYmx9hB8wAjtWkjyL6h1SLuMamgLXMIX7IahtdvPz0jlz6?=
 =?us-ascii?Q?GKE8PecWEsAEkqQCcj50ZO72pQb9ztEjLUf8Sbs4cMA/2/x41PzkDAHcvh6S?=
 =?us-ascii?Q?rv7bOn8w/6J71xgZCHKD3ARlY0Riip4I/HidEEgb3eNP9BzJ9RD9fsKTgOiA?=
 =?us-ascii?Q?63PK26DLSa+eOIj1zIAlV2BLjdf3qiiTgmidJqwvYXfzzhvjcEK2rzwcNivl?=
 =?us-ascii?Q?3ZE9R7D9gZOE7mRvxWtdKJuKrZwCTz0CgdI3n8lV5mlmisyYmX55XGry98Y7?=
 =?us-ascii?Q?SFigUKqwTYmqlmmbbzFY7WqEsusp7tGTi3wYinvYTdM0AIJJt2+VzSqrnXjR?=
 =?us-ascii?Q?mhhkrI95WcBQanBX90hpQWiAPm8xtJ4//tZD0CSFKjGfFHaY6GjaaGXMq341?=
 =?us-ascii?Q?tDMZxdDK1+tPHyyJ/TiQ0KQWfu2Mi0FVHH1aQ8/d9xba/MMtIcklS9Lc39W3?=
 =?us-ascii?Q?+Vds3+aIw62CAhM9HIT2h3+ECt/depjabyyzNBR3yrHx2rf5dX7ZgxW7ivu1?=
 =?us-ascii?Q?OvShcAlyrt/AbfwjllLQcVD02WOb7SdTvqVibOWvqkFiOXGlzToQUU7dhgUT?=
 =?us-ascii?Q?8YjXk/ennwSjmoQtUW3Ea2IgArEOXw8l4kHcMW3DlhAeMBKV2gqOmj5yG9G+?=
 =?us-ascii?Q?V4rGyiGu+dc8ZqJbY48qJJT19yUatP9vbO6i/VPyL48xAGIxhbyN3XRPKHVf?=
 =?us-ascii?Q?UUQYmwyrJGgmKC9afGE0oywghZVL19dCJJWmAhb7pM/mFrleNoeENTxBxSf8?=
 =?us-ascii?Q?2TJSD2eFlLDJD71O7D6K84ZIOuIdxddpPog0A3YQeCoEaAWfZqA9SMaS+KOq?=
 =?us-ascii?Q?6mjrZdIVMrYtLLN637yw2ZUMCrcof/ei1/DtkFrGk0HYzg/uSvO5ztnPG6gS?=
 =?us-ascii?Q?ZO5zu8V7bog9zQkLigiwono=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606b1027-224f-45b3-0c2b-08da017e0973
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 03:36:46.4575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKnR52l6tMjhXxjw5hr9XXqlR27KhjgRE2QKOWFfjzDLvZB0hVwouAm4LWfScl9IqlpwHuF3QtEA9NT2NnaO6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6333

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
 tools/testing/selftests/bpf/progs/mptcp.c     |  28 ++++-
 3 files changed, 126 insertions(+), 10 deletions(-)

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
index 87ee7bd8a689..035a87755b94 100644
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
@@ -36,6 +37,85 @@ static int verify_sk(int map_fd, int client_fd, const ch=
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
@@ -70,8 +150,8 @@ static int run_test(int cgroup_fd, int server_fd, bool i=
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
@@ -83,6 +163,7 @@ static int run_test(int cgroup_fd, int server_fd, bool i=
s_mptcp)
=20
 void test_mptcp(void)
 {
+	char cmd[256], tmp_dir[] =3D "/tmp/XXXXXX";
 	int server_fd, cgroup_fd;
=20
 	cgroup_fd =3D test__join_cgroup("/mptcp");
@@ -100,6 +181,13 @@ void test_mptcp(void)
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
@@ -107,6 +195,8 @@ void test_mptcp(void)
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
index a14ed1b66da8..b08448a12c02 100644
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
@@ -20,8 +22,10 @@ struct {
 SEC("sockops")
 int _sockops(struct bpf_sock_ops *ctx)
 {
+	char fmt[] =3D "invoked=3D%u is_mptcp=3D%u token=3D%x";
 	struct mptcp_storage *storage;
 	struct bpf_tcp_sock *tcp_sk;
+	struct mptcp_sock *msk;
 	int op =3D (int)ctx->op;
 	struct bpf_sock *sk;
=20
@@ -36,13 +40,29 @@ int _sockops(struct bpf_sock_ops *ctx)
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
+	bpf_trace_printk(fmt, sizeof(fmt),
+			 storage->invoked, storage->is_mptcp, storage->token);
=20
 	return 1;
 }
--=20
2.34.1

