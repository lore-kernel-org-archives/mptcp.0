Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE456FD2
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 11:56:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbNhpoEJwORIfHpl+lxgwmmSc2pbdmFiWdHWGFOPhn+thdj/5EP40WXl+1bNBNmSbi9J3lt8Fyj0s9GXFQS2ofm1O5oH5zcJ+mYlGFaCGP0ZcvAMGBpxmVgXqA1Q3MY5NOYUOyaPiKkbFgVZeiI3yzvpECpGK7yj0Cqz6q9tkPHysQetwuBDbR74QGPnNkOUUopVdfBzAUfL94PnTQc2WP6GSwNxjCI50Cl8/fSH3WoHW5VmFpgROARjylFJDPpdIepxw1+019HJION6IDNH9hTsLBIUht6aLIf5ee6kLaEiGluB3iHutEyAZzIz9uhI0BU6WBbRrGnLlvnVqVV0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fo+P5vuHpd5Lz1cBD/vS+ZPFVx5WtqJPo1DuzvttYkk=;
 b=NQK+2mgNKJtMTRwyZMKBrsWq3Nr3R1DwmhwiwDNrj4ZpGaDioo1kJ3B5df5Z5k8LAYKP3PfhuczrFAgsSMMGvu5JyoBCn7MfAlJ4T76YvhxKhG+FeMhEcAUIZNt3kooce7PLZi77ZOcc9fcZwbdVxNp/MuVHzOKngJ3e+bJAfXMO7ZEManKHRYi7FmrSFGRrc0JylJKUSta6u16IeH0PmoRcafYsToForygyt4t09O0ysEYHG5/4glhYgD02rI/VYStn8fX8yPKvZvn9ZvBePrlfrZxRT76NJHVDSGn9NuNNV1kvzttAZ0FPH96M+JtM07PAnWJsUwZ/AamXOSTaNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fo+P5vuHpd5Lz1cBD/vS+ZPFVx5WtqJPo1DuzvttYkk=;
 b=XyTQAC4l2J3PAHV8NSHY567yr8byaLw599xH1pUhLvBDPcy9AoXefvLYsJzujnpRN22qegs7FEEjn97l5dT08TV91anDFDSedRfvcihNe63rI1BLdYDh5Rmkp3F58Gxdiwi2vUykh5941Izi6KEx4apSECawZAEfRIeYvajeyGC+J39cbZnX5Heu/36EWs9Tse92K4p/9tyqv1xDBsdAyAb9Q5STxpWDl2lSLVSi/MMDXh0suF/Nfekao5mQoBqdA2MBIthJxux484EO7Zn84wg1WzaNlXT1KMVxWNyBc0V6LgTfK7uLyRZMHfcP+xFNCKPUVbmp594qHJE/ia5tBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8023.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 11:56:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 11:56:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 6/6] Squash to "selftests/bpf: Add bpf_burst scheduler"
Date: Wed,  2 Aug 2023 19:55:32 +0800
Message-Id: <7cc369ef8c192ca7ef18b8d31a4673ea1b13261c.1690976940.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1690976940.git.geliang.tang@suse.com>
References: <cover.1690976940.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f4e6c4-b5f3-4536-b053-08db934f80eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q/F5hEDsBfjSFF3QFjpxCV8dXC1Q8l1Cjq0crszXepojxpD7X55qXvwRnNzGLa7rvnepUh6FHLM0OHrUWJkhB58Lh8Bf/3p1ietYgsxYGQBzrAnOzyePDB8KtNS+jlFwKyapX54O5xSgCgZZyS4fmyqUB81oHCUGXR2hk6gQqJ3gNmlYHRuoCyaBPgo00xsjpgseuReZdfzxRcNZXLUzMBfSNZ4E1pGico5Ii6oTM8l1wnXUTiVawLB0t7Z22eqT2RGncaimshaGjYlLJcAy+fnJqXR1HBJhS7HzSGhttE7kKOThhPeffMJNgcBC9tCZ3erPzI2cio80K7ZjmdOhQqArlRnEg9AbVVCvsa1uCaYZg7gXf+eK5YIanO6mDrieUE0jtSK/2DcH1BKxD2hDTtbNeAppvhzpTcKeYdGtXF0sywMuL1jQgJOaqO/oYHUOIllTaaaHO6NTagNJZ/2jgE2jHL7i4V4g+QozcJ2f3+JJHVd2bI/cAnVO9f3qfxdQHmX67EoIHY4Lz33bJUn4pGSXKMzBbA8TAQnTd1V+SUiICYYb1VVHdl8Wu9KiUmeNoSVfWVfp2kkS6qZjuObFxDieNK0ap4wxENR63+R1lTU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(5660300002)(26005)(41300700001)(107886003)(2906002)(83380400001)(44832011)(4744005)(36756003)(2616005)(478600001)(38100700002)(316002)(86362001)(6506007)(6486002)(66946007)(66556008)(66476007)(6666004)(4326008)(6916009)(186003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+D1/eTH2cArGFkmVyjcOOeQ8FN5MPOpkybGRlvMXYqXr0tgS16QfYGeCGdRQ?=
 =?us-ascii?Q?4MzBsEbFJbCiLZ/9gUOnIC2DxEh/FVYHEaZpTlRxRO7Ly0xzjlxKN4r3qD92?=
 =?us-ascii?Q?pVhlVJoxQpAlj2MeUH0e51EKh/7/Hiu9/evYUArIyfAgTBRRmpQZiOHg/CU4?=
 =?us-ascii?Q?IbUtkcc5YPOZr9b27nOgYdWrip8acH5StEPEQcAN/f7e74xECotGHZthT6kc?=
 =?us-ascii?Q?gJ17J7wcqv1FXp1yRj3zPomUvu2qnQP5at2vHm8AiZ9dQODE9SMY0jS4FRLx?=
 =?us-ascii?Q?13JItJpXJvxzVOv0xDsU2PV/8QLG50k2H42Z0/cTlWwIiQG2vvFoNTrFPsEd?=
 =?us-ascii?Q?XDHymZC/Smday+R5ndkdRh95kpcsKGaryzb5rP0n5PICQav/3gJVhUcWNo09?=
 =?us-ascii?Q?GHFfuzWOUHtUmz5StI1jA3/AnFE8MaBMHIrF6w8lBCjnSF+Tza0EoTKBMJu0?=
 =?us-ascii?Q?NYuRp9B5f3gvd2c3W2PIfFQ5+Gz2mAi0PAGXN4ywp2OGq3qPnwlMIEb0x0h5?=
 =?us-ascii?Q?VWBflTPkmNN8d9vJ2ZyJNY8IpoKAwWpQKZK/NT9ee4WwCZIzV29I/Xo1FLpp?=
 =?us-ascii?Q?hhfZkR7ScXmpw0Nb6quAh3THPgjtyOvbZDZFOtqd+UIRewrknppG9+WB7j0q?=
 =?us-ascii?Q?T22WbCeEhrYCdSYAAFAWr+ulYFqDnxtqMtk8vAk/78pP8ytrW17gFVbc3gMi?=
 =?us-ascii?Q?sQGYBaO/pQyjcBVM06nkm2TPBApqFbJu/U/dMeldnyZ0eXUNV8OSJbBDKe7l?=
 =?us-ascii?Q?p/EmRs0s4MISUXnmU3lwGp/v90n63mDQUp4nAEdAJQjVqwvxvqbH8YK+9PEK?=
 =?us-ascii?Q?XVfFw8H7278yXHWMMFnShEhK0i+ISEVXoU6seDpS38TtzxtrcAbiaRFvJP2S?=
 =?us-ascii?Q?iUQRYy/fAoKCKoYfrFucIGCB6DjJ63Es/eu7oyyVRcV3itmKO2u3SoGzy5Co?=
 =?us-ascii?Q?3H/b6A6Fiaw73dt//c4qmucus1RlO/IuXiW4N3VXBpsf0GpFCz6uDvQmiTbH?=
 =?us-ascii?Q?idGa1J4oEnaHQSemKNh4RAKdAUypHsuffolL2UM7I6cSVDHjWPRVeRsfg0kF?=
 =?us-ascii?Q?SCU7w052jHEKraXjjS3K2PGghhovD89ueOkcytUSY85WWG8GLNnG1tKLVCGI?=
 =?us-ascii?Q?m/6JQCv9HGGX17F7kzd4fjxywOLfR6aju/fPCtlX6VkA+NTd9rtTnOhhYpTw?=
 =?us-ascii?Q?qFnduHsiIqdlBvyS7ynw2m4rcgIzgmLYI3HGhdPCBLsme4/yd016NA283Ruc?=
 =?us-ascii?Q?qCUJ2iesrrjMdCi38P8wYdoQfEOZcmU7jp3XgEvMZ9Nieem0mX0Hs6fLPScY?=
 =?us-ascii?Q?y9VwddXS3ohHWYyJQh7M4cPrD4C4+/YZcwDunKDHo4FgVZVuufm3zdCknT3O?=
 =?us-ascii?Q?OncCYpTD7kkGM2y+YYvYixq6aYJCT6Ni+A/Y5V9t0KjMUcKax2UNAwfux7QY?=
 =?us-ascii?Q?qA0b5GbO0rhZQb9MN59BzzgVbPt0Xf6QtqijXvEOSxrq4hp3vPg13IM8VhXw?=
 =?us-ascii?Q?fymwiQjfxNeI2lgPN5bNlYYIxxYc9zsp7yLhX1G2b509ISOfdRqhLUOfl2Fn?=
 =?us-ascii?Q?ZL/nhnMpuYNBvXIe+uOgifkWGpIwAyz+6udRYs5+PZGOcHEg/XH2PUXkIotq?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f4e6c4-b5f3-4536-b053-08db934f80eb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 11:56:27.9027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amBWmfoOA5emORJfiRh1PiiMLdL9WIK0I0rYdWw4JWLi58WP0gfCwyjvCzIBC25DgcYuBU84e4/qGImBkf2g9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8023

Use __always_inline instead of inline.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 7af21d03277d..6703c7e6810a 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -25,7 +25,7 @@ struct subflow_send_info {
 	__u64 linger_time;
 };
 
-static inline __u64 div_u64(__u64 dividend, __u32 divisor)
+static __always_inline __u64 div_u64(__u64 dividend, __u32 divisor)
 {
 	return dividend / divisor;
 }
-- 
2.35.3

