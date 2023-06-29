Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DF711192
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 13:34:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcVqwN7w4MJBoW3QHZqapVHtozqhM94haNmbJG5EDm6iziAT1cXqi6uPfBGUnlh0fqz7a3VguZpaKaipziFT8BfSFlszcCWOekPAqUaoGQNa6fAe2x+jFH7/1J86kCSl5BL1MlbdvJgujXOxEAsDXZ5NUjycgmiPu08iJKR7hOYYBXqXGcVRKlLY9KzuHcb1Jp5f9OFUMaiDq48nlEmQSUd327Zd2tEagGMDG4vbOZPjxrvM4b8/Y4wEIYTo/Orfhp6OQEmQBz5Fj6XtXEK7BHFnKDg+aws9+sTf+C4rIK4TXvbcUcG0kTpNG2yqdgi18hjEbra0ZGuB5+bIvVqhUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOR6gKi/8AVW66L5aBMNqlWuV2URJauNlovyRjmhTZA=;
 b=MSyq+UU6UGmHjeH9em8WyK4iM9ESz8hxWUitJozvDw3ulRC6t6vDqkdog/d+uz/ryvocu1s0oyOWCLOMeS1G6a2vqvp8aTg48DZdsMgqXxa692hgmmpP1DVSeDxXAffKP0HeS9/QnRtSUg67MMyU+LpwQ4Z6HTSvGE6eT3R+cIypIb9Haj9i4Ev/KvI0cEXns8H9zQG98lvzf3yNK29iB1t5Kx1AGNiWK9Mqnk8fPvfDJVtdeboJlcHc9buoGLWQPywn2ZaKrVRa06tJQ9XHl9uTRwxkyOItKmZYDTtbkWJliZIr8QLQjqjREeMrszfQqFATL5Qe9CY1gA4mYstBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOR6gKi/8AVW66L5aBMNqlWuV2URJauNlovyRjmhTZA=;
 b=dH96SUFIcA1uB5b3VEFEsrg1r91clwEi5CpAebQz/LoWiy1DVRyaEQ1QmdpRX6kV+LBWjvUNI7LC2fYOOaESY2ip7l/xryNmpqBpdQVov7jUxS6VAnJFbe4MNKy8n/ubBMfjIh/csb735DuB4/iCTp4iZNuwUs2HMKPbIGoSNM7GIXDV4WlqVUUXi1S/XZ/CSRdUeaVO940mx41QCFDU+8dGHhk9mlr6jvZX+rqLKL1SNdHLeO3581ieF1+T3k59aoHfGTw9SB0ZrKh7zSJ9UaEZF9vGc2ltpgKdCjNV0wXvbgwql+gb6Jhl5Do1mZCsp/mepXmP0jKhPQrvQsjqVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8286.eurprd04.prod.outlook.com (2603:10a6:102:1cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.37; Thu, 29 Jun
 2023 13:34:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 13:34:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/4] selftests: mptcp: reset all the env vars
Date: Thu, 29 Jun 2023 21:34:29 +0800
Message-Id: <b0879a1289735ff45305ec2a7d159666b7b5219e.1688045383.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688045383.git.geliang.tang@suse.com>
References: <cover.1688045383.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 1acca38d-e436-46e3-5f81-08db78a5995b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	foa9Zrx021/EixohfG9Li+WSyygCQJWx51O955vQqeOXjP5CkWBO9X10pyIe1RY3UIxwjBAx4xPlO/Yd3BJctk2eEglLyDmZ/mIqUa7L90RQNdiL9pk3UeQl4gaSWSI9nchm02m1T+J5ZtFZglE4CuayBfM2BF16V8kt+CsuTR3H/MXpSgBqi718r38GaTxuo497LFEFwdBXED8z/BtbwcjZDnHBd3PIwvGL5jYyQyAFtxCCbpzjkFAvVj8QAMpGCTjJVjGk0J4R8nLY4D/6cZ7gTFLUPj+fNMXWmvACXmWN+jUPrgbt+mVOgJ+r/PmqfEa9OByP1s+Jb+Gv/HWYIPcuvnakP4XxkOOoJ0odhjSzFyqsh7ygJZnvMomAKlCxbatzZnX3Bd020rpgNZjs8r0r1EjU2UnwO2Ve2DnSf0wV+pPmnGkVx27JlPCbCQSp2PV69x03SI1xuMwrrNTFotDjy0HkZbm6so7vj4L/RhEly9VwjFEZYvZ+ITcSHFvEZG659CKVDoM2AuFN4If+Wh8GFRzDiEXt3u6SDBiBdqerEpqi7LiTrH7efWkvzgey
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(478600001)(6486002)(6666004)(6506007)(26005)(186003)(6512007)(107886003)(4744005)(2906002)(66946007)(41300700001)(316002)(4326008)(66476007)(6916009)(66556008)(5660300002)(44832011)(8936002)(8676002)(38100700002)(36756003)(86362001)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wK1qldGGfnUHIF1+BHPPCpf83DfiJPuT6OUfnCQfX0vrAflS6e/YmPsBYwuf?=
 =?us-ascii?Q?8ftJBLUwh6a670g1E7ewbxXA6ST3vf37YYQzinqBZW0WhTA426Pt8So9Fo4n?=
 =?us-ascii?Q?3uOJEvQOgTSwYUISdh48QuFlRoB1jyZKYui4wG80P7pCuabUgoJtrIzXWCqA?=
 =?us-ascii?Q?aVP6xlPI5m/iwU9wrf8iyt01HPuigHEWUGCwVCCs6hXmuTMUplQQZX9UP2kY?=
 =?us-ascii?Q?cZidZspj3H6qxUWejudbWHW2iJskX9/xeYAesY8bG3eYfpry9HFbM61XcqMQ?=
 =?us-ascii?Q?a2odyaFS+QytQPBFBBBViJecm7jNZti1GnUwf4JVEuPnDdNlstQIhKzpfyqO?=
 =?us-ascii?Q?jySbkUR3hzPaEN25nQzZ+0qt5fMwKZPpIyle56H+7hGLJDvAeLYRIiBEblP9?=
 =?us-ascii?Q?l47pbsLWEEwyNhsNvdER7WRCkhsB5FN0gV4RsWckWuTIs2H1FWK33GszHZp8?=
 =?us-ascii?Q?A7nOcYUIKzopFnAijC4xamxNOcWBduCuBvG/JDyuU2R8SLM9vc8Vqo1h6ZtT?=
 =?us-ascii?Q?UPepwY+Z5hR5Hogevd9AS4dFrqepLVvZrxGyGMqrKJKFPXR/dNvRPTyEoJPr?=
 =?us-ascii?Q?AwXu+tA5ApNNIXcDHzFmQkIGwNop77WPMnNDgDs8OVto8eJebK5U6SxAQ4EF?=
 =?us-ascii?Q?SxJvtaF2DoeXwCH1DuA5jPmegVcBB/aW/DFO5NFlbjwcdFNoV4mCwHEIKK8y?=
 =?us-ascii?Q?xq51kci+mnpejh4Eu1BfSaE7eFT79YP9w7jT0RKPlLMgSuVhpIvaOICTx0jo?=
 =?us-ascii?Q?I65/Zd979uevDJenvibGdnjEykbxt3FHL+TPd7KBtaLK2SvK8Myb/Zs1rpZu?=
 =?us-ascii?Q?pG4B6b8q5rewjmvBGAY516Y7G8HudOFKfhxlru08ninPPb/bof8k6oEKZYyL?=
 =?us-ascii?Q?UJD0r5F9BPTvWU3NNEOlYox/oBOPMOFRw7xq61xWbK98j3zzIAPtdJOaFBs/?=
 =?us-ascii?Q?eUBZE92srpktbFhfvS+10VEU9PoguFU6c1DcDLMW0cxFenS4RFf701O8InbM?=
 =?us-ascii?Q?xTW+xf6FLvAaA+2Lt5r13najnb6p++1oBO1Hegp4cH5+fBnsJXaw1E683lGi?=
 =?us-ascii?Q?RDfj/08vIIXikQS/hjGvt74zt/rzfalr2Cgm8lkDDjEM8DqvEZuVrjRK3fc9?=
 =?us-ascii?Q?Cuw2+KAIFCGUSq1j2zrAlvLYB1f5A37NsTsKfcTuv3vbt43GWREa5jauSDi9?=
 =?us-ascii?Q?6urLIvUDLL/lKVqycaeciW8q8vYn7XtR5/dnszocEnp9gpmUlbVKzrnkand/?=
 =?us-ascii?Q?9A3IekGgrMMHcpOqATC1B0oTSq8R/VUMxowLzVCiI7CAnomJ3Bo3V46wpVtz?=
 =?us-ascii?Q?/KgTedQzGsy5pd4rI7AYWWEcoeHiWaf9j5BppMWYRqY4XGIy0YL3I3iSfTsD?=
 =?us-ascii?Q?C7NRy9LZ2ZTpeQ/kZf2uu0sjEs17feZfhIY41dGUpWp+4IbAC2ZLvScjN57r?=
 =?us-ascii?Q?H5d4Ta7w3vQoUvwuNeZedxZvaqAhoywsfq1/26xAsi4qbvm+y84Lo2iN7J0n?=
 =?us-ascii?Q?k0/oSaf4M1bfg0gVB8J3T2+UIQYys6ZoX+/rx8ojsJ3e+7HFvbtc0zqJjHF3?=
 =?us-ascii?Q?SMkD3Lip3QB7yroUeqKMsDyxjbL1a6qgQ/G6bQBm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acca38d-e436-46e3-5f81-08db78a5995b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 13:34:44.2089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bA6FiMFALuj+LSIERJHK2c3wqhC0MoT+C1J1Y3qhFE0amk2pOgcle+CU6pfE2HjchWFwQZ2HB3iYLOobuPRPKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8286

It's better to clear all the env vars in init_partial(), to let them be
reset before runing the next test.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e6c9d5451c5b..b80c5e7b5a7b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -101,6 +101,10 @@ init_partial()
 	check_invert=0
 	validate_checksum=$checksum
 	FAILING_LINKS=""
+	test_linkfail=0
+	addr_nr_ns1=0
+	addr_nr_ns2=0
+	sflags=""
 
 	#  ns1         ns2
 	# ns1eth1    ns2eth1
-- 
2.35.3

