Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635222C80
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 06:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644472822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1cnhmfvOg1lGapreID3J2bgUAhluk3TVZnCBFXpbmQ=;
	b=IIdLNF8i9USxyYPpurEuF4QFN+z42kNymTKgCPF6vzyf0SzE7w7QVKcVrvKaUWWSYOA9y7
	0QI4Gaeep68KRtmhIL0n5yHnBMV+P1N0Z7AvM0y8L0ykgNXLI9w2vEBRQNjCcl732IBvo7
	4+C9joWtD1tkWIdZ0ras2EiE2LzDzc4=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2058.outbound.protection.outlook.com [104.47.4.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-ryZFHKI4OUSyYJjFunXj2g-1; Thu, 10 Feb 2022 07:00:21 +0100
X-MC-Unique: ryZFHKI4OUSyYJjFunXj2g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJTxAo7GBptbbkNTEvKwcQYY9tl9l0h3PXVb+xoCurIII0ZrQ7ieAg6PnZ1pGaLS3b7r3YmXseju8wunIDKd70yKPCjPJObIK7bdqYG1Ylo0f7cYsSA65JYrrHNVrQoRZ8TfkcdBLw9JfceyTAY4EZagFsgmzKatnkhLk0b+J7ORAX0vhEANfxYDvBxcbSIVUqqrSh2DP94ZsIiF6ewC8yt8XV4SsJlLZV5AijdaiUpK7PUyWF1eqCkEQJark/3jepjsIMCgFbHOj6wsczU1zr1qJ3JdWVgJwGOeBmZkC1WRcj9KVCtgrZNE55KqgLXH9sRzTOjh+98jlOOo8wjyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llTAtFlYKBFVPMj2ywwSufNYjArxy/q7XOS0f5KZK5o=;
 b=h4zhhxadKBhwpEJ5Pz+DBqaXX86QsyxzeICFcJe8EWhQgOgr+mkX99KHVupT94v8qeJLwxCx7SUqGFoZnwUl8eUwDHrSwkzmRtrBTsW9qJXkvYHxkCfuvzlJ6s0TCMIaIZXYHIkA3iLiIHAmlce0SJ0t6blXXks8ngXrbrqQcs56ELxbIEclB26IkdcQvGHDPx3Aq3RtGyDfDPv+tNOxkpD6EVnU5kgyVNHTEhUSjTrhUVz3TBOof7Rn/ForOqy75tFKTOiR9uavXS8mCkWvEydG0AziJTI2kJGKfkDh8nn5oCGSuVwuJ1JE5sfdWhOg1Nj0obl/Bdj134SeU1ePJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5761.eurprd04.prod.outlook.com (2603:10a6:208:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Thu, 10 Feb
 2022 06:00:21 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb%3]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 06:00:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 2/7] Squash to "selftests: mptcp: add infinite map mibs check"
Date: Thu, 10 Feb 2022 14:00:26 +0800
Message-ID: <d133ed1ceac1bd9ba3b55c9b9601cb3d01b6d7bb.1644466571.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644466570.git.geliang.tang@suse.com>
References: <cover.1644466570.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:203:b0::33) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c711db8a-b109-413d-d118-08d9ec5a9eff
X-MS-TrafficTypeDiagnostic: AM0PR04MB5761:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB576191C32FE13BE6B9E2E93CF82F9@AM0PR04MB5761.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9BKaxU8JtPIHlCPbt517N0dwHw2gkU/zTJCpJ7RnoCNz33jjfsmoCu3AJWC0fX4y44Ct2fW3mJ30IvjJSFXb7GfORmCDzYWOk4YkFU/Y9Yk1VSPaegsjTgVaqwX4Yqk/uhDeCFGrxoUW0fYAeinQVddCS9if/UA0dSVYgMoj9AUwdUxvVirHBZRD5tS4eZqEwsI/pWDiZSROZiB+ZiWQBWBWbsdvCnrGst0yOCs9WVJdb/1GgKIIOZ+zJlWmbr7w3Ponl7RrZq7NPOGWw7iiC19PKQe3BN7Om8AFGYofpifW96M+sYpONTWM7yAitSX7zfxsVix6cBiB5s/uLIjLDJdIjTwPeQdwKX4N29dmaF0rRqj2eEoUSj0D8kNVKLizwwxeJHWLm7QnZMA0thN9rMHvzsF6Trwt7aug2D6u3tNH20/Tx6XJfNklbBOzChUjqQjHwPpiIf0mUJVfqlPYeIJ60wg/EyO4joE/WpL7zuGLMj+n7VODnYbeXV2KMbuegdHoTkMcMCBhPKawHmh1vmOucaxzMMVp8LsOOPDXTGBLz50hHCbTvar+sFs7IqqwB3PvZ+7UuVc/BXyIX0dW+AnJdDZ2Mgy6O01Zaob91ruNpMSpG526Tr134c9JYLWpSCmH4Qkxo9c9dZHqb2u3sA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(316002)(36756003)(86362001)(55236004)(66946007)(6512007)(6916009)(66476007)(66556008)(6506007)(8936002)(8676002)(44832011)(4326008)(2906002)(508600001)(2616005)(26005)(5660300002)(38100700002)(6486002)(107886003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oArnEdsVcvH43tP+j4GSBwuDPH20iMYbXmdCbU3WX6qGVFc+K+p4rWc9Oj7U?=
 =?us-ascii?Q?yaa37zMMFL0amQWpLR5YcPdD+qZC5pC7STZ/L78cj7/zEnmhv+zz9U+nvxcl?=
 =?us-ascii?Q?qP01IS+sCnrrbCqDnLtwJkvtjv0Z7qnJzm/C+qNVbgrz7h7gxASsM9Y0YDPH?=
 =?us-ascii?Q?d2yiDI9yozRT6j24DtUZZ9MeIQmQWsKSI71FICf74cFKzoG4bzwwthXFTRcP?=
 =?us-ascii?Q?QifuuuMPzsS419RWOh5xaA6r6ZwPVjzsZRZRc4XB/YMNlF2PFLuuAkGC/FNS?=
 =?us-ascii?Q?0+wAOuqn2K8VtZTH1JlNVs88fSASNE69Y3vlKnlIf7PpEPXW5c2VtJelOSKp?=
 =?us-ascii?Q?SjF+ymoLnHdcFKxKfh+2zL2vASX+m+NcmCXionYCqhWpmPTDRuH9QLHkFfS/?=
 =?us-ascii?Q?/0kOM1PNtixmBSDSwQYUAh+4toZ/eVAcuFbk8kGvJKbaSDXMFxnu3Zx48Oaa?=
 =?us-ascii?Q?3uPGwmCP5XTenYcjQYKHiy8Q8y9Fn8vvE3ZjkKk36WuCyBgwo5eOsiNp3kEk?=
 =?us-ascii?Q?TDcrBR7+qFyZ0QOksWjt7tOkcGCqMkjPzLR+PitbuQrDvIT609HOlE/QApjc?=
 =?us-ascii?Q?2MoiWSZMcKj+vFwyaJek59D4eTpQ46a9p6eYR7dMzryPZL1NQ/rgVJDBhBkK?=
 =?us-ascii?Q?iZwGu/m2yiErOQeaPR6Y5JFf4qBFwAzMK7eRzZg167xhz2J8BJmDG18Uhy/U?=
 =?us-ascii?Q?bN3kDtOJ720+n1OdSinTdTO11Kd+rZUE0yikUYgprd+qX2AquGeRtczC7mZ8?=
 =?us-ascii?Q?8F+cqPN7oyENa5aJZmxQupcciS7S4HH6ZdkAYzMhlw1buNcSM2+ZY0LK9ulb?=
 =?us-ascii?Q?2v/Inpd2U6uuG5OVhrDukdRob910D7R9LtqKf4TqlOWUotHzXTc31+cZvUY4?=
 =?us-ascii?Q?l4ETI7RQG/K/CVyxXZ7CgXoH9WhPJ8yc34/5gWwIvauEOR7Sosx3GFZeWo/S?=
 =?us-ascii?Q?SgcoJe5q1hcLaobnuYNZV/2npEn++oRSbAjZl8nUmqfMQCZETvcpM+NMd/xX?=
 =?us-ascii?Q?06GOqFhbXoYKGAz3bC4jd0uUI0DMQFYzcJk4mCQb6HZA72p1OaIFlIFC66ia?=
 =?us-ascii?Q?XhyeaDBoOGS5kl28E7EyCyY37zSz12IE/2gbxg3M74AyrcRovHZlKZOvfeSS?=
 =?us-ascii?Q?SvXupkIOvj3T/ft/PJZC7w5E8iIjushDyOYWDJ5XTfo2llEWx0tIJN2BPMSJ?=
 =?us-ascii?Q?WIHJe4CcXze4HwGIFH8K6KBtB1ZHrN6lPzYWuxhDhnqt3onnp58m2RZfeqfO?=
 =?us-ascii?Q?7a3uG0QtKsfwGapt1+0ogxBA1xcjE1urZvYvfE9f3sunsR+hjAl5axrzwD3x?=
 =?us-ascii?Q?etNIvHh8N5ssMmmeIIOSObu+7mz2C5cP9zhs4IIapNeI8m1pc5Kv6qmhmsan?=
 =?us-ascii?Q?/x+IVOV6+pKZho8S4MIQ2+rTmv/i7Gd5ltVHTjfNilsk4pmTd+Vs+Gan5PeP?=
 =?us-ascii?Q?fJbE54S7CPOQO4Zg4BWD7TKEj5tfSGp7I5AI64KbCOMYJqNVYXefzh/kNzex?=
 =?us-ascii?Q?8klHwrnLDBE4TiwDeubYy9UwSP9ttcOZ4+gKsfo2ioaGCBAIlTR1RWx6/ngy?=
 =?us-ascii?Q?GnX7tz4zIfe3wA4R7T8pk5lnnBjU9FoaAkIUa6RMaCjw+bEgLw+ucMskgIvM?=
 =?us-ascii?Q?gl4rXYGsmMr+R7FMSj82aQ8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c711db8a-b109-413d-d118-08d9ec5a9eff
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 06:00:21.1069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nYLmEwDWorVZX1nUUX6zTl+mr/3Q4pfTrzO7OEBWNUcx81hT/2BONWNn8iTHphrn60XK7fyzfBpSAUjQI73hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5761

Rename mp_infi_nr_tx, mp_infi_nr_rx and irx.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 90a6adc36490..3577716cd5e6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -784,27 +784,27 @@ chk_fail_nr()
=20
 chk_infi_nr()
 {
-	local mp_infi_nr_tx=3D$1
-	local mp_infi_nr_rx=3D$2
+	local infi_tx=3D$1
+	local infi_rx=3D$2
 	local count
 	local dump_stats
=20
 	printf "%-${nr_blank}s %s" " " "itx"
 	count=3D`ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print =
$2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_infi_nr_tx" ]; then
-		echo "[fail] got $count infinite map[s] TX expected $mp_infi_nr_tx"
+	if [ "$count" !=3D "$infi_tx" ]; then
+		echo "[fail] got $count infinite map[s] TX expected $infi_tx"
 		ret=3D1
 		dump_stats=3D1
 	else
 		echo -n "[ ok ]"
 	fi
=20
-	echo -n " - irx   "
+	echo -n " - infirx"
 	count=3D`ip netns exec $ns1 nstat -as | grep InfiniteMapRx | awk '{print =
$2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_infi_nr_rx" ]; then
-		echo "[fail] got $count infinite map[s] RX expected $mp_infi_nr_rx"
+	if [ "$count" !=3D "$infi_rx" ]; then
+		echo "[fail] got $count infinite map[s] RX expected $infi_rx"
 		ret=3D1
 		dump_stats=3D1
 	else
--=20
2.34.1

