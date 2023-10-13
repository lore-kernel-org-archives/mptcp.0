Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C615695
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 05:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dNotzH1c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7CPFVpQCK/ScL1NJm8vOy6KT3cQSAhP3Kp6BcSH+9ZqyKVJJQ4lpc4DEY0SvUvzwQ2PugEERk3BJl/gZbtoVMRREeMNnlF7HpeyP+KmqRGBlocHB0t5UcvCoro/klzdonJ22nEVuPZNLKAB+o/G2oRWxLyVicGtdmQheZEtjp6mXYUHR0/udJogn6/Cwf8dj+vK/Cz98UNXl3dGJWBW8riB6FlCgDXSwCLt/hYuJqbDcQbSBChHWXlnhf42NTyZhtGyeod48fIfVXELhsPY7MAVo0AFOGmRuOmZNGQ5Z7jry1ojH3jX1GrEYV5iM5H22HKAaZ+ceZjyJTHM780wcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vgC+f0/944ou1vsxbt4iW8ls1JHdOqfezUucIuQwjU=;
 b=RHLfBUoEI+/MK9U71RtkeBERv7FCdVs+dAqDYJP/C8yTrmlD4MqBpvGHg0snxpKxk/4K9iNOpnyfCnEpv4DL2ACRdFMwDEJv/m+xg7BFrHyzr2BEQw2mhPf68NB/vcl9gavNAAqJIRnpHDHEV2cbwdEqcUMurLeyRXZOjD8YtHPlxloTIPO+V7kPb5TxX69qghAFAnEMMPf0D9dZqKFU4kMyxydpoYcX8S3K62kzltg7O/Fmhz5B5NWnSU3oWVO2KyzIXA9Llg3DI8nCJ19lh4SYyLygTArnNjd5FwsGnIWSmn5i2qttJOOOErizvJ/6o4dGZF/G2S3us9WNG23OGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vgC+f0/944ou1vsxbt4iW8ls1JHdOqfezUucIuQwjU=;
 b=dNotzH1csoslgn/8LgVEavEn+4S3fYuM5rg4+aGh1Ud+TM3jJsc21PqeTuMtV1UCE2rUBFZKEz4epD3CBcZgkKEu20O9gtebz3ztaJKgapQmgIr8Jz2tGO91zGGnHeWqnnlOOwxT14BwoXH39rUUNl/9rvawXbE7N5Wl4IInk1hmQ9z5QHELNf3Zq/ZBgETUD6ycM7l8bysQ+xDu+RoGlLGpaOOHVOlk92yAuA703aoji8XuUWLbhN0MFGHfdL+AhbAPMfwgokmjI+33oDwGe8Sp5LC7r9X5DXspcr7Zp16YC68DzQRRoFf5MCOji5Rj034eON5E3olsUWtq0PPh8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7288.eurprd04.prod.outlook.com (2603:10a6:10:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 05:45:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 05:45:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v16 2/8] selftests: mptcp: join: no RST when rm subflow/addr
Date: Fri, 13 Oct 2023 13:46:37 +0800
Message-Id: <9d6ca4f7be7a52a9f80a680f23a431a0daf0b841.1697175899.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697175899.git.geliang.tang@suse.com>
References: <cover.1697175899.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::12)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 81fcbf8f-cc4b-4bb2-4da6-08dbcbafaafc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GxtIzEHVSnrKfeevgImpxemr8zHn0SnZ81a9w4MW1B5WoEb9+JxLxaa6mz+K4BShcn4I8XnAgz7+YDkkO6gYM/itvqaNallj6lZS9oA07ZCHPNc7OvnPiIhZDK4eIBujBtPCi/GIL6BUTPJdZV8IfP4MN/mzQ+e0BdX/TWoG5DNv04kv/rQkCYFf5IaDNiAdzLJ/7xCx31qE/JsdWjOiPKDldhgi7NtZYqc8CeqOVZu49ZkpHcfVhxoANvf34M3M47TmX1Cap3uwLdcB7g4Zh6b9OyI4JE8YVD2NmQIFfNcauvR6r5Pk1AWdVdBQ5qxON4xTSn24dv5kqd1H2GZgAQke9hABVLT8DWDH+BAe8DB9kNxOpVtDcz4Oxl1psbl5kdnbdSPMkMA/VrnuxTH/uwtvXSp0CLof48JxcPH9QhFEO7WQ8J0u+utCChtoYyJK9KyLu6YvSk/q0E2xOj6Fuv4MhEApxap6dLkOfDRaVYL/1AbxLRCn8Iu2TYW65bYbtLDZuBSx07GiH8u8a+d7a977ZcG0LyVQbayu+gRBMEooswy4RDchGDZWv5IRaAJCF4PODDmpzV0k5Axr4AOoqB/QAAbp+d6ydk0hQfJkxqM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6666004)(2906002)(6486002)(478600001)(41300700001)(4326008)(8936002)(8676002)(5660300002)(44832011)(66476007)(66946007)(6916009)(316002)(36756003)(66556008)(83380400001)(26005)(6506007)(2616005)(6512007)(38100700002)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e1dWdemhxbiyNm83mkOe/t9BSjTDf8Y6ZnfSd/gV5a6B/jBKhAj1W8vsQMBZ?=
 =?us-ascii?Q?UdTApChALk6dghTtVhI4MxfLoSBgEkJX3o9MAERmSj0n+S/tgEhEmnDiAR16?=
 =?us-ascii?Q?Bkd0KKxBKUcKQBQbJ4Qly6XT3aK3ED+LM0bxX7v4bGaq4RNGlw/FaxP6dti6?=
 =?us-ascii?Q?KGDjWnGl8yQCqo4r72ydnjU8Cb0VCcubIapiLKkbR309ybmE3GR4DcZmwti3?=
 =?us-ascii?Q?N3eO8eKT1xCAUjXLrFWTBJUP9qRIi2r4HxrZE+Uqtt72lAtbCWXYPuKaUCBm?=
 =?us-ascii?Q?gTdm1EWWMYTAQFB8DijVhD93jv0L1jLc8iUHLfBSCMF2d1D2sBUDoTganmFj?=
 =?us-ascii?Q?0JU1/4/v3xhk4X/3ZrVALHyDqu+wnByYXEAUZvCbCaeYuMD2Y+849cQUCBfs?=
 =?us-ascii?Q?AoHKbXU67jTWlocfVydra6SOKMNlMhGecNTeUnpAeHsBGsKYLJvUEjdq9H1v?=
 =?us-ascii?Q?JUT4clR0RP5z5q54jVxVRVjw9Co04D5YpLHRl8jyFCx5LJ6oTlRO495+3sOB?=
 =?us-ascii?Q?JEmhI6YaK9ScUtS4pkOjt12w3I/cssi/04XPfh11+ebuFSBur9B8g5JlGqnD?=
 =?us-ascii?Q?l7vQLQwW5HQv3lYaf0kIt34F7vlY5f71r/GVnchcAfEZJ9z1rovA8L0Qeijb?=
 =?us-ascii?Q?P7l+Mf800X9Co/HDZjIntYnLFFnAveJUq/hpBuZID5kvi9WQMItkgANYDZX7?=
 =?us-ascii?Q?FM+tD1P6DRCo5lzuc9RUdxPE+gRdi1FKUyyr0/fbtKCdH+pqX4Lo4WStydCb?=
 =?us-ascii?Q?bkDThmVzMo4nX8OxDnJ4GzJtuQ19TXLqeoI/BZeuwOmXWPkrfiufcf/CWK/b?=
 =?us-ascii?Q?0OI8r5j0LxxY9aNaphiDDsWyI1M4LxXfqLwalsjqfwztWprSjBwHFC2FOdQ5?=
 =?us-ascii?Q?yRQ9S2YmBn8lbkE7cgC6RNpNa+nY5pMu2i3nQuPB5lqxklxoTfzfJiAJXCSM?=
 =?us-ascii?Q?oX7lEupKGfcVoqpOfOoPUS9pV+Xa6JHGY00c1N33+t2PjiY3dJm9nieRAn0v?=
 =?us-ascii?Q?k13Vh8LeMKecol5BTwIi//ivYLW75A2UAmPIyW6TWlAUd5hWTg91MgKp94Es?=
 =?us-ascii?Q?lkg0UNejB96tJzI8rrL++8ZErQQPPZl7Kgb6ZrYy+kX82gJqJYUEpAT+GmxS?=
 =?us-ascii?Q?fmhkmd9JSTxWf4rlvnnB2vhAF9pS1sQn6V0eRZqwl3P6tA45Vlh4pLm2KxNH?=
 =?us-ascii?Q?MeQPqkkE8yjxPa7zwuIjd+bBWX8r+b789aVKdH1zMLLTy6FMM/+F/hmsgBYL?=
 =?us-ascii?Q?9ZQzKmFg3s/DCrsGXAYgmNO9HHupckbod2ucHHlWKjt5qtZIGHI6qsxKUAcF?=
 =?us-ascii?Q?ByB5ML1Yln1Uai9ml+RaLdb5AeuHvuWBbCAFH9glxTaqbBWvOZ9t20kFxRzo?=
 =?us-ascii?Q?dv9bq7tfUBk20GLL7fCvcuEdS560+2B/h/W3siOAAgJhoogY2y/Z0p4QrDvX?=
 =?us-ascii?Q?Neg6BrlCKhRBX5R1q1xPlz97XPDKoEr4zMLj8XclsysEVCsv/eyyv8L2uCqq?=
 =?us-ascii?Q?hcD9A+oDrUgfeUaLKXHFxUJg+zazlXzosMlyzKkW7IgEnuY0rMEh5NW7Pjje?=
 =?us-ascii?Q?a8/tKTdvjwgxo2DglYbKXTE4IPnJYfQAilC5wIvR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81fcbf8f-cc4b-4bb2-4da6-08dbcbafaafc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 05:45:55.3282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+fJIVujmMzXyc7K67HWGZH7b/v/Qrx4+X/3EF99jsQtC+Ha1UvPtPhZl4g6iLlamQtzjjl0Oi8EZtQza3OGYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7288

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
index 01480663c102..07b2c4bfa183 100755
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
+		chk_rst_nr 0 0
 	fi
 
 	# remove id 0 address
@@ -2506,6 +2518,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		chk_rst_nr 0 0 invert
 	fi
 }
 
-- 
2.35.3

