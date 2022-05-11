Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC028F3
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 12:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652270996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXskkd6EmNPp2sPDlg+georMaMOfeE9PlXRANa/fCkA=;
	b=JaSQ2K0TCKFmAsLOYotOxqCeWQvoYOypEsuapirTd2kKSkXb112zJ8rwW0xlpEBAucvVVh
	HrfdYarpqmSOJE/4wdB2H/Ahagwfki7WjeyX4IVKm9S/F/b2Ca/TzgKQikPIcUFDbbcF3Q
	OZZMjSi3RDJKO2KS2iikgaSt5LN5ZIs=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-ehjnSJ84OmWzVxevgojpFA-1; Wed, 11 May 2022 14:09:55 +0200
X-MC-Unique: ehjnSJ84OmWzVxevgojpFA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqMXVREdGB5X1Gm514XF4aiyqmhAO+C0ELcI6kzhk2LUUOrR6caFAczbe96a8yPsD3Bh+Gbgqf1OEygf0VqP2HsM8KpSuv+SJk4pePNVYJqoD159wySOhV7MGDjOqS151R0ezNLE7dTYy4pPh4cMBfNT3Wm41rQMQYDBJpii07kEHraeNsXnWcJ/tOErX0X/dWtGE2KIzzrTYwQSUnBnhFeWSrd2mhYEHHcpLwf8QZc47Jjskt6Jt5atXWuZ439l7sxZL3XOdozHrtVygfQMbDED+KHUFerEp5NEKVcje31sjiThRU3V8AmnavrgKb4sNh1/D60kO/I2tsO8TlvyhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y5AVj/dl0ZNDPR6FiTrg0YR0FybnCX9am+puDXpDIU=;
 b=PsXrf4Nr2lLIuZC1OBwVmqJJRNYE1V57m45mjI5zVCyVx7+dJoftfK4+rzJFSXO4v/CL5jwUeP92/h7atimBkdMrqpAms9SmAPXNl3zROuMo9rXMrWxu8nRoQvS7uLYORNnSF4gMzEWb49iQPboJ6Vod+Js6DkRUou/OQvN51EO4XpynkI5jicyWbBGvGE//QdaPlCGe9Ma7F4qNo1BLYplGwZFCtTrPqq8kDz0TCB4i4NwD3MUAPH3tf0Ad9x0h9HF118BaRT74Fyd67/znohXHcTx0Dx7QZlVzAYxJvkacmizZQtEWSd6Q/yvLI1tEO6sfC8mAS5pnrFGPFS/G3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5716.eurprd04.prod.outlook.com (2603:10a6:208:128::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 12:09:41 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 12:09:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 3/3] selftests/bpf: add bpf_rr test
Date: Wed, 11 May 2022 20:09:09 +0800
Message-ID: <e3d31fc19246a91423fca7c497bdd0f661470e36.1652270663.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652270663.git.geliang.tang@suse.com>
References: <cover.1652270663.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0208.apcprd06.prod.outlook.com
 (2603:1096:4:68::16) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3500afb-2224-40f7-5eb0-08da3347208b
X-MS-TrafficTypeDiagnostic: AM0PR04MB5716:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB57169972FD64A6B7882BF4EEF8C89@AM0PR04MB5716.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QeBesuGHzEHdmtdAnIxAiPLjzPI351iX0DYvg9jl2M2ezdC/NMskx0tCH1JMxcLJeU0OW8MMJQjDTtPZZHn8S5oXpMLBS+GFUo72f2EhBlWy93MqRAEYvyoBmXKcYmwr1blM6InO8T7hvPW+Z4HTL2q3XaXFSZpvm0BCFKCH+qoiQZevri7QEN2kXl3u7rAzUTKwtUkYxMwRsI6nJbkDkSGMx2hXB968Hj3miZpxi/hxI/e2PWaFh7DejKLJCDp9xu0F/A7XQ5jJebcbVFjsBjapXdJ+pGyTJnbeziBuq22Xc1QstyNnrJKvykDIgd4U8aewa6DPiGWxtGjYYzYN64rNKU093YQQGMWJ14RFbin/SixwaGHzmiFoACQ/IN1rfJAdGjKb1pUNNZJKulCvIJMIsVKc/T8yiKcpIA+bNYquZdjuHweuVtMy7lfsRgzYWkt2bGPWamMErmjVFrMhAhfTL/hXACr5Tgi59m0AywGyNJzj7dqy7eIWRSFMEOo1+xRB/iaQ/ie+S+mb31OKj3zzU0L9ipym/ibve+bdX2ib3qGr5XeGQ0qBaL50YpfrujUhSD4rKMaYx012yAAHzYtLIQrtUe6nua1oOvqHXbXUj6v0dyHrBAxZ40gPzqUAamwHbQivy2AeXAsHvBP22ZHZT8XUtMCzfUCX0qubdXawI+jaV1qsCUNajGxTijvN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(8676002)(6512007)(6916009)(316002)(66476007)(4326008)(38100700002)(66946007)(26005)(83380400001)(5660300002)(6666004)(186003)(6506007)(2906002)(508600001)(107886003)(2616005)(6486002)(44832011)(36756003)(86362001)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PsDh0OhzrU73jFJaRFToIulJmkJ3/ST6wvHmV/5b381hm+QJB9LYM2QF2X/v?=
 =?us-ascii?Q?lwePEsGvV8MwRRnXS7d/F7MsbN5il9LdB1ffx0oqmfbfPC7+a/ABbGbEuW6O?=
 =?us-ascii?Q?7BTEDDzfzwokbzOaHzcYuMA8V1Ifkncl3ih0v7TqR58iLFeM8RSq8IE5GLw6?=
 =?us-ascii?Q?aW9DU2kxmfVoDk0oLhSYUprQhQ9YnxXSW4RL2x3IJ5TezQuIEdpRI9R2Hyif?=
 =?us-ascii?Q?ioNQTgYut5NXaTBJrXSKVtx23UsjrjItmdV2GGS7w8OgbGaCMn9fqJfrx5OO?=
 =?us-ascii?Q?fsYzTT1yFbE0LhTCzK58WgqXTVfuEJN+nXphTkuVeyIXHHUByNCuWuG1N9Ks?=
 =?us-ascii?Q?zYu36g0l1vTNlOU0ZH4bL5uW4iExg8YIL0DOp6MdDot8Ca2GZUBkpsmUAOIg?=
 =?us-ascii?Q?pVisd42FmZKbYUTtvCNYAwhS2w/bEsBZAUxp+7cYBcqhVLfieKIolLzcUtlk?=
 =?us-ascii?Q?UUaFDJ7PzBCiY6J8znvpUnIiFJnDzC7NHsBNGUAMW6xxnAy04zuN3sS80Jp7?=
 =?us-ascii?Q?ppibBmZkhz+sCImlgxz8QIE0oZ0D+kNRi1+VXH4clCIYxwsVe461/Q+8Cioj?=
 =?us-ascii?Q?+Mlw5jdfYIiHKME/06o2fyDt2fX1a/uIEW+FVph3IzzVxy39qXIYuxLZQpmW?=
 =?us-ascii?Q?jSGkwTFvdhd37Hy3LUamJQLMB0kZYUScHsRvUKIVc/xGgFe58WspPQNEBm6v?=
 =?us-ascii?Q?FmqEQdtHmZDVKCpcv6qjtaVSzxwdBYIwpRzvvjHC65wmdo9yVaKoh7sk8DQz?=
 =?us-ascii?Q?k3uIUs77A7ABfajnWF5w4BlEkwEf+2OgkYz4gXYr2xiXaTp0uyNwTBWLsEa1?=
 =?us-ascii?Q?Sm6/X91NseHTa1QdAbKa1oNoGY54oHeaDdN6ToySgLBs/WqUJ8VFrskXEzdq?=
 =?us-ascii?Q?Pj6ad1M3+ykSf42BhF1e6Zp6x9mQj6bIyKLtEWconFuKfIfbCUYh4bF3I2Q+?=
 =?us-ascii?Q?DvvPIGERjiOyEnrOkYyCtFHrA0k/+jC1mFUEE9TxMVL4XBEh+zv+LxFD5iPl?=
 =?us-ascii?Q?PMsVbSYOqcqzuEHn2fukKTz5n0mSBc5YBHMzUyIuJdPeXJUUkC2FmvgK8PJO?=
 =?us-ascii?Q?NXvbiW/lpB1GicjLfqUomlRwZfvpy8gQI19L4YuYsYCVAsBRIZ+lNAca6U1W?=
 =?us-ascii?Q?hMqujiIUVgtaNjDR5tVLIL4+Yegl40+HbAqRg5AAkQJngS7XabB10PDGipjy?=
 =?us-ascii?Q?8MCpZDMtcswvtl5dYGqqlcpRf8qd6dQxRoRknXnh+EG3CjsCOGZUU3QplLZO?=
 =?us-ascii?Q?9eNUmDYv1J70K+4aJQ2vsOF69vdp7PiBC7nLvG24jKrjF52/oi7Ii0DdPDt9?=
 =?us-ascii?Q?GkV9JtUGTyu+V+esxnpVnI62Q622EIBK8I5MwHJfhbgRDS2RUftvoh0R9/pS?=
 =?us-ascii?Q?pAvmUnVvkhKXkLoJ9iWx1aZUOmsFRCbpMnrXBoPEPV9nKfo/CNimWpw5h4s8?=
 =?us-ascii?Q?b1w8MqKZo/TVZFSArPwBupt2R0zSkH2d62a8tNOrF3lXCnWWlLLcFv+II2e2?=
 =?us-ascii?Q?lLyi77mHKSFwF+24hhQULqXM4t+do7UMNOBtLu6U7w8O5DET1u50fAjnxM15?=
 =?us-ascii?Q?sX+tcKvJDmQlMSN7fT8h1JBne8yuzsku9tcHJ0aYC2GU3agBcdsxU/KKZm0e?=
 =?us-ascii?Q?avn1L5o4AvtaZ/RzqT00dnJiOr1HxkV68Zhk8vaNtf1OtqXqikz9ENvevByD?=
 =?us-ascii?Q?d95uGubMNQraUs0Z6ZzQX0cKG2y2XJnR9KUPz3QQrIai/O/LECk8xDozOBQo?=
 =?us-ascii?Q?bTTabPsGuFJ+RkVbDNhK03y8/cPbS6Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3500afb-2224-40f7-5eb0-08da3347208b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 12:09:41.0389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1eNMvatf68FQpbLoutFTa1mgzFgVDPK+pS/M/M97/OZOeERWYd4eC2NBopEAESrQjIR/OBxZc7SgzaWBbHpjDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5716

This patch adds the round-robin BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add this new endpoint to PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 93a5739712ce..6303eba67fab 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,6 +6,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_bpf_first.skel.h"
+#include "mptcp_bpf_rr.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -369,10 +370,47 @@ static void test_first(void)
 	mptcp_bpf_first__destroy(first_skel);
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
+	system("ip link add veth1 type veth");
+	system("ip addr add 10.0.1.1/24 dev veth1");
+	system("ip link set veth1 up");
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_rr");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+
+	close(client_fd);
+	close(server_fd);
+	system("sysctl -qw net.mptcp.scheduler=3Ddefault");
+	system("ip mptcp endpoint flush");
+	system("ip link del veth1");
+	bpf_link__destroy(link);
+	mptcp_bpf_rr__destroy(rr_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
 	if (test__start_subtest("first"))
 		test_first();
+	if (test__start_subtest("rr"))
+		test_rr();
 }
--=20
2.34.1

