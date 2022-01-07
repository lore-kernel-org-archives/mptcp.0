Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92222C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 06:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641536281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vausICJE01f1HlQ2JnPOjHonpMDurxI5PwJ06HwGSD8=;
	b=DMyK93fz2MXI723xNI/hE3+oZc+gXy3CSpiPHIrqTibwg5DzchFzSqcIeWvP/gjcpS8e4K
	jpKlrBzhfS8JVTs49vU/usWydLz6TWuA9KtYVrYXgeJkNA8W5DPxuGRc1cHm5yA1+/8tG/
	clXq3GH8MUtha1Nw4iON39YpcIey4ps=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-AGxJW7L3O6SzXVXrjxpxxw-1; Fri, 07 Jan 2022 07:18:00 +0100
X-MC-Unique: AGxJW7L3O6SzXVXrjxpxxw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7FINeffkOKQKMsZHkUlKa69/FzED+0lYw6fmLXYfpA2wweXPHsCxcyEw4u6JlvybbS/VOiIgKz+QDnWj99k09GKHoVrOtgBYBn1palmowgvAoIopU4y0p6v7yfiM/XnTklXW4zntUaXlrxkgPC7AxIF6L+RyFfeZK+TFWfCwNXQwueHgI8xjcW2R2HmyVGdO8gVCqbfsDsHdMi6Ldm0KhFzFXhAVs+4Hi2wXFn/AO9omwgjog0TRKTkGrOs4/xjldqC21aEQqPJbvy517VGEnSX5mVV+tRiGoWaywZiQtsOfHYSk0hFETAwFdvCv35l6Z3CpAstV0JK4uuTKOJlUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxTBGBXO3CApFldZpLmW98vLiHAKnLjuLJ027qJIewc=;
 b=Xd7zI0p35MXLEo9gM/H9JTBeRvm556PmWpD6XZHLC2Y8ScC9WJzLDxnG6m0yJ/W1jA1Azg17tjXUN5nUJxbeiCcRyd335vjSa7OFsWhZI/EC9nLFCqZ2I74v3HNCgjjkxW8zxxjKaeCVhtjVigeMg2jcrl4wdi78mUtkZKqLHn2rvKXGZ3LuU5DKzo420HwtJLCZCW6i3Y2O0jY/y6g9nld+3Jp5edYQ1+Pz/m69G6pdQbVhi//kO5WBMkKnOdLEXQv02ZDQCrJNFmvdD6/IrAzTf2pwLLC1XyjPdpzswmHT42xDhsmfamin7mmhF78xEgQRLRgp+emro82xndXw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3369.eurprd04.prod.outlook.com (2603:10a6:7:81::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 06:17:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 06:17:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v2 7/9] selftests: mptcp: implement pm_nl_show_endpoint
Date: Fri,  7 Jan 2022 14:16:59 +0800
Message-ID: <47e4e94eda65b9e68ec469fb3e7309405167ec73.1641535880.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641535880.git.geliang.tang@suse.com>
References: <cover.1641535880.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0022.apcprd04.prod.outlook.com
 (2603:1096:202:2::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc1fc1c4-da80-49d3-76cf-08d9d1a573c4
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3369:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB336920BEBC8804485559C277F84D9@HE1PR0402MB3369.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xWmvh3efzv3Mhl4+aspgQzopMzo6s4Z3S5k6eZIejWP0pU2bt39bqs41ipn+wfxJPNzwN2SddxqUW9EnDHHswIQvC5cSl8cDcCMio4199K8GTNTUA0zo7gqcmXAWuxh+FoXqftnThJ+aVoRONSI6xkr6FXCcWJ1kSe34mFziZulCb3IKUsqMK19KYwYxCvpWawXSibltDgfSC2GSbQ6oyerjb55/pZ7iF75LQdrtv2EbtBWXaQiQHfnY1q79ngW1jAxdYkrTSs07LujDp2AJxbuSyIsIPYihQ/JaRV49w8hsVjuV85+bMOjoXq/F+FSPOGGfaA/apZKf7s+NuQ3P3s4ddB2pufuOofz6WNl6K+1I0Vo6iQ6nEmqKX5/ETjUZ8PLL1xY33PJakHc2g32/FZ4+CyjC/tUKAwD4rwtkuZVkIyRX+nn+zP/enktXx2Pf0C4g3diJyNw52YFsPBgLloU3df7wuHXsmT+6gY8OJlZiI7Xtli8Bi3qiO7s42N5t/oH81fyCk7Me8lmZotmokgb1Nt3vCI3b8HYgwyNIdZp3QXmFjnQuCDhrc2jLnPoplMSxANInRZe7tHrjisRjLsc07wblXj5DM/Ktq83DLxgOpbzYMzTDvEmPRg0INkEnSaAhkUuVYsG19hywC3r9GQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(6506007)(36756003)(86362001)(55236004)(6512007)(8676002)(6916009)(26005)(107886003)(316002)(5660300002)(186003)(2906002)(6486002)(66476007)(83380400001)(8936002)(44832011)(2616005)(66946007)(38100700002)(508600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NFeJip3Fa+Mcc/mhxAS7xfpeIgyx6Y8a42wyCEC1QuRtCIWeZfRHHeC3Eq7Q?=
 =?us-ascii?Q?QRYoLkLw0Q1+Z/MUGPn63W973YvsD/s3PrqHTbHiMQv2HE36msDIKwT8o0Ks?=
 =?us-ascii?Q?pEhOKQ/KtvQdMDk373SqsWqWmAGVEa/kA3OIyVO5/6NXrnb9xEhfO9gYv16q?=
 =?us-ascii?Q?bdnMsQ1B/aaZ0ZhGyLoF6l4JcGYIwJ3EI/6BMJ1sMLdSTP0XmSsyCfFXivlq?=
 =?us-ascii?Q?9rBO6aYGL97cx1eel9F4zaa5Kl35Q+HhF52vKht9734i1CmjamA/0it0W+aP?=
 =?us-ascii?Q?uim/LQtgP5EvYCKjrCQemPCFTB6pwp9ptydninSEShgbnECDhFzMWo0SylAr?=
 =?us-ascii?Q?NmZYY9w44D3fn1HSsA8usGPP+b6aIJEROZudhQao+I8+Ur7Ittt3UVZc+zBk?=
 =?us-ascii?Q?0BLe4KOGHD33WwOwwuM7pkalVuw+YYvBvN0u9Q5/7kAsU0af/NUMNIYSE+9e?=
 =?us-ascii?Q?Ivy4rh6RPAA8vIzwEMGdxb1wmDNP6LlBAX8J0oWBI8yK17l7PPbIWZB7LIyO?=
 =?us-ascii?Q?4waVuUl6g9YUijcnYOUytcML7zFeRBEDtqByF+uqZYxhGBzWl2ISYeROo4p7?=
 =?us-ascii?Q?O5w5GTL4AMPd5H1eAQ2twQh3euA95c88npSogdbwyr4rBu+eqi6T8+DsRkqm?=
 =?us-ascii?Q?3ucVoJkmDc9rQbu8NXvbfEG/tcuh1GZ8iwCD+6zwYB/oSC3RIwDjhCSXeBBV?=
 =?us-ascii?Q?M2bjShR/yM66mCZvgz97XJbvq/K/0UMH5KTPz2/n9relynjpbrRTR8YnNFsC?=
 =?us-ascii?Q?Na3tGNwDM73zlyY2I5tOaADCZjaqJKiflQNO6tRuLi4raltp28o7G2vVLpuI?=
 =?us-ascii?Q?RTgnYSLdw5qIzyy7NJ4CSaUjZp4Np4cvA0M8nlQh6lRCqhtLZDutkj+9xG/j?=
 =?us-ascii?Q?3dd3UVEnlCVMVERYMlqk25sreperyKMJ46i8Hi80tE1zyY+ysFhzU24MlF+V?=
 =?us-ascii?Q?UQk4D+vK8qJEbghzAnWhAQr/Xi2ulguiMjgkXYDu01Sx2tyE6IyDnXg5jEe+?=
 =?us-ascii?Q?7qgBOP8zbJz+vPvja/U5ZI2C0xYsv/EiNT8vzFZwm+KoWqFpK6LXjST9Y17b?=
 =?us-ascii?Q?pERo8SbnDkR6VZkfILfyhiMQPbm0hkec2ScFum0FA3Xa1WA0dP2yy6aF2t4x?=
 =?us-ascii?Q?1M6+BP7WE6lUfFq7sJp6orh3Spo1vkQcGxGPjOC2GzYUAPZ5u8ihhEDlwyNi?=
 =?us-ascii?Q?7z46W0cPNhJHANhERpHuazobwv/tLH5OAWnTrBUMjVYe30sfJHmfSM6AZDIO?=
 =?us-ascii?Q?dYwt2pk2/VUrzH0wTOd3xoVAmpmWFRFzGnGY5WFqg/4YH/qNeaSs624kHb9b?=
 =?us-ascii?Q?F6iYNeYs0wOUHSprwUd0EwvkZUSZC0yA8XtnbBIK4Elx3FMy2sGo4iIAptE+?=
 =?us-ascii?Q?PjqUyC5Xxy3TWjJ3hLBGmp4DByfOEoWz+cj79OJivONF143LZHhwPmicjNJG?=
 =?us-ascii?Q?1h5T0SLtAisga3w/vCXcdn5vp1g9SblO2hO0w0MpGcBa1q22cqk06UBWKfak?=
 =?us-ascii?Q?/x801Bf7VrZJUlPl1KHcjDy0t08vIwtvErImeV35i3+ZCiUOMaEaet0QWagS?=
 =?us-ascii?Q?W/Kv0sv993tvoMEJ274OUK1L6dURzT9isy3gBEmq11oa8HaDtgqlcQfRF8Yd?=
 =?us-ascii?Q?l0Qhs8vp9Pt4JLm2LdY3DPE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1fc1c4-da80-49d3-76cf-08d9d1a573c4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 06:17:59.2637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbAGAQ/vnrrdf3L9Ko5YYTlHiOADoC4tfBWvhOkkU+4gcZiL9f8rWqADrshyuNlbHvkV4NFKmpgCRbeewkmBpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3369

This patch implemented a new function named pm_nl_show_endpoint(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use to show all the PM
endpoints.

Used this wrapper in all the selftests in mptcp_join.sh instead of using
the pm_nl_ctl commands directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 475867a01b83..1a92f0526a4a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -363,6 +363,17 @@ pm_nl_flush_endpoint()
 	fi
 }
=20
+pm_nl_show_endpoint()
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
@@ -471,7 +482,7 @@ do_transfer()
 		let rm_nr_ns1=3D-addr_nr_ns1
 		if [ $rm_nr_ns1 -lt 8 ]; then
 			counter=3D0
-			ip netns exec ${listener_ns} ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoint ${listener_ns} | while read line; do
 				local arr=3D($line)
 				local nr=3D0
=20
@@ -524,7 +535,7 @@ do_transfer()
 		let rm_nr_ns2=3D-addr_nr_ns2
 		if [ $rm_nr_ns2 -lt 8 ]; then
 			counter=3D0
-			ip netns exec ${connector_ns} ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoint ${connector_ns} | while read line; do
 				local arr=3D($line)
 				local nr=3D0
=20
@@ -560,11 +571,15 @@ do_transfer()
 	if [ ! -z $bkup ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
-			ip netns exec $netns ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoint $netns | while read line; do
 				local arr=3D($line)
 				# 'pm_nl_ctl' shows the address at the end
 				let pos=3D${#arr[@]}-1
=20
+				# 'ip mptcp' shows the address at the front
+				if [ $ip_mptcp -eq 1 ]; then
+					pos=3D0
+				fi
 				addr=3D${arr[$pos]}
 				ip netns exec $netns ./pm_nl_ctl set $addr flags $bkup
 			done
--=20
2.31.1

