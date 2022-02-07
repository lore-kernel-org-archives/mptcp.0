Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0773C2F27
	for <mptcp@lists.linux.dev>; Mon,  7 Feb 2022 06:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644215868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5fwqyQcN0KqbHNT3YCkRUT57RiDzCclqHBOV/ABmHcg=;
	b=l2KaWbf6BNkrXLbVeKJ+sJrbL4UCm4RkO5RYCV/M9MHaSf4ImFDB5UImTqjT/+3FkmHnNf
	P/opaSseSi0JLhrEPNBw0yD3ZtrsoUwmRM6hxz5vQ95QhVYTL4GstjyjQR/8aB+XwOH9Uz
	zttwyG0oyYSlpv6M8NEQIxXgAWCD8Ss=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2054.outbound.protection.outlook.com [104.47.14.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-NCToNeGDMDOUbV_Fs8egaQ-1; Mon, 07 Feb 2022 07:37:47 +0100
X-MC-Unique: NCToNeGDMDOUbV_Fs8egaQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3O403LGfjYF/WqeyKHQiMkMQmMFEHzlp28Rop2vjFRe6D4SbE1HEzOXvKGY1n4cuMxwuOG8hh+VaDP6S37Kpo6XUS/rhLRPGjABASxVYvHOYlmBz6zccvVHCgfa6fBa7wOjIbUV/bFMpmH/wSyCfKf23bLB6Yve+xgznEmIS17/xHIacJPBb2+/Jv7a35Dm+DEmibUB5LGO4hWr9IMI+/+hsPDX5Vwk7MIZpk5TTTwQK2Eexqq8f8b+vR/yp+1FBX/RcikREdleEe+w5bvPQPhegw/t+Kh3zWvYSfRqB1asf1DdVlWTboICsmU4iytLF6aUWixcXuqc2IJ8x4N/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEgGEaVIpRMlqHKRtxjJ5sa0Ya4kKUF4w5Jxn0raPrw=;
 b=Cq1Om7n4M65H5whHHVdvuEJhQi6cp5+Z9+TA/utAoJAzxxmDe+4s6pUnEF14md+iP/ll4XwP5J+Ob19sZnrPossbBZJFkzGRNNiyC1YLO4lqpPPklwK76CytpygonGktiwTFyv31wQsOqoWbs6hXtV4SOJAWTAt6ai9QRjoHysG1/Q2HSTZYQVAbvA/QR/KSCcOWHcNL5g+uuZHBkAdEBe7JBTIhM0G4O/6e23IueQwpVsqPdnplwUk3BSPco5D2wyI9p02swH95RkwiUIr0YrdaEqzKh/mTmuCiN42RabnmPrrQFQuBGOYFuiFKvQC5KJS495YUAbFFcv2E68G+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7204.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 06:37:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 06:37:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] selftests: mptcp: simplify pm_nl_change_endpoint
Date: Mon,  7 Feb 2022 14:38:11 +0800
Message-ID: <3172f829eeb966f7265e4740a6e3f9bdca2fe44c.1644215857.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e1064a9-276f-4dcb-5073-08d9ea045954
X-MS-TrafficTypeDiagnostic: AM8PR04MB7204:EE_
X-Microsoft-Antispam-PRVS:
	<AM8PR04MB7204DEB220A72E46D5800A55F82C9@AM8PR04MB7204.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mrAxX3rkgJMHDKiwATeqdhOwsMjMMpYlRrqCa41uN5s9kskgrGzIGDEkSdMwJPkkBHiP60bHznrrZNoDvMr/ry6KJ8ffdTIQ6YEqg5PeV8AlvGEKHSxAm3FIK0nFRLaPCThaaqn5ZMQuAss8jc1o8ee2uB0BOT67Ipqa5zoLjOC2rEO2aiwFy2oF76qS76OZlDGyCIsKm64z6UKEOq1JCxtzZFFrP6FBgR62SU0YsbyvQcsDrnG+FU4rTZvQzki+MIyRH25U3AmQgdJXlNA1A4PaqjfMw6jyxhNOxCDame1zgVm/zRLD88fx+spYMMQqh9aDgfbJ3oYUsaRYqPiCHR7PJ9F6eHLwWegslRLs7ZFYdVGgQj9m/k6RPIZXdKQoar5e5ZUQ/uy+k6DHh9R91dWyOXFGVb39DZ4IKE7dduEF57g3pwLNC7XnHpDWdTYyQnfzM+49AiPDVe8li4tdsBMNHoGASwFUTIUz98hHq0oTUi4yXTR/VV6xy6w6YfBfWqlwUVwxnpbBLYJC70+xq13SvFp611JM2sLFouoarpGbsb4hbsZ9uRG2Bv1mtjAxFEH3pcX7AJZsEIZ+/KTG1aKs4iJxUC5T4iCWvp+mqdoPCprS8is5B6fTvuiolsH5tq9nLwFYMOaYz4UopkwN3Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(316002)(6916009)(38100700002)(6486002)(4326008)(2616005)(44832011)(86362001)(5660300002)(6666004)(6506007)(36756003)(6512007)(66946007)(8936002)(83380400001)(55236004)(8676002)(26005)(186003)(66556008)(107886003)(66476007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eZQ3F3TF9KYg6HXVC72QRzwANLnZNBZPRMY0xaAi7I18/H+GEpzcgS5oUnmK?=
 =?us-ascii?Q?KljuB0k9VwXO5ajsft1mdw9aNYjdxSq1zJ+fbuMo79PwtSgbXxT+PoqRrycM?=
 =?us-ascii?Q?jSkCve3K2V5MXmrHmgiPBeZWG6v/p6JbY7KF6GW8/Lt/5CCCBDmlg24JN3K7?=
 =?us-ascii?Q?lkCz6k7dXUB9TlbcZToRw6LUPHzYYkjAiQv9qizptYph8Y7dHxRYt2+My2Wd?=
 =?us-ascii?Q?4Jz8f1wr9sVGv6enPGMk9QRSdBYLaPxTi8q1M1SoCpKAwNpxL7r/hUUlOXfB?=
 =?us-ascii?Q?B4d6gMegkptPxq3ocUBmPLBYYR4P/b3e3E18DlhZw8Ccn+0XtgKM5pXWA62/?=
 =?us-ascii?Q?E1uw8Gb8bb1WonxKJBOI9Ys+DF+bAUgvp9Ep+ZmctfZtHTcTG2NUZD4eoJzb?=
 =?us-ascii?Q?slPCWAd49AwNMgxDykAWTozGlp36QrMg4gK2h1aX3kSdSc+cXvsfN4xsyd+m?=
 =?us-ascii?Q?lv3oIeJ70OE38M06+QFeh3tU4G0oXCv0mFEImJTWTVf/YygyCCJ9JTixzIAK?=
 =?us-ascii?Q?3AadmRnVbBzoPJIJUSZsuH/LG3DTTFuLkDJIzDHcy9OyyLqSn6ZpoqzFon7t?=
 =?us-ascii?Q?fE0ilaVVaKCS7no1GiZvDuUx/w9hmbcrSdgi79d9J4sGcnZhSnYCU6mjfi1f?=
 =?us-ascii?Q?NIpXvswYal1rXQeJhwAcdNf6mfaVX0zQpB8usOEKL1REcurZ2V/5vvDPrn32?=
 =?us-ascii?Q?M2DKAUaFb7c6wm0nBC72IZ51mM/15GMLiet5TkidveNGU5C/t38zs/sGPo2O?=
 =?us-ascii?Q?rE++igAh5il1nDgx80JAvcr/CHJ/8P94/eNNg227QA8V717mvbEfyq708aNz?=
 =?us-ascii?Q?VIuzwfRyn3Bc8pL/r25PviMFn0C0/aQA7F4NSKV64f9lxnqKaQZ6cSydEVqs?=
 =?us-ascii?Q?hScWiNDLJwqH4JxvO8FNPjZ/3agUUuDO/Rg1Z9AJToDdzTUKkoJIErara0uB?=
 =?us-ascii?Q?Xx7l1qmt0rwkBt9TizJ7/K4cS5PlgAzhZHqFVcAdTWofRyFfvU+I5FC112AZ?=
 =?us-ascii?Q?4t6ZMAFOYxsQu4rl+dYX57e985wY0deyxx732/GFApDd1uALwnwWZoea8kLK?=
 =?us-ascii?Q?K2rGFhCHsBqsC4nWDd18rXZnuOW454itaFrEL2DMeA88G286i1j90zFeAJNQ?=
 =?us-ascii?Q?D001DSoaAbqEK7oYKAq6jpaEr4wJzW+elFucs62wR4jFFA648b0QxwyX7b29?=
 =?us-ascii?Q?lySXS1xNq2jJxDW1xKHW5FaJUiFISDc1ZRfjUwcObRtUEJ0tlNvoFXuPICdp?=
 =?us-ascii?Q?Bc4++Lxf6JLPrMEGkkhSMrgN2Lbgpod7yZzHVz3vkqNOrCDMORi7M7qCCYDq?=
 =?us-ascii?Q?+37AxhijMoMLC0aeLJKyv96Vkbnl1TsvagcMnRULFaThRjfdmcxNC6Io8N3u?=
 =?us-ascii?Q?DzkypYEDiQh0NFArO3QhMS6UGp12Fet3EQgIJdmGH/R7p1Pxc7NfO5DUIsQ3?=
 =?us-ascii?Q?2VSKpMU8HdGjCq4AithC72/datSj47uPY+5tl9ZTh96uMAWt4VlrF9G8a9Jb?=
 =?us-ascii?Q?zRcVcDdV7wH2LvYJyPfFtKVEG1ZTuCuiY59/h+TOkb2HJ9QBFeDq40umE/xM?=
 =?us-ascii?Q?zcVNouCaZ5mWOqIfd/ZoPDWJ8rCnp1p1qy70l/oU/+iQNYf/XzNmgRgpKWgE?=
 =?us-ascii?Q?qoruVHBqYI9w3SNLJjisrCQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1064a9-276f-4dcb-5073-08d9ea045954
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 06:37:45.0196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtfmqChNYnF6rCeqQ/YK9NbZNS44U5ZT4Xl/692cesIiFQKiyMj3z+yW8A85hpJqW7cTc0Pkm7O8vOY9CqYm8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7204

This patch simplified pm_nl_change_endpoint(), using id-based address
lookups only. And dropped the fragile way of parsing 'addr' and 'id'
from the output of pm_nl_show_endpoints().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 37 ++++---------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 2ddb373b7c1d..90a6adc36490 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -251,16 +251,6 @@ is_v6()
 	[ -z "${1##*:*}" ]
 }
=20
-is_addr()
-{
-	[ -z "${1##*[.:]*}" ]
-}
-
-is_number()
-{
-	[[ $1 =3D=3D ?(-)+([0-9]) ]]
-}
-
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -390,16 +380,13 @@ pm_nl_show_endpoints()
 pm_nl_change_endpoint()
 {
 	local ns=3D$1
-	local flags=3D$2
-	local id=3D$3
-	local addr=3D$4
-	local port=3D""
+	local id=3D$2
+	local flags=3D$3
=20
 	if [ $ip_mptcp -eq 1 ]; then
 		ip -n $ns mptcp endpoint change id $id ${flags//","/" "}
 	else
-		if [ $5 -ne 0 ]; then port=3D"port $5"; fi
-		ip netns exec $ns ./pm_nl_ctl set $addr flags $flags $port
+		ip netns exec $ns ./pm_nl_ctl set id $id flags $flags
 	fi
 }
=20
@@ -602,24 +589,16 @@ do_transfer()
 		for netns in "$ns1" "$ns2"; do
 			pm_nl_show_endpoints $netns | while read line; do
 				local arr=3D($line)
-				local addr
-				local port=3D0
+				local nr=3D0
 				local id
=20
 				for i in ${arr[@]}; do
-					if is_addr $i; then
-						addr=3D$i
-					elif is_number $i; then
-						# The minimum expected port number is 10000
-						if [ $i -gt 10000 ]; then
-							port=3D$i
-						# The maximum id number is 255
-						elif [ $i -lt 255 ]; then
-							id=3D$i
-						fi
+					if [ $i =3D "id" ]; then
+						id=3D${arr[$nr+1]}
 					fi
+					let nr+=3D1
 				done
-				pm_nl_change_endpoint $netns $sflags $id $addr $port
+				pm_nl_change_endpoint $netns $id $sflags
 			done
 		done
 	fi
--=20
2.31.1

