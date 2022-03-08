Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E2B48D0
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 13:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646745465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRx4Oxn0ZfItTIvSTEh1fDCulEXmsBGkEMP3HH9xuHk=;
	b=d4mUS8IFHt/zlKN0r6qqC6K5B2kmuKlgRk6O2oWdIFRU9v2KPt9PR6E5eFj+j/oETNCL0A
	n7c9pq+vzUTfTPNHwoiL9OnFgtQuKG40m7cu64v8nIkdgu+NLGG53d0sM27HHX/SneklXy
	VxZbDSLiKyRBaJqy2/pev0GY4qmEzXg=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-Q3XBtItnPmSrfj6yl5Yh1w-1; Tue, 08 Mar 2022 14:17:44 +0100
X-MC-Unique: Q3XBtItnPmSrfj6yl5Yh1w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDvhHd8u4iHZm0+sSCNKErXUD8egXzCPCZBjZ08+gzNeeEvu/Ibelp0IeOgn2jjpUMH5+B4Uo4+/V5189+xkzJRVeVz1iC5wUFrh+b4HnBKPDwNqoulyJKZbLU3DK+K5fUTJ6vuy8t/AY5uCVP0ZbJ4Cr84XHCOEd8hcucz8IllpEn7r6xSYrFQZ+uccNDS6DJ8erO3B9jyWY5l/wsfz8CizBJcWryym6BBAxjKjhNAudbFVADtqIVVUXLJWW/d/HSb+UPYyq6TZLD6V6yRqiqOyjn5OyuGrhhylWBrinYdCzBZKJiIjffZ46OnPQJDg4D9+pfALmuDx1RjIiVuLUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1hF89g2iDSVxNYhpJveLTsC1tqPlS6ENYT+rK341aU=;
 b=l7xhJECuBd1mABsLzWSqexQZGZ3alEo21nOCZbiQ1PblkCPTuVj3d5iQqo+3S688SfbxomGJu0VmmbhumqSRqiZ7fctxwVshF1gAu4t/XbgtWUnjRwiOPoua4i4JbxJD3iCBbqYYnx8HkuHqITHtVxfY7wNTTZcoT9PLr3n0veV4I3LThRMXGIAL/aNSoITgoStemErrnGZ7AWO+ZGr9YimoTbQacvWBHFbtxZ52AyWMf0y6Srs1/nSo+iT9z5P+jeczKGeJTCbj73Y+nU9k7gdnSQ2RiDnzk86Ok/3KgHiCWdsRSP97lTQC5EjXa17eapZnbsaqHLvJLsi9H0aZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8514.eurprd04.prod.outlook.com (2603:10a6:20b:341::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 13:17:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 13:17:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v9 5/5] selftests: bpf: add skc_to_mptcp_sock test
Date: Tue,  8 Mar 2022 21:16:58 +0800
Message-ID: <72ffef207bb0a4cdbce2c1bb5bf9c892b2d9a1cb.1646745228.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646745228.git.geliang.tang@suse.com>
References: <cover.1646745228.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0176.apcprd02.prod.outlook.com
 (2603:1096:201:21::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88d560e2-adf3-46b7-fd3b-08da010606a3
X-MS-TrafficTypeDiagnostic: AS8PR04MB8514:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB8514054AA14230F8DD5467DBF8099@AS8PR04MB8514.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3trF9QqM2KE1dSzxabOVhDOuainBbtVXVWfkg8cn8gbXHK3DNzo9fdZEFP+JJVPzX3rpFnvDpyLbYrZWWCYhygRVS16Nh+4T36NMWtrtqXtVNP5cS+vCBpHpS5sah7B0McztshkXH/9VvV/SHswzSM3reE1GMqNcrYXp7XwJtNpImzictn3XySyPESl37vLb1ElaV0qqkHkco/UYgb399W3bD9HCwBAln1Zu+Sjb/0doXRENHERS9rDnQBHnP4l8IFvyLhlKKLZFmhQTeeCNYJrNKQ0aysJz9JXPDqwuJyXDu1rKFqj4rKwAgA4xHQEoA1UBOpSFx+lcfTphor79tJmg2eAudtH04WnPas00sBqwrHT/UgB9SDZxlZbuRYkPBoi4SGhrWm1np9EtIFEcNEKxfv1TWEQ+ux6p6WsdB60YZYHL6xBnrHmdMPPHEaXKStfGouq7p3xxUlIYYWnzz4r6CoWlEjuBuubEEGRN19x8YrspZH/MsF5usG161YVTb4nj1AuNT35kxIoWYdmNLoem6QNXCzqbJ5+sp11aUHu+M1w11sPUiXoPkTOjTcNFHMTQTlz8qs8iV3ivXW5xfV7n7Lb0tHtbM8cO40Z3FWGjcwOJtH0vu1x/CWL7kY8+1pRYINu083rTdut3nTZc3e186znkV3uxmSmbmNRE2yqLlODUaX3X3OX7pcmxc41vjTzUeKdEQR26CL9gi/ueyn0WmkvOGefF++rNsuwin5DlgqFPBpwgGGu5FnuxvkHwq13c7Lrpbstg2D3Q1XcA5Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(86362001)(38100700002)(316002)(6916009)(54906003)(2906002)(508600001)(5660300002)(8676002)(44832011)(4326008)(8936002)(66556008)(66476007)(6512007)(66946007)(6506007)(6666004)(36756003)(83380400001)(2616005)(186003)(26005)(966005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dCUd2ZkrwRX6Nglk3OS7IwoYiHNGQD8hlwAJ2YOhX9g/UjbpngmXNXi8z+z6?=
 =?us-ascii?Q?Y4RKvZ8+bSYVCm/eH1pLWzGlCMHYHQa9RZ/xGiiI9e/u27Dm7+8OhtXt2EXJ?=
 =?us-ascii?Q?nLQD31jDTz6EV1wq3XIIRAMt8JT0c30LmG8VMAgzNSlhFXBGariDzEIbj+su?=
 =?us-ascii?Q?Ua1ApErhZgyKS8VV7VzXuI04bB3cRUzm3CRoUVXF5vemCxpXMzP+p8dGeGYt?=
 =?us-ascii?Q?VhfHcuXtNpkJYRQmtdb9AdkX9uNMrGRAdlqNmhaATHNcwVgCBlpGtS/8Wdym?=
 =?us-ascii?Q?+1u5Jj7ZwgWkRPv8E0YeP9mdODgug65+ClPnFnpjAfxg24rBN7g6KcxzTEV1?=
 =?us-ascii?Q?fKZncRWz26sVAWZYqmYKPFPONhnICNWmY8p64FwVxC4JRsP03kchnGYvYlj/?=
 =?us-ascii?Q?BJHvqV5gA/5VsejuTiHKgptr0nh+iXaVfaDR9sBR+E3Spxkha4mMLR7bYczi?=
 =?us-ascii?Q?8rtP7xWIFGQIrvzZ/kbIBIovkIIVXiScw9J0W11YvQLpYsDkPcHiHn9WRiOB?=
 =?us-ascii?Q?x3bcc+N3ghuNOEMhgtkOW6Op3ipGVbglq9jPqGRG9PJaAPRBaznTlxEbwbQc?=
 =?us-ascii?Q?Jx+laQoOTDLv41QMJYcQjpHGUGOsnE5yTfIVeS7X3f8SRkhsg7yC56vwT0H1?=
 =?us-ascii?Q?mLcDogRo48Ypq+WGxNNiAbU/HpcmF3wgw4RZa3jrhNtt9fblZ3WBtSTIE1I0?=
 =?us-ascii?Q?KYkXAlpwqlHG34hzrQSnczn7xXoNPptpeQ5v3TtCSwelh+y9+Wbp8bqJHT4q?=
 =?us-ascii?Q?fYdHH0XS1Rtv17syehnzetmxq/GAgbTmoedXvXnLrSsJ76Q5Ykh4RmR1+pFa?=
 =?us-ascii?Q?1AUib3K7GeYCGOPpV730XTK8BF2owtgbvPRjlZ9tB+HrndW1fcy4NhYaSr5p?=
 =?us-ascii?Q?xkLsxf6lMG2wC+pqWMd8agmV9ES5zsNahClfFhRcLZGhafTJTY7O9nRL/q8Y?=
 =?us-ascii?Q?RkLhm39PFtPRRY9M8fUB0f0mpnbTdQz3Xzd2eHb+grUWVOHHfh7kEeSmGJUV?=
 =?us-ascii?Q?37S0MM8AjqHD7qP1TGU6uWDw3mbJeHEMSF94kuMZl1pCa7TodcfAYzri97Nd?=
 =?us-ascii?Q?Sa7jlG21JHzRYHEjTk4ELFcqXG8HyFMp1gmHayMYBrrbG2AX/auhhABz/dAS?=
 =?us-ascii?Q?r4Rh88aApaG3JS30oghYo5rcLbG0hdoy7/UgnLOEahCvjW4uAKs0M2Zs/oTE?=
 =?us-ascii?Q?YSXTBgqu1LmMzhohgwzeBz7grt4ourGRXW34JFmpcUbz7jqVfWs/Flodqy3o?=
 =?us-ascii?Q?MlkJR64sH/zyAq1EOPjjDwxIHWhl8TPfO6JsEoO+ZT07X6EYnXv8hdOaEuO/?=
 =?us-ascii?Q?+wh0NgFK/ojdgvPQxW8+tMuCZjaYqi7WP6O32AZ3llJ2CIw9ZV3HLK3fPDoF?=
 =?us-ascii?Q?aD/fmMGz2JBB0L7C+48J/nyJF1yhjYszhLronYdCgg8tPgpBTzr4xucZqb4K?=
 =?us-ascii?Q?vGHF44SmIwO6AhYeQKvOsZ0c1gh+A9p7BMUgXT0m1mUIT87XvOu2AdFcZwrj?=
 =?us-ascii?Q?yX1PnXFUMuURBmqPv/q5qFdI5/gv5QpXt2r+Xc+8KXZuhPW4EEqV2B6X7D9h?=
 =?us-ascii?Q?xnYsVhFZaWriZ4U1LWLHNXDBXPTqAdd2YoY2c3cfIwN+EeoQJk4lq1fOyWI2?=
 =?us-ascii?Q?zzfoZA0kAwRppt8UV7Eq00A=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d560e2-adf3-46b7-fd3b-08da010606a3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 13:17:42.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQFZ+Dbz3EUd1dsnQoxQVUnJLROv5rt9xnMP2VdBL3h2bcrQs92516/MJHlBUDuXsb1Yl6qwQZIzsg4FMZZojw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8514

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
 tools/testing/selftests/bpf/progs/mptcp.c     | 28 +++++-
 3 files changed, 118 insertions(+), 10 deletions(-)

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
index a14ed1b66da8..c429b6088832 100644
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
+	char fmt[] =3D "invoked=3D%u is_mptcp=3D%u token=3D%x\n";
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

