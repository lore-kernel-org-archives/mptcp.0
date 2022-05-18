Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE681852
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 06:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652854296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Atk3G91JSSNUe+UIEuu8GjmY3hMPn56dEBUsv8p19hs=;
	b=aoEN5W6juanRBGoEK1NXALHPbyJxjfcLs/n+Kcexe96zLexIuHxR55vfNHAmRT9gwvMGk/
	uNx/RGW4Pc+G29PKuGHQFHl8zn8AwOh7eaAToITbycZ268ZaUQuMAQQs9OXkxjFCmOlZEE
	8dLjNo4ElzDdga43tPghcDcgWHQR2zk=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2053.outbound.protection.outlook.com [104.47.12.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-8ShW3gt5OnyFbcSjFF_kWQ-1; Wed, 18 May 2022 08:11:35 +0200
X-MC-Unique: 8ShW3gt5OnyFbcSjFF_kWQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7y2EN6j72ABGOeeVHdtjygcQzyoOoLZDKc6uZGOtlINwtjAPkDmGoKXRgDTvR7k0mzKMlTWX9chTDJm73w7GJsmjaHzrkvCljiNAZiU3IvomOoJtacqZfZ6VpkrWjGThyHdSO94IVKsO1IVEHNaI7onuyt+45Klpu99nmYvx4dVOSow3z0gJxExVwreU8g0A5Id8t97XUuGCLFFYo+CPsPcz5bXPbQE5BtKOhgdmxN66163AooHoyfGB3XtsFXlP2zskWXSeg144lVYwLZQg+8vxhLNeciXcqmcbi0n4Q78gcrRvuUvLXbZ1/f8HKUWjO11xTbutOGP/ErzBvjRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y27vFa5j/lSX4Ma9newk9esbxK4aYDN13I/rD70ttUw=;
 b=dIQALP4aKHE55/MogmhEwLZ17lNMla7P0xyojnsE4+3qtEfZmnxRHX2b0vYA0Io212AhGxfLrRRr86iWUyKqV2yfstETFkey0xAx8m6pnXQlTlAhKP8F8yXUR3LbKIPcmyxtr3HuWfSZ5L3IeGlmzQWAk1n82HehTTPykUeOM4JFmA9ajCg4MAiU/jG+P1dcNJbArVVHFLdvII4B8aENwDGqBQwU7jqWMyyHp+KySOCUQVKsTLhuayChkR+cLsQjspUZgLLyD9YF1LY76IusCbYLems73FPApfHEM0064SZsMoWkI+qR1smix76wPhUD36b6ZA4fySOHycZKM40tQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 06:11:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:11:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH mptcp-next 05/17] selftests/bpf: Enable CONFIG_IKCONFIG_PROC in config
Date: Wed, 18 May 2022 14:10:43 +0800
Message-ID: <1d7a80011d37d74886e4ce9c0e4c9b2b2de5062e.1652853898.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652853898.git.geliang.tang@suse.com>
References: <cover.1652853898.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:d0::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ae86135-7f01-4106-b9c7-08da3895427b
X-MS-TrafficTypeDiagnostic: PAXPR04MB8256:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB8256719DB70A98A4F1B4C28BF8D19@PAXPR04MB8256.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pxMXC4MKUf0Lz0Dae0kQvDZN3JSPYM7NsMd4TV1UDt4V7QlKMLlDRBycNB0GljqY4wI8OYbghOO0s0OFHcDmcam1TbAXJ26VypA+4DynttxTWwVG5+10UOsWKVGpI/zoLM5YhY5/HGj1zlWGrng8eyNq3BH6U3H+6IekhIUTOBeAnpdKhRUQUoJMe/rrfJ8vCaA31QWiqkz6LmFwLbXqie+4B9wSX4kgZ++eOZTVTgpNoYGJSrhVB8Rnw0n1gCoNjqRdZISQvEl8aC7ynAb0pmLK5g2U1w77yEf2YllqXNFl+ibBTm8+kv1FpAJP7FkT13ePkax8aWsp533MXQOHC/gljs6VUzE/ZZG3taOHMFH2h6Ku3Al5b+cf/QTMPnXXg3rPKjEiDnq6ryBvLrYzLmlUunbhB+jz5jrmLrqlDU5PMoro+XiefqmPdUCtdSAlzBajwEgQBx79rkzUOvkI0S6aDs9gHeGy6NdvoewpVnVPrJz7vp9GOjLn3/XwkmdSAchJhywQ+Q6m9aaRs7fb288ibHVmGVbWFs/4Xlkx8kiEJaYhUyX2BURPEfbZ/GWd14Qq7N3MIMBb0hw7K+fWbqW1kzGcUlc1RxNtwsOzOXAmvRdpxMkEF4aYhe2nLGKyTxk7Rf8cu+Co2ynpXUsrIhvnBsaqjeK/hGtR776ZQAFXqPFNR26aN8ZgRSJhJX8LUft2LqS+JvumQOaPNQw/uw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(66556008)(6666004)(2906002)(66476007)(8676002)(4326008)(36756003)(66946007)(316002)(6916009)(54906003)(508600001)(8936002)(38100700002)(5660300002)(44832011)(86362001)(2616005)(26005)(6486002)(6512007)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?133b/28+DzOxIRPHpCs4xE0/EYlX4mx8xqljazx+eLCsLmAF2UEJJwQxSCMi?=
 =?us-ascii?Q?L50A1/XMOsHa4uRs5jku6RV4kObpQ6KEfq83u5n3ZEp8FIRq5xrea/quaeG1?=
 =?us-ascii?Q?ft2YdBjDbMe/yrzXZgEehlvXr4cn32npZkA2SiZO5e6EfM9CYVO3oKA9vO1P?=
 =?us-ascii?Q?OUzGZks7TrYoPY3ygDA9c2+RhKcsZXLiuS9oWFOb0ghNL/wHaSUf6yje1+Gz?=
 =?us-ascii?Q?2OgHfZxgB+J3+F2GDklp5AUwCQ0QdR/bcWprSXnxA6BkwniiXy+rcntmYWpH?=
 =?us-ascii?Q?Fuom/MBBRjFywtNgS3+OkSrXrqBDx5azMX98D8BgZowqGyRnhasGBi8H1HDL?=
 =?us-ascii?Q?qhj54fhmmU258T1EprQNplfTV+NqNBdFv96AXSJ7kgkyKB6sUKITFAE2ZnKh?=
 =?us-ascii?Q?QVqhEQMVh91ltYMkPshKnIM8mU3ZtJnrgrCkdjFJ/2rNzm2M9bpXsjWyPHRz?=
 =?us-ascii?Q?97Mvkta5EFCW81trKdGOCz7fKRX8Q3YvzuQojmJE6++WUmJZh+dKNM8cnvA6?=
 =?us-ascii?Q?F+pOIg3d4EvtnOQTnmbNF0zuZxx0kj5yXiru3G247QLKXUsld0ICxnDc9oJH?=
 =?us-ascii?Q?/CNXzIL5wJLk8W1VoiPjbRH/Ye6GePyNA45J3vg0N71z7jtHYpQ78Ho0Mv5B?=
 =?us-ascii?Q?pfEBFrFASkTtcG2W6SVI74LkVizjx2LIbcq/Ycj2lAWtEW+NGFAhvLz5Y22R?=
 =?us-ascii?Q?hdJdR0yxC21GxraqtpauTsBaXw6bpB9kFPLWjVMjRMKW5vsCOeQS/YDPThIg?=
 =?us-ascii?Q?RbTNQqqx3L6RpH5/ekHzmPJMIIxXdsKKGVTfD+Oc49PSaeo/ulRut3NI5t6p?=
 =?us-ascii?Q?9N1LWcYiiROV1jMc4iaOpFBf895d5aLQGBeS5tB8h7AW+LKg2WQp+GddPEgb?=
 =?us-ascii?Q?639yjW1w/nqiUl+h6616f52KjN0BRVgSAM+f8xEColAsea8pWelh24PmCrZf?=
 =?us-ascii?Q?KfxcLPaUVHgS38qC86SN/bLgPxElU9mnaPs01K9Y+0VRjku7qr5XlIppDJiG?=
 =?us-ascii?Q?03hAZHLKvRO/x0V89vrXFkydMdXMWuSpS0uGnq1+UtA0hjExHCNcTBgsuZuc?=
 =?us-ascii?Q?KywldfSdafmIBRwW+L1dyXtJT5l5nCwPJaj5s/95ELGbHSaxVNh5Sj4cssqk?=
 =?us-ascii?Q?bZNwNzVKo7TycZRFdE6mUohhY8IR7iXqZHT2L/aK0WFtl9tPDFb3orJVVTa/?=
 =?us-ascii?Q?c5WeJjfBxeS5+ISEZRdoy9o7RD809tm9FFJ4IPOP/I198rknQnDqQPLsrDTU?=
 =?us-ascii?Q?vYWZCykzL2f23Mf9OFmhL1wSP68EBEfBd6UaA3Uo9HupzTZqVMBfEY8ymK0i?=
 =?us-ascii?Q?MBdcJGLVnG1EAg2z14evJtNG5ePY4CwqgzetDk1xDMH/VRZLBBM0M4o1xZy7?=
 =?us-ascii?Q?RJOPjYtLnG8JQ5j5pQZnoZk/9A+sGgb/+cOZkAVKs7FYDeBxlvzZ5kvU5JXh?=
 =?us-ascii?Q?oZfUfsZSady502GP1y6o+YZYAv/dkQsZ7kidaAbZ7QeTWFzYXFgAGofgmXv7?=
 =?us-ascii?Q?RwagVJ7QLSBpHKYRuBeVvkWaAyTuxoZKrylxlepkFvycjlljH6kP7XMmJokS?=
 =?us-ascii?Q?NZ6SWXl+Rs0ZUwgzmgQMmd6+fWFNlqgIeKyvo83XpdSius+Y6dQ61ZTzmvqE?=
 =?us-ascii?Q?BXa0Z0XjGhPyusMV1+usVxazkGnyq+UwkFP+4APyIZd2+sGwXJ7xwrPnAqmL?=
 =?us-ascii?Q?HOkOevvydIgtydzqu288XCaiGj8p+aUrSw3eoAVrkefi786jFzjTyYURP7t4?=
 =?us-ascii?Q?xm8nteC7xMV+zk0G5xnfpr9IyQt7Too=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae86135-7f01-4106-b9c7-08da3895427b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:11:34.4127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Jimi/Hc9W1HELnBe9hP6HiUBCUKi3A3e3e96lKY3Nwqc82H2EBo2wueMs41nTgoJEuO0nzDoQ3O4KdTfT+gYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

CONFIG_IKCONFIG_PROC is required by BPF selftests, otherwise we get
errors like this:

 libbpf: failed to open system Kconfig
 libbpf: failed to load object 'kprobe_multi'
 libbpf: failed to load BPF skeleton 'kprobe_multi': -22

It's because /proc/config.gz is opened in bpf_object__read_kconfig_file()
in tools/lib/bpf/libbpf.c:

        file =3D gzopen("/proc/config.gz", "r");

So this patch enables CONFIG_IKCONFIG and CONFIG_IKCONFIG_PROC in
tools/testing/selftests/bpf/config.

Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/b=
pf/config
index 763db63a3890..8d7faff33c54 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -53,3 +53,5 @@ CONFIG_NF_DEFRAG_IPV4=3Dy
 CONFIG_NF_DEFRAG_IPV6=3Dy
 CONFIG_NF_CONNTRACK=3Dy
 CONFIG_USERFAULTFD=3Dy
+CONFIG_IKCONFIG=3Dy
+CONFIG_IKCONFIG_PROC=3Dy
--=20
2.34.1

