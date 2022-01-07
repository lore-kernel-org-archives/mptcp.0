Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF8E2C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 06:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641536288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hf/U/VYL9BSCIMZZR0FhK0uFHbCyvMDDYueoIaW68k8=;
	b=aDdV5fShD/DNHvQBgEu672dgwnXpJCl7DnJ0FjCRreMtWEGIY3JSr7iTRQ5aXYeI5ftUiz
	RAGOe2syUmllE2tUJfGOAv97InLw+rvqc7JMuqUHeK5sPmNSL/TkUMTynbRQ2SIvhNWGEt
	lNXc7ha/v7C20aPAbn3WrOBktIPST98=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2106.outbound.protection.outlook.com [104.47.17.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-HCTwUF11MsWlYhvyp0IbMg-1; Fri, 07 Jan 2022 07:18:07 +0100
X-MC-Unique: HCTwUF11MsWlYhvyp0IbMg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vve7sTCwKsCMB9e7E//lj87uPjEggKBJCXI6AowJUTlAFnSyjF8nfi5CqWDQiJyzYMq5gdrkkqe0DhXIRl7a7rCXusOB/YdBh+DAkflRT5Inh+af+sxH/kwTU6VdfdPj2hKjkglRjWL32HTEUeXPpKBbfz7ioTr5TvhN5LWUmju+4hcpkkpXVsk2hPUrI9cwZi0RwwzfcvzsLmrF1enJDFHJGCaLQUAaDbSDnUUIuZll4Rts4dgoxDkNzZT6jqgk8QT42qjRmITkhU9EL1cgM5kHzIsBtkPg0Zq7y5S5onxCbCfD97PkMHhWcTDga/cmeedJG7ySDwLfLmnVPLujvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cr5G8LHlSQvwBE62MMnjuAa4Lj5vXn9dwh4QTaOLmzI=;
 b=iwayS/6rzK77TwEJo7CeBpxhpJEhY6BMP6BaIBqavM/MjHtTTvXiEGWXbPKrUof8kv+YVtEKZIQVJLFoWDJc9PYJxhFlFlLnBAyVYPaHWd6W9HtoUI/Z+YhmAZrcOiA6OaXSbqF07bK5NjHeIR7gcuogklhcVadJp1SftFFFcZr5sO429e38OUOaO49tP46x0zO+tiuh2hQ7c5YMTdkCi+7C2ZxC5rUeP+iB5CL26tCbbZ4is200I4bzZvMidT5s3Zk4Zw+PJywZB8r1FoyiJ9hiRSl8O7vXip24DeDXjQ62IErC83bVxOt7jDaGo0fKxpmlgOXcG4i9MZOEofeRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3369.eurprd04.prod.outlook.com (2603:10a6:7:81::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 06:18:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 06:18:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v2 8/9] selftests: mptcp: implement pm_nl_set_endpoint
Date: Fri,  7 Jan 2022 14:17:00 +0800
Message-ID: <f7b86a8bb99769cefd4e9cd7673b0228479a498a.1641535880.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641535880.git.geliang.tang@suse.com>
References: <cover.1641535880.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0023.apcprd04.prod.outlook.com
 (2603:1096:202:2::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e322686-8fd7-4a92-9511-08d9d1a577c5
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3369:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB336998DA5687A99294D86F26F84D9@HE1PR0402MB3369.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YR8593AZTvuwPGmOU21WsnGshIwKz89gWgbfRf5xe+rWaBU5ANB0/vaI1gBEYlQlrq53Iahs9D9nJeWldxm0lWdL5+knXBrNsS2diOX5LibukKmENAbPXqK4kyXryrTt93Zf4lyJGSnT43Y4VI98ZJhOH4QrZ+UMjdzsQDlhFr7PJjTk23/Ldj11LhB8Hs8cR6xbHeFjVIoVoIMI7mjFnb0yhOpQGKn7Q320QgBWimiE/Yntk5i+JoptemUXnJW2LGO1C9fbZNGR312GqKZtDgeeiOt7qG4Eu2r4ASpBc9Y6T5aybq6ue+JFScm5xr4Yrlt5R43dPrYRpA1NslmLqsmIkw5VGOgtrEs5VyWFin+q0F6Ug2KvdS7aSF8aCGzbWYipF1BapPuGLSiSgMPJJFfrX6XTDAlKSy8ve+C0U84kbA9LilhV60ajjxBAXq7SOKBtCxFpFNolFVD/vrjWeOG1+nVRhQukl7aXF0OrjYgX9iWJcZ8M6wDNLjUKYScBuZNkmqyV9b1P8SVrb5eKGrw+DG7JIE5ZY+LRc2DdcUMUT0uNS3nmmABqgP0euX4ld85dYEGbNrsHOElPITVdwNweKuWWkS7j4QE1UEy7cpSPfDgEGg7qu++IIl6GEg3m7RFMtLz8YnawGDRpWEyBIQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(6506007)(36756003)(86362001)(55236004)(6666004)(6512007)(8676002)(6916009)(26005)(107886003)(316002)(5660300002)(186003)(2906002)(6486002)(66476007)(83380400001)(8936002)(44832011)(2616005)(66946007)(38100700002)(508600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GsNeR+//B3mO153+qHEcP8qqrZiQ0O0EA6lziPevOEu1GN5En0oYU7waQfe1?=
 =?us-ascii?Q?Cjzai1Gj4qAyXaUnUlvU6mSRkmKsB1xtxVKGYy0OSdcAK2uF9yUXTOX55KV+?=
 =?us-ascii?Q?SQsAYOGkgE+dGxP8qZfLsYWL43WYm3E15mUZa1QjXb0cRkrihy+EMqVgF49D?=
 =?us-ascii?Q?2ZNOO5/J31XRV2AojxiuXgvSb4TMLu867oORYA1lw/l1IEEa4BP6+OOBeFsj?=
 =?us-ascii?Q?xEob53sYcOIylvuvfzOKo0/JYrQel0eE1XWaHI9t78HXXJfgs18V6RsVgmYd?=
 =?us-ascii?Q?YAIYivbbNuAx7JshITxbtyScSWMh4hvQ63/sAi6AdoCoYOLVXdsqQtMVx3Xr?=
 =?us-ascii?Q?N4O0I4ZoxQEbE0LpnZJBapWVbantzlNQn6zL1Gz/RnbePaaR/gG9NlCB0OdD?=
 =?us-ascii?Q?FDzJivwlk10S1xzu05S5E0ueEkCPIV1cl4UGyWt3TS4OuI4QJj/Rn7mUe2PO?=
 =?us-ascii?Q?kjFlxmdXdq7ynP6X7JRB8Hwx1vxBzfdKJE9CJtoIc7b3mClj2SJgKHaSEPq0?=
 =?us-ascii?Q?+mc2V9N5ETXvH3fdqbKpAYOaIg6XBKpd5nhyPYteh6RGyeQ0S5xTpsaP7fQ/?=
 =?us-ascii?Q?w5yxsbO+AiHZVRm3rcWUN21dgK734mubYRflF+72xXDb63H0V6wyDzVjISjn?=
 =?us-ascii?Q?W1L2jYAG/KmJ1VVT/O9A6BhjvOlzsoacpBUEkRKA1OazyGWYf8ogZ4+Sexoz?=
 =?us-ascii?Q?k6IOxnNMcojBYMIq+RqN7wCH6EAq67koALzLBdQrtUJLBJM7nOjtrst0GWBK?=
 =?us-ascii?Q?N+lrwLRDMZL70mMEyDO9Bx12OnZ3ZiE6U1yxmbbgnP7Jtxv630IIyZoHk6Xz?=
 =?us-ascii?Q?wHzPxbOofvQtQy/lgRqJeSWaYxtLwPH/cYTBD4NGmfZzsLORh8Ugz0VdE4OH?=
 =?us-ascii?Q?copCbMqndiGrmsmMH0tYrLTIKy/RrohzmncE2IR1DIB6Vf7Abv8X/TVJabSt?=
 =?us-ascii?Q?pNHRZFt2eRbp2qmCWYbnuexJaTQPqRmmn0y6WEqAdvvV2CqIckVL/Iw1qa+G?=
 =?us-ascii?Q?5cxZWpBrbegekmaIkCcB7MZ6FqVJKTzBZCjRs7mjJmFR0tp1EUq9wgWPMMzz?=
 =?us-ascii?Q?N2rC/2y1jtjMHs1v38/B2vl4yKbb9vSpO8OCSHk6CCGISni6qOsSno4aTeL2?=
 =?us-ascii?Q?iaxcMqXI3oL/Lt9hAj0N6BWkaOzpYJQ1hFZO6mCbtSIBp6m2Mo5YhEbihI5O?=
 =?us-ascii?Q?Z3RRQUYhWUcOw93j7uBa/f2GwO44KkZRJ3uDG5h4X+se3ZcSLNs53o2m8S0A?=
 =?us-ascii?Q?46vi/znk8eNildvQTsw0QF/NfnAOlLkffpRCAG0FAuJhmNvWcOG7KzSCMPJL?=
 =?us-ascii?Q?OSfWAROykaBpCPhsCe5Y/CmN2GEPVAY2wG14N5ksvwAHB3pexWkyghSKWSoU?=
 =?us-ascii?Q?fh57N5eMMIX0+8ie+RABHAfWh4sX4zmxJ1dlXsol8QCAhNnyWwgFLWd70CuZ?=
 =?us-ascii?Q?4wX/LxrlH2jYz5exlzE5OEgfrHFqc6Ibb6QB6AruXn8BXEA8wN1U0nCybYwr?=
 =?us-ascii?Q?NslRv2JPGhQ1TnOUte/2vSBgzQej+SfZ5XsktK8WTegifBhJLx3X4Nboq4Kt?=
 =?us-ascii?Q?c1gDJ13JgP7Y3L7MmmquUQ3ejgEHBsMMYI1HltMfqugKcmqJTKsvNo8etC5F?=
 =?us-ascii?Q?y+4Y/lCgejPeqFW1/ye9aqs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e322686-8fd7-4a92-9511-08d9d1a577c5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 06:18:05.9975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsWb5LNjaT2/Kqv1CEWCm/mQuzqTLo0HqpBZYsNNZHB5ObtvhHpSh2z0JdW5Qz4J5VBajxncEOIHLGP26Feu8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3369

This patch implemented a new function named pm_nl_set_endpoint(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use to set the flags of the PM
endpoint.

Used this wrapper in all the selftests in mptcp_join.sh instead of using
the pm_nl_ctl commands directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 1a92f0526a4a..8202c5750c33 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -374,6 +374,19 @@ pm_nl_show_endpoint()
 	fi
 }
=20
+pm_nl_set_endpoint()
+{
+	local ns=3D$1
+	local addr=3D$2
+	local bkup=3D$3
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint set $addr $bkup
+	else
+		ip netns exec $ns ./pm_nl_ctl set $addr flags $bkup
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -581,7 +594,7 @@ do_transfer()
 					pos=3D0
 				fi
 				addr=3D${arr[$pos]}
-				ip netns exec $netns ./pm_nl_ctl set $addr flags $bkup
+				pm_nl_set_endpoint $netns $addr $bkup
 			done
 		done
 	fi
--=20
2.31.1

