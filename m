Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575231852
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 06:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652854312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmAAt/P46AJDFshvzSJbe0G4hyPuipBGsJJ74pPRjZE=;
	b=QyIaWeNlcjd/OSQ01Z32SybNgxi7Yx0yg+R+4h6/7eCIc+iI5R8bQpgxfdlboENsVWSSyB
	YZH1QX+mpdNeRLxbetzUMfvuT2FtaoYcHaHQBvQAnHenVBnpOCg4Qq8cBnqPbMs+KfaNfB
	AzFz9u5AZPh+Dz9+lBLZ6GYcZ4GduVM=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-1oY-Nh2bMliTDVzB07atQQ-1; Wed, 18 May 2022 08:11:50 +0200
X-MC-Unique: 1oY-Nh2bMliTDVzB07atQQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nx1XpgjZyzI+QIq7COlYcLuypnFfCvFPOFos8rV8k3Abw1VjQ0BJpBAY8gi9kJ3/LhCOvpizRBoIR0JXnYdem+tl8cFWnoqC98tf7+Jd1C419XvMZ44GlzfetaIG3Z02DjSVo63gGfzKRPI1KoEr7sDIEI01xgRCgC8dAeuRJPTEJ1EC7mYk+HV8Bz+l3D0wehENplx93rxgOpdcZTRt4gHTm6LE2IGKT3T/whptGkzQsmrnCyFcb5WR7u+9TfIzXGv0mjm3fWBwXTml4VYwRUNGe2lWMnTJGF2y+zinStPe3q4EHHPn4vKUCP8Na6RGvJduYv5fxQHR3Ft4fsq/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoA2QZPzgT7rUFIOxYqQoWbPyByXXnT6AS9neNTqUw8=;
 b=TmrwoKkn98nn7nsdJaYQ2LTZTLLiEEXN/bH399gu6QE8OLSK4H331hG40QOT0utp2orBrlBHVVZiRESgmjSoLyUNzLQSmcSKUpKmqccw4XaMC6AkuGpnLXIb1pXR8PzFO9a1VvoAfG0toyRqwspugIlPLXKKvOjnRyp2HatipxVpmySxz8ZudBRBfcF+rh3Z029H41K+2QxPuP+e5JqltBQ2oOR2RAGKUAUaq4zA1mDneh8pl+eUwJ646cIsNqnYHIe9KPrIjrCrOXZGIU1pM1+Zx09xfeLQymTa+SiFc4mQRMos2DPEJ5MVNFuvEoi4WGRD7M+v7Lv7aSqbvfkw+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 06:11:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:11:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 07/17] selftests/bpf: test bpf_skc_to_mptcp_sock
Date: Wed, 18 May 2022 14:10:45 +0800
Message-ID: <49fd886aba92d3ae5f6940051fcd5eac03586c8e.1652853898.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652853898.git.geliang.tang@suse.com>
References: <cover.1652853898.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0024.apcprd06.prod.outlook.com
 (2603:1096:202:2e::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10ac36a1-a383-4929-35f3-08da38954b65
X-MS-TrafficTypeDiagnostic: PAXPR04MB8256:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB825647AAF406E1FD9CC158E5F8D19@PAXPR04MB8256.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+0dUhnUfhU7MugFg8mTonKIhOrKQ05lced3eivV8vK8bNosUnGXWR2eTHIgmt7slmvcE2r55PqM9BnVfGxqzYPKPj7d1wqHO2CJkO1q+NQTB3+7zZnPLh6rGGB03reCPYycqiG9EthePMbDANu3/ScpJl4UG1040+s5AMyY3+gZ5x1PtTKAxt5eB/ZlyjWjgK2K6/wdA5Gvw4V/bAv93PCdWruaCoAepX8se+2DvU/fsIrhJysRFFS9vWFkll4fipB4WqtyqBC27uz4H0AkPcHDpDfBSOR6pnqpESxs/eJ1n470uNeEQPB6za6M6S61x0/v+tw+z9jQzhQGjzhmQ8YWHN4ywj95XU9LYv67ERCkAucu8JI37dM0PW0kzKMq2xFks+YrcBXKYxJR+R+f1ka05j4WrduaZkfcSx0S2ikmDA8k/1gZC/7aEtMXTkaExjcNnMimC+ycGAVWKHAIo/63CWtvKlSrS1MCTypx/R3MNwqoGhA5Ws1VmtDg7HaVgoIAKI1z0ClVHs4jgIo2fFH7jmuQRJXAk8wgy7lBSTnnWo8WYlbJ065qllsis2AyhoAETayOvESjAUPtvYq+ccLPhDoP93AhCPQk3LUxwX0dlwpRNJ9GissfrpqwwtEdmKg4l3tTLUfE87RE8bl3grp/FbrDANQTFnhN1qpCRna3NqdF/CLjZqwbssdjY31fg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(66556008)(6666004)(2906002)(66476007)(8676002)(4326008)(36756003)(66946007)(316002)(6916009)(54906003)(508600001)(8936002)(38100700002)(5660300002)(44832011)(86362001)(2616005)(83380400001)(26005)(6486002)(6512007)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bUru/c7csjXuMbuZxxvakRR//XtRlaYXSJYRSiGWE5Rh5QcbzjOIOq6CPzs2?=
 =?us-ascii?Q?+Vz1LgvNQvtgAxVg4QudjMtIAWqqoffhiFo+KAGtvYjDb3zlk7ecPc5tr5+H?=
 =?us-ascii?Q?Z+HLBGcthuiuqpsdrkzlKNHN3MHrlW1tSyNEPPtY7zMNAEx1G7QVzDtMNTap?=
 =?us-ascii?Q?qsAiMR3mBhlZUcMAzrkkvaaTNHrhny5GeEYuz44uT5IbKlG01JacRxS7xRQS?=
 =?us-ascii?Q?TKjg3xspc7GDTzOOdYuXuGDJaKq/3KToQEwt9XmqF/4TUour+DbCuaIYehJo?=
 =?us-ascii?Q?cz61IrgkkybhP3wuO075IcDx7gf61XVnidi8+9rH1qbDFJrBS8uKW3LGWGuC?=
 =?us-ascii?Q?kq64t3L7vj1lJQEVlaklRY/8o0Z5A2lq17J6KmDql6/CZRgYWrCg/h0CRYLS?=
 =?us-ascii?Q?CQsDxxr1kHVQBqvm/u5LuhFL2co0U3qmxTzR9Kp3qITojeJwYLBFsC93xHS9?=
 =?us-ascii?Q?uriLRYGQW3VIR7o0zT06S45ALkYLrTRAVu/zTdcFR4LqubgwL9cD27pgOnxJ?=
 =?us-ascii?Q?BSl0bte8g+aUfTfuvLxVKmmrYB25YulWyOTyXgF38cvuXuF6Qf8aE2Kg3+bJ?=
 =?us-ascii?Q?79p/Rzdt+s4x7k79VS5FP1HlZ1qzDxgbmM1qDwlywUzAK21nEpcYkKoLXn5R?=
 =?us-ascii?Q?P2tx+XNdOgz9JavR+FpGtt7oo8yZoAZR3wAiVH1xWw/IxE/w2b+mLo3ivtev?=
 =?us-ascii?Q?rmtSWBzHhR1aFBlQL5mH6lJcvXtrXBOkdpGupZXYoG5IE44v15Q8YO4x+QYa?=
 =?us-ascii?Q?xWFXSi0mVxXJFapL/v8FH3frGWLdp0TJ11BAWM4UQ8Abbh6406VFuhXbW0/h?=
 =?us-ascii?Q?0KD2+VhvhNtCEIYSYSTuFhzLiMOZhFnlvdheQrIIw3dC3HBxFMMVTa7rvyqm?=
 =?us-ascii?Q?bm7elkTm4Sf000gazh23yGFUespMn/df5gnrmjNLTJoFVZNreIaLrQhMEYGh?=
 =?us-ascii?Q?3S0CBZK9xqvER5TXMnhClBAooUsvBDMGw/ksI/J5mOXhu2GRfK4/IFgu38IU?=
 =?us-ascii?Q?j0dogOM5+2QOn1RKmv2U/uMo/+J9pktUlTMlMFz5CS8aVbnHE4uR25JnFO13?=
 =?us-ascii?Q?2jBaShRSEsb8u4JDR5nwsVv81qAmdoXg6Pcuxk6g64v7u27vGQR42P88y4iQ?=
 =?us-ascii?Q?c6DeXU23pIR4DJXlBDP1grzTH24gSTnJFC8qIzkzZQXvew8tFsRtxRD2f48+?=
 =?us-ascii?Q?ss0kCkL9vPZ/mJJd6fGTNAba9w8ZarsiGUhr7pPBcWp1nIznck6LUIR1HX1s?=
 =?us-ascii?Q?WgYgdb4nNbNt1Wk0257NQlMJGQaIqR5Tb7JsrMW6mK8hmLJIatXEecXWZTis?=
 =?us-ascii?Q?4tHrPxOi8YYnq2Bp9l3qcfmQgMiVLMakS3X88WIZfyU/hN0r/27cSxhIPRAl?=
 =?us-ascii?Q?MpyhlQG6QQvC0tqhPdACRkVn3qSRVJReU7PXS7ebvdYvTxHmCNMyeUk7vwm8?=
 =?us-ascii?Q?Zhgm3KN/osOUxY7R3JSyG5Az0j/Xx11HT252isMRdaMtSnrS1gJy6r/a7CHt?=
 =?us-ascii?Q?YFLVLNrF0YpJs+9y237va6mBVr9R4Euj8AsiGgx+uPBXXmU1jyqOZJxadJ1Y?=
 =?us-ascii?Q?VBHXY9l4aw7Dq5vD5bg+bveNUWoWJXRDuqdsQmtfz9ckaxhDTuRWBn61KVKS?=
 =?us-ascii?Q?IF3LkQ959L3iUWzXrPUS6YPsLarOm/XSLvucmcXA+eu0PqHy7Y1LD4OPfn7l?=
 =?us-ascii?Q?WvLC+vd6KMRUEeA8rQEoVXQfGRVqBK8XQR+28XYXVgjqTkFdJAbzX7pRcDOg?=
 =?us-ascii?Q?PXMgiaIF9hWD50CQD4JRuTH09D1LqZk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ac36a1-a383-4929-35f3-08da38954b65
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:11:49.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okxZ08xq1StbRj5SFAwDnV6d9ZUmHSTPa95pDRbVohc95x5jaFLgYCgyf5dAzrHlj4gA5+/UVQJ4uf0hR1NwbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

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
index 59113eb982e0..6f333e3aba9c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -12,14 +12,11 @@ struct mptcp_storage {
 	__u32 is_mptcp;
 };
=20
-static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_=
mptcp)
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
@@ -33,6 +30,24 @@ static int verify_sk(int map_fd, int client_fd, const ch=
ar *msg, __u32 is_mptcp)
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
-	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", =
1) :
-			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
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

