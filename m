Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA717B
	for <mptcp@lists.linux.dev>; Fri,  1 Apr 2022 15:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648827074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sulFwIRyO6ZXwZF6lU4kDTsEz+iBfbTee7gQmxn1T2A=;
	b=QA42tNh1FvC5Isk9BkedPksM7AIJJraey/++7ewFva/m8x7rQI4iFe4G1cpzEK+rpClQhy
	/+D6W2obmKIRywxthp9nTyZ3ZRbC1BGa/8i2gWoqAked/+CFo1hCUjFGeBZJE71HeO04ud
	NgJxpCaVRLL609cozWCxilkcBoIEx/8=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2055.outbound.protection.outlook.com [104.47.0.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-5xIW3Q6pN1i97-c6MurK8A-1; Fri, 01 Apr 2022 17:31:11 +0200
X-MC-Unique: 5xIW3Q6pN1i97-c6MurK8A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5zrnVT/lzfuGqYQL+eeA8roSngqH00aO3dPCmnb+RTdijrKh6RRtwv2xkTzy4C7xSV7RsRT8/FD0i3dxC2LD5XsTZnCcR5GJvlJIkVlfa9ykOqo4Q0pmwQZhp+ov1N1fFbJqXt+MA7nrNFVqPv6Nc9Uy+NfTYdOdMsfAMYA3ywPJRxgEps1AhOtwH3Cfbzj6OWyh0CElb/m7tyRjU0ZDZMACa4fG/Uiq/Udh4YrOx80Vpcl8pcgsLzltAkVDoqQ2c0ohYquZsoxSLduUIn4q8eIXLUSdQfKpeD5E+agBQMOJzlHXN1RXY5y5KT42hMJoS4lTCPjupundDtwaOuzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ckm3Nxlz05EMqmwZo4V2hMtrFU1rtLr3SVOO0BajXis=;
 b=C4cZRRfPZaGZMEIIFG+MrMAcVuVPChWC56OdetZSJbBRuoDbjwbFxhpf5q3SJxpRYSGHGENGHyiyRjRECrG+NYEJ88oR+rOQ0iqDICGBHT9TeVRmV9NVqnpJb5qnLJH2vVheq+zqbsNy1AhZOQwkpMvcI8uHCQYe+bHSQjBSs38+SXEwa4D/HFR8pG130Fr2m+gOs3QjDF3IU1NGgDKMBh5BdkA/yxrku0h9t5sRTcn/Beoi3B+qxH+PoYkfjsneWzLjzU6+tY0h3CAHbGUcRO4w2LjEaiTkOwAw/HGSnFwD92irgEN7wPMwy3zQ2yX8srWpRqE/WeMjAW+uevSWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3418.eurprd04.prod.outlook.com (2603:10a6:7:82::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Fri, 1 Apr
 2022 15:31:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 15:31:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/2] split MP_FAIL testcases
Date: Fri,  1 Apr 2022 23:31:05 +0800
Message-ID: <cover.1648826372.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0074.jpnprd01.prod.outlook.com
 (2603:1096:405:3::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44cfc3fb-615d-4f74-88f4-08da13f4a5a9
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3418:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3418F846121F6543F617BEAEF8E09@HE1PR0402MB3418.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ThCXtwwlRU0bfdi0tX00vwtR59ZXOAd0Vkg5PU2Ip9y4VwLqhh6pM6Zh94fP3VvajsCUm5MqkHRAQ/4amK+7oRi5XeiI0nnPP+kvsLmUMWsdM4OedgaiQ/k0uaJTPQke9f8N9tNtP29caJG4fjw63eUBdcqvSlhQQKGlEdm9zkIwNAA3X91idWrwOccGt1nnv6+hdM+8DyGCJj84AWUxgbbao4bd05p3C/oZCTnYpVtXlJnWaLsWqh+G+A4M+L1uA0fC0HYAYBKtlPG6rSVM41kHK5XbkHfRWeQJsDCAAQRbttM0usWApUsRMDJr7WmQ8eoe3YIVJ+VWxEohlxzhc/+cPs4qTEFp923K8LbFRd/v1FKhk64KDAZ1Mg5pWXzQ4FxzHaSMHjIFBm48tiNvyYESyjED+WUNvTvN4Fsg/9mf8f6Dm5hGh87JxQnfxMnkWmTzObBEC1cXtnSAUC7RbX129igtOHiNmyKT6BUEoK+lUZAVBJoCIb2Jrx02ymLelJA1Ol3VFWb8qloff5nknIzieySMjqEvG/eNpBjlg5P6iVktNjsbHBxNbx8sayZOqX+0bBTxiZwUPQvwT49V8PKqI5oCdtOfQRwQRq13Qo42EGyxI2NpyGaQJN4Xrwk0vQXE+Gvr3IHngAJLNzrbsX5th7z4MQP3siOqlCJZxKom6iPjXq9yAA3UwKLQIUok
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(36756003)(186003)(8936002)(4326008)(107886003)(44832011)(26005)(5660300002)(508600001)(6486002)(8676002)(66946007)(66556008)(2906002)(86362001)(316002)(6916009)(83380400001)(2616005)(6506007)(38100700002)(6666004)(6512007)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?temrdSmwsa/nOLYkknehGsOv/z+YFYnWG6oEX8tJ0j0VnmZcxZDqR9lFFK3F?=
 =?us-ascii?Q?2GLo6nDmNEz9dgRTWWX0ww6BmwdPHp+bnbwgZLiuB611YwP9R1KwB0vX6nRu?=
 =?us-ascii?Q?EOSdpQngl0ptHG3UWJwzhadT05i4QwvCXvBg1HYnFq20aJoUQqLqDjHoOVeo?=
 =?us-ascii?Q?vkJlexiUqdpMATsbCLKUS90PapT3yM28Xs2yd+b3Tdliyvgb7oQChkGL0P5f?=
 =?us-ascii?Q?TP/dRnFE71LrumWge3krJSj+NJmDxoLB3PmWAckdA0FE+NDn1l3DNeydtV3N?=
 =?us-ascii?Q?g/+Po1ORTkmrBRynlurJih03V+/6hCbgZAxjTyfnYHEDhcSyGSJJ8eMvfsVg?=
 =?us-ascii?Q?M4hVXePjybz4Uweep2Kx3MRjYaIRbH2gnquOLGP9yDYe4P75t99dTkWZT3OB?=
 =?us-ascii?Q?oBehRJLwbIGeJULBLbAGSf5r46tYDjBh2ftMqaPop8sd0brsl5VeK/Ish054?=
 =?us-ascii?Q?gY0f7Ldl63MvW1s6V5uNfP1pzR23GF2Dkh4BsLd4pVb3Fn/IzX/eTJSmlqV7?=
 =?us-ascii?Q?86dfuBC+UZJG3NF8blvq7/t6tEFlU6j/7G03vkJNV2HMdSmnNoM+gw06CQro?=
 =?us-ascii?Q?iSad52sf6eqFO8dMv+LSKbMkA3JxwwA3tg+fXxNxPtVR6D8ec9A0hqHMKfHK?=
 =?us-ascii?Q?WxV9tvIT4HFLttRTYU/yT9H7GPmj9ZMqAGW/MEFOa3s1q4fcLRIDDpZcbOkm?=
 =?us-ascii?Q?6sf36q+Gi1GKG7hk0RHh18L0lIVunqrhPdyJS64bkO3tS/OEY8xyEwj8rPfF?=
 =?us-ascii?Q?oGrEuHcIw9yyqnGhh2xWtezjXEmuV6/uwHsLdef7giqQf+TngfbBoaHjoN+J?=
 =?us-ascii?Q?mIjm48sDsIoz8UBsuagXVodIJU9IM6vu/jYS4spWXJNpUkqjaMKNUN2ZV9HV?=
 =?us-ascii?Q?vGazRdeDQuTfvKxvHna9J1+QPC5PKYG1jPMiDhFrG4+6aQmIZbW6kTQlfvhf?=
 =?us-ascii?Q?i2JEZ9HJClMkCSSY5is3z+AUFjogEPB8XGANBDgRRgOllqzHfEejRZmcCwW3?=
 =?us-ascii?Q?SRQfbpW+7IdNwd0TAa06OASBb0kcXi4ngf+8YHdSUG0eF1pHwd7NO+q6Trob?=
 =?us-ascii?Q?ktYWJobA/8AFcvjpuOO220MTXooMoz7rTyWnr09g/mgy5rvf6DGYEmQNRhbW?=
 =?us-ascii?Q?JprBn/89tQkbY7KIcVfT20LVF7OV/hN7Ubr8d2m2Erx47fOiQUOhHj6SUFQK?=
 =?us-ascii?Q?mE9q+yYipFOLQ7SmDecJSA48UAmvR6j/sr92jhLJANQvDOcFMtAaNwG8te/D?=
 =?us-ascii?Q?VK7TqciczXEYLe8DBvQ19erfnqMXB+A5fHBqZWdl9VmEO9oe6ErFvW62qfWs?=
 =?us-ascii?Q?waczUv6uvqRVITPQbCSoMJvsTVeM73zQznk097egx6yeZ84v1n9aRy7BeAFd?=
 =?us-ascii?Q?vxWaFLElrDug+Iobz0u4RmU/IWmDgM7uLvoLnQyzmv7/XKwQyzwa41EtNge7?=
 =?us-ascii?Q?7Ppzzjnd1qk3M0oo/s5DR5Lle3EWg6VMwRn5TxMCTp7mKKVDy0Y4EcMjioW7?=
 =?us-ascii?Q?XkaJ4Q8uLi33DKQFtGXrG4O3fn1crcNtgz1HZmKhO+OG8F5F42R5PXJLYtLU?=
 =?us-ascii?Q?8orueaCZ0YfzZQpDwkFINDI6qoVkvWvq5kkCRfsfpAzcAWnf6a8EsAEwn5Rd?=
 =?us-ascii?Q?TFayXRcgZ66f8kaSQmNq5wwGcSqjJfXfHWoqvk+bZpqtswIN0gqhlXVH4J1s?=
 =?us-ascii?Q?dGu4mth82OLtTYVCabLSCl2EoQpsbtkPTl7RPCMXr6c5uTw20l9YtmmA2D5Q?=
 =?us-ascii?Q?snAw5xUHMnIo0fZ98tuFt9bFCsmgC84=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cfc3fb-615d-4f74-88f4-08da13f4a5a9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 15:31:09.9895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAJ2SAbxoTfzwPZz+20YK/6M5bnR9y8fSrtZ8K4c37J1v0QLlZRTAMSRwxXYP3iTJ/z01jOwW5iq73mUeZBcXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3418

Split MP_FAIL testcases into two patches:

 selftests: mptcp: add infinite map testcase
 selftests: mptcp: add MP_FAIL reset testcase

The former can be upstreaming with the infinite map series, the latter
stays on the export branch, waiting for the dropping bad data patches,
and the fix for issue #265.

Geliang Tang (2):
  Squash to "selftests: mptcp: add the MP_FAIL testcases"
  selftests: mptcp: add MP_FAIL reset testcase

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--=20
2.34.1

