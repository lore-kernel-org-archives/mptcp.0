Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FA153B7
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 06:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gE+HI3yMwVjhBAOB3rC3j93AdTbejXYuaTBQGyGTDuoXeqIdEjyOWz1UFIidCQGP2FM0U4hUEjvNEe9W8dpPdrvpLaGvTyleyQo0rMx9TW87GAmELyC8PRBmvZm/4KpEMZNNal84KFSyhfD/MqZzR6m8t9LhP4/k1QRT9dsqo+mWt3Wv+uDW4Ia1Nx+3cd74CzLkBQlBhz12SD0qyD9GkPSgngVJx4DHYin91CJiXEokC26utc/ozdtIDW6rieJvx8hEuN4k43F77FDyAHB/RlsGn3d+cNYjn0zrLn9Cun4CgcIVN/1TeMnyKYYrYQcpZxoqGZWWslFqIVOeaiEf3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIScZCYOVQxn0NnzHdWJp/gCQ41x6fLhNYZyB/4oKo8=;
 b=fK41/KzK5sL/TTiQmj0JtspqnVMBr921h/FlyZabd4Q93mu8J64wJRS/SawpuNS+vNHg68Vko4qlDVBh7DQJuFfwvGTJGhhcOOhukuvBlocPDWVyIkAQALMBlNJa83em/yWu5E+epRkNFdUzD4BeG7ONn6hr/zqipXz72paUYXwH7MewE9hg6DbYNwLPd/NPnb3PJCQDSr9IXw0cTHQ3KCLY+sLvrzFWbNGVC1nE4lvhWEh/eX907ybtJ1GBEmWF6+jDiQM4qoySG5LA48DvBwi0uiwzbhTm4J451tjygUe5ibtFIMPpUAaoDjn1PNjbKOZl8Z+HN7RUTdcpOf+Z6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIScZCYOVQxn0NnzHdWJp/gCQ41x6fLhNYZyB/4oKo8=;
 b=XEeYJnwde6kG5cpr2E7o8TNSOJcGdoTyjKiKq9s7lAj3p84GHffO+h6JbgJ/BwE/IXWUgJVzbz8y08Jf1FLjUQ0O0+5sz6ip4cOqNK+1SlP3DOkCDgO4AmDrZUm+gaB0qBOFkhU1LqljuTYLpGN+LfpULUHFW10SjyYqvOmW0d4zWQKU5nR7jhRCFSulveDgNE2YUGpzw0oCpH13Wb0qIxwy+juEQQlIr9nLUP5/3aikGM7UVL9FfyGSa+VjY5ZsB4Vn0AjasvtCKCdbuUK5sUVeq9eCl/4gnco2qjaYjGLr5hsLu3wIMibxBL4tPjtmvszllgWXDNeYCO4qNQ2utw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7029.eurprd04.prod.outlook.com (2603:10a6:20b:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:46:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:46:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 12/18] bpf: Add bpf_burst write accesses
Date: Tue,  6 Jun 2023 14:45:11 +0800
Message-Id: <972ce6e4c0f93d1fc02fa202bfac01c38c681623.1686033694.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686033694.git.geliang.tang@suse.com>
References: <cover.1686033694.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a07f4d9-bfbe-490f-55c0-08db6659c41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qwTLPbC1hlv3DA9PvgmC+YCjoVxhZmueBcpb2dQ9mF3Ita+KWLObRuchdg+40QiTIfo71UKgCnO2dVZnbkBVOxMMwCDq4MXUt5lVCZ9ly36qMcJRcONND9uYrvywlBrLa5SHGkQoVnBJ5h82wHd7kjPUqR3HXaMQq5IBXYk03UwkOy653h9+iLxbzKXoE135wUDvjORJ19C2xFbd3RU4YaLl/rqaQll+Auk35EPme4n18pit3TDXCz01jSfh09PVIesgkpuwulj4RuBRFOXjgXK9Khm/ZBclRpZQANDy5LqHgmmlxJ4nc+OVsh8f34ICBr+W/cBY9yguONzUmcEh5P8k8V6YhMHx08dstZhtPDXxp+3c+lWsDssKzI5YXjlyNLyCkR1GMj12IcDCFel8F4CIvuQFOSkpgqqjJhSgkv3XFTujm6+b0XTlXRXxhLywcVKMjg3gB0g4oz4mW0QlMDuSsKv9xflMV2Rlj4VJ7ReVK07vJg0q7YUXa7N4kAjlif18lcr/FixU8ScMEbC/d0XGnyIsf1qVscb9gI7hlepla3kimh/srE+UeXZ5HqZ3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39850400004)(366004)(136003)(451199021)(2906002)(478600001)(8936002)(5660300002)(8676002)(4326008)(44832011)(36756003)(86362001)(66556008)(6916009)(66476007)(66946007)(316002)(38100700002)(83380400001)(41300700001)(6506007)(6512007)(2616005)(26005)(186003)(107886003)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IOnylKJ3ebeYcN0MbsZSEiBjOuG9ZDujdNYAeN79F+LTF+C3MowhMODiw8zr?=
 =?us-ascii?Q?6XxUhJl9x43p57eMOny5e4KVxqefZNN57B2PO/JZnKv4zBab9xM16vfBdHmf?=
 =?us-ascii?Q?4cOdzg1B80JSNPvKvwBz/nrboaRMZ36cmzUYLIKebpWW5qgENK4JuRo/msWK?=
 =?us-ascii?Q?GIaTScOm0RHDV94ISh4DYUAJNOnTcecOFixE2CbOIaKt+bl4PLDwJ9c3qVmB?=
 =?us-ascii?Q?JmkxQuFmShad1eGaWUXS9KThlx2GefkMNkLUJdDPwU3wAZB1knguQw8SmfqB?=
 =?us-ascii?Q?kRbdh8MElJtdvKzsTvmPABErdQ/si+xoV4KxQGxChopW6H3qJSuoJoLazpOp?=
 =?us-ascii?Q?f/sUu1n3CXz6xVfXsiilHB8Z7b9voBJrhukfWHjz352EFQy8xIWHXjejJJwQ?=
 =?us-ascii?Q?3rr+AqVpUPEb4OSnOaPn5wj6Iv8uI0IoTv2MgW2Zok4ZuJQ8yT0V7sLJCLh9?=
 =?us-ascii?Q?awKfvzG97XQucltBdYnjIhZsnOXWWO4Vn2Pz0ruUi0x9uQ6lOjtDI1kxHCNm?=
 =?us-ascii?Q?dHvTacudZGcRqM/AyBpkO8KwpAEttML3sqY2rUUkkMltcQjoSYOuvsJuWj0P?=
 =?us-ascii?Q?HfEiBF6xpR70tIuhYPZ+UXp5guHnupd4JaEyMyQVRv18XlZjHZ68BQxJzIeJ?=
 =?us-ascii?Q?CwFQ9LamJnafCRZNY4P2hr28d+H0aLf2RBNASt2UH9qxCVLaG/fMQVpiSb+2?=
 =?us-ascii?Q?0grj1mcp7Xs9l/MGFQ4dYo9AF6p2VuUllsL2jO1WOgMvKgOOYMj3XPegruq2?=
 =?us-ascii?Q?LzUFfWyDO3ysuqSta78EVFMtNu98nr99i8cNRRH28QGS1O71rK4qZrdqMLoJ?=
 =?us-ascii?Q?4sFKYCHE2FI4R0rx9cGndb0tAOBGWeGKzJBWfQnYsu3uFNsFWs6hQPnkoaTS?=
 =?us-ascii?Q?YGfJO9jbKithOwX9ilKoO8ZhyrwT1Ub/O98ZVd2l0lH2M+k1zRQJGEQki81+?=
 =?us-ascii?Q?yh/nyO2pnGrG8W5XJpKIElx/SDt7q7Y7I87XltTI03Bc6XSyNgY5n5kuFvy5?=
 =?us-ascii?Q?HCcdrZVujLdEQMtaduzsC+N09imHbWuItC2DQMvypybXpehkJsKq7kB7TSZ1?=
 =?us-ascii?Q?dA+H5u94BSChf++i11MAdsw2+BZK+n655lNQE578LwfA68Xn77eGQ9XyxiuH?=
 =?us-ascii?Q?ofpShYfIn0evO8/QSnL1GuXhCx9o3vJvxw0dnxYmewHON0nn00DWLqjZsIg6?=
 =?us-ascii?Q?l6DsY7kOqgfe9xMnWb/P5RZT2GdN2k7vO3q6nuWfp95Uzyzan70v2E90pQAm?=
 =?us-ascii?Q?UGMRlxGvfuku7hoFrBh8YFHkuy9NtJm0c6F5r1fTGg2iNlnNdl5Bn88DLhfg?=
 =?us-ascii?Q?5qs1YIssCZ0YW3DJnSlI0QTKxUtuXJS+5kf8vdPQ38kNOdZhrb4zU1bScjnp?=
 =?us-ascii?Q?3ysMk3dNcJa9/o7/eXOHNuY9joDuxYESjz4mAGiGOi5kQ7ClY1m2/OAVFOyF?=
 =?us-ascii?Q?Sc9yZp0TkhUZb9RiwMCuQxLvnkjgRKxkwb3rHOz6HnC6ibb5awKpI7y0SAlA?=
 =?us-ascii?Q?SsKYh05XGGXdbMoV+5mQgXeE8wy9gxM6yLSPVohoYTXSfWWeA/wJpJDpHhXD?=
 =?us-ascii?Q?GBI+xqoRKVR8Mafzx3cbSxDWcKsTQ8cAPvQrbTFF?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a07f4d9-bfbe-490f-55c0-08db6659c41f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:46:33.2928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ml5f+zVwSkqVxw6fwFo+qyUU9R/XIzIti/TK+XDT1Ou+cW9EY7LRxE3S4U6TVMASWsPDMZ6qFjmyCETcS4RE2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029

Add write accesses for avg_pacing_rate of struct mptcp_subflow_context and
snd_burst of struct mptcp_sched_data in .btf_struct_access. They will be
used in the bpf_burst selftests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index cea6a8562f70..719d673ad346 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -51,6 +51,12 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct mptcp_subflow_context, scheduled):
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
+	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
+		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
+		break;
+	case offsetof(struct mptcp_sched_data, snd_burst):
+		end = offsetofend(struct mptcp_sched_data, snd_burst);
+		break;
 	default:
 		bpf_log(log, "no write support to %s at off %d\n",
 			t == mptcp_context_type ? "subflow_context" : "sched_data", off);
-- 
2.35.3

