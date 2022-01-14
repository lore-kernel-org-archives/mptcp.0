Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24222C9D
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 10:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642156077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nvAWRRoUChJHIa4L6i+pqT2WIp2d4La8IfNJj61+7dM=;
	b=YKcY8fudpvTXyTd0h+pu0f2D+w4dFkylvs7CAeo8HT45VK+k8XfvLj4ntV5JDn6wf9kcqv
	41fpNkjVx9Hx1VP7ksSA78IH8YWbOPmDo3bgZet1C5/hfS3gj23Vt4ehuRyCyYlihIQPHV
	QV0tltcQJL/j19ZoFfF4JGKoFl04Wdo=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-k0UyUEpmOeW2T5Fd2Kt_Rg-1; Fri, 14 Jan 2022 11:27:56 +0100
X-MC-Unique: k0UyUEpmOeW2T5Fd2Kt_Rg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/xZV8+XImbmhyU4G7uHLJ2wQU0gfBBowiCuGc9DN8HI/LtAoNYVKJS6HdYrFqWXUsSN6B6hCBROzs8rL1GoFiNSgyymNbIl9d2TlhJcr1uKNwTiA4Zc9ZsI2p2RUfktku2X0moL1nQm77XA/nZWdvjaXE4X8EQKsic4lMTzV8nCbRlQ1gt/7CZl5JckwmIfZBkCPql9YaJByo8MwKi7qyZ839fNwJA66mcl/zuL65849gAvj0BjvaBNFTGf8J8rXtiV7HJvFIeg9WiRDqQucZumidg7OIBnVpFBReDS6RlYIbQidO6onQyeWeQhSMV06Z7h2ufnylbxBpCwyTFE6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzDy9N2dzu7E4CAr/2+3lbFvTBKhFTG7oALX/BrCs/Q=;
 b=VjT6ixZOanKIY/6zHBiTV4FC9RI/6iB2DfU/tZyoEKZ24tyCSWIeCUZ6cDVmDtGBuwE/WyNjp7d59Skbc6PfySh0jgOjhAzepUmZOyHncUlwk2vZTqhKmtshA6d5MeVWXoCD6PnGWzAPNrDiNZfUhu+WoHcC3tg2WHs+43kwf1hSX1aNK8WdTEq2g4QxCZxf9EeAzd/klIgN5DB0Fn93rH4vm7Gi2sJ606rb8loBb6Zqod1239VwrgKIL/YZ0HZK95x5QXKq4qSQZeJqECXPtMx7fwEtpp3/3kUrNY7mNrAhjompugY8MJHoJ8dXwSC/6qzbjhmzVD6/3CFpZCgNDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB4558.eurprd04.prod.outlook.com (2603:10a6:803:6f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 14 Jan
 2022 10:27:55 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484%4]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 10:27:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 10/11] selftests: mptcp: add wrapper for setting flags
Date: Fri, 14 Jan 2022 18:26:29 +0800
Message-ID: <5fdfe3efa18f141a43ec07a9b01d5b679d1a4a4b.1642154579.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642154579.git.geliang.tang@suse.com>
References: <cover.1642154579.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0161.apcprd02.prod.outlook.com
 (2603:1096:201:1f::21) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5edb2b53-1d52-4fe5-51c6-08d9d7488737
X-MS-TrafficTypeDiagnostic: VI1PR04MB4558:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4558779D22AAC3541D4F0C38F8549@VI1PR04MB4558.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zg46YHx/KUUPWt5RgYRdNEMFJ6TOBIdRrpDbj0YEtAjw5rNlAEv4HnTwICwFrdkwpxwWTrM8w4haLpcky0c3VlLJ4j2g9TQUKkwwXOAiTG6nz/tRdN6IL6nKMABA7EtKkef6jhJrC7JmVv2S+e99GfgItQznaswJW5K4ab7pe6Afdt8sai7ivNfBCB6xdkV9c2KT+8TprXU2ZjpLYsAulg31UIojPcyAt2OEj2G8/lcXB10sYbwfDe8d1S4DeKc/AygBtD5b73R3Ni8Z1lGRWawUH6PMYBD2Abyx+Zb0iavKiMZ5Pbwr+4Czt085yqhrzsic/9iBXxDwzusryhbrUIR1x74UHOONqRk9aKGNmNaLEodLexq0BSoTPlrkU74QvFHJzPphxmyZPkb2L7D1sd2WXgUtTSLDN1GYlo7XDyLvLxl5mb9b7/SLjwSNLynoV/8GPX2gUGJyMVRCWDYr5m7PT4J47gEPvAUyA/OgIrSExmcYOrHN9geyo3S3HETnZOUGtbMcsLM3/vn4rOWQqTHi0yexyApMcO5T8PBycfreqrhS8nMop4g5l2qTeXelbQ/jrx89Er/5YqE3Qee8NT9nTb7fP1TZW3tiQKNzxCheAx7AylolKBVBefxE9BiLHMWV3M1bSMHdLtTbVNVmzg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(6512007)(5660300002)(38100700002)(316002)(66946007)(66556008)(6506007)(8676002)(36756003)(86362001)(8936002)(44832011)(2906002)(26005)(4326008)(508600001)(6666004)(2616005)(55236004)(107886003)(6486002)(66476007)(6916009)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wNno9cVQsUQ+Nz+xuU9G2+uVXy7mY0iVts0hmDJB/yuXGjgSXFrI6aPCkPfy?=
 =?us-ascii?Q?lzMockmNZzGXiX4ttTz2e70y84KJJhN0HBfAkqZV1cHEhAdhNXJ4QXT4Cwim?=
 =?us-ascii?Q?2dMlxcjYZDLeJ5+8CFFxjNUuLs9gphyTcY4NeIxbq372Bt3pLkJLuOaiJ1mA?=
 =?us-ascii?Q?XASP4eN0rmFjA9FVer09Dtsmek7LI4VjuN3p52I1IRMZkaBf/25jdEtXkFzX?=
 =?us-ascii?Q?KFJMW8yFNutSN07KDt5YW6nID6C1D8jIPrdZAJsi9frdFWKfEZLNIeYoFNLZ?=
 =?us-ascii?Q?2X3W3jkqn1EsbZsak6p16Fv2+83soLF+BbJPOJdlXHpFSbaJstPv6tH9Q15p?=
 =?us-ascii?Q?HJMjbaCRqAZ3euISZPn72a0M0KfQerPKGYpE4NeC7+No3oD1XqdHEEGqb+xM?=
 =?us-ascii?Q?7s5PiuNrz9pLRhU0g2bbzq8AOJoUK6MiBxqeyrVykGK53eJRoF8ZSeO6T9a3?=
 =?us-ascii?Q?BmcmTzGZkBgVwtk+wGfc+AVvH/One+82+2u78q5G8rFuyB08ESMxlRlXA0yJ?=
 =?us-ascii?Q?9xGMmHO2nA+UfgYuhs1AFycnW4nxauZEwwvOXzE8C4FfcQVqxlBQAqABI1hj?=
 =?us-ascii?Q?qGmMmZIv+I2u94SBt5d9M4vjwxKLjyn6u24Xa955XTGMD4orM4SuqSM2HojY?=
 =?us-ascii?Q?ToYKxu9NgfdTppKg5kCSaJABfcPWw+jWVAspli1ki9o2Kq45Tp3yb48Q3twJ?=
 =?us-ascii?Q?lvg7A91wqTJNaUjMCPf/HakFa5s8nSZjsNS499iB31WygRrN7JibHTcGstWf?=
 =?us-ascii?Q?328dE8DL1kDJxUvc2iVliJ86ZgTWDBswgDC4/sI57fasEoQizh+MB5lp1nnt?=
 =?us-ascii?Q?yH/TFg7hVkFnYN/N9iE9G8l4O95+E/wwtIJ1mVKaQr0U5x91X1KXui13GMGU?=
 =?us-ascii?Q?C8+ODP+4b+zDytcnVKHKJUL30c4OfavV0C3U3yR1G3wf5N3TzvvkZk9sZ+0i?=
 =?us-ascii?Q?0827m4lJEBfFwUJWECp/m2bSeVVO7IkM1BB7aLomPU59byTd4OuwGbk5fzjI?=
 =?us-ascii?Q?RBRjjz1kyhbGTV6j+9IoFlMbClOQr1gwVUfY9N/1YqN477fH/yFwFgoatOsx?=
 =?us-ascii?Q?gVoU1BrbRvKH1fm+pb57Mnn44FCKh51Pqa637+0Tswt5dz3qm0u3m+skEzmt?=
 =?us-ascii?Q?/uQZPQftbsM/9mSmUe0D3i5egRb2OTGQ1qVPi+QMFaGrPhmkjiltaXO+QOY2?=
 =?us-ascii?Q?No8g6AxnoRH6ZVhKTeoaSarTEiwZ3wMjj/J6yu3iea6Y1MZchjR63z7P3QUo?=
 =?us-ascii?Q?VDbxw4I7xceBPI02fIxbD7XaybzW4eZ8nDA8Ec9hyP3ZQw/alht9F6fmVLPD?=
 =?us-ascii?Q?rMyT5pwbkOtjgFktE2ABIjG3DL+Ejze3L9TRTwTWNMPFmOlxT5NkEkL08VmR?=
 =?us-ascii?Q?BqW/4liNsSrq08WZMIr1ub+046YHMY62RWp3JrS5/REouX+mwu8pqGBfmK/R?=
 =?us-ascii?Q?jY24F2CIIjcLvM8F2hkYRRRpnzlKIux6ZCFarBdbeiCHHqEoqWEn7LESnUS0?=
 =?us-ascii?Q?KZz0zw/wpSBqJ9cXa7lfnEckVkdc/g+cAvdYcKZNqyXG7hVcJPDqIM353T1f?=
 =?us-ascii?Q?NM1MkN1ACUh4eZWsYMiO9HLw+x7l2PksdVTMO2jRBZtHB7ynseGVR7JhnMOO?=
 =?us-ascii?Q?KnOvIb9G/SnBpVnDEVbxPrI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edb2b53-1d52-4fe5-51c6-08d9d7488737
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 10:27:55.6740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3D7Ny9K5MMGqGZMwq6VkkrA5CHI4t5vB0vV/f3VPF4QbU5fsLliWPrTS5f2UvjVTHebbUFW033FqtQrPAFZxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4558

This patch implemented a new function named pm_nl_set_endpoint(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use to set the flags of the PM
endpoint.

'ip mptcp' used the ID number argument to find out the address to change
flags, while 'pm_nl_ctl' used the address and port number arguments. So
we need to parse the address ID from the PM dump output as well as the
address and port number.

Used this wrapper in do_transfer() instead of using the pm_nl_ctl command
directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 24cabed18f58..4df7417013d3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -377,6 +377,22 @@ pm_nl_show_endpoints()
 	fi
 }
=20
+pm_nl_change_endpoint()
+{
+	local ns=3D$1
+	local flags=3D$2
+	local id=3D$3
+	local addr=3D$4
+	local port=3D""
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint change id $id ${flags//","/" "}
+	else
+		[ ! -z $5 ]; port=3D"port $5"
+		ip netns exec $ns ./pm_nl_ctl set $addr flags $flags $port
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -578,7 +594,7 @@ do_transfer()
 				local arr=3D($line)
 				local addr
 				local port=3D0
-				local _port=3D""
+				local id
=20
 				for i in ${arr[@]}; do
 					if is_addr $i; then
@@ -587,11 +603,13 @@ do_transfer()
 						# The minimum expected port number is 10000
 						if [ $i -gt 10000 ]; then
 							port=3D$i
+						# The maximum id number is 255
+						elif [ $i -lt 255 ]; then
+							id=3D$i
 						fi
 					fi
 				done
-				[ ! -z $port ]; _port=3D"port $port"
-				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags $_port
+				pm_nl_change_endpoint $netns $sflags $id $addr $port
 			done
 		done
 	fi
--=20
2.31.1

