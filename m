Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E55157D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LgLa0k4iwdQV5ovOVyFWqBVgHmak8ag2xn4ZPYSgLT8=;
	b=jHufkocijrGBXeDV498zsOZpincC0SUCDjWVsKNGRvQ+E4oTO1jgehl3i03b4mC/ZF2Lvy
	Ox8lg86Ty5De/1vf0pbazmZMw6zL1FVeejlTRuiIihiWgw3zQ5BZu/3Cd9E0+ZY8LqgKzL
	5ckXZUfaopcgvRrQAzPzU6BmbJN05vA=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-zZ3u4xSoO3i_pICtYoJDCg-1; Sun, 20 Feb 2022 00:17:44 +0100
X-MC-Unique: zZ3u4xSoO3i_pICtYoJDCg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLhsLs/wuAchxbryD8Qj08QWPx776h60yVoQ+EfqkBBHIWiRuPlXZaWzfGYgF+S5oNLCbqD6f3SByvmpL/8ETqTgPC9QkFcgbM4F96TIJNFqONqAN/wkLoZ9g47EejeSySGGmj/cCsaMX4+fCvSafhSfQgQWX8EBhBQwzKbvd1rwW5zydIN+ROzp2nETT0PC+J+Q8fuwJwmYtUZ8BK3GHQ+DHHwYsbYHP8fEwXdJmJcylaYMFdOmnxIzszuYFwIoSCeiOoTByW5h8RwN4KE9akQx21jY4UtZ5qtMXBVsTEoO+mLXLRMkI9p51Mw4jLwMhpyX406SIbh2u8twF5MLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCP0cEqF9Lr+c/vb61nD0DcfhluNp1fxg4OfD7zJPjU=;
 b=SOTI9NOLBrcYw/7cLqOfC58W7ju7gcgSCQwfQtBlOfqn8+Sz+Hnh/LX2CLj4hvdg1Oe3SfuH32QfyNTfa3DYdLwbNgYiTIIl3SoRLDpS7yNmFH5mROJ8RRpMyQCDnKGFeLYrwWCM55rwVUPEstDCgt2y9bDqHjqR1wbmPN3nC/NmaG2Zi2iZR6deMtnWaKUnUfhL39U14UuQo6Nee0iYo2itqUj26RPznLuSEDrmbzp4iEOMf6plvj0kE2VRGrrulAV3I6OmHvrP13shONeRDZUjyG7vSvLVkR3XBPTsIf/F5PkLxt6+WecTQ38uO11hDp2DB+Qz2Tc7I0n+ZINafQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6841.eurprd04.prod.outlook.com (2603:10a6:10:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.25; Sat, 19 Feb
 2022 23:17:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:17:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next 02/19] Revert "selftests: mptcp: add infinite map mibs check"
Date: Sun, 20 Feb 2022 07:17:46 +0800
Message-ID: <5f31185476db75e2f04205b187ac0d47d894fefa.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645311956.git.geliang.tang@suse.com>
References: <cover.1645311956.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e5e2351-e78f-4669-5e7e-08d9f3fe06d2
X-MS-TrafficTypeDiagnostic: DB8PR04MB6841:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB684137B49A47F98E7839698CF8389@DB8PR04MB6841.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mTn5lc9Um8fzopvmV/1nJ/GfUXocH6qToytHMQnFf7vvLvMCQa7imqRIS7TyjAmWiqAHG0LzTdzYyFgyBtYCa8hQvQpNgyuuecKZPYmgE1tlVvn9p3BOxaR5HHzwADTb6QQjHYQFCvZMz13Dyi4AQNgAzov9LezyUfntKpUpMNuZz7KJHi1Y4+bsebUG7NuS+Vhqh4BAY5S1xgwdRKW+lgR7S3eJejSNBa0+WfrlWIdO684j/S+2A3kaQ+EpwqjUlA8m8BaFyKpbKitocJa1Mrdm1ggaOm86lwsokOGL/64fUjKsj8unGBAvbG32KaRkNGPbT5dfLguWMVVikqLmIOWJLwX9ZvC7SOIy/Vzqs3wGMiyEKPxTymlhdZz9s9L2HMWs/rAOLFPeu2NRPTD8H9th1euMEhepFmwrJ996kIl0lh3y7ZnA/V+/QA/lbKKHGPx+bIV9w+IPxu562sKMaOcbvWNXyGwFVsx6uOpqwEgMjyzTGT0bXSyxEeXCxVCBn7OwBypxfekJhSEjK4YxVh8Lv+9YuJOeEvUMOszSa0595/EbezB7yPUIu/v6VVaJSuJ67dHauGD1vm/3uqipfWQT+ntkzaYsByKYQtQldqo53fTaYvSxux0OiIh12tHzrk7aR5Zdp+xlOIgE4TinMA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6512007)(107886003)(6916009)(38100700002)(8936002)(86362001)(2616005)(36756003)(6506007)(2906002)(508600001)(83380400001)(5660300002)(66946007)(316002)(44832011)(6486002)(4326008)(66556008)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dvmuOSnCdaJxtiEI0SOFjz/wdEmcaGO43XMoZNJnG0BmxDNnt0eFGb/4/hGL?=
 =?us-ascii?Q?MT5jhCxDJ3TxQ2wqaKmQ+kjd8gzKCKIRbzFusxGB0oUJ94JwZOmfz3hJakwr?=
 =?us-ascii?Q?5Sw0zgpYJIa16RH00FTysh8y0hrB612uGSq/DaWxIe0fB3x8cdoAmpgglXwE?=
 =?us-ascii?Q?YZXMHEkO6dkxAYa/cH90QK5S7zVIFlWD7XBFa0zdJsgdOMzTU859iwUYb9PV?=
 =?us-ascii?Q?eGONcaDMY0cthMV2DFzzeMcwfnm+pYOIPLvYu1bL7j5m+h58T3w86P+/vv5O?=
 =?us-ascii?Q?TpeA6sW2NT+fvPSVe+07B0YCHzazKbyCFchb54JWm50P+WGAgJ4ayHqtciUY?=
 =?us-ascii?Q?ssvNTWc4BjFxybISzmWdIaeEx3ZfWwc0EFq0P9MvqTYl6Ktu6V6Y5mXluL7k?=
 =?us-ascii?Q?DNNfrlc0MGhrqFvY1+/JWnumt1lvbgF7VxE+R0XaD5h65luZ4FXwF8VCg8eI?=
 =?us-ascii?Q?HdZU1VHWUv4EIrOU1VSBjudSh2pGf8nnIqHtX333gzc7v8mLnuzkrfaYJXAa?=
 =?us-ascii?Q?4vspqtN61i4Dc3MxIUdYUL86MgreixU9Sgg0axDadJD8Zrbh9EFdvILaQDWs?=
 =?us-ascii?Q?Ekjg9ESqHspFu6fCuyFXJIPb/LwqLJltaqCB2o4s9gBdTITNTPLC/eotswPL?=
 =?us-ascii?Q?RuKwn2SzCCi9Y+8ESmCDuLPRtF5aEWUpCzmzNKSS+1nWqK8DA/a2Yce/PT0Z?=
 =?us-ascii?Q?0hmzHOpITyEfr5tXIyaBncpIFWX8bkaq4GJhNKWrRG5CjZFEgzenX0kyXDwY?=
 =?us-ascii?Q?z8ZUHMDancLng2Qd5wymz768ccDzKgdlBPpC4uqzLzr6OePwJAgceYarry95?=
 =?us-ascii?Q?NPTPMxG9pXwjbXH/z+YSSaiXlNkd7aSziuCJRydyMDLW6OPjndXCe8w+5tYc?=
 =?us-ascii?Q?69y42dmrU8P5dJZR9PswN4gqRt6HfWe5Cqiu/yomhcRGP4SstpRVhQ6gWD+Y?=
 =?us-ascii?Q?nvVeVjiUed1TGEXP9mGu3cAE+CHUbHIS83zVf0kdeAkWCaDZNnkYEKg8MFhu?=
 =?us-ascii?Q?Rw8wWbdzzGqEj4c7oG2p/jXx4KdQV7BHbfhd7S/rp2slMNnTNAj8nmBArdH9?=
 =?us-ascii?Q?eM/p1zuZ8QI+1gDpnTEZyKDxIsjw3Lbh38ROmwR8fbVdb+Miae12gxKI1+OE?=
 =?us-ascii?Q?PpDQ32cg0alKSjf+3L1ZVVxB/gBslac4x5vnYA5ltT61FUpo8NLx+mEYs1no?=
 =?us-ascii?Q?2eDcnPM4CLJvFrZlY7WjHSRMISKB4+r6Jm9tRr71cNYPZ5KEQGJVf+NFWDF1?=
 =?us-ascii?Q?j/4Nebv1wSkEROPQpisQBGnZnonAXTO0BH+CIQE8QZJhK865+55lJR+FJ+dg?=
 =?us-ascii?Q?Gdrcx0xDiPhG98/qsnkBZyctTCqQCAG+80WCQgdcazgpWqQt2r4dVbegXOmw?=
 =?us-ascii?Q?Uo5EMBeC8vXuygE1oLMct28fQJ8qIJTmN8Fq2svMtRjTkHH2AYj/u5tVe3Dw?=
 =?us-ascii?Q?2hV/Yh2NdaqfgziYztLBqvL0AGP1d/ATSp8HjydhSFs3/xXB5xxJX+nsBqpc?=
 =?us-ascii?Q?gehlxb+p5sNM8PxvwMjf4+jNIdeSwkuIvXMKg9vagaf/cjT62UO5WUgfSv1y?=
 =?us-ascii?Q?AAG4lIjDzj/AnJIBIOB2Qyl5N4eV/bD2pjU8aa3iWtqS/ifwL8zeJJBEyFqq?=
 =?us-ascii?Q?6b9aZQOrYZKJ2FqxOF84/EZdOT4Vxg0Uv5AhyRpNl7+CihWwuDn30GrNuIOu?=
 =?us-ascii?Q?RiY8Dq9wEzGHwuW2JahHlBGCFrY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5e2351-e78f-4669-5e7e-08d9f3fe06d2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:17:41.4453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjUE+9xTu+TefF9mbDoDGU26F4mjH2su4uc+bg9ptlrXye30rARzvDy4qh55AuPFdw2UvVWEKMXiZCUq7I8Wow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6841

This reverts commit 22ee6e6a089b8ad85103e6835ecfd822f4f6e1f9.
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 33 -------------------
 1 file changed, 33 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index baed1e0aaa0e..519178dacae0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -871,38 +871,6 @@ chk_fail_nr()
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 }
=20
-chk_infi_nr()
-{
-	local mp_infi_nr_tx=3D$1
-	local mp_infi_nr_rx=3D$2
-	local count
-	local dump_stats
-
-	printf "%-39s %s" " " "itx"
-	count=3D`ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print =
$2}'`
-	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_infi_nr_tx" ]; then
-		echo "[fail] got $count infinite map[s] TX expected $mp_infi_nr_tx"
-		ret=3D1
-		dump_stats=3D1
-	else
-		echo -n "[ ok ]"
-	fi
-
-	echo -n " - irx   "
-	count=3D`ip netns exec $ns1 nstat -as | grep InfiniteMapRx | awk '{print =
$2}'`
-	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_infi_nr_rx" ]; then
-		echo "[fail] got $count infinite map[s] RX expected $mp_infi_nr_rx"
-		ret=3D1
-		dump_stats=3D1
-	else
-		echo "[ ok ]"
-	fi
-
-	[ "${dump_stats}" =3D 1 ] && dump_stats
-}
-
 chk_join_nr()
 {
 	local msg=3D"$1"
@@ -957,7 +925,6 @@ chk_join_nr()
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
 		chk_fail_nr 0 0
-		chk_infi_nr 0 0
 	fi
 }
=20
--=20
2.34.1

