Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E39362
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 06:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654066044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/1D37CrJPvZzbxiZMvJq3yVCCtd/NboQN/xO+EiniM=;
	b=NfEGU6BlSHs5rk+ON2i98ry65ObcGiQnQoC/vlnugEjlf04DthB2k+dhr0acT7DC2xI1MH
	sRjIjZqtSmIN1i6n6yaIoiNmLfG29NP9Ck3dopLtM5A79bWKD8oxvBmzYKWkdjQkrheOwE
	IASByPI9jA09bbYVBHGD7+8KHH1QRKI=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-CkYcJQYPME-VNARcsuDbow-1; Wed, 01 Jun 2022 08:47:23 +0200
X-MC-Unique: CkYcJQYPME-VNARcsuDbow-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8Ql2Fh5X9n8MMiPHV3vuAeXoinvje44t4KU0ZLezfT1HcC+nYDkxdGO5Gh7HCXmsRvHW4+D8WAgtjKFxWrqky/k27FXEHoPe6/edPfQbAGMqqbYxfc40zPnt24yPip4MYYPovQEdW3Bf22epcuTJ85t8PvmiaWWEhtB0SK0ss0hzjmNsfQV9VRHMgWgOgZ1UTsQfdsbswf43gYnGmGD3eJxy002DWkODJ9ssJQAp6hVlIlXBKLUTW5WRkBSadM+eD3hc35YtIDlUJIUhlEHMoZRytW+XDRdlqMq0Ib9HGdBbdrueyJ2CYv88ksPJzgvkMW/jFbeVrfPVc8oPMHr+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdN0/NTSngD34hg/2mAz8TcUJyKmvrSSKr9bbGv39HE=;
 b=MrsFJvFSh87voTJZyfvIUItMH8/eaJtAbi5qmzj91H9ARkEuJTnc6XUF87J/5o4hs7+8N5jbZ6DVM6wDKwJLOC/4BFVZHwf3bEGc4MfRErRVIUB2K0XM2f9tV5MoHs4o1ZYGwUdvhHolj7O3MryL/Nv0Thpiq3HTzbaihpU3e8Z6WdiS/WK56zBXiixhJxXFRySGOydfkf80BtZz/NWZwarjE/buXCQ9kqV5QN5K5Jb5TOZz3vDZ0wjT7bxUf7cln0ULOJlw8eUwvS59lBu0BXCl6D9NF8aXfTHXkKEn4gSG/q042RUELJtV2cmEwgmPEEY9qqMkqkxukz3GydOceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6904.eurprd04.prod.outlook.com (2603:10a6:20b:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 06:47:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 06:47:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 11/11] selftests/bpf: add bpf_rr test
Date: Wed,  1 Jun 2022 14:46:00 +0800
Message-ID: <076285ed7f05ec809cfb5866c6ff2d6b8cd04e95.1654065674.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654065674.git.geliang.tang@suse.com>
References: <cover.1654065674.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0069.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a56608cc-622f-4f2b-981e-08da439a948b
X-MS-TrafficTypeDiagnostic: AM7PR04MB6904:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB6904102AA11FD9BA4968E55BF8DF9@AM7PR04MB6904.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qtr7k/nlC/7ipxjLVAtyO6MzEZChX5ZKi3wpTLyRaZlg1ERpSPvLxeg13J4q24YVrslH+3tKi3oUKacTLIAEHkLRBb08AWDjU+5/UO1ln2f1atOolVS8GVvINjysRqRzcHIarx65kmtNUNvU2jKGYt8AzwTY+jC/UFqYGcZKacPl3rGqyh4hBCid8vcaQyOlaNn6vMNRekQa0wgNd2Eapf/xvQ9VZG7Q3iGTI3m12k+xsGZ6nHEdRVzlQpNuixZvP0Z/QIQnfIGao1uNF4+TrLGfxha89+cguiwX3B5KYi7p8kUdHEJREVFF9x8+GlWdJZ5YEg37uo9PWpCISQE4+52N+Hym4Sw+rKZNF3IGkGGekFmPu/TeOMQMSXjddDxiNKJ/1Us/BbS3Eyu0aenEXJFsev3gRlZoifqrHhDQ2gLoO2rgLN0Da29ERCPKX92OkfXASFzRspjrAQ5y/bCrcC3ikqUf8qHVzDxTHwoR7fwU9qEazgGT5xVvr33ZPp+HxnfiQYG2Pn6t1bqX+U+i3uGo1a4F/xYnhveCgn668UmdmotL5GI35JmilPIsNady4tRNwhjQHOjum6xLLHTWSGD/eYfdDzWghvJCSE8wVEe5mCKvtV9nYSRUdLUIQ5hhzgFHnxYFFSc9X//05XNMu6axE5En1A5w3+LaY2BCZblCX54ng5M9yArLo0HGJMm4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(107886003)(86362001)(6666004)(8936002)(186003)(38100700002)(508600001)(5660300002)(44832011)(6486002)(2616005)(6506007)(6512007)(26005)(66946007)(66556008)(66476007)(4326008)(8676002)(36756003)(316002)(6916009)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0vubwzqWGoL4y77eO+0SfV9oFTdCPjO6I1ftjcb5ug3C3sD/SD531io2Xv7V?=
 =?us-ascii?Q?mEbfT9Mwa6PaA55wyb1Z65MgMUE0fqmI/Jf6z4XavQtuP8d++3qU1XnGAK7Z?=
 =?us-ascii?Q?fW7bNpcN7D1ywctpa5NAQwC4HRjndGxDU7cxaX2+Z4HdGxj7rEkCwwK6vnh0?=
 =?us-ascii?Q?SYJS0XALPRPQV0myAgbUeFTvujLHTcTeEYRqKv45hS2bUGSEwK+RWh91DLQa?=
 =?us-ascii?Q?hafBwMhFlwhApK/o3tXSSGXlFnkb+w19kxT+vGrIXMIV7B4FlS54pC+r4XjD?=
 =?us-ascii?Q?XgfQuMLT3XKkjd2j8jsJsnAKbpiq1mzy2BBdEAybhkoS+PuwhnB7PFGK+lT4?=
 =?us-ascii?Q?Bi68aISl6RwFSPq71a3UfL/hTKsZNxly9lEIdTBSahSeC6IRyLnnB0tHFxjJ?=
 =?us-ascii?Q?vdiKPC0SBhONkRvOWSQBaIu78HUZ1W0fMRaEnn8tk9TbGEbrXlXi5mmUNyKz?=
 =?us-ascii?Q?whUnB1iuEzRAOQqSricznbwWxcuwyBGCjVo+/9SWAqiXCKNQPaqMYYNOf0U0?=
 =?us-ascii?Q?9eeQmiLuBlHqOevaewSoISvmRSn4CQCrjU9Stk7ABGdpqBvEHDuCCKL7jITj?=
 =?us-ascii?Q?H9gqKOME2dKa31yIXi3YdITkZ9bFWhLu+pboQFxdPwU9levUhxE4YFLRDADC?=
 =?us-ascii?Q?ODSo56nonTQhtV4oz9182oNbPasuXMepWFRGAF7zG4AcrXLMm02ZoXSidE/O?=
 =?us-ascii?Q?3oNsTXkCiPo5bnDM640DNifv3mHBVNZC5uSfipBlbmiJrNil63zvjQjU3BdO?=
 =?us-ascii?Q?SdHKiCu7/MkbWa9O1ZHPQdkBR47pvX2a5UTQnZEq8PBU+BAvoQTqkbjEk3lY?=
 =?us-ascii?Q?VCVzO3n6CfOHdCNmkdrUTBOAttWZ+qcLw5DrnbbHQQ4aklFAtF2c4KR7dakV?=
 =?us-ascii?Q?FEnOiqDmOrQwnaGLQB5SjoM6Wc2QVLksBUQFyUtfezY00J4LK+JsYLywFb5V?=
 =?us-ascii?Q?eWLS+2nporyKA0IdmWJutcMzp0U6gil9MMSo1qywr1UQxh/VfW1aHrtEIZjW?=
 =?us-ascii?Q?oob8ksT8dpjex49Wiu/fOaBS0ZoMxUKL1JY4F6FlLnNjzeG1N7Nl6ZvgsD+g?=
 =?us-ascii?Q?+DKKRxw1yeuKToDQ6eMtEHxUOiS+c5y56jKmRxu+ehBQU2Km+a/T8/QpzJtM?=
 =?us-ascii?Q?2A0fYYDYYU1tMt2LFyt4soFAfARYZMEpSpv00cMH5kV55DQ/bJRsd+KLkEQx?=
 =?us-ascii?Q?wltYBtsVsyp3wtzpEXiUHt25fOYQc5Ub81phHrkcF5l3B63bIOv6xHv7EpIM?=
 =?us-ascii?Q?3Xg+bzYD87GN4j25gk+LKRe5FUFff15ey7oxNEPpmo6y+QazEnrGWHVm1flV?=
 =?us-ascii?Q?JToNlSUJEWylb+BZUopH5JaCUp1DoDbWUQ3S5t6fUALTkRkyQnF/F8YsfhnP?=
 =?us-ascii?Q?N4hsvPLinhRRgCEg+xW9CL/6IA8MVevycerDpifYvRla8nnyCdiXUk9hsXTT?=
 =?us-ascii?Q?ZekqEhUZz/y6zBWfzBMTMN468y2sO+LslebYb52PV/y4+B0rgQBnbgIS2FD6?=
 =?us-ascii?Q?sntueGyVfbKKI2pGEH2nP/4o2CBVCOIy/6FGw1+aPCfcWCVtoVycLbdo1rRd?=
 =?us-ascii?Q?PFzJFlNUFMn+4wOTn6LnbcSJYLtVPZH0LIRmhcvzsaps4oAzJzR/mNO6BxPZ?=
 =?us-ascii?Q?xb1LyXFgKBvnoFg2hPZI1VTW0gkOkUzj7asvZDtB9UYAwWmDb0JM+TD+Qlfa?=
 =?us-ascii?Q?z2XPPM6SzvEPA4K1VNtMEclk5IlOEXVJurCMvsJ/gMM8lCWKleREwPUojTQc?=
 =?us-ascii?Q?s9BEKjvgWhSbwAWHnwuE4/vzJwbBpj4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56608cc-622f-4f2b-981e-08da439a948b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 06:47:22.5984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lspLpqVM5XEzyDWpnowWoY8J1R+XRSRs08x0blQHE5ieq/DG697ifeeOoTEDvvXCkyHBmagxEF4iTF/VP6tS+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6904

This patch adds the round-robin BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add this new endpoint to PM netlink. Send data and check bytes_sent of
'ss' output after it to make sure the data has been sent on the new veth
net device.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index f3c73cd2c786..1ecc8a2b76b6 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -8,6 +8,7 @@
 #include "mptcp_sock.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
+#include "mptcp_bpf_rr.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -329,6 +330,38 @@ static void test_bkup(void)
 	mptcp_bpf_bkup__destroy(bkup_skel);
 }
=20
+static void test_rr(void)
+{
+	struct mptcp_bpf_rr *rr_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	rr_skel =3D mptcp_bpf_rr__open_and_load();
+	if (!ASSERT_OK_PTR(rr_skel, "bpf_rr__open_and_load"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(rr_skel->maps.rr);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_rr__destroy(rr_skel);
+		return;
+	}
+
+	add_veth();
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_rr");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_OK(system("ss -MOenita | grep '10.0.1.1' | grep -q 'bytes_sent:'")=
, "ss");
+
+	close(client_fd);
+	close(server_fd);
+	cleanup();
+	bpf_link__destroy(link);
+	mptcp_bpf_rr__destroy(rr_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -337,4 +370,6 @@ void test_mptcp(void)
 		test_first();
 	if (test__start_subtest("bkup"))
 		test_bkup();
+	if (test__start_subtest("rr"))
+		test_rr();
 }
--=20
2.34.1

