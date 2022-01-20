Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E394F2CA8
	for <mptcp@lists.linux.dev>; Thu, 20 Jan 2022 07:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642662990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARhnx9kWzNNCbzjYvCGQXF5HTFufWILaM0S3bMOavx4=;
	b=C/HafpDjg0s20tG6HiwHiUUAK5l1Zl2OB6MZuA0924NXPZZNTC11UL0zPrsCHJWhIuPVXm
	29oBrIhyCrqasls9Sro/AgysvSbHzE6ncH8LO/f5fvC706vCcEsjMQYcY4gI+LeMMCDRU1
	Gay1J63Z/D2Kay1IbdhtCIZyJaoPiJA=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2053.outbound.protection.outlook.com [104.47.5.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-a9sb70sDPq2qK8Grfv_LTg-1; Thu, 20 Jan 2022 08:16:29 +0100
X-MC-Unique: a9sb70sDPq2qK8Grfv_LTg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwFH6DHM4qedErt44mltiDTeYh6CVWEx+O16LUxtJAdt7zJ/xX/2O8cSxi8eXLOfvYAgbkd6YucgOkmmIPgW3HasJbRt45dojsRF4PfGUe+1i9l/uobhELZP7Mx6c/grS/7oxcBZ3ERpcJJQUDr5FCv4BaCkmf+ecchLIrZvlfbXGFmwVbGQmXgsso+tOCw2DTPWPLGCfYTiopVJiGsp5HQl4bmbyRsQo6tW+qlWxdAPbirllg1zNg+auYMabjYOoHabgc0o4cCzBw91qzpfaIZru4ozQbpHmGQYoctmE/IbntmOtk7ZhD4P0P2DSifdbm7zyt3KP4IxceDZLwwXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHNtOd5nw5x/DRfBPBeb54E/SCJhPtomPWYDn+vce0o=;
 b=MpGqPNZWvL/ahHKbrXUXQRgaE0un/X58d6iJdgD5v4WTiU54fwb5GBVS2q9+DosPXTMw4HxxS5WpuZcmXh8KUQSU4UKFKYOunPrKPCajG0DmOET5QgblhyHscTDb6XhKXyFUOaeL0ps5q0GoNXpV4McjYqd6YVftuwrn48+lpszahEH+ubNkM31CslOOvuKwUgK/WMltXorwfXDFFzGueNGftl1uS0CKB+LFdyehwV2KH/9KCPI7w/qxgYeg+PqDcjxUrJEUqtCUQUO3rpS9nMrwnKOAZAp0PuCSSbVDQKaczxn31PFeiaIW5w3Z4CWtBaIvfDDYP2mj7dxqYSlkGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2441.eurprd04.prod.outlook.com (2603:10a6:3:7e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 07:16:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%6]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 07:16:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add wrapper for setting flags"
Date: Thu, 20 Jan 2022 15:14:30 +0800
Message-ID: <5b56a25796794126dd9b57f1afa21df21d5d9ca4.1642662798.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <62353f253ecc5eb7724f0599cf1baf087e2cfa5a.1642662752.git.geliang.tang@suse.com>
References: <62353f253ecc5eb7724f0599cf1baf087e2cfa5a.1642662752.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32ccb0ac-cbc0-4432-9625-08d9dbe4c6ae
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2441:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB24412A7CFA2188DED4A5DB34F85A9@HE1PR0401MB2441.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V3w4hdoqOj9e5xxcOMzkI702XKJhLQEVNe0gA8eUZ1kZauZ07cXL38YqOUrVmcttG6faJL9I3rGd1Rt68/fiMCnvGV97ZHrXHIIjIDCL/OXcYa+KJ2ezyAxxD4h0JkkwhMlwQhWIoCpwaPM5RINnTHxtCS8FJrN4jESwLufO0YcQYBE4aq7tMRgkM/gh8i180+JV7JKe2Sx4YNdXvRYNDEy+i+7MbhLYnE+pLOP4QcWO+BnGVuXzNMfxzSUC6Z+xJ0nhCmVE+Vj7NXBXkhnvmiAFAg7finBxVbcehJIVkQp2icMJyYjNZWkBIGnmVPQChZ8csJQI20xjhWrUIjFjnnZimW84Dseb7T9PoxL2WF2DtGgMA3jwMXGsify5XGzBceGLnWGwLo7n2TTHO0H/oeOx3ucxz8dVo/sFHGDicZzm3mgQBRFyeDyh48Du7ckZRIzUmg5bNx2c1UT7iQ3SV0evn9QJa3vSUUywatsyzk4mC/o43Z8wyC5lQmvl71PSEVD8Heo+YOsqn6TultBd9j3KfdNOx6rzoGK6ZbwPOKcrealUAckhXUyjyx+/3PF199M/qNZeg3jAWgOKzo2bISga3SbjTeLHotEaZWRi+yUsqw6bXiOd4ahP2vHQhCSkOkUmzxXs68kzsm6cD7Pyiw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(6666004)(2906002)(55236004)(66556008)(8676002)(83380400001)(8936002)(2616005)(6486002)(6512007)(26005)(6916009)(6506007)(36756003)(186003)(107886003)(44832011)(4744005)(66476007)(508600001)(316002)(66946007)(5660300002)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wtr6X8LOFmjXuqxMoeW6YoEKatERCxXlIN9uvWuTLgLZYr9A3KZkplnm/R68?=
 =?us-ascii?Q?8xZMDOV9jdRxPumMhc+RBm7jIXbY18ohP7/55vw35cRCP/e2JKsuZsYTHOur?=
 =?us-ascii?Q?VurepW2oMhr6U79smNmyDh2LCy2oA65AtyQoFqfVYjmmql4ATi198OvRQ4hd?=
 =?us-ascii?Q?wzilQyXQ6s80xFs7sf2+KPUpZLnQ5zNR0cDK7Zr1O/gYiY8sctqjWHBXMZlB?=
 =?us-ascii?Q?59jhzgTBXlrGNaxxqgvcTx8sDyXxmK0HNXp7D6wIHd7GOQV6fei/rkCdvV6u?=
 =?us-ascii?Q?93t08OKNiRdnA2GkxU/wfqsnowaLh9+Ssle+ECe/Qll6BixQ1+s4Ezxu2UK9?=
 =?us-ascii?Q?beA6fZ0cnWU4zJ39EFZMVaN2J7BmCdEjzKqJDc+OL5RbCKBJN4bbrX0ITmbL?=
 =?us-ascii?Q?n1DaNio/6T5/W7zH5gTYLKWzj+UoR2eoaCw72DTu+3va+k1fVMy/HxApVMdu?=
 =?us-ascii?Q?CcJDI7U0V4VczDHZ18QHwIjDzR6MUeVSiDky0w1a1GUlTSgSkvK3PMxX1hs4?=
 =?us-ascii?Q?2zxoxIvMpaBlUfYF14fjEl4VB1IgN28KshmJlT6LM3ssuPaZF7OVmAs/DVZW?=
 =?us-ascii?Q?KxKr7jJUiPcHfAcbVtDGrNFjvMXG7e8tywmWKFD7KaXCtFldCJydbSIb/JMw?=
 =?us-ascii?Q?aXMK7V3A8Ozi5k1F0+iH5lEq/MExfqez2utGH4wTfZ8FRp527MdFVX/bT4SV?=
 =?us-ascii?Q?xj9XeLKBwR79vWi353wOmqpkbLXwKrJqhp8+IsIT5tRsSDgFgGtam12wGuyK?=
 =?us-ascii?Q?pCNYkLNxGAkmaxbE57FbPA32dfxSfXPwkTuzBVK2j3bqqN/zh1ba0cd7nNWV?=
 =?us-ascii?Q?EDmTzplgZ21mNLLsUDSFULfyO2LBfNtKb2P7edvL9YYrw/TzxdaE95EpiGnl?=
 =?us-ascii?Q?ockXCVlTYo2PhSvATbC49Rq4M8i3om0RFQLMvNRfowvjcQi1RSq73YIbHg62?=
 =?us-ascii?Q?vMv7Zs2py2rDBZmYxSpdtaqB5AiDIMFIlHV7JTHb0GtzPycJk4ZN9WvxFDIY?=
 =?us-ascii?Q?c3jPHv9VdRCWvrjv1mkgVvnciCv6ZUtbUZ+pSCi9KEg/0rOBZlxC7+NXjyxa?=
 =?us-ascii?Q?HWgxVNNVcs95KUGb+ZCC8spwpasd5lgurYl8MJQe+cPMwJKeTmmNVrdQlrJw?=
 =?us-ascii?Q?CKtqc8hqw0joUG5heWPE3zebDJXo6jZQZ+hy/WpXuReEAdq6LNa/6aeW7Eos?=
 =?us-ascii?Q?zWDbf6K3l2Kkervh14NI0GJ3KkkY8yZAn18Jh6WMbxf0hZUBwVA3LwEGyiWr?=
 =?us-ascii?Q?fbL8e0AdZu6ii1YQNSljS84FDVhT6fttUHGPkwp9PD4MTzyhXBeP/QDhiaYX?=
 =?us-ascii?Q?qwnFi54vmeyH/9WSWJl/WXkm4LcP1YRy/Ixrf/UeZSXNdrHFNIUK/edcEFuA?=
 =?us-ascii?Q?bKm385YX84SR+rlvSR9f1WeB5UmQZno/QbQdik6lU0G2kJjRWH7BRb5sCba2?=
 =?us-ascii?Q?XWSoeh1eo2sWTXTIM6oGwefdZuS4Wb0tShUnRKTQTE0i6r7hLAkLGMVht09x?=
 =?us-ascii?Q?bFE8lwEf+G1hCgVnWd6afewQvbCMj4GHt2Y3XnZ2ZETDb/tFixi4G5zm1Gh8?=
 =?us-ascii?Q?MK/FJjIZnACaogzyHu05WFOubAOsEiU0CB9yKLoY2v0IGX5uJJkdfj3SrhEB?=
 =?us-ascii?Q?5o/bwmiFwPuZLRLtgrTsGtM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ccb0ac-cbc0-4432-9625-08d9dbe4c6ae
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 07:16:28.3086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgn/55UaxH/T1HGWIucmWXIdE8vXotbkspaRxZTdBZYqGGLA7P6ENQ75aSYVLbaHd9mCQJLrs4dZcqX/2bnLOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2441

'-z' is incorrect, use '-ne' instead.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index f4efd18447c4..5cc892b350e0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -397,7 +397,7 @@ pm_nl_change_endpoint()
 	if [ $ip_mptcp -eq 1 ]; then
 		ip -n $ns mptcp endpoint change id $id ${flags//","/" "}
 	else
-		[ ! -z $5 ]; port=3D"port $5"
+		if [ $5 -ne 0 ]; then port=3D"port $5"; fi
 		ip netns exec $ns ./pm_nl_ctl set $addr flags $flags $port
 	fi
 }
--=20
2.31.1

