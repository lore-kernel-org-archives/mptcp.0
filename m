Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80044.outbound.protection.outlook.com [40.107.8.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612D4111E
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 12:41:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMr0HbzGYXjrezRndWpAKewGcDzMqIf7SLwEJ3WQivjqJeaMcS1woPkG16yS4Fu8SQNw0djpYynARqYWuBU10nGRWlriLHqmXH7/0MxhN1ufYAoPuNEwlONliHOZuCbeutz1Dn/d5NDIKfIZQSOvDDWVKXmp5XIsN9hRiTIck4T2jQdXtFQgWrCzNomF+piXfKCYNClxGg/GYVXiRTb6sglg4azjvRgEGPSneqRpH68LgAgHg4Iv73NfKJkuCCXPM3PowJrjG0WUlqXOvWIdI6EP/PmeWEHSZ/3zKYlaLtsJIYHANjm+725ZWZ4yk4qtwJtIGXtT0yBnPoIifAokrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptZTFTCBgZyKgR3fS+GTtpc6t0adH4DI/HHOiSvxUXg=;
 b=iJArumy80ALiDItPoyBlKlrIo8L4bbp0q0BfDiDzaTv8exn7fM22hVWR6+5oezLSKxzqt4KvxXSNClPfZiIkwTxv+LytTmWgxZEa2dRErTFXy501NYDpBYRvJoRRt0EpGEyBfob+ZObIOE/QJ050kUq8dp8sZmXpZEDLGS4UWh/wdzmVl8zRalHsTdciEriIsyh2Bo8uRgvqJpc5MWB+i4mKpaF0GRzzSq9Ak77oyjzeuYwQt4J1W4LswkWdkG83Ixu+PtdoaF4Sj/lSuRj/ZNBpUA+OC9UddNuA+b0a4ORn72r7OezytK+imuQWHHxrsZVtxmQKrLvIeUdtwsKgsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptZTFTCBgZyKgR3fS+GTtpc6t0adH4DI/HHOiSvxUXg=;
 b=zqzdKzTaanxWUi+fGeEKbRMLkLjt9uiifuf7jnlUUUGFIlDY80vnWl/ZB4BZ7msI8yhV4/RFMHcikgBl1Y7FGCn3yIImSoZ4rSc+4lYtJxNV6ElqlTWzGoAM5mbPt2n+XjR7dNZ9PSRTjHy7KTNYOfMw3Q2112w/h2uZyDCBghbi7fdwm0yWVCEs+Az40KdVFzWrSviQUunKvWcOeB87S0ZsVXO6+JRimqWX6onRsXF88arSjHKbmhlh31esAZzG2tDEXoSgfPE/cDmjRF4f9J4umSxnRJaM2rPYM2iF0fa7/byJ4i+HQa3KMRLOKlupBOo+KQ/ev6twopDRyQfivg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 12:41:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 12:41:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] selftests: mptcp: update userspace pm tests
Date: Wed, 26 Oct 2022 20:41:14 +0800
Message-Id: <20221026124114.24816-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dee7d60-de92-4e03-cba7-08dab74f6194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oM0uZBOewEt35UwbHg0BVobqWsd4E/Sa4mJYkpkHcT7f3nM3dCyHo4uShk5Ho8cPQjd3Q/w7HU4edTXrlULySo/K709OHQicgw/L+HnekQz8FWBphYDTxPmAP3PN3lBhJGJTTn2NcYwG+brt5nDoZ84reoaj0tn0goWRs2EK6EZDby3ytG6PVpszWY5q25f5O5bzmO9sLBT8/dw9+SzWf0A6KNUU0Y9/NDFVfc7pN7Ba+1E0SzdrVk7218XAtNij+zx7nR3Z5I6bKkvVeFahU6ahVsJ2WIrM4eKrHAQUurKDN75MWpFBx5y7fzvKUrunOvUWefCpiQUHA7AHNZqLSl2CjagyrS2p1/IAsutGUMrm2GgHK6dTg2s7wuM+pcSYTytYsroF0YDYSDGII6zNtYuGFrvtpqPKeOlasLDpHBn3tFbMz4YkyNVDlOZMpg2s2VlxTYgEHVGHDvKWwkZu3DGpqXyAxXJbqq+TaeWrBWqn2F2ckn2picltB4Yh6xemTjixmpAG3tgCttmIyf03+uJCSEibJMIkOSRKveXqSc+nvEzsnD+D/gzeJlUkRTL5ggcr/MDEkiAjdYRXNKAmYsW0MQHtjMzITxxuuErGT+m5TGuGXcPbxRQ4cuJjm4dtngrTNpbffdA6X670Jpv5M23lElD0C2aMbMQhT5wau5KIXJGWIMkvRfo87it0vjCNap7zMiYnhmO5T8teoyI5sgyDWXbhAOQAnYF4Vh7n2Pfy0fZPilWNwaJ87vxfV2N4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(66556008)(36756003)(2906002)(66946007)(4326008)(316002)(8936002)(41300700001)(38100700002)(66476007)(44832011)(8676002)(2616005)(5660300002)(478600001)(6916009)(86362001)(83380400001)(1076003)(107886003)(26005)(6666004)(6506007)(6512007)(186003)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0WGFCLvJM03lEg9dgXqvD4f53d89x+G6ByWrOb0NOaM/tkw1oBm8im0BZkAO?=
 =?us-ascii?Q?kPfNXeDo+IFBXnf+dEhl1hhfJXI9oehpNwR30uuI4Iv2vtzhfLl0Tek8+gsK?=
 =?us-ascii?Q?XhBOGySByMIsq73od4bZqfIQUFF2pdUxECBszfhvU/3363VfZDVMaIEI++MW?=
 =?us-ascii?Q?6X8Km4RayF6Bm0UoEw4sSS6sBJ6A4FveFvOnJv9/ABTNT/dxQXTXS+WMVRsu?=
 =?us-ascii?Q?XnokfcSp4TyMzG5fRujBdCXdw2M89FyzpkZTJ+c54/4NyKTD2WH6cB+fU5n7?=
 =?us-ascii?Q?NuRlHBrurMzL56sH9E51KSV4ApS3J55gXwusy9HQ6Ajd/Syzi2ep4O9oZuWS?=
 =?us-ascii?Q?RMepS9ay8sOmltn/ZX8jIvVb+JqZRNzn8vcO0mqzTDm6nIUl1zV7aUqkCZTl?=
 =?us-ascii?Q?TxyyOcsASqFdowwEzoNZdwp5ZizkZdaN9kw0f1qDyjMuS+pwz3W5oIyE0Dc3?=
 =?us-ascii?Q?BP0auVQlzbiCFXZQvQv3N2I1eF6uAzGiOVTZe27hGREboRqmuxgyIq2kJYC/?=
 =?us-ascii?Q?JxM94PLuYRxRkC76Lfxj0vaHU9xDprAyKvwblKD6fPjmMvg64RHkFNSJkzfg?=
 =?us-ascii?Q?EDrPVLTNnAZ+WGGUFGr95VEYjrGCRBT3eQBPO8yMzUd8S0IrMZm7pHvzu6e4?=
 =?us-ascii?Q?k9AxQ/0b6Y/h62LmMf99FwKF/eyxkAHPm7k+9V8zYwmsZxHqWjEiFVzapeA8?=
 =?us-ascii?Q?Md9shpVhWcjB6knX1u5XEs56JjNWSfW7us06j+2mL0FFGZERvrxpYX2K/MJz?=
 =?us-ascii?Q?CGPG6BzCQk6o/GuKlUPMyWffQrf4IIBvk/tTFLt7rANxJ60zglzf5ZV+hKa+?=
 =?us-ascii?Q?3gHZH5lGClAzC6PvKGl6WJy6JPmMTG27j0/smpIIv8Tzrph8wLnmquB06h7Y?=
 =?us-ascii?Q?ktW1xiYhJBUpfcKk2jHJDfRN37dqt/Dqpmd+OzqceO9tdOJ4RL9VeTBuEKgQ?=
 =?us-ascii?Q?QMvpbUl5nKtMip5M8sKENSl/XnH1nfrO8Yh5YRHrwqx90vLfff82QELpAJy3?=
 =?us-ascii?Q?qAgNQGZA117KWeQ87XXYNVXoWNLEDmOJwxHYy+HVL824zZ8STovamZWwXmsJ?=
 =?us-ascii?Q?xuR8cPClI+LRg7mIMPd9MO5ItQPEktCsIXLBPMXIP9u5h4JxWV65Qyoyl9Hp?=
 =?us-ascii?Q?RxoYt+Q/ZEO+OyJJnyqc9Rh63nwb/KJs6ySZZMOotUE3m1WSkeLRhxMe7uNZ?=
 =?us-ascii?Q?PldfR/wAGRHwO/C7AhysgSCbA2Vplmna4RLu/9u5Xy19Ntums32GfV9nBIF/?=
 =?us-ascii?Q?Jfvv6lL2ykoEPKrtMAUR+TXhhFmmW5N3WYGNVkXhz1uh6PHXamfVbh/EbW1t?=
 =?us-ascii?Q?QBR5hmlQSNPzbpUDakKA/gw+LPoCpVGi6bU/lxoMa7mOTV5ahrc717xR/qwk?=
 =?us-ascii?Q?HnSAi/NrDmu87QDjmSz80dtKSjJ7MXuFZqnEhrvTjGaDjHGAh2lP6ssqOiAo?=
 =?us-ascii?Q?U/0JpVM6/XaHsehEDA/IQUsa3J6+48VJ2RfzTM0mGcZPxwshw76dRiwwEiuC?=
 =?us-ascii?Q?sLXfCRgVWrLduFgBKJdccYiL7vy3S2vLyyM3vM0FHZ68clWYu25JNV27PU5x?=
 =?us-ascii?Q?r1m7XwueVcbN8p/Ej892CzNfYS7yXW70gxWEcHwJnMroKwM/AGO2UROa2y9E?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dee7d60-de92-4e03-cba7-08dab74f6194
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 12:41:19.8005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgqQqCzZmxErivqjWmHOx+Ym53BZVRe8WWJ/T6T3RK7i/tJSBaM2TWbzMECneyhRELWSMylI4aIc256n2KxZkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8582

Some userspace pm tests failed since pm listener events have been added.
Fix them.

patch 3 in "add pm listener events" series.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 3 ++-
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 7 ++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f3dd5f2a0272..763246eb16cb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -829,7 +829,8 @@ do_transfer()
 			if [ $userspace_pm -eq 0 ]; then
 				pm_nl_add_endpoint $ns1 $addr flags signal
 			else
-				tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns1")
+				tk=$(grep "type:1," "$evts_ns1" |
+				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
 				sleep 1
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 3229725b64b0..856ff26b6ef0 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -172,9 +172,10 @@ make_connection()
 	client_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
 				      "$client_evts")
 	kill_wait $server_evts_pid
-	server_token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
-	server_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
-				      "$server_evts")
+	server_token=$(grep "type:1," "$server_evts" |
+		       sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
+	server_serverside=$(grep "type:1," "$server_evts" |
+			    sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q')
 	rm -f "$client_evts" "$server_evts" "$file"
 
 	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
-- 
2.35.3

