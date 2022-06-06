Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E31623BD
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 09:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654508279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xg5bYFfoMWgJ4Uhr39Efb0QH7UJmjf2Y/6RQtASUfP4=;
	b=nBCGmwasxdiqsk//h0QrUopgyjmPCggB83TbJ+Je+QxOc/iDEh7eOqat2KLSPf/S6HSgrH
	asaz+pfrgKsIPv79F+w/aGHg347Nn5CAzUSbQ8lZBJwbAgT84iZ1/fhWK57uzOhApS7FdL
	UH2IA7OqN+h+vWbaiN0x1DRSUtVgt/s=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2059.outbound.protection.outlook.com [104.47.1.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-aicRdjYzPVKp9cbvjwdybg-1; Mon, 06 Jun 2022 11:37:58 +0200
X-MC-Unique: aicRdjYzPVKp9cbvjwdybg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYWnCyGy6oVv+INngiC/9ovam4cNNTt3mmVxZIl/D6LEBPjncjlDnH11OIs+QMDR1pkjqSLXDp3tRE4H/FdjHPm9q6rqE4V2Jl7PTIvjfIXIKf3/QTHm3cdV2srZ+Pd8Qk5BpnBIO5fRWSdjh75fqsw/lW52yvR407627RfDEhtFIEyvqmzQJpzA07dRpR1qI15LQxvC/fznnO1DGWbSRj6gqI7EjMQgk9WoROdiZ3+YFa86uk7oJym9Br+asI4aRVBFEaWanPD9y8cpH/iccUOtlBKkDA/d7WLZ3Z+tSEwfQJ2XLs5JNAZrE2JpD/HMXeyBcL5Ozf5qf++XQVmTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btYBjrNjwG8DdKdGai1oG1L2GxlOBfErvuIc97hv+fA=;
 b=g7U8pcBTOf1J6Nw9I+NxnZ5lgu5lRpQiSdVPNoH/KKqDnNoSJmiILYWWmp0ho/1PvhM+6uKCh3x/4sqXIRb3ssFbo8OZHW4SfX4bKqmvvQoII8VBcwgHGvlV3at84Kzr8XgTaAAeND+8AR3QZ/k+kUV5ejX+Ylx8VM04NlKiDFgh6ItxD7KUqE/IJe6aq2oq81/bg1dxLfDCjiL+vUfXi87648DKCGY3Z2F6W7ENyRu5rqbACggNesksntJTW6BN5Zz0HQXRPoMNToEYnxnoDa29kWP/i2Alu+eCWpv4laVV/escsKrtPfq6gRSTgFSW8w4T0y/csUxJPxgmW3/uuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4751.eurprd04.prod.outlook.com (2603:10a6:803:53::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 09:37:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 09:37:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/3] Squash to "selftests/bpf: Add bpf_first test"
Date: Mon,  6 Jun 2022 17:37:28 +0800
Message-ID: <31119d287afcb67d4ef08e25eeef4805ec70f7df.1654507832.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654507832.git.geliang.tang@suse.com>
References: <cover.1654507832.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc19d3a4-62f2-419f-5e78-08da47a03d05
X-MS-TrafficTypeDiagnostic: VI1PR04MB4751:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4751738F38F57C0B83F3CDC5F8A29@VI1PR04MB4751.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qlvpF1eBbbksx35M8gHU/eaWdppq2XLLeiHfGmD0QG4huh0p5pCkCy7kgtf+XRIoZEXtxlSVKshmrkdS0Jg8ElQl97ISzwVVJoj86DMP2arFVB4FANHQK0lkY0/CFdYjeODXG1Xi0Pu7r2MtGwBrJlElfpzRBLBCxbgOIPjUWE5XYQo5x4xf4Eyq9f3kCs8bnmU1Fqpan9E0Qcp9Y7JZoAMxVH3H8aRlx5TJVt9FN49xLwgJVRPGow8v5agNAFXypdnVR8IP4AW9QnknE89LMikdgHL4UJvB2L1V/Z1FqTLngn6cgzGeRZ6wQc78MtJZTte2WUe8BEYlsJVrJhwPn7HzFv2UZ3P65wrJecqbmrCijyvOHESy3z2ynLBmmfeQysV9m98bWoype4sFVDKWxP/KdM4b7so5mw7HW+8UqFsKjzaV4BnFHm3rw+ufed/0m1DEdYgkEqnE7yb7uia+fWaLmcUiR9u5d6EYXncPAZdDHQOcFXo+DSChqzqfj/BgMl3OO2MMCNbi86eqopHABUVbt3FDZCr2c/uqQMLie2Sz0136AFmuyzOuYchI4q2V0O9eQNAlydEKPpMoI3RGFuBvuH7Ymtw/zh7/NWm55IZGA8gl8n7UCjh1P/yatGd1HjXyt6D4kl7VE4znX/+Y1uss4FsMzUaCDJYPhPHZ2+XWaYHP9FPRNBJDRIbX6KS3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8936002)(8676002)(5660300002)(36756003)(66476007)(66556008)(66946007)(2906002)(44832011)(316002)(6666004)(86362001)(83380400001)(6486002)(508600001)(38100700002)(6512007)(6506007)(26005)(107886003)(186003)(2616005)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CxU6yAXtLHNmT75UZ9i9J6zotNI+dTLZxJ9yb4Uj3ncKJ58shPKE6DEhLCwB?=
 =?us-ascii?Q?Tu3uEZbMiFw33LTVvxzdulTvNrT+XIVMGiJUFMMxmeF+5F1tKtv+U+KM3gvu?=
 =?us-ascii?Q?lAQFfKb9/IFq6A6RspDHtbGPGy7GZc2qhPnNc+lYNfTn4SFnd9M6LTosWTBE?=
 =?us-ascii?Q?vVPoUCJkurrirxtrolGwiF6leJgp6M9iwZO1mBHLxWRJwPO0D2BzcgC+D+wP?=
 =?us-ascii?Q?ti25Ir5RnzCiva3egdCC6aXEOdMmI3BBj7KK8mgiAB5vBEvayP6DbbL4ekCk?=
 =?us-ascii?Q?8TQQBflUXwLaIFKyah4MssCFdK9qKLM6NBrb1EY7VxWNYay91THHw9pdc5lU?=
 =?us-ascii?Q?TKRkGN7NBUW5pNM4BFKMumO0ZMMDim7RgtAsA0L/vbdewT0TTJDYKBT9q97W?=
 =?us-ascii?Q?etbil1qJjIL4YGB/yOndJBeyjDSbUfTpTo6fNP8qtugcNDXaUWkiIW+H/MD8?=
 =?us-ascii?Q?CI3L0qzZZff0nPkdZCyUbnIJ3DPTabWUnKARY5BW84Y1Ige6UPuM7HziSQHW?=
 =?us-ascii?Q?hkMgEw8cdJIFwIFIun+7Dyk2fhELl7hF5GR6ueAbsjM5P3+Rw3MydOcjuayB?=
 =?us-ascii?Q?c15MtfJiGm+Iu8nXpUqk4mMFICUnTMT9Y40dY1Z26He/3UnNHqoBcPnGmlk6?=
 =?us-ascii?Q?aIxeXYkl/Ziu68dFcceu8vOd+UUYM8gDuaZ/u8nE5n/ko3clH3N7qv9Hmxrh?=
 =?us-ascii?Q?P7R+TQF5XHv+HVHBUW5ZVYG6ug84pyUuyXXC+N3wfyyW07S+fiqnBDbWrMkR?=
 =?us-ascii?Q?RKLKP0oGXL8fJ0gSEMRx50cp8S4AYfQ1B2rppbn7pXDu30R5ZMX21Zpn3XfD?=
 =?us-ascii?Q?O6hIEEbDMYkj3dbVR8Gsz6As1E+Q2lg8OhylIJmJlsmhsKXXCVCT9RJHCdT7?=
 =?us-ascii?Q?f8dUaRanaFR9kTIpHXVmi6e9QpQ7vJ70nLq41CN6YV7axnsnd4b+IBrz+dNo?=
 =?us-ascii?Q?kmrJItvehhhFhn+mo5WF+T1oAqr00KqAysL5IoyWIm+VjfZnLWpmO97AJR+I?=
 =?us-ascii?Q?m3yXElWK31CBa/nea/J3kNr/QkVqYw/yOAAdT0glvEinF/3t/iL0M/d67l9x?=
 =?us-ascii?Q?YDaybl4MyZK/dlfsitTsWuFGPUNXviZ62fvdJj1E6vPgAEovPzVu7dCDAv0n?=
 =?us-ascii?Q?fI1LqAq4funWUwloX4T4xvgIG/Gh7QZ5VIbP/V+25NpmSuuLj4YRx0MS8Svc?=
 =?us-ascii?Q?FdlCx4MaT8D2cV6FDCOjekSjWrKsTJvrivfYUHLkXWlrq0PrBzRwYCPmXUyK?=
 =?us-ascii?Q?Pk7OFBnrZwGF/l5SbiyuKoc9gtkryWg7dVxMEAsGIS/Cez2oTdSMW+KOEnnR?=
 =?us-ascii?Q?aHOJ3tQdz/YOHGKdc8NV+rzDAmag3j7Lqo0pw/H7uo9KhPkxESZuQAI+GQgm?=
 =?us-ascii?Q?udX9zHzSQqqoLgbk1Rv69fxTVBFJiX/TY6yH+T24FtMlcGtzNlhak/Pc1PWC?=
 =?us-ascii?Q?1beOloOpkZfEKZR52e5WXOMkTHC9WiwWyjiBYUT5hGfh+zNOxjiamwI+r4+D?=
 =?us-ascii?Q?bVyAjM1oime6iF6L2C2h6TEqgMCxC0MNy42snqyK+/KcWCz/rFqz9CXOVVTk?=
 =?us-ascii?Q?pr5VD4aUPs81W1mpXpc6YXCJniLUV1h8oasmAzXcc1ubwNtKb7hTkhiMEBmR?=
 =?us-ascii?Q?Fz1SOHCG7NvPUKlw7LXUsWNBUhOZyjv/SYbiPuDk6lfyPlj9/3nW1T3cM3hc?=
 =?us-ascii?Q?ASt4KUgwQB9WL0kykiP4NFVSdpG+T1s3ZEwGQ7LiraIlCItUG2cZdFkitDP2?=
 =?us-ascii?Q?2Aac8oahnv63cOnPtNS+9qEGgNwjUTY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc19d3a4-62f2-419f-5e78-08da47a03d05
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 09:37:57.2166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8K7xJB5BTGReEY4bJ1reWUTnR3Btb6WOHX/CfQOCeDlh2DEeAT0u9hnj8zbnT56He5DLdWLUX1f8AkvngXgnyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4751

Please update the commit log:

'''
This patch expends the MPTCP test base to support MPTCP packet scheduler
tests. Add the bpf_first scheduler test in it.

In the new helper sched_init(), add two veth net devices to simulate the
multiple addresses case. Use 'ip mptcp endpoint' command to add the new
endpoint ADDR_2 to PM netlink. Use sysctl to set net.mptcp.scheduler to
use the given sched.

Invoke start_mptcp_server() to start the server on ADDR_1, and invoke
connect_to_fd() to connect with the server from the client. Then invoke
send_data() to send data.

Some code in send_data() is from prog_tests/bpf_tcp_ca.c.

Use the new helper has_bytes_sent() to check the bytes_sent filed of 'ss'
output after send_data() to make sure no data has been sent on ADDR_2.
All data has been sent on the first subflow.

Invoke the new helper sched_cleanup() to set back net.mptcp.scheduler to
default, flush all mptcp endpoints, and delete the veth net devices.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 41 ++++++++++++++-----
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 1ecc8a2b76b6..3122279d0b9d 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -14,6 +14,9 @@
 #define TCP_CA_NAME_MAX	16
 #endif
=20
+#define ADDR_1	"10.0.1.1"
+#define ADDR_2	"10.0.1.2"
+
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
@@ -252,20 +255,39 @@ static void send_data(int lfd, int fd)
 	      PTR_ERR(thread_ret));
 }
=20
-static void add_veth(void)
+static void sched_init(char *flags, char *sched)
 {
-	system("ip link add veth1 type veth");
-	system("ip addr add 10.0.1.1/24 dev veth1");
+	char cmd[64];
+
+	system("ip link add veth1 type veth peer name veth2");
+	snprintf(cmd, sizeof(cmd), "ip addr add %s/24 dev veth1", ADDR_1);
+	system(cmd);
 	system("ip link set veth1 up");
+	snprintf(cmd, sizeof(cmd), "ip addr add %s/24 dev veth2", ADDR_2);
+	system(cmd);
+	system("ip link set veth2 up");
+
+	snprintf(cmd, sizeof(cmd), "ip mptcp endpoint add %s %s", ADDR_2, flags);
+	system(cmd);
+	snprintf(cmd, sizeof(cmd), "sysctl -qw net.mptcp.scheduler=3D%s", sched);
+	system(cmd);
 }
=20
-static void cleanup(void)
+static void sched_cleanup(void)
 {
 	system("sysctl -qw net.mptcp.scheduler=3Ddefault");
 	system("ip mptcp endpoint flush");
 	system("ip link del veth1");
 }
=20
+static int has_bytes_sent(char *addr)
+{
+	char cmd[64];
+
+	snprintf(cmd, sizeof(cmd), "ss -it dst %s | grep -q 'bytes_sent:'", addr)=
;
+	return system(cmd);
+}
+
 static void test_first(void)
 {
 	struct mptcp_bpf_first *first_skel;
@@ -282,18 +304,17 @@ static void test_first(void)
 		return;
 	}
=20
-	add_veth();
-	system("ip mptcp endpoint add 10.0.1.1 subflow");
-	system("sysctl -qw net.mptcp.scheduler=3Dbpf_first");
-	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	sched_init("subflow", "bpf_first");
+	server_fd =3D start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd =3D connect_to_fd(server_fd, 0);
=20
 	send_data(server_fd, client_fd);
-	ASSERT_GT(system("ss -MOenita | grep '10.0.1.1' | grep 'bytes_sent:'"), 0=
, "ss");
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
+	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
=20
 	close(client_fd);
 	close(server_fd);
-	cleanup();
+	sched_cleanup();
 	bpf_link__destroy(link);
 	mptcp_bpf_first__destroy(first_skel);
 }
--=20
2.34.1

