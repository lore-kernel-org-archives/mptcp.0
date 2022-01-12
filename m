Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F32C9D
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 10:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641985033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iu1a8LomT/JBQQRpb+GZYDoq5RDmUWcmvQ+EsyKdBtE=;
	b=DLbQcsYXaOcpH7MGsy3lHQ7i8HpcNSBFcngVYBCN5nNX/fceGyXUl6zvvKTOC/QBZDZG0v
	WhIB1bTCa2ux2rGKjmGC6Axrfbqk09wTj6a0hdy7DmHLfsmFoBGB7y9NOK4+7KFhvqC/sT
	OS4KXKibs/DFnUMVa0VwMX9uOMUbw3U=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-FvrZEK0iPkWDpHme8SyGlQ-1; Wed, 12 Jan 2022 11:57:12 +0100
X-MC-Unique: FvrZEK0iPkWDpHme8SyGlQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ld9r5A/ydesQw2PQv/fyLn6FJQ1vxF79xDmas1Lhk1f62d2UCuxVa863dlE4/kI4hQmpgWBXc+Vg0FJfLJEAvnVbxOumEfUs34mue+0BOytYgBbsyRnhpl7+5qO/pYbNDxm5vIsZm0oBzL8vG29pyswB+3e/X4W3n1PmrouHKXqKdD+uHzNhFNOOUKypB0kFwm9tE7UDqP+U1gqW6H2q2lfo6eykAXsY4SsR/ObqYmYgE+JotRk5suPItppvqy7xmmxLl2xq4UCEwg+OxH9PQgO6/yeDJGr9UyQgv/dr/Qfi1d95OHa/YAUVWI4ppKPwQasrDvrep0nVwxGaS9m3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jR+7VrkF433tJxVARGTjcbwMmFv+9rVBDoCglbDvy0c=;
 b=C7pF3qawsYXoaz0wa+HKVM7l8IX0R6+Vl+KGL/QS+995PBYWYKEmOkywWgm2xM2BQooNcAXOotK65y/LSyipQyzHkLQbyQR6X78X1poVVrVqHPJjl7Y34BmnyLa2l+koSBC40k2udTNST2xhq01njSxJ8TBWG/fa/HIlvBYSZNnE1uN2LQ6cESwEgSX34fkRnqUduKRKtPTgnbOPeMQTsdiiwYKhHTv782ncSkhAjbHgY+7mN/DyTFKthx6OofaKszNMQIO6NpvvfYQKvlD/XIb2kid1kTeBt13DR00QJYStSWXVPHjcPjUZaHK61fbbLpuaejDqZJORxyo+TZBYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3483.eurprd04.prod.outlook.com (2603:10a6:7:8a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 12 Jan
 2022 10:57:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Wed, 12 Jan 2022
 10:57:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v3 3/6] selftests: mptcp: new approach of getting addr
Date: Wed, 12 Jan 2022 18:56:43 +0800
Message-ID: <f71afa694cc749c7d234b8ed0ad4d980e9fe1f61.1641984855.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641984855.git.geliang.tang@suse.com>
References: <cover.1641984855.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0171.apcprd02.prod.outlook.com
 (2603:1096:201:1f::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b4dac72-2f26-4939-a446-08d9d5ba491c
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3483:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3483C20FE41B78C3241C964DF8529@HE1PR0402MB3483.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m+wGA+gX/mPEDKAeG9XjfmD86eEYzYUpszKimRtT0Ggi/MZ4pPm2WiR4A10tvjT0K5TB5yuv4XeEdsIQLVQWRde6/22K/k2l7qPuaBpx4Mvc0UKq6bwcCu4iI/bKVSN7AmpefVmqWOYX1kgRe+iKN07021ueya2d8dRtVaIl3hxXvXLiVdQWlukiA197UsVyje22bdqeu6J8kwcGqNRZH6RHQ3sj9yvbzyycKALq4RCoZFtx2vMWdqqEdkfuAQPcWF+5qYPoVaP/ASWMhNufiZ6yGXIzXb+CmiKBiBTGSrzkHR/1CN+ssTBBoKACffGoeaXHVzIFj4hIaB8io4TyDJu5nxuTWA2tx0f01/1VNrMfZ6n1vAgOkbBOCm6KJgr0d4cleMfku1uMW7iHDYFYbwxKEZoK6v+17Reb3n8gd1whi80k9b7A1PQsqiAaLxhFH8hAE2qdbegC1dTe5WX00p/9zQhSu9L9g6lrp3J9X1n6Y/jLheNib9/h2n8hSoGt3k0ssDnF/7UF9MLWvUvGJAQN7fBxYGJbySdhVmbdplfXF26MCJjPC9xyIsM4TcHME34y7qGdC22f8d2AjjYPDLybf+RE4JyFeKr4ZOdDStmKhSuOxHrUPIA0muMPsIMkpQHCJ/Meu+PH52DLsKm5iQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55236004)(8936002)(6506007)(107886003)(6916009)(8676002)(36756003)(38100700002)(5660300002)(6666004)(4326008)(186003)(26005)(508600001)(44832011)(83380400001)(2906002)(86362001)(66476007)(316002)(66946007)(6486002)(66556008)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KLGR0wwGWugygWqu5N8wFzdFs3RO7N+P8ozebTDbhK02ripBgmCcMSucImSe?=
 =?us-ascii?Q?zK4QxwtnjHCGIy7rKRS/I/PA6nKTQfqHBYoQGbZO97aerOy3cjDWr0ZlEH3z?=
 =?us-ascii?Q?CuhhtX8LQKSN8RVlId6x+czIDOiovEGo++nEzbnrD0a6zCeGAZR/FBry+5Yi?=
 =?us-ascii?Q?jhixNJnimbCSBkIeK4h4bpsxsExNSxEp8brA+sf+9wAG6hzjnp1RCdhxPmE9?=
 =?us-ascii?Q?FAthIB5qEdoXLdAzlwwJcfRdALcMLfW4oQxjUjZqqPsRPi23GcFKtdZgQ2hi?=
 =?us-ascii?Q?v9pLuD3Cb5GgcZUS+B/gQGlsaUt4fzWSLGzSpA+vx9Oz/HvL8sUQAiZLNuWN?=
 =?us-ascii?Q?7f/tHnIOU7Y6QHnOmZNXkBAOT+f9SqZ7Ddlj/5fBaChkumZzMA34OVj51WDy?=
 =?us-ascii?Q?2el1e34DDouLVgRxkN5YSpgllyA1kCzwXG+nK6U1zuMBI7Yb80G4fKMCU8s4?=
 =?us-ascii?Q?iJaGHlzm3YRMP3uSp13cGPpCwFwH+wZMkQh5GtEKVn4XXa72ngxCBAz6v6IL?=
 =?us-ascii?Q?Z69xHau5JJAeVL+K5i2sw1Hh7eJT3qtMl5CJzAFPjTkkygOPCLM3p/xo8q1G?=
 =?us-ascii?Q?Z+UqC6zHY8pmA8hdqQ6kdvLrCpN1WDZWG51IndtGCau3P0gNe3abDhx1mBqq?=
 =?us-ascii?Q?zfrxGwxhNMiBzE6p+CAt/8nKphkuRTR+m/ZvhbWJEj3RQaD+BCfjoxKKA1c9?=
 =?us-ascii?Q?90nig+Kehlfo0vSZO0xJK0pBOUDzu+tXZ7jv0obh3wCSWXI1ygYto+g4aBeE?=
 =?us-ascii?Q?EYFeVrgj5sF+d46tsqNiGBPTT4u+vyx70OfcbKDHRHYh3L/zYP+bHg/4Rlcw?=
 =?us-ascii?Q?EOnguORBjefBzh4sRhRXhBdLH7xHWdREuorKLwlaJWy9ysRk9fxlq/rx60hj?=
 =?us-ascii?Q?45294zqxvPLxDvKP0E4C/eDVn0cSxLPCgZ1YuRJN1U4gRslBjg/mVE5J+rK7?=
 =?us-ascii?Q?UvmV5hat6YFmwQhfPZmbpU6xfO18Q73/2XkPXcna5pbe6iYMVkCEkb3iSvqM?=
 =?us-ascii?Q?roDi5OBgyUlZQ4Z1UoiQ8Ltl+ocF/hfH9IjhxOrh3xG/HsQd94XK9L/RbWBB?=
 =?us-ascii?Q?RUyyM7Q/vm7PBQpKSncr8m3gm64bwMyZXdPdmJri6rOCfw42Bhl3Yrei+6YU?=
 =?us-ascii?Q?FAroMmbGWxWMA7GOiJdPu/2WbWhDbPZH0ehEuhegzQELpW4sROCs+ktWTd5k?=
 =?us-ascii?Q?Bbbdm42yRqs9FStY4rHoeuaAaL0F7MNdg6Y6rnQqAeT8jn/1lqdVp1PJW6ui?=
 =?us-ascii?Q?1bAV11VntYsyOdiq1xcL+p1Ol4xsiGY9Av5R0eO8YIwv/wbrpxVoIYRTur7g?=
 =?us-ascii?Q?zwQNTyA4cbeHZSxQgtCrfPAeiW6v+7bn1OeJMPnY1kBlN4dvL7Ea7NKWY00U?=
 =?us-ascii?Q?cC1IycvXPtuglYUrbKqFAmn+DCEpoZQAyVCf1GHZH7bEc658by8ragmxsZ7b?=
 =?us-ascii?Q?pRuBaN2XVMSDrus+FNrz4eBVuxB2gwivyr3sQp82NdOFuuFFlGRzNl7XLrsW?=
 =?us-ascii?Q?MrwhTrYgV/Fobc6pJezd/js2VfHooISQM1jCM348+9s1TcC251gYwamRzXXd?=
 =?us-ascii?Q?lW8lmsMEN9RbN1R678qNH5yVv6U0BChNM0aAe2rWraxyjmdreAIXfC5vfUHo?=
 =?us-ascii?Q?yL9z4O3KLsYeSeY6p6zreSo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4dac72-2f26-4939-a446-08d9d5ba491c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 10:57:11.7976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5NbxS8AzYs4xYnIkFo1DV0WWfEUNisdmv+hC/eZaMbFu6IFdeHO/3vH4EB3eWPqO4obxaAS2Efd/RNuN3duCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3483

This patch implemented a more flexible approach to get the address
from the PM dump output.

The original code in the backup tests only works for the output of
'pm_nl_ctl dump'. It chooses the last item in the endpoints dump
table to parse the address in it, and the address is always showed
at the end of the item.

But it dosen't work for the output of 'ip mptcp endpoint show', the
address is always showed at the front of the item. This patch rewrites
the backup tests to fit for the 'ip mptcp' output.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 395f06784582..086e0778a1fa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -240,6 +240,11 @@ is_v6()
 	[ -z "${1##*:*}" ]
 }
=20
+is_addr()
+{
+	[ -z "${1##*[.:]*}" ]
+}
+
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -552,11 +557,17 @@ do_transfer()
 	if [ ! -z $sflags ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
-			dump=3D(`ip netns exec $netns ./pm_nl_ctl dump`)
-			if [ ${#dump[@]} -gt 0 ]; then
-				addr=3D${dump[${#dump[@]} - 1]}
+			ip netns exec $netns ./pm_nl_ctl dump | while read line; do
+				local arr=3D($line)
+				local addr
+
+				for addr in ${arr[@]}; do
+					if is_addr $addr; then
+						break
+					fi
+				done
 				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags
-			fi
+			done
 		done
 	fi
=20
--=20
2.31.1

