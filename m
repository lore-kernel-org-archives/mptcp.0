Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD498256F
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 14:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654092563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=58WBS+HBnxE6l/SctnekWuFU/3nS2PtBjy+z6uzcPf8=;
	b=VZPACfnGJE7LwRuRp2mH8pVRdj/GEBS5I/Abb8UUg6Jsvp54FESOGghOKpkjkG/0Qq2uq7
	JXroyEKOzt7lMXh8f/CK7o8eg/r0I8AEhZGcKVu/KKG0yQlGK4vSdir0/S4Qxj91DnXoyN
	4wfiB3dywe8qIlt1/Gn9IG2Vbr7i068=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2054.outbound.protection.outlook.com [104.47.0.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-43-kXFq9LOMNjSguHUlCu-nDA-1; Wed, 01 Jun 2022 16:09:22 +0200
X-MC-Unique: kXFq9LOMNjSguHUlCu-nDA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASU1JTYnc98QGQYA3GgI6NDxGXCHJpPuC9ywfi6yv8MZvyXlLMOjvI0/GwlHp0/8SyN79077Nm7pOJkmiI23BSe6HMZzhCwkIlGtdEBRT6JsnZZ2mKxtmflRiOkYff3t9Zti4pgiRyrixn4/1W2EnJmtho5BSixWKBzT/qZ8JicN0nrwdDt5nIL5qf00Fn7fDd1kr1GCxgw8xR3zD6cV72aHYrKtJBBXlawln8HdSH2fZrPl+EMXS3b7MmHn/CpSSIApXXPngxcACEobjgtQJmxZ6pMMyhJV7x4F3j+8h1zXtGVwBfEab39UNVkLUCrLC4aH2jY7vE3jFtotT/PHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijzT0lpNpuoNGZANhRHgkAx3g+9T2m9yp3NXix5KUnU=;
 b=WdS1VfT/MUW6o3aCj/mvYA/cD5dDHTJ4QOIv6Eh1gaXG8Vnk+Z+UXfGw1/CLCCaVehRoMSTIDKNCdFO0NBFV4dxkScpuhpBfJ72y60wUZZUlnmCmsX8azHAVQdDsl+tM5noofu2FSp5vSVogx+UK119oLjZ+1cfCYRSL0+n2a7qF7zKyEnJlCnDONXt0d9D+cGXAwYBGTrZkX2IHL9prvvbMtaeUKfcxonPWWzVk5hODYwQZTgiJTbNavIOBac/ZCeKTUMyxuSbHiviDSkRqxTdHwXmZJNAS2zK06PUaV/LYsuAec3J3MSD6ZxzWKym5KvH1jfVfJJZWijrV9BUTQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2935.eurprd04.prod.outlook.com (2603:10a6:4:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Wed, 1 Jun
 2022 14:09:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 14:09:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 07/11] Squash to "selftests/bpf: add bpf_first test"
Date: Wed,  1 Jun 2022 22:08:20 +0800
Message-ID: <8c536f1ee5afbe64ee95737d8b7e214647d2ec57.1654092153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654092153.git.geliang.tang@suse.com>
References: <cover.1654092153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0195.apcprd02.prod.outlook.com
 (2603:1096:201:21::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe741803-3011-4cc5-0c2c-08da43d852cf
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2935:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB29353373018EBED88132A65AF8DF9@DB6PR0402MB2935.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/OEM8Qi2gN1zBOG0dwwrQApPBQbiafRCeDC2mpngtDd+YEG2wJMzAlNWv+j2GR/4QwMAQkAuIbQan5td/7DgcDwB99tDP/FiMUACEKJO3vFk5kEg3ZpayVFzsUtW1E1nyc8j+WU106KV5WXqLnksrf5/GxuExlfWhPHsNQjx8sxhqJzwKyPeWKDOdUeOPHpOT1VPPB2mTIzQz77e44aLKLgBK0wFb/UauTo20ayOjKJCfqvjuRpm2Tzpx47rsX6/PXnub3vVKKt4mg7/oHgEQCStgI7esp2eR89bYjy7EO3uXZLW4CC3h+4s+KoQfBqG5j+EuoKt9ZjR7v4h2UTn0hfZ++77zjkcHT3dCV8KAKwijQLdAD7b+5CWooXj8QknZW4zCkBPqkhSvstRvovjQmkDkliMbTa/0nBR412V5cxzl15WBnXDbidBhzuyaw/7NMaNNNYrDkEopz93hpn1SDphSGBvH6eLVxEufg07V21gLbwnJjsBAfADkWZXTE0aCVOqrchERKgqh0z+kTV24cOTfbYadfhFe+XCDwTyiGCY3L6/DrvzUe7kTHT8gERRwk4qiv7OeQLP3Qhpl28GpWVp87hR8kZ+rNqokCuXpgiZiKyglDShrs/AGvFYfN8iGa6S514qNAklj3UEVLVny1seRuGLsMmudHkY7/FvwYTOnAVE4wq5LPN3e+EIa20w
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(6916009)(6506007)(5660300002)(83380400001)(38100700002)(316002)(6486002)(4326008)(66476007)(66946007)(66556008)(2906002)(107886003)(8936002)(2616005)(26005)(6512007)(36756003)(86362001)(508600001)(8676002)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cUJTFmTqVdfJehDPd/PVeGhlx2OvTAFT88wgzywGx11GeMeYFM7bK9CUDMg4?=
 =?us-ascii?Q?3ObtEL+hlNIPhLoNRzmkrNSLWMg37FEEZ8MlMao5h/M4RImtuf8jC9QDxVVd?=
 =?us-ascii?Q?i2sm9Alrs1Bt86cCYMpfdmw76Pw8JrVqdWFqiiLa0rRE+M3mwUmjPFHcDzMq?=
 =?us-ascii?Q?0O8XPmWPyJeQJoe57bXlsZ/7vohFWsgO2YzwVJnRctRAmS8cD+hv7Ls34tXO?=
 =?us-ascii?Q?r46nggX6PIG9rCyma2RTN8l7IkBNgrAlgvS/QO4ldqVMNG8D2BaJ2xfzPXmO?=
 =?us-ascii?Q?B16flvvCQZnDlFXhAmBsFNyaQvodjJ2SG7vkoZAQpKMb7UZf6TOCAH58aWFD?=
 =?us-ascii?Q?PbQw3KdENrSjNJfvrYFawIxgOQRLgipa7yq+WHMIXtwTntga2Q+nhKuArMyt?=
 =?us-ascii?Q?DiFMFCdvNZ/6K9UNnQUEzmLTP0Cf5thF4gGtXqfNG7HQv4P0JXV1cEP9mn4J?=
 =?us-ascii?Q?f/Fm+oVXDbFX1RugAiW968QyhlElbsKb88HdRNB/1lcXQqNazX2bE9sBsLI3?=
 =?us-ascii?Q?nmTnOVSinb6ulmoObJLd75D5/xJl+0akNdbejrBhiRdwuu1k9v6tr62FYlOW?=
 =?us-ascii?Q?WoVNkZgo28w0JR6FixkIQpmkpU4M7RY/CLr7QKQIjNgTx5EiGoZ5SSli3+Sj?=
 =?us-ascii?Q?aYO73l1YekqQntPrEQ4/sZEc54chUY+w+ghwFjdq9735JDvLpNcvJ3eDVOWb?=
 =?us-ascii?Q?f2tx4JkhjtfV+ExG6GGL0yZoIGD1/dBf8/XgQYcHBwkwQmMMd2ERpnSfbocC?=
 =?us-ascii?Q?F2Bw+nLLJctXYvCxNl4761uB06wPzaWoEw/ImrWfmszunvjyFxcyzT9YCfXy?=
 =?us-ascii?Q?S1N2PxNq8pjclpqS8SNF5PwwoiL/2xmz+OA9Yj8DLGak7x2fe7SgzzG8qFdo?=
 =?us-ascii?Q?vSi0Tq2j+OtWO/azq4iTM8sBJ9I4vgZ84psgJPnHZO3ioaqPfZDsiFHKT8xF?=
 =?us-ascii?Q?coe+tcbqKWdPwY28BljsTItII2/x+9Yo3+PHtCcqOeuEEhSxCve+LCEIWzT4?=
 =?us-ascii?Q?Gwdj8QTZh8LAj3ltMDSheeZ5TPbDeiSU3TNh/4hi3jfY7WGq+ltdF7C4orXb?=
 =?us-ascii?Q?FtpRWTayJGizz1W95jSb5XH1NoJPeyD6RXraUSDql18vUWVCyFaYUrkvvdni?=
 =?us-ascii?Q?XObodNDaQVk3Q0ZfjNHU1oyZ7dXdQB5C6cVBbWSntgVCLSVNIfNEOUAmxWQx?=
 =?us-ascii?Q?yFA/jvwtxnkNN2+rpJzov16EjZCx1MWbp3ZVFADHTAFWfJMXQ2dRLo9xgHle?=
 =?us-ascii?Q?gbxwNLCmdg+4jlIBfVD75KPXuxq4Po9WyQiUZOL6agX0Y8zmicEcIDtECQ2G?=
 =?us-ascii?Q?TMTH0WL7ks3lgUbdceYf7pKQQD0OJ1sAO0FjlKhh+j5pVTh+29VwgdZ5E3Dl?=
 =?us-ascii?Q?6du1odfZZfWbN7LAzFPfVM0kzSXGpVJpNMTyiwV0GE7h2gJF4ySYYdUiI+cU?=
 =?us-ascii?Q?G/3CEUzXuVGDLUHsMq2z+riFxcpb8KbIzksyLCa+OAVo6airaBgshmyt2zAv?=
 =?us-ascii?Q?ybAcpI2H8PJzBb9XMq54HtDpXjNgxqFsf6PyHhNFosVcRTXR6+XXCCT+4X5N?=
 =?us-ascii?Q?Ai5VU+oKYmTCu3kpPvmbA/wQZF/sXIcLcUP+GqoCmJzKousOs+MsixNPX/0Y?=
 =?us-ascii?Q?D1J64YVWSEuNfZn6w0CiRFNiiUZirn0oC1BOgu1NFjFAWjdK9dJerKOkVBvd?=
 =?us-ascii?Q?qzU9jPSdeBf8XX3EGxkCoJ7HE6hHN4/2YUadN82C52GBG3kak9ypIvDfokD9?=
 =?us-ascii?Q?jfBccnG0XRdp+mIcC570dykfJcCuV4U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe741803-3011-4cc5-0c2c-08da43d852cf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 14:09:21.0456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fnzguOxqtb+00IBvH0kXuRWTA8mh5ou4k8Aq0eUj2ir/NahoUt8bFTKBChSH4lY4fLGrGqaSZQtP70IB4MGng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2935

Add two helpers, add_veth() and cleanup().

Please update the commit log:

'''
This patch expends the MPTCP test base to support MPTCP packet scheduler
tests. Add the bpf_first scheduler test in it.

Use sysctl to set net.mptcp.scheduler to use this sched. The new helper
add_veth() adds a veth net device to simulate the multiple addresses case.
Use 'ip mptcp endpoint' command to add this new endpoint to PM netlink.

Some code in send_data() is from prog_tests/bpf_tcp_ca.c.

Check bytes_sent of 'ss' output after send_data() to make sure no data
has been sent on the new veth net device. All data has been sent on the
first subflow.

Invoke the new helper cleanup() to set back net.mptcp.scheduler to default,
flush all mptcp endpoints, and delete the veth net device.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 8e9764275b07..eaea4105728d 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -250,6 +250,20 @@ static void send_data(int lfd, int fd)
 	      PTR_ERR(thread_ret));
 }
=20
+static void add_veth(void)
+{
+	system("ip link add veth1 type veth");
+	system("ip addr add 10.0.1.1/24 dev veth1");
+	system("ip link set veth1 up");
+}
+
+static void cleanup(void)
+{
+	system("sysctl -qw net.mptcp.scheduler=3Ddefault");
+	system("ip mptcp endpoint flush");
+	system("ip link del veth1");
+}
+
 static void test_first(void)
 {
 	struct mptcp_bpf_first *first_skel;
@@ -266,15 +280,18 @@ static void test_first(void)
 		return;
 	}
=20
+	add_veth();
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
 	system("sysctl -qw net.mptcp.scheduler=3Dbpf_first");
 	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
 	client_fd =3D connect_to_fd(server_fd, 0);
=20
 	send_data(server_fd, client_fd);
+	ASSERT_GT(system("ss -MOenita | grep '10.0.1.1' | grep 'bytes_sent:'"), 0=
, "ss");
=20
 	close(client_fd);
 	close(server_fd);
-	system("sysctl -qw net.mptcp.scheduler=3Ddefault");
+	cleanup();
 	bpf_link__destroy(link);
 	mptcp_bpf_first__destroy(first_skel);
 }
--=20
2.34.1

