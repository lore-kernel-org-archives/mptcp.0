Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791E42F33
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 04:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646712220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cE/+bukQ6c+H3/YUczMf1yydHo74H6KafTYxKky3IaU=;
	b=id85rSStUfYFMMDOiDeYlrVnh+zxI+sbGseRFk+YYRGFgsaD0sGoD6rhza3I/B5KRl6J03
	RMRrkxN0lDKf1/ZHQiIxiHlRimYLX+8R67t+z/12u9umZ8vUhRdnkrSLz8J8qPa1OwZoWc
	XEM0DubqdLBNvnJgGvQ6EagBlifTZuU=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2055.outbound.protection.outlook.com [104.47.13.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-M2rk3_QXMfefeyjH6Dpi-A-1; Tue, 08 Mar 2022 05:03:39 +0100
X-MC-Unique: M2rk3_QXMfefeyjH6Dpi-A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLH+2bxYD2Di62hKKiY6Ilj7LE2BLN1tS+APOEds6MedAICIcErOF5vmTxK141hFUDEHqE/nTDdaTdRc9Omc7St/zzTZOXEFkqvHWzsfZddkRFci/PRj7NRtidTRzJhLUMafzfxjM+S2wqRWBb5FOBI+gBobTBi33T6Ethzq+vRrwnL/XVBuUjGizhjfxOidKG2P7coNe1Vm9i7wGBqnwH7WKykirXXCPezLaS6VGrCaS0s4rXq4Ih1soh1NqYrHMNK3kJ8WTDiJr/6RaAo6fP3N2OZVBDSCHVZt4bHGwU/jMUxtb8RJJFuUTBpgF+bofQZuUcACsRz4GgoOoWPbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+a025eHOvqxteg7kH0RWEydXfkUNHn/mKaHZDzzpSw=;
 b=nQdmWr42laigcf2GrtwyQR1bIhRuFDzcyszF1tISas5S1udvTbevWNc1BWBbaK+qAepGppkjQhR96fkDilIkCWkiJIDe8zUnY0tfQeQ+4hoaW0rKT+2Iz4ydhOAkZSHn3ilZ2JdwHqHr33UhTThaa2VAROsBan0J4Ecy/WWgebHO4jNWokf0qm9gYJWwapwVpUA6216Q9iOMNZGATh9UCcPcuEorI6wv0FwKuiDO/os6oiKrqa8IrrPKSt3+2MDFNnJl8FEOKBGSyupNNvorNu+nAuJZeO2wiRUQJZM6ntCKwzszU9WesxojZ0h3VyH6S6+qujrvQKpipbP+HlYCOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7862.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 04:03:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 04:03:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v7 4/4] selftests: bpf: add skc_to_mptcp_sock test
Date: Tue,  8 Mar 2022 12:02:53 +0800
Message-ID: <522733c62616c526a072ab5f8bc211efad1bbd66.1646711943.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646711943.git.geliang.tang@suse.com>
References: <cover.1646711943.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0065.apcprd03.prod.outlook.com
 (2603:1096:202:17::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59ee8e6f-32c3-4e68-a9e6-08da00b89fd1
X-MS-TrafficTypeDiagnostic: AS8PR04MB7862:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB786264E8808A42A5AC79D5A2F8099@AS8PR04MB7862.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9AGdznzeUwwUPvoqn7crbVaMx+LEzsEmXIv4RXCfqDhcH73kqD9sSBZ/cS95AU3FVbtNZOr7Ebk62ctqWZG8zTbTNXVRL2GNkRLbXITFGJH2N6RT6mk95nT0HTgL4mAhlZSmr6qaL3zYSa23ofGwNvDm7hqtJlqBLZZ786LeLWDJHGzZV3pRy/OoP/0XKgf+F9OucSKfN+WonwXrojUnpJYIqHPMaSITtwJvPTqchuriqp0VCGSoZG2Fg3vWf1TX6g26+ZIf+niPE82nhWkwbrm3a8u/9U7qGkSlm9t9TIZwfEVZXq0kwo/NAkrS3f/NLy/utV4sX2pLx85HGQb3+OnS82MaTw/qz9R2nCvt+yITO476jDi4QQCRZ2TSooSY7nPIO05pN7Y2PRMTLTNrJKuK10IebxDAXZKpBUvpa05zRjtOFtOkRwcNMLYXh2DgPpO6d7EEoj3HrdMMZ56dF2R39dQFF9snTQqTwmliLXtN8hEBl1BHK6MNrUxHyF6U7TUgfGbr6qT2kdWNSwTdIpUJeP6dw0LBKNB6FIcAKUrq3g22ckuHlP5kVL3P8nipmuncTTsdWx0GiKZ/M7h7STP2wnuSxP/1PpzAQvxl4FJztGQK8dyrGhWCyIiKoxNM9Lo/acUXELgmtDTFhtW5M6ylPHnn34IgHPtu0s70t5/a1hMGyfLbBaXILWJbzIkNIEfAZnGxs+TbeVAZc7PBhw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(26005)(186003)(6486002)(6506007)(6666004)(6512007)(38100700002)(508600001)(4326008)(83380400001)(86362001)(2906002)(44832011)(8936002)(6916009)(5660300002)(316002)(54906003)(8676002)(66946007)(66556008)(36756003)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+etE3PCYnKnnvIrTAABZSuIpXBv04cjyIk7zCOI9PPQZTwxm4GWnr2jY9/xk?=
 =?us-ascii?Q?tVQWD+w2rEH2kVF06fqMxfdeRVMhmRqAC/e5zABwYPH9Ea1EedrGgFk6Wo/d?=
 =?us-ascii?Q?RNXGETV2t3QOBrXCkUzXehfTKR2srcZdMkkNIHCEOjnaA6jR97ERj8dZrZqH?=
 =?us-ascii?Q?TEw5cojtmodlJDRgcoOwUkQvjq+Y0X4tZyMV5udRNQLxRUfwX+SE7vIRTAi5?=
 =?us-ascii?Q?rRwblFDjguZMAIWrKLf7TnoaJeHJfwZguEe74fCwo8JSmhWhruFAzTBuyd8d?=
 =?us-ascii?Q?dwLTmqoAa7/32hpoFpDao/HpQt9guApwjh+TTO8xzk7sSDdyxtMelWKv80wD?=
 =?us-ascii?Q?u+kyhwvmKUPVTiQJbghoXbL5rj9VnBNg7hZ+k0m8najOmlQJn9G2OcSCDZPg?=
 =?us-ascii?Q?c05sx79jx5mD3C5Hgfgx6wYOqFM5CgDmfWokKtYa28RjUYuBMHaTR347XE87?=
 =?us-ascii?Q?XnVhbH9IjDr3zxexBPY2vSDDpWYDbyng7cSCTSNxkarSXz2I5ozEbIqz0Yo5?=
 =?us-ascii?Q?+9wqpeJDDAjp1ELjtzto5BfJ8HE7EhWZy5r2qAFMbbYEN4NLojGHkmOwKC95?=
 =?us-ascii?Q?L6XltBAGU69Pjk8hotmhMPDRkt4nLVtEwkQ/vEFvVM/LESaj+2GOWgcFDBII?=
 =?us-ascii?Q?jlxLAGYyEGCofA1LXiuNf/FgOprhnPTEvbYAn8gvvTwRXky9V34iM1r+R244?=
 =?us-ascii?Q?Nl5pvCrqNweZxcU3XgBGnyjt/rgVIiM1SVuXJjIOsMiOfy9hB7+rFaKe6n80?=
 =?us-ascii?Q?iedquxf0nFpsBsyiOFjNY4DitFupXHvFk2o3+xF1XNml35RpI1ZtsYQ7jiUF?=
 =?us-ascii?Q?RIoNfJyQbe191dwHuwQzt9FQIqw5t6FFgvG1g8DRd77BY8oY0Ci1jUxQa4hY?=
 =?us-ascii?Q?UZnbGSsrrMatIlvdaTcAQq71ODoVVGkS9GWxw+WIAXdwlMf+esKC9JckYrr5?=
 =?us-ascii?Q?HbyJ3Wok3+uOZhi9GFxxQrEbl7il94nm5zpfeb86RgfEcAQfynI5cE5DrmIj?=
 =?us-ascii?Q?qQVylLm1GP20f3DQtDiULnRtTwLGV/H7S29Z53wOMX/w+WHANmjyA2sQ+4GP?=
 =?us-ascii?Q?8eJdq19qJnzj4ahLr1Pe+loVRo67nhSXixtL1TBDAhwhc8ckoYJLggJ9dpa0?=
 =?us-ascii?Q?fCK/mKXRHzjwaDTC7Y/eCT1/u5xK/K2bFspGaBNRGTGouFejtl2gFOuzkxfr?=
 =?us-ascii?Q?sgsBxUIkIVgRsv0TOVsgFD2BdaZNbZ7GnMiyPBABCxMv3D3cvRH00Z3N8jpv?=
 =?us-ascii?Q?FQSM/UwMmYn1Gza5ggPq94KbZsLqvzZSLvXXuT4kQUO1yTZlTmyvKlK8JatX?=
 =?us-ascii?Q?kRj/dxH8411gGgALk2gc+WXMb8/ZPj7jkFbqfFIDlag5CWJ6RCz54G66M5au?=
 =?us-ascii?Q?ABvnol5McsIqArO+HkoOLEDoCVX7rZzaEU5LTwAlgE4YADJYjxuFoou4cgfe?=
 =?us-ascii?Q?KmHtSdaDJ4pgcsFxqym/93vLBThpEmDb9sxS/du51PhRivPSQ9w5GbRX+mgq?=
 =?us-ascii?Q?ws2EXAgJKIcxTODIbPQu9zSe27egxqf3qhAac/E2O02cmBIwEITAxUIZ4oYo?=
 =?us-ascii?Q?IwuxX0HyEYXaJfMSp92UZopRJE9T/ntVXscaBBlFHQdeh0/gUXmYIu+yH2qH?=
 =?us-ascii?Q?wfBEf+71bCM2cKa4f/FcnYI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ee8e6f-32c3-4e68-a9e6-08da00b89fd1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 04:03:38.3209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6hxi2BcCXj3UIZFcSzNIaAwYwIYhFl6lAambJHgKDHAMa1OPIWi7KvdM5xtttPUBjZHr+/H0ApeFX18gLRTMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7862

This patch extended the MPTCP test base, to exercise the new helper
bpf_skc_to_mptcp_sock() from C test as Alexei suggested in v3.

Added a new function verify_msk() to verify the msk token, and a new
function get_msk_token() to parse the msk token from the output of the
command 'ip mptcp monitor'.

Co-developed-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  6 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 73 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp.c     | 19 +++++
 3 files changed, 98 insertions(+)

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
index 04aef0f147dc..d60525d5124f 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -3,9 +3,12 @@
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
 static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_=
mptcp)
@@ -42,6 +45,62 @@ static int verify_sk(int map_fd, int client_fd, const ch=
ar *msg, __u32 is_mptcp)
 	return err;
 }
=20
+static __u32 get_msk_token(void)
+{
+	char *prefix =3D "[       CREATED] token=3D";
+	char buf[32] =3D {};
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
+static int verify_msk(int map_fd, int client_fd, __u32 token)
+{
+	int err =3D 0, cfd =3D client_fd;
+	struct mptcp_storage val;
+
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
@@ -79,6 +138,9 @@ static int run_test(int cgroup_fd, int server_fd, bool i=
s_mptcp)
 	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", =
1) :
 			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
=20
+	if (is_mptcp)
+		err +=3D verify_msk(map_fd, client_fd, get_msk_token());
+
 close_client_fd:
 	close(client_fd);
=20
@@ -89,7 +151,9 @@ static int run_test(int cgroup_fd, int server_fd, bool i=
s_mptcp)
=20
 void test_mptcp(void)
 {
+	char tmp_dir[] =3D "/tmp/XXXXXX";
 	int server_fd, cgroup_fd;
+	char cmd[256];
=20
 	cgroup_fd =3D test__join_cgroup("/mptcp");
 	if (CHECK_FAIL(cgroup_fd < 0))
@@ -106,6 +170,13 @@ void test_mptcp(void)
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
@@ -113,6 +184,8 @@ void test_mptcp(void)
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
index be5ee8dac2b3..7ddb73dc69a2 100644
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
@@ -44,5 +46,22 @@ int _sockops(struct bpf_sock_ops *ctx)
 	storage->invoked++;
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
=20
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
+		storage->token =3D msk->token;
+		bpf_trace_printk(fmt, sizeof(fmt), msk, storage->token);
+	}
+
 	return 1;
 }
--=20
2.34.1

