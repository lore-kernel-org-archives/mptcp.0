Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288352CA7
	for <mptcp@lists.linux.dev>; Fri, 21 Jan 2022 07:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642749763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCNQhrGG3ukd4EfX3peP3ENc583+/hVy9P81nEZKg9A=;
	b=J5m4JdYZxzBoGVMNNallXTTvzRKhdnQWKEex+B+qA0AzN21oPP3aNjrAsmqLISjKUDhtdn
	7BirlcBdfqECSQVytHDNtLfrYqe9ysZzLa7dsw6ui9uy6CYupEOwMiYyCo89dIZrkZqDMi
	RlhbDD2RVL/iM2l510FBtTLRhliXLa8=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-2ap22ylbP924mFcA-yeu5A-1; Fri, 21 Jan 2022 08:22:42 +0100
X-MC-Unique: 2ap22ylbP924mFcA-yeu5A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/ldlqkTglCEfKrrxOPY8kP13DCeWcRtqXoqnFqXdOIO8dGUnlx5tFU5nr546TMS0lkTuT9NH0Fj1cJDLDG3t8lOzhPoqDMaA9W2m1XNaZ+tKhbT5ZSMDZP/GTxKlIi6bQjI2Xs0Be6Avc0UUcNjsEnkSaoWYbfkYd4PTpmTavvUcFSI56f/vSPNyPLHkzHLeR2dBhMd57lTag4lJKj1Wtr4IkUlKWYkromFXTPw21y0ENCK51hK+8edz6oohUDziVkPt12c2mNnAIyMfxbQ5pJ1gaj6qOwPYEEA+jwip14dczGnPU3APwD9uJM/OKuGJmupdgY2JuMVvEziy6gWyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkOXorI3110B3KdI840lhK6LIQ/VIiDFOX0JwsbSgYk=;
 b=Tm1HOan4F/zPdOeY6VzYK8CbOCFJuwExxJ7UY54uNNgdEL4zNAobck3GNHlEMhF+mYSVAh0+JehjbLrvyMFMU9n4FVRwkmeHXS6YPayozE09WGoVwN1nBnckOJedRLUm9STbzPpy2FssTzo2ptA63poY9Rnbsvl/OfRyxcO8cpWaBTL1aZodo7Wt6K+2uskMGxiOTU22o4sEmpvLg/nJe2cBJWbjLfCaOZDyk50Dk9wyLd4S6Ag/VhZqxMHDJll+P/fg3tXjj7jkcu6hnhrd0alQDa9xC6SaVmK3kgnTAZTrTGl2A0/kRHJQ7pzLOcy0MmJeqp5zP5lOZEBQHgJs1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7600.eurprd04.prod.outlook.com (2603:10a6:102:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 07:22:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%6]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 07:22:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/2] Squash to "selftests: mptcp: add wrapper for setting flags"
Date: Fri, 21 Jan 2022 15:22:31 +0800
Message-ID: <f7696ad95afc97a4c78443ff700c588b600cc822.1642749049.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642749049.git.geliang.tang@suse.com>
References: <cover.1642749049.git.geliang.tang@suse.com>
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
X-MS-Office365-Filtering-Correlation-Id: 63bcb3f8-f36b-4564-af9b-08d9dcaecf94
X-MS-TrafficTypeDiagnostic: PA4PR04MB7600:EE_
X-Microsoft-Antispam-PRVS:
	<PA4PR04MB760023F10007BF1D36A24016F85B9@PA4PR04MB7600.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gKILn0P+fes39GIcWdbjcdP9djsw/lUJ97guOBGO9HR2nTxEilxgOoVd25kelFZIa3F20GxwBTqS05TcjQ24p1Z4tIFT4zvE0nKWao3Up/DU0C4zVTqT0Hmkkxc3ow3wVjMbjiqvVsM6dBlKbwvuN3edNFwlrkYf7n6gBVGkRel5m0wkORCe0JSnAAyTS8sPdUOjYMaG2UDVmWUHhLCzebIi48+M73WjhDVtToJgqaSv+ApwBmaJ85BdHP+jcB1Lulnf/kMcaVGsHkbC0sCCSmBC4MO5xoJiCmj3yKpkrUOTLZZwJJlGqMQ5X9DH/ahPrs91TniMykw0Kag9IxAnjD3CGPpnaXIUUpeaBLSSRPVbS+ygPYxXeS1EJK1BdBB17SUiUmc7GtEx6gtZ1j81UgFCYMzDI1ehB6sJLmyO7u51woAFlfTpBSJYPFhsEvcdbGYJFTUDXz/JjnGXy7wpYgo6kA4gmQe6kW3N2ESMsggc1KbSbmYQOKJXuXOCk+0r7kU06yTWw3d/4LL8pPP775k63XitjkwHuFnFcHcre1BNwAPXulGFDttVQi3CVEAF8t8byZDsn1Npq6KV8llG66wm9eRdjVpru1x5No7gzh1ie+iCGFK00ng11gJinbW/YZrbqItKYlPOjC2k4iDOCA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(83380400001)(6666004)(6506007)(6486002)(86362001)(2906002)(36756003)(107886003)(38100700002)(6512007)(186003)(55236004)(26005)(2616005)(4326008)(66556008)(8676002)(66476007)(44832011)(8936002)(508600001)(66946007)(6916009)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SwiRmXZYGfNRdkwQZr30MD9whhqVmU63MkGZN5+Ix9bXa0Ngq0flMJzXSuCc?=
 =?us-ascii?Q?vYQP8Q7/7uF4ASLxe+dQLWKdAdV1qyZ/rKonhDUBpyg8wia7CZg4L7Curp4/?=
 =?us-ascii?Q?Ysvg9bHrZpiMLQkX0kDnHB7dUDLOSU+yOVmGAVy2/MwrADsrtpzFKx2HT/2f?=
 =?us-ascii?Q?taz0VNUaoQid1UQB59Rrj0BS6Rd5sWlBXj5iVAJRufwFfzNxkcCF0VVKqBna?=
 =?us-ascii?Q?BvwzIs13/YXgNG9fzCH3BSakir7sNa3v/gawZHzASTYOapYspOeNW7099rFg?=
 =?us-ascii?Q?z8GYtXxm3Zt8f57qxUEfPIr+OSb4jm5wkaMcxJAc3vG9TDUshgkK2792X4X7?=
 =?us-ascii?Q?dGDaVN/GCeiDnOyuCiuMexmXtIJg8ZnAZPE562MZ4RVrDozxMQEJjAlyoVnJ?=
 =?us-ascii?Q?uAv0GytNwWtZfsgVf2qTTy5kJDHeww1k6Bh3sFbfUPfHxBGSIHACZlwdiYRm?=
 =?us-ascii?Q?esPz5+wZZiaROrIe3EUSzcCpxwejGDke3l6FedhCEoJkAoYxrLDoopObo99c?=
 =?us-ascii?Q?utVF22sDDDvVaoFRe9ZUHuJ8UXMiZV+nhAA/EmYraFeDcS8RD5zossYtwJhd?=
 =?us-ascii?Q?JrXmYvAtaJ7Hq/i+79faiF+tHFqddWgNoD7YxXAOEgLbPqlToFL3SrryzYct?=
 =?us-ascii?Q?+p/REPt7Xi+gEVKnhC0qJ3DYcmKpI4ZOb13CR6vWAvyCNTBt+NKjEJddmTMc?=
 =?us-ascii?Q?fKpTOmUj7edMK8N3v1w3bo9b4vvKJDuGUJpVCbYzqtfG6JFpxPsMMFlHe/lR?=
 =?us-ascii?Q?CBgSqPxWQEfPcoSZ3SiE6wnSvfEN+z6Jwdrv26awGvnZVqeThb9PBvdVJf6w?=
 =?us-ascii?Q?eIiSb9ZB1soGI1y/yOSvZqcQhhL3TOREqODBWZsfdLqtUS5vbz0QF440ivvi?=
 =?us-ascii?Q?8MrWSGMC78+zjSjT/u7bOeS7DHcgZtLGxr0GEamiUVkhl8LBD+lMdUr88xGH?=
 =?us-ascii?Q?3IlSWBlyob8+ZvmMFAsBKNQWzYgzzFEfP/MmuqOKVLPWJHL+M+gIbNP8N9dP?=
 =?us-ascii?Q?gBQaWZs2zAdPrNsSkGrxjf7B1oGivOfotazKVXayqUpdzBIeB2P8ebHMqDIq?=
 =?us-ascii?Q?dS/gEzPqX+IRiSv6IP66SL2fTihA5OgQLcikHOSUAkHlH0nuKmB4XigJGP//?=
 =?us-ascii?Q?ZV9nW0y+eL9eaVo1IdpDOPm10X+yM7uywvb4z2GSntRUZG/zBNxOcKgFaN34?=
 =?us-ascii?Q?3E7hVT1kMJDsX9UNupDHq7fp+jjrudjJ8D52OHj6A1WlWnO+wOaC6kwWYuwi?=
 =?us-ascii?Q?ypGLx2VPlcRHKjVvnjQEcYbuQO0XgrfMPj8L+jp97/KKMzYzTAdBUH7rEVXO?=
 =?us-ascii?Q?pEzzX72pPZF2VS8qWM2r4iUarGQ4M/iX1a5s3HDOJ9NE2mwxYzZ89ps55bcZ?=
 =?us-ascii?Q?6q2NrZ2xpBojvoZ0YQzJ19ZP+QT3w6PKRtNVd0Q/TUxZPz/zO+mNYy3EDv6K?=
 =?us-ascii?Q?pPswM0UhHH3K6iIH1fZ6J7eH0/n8NtipIEDSCRuCOy5HcTrCVF2eUHXKhKEn?=
 =?us-ascii?Q?/s533HQp/XQdqivLlvQeVePjBD2HvucrdkepTu8PG1g36xxBQo6Pd+Jdvl7p?=
 =?us-ascii?Q?dyIN9TkezJ2DRzCvA5o5JVIu8j/ox8HoQtGWA5hY4EfyHiQ2/8NVaY1voUzb?=
 =?us-ascii?Q?ycIp45byQtq61t9+0gs3Cpg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bcb3f8-f36b-4564-af9b-08d9dcaecf94
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 07:22:41.5465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lav5E81jSW8KjSTUvBof+k1CrcKYAwuAuTbw5J9ayhQIIs3+/vt+XE9rTZyJoMCALD7ZcVy1BYRT6+HgP4rHTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7600

Please update the commit message:

'''
This patch implemented a new function named pm_nl_set_endpoint(), wrap
the PM netlink commands 'ip mptcp endpoint change flags' and 'pm_nl_ctl
set flags' in it, use a new argument 'ip_mptcp' to choose which one to
use to set the flags of the PM endpoint. Randomly choose the 'addr' or
'id' as arguments for each command.

Parse the address ID from the PM dump output as well as the address and
port number, pass them to this wrapper in do_transfer() instead of using
the pm_nl_ctl command directly.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index cd45b854ff6e..ff82ce6bf81f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -457,12 +457,22 @@ pm_nl_change_endpoint()
 	local id=3D$3
 	local addr=3D$4
 	local port=3D""
+	local use_id=3D$((RANDOM%2))
+
+	if [ $5 -ne 0 ]; then port=3D"port $5"; fi
=20
 	if [ $ip_mptcp -eq 1 ]; then
-		ip -n $ns mptcp endpoint change id $id ${flags//","/" "}
+		if [ $use_id -eq 1 ]; then
+			ip -n $ns mptcp endpoint change id $id ${flags//","/" "}
+		else
+			ip -n $ns mptcp endpoint change $addr ${flags//","/" "} $port
+		fi
 	else
-		if [ $5 -ne 0 ]; then port=3D"port $5"; fi
-		ip netns exec $ns ./pm_nl_ctl set $addr flags $flags $port
+		if [ $use_id -eq 1 ]; then
+			ip netns exec $ns ./pm_nl_ctl set id $id flags $flags
+		else
+			ip netns exec $ns ./pm_nl_ctl set $addr flags $flags $port
+		fi
 	fi
 }
=20
--=20
2.31.1

