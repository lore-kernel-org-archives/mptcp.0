Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C66B2CA0
	for <mptcp@lists.linux.dev>; Tue, 30 Nov 2021 03:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638242504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luGxql1um5DN+2X8GR7VzoSV2V+NSjWXi3A5B+M50JA=;
	b=UDV/K6/OzaxwE3AJhnaNY6u7kxsPYEtmLbYh2R9PS2i2bQdaJfjW2r/is/vKFdxNJ0Hgj8
	AXvJC3MCJf5SIvGpz//lJeVdjBMNvB4CUurx8tlUJMm7o46iQGliygT4FZFGAHoD58SdHj
	H25trtLZbutMPhU+skWY+VnKY8M0liM=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2059.outbound.protection.outlook.com [104.47.5.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-u8g1gNaSMqaGp6XMRcY3bQ-1; Tue, 30 Nov 2021 04:21:43 +0100
X-MC-Unique: u8g1gNaSMqaGp6XMRcY3bQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYkueWML+0Ua2TZioBdEcpW4LsGILkbjMEXoBKNC7MmjI6X8su3JEuDsxFwImeFg8A1UpiuLYpqctUmtUZUoCPIocm6IkBuSEZ5XRiVmXRugNIp4uL9VsI9KN3T8RJSBLKbLzIAemTIdT1fVm2KOOpJG+wV+2KkfgBso0f79NhkMw1dICBPitThyq7scC87LPiInlFP+dciA7LssHp0o7dHlSQZGP0yaHWU5OSCNICrexg9cZRBK/1jViiYnWPU2y8s5pxJD67KtPzJnKyItuBk4FeaTsgwge3NTSiihP0JL6d5/hFy/MKSj5AZ97JIN7FFFGQNXPhE2HZOBsNuiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lj6rH17DvwxDG8oiwIJy2ZUNfIUz8KL9bEX/R4Pr8wk=;
 b=MLyzcc9zgxvTSz1QDwv7T4SxFQlrSTzpOxF2wBlKmgZ6Z3aqk/raETSTM66CHQ9g7u3SAr6HVO6o+WA5mtNTf87DsDfw5JX+dkwtEccel4RJOa2XF8NcYtMwOsGLblGFhKX9GX8hVZLby5aWGf3sIjjfqgdSTh9/oklHkQsCAHVWgYUJe5/aUUQ+aJ0w11q+2Yh4NKKiqspavpsb75m17Ueb2PiycJX0hZZADgTMmPJ11pHO+cwoaJy5A7ZDKHkJsuIyL/Lztkqn8ULlQ1Tw18p0f4E8OkQVvQ88iiK6Pdz2ML2ScPOMpq4uboE4iUucPhOX7rPCHfTB7RtK96n5xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3180.eurprd04.prod.outlook.com (2603:10a6:7:22::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 03:21:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 03:21:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/2] mptcp: print out reset infos of MP_RST
Date: Tue, 30 Nov 2021 11:21:08 +0800
Message-ID: <70e7b7affd40c503a26ba6415848bd6943e74cc7.1638242181.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1638242181.git.geliang.tang@suse.com>
References: <cover.1638242181.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0037.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::6)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by SG2P153CA0037.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::6) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 30 Nov 2021 03:21:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bbf6e37-0ba2-4048-055c-08d9b3b08791
X-MS-TrafficTypeDiagnostic: HE1PR04MB3180:
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB31800646ADACA0600F27B01CF8679@HE1PR04MB3180.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	inegqRKNw/ftKwks2TwjDUq7aLq5n+wbTAFDnno7hhxA/l2JylZTHePLnLUaMAkQeKGQ+jIp58KXNULkByW7AFdn3gmRca0Pr3Xp8i/m2+aHLI7H8Rmfg1tErhXnj7Y+/jBO2Vc9zzdjHx+pGvqXI1cLxnUOEShssanInY27QquqX9FURaD/fk55r1RSOF35KVSmct8kFpJz31XaQBzTTjBVO9Om4muWRX0WCWMAo3I9AUhC+nKLboMP3Xk4jOq6VkWTmVrMVVtfLYPSTNa0iQm4HT8DEI4prHEjUfzfiPY5vf/tx6ExsMDKUa75kduE9IxpcYXEmbanGBO3mJwtvmXXeXpGAgkQYFu4Vhb8DLpN0vdKlDsxhNo+bYMpTbyNj2Ip0Sgu71jytfD/sAXuPjuH4xW1GMPncsCa4DRcVEvUpKVSS/B2eD2rVcqAlIGOe0ihjjzg3ENmvE7CkZSOsqRIYUMIPgRaf8c0TK/F+ZkFAyw7/s1Sc5AbUGYtmVBUq1+sDUgRN1wlHPZLBom+qs/KZJLcWuaj/yK9j4mT9HTSWrAIwT6XJjIYPWnF+U+oU7r1nqRKyR5gvoZBrG6aYIoqTq3fWu7v5JB9wACldGjVtoxa4HZOueVCgpjgpcg6AhMoBbMcyXVJl9TQTmiROw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(66476007)(55236004)(66556008)(86362001)(26005)(8676002)(38100700002)(8936002)(508600001)(66946007)(4326008)(6916009)(107886003)(2906002)(5660300002)(316002)(4744005)(6486002)(36756003)(956004)(186003)(6496006)(2616005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rOOjk/HaM44Gzr0livd0zMPVXxjp0c+eCAu8b8dXNTO+uXKoaBt/P/ZgPYZh?=
 =?us-ascii?Q?BkIQFhlcBVXDU1TQY2DKSIWjsdLBqGatrUAsX/UQZSpPoHy2Z50vwgz85j6O?=
 =?us-ascii?Q?6sn/7no2W2u/NazFC2CJCHZ3lP+X/KmRVMhkM0BhRjd3GsTrjQ5A8pLGXehT?=
 =?us-ascii?Q?vR65NgWklF+zbJTpJZfpwy8zWPl1UcFyrwS8VRjtmc4zlw2GqTOjiSc6Mf02?=
 =?us-ascii?Q?Tch1gisqdYH5QVdOQWOS/LEzIC56pXvmpeDKl4htsfb0HmyLERkQ1wwzXuQv?=
 =?us-ascii?Q?QK5uwkgAuTUSUDc12aPqnW5hMs6sbiB2+oC0dnORQDZ1FFXhahTlX/Gn2rkn?=
 =?us-ascii?Q?YVK30wQF0mei+aVmLJdFLD54ihHykiM/s1ryN3+CpjSf93q9gextbo2tay6p?=
 =?us-ascii?Q?HGvoDn2JoTHBmSYRhh6nuJHIhEm3snnZZy7UathgUjKk+ArSAm3bwfivwgms?=
 =?us-ascii?Q?09zp1Y+di70VRZomqm7CpDCsvi31crinHeZdMTwtVY6tyeDrV72pwWnWp6MX?=
 =?us-ascii?Q?me2B1RRuJcxWUiuuqWGi+KP2WLnGSwZhywL8Hx8pYBR3YOZ9tGUia9HxMgEM?=
 =?us-ascii?Q?s5JYpWEYoPPoMl2Jg16GYwNoQJZXU7sBLiyAj6TnqSVWEPqklbTg6s6xGFGT?=
 =?us-ascii?Q?nwLSdJJj5yY3qn6vbPIAnRo1eq3i1NctZKettk7eokAeMlF1I8rOiCy1EGpj?=
 =?us-ascii?Q?J5LdrVBlNz7DDVQ2TWf3wZPvZk/gfA/gqJIsFg7ZGEfIlpHUcCs8dQiyIelJ?=
 =?us-ascii?Q?f3rY2a8HAO1SslHRNd+q01HxSepWFGZlWiM1kDoEGe0ZVAiobMmr53nb50H1?=
 =?us-ascii?Q?VvwoIeDAG6Sr/qsg2NCGlACGRI+k+XPfpJQuV97zTE6XNVj8XaBd57SGTptW?=
 =?us-ascii?Q?sfwp0QX2nvRAqVCs7QzQnbXJB65HZ0oFLwlrzxF9/HWMSbc+8vrfEY1F+kMH?=
 =?us-ascii?Q?5H0t9e0/A/WLp2MLz5IeJKu2M3qxZp6fKrIjS9uNlIVqLlvKD/x8RbqYrahV?=
 =?us-ascii?Q?WOBekJdO87LoQdhNofL9JMF0JNni2XvUUvxgWfxAYKFh8YK9sDS29AijPd8B?=
 =?us-ascii?Q?S/xxlCNmBZJjolfx7/iViaINMU+MfAzNbfezxYNlaAyc3hsH8gFSHZhAKOgc?=
 =?us-ascii?Q?uRuBf1Ka4sOgTy+PCB1t068FIS2VcRXr9DKOckFkeC4RFH3ynIbalWU1q1jm?=
 =?us-ascii?Q?soW167le9pTGt72pqnv+aEhnIddSabenOVxduKJnUOoQIaCX7sStfLt1N7p8?=
 =?us-ascii?Q?N5hPf/yWZXh6++P1fu2RdiPIvtJCaphff9s7Kdl13Ylh2Y6F3YuoNVlXjIK5?=
 =?us-ascii?Q?kkaoJOXublyeivQAKe5M78lJCF1TgoAtoXJSxRtx06f4VOFHPq38UxHuRV6Z?=
 =?us-ascii?Q?++uRG3oJl8CUrfPUo5dArkgoY/0zQhMpLdGQYEMA+mUIvtqnUIrA+ow2MQ0o?=
 =?us-ascii?Q?1yi25rivMbMIfKoRJddIUL/86DND9UHmQPq608rkTqsmqCAYpcN+VpQxDPZC?=
 =?us-ascii?Q?M+SB1r2yT6qBMov/5s83Th/3iRVmB/dPhC9TcMuNeRexAuoFKedtmHkJK9SR?=
 =?us-ascii?Q?Y3yJSueOg5CLVujJYmy9jhExmAW5fDgq06zhjZEDFMNrG/KplBa3XgmSkOAU?=
 =?us-ascii?Q?YxS+zU6IlAhlorFwogQfmzg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbf6e37-0ba2-4048-055c-08d9b3b08791
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 03:21:42.0829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31/MegGefeUwt3KLP5DP7wQRdCIFW7X4b46jHr77gANICLLOJJXteGuF99Lgyy2oOnWw0eSEKw+F7C4KszzJyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3180

This patch printed out the reset infos, reset_transient and reset_reason,
of MP_RST in mptcp_parse_option() to show that MP_RST is received.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 35425fb4b179..f38220f30d7a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -336,6 +336,8 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 		flags =3D *ptr++;
 		mp_opt->reset_transient =3D flags & MPTCP_RST_TRANSIENT;
 		mp_opt->reset_reason =3D *ptr;
+		pr_debug("MP_RST: transient=3D%u reason=3D%u",
+			 mp_opt->reset_transient, mp_opt->reset_reason);
 		break;
=20
 	case MPTCPOPT_MP_FAIL:
--=20
2.31.1

