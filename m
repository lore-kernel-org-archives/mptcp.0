Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5A02CA8
	for <mptcp@lists.linux.dev>; Wed, 26 Jan 2022 02:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643165792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZoDTd3qzDZEdbvEYaOh+pVxHfZFCxp3uTEhR+SpZ4c=;
	b=fisfJ8YiWMpQWHVO+Iqt/4vw8ATRSA8wMrAsaS/eoYy0KILTwFFmZrE+Kma97T1qPDhPi+
	JVDfJ0UWltubp/ioByokywoVBkyFVtXX7sl6AIADx4tahd2T29h/Z8X75iLSFRwobl9ua9
	JtvUl+dZVHJHocBZaTlvAzJYGhhgWVU=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-14-1HtHBEYFOqOfmC4NT5At7w-1; Wed, 26 Jan 2022 03:56:30 +0100
X-MC-Unique: 1HtHBEYFOqOfmC4NT5At7w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNuqM1/x9kiEl2r+6NFUtSaN5ZKlh6Rd5+wOFy9XzxxVeWOl7wMCMJGBLobltZzmahBHTDKIYJ1t711bG61xrrUJrWMUSmpxTIA/eeaNIUv+gl/2v5Fp5K++95KWoLaWtdKMIv5e2IWXYRW5TsSGq5APEdEiPClrMUcoX2ZXJabXpr+m5Iog7bkM2dOy3+ZO4o/xzc/Se6t75TP8+SnCu9b6wJLrtmDLa5PXqCYhT4BRMZkIqSMmZn/gsqOUUnycLGkCmno7IpAFh74DpKqbBpUqYtyGYIQlkCneEJKDNQI0kXSt2WFQ45iipZAvktz1g8+lbG/9lRdhlM7Tg0O3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6EOH0DSzmbKAw17HJrJ11xbXm7bQGxiMK2Mku+JNkg=;
 b=TDhGlN1x49HmjBa8MCD7BWv2w0pzshZnEwkVDd3CUXr7aWc6OIx67zQYt/DtlFJs0pbC/sQXjGgv7t5jsb3tCqz9BJAy+hVMkoeaJbVZPhaQsqn6dcmEnD8OkVSibQNByaSLvzIQ/nYtlkLWLAdvPE3/d57aECpRPulB3/w8p+Y814JLuwFqzMyhpC8IRvtURTMmfvJ+2KrDGrC1Q6FxeN6zoTUM+b2UuFA2ILIiLxaBugTjUZevO+0dJ/GoQXlSoTaAXtx6Hhj8ahF3hcXEuFZjHeyVdkGoLKKkMOgkqMidewsJ7qVXz8rAP8je5/2wChWma/0+KJKFHPPdymB3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2391.eurprd04.prod.outlook.com (2603:10a6:4:4c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 02:56:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 02:56:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 2/2] selftests: mptcp: add set_flags tests in pm_netlink.sh
Date: Wed, 26 Jan 2022 10:56:23 +0800
Message-ID: <367f7b638bd85634f79aca409139b1b00250793c.1643165468.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643165468.git.geliang.tang@suse.com>
References: <cover.1643165468.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0197.apcprd02.prod.outlook.com
 (2603:1096:201:21::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aa26958-ee07-408b-981d-08d9e07773c1
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2391:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB2391055BB675C39C7A5D00F6F8209@DB6PR0401MB2391.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	foZ0MOEkdGxNjlSJpxn7nMijxQDTa+fGQoSquDomxKr+7P0Eaf2U+kox8tEeuBw9QVfIBDCKepE+FXFVu7SJvaLPSyNOxKXMHXhCRwrS6sJ5zvkiOhjwPhRf4D3QcQC3sGiaTetV2tJ+xRLam45eTMebMsc/AAv+9uEL/0x+A3+E3v9/RcVtnOl+B5m5xUccem6blPAxfOrQnAF1zW0YsKpqheErtlKRPgBrlDGeLBSYSbW1CUZPBo2OAjoOFggkyROlFZRfdm2RSyt7o04gBTaGSSmf+FZx1irJe0Z/yCHOto48dGZIcudr3ewFsmFWpDmflK5NAk3J0hgjQULAdfnCFIiFcJnsU8Bbgy27Wl+5h2WvV233vVQLojHcBhDzLFvRAGcN1o1tFRBRvaw9r4QDyiMWyVs32yPc/mZqqGHdyJaxE/dsOrcL7FC1XF6nv1TFaudX2rtUOruXnYH8gTG2K8P9qY9EilutvaSYTPolDWaUd8DX9YX0I3MFNDaD4jZaOhk+3/moCqYbZhqbfpFY2OxrQsRf4M/dwPvhGCEV6y5hF99KWNW3Ulfgx0Gi0DJOw+epoFvanbtTsARcUZGOsMQyb8WD+aNriBu3xHfOIZ5ulC3yp2CAAxre/6l056xBO5e3tNdxVujfW633DQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(2616005)(36756003)(316002)(186003)(6916009)(26005)(6486002)(66946007)(66476007)(66556008)(8676002)(5660300002)(4326008)(86362001)(55236004)(6666004)(6506007)(6512007)(44832011)(8936002)(38100700002)(2906002)(107886003)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SRdUNf+yXS4Vsn4ccR93R9r2gRh6m8Gxb4f2PM8iYG8eeeDFMRfY95twy9Za?=
 =?us-ascii?Q?KFhnjNSb7b8d2mEVoM2+Slpn2HCOZeZn3kXnx71fyfyJgfLnAsuE1MZ/K5S8?=
 =?us-ascii?Q?NnJJV0jBAHgZU4YTb0+HIe2p+NJoUwbmX7f/+Ez3ssUrAjXoQSU42FyV1cTh?=
 =?us-ascii?Q?iFyPlLRsRtfPDncw3kQZ1ZldQkYKKuVkmuh6n2PA2JlnGrWsfZC3coPVPUvU?=
 =?us-ascii?Q?i6L7UZMvDuOGXoEoWXAfuHkFTCmC91dyl/ojhYR7WD8BsugmwlMGycJCE6oe?=
 =?us-ascii?Q?WFkj08pHEdXI8RBY7ydMrR2CJ+C2uFTJK2tpugQe55BThS42zq4Z+z2awwk7?=
 =?us-ascii?Q?icEuZzobcx1chVPJfF/MoS47HM9UjuY15NMcfBPPyL2yLaFU6EOcuw0o+6kU?=
 =?us-ascii?Q?40Z8upS7wLkPojTPMlwGtlvYYnm9YC1Ls0uUSzgnD51W0skUrc5yJrGAFtDm?=
 =?us-ascii?Q?75hljz/ti1de4bJP7Ymdya2DJDOtkCubwFXde4fe0DuoqdQ9daXbqStSeC//?=
 =?us-ascii?Q?mev0iwhwR81EBqIBiilt8FMJCoeMqThsGTA0NmDwCz77GlvGcS6f5bDFJSwW?=
 =?us-ascii?Q?pfVtMpxMx4sB8NKbkWPG9qWdYREH0/smidDN1IJ2Wi4O9nnasrH5uFGhnEW7?=
 =?us-ascii?Q?NoZckuOl4QodXZIFBcoPIN1i6EmubtEPFnoAQYwdVUdFwwthiWykjrPOGICG?=
 =?us-ascii?Q?sfR3farzGN4GOEUWNUKcuASUz+7kOwu5IpK5kX6cajAOzLcUj7WYFAIW8GRR?=
 =?us-ascii?Q?g+2xQJfTAdhdckNr6pC6NK9+qnLQy9GPnFDR7Y6HWWhV/OQVWqK5uF0XEuyx?=
 =?us-ascii?Q?8AWx9gxL25wTmeMKwo9XssW4Qd6O1zLy8cZtymzw+xFWf0neoeYmPCO3p329?=
 =?us-ascii?Q?ZGHr0y7oMWzoYPFnAnUuR9rRqD8jkzCLxbzOAA+9VCGQtFM/UKu1riKIsVtE?=
 =?us-ascii?Q?0ozuQVqP8LBLXfie6ozms1RlLhQz6XASlzq28NLHC3AbyQQm5znD/yqwhxFU?=
 =?us-ascii?Q?40FNJ+1P2F+o6cyhxpgdci5HJVLvTaLA7T2TDyZrAp9Wq/xBHQQ6/tIdsgQL?=
 =?us-ascii?Q?zEvNRjaBR1PnSIM6kaNRhov9Q2yQR9+w3VI9GztjkklXMOsgIr/LBk9C6IDC?=
 =?us-ascii?Q?1t5UFK7h1rLIFUHxuVge/0VKMG3If2G6PjhyF8lwj1MPSeuJ4M0W4nkd9tEC?=
 =?us-ascii?Q?D3zvWUGOfsV7Tkn5BS8FMmz72EBa69+/8R99PWKSCzwPfqRFXD02CaN7JOg6?=
 =?us-ascii?Q?465VAlUpZ1W9pFg8PdeRrPAIDhFVb84ek3EemsNDMYq0w2lHDEWL5OLFfifN?=
 =?us-ascii?Q?VKmmTW96/vHSSBvjz7jDtJs/V79Sf5FAPZpebllXlNZhjmnbVjNvP74mkUUv?=
 =?us-ascii?Q?XIRnavurihxfMP3EXvqDX7z5WDuoBmJ0wwxe3cTudEfjM+Op0pJqRqmoeXfT?=
 =?us-ascii?Q?wFIxla1egVsqUB1UEmidFBR+Ja8UDgbBoQqJMAaRf4sI6Eo6iSisBK+o4HY/?=
 =?us-ascii?Q?FkvGCzxCSjdbnbvnBv6gwOShkQy8YHnvegrt8cROfnUjKhk+Vlbb5GAQlOVh?=
 =?us-ascii?Q?LR61IITpe7pvilZLnBZOL0cyWjxagPOv+WvTSHoW1tURO/GCKjAkcAQyjfuT?=
 =?us-ascii?Q?oLap3oSDzE+RL59P9SJ53Jo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa26958-ee07-408b-981d-08d9e07773c1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 02:56:29.8370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yo3eC31ShrNRtaOqWE0cNz+Lbq9ym9cRPCQzmTXqFJgODlH7p5GyHBDnEJK4r6bM2fz8hHnLZaxSam4BpGYfQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2391

This patch added the setting flags test cases, using both addr-based and
id-based lookups for the setting address.

The output looks like this:

 set flags (backup)                                 [ OK ]
           (nobackup)                               [ OK ]
           (fullmesh)                               [ OK ]
           (nofullmesh)                             [ OK ]
           (backup,fullmesh)                        [ OK ]

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/pm_netlink.sh  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testin=
g/selftests/net/mptcp/pm_netlink.sh
index cbacf9f6538b..89839d1ff9d8 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -164,4 +164,22 @@ id 253 flags  10.0.0.5
 id 254 flags  10.0.0.2
 id 255 flags  10.0.0.3" "wrap-around ids"
=20
+ip netns exec $ns1 ./pm_nl_ctl flush
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
+ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags backup
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+subflow,backup 10.0.1.1" "set flags (backup)"
+ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+subflow 10.0.1.1" "          (nobackup)"
+ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+subflow,fullmesh 10.0.1.1" "          (fullmesh)"
+ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+subflow 10.0.1.1" "          (nofullmesh)"
+ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
+
 exit $ret
--=20
2.31.1

