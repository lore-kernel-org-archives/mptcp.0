Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941351FD3
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 11:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645097024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrZKPQVWFihMObEcdAPwZ9ZI1x6cz6Exaak2wjBFH0I=;
	b=k6R5ipsKyMNB241c/0ez54q2qeLX1Zuh9dT2aGQQvhGqaN3u0SchoMzTLL/6Vh/sXEzCMK
	bt/lUDzVUr/ibTTR6nGKL0hshVwuGjG8itEFDcYeMPOcItpETZu2hJL8w0y8dle+xtE0cx
	KkOeJsIZKz+9IlFOXiE64oKSo2dVlWg=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2050.outbound.protection.outlook.com [104.47.6.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-NZLjmuByO2u0oQVzuIw5ZA-1; Thu, 17 Feb 2022 12:23:43 +0100
X-MC-Unique: NZLjmuByO2u0oQVzuIw5ZA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIP6jwaUq1HYuaRuEgsBQE/5hvANdAYZ5vLmX4tBuC8pKvG35cZFG2Bwe3W1ge0jmpP185QLtsJnEW+Yl91Evjy1rPGDRk5cSTmkBlH5fGuOljeYUfqFYmdzwEFH5vIwKUVJfb6jgyXDLG7lRDQgV3DikNvRA+d0GTZtKlmmoUuK5fraYsGnf/mp+srF9I//ZSXibX0Et2l8SyvryCCQixa35dqW7zoRuAE+IGZ3AmQ/2dRTU3aSoJy6miPVqKEgzaae+ZtfohzrdMaPDgEmyBdTJB7UD6m3HEUn+lUJzXWIXEFSJl0kBsaZckH+w8QRlKbbBEgZFrRpEyUfD0nKLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyqGHCOVD1HJBWCrV6PPgvlU5PWZlXIp7ntLuEDXrkM=;
 b=Adt0dlw5J7Vkhmbu9gVe3CeFUreDAe5Yw8SEkemttPVzemYP/lnAIsK3UfKu51FwZ+ODXF7vZt31HMrTdzpi8gTQgOBO6wK6sXUxxCPTIe0T/a21aJrkPT6TCXO/VLnW9vie+L+s2uLePJxwuzgyOeJUAJsuUSn+uNTOKibG4c8pptXo14ZM6cWZMD12nJc7ULzd9d2VgZI+iiu8gTOw9o+E67heXuopT07JXoHUKZgt1hyj9/6JPonDMDMwjSlNwFAZp1YltG73AcOg8ntNJcKzX9YI1OP3ZIdWz9JnU1pxrcSwxBSwHfGbrNsunwrJNLXJZHdkf/YYMhoXJQSb8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB9413.eurprd04.prod.outlook.com (2603:10a6:102:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Thu, 17 Feb
 2022 11:23:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Thu, 17 Feb 2022
 11:23:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next v2 3/6] selftests: mptcp: add MP_FAIL echo mibs check
Date: Thu, 17 Feb 2022 19:23:41 +0800
Message-ID: <c910aaabe7923a7a267279578d6b25f1efa0c72c.1645096378.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645096378.git.geliang.tang@suse.com>
References: <cover.1645096378.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:203:d0::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21fd0a8e-d288-4b17-bc41-08d9f207f3da
X-MS-TrafficTypeDiagnostic: PA4PR04MB9413:EE_
X-Microsoft-Antispam-PRVS:
	<PA4PR04MB9413882BC2EB069CF60FCA5FF8369@PA4PR04MB9413.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:157;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FbcA60U4HcSesb56ydkaQOin6+47MsY7QQq7S5mWf2KcbsWIFOXRdbzs6jTX3GeB6MQFrf7neCmEBPkYZyv1MdYAacx1v8sb2+EzGx9NfRp/sQDXeMUxq07wCRzA79tjq5yj3W2YZYvLtsXYga7FS/U/72tyDP3aHzhZs5zMvgrwJwJfg5D9bRZ/N7EcM74uew3sS1SbRAB8DivPgD5MSbAUY6G29CQRQFVY0Bxv/mDgPbEGRCk7WEtluEJED4fho6JTrRoJ0BjWP9UhrH2/2vdBpCiLfKycbBZbVdPfXLqPY/d3FAo8g+odGQ+qG1PviwmGMXiKSPHpUgGzI1iaj7CP1akD4aY3XjxJl7B3scaQhLxMyUEGk7VwtdVkyP77Txj1a9ggB6R/s/JzIg366gyvxiQDFIfzEWlaiSWyQ0EMOcFyjc0qc6WtcxIKZD3JbNrrNX01W8TfyW7O29shSbVK9VgtmU3Ka0mpLYHZyQMhht3lBBcuQMTs2s3ziUxmpXS5zfTESKnwwii2GIXIqppmZfobGF/Hky+CjdbSolRlnstPLj45jKZgXVVMfWhiJ+ISJW65NfOSGY+YCRjVA1KJNttP11YSB3vpTklOC2cujuFvZ9hEwVBOE5/teVJWFYzSxhPBgit12/VcSanO6A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2906002)(44832011)(6916009)(107886003)(316002)(6506007)(38100700002)(508600001)(8676002)(4326008)(66556008)(66476007)(66946007)(6486002)(6512007)(86362001)(2616005)(8936002)(186003)(36756003)(26005)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JY9D4AbF6y8RAXn5TutLvPQMnMQ322x6F64/L6x6QhRq6A/3F4zSou6uPCgx?=
 =?us-ascii?Q?XU2eIMmwA2p2svnxMAf3cVCVNreaXNt5B+51oUpfKs26qy48p1jhWsIN1AS3?=
 =?us-ascii?Q?oirGm6g2GsBycFYrg2SIbU5PTMvXitC35IlMi0k5oRuobM1RKKUzpwHKPhTH?=
 =?us-ascii?Q?sTSyXicOFuz/hlb34EcMY2LXzKB31YXr1XQ755VFRyRJmm2417bnzLxSnYyO?=
 =?us-ascii?Q?lnlwFaheBStVFAxARtGxaI27RFYVc14Ri5EbdDl0VSLGJl3zYz4rctmj5dao?=
 =?us-ascii?Q?MZSybHYFc8DOLWrIJi4WeFvCFa4YKsVm9o+ys0CMzkvRybasghMcuF6PoZIe?=
 =?us-ascii?Q?tAAHJN9KI4Ef9N0qT03/WW8NZP+arerozb2n6CRhCRF85lEF/mTLuu9UsPs3?=
 =?us-ascii?Q?k0MAB4L6y+73DvURCUFJysi9Y0GA7ozDz3NO0yJ2T6r+YcMRaBvuLlGvNCsg?=
 =?us-ascii?Q?ORYkq1u37ObYGlFcvTfh9zkiRNAUCkXXIA4EtFDO1USNUlSoWL0fnd7CHSD3?=
 =?us-ascii?Q?GmjFvf0FUIzzSxBjQwoxenr879uvyIvfy5oLSBGvrURqp96hDV3JqpPItMz7?=
 =?us-ascii?Q?tVxkM9zYm7sPm51E2OiACxeMsA0+mwNDYUojgqTDKtj3a+AK+ephCyW/jY/u?=
 =?us-ascii?Q?jpNsUw6SQ1VL/NXtGEy8hJNvkdyV5/lPQGePl6DLuBGHA3y7T6QtGmv/2YkR?=
 =?us-ascii?Q?UNzhV0yQG+urMe2ZXpe8YXGwvKs/AWN3PfmginWdnIosZ78ZAR3QwWDNj4gu?=
 =?us-ascii?Q?JTf8FRNOKubTv4jaO5ytrHveckaUlTP7WGyaXKxn3TScLfmJn0Cl/1ZJ6UpD?=
 =?us-ascii?Q?my96iA0FSB7wB1EDVzRY9T16Oo/ygOfFEGw8Pya8zaAeEyO1FmRCzyvHruHG?=
 =?us-ascii?Q?acFd4eV0KSjl5zNqIybdJKbZrVpdoY0EyULVUheCtrDELTkDD93cYZO3W2vY?=
 =?us-ascii?Q?xSjSUJ/gDKO75fKpmLCHEYrsABqgK8Bevi9L2U9xuVWiisLt/aMu5geycUIp?=
 =?us-ascii?Q?ZzbCCmBw1s6rPx+m95w9x1CnMfi/omJ7fgPlSVuzpm0Y+3AkVLrmlvniNeJb?=
 =?us-ascii?Q?P5yDQcsRjYL0gXLi8llWCRK8yHnxoutzlA7DbIJf/lr/qTjvW9/PdqnBZ7br?=
 =?us-ascii?Q?lNYKf1weZ9RIjr2zo1QMqHqXH6mR+51yEcnJdjjuO0Ggth+nrdxzpOizOdfI?=
 =?us-ascii?Q?xqNO9Lmok3JZ/5TiaexRnVLoNmgSj9cQdolffulGo9qsOJrh0RI3YaZUp7Fe?=
 =?us-ascii?Q?uqE3rJLz+8nHIBt9faOtYNfTRxmhvl79MML2GZ01lnmZfcZS/T2QwGk98B7F?=
 =?us-ascii?Q?1fcYDyvyf+lvtYKFNNpNbf4Ln7laCIUoRLZPIi/RfLKyoRuVzRFCEGINo6yA?=
 =?us-ascii?Q?RNHThfwlSH+phVxfWBVhp1HyMUOQ+XdTOIg7aU9E8EQTVy++h3qVPqvKXe6f?=
 =?us-ascii?Q?3ENgKo03/AHmcb68Iq7if0KZ44EvwLeq6eOsgSaveuyTk9hL9olXdHum43qp?=
 =?us-ascii?Q?jart97V0cjb1ufdRRlOf8UedSEnmQWOBXb5otjG2Nek+ccbXhHDjcYnPrZJJ?=
 =?us-ascii?Q?Z+tpdMM6Zh7IwHOzX84To7Up6fQAmcfcMJ4/dOq6qwshN8Fa2QwiHDstG+E5?=
 =?us-ascii?Q?9aGI6ACX/kSAAsahaPnKtT0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fd0a8e-d288-4b17-bc41-08d9f207f3da
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 11:23:42.0464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXvTkVPhFv+ND66JFh/Q9IJIr4XVfz2lEaaM2CF0paeL5pCajThQQOL4JQ60UtzYtquYAupH9PEgT6Rq6V+SPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9413

This patch added the MP_FAIL echo mibs check.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 8708be740334..9a1d8a1d3447 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -947,6 +947,8 @@ chk_infi_nr()
 {
 	local infi_tx=3D$1
 	local infi_rx=3D$2
+	local echo_tx=3D${3:-$infi_tx}
+	local echo_rx=3D${4:-$infi_rx}
 	local count
 	local dump_stats
=20
@@ -972,6 +974,28 @@ chk_infi_nr()
 		echo "[ ok ]"
 	fi
=20
+	printf "%-${nr_blank}s %s" " " "etx"
+	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailEchoTx | awk '=
{print $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$echo_tx" ]; then
+		echo "[fail] got $count MP_FAIL echo[s] RX expected $echo_tx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - echorx"
+	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailEchoRx | awk '=
{print $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$echo_rx" ]; then
+		echo "[fail] got $count MP_FAIL echo[s] RX expected $echo_rx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo "[ ok ]"
+	fi
+
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 }
=20
--=20
2.34.1

