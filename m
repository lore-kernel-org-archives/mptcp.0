Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737DD5695
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 05:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I+PpivJR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAyvrJRMN/Ur2cm8t56n3VeXuSfyxBFTJ1g+Jn7qs3PssUYqLA29avZ6AgAIRwI1xTvgSNK8dMYcmHwGP7s05OBOm7zCUpSLtonitDPDAVEp6LUoveRryNpGcu+ydGnWHFWz79Ll53/TtAF0Qb19BAqacZYiTjv0+SJDpGkikUaSwMQ9kWOnlpnqgZh0YeMEcmuC6Lxddf1sYjAIBTX2vDne8q7rW5BaEEzU3E76ByY8f2vHPz3P0QjcjopEVWIwAtFzSOY8VWF7wI+zFKko6GoKl/Zg+6qR3VLGClKibq01xETm/peCykjr3UnEiPiPde5UpkjyFCWnKHRBgvX3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6hPK3oSaRNxXdOelXMDrwTeosSD5oDrdwziMA10w+8=;
 b=N3BHpn0o6C28T/7+6eFnJhGLXBfTXF9Wq3yRmapigJKZygrItk5k29tmE5nrlU8/eFXnDtrPsUgOeoR5a2Ak4iV8lO3DMnWv5xPp9o3Z9zfBeRu+X/iwWeQj8P2kh4lFxK8TlNw7IHVB3Ne+zWH0tT3zEWGZks8Qb7OKFUi8I0mgsQUSwkeEKKhtwpwMQHDnpWXXj19epVMaaxj0KDF8V0lDZOIXuGgiqs9OODw6qkpx0R+ZBRX97+WmG/Iy7qKNr2K8oWr+kaWajtM7E2ACylEO7iCuGvjU1uYmesKLT/OhZiW1ci75hpXdNcdayszEOT4XEQWLCHlxg0uw5T2mkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6hPK3oSaRNxXdOelXMDrwTeosSD5oDrdwziMA10w+8=;
 b=I+PpivJRV7go5mm/MfziGJLVmmw6qnjlO9ybf8VlSC7UY+Eu11hVfBlH8BxoJZwaJGLIdXEmHzVjdMq2vnZQ/xZb9UAL6PqHJb2rUb3WGrRKza/tJFCIrPRvJT0nbx1MQhqJ207jTwgHva+NGPj740nvDbWfDe+b9CR0dHUkI6bm/nJoNacG6wqEV9ce3XAnCG/RhK8P0Aj9wMU7XUs5KelOeUZjOOt3VBG+FyyjP/mK5Z34Bu2l8wtIngkJVjY1odhmTuYwJ7y2A7eCa89BSfGnBJ4m15318mK6illiJCPe1w/EvgtWvw4pL1jJ67EC+rdzrY6QpBjKi2VNybnC3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7288.eurprd04.prod.outlook.com (2603:10a6:10:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 05:46:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 05:46:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 3/8] Squash to "mptcp: add mptcpi_subflows_total counter"
Date: Fri, 13 Oct 2023 13:46:38 +0800
Message-Id: <4f136ef2b23fb55e2e42397f1e07e74b355d5f61.1697175899.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697175899.git.geliang.tang@suse.com>
References: <cover.1697175899.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0036.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::23)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b93191b-3255-4742-265c-08dbcbafae73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8GtxBzngQAotbbTj1aDXqrBaXTUOobJDXDBDxagMPSPgmsZ1S6QI5pH3D2hbli69i+DLuFsaLL8/inhUvfayYV9xPa70MR24Xfw33ZXuhdjImJLQpsQUiaCXfU5V3fkehULgGK60fNOALI1m/sEbN02wEuvuG/PVOg7RW2rNewaVmhK71JsmrxEjkjKESMWYGxDjShjO7uUJfIb8tZ/9L1x8YbCIQxtB6uMeFEqCzMTd+VO3XYSl7UIai7ABfiOMAiys3MwcwhVONgbVrg/PZFbXn8/l9PsN9HLtHuMYhhAyaIqga3IgoGulhyLExarROpDYi0Wm9VYs+oG+0STDNVAMuStr6mzdnZ9ESkNfiBPI5fUrYcgvUsqd4Ix8upFRjLOaldtFZu4CS4v2stwJE6QFgo94vqbxz25bfBQ3o2vMZ0j9O85MDtEvoKo8o5GJEumFpGhuRdCdrnH5UVOtMnSp7WzL4wmO+HIEPHoyVlGDOAcK1UjsOM9IlZyORO68yn68/YqYjh1wFaa9WPC++oTdaCiJpnKS4L1qHbMMfZqlYaVNwUjLCTKRXE7ga/t7VG7ZdBmlbCKX6QXkp/HHTqBYPidmxmMe+alcqtFxi4M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6666004)(2906002)(6486002)(478600001)(4744005)(41300700001)(4326008)(8936002)(8676002)(5660300002)(44832011)(66476007)(66946007)(6916009)(316002)(36756003)(66556008)(83380400001)(26005)(6506007)(2616005)(6512007)(38100700002)(107886003)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MqgQ9uaRIiHRahFos0uqpDGTRiW808DHMutg05qOzOMWNVNw94Z8QG5OrauH?=
 =?us-ascii?Q?pnk/IDz1cTjUCKxX49YVrEsbZRBF9+jTvyDhiw+GJ4lst/s3Yc0Ih5fttPK3?=
 =?us-ascii?Q?vExquEOMErXJoUuMivxz+V/0yjHpa9zleWMTjRVBdzl+q6xrdgXSCvSv6PdU?=
 =?us-ascii?Q?jtmmcBIFnNUcpxH2+mntgUUDCSpBpNrOpDF0vuKiWjK7EivroJ8s4TF1GexB?=
 =?us-ascii?Q?vyUSg3zNboFpN23/5bcFOi9PRpLoB6luEaX0glNsiashfPsfwjkbmGOr/zDe?=
 =?us-ascii?Q?Ghk4CwZRRPRzYWXOdIqGoPQK5K8L+KgwWnXSxdDlAev5CWLeIgRwR4B7zewi?=
 =?us-ascii?Q?U3DQcmp1ICDxLaRZiIFEBkfA4rbdlw7aI4NhG3/0UVQlObsXVxbK+Qngk5Pd?=
 =?us-ascii?Q?+NwI57HeYEBf5hvBQw/+ojgb4TttAA9WtbOs+zxtXqdoQbVY2ak+hTQ+n+iO?=
 =?us-ascii?Q?jsQzV9QW0QCcEpIyvTw4Sn8ZLjcCtPaULJEpy0CY81Sz5KxdOI53qKL4Pppy?=
 =?us-ascii?Q?Ip7YiZflgl6i9Ct2F4O1f8Jfr62L1B9fR0JvT7rPFrITpcNAYbiv5BV0AAcU?=
 =?us-ascii?Q?cJngUda7+R7wiz+R+2hOK41pR6qZAgFDAizrRrLkL1ajeiIVqAWLBywCgU3+?=
 =?us-ascii?Q?ZjvgyQDPPdSEMhvV1F+E3rwEiqGXhByYH4DQO2cYnRZv3iHoGzaARilnkTqq?=
 =?us-ascii?Q?OU1IsZrNNd+IMlclJChCuP29d/vVmJBYK/+uNUgw+4I637GeQiC1bZxudwUT?=
 =?us-ascii?Q?DkIg0njaZu1h6vAq80/Hp4F+djs9XeaKAU/8bC/a3zLqxVP30bOtW2akH5gE?=
 =?us-ascii?Q?uReHoNwbh6VMD47G7ABf2mjrwuSp3wtGQc4rxw7eCf6n+CIpg5TqnYDEjgsY?=
 =?us-ascii?Q?4NYQSHp/xDQzjQCAs90d76Ev6KvnfqPoCJiUjjmP8IDGnC17I3gGi6p+Pjov?=
 =?us-ascii?Q?INBSTxFaih7OCNFBtSBFI++3DWme7UxPBzIqMbALD1rtycq+YbbGF/0r95SM?=
 =?us-ascii?Q?VY6PtlvW+MwSA6g1fqtURyve4hfS/h/V/tH9ta3lE7XSa5EATF+WEl2eskqO?=
 =?us-ascii?Q?RXFdYZucXTje3Pa8Dm5GjRcsUJJ3d5dNKU93XSAyppjk+h3NQJBfnNegkvhN?=
 =?us-ascii?Q?CGWqn0AMrvA559i1WrJOIE2OvcfWopHCxvJkatYbxt+HnkrUkATiemL3lVsN?=
 =?us-ascii?Q?5b9EtyQqsGOhRCv0++/lYJWf0QUQOgd9CJ9GiCPoTCfQIjU+451UrrdbxQNz?=
 =?us-ascii?Q?CFrFNZ2p4xbIz3J68lvgLnkg3qQex/E+gt3l0YCCTZ/l8B6BSco0oCN+sJlg?=
 =?us-ascii?Q?MB7OYvQL/Bs8Yjl/wXYi0pHIrBxXy09gHTDnX8uFT/me20iODN9wgDotRT3W?=
 =?us-ascii?Q?an8pTIjD3suc7L3G+/Jd6i6U/tYC1bE3xmW0lZ3FYVb0DF5KgZdTNT0p7GZH?=
 =?us-ascii?Q?zs+TDLYiyonUUnibKCmfp82DSJvCV/Z0LRix15836M0IwCto5dnfM4NqYJzU?=
 =?us-ascii?Q?aoQp1vzrVe9AuR7J/FO0PPBvuB4X+bIkiz8lSDZxX0fSITPPZHbxgzA2oBqT?=
 =?us-ascii?Q?SZDPFJgWV8/8goE+hctaQQxyq7m6fhZAXRL7NTxz+eEB9oNnXqNVBFx/k7Ae?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b93191b-3255-4742-265c-08dbcbafae73
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 05:46:01.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTqesX6bKuRF0d62cN+EuoU0N5cq+JVr5IwfvH0SPTZNYDPImRMh0DFGTzd7eWCLqmFRx4ShqazjXsfmZlU9AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7288

Update __mptcp_has_initial_subflow().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6508179e94a6..1fb4ac3727c4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1081,7 +1081,7 @@ static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
 {
 	struct sock *ssk = READ_ONCE(msk->first);
 
-	return ssk && inet_sk_state_load(ssk) != TCP_CLOSE;
+	return ssk && inet_sk_state_load(ssk) == TCP_ESTABLISHED;
 }
 
 static inline void mptcp_do_fallback(struct sock *ssk)
-- 
2.35.3

