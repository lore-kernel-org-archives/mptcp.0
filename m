Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB1C2C9D
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 10:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642156070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncG+5ATqQHyMEGsfHF6Rg5FTXN0naavnhILa1zSedAU=;
	b=GYnTD21uIm1UO7ASMACkXSZtafllugRDYKqoqanbKr4CgsXW19H1MvQmZm8wSbPofPUqE3
	72BXaG2xQcj2lxbpb1MfRSNXjdeE0V1sJ9kvUjgVB6azRcBP43wy7m64AzEv8JWJMFDSJr
	ekHQFoZcF7K0M130iFvliXJ0AZpwi/0=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-89mwztYeM6KYj8Hklfl5FQ-1; Fri, 14 Jan 2022 11:27:49 +0100
X-MC-Unique: 89mwztYeM6KYj8Hklfl5FQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9FE+Kj9NpWivhxiiNI52pLqK1EaOzcaGhpf/De+OVl3kXh8Y15BzIwNYezFHq1mXajJIjVg6pxUIm7TaH9BUyZGjkqddGepEcOlT3x1JxEupWPfpK8aK89gtJXsGiCIdMgqW8GNe6T/GJ9ugQ/fAoUfOo1YKxalnVIygddz021H5Ikb9MuIINTnDAz0zWbDlmxHu+ZFf3zTiHxcQThvPSM2DsruolqCbqT7JEK1gt6lgUzpMjUDpQJ2JSZ7pF6+P+zVfvqWRGztWjOXEy/PqrK9Bl/LwHwssJgQ0LD9McoklFXFZDGTshhpc2MU+GiK6u0sInGdkyG6CK4V/xqkdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnJWkMkOYMtyQWdabgLC5T/Ns0d+BYRR5TW+IV9Dm54=;
 b=fHUSV7D3JbPBppVECnOcz+ASiuVEZHcrg4sKAnfYG70cjWZy9gZSfmFm2jVBZKgRWBelUaFoDCmYfz9+LUG5NxVkRQaw2iZVakMk++Tmdb0e6KzwGf8EIN9Av2s8z6p4J2CfKsVrzpyomhEiG9WdCRRri/r3cTkh6XZvxxwvvIo3l+Fzml6WJFX4vDHS06v9Py3lOe8MWIBYq+dKMwFIcX2Od3GBNtGZJSGZYxX0la8qlG+8h3bjKUOpoPrP9X03ZEZauvxi8u3j+k0vQEtCnffk0ZFFISfESi1vsi6dYgKAg9cTdqeUiQfVtki7jEZ4/4NppNVngtU4rVeVPLa8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB4558.eurprd04.prod.outlook.com (2603:10a6:803:6f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 14 Jan
 2022 10:27:49 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484%4]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 10:27:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 09/11] selftests: mptcp: add wrapper for showing addrs
Date: Fri, 14 Jan 2022 18:26:28 +0800
Message-ID: <82515476d59253de8cb0807a8214d5552e26c0b9.1642154579.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642154579.git.geliang.tang@suse.com>
References: <cover.1642154579.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a400f859-4d7b-477e-b975-08d9d748833f
X-MS-TrafficTypeDiagnostic: VI1PR04MB4558:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB45582C2B75608D3F393E5682F8549@VI1PR04MB4558.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PQWIzdADKajfB3UndjJwbHU8Jd1bzGSCf3wZuQArBLH26ygVYjpxtbmzFRWHRwJfOwtZnHW/juR527Dfq0N3uzGrpSx1pDkNHMyb+JFWuN5ICyHDY6WXlB4xVndl+MZQmPELuLJhcbI30Dqf+iKV5Wa8aBqqmPvJaUoCKvRrtRtkm8caFGIBs6+Ll5JwfhrN7VxJfvH2dkU5K+63Z1jMQY45TvesSNUDzu4GhsThyWgNA0hZlW0XdSpYHA7ob4ewUOFDTALAEkefZcKFMUpsKacxneWX9JJHn/pVyhF/HsI7VFH9a+y0y5caFM6zUkONL2bBLD2NW5rSGd5ME19S1tLYnX+myf2D0WlWrhAi0oUVFVeSN23YMIvI9UwCM8T2CeQp+n0zmw+9mE7Bk560R1byEB0f8KIKV0ga9RMmfy+p0fTuEXOJOQtncf7UM6v5PS/vTSzvkUotOd2EGcGToYUIlLQEA7lh7iQMgLjY8VCS778BVEm70R04ATjrjiiFFuBReX7017eZP4v/sgVih3S0lqPJhp/PgsqWppaTzpSC48id44ikaBWPM47pcXljNgOKGzhxJ/NRHoz+MVX0A7CJEB9HfctiSkntS/Wy/AWnb4ug0RpBeqFC3fE4U0EMjqHQ8o1KgH9r1uXET1CQWw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(6512007)(5660300002)(38100700002)(316002)(66946007)(66556008)(6506007)(8676002)(36756003)(86362001)(8936002)(44832011)(2906002)(26005)(4326008)(508600001)(6666004)(2616005)(55236004)(107886003)(6486002)(66476007)(6916009)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?185bcYlzbQJjr71mmiMaFc3cJrg3V3lr8INWhl2TbOkfNC2LsHUVSU83A0/Y?=
 =?us-ascii?Q?X+i/CbH3NsclRPhZEo4GxCryT0Evu/8k0VYPDXjNYSFwmAre+O5y6i8xjAM+?=
 =?us-ascii?Q?yB3xVW7Qw1Jz+otPXGN5sPV3kK/Hq2R988rzjvEf3Xk/iGdF7iJUrMX9kfGT?=
 =?us-ascii?Q?uWMHJB0/WnJaE+emY2+IFvBdFdCo+xkvDKjSHl9K33dyVBXUChCQg35LW1Q4?=
 =?us-ascii?Q?rzoUwhpUdJ8xoWwJwewQkbNflM0ngN7J66i1wUllzSxdYFtODdXl7c2hAS20?=
 =?us-ascii?Q?QnnMnJbLK9W8n2zsutEx8bhgLCZ6Yp2Hjg38QpmkG2NiTxrEuIkGkKMIUN7Q?=
 =?us-ascii?Q?LUju643M5J/30tW94aW5FEpQbSBr/fgU6zH/xaaa1+Dnk91ZR6k+XjtKmH7A?=
 =?us-ascii?Q?+TQgjXwwuKNsfg3cNFo8MdgZuoVSsq0m2yh8y44o95H8N74zpFDQfcqAiPu0?=
 =?us-ascii?Q?InNX0K1G/GP2dr/m0/YdX5P75MgnyP27hR9xow3+HFWGuQSn9WMudJit0dLi?=
 =?us-ascii?Q?c2bOB5dMvBQj8JvyjPRYqwIihVnf+csyV2JBOo4FfdXOMpQcRCNPGbYmWSUF?=
 =?us-ascii?Q?dLvywr+YCfy/78hrsgfigePHA7djwgxdIN8yC7vjxaouWXgMzqOlxJxzZTua?=
 =?us-ascii?Q?a6Sn4DB/w713WYzJ0TjqT9iYgbGmXpKBkPMTufNdxGBBWF3RgIT0IvrFW3Xe?=
 =?us-ascii?Q?7cWLeOihEe8kvAZJV0UiF2ve5glu31FYi6Awvg3QrG5Ti3v0iqZN0yHBuQ8k?=
 =?us-ascii?Q?N5IamLaxwwOZHPPngx0GPsbQVHg8gYlRnjGKjRoWJ3BxVgXRTv6fWwC6tlrk?=
 =?us-ascii?Q?qCzwu/sbu7pp1V6HzOdOTBm2DLJyMiVIoxapTvmDPhuoI57TM4QFyuwWOjYL?=
 =?us-ascii?Q?y8/luQfkGVzMYlUYyQw+Rvu8cVmPgx28yaOYNHOth7yupdqdaWMxx9Hqr0Xi?=
 =?us-ascii?Q?mxaXgUE9d6am1f3YrMNPwWR8S9ujYPdSDwzc0GAIqSOWbA3fgjfFf77PD5PQ?=
 =?us-ascii?Q?iyKr/uW/vjTVqhwIBaBU8ygJD7fuRJG3GCifsUVFYrJdk3be2D+WeoJocQP8?=
 =?us-ascii?Q?oA+O/SQbisT9mytBS14M+LuL9a2YrqoW6PwG21cw4oJWxXzy4Yd3eUXD90Dq?=
 =?us-ascii?Q?QaJ9L3JDACy/K1kNLvff4rvjb1gUWCqO9i+wkJMzF0iqIILxhsP9mPF3a7s+?=
 =?us-ascii?Q?TN2vR55Ey3hIDLZjzAx9lzNQ3b+4mL09btmLMFtEgZkPPA1uW28BcrzhXPrq?=
 =?us-ascii?Q?zihc5+iGh3j5fRg5BpJYh/WCFvEnJrx+FsflD7YuUS/XkkHukvE5EESPP4TO?=
 =?us-ascii?Q?iYDwaxMGXFPu8oBaXZOJva5InVwietBzoBJVolAJKR6ud3H8fh+jvPwl5gDJ?=
 =?us-ascii?Q?2z2V6TT9kMT5LSXLGpA++pyi1iSitk2igEFOGsfk9jyn6ehMFA4TvKyrc6oQ?=
 =?us-ascii?Q?y3+SGjwWjAfsKapADpBhI6swS6gESq8htNA9Ors/TqdayeyGxOJYdbqxQ8A1?=
 =?us-ascii?Q?OJbAp+81KEof0/7XY7jsr7yYoLMx+K8bXXOMQBqSaVGjd0cPy2IJpTYMe7DD?=
 =?us-ascii?Q?0/yvpX3FYtu3e32H7maHnJhq8O91cHWEuu2o1NVq0lT/actdQhVfWaSp3jW7?=
 =?us-ascii?Q?Lcy370ePR/Yvu+ecR7aM+jo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a400f859-4d7b-477e-b975-08d9d748833f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 10:27:49.0181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwLUb5vp1zj4CQWgBQGaHX8RasQxxExzrNtX2+nzhPIOjc8nE8nz2CflypNgH+MEafeV5iSZEiT5uul6H0tq5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4558

This patch implemented a new function named pm_nl_show_endpoints(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use to show all the PM
endpoints.

Used this wrapper in do_transfer() instead of using the pm_nl_ctl commands
directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 866b499202c3..24cabed18f58 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -366,6 +366,17 @@ pm_nl_flush_endpoint()
 	fi
 }
=20
+pm_nl_show_endpoints()
+{
+	local ns=3D$1
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint show
+	else
+		ip netns exec $ns ./pm_nl_ctl dump
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -474,7 +485,7 @@ do_transfer()
 		let rm_nr_ns1=3D-addr_nr_ns1
 		if [ $rm_nr_ns1 -lt 8 ]; then
 			counter=3D0
-			ip netns exec ${listener_ns} ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoints ${listener_ns} | while read line; do
 				local arr=3D($line)
 				local nr=3D0
=20
@@ -527,7 +538,7 @@ do_transfer()
 		let rm_nr_ns2=3D-addr_nr_ns2
 		if [ $rm_nr_ns2 -lt 8 ]; then
 			counter=3D0
-			ip netns exec ${connector_ns} ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoints ${connector_ns} | while read line; do
 				local arr=3D($line)
 				local nr=3D0
=20
@@ -563,7 +574,7 @@ do_transfer()
 	if [ ! -z $sflags ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
-			ip netns exec $netns ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoints $netns | while read line; do
 				local arr=3D($line)
 				local addr
 				local port=3D0
--=20
2.31.1

