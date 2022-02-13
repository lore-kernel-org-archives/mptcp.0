Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72511373
	for <mptcp@lists.linux.dev>; Sun, 13 Feb 2022 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644763822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmnNQ8I7yi53PgKS5AW9GSIuCr1OpR5vFPtKocG+LjE=;
	b=m7UadL6aya7/MoQXH/NIR50JeGRvLLg858gh5iDrjGUQ5iVQrKxfBrfEdENMt+PNSIk5TB
	uL672k05VdYxdV+G04gYqWzT2Sq9ewzKcFBk9fTxtb6wcyYInwne0qW0JHDsm2cNaVWij9
	0Fd9q2SKGXGlY774tUfKMOeS1b6OvM0=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2053.outbound.protection.outlook.com [104.47.1.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-pFIjcT3GPv2QrvzYibDcdQ-1; Sun, 13 Feb 2022 15:50:21 +0100
X-MC-Unique: pFIjcT3GPv2QrvzYibDcdQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvCSmHbg1NXgg+jUPkWlLmkTWoBgL/t79sgUVvTIkrpx8ycHYbvbvA4eR8xDcPMugXMrJrZJYG6wpczxiTNPtEw8HIVDB/x3qLRAN9oZfx9CwcZ65f0BDq8n7Wd0E1+8i3DaYhf/7T6e7rerzhX53NOGk/v0Ns6mhuppZKtoVZ23D64BtFz7OU2artiknRuqcqOM0qhKzZ8+r+L1zSDYqjeqDl9vI7SMuWr8CGNi3bZqaznqQgBwZ44ykg4gn9eQ9SMZnQn0Tvh7mfkfCOSsx2X2xgCn9oDPxRxa30QkFBLZF9JnQHzcwzyS9nqxu5SliJJIPyrj4qNG9oVfVchrIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dlZ6mvFvziLhG+/zdShszurzWWe/RgE86pGllWpX8w=;
 b=CTPO1p9XE1FZL0d1FKS/1Mr7T6BrTFln53ZhMYrG+ZHsiyyMlZfbZYtndezUj4E+ZQF/HY7I8MioHD/o6BY8uTIVtwmCGs/qXyOefmG+nTO4t6/qwo7Zt5NwrjMDrwgBuwKgF8FY+APGaVqArOAdwojXVbcUpO9BgNGW0TGmzUzBz7N/yEpbujFwJLLvdj7/EyZGSe392D5jjLS6Pe0XzHNLPJa2PrV7D7+8FV1PwO+Ls5gaHES0foUxcehDZzSbyLTVJ1XRKBRYMJzJWqokPXmqt9dak9ogkjA9qwt/LAimjkxmOrF3XlSv/4onFk9FwkwIhJ5nS+4uufxAEFbzVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Sun, 13 Feb
 2022 14:50:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 13 Feb 2022
 14:50:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/6] selftests: mptcp: add the MP_FASTCLOSE mibs check
Date: Sun, 13 Feb 2022 22:50:32 +0800
Message-ID: <6ddc8dace646141f6b64066c1626e40bad76804a.1644763526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644763526.git.geliang.tang@suse.com>
References: <cover.1644763526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0019.apcprd04.prod.outlook.com
 (2603:1096:202:2::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 867ded41-e529-463a-3519-08d9ef002879
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4845E75C2F1CFAF7BD7C2DA6F8329@VI1PR04MB4845.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i4ok+flICnXc0GwEMGDz+eExjHkb53IMjNdjltH9SDOevFbqTVpysPBX3AgFezyXN6cE6VZKB/W356PyhqCMWJzMfpx0dsRTikCwa24S/AkelqQT2pTNX5MiQIFxqELGj5f/3xpEp81E6IwJHvlaoxM+pPrqoo7KWwbdbs2sPoUTKn4HyWLe4K5xpsfAF4mh7F2lpeIx/uV0L+YXeM26nRI1jRGwQ8XiXzXObQ2YozAnUui96NAGiheo424kJiXVfvyFEunYv93MneOEj8XRoDavOiKdIRCKZ+CZVZ+cW6XvpfswLFet+lECNi87aCIzidmObzjGr6VOzIJYyvj2+0VXPL/5zlpW59FyQdobngMYFMYgcvsrfMjMB869R4LasJ9xzpqe9aCcVWFSTt3gp82aFSZXwAel/gTK0XYK4OnjkMWF3I5hyXtUFcwbszpt6GP62pN3HvF8VjwZEVExAmBWjm5LrCEc56GpcGjRVB1JGxelOnZ3HegJeV8XpukZbMO2vGOPv2ZVX/2dcjiEsMAZ4G3GVOYl80BUsW9lFYF73yVNqEfh0tVeyFU8BjC2GnVn/iSzFBRYO5C9xAtc2/Lgf9PJD4cFmU1EptnUC5E58ySjucC+JoPo6thZE9m9fkUHgjWCLRI3I2OY34COYw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(186003)(86362001)(83380400001)(8936002)(6512007)(508600001)(6486002)(6506007)(6666004)(38100700002)(316002)(107886003)(8676002)(4326008)(66946007)(6916009)(2616005)(36756003)(44832011)(2906002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rpT93lVSdCn+Bhr0RARL46Eh4+TErDeZD4HMj3WHpqJwNV52fFl9hzuNarUn?=
 =?us-ascii?Q?sQCp6OmhJIIz+KBYdbXL3EeIrdfgcPbEE9UdDx7fw5n+cZapVWQpessZ19TA?=
 =?us-ascii?Q?69l4R9cYYkMkyglVJuqDm7ByHFakW4BXB9aj9zPlDc/FbaHP83vTTGD69Ar8?=
 =?us-ascii?Q?6q9EZ837tfb6XChspxrdQtZ8XJTVOZRhb902eaMh/4oMtGQNtSUjXXyfWPNH?=
 =?us-ascii?Q?xNxlXpZJHBg4lxuRM1S4UiTGPu0lEtUd/Xc7tv95yCugkwRviYWS8Bz7DAnC?=
 =?us-ascii?Q?PTdN2beXFkJKP1zfg51E4o+9W9klcyAyNeabHmZGbnz5vCyNaG/oU+YRQ6DS?=
 =?us-ascii?Q?0hgYqVEqZ8SIS4r2s022uYLxcrh7tgMS7bwUF8HuDVTukkQPxmgttYXgitQL?=
 =?us-ascii?Q?zFx5eSxMQQA/QtFxkdzYB5YqlY2a/iTwrNz3RV9qTKs9NYTx6QGJO6TnPgBX?=
 =?us-ascii?Q?Clll6/t6RoLWuAR83b5cH6zRoZTV/wjK5jzIUhswAXaFx61qx/wA27vaCsNz?=
 =?us-ascii?Q?Ty3gd7i7EA4QPYxqKrNm/tUo1u3MwmLfwAWgoP6e5FN/MEVGQIxLVLPWyvXy?=
 =?us-ascii?Q?Iw4DOx9C+QG5z+LD8oTE/bUHkb5NQbU7lQJZt3VgZ1AaFNsJ5BTL/cfq2n2d?=
 =?us-ascii?Q?Llo2vbTfhDp8aVNw2YTXcRrcgmpmWw0nzjKHQl54xQjZ/+/ITnUutvSt93QR?=
 =?us-ascii?Q?uQIyXumw671Qt4uLZ7Yau7svfY01owpxRC+XYZZzsofippr4pitjr85ItIuK?=
 =?us-ascii?Q?BIPuKEpyjWcGBvp0INbjX5gEa7gJssfEw/MLn2p2eC6JqDJ7sZpwG6me0jTq?=
 =?us-ascii?Q?cxiX1IuiQ3LZ1YR0XLLkRymyGyqXrO/fyzUTyxcfaIXxvItnlYpGhV0mjjKE?=
 =?us-ascii?Q?j+DYGxorUeVlMJS/Fc3n+2wa5wBkjO1egapaQMsH8/vlB89dAOq61ST9HMIB?=
 =?us-ascii?Q?j7w6ttE0B9FEqM2cQt9a5MFqCBv9hpn5SaJPUcUd/KADvzV5eJ9A3b0N4gGu?=
 =?us-ascii?Q?7MSm8ZUhBl7Mc/3bRh/cnHN0bsEjdeAJ94qVkfCLEd/mfSA3NVEcsLu9Mo8X?=
 =?us-ascii?Q?aKZ7ebktj8SOgKeHRZQb1F7TgIutCdcJqSEUZi7rid0wUPsNDvrqqc5f7Af9?=
 =?us-ascii?Q?sWmXZqS0YsTm8AJnQf3Kk0JuedpqKEocbyvEWPBPNznzWQ3XS9kS+oDHYg/N?=
 =?us-ascii?Q?L65MAe2d6n2w23J4jjIrezwgo23GImU22Y8vj3bxLz4wOIiDX+FtbL62HDf6?=
 =?us-ascii?Q?7Clmxi6LXSALOAV7zoL/zk5LOa19aq6/w62e/oCSTAc4MgkBotixdnkSLr9t?=
 =?us-ascii?Q?mN94Gjzs+ffdaVg0HMzw3/SpI8S+73XbipzU87FA/0uOBe4RxCE55OrXEKDj?=
 =?us-ascii?Q?DbA/jPw11w1atom7FGNRYGpiLLxGQ5VTjikqzoOHh4Dm8yZ8X9EUD7jv1trV?=
 =?us-ascii?Q?kA34VtBIfDplyZK7/CU11O+1fHASxI3rMAciYkj8QoFoq+NrAAfJW4PiqBoE?=
 =?us-ascii?Q?Eb8/QjvPhxVuaY6/pWJdlhiJV7cnVIcpPg+MyBkAOpWsxDOKo3Na3yzv1olB?=
 =?us-ascii?Q?enMYifUZcAI0ncy89RVLzSP1lqmotqeZ1w4fJ0PG/geVnTWjFKoAVlHYeUWD?=
 =?us-ascii?Q?BJg4WbPMJaw3Kqgq1U9ZpzXSk+vBaUARhwmKfVrcgujFf5XO2RVFrVUvyRqQ?=
 =?us-ascii?Q?EoRxNDNCbo6HqgRIIWDghp7gPqA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 867ded41-e529-463a-3519-08d9ef002879
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2022 14:50:20.8643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpZzJOguywAowzxSzOEDLarfTE4OLxJ+KidUPTs3stQkAfvNqO14vIxb/o9TN6RHlB8w7WVrCOky5xkAeT1DLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4845

This patch added a new function chk_fclose_nr() to check the numbers
of the MP_FASTCLOSE sending and receiving mibs.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index b48b11714817..f71494b87d5e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -834,6 +834,38 @@ chk_infi_nr()
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 }
=20
+chk_fclose_nr()
+{
+	local fclose_tx=3D$1
+	local fclose_rx=3D$2
+	local count
+	local dump_stats
+
+	printf "%-${nr_blank}s %s" " " "ctx"
+	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFastcloseTx | awk =
'{print $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$fclose_tx" ]; then
+		echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - fclzrx"
+	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFastcloseRx | awk =
'{print $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$fclose_rx" ]; then
+		echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo "[ ok ]"
+	fi
+
+	[ "${dump_stats}" =3D 1 ] && dump_stats
+}
+
 chk_join_nr()
 {
 	local msg=3D"$1"
--=20
2.34.1

