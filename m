Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FBE210B
	for <mptcp@lists.linux.dev>; Tue, 31 May 2022 09:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653988239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPpItPyHr8AOCZ7aCBte/4Si/gXU9rjNGCX4IwloFuM=;
	b=elhTihtW8gJWaSixuQfCnGlrSVKJSDu/gIbhP+HwFoexfUvVfwZuziJyEnuI3A+93RtSLH
	8gW1dVV5nDPrDscc2rzU5tk07mTx+seTcGerbrCd1VoUXXQxSgIY3MR6VPz3IlwI2RZ713
	gLwNlkmS83nPAwow6qMON+PWUAHo86U=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-sypY5npgMOOHrDIReKvWjA-2; Tue, 31 May 2022 11:10:38 +0200
X-MC-Unique: sypY5npgMOOHrDIReKvWjA-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fp24A/Kw8INqljj4UPOnS0a+lxKGdUp0ci+Y7qD8cTJn3wawr+eG6TEh9HIrTDKPSOsaFJcHfyjVL8ddyh7qO+lWvMwQebKML5/UwPyzM3KjVFS14aVPVeE+tRdIBuWXzSn4wCjunwp5UKtyGVS1jz0iZquMELRGDr9xMHkmjjY6nd1HG0hbQqT+n7hRXrC7Scy63eYcGm8CzfVgFiCAE3YBTTpfxaYXagMjZhcn1ev3z7U/mZ2WdhfqY8SqK4VGFtg7qjgeE8coI4DR0VlWzscv3WNzqMGh3zDihRykY0gfNI5TfgdEb/ohiw9Ro97GtimjSsFjjn1b9rCUQrO0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ael+io80MwquXOhtY74KR1TipgQJZGlW9Li+R0twraE=;
 b=nXW1PGFzzJCLk4blZSj3YLrVwS+qnEN5Ak090rHf1ACmwAM6hwpnR7W/ipvJdQdKiMsI5amtKX3HrMgvuya7SRIo1vxYnKTtA0wFGm6VIhy+cxwWRIubsdmBSHG9DND78BoGrJotiM8XlIcQjvysfdJ2yHfGK8fw5uD1Lll3qx9yxdvsdJE6gRbFrD41TaofNJNtucGCDVo2W632JsaFp5L6XqeqcRJ/OljS8ADSlaHLlL+KJYJSCUiXGmjDS+rV+pL3kP3icNG3ZLngpNtTB5dpbT9MrDkRyH3p4PSQvX2nLdqc5UhGsn02Xgib1pkiOUrvm/0Cc4sov1C3ykSwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6434.eurprd04.prod.outlook.com (2603:10a6:208:174::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 09:10:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 09:10:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 08/10] selftests/bpf: add bpf_backup test
Date: Tue, 31 May 2022 17:09:53 +0800
Message-ID: <9037c9679144745dde14866e1f975d221df90f94.1653987929.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653987929.git.geliang.tang@suse.com>
References: <cover.1653987929.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dcbfdae-d45f-4a1e-5add-08da42e56c96
X-MS-TrafficTypeDiagnostic: AM0PR04MB6434:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB64340F7CD0B4639FC9F655EDF8DC9@AM0PR04MB6434.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mmPHn6v5SX3VBPoHn1+wdIQh7BVifsp45aVx/tbuc4X5L05kAgglyata6GN0EGOl0f5y7NZxa/J96zjMQxcf3LUKyoPPtrWsuAwS0O4U2f09oWD6rgJlsnbf4+gIyYgdi8279Wd/3E2rIo3+nPW9zOeYdzY3SOHxShqxS6U1et3ukNF0O4yfJArfmz2/7oyN0xUOaRcwD7PnF84JcuKxjixcQLXPQq9pHX2CBscA7CFmpjsh7CNDNNIAByu4qgiffuNBUgNPZZKgSfC0E44cqjBZEdrwaXsoD06G+4bZ0DgLMP0p30PQPFweYKds/YnBwRZu9RVn9svBW4s8y6n1SauqJAYOjgZOkMvGObZY/Fal12GcwkRFpyKs5Jrcn8yHYHowgnzkYNVVCrA2nOkVQd6TZfYf8+8mDn+b4iNT/iCvUxjNte1hlr9mVH/RVHwBMcfIrPJaqOC2JUiLlsIlyw339MTDD4o7n/JJotIE7eYjnZlbRYR29/9d9Ja2Z1WmonrmN12yFwtjhgFmZBYT7/RG4tDK3VnC1eStoF5zJZ1cebl5/iw82+lFi2Uhl8jV5BoJorgxs1Okdb7J+yk46kkC63IO1UCbEVkjY7Z9xoEgFNx+3G8mJt51KLh1URQ/Z+085jM+uqRZYPoqZ8s356X8Ivh/aRGim3ZN8aJwfsMwzAUa/I4CyI7wCoHPM+dI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6666004)(6486002)(8936002)(5660300002)(508600001)(38100700002)(44832011)(107886003)(2616005)(86362001)(83380400001)(6506007)(186003)(26005)(6512007)(36756003)(316002)(8676002)(4326008)(66946007)(66476007)(66556008)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EWSDAl8JcIPWavCRgI6lHOMEeuu3rcS7RKA+2EVROUjxgF9pmXWCBIByb4iI?=
 =?us-ascii?Q?bsFALcrunS7UrM0qleOWNgqvJ0Vem5iTAr3XG8XOeS90bWMEmalBmk/pmQkU?=
 =?us-ascii?Q?nBHf8bJe0X3JN9mA9+0jF8JYQX9XzTox0ZeeiW4ddbEOje7eHY7dpRoBIBQE?=
 =?us-ascii?Q?3yb9MNrmlciQRB0HpN0wnp5iaHFtGE1hnJ5w1FkZRtVkxCLo6ha0JxiqHpXG?=
 =?us-ascii?Q?ptMjtZ6+sOOqS2nHXFEwpy18CLKY9K5eq3bHrziqXakLMvwDl4BONFcevuqJ?=
 =?us-ascii?Q?L1DiToNBiFiL6MvkHyZbUOVNJnvXkq8sU7BN6tJdfO4q2wBdFJdMj64XBSU3?=
 =?us-ascii?Q?FW/BHVylNND+YWb3nfc9mOPid2kk9Aj1MqGvRv7sdcvK45p4n3WqRSgDdXzk?=
 =?us-ascii?Q?aGfdfBaWzSjPlkZmN2BJE/VZUe+ujNfS+S+inqewdnsCGQXj+o7mV4IycZjD?=
 =?us-ascii?Q?ai//3HaRq3dyCMm+4gD4WhwbE1329xbagJl6XhtHJTsKp+yYyY6siD1rjACj?=
 =?us-ascii?Q?EwvJ9zGJm367iJjtKjKfIZAaytbENRKTPm+qNxE4q62P/eSwxJDx+h4Luthn?=
 =?us-ascii?Q?dV6DNsMu/AsFPdkTr+SIfGSLUdlp5EzSRflTS88pyXb/fOmtVvYsWDqlsUyx?=
 =?us-ascii?Q?jU6HlnEVJ+3JY7mQpdlW3+GOhZ3Bj0xsWrCpylZ0EEJkUJOsdq6mDoleeyH6?=
 =?us-ascii?Q?sBBEXsoUeaomF9KV85EL2BO0QyBumTTQ6WxBN5+uQC7jdhdRnCW1Xaw8VBxi?=
 =?us-ascii?Q?MsOrlkNNOPygd71ZaGN39HLQP6MuJlLAAswuTL5x/eylGGgNPTLWMcO8cD8J?=
 =?us-ascii?Q?hF3XBNMK9qkrbTD2eK6FVJ3ytquyyhneLghTNXNbZDxoun+aiTzWRsiZndwM?=
 =?us-ascii?Q?lHy+53Ev+mYd4qZEe6ZT+DR2pamtodK40WNZqsbhlZBkw8FJ9qDAv3wHb9CF?=
 =?us-ascii?Q?2PFIwyQsOTST4EWf7zNRuVcW+IiDD2C7/I4uRcVqzXVXG2KtidJ1aOYsrcN3?=
 =?us-ascii?Q?LA6g4AkNoyOYGz88TxYu69IiRtq0lnj3RaGjIQGEq07NQ7HOi249z4jxW7DD?=
 =?us-ascii?Q?lJz4uZoSJdMke4Gk9AkyHNIzbSXBaMH+h/HSGD8MhfHfNRvRSFVYPAz0uirY?=
 =?us-ascii?Q?4FL4CEXmT//qjh/TkSoB+ALwFfiLBTPXQI72XvH69JQAikepAWcrHjoLZlMl?=
 =?us-ascii?Q?6c94rDncZH6M2RgNc8MQnGQpmkNVtj/oaiTXpg8JPi55YmaFHfRCrQhh36+2?=
 =?us-ascii?Q?jSAIKtIX185gwcXgJ17jGWtklnZ8H6wNAdEBJppxZMH85mft8g2uBtnJQ1Bp?=
 =?us-ascii?Q?fWTL8P23Xc/SdbuxfytExL02M4TiuX4pOQPJDBNWa8QkZJiUf6ee4mQyE8Eg?=
 =?us-ascii?Q?/K98NCmtbhNeMYTJGLc3Mzsypl5w4fRP3nJOrQyjhDIIB/6JKFL7bdhWWawN?=
 =?us-ascii?Q?n++MkAtY6uEvUNNMZk+PTozf8hw8UDUp7ExnC6bVWGUuVWQ3e/K6E6bPHK21?=
 =?us-ascii?Q?Ll2S9VXLUtas4dsOxORMegAi1OwnK9SPc7yF5ufy4W7ErU34WQrJB4jBHsoM?=
 =?us-ascii?Q?U9CxDtKvIfWKVhRluGBdZG6zKGSm69jEGBPme7zmrqgXQHZWc1FJMB8KK3Qc?=
 =?us-ascii?Q?563w4tqh0hCyTvQy1ptsE+fMpmmXenL29l7ycOZGQcxXDlGqS39h4ecDQ0SE?=
 =?us-ascii?Q?YJxwrQGGDQBC3hNSswW27roVHTvStq+Zxyp77sUk+LhLRPUCp0XgTqXQnyLJ?=
 =?us-ascii?Q?hFxxVDsCVfQLFNqGpK2eC3fkOkO+Y4Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcbfdae-d45f-4a1e-5add-08da42e56c96
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 09:10:36.6051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXRPGH3cxphERKESZ5uKNazZvDPXCSLEKSw7s4GVC1WKPMaBBdeaWPjLAv+Qm4V4KiuVBCnNlI0yaXO+MDGY7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6434

This patch adds the backup BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command
to add this new endpoint to PM netlink with backup flag.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index eaea4105728d..f3c73cd2c786 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -7,6 +7,7 @@
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
 #include "mptcp_bpf_first.skel.h"
+#include "mptcp_bpf_bkup.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -296,10 +297,44 @@ static void test_first(void)
 	mptcp_bpf_first__destroy(first_skel);
 }
=20
+static void test_bkup(void)
+{
+	struct mptcp_bpf_bkup *bkup_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	bkup_skel =3D mptcp_bpf_bkup__open_and_load();
+	if (!ASSERT_OK_PTR(bkup_skel, "bpf_bkup__open_and_load"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(bkup_skel->maps.bkup);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_bkup__destroy(bkup_skel);
+		return;
+	}
+
+	add_veth();
+	system("ip mptcp endpoint add 10.0.1.1 subflow backup");
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_bkup");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_GT(system("ss -MOenita | grep '10.0.1.1' | grep 'bytes_sent:'"), 0=
, "ss");
+
+	close(client_fd);
+	close(server_fd);
+	cleanup();
+	bpf_link__destroy(link);
+	mptcp_bpf_bkup__destroy(bkup_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
 	if (test__start_subtest("first"))
 		test_first();
+	if (test__start_subtest("bkup"))
+		test_bkup();
 }
--=20
2.34.1

