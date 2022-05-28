Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFB128E4
	for <mptcp@lists.linux.dev>; Sat, 28 May 2022 15:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653750758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6Eth9dsXeWY4kS3+bXuxDVlQ7Xkhzg5XatxfAJjSEI=;
	b=FrFy1Uf8mw4mO0peg4eADTZYncjFayBfejczJk5JGC06A+8Z7YruRbA8xV84dbJKsM9K8+
	8D7z3B/A2EV1PxIgybbUuzMaTOfSTiAXH7Xs7d89DHwMtTT8rs7RODDBwW7p/bJHiubQ34
	8ZX2qHqtDBT6VfzyVew7LoG62YZwgLk=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2054.outbound.protection.outlook.com [104.47.1.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-Ask5TvR8PTuHl12MsxZq8w-1; Sat, 28 May 2022 17:12:37 +0200
X-MC-Unique: Ask5TvR8PTuHl12MsxZq8w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGOr29t7E9oGAkGcaW7SL5mxv6bnsT5GlZKUFBXc/ZcbNpsSESl1t/TAx75l0q2hvGHYw2loddzo7VfXaXRkfsxukx4Y4ExM0O42m0Lo40iH/7QrxzVXQYqFgNsjThuctIYdUNVGPj6qVQvULeekeA9+CVzyEmXEiyMzH7eF3POIs3VrIH56O6bENseZsUbXRHe+p33nJZNroBXHT9+jsCFtnCzMVVcF2j4hZM+DXW0idfglfU4kxiuPbjYzhKCLmSftUgdwR/FbIYMcbNSglHE92MLWF5LihtAaC0j425VsjUvlMH+fBW5g1d1VHBM2CLh2BExWSVd2a7O2TRiAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NCFrq9klNPD7YBFHVDpPdg7F64kDPE5LA0UPye3HXI=;
 b=LzcvW5nBBG2hGJaD8PxCqJBIh3vNZjWKhv88h7vupMQpBTzBJINKcsh6/kxZi3M//7yWAzdO84b1LRRgEMbth4sJIWXrjNPtZ7xOIf28RejCxt3cUfDwQJHSt8HpMuAUfFYLEz+sEGycL/rXmv+NRpQVnd3S13CtWcNVX3H2y8L1PaRc0cA0Z0MgUlNww9nu4rXUZKuUa8hnyF81zlORRAzsLa4UjYXH5Q/EM5EgbotMAnSjASEX0c1fAwUxWDdQ7ot2Z3yYa0IFsgQ0fN9GiH54KkilMNW4jsy4wNa0PuAYrmF5H7o9GFAieOVxPmE7uF8VMRtDRSoo8ueZAP3hjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8485.eurprd04.prod.outlook.com (2603:10a6:20b:418::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Sat, 28 May
 2022 15:12:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.017; Sat, 28 May 2022
 15:12:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 06/10] Squash to "selftests/bpf: add bpf_first test"
Date: Sat, 28 May 2022 23:11:48 +0800
Message-ID: <70325eefc8777a1a56ebf53154db6248474ae985.1653750351.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653750351.git.geliang.tang@suse.com>
References: <cover.1653750351.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:d0::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa22a59f-b626-4faa-3b60-08da40bc7f5a
X-MS-TrafficTypeDiagnostic: AM9PR04MB8485:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB84852CC45DDB35A5E6DCED9FF8DB9@AM9PR04MB8485.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HOOyEKNapaLMP4Uv2CIfYwUoPXCC2+hzZBE4/8KpXez132tIEw7UbgG//3C24TnO8KVOrjE+MpEsKizeHevCnFvokzhKuiu4O6AvmCtC4zauLQIxau+3TVbqjD8v8PjlNC0JbNEir4IXKQfoRTBnWMoj/lVAJ3mxyqi/S4euJYeBd9hH2ZPXdtXvtH8YudOg1TSNUKtJYdh0F3XtNiSAk49B59XYvWv5ztRskIiq0VREVoG6zyUD1fx+5N6cco/ToCCd0jH+87HXHHgfjUN04BG0pyajsr5psNWcRBTKmZG0Ms+xMHooZLcg+enS2LiRrAxPB6X7/VSaEteMDNnZhH5S9zxNXQgrfLFuDxNMgofNFr35CBGGsLXoGUooOFhRndeO/2P248gWi2xN3DNu7/NeEXSG6Odi467AUi2qT4Y0iehNN9Ed+ic4k14n+sebu6JmM7J5iWDqA09Lx7XT3Vm8fior8mE8t2dwau0dfFvlM6p6CAKYReOm82EWEW+iWeuDl8YMHR+McybJeGZoaf2jMl0UuPqhQlnnmFP7krI861/MgsYOIYnT6hOY+RM0otx4YzZq/7sH5JPiLNlDup7lhZp7QJW6/EW/L2PKgSo+/oETUb+YRgPNg9QEqBq5jI16+XUaPW1mB4bdlUVSOMsYIhB82MvXJk9lgm1YyACkQQM6LDMPoGftkro2pJEr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(66476007)(38100700002)(4326008)(66556008)(8676002)(86362001)(186003)(107886003)(2616005)(66946007)(6486002)(5660300002)(2906002)(6916009)(44832011)(6512007)(316002)(8936002)(6506007)(6666004)(26005)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PTsTrLYJRXZetj6qv8uO7KHQ/efMqY2a5vD8hnfnn2yscc09mIud7HGixh0X?=
 =?us-ascii?Q?TIn3HylSbe5uD2MMF8+Y4il/NDsaLcxCpMoALutKGT8UveDxv9HVEkiTy+Bo?=
 =?us-ascii?Q?uggrX4YFTwN+XyWJ+iDsCtTMorwoQ3kIuQo5aLcitEt5/gYnG0k1wgBZT10W?=
 =?us-ascii?Q?P5BEdClzzugp/s/HxY9VhzSmiHPUrLneoOAQGRPy1x+2QPUrsPTM1Z/c2ern?=
 =?us-ascii?Q?knosrVMi+aJ3Tksk0q9yFjlnzR8SY4BDdZILHEpwaNUFnV+JX3W+4+dieJNc?=
 =?us-ascii?Q?vE+MVhH6YE63xUSd1zJqqn4M34K1Xg4dxWXYZLCzhQSpZ4sXBJnykDxbiIIm?=
 =?us-ascii?Q?iFcEAeEBbrp4l7J0SeYmatt1spgoh8vHCLZq9UevfBUXGZ/+4bb4nCckVLMB?=
 =?us-ascii?Q?99Z/W/MHVbuRsKI73mjSFvr87oJsQjPyd87QIAx7f/vYpQpfQLujDPmNLweK?=
 =?us-ascii?Q?9oweONcH2i774b+5nBZvWAROIUB6SxMMmiRbthc3bMCH8hq0P/qi668MEGjk?=
 =?us-ascii?Q?41B1otztBusYjptlQOEHRTQ/ofcCR1psD94nkdTm8wdQFi0NEigo5QgXElrb?=
 =?us-ascii?Q?VCqrT2A4kEWSgWnaIAstGpKP1z7cidzspaKmJkh7tBFpdPIWP6uCkB0nARSP?=
 =?us-ascii?Q?EwCzzR+JUCGwag1SXCMvM9fKBT6YcSdIobOgtKr2gQwmocLDWotajxEatAFB?=
 =?us-ascii?Q?KsNg4VZUSrlIbkrETnoFMB4i5eFE96umLyeWrY0lfgCiU1k2TiUH2ZnlY9ll?=
 =?us-ascii?Q?TRjcnf/a5m2mNhVl/kWybl01JmdWTDyUWY4SajhKapsXST7WTC+KGDjRPcfu?=
 =?us-ascii?Q?OEWhL/LYugbBMlwNKx8C+xN2ttK1+r3uu0+pnP89chfTGBqPEf9q+08riM45?=
 =?us-ascii?Q?4BOm9DHGc2qGo++50M5U37df3vWwbsVPmppvsnkKq6Ga0SUndsPnyU6ND8ng?=
 =?us-ascii?Q?VmHxcXFgScZNY2f9HeIB11NdZvICGEt9rTB7BHnIRqrKgnWKdVUUTJTQ7t2B?=
 =?us-ascii?Q?x/LkiSwxXM0SLwiXw0APOcjFTjFS0qydJ8O8ctniwYDHx9YbkhG4iy3vjEaL?=
 =?us-ascii?Q?NyQFm1c+sHmOZx7Tfg5FJ4uBENU7T5HXQ/9L+C4bkk5yR3Sfyu2GKiJpTcG9?=
 =?us-ascii?Q?bnpptzs5OukPTdr/9hiteMnCPWIBn9s6kDy/O3oKLlHHoyh13Wn53IS0rO0t?=
 =?us-ascii?Q?JMQQwQpPscutemH+YWZ1xIMjero2mpA3zB07GcEgxEtryqv1c5VancuE305I?=
 =?us-ascii?Q?woMdw6eLJUsIuP1NQpXBni6rpcIlLJh/IUHy57TjskvekD1v0R0/EOdwhWCW?=
 =?us-ascii?Q?BVtxxw03pZBwPvjcRM4zvOzvqzaScPrkF37KDiUYdYoRYTucmOt3tJ9ZAO5X?=
 =?us-ascii?Q?Hto2NrIx0AtA+fjotDP8zaO6dEM6SxHAwajsvJfiDSN7nR3/G6VZkbqI51oA?=
 =?us-ascii?Q?EOZlzZAXi5gYnyppY+eiMiQkcVfLcRWZZSfXYEAwJ+MOJMzDEDD+CHHtxxh9?=
 =?us-ascii?Q?1p3wKKqunFQRTyosOYYJJQg/o9xUKpWB2fxR7cSAy7QgYtY7G+KQMhFv4nag?=
 =?us-ascii?Q?hjSUL3NRO3fBYXDloCJJmBaZwd+nWgYgb/+/eT3xuiuSZJdgGsYfUzvXbzVI?=
 =?us-ascii?Q?zdHMUpzIh6rpz5xXfOyuooBogKhDei02unAH0LAqNeNC8eIQeOEKF6yyq6Tt?=
 =?us-ascii?Q?3NcUzv0cAp2DbiNQB2G0Sj04uz5sj5k7K247F7gBJikNEqbJVT1i+2m/tNUJ?=
 =?us-ascii?Q?iM3DEQUalnvhbTp03HpiS1ZO6JpzSO8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa22a59f-b626-4faa-3b60-08da40bc7f5a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2022 15:12:36.4120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PoxW/x/G6sB4SVyZgx+5jcg66Gy+IlvBwgv0FkR1j7uyW9o+vRXNgGbC1okFJ5i9ir4usV5BfutqtqhXItVvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8485

Add two helpers, add_veth() and cleanup().

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

