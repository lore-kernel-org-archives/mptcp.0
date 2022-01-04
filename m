Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B425C168
	for <mptcp@lists.linux.dev>; Tue,  4 Jan 2022 10:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641291110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXqmdpQhF9TsJu6DU4NhEde2wUVF5wVoqcNmFMKfK6k=;
	b=Eq8FP+Q4nbq5CLtoPvJDWuTUnYv9tHVxSD+O287uBnjzu2+DeETzW+rscFvWoAB/NoGcpc
	3UEXRV5dGcgl4fU7WC0t+c3e1iOthYvhs5e3rrlhnr6iqo4jWDcVbyw7s2zE+G/zJtK9OA
	umJ/4MPbRdSnKqbK6owv9btsK0JxIgk=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2058.outbound.protection.outlook.com [104.47.6.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-84nDgNbgNNu7b1Ds9vPC-g-1; Tue, 04 Jan 2022 11:11:49 +0100
X-MC-Unique: 84nDgNbgNNu7b1Ds9vPC-g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5jN1bGQqU11AVeGOShbpszN6IvSosKcTUpZRncVHlcquIzesDJDxypHmhPYQEQGzCXlgybjmfewqmsrwtfavnK4xYIJ8uKdl6aW5RiKQUCJL9YkBi3YGIMEKfPuS+Lvsl7bB7TcTVUK5J18acfREFJcOxjh3vcmYjOwPLKt2vjx2J8DQH7U7j4ZBQnQdMggjD0uI5Hja8E0EcNBPSk1IfdyuegqUJJt5EF7lh/X5hciCCeNAsdFt9jAs5hvrDuhW+VDN/VgQ5R3gKoKizyC5gpRDFZ96S6ijrZInNGowbx57xHYM/CJfcOGwrmEemAHP5keV5QZoRICNVsHHtN2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6pN6rfE2S1EoCE+9gvoL01WShYwecDufpFKEK9HCCg=;
 b=Iu9IncQLPatpPMtfRqdleb4CacX/kUA0f5UXh7LdXSjn+MwDQBQAP3MGNcUVFj0N2JGAf+X9pj1hyXuVlwF6Tv/ak8m7G4YVlS+Pav/H6r87TTuT3bhOXXs2YrE9n0baxNSfx2AF/FNlpyxZdoMAJtP5uAetzcfgEuTKBuSpEvpgk+pJhTvFxwLonlxxZ7AHHcCcFnXyxSQ/7aYbaxaS1P54lVwATLSfT2fgXqQn/QrztLszJMMyPrZvWzzADNH/BNrmgLm3vqhtLITkeWDE8IFb6bzObSQSzU1nvJjNBOf2B2Qvt4FdvlHX3qIc8pR+Srtg3aSXXcdPsha4H7qW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2540.eurprd04.prod.outlook.com (2603:10a6:3:84::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Tue, 4 Jan
 2022 10:11:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 10:11:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/4] selftests: mptcp: use 'ip mptcp' in pm_netlink.sh
Date: Tue,  4 Jan 2022 18:11:18 +0800
Message-ID: <cedd4179c8c3503a47f78f303accdfe99473b0c1.1641290905.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641290905.git.geliang.tang@suse.com>
References: <cover.1641290905.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0203.apcprd02.prod.outlook.com
 (2603:1096:201:20::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3de81546-33d6-4f35-3a03-08d9cf6a9e51
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2540:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB254033F3AC384AD8C60C6C2CF84A9@HE1PR0401MB2540.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SSH7gvSgs35RdnbSUWFcfbzDAXhg8fyF7KhdTSLI9g+c3RM8qjUmbVco3aoWQUGwzmvUaakF3X+ZfVLWMvl5Asay4dOHxgn9Wjst+IZcKEW3tGbvxyFD2HLxGwchHZm7ifoNURpUl+ATDX434X+9hKOgR8WfZB8kJmHuQlZVTf5Uavo+6FaWCAZLuqQd+VlOj8HJE6CFDR+gr763XqxTZwvjX/SO3WuA87Mym4AtrATJF9HbG865jNCueADhfV9IBVtM1ewPyHZVF+9Snu8qbl9uexovdyV8A1EVFT0sM8MRtTzgxuq3eEl3qjTdkyWM8gDYvkZ5+2xWAbIStokw84lLlBB6Fl4U10Sl9eO5SQXL6SeikYh30SlxCtUY+/AA9ZhYxnNvWJ7eVIYx60J+UWRem3d9M8dFIWN5i/kvx3zpVhakkiQ8O+haU+KhMZzWY2O/I5+iHRzKZ1EcKb/Ty48kxgyY5/Epam4in5CaMa9ba6x0D2b+wVFo/9+xW9/aqLI33b6YKrdacVhgiOmH+jvOtA52Gnq8qzktehwGRb1ciitFQ6WMzXn6BYXiXGqH8xbYuKyxFfm0TaWx0GGv5yEPhT25RT2PKIBvukh6ZaKldQgZ2VDqbNIB9IiLmce2YuzJQqwFEfT2puCNQJkHzg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55236004)(44832011)(8936002)(186003)(38100700002)(66946007)(36756003)(6506007)(6512007)(83380400001)(2906002)(26005)(316002)(6666004)(66556008)(66476007)(8676002)(4326008)(5660300002)(107886003)(6916009)(508600001)(2616005)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q68FzQ4rdAMLaTf8q+Q2+Mu55lC9bHuxXxuGfjlTfKXF3ajBmDGMriyxjw95?=
 =?us-ascii?Q?fdlXpKr5D1Xdqw+5+r/MlaLmPiwdj122aucAuqvPqqCdEE6en+1AP/Ggrnwi?=
 =?us-ascii?Q?6NDy1n9hLxFETx/bXH5iblbYOZp0QxPPFovhaJB00MMmbukztSKOojzBmr4s?=
 =?us-ascii?Q?zCbFjkaPfCKJizs5TgerjO909WbQYD97QYduk2ViuMw4deSpS3lAkhwoSqfL?=
 =?us-ascii?Q?iSV4VaRUBtkIzHrkixka6h9AEqIyzihY/0mHyNSitLAHrnkYtEeAcY1bI0Cw?=
 =?us-ascii?Q?QaRFoChIj+cMb3a9Zn0Ao6OSQgFE72FKFqsD6VOBDrRd05DhgprnJxNW37sB?=
 =?us-ascii?Q?75zNLTNMej+/nX0d/xpqjm3Qgt1TSq7y7csaFDiJbzv/4/t3mgL2n7Uh9/Q7?=
 =?us-ascii?Q?6HT6+legPqn6WVOxB5IUnuwhIz4ba1sZmsheGXwnvmY1OZPOeka7OvkDK62i?=
 =?us-ascii?Q?B/iKvQw3oHNV9o68ZuX+E6+Cp/+Oh8+aPRRVfhWt5GI4Bg55rO97vg5S1CIc?=
 =?us-ascii?Q?og99aClSxWo1DTiz90Jx5fJV55ocasuxef8/6mve45zipPCRXFeNn3AV1Zbj?=
 =?us-ascii?Q?QE8UmQ77sv5/b46L4uOiAEahuamYuxY3OCDOre5Iyoqgz6+A3f6k+7jLR06a?=
 =?us-ascii?Q?6EKP3eeaIACps/P1ehTxanb1zRJxBpjqcFYtRtV4raR0Ne3XbNG4SaK1EKh6?=
 =?us-ascii?Q?G6bt2PflRjWq9Di0EwL+VjhJzSaJ4FVWooVFcS46n0P17oiZJh2zeJx2Diwc?=
 =?us-ascii?Q?k3KleMAnHlN4nTv+Y5E5wBzMqLCORgpAbYCNorK7UlZXj6eL/MBPrSW54Ksv?=
 =?us-ascii?Q?3thAAUzw3BON7aGG9oMflehY0LSBvDAlCKf3Qlra8K3lrmihcSHpZ5LXu5QE?=
 =?us-ascii?Q?ycO4KQir4ehENinKpCn+evIQpJOg201QTv5yTCJmjiryVByeR0Y4325/QOiU?=
 =?us-ascii?Q?GOJnjr3WcSUcFtDlc5phitMWVfxAXYd6oM2qUkPyLSXSl6/SRMUprGfStznL?=
 =?us-ascii?Q?vRL84x+/XrQs9AUtdlweZGpWXAzaKHlYv03zCrc+l1Z5vLa0rbh9Urla1iDv?=
 =?us-ascii?Q?lII0DPdgRRvN+jknexgTb6e3GPSHqgoBqcT/aaBjQd3sK00ezE3lj8MEw5Kw?=
 =?us-ascii?Q?Qeo7PkXHAtc0JKA2/LLs1QJjFg78FVVivictxy70F9Az6JXxRODu+5IIpZM3?=
 =?us-ascii?Q?0KZRTkUQ2VrgUSf589Roh7VT6o2Kx0TrXiOHXrZDb8cWCE02jJWpt1eQ8r2M?=
 =?us-ascii?Q?7aNR+kH8RMjtvvF+WdSaZ9nnGnoaoWuqYLJXlkheTw6ivvgIByr/HNVOHRm6?=
 =?us-ascii?Q?h/dun2VXLMirheR496ro8J3LRT3yNOZ6A7S+W9rvEPpKHJLj2jO/fpj3deKQ?=
 =?us-ascii?Q?kKOEbucLc9Gdmx0YJQdYYmcGcc9T6MRYsstJrlFw1FD+RQXkNrKKVIF+qL7V?=
 =?us-ascii?Q?jOkIIJKIbRmdVrrLilxd6Nv5JTjHLoXXqknPQzmkICy2GFCnH6se9hSYUf+3?=
 =?us-ascii?Q?OjMGdEc5vq6qNBw/395jkzZ4jOdRD5kE4qY0IxZZkXaBe9/l4ALGqXFg2pzL?=
 =?us-ascii?Q?hUx+gpst8+ULu7uk0hf7tlOoXTpJEw5Gg7j4FZ0NSfLG6gXcM84B1B637Q4t?=
 =?us-ascii?Q?360nv1Q2hZDpJzLARq6o0sY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de81546-33d6-4f35-3a03-08d9cf6a9e51
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 10:11:48.1898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E49vyj4e5VGXW6YjRuZC8NbDmsl1VAtBZqgW0otWsRQSOJ09umsY5y1P9P9WEUp/hsQh64tzl7xO+yMiEqTksA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2540

This patch replaced all the pm_nl_ctl commands in the pm_netlink.sh script
with the 'ip mptcp' commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/pm_netlink.sh | 164 +++++++++---------
 1 file changed, 80 insertions(+), 84 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testin=
g/selftests/net/mptcp/pm_netlink.sh
index cbacf9f6538b..638705d639c2 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -68,100 +68,96 @@ check()
 	fi
 }
=20
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 2" "defaults limits"
+check "ip -n $ns1 mptcp endpoint show" "" "defaults addr list"
+check "ip -n $ns1 mptcp limits show" "add_addr_accepted 0 subflows 2 " "de=
faults limits"
=20
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 flags signal,backup
-check "ip netns exec $ns1 ./pm_nl_ctl get 1" "id 1 flags  10.0.1.1" "simpl=
e add/get addr"
+ip -n $ns1 mptcp endpoint add 10.0.1.1
+ip -n $ns1 mptcp endpoint add 10.0.1.2 subflow dev lo
+ip -n $ns1 mptcp endpoint add 10.0.1.3 signal backup
+check "ip -n $ns1 mptcp endpoint show id 1" "10.0.1.1 id 1 " "simple add/g=
et addr"
=20
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
-"id 1 flags  10.0.1.1
-id 2 flags subflow dev lo 10.0.1.2
-id 3 flags signal,backup 10.0.1.3" "dump addrs"
+check "ip -n $ns1 mptcp endpoint show" \
+"10.0.1.1 id 1=20
+10.0.1.2 id 2 subflow dev lo=20
+10.0.1.3 id 3 signal backup " "dump addrs"
=20
-ip netns exec $ns1 ./pm_nl_ctl del 2
-check "ip netns exec $ns1 ./pm_nl_ctl get 2" "" "simple del addr"
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
-"id 1 flags  10.0.1.1
-id 3 flags signal,backup 10.0.1.3" "dump addrs after del"
+ip -n $ns1 mptcp endpoint delete id 2
+check "ip -n $ns1 mptcp endpoint show id 2" "" "simple del addr"
+check "ip -n $ns1 mptcp endpoint show" \
+"10.0.1.1 id 1=20
+10.0.1.3 id 3 signal backup " "dump addrs after del"
=20
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3
-check "ip netns exec $ns1 ./pm_nl_ctl get 4" "" "duplicate addr"
+ip -n $ns1 mptcp endpoint add 10.0.1.3 >/dev/null 2>&1
+check "ip -n $ns1 mptcp endpoint show id 4" "" "duplicate addr"
=20
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4 flags signal
-check "ip netns exec $ns1 ./pm_nl_ctl get 4" "id 4 flags signal 10.0.1.4" =
"id addr increment"
+ip -n $ns1 mptcp endpoint add 10.0.1.4 signal
+check "ip -n $ns1 mptcp endpoint show id 4" "10.0.1.4 id 4 signal " "id ad=
dr increment"
=20
 for i in `seq 5 9`; do
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.$i flags signal >/dev/null 2>&1
+	ip -n $ns1 mptcp endpoint add 10.0.1.$i signal >/dev/null 2>&1
 done
-check "ip netns exec $ns1 ./pm_nl_ctl get 9" "id 9 flags signal 10.0.1.9" =
"hard addr limit"
-check "ip netns exec $ns1 ./pm_nl_ctl get 10" "" "above hard addr limit"
+check "ip -n $ns1 mptcp endpoint show id 9" "10.0.1.9 id 9 signal " "hard =
addr limit"
+check "ip -n $ns1 mptcp endpoint show id 10" "" "above hard addr limit"
=20
-ip netns exec $ns1 ./pm_nl_ctl del 9
+ip -n $ns1 mptcp endpoint delete id 9
 for i in `seq 10 255`; do
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $i
-	ip netns exec $ns1 ./pm_nl_ctl del $i
+	ip -n $ns1 mptcp endpoint add 10.0.0.9 id $i
+	ip -n $ns1 mptcp endpoint delete id $i
 done
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1
-id 3 flags signal,backup 10.0.1.3
-id 4 flags signal 10.0.1.4
-id 5 flags signal 10.0.1.5
-id 6 flags signal 10.0.1.6
-id 7 flags signal 10.0.1.7
-id 8 flags signal 10.0.1.8" "id limit"
-
-ip netns exec $ns1 ./pm_nl_ctl flush
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
-
-ip netns exec $ns1 ./pm_nl_ctl limits 9 1
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 2" "rcv addrs above hard limit"
-
-ip netns exec $ns1 ./pm_nl_ctl limits 1 9
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 2" "subflows above hard limit"
-
-ip netns exec $ns1 ./pm_nl_ctl limits 8 8
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
-subflows 8" "set limits"
-
-ip netns exec $ns1 ./pm_nl_ctl flush
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 id 100
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.5 id 254
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.6
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.7
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.8
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1
-id 2 flags  10.0.1.2
-id 3 flags  10.0.1.7
-id 4 flags  10.0.1.8
-id 100 flags  10.0.1.3
-id 101 flags  10.0.1.4
-id 254 flags  10.0.1.5
-id 255 flags  10.0.1.6" "set ids"
-
-ip netns exec $ns1 ./pm_nl_ctl flush
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.1
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.2 id 254
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.3
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.4
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.5 id 253
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.6
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.7
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.8
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.0.1
-id 2 flags  10.0.0.4
-id 3 flags  10.0.0.6
-id 4 flags  10.0.0.7
-id 5 flags  10.0.0.8
-id 253 flags  10.0.0.5
-id 254 flags  10.0.0.2
-id 255 flags  10.0.0.3" "wrap-around ids"
+check "ip -n $ns1 mptcp endpoint show" "10.0.1.1 id 1=20
+10.0.1.3 id 3 signal backup=20
+10.0.1.4 id 4 signal=20
+10.0.1.5 id 5 signal=20
+10.0.1.6 id 6 signal=20
+10.0.1.7 id 7 signal=20
+10.0.1.8 id 8 signal " "id limit"
+
+ip -n $ns1 mptcp endpoint flush
+check "ip -n $ns1 mptcp endpoint dump" "" "flush addrs"
+
+ip -n $ns1 mptcp limits set add_addr_accepted 9 subflows 1 >/dev/null 2>&1
+check "ip -n $ns1 mptcp limits show" "add_addr_accepted 0 subflows 2 " "rc=
v addrs above hard limit"
+
+ip -n $ns1 mptcp limits set add_addr_accepted 1 subflows 9 >/dev/null 2>&1
+check "ip -n $ns1 mptcp limits show" "add_addr_accepted 0 subflows 2 " "su=
bflows above hard limit"
+
+ip -n $ns1 mptcp limits set add_addr_accepted 8 subflows 8
+check "ip -n $ns1 mptcp limits show" "add_addr_accepted 8 subflows 8 " "se=
t limits"
+
+ip -n $ns1 mptcp endpoint flush
+ip -n $ns1 mptcp endpoint add 10.0.1.1
+ip -n $ns1 mptcp endpoint add 10.0.1.2
+ip -n $ns1 mptcp endpoint add 10.0.1.3 id 100
+ip -n $ns1 mptcp endpoint add 10.0.1.4
+ip -n $ns1 mptcp endpoint add 10.0.1.5 id 254
+ip -n $ns1 mptcp endpoint add 10.0.1.6
+ip -n $ns1 mptcp endpoint add 10.0.1.7
+ip -n $ns1 mptcp endpoint add 10.0.1.8
+check "ip -n $ns1 mptcp endpoint show" "10.0.1.1 id 1=20
+10.0.1.2 id 2=20
+10.0.1.7 id 3=20
+10.0.1.8 id 4=20
+10.0.1.3 id 100=20
+10.0.1.4 id 101=20
+10.0.1.5 id 254=20
+10.0.1.6 id 255 " "set ids"
+
+ip -n $ns1 mptcp endpoint flush
+ip -n $ns1 mptcp endpoint add 10.0.0.1
+ip -n $ns1 mptcp endpoint add 10.0.0.2 id 254
+ip -n $ns1 mptcp endpoint add 10.0.0.3
+ip -n $ns1 mptcp endpoint add 10.0.0.4
+ip -n $ns1 mptcp endpoint add 10.0.0.5 id 253
+ip -n $ns1 mptcp endpoint add 10.0.0.6
+ip -n $ns1 mptcp endpoint add 10.0.0.7
+ip -n $ns1 mptcp endpoint add 10.0.0.8
+check "ip -n $ns1 mptcp endpoint show" "10.0.0.1 id 1=20
+10.0.0.4 id 2=20
+10.0.0.6 id 3=20
+10.0.0.7 id 4=20
+10.0.0.8 id 5=20
+10.0.0.5 id 253=20
+10.0.0.2 id 254=20
+10.0.0.3 id 255 " "wrap-around ids"
=20
 exit $ret
--=20
2.31.1

