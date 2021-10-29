Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAD072
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 04:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1635482473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSJH5Mca7FU8D/ECu9ZsxQ7V8K/yx2u/5UXvWDUNi6k=;
	b=QYS728qX99U7xD6ydJ9YeLir8jrm7E5gjonVjAQxVfNdDze7JfbJj9uGyJmbCthaa7pC3o
	v3Zc0qni8JTcHNZHSUoL4e2j4fBrBcJoGZTdNDfUXBx/RpMz/uIL8nAA9L1+yPZW6atGi7
	d6JDHcL0TT92y5Goyq8RI8En3erbR5Q=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-36-oHizatGPPtK6N27KtboABA-2; Fri, 29 Oct 2021 06:41:12 +0200
X-MC-Unique: oHizatGPPtK6N27KtboABA-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i23SBNOTlLP426nUpomxadxssaGufakcFMf3s5dUkJzRBZE+R6hOF0nC4Eu1NeCdMce7EVxzud4kIEXxLqNpyqvlz5AL92YkTMfWZjFOBzokqexo00COkmAO4/VWeYgC1hOp9TVCHKpL3JRY4VfSYE9I0wI5fTOR1QopHL4YrX2ZylZu0nPmaXmaPeoisrAO8NhT2GraWAlGHuay8VuR/wND/PBNfXfBcDwf9eV9uSh/MM8HffKdQotdGJWVex7FFhlx09+2R8EHseu1xl+7D4rpuRg04SlnosESPZzopY0jZuydzOOfMUqJRFtDC4Ohy8/6IXQRHM2eAW8mbbcY/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AxlS3wJ1YSxVHCfMwUhVqXVweg3QG9xp4I13mYPjgk=;
 b=OQsC56vhl1rWR3IaJrCiu+tlqpb5rghoN9N8xeHxVolX1igV0QVT212gDdxE83iXSDUDSIs7vBbEMCGCY6/NQ0uhQ4ZiuoMu7sUDxttwX0HQwJX9nY+MskW3EEJ0IPMNBcK/4zC2dcphlpXI/mtHSI6qTDxzIKeoIhDUjk/SEZBrnxEib9IgPMoCEh8cYtJU3kND5AFqePgzA7NKrwuy1BGYXx0CJHMPRe+Sf/qbiDazCSDS1LQZYYcAKjOfokdwRzDvdz6rwxyHGDrv+vXEfypeK2+v7oLWAVdk9YkNk2CY/tsFmv+l/CGFtROlFo/SogW/z28AkzPvdNR9km8ZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2652.eurprd04.prod.outlook.com (2603:10a6:3:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Fri, 29 Oct
 2021 04:41:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 04:41:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v8 5/8] mptcp: infinite mapping receiving
Date: Fri, 29 Oct 2021 12:40:15 +0800
Message-ID: <22e015ac1fda01b24220e7d61986ea6e999a5182.1635481641.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1635481641.git.geliang.tang@suse.com>
References: <cover.1635481641.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:202:2e::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR06CA0011.apcprd06.prod.outlook.com (2603:1096:202:2e::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 04:41:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 939bb5b8-e7e8-41c3-010f-08d99a965505
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2652:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2652FFBA993DA26B6CDDC4FCF8879@HE1PR0401MB2652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xAy61V/7zjs0i9xfZQnnr+IGV3ZTAPSy0gfRh17OIv0J7/xOOB9O5u++5Sr0frD/pxvf5W1EuL/UqWPMQohPbDHkqdRgJdhsA5m7qzYBdyIuhseSJJGpV35JtBbr0AJP3RkDcDrS3cgSrLzCUVmsuFxPMoWWU5megRwxJ0Q4iaZLnvzmRG5SxRlYiJCN7NoUuP1yd9OssY5vUtol1eIBxlTSg7gUHIS/dvzuPjiivzfOzD3+ig8hvWckaoEbu60sodynRtRhnVMYx4mbtfQuoBt4xL1Iap6yXj9IrZnphEisaT6NjeZjtQMX+lQehBvWXZxTHslxr0QEc2/OW7dUg4zoMZGKTMsOJ8GsEvUi1lA6BjTndBizN9lylsqExAiHItiXRbbt4S1h6HH26seUv5Mj/wi21r2Cg9Rkkpq2mh3wQa6uClZYQ3U6ldcCVfFsitAChk0GztYxEiTu5pjDUwDi6Z3x9HopXmXZFHj5ubGgH+f9JlYGD3fGYVsb+SVbdgqqi9bo0LzQDzFnFG45nGRa5imFDve6xN1kqoQ7uk6GHnQX0p4j38SBOBLCIvZJoXoIClRGVBHQ0rXFGeahVmxNFme7FjtcGcRTvh3WmgBuPUQxYFlNT5w4gJf92QWUgIEx/FnERB0WBOjk2mpzUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(508600001)(4326008)(66946007)(316002)(6496006)(83380400001)(55236004)(8676002)(66556008)(6916009)(2906002)(44832011)(66476007)(86362001)(956004)(6486002)(8936002)(2616005)(26005)(36756003)(5660300002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XbUNRWdUlMtoDcnX41Yb7aXTeY/rX0xfQDTnKFZ6YI6R5NBC74eomhY997EX?=
 =?us-ascii?Q?ewLG4aFWfAy4y4prWI0eqvCo2xQaYTppBTl+FLhARGC4BgVt3j3hHPVMVzzK?=
 =?us-ascii?Q?0DxPn7CzSL5jqykexxOO3sav3d0HBjzUjfee2cPkPMjGeFatE4o3TlEbWM36?=
 =?us-ascii?Q?+jOOewJM8TZ0FXVbowMTV6ILEJr9wRIGz2vFiCX4Fv80d16l8scBHY99jD3m?=
 =?us-ascii?Q?XyEHl9jM2+w79a3fZBz/V6GQo0D2oMMPFcUNs4DF7U5l+3dRt3j686HG9SaN?=
 =?us-ascii?Q?JnnO7BIna/Fj7JW2NVGSp/WeWvXuT9c6pW8JUV0cfWVBRZ71843Dmv33SIrc?=
 =?us-ascii?Q?ayK8frPBZDGHrPSLdm99FI9YNBrlbN8ozUcrq4fHVBc1v1qNIeG2tKCKOtrk?=
 =?us-ascii?Q?avAg1emEERupaXLqJd5gTNuV0hUHQZDxlRP2NeOYCvTR6QTVoNaIPqCqX+W3?=
 =?us-ascii?Q?7oUQUcxqWhuZ0GaHxzRr3ehZJbORHFQROLo9w8UjKj6+KCIFXukTn+y+BgeN?=
 =?us-ascii?Q?WWWQ9QgwyxJYy2jZBoGuiWU4xeO25ImGxrqfAXTJu/mGw3N7xrJn8BAKGAJc?=
 =?us-ascii?Q?D/1q9WGmSn2iMR/kmPFQ3+OrmzWDjb8ZYFnZBzN8t+xezHzPQ2TsG/S89yvC?=
 =?us-ascii?Q?QF3iorlGjRDj0iJP/zhILdvnWB5vzmT5dtLspX8IjpJ9Ns1Vih+ygx/hmxM5?=
 =?us-ascii?Q?WwFZQ5iIxmm5xZRA6tNiJHRIE6eu0Ib5hEq3pvV+uqksGRWBMIPpIXC0qrc1?=
 =?us-ascii?Q?Tkq4mzJWMDGZVR97im50AyHmUZ9CHofsOPVKLRz5Lpbe4Ko5tWRSdOv63TNv?=
 =?us-ascii?Q?uccZuP3nUS2DAipg2orbZPRSvgcYAUPARpsPYXK3f6WmyvwEZaey8zqWd5Qu?=
 =?us-ascii?Q?asksOpQtYz5iYnLY1VWA1EzkmgWpxQrjh4yYzLXtnovGDAhSN+zRpSIVqm6L?=
 =?us-ascii?Q?0sRIAdtlWvnRnrPMMGAouWHaHEL8i39os1EDLXHI6sFMhmzHrWzShObUSAGS?=
 =?us-ascii?Q?hT5uBp0/+lNScLro5bF5LgJkLhK3U4dPBVqb3frTlTzHroyh3bDlhOvAV6b3?=
 =?us-ascii?Q?JoWKqt/u2+k0GfJZ/ha23ABF1bDAZVaOnQVrU1L5EfgV19BfkU+5jx+bJ3VR?=
 =?us-ascii?Q?LkBp5yEJt41D1dHxNU3WXAtg9gSPvDXvyF31e3hJ59n3FpaFzx0pAAuAetWG?=
 =?us-ascii?Q?THruydlqvfPBqvy+9zObRKajfKxcJcU536WPdixQZd+3SDCDmyT5Gw03jlJM?=
 =?us-ascii?Q?1X/PWGo+5dKbb19C7TrHbGdphGikHQ7n+fLIxSVtzfFB7+GLrImHbb2sPuph?=
 =?us-ascii?Q?vXKFr5c0MsFJOF3Ytc5Dke25l7urQXr7/Zb6YH0yfSzo9kUkIXpj/pU8pyz1?=
 =?us-ascii?Q?pyvpqu/+K+csWyFkAjz7swYypj6rUdThpYr5pv19T/ziu3rl5FRc89F3EBMg?=
 =?us-ascii?Q?E8vkDnWXIDJ4TFSCB3CfPOUcl/fAN63jp6QylExG5n0UwN/1BK6/fwUutyhf?=
 =?us-ascii?Q?qttBZP1a7bqFcJE1z2sa1huiV/x2V2/7soRI9YPMWxdBYWYuesL0e1/uTJ54?=
 =?us-ascii?Q?Wl2ISXn+8M7X7jG/D0uB3sTSLgvF/fDnWlv9R349ctqm56jCXkjpvUl0aAyB?=
 =?us-ascii?Q?d3/HAX+hVtMUlqUt0dV91uE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939bb5b8-e7e8-41c3-010f-08d99a965505
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 04:41:11.2802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojKP0Jbp5nAtI+r9Nc5eolxgOrKQlAgSEYRyh9ufaDvRnpDZoop6PVn+7QpVc8Nzr4qaPY4WlNHVrHIiMXj52A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2652

This patch added the infinite mapping receiving logic. When the infinite
mapping is received, set the map_data_len of the subflow to 0.

In subflow_check_data_avail(), only reset the subflow when the map_data_len
of the subflow is non-zero.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 93bc298bd41d..9e54122f18f4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -968,6 +968,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
 	data_len =3D mpext->data_len;
 	if (data_len =3D=3D 0) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
+		subflow->map_data_len =3D 0;
 		return MAPPING_INVALID;
 	}
=20
@@ -1181,7 +1182,7 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 			return true;
 		}
=20
-		if (subflow->mp_join || subflow->fully_established) {
+		if ((subflow->mp_join || subflow->fully_established) && subflow->map_dat=
a_len) {
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
--=20
2.26.2

