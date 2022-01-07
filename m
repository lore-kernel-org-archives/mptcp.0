Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDA32C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 06:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641536245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olvEEIC5B7xVu88/Lto6Nw+PpWRppOp7IhyjIlwxE/g=;
	b=UfW4bqHx3TjqboGMTayG/owrjTy9Rld3ARziC9nyPu7TFWsuM5ZMKHgujMGUPr2DN43dcI
	IkK4vUHRm3QV4hi1qp9ElTnSKhjJx27O/CBPqFZlBhzKTd6M71eavm6Pap4Lwb+5bb69aP
	y9Uqx0qGwSH3l52YqBGuIe5FRVf6O4Y=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-EXzZxOL-NvmdFUWKhvIYaQ-1; Fri, 07 Jan 2022 07:17:24 +0100
X-MC-Unique: EXzZxOL-NvmdFUWKhvIYaQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZK0jlUXt/ojOx8u3x9i7NRG6eG7My30aUuCqZg4UwmAomcffQ0Lyroqj4o+QzV1Sv2zFX4yGJFHmf75z0SVuV8ShEg2hI78O66XBV9PoXc2y3g+JSyiOktUiMxrakLfhHOEmaEWpVRTLjuFaJFBhhBYJC4UUpj7v02Z/be/ecGfQ3OWMugmFTnJMmZHOdxyTYzhOR0sqUlbHe/VKBKE+9JBDumVfWQknZJNRymV/r0JjAaw9o9NKwM/ujpmhsWC2tRjBvrIvPF8VgJdSn1TRDRjZP2iaqxC7CpiDMmsp00kdwW2/zpUXDi3Qj1sE+t67u+dvu3ivuvEyGsj0kf9Uzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTx6xDH6Ocst8cFyX2cKNnMdFxhDaa3cE63AZo8bj7k=;
 b=hhzh5c0YVVWF3vKbeHs3/jGHXXiMFGqp48ttc/aLl62LFND+gnulTewqn5QScIyhKu/ofdCtWWcJC0GcrJr/uSEEMxkiUIaXyLN54E9ZT+bY5YQt+8+4q0Os0IkZGlBPtbw8CAoDIy5Bd/4sqHMWVz2C2KV3t7me/Fp4l/3dExpRvpyqHDdTwuk3AC3rAl1VlEDJ3sMSm8FONuKVqhPbPgXuwPxw9ECpvBFJvhuGWPJ8FuiFB6lrfPRs5m1UZ9psjF4ELRyiUayGQndO3rC0M27jxnlQh7J5eMk9L6JQU3q+PpYlxMRWb6QkadjAXzyE1EaBD0eEV34FeNG5X9ge0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3369.eurprd04.prod.outlook.com (2603:10a6:7:81::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 06:17:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 06:17:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v2 2/9] selftests: mptcp: rewrite backup tests
Date: Fri,  7 Jan 2022 14:16:54 +0800
Message-ID: <e19f023248fabb46d27714a35e8ded9a3410ba0f.1641535880.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641535880.git.geliang.tang@suse.com>
References: <cover.1641535880.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:202:2e::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80ca755d-49d4-42a1-d55e-08d9d1a55e05
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3369:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB33694EA7741E0AB35BAF84ACF84D9@HE1PR0402MB3369.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WEwmiU6EQX52kJZfCDFkPElOWgawR8I9NHZ7cGOKGMXByitDW4Rk8Z1FYcrGPog0yaX5vWhefFIKBB3/yBl/pubBHqeBRT+NtXCnmO8ughib/0OlfjzHvhIBk5h2+GbwF2d/jc9XbqYunknd9LzdPOfFbKapVZVIGTHwXc3rfRrtwsm6/1JT27lrbnPVMSpaJmVTFzR7t8NZFropT7mAstPGF3vnBSi9MRkrrpY6qKJ1dw/M1L8hmstpx2aRcmg4WrHMVHIu9rfB7C6FBbE1LTnAXgaBE75AnlrguGvPibTWkpX8hw+HlwjboXf61IKz5K4gdGimgSJbrma6YdOqdhE3j5J0bU/pfQX7kq7y+Jc6RK2rV+wAHm81tXuutE5EosZfhfk16PBY6ltDuVGwYBlAT5ulTAoC9XswQ6iaeqhg3ragNtjKfTf8iV3irPUiZZ7+ECeOpeIw5tr7lZoJ46k1EYsQKe9/HNh9JHjhrUQpfYSRBPkzZYIDt2g98muaLowovgGxVoZgKmzRMMeW+MUnIcROjRMEWmoP05Do5HMsfNe+biCqV+2lHnz0M8FH1qs7KZVDCDZjoDv1qe4tUIHcG6XTXAkslt4aZqSOBg+3/KsItAlW5fnlJPl0zzrJR+GeSrLzggSaJAuevoePdg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(6506007)(36756003)(86362001)(55236004)(6666004)(6512007)(8676002)(6916009)(26005)(107886003)(316002)(5660300002)(186003)(2906002)(6486002)(66476007)(83380400001)(8936002)(44832011)(2616005)(66946007)(38100700002)(508600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eYKvnMvX0RAvZ91nuKjbzQPn1uTOXsMP26EIaTCCpcx1n9qJdN8pttoh3Shq?=
 =?us-ascii?Q?bxrY+pQjb2Bykt+CdFQ+pwDGqdU8ZpjmpuleKvhQAEDhPCbg0PfwjVJmNzdL?=
 =?us-ascii?Q?EdNt3SODAn5fn9EqwetI+anvuKzbDp4JvX99X7nClbsV491pNKmDvxYa8dm4?=
 =?us-ascii?Q?ADU3zVSMea9GdrBl0gT+v0Mfx9aIUsoJzdZDvgS4uZki2Fu2bgbiVqt06xvQ?=
 =?us-ascii?Q?zAQgw4HnrxROwwqvKsOrarMEYVF5ZjMaaqdM9cOvnWGOaD0XKc3vGqngAMFc?=
 =?us-ascii?Q?sDGzufLwjky+iCXQfELgJLlnAJG6ORIjo24h/tgdraFJSggsfzAxIhmkUWMa?=
 =?us-ascii?Q?CZJCQdX1POVarXz2l2aRzSn1c18DZpUkON2dC6xkN2zyOIL2nlLUaGmlx1+U?=
 =?us-ascii?Q?mjWBQk2ebX56p0OzlPgY3+nzPOm0UnrsC7X3KyL1TV6r1bcd6gbJIMf2mlAl?=
 =?us-ascii?Q?1lR9CWTLU6awFXSk6rYwZ047Od1GZ/65eF4ibbKTJrEsYfuPSG5MaEnvzyCw?=
 =?us-ascii?Q?g59Woiy6+DiQ2KFXHsc1DzXItjcpFVntBoJEbjgr53GxHMxQVDHdbzZqDnhP?=
 =?us-ascii?Q?Lex5AnQIVOurNyGy8BzyHIaNs0/bSr4n8OGc8v0YeqZG8+nGb7aDJkNRAw2w?=
 =?us-ascii?Q?d0xNJr83kaRrhrarbMhYGStlYPdKwTKb/3Z2roNWv+5LNga1FagRPO8VlfR1?=
 =?us-ascii?Q?B7GQaAGRadN5fu/G6T/U3JjGKbBedJ9c/5PAXwFbXOiQ3lcCSSzGECxsy4zG?=
 =?us-ascii?Q?rgOEj1pMGf048+xk5ptnecMlKlOungzPoZybqklfjEmcX/ejUBDCAawmaMn0?=
 =?us-ascii?Q?vVRp/JPKPyrBRrckzbELXVZ5Zjzm/pAmsOG8CBHb8EsnHxAJXQRcv17t6Rbx?=
 =?us-ascii?Q?m99+l6zCgSM2yNlKHsh4lK5A5btiUzTpY4vFvSwBX1N5ozyd8rCxt+xjVpO0?=
 =?us-ascii?Q?042OMte+X88CyNuNXCPqfR71YJk0OWZ+4VvfnbS4xxfbwan+lMVpJCu2FYSo?=
 =?us-ascii?Q?hqvzhimyWO6tcmvAia3WnYCFXh44XzGy0yuemCbbgLgVM+JcFxZh24qyR1M/?=
 =?us-ascii?Q?y3poWd60CZW7UfL6ZWrZd8I4PReli06v1q2DdEnYYmll79p3ZQUPb5Fg8X4b?=
 =?us-ascii?Q?XzpEzKZaB0GCJNY9YicDm8INnpX8aUWJhXVLCzxB16Xlkwl54hg6DZk+ljHD?=
 =?us-ascii?Q?nK7s+2e5WPDh0ZShECPZz6SZSdxcYzHRPmVIX8NK3ZbHYQEgVemftL2kSiZB?=
 =?us-ascii?Q?cLALEUk7CNl29jJJ0GTomN4lq4TGO/Pa5OpNX6RE0n03Ti8Gz8c3BUdYEGuJ?=
 =?us-ascii?Q?n/HR3M4JupIxJD8wi8hKHly2ajzg7nCNijAfIaOix4DC2qLmj5e+U58wag9/?=
 =?us-ascii?Q?aWEnPMxrpZlsEmPfMjpRMLeOofg+Di06I85gviGn1edTG70cU8tcZotTdKU8?=
 =?us-ascii?Q?xAlGRlSDw6yf91hclQJZdU0FNkQgovYoWTSkfrLhFgCCleNlthz747gS2W3f?=
 =?us-ascii?Q?qh1PUkibHuYMwrMWO8g+LzGL4nsmhm+0j3maBQ0qq/jXVdQZyZV6eae3BdG1?=
 =?us-ascii?Q?DSJU3mLxMta8HMLPKFMFDjswx+DqUyGS5Gh/bEWi//pf19Q7Ql9B7oOcxI/4?=
 =?us-ascii?Q?0u3G/OeWjwZ9m5XRc8I97cU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ca755d-49d4-42a1-d55e-08d9d1a55e05
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 06:17:22.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KecNMA84c6+aCTjy7/e7vgjbFCRU+pTxuAbf1Z8nPi7usWiUmkEP4SRlbFFjHi3wKAZlo8nJtQuCx6du3Yvccg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3369

The original code in the backup tests only works for the output of
'pm_nl_ctl dump'. It chooses the last item in the endpoints dump
table to parse the address in it, and the address is always showed
at the end of the item.

But it dosen't work for the output of 'ip mptcp endpoint show', the
address is always showed at the front of the item. This patch rewrites
the backup tests to fit for the 'ip mptcp' output.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index b41126d4b1c6..b8c21d0b8919 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -475,12 +475,14 @@ do_transfer()
 	if [ ! -z $bkup ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
-			dump=3D(`ip netns exec $netns ./pm_nl_ctl dump`)
-			if [ ${#dump[@]} -gt 0 ]; then
-				addr=3D${dump[${#dump[@]} - 1]}
-				backup=3D"ip netns exec $netns ./pm_nl_ctl set $addr flags $bkup"
-				$backup
-			fi
+			ip netns exec $netns ./pm_nl_ctl dump | while read line; do
+				local arr=3D($line)
+				# 'pm_nl_ctl' shows the address at the end
+				let pos=3D${#arr[@]}-1
+
+				addr=3D${arr[$pos]}
+				ip netns exec $netns ./pm_nl_ctl set $addr flags $bkup
+			done
 		done
 	fi
=20
--=20
2.31.1

