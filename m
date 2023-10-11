Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A377C1F928
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZM8ZwB4J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZx6bVwN11/kVU81W0VRY/Xa95WeuZhCvVVR5zILxMGDh2Sni7qbIZ6Hjf8oxQ6i5aXSi545T9UxSnDG1/FbZzssUvICKTMj3grRGfNkKRwqgg3YjbTzC4wQBNhZVCJe8zC4+xcihWR52tFPvpCNJII9EoSwcmmmBXp4zJK6CBfyPAq1m3EqVNq1zUhEs4vMkExTZBWqLLbC/s41lbh+HRLjIJE7zqiG5bPe3UjGqztzBDE0/pn0+zpE5lc3g2VctswT7vpGT/MyuNIEk22+s6ueeu2mcXIYTpCtCi8uq63qqbyScpAeMIhUqo3RV5he/e09DXDWKzHSrmDIavyvVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRd0Bif/P8noQUpSU597xprr5qSWRiRqC/fpPuazJ+U=;
 b=EZeW3i3aDPngbmV+tM375Bf/tOD2t6zvytXUvGo3XGigrP/Hc3VoqF5kCmXPKPpO2PvCguZ5uvIUdWeSm/iLQZcsF7dv1StSeFEwVOvRvhpWftZ3W+/7x84KIyEXMURm0ntphyeodWmonGD8Mmy2SfbXicxpgv95o55wWzb7wTc6/TdW1VREcfPlNkU3PcYJipbdiFfDbGm5oucE8oZ+0QMN0i4TxLIDUebVjfBikKTXuKf+Io6kquryzW1e/ZNMOryOZLeWJ2+Pam6S4yBnY7Sh3S5mJvwuwUFei4IU8aOyA4Hyr2kkJYlTvyGG0Eebht4lOQYupQ+ZpXr3QjHWMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRd0Bif/P8noQUpSU597xprr5qSWRiRqC/fpPuazJ+U=;
 b=ZM8ZwB4JURzpeLDXcgQkC0BYBtkINJW5jwn9lj/h4B1QvPNzDNLxLLi9y4uCuwnhkz1fi5ii4CozPxUBkG72OLdy5aQ0TZXh9f9UfhVMdcivGHUXgWO8zp/MWKnGMG8XHfCQ52xRGvseWOr3OfYMUYKE8TaWXRpEmGhTEcIAKAJCV9QWqzPoFR8oW3sLrgrw/E6obWOQOnfEHkjl3iQCt0gyF4dTbggsZ9JY6VMfKWT78HTbI+oLNV+QtOjA6+gS4XlwUuyTW9itk/cqDeSCe9JOpT2R8WsDNA9ml1h5Asc4E9hDs3UXiD9o6eXsMwcyw6wrRpbLie6FrHX4k8Igyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9139.eurprd04.prod.outlook.com (2603:10a6:102:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 13:34:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 13:34:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v14 2/7] selftests: mptcp: join: no RST when rm subflow/addr
Date: Wed, 11 Oct 2023 21:34:57 +0800
Message-Id: <da82e7451e6079edbcf91deb5b681bcabffd568e.1697031190.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697031190.git.geliang.tang@suse.com>
References: <cover.1697031190.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0029.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: e66552dc-697f-4b0e-d806-08dbca5ec6fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FV81K+Fa+1dfsjkntdxypEa6ANMuDpYt2DlW5TAMXbywTDB+Kjty2HcE1GlN2crKMzSIoXvsZ8S3TFHMhUqjltsJ/fPcx+bd2VPD+MJUE4pb69sP1++xzZY36RHSqwC6WK3rCjFq1kOdOc1OZKO1uiVez3scteWoJAzjSlbCLmPPMGxltxDHGBt7ytQMkN4ER895d8bbczdv3m5TXjXsy6FTQdRDcWYQsHKGnO3bduJWaXM2QRdrcFi9DcHsrBjfJK3EdEkrLc8wXuDNLaHSS5iOiGU3Pke1IbdS2BRJJKsxAONIakLjHbUa6Oi6IFqdFjexqhCDgQfo5GSl92pkdeuZFLUvUBiR5dL5k34eVTE99g9Xz5F3jrHWvlOpyvQ3Fz/GS07B5Hv3rzYzTeos9NKQCzgJa+2eCWw6m4xAWgOcL630YBZTIuLBw7aswp+/6l6xH9C2QqBXk8ycILo3SAD6LpyFLcCPm0TVWjE3yOJr0WwTBS1bGjNOKwNvYZ2GBeiFPMKMZenlRlBKyWmqAW6QXqhQd6mTFCbXOvWwDElgDn96sZe9twNuLYp2CyTz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2616005)(478600001)(26005)(6486002)(38100700002)(6512007)(66476007)(316002)(66556008)(6916009)(66946007)(6506007)(5660300002)(44832011)(83380400001)(4326008)(8936002)(41300700001)(8676002)(36756003)(6666004)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k5FvG4jqnGZf2KHPXvgjh2e5cl7Ftth0Lmrca6xJHDI03XPcGoz6keiHtR+s?=
 =?us-ascii?Q?SqtBXGhM97CA3pLHDz7waCfR3W5MBkzwoqM4b0ZFdxbCDvmZTJHydF7wwmzj?=
 =?us-ascii?Q?9fy8pmLj38we4v+Ax6gOvqbtJmfsO+kcJSy+9Ek4ZSodCdLIaPQZ3XG1zq7h?=
 =?us-ascii?Q?7A0ZEwlqHOmVbd4lNhuUyAsXuMoTYB8539gKb82N9EX3AqdjJ3suxOpnx/4I?=
 =?us-ascii?Q?pDs/ZZEmoMFKaNVmYdqFZe6FjarmQrXPPXwAD3V4L+cpl6RBUqVkg6POkg4f?=
 =?us-ascii?Q?IY5ihcg9kMMU0zUnfpM/C0K7fmBb/0A3H3/ImJmZ/LC5+x56O780JPSyY5CV?=
 =?us-ascii?Q?EvTyODfo2/sChyQN7BJ3mpYCQ7qNAKurO6xe1NsQFyga1JgLihFUqgIAj2W9?=
 =?us-ascii?Q?6X7RlbMTnYKZQ7cKT33FLhs/NBxb3DT+E54joH6lBw5YbYxkJ6GsKZrDvTEH?=
 =?us-ascii?Q?WtMKgMwt8QJDfhF/BCcCIeWJg17BlUZKe/S/rA/rZSnBJvq7Ylg9MmPML+xb?=
 =?us-ascii?Q?ZAfqt0gNCXg8CwSY0FAtrNXnNqR+XAnrqwnsZNQTLt0TkwGhwKdhJSiWNUQ0?=
 =?us-ascii?Q?r6uYrq8L3RmugzcS3uvTg09jbpdMjUXjJyFWeMUJex/hjoZ3Y81JIBrn14dM?=
 =?us-ascii?Q?M6OH0ActLx4gjpr9axUo9dgPO4QtMpFioNcLlEBom/qxbIRnnAHfFpZEkdLV?=
 =?us-ascii?Q?X+Hgfe7yI2++rCtRNmXxeb0umAjexdvBrDbKJxK9R0wHDKQnFgAtJBJf7ZZ1?=
 =?us-ascii?Q?k7gGITcNpSkcxCh7ZAvdgeuViEwgV/TwUg7XBnDzjfI2VyyYed+z37GExjFH?=
 =?us-ascii?Q?wwjVOGZ2pudrdnVHf/Qt5jUXkQ0JgpEaCbe5OGbShaFqjOBIkIaZFx9iUXEz?=
 =?us-ascii?Q?QkWbJYHRLc8hjYRfEO+4ox5KxQfTmGQf/NQNbXnOLBwKoLk6VR3sWYL+YJVy?=
 =?us-ascii?Q?C6PPIr0y5gZYWDMjgr/Fd0NmPr8SwUpwMg131GVLSdaQsvHpTgGzRhQcqP2S?=
 =?us-ascii?Q?Ita6MtB+J9SDT468+gDfmKIdlldgs4AdmtudrID3iQV+QogJC9vO8llKcitZ?=
 =?us-ascii?Q?naeja9jig2VX8cY5jsT2FIOaPNlpKVEEOqd6N48xx0v8+eePOLJFiFVZvNGM?=
 =?us-ascii?Q?MrnxQ7v+ziIO5SJTkoESNKN8quK3BN+4EVrIf0X7MHsIYe/PyM9g8AnSSr/4?=
 =?us-ascii?Q?o5ykfPapHlz5z28TIJKbKQGHHTnByhQ/kYWAq3MSE+CLjrbOmqFXACqqw2hI?=
 =?us-ascii?Q?O1zwBg50x2pu4Td42AgEO5dsCTJLyA2ata2LX7TlZ/Npr+4jPpOwGrCqjh0l?=
 =?us-ascii?Q?LA/Gw45pw0XPMtb91ez1WXQV6ukJ1yY+t8LDwLyENPqssjXr5T8zi0xTxSBy?=
 =?us-ascii?Q?12F9SxAmXHuuI9tTprjXE9rmmY3nzTK10J/yR4W+3+XpPAF6INDtd7ycTRy9?=
 =?us-ascii?Q?6ZEeQ8pntfU87CVe5dzYuEoeQ8ZTj8zYY/0uvkPqGL+VTRgaxOJaUMzCXL4C?=
 =?us-ascii?Q?kCn9nNXGfjsZYPxBG4RPR1nwa59pdekp0XxZGU4hqP3rD8Kuoyl7OMW08wRM?=
 =?us-ascii?Q?Ci8zTTwcYmdkIGo1V1rVp9eYsE8hNCCGgzrKZb5+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66552dc-697f-4b0e-d806-08dbca5ec6fd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 13:34:22.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vi0MDwqOTPwW+eT3z3tADfnoxmRZ3m0g3dqPPkTqSUpJCtDhzhVT5W2LImeq2hTepAkLm4YT7X/2izWvEKW8sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9139

From: Matthieu Baerts <matttbe@kernel.org>

Recently, we noticed that some RST were wrongly generated when removing
the initial subflow.

This patch makes sure RST are not sent when removing any subflows or any
addresses.

Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 01480663c102..ab6908b7b143 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2343,6 +2343,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_rm_tx_nr 1
 		chk_rm_nr 1 1
+		chk_rst_nr 0 0
 	fi
 
 	# multiple subflows, remove
@@ -2355,6 +2356,7 @@ remove_tests()
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
+		chk_rst_nr 0 0
 	fi
 
 	# single address, remove
@@ -2367,6 +2369,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		chk_rst_nr 0 0
 	fi
 
 	# subflow and signal, remove
@@ -2380,6 +2383,7 @@ remove_tests()
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
+		chk_rst_nr 0 0
 	fi
 
 	# subflows and signal, remove
@@ -2394,6 +2398,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
+		chk_rst_nr 0 0
 	fi
 
 	# addresses remove
@@ -2408,6 +2413,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
+		chk_rst_nr 0 0
 	fi
 
 	# invalid addresses remove
@@ -2422,6 +2428,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
+		chk_rst_nr 0 0
 	fi
 
 	# subflows and signal, flush
@@ -2436,6 +2443,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
+		chk_rst_nr 0 0
 	fi
 
 	# subflows flush
@@ -2455,6 +2463,7 @@ remove_tests()
 		else
 			chk_rm_nr 3 3
 		fi
+		chk_rst_nr 0 0
 	fi
 
 	# addresses flush
@@ -2469,6 +2478,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert simult
+		chk_rst_nr 0 0
 	fi
 
 	# invalid addresses flush
@@ -2483,6 +2493,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
+		chk_rst_nr 0 0
 	fi
 
 	# remove id 0 subflow
@@ -2494,6 +2505,7 @@ remove_tests()
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
+		chk_rst_nr 0 0 ## TODO: currently failing, Geliang is working on a fix
 	fi
 
 	# remove id 0 address
@@ -2506,6 +2518,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		chk_rst_nr 0 0 invert ## TODO: currently failing, Geliang is working on a fix
 	fi
 }
 
-- 
2.35.3

