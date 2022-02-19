Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5357D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eDFf38yVs+fnroJ77VArdIC6sq7WdXiKn3HvTmjPgG4=;
	b=fse0cfjkz4YLZkiDhsuMalIAXVG6b+Hzn88UFTUV9Fa/x5B/6VaEFJPSX5pmbPFNNF+Uho
	bYaaARQFqzDGwo54vY3GPQv+sF79puGinunCCYaBQwTOr8AxKtYi4eWnYwvmPrSwSNRJyY
	ptDtOIltIM9yvFaF1+4F1WhgEpZlNBQ=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2057.outbound.protection.outlook.com [104.47.5.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-APzA7CJ9NieFbu9kDXgaug-1; Sun, 20 Feb 2022 00:22:02 +0100
X-MC-Unique: APzA7CJ9NieFbu9kDXgaug-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+lcBmrA4ZznrKW109FhNFCDruIiazXV9S6pSSgdgwQFv4KWayGwhXlMKtWtFxUsV1mxVcoPap5YLp9zS/WLII2aNaqMoNQcfnLzWnPEuO4RI6KunaIJTH88k/x+RFsVamBbRquRPs+poQhFo+sdKnR5OJTfBXQL3DbIgtdJl4vFZrBb+yE3g1Vh9iVTqXjkLH5ZMfH5QiZEejEXJE277mZxJ23Hafyr3ieIlg+5PwiAxWXV7MWkWm/nM1iygpJzrwo/qs3Lm7cTHatergmCQZKAEYtA1b/vAFpU2RbVY7bd8/RCc7TZb4HVaYWqxhglm3KHc01GD1EUmu379CNkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbzQJ4MMOd0a2SJ2/9lDPQFtYW0Nl50iulAsByUFh6A=;
 b=eE/eGpcAnAQnXqF7OgMc6DCIWNnhoJQvbtWUVq5owyRGJgYyL4sEyULLFHP7v/FQ/SjP5aHo3eNyT5nOL4kZN31zDoJDklVQZGjGH6LpSq5VnP/KtSxP6zwSoPpbei4/1eqmE6NP7mr/iHovspetSf9yJcDkPd26hDg1SE6wdwvjZcWs2Qupyc2x+k7zxfkHGUOi1PgiS/i4WtqylrFBtLN4kjg6nX8jO9wbAHDYLu1jXBF9FywVaa7kKtxK+cVmPtw3kdQ3d6i64Z3VNUdKGsmyKwsa6/pbBV2wuDU16a7ipJOwnK/36daGeQdHE3mF3GYgibUC1qA9lQCOmfhQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8812.eurprd04.prod.outlook.com (2603:10a6:20b:40b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Sat, 19 Feb
 2022 23:22:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:22:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next 19/19] selftests: mptcp: update output info of chk_rm_nr
Date: Sun, 20 Feb 2022 07:21:34 +0800
Message-ID: <d744eea11e56c01a62bbe77f670a91c77b545f18.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645311956.git.geliang.tang@suse.com>
References: <cover.1645311956.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0190.apcprd02.prod.outlook.com
 (2603:1096:201:21::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47d977b3-03a0-48ac-cbc3-08d9f3fea1c0
X-MS-TrafficTypeDiagnostic: AM9PR04MB8812:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB88129CAE1BBC62D7FBA3A5AFF8389@AM9PR04MB8812.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JuTTekpIeE4tykyZsQ7/P4EYvohTJzLVThQ/2Ecu7OEipES3eS4fkgEC8PBeiq14lJV3SErq+FN8gwl3mgVUNQNq46UPAZFp6J87+IAOdMGrep1PSNOZX+UPLPfR9T6psemXhv2Y/Uglc2GrgpZe2jIOQ0IeHW9FEhkikEEMsn8dN/in5nkh2x7+qXvUg4s8xDUJpu2+PM+JejN1C0h2EA6iWcssGhSysVBeUaOeI+6eYTwKG3SYQYSl5QBRaYa9xrsFbJpc/5zrn3WIWLF9M0KXZL5vGCDkCoy9y9QVSUz0JSQKAz70DcXpB8dTSNZjAGnY1zBPQAZu+IIc9xxh2BYlG8udUnl+oTFF0fjHKkUa3F2ZbWflVSrfwUcLD4b36MOwv66vlIuQvgabld+fDR9JtYSeFnrqNg0f+4dYmjhUR29WA1+asixehqBF4fYIf3oXxmTTQbdcW7Vm6esiMPozrk78iwlaK8N8ussXO+hE0sgbjgFTzGtqwr7qaKImWsr+F7n+sGydIcN9DXH+/WJHIa3HSAr1nZVgGg9oSjLucW3eFFCMwreASnYPctWLzPerPEQdOPLK8a93+SLEDdkZviZntaj2c023QknVrKQyUs+xMToExwP0DMb3Ie3/wy846u5MdU+arlIU68Qedw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(66476007)(15650500001)(6486002)(66946007)(66556008)(4326008)(86362001)(8676002)(5660300002)(54906003)(186003)(8936002)(508600001)(6666004)(2616005)(38100700002)(6916009)(36756003)(6506007)(2906002)(316002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zkCr3yT3mcT+QkkfKxFON2tA6p0fXOWn7IatCtVbK2wGAD0UDNdQYphrOpx/?=
 =?us-ascii?Q?gK6AgBbUozQ0JZ4SnnOiPOWYAyO6yoLXNPmH9aL9/9rQSNQdgUA5ByoKoF6G?=
 =?us-ascii?Q?KkDbt0TbHiAzIfIJLByJUs946px2JZJzsuqvz0VlGEI/LXJoJFDj+WSFF0Jr?=
 =?us-ascii?Q?Pwn59B8Zy02Vc315gI6sh/dRqigd4tPc1Yvg2/VllMXloWP1zLnbGbHXV99A?=
 =?us-ascii?Q?81CGLaAHMYJxZVE7qrY2OWtKDsL3mX+rZaoWuw0YcH5W4NyP0yVtNN9y7ecc?=
 =?us-ascii?Q?EyYFEamfKmnGyGnsSJoSjpNVgWMpqRg1U6cO8I169qzd4BgjXkiGTgE13YBn?=
 =?us-ascii?Q?gSEN6QNsN20b44eydGKBEg4kAUAERrPZWqxWMQtDdHzNMiDgC6E9mmGWDUMd?=
 =?us-ascii?Q?kG2sHsYcw8/abhDsBjmUlYkOcaAk4XCo5B0Gkbrq9YXxuDsNY2pPHFg83Dc6?=
 =?us-ascii?Q?NuQfZlgIzxDaPCf59HFgeWmo7YWpIhV6R5EnutkZfnvIQhQKM/RlB53YcXpy?=
 =?us-ascii?Q?PbrNZrzdtcgU4j56E17oAIZ+gDqWN6GxxTnp4yzBXFGU+JswMJVNqWv9N1rC?=
 =?us-ascii?Q?qPdM0CnzX7eFpvO5G0ewgOjL3810tFY4S1CLcU92F3fA51zKYDrIHgGkQGKN?=
 =?us-ascii?Q?2CP3oKgHc93VjcHoO9w0zbEPlat+1nlEar2pZqPEmSNq1ASFuIuUtkNX4Bu0?=
 =?us-ascii?Q?U0QLsoc36IRP8KtOlYoOTIi64ihTWrZdEkmaPBwO8AzLg7/FC954ROpin6Rj?=
 =?us-ascii?Q?3HB5XVQcheGyBP0ebPxfAYidiTeSFjY9A8TduMUuan6XehZQvEAhrbkGbObs?=
 =?us-ascii?Q?wf/3VlX/m383Wu4soMj1zt9Mp5xIVGn2b86NWBHNDmu3+4F5f/GNnzHtp4uV?=
 =?us-ascii?Q?h4D70JgELL1AR6J3jr7bJ1Csif5gthfkcx7SfTwTW7LaV7t2m0FZD8UU5PJZ?=
 =?us-ascii?Q?ZHkkoDPmhR/B63ghu/7cl675faB0Y6uYi0qfJv7hKoNqowhPGocf2ompDfHb?=
 =?us-ascii?Q?KNZ9WpijP3R6h6M/xhWDclDmY4ZjSXZEYGNNakxQu3N1+m5USo7Ns8g/EATB?=
 =?us-ascii?Q?Isztur1dowc4212JW/TRjBE/5uK+iQQ95/bFMfUoQWInjvlnHbVQxz7XDEvX?=
 =?us-ascii?Q?exnnC90v3vOrSPHLJC9O95eKpthe+qAY/fRsGutJyBTcidELo7CLePP2WDyT?=
 =?us-ascii?Q?5ss/334A0mxEsbnuJf0cKjFjhyQBCJGlafAqeeG2IaNQ8umQ3wNfTNJZuJfL?=
 =?us-ascii?Q?Nqy34Q7npxS6cBHURDzO+fAg+d1L1Eu2GW7SUJZ/nN4Gkr5tPvr/Dsh78eQd?=
 =?us-ascii?Q?QSHnb4eGuzuy4VlJ4RwgWAOI5RJEC3avTj7QVZe76pM6ekORiYsTcaBq5U1b?=
 =?us-ascii?Q?EuxhBNBvrSaoX5n4UHbS+tSfpFFFjqNtyOcMm7ESU+d1y+y+GKWyI/ENDE0b?=
 =?us-ascii?Q?s6Ub9Qffz/NrKHb9i5eRFopms4w7pdKolICifY2WXb5lrY04PYmYviDm0bHN?=
 =?us-ascii?Q?gQwAHyZrpToDkTcd13sG/VgR3CEVpQkuPik9JI9/ZnJ1h3s86ThONuuBsuQW?=
 =?us-ascii?Q?7O2oFxvJeWSNOtIywOHGKqd+VHWdUIMuePmVZ3RHJpR5dZWrHArSc+tUpwy3?=
 =?us-ascii?Q?KAy7cFbd+1EA7OtITi/yYPbmceSjlmK40SO4K/W/58EC4lzyC+LktcbzsJWJ?=
 =?us-ascii?Q?q0baxQgC4GmdQpQk6eM5f/4/FKA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d977b3-03a0-48ac-cbc3-08d9f3fea1c0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:22:01.1426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joDUDQhKgufZqHBm4S3VrL7YYJem8Jb2SbtxzpsN5TutM5qnoh9NQMw1i8zHFkHBqqLN9BIRI3sj84H/KgajbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8812

This patch updated the output info of chk_rm_nr. Renamed 'sf' to 'rmsf',
which means 'remove subflow'. Added the display of whether the inverted
namespaces has been used to check the mib counters.

The new output looks like this:

 002 remove multiple subflows          syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       rm [ ok ] - rmsf  [ ok ]
 003 remove single address             syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       add[ ok ] - echo  [ ok ]
                                       rm [ ok ] - rmsf  [ ok ]   invert

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 6fb883971d46..3655911667e0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1312,15 +1312,14 @@ chk_rm_nr()
 	local invert=3D${3:-""}
 	local count
 	local dump_stats
-	local addr_ns
-	local subflow_ns
+	local addr_ns=3D$ns1
+	local subflow_ns=3D$ns2
+	local extra_msg=3D""
=20
-	if [ -z $invert ]; then
-		addr_ns=3D$ns1
-		subflow_ns=3D$ns2
-	elif [ $invert =3D "invert" ]; then
+	if [[ $invert =3D "invert" ]]; then
 		addr_ns=3D$ns2
 		subflow_ns=3D$ns1
+		extra_msg=3D"   invert"
 	fi
=20
 	printf "%-${nr_blank}s %s" " " "rm "
@@ -1334,7 +1333,7 @@ chk_rm_nr()
 		echo -n "[ ok ]"
 	fi
=20
-	echo -n " - sf    "
+	echo -n " - rmsf  "
 	count=3D`ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | a=
wk '{print $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$rm_subflow_nr" ]; then
@@ -1342,10 +1341,12 @@ chk_rm_nr()
 		ret=3D1
 		dump_stats=3D1
 	else
-		echo "[ ok ]"
+		echo -n "[ ok ]"
 	fi
=20
 	[ "${dump_stats}" =3D 1 ] && dump_stats
+
+	echo "$extra_msg"
 }
=20
 chk_prio_nr()
--=20
2.34.1

