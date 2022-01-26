Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF522168
	for <mptcp@lists.linux.dev>; Wed, 26 Jan 2022 09:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643189699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nF84q7Jyr4yQYU6Lt834nIVePouHPZNFA6yEmDuKeNA=;
	b=ZMdumVr1EV9bvNSoNKOHDfPUVUVfq29DPYisWJnsGl+joB++rnjFC5h4AnhKErWcsLqeIQ
	7SRypqFHGdE7tkEB0Oq2QUAMK75lxluPTeefZGDIEfLavPlLQryCstLnG/IOqN6xOO7aX/
	5VFKN3sGopnB5okD9/BU0ZaQ5D1OIj8=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2055.outbound.protection.outlook.com [104.47.2.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-EZJc3s-BPWGTC8RxQqd4_w-1; Wed, 26 Jan 2022 10:34:57 +0100
X-MC-Unique: EZJc3s-BPWGTC8RxQqd4_w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWhjz7NCawarNA7uDOLInx3laD3BeoZ0V5tZXemugTwg14+/sftS9AxqfKVD0Bhq5/Lfl5ZXjwOk5gecSgq4nN6ZvlEjLroKR94eNiqScuP/c7l4cmP/X7/DhAzXZQO2uHN6kwITPHgwbUHvgLx2NNqi+ih829k+Ihw6mqlh3S+6MMzGwavQfImP5Faxe6EB8ED2zKQBujnyHZLlo/NqhHdbv4vk8zTDEMIkogwZOSY+BcJl5qfSKA1rxAZ5hwd/7KN1KvTlfM+VMr1o55ZMW52wf7kOljQ9oPh/XDXgN2h31UuErp5UjJ1ifDcB2FFbps/lDbLDI04gNgZUJeoQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGhq+Vh6DZzJh/yIBnfHMdAjXzhQxZxv15GasOgPdyg=;
 b=cGPxImgD3OKJHT7Lgy1InYpjWvkim1VPdJtHrhJMzIgUvsj5D8OulvcPO+rEItnfed3DNfu1ikl/NQ64zDtKYXkk9jd8zeUPCLAaf2k+iVv1I6uuMrUWB4rgkP0+/tmYPbw6TwUo/7keoNByW/1lupZFLG6ljVD5sKYSBIL4VsmmFJRZ2LgonB2VTn3EfRmPPR39MGlrqYq+3wHGhHg1GxvAUxiwu1Hep1+JUAfBoa2bt/PaovalDAkKrKU51PUgYxbJ9pb9Y4+ibUvpGb9MoAW7Zc6eiesEkV/DtYYsg5nkG7Vjby0vMCkkwRDoUZPJP1nz1jHmDXjbraoU95d0wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8088.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 26 Jan
 2022 09:34:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 09:34:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: infinite mapping sending" part 2
Date: Wed, 26 Jan 2022 17:34:56 +0800
Message-ID: <016f512feb4ebf9a66808074e9b096bc1c3274d5.1643189677.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0149.apcprd02.prod.outlook.com
 (2603:1096:202:16::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3837c567-b71d-4267-692d-08d9e0af1a0d
X-MS-TrafficTypeDiagnostic: AS8PR04MB8088:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB8088CB9843C93A8B40026396F8209@AS8PR04MB8088.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b5trzi8sZa2HHmGJ2WYCTBnIwi9CQ+ZbImp+ub4F/nUIL4oQ6SLxEeazRcoPLExMHT+6XbLp18Zql9i0YUFbZz2hROs1+ljXqqT6pOV1sbflGOrApJry3cKW2gDGJKrJHhqlfyua0o5eDyQQ209R38As3WPcA1LPL38zOmiz6Y9V9vJMEpzkkc8TziOA0tPfe0cjOE7R1N6DRlAYl6DXM1/5U7nZ1F4xLxmlegjlTdvauQFOwSX2b2oT+iCIqD89tfQWYFVuzMbezTRIFjBRkkTi4l+MsFvgvwwJGbZF4XRSdBro8pWsXLHyQqKEPTRHQ09Ym4zK/lPeNLyiSZL/ATajGXDrYHu8PGaD4uRvuubKiyn9vSuefLr6sI3i4jWLGLDVGZh/uksc3SfZp3sAYR9VIedqsr2pQlxiFyXP4dzLqhPfmXC4JH8nwG3ccdz+qQCuKhaYdTkaGPoNYwor3Rfw8gqG4m7JsBR9qMoOSeBWsGn4zkzjwB/K0jJ2fZP9J0tOKRZcYPlh1ZuHoBJovT+jD9Z95RZnFaQe634QtxtF95snXX2XaYJIGbaNcwSBhf5pdEApU6xmf4FHRTTYqX0ON5I4N9/J6Uo8wpoR6lieh1y3E6DDeZI8IPVNjeneIDkpYg2bBqy5nNjWdFaWzA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(8936002)(4326008)(6916009)(44832011)(83380400001)(6506007)(55236004)(5660300002)(508600001)(6486002)(86362001)(2906002)(186003)(6512007)(26005)(66946007)(107886003)(66556008)(66476007)(316002)(36756003)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DJZsBn41ALLQrzyEjxmgLsb9Y0LamF5F3s6zboxCXjJ3AkXSY13IGlQmNtGf?=
 =?us-ascii?Q?MyAv9atxlurrN21YfiPg2zrV4wRuZj8pXbYWIFL9TxAQo8eRdw2KDqcPXi6J?=
 =?us-ascii?Q?2DiLKvDpcyKqfFFlEWSW796lh3ZwM2zNSvgHK1qXHe+BbCK9P96e8tQXb662?=
 =?us-ascii?Q?2fGFIQmuu/S7uMzXCgHnyD8hMR824H54cb9a635+eGjLS8T6k7AuS3ky5L8m?=
 =?us-ascii?Q?S4Y5yHWNeACUcHX1VDyAgjoqRI8gkCVPADZrgjiFqJKRWhg3BMHAA9vhsxjQ?=
 =?us-ascii?Q?Q7Nwl1h83OhPhAj1u49bJDs0wtvnIKOaKd09CQe3OPmXx3Uxzy7InhgMfr46?=
 =?us-ascii?Q?oGC9NFyX0Si0IRjLCsBDt/TcqmZ5SB9EEu58NziejjrZdAvA7DAeVbKAp6fe?=
 =?us-ascii?Q?tEkH5JpHm2/bNeXOyexPvFnqhfxzxEZVE/pVUml559mIX7VcuvUkiHlT2cHW?=
 =?us-ascii?Q?mlw5Ci8j8m3BbI5QxpXZ20mgEJ3nf77FtCOiccK+YSK653lgvuvbEExqbLh/?=
 =?us-ascii?Q?s0HA9T27OBaxNw9WOtEwggPxo6g9RL742nDp/WpAfViy00kiOXFfvjF6UNrv?=
 =?us-ascii?Q?sFscaIqmWxPPH3/5rwIELkw6knPFUHjjLz19pWhOwCx5yoJt10F6Ysj9oXd5?=
 =?us-ascii?Q?+I4vLQ85efvLhqg6Ig9TiKRijm5dhIIT6YAFsM3B4BaLR55C/P2PV5CA1wA/?=
 =?us-ascii?Q?SpGVBWl7vfn6tYXy5fINPjqMyqh0KTzsC8diDJVXFuGCQctOxLlIzWfpDjPB?=
 =?us-ascii?Q?6g1uZwoTSUYnjosdh91K7mx3ytSZf1GmL1fLChkb0nPshOcmlX7fFU70ZutI?=
 =?us-ascii?Q?sr1aBvm03q+YiRIIMh2oRfSZ6XPTnYjh34laFdQPxSr+viihEq3DYL+jMPKF?=
 =?us-ascii?Q?HWCA7bG9shtPBJ7lMD8WkpE8133CGXbhebQg7lN022tafSrtLhTecjjrDem1?=
 =?us-ascii?Q?bRC47Kedqwn4yRcRjGzkHug6k7h0pkaJMBHgSzDdRo3G8Jel5w9A6f/YGRiQ?=
 =?us-ascii?Q?jRhAsnctVZqx4/XcTml8QhqWRBqf5XduJQ6XF2PB0Vp//pMkVRSBKJykPxZN?=
 =?us-ascii?Q?FFTq0JYJE4Ua0U7E37vnv801LxaGbSOwNfCMInMaFG/e5uaf+tW4rcMoOUcu?=
 =?us-ascii?Q?YpXBjZTDjEvDo60HhncfNYNZYDBMMUUYp+mJ10Ds4IP7UbLUgMPqWSrRDzM0?=
 =?us-ascii?Q?VUXi/HkFSwlJa74DEBaDn+KwpH6Tce325AfQN6TWey8kvg8kF70TIwo4Ox0D?=
 =?us-ascii?Q?SDA2O0Zp/3/+v9N1zjoE8LSSz31jwt3brlOfdXd0oCGWxxVxFwwdB2f0LoxG?=
 =?us-ascii?Q?5bA70yCJcQp+eVJ53FTvMVmqAVMFD50Eh+MQoyT/uTrMoT5yExOF+FLrhS3V?=
 =?us-ascii?Q?XwUFEVWah8+b6craFOlGMAUaiJk8Vuivnw1EpMXZ8g1frG+HvgOIusiRirBA?=
 =?us-ascii?Q?NIv2hAG4KNwSKKLkDRTw0Ea2N975vvtc7bStH/Z0PjiLXr+SxP0GpDgMjIDh?=
 =?us-ascii?Q?+6kjamRhNXYA1+8KxCiMQLg+niYUUqk1qXXVbNhlNmOrGiIGrJlj18x+sV0H?=
 =?us-ascii?Q?BKYXElOCNCjK/Hrv5+6cHG2856cDqXKTClkLliYguXoQOfR21YUkpXfY2dBW?=
 =?us-ascii?Q?QxYXFnhizPXcHHzRgtHrBSQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3837c567-b71d-4267-692d-08d9e0af1a0d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 09:34:51.1402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hN3f3Ps5Dkjdo2s8S88DbplXGOeWbJurFF5QQFYCmsCWeVgLdxEFgbKZoFTdAgOa3EI0U47HBSIwNU8C55hc3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8088

Fix the checksum value of the infinite map.

mptcp_make_csum() will return a non-zero value when mpext->csum is set to
zero.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c  | 3 ++-
 net/mptcp/protocol.c | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 03c82985dba1..48a805731216 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1339,7 +1339,8 @@ void mptcp_write_options(__be32 *ptr, const struct tc=
p_sock *tp,
 			ptr +=3D 1;
 			if (opts->csum_reqd) {
 				put_unaligned_be32(mpext->data_len << 16 |
-						   mptcp_make_csum(mpext), ptr);
+						   (mpext->data_len ? mptcp_make_csum(mpext) : 0),
+						   ptr);
 			} else {
 				put_unaligned_be32(mpext->data_len << 16 |
 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 526a0f5ba415..3324e1c61576 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1231,7 +1231,6 @@ static void mptcp_update_infinite_map(struct mptcp_so=
ck *msk,
=20
 	mpext->infinite_map =3D 1;
 	mpext->data_len =3D 0;
-	mpext->csum =3D 0;
=20
 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map =3D 0;
--=20
2.31.1

