Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4625EA3
	for <mptcp@lists.linux.dev>; Sat,  7 May 2022 06:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651904296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9HygC/q336DB8NL7c+p/+moZqRFeYh3C8UbK4JAumE=;
	b=BwHdQKz8Wfr8CW9KN9bMYf1OcGq+oo9RzLvmAHHVOgvHAnNwMaAPJtnXQMrkyeEQcViXsJ
	HcUxUm1eMJEPvV8+/9GVaRUQ/RlqYA3SVJkZRWBgEfAlcjVCKMCWJJfbgnoBw0IGV9qeEv
	lceSL4+HKjPop2EwtjFsgdsf6NFa+dY=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41--67oMeeVNweWyai2r_1BGg-1; Sat, 07 May 2022 08:18:15 +0200
X-MC-Unique: -67oMeeVNweWyai2r_1BGg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlNS/j+n/XxYOPNbcJxPmK3UBTwVruTo3219ECHy03FeR+pFen63MbtYd/mzsCU1/q07yG5XutNnIEkdy2nsZj3cQAlALtVtO/FwSy0q7wX5CvkiHGPJNNXJckNrpRxmJ/FAKu/PmFymBpRyo4/phWL3J0ITK9ZqB1YF+yPMvLiIsWzlb6Tf7kx/EW6ZVvzDdcAoPlQcdV+GwRBEsXsGquku5XcsFFn3nKMW0Zk9A4rWri+Vqn6yR06ESxAYg8SpVllibmXbsgs0kIYcZfTz4Pjf5QPIYJaRomZrJt/XcVZeNdLFcnFT4NsO9QShn0Yka/n2UQZKX6T/p4OJg4SESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMQilRUz2TY8fMzM1CeS2VsVwnOK3KhCJnIOcJRZSYI=;
 b=BHnfYhpEi4V+tz0aL3dbaHU/qHerqJvrMMVraeI/0CoqosgFcmZXzJGWGrywPAdDxcSHlTKq2rf9pFCMsxOpgNfe+cVyqb43j53+uV02J5ZlFHDoqLTA9owXal8Sqiy8ZQF7C2we1jeQEJp77GfslS3jjea49C1qyjI80E16bUcbR9stY70QTkwb4tgqX2l7fkmh7sZQ6KCAMFud868NScDynfGj537rDiXAaWfYpK7PvzZdC9EpJBdLCjx6HzkIpS6O0k0vEgej40HOIquXVppbxeOg/TW5rs6DJpUiSVkK1wPTmFwRjDkRszk7mejRhR2FPnfWXAKftOfkJtCSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7489.eurprd04.prod.outlook.com (2603:10a6:20b:281::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sat, 7 May
 2022 06:18:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.027; Sat, 7 May 2022
 06:18:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: bpf: add bpf_first test"
Date: Sat,  7 May 2022 14:17:34 +0800
Message-ID: <c69a81a2105542dcd9979f4d722e9d47233ec851.1651904180.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <83acce83a5bafc3b45c45b56105678210d07ac92.1651904124.git.geliang.tang@suse.com>
References: <83acce83a5bafc3b45c45b56105678210d07ac92.1651904124.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0217.apcprd02.prod.outlook.com
 (2603:1096:201:20::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7aeaa76b-792e-4d11-99be-08da2ff15dfe
X-MS-TrafficTypeDiagnostic: AM9PR04MB7489:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB7489C8929F54B22C43439649F8C49@AM9PR04MB7489.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UYqwSIosdIiHi/J/Mo92eoYegTSvcECQB69bhO3CEyUmSqWjSNSyCncYSg13222hl/8vQRQSpZ5J4HqyP3LYQ+sdlYKWgQ/j7pFkjM8SYncED2+Vip28u7r5qggPidhgMQWPsf3EaN4rfEOsGqoob0CYjOqp8hfW2z181o9qUpXei6xbyj5KuOFs+HWBycP//qkXN6PdcUoeK5Cw3lk9sgwoXZMd+LMafzsbILRFmDvOVgQeoRVK9eWAIxfWGBZd1+w2MsWe6IXn+sHZp5iYGIGhwR9SMFw//sdyOxIKfY5R4RA72XYbDEhgg4DXYH8Q+2AgbhoBFS2NU2AVIxupRhSp1HJOA1Vs3vsz1unrh5eyr55due+16O2KHixScbPJxkcKuljHIdiRmx0pDqVM1WcUz1fcXq7M+HlTbDjyAmR0vcXWkCMgz0/Z73wjjctC0xQ0leE8Hj0OZiAFCNH/G9Fv3IfMfUt6vvxxYeVlFifFhsS4k77d0LIiUAtGn2w6MeZCEQf9WZOHWgF1hqUxqMcxgpxq0nH3JqPp5Qd0PMK8Khla+DnqWiYidVPoBoBiC3Emsig/vbbegAxVrPC0Yd1tCrIf0ZUCGfyhzNjZVPmvllYAQLDybfQlHLVTDsvksKbkq+Qd14waavtgCd558Ok/Fkyaz1ZIH33dKB0Wv47HcRamBfMf/HyHYObR8w2o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(8936002)(2616005)(4744005)(2906002)(5660300002)(44832011)(186003)(6666004)(316002)(508600001)(6486002)(66556008)(8676002)(4326008)(66946007)(66476007)(26005)(6512007)(6916009)(86362001)(6506007)(83380400001)(36756003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qIdQQPlCv7gFRHn1USmcw30KgU3UURB8GoV5ErTrGZVtj+4RQ6LjdEFpAChu?=
 =?us-ascii?Q?H+CxSJ4qishROBBhi9YCB1wYCPhlrmfijTJYpg+lrbgihqku/AtygT25G6mC?=
 =?us-ascii?Q?jdIa2PNZIaddDvL1UlsjiyunQyK83cYTq9JnAvo7wLa5aab9JVVz/16bmjUa?=
 =?us-ascii?Q?b4Ela/ScjEoD+bK8WIgwF3NdF6ufR8KXDm0Bgs3PuB3vV2/Vzzud6+n+kJyj?=
 =?us-ascii?Q?WPU9ETrBEy/cfvNnjjqJ+869tznIQdkW+XQZKegCIBpvfmZDBDcP0WNEY86H?=
 =?us-ascii?Q?n4SEFm0/rrYX8AeVOoEn5wUGkUEr5zdXyfY0rGTAjeUUjQ28pvVbr+JJYcCY?=
 =?us-ascii?Q?Hj0/wYqY61bJBjOwoVOrHQBZ5DZmsArbuzXAMoOYgrk7BkSqWog31/3ueoBw?=
 =?us-ascii?Q?IjprRkoZydPx1PKAkxd/LXylooaVN9/IFpq+rrVaERI7C+UgbUVt61YEkkRM?=
 =?us-ascii?Q?W1je3ARP5gUftwnY4jO7UShtaJlmUVGXNvPIYGSWigXYNxWYHf9NqLSs76Ew?=
 =?us-ascii?Q?ltkisXPdMWOjXjI8Y8ONBkeTCu3yHlb01m2tWGdmjdgGaquF5yME3VLOLlFj?=
 =?us-ascii?Q?8n1j/7EIYg+QbVaTEC3JAvpTmkxW8Utks8Hh0hljHj6b8mSCLuPZRA7qcIeY?=
 =?us-ascii?Q?t3xxqlo7ftFlNM3IZrT+EGwxmrgBoE9wvnxntJu0SOQWJhJZzQAM5qf3SVJT?=
 =?us-ascii?Q?Tz79LGIf2wcunQnQF1tjuvFcYg2lvV5nnY7to45nh6T4JDC7LvFd+GeCnSWT?=
 =?us-ascii?Q?NzF2DH9mu+hCB3bykg090igtgpCpGs+CBeshZvhBkooRvyAgA9n3SQg+xlhK?=
 =?us-ascii?Q?GEcRI4OUMG18V3SEbkBdK28X5MshwNcVIvHzjgcNXQXFQXyrFtWi9mY/UQNp?=
 =?us-ascii?Q?X7bHXJABi+v1pwd3ZXrfL5JjRHkvgN+qc9IJRY6FkM2ZcNrF0L6JM4ULMDiz?=
 =?us-ascii?Q?vulF96TOnUS07bmFl35mWYZ7gqRQTpnfdYMfY0ORZXv+eYiMq9ToRXVrsaQJ?=
 =?us-ascii?Q?MsEnzZf/clfkqVhDuwvSn4xCtI9gND5AgAJHyzHoclc74NYBXOP6qojYPY/b?=
 =?us-ascii?Q?DvrIjG4+NvKGpqbAeSmqhqzkR0SZvv5CiF0REv1DcMc2BZbDS6VOXYRL8Yyd?=
 =?us-ascii?Q?iGLFvJQ4yjWnUPO3tX711rTmm4SLS33Z3mgWy55no/0P6zsWs0VNFYl9PyTj?=
 =?us-ascii?Q?2xEkO2rez0X/tEoZnpyrNOsBmXHWfmsxk0WEPiLuXmPvK+X+axeWuTWqzoeO?=
 =?us-ascii?Q?Tx5leYH76tXCPRvAzf0J+Jht5xgBq7rYfOQ+95cX2y9GVMSkb/DozhzHoyuI?=
 =?us-ascii?Q?FBUbXVCOWVFH3H+2IKMUYLMMoejxmru7v8FbGGDVFIfWDdcq6c1Y3YPVmg9N?=
 =?us-ascii?Q?+wtukzMh6Yiog0kVn2izyac781qtO2Px1idc6Kjar1mFWG8efMNAIqa5GAtA?=
 =?us-ascii?Q?1og3aUlYcQnfJvqW1xu/nnmDEXca+RyyEbqgisqdnBkKqA1OYJjtgHO1gH/a?=
 =?us-ascii?Q?YWj9mfJyLp5XpKebzvmIZZOwybB4NKLbukwV+OwqgZbc2tYIRa3MC46dqqBv?=
 =?us-ascii?Q?DSSQfJivLNh09OfvMKVE7NZe8hLGn482DsKEVEevkvOJLw200bVOMV0VWdMB?=
 =?us-ascii?Q?YRsRT3AGrRbP71ysDBqk0U86yjOYWugTubgVO4tu2ToIOeH1PV/46nenyKl8?=
 =?us-ascii?Q?rBRVRcWlj9nm785TDTdpxX951zFt1gv4JjWLFK0PojO99TKiZ6WWqWyLWIGb?=
 =?us-ascii?Q?U4NhSZJoa02MdtzP4ZEL6rCd044BjVg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aeaa76b-792e-4d11-99be-08da2ff15dfe
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2022 06:18:13.8655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYHcLCtcnFerjEWmkZJkdQl7UJTsD/OtvKlrbdfLUO9YkXOxD0sEoFN5t3XPfs3NFMis8oSDiWOyl3rQ6iIDQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7489

Address to Andrii's comments:
- use ASSERT_* instead of CHECK_FAIL

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 625d7a644fd4..865e3b392ac3 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -343,7 +343,7 @@ static void test_first(void)
 	struct bpf_link *link;
=20
 	first_skel =3D mptcp_bpf_first__open_and_load();
-	if (CHECK(!first_skel, "bpf_first__open_and_load", "failed\n"))
+	if (!ASSERT_OK_PTR(first_skel, "bpf_first__open_and_load"))
 		return;
=20
 	link =3D bpf_map__attach_struct_ops(first_skel->maps.first);
--=20
2.34.1

