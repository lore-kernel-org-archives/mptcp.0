Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEAB256F
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 14:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654092524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XVEh+4oohQt0XUMdIgg5ktNgzeix+uZ6ytucP5wyv4=;
	b=VDpcIpr1ASQ01nonuoJEsAlrWM4JhGroIMajrxJeDMxoXi7oZZeno+JE1JE3rebNuqo1e6
	LHD8z8WMR0U8qQmOaeZS7BXm9tX0SEe5e676boR6lVSYnyWABq4elUTFNKmb3K8GB5jLvS
	xHNMgloRhy73E+AHd9NzXmrQjJDBmiA=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-43-dnVu-1tgP5-Ht_ix-NZ2EQ-1; Wed, 01 Jun 2022 16:08:43 +0200
X-MC-Unique: dnVu-1tgP5-Ht_ix-NZ2EQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUyhrqRL8ExWlO0LzAZKMrrc7sTiIBQ434mFfewGv8ervEudbG644PD0+ffumycvd49NulrCovt4cQw49Clkzxmif7Os67nI3G7y0H28LXHtDqCFFaPxHtKwoaqZ8pkgH650kUP2BN6FarZ7LRHNoafVJ3rrvGnFdHaaySlfT4/pseYSc8oE44YNUMyVTo3OaoE+FFlWce6w76in3aooXUE1H5jP14r4wsVPtEsF7NRla15yJvGwsNlkKNf1DD5p1px2II2HV/Yg06ONiE4LOgcmnIZF5nx5fx573wbQ74kDGzFouQApK9KvytL6Fchx8VgfxB9oyBvjnZhk32JYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTZx3ll2k3q1OqI0daXsEaVA8G+mDbxRVrj43jBmfsA=;
 b=N9OErM3L0J3koG3P8c3XjPqHOWqWTF2DXuY/Sp8z9sF5mwrDspkBs6qQ7A7AIrTMPmiJIzY1T+eTnKSJ6iIpuKNFQL5LTKCIdtSO/0IPfdz7mp5MSwpabmT39hlKKtNufAKcdHdRllwH5MSVYRktlyveuAhJBrcUVFPGzhfR3lfrcuPKngWmG7V5w5qsubFQ2E+vSw7h/5XPVbHMuTg6TbTNWC5h5mh1EYxClxB4Iv+37lc0xyN7XprJTCqF6ASRty9bBbQRyS8qY57ZH0jFpsjTtz07NtZ8OXTgLjasenp3Hz5pihIAQ559ZnTxaSk8lO9WAt6DN6g+WjWr3LIACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4805.eurprd04.prod.outlook.com (2603:10a6:20b:d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 14:08:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 14:08:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 02/11] Squash to "mptcp: add sched in mptcp_sock"
Date: Wed,  1 Jun 2022 22:08:15 +0800
Message-ID: <4032935cf852a5ba37ccdbe925f063967cb30402.1654092153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654092153.git.geliang.tang@suse.com>
References: <cover.1654092153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0202.apcprd02.prod.outlook.com
 (2603:1096:201:20::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e55e26e2-937b-4935-15a2-08da43d83bf7
X-MS-TrafficTypeDiagnostic: AM6PR04MB4805:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB4805F3E66CE0A52B148533D9F8DF9@AM6PR04MB4805.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ees6akdejgwb6UCNKm7YX6Z4Ap97LymahBvr3RjMB3lGi0BYLyIx/uh9ABBWTZwf8WCVwkfuLBmEj2GctoXD6ItBzHxBLIZawmxvLyCwgtSyFf09fSDIHiNufMwOatAwGXqkGhHcp7UfBebOkSBlLIUZ1htR1h+d0mZxE/z/vEq5Qgj9eATZ4Z8FKELkzrENJdHgmXo0YpHWojIamcCE7qIiED4OP+HGF6qQNQzD/xz2Rh3ElMjj+kZNUqyJDf7+vmgm+e11lb0q7WQHmDZyy1XHLRs+6+eG00R0gOSyaGq50YRChlxJdSfPGJp/Pwccr8nhapdy0WnJuAQG1lpwle516ZXqroDxjKK1wb2b8Ne6Gsj7wLWqC/RkUUHpF7A0F8zwJzmvBMHZnHFyaP9V9v/LYk1xhL+uxRvIziuazlSq61o21oQ9ldmJ7omwmB7KVIKT/daeBpOgfRqQaGXOgXixf+7OwAy8A9MrSGq6E2Xg9nFcw/L+Iigr8b8e3YJ93s5XFWL36xjIq9o/X4/9Jqsb4bHExZVP6SSpyYzGf1cDgS/yrIw2y1qASlnxwiQs4W7bq5HZWvJomMwWXgsG1uZq+gvjQ57DmKFnrW868EMVqlbgNTULN7FCwu043SY2Iwa9DwdC3ss6+el8y+PeZnfnwMOt836JF6n9J6u6iB/uj6U/dithb7cUoNMQAzYu1X/P16rSt7AlCD48HDybYg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(26005)(6506007)(86362001)(2906002)(66556008)(36756003)(4326008)(38100700002)(8676002)(66946007)(66476007)(316002)(6916009)(6666004)(44832011)(4744005)(83380400001)(6512007)(186003)(107886003)(5660300002)(8936002)(508600001)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HPa7yNJxteIjN0DVTR+MxhJoP5zqRqMMw3qLeGmSqdFqYsnmitcGBzowUzSe?=
 =?us-ascii?Q?VXiFORjnCpTUveh6q5JnVJeV9SHwb1wi8OcmpTHv5CaTM5i51ETIGwEm8gGf?=
 =?us-ascii?Q?G7HHhZfGzX+p2wZBY9vAZWlRhHljIZg5tM9Gi+Qa02T4YELjphS/fdpJQ2eI?=
 =?us-ascii?Q?z476WgQyuH05nYNm0kbtkJPWF7GcQgMyO2IobVCCA05jl3iLPEzbmGiOUM5B?=
 =?us-ascii?Q?+xmOAi4w39/V5tIDurq1WJQnVojYpiRB/XJC8nmKsIzYEYi+ncLyI09a+a1S?=
 =?us-ascii?Q?vD5JAZLsrzhjy129ITo+6XzATmL7twVgIXsi4MrgVNismbhd0EQu1Bp0REYB?=
 =?us-ascii?Q?vNTpHnKELEIGacuC7wInPr7VWYiN5bqvV5wURrLkCAY90pTjvOSnZ+9BBFCR?=
 =?us-ascii?Q?CFYi5URLXcxUp2OYteSLXSDAdMV8ZsabAoB2ebPRsF+GGM2UwWhD4oF5hKnJ?=
 =?us-ascii?Q?qgakMaMB1bLd2tJQiMtKY614AwAn0J1vNAYNppWhWdPhwKJKXTDapwmzJMjF?=
 =?us-ascii?Q?2h9NwvZeMjb7mjexy0uChde3LRIowCU9xDAm0+E/TcNN/eDtFKfXl84G03q8?=
 =?us-ascii?Q?MhBT4S5he+3zL7Mlp5pDW/Fxep3/xAImGObbKbfIk+tEvqILyxgVBjYU0B0q?=
 =?us-ascii?Q?0RmlmRejvO1ewKwQHKB1XGg73hYI7JUxwDfg94BnaaiTiRlBV5tnhGBlx9LC?=
 =?us-ascii?Q?qGLLWB7gLPiQWsai3Dq7522VCuXwHdfRnu5UCU6Kq7EQuUldzCNnJeGJdsDr?=
 =?us-ascii?Q?le4sAiq2Lnp0kuJMqCsIXE4ejOQfmkMhm3a1CRhUqUa/ccrH39fBwyglzFoV?=
 =?us-ascii?Q?/0Q6l/I5wdQyW4hrHIpK5pkFEtHMpse/qBTAX3TK15lcfHEffG3+tEV8NGe4?=
 =?us-ascii?Q?DRaGirsrv+aNrX1eJFduTUG6ZWpok7N3Z9vT0hrUAW/I1HLS16JPHxLBlhs2?=
 =?us-ascii?Q?+hVjbpxvZ9N4eYL7LNYZTwRJLIxdc6ISMYHAAvshRWKJkOasdVkCZkjcOzVT?=
 =?us-ascii?Q?hjSyttaSyl7UEUSj4BhRfFVS21UIAy9hxOz3Y+RLJ3DrJYH6eF0BANaflS9O?=
 =?us-ascii?Q?+ORKdSVhH0AjQnQMeN7QAnl7uMOT2dOKMxgQ9oIcJ6rriUMqNBxM5ryGVFFO?=
 =?us-ascii?Q?5Bee3koDl3EgLR+0Y3B2BFTRuMvMnD57kof8B81CQw/pDdVFeL+T9nRA/JU6?=
 =?us-ascii?Q?OLkwNpbThnnqAv4gleQqMAzKVh/I0G87JXxd83tI6FJhPSJg0lsrXqvrChKL?=
 =?us-ascii?Q?KD5TAhNUuxzIOVI2B0ZkOx5yJq48E7r2mvv1x1I+eP0UxDCjBq2fbHla8hh1?=
 =?us-ascii?Q?sfCveirqpaRvv7+u9mC4YUjJNz7HPSoGZIqjAtLM+MADxxIijjnPdVJjVNlu?=
 =?us-ascii?Q?FlSV6iDhwu46oowWtDYTjJYgNipmP/LJPVsMXeXuwJ/crKWFYibk3q2ReLtc?=
 =?us-ascii?Q?bAn1zuz9HRD02ZW56yoYim9Alg6dqIt4rPEbtJ/HNH5gggsju3oxCVQEOJTA?=
 =?us-ascii?Q?AB1XL2FXyzV8bXEmXS3hFrwP8ORd51uHu/rB+kZL7tlsK0p8gSxTw6aARw1b?=
 =?us-ascii?Q?EsWqCguseR5zskUCytEau9WC/6cmwqzVUQsrkxgMxyKIsoSqHOlB3KBt8S13?=
 =?us-ascii?Q?pvGdjZN5YIJKhNZQdcECYfSPGmmuD7hcG8QhoJ5PjEjb/oTlLZU+lhVN1B++?=
 =?us-ascii?Q?hCecBbXMmewullT88H1Pu3SUyHUuGWJP85P3bwES+RKhUTfzf/Kh464kzoFT?=
 =?us-ascii?Q?h7A6MNf4flTQrclIPyoHPUDcM2u05VQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55e26e2-937b-4935-15a2-08da43d83bf7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 14:08:42.5017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhGEReziL7sSnnqVhL1EahLkP2pkTqC6sJUs1cZvufx8im85Je+sE6nNo1py89ePAlG7XGL4IWoMWgHnBCp1IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4805

No need to export sched in bpf_tcp_helpers.h, drop it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 8338c7b31f87..5f6a7fa2269b 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -258,7 +258,6 @@ struct mptcp_sock {
=20
 	__u32		token;
 	struct sock	*first;
-	struct mptcp_sched_ops	*sched;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
--=20
2.34.1

