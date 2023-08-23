Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2043.outbound.protection.outlook.com [40.107.249.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838F34C75
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 10:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npalzoXkPMWTgMfS08rUv+531IBDHtxyX4hHQzFFTpekXfk+RhNOC7yFV2c3VG/1+rH2hUmOkiHt92Ut5T+JoCqLTKtsxoRKsdHCoJ/5aHFTgsonBnJm8NxEN2fhXa0P0GZBJ7KemPheuBvGQNqNNWjg0wuPhgHKV6OxaF/KcxK8xs3B5uDsxAGuFfeDObzhXwLoQe9VvdOeJff2bWRd3dZnFsBbvq4sKehGbB046Qzii0Cik8GAPqD9PYwM1ZsGRKZLoSqTYnf+XaR2ON1765GMS8akSUG5pmqIdwwMWVYkSqeYuVh/kzbuAyejSJq3A32YlBNE/pOUT4sRBSB5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TR6bBBHsfIYt0EkioJ1tiLTLj4+eX5Y6PDswY8ut9ro=;
 b=l3i4NJDOnUIwiDD4QPRLoHel4mEpsxuJntFOI4k2AF6LgVAannJEvfBnYGbpHMGDlZweUqA9ZX8eO6obWACqeYVd1wPaiuv91nly9wqxWbWKMqTKG4ms7aAZmT77gugNIGf6/ir9xe+oAFYnMnwqKh6oBoX807EnJzpbMsh2rA7HjWHy+wqBWMaBeMYUMAt5ZyWGW4olfbDMwqo7DFG8wwItBcmtWUV4rqdVnXGYjVLLYCNvFUwio2M2O2Za+UzFdPco/7oB2KIGsqRFnZmjfdDymt4OONS0jbvZ/rHe6gzbzdgGDIWCKicyYkNjHObFKysnHHjclRa+tGQ/H4yvng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TR6bBBHsfIYt0EkioJ1tiLTLj4+eX5Y6PDswY8ut9ro=;
 b=Sde8EDpMO8REgaFhkr+E8ggyJOlZYzmGH+2xi/Z0fh25PvWavFxlb73KH59sbTHe1QIEZk0DMzQ9BQKDflvAvx3nQJRtVUTRZhINE5cuMYBzG3FrsgAjq4ie33BjO5YM7BJXJeriNrNCBzpktSpM5SO1edtHu1ACvk9qJ/gAlG8GImWBEAj3xs4qteJ8wQ8nzmQ6NY5soz9BzS6DJvZmJBpwyJ0wex/PlE2Iplr2ngG5cSDNBy56KKjGyL5BT6IE8KTqmFfClW1Ovt6HlVNxuhruNWQd6SWIWM2e7Wc5vWo/er7FyMnye7jdwWu3ytk3bPxucB+FfpNmOVLdtXM1zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8967.eurprd04.prod.outlook.com (2603:10a6:10:2e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 10:43:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 10:43:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] Squash to "selftests/bpf: Add bpf_stale scheduler, v3"
Date: Wed, 23 Aug 2023 18:43:53 +0800
Message-Id: <bc154bf23639cfb4c59e6b1f593cbd0772095603.1692787403.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 727800f1-d9ec-4f7d-42f6-08dba3c5ca5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xUBreRdVTaVKPFa+6QCBicIlWkYAGQmZuX9nx7s1OK20sGquqjJPRbfh6hHhroBg5MD2dFhziR4NhVJDEYrVpHhLJ90I/9tXLMOrBh05zjMuTE9GI1V3tIAiHJ0EIeKDGjhOqMHbq+Wu101tecWJc26QsDUo5Ju9xuedMuwqJXKHHC2itIzJVgyAEdACDnD4xFyViq9uhR4JBdBS5b0R8/2PdWnXOlh4VbA9K2xZlsD7hLXqEbitF84fhg5e4SOX+5bUA46OZBbZLIJ+O2TnfWRe+vp85jzBWIm1snIFr67gEcLP1vydFgaPrx6Q3l14XcizlesZeX910W3oyNH1e6iErB0RmSWFwGznGOzhGAOJi0vHeKT3jFi+fPrxxDUNDbCV4SsThvHykVIppL31HxXe8daZQmC2USZV2WlLRy/uLI6NkD+et2qm57iu7aUl/qVPaLyWKTWiehZlVVMmVQma9qMBejICob8JT9UB65T8wgdeYfwD/U3xZ7JD+24jl4I9Kyi7kbYySUekwpcdjK1q1NNvBB0pEXVcFTwz3JIHygkFsD8UHvnqlSpr/CAXiBsR3xqobTArYfLU14XrOxDJz1G698Xdrd2hgRBzUYs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(346002)(136003)(366004)(396003)(1800799009)(186009)(451199024)(2906002)(83380400001)(86362001)(38100700002)(36756003)(8676002)(8936002)(4326008)(6486002)(6506007)(66476007)(66946007)(66556008)(6666004)(316002)(6512007)(41300700001)(5660300002)(44832011)(6916009)(107886003)(26005)(478600001)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dqAPmntZ56rnLp6udtPlzPNkEymepeq8s2xE7O/rvINWZyaRaBvdRb36ttLl?=
 =?us-ascii?Q?Gz5Ikk8BmbVOIHgz6QbPR2K7slxT/UYie7I7+9aplw8xlYa1vGGHXAojGztS?=
 =?us-ascii?Q?ZKd4YptxhCtqaNx2sZ0Ec4olUbmwVizqWnavAiDwpbiN0pEkZ4/j0y9BtXZk?=
 =?us-ascii?Q?iNpYs+Te7qWl7V5C8i4nR9IiegCWq7zTxAjl509pr60dsQOT8P64L1/iqx4Y?=
 =?us-ascii?Q?gO/BkNQeJqGWA7AwdUdx3x1G6su6mCIC9B6tlc0WsZ3bwlFmYwF9RfspExH3?=
 =?us-ascii?Q?l2t75/uELHAvCZNDwnmyYb0+DAMJ+Y8zgtEOS6oZur56fpM1seNqVIWF3J1p?=
 =?us-ascii?Q?RmoYoATeI0R1jxulPunmCBW+aXebpvy3eTDl49kFBtL2PdMRrW77g2BI/kYB?=
 =?us-ascii?Q?k/mIxNdEfVxIMqjQP75xbkISNZGRQzWV45XCGwNI4jIzr3jh5NFIvkRckjjJ?=
 =?us-ascii?Q?5GcXyAnOND7vK8hDbQ5W/68Md+LsdTVhGIKfmMZECOnWW9QkBvHOoYy97+EB?=
 =?us-ascii?Q?TKz+n96G7twDTMzeSALQRPmOhMVhyOuM4he0N7VuT0bIYa1i2dytNfUftUuC?=
 =?us-ascii?Q?f7BL2kpnFjSEYJyyJXFfkBTzNoipXEF2GciPufPGP9jEBPi8u2wbGCjjxfl6?=
 =?us-ascii?Q?UDxdtq+bL4np2Cuj4fwUSeDgY29UEG5G5VFS9gQNAdmllmuMO6lKAZ3LOyjH?=
 =?us-ascii?Q?yYwwVoZj+XJdG8q39vfRk48ICbesak8MxVjs6SJJkyERYEa7PovOdVmGXCNp?=
 =?us-ascii?Q?bDiKPz/b4mQw7mUqQN1MYvpAwfTh2tKO/BAyr1DvSZKql3h3DIa/FLOJUVhy?=
 =?us-ascii?Q?IdiFMTCtPBFry2yTZlXXqKBGBtZ2cRSQWhaBe/LFt9FqlSWl9w4ue0JsMUlS?=
 =?us-ascii?Q?JbcAN+dJ/RsIzHOao3gC6VfQ0ZWHZOELneKO3mCDyRMSVmAc8jtcM6WQ1UPr?=
 =?us-ascii?Q?LTEc0f7+qxsWPsb+647Ql+I+MdZ38nMsdKh9z81dD4Iz5RlQPjrumoyUwjPU?=
 =?us-ascii?Q?coOSB+HvQpWb2217XL0kArLQ+4AbSmeX4NB7Q0GuXSF8HFn0aFh0Fi921PRc?=
 =?us-ascii?Q?lTW2JnpXHnxne6XjC7CsXlhg5vRMK40mEGzv5oRe8tVqhq9jVyL4Kw5QAU+D?=
 =?us-ascii?Q?DEDujM43zzqABZQMEbVz6FkhYZd7ao0klxu5ZjqiKtew9PB9/90KI/925cg0?=
 =?us-ascii?Q?WL2pus2HJ0DVUycIbbyYmIlK03Lr6XibiqwZAD9sJpmuGaeHxVcvgKlSxyVW?=
 =?us-ascii?Q?+QhdmLrYgoYto2gvruyh/E8m9l7IkGk8oEty2jMzgpvIC/CVZSeF36NtNk9M?=
 =?us-ascii?Q?uTDbz7wwlG/gKr6tETiaR+FuWc5cvyknPpLEpYAL+2Qf+Zq1YKemvSu/1JGP?=
 =?us-ascii?Q?JjkCIorlyJwImDOFWqV6uDIUbE7M8qp1y48rjjQckrhv8qUfMT6RbPQu3gNK?=
 =?us-ascii?Q?F9bdb+47OMDFSjDQJjN7afW/gOAiS/Ubzyt0vrTa4fe6acibV4AgtFdDwq6w?=
 =?us-ascii?Q?3tmdsNVWgxqHekM+diBtiKkKt5r5VOolsRYi999YNncw+huMtPefBJOdPsi2?=
 =?us-ascii?Q?TOHWvUmiRMYoEFkpoXeqeTaADM+7EKeJ1yFPAs1S?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727800f1-d9ec-4f7d-42f6-08dba3c5ca5b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 10:43:30.6336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnhzBPgZiBUfW8yJJThKGk79i3in/KLtGSbN7TXfG7mnMqRSudlDIxaZW7VM0vSs/dV530sa+7PUR4Oe+el00A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8967

Move set_stale from get_subflow() to init().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_stale.c     | 33 +++++++++++--------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
index 08c857f79221..4cd44f911c1f 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
@@ -90,7 +90,12 @@ void BPF_PROG(mptcp_sched_stale_init, struct mptcp_sock *msk)
 	if (!storage)
 		return;
 
+	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++)
+		storage->ids[i] = 0;
 	storage->nr = 0;
+
+	mptcp_subflow_set_stale(storage, 2);
+	mptcp_subflow_set_stale(storage, 3);
 }
 
 SEC("struct_ops/mptcp_sched_stale_release")
@@ -102,28 +107,28 @@ void BPF_PROG(mptcp_sched_stale_release, struct mptcp_sock *msk)
 int BPF_STRUCT_OPS(bpf_stale_get_subflow, struct mptcp_sock *msk,
 		   struct mptcp_sched_data *data)
 {
-	struct mptcp_subflow_context *subflow;
 	struct mptcp_stale_storage *storage;
-	int nr = -1;
+	int nr = -1, i;
 
-	storage = bpf_sk_storage_get(&mptcp_stale_map, msk, 0,
-				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+	mptcp_sched_data_set_contexts(msk, data);
+	if (data->subflows == 1) {
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, 0), true);
+		return 0;
+	}
+
+	storage = bpf_sk_storage_get(&mptcp_stale_map, msk, 0, 0);
 	if (!storage)
 		return -1;
 
-	mptcp_sched_data_set_contexts(msk, data);
-
 	/* Handle invalid subflow ids for subflows that have been closed */
-	for (int i = 0; i < storage->nr && i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!mptcp_subflow_is_active(data, storage->ids[i]))
-			mptcp_subflow_clear_stale(storage, storage->ids[i]);
+	if (data->subflows < storage->nr + 1) {
+		for (i = 0; i < storage->nr && i < MPTCP_SUBFLOWS_MAX; i++) {
+			if (!mptcp_subflow_is_active(data, storage->ids[i]))
+				mptcp_subflow_clear_stale(storage, storage->ids[i]);
+		}
 	}
 
-	subflow = mptcp_subflow_ctx_by_pos(data, 1);
-	if (subflow)
-		mptcp_subflow_set_stale(storage, subflow->subflow_id);
-
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+	for (i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
 		struct mptcp_subflow_context *subflow;
 
 		subflow = mptcp_subflow_ctx_by_pos(data, i);
-- 
2.35.3

