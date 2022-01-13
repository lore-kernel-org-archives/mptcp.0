Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDE32C9C
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 09:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642066192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=op0zL/NuF+ryK5CLusB4Sf2I6mERYrJjbeGrY7y2C1I=;
	b=Y5Edh03MzysoThM43UCIBKR+UMgvJAjS99BjGKmsLnpzqpgIiEuml0/kcHBqZgRlOTSTkt
	T2Et9/K0xPB9f/vZGRJF1H5QHbSEUnOI5EwPw/p6L5La17epCCNWk3fIshI/pz/eEJfac+
	LPy0CKyNzqf2srWryB/h5L1S7wJu9zk=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2054.outbound.protection.outlook.com [104.47.2.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-8SIRobM9OHeQRiBHpq__Mw-1; Thu, 13 Jan 2022 10:29:51 +0100
X-MC-Unique: 8SIRobM9OHeQRiBHpq__Mw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oy06Jo6oWRU7UUVprRqygzpJWTeVQ0MZkJSd7dAisTsL+CacHq6zQJjo8SzlysH/1IHHuYcNHOcAkraEi4hxbWsfdUf5ilkCuGbkixw6a20wyEafWRrXdpfcgs+PPq4z9o95Z25HDVph/xlIQG23lnyHjFEFPosrLE5uEelfhODqv6zKYWGkgVGZZFKudTCebLL4dWAb27vP54rlsw9FhYhwVRNC/j2XG9lxciZAOsNqgHbY+cz6/CzPQBc1W9BuhxGUoEk7UhYkrNvmNB86JpprDnEN0tBATXFEoQPq72YUvr3Fg/8EwKSe87Zm8Tbp4ZDLR5gvViJI3grzwada+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RX5+tG+FCQ0Mh+YMd0eT7LyUbjfx5LDWFI3GnFHypC4=;
 b=eiKEoDmak22r2e2O0MBomicSHlqD4l8gw0CqlNwOchveBk+nEAzfcqK1zjH0KfE2MAGLZDiDxbxzA/gFOjalsFxZgQMHFR+HLpy4bRWp7+acvMd4KBwHEX+ze6TpPha8QaZexlMtYnDvnm7YxEPDSAvl7zpYJ8digDpCaFhW+hg8+EwZtcGoq6Nfxp0j+k0KbLvr0PpsX+J6rOk2iWANsbvf7dVMV1TQfXV9KJI/yBQVBAMlXNYxll5q/32RWCUAKBY29XcfB2HGTAUCHRfCIQh4I0+dAVTZeZbu/K2h1F1qG74s26b4F7iAnLNZ3B0O7LQeBZgW/HAkQ3rcXnloTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8596.eurprd04.prod.outlook.com (2603:10a6:20b:427::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 09:29:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 09:29:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 5/5] selftests: mptcp: set ip_mptcp in command line
Date: Thu, 13 Jan 2022 17:29:06 +0800
Message-ID: <3fd46eec8c2341f54fbc4456fc709defdaf39317.1642065488.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642065488.git.geliang.tang@suse.com>
References: <cover.1642065488.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0109.apcprd03.prod.outlook.com
 (2603:1096:203:b0::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3432cf39-2e35-407a-bc28-08d9d6773efb
X-MS-TrafficTypeDiagnostic: AS8PR04MB8596:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB85967CAD7429F99C404668EDF8539@AS8PR04MB8596.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U70uI+t4RaT/qQKebJS2Ltu6QF9jsDcuTZuhx8B8l/8LwKJ+YtEyO/9Nh5Bdxe49kZXjA7z0FK9MZYgTXPyvJnN7bPmI7qp3IeI6xnYVJ3T7fpphlAMqm105CiWTEJ8fPkOZcUnLdsrGRi0m0oGfTqcoTwBfXS+jMgbWvty2wb5ZsOGBljCK2mT/bf7qVDrXA8wgY1NmAcFvtBFEdXUiRhrD15++hzcIB2t05ewwDVD8uBxK/lsYNF4wrrAvuLwDD/ER6ChVvfZRFSrDa325GCmYthHsT3RncpnsjyIMwKtPnYXCOKxviCYo09KB6itxXXMz9Nkg/e4v+aTFLsDKZJA8GxxGLs7dkBEouZD6+cq4AmxPO0+C1G+b5yBZqm0O2uRiwvU+28RrjkoTbtCgdcG8vQ2O6fDZnt9oxAOXsj8IIH7q2ok4zqPy3wN3X7WZHkXolhwLTXOcf6oWzHn7Bos0bTAKyMJNU+VbV1Hfjnxfu+fhu+PWO3isIT6Ix1CTK3EhjbXHgZ3WeURxnsQBJSRujJCi/i+blifHVjgfuDh9qU9mZPkPp112zVZaTbMoUmlNdLJvIkBfgH1FP68jcTDiiDrch12HztUVXbdZFpHzlIm9pp2bR/2HTQRYpz27SnqhTaotAwF2L/lV/IbPSg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(6506007)(55236004)(107886003)(508600001)(26005)(186003)(8676002)(8936002)(316002)(6916009)(66946007)(2906002)(6486002)(6666004)(5660300002)(4326008)(6512007)(86362001)(38100700002)(44832011)(66476007)(66556008)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iVNYCNryezKkbICYt4b4A+3fTvNFYCIG+RsffGE2JyHWj4zfy/vX9OBv7Vp6?=
 =?us-ascii?Q?Fj27J1xC9/zIrT3GFDp/wZqmWv78ZKi8bDYa2GUw7d+AZ1vdEmOpyYvN9GQv?=
 =?us-ascii?Q?fOzBF/ROHKeXH06pGUJYcbowHFTRkum6kvRwteDVkGsTWemEY4WFx33c0ndV?=
 =?us-ascii?Q?IOFxVzU4ej7qm/GvjDNBEOUXkV8FvhnrilpMbgucFsBSgEvJc8KJ7TlRR8GX?=
 =?us-ascii?Q?zGZlA+F0X3T+ITD3AzR61uITCj/xaQNCmyKzXzfj6l/nhQ9VE5C7DWn7ryfJ?=
 =?us-ascii?Q?bgjX6ZIFgUm99VNAiThS74J7BsXeMzIvfMj7itlcWaXGaDE24z1CN0Yq/0i5?=
 =?us-ascii?Q?fo0UttXqBxU+vsR02Uv6ctooU8davYkKAIhq/G5m70GxErEH9UaXBQyiGTcy?=
 =?us-ascii?Q?k/kRoRFgR4O2mlwuLJ1ct17zYVkwHZfspAV1kA4vcMGMpeYLqm6N1gd57qlE?=
 =?us-ascii?Q?kkZY3ihkPUxO4hWl/NUJxXhHswg0UrCl67moUhWH+8DhK6p3C0cPZjZ3wT1t?=
 =?us-ascii?Q?C6s3X0lZK7G/AqMUAnOrMGwHO5kvWILRemdddmgjFYG5i/DyoFI2goejk2A9?=
 =?us-ascii?Q?Uv9FU74w0gnYJul4wX2LV4nGbZKdyGs9Gxf4k6CS2E1ImEsWN7uNDwBdzU9U?=
 =?us-ascii?Q?dfGFRFJTlZlpTqVe9Us+a8AcGIxrBJDKnIvITnNLuUGycI8IVRPOWLraGASu?=
 =?us-ascii?Q?7K/zHgFThdfnSkVGdNTmNV7yW+tQEDLdJBWSTDjeeK/3HwuTTNSRTvQVO9rr?=
 =?us-ascii?Q?D2dQEqe6RKfatC8RnDzyNzbYPM863NT8TgBP1L2tXDxjqiN+ioi+eiDYe5Jp?=
 =?us-ascii?Q?2osvmGOtNHPEf8q48NP/sOZu7fZH85BPRmUlchzpyUU74RrMMTsIo3emTSXk?=
 =?us-ascii?Q?0H22nOWMAmq/C17F59Um2k/eTm64TpcohbJGM0DpgWVEczfWq6OU+m+IZhY2?=
 =?us-ascii?Q?wKC5ew1hS8Y4LGWugAMRbJDio5PcWUwvPzPpbWQnhUq3TyweWX7mXcFvMRSq?=
 =?us-ascii?Q?QvRZ16LWtEg2dKUkkxO06Ejavx35QfJqZKfliyRNk4Wy4j0haXAy9c+ZFS91?=
 =?us-ascii?Q?cQ9mUDeVO+XZhg2SM4rqBEQHiolIkQRUGySWD9zzoUn+NMiLfafoybB1sfYn?=
 =?us-ascii?Q?FFKpUa4JZezA1qR2T271CmjhUmeZ7O/EMccHpGCF29xTOisJ5ZTbh6nMxMxB?=
 =?us-ascii?Q?ob0xBPA3df6iqCGK718tIoSbU7J3PHxLD8p1tNUXyqbnVnRX2F6BzvVT1i2r?=
 =?us-ascii?Q?GGi6y6hh0lS805gCJSMXZUCKTdG8BhJnOYvD+J6F/WJHa0sJ4ViTnU7i1lfO?=
 =?us-ascii?Q?y6X/kvzjwzcOJhn33auCKIoLKr/jCF1ieeLBQb29Q+vTChD4Stuta/ihQLJ/?=
 =?us-ascii?Q?DFEM2HQeOiWjTCKpjiYV8SOxK0VckSiSyaIbCxrLLVFBrAg+dgMfDNsfmm64?=
 =?us-ascii?Q?XMqdK7YQMWlnk6gamWw4MirfGV1O1potxfN/nD+W+sK9H3kXxmbcALxS1Xia?=
 =?us-ascii?Q?+xYl85V0QRSk6iG0FPt/cvIizd8j5OU5AkkucS+coIRH46j5DQgFwUsAcyjv?=
 =?us-ascii?Q?FtjydnoVQprkogiQ4l6BadI7g3ZqBFGfJGowWmAX/wyjKSQJmlQ3xhVrltcP?=
 =?us-ascii?Q?/PPP/vFHBchyMGm5si4BW3Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3432cf39-2e35-407a-bc28-08d9d6773efb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 09:29:49.6554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EHH3pN4LNMeu8sm/PPO7iF7nMkOZI8ESJ6WpHMuXu0wMIgintwh25WRY9CuPO2/jnR/FFxej2Ljj3CVGBqe2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8596

This patch added a command line option '-i' for mptcp_join.sh to use
'ip mptcp' commands instead of using 'pm_nl_ctl' commands to deal with
PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 16fb756e363e..1302cf7c0454 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2202,6 +2202,7 @@ usage()
 	echo "  -u userspace_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
+	echo "  -i use ip mptcp"
 	echo "  -h help"
 }
=20
@@ -2223,9 +2224,12 @@ for arg in "$@"; do
 	if [[ "${arg}" =3D~ ^"-"[0-9a-zA-Z]*"C"[0-9a-zA-Z]*$ ]]; then
 		checksum=3D1
 	fi
+	if [[ "${arg}" =3D~ ^"-"[0-9a-zA-Z]*"i"[0-9a-zA-Z]*$ ]]; then
+		ip_mptcp=3D1
+	fi
=20
-	# exception for the capture/checksum options, the rest means: a part of t=
he tests
-	if [ "${arg}" !=3D "-c" ] && [ "${arg}" !=3D "-C" ]; then
+	# exception for the capture/checksum/ip_mptcp options, the rest means: a =
part of the tests
+	if [ "${arg}" !=3D "-c" ] && [ "${arg}" !=3D "-C" ] && [ "${arg}" !=3D "-=
i" ]; then
 		do_all_tests=3D0
 	fi
 done
@@ -2235,7 +2239,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCS' opt; do
+while getopts 'fesltra64bpkdmuchCSi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2289,6 +2293,8 @@ while getopts 'fesltra64bpkdmuchCS' opt; do
 			;;
 		C)
 			;;
+		i)
+			;;
 		h | *)
 			usage
 			;;
--=20
2.31.1

