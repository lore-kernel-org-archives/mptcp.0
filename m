Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE2B10EE
	for <mptcp@lists.linux.dev>; Sun,  6 Mar 2022 01:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646528541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KMFG0cyu2D4b32mHfVhpf/0t9RCwhMwt/4tIm7uVxtk=;
	b=eSctqTUCc1wzX/WPQUXW8WUlqJjAPDPIq0FBjB0cfBPLvI8mmcM7U46+B4oZ3U/kDnhdRu
	Z6K511X2SYhabdwm5Cfi6O18dgVZ5ZWM1GHexNxmdYSmJATnd5qinXC/P4pRSa4YUSby/v
	QuseyHc7vXcZDosW73h8dU71XpAp6h8=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-KP_mOJwJNuGMg-ee66mpyQ-1; Sun, 06 Mar 2022 02:02:20 +0100
X-MC-Unique: KP_mOJwJNuGMg-ee66mpyQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbq9q8eOZ4M/NvB5FSpaDZSmz1KLwKB3jryQwe4ukNbR1gZXXKSyUGhg09rv2C+4jPGUw0+THuUNRb5baPhFkzT4GjWVHv6/zbQFsES7f024ZujC/Ody5bdftuzniYTLWQAmvdmeIc0VSz9Rq5BQujD9xoPbx2ngudjMXoqvZHXH/7CnVu8zcq5WcrRYQo3Bo6+DBIwcx9V2D8f7Ru3rKW6a/EQjyNj0dhf1Bdgw1L2VkuiaWaxfmWDvsgadXAy6IAiprmZW7/yT/jQP2HnYYz3/hMuHMsEaM0uRRepiDgudhTauXxOdUf33i3rns1R071tn8dHIk/0J1rBi4d2AqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FA40s9gFb6FU62Q8yhMglXZBRb2+YrdeWGqgjORLntY=;
 b=ca95Em2aGlTtUxhIpCjVl8Ew9kOYG2L6yoO1jIylQKWg0O3/rLWEl51scvPNjDDz6dNXH/VxtoA3g0u/o2ePU+dgyXDeT9MDz4OW50VNDnSYrl2smC+Oiw6YHGzPhnF6vTORex9Z31a3fRG1K+5YEbTtKzE2+RGlfA5g4b3sSQFuukhhDxjTQT+GtY4A5r7t1o3hhp0JPD3fZJWHQ6eyxBNoodhvQhYQu9M9aylbZT7p35dmfLi2VpN7tH+rXJoxSifldjMCbnrPjR+xQ2fLBClmKujsLRNiW0kRcfHOspyw4xxsfl1YIb1NrglJ0rrulDW+n48s3oJWWj1OdB9OaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB5724.eurprd04.prod.outlook.com (2603:10a6:10:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Sun, 6 Mar
 2022 01:02:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.020; Sun, 6 Mar 2022
 01:02:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 4/4] selftests: bpf: add skc_to_mptcp_sock test
Date: Sun,  6 Mar 2022 09:01:37 +0800
Message-ID: <f1b08465b87273f458eaa67df848453fc0e25413.1646528337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646528337.git.geliang.tang@suse.com>
References: <cover.1646528337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 824ce59c-e306-4ec8-0204-08d9ff0cf638
X-MS-TrafficTypeDiagnostic: DB8PR04MB5724:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB5724389310316B536673DC68F8079@DB8PR04MB5724.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	35q2qs6HX131NhXi1pe1Isx9V+vZf+0aaCZ+e1LW0bD//Q676mGhC0VAMHqZ9OW5QY5J5wQ97Pmp+Zng1pwzxt7XUp2tyElrb/RbTgf/C1mPIeUJ4BUMn23Hqeenhr50BQasjM7wqTusrvr+tP2a8A9kx9Hwuvrq1sRiFANM7xcyBxIg13OtAJleiZ+3djtkT9WkNwPPH5oXyesCeBvtrgiK+0PsGHoWxpFdzNPbdv7f2SwU6XWezYZj7mk1OeVNdNG3yVQQiO8cDil/fkfrMbVeHPbuKO5ZBi201AzTHPljk7x+0ZjPceIpJkd+mF40k5KUBSFpsrOP96mgePkOnuyf0HDNJjsi31Ilc3mgJdgbYH3F+HJBIa/GMW45avq6WGc/xSlqy2NKwN6qm8dTqJolNW/ayTYH/FQxg0vBwUJc5s4gfssuAZBTpFAnKWvqWQt1wDlWRC/97jHgONuq5DE6FjpfNCm7i52ShHfpfQAd8ak+d6Ld5c4NTQ3nYwnXsTjflzNQSvPLueWY0safr0B7EJ6WBEfMzTuM3zmUlLBC6bmdPs8Z9RmqF4VJV4tLfshucaxa0yM/2PRa776+4u8PPjzjRsNt5E/tAbfmHETMWWLce1HcqvPLRwJcax+2DHBghWntUJrRtE23ba4SFDBfWU5iimRtc+0AylwM/rj09V0+U0iCKl92YzCrBpIs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(86362001)(8676002)(4326008)(6512007)(66556008)(66476007)(66946007)(44832011)(38100700002)(6666004)(2906002)(8936002)(6506007)(83380400001)(316002)(26005)(186003)(107886003)(6916009)(508600001)(36756003)(6486002)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iz9fwzeGfbnV3u4pjDl6PHT3pTookDTEjZkT4U3LODgk9vv6+BesHf8djMmN?=
 =?us-ascii?Q?XNLNSBtZJlv3E+WdCfmM11dsh+VJ1R7rKW4o/AWuUMMEyU7gnJ91UnzLkx6E?=
 =?us-ascii?Q?DcLkhnyLOeob0YCML5Q8MXZFq8JIgVMWNIGBFBgPa+VyFs6kbDTPZg+HkBIJ?=
 =?us-ascii?Q?iKXpWBzU7SuyfgRB9Cv04A9bQusSWvjaiZR/Dqpe8NX9LeC+uiw2r3Wim0r2?=
 =?us-ascii?Q?yE1N/duSwI8zuKh3I7cWvEky5gfMIim8eoVzjBF5kd3nWi12Y9oQixElYDxJ?=
 =?us-ascii?Q?VIg+z8suW85jaSjCdfVND5tSTYaVo/J3GFNmKkkLnfbleT+0vZzpvzg6iZfH?=
 =?us-ascii?Q?1Ppypn1MD9K7vMAkUyIAEeW0MHcoKqi7j9G9KzAnlTrow2yO2Ii6PJTYK0RZ?=
 =?us-ascii?Q?tNwQNumhTLM5fqr6GHPxCUM4Ze58OFwc5+sZrpA1Nw1LwUxmZfkrMd+BzGut?=
 =?us-ascii?Q?DIL65FqYhgLZ/aLlzmfhW1jvXRkDmg1jb0ZvIElN0SoygvyehrFn23qnYdW0?=
 =?us-ascii?Q?CBnBqNw3tJj2kmTHqcvOFAqcuRWX1rJYKgo8FDvi9V8UgqBlN2tqWMMT2GQ2?=
 =?us-ascii?Q?yuEy2AGj1654yOzdZQ4krRJa1gWXY48tf/P18Z7jQe5fGeB522FHJMNo/tN3?=
 =?us-ascii?Q?vXlGOVv6ehijDr1/0IqgWMfK/e532RhpeESvs5DmvXhr7/KUboAmo9OPDGm8?=
 =?us-ascii?Q?SpBLYIse9DIfK2tPOrEV3jLG6bVm12pVoYcy/ISQjsUTKn0anyqCK0ST94l3?=
 =?us-ascii?Q?8z3DIBpFIse8sDCIPuLGdbmiVmLnPSJMt0IqvPaImnFggl4ASi16Wj/rfN3Z?=
 =?us-ascii?Q?aSl9OUj8akVGm1HC3aE8lwb8n5MrZBV2gdJpMzKECnD1BLcDvVvVSbSQO665?=
 =?us-ascii?Q?nMwnrQMOXBymQYDDZQwDpLRbS76IcUIc46vNOAspQUZsXo9NFVs784Vf4kcK?=
 =?us-ascii?Q?oxlrgVK7Vsbt8InAJd8/wEQ/YG5BP07c0LZJTd+sC7GVSa9qjgHJ3Yx8SKaV?=
 =?us-ascii?Q?vvouvITKSYO5DaasgFObNpudfJnQAfOZaBN1hTwR9VywfL95IIkQ3FKH/mQw?=
 =?us-ascii?Q?FavVGXG0Tw9kmEcm+Mp0sdqqOFaK0X2vaDKA0WlhXitJ5oLRRbAbSCiP69/T?=
 =?us-ascii?Q?swDBR0FRVXDgom5ixWyotMJrv2mh1HndX7hgdiUU25Ils5ULEg6pIrZH+7tu?=
 =?us-ascii?Q?3gI40xHI5FtumSQW3UaZ1SDMhgIZZZIZsVOfcHUM/XD+MX/BQ41wowA+MN71?=
 =?us-ascii?Q?gHP7d5qv6oAWnJFfTegmFor9VU2+g2QPra6VC5vn/xHc2b1/LFxpND3p2jKm?=
 =?us-ascii?Q?TLJcXx2Rtu3iRZZNnpcbJ/tyxys27FDrTlj1PjKesI5rPsYUdm/4iqaORdHP?=
 =?us-ascii?Q?OHmGt9/nFE548LzuAJTXZOSlfkVmE971G1gacs2Az8JiS+yvHzdnmTZ3VNt6?=
 =?us-ascii?Q?ljUjg22MX9NkOYJVyLSE5LRQtknf5PXGXuRT4PcHlZlOaQzmbsNEX5suRKbc?=
 =?us-ascii?Q?EO3nA2a0ZF2/f9AXEnInxvfi34IgWANKCqw941moNKuBoKpv0F4yGl1ZSYzx?=
 =?us-ascii?Q?eCxxkw223+pxRutRJDNeWf+eOAiRmi5+vydhXFNjFtrK7D5Q4Qc9bhNfNlWI?=
 =?us-ascii?Q?/kEkasHIZ3BTbDYv5Xi7OPg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824ce59c-e306-4ec8-0204-08d9ff0cf638
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2022 01:02:18.8004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SUE2kmTu6ZACweglhGYqc7noKYsLJnTlWzCIKruzm3EMVaQnbi8rLDnaGzsK8e1AtCjApUnuI4wwNR/iRq3BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5724

This patch extended the MPTCP test base, to exercise bpf_skc_to_mptcp_sock(=
)
from C test as Alexei suggested in v3.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  6 +++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 27 +++++++++++++++----
 tools/testing/selftests/bpf/progs/mptcp.c     | 23 ++++++++++++++++
 3 files changed, 51 insertions(+), 5 deletions(-)

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
index 04aef0f147dc..ba856956f9c3 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,9 +6,11 @@
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	__u32 token;
 };
=20
-static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_=
mptcp)
+static int verify_sk(int map_fd, int client_fd, const char *msg,
+		     __u32 is_mptcp, __u32 token)
 {
 	int err =3D 0, cfd =3D client_fd;
 	struct mptcp_storage val;
@@ -19,8 +21,23 @@ static int verify_sk(int map_fd, int client_fd, const ch=
ar *msg, __u32 is_mptcp)
 	 * does not trigger sockops events.
 	 * We silently pass this situation at the moment.
 	 */
-	if (is_mptcp =3D=3D 1)
-		return 0;
+	if (is_mptcp =3D=3D 1) {
+		if (token <=3D 0)
+			return 0;
+
+		if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
+			perror("Failed to read socket storage");
+			return -1;
+		}
+
+		if (val.token <=3D 0) {
+			log_err("%s: unexpected bpf_mptcp_sock.token %d %d",
+				msg, val.token, token);
+			err++;
+		}
+
+		return err;
+	}
=20
 	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
 		perror("Failed to read socket storage");
@@ -76,8 +93,8 @@ static int run_test(int cgroup_fd, int server_fd, bool is=
_mptcp)
 		goto close_client_fd;
 	}
=20
-	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", =
1) :
-			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
+	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", =
1, 1) :
+			  verify_sk(map_fd, client_fd, "plain TCP socket", 0, 0);
=20
 close_client_fd:
 	close(client_fd);
diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/self=
tests/bpf/progs/mptcp.c
index be5ee8dac2b3..212e9341b877 100644
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
@@ -20,6 +22,7 @@ struct {
 SEC("sockops")
 int _sockops(struct bpf_sock_ops *ctx)
 {
+	char fmt[] =3D "invoked=3D%u is_mptcp=3D%u token=3D%u\n";
 	struct mptcp_storage *storage;
 	struct bpf_tcp_sock *tcp_sk;
 	int op =3D (int)ctx->op;
@@ -43,6 +46,26 @@ int _sockops(struct bpf_sock_ops *ctx)
=20
 	storage->invoked++;
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
+	storage->token =3D 0;
+
+	if (tcp_sk->is_mptcp) {
+		struct mptcp_sock *msk;
+
+		msk =3D bpf_skc_to_mptcp_sock(sk);
+		if (!msk)
+			return 1;
+		storage =3D bpf_sk_storage_get(&socket_storage_map, msk, 0,
+					     BPF_SK_STORAGE_GET_F_CREATE);
+		if (!storage)
+			return 1;
+
+		storage->invoked++;
+		storage->token =3D msk->token;
+		storage->is_mptcp =3D 1;
+	}
+
+	bpf_trace_printk(fmt, sizeof(fmt),
+			 storage->invoked, storage->is_mptcp, storage->token);
=20
 	return 1;
 }
--=20
2.34.1

