Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB6372
	for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 12:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1634560459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imvXdQgRfu2RFbAGJt7i7MT1Est6nVyT1Pinw6QtTsM=;
	b=frKp0dO0bGsEefIxMDbGo3dJyypggrDPLZfMqM9QLuW9Edqgky4RtpDSn80bqPf0K8VVh9
	+27CDgkY+pstcT0U9ZbuCLJZnIq2N4LrQwY2NbEp+FBGSpaSX9NnlXd4iot93FVL9y/9GQ
	W5wZaumirb5m+xdDEqOIcbIBcikZEFE=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2051.outbound.protection.outlook.com [104.47.1.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-ApHa0v7oPbqaKVI17jvDCQ-1; Mon, 18 Oct 2021 14:34:18 +0200
X-MC-Unique: ApHa0v7oPbqaKVI17jvDCQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+ewb6BEf52MajSiJi8BKlHKjj8fm9x/xwSijGMG45V0CmZxbVVb82De27j/7BNJ8LkN/+DM0Ph0pOSjAWwmCllC4oPey2y89crNOA+0viNxyHrT3rlYmTE8+50P24eCX9UMAiJFKgIy9d4Zuxs18Sk8M2sYJZhnWf/aqNRX8XY/2QH0hzn5iBFug3Nw247MlmtZgKH6o2YVcjhDikG6G0ZgPxbyDTkdtyQLjAEXmcIvMWgotm2hPo6ZxHQ4AQUS8hWdUV1D1lQKHaXBHnbDeIavDI10eaYW/RAjHGf7rN7nSpiVcQYYs+TM/9wxUn7DXF2M5rgAzfrtHA9WGFGNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXlXkNJGO1+FFceiRdC4ucAdYHY8r42TO1WcxNlpKpo=;
 b=Hj+oRxKptPy2XTQIGcKxcKyIANExDVNWR+n8J/AGdwZ9UHV+7esYCWQ0BJjsHAHRmaQFpjV0xziJCBvEQh6B/0feSKzIEFL6ldV9G1Kin99bmzjhA+R8EHCF2MfFi4J1FL9stuI1nWJauFiql5JLs/b1AIQGQqNhSSKy7dhLUAUpOwuimTeT6t8KYZWaF4xEc/cPYOhI3G5YGAGXXXeJvtruCvVJifEXGZ3kUH4z0Xm8JnCokbHRf4xFrnaubyCSRbe+H44bNHH6u1F57mxmn7W2UBbbNaX4QyYcSfneazsgS6CQm7ZY7ab2K67G0ZrtFAiOj0yd+Hc/iXOBSsKz6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3340.eurprd04.prod.outlook.com (2603:10a6:7:81::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 18 Oct
 2021 12:34:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 12:34:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v7 5/8] mptcp: infinite mapping receiving
Date: Mon, 18 Oct 2021 12:33:12 +0800
Message-ID: <2df688ef0e37a820923936f23c86f93f6f1a2d4b.1634531093.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634531093.git.geliang.tang@suse.com>
References: <cover.1634531093.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0006.apcprd03.prod.outlook.com
 (2603:1096:203:c8::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (2408:8207:2546:b4d0:1867:9999:db2f:de88) by HKAPR03CA0006.apcprd03.prod.outlook.com (2603:1096:203:c8::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend Transport; Mon, 18 Oct 2021 12:34:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: beae4729-db7e-4620-1ded-08d99233993f
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3340:
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB33405B7C5AC2E226CD2F3406F8BC9@HE1PR0402MB3340.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PALTOreK5PbZvD63fHc2wMWHWvoVDihOYBTqEKmxOp43EX45w/oLRAswEkJxykmmuUiapjjuVmVK1NLtHe4PKK7db99pu3CJT5vX1wRjkDzszeFvA0z9cLRS17pbkeUSbuA2FaQc3XsvcMWglh6thSJxJyNI3K75PHt9CKG/GvG8M8rEsnmr9PAvxDFSPK7OmLjwNUI7Ox/Y3wOxBfOXS6D/NhFpZBWR+aI4yn7CMvi6yxxvHLMsXiqXvD73Q9nRoTujA4YTVIERIhHS9aU+3TIkT3mvk3WeZK0kP0vTfIPINbAGlnMkx0/S9+xjFIb9sCIf+RP0OhmSGhwuVX63u5rCa9iR+0HjvWPbaZFW8gyqpT7/WGoPrfo/bi6lWbLfwFaOpgaUc1K47yMBicBc03bqrHLHQfgrhDHsvUJPAVosJOxpZ5QmnOwdDvm3Yui8xOEHu5M5f6t0Yd5JhfYnvTYmLWb61CVYVV4FAk+IDyhKC4VrkJir7D1d+QQFb79Si3hmrQAAXhsuzj/u/M9+1aZXZ95ky/ty7NTXWXTyk5Y4EuNVE2+tKGKBfaFux3pUniWWTI15FT86kyNQnEMeZ/cd7VojhicgBbBjDSmiLI2gBEYNRU9qy6rct3qDJP1XT1Ke4kSitsbYOItJ8zC08g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6496006)(66556008)(66476007)(86362001)(2616005)(2906002)(5660300002)(38100700002)(8676002)(44832011)(8936002)(316002)(66946007)(6486002)(6666004)(36756003)(83380400001)(508600001)(6916009)(186003)(4326008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HATXfAlU6NQSZLYRW8t8ZlgmQBb+j+xkIJ5FdVtK+mXPeyfQl3Jw6I45IiD6?=
 =?us-ascii?Q?jQPwXGmVxpFe7rfNTcj8Vczi+ai+fDTqNwm06Vc154aAoiIXWvIz6NKo48sf?=
 =?us-ascii?Q?smCV91UYz/KYH5AOuuLYNCY4bYUBU4JCmyiNlrF+Oe6k7ZfmX+S1u6mO4gAT?=
 =?us-ascii?Q?hZAF0UVLAGDdMHm4XgqBJxfClY5jmuva8xyETue6TCdqSRe/xl0HQowg3MUP?=
 =?us-ascii?Q?tro6xQkVAWGEQGFG+QEeQo0P6pqqx7R8AQ67ZrB84eDT5W2tAttP8a2/GyEV?=
 =?us-ascii?Q?Mpdrrb8+Er48fQrt8xHv6v5ElSSKmRm0X0Kfwm4tXJrRaAh76O0bLjxiCEvr?=
 =?us-ascii?Q?BoD6c2wp04GpZapvE+oyPR0ST13HOW82115sdyj3nO2KjxwCKWciKyeatqYv?=
 =?us-ascii?Q?1Q1DVNZ6xfo5A7hEcNskLyd4JbSmHHOoQJKK7Esd0LkLUXK3sz7ejqHu8hz+?=
 =?us-ascii?Q?Hak0xYMu4wSTKPy5cGVS74gk0mOkSt8Rf7L20donFDjReema0TjWLl5UHf1y?=
 =?us-ascii?Q?nU8/uYsr2WrQ7N1Q+ysDJptShulE/8SSE9sauFXmn2smz0QlPjDWEXa8p0mW?=
 =?us-ascii?Q?TAD35DCN2q1ep3K96NGKfYQ8E0nJiqFRcSlrF0CZEYfTnBl8G8CHXlUsH0V4?=
 =?us-ascii?Q?sv57TOi/ct9OS71pwKQ0y9es2mpqpk6Vs0wifmUrLjLNEhoVSD6DKxAVyO/m?=
 =?us-ascii?Q?TEgQru9+jiPOlm+qdmS0mvX0l5oiGcKYUds3y12+p5Up9qNRCF/vHZhRrYkB?=
 =?us-ascii?Q?oA3PBCvh8AMjA/CWv3CXgyQVFC1HvoIwSMq8pS/og3IY7KUJb8ZguQWXR7Cc?=
 =?us-ascii?Q?OykYb/0iyZBbFVonYnbkKT3qX852JsEtUfBr+u537uOE7WkaYPddrTbvpf8p?=
 =?us-ascii?Q?Mnfbm0ZoXwuWRQnaDEHbmi3F8P3HhHkn2346wBicBLqKDpugbe/rK4aaO7PN?=
 =?us-ascii?Q?5IsXkJFyW9zrX00jVpoiWLRKb9npNELpTYWbvLZKrZA5tzteoXfgBuyR55C9?=
 =?us-ascii?Q?9a/mZHdEEy5bsSBFluPYnbTXsSp419cpQGteEP9+vwXONUe6F2koQ/UZN2oo?=
 =?us-ascii?Q?InNomxWLeIqIWzaLMbB/UHKwib2Uv1OC7hFCsPCzPt6VjVJorxUNPp5sDG1v?=
 =?us-ascii?Q?2gVU9zAvkfkSd+etlMu9hsa3upLPpc6pvEfxxd0VYmMVYwTn2L3pULIpzoou?=
 =?us-ascii?Q?0bjUq9NVWZWpK0N9luWmAmwQFhPq9CHR12HzXPGegXKC2yDlxtGhmEoGE4BC?=
 =?us-ascii?Q?tzUsLgtYoiSciH17Tpr8oa0IWLdCskAI1gS/RHwRw3Twz6MeA86YxtOqzds7?=
 =?us-ascii?Q?4c7d7x1eQ+vc4qeWzhOkiXet3t+6q1+S+WzlyAzXy+R1Ejjv76pMTpDBJ1Bz?=
 =?us-ascii?Q?Hgy54CWoFK3Ke9Huuh2W8mHcPkUc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beae4729-db7e-4620-1ded-08d99233993f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 12:34:16.3112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfPSXYL1YtHFD2owL9rvBKXfp/BhJokI/KsW0cQdcLbrMJsVxBbZRnLvGUZHPbPrZag0NqwqQADkn+5UjM97og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3340

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
2.31.1

