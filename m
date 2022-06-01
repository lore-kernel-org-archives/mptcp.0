Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC39362
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 06:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654065992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mM3+XND7/C7tWp8dWVpcgU/hF1flnJ3n9SUIKtqoJ2A=;
	b=XgDpfKJJWi5a5Ab5XMI+VxNKdnDGxsq8o3ufpB6QpBqtSJNRkPksgLZ/9TUqJsmNXf/WGF
	TeC8ZarrX51PE8IpKfNvNiapklRbiAv49GtJm1amT8eQUGNRTWoYO6qhVeeTWDQsQdMcyI
	1Hu2vB+4WDI32Yi/wv5sXGi1OfCqVSA=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2059.outbound.protection.outlook.com [104.47.2.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-bc4j85UHN5apuRQ_cEP1ng-1; Wed, 01 Jun 2022 08:46:32 +0200
X-MC-Unique: bc4j85UHN5apuRQ_cEP1ng-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmNpVwep408fbcvJHuHJL/6unVWXmcXmJCgYYCw0wqvE92x3mz63SW0WUmx9km5Hd7Mh0zjbrtPzqr7QLPCwEjAjsxS6uEHnWlYeruZLN71I6AVqd8AmLCbV8cZ2bkBUnhhKzxP2JGxeDCaUyN+rqZF/8F5a2ol/6BK+BKnkhGQ9dzh+leze7H/QrqVON7vFavad53JiTGzN7Tw4z2Vkeghaxl9EgqCsMlbnyUcrNsHCgGqJA9242G/HjEmwCtxg5nWS2TscUDSfw80uVOliz1AgvhRF45eYv9oN3GsJQZqShY5+QoGwm3WmQW9aazIE5NlK436Z2zXoUdQ5pIJLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnB6QZnX3QjWi4Q6M3PhES5A94xjRZKIWP1wm4KUspo=;
 b=jKzSwwoU0XOAdjqxjnjRWm8qAzhE0h3AieofEroCPpD1sl9PJt4jk4b+yBHDTZdmF0YpObWVzB3YFiqpIppBvXM1Lx9gyUWNkBAoEAQluVPCnhzeWvrk//tKfNZuc/E1fTZiHpfB5MW2E8pGt/075uL2dHe9eGo90w3SRzdqwMo43tJuDBQG6gsSDVXjGKxRjAAb4vw+mERbiJosk4dEa6yz6AiUbaBKIM8fOqM1wN0nsmhry1NxLZ8CRNZWxOTbEGUpVaD7GlHBYYs/EHDyi8b95EmPVH+xURcNJF0475Yi9+oNzwUN+MB4Kr9ZhxoDYvrivEp+j3zxYFPUUgwg1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR0401MB2434.eurprd04.prod.outlook.com (2603:10a6:203:35::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 06:46:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 06:46:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 04/11] Squash to "mptcp: add bpf_mptcp_sched_ops"
Date: Wed,  1 Jun 2022 14:45:53 +0800
Message-ID: <1f5a7207b53a8e27a99c5c037d6e7dea9668b04c.1654065674.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654065674.git.geliang.tang@suse.com>
References: <cover.1654065674.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0213.apcprd02.prod.outlook.com
 (2603:1096:201:20::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d207fc2a-9354-47a1-a085-08da439a7586
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2434:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR0401MB2434E80D9E0F278AB6BB87F7F8DF9@AM5PR0401MB2434.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2jaep5wKbxISU/nSjLtkZ7Ia4pT+Xwth0Qnb9UlFOn5YQW7+pVR1mxHSYQH4QWSi43YpEY/YULj0pE1FaFh0rpD9JLy8IHQMkLgtm6W+aTqXTzpykYCzNwQtAu/d+Gcl/uY3A+Gy3fpzltYAQs7vNV8RRxXhDX+1WJDHFDDxJmw8lfLMtFj8FL47vXMxKyPqFf7CsJ3eMlInNN/LgHE6d+EoFYq/HxdIUcx2uDYzge7Rm4k3GODFZMNKEgNE7PT92I8N8Lz4BVkaYCF2f7wkrhHzISpIhHU15RvCIr4xtQvxVzJVwSqDbHXw52J6gzGEW2xUecn3eScuO5bR8WMDzXoHamnKjcKINxka4+clVeqqwlU1GFnw4X8985vE2IRkv7CcWai0lShPKtROhwt2XKPceVAVGulcsND7nVZHPq8YEbo/bsO6HgOe90SDR0o7wIXlS8LgxYY26nJzXDw4r3eqyvUt06QEG83X8F3nZtW1EF9bdoxp/pZBRbwGpJfcTAHAuFY1rPCdTLQkpzSijE7WZvcY7hzlp23LyjcfjnPiwL1Nua3udqCSS6g4StJhKGUniu4IgdkekXu1h4Sksfep5SUuJAn7/aclmi7irviQI3p3Bv8VhZAhw9QysGN0PkoH7M/gCWp63EMXlm8OGVzp0JwVgEa+bY4lcEcUMG/MruEhy+HNGD8oGcH3sFbU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(6506007)(44832011)(508600001)(6666004)(186003)(6512007)(2616005)(107886003)(26005)(38100700002)(2906002)(83380400001)(66476007)(66556008)(66946007)(36756003)(5660300002)(8676002)(4326008)(6916009)(316002)(8936002)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kJt8KEWpxMp8XXCxehx0hzke4GFbXRrRFfQu3EUL5EZ8JTQeshKzX15/fJx4?=
 =?us-ascii?Q?d5RPuSRrLx+4zH7UZrxp0n7yg+bfKBaTD3Ijgyh5s5RzLB4H1557O81kqpOq?=
 =?us-ascii?Q?DKeWC+9bC1fGJOmiEWjsZWqKQXsAxwpmPSFYsKfPaZTZDl4SdFk13bTfy1Tt?=
 =?us-ascii?Q?y/FEfGWj99O0BF513Z3qGlEsFkUGZvXz7/CrgLhmX5lw7iMZwK5OHFKcQh5u?=
 =?us-ascii?Q?4uqer48BlyqLgeq6YGibQbTsLs5CMhGedJFjCrxrLAyOJw6CJOcwwo1w6hvc?=
 =?us-ascii?Q?kJFsoBaooQvtOkOmda//ZYEAk1YVt2vVZq1BAhyGb8l8eo4/9qfPhWI1/lMo?=
 =?us-ascii?Q?USWLvJl63pbKEZMJohIOHtZT8O2DT4UpW0TdkeKyKpGoLYvrDcMFdh4Kh/p+?=
 =?us-ascii?Q?ZBbLM/kAEGBgwPdO74W9WLu0QHmyP08dBTQ1hkvsIKDi1XrElhxWKByqdDe2?=
 =?us-ascii?Q?XaJMURLrEYAZ1ubrmHMLUAdqMPjtmg/aQUrD6S+xdIbXG0G7AHMMhJOhoqUH?=
 =?us-ascii?Q?hzwSxU+NzUnJh5+XAWWpHHn4gOMX91yxj2oDXSr0mTYLb+uk+NS/fd2J6SC8?=
 =?us-ascii?Q?LGKEAwyeT2AQaMllBsWQ/Jo15WmDUzNC3M0v+cbyhp1tH2G7juLx2xM1IU7N?=
 =?us-ascii?Q?LLxsTIW4oIemKWNMMU4dGMvAnp6uuhQHmQjkrJAjidk/StOmtrX2NAuFbj92?=
 =?us-ascii?Q?Y10ZLFoc7zyAH0lMgrR4YFTuelxSkwjsnZbXS1uDDkP4gBQ9rdlZc9vNZtIm?=
 =?us-ascii?Q?oOHr+o8W7uBtYjnwZKn2ZipdOmXlulLJVfAx8Ee5TYw2B3JMRGQ8UQsn3rMQ?=
 =?us-ascii?Q?zIQhY+wqJjfemCMa1WlnmfA1ImK9KdZQvVIh5EutvU3DB2TOEMH1wAY1pw9K?=
 =?us-ascii?Q?LMuQpavhagQf/bPlQdvclM65A+zIM28e0AmVITccu6SmvvVp5Qd4Hs8BYR8X?=
 =?us-ascii?Q?BSCCwDpryHIkyR0BQgeFk5lhB6TPdUrf1eUWQzaeL/YBixQT+1nzTgVxnn6H?=
 =?us-ascii?Q?jwNRarfm6aW5YrZdOt/iBvMlV+ds+o261EfYyZhPeDnGXkTdH56zAf8uIHQi?=
 =?us-ascii?Q?b8+aRr1pfEYnknXDRWiWND0LbHJbriaomMizFdDgH4LmSD+VpwUyhTCbDZ7r?=
 =?us-ascii?Q?QPrVeoG3J/BkGBXxbSpFOK/2To1jOgqzRbYEbaLoOtekvmXia2IvICCVmQH7?=
 =?us-ascii?Q?HqlScpOXcHPpFSE75c2Qc2wE5QlmfCUqknA8KeNrOkmvb0rMrIpAWQ2qsuiq?=
 =?us-ascii?Q?UfMEqNe7KM3CtPHXG8Uige1J/74ouqA+4tTt/auN2DUUpjMOgWUEcEtcvRkU?=
 =?us-ascii?Q?rnmy/VzK8ypbCoEg7/ea6ys/iRidLJH4Hr9ya7zfIHYFSXNgB39l5b7PCOZk?=
 =?us-ascii?Q?0IXEUs1BQMbIkhsQCRYQzaExnjpJOGWM1LEDCzKEfCqW7y34ZgRIDYYDVRjM?=
 =?us-ascii?Q?l6kx+eNAclbrTqHh5QPZkydiVr3Mpsn/pDl6rPfXvCRB7WG5Q5y6oUXpapSf?=
 =?us-ascii?Q?aONAvC8DQdC0eSdBoc2pqZCZDs3KDfT9Kq4LBwg8YLI60QuOTQLG6CEd/vlx?=
 =?us-ascii?Q?Gd0kg6cL2RDrJe291bweYfA+OyPRZ1rzrxl22SYyQPtyu355g/41lKVhd3hj?=
 =?us-ascii?Q?i1f1eHCz8K3fJDr8mY4IoCJr09OCbmmNzffPP5RKl/nbSawjD+C4vvkKANgz?=
 =?us-ascii?Q?mw9QbX6qGwcY5qPaVJ4l1aC1SJl5yo4z8svphkxsONrG6UXhPSAPQG6DPHRw?=
 =?us-ascii?Q?sg1c5Nlcr81b4eW8f6mHQQ/Ro6MnEJo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d207fc2a-9354-47a1-a085-08da439a7586
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 06:46:30.7908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3liZezbffV7x1+Q3TekaU0frTNKHnq7b1fOlEtGORnevKRdBec/hqhSdlY+qy3qnevMVLbCaRUqvbGSax06nVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2434

Change the access code from mptcp_sched_data to mptcp_subflow_context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 338146d173f4..0529e70d53b1 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -42,29 +42,27 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf=
_verifier_log *log,
 {
 	size_t end;
=20
-	if (atype =3D=3D BPF_READ)
+	if (atype =3D=3D BPF_READ) {
 		return btf_struct_access(log, btf, t, off, size, atype,
 					 next_btf_id, flag);
+	}
=20
 	if (t !=3D mptcp_sched_type) {
-		bpf_log(log, "only access to mptcp_sched_data is supported\n");
+		bpf_log(log, "only access to mptcp_subflow_context is supported\n");
 		return -EACCES;
 	}
=20
 	switch (off) {
-	case offsetof(struct mptcp_sched_data, sock):
-		end =3D offsetofend(struct mptcp_sched_data, sock);
-		break;
-	case offsetof(struct mptcp_sched_data, call_again):
-		end =3D offsetofend(struct mptcp_sched_data, call_again);
+	case offsetof(struct mptcp_subflow_context, scheduled):
+		end =3D offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
 	default:
-		bpf_log(log, "no write support to mptcp_sched_data at off %d\n", off);
+		bpf_log(log, "no write support to mptcp_subflow_context at off %d\n", of=
f);
 		return -EACCES;
 	}
=20
 	if (off + size > end) {
-		bpf_log(log, "access beyond mptcp_sched_data at off %u size %u ended at =
%zu",
+		bpf_log(log, "access beyond mptcp_subflow_context at off %u size %u ende=
d at %zu",
 			off, size, end);
 		return -EACCES;
 	}
@@ -144,7 +142,7 @@ static int bpf_mptcp_sched_init(struct btf *btf)
 {
 	s32 type_id;
=20
-	type_id =3D btf_find_by_name_kind(btf, "mptcp_sched_data",
+	type_id =3D btf_find_by_name_kind(btf, "mptcp_subflow_context",
 					BTF_KIND_STRUCT);
 	if (type_id < 0)
 		return -EINVAL;
--=20
2.34.1

