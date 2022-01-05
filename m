Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5068A168
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 09:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641373829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B3ao1T5SmJYd9XJ4BWPEo1Eg796IucEygFG2ZrzjCAs=;
	b=FEIM0yzreb5Q86EWNEswxTalXW5EafXH5L7yjJQK2XG/0BbrLtmMpFFIdneeRwXd4keG4t
	OZAr0z9RaX9XgTL10pq42xIwHeKralBEAX1AkjursqoRdZd0Zwx/8DdkDQuGxmXhUaSRSB
	F40BemFHgtVYBzZ6kwPOmF6Bp7fXzhk=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-kFWkPXdNPvKyQl4oY5JnAA-1; Wed, 05 Jan 2022 10:10:28 +0100
X-MC-Unique: kFWkPXdNPvKyQl4oY5JnAA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwjR+QZshm/qErnAabVdsqb0KFeRprumSeDy/pTkVpnSu+mSO/fjnsc1voQ47+uR65hv1cRU/Gwova+/Xfk/8kYWu/QbwgCwrn2yhGeVX0YrVx6nksk3UhBLESX+FqwmdKk9e/xk+1EFe+2QH4cnkhUFeVJA1hIxJpVq6GzQJFH+wfCpGsfmt1HwL1vM6WJY3AP6sPqVWHeXl87Z894yQI70MVzciGpqPKxlxFddiWsmxFBmeBE5e1pmXYXy7oI7UWVGd6ZPCpyd4YYdkfDlrgReRYMnFnd392aPR6kM2OJzg8qGRqls3hpYr5FzDbvANn1oQe/iXD5mSpPSddZSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxVTCRuYCPHUp/JJ7HGzr+/n/i3Oe89b8DU6htC/YQc=;
 b=QK9UnT1aNHfbP+X+cIuFZAN07cSyFnqdl+tGigS5f0ZSRC0UoZeNgi0LyMftkCW/Uq4xo3bgSN6j5reJkspb9d58m8KAy4xXa0eqHYg5oQ/mtghiWp5l2tf708qXt7JF6i+qwo0TcZ81zzh5dxsIQNFVImFI+w6CZyuiCzcN0CQIPbM9/egFoKT4uvnVR99BP9pxLMFe05FcZRWkQwjkGaYpXA6YcUd6TOohHNu0d1o+nS41IoQ1ptpEyqZ8MJCAx5vQjCwY4jtDlj0QQe9pLAmNkjfrYG81lpKSKo6kv2YZXocG4un2mV48ZpFwMhhIj9VgVHrqB3MEJGY4rH6/RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3066.eurprd04.prod.outlook.com (2603:10a6:7:20::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 09:10:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 09:10:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] mptcp: fix a DSS option writting error
Date: Wed,  5 Jan 2022 17:10:16 +0800
Message-ID: <202f88648cac54c062f5964526f55a2bd561cebf.1641373778.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0101.apcprd03.prod.outlook.com
 (2603:1096:203:b0::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e67290b-6735-4a80-fadb-08d9d02b3702
X-MS-TrafficTypeDiagnostic: HE1PR04MB3066:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB30664EC9159A5DCF6AB16C3AF84B9@HE1PR04MB3066.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zEgvT7vJ4fRDx87IFNwP4GGLRaZnmQOG1ELjXAb/8NeyZJmTF/3UyypA3WifetjsPStvtI+e/g0so8SSG7EHKBYiko0CNAsv9yhsSKgnoJIJyzbjizLbIvWorP+jjdgmvTqJ1l7TwS5Axtk2fM/kAB/SBzFEsZhB6tFQWThaart7C+p5KKKSLPdE2csV4NPfjCqCZ/uD7Rp/9wdFwL3yKGDqsjfE/7PT5XXPu6NXvNY1HwYqdd1tHanwUacwMSWBUwB16ViKTwIaiPtYH7sYBzEgq6jz+YbKyFJl3NLS00klKkYq0yyNr+vSh+2Q/zzCGP7M743lJUcQFfxcpTWtA8yhcE7F+yYj5lyORJugjD9JmiE0C8P2J7CFDjPhtG25b0+pbsgrTNwjo3pJSPOzkeqOa6JCR1bWpsGRqP7Jw4Shan+JU/e8ripNidbPO8AsTKmu5we2sVUq35z9c6/Xd1Tk3+lFHHW9NAhd6bXTJ5TmnhAszRoZidhid25geNSBepsyU+JgkOqGeA0AJ8R6gaZbp1gnnMsBSFHNwcj9od/nc+t/yHdT4yT9JYgubP55IrOdq5gcS9ijpSaFnuLawuwhLHIEj54IdyQiLj2QYgvX6RRCWu+gTrR3FL4dYrdgK3uZIYqeRllxHTK6dfrCHg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(107886003)(86362001)(2616005)(66946007)(36756003)(508600001)(55236004)(6666004)(8936002)(6486002)(4326008)(44832011)(316002)(6512007)(4744005)(5660300002)(66476007)(66556008)(8676002)(6506007)(6916009)(38100700002)(2906002)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sLl5Wk5rvocanDISa4J9lxyAXee4rPsH2KMuPJFMStiZj9R10Ua+HI/qJSdp?=
 =?us-ascii?Q?g+p1OeXvr8MlJtUX+q/Ra99sVczR4QmctW8fvGhGGiKb3F/6If2xJEmC4RcQ?=
 =?us-ascii?Q?AhcseJTyhAxZpIfwL57DMXZ2n1wYJ1NGHECALMuW+ft/YJIrLdCGoN1mvsPy?=
 =?us-ascii?Q?D0JlNcGo6uY6Y3e9OVu5vhKkr5CxIDJ1UwrYu0oaxzhmZu5ggKDorMsHKryK?=
 =?us-ascii?Q?vE4QnOFM59i15VPDZ4mHafSTd0cxnPQVWogWcXFk0meCYONyv3t2fQQEr9rl?=
 =?us-ascii?Q?xmMlMkaI3zl/wuV6tn9kt/eV7tZ84WSimUu8/OgyNnE0QW2OATVUEJcZa19S?=
 =?us-ascii?Q?x+Hu03XWdqzAWcxpH20JCM4L6p5er8QKJv94vXKa0dKVnQeA+ml5I57qIOAj?=
 =?us-ascii?Q?9z1cCD53+g5h9QHBv2Vj15Hpgy5XcQwlZDGFijHhR8S4cn8EpNY5CdYGbl15?=
 =?us-ascii?Q?K7vi+uskSrhc2uuODj7WAHiPGatpgFpD5PC91JOU+LK6/JViECTzEDj03/Zk?=
 =?us-ascii?Q?fO82JADJw07Ct++UuWuTFaJcpWbLdIEsSX7ZGB2h4P3oxEiarhiwrTntY33x?=
 =?us-ascii?Q?jysirTRSwmNYa5O71C8HF5QW26rnk1x0Sb8SWRd37tMvwkkYVIIV8FYr53YN?=
 =?us-ascii?Q?1Tnh6sbrI1s9LHZKMacPwLPtPAn2rrM5VoTHAP4gB1OKhPBv5/Ny2+Yu7RJk?=
 =?us-ascii?Q?31WI45suuloICMPhjHPHL/KWgf8SSn1IdzQCM2Zt6ZAOwUZMUw9c6c4JHPBo?=
 =?us-ascii?Q?9c1R6/nEBz8gyrUGEOMBg6JmRNIpOLA4yf8idP7lIxPb+Bh8oUbYpSfIIr1v?=
 =?us-ascii?Q?UYFdyQwn25FU1OhOjcKMRldWIUHn0VZd4NOYVSENtNzlqpuJAk8Osjwxv4aT?=
 =?us-ascii?Q?AFNnL5ArhAWUfz4uJATEfX9io5CXaMOfp2aVTFPuZ7LLDhMkK7aCi/81ytrd?=
 =?us-ascii?Q?jn2S6PY67xoZJ5pl1BqAk0hOqA0zOTHxZX9mR3Az+ogVMYD4h3umTFm8O81G?=
 =?us-ascii?Q?JKY6VtbIKuHZP/aWCD6yrlmSSe8vXpmg5Df/pOMi2g9HrWJ0GAqFtwOljMDR?=
 =?us-ascii?Q?FoXZyeSlHmx4Ah1ZaYAi3t4wjJWdmNkjnIqwER5AoeS87lxdRVPx/Tr2Uiej?=
 =?us-ascii?Q?IcxvSHzFgFlmo6ceBpPawKjOp7eO7ufn4qys45tHtK/0Yt1M0F2uf/fd8FqY?=
 =?us-ascii?Q?SKAG9D8n5U/R3HXOD2lnpCU3KCuwHnJwhQB8sscPF/I620BlTyWKZAqrMsWS?=
 =?us-ascii?Q?CGtfmiRw59QoSP62rf8Ou9zuuVangvTbUjsGVuxiWmk4ncQm73NUH3lFZlQq?=
 =?us-ascii?Q?hV6TNnIamhGr9ijOSS4xEh7RL6tVNVCWkA4P/Frl/SZKciLgiMwl9AjBZU4h?=
 =?us-ascii?Q?ublBLzuG375sDgNnIfD9WGYEmbqJ34UVepAxUVycFAMs8/MpMa06LZtIWSiE?=
 =?us-ascii?Q?18ir5NddP5Hv4aJNSqHljS9wGb4PXWIqCwRd2q/2Effrk/XaRAzzIdfOYQM6?=
 =?us-ascii?Q?XKBN6jK6zEY8mQoi2VaweC6kSuMSQXrvPeym7l2uUj9V/1ZUSWlUJp48agwa?=
 =?us-ascii?Q?0zlOEXt9IJnlI+tPZ1mW+HQPP5gw808VvNNn3UUCTzB1s74F8rrKBb8n4ATj?=
 =?us-ascii?Q?emeTf8MLjTCqmrIrhrVLCO4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e67290b-6735-4a80-fadb-08d9d02b3702
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 09:10:27.5999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhQx15YUMmheRhSJ8oiCVVMZkDwXySePWs3fB+RpfEZXyiuZmjoFMBh6Q3GUp/pP3+RFGO9gxSDSe1REeZ1Dcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3066

'ptr +=3D 1;' was omitted in the orignal code since DSS is the last option.
But now DSS is not the last one, we need to add it.

Fixes: 1bff1e43a30e ("mptcp: optimize out option generation")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c6726e8389ec..fd6c19b809f8 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1327,6 +1327,7 @@ void mptcp_write_options(__be32 *ptr, const struct tc=
p_sock *tp,
 				put_unaligned_be32(mpext->data_len << 16 |
 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
 			}
+			ptr +=3D 1;
 		}
 	} else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
 		u8 len, flag =3D MPTCP_CAP_HMAC_SHA256;
--=20
2.31.1

