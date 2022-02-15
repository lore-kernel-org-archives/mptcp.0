Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF491578
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644939034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UmPp3Yfa4xmaq7lJlPCkAQsolxbqkhSfVeQfiygGPhk=;
	b=B2GaBYKj8yLZeaarL5yOchSqttmSh7eZFBnUBJnoOatu6u065SzRRcgRHHKMbZcYRBCQYM
	uXSgLcWlW4dfVNRTuv4UPc+FK6a9v1SHwpOXRjPxHP43SG+y8z0CMa9EqQnfvdiULaiF69
	hv6MFjFHAVgdqvTgSKWMDwUKN+/3/as=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2055.outbound.protection.outlook.com [104.47.14.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-7q-Dz4QdNnG_IBgHVV7vQw-1; Tue, 15 Feb 2022 16:30:33 +0100
X-MC-Unique: 7q-Dz4QdNnG_IBgHVV7vQw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqK2PanVBi9BaQpH52Gz7SJa0p2M5UFFarWkbYFOXDFx8jE8jqbQXiGdsp3W5dvX2A3yNoq2BqGZ0DA/hJPQFaX/1NgxXhuHTaP7R6tOj0QIPJbLufOakW6GptsDgPVeXDKMNU+X+e75So4fJvRoaQMxmT5qUbGCwqxAXGpGSsht7RuKPiF8sNI4LkCHk8aWqKwJSuHzOeNwXUExc445HD4DQ0yClZJ+XU9xIivR1Rk9SlI6UNSLC0VAb6FcCbb0HRrxsq02MzIxJW4+LRuZkuHDMMofrvnUIzA4ucPe2BRG0yRkbst5+/oYLHVwHYbegBNuVl/f+gF/4eothFTHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhK5lzghLgiN/56O7/l1w5oURuG+jQHsZA6lomXTPEw=;
 b=ilfqTYLL5FOHexFBOSBXDBmQ8U2HS1afUGF0Wmd3ZbxfQuN8s8aUE8V2yt++BugNsV5f5PzpwJKx2F8dpHJ00mVbbVOFtdM9pGpVxzAqlJWksdUGEIVRhogmkevQQzF0EALaLvL8/x8zaRJ+EFp62Y+Ro1Ojh9NenYbcyeqFrjesWBRDT6/smqXOgS/lqDndlWuwbyeXqwdHmq7gK6wuCPa2ueke+Q94qCA488gBRYXNrpmaTI/a0TVtGni5fxce/hfBKsL+C7zTnzZ38pOXrilLUeqitFOOhMAKAyLiAnHJq1DSbbBXaW6Xtc7XyXyy3GIWkuqbFKiURzS0jlYeSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9092.eurprd04.prod.outlook.com (2603:10a6:102:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 15:30:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 15:30:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add more arguments for chk_join_nr v8"
Date: Tue, 15 Feb 2022 23:30:53 +0800
Message-ID: <5cc51026dc3379d279f5c65311e641d77c789451.1644938898.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d043a21e-7f25-4191-9aef-08d9f0981a7a
X-MS-TrafficTypeDiagnostic: PAXPR04MB9092:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB909240FA12F7E22EE7A61AA2F8349@PAXPR04MB9092.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:157;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DWA/UBczU7ilYPKlGh3zxbBN62QWiADUXn3QZFsvnJb6DfS8GBjmhTJihGeWerRNPZkSeJCK34iTn9+wtR+mTxV4dK9eXvJWxWOW9dKfVrnqhIPZ3G3jkiqsX7yUgzLYcXKKTgg/KDWzIgLLHCmkjbCuh+HeGYcbDtQpf2kHtwb5LbRQvpZ7YKlvillz4avdneM/dTJQnEt6B8PznssR8zJ08RYhLvFgTzkQcFkffBYl7jyBCY1YX/ChXT8jV4HfHKu8zGxp/PwSbIvU2xiCypavB3iYmfqWuZ4PmOeGdYT0Ffw/S7WikP2wBh+weM7yRrYGFTTxF1IKeSR3oDBM+26YUAr1YeGaR2cUlS89q8ybZV5j3INLe+H9rltCChOFZcZsFt2CecB5UNt0+y2Yzj5bH3X3uo1Baanrc3ZGwGY7g0zFyu3ojHoH+7Oqpvi8YXc095vSmmGL6r+7zS4ukvLuymbzqk72VBSfJUIHEJl9IcsMMvbyZxbWaH0i0t3r9eNeyRRXvOekAt1qLbQCE8ZQoK5ceMix9Dp5of/R1OiSu2ntjuTHAmwOElqjR/9CossdpR7xpVUBLR9PG1vtI6cM4yh0XKJozx9r7KrAHdsWUKjw4CXtTUXj0+DQJ4PcgikMYxdGwJkTQFbEy0yy4w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(6916009)(2906002)(6506007)(6512007)(66476007)(66556008)(36756003)(86362001)(66946007)(316002)(4326008)(8676002)(83380400001)(6666004)(6486002)(186003)(38100700002)(8936002)(508600001)(107886003)(2616005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NSNTj9NY2I13Az2g33K2P9V02JaVo5WhQJ4QceRY6zG1hUukHpbuLI9kNbKN?=
 =?us-ascii?Q?iXL3jNoWiNc8rhoD4ReIfidABrcr3qZgsoWZ63+qJaj04w5YiaDa+63V2j+z?=
 =?us-ascii?Q?3mXixUxxod37Tgd3l5bo/V7w9sXo6tYsxN2MlDxJX/y00bGNXzYr2yqOMjAQ?=
 =?us-ascii?Q?M+7ET3HQk/79szdcNoV3ybqxCW1u6aDyvhdGcA6ijq4fVUTQ8+iguHJ2nJXc?=
 =?us-ascii?Q?vxq/ei6+BJ+C3U1xV4hBvAOYz6mILekZPjALLqMQqiT6cGgVTcYxmz5MyiHi?=
 =?us-ascii?Q?lsNwJ3UtCrIZ4MMrI5tNCfONkOnZPF17UqR1gyTz8IZ5oU8s4zi3jQ7W0FLc?=
 =?us-ascii?Q?YinBRyUxyGmbukbTT9iFBqPLzlC/RQeU8m24JtQ8kZXJurPecWwaOZSqnYug?=
 =?us-ascii?Q?p6QQzt70CU1OAIS9kzPSm2gtnSqjgU4L+d9YcB7agpxbYpGDH5rTQ4ZJmuQt?=
 =?us-ascii?Q?LvuJ5U5IiJ24mj7YJJztOMYoYAhaqrfiQQl0i2S1FIZ/RsCdvxpp84sKmrrv?=
 =?us-ascii?Q?SzxRC7I8Fn44XGMVlFbzVd84zmzUuu5pxfgUkXBklt8R4kO0eYuBQd/ki1w6?=
 =?us-ascii?Q?+8x9tQkzbaB9P+iQe3/rVgkLjoyuGotiOLIVbcOAuCW8RZU4pe9G75eYQ/nO?=
 =?us-ascii?Q?BzFJXJr66W2inv4mqKnwFNeiWCxYq34kl6mR9RVZOMDiVTiM7QKvpuG+5MZr?=
 =?us-ascii?Q?WDeQzzCJ8hDkqfmf99d3gZEl0PWZ24a3wXtKLMvdebK6Z9RZC4Y8/266LUqK?=
 =?us-ascii?Q?z40p8INqfsA5vC/HKBHFHL9Tzb+1rNv6ojZzIyktjdRaLeeGxESeq5jNvoWj?=
 =?us-ascii?Q?j4jynbNgTRehxEHpaLIXCXZR6zJVMMyab8eX66fk/nqGdphAY6OpX3WY+emv?=
 =?us-ascii?Q?ThBMu3Ki0aEy1QpOHEB+kLObYR8aIkZszkvtfoZQOLMZb8yPrlOUSFWb9BiQ?=
 =?us-ascii?Q?sY0OOtjZNywpBRQdrDpeAw3hBZ4GgF5wpzrIHPaFox66+b3K9SXJmvTEnu1h?=
 =?us-ascii?Q?YKWqqNbUXC107U5g0rjlJ4hP3VLhDv9N8AZtlMhuDEEh1uSAFH79pceDf0Mt?=
 =?us-ascii?Q?u5eI8Bjho3FcKdPixJou0Cv8vkG6AOBsloVaSok0lQKNFbUwGtLYRuk9AR3z?=
 =?us-ascii?Q?GC0coDcc64xqJGEQan5g6h/jkqO/GdlqOOH8Fx1K8RWqBBMihZCW0Fwj8Cjk?=
 =?us-ascii?Q?TochFncXy9n06vSYLfFr5v/3ZpTyHsfcHgyqIUFyPZCmmqrE8WJh/mxMaQTp?=
 =?us-ascii?Q?y5/djnKalrybyc3KDaG4cPEI5AOqz8jdkteUTCYBq6sNzi31pkp7xjVsAIdq?=
 =?us-ascii?Q?YnL69dknZtWOxC+cHvbKTmtve27sk2yJHfn0n75Dpm+sIjWxVkvx7KpKclyV?=
 =?us-ascii?Q?yOaqdZlUww+Z4NvwC5hQaKc2Ql9ZIPw3fam33kazw/mBvwR9gpNJFXtWJmuq?=
 =?us-ascii?Q?Asl6CG9+kMnWCOYBhfeogfILzAD2zOr6uAiAo5amXA5JNwIFrG+J4SsTqIVu?=
 =?us-ascii?Q?yxFlqKdWdhS5t6j67R0mfbApbZBt8dzkxtUHvsM5NSWgOjRDlZOZ8qH4WuHs?=
 =?us-ascii?Q?Iy/gcbr/ImxmTiB9P2cul9f88r6mxZtm7DGImh2KbzgmrEmCFDLJd0ghMvfe?=
 =?us-ascii?Q?9pHRyxOG2CdqRaV6i7Wzs4T9Q5SVghVltq8OZ0FPwma84fQWSweouLwIF7hi?=
 =?us-ascii?Q?WoUB9Zc4/MPjY+rQlt3mcC5VLMQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d043a21e-7f25-4191-9aef-08d9f0981a7a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 15:30:32.2854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpKr5pAv1K7hYiJ9IPhRTIVPGoLrHXpSTfqnVUhS5ie9x1ymACgUeTt0T3kvCikKuLMCG6j/uxCSJvzEIErveA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9092

Reflect the if conditions.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 +++++--------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index ec8d750c19eb..52628038af9c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -769,40 +769,22 @@ chk_csum_nr()
 	printf " %-36s %s" "$msg" "sum"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D $csum_ns1 ]; then
-		if [ $allow_multi_errors_ns1 -eq 1 ]; then
-			# allow multiple checksum errors
-			if [ "$count" -lt $csum_ns1 ]; then
-				ret=3D1
-			fi
-		else
-			ret=3D1
-		fi
-
-		if [ $ret -eq 1 ]; then
-			echo "[fail] got $count data checksum error[s] expected $csum_ns1"
-			dump_stats=3D1
-		fi
+	if [ "$count" !=3D $csum_ns1 -a $allow_multi_errors_ns1 -eq 0 ] ||
+	   [ "$count" -lt $csum_ns1 -a $allow_multi_errors_ns1 -eq 1 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
+		ret=3D1
+		dump_stats=3D1
 	else
 		echo -n "[ ok ]"
 	fi
 	echo -n " - csum  "
 	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D $csum_ns2 ]; then
-		if [ $allow_multi_errors_ns2 -eq 1 ]; then
-			# allow multiple checksum errors
-			if [ "$count" -lt $csum_ns2 ]; then
-				ret=3D1
-			fi
-		else
-			ret=3D1
-		fi
-
-		if [ $ret -eq 1 ]; then
-			echo "[fail] got $count data checksum error[s] expected $csum_ns2"
-			dump_stats=3D1
-		fi
+	if [ "$count" !=3D $csum_ns2 -a $allow_multi_errors_ns2 -eq 0 ] ||
+	   [ "$count" -lt $csum_ns2 -a $allow_multi_errors_ns2 -eq 1 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
+		ret=3D1
+		dump_stats=3D1
 	else
 		echo "[ ok ]"
 	fi
--=20
2.34.1

