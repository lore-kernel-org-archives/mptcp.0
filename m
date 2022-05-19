Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21407A
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 08:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652948750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgvF/pS55UHA6+MGqv21qUCJNTkQUGLZgQu4F+baYa0=;
	b=D5/eD8gRKB4vOVynEwahvxzl1hpwyrvNsjVQrBPTbgTvyTeq8lrCt7nGqOEWTAx8YEXdDF
	8KWQrfWANqql0OVOWILCxHLyFm3ikA+srAfXASEeaUL0P0wEOl3kkdwOGCjh7oifBgMOOE
	0CX5sRMRd/VS1loueEvMm6p3hiyMTfM=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-H3NytRf6O5qcTK7jrU82mw-1; Thu, 19 May 2022 10:25:48 +0200
X-MC-Unique: H3NytRf6O5qcTK7jrU82mw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1nv8/u371mVstAidFd7Y8oHVyZQGQzylIBu+Il74TqSMdHv8mA2Ey90KWknul5AEmvU8JOo52XzTgGyrYZrWRSweeV4XgjBoXo10CEfkauEBYysOvde6UuG3Ye0oHx43/gq2iL5LuWRycTjPEZH9Z19C5D/75NFrnxh/qP5Q4zoiSIig/Z6IXDpFcB5KY7KP1GORNT5dv0qXMRzkNKTVazMzaVuP9MlYdpchWZ0GGBYxjHfvPj++1gj4Gg3jsri1TzU66ozQ4aZgWqunVBRaeRUO2fcVK3gG/UONoizb6+q3k3bGmfqLL/eqYfmVafGqRij6lTYJ7mJIZrj/pveGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjS1I7izMMGNCyAWyudWiZyxvBGl5pqmzRA7auoYFU0=;
 b=GBnHu2S52vrxECuUo27T+7ZHYCcfZ60NX1sj5yDhJIfwXObZFXnnzhzJrKhUpxsVLWv0Szh8miQfUzhpeJ/ZDIVERJF0ZBi9fSCOzU0Aj8FED2+ZDH/mFGSBi3KTX3vPGWE6hAxq0k7Zjogx6wbS1DLheEcT09TLsLhVRq/gQnhpcr5uQjhXJN53DpRf7q8kD2g6rifIyWKSpjILoMkFk5FjiJrJIGVVqxISbiSjDdor7P/Ggi3gw6xaFDGcUi//rI9LnySX86Zf186zKqmg/EUrvo4+dYjdIZYWW88PVoup5BKHg7CWsSzv6amxpEdAnhGUwF+MSVOdo5oNvcL6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6652.eurprd04.prod.outlook.com (2603:10a6:10:109::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 08:25:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Thu, 19 May 2022
 08:25:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 4/7] selftests/bpf: test bpf_skc_to_mptcp_sock
Date: Thu, 19 May 2022 16:25:15 +0800
Message-ID: <e3486cefa28998555b99fdc06b815c9512490db7.1652948238.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652948238.git.geliang.tang@suse.com>
References: <cover.1652948238.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0068.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13c4fc9d-cf74-456f-0572-08da39712ce1
X-MS-TrafficTypeDiagnostic: DB8PR04MB6652:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB6652EDBE4DECB75CF11F7D39F8D09@DB8PR04MB6652.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uYG0hxOyAXAGCwvMlHPF8v+s0KlbaQrrHwhhAhwrs33XRzquLJp5UF9dBSjmwk+OHTEmrYo0KSvz21WMHKuecYtgi6eLal6FeMvAqdob4Xfss7qd1yKWnKtVCIOrbYv6T+UsKhPNYpOU0t7qclIi8kUDQZ3gjvkjgVet8TgNSFK9hMOMXv4Uv5qC3QADt4V61I8+vi/uCT0hee0Z8UjbF8RrlJO82goD0+93JOyFuY0I+kFM6i8o7XEV5JytPt71cJu0wfZEi7CFMSNzapmruI7V1tMwkC4VMy6MzpguFpxajYnKl7QFk9RejuYoaiNl2RudnrNKvTcxAqjqcbFfOWBSLDsSQLupVju8TIokP7mZ08HFjSYPjDo4n8Fum6Xm2O2XdXKZLj84tLlJX/X8HFshZtbODUbBgPD6ax+rmwTPvmkbiS/75LgSevBIRvbaWKIX0ZkJXGLjCEOX/83C5wQ4azIi0v1OQWzEE9c3YYG1RjpxhzGTF0PoilE6BpBRn5+H2R7QWHKzPiR4G+sCPy+I41n+t/7qgpv0x9v1BQeKMpX4NSaGEBBqt0yEUa6JfKXwPx6VR2YCwCFvLawvcutGt3tEwRirucyt1Ol+L6egMQ8PaAOUMdHJCLE2KNmLzCHPqleFsmiRDv4c6JVIArX49Z2p7kXhlMCdihMOtdPMWjdjGVdQsqo8fhOMlJZJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(2906002)(6666004)(38100700002)(186003)(6512007)(86362001)(316002)(6916009)(54906003)(8676002)(6486002)(2616005)(44832011)(66476007)(66556008)(36756003)(5660300002)(508600001)(6506007)(26005)(8936002)(66946007)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jmxu04M0jMrmpUDOnsoE/HMr0w+BpjKVAY9ZrjH6/I25hKPrGIhN/F3TJuls?=
 =?us-ascii?Q?QEo2keBXljI5H8mlp4KeIQfYnWgTKJebPTfAo61w4xhXP7kzvzRMTMSpSk7n?=
 =?us-ascii?Q?GK5IonOxHXjW5C9gNIBiuEUMRo67cfw53MXgujcfvuu1zpihfnuxiEX2/8x0?=
 =?us-ascii?Q?cVPi5n9arg2L6VlQfVhz4DJwpkCfTba6lx7E+kYW3pzXr5Bf477/6AtsIcxk?=
 =?us-ascii?Q?5pqPJIguCAfWsSz4ei0I68Rn+Q7XkupdYvO9UzrNYKbcNvxKL//ALCgAtGZB?=
 =?us-ascii?Q?5A7YCXhH2KYptrprFdL5r3qiVaWIerrkNqtskamlO8qlSJTtSZnK83ApIkge?=
 =?us-ascii?Q?v5J4f+pecwyuIJnrBzJf6ukfcIDQZIYJ4YZ6AiJ4BatQid1mDdj4dyj7S3wT?=
 =?us-ascii?Q?wQVdNKFGnN62LGPICNu3ED/iaS0JWEHa3i5Im8FlcNzLeNmlyHRibxWC2Urj?=
 =?us-ascii?Q?37C0zmgzCjEqydkAGbLZXt+4YtnbjZlEwNQFZ+m7OxvaU74psrsn9doSdBMC?=
 =?us-ascii?Q?cBM4BQ6P2pAS4C84pFSYLfodFFjUgiwQ69dVlBPywJTYH8Cd0EFfF/Pzoo+V?=
 =?us-ascii?Q?wV4bLvUJeo2Gghtcz8DikqK4+kkvwyo0H+1weByCHaf7wEU5jSQz9mTS7uPC?=
 =?us-ascii?Q?olblkV9wIbH/+X4IRKRGsP+pytWsB1kL6LGsBZ+mAWkzP0LvxWpSp3KxnEAh?=
 =?us-ascii?Q?YtsA359XPst8ExJOrGAM+jdbkD4QoIxzmj1NDUnQAuR8D3nYyXAj5TMREuls?=
 =?us-ascii?Q?YssA38EClSQQnBYdfpxYKt3WsnKSKboa1hNZ/94yspiALnl3GkE5dt6pHoi0?=
 =?us-ascii?Q?VQ5CRFbVcMyO+oHnFOFkGo83N6zTGCYPezxqdzpTOFXFXTs0Dhc8ncCBCEXz?=
 =?us-ascii?Q?PePL+bECGrTDB5DHydatKPVZZP7JpRQcMm5jf4Et4JOts2QG1JYDwYqHzved?=
 =?us-ascii?Q?yKfrh7Sl96c+8524rxS12ZiGMLQmgoVRZFJZTSzps5jC23gp8Nh3HnOe/OcE?=
 =?us-ascii?Q?6TWE1sQdWG1ZkmH6TwYM1N05ixbHKcJj2+8QVl4iTN1W3HgAFKp8NlZjUPal?=
 =?us-ascii?Q?fANeC//0UNpmtUOYT7YedU8piba3KF8ZeeIGejTymiznQwp0lCZo9IoeEpWj?=
 =?us-ascii?Q?Me8M9Bsg7ivariV8eoWOO/NpsvyLDXcCLpe/8Wh8VVgw00SytuEBRN2nCKj0?=
 =?us-ascii?Q?pBneqCJAF65p11sq8vvPqBthyfPu6OsIEIBWqNQIu4oFPEayeRccyGS4bDnE?=
 =?us-ascii?Q?J5mlr6AQ/N3PjMemmKipJ6UFHfRNzd11AVATQG2awtXwGoblSwtEd/0OTUf+?=
 =?us-ascii?Q?bKNaTl4ISky6G7kxeffYnJ70xAG8V2IUsKXNm3wd2ZAVkYiogvjnCB4GVS8D?=
 =?us-ascii?Q?zauua+9QWg+1IO3S7PIG6uZ2wLbBFkGonqOhF5jCxM5XM0xl25QNHCPAsUk5?=
 =?us-ascii?Q?FBPPyxgi2cflrb3Tsgr/I3qyvzPnS7Ds6PaZkR0wT88oWMEly1KXqJqirGPX?=
 =?us-ascii?Q?4aFaAs93z2kR49gKP33uTiP1ApyZ/rILsoyI1vq0wfwHzCbxeLn+9dRrk74h?=
 =?us-ascii?Q?1OcrYXJsN+DKJQsZqXJZwgvBgtLF4R34dqnqp9TVY9U84UGVRjtQxi6KI23z?=
 =?us-ascii?Q?F83ZrzhA4HC8qlfHvw+5lW32EKGFi9OjcnFB3peCQiGaVTUtqbOc/ZoOD2b2?=
 =?us-ascii?Q?qglOnnt35j+DQf+srsc0FHbgSopkCEVH2sFVPLF8M5tyZ3axJ9SH+Y8mEyDP?=
 =?us-ascii?Q?z7EAdy9eKXiR0KYtEnVwlT6JI9lHJPs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c4fc9d-cf74-456f-0572-08da39712ce1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 08:25:47.6347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJ4K77UU3Ht7lZ0CEdDJMWKpvmXOLU/wMJaJHGqmGRuzOYPT1opIiz/zrdrrZx53vhV7dpzcPj4FwS7XzkvnXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6652

This patch extends the MPTCP test base, to test the new helper
bpf_skc_to_mptcp_sock().

Define struct mptcp_sock in bpf_tcp_helpers.h, use bpf_skc_to_mptcp_sock
to get the msk socket in progs/mptcp_sock.c and store the infos in
socket_storage_map.

Get the infos from socket_storage_map in prog_tests/mptcp.c. Add a new
function verify_msk() to verify the infos of MPTCP socket, and rename
verify_sk() to verify_tsk() to verify TCP socket only.

v2: Add CONFIG_MPTCP check for clearer error messages

v4:
 - use ASSERT_* instead of CHECK_FAIL (Andrii)
 - drop bpf_mptcp_helpers.h (Andrii)

v5:
 - some 'ASSERT_*' were replaced in the next commit by mistake.
 - Drop CONFIG_MPTCP (Martin)
 - Use ASSERT_EQ (Andrii)

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  5 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 27 ++++++++++++++-----
 .../testing/selftests/bpf/progs/mptcp_sock.c  | 19 ++++++++++---
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 22e0c8849a17..90fecafc493d 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -226,4 +226,9 @@ static __always_inline bool tcp_cc_eq(const char *a, co=
nst char *b)
 extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked) __ksym;
 extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) _=
_ksym;
=20
+struct mptcp_sock {
+	struct inet_connection_sock	sk;
+
+} __attribute__((preserve_access_index));
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 7874d8264836..6f333e3aba9c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -12,14 +12,11 @@ struct mptcp_storage {
 	__u32 is_mptcp;
 };
=20
-static int verify_sk(int map_fd, int client_fd, __u32 is_mptcp)
+static int verify_tsk(int map_fd, int client_fd)
 {
 	int err, cfd =3D client_fd;
 	struct mptcp_storage val;
=20
-	if (is_mptcp =3D=3D 1)
-		return 0;
-
 	err =3D bpf_map_lookup_elem(map_fd, &cfd, &val);
 	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
 		return err;
@@ -33,6 +30,24 @@ static int verify_sk(int map_fd, int client_fd, __u32 is=
_mptcp)
 	return err;
 }
=20
+static int verify_msk(int map_fd, int client_fd)
+{
+	int err, cfd =3D client_fd;
+	struct mptcp_storage val;
+
+	err =3D bpf_map_lookup_elem(map_fd, &cfd, &val);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+		return err;
+
+	if (!ASSERT_EQ(val.invoked, 1, "unexpected invoked count"))
+		err++;
+
+	if (!ASSERT_EQ(val.is_mptcp, 1, "unexpected is_mptcp"))
+		err++;
+
+	return err;
+}
+
 static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 {
 	int client_fd, prog_fd, map_fd, err;
@@ -64,8 +79,8 @@ static int run_test(int cgroup_fd, int server_fd, bool is=
_mptcp)
 		goto out;
 	}
=20
-	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, 1) :
-			  verify_sk(map_fd, client_fd, 0);
+	err +=3D is_mptcp ? verify_msk(map_fd, client_fd) :
+			  verify_tsk(map_fd, client_fd);
=20
 	close(client_fd);
=20
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing=
/selftests/bpf/progs/mptcp_sock.c
index bc09dba0b078..dc73b3fbb50b 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -24,6 +24,7 @@ SEC("sockops")
 int _sockops(struct bpf_sock_ops *ctx)
 {
 	struct mptcp_storage *storage;
+	struct mptcp_sock *msk;
 	int op =3D (int)ctx->op;
 	struct tcp_sock *tsk;
 	struct bpf_sock *sk;
@@ -41,11 +42,21 @@ int _sockops(struct bpf_sock_ops *ctx)
 		return 1;
=20
 	is_mptcp =3D bpf_core_field_exists(tsk->is_mptcp) ? tsk->is_mptcp : 0;
-	storage =3D bpf_sk_storage_get(&socket_storage_map, sk, 0,
-				     BPF_SK_STORAGE_GET_F_CREATE);
-	if (!storage)
-		return 1;
+	if (!is_mptcp) {
+		storage =3D bpf_sk_storage_get(&socket_storage_map, sk, 0,
+					     BPF_SK_STORAGE_GET_F_CREATE);
+		if (!storage)
+			return 1;
+	} else {
+		msk =3D bpf_skc_to_mptcp_sock(sk);
+		if (!msk)
+			return 1;
=20
+		storage =3D bpf_sk_storage_get(&socket_storage_map, msk, 0,
+					     BPF_SK_STORAGE_GET_F_CREATE);
+		if (!storage)
+			return 1;
+	}
 	storage->invoked++;
 	storage->is_mptcp =3D is_mptcp;
=20
--=20
2.34.1

