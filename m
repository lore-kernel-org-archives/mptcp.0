Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2808210B
	for <mptcp@lists.linux.dev>; Tue, 31 May 2022 09:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653988254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ekEk93sHIKC/NZYCmtxEDy6vUlHdJCjlMSlRzvIl9yA=;
	b=VLPlqFDP1oYqwIRxymVxZZxgrgQHcJBGYJ+rAw3ZdQK6SI+p7RNjaif6PcDSn9IcW6DUq9
	Bomm3g8bMjyKkjy2nQJ6e6Uj0ciYV2NhHYsB8ho2uMKpEj1ud134pSY5gesgDeLrbAGd2y
	lish9EjYyhWeghRQHehjohcXOC2t694=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-PVCyApF_MjeMh8JIXe3wjw-1; Tue, 31 May 2022 11:10:52 +0200
X-MC-Unique: PVCyApF_MjeMh8JIXe3wjw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrcPV2HwPpw4CQM8PfLFgAfoFTOApT+5t18FOke7ZvXdZw/5EA1L1sFyv0L9vvZjNAwwKwUnJ6h6UO3CdpAsJSt5hEvDEdnLPOfAa8Hz3WjycNoGUX0S7WjNlCTin53EPlH7/5pUKj5v6ErZf9lsAHxcOEZwVyb1GA/IlINjPAfLCKsmh3HPgtIrOU4+9y7A/+fiI5gZepky42nPdBubtUmuCjx3ORASwsBjOZQtwLOsMYmid4ZWMOP+cr00psJeL1L36+8zGjSaYbzjyvq6kADneFSu/nISha56CHddrg10d3VCAmM+AslCn63JcNPqJmD2LYufPFsaAgoG2OwpfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfsYULIiL64ICc3RDDsnoenxiJnqTPNwALZt3Syzhr0=;
 b=l6CvhCjAPe3jIRn50VRymzLA5pNM+3q6YxNd76U1EXwwjebGO0f7ZJrViNw2vL8ccS2ItGK8Bh9hBDTBJDUMn+USMQ3Eo6tpmK2LKa5EJZFSJgvtEa7pLMZfBlt6B9tcfGnIXEREQEFZBrZWcA+xOsRVApUzxcVok0MMk8mAIdHpD3GpCwZ8Zb5Jr1XiMcthkIyMC76WwpZ/eevSLOV7yjHS777zaqOT4/UrKNPaQI37qMb/LhMO8HJNtKcrVFl8HkE1VnxV+9DDg0ncWskmRpL+/JREtHu09Nv+0TpdxpSf1qk2ebbzkK0VgpHojW7JIDaLm11TwrWJ4XHIBHTW6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6434.eurprd04.prod.outlook.com (2603:10a6:208:174::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 09:10:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 09:10:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 10/10] selftests/bpf: add bpf_rr test
Date: Tue, 31 May 2022 17:09:55 +0800
Message-ID: <31935db8f3291afbea6e5dc057f63032ed6f259a.1653987929.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653987929.git.geliang.tang@suse.com>
References: <cover.1653987929.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::28)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ed9a086-c438-493c-28de-08da42e57426
X-MS-TrafficTypeDiagnostic: AM0PR04MB6434:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB6434E065F27F0799445C826AF8DC9@AM0PR04MB6434.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ojg+f+7KIFPhyBnq/wBLpR3VicK/uM1jrlBPtctrMYGDPUvcqdn3Q6sXvGSHJVc5iJKJ+KZ+1jm5zxLDWCtv2eEE5F8YIL2spM/lGUQTE0hrSFJPsW0Y3GyA3JvO0xwt6ggIW9BttVYqG6Y2YG3mlomdnD/Kq4G0tAaealgOmxMj2H/d93EMiCIy21oTV13aWkbgxLDPUwmR8GtWxMSR37Ni2lwAirEthdAV8mwej+SgoBdH+VI9B5CTfeRL83UNz2vcOfViz/EfGL9/sSl0Bej9M+DTKcqxf4D6ynb5q0B5DlUFNYW4QuQ9bMsQCeXmoFn28wMRNePstgWjHadKM08O6YY9v5ll4psx2f3xAWXxpmdOa6iL7R7BlRHKk0whC6eDGSYvoqyK8tz2CEMF9pxixLtFV105ubVWZPkAZI12i0oC3Er9sqVC8dA6APuMtBPQA6sR0ltCb+jctuDbJKHZCiX9db2dxem+OhxLVxfEJABbxOV39kJVVxrMktlArOj6daMR3OYh1SKoWBpg20RGi/Y6Ms2gdKW87Koiw9CE6KncQXYO0fsdvwstC0GiShGqkzRkmE+fmna2+VgzxZWvxsDNZn4xaXox5fDNJJfMcs4m4GLv10CGc3Q9j1Xs5k4O5ReJdHBzPvAB36mK3C7ZgD0+JJazogZwmuKtTZYpZfpIQ9MINBh8sofwBjtG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6666004)(6486002)(8936002)(5660300002)(508600001)(38100700002)(44832011)(107886003)(2616005)(86362001)(83380400001)(6506007)(186003)(26005)(6512007)(36756003)(316002)(8676002)(4326008)(66946007)(66476007)(66556008)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5bK5lQBw73XIivxxCsx2lRhEpbPq9KF+71BPg2wXuemFPSrWOliLOaRFd1zl?=
 =?us-ascii?Q?j5BpN+i38wVYVfELf1bQx/qtbrygOFS0/9Gmap3nVqiP5wr1yeHeU18QVvOK?=
 =?us-ascii?Q?NZKyJM2sBTLwQkXnalyZFGighrOUpMN24js/HBQc6YisyrDx/M4xktX4pPWF?=
 =?us-ascii?Q?NVrAO9dfsLOO8U/rfmscZwGsdqihyU8rgd0J2lysRQRGd0yhjAw+G+UUUmG2?=
 =?us-ascii?Q?1prKbocI4bbDxQeIh93VgDR79qMfzugRhz7Rn7mK/JquzfDNsO9yXXhjM9jl?=
 =?us-ascii?Q?RdWU2D6bMvAUUS/qosLs7ySBVfUuLa5Mob+ykHAWMlsz/FCcxjShdz4MwumP?=
 =?us-ascii?Q?djwzbZ28mbgyLzwRX/TsdNMQ/5+hOgbtEHKbe+EsliWiCkrBYrrDQttpul7N?=
 =?us-ascii?Q?VX71+aYm1suLoNbC3ZnrY9ppaQp5njaYrlzGYJfSZtFytnI7rH8Q61BSGsFe?=
 =?us-ascii?Q?ztAtNIKEhdxp1dGt1bPzyUxvDVwfP6E9wAxotoKKUv96vGx63biJYMzsUM5D?=
 =?us-ascii?Q?3T0z4r3fhnFt8GdLjENl8/PbSDPMHH7fe7m8QXwRTWHZuxjMkEvDTxDm7BUv?=
 =?us-ascii?Q?FThtHmbEMknffajyqXApwECxkODUGUQWc90VBkpbWSZn0SfXRo2rhREZfgKn?=
 =?us-ascii?Q?/WiK9VLVVPnQzn6ZQUOKKrnNF7tLcAnmeswYMnGD0kOLc+THt3b//2UUQqZW?=
 =?us-ascii?Q?wlAbm7r7yYgIDVb1QVkHj5R3VpNPjwkzaKJZxuSnCOCXOM54oX1nnKhJsRRt?=
 =?us-ascii?Q?A141qhHIwiV/BXP94mj5WHzoKtYEsSJLPl6e+jRn98WHAUHu4o2n1pZ1QM/i?=
 =?us-ascii?Q?u92DdcSdJ1wWVCntQF4wIGAB98JzecK2u9KbTFrNk2OlC/mkyIt1Ub/NtNmf?=
 =?us-ascii?Q?QAjmCd2TgPUFrAspZIvNvkOtiv5O/m3gWtrfot2rKWkMZR7d2MmxovlLwHas?=
 =?us-ascii?Q?o1ODpdXj3MWuSeSQyyrw1NX/sqrJWLiomStiQi6AXnxRxX2wjwaa31sSUOAc?=
 =?us-ascii?Q?l7EHTjFrx7/qUBWdJn9Q+iisRcFEFMw9rQmAEdbfI2hm1lXVY9dYKkbNzDMd?=
 =?us-ascii?Q?Z4qK7CJZ+5yDHFLvhGEbZ6q68CMIrGqyfFMjE9wgGvAWuQZBvtk2TbGylk4B?=
 =?us-ascii?Q?5nWB6SrNCMqWPHpIf0//AFy4xfJ2cLLtNvFCWLPcw+bkA9dgAau/+frc4RDG?=
 =?us-ascii?Q?f7oVqBnz0XbeitWymBA8tyb/h3w0biHdlJTsj2J8mTYb2lsqV10vpbe+NFbE?=
 =?us-ascii?Q?Qj9nW7q5xz59LcKnT0r1BYcKjNMqz4tvPr8VhVqxWGnIyNifWWMt00IO5YjE?=
 =?us-ascii?Q?FMkhy+8Toyse1NZSxfVWMxsqYcFTizzRsSxU8E+wkZ+OqdL21DjZgZLJAGFG?=
 =?us-ascii?Q?WR8G4/4xb46cdofnrkmtsjGYP0Aif7M0A4YIcg16RWhh4mI9H/1tN7d9kN/d?=
 =?us-ascii?Q?HQ59+xeCAlinelu2xeQGJcKyfWVaQt7LcuAwr42TMr2M6fLocsiByu3ijZTl?=
 =?us-ascii?Q?+7L9sNvr7Bvyan5Ery3PrZ6ku5dx42DTPH+pTdbHYYJmbOh4gDPbxL9jc1hK?=
 =?us-ascii?Q?V3TKR+tDX0Iihv/J7HE7h2NE4y5tye2Kc56CG7yvb4lHjIiqlKjy3jqideHU?=
 =?us-ascii?Q?a5heWAgRe9ZI6fTyYY0M2eWy0LE/vl/KlBkj/9oUS/n+wGtE0dPYfj3us1JQ?=
 =?us-ascii?Q?GRhLAhAYgr5SS7dHhDAnKUVOxe79M0XFpqvQ/fN6EgWkmN903RE2YGGSv8pO?=
 =?us-ascii?Q?nqMg1WZ3xxGo/zYaMUu9lGPzhQJphmA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed9a086-c438-493c-28de-08da42e57426
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 09:10:49.2916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mk26k8TQoHc6xVO6q3tm5ieIIuSZ1V0QV54ZCIYk6oSMpqVAh1EMIkYo+Jb+nWe1cYdgU3Vwaji0ut+cLtvmZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6434

This patch adds the round-robin BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add this new endpoint to PM netlink.

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

