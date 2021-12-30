Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F081168
	for <mptcp@lists.linux.dev>; Thu, 30 Dec 2021 09:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1640854803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CVWkqQ0Q2WrjB+7ZrZ6mC+PL9HHlNrPAcH5sh/FudGg=;
	b=XsXR7gnQvXQDTZgUGxxG4fTild9f4VAJPJTNCFiqcP7EEf2sNb6b3acbFoUhuYxX/gac9c
	WCXdOllMQE8vbij88Bdmgdht7yytY8O8Lb2EdZTeLGgamI1Oy2NRToOqwtzJ5L/MoWlMm/
	GwLivzNCksp/hKzJ8VcfdaO3aoJLC0A=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2056.outbound.protection.outlook.com [104.47.9.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-PpWOTWXaMdaliUEXs7Ei5g-1; Thu, 30 Dec 2021 10:00:02 +0100
X-MC-Unique: PpWOTWXaMdaliUEXs7Ei5g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0PjMWxso4as+waU9cAQfC+jl46wq1oPsZ1j79FFEE6ad5IBHE39k4WlgmHWRxmwwfYCr87xK4ODAz0XT9iyx4+hBW+fpx+jIwqOI/rYpMJjVvL2IvPzLshiVwga4yrNSHnYy75wO8lfBTNXa+LLiMHnJX+OEEn7xdKoyU3rfGnefR6yW9YO55c3uw35tjhDTYvK4PMs6FHjrv+6ksI0htm6tu6qYeVR8a59Zk5c0X/HfuUdaZETUmAz44Y7InF2tKJYIAXnoXIZXTcYsQ9X59Cj6+xtPTtD6WdxkDaMRDAPYjFtepP5CqVdIbC61RIZSp3JdhrA950vttcvThYEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmsGJhIFk6Xo4yD6vsrQOUGHy9hC16dCZQ2t5Gfv/l4=;
 b=nrZPzNI1XVxHh8NfZAWEgIxJ71DxMCK6qj2qbXaZ7fzLaSaM6EE2FNY4aaryFTxvPnc+jxi0rJW3foEBYn66cZzvBA9+0fgKK942a6Lg9CPs8hWSFTFoIIGdP2QHPhiQtCk7Pm+XDimU41HvVpJtaPYrGYoeB3vwCR4WIPhCYvJwojvYph55uA6JNe2RN8vsX0WZqXPuuTJeut0p0/Dp7EzPXXt4BOGyfaAQ9vDV3n+2rnEGSGNI8mSVEzsluW4kCCSy9sQTxG8qOReZMS3csIqASiuWu52yxHAOkO6+KvKbD26t22/zzcvrb/je5upkLLcbRFICqdRuHaXMIovTUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2252.eurprd04.prod.outlook.com (2603:10a6:3:24::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 30 Dec
 2021 09:00:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.014; Thu, 30 Dec 2021
 09:00:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH iproute2-next] mptcp: add id check for deleting address
Date: Thu, 30 Dec 2021 17:00:13 +0800
Message-ID: <e45ed5bcca8c7d1692562cb20c88185fb7e331ca.1640854748.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:202:16::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d9e9b26-620f-4287-f426-08d9cb72c2ff
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2252:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2252024B6D02AFE73693C176F8459@HE1PR0401MB2252.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0WD2yqrwUMTAIrhs+s1xfdK1DHcTgcu0GAj3/+m4nfeiHhYGgTbafXDjS9YmONqDC/iFZPt2xEnRyhUNNZbj7QHIFJJhY4WkX+4wyXtpsS6MSdsYHKaj7WbnlvEg/LXHUCgfZcHj4WigTCqx6XFmf8NlLscIyQWIvQeu16AcXFL7DMMxLcLh1W9AsvIt/MuIHpszb7IhIaTE05Cs2ck0xPacN5b0nX0FpMnASMd4HeNkRrAnEAchKPcwbnVn08l7tTn/E8erzT3frJ+9SJYQwvKrbR8V7HcNZUU8qOZeYwZR++70u6D7XRlTtJDM6ZHnZJmufa2ERDe40IcRsLnyLK/meXBRdtRCPgJj8KXfXrm6qy3x+Z9x6Qthmzm15VZaTwL8BjgUYDR+iXvLDzQQziy6HY97+QosjqU1ezEjwwmjCV+3p58NzSociNZkE5Nz52PrYtZyRVlrKv3XXwpstJazuaCU+N6xXMzNdHDo9HbLHrgmCmpW6yoqrIVPdJ3TJePaeZDIOjRxKMkIcz84po3UQ8UbkSRM7cI9sx0lYzAPFI19U0j1+/wemEQIHDI4xwDgyRC2CCWQmZDwyKFN6vZ4gkNQ9MkhOGoB6SVHYjeqH9QZWPIF88RxdQfszA6+tU1NDhk3hGZLsfCE+v/XgYaopo7JYSkro7xspKwbJJtsdVMYDKc9XFUrlPOI8EWom2LeVJudz9vUheviy6wOfwmAdXntRlrdE4eW19dXWcI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(508600001)(2616005)(66946007)(8676002)(966005)(107886003)(5660300002)(4326008)(6512007)(38100700002)(2906002)(6666004)(44832011)(6486002)(66476007)(6506007)(36756003)(316002)(66556008)(26005)(55236004)(8936002)(83380400001)(86362001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GMOG3W9IckcbXCPN0xTVX8yqlsW+DbSv9zzHuqhGL22VYb8+OVhuwvW6onS6?=
 =?us-ascii?Q?WSN0H2k34Rgnkq8cgea4kS7GdokG1iNmxsR/FHL7H75QKpzDD8hEPwJ1X1i4?=
 =?us-ascii?Q?Z707Sz7BZdKNChUwwyDs7nQqlm24ZPZCX++h//SBdNUanlEooYnrn8WWZKvL?=
 =?us-ascii?Q?RqPKTT0dquBzonF+hdJcayo9Zd6d3LCqlvoh5WX9rj+zLOIT4ziEae7+D2v8?=
 =?us-ascii?Q?w6OuG6hqU/Ay36cWE0p9PGBGIg46cpP5XsSMeKr+WmZ3SHmWT/lqSQNSrO/c?=
 =?us-ascii?Q?DM2rQGjXsme+JWLAIQg3II9fiJg1FDktPN0DW8iN5m5ia1/d5dNw0XSW1dX1?=
 =?us-ascii?Q?3vd8uJMnBG1wg1hmEYeMXj3HR8V0ClqILabJMkHSJVGdg10iXiK2N6MRh33H?=
 =?us-ascii?Q?2hiZESzP3aZsCtaH7wT6ls+W8etmERpFL2W371RISpzT5m+O4OAKA5VovqnI?=
 =?us-ascii?Q?f4dl8klHRARSH9k9Gbc+ikD3GyOX4vyYAxp7759YBdSv3NmJVW/qP8u1lZ/W?=
 =?us-ascii?Q?tWwVTVAW8jSjSt66LB7fzk3XMEiScrQtsUBOyYk80SQkmW9dAgQm2TpKqeMR?=
 =?us-ascii?Q?Ne8LLG4GpfI7SHTn7t3JIyNVYTXw0riwU5EERuMO86ht7mFOnTMcQCFS/zeR?=
 =?us-ascii?Q?bsoiHqZ3ar37kFKiGfVo1X73wFYXbH0fmPj7buN7/XN5NR/TjNw6i3mxkfGY?=
 =?us-ascii?Q?amN0O9VbJDAJKWUw1P6eShh+Us3qPckb3zuD3cvuSnw0rVhK5RsUM0fHO+Th?=
 =?us-ascii?Q?BJ2z5ab3Gd/Vz77e6yPen44qbQeIi76TNTa0lngPpfkT1NcaMQRB5MShOflJ?=
 =?us-ascii?Q?cOBMUd1nDZm0sleKjkNFNvcq+Zu0cBvK3sHoGudsSo3siwaz9XgDOVrI1vp7?=
 =?us-ascii?Q?pljDOTfVwWDbjv+3IRptupux6lyZZUpjPImVJX1VmDw2jaFBsAmJDntuHbZQ?=
 =?us-ascii?Q?OROO+BMAJpcANGiWpw+wKC4xhGOj1UfL+HAUDkMx1VXnq0W4NAx6FsTWsv9Z?=
 =?us-ascii?Q?UwCd1AMpdL/n0XKxcyVNOUhN6cSZ+Mbp4SkzvGDeu5TJm6y8mgOWV7gcL5iV?=
 =?us-ascii?Q?0TjxGIDE8CzGF0L32+Ff5Augegt/o7DLVqGS+uuV+40ocmwrwAJi7EGI0dM2?=
 =?us-ascii?Q?7nGbN8TehuVtgl2sXJMi4bk5rHTmKYndBGwO2zYIaYiq09mroXVWSqhLu/s+?=
 =?us-ascii?Q?y/xKWivKsH2RzzI4eDGAKkhAZvQfDAq9hPHCkaVVocTXv4kFjdcVmCKdOobJ?=
 =?us-ascii?Q?2Leo5OFVIcx+BsLDrrmSfdE23nv4Wi7Fxq8Pnb2oSCsMse8Prkt81xH8LYYf?=
 =?us-ascii?Q?czSXMzoOOdWGiLGIFrAnTsWnjOTq3X6b/MXiKZvbksTWyGNcoIe5SouDX9M4?=
 =?us-ascii?Q?2uAkSl0Xh5kmYpp2FNbT9P4JeC6cvfNWXSWP9aBq3Upo00L085n4g9TV2Nr3?=
 =?us-ascii?Q?oYzBsU9WKFcw4/vYGs8I8Yr9jkBTh7hF/Z1ioJA4Tt1d+MFW1iZMs/tBLpcl?=
 =?us-ascii?Q?57rHwjJb3a6CFzz3IQXMBAvnGQdUKwgu5B39o4e2WH6NJx3iF01bM82a4flz?=
 =?us-ascii?Q?xMho08w+ylYMr8s0a4dIc8ssbWxcoTNEq2Vevf7iscrUk7JyMMf+2l2o40HJ?=
 =?us-ascii?Q?MfUAuXdcwVycZZCzhK6cBzo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9e9b26-620f-4287-f426-08d9cb72c2ff
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2021 09:00:00.9618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpkttjS2yK4Rw1dn77uXfMVVLFezNI7/4Y1Ga2JH88XEdtTWG8G1AWOIKKGC07bhaYV4ahmgEOCjYZICCZeDQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2252

This patch added the id check for deleting address in mptcp_parse_opt().
The ADDRESS argument is invalid for the non-zero id address, only needed
for the id 0 address.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/171
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 ip/ipmptcp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index fd042da8..c2691ef4 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -18,7 +18,7 @@ static void usage(void)
 	fprintf(stderr,
 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
 		"				      [ port NR ] [ FLAG-LIST ]\n"
-		"	ip mptcp endpoint delete id ID\n"
+		"	ip mptcp endpoint delete id ID [ ADDRESS ]\n"
 		"	ip mptcp endpoint show [ id ID ]\n"
 		"	ip mptcp endpoint flush\n"
 		"	ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]\n"
@@ -142,6 +142,12 @@ static int mptcp_parse_opt(int argc, char **argv, stru=
ct nlmsghdr *n,
=20
 	if (!id_set && !adding)
 		missarg("ID");
+	else if (id_set && !adding) {
+		if (id && addr_set)
+			invarg("invalid for non-zero id address\n", "ADDRESS");
+		else if (!id && !addr_set)
+			invarg("address is needed for deleting id 0 address\n", "ID");
+	}
=20
 	if (port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 		invarg("flags must have signal when using port", "port");
--=20
2.31.1

