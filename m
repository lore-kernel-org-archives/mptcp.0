Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7B41B64
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 22:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644963341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bunE4ufo0z+ycI5GaIvn4VeLlhCAN4WgksWmzD7BilQ=;
	b=P1YQYm9hF775i9ERFOY2AmjccA9BbCnnN7mCaXEfFk+xaA5DNubt7qIuPUm9wF/vVq8j72
	O3Cb2w/sY3BME+DXnlN/nb5LFHbrFikRizNZyabUIonCpH7qLQAkj5CmAKIe9JoQUXrDQB
	ipnyONXtNWOmzDi7RZBo3cZgAbm1zGI=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2057.outbound.protection.outlook.com [104.47.9.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-Joa1OYqaP3OkgvaqbuRaOQ-1; Tue, 15 Feb 2022 23:15:40 +0100
X-MC-Unique: Joa1OYqaP3OkgvaqbuRaOQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVNdHlZQJ2FCjqjM1X3kNAtPl1gnjNvIpAHWc0vCkN0Dy7YgkgJErfQKugh3ZfKVdRKTjoOEOKTiLh0s9wnddGoRTYtKsPxG1zvARZQykufSF666G4/y9CtPzFRTBLSY5UgrKGswep5lxke5vedM9L64t8k+Ur2wkpxDIwIqEYvPgbt2+e2Ficm8fVWODGUIwQF2Riovnpb/gbAjB0rTnxhQLfU1Jx8sb7FFkNrEzANs/uN+QbTLUTHrU0OUoozk5aBM3XtZN+vabWVUN6kT+JzW2/qn+CR8qA+umE2kS2Ui3Ynln+zOFU/Mz9uFHuNDqDwCFAq5y7ivy3n4PJJrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvjK3LTB3epcZmXejyrJhs8sGlG0Lyg4SBPUgNzN+aU=;
 b=FyQA777mj6WweTZx8Ngt8YQg1BIMkBQkksF581iuk2Ld5rm8bbA6B87DtBXynkEySGaKN46imb4XRFtKWaOzsa4RKsGTgzQHXVO94TDuemkEBOmiGVcR0jpjBwwNPyHegkj6uAyH7ReC9QLKukJTmDt1kg/OBHIVHd4KVon0ZtzXeP8/w14Xb8DlQhh9DzEnxwYtoXX6LdrKLSlWCqV9urAVE2M23mbsxEOVfq4r0PinyyD65o5iECfVe6zxnc7hHaXJ5HjLA0zKOSJfg4ElVS8gnInf3yHeOiO9pKiV+pkU7p2lhg8YVkioJzlxY8OCEW4JM05rhmuAGJ6SxTDrmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4784.eurprd04.prod.outlook.com (2603:10a6:803:53::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Tue, 15 Feb
 2022 22:15:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 22:15:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3] Squash to "selftests: mptcp: add the MP_RST mibs check v3"
Date: Wed, 16 Feb 2022 06:16:05 +0800
Message-ID: <b3e010c769c9a15ed97534201c4baeed8c182e07.1644963254.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0154.apcprd02.prod.outlook.com
 (2603:1096:201:1f::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78ea2555-89a2-4e50-ed99-08d9f0d0b27f
X-MS-TrafficTypeDiagnostic: VI1PR04MB4784:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4784AFCEFF3C8B2F3BD802B0F8349@VI1PR04MB4784.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oFFnElO9rklqah9o4XuJ8wKk+h41LrOYyXiHYT8IFWmkIIJ6oQIbBQmwnpJSHtMDV1DvwfmFtJ0V+QbToXkVTlUj/ePuYdXgMve0pgH0BEXOx2/UX693IoFy5VSOc1oYMNWmBhgIzd/TiB6j1jdXls55pajARnc/Ehkrr/Mw8PBMLZgaMp0c0oTs79Pnz7s6GpxzT/X4tE9QTHDUlUHLEM3Kgp6uSWpCPtgTdNqEf/MtkHSdYfuVZJ73cwdFYYgfHk1yN74zkJd+UVZGWSg0HRLiwGQaW0CKaOoAlqrbycy+YggoqyE82QUgwimxA/IhyNtRvR6xh0sfNfVW12qPx6Ujk5Eq1BPuPsUG/O2lAJ4F0audKGwfRV6TX42l7HEH2TQLQBb/aluZib6ZBcujGErTGE7oyoZF5ZxdZTUVsHm8t3WE5nMpE/DaE9G1ye9u8ud4yyk/Lx4eg3X+uE9UQez7pbXPaLjYKRhoYfJ/wZw11BRuCPR+/ZtGI62Ss4PR9VtFeFrApCII3tjx4H0LAmU2RgbQRMLd9X1GKL1GWUFkgcbISDhp7jyDcx9bof/O86RAzZ5KcvMRzgvJKeqmcwCkh2rIMA6DgZpaSsBFtiSSJnInMdH+uO7Dbk1nZ3FG5DB+49b0JBH60TjB+LrB3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(107886003)(44832011)(8936002)(66476007)(2906002)(66946007)(8676002)(4326008)(66556008)(186003)(508600001)(36756003)(2616005)(6666004)(6512007)(6506007)(86362001)(6486002)(5660300002)(38100700002)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?76BRZ3wI/KwFKPy6xunZBaxdFsb9NwIRLP6dheuiYAjIUejWpuJkg4tvllB8?=
 =?us-ascii?Q?Y7WiI0zhHuS0zmsQbYlmyGw55wiEvoxbBnBgJqscsqiXiG/XsJPS5xKJ4y89?=
 =?us-ascii?Q?MAXGbueRHtDMmI91XzF7mEA3U+WjNsHzLQtwNfjqqgNHy91YpRM1D78Tb0rA?=
 =?us-ascii?Q?xomvy4zcyi2jX6X0/YYGBjDFbDQd7I/pOfY+usaKJzGLwsVszip2UQ4oDe3M?=
 =?us-ascii?Q?BwWNZB48Knj6ILU8+l7dsgg2SI1AOPf0SnfBDcXWIGnXX5OnMh7vl6Mm8MLy?=
 =?us-ascii?Q?K8aKBmfIqTxkkQ0+JulWVx8QkigFuJd9HFeY3FVmhYks0WTa/nSUL29XeNRa?=
 =?us-ascii?Q?TUPRnK2r/8D20xNIPhZVYt1YNp5uC45rsQESC1A4VtqoO3mq0Yzw7GHnIdg1?=
 =?us-ascii?Q?fI1C3k4Bcf7QNZDy2oTWP9TfzquYC4RdB2vWUL4Np1ls5fxcqd1rOqe6/74G?=
 =?us-ascii?Q?L0f+LwylPc9rRKVgnWSkp1hB7WeX+46lDAnhtLqUyfbsqw9EgFrrj0JzhCY4?=
 =?us-ascii?Q?mC0jsRwXEQYaSiK6JgvFtpjalACkeWz3+EmpawufB37j82S7rOuKIrmb34Sa?=
 =?us-ascii?Q?GfLHNSKd/+D3m0mZWeROZsCBQrewUqgkaFmiO48QCE0KJTzWS731bMcTuq0p?=
 =?us-ascii?Q?FVkfTyU/1u3iuogiLGrany2lss75ffV4BktnhMZitOiOUer0xUofW4CahLpH?=
 =?us-ascii?Q?+KqUk63FwBYRiv5tXsHOWb1mcYzSY6ubtBZtUqCLs0+yttxWw1OysZJRqhLE?=
 =?us-ascii?Q?8r0c/h3lh3xwC5yB539cWCrZomJnSk9sw+C5plhSJV0QhN1gu0KKtcQjXpUL?=
 =?us-ascii?Q?GiXCdZ/FVqdpe4sCogdwvHxXK3CuHHefSkhJaSYJjrny3nzoRudk/ThE/YqQ?=
 =?us-ascii?Q?o9sf6UCe4ojtJp824bPyRoO7nNDFjdP8W83hVSO2l4HwuuABgY9IZOZL1i5q?=
 =?us-ascii?Q?MtoIws9Utu1hrzWHk9K5TmqvVs2qbHjSATprqGF5J84PCxcaUhgPgHbRCkLI?=
 =?us-ascii?Q?pH1HDhvuejdbqf8D6FVTH5IUcID17XApBbElP65+chFPjfGTraBm4bs9v53a?=
 =?us-ascii?Q?773UfgoVKjsHGWEljfhARvuhswllbJ/vqJyPUiB0IVPfWadLXDNozUS0sy6l?=
 =?us-ascii?Q?zJpzdRcxTCnlu8WLg0e0raM++QBLTHzsZ0PbjLZyJIQeMGtuVNHWHMZejGef?=
 =?us-ascii?Q?uTiLv91hWopmGa1Hns0rJXo39/sRjibTqybDuRHoqOiYXx7s9utEtpWrLLMI?=
 =?us-ascii?Q?U7hnIuwE3BRYqbvgKVRwcFP0kl4MaSVNlywz3EV8zEKYEKOC5l95A3s7bH1q?=
 =?us-ascii?Q?rm76RNnKZqe9R66Dv95JNZoLnUsypiMcHL4TrveP8QfizNuqGRw7DLU8PkE2?=
 =?us-ascii?Q?I8kSngfsCB6A3aQiw6K115dbXxz8Cif9yL+EZEddNMJug0u9/EhxpJZplNc/?=
 =?us-ascii?Q?azFnf7bkcOXB/l7W8c6quPa7iikDKhy1C2hTnyjgU/5W8Cv9lVSsOD2E9TgW?=
 =?us-ascii?Q?LUnXcJYTF0DnJn7OdMVMHFDqwqxlJQ2dSXUE2Fu4fdPRaUX9axW+kAP8VC8X?=
 =?us-ascii?Q?j3jJJ12CsQ3qLPG2TiYu1XwDgdpSyxOfs4mlYlcAL0vJEiW7pKrFNDV8dOxV?=
 =?us-ascii?Q?yRwyHGzvyB6lDjGhGXzheXh+Ja7ff4QhM+nJFpy3qLaOdzFMJQMQ/lPhcEAJ?=
 =?us-ascii?Q?5dI8a4xYAJDcm4tE+Qeb9TrWjqQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ea2555-89a2-4e50-ed99-08d9f0d0b27f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 22:15:38.9009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCSnAZJ2aFXLpekchKUnUbFuupB01WnE+3he7GCd9NzWN9gKCM0Ta42boSrfPLvG6j8VcaYD6X9LQEEfnw5UNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4784

Reflect the ns_invert.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v3:
 - add extra_msg

v2:
 - update the output message from
                                         rtx[ ok ] - rstrx [ ok ] - invert
 to
                                         rtx[ ok ] - rstrx [ ok ]   invert
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 3252865352f3..93943cb5e4c9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -809,13 +809,14 @@ chk_rst_nr()
 	local ns_invert=3D${3:-""}
 	local count
 	local dump_stats
+	local ns_tx=3D$ns1
+	local ns_rx=3D$ns2
+	local extra_msg=3D""
=20
-	if [ -z $ns_invert ]; then
-		ns_tx=3D$ns1
-		ns_rx=3D$ns2
-	elif [ $ns_invert =3D "invert" ]; then
+	if [[ $ns_invert =3D "invert" ]]; then
 		ns_tx=3D$ns2
 		ns_rx=3D$ns1
+		extra_msg=3D"   invert"
 	fi
=20
 	printf "%-${nr_blank}s %s" " " "rtx"
@@ -837,16 +838,10 @@ chk_rst_nr()
 		ret=3D1
 		dump_stats=3D1
 	else
-		if [ -z $ns_invert ]; then
-			echo "[ ok ]"
-		elif [ $ns_invert =3D "invert" ]; then
-			echo -n "[ ok ]"
-		fi
+		echo -n "[ ok ]"
 	fi
=20
-	if [ ! -z $ns_invert ] && [ $ns_invert =3D "invert" ]; then
-		echo " - invert"
-	fi
+	echo "$extra_msg"
=20
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 }
--=20
2.34.1

