Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDA7373
	for <mptcp@lists.linux.dev>; Sun, 13 Feb 2022 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644763845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UAxbJ3lm6VhLg6Czenz+Qos9TMeti8BNHsAMqQvZhQY=;
	b=BlVBJJA1bi4jaFT4CdUztVnriJEW/4zX1glpcofoMrQM/Lo/ssWJodPkTq6dhB6WpeW0XI
	EL+3O5O6jS1ToWYggi5oVMc6DR/gYYvU7EBo3Um4YRZs4f6il8ONbeavxB74k6hSYVjtxx
	7HxC59YQev81LBnP0A0wuMhRwYwLumo=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2052.outbound.protection.outlook.com [104.47.9.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-4OqRjUELP6u5GlbZZHngHw-1; Sun, 13 Feb 2022 15:50:44 +0100
X-MC-Unique: 4OqRjUELP6u5GlbZZHngHw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOLKTIj2e3U6T5FoSnXqIJYOflcT0Obu0FDIjZEdnHJKvcAPuypIsaOc+S1/VhYqyc6/2+gr5s/025wHEKQTBOHTDoUddzMsZzFmV6qioITLWIpz19oOIVekXTy1eRyQZgI4Y/vX5hDKPJUyHQ29XIH+Ob6n4Y6aVFqbDwz4btN7hzUxhfcYVeImt57av4Q6BuM3+tEbDvitQee4hRa4ZFxX5DOKhGnFqOg/m+KkSCseju6nvQ3nvwaoB7S8eVcwOCVDMz5FR1F0ZWt0k/of7cp/wImF3VHObMRANmi0i6C9pCSn9KFrhNIJu3/zShx7Wb1rLQczJDtZmGNE2EseMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sorjQj7txn9tkcQBr+ENLkOY4LCKsA1vIsX+H5KXUl0=;
 b=Uw4sZQfTzfe0pKCaEUHA45ZQ0Yk2rrTexP+Z16YkSRSpK3RUYfYLFUxLfj5/dShp84SpLYY6AsfXKKllnfkbJAJQWccIZTrOc3glpeTGUttjQ1AuTf4EVSIudVmVfrIgM64nVSmFcQTcRU9G/1t3PQgnnuvj26NtAMJChmz/vfzkvTA8GQoCuiZ+9d2h3iGibq/zrH31LJxHKasDM5a2YKvM8WIjVvTqUzXMCQajrw89v0jndQ+nJCTrovcxfe0mH5OcwqDO5/JnDPYdoccNmT+o3d9yyShdB1IG1IchLBoBjMQInE/Ql7Wd3dFudpfLJuoPeZbiF2ilpBFOTiYgfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0401MB2384.eurprd04.prod.outlook.com (2603:10a6:800:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Sun, 13 Feb
 2022 14:50:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 13 Feb 2022
 14:50:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 5/6] selftests: mptcp: add extra_args in do_transfer
Date: Sun, 13 Feb 2022 22:50:35 +0800
Message-ID: <a8644a115c1d2251881bf34af4eab5b75968ca16.1644763526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644763526.git.geliang.tang@suse.com>
References: <cover.1644763526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dd7fce3-1a41-46b5-78d8-08d9ef0035d1
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2384:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0401MB2384A2258A1AD83720A478CCF8329@VI1PR0401MB2384.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mcdoZGm9/Lo2AkeyX+CFMIdoxpw9d2E61HzkIWRVVRlv0kezcsSbXIj69BGZnhoHNj6Swf9WcLwx1NNxjPXapVkW1Wwj3X4CYzydF7nolqX+GJq6801SPLdHFnw4dEwgrS1iLIfb6VJUxxsjvXQRGfV5oSzGrPPnR8xspCFmogmUvdtKJBebsrFDsuaHSSCQ1xY3VDJVvgtEEnf1O0lSJ07lvNqpN8EbCQFvtaNso4OitQqJvBE/cB147FFHHmd3diODs8j39NfM0SxI93R3qqGk7xO7e6LwjbeooCwzA3foGvst4yx/LCBw7x6BpghmTbmAefpvxfAevmr13LcvIN6TzdCK++y5QH63WDo+emtc/qrzXYqJhkuAx/G0LkzvAiMR3l6M+TIcbncLys+weWq1KWwXVuzbGaem+3jzIDRotn/ycE95deS7xISswWgElxC/nBZcfNIr7cx1BJmF3zbIBARDKAFSoZ47y6Fu+Y9kugu1u72K6cZO2XfQONW4VcOh9Y0Ebp7ippPIvyLeHjUB/+C9uiwVpv1sIMq9xxQXPRJf1mP02/6H8Mk4l4umB3d38QuozOfq761/GXcs1yuhFOg1CqSCogCLzpNUoU9FsSwFXhqBEt80CUVw5hOiJPTD9x1LUtj1gT3dLx5qng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(6512007)(316002)(6916009)(6506007)(86362001)(66556008)(66946007)(66476007)(6486002)(508600001)(2616005)(8936002)(186003)(107886003)(38100700002)(83380400001)(36756003)(2906002)(8676002)(44832011)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hlUACArfopVFrF8mvJyJRJQ8gh4tohxD4z333xKiXot6u86gSP5kM813u9qG?=
 =?us-ascii?Q?Uf7WJ7VFg10Vh+qbpJmErVFQDsqIuiGCkn30DX6NWTUYK5n7GQzkS/98R2hK?=
 =?us-ascii?Q?kNAE9/Nln3I0hZsHk9OZMdvXHHgggIDBkX7boaPUJSIBBHlKklc2MOHh9pPL?=
 =?us-ascii?Q?z0ZW8z4VcwE7sgAgacGrJ0kYYpHPQjS4wto/4/5MLJkiaUqMZS80s8auDID7?=
 =?us-ascii?Q?utqivqo7dFj6r6E40/fougnOwDHlVUQJ+2yX/4bLuBN0OebeWgI/IqnHV4nu?=
 =?us-ascii?Q?E45idfMCcZ+KKUHpweLA5ONISRV/0bqO/xziIxYMBFepUXwACKrP2tTuEIU6?=
 =?us-ascii?Q?K9UuLF6EkUXIV3uKuz3lbOB73tZGv9TWnlrEZqYwgHuoSW3cy3Zt+DOje5lg?=
 =?us-ascii?Q?4Y3IRr3J+mSLbveUbGDxfUo83utZq4EKtnZSPMiREJZ3yhcsgdzYZEe9s9z3?=
 =?us-ascii?Q?IL0lQ1XTyCWYmxi/YuPO2It4Yify8s71lmEXpUf9ZnF7JCoLpZY3Rjxyc596?=
 =?us-ascii?Q?rpG6o9TbWwqiERSHGeyzZvbGiQyQjzRBNJ0osHLUmWQ6k5DawZl7HjLeryoo?=
 =?us-ascii?Q?MkZs1rfXmzZci8X6LXwnWIAWwhZrbrPNGicbKvHBPuiGf6BE4Ex+yoLjMMv2?=
 =?us-ascii?Q?2jWbMNKbLFFAkRdHsTl1L4qRU8R39o66e5kZMNCv5dV/WdvrQtMXSOUbRzBz?=
 =?us-ascii?Q?hxnoHJo5agKESHmzTYaMMK2fpqdXLYzjTgdvqmxZYRWHObE1+VXk9R0i8k9b?=
 =?us-ascii?Q?Bfz8QUp/6EcJucXksaYd7ljYxjEYZIqUmXtyVSuHFqt+3zYBEQ9hJ3UnS6zP?=
 =?us-ascii?Q?u5eKXU6k0NrXaJpNLsneHzzipSC3bIX1hNqE0dJxlmKmqM8LJ/M/x9csvsHD?=
 =?us-ascii?Q?6wLdG8Mz0c45sntX37gzSoZU5pWmTy5WaaJsfzICOpF4kxOmPeoffM9JCxcj?=
 =?us-ascii?Q?V34jTF7ByLnHjmjTNLdWGngGF7hZvgn4wkt4m+HrT/kZ6JeFT2OPyf8bVgqt?=
 =?us-ascii?Q?S2a7nzsopRV9Dj5CQQBcKOYGrqseeYTLE6oWo6adeXNQjO/xBxvRvMNrRlm/?=
 =?us-ascii?Q?Hd9XxQbBmsLrrhu0nnZfEcdmm1M59YPlpClQRX8rFgOnO78T1vyi9ZMTqgIS?=
 =?us-ascii?Q?Pbd8QSqDiuJhC9v5rQw39Of/2fTTdSHENTIXO6hjDBmotfl8WvHS4VhVuSIK?=
 =?us-ascii?Q?fvYedf/hztKebb7mls6v34Op21ETdUvA1VpSa2Q60jOCwiCpDEswjRdVXRKI?=
 =?us-ascii?Q?81g938w5TwJoIvGCPbdD2DNl/Slyu85ObbuLJUJve4bMTnn+7RCSdvGMNWb2?=
 =?us-ascii?Q?A3fJPnf9hpE1crQvST4WesOeWUOcBeyN2tKgBU4Izm0cwubYSaWmgdrVkzgK?=
 =?us-ascii?Q?L+StOzNp6/H099m2PQfimc6ldTQu+m2TxSJrXmZFsvuI+T+WVDTxSVjlUf8W?=
 =?us-ascii?Q?EXEmEC1y0oQ21h+e+3AuZuLrpxFiFRZ6WGe2gyha57q53DlVDcAEyXgTMKco?=
 =?us-ascii?Q?TraTPNsdjeMrpcRc3+QINphqyAGmIkef6ETsM+OHly966AHqANZC1oLZ6VLG?=
 =?us-ascii?Q?5xYAsCXDNrBNDk8MYc20w757tmeZTSDxFF3OxGnz+DW/zVfcrfT0fYc8xx/s?=
 =?us-ascii?Q?jYj6Szoc2YaF4Bt/q2D75kkjTEAkogspOSJYwGfSjqQPwp3yYv6Zx/+nsgol?=
 =?us-ascii?Q?X6Nwte2XjofoONgwmeHH8vONNdI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd7fce3-1a41-46b5-78d8-08d9ef0035d1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2022 14:50:43.4406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVomTw4Zx8oaGWLMngsWbB9LlgpgvGm0m5ly4TlNQYQGqdqveg5hnW9ooWE34GOjq+lJz8XL70+hmoBr8weuJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2384

Instead of using a global variable mptcp_connect, this patch added
a new local variable extra_args in do_transfer() to store the extra
argments passing to the mptcp_connect commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 3252865352f3..ee747f4a4c7d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -12,7 +12,6 @@ cout=3D""
 ksft_skip=3D4
 timeout_poll=3D30
 timeout_test=3D$((timeout_poll * 2 + 1))
-mptcp_connect=3D""
 capture=3D0
 checksum=3D0
 ip_mptcp=3D0
@@ -454,12 +453,13 @@ do_transfer()
 	NSTAT_HISTORY=3D/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} =
\
 		nstat -n
=20
+	local extra_args
 	if [ $speed =3D "fast" ]; then
-		mptcp_connect=3D"./mptcp_connect -j"
+		extra_args=3D"-j"
 	elif [ $speed =3D "slow" ]; then
-		mptcp_connect=3D"./mptcp_connect -r 50"
+		extra_args=3D"-r 50"
 	elif [ $speed =3D "least" ]; then
-		mptcp_connect=3D"./mptcp_connect -r 10"
+		extra_args=3D"-r 10"
 	fi
=20
 	local local_addr
@@ -472,13 +472,13 @@ do_transfer()
 	if [ "$test_link_fail" -eq 2 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
-				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					${local_addr} < "$sinfail" > "$sout" &
+				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
+					$extra_args ${local_addr} < "$sinfail" > "$sout" &
 	else
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
-				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					${local_addr} < "$sin" > "$sout" &
+				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
+					$extra_args ${local_addr} < "$sin" > "$sout" &
 	fi
 	spid=3D$!
=20
@@ -487,15 +487,15 @@ do_transfer()
 	if [ "$test_link_fail" -eq 0 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${connector_ns} \
-				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-					$connect_addr < "$cin" > "$cout" &
+				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+					$extra_args $connect_addr < "$cin" > "$cout" &
 	else
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" )=
 | \
 			tee "$cinsent" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
-					$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-						$connect_addr > "$cout" &
+					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+						$extra_args $connect_addr > "$cout" &
 	fi
 	cpid=3D$!
=20
--=20
2.34.1

