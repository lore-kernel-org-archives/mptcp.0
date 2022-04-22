Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B023CD
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 07:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650613648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9PjuXmxx//rp3Sg1bxMtKi7svQtMfnWGsRK9tVAIhg=;
	b=RX0T8OF5g+JQ8GZs6YwQ64aogV8yt01/sYzzkzF/ggqqlq5BT4Z1VBwOXW7WdIMRlNcus7
	EtVuiCMCr4VdshUuWz4ahT8dfpGod4/TVPfydyNvvEnSHsbRxYm6YWI/C7tYxoyDPBfptL
	U2j2MXp1IuVH47CVtbE5R2LRecLdM0E=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-mzvyITz3M5OMaMZ2vpPZ_A-1; Fri, 22 Apr 2022 09:47:27 +0200
X-MC-Unique: mzvyITz3M5OMaMZ2vpPZ_A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNFHkrvgBbGJfZxScRgWE6MSQZp4VF1vgh3Zb4Tt9xkBMxyPcQe6GDrvZWsuBfFZhjTwRQvR7rqrQ8rCsHpxlzy2W/kOg8VqBNs8VI4UPrkX2VrwNFFKO/VSaAy7xhfmC6UwBEPXlGUb2dnKZTtwTCXueDMDhHuW1pBzDSPckGpeXQCsnIv2yhlQ2UkxAQQT+jAXU2O8daNNtreaweW8MBobYaVoDZa7NlmFK3V+em5eo6ufnq6aGBAA4SizSt2MxoFJ6ImVOvMPSLBshySM3xFDyASLLlmNRtdxDX9vGbSINSTHxTGqdyX23ad1YgGvlybBylxa8s2WNhqv2T3xtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDnccN4Ej6cG02KY5kELgZn3ENNVMtxOEg3GeS2yTrk=;
 b=gq3nAssnkNo0yMZvljyjv2g/idbA2iDYk784UbsCFwi31B/5fBVQRyhrYHQ0AueuXiOlL8hiBgvySOUmfqnFQUrQJOLIhMoIsTVkpiXVA29+j+FOJ0CGaAJW1ptb4Zp3HZhgo3WeD5YJkgCE69mXKg5aSqbjDixn0/srjnNioOFKjwEyZyB/c3YVNtvJNOVQEgldo8j0/9gYS7YIdmKGXgDQgGv1mbS3MBFX1pyibL54yIZzBlc1GBvoRKirESHHfu3SrUnIewfVlhkH35yd3nJ5/4lOdM8tV8nk3Zo4bh2aO+5vInXv8wWLso7UYgQ1KVN+JXFxg+n2cmhg/75l5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4899.eurprd04.prod.outlook.com (2603:10a6:208:c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 07:47:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 07:47:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 3/3] selftests: bpf: add bpf_rr test
Date: Fri, 22 Apr 2022 15:47:16 +0800
Message-ID: <b52db94908206a82c2ab7cea6e1a49b8aa333e16.1650613515.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650613515.git.geliang.tang@suse.com>
References: <cover.1650613515.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0023.apcprd04.prod.outlook.com
 (2603:1096:404:15::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56a216e1-3d33-40d2-4636-08da2434584d
X-MS-TrafficTypeDiagnostic: AM0PR04MB4899:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB48992DEC7A0B8B82CA525F7AF8F79@AM0PR04MB4899.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zKFAhkDynfWk0onXGr6LjQk9Zt4Ovx639whqiORyyklm3nq8w9oeeLuIBJ5+ta9rRqLw/5bUbDzAxXFDeAxGWNDzsBVDiTmKlhlcg9WKE+NMvnKxQOWI/qk0RGVqNe7uqD8Lo+SHhdzZxwU08CnwD8ovhz6zQ//QHm/sOTh2bkeTfy6vCBFg0xhuAVfcGb991m8gguFumOTl6nZuzYgXJDA4RHp/04EhOL2zZ8YJeH9N7n9U9z+a/zfj/LWop3xCxyMfIqbP2X3jxqTDJLmaAwnLe7KMME2GkdoyLlMalKVMS1khFQjVW8nXrUHV//TQDuS9niT/N312jnCEiO67HG8N4pk/uRGgX+UWW4Utn/PvGk5Eqf5KnT/uUvzvoy4A+N5eFfFD+J1kxK0Dy4zWgzu4RnnlXHnVYNXB+qZ6EujhGu+8UxDosUqFU6GGBa2ml/PzlyT/nAkyhTELJ8bJ8S3+ePd2RnvEwGqcAW1l1UEzsjrcVwDJ643Eesu/84+/ZmSMyYHDPEjGECx67oDnMM0nhI1Og3eLfPM2OvkWI6Gp2akiMKbLw1cahNAMP2oT8wXWrkzu9j8nGaNz0mUt7WBYs0/fEQ+yPr9Tzf5nqmbVGMgmbMFI/xmBVuqF8+39pzLrYtoD/UDAE/FSG/d/bw1Hh6/DeZi3NiliU3GNG4CNGz0VNrqmlsAJcF+dIAC1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(508600001)(44832011)(107886003)(86362001)(66476007)(6916009)(4326008)(8676002)(66556008)(36756003)(66946007)(316002)(6506007)(5660300002)(38100700002)(8936002)(6512007)(26005)(6486002)(83380400001)(6666004)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xe3SnZWpo4feJzX5S4H80nntCfSaXxLHLaFY+W2kaZ8lH3JbDDyHM7vQ//Rd?=
 =?us-ascii?Q?FoOiwLDvDIrQQYczX7acH4075JLV8g1lezW8sLnWOdw2lLFtocnfI13AU7Fn?=
 =?us-ascii?Q?Fkd9YRVosZRhcapSb3hReRoAg3PO30m9+bp2RinlIfJnckfDP5BIr9RjkDLA?=
 =?us-ascii?Q?P44nZA71hhR2AISu0YxDDTCYT0F9qqzhqZUFcsy324p0pUYIMapZTyy8piLr?=
 =?us-ascii?Q?XEPfDe81bnqKF/acZ4Oq+Ut3kzi69m1N2WL1jfg0Jef9gapJaXjMVYFPGLB8?=
 =?us-ascii?Q?s/Rv4GCILxtkZ6zl2mBJMmIkYfGV21puaPs/r6HQewk/9lzxezaCuOXz9znL?=
 =?us-ascii?Q?mqd0xWThzVjE+OgdvDNzSL6uS4WyUdEbZMJBHEoEw7d8LJHd62y/twwIO071?=
 =?us-ascii?Q?3wdl9UjIpEjZDKASm+h2k4ONrkaNZ8Nb4OLC3P1JsEaUEFhEAp+wS9a85YO7?=
 =?us-ascii?Q?dM5EcMSrH99qyedgGd+lb+laBwz0CUE4CtF5ZRbm/uIhSYJIvi2Ya+FCpH89?=
 =?us-ascii?Q?2od66Xmwml76s+/cF5o9ImTUhiNwXdIMuOJyZa6fkeQMhy6vxLVRCQqJQKoB?=
 =?us-ascii?Q?Mm6gtZuOuVR5uSk4OPkBo+vLTmj942BwHt4ZNcI67Mh6QIlKrSTjdm4AgNp/?=
 =?us-ascii?Q?wC4KU+E1TWMOwxAr0VcGbrZmlFdrRnSpV69WoC1331190Xk1ATmvAl/p9hR7?=
 =?us-ascii?Q?Uag4w4K8v1g3/V8YFOPXsA4TnaL/B1sYeQ9dCPfS4KIWt4kzEp6fl3vD0nw+?=
 =?us-ascii?Q?bryRuNKB65soFdF/e+AAohQAllANj2yvgqc9j9VbWa+I67CaM40nAp/n38Cm?=
 =?us-ascii?Q?5YZvNzMgWwJrMExI9U5GchJ9W20l9wa5hKb+oNFrnRkDJpExtMJctHIQ3ota?=
 =?us-ascii?Q?5MUCp5+9MsVnG+molRJ7DFTftc4vBPNYB3XMG5R3wft3iMTX8vQmq5pnBYyg?=
 =?us-ascii?Q?VyFVGxlA/T214bZf1zxQuHkqeisYH1LcA75W0Q4cBq/3gyRSHzMCXTioh5XG?=
 =?us-ascii?Q?s1JggTowops6V8OupHnQ98aIYLKi2lO4Zh/+pANfDNRBG7l8q4ZWjSyr3EIY?=
 =?us-ascii?Q?S1ej73RxifkcANvhEsGNUivhr1UUNeRqIzJ02KK8ZK3i6g0KkWGK4eIGnAkF?=
 =?us-ascii?Q?MLV02leBNU+MKA/WydP3Pub9IRegpmajVCZEZimHLQywSSXwyC1y1Iov2XZy?=
 =?us-ascii?Q?k8TnOjHvaIniYamcFIA/tO+K3kAuMhgzVqDYxRDv4FvN+KZwFVirC6TAyO+w?=
 =?us-ascii?Q?RCUel1J3SffN0MkGZrXWOFNsYsok5oOO6uXsORE42NN/lE+8VORfcut+Yz9F?=
 =?us-ascii?Q?loDZR5rxXTzHFSKfzXkHPjBuwZG6MG9QC8pK2huzZqJU5qZp2soOtR8rML9G?=
 =?us-ascii?Q?gUMaEhugoJ7UKihIuaT3bhDv6QZIm5Xsc9aIiAsxria0kREVbeC1Hz6YIS+t?=
 =?us-ascii?Q?Z/vaL2vwAbIHvJtL5GFsWM/+au4OhZ5eSGz8GXNIqImh2K9NKi1eJjFk9n7L?=
 =?us-ascii?Q?ZWtD++sDcUffC7qQ/DUFjuCSFTx0Y00HC+x3bxzR8mnsyyPrDsvxzxEZlG1B?=
 =?us-ascii?Q?W0yAWyKTSzcJ1FXPqRYhBvzpfqEhxQFrmgRVqgmwUZqdHJqAwMrQ7FGwTBWD?=
 =?us-ascii?Q?E/IwsGQOIEs5CFmK0cBY2rXQze0Sdbo/4L2ZOgX29qFAy4DysE0dY1aIVbZo?=
 =?us-ascii?Q?n0xDauFQcdcPPY4qkvceP6Mcab2HajDVvV2++t2Y1vbtKQpTzdpdFmjOV64B?=
 =?us-ascii?Q?PZPF0C50ecjfdj+eZmvIQb2la8xfrTc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a216e1-3d33-40d2-4636-08da2434584d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 07:47:26.7829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gA39X3EO1at0h+Ok7+hqLi10rEkKIZoTeHrCpllFpeOpp8GKHhgafWdDFin7NI9Z5WKmn5/tkV+JUoTuY8k4kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4899

This patch adds the round-robin BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add this new endpoint to PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 377ebc0fbcbe..7052c520c0f7 100644
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
@@ -362,10 +363,46 @@ static void test_first(void)
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
+	if (CHECK(!rr_skel, "bpf_rr__open_and_load", "failed\n"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(rr_skel->maps.rr);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_rr__destroy(rr_skel);
+		return;
+	}
+
+	system("ip link add veth1 type veth; \
+		ip addr add 10.0.1.1/24 dev veth1; \
+		ip link set veth1 up");
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
+	system("sysctl -q net.mptcp.scheduler=3Dbpf_rr");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+
+	close(client_fd);
+	close(server_fd);
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

