Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89A21860
	for <mptcp@lists.linux.dev>; Sat, 10 Jun 2023 01:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8tHxxoXB9RSHuTaV669TxdWyskziA/6mvTRZJhgo82EDkHRavmmJLYLqR9ebrDZq0EllB0cgBw3t3m4I/y+yjBBULZHU37AlgmdPeSyvv17Vvwv4hfytYoU/kZFS6uDyIgjx0/TK5D3QdRoz3Pv9L7ujY6SiI5rV0NWxiwmVzPAueKolFL5G6OtIaimWALGJ/b8UyL2du/cRaMxiWfhHCae8djH/wNWzMtUgy4jn8Ujq+bUPeLJv7WVunMrIW38kk5npU6AqkMwWezIz+SBMbJ6ejp9YgJlaa6m0OHrCUgBjuA4A1VHPRQjXrzBStpkn1v+yJfOhs5WGXLQPbCfJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBfp4t5TM711ceof4NIeGquvis6ZxyOrPbBdH4Pxei4=;
 b=UokOIR/GPejNWJPryFbfy4JtEjxADG4Kz1ipdu3NEUnZsiUVjbhxScKATtxPFXIQ9/FUxPnv4+TyyciJqqSBmV3CX8Z7aBL196FcRZUP7voITStruzhQ4bRRMRJTQzfW6L1U6r+mwqQwTaCSWaC8Id33KlHtplhZhulJg0pZF+hs7UyfwBrhzmTCj2kKxtPynh//fQKt/F3xhWUUtYma5VshWpGhpKUikUZCjbLev02meur9meNkkqj8UHeYHryHDdAfQ2x68w3nrn69helJ4gK4JWcoqoKeR57k/AreZviXi4IISwNBHB6x33DtJ4eU5q9/dl4rI+DJXPdcSn+7Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBfp4t5TM711ceof4NIeGquvis6ZxyOrPbBdH4Pxei4=;
 b=c8albG55f/iyA3/gZbC+MtVxFjWfAtyc97+PGGvnf+LpV0BCbC4qWTZQMAgEz/0yE/1LcJx6xzB2ehpChQfQlZqGVVUFBKKN6sAXQzPVQqD5MZRVy3ZEppdYcGzsk8lCWtFB6r+dSnAvkNXeTD1laQ5siMY2wD2JMC0vG2TIJZZCD9NRNX485NbiCyx/C+cStNtMyPLAUqP09u2zb0YYauozXvP6cj6nhYIBYz7lEe90qpnNF9jZZwUhlmrnbz1mqTJ9hi9rYHrra5HFDiGUsPdQbaHZk5l6+jV1OTT0Z9tXxGSVpZiZHo49owm27nZk0v3tTcf70T85mlDjFbGZuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8612.eurprd04.prod.outlook.com (2603:10a6:20b:427::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Sat, 10 Jun
 2023 01:45:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 01:45:28 +0000
Date: Sat, 10 Jun 2023 09:45:14 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 13/17] selftests/bpf: Add bpf_burst
 scheduler
Message-ID: <20230610014514.GA2843@localhost>
References: <cover.1686202841.git.geliang.tang@suse.com>
 <bf747921efceb7f066a75cb2dae2ab46071b8275.1686202841.git.geliang.tang@suse.com>
 <666004bda6ff9e3e6d65c6903c5b18f18f0e31ed.camel@redhat.com>
 <20230609133236.GA30403@localhost>
 <4d34b373094d8415d8d6cc29af013dc508a5bf81.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d34b373094d8415d8d6cc29af013dc508a5bf81.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ebb864d-4813-4e1b-ae0c-08db69545dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FWuo0yBQJ3QyuNxqsKeFczhbz+EOzzhxb/HDmosm1iZxTYu6ICEn9zbDSMBzyscsKubx1lF9UK2nEK6P11rMYO4/GhvHvGdK26nr7tQprkUSlApkQvW7gQeEVeRqfcodd4dm9pfMuGfsoLWZ/3VAzuKGwqaf+A/etzh3WklOlCtFOYE7C1u1f2cjs++LAdg1zS9btg4q6z3oDJ+7YCQzCOUKeWx0JulnMiXx1BBu0d75RBSJhXXZwBd8qLpMW718zbtVvh+jC85E9H7EkhvdG/DSfaiK+cqFdmVhYywgSMmem812ixxreAyRve3cUa5lYOqoO9A61hWEBNWb4WJPC1z+O/zyA3BcQ04Kv3HCZg3qmktH/+3izTC03wcJpMRQQuMpUUid/hCjCXWEbuZXuWRc0KzXWXJgiE0+f0GohV7G2LoG5/Uh+wgUK4KFzpSDgEzFcqPxnkGXlQpilTz16bmJ2KDx6ZBQH2ycdoKXBWpZT6DGWMl4Sv+p7OymqkYOzvF3c+Q4sV1TDRZMa+xAEu4pMey0lAmEfbJ0Eo9FHIBIpfTYlX15WyjlXdZrdEGfiUGl3O9EevwJQHaxZP9iCxpulktP+SUSrVNf3jP0GPY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(66476007)(6916009)(66946007)(316002)(66556008)(4326008)(478600001)(33656002)(86362001)(83380400001)(6506007)(6512007)(9686003)(186003)(26005)(1076003)(41300700001)(5660300002)(30864003)(44832011)(8676002)(8936002)(2906002)(6666004)(6486002)(33716001)(38100700002)(9126006)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hJi+W+mx4FsZ80mEHalg5sr24LcyfYjB/mPWWPtVpyWNFdC2bEQt2r2ssUEH?=
 =?us-ascii?Q?V0ofd2NckAC/ZTZZMEMUnv9otmYY0Zl+Vv7mWP1FmzDF6kiLlZ/mtCwnJlnC?=
 =?us-ascii?Q?WdcWm5Z0J4T4DMrDw67+ZB6AeUK8+NGjOh1zcs2gZbiQRhcG332+SjR+FRGK?=
 =?us-ascii?Q?2t0h+Odfl/7J0ewmYvNsAKOhvF0DMFtFvbyyg2EiwzFmmNUVr5XBovwoKBxG?=
 =?us-ascii?Q?dLg9F2YWAVEqQDPhD5RoFOYLP7iihdqKoZfIDOh0BzLAVTq6HKKYKD3BFxV3?=
 =?us-ascii?Q?XDXCtcjj+j30T3akWp6r4tV+1SNM0OUjBzyKlRamKpOohLGx43mHoToB9QXi?=
 =?us-ascii?Q?jAevuYfdcMq0TL5k9s3KAYeybMbWKxD/ChNblL60IW6RAc2TY7QQlA2vNvn8?=
 =?us-ascii?Q?7ofMZVqCyTMz5CKytrMduMwCY3NcF+5j50O4AgM/F6sVJzIeyw6U1J1lWQSt?=
 =?us-ascii?Q?JIgMPEbQniFKCd9VKE7Ulib+fygUb7N3oqOBC32B0/VNztMeAYKVY0ZCGL6W?=
 =?us-ascii?Q?36kDKjol7RvoQ2E9SefoeEkSc4pSBH4XIwvwY1BBtnjP4J0nB7SRvUbDXRgd?=
 =?us-ascii?Q?8pW0iyO18epJDckbfW5TXZJuzhrkMmQmv97aDqARQxqMybHAcU4GxCs7iMih?=
 =?us-ascii?Q?HbQENK7uUnr7454MLE6WLrX0a5XQuFKCSnwdM/vc5cJ8OYPupVMCCwrL0jKW?=
 =?us-ascii?Q?CEMRE/DxYcIar9TSovzYGYzaSU3P8nfaaWPJHbOaqBD86+ytIzxNk1z7OkZ7?=
 =?us-ascii?Q?XAgMjOj7i6zL9s5ZybOR+od/SFZbkDGJdmEp8mXfbeKcXCRKiUBbWVIlKBgb?=
 =?us-ascii?Q?WVowcot/GbkSijxT2bS5W5as7g3RdiduZQ3xSJ3bXahfBwTdS00kDMT1/6eA?=
 =?us-ascii?Q?M70NGH0QsWl0QtdYTCDx0EEAQu4YJNWIMRLefXLxmTFql00nrmGYWqyp9dkK?=
 =?us-ascii?Q?CxW6ZNvyStws4J/RwIZ1WpdAzVNTZ37iS6U0/oyPrMowWKZcrs/dZho4TE6p?=
 =?us-ascii?Q?4i+9EiwaTFqHn//yIgEXSzmQwEQ7diDopfhwIUbsvm4YINZDNXPhm6v7/O7/?=
 =?us-ascii?Q?J823Sb1fdt8sO2zLtt0yqZgWmlx9p4CO+TtGblYlLmiwU/TX5yp1AbzaTFFi?=
 =?us-ascii?Q?x4kTfxp03BIzOhCPcxtqtIf5Y88pY/pUwsnWb3GEWMNEtJfZ6JrV6ntfToi6?=
 =?us-ascii?Q?OxtuBSHRrRldieAjT+sUPyTwlRQYYr08VjHxRrBfOjVC9aSUfFda8O+dkJKQ?=
 =?us-ascii?Q?1EuA0s9UghPnYAt1jHfqT1tKwWir7omLjXmCAgR7lcKhGyHi27mjvgO4gNUI?=
 =?us-ascii?Q?h4ByRgDK0t6PY4CXDcYDX+u/3LzzLxSYfLCbj7fw6xJdK4rSwm2WBG92Hl0y?=
 =?us-ascii?Q?+4sVFrkQ/21XiTMn38uNQBbUVJvskuDZ8pSYk4RY21rPbV0xAosKVxI13kqd?=
 =?us-ascii?Q?4/KsWaYhgU/aP/V1Qnu7M99oG2OZkaigeOsA8bLkxMRhbcQlbl4cxr4EcgXi?=
 =?us-ascii?Q?rv3fAu1JaWTQtyl4jQQ+RABzsaWL/kI+0awXVpFHSS6ojiIQwnbGLOQVbIi7?=
 =?us-ascii?Q?eAXBUUL15PhQcW9s4Jb0p3BXCsS2eI4qZ7TOD0R3xm+Pzm2Dq41ZtcGq0NR2?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebb864d-4813-4e1b-ae0c-08db69545dda
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 01:45:28.2676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JAzdqXxkgzoUi3+LywPvmk84zqP9JeeakNm9KSWL5KHE4KbZZHqCuyh3f03L3BO0ly2zPol68splIHhQX6bCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8612

On Fri, Jun 09, 2023 at 04:40:01PM +0200, Paolo Abeni wrote:
> On Fri, 2023-06-09 at 21:32 +0800, Geliang Tang wrote:
> > On Fri, Jun 09, 2023 at 11:57:53AM +0200, Paolo Abeni wrote:
> > 
> > > May I guess you get a similar error if you do:
> > > 
> > > 	subflow = mptcp_subflow_ctx(ssk)
> > > 
> > > ? (just out of sheer ignorance and curiosity)
> > 
> > Yes. It seems that accessing 'send_info[SSK_MODE_ACTIVE].ssk' is
> > considered unsafe in BPF context. So here we pass 'send_info[SSK_MODE_ACTIVE].ssk'
> > into bpf_mptcp_subflow_ctx() to find the related subflow. Then we access this
> > subflow instead of 'send_info[SSK_MODE_ACTIVE].ssk' below. This can make BPF happy.
> > 
> > > 
> > > > +	 * then use mptcp_subflow_tcp_sock() to get the ssk.
> > > > +	 */
> > > > +	subflow = mptcp_subflow_tcp_sock(send_info[SSK_MODE_ACTIVE].ssk, data);
> > > > +	ssk = mptcp_subflow_tcp_sock(subflow);
> > > 
> > > What if you store the 'subflow' pointer in 'send_info'? Will the
> > > verifier splat with that? and what if we store the corresponding
> > > context index 'i' instead?
> > 
> > Storing the 'subflow' or index 'i' don't work too.
> 
> Uhmm... I'm very surprised about 'i'. Specifically what I mean is:
> 
> struct subflow_send_info {
> 	unsigned int subflow_id;
> 	__u64 linger_time;
> };
> 
> // ...
> 	for (i = 0; i < SSK_MODE_MAX; ++i) {
> 		send_info[i].ssk = MPTCP_SUBFLOWS_MAX;
> 		send_info[i].linger_time = -1;
> 	}
> // ...
> 
> 		if (linger_time < send_info[subflow->backup].linger_time) {
> 			send_info[subflow->backup].subflow_id = i;
> 			send_info[subflow->backup].linger_time = linger_time;
> 		}
> 
> // ...
> 	if (send_info[SSK_MODE_ACTIVE].subflow_id == MPTCP_SUBFLOWS_MAX)
> 		send_info[SSK_MODE_ACTIVE].subflow_id = send_info[SSK_MODE_BACKUP].subflow_id;
> 
> 	if (send_info[SSK_MODE_ACTIVE].subflow_id < MPTCP_SUBFLOWS_MAX)
> 		subflow = data->context[send_info[SSK_MODE_ACTIVE].subflow_id];
> 
> The last assignment should be equivalent to the already used 'subflow =
> data->contexts[i];'. What kind of errors do you see here?!? Could you
> please report them verbatim?

This line "subflow = data->context[send_info[SSK_MODE_ACTIVE].subflow_id];" will get a error:

  R2 is ptr_mptcp_sched_data invalid variable offset: off=16, var_off=(0x0; 0x38)

Here's the patch:

'''
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 2f97ffb707ac..cadf7320f233 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -10,7 +10,7 @@ char _license[] SEC("license") = "GPL";
 #define MPTCP_SEND_BURST_SIZE	65428
 
 struct subflow_send_info {
-	struct sock *ssk;
+	unsigned int subflow_id;
 	__u64 linger_time;
 };
 
@@ -79,13 +79,13 @@ static int bpf_burst_get_send(const struct mptcp_sock *msk,
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
 	__u32 pace, burst, wmem;
-	int i, nr_active = 0;
 	__u64 linger_time;
 	struct sock *ssk;
+	int i;
 
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
-		send_info[i].ssk = NULL;
+		send_info[i].subflow_id = MPTCP_SUBFLOWS_MAX;
 		send_info[i].linger_time = -1;
 	}
 
@@ -98,7 +98,6 @@ static int bpf_burst_get_send(const struct mptcp_sock *msk,
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
-		nr_active += !subflow->backup;
 		pace = subflow->avg_pacing_rate;
 		if (!pace) {
 			/* init pacing rate from socket */
@@ -110,15 +109,17 @@ static int bpf_burst_get_send(const struct mptcp_sock *msk,
 
 		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
 		if (linger_time < send_info[subflow->backup].linger_time) {
-			send_info[subflow->backup].ssk = ssk;
+			send_info[subflow->backup].subflow_id = i;
 			send_info[subflow->backup].linger_time = linger_time;
 		}
 	}
 	mptcp_set_timeout(sk);
 
-	/* pick the best backup if no other subflow is active */
-	if (!nr_active)
-		send_info[SSK_MODE_ACTIVE].ssk = send_info[SSK_MODE_BACKUP].ssk;
+	if (send_info[SSK_MODE_ACTIVE].subflow_id == MPTCP_SUBFLOWS_MAX)
+		send_info[SSK_MODE_ACTIVE].subflow_id = send_info[SSK_MODE_BACKUP].subflow_id;
+
+	if (send_info[SSK_MODE_ACTIVE].subflow_id < MPTCP_SUBFLOWS_MAX)
+		subflow = data->contexts[send_info[SSK_MODE_ACTIVE].subflow_id];
 
 	/* Pass "send_info[SSK_MODE_ACTIVE].ssk" directly to bpf_sk_stream_memory_free()
 	 * will get an error:
@@ -127,7 +128,6 @@ static int bpf_burst_get_send(const struct mptcp_sock *msk,
 	 * then use mptcp_subflow_tcp_sock() to get the ssk,
 	 * and pass the ssk to bpf_sk_stream_memory_free().
 	 */
-	subflow = bpf_mptcp_subflow_ctx(send_info[SSK_MODE_ACTIVE].ssk, data);
 	ssk = mptcp_subflow_tcp_sock(subflow);
 	if (!ssk || !bpf_sk_stream_memory_free(ssk))
 		return -1;
'''

The full log is here:

'''
sudo ./test_progs -t mptcp
#141/1   mptcp/base:OK
#141/2   mptcp/first:OK
#141/3   mptcp/bkup:OK
#141/4   mptcp/rr:OK
#141/5   mptcp/red:OK
libbpf: prog 'bpf_burst_get_subflow': BPF program load failed: Permission denied
libbpf: prog 'bpf_burst_get_subflow': -- BEGIN PROG LOAD LOG --
reg type unsupported for arg#0 function bpf_burst_get_subflow#38
0: R1=ctx(off=0,imm=0) R10=fp0
; int BPF_STRUCT_OPS(bpf_burst_get_subflow, const struct mptcp_sock *msk,
0: (79) r5 = *(u64 *)(r1 +8)
func 'get_subflow' arg1 has btf_id 33984 type STRUCT 'mptcp_sched_data'
1: R1=ctx(off=0,imm=0) R5_w=trusted_ptr_mptcp_sched_data(off=0,imm=0)
1: (79) r9 = *(u64 *)(r1 +0)
func 'get_subflow' arg0 has btf_id 152912 type STRUCT 'mptcp_sock'
2: R1=ctx(off=0,imm=0) R9_w=trusted_ptr_mptcp_sock(off=0,imm=0)
; if (data->reinject)
2: (71) r1 = *(u8 *)(r5 +12)          ; R1_w=scalar(umax=255,var_off=(0x0; 0xff)) R5_w=trusted_ptr_mptcp_sched_data(off=0,imm=0)
3: (7b) *(u64 *)(r10 -40) = r5        ; R5_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R10=fp0 fp-40_w=trusted_ptr_
; if (data->reinject)
4: (16) if w1 == 0x0 goto pc+51 56: R1_w=0 R5_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R9_w=trusted_ptr_mptcp_sock(off=0,imm=0) R10=fp0 fp-40_w=trusted_ptr_
; if (pick)
56: (b7) r1 = -1                      ; R1_w=-1
; send_info[i].linger_time = -1;
57: (7b) *(u64 *)(r10 -8) = r1        ; R1_w=-1 R10=fp0 fp-8_w=-1
58: (7b) *(u64 *)(r10 -24) = r1       ; R1_w=-1 R10=fp0 fp-24_w=-1
59: (b4) w6 = 8                       ; R6_w=8
; send_info[i].subflow_id = MPTCP_SUBFLOWS_MAX;
60: (63) *(u32 *)(r10 -16) = r6       ; R6_w=8 R10=fp0 fp-16=8
61: (63) *(u32 *)(r10 -32) = r6       ; R6_w=8 R10=fp0 fp-32=8
; if (!data->contexts[i])
62: (79) r1 = *(u64 *)(r5 +16)        ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0) R5_w=trusted_ptr_mptcp_sched_data(off=0,imm=0)
; if (!data->contexts[i])
63: (15) if r1 == 0x0 goto pc+22      ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0)
64: (7b) *(u64 *)(r10 -56) = r9       ; R9_w=trusted_ptr_mptcp_sock(off=0,imm=0) R10=fp0 fp-56_w=trusted_ptr_
65: (b7) r2 = 16                      ; R2_w=16
66: (bf) r1 = r5                      ; R1_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R5_w=trusted_ptr_mptcp_sched_data(off=0,imm=0)
67: (0f) r1 += r2                     ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R2_w=16
68: (b7) r9 = 0                       ; R9_w=0
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
69: (07) r5 += 8                      ; R5_w=trusted_ptr_mptcp_sched_data(off=8,imm=0)
70: (7b) *(u64 *)(r10 -48) = r5       ; R5_w=trusted_ptr_mptcp_sched_data(off=8,imm=0) R10=fp0 fp-48_w=trusted_ptr_
71: (b7) r6 = 0                       ; R6_w=0
72: (05) goto pc+27
; subflow = data->contexts[i];
100: (0f) r1 += r9                    ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R9=0
101: (79) r7 = *(u64 *)(r1 +0)        ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; return subflow->tcp_sock;
102: (79) r8 = *(u64 *)(r7 +192)      ; R7_w=ptr_mptcp_subflow_context(off=0,imm=0) R8_w=ptr_sock(off=0,imm=0)
; if (!mptcp_subflow_active(subflow))
103: (bf) r1 = r7                     ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
104: (85) call mptcp_subflow_active#153119    ; R0_w=scalar()
; if (!mptcp_subflow_active(subflow))
105: (16) if w0 == 0x0 goto pc+36     ; R0_w=scalar()
; pace = subflow->avg_pacing_rate;
106: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
107: (bf) r2 = r1                     ; R1_w=scalar(id=127) R2_w=scalar(id=127)
108: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
109: (77) r2 >>= 32                   ; R2=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace) {
110: (56) if w1 != 0x0 goto pc+7      ; R1=scalar(id=127,smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
111: (79) r1 = *(u64 *)(r8 +456)      ; R1_w=scalar() R8=ptr_sock(off=0,imm=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
112: (7b) *(u64 *)(r7 +16) = r1       ; R1_w=scalar() R7=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
113: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
114: (bf) r2 = r1                     ; R1_w=scalar(id=128) R2_w=scalar(id=128)
115: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
116: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace)
117: (16) if w1 == 0x0 goto pc+24     ; R1_w=scalar(id=128)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
118: (61) r1 = *(u32 *)(r8 +336)      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R8=ptr_sock(off=0,imm=0)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
119: (67) r1 <<= 32                   ; R1_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; return dividend / divisor;
120: (3f) r1 /= r2                    ; R1_w=scalar() R2=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (linger_time < send_info[subflow->backup].linger_time) {
121: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7=ptr_mptcp_subflow_context(off=0,imm=0)
; if (linger_time < send_info[subflow->backup].linger_time) {
122: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; if (linger_time < send_info[subflow->backup].linger_time) {
123: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
124: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
;
125: (07) r3 += -32                   ; R3_w=fp-32
; if (linger_time < send_info[subflow->backup].linger_time) {
126: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
127: (79) r2 = *(u64 *)(r3 +8)        ; R2_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-24=-1
; if (linger_time < send_info[subflow->backup].linger_time) {
128: (3d) if r1 >= r2 goto pc+13      ; R1_w=scalar() R2_w=scalar()
; send_info[subflow->backup].subflow_id = i;
129: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].subflow_id = i;
130: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].subflow_id = i;
131: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
132: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
; send_info[subflow->backup].subflow_id = i;
133: (07) r3 += -32                   ; R3_w=fp-32
; send_info[subflow->backup].subflow_id = i;
134: (bf) r4 = r3                     ; R3_w=fp-32 R4_w=fp-32
135: (0f) r4 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].subflow_id = i;
136: (63) *(u32 *)(r4 +0) = r6        ; R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) R6=0 fp-16=????mmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
; send_info[subflow->backup].linger_time = linger_time;
137: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].linger_time = linger_time;
138: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].linger_time = linger_time;
139: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
140: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].linger_time = linger_time;
141: (7b) *(u64 *)(r3 +8) = r1        ; R1_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
142: (55) if r6 != 0x7 goto pc-54     ; R6=0
; mptcp_set_timeout(sk);
89: (79) r1 = *(u64 *)(r10 -40)       ; R1_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R10=fp0 fp-40=trusted_ptr_
90: (b7) r3 = 16                      ; R3_w=16
91: (0f) r1 += r3                     ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R3_w=16
; if (!data->contexts[i])
92: (bf) r2 = r9                      ; R2_w=0 R9=0
93: (0f) r2 += r3                     ; R2_w=16 R3_w=16
94: (79) r3 = *(u64 *)(r10 -48)       ; R3_w=trusted_ptr_mptcp_sched_data(off=8,imm=0) R10=fp0 fp-48=trusted_ptr_
95: (0f) r3 += r2                     ; R2_w=16 R3_w=trusted_ptr_mptcp_sched_data(off=24,imm=0)
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
96: (07) r6 += 1                      ; R6_w=1
; if (!data->contexts[i])
97: (07) r9 += 8                      ; R9_w=8
; if (!data->contexts[i])
98: (79) r2 = *(u64 *)(r3 +0)         ; R2_w=ptr_mptcp_subflow_context(off=0,imm=0) R3_w=trusted_ptr_mptcp_sched_data(off=24,imm=0)
; if (!data->contexts[i])
99: (15) if r2 == 0x0 goto pc+43      ; R2_w=ptr_mptcp_subflow_context(off=0,imm=0)
; subflow = data->contexts[i];
100: (0f) r1 += r9                    ; R1_w=trusted_ptr_mptcp_sched_data(off=24,imm=0) R9_w=8
101: (79) r7 = *(u64 *)(r1 +0)        ; R1_w=trusted_ptr_mptcp_sched_data(off=24,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; return subflow->tcp_sock;
102: (79) r8 = *(u64 *)(r7 +192)      ; R7_w=ptr_mptcp_subflow_context(off=0,imm=0) R8_w=ptr_sock(off=0,imm=0)
; if (!mptcp_subflow_active(subflow))
103: (bf) r1 = r7                     ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
104: (85) call mptcp_subflow_active#153119    ; R0=scalar()
; if (!mptcp_subflow_active(subflow))
105: (16) if w0 == 0x0 goto pc+36     ; R0=scalar()
; pace = subflow->avg_pacing_rate;
106: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
107: (bf) r2 = r1                     ; R1_w=scalar(id=130) R2_w=scalar(id=130)
108: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
109: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace) {
110: (56) if w1 != 0x0 goto pc+7      ; R1_w=scalar(id=130,smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
111: (79) r1 = *(u64 *)(r8 +456)      ; R1_w=scalar() R8=ptr_sock(off=0,imm=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
112: (7b) *(u64 *)(r7 +16) = r1       ; R1_w=scalar() R7=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
113: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
114: (bf) r2 = r1                     ; R1_w=scalar(id=131) R2_w=scalar(id=131)
115: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
116: (77) r2 >>= 32                   ; R2=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace)
117: (16) if w1 == 0x0 goto pc+24     ; R1=scalar(id=131)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
118: (61) r1 = *(u32 *)(r8 +336)      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R8=ptr_sock(off=0,imm=0)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
119: (67) r1 <<= 32                   ; R1_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; return dividend / divisor;
120: (3f) r1 /= r2                    ; R1_w=scalar() R2=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (linger_time < send_info[subflow->backup].linger_time) {
121: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7=ptr_mptcp_subflow_context(off=0,imm=0)
; if (linger_time < send_info[subflow->backup].linger_time) {
122: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; if (linger_time < send_info[subflow->backup].linger_time) {
123: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
124: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
;
125: (07) r3 += -32                   ; R3_w=fp-32
; if (linger_time < send_info[subflow->backup].linger_time) {
126: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
127: (79) r2 = *(u64 *)(r3 +8)        ; R2_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-24=mmmmmmmm
; if (linger_time < send_info[subflow->backup].linger_time) {
128: (3d) if r1 >= r2 goto pc+13      ; R1_w=scalar() R2_w=scalar()
; send_info[subflow->backup].subflow_id = i;
129: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].subflow_id = i;
130: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].subflow_id = i;
131: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
132: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
; send_info[subflow->backup].subflow_id = i;
133: (07) r3 += -32                   ; R3_w=fp-32
; send_info[subflow->backup].subflow_id = i;
134: (bf) r4 = r3                     ; R3_w=fp-32 R4_w=fp-32
135: (0f) r4 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].subflow_id = i;
136: (63) *(u32 *)(r4 +0) = r6        ; R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) R6=1 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
; send_info[subflow->backup].linger_time = linger_time;
137: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].linger_time = linger_time;
138: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].linger_time = linger_time;
139: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
140: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].linger_time = linger_time;
141: (7b) *(u64 *)(r3 +8) = r1        ; R1=scalar() R3=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
142: (55) if r6 != 0x7 goto pc-54     ; R6=1
; mptcp_set_timeout(sk);
89: (79) r1 = *(u64 *)(r10 -40)       ; R1_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R10=fp0 fp-40=trusted_ptr_
90: (b7) r3 = 16                      ; R3_w=16
91: (0f) r1 += r3                     ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R3_w=16
; if (!data->contexts[i])
92: (bf) r2 = r9                      ; R2_w=8 R9=8
93: (0f) r2 += r3                     ; R2_w=24 R3_w=16
94: (79) r3 = *(u64 *)(r10 -48)       ; R3_w=trusted_ptr_mptcp_sched_data(off=8,imm=0) R10=fp0 fp-48=trusted_ptr_
95: (0f) r3 += r2                     ; R2_w=24 R3_w=trusted_ptr_mptcp_sched_data(off=32,imm=0)
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
96: (07) r6 += 1                      ; R6_w=2
; if (!data->contexts[i])
97: (07) r9 += 8                      ; R9_w=16
; if (!data->contexts[i])
98: (79) r2 = *(u64 *)(r3 +0)         ; R2_w=ptr_mptcp_subflow_context(off=0,imm=0) R3_w=trusted_ptr_mptcp_sched_data(off=32,imm=0)
; if (!data->contexts[i])
99: (15) if r2 == 0x0 goto pc+43      ; R2_w=ptr_mptcp_subflow_context(off=0,imm=0)
; subflow = data->contexts[i];
100: (0f) r1 += r9                    ; R1_w=trusted_ptr_mptcp_sched_data(off=32,imm=0) R9_w=16
101: (79) r7 = *(u64 *)(r1 +0)        ; R1_w=trusted_ptr_mptcp_sched_data(off=32,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; return subflow->tcp_sock;
102: (79) r8 = *(u64 *)(r7 +192)      ; R7_w=ptr_mptcp_subflow_context(off=0,imm=0) R8_w=ptr_sock(off=0,imm=0)
; if (!mptcp_subflow_active(subflow))
103: (bf) r1 = r7                     ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
104: (85) call mptcp_subflow_active#153119    ; R0_w=scalar()
; if (!mptcp_subflow_active(subflow))
105: (16) if w0 == 0x0 goto pc+36     ; R0_w=scalar()
; pace = subflow->avg_pacing_rate;
106: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
107: (bf) r2 = r1                     ; R1_w=scalar(id=133) R2_w=scalar(id=133)
108: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
109: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace) {
110: (56) if w1 != 0x0 goto pc+7      ; R1_w=scalar(id=133,smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
111: (79) r1 = *(u64 *)(r8 +456)      ; R1_w=scalar() R8_w=ptr_sock(off=0,imm=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
112: (7b) *(u64 *)(r7 +16) = r1       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
113: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
114: (bf) r2 = r1                     ; R1_w=scalar(id=134) R2_w=scalar(id=134)
115: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
116: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace)
117: (16) if w1 == 0x0 goto pc+24     ; R1_w=scalar(id=134)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
118: (61) r1 = *(u32 *)(r8 +336)      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R8_w=ptr_sock(off=0,imm=0)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
119: (67) r1 <<= 32                   ; R1_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; return dividend / divisor;
120: (3f) r1 /= r2                    ; R1_w=scalar() R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (linger_time < send_info[subflow->backup].linger_time) {
121: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; if (linger_time < send_info[subflow->backup].linger_time) {
122: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; if (linger_time < send_info[subflow->backup].linger_time) {
123: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
124: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
;
125: (07) r3 += -32                   ; R3_w=fp-32
; if (linger_time < send_info[subflow->backup].linger_time) {
126: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
127: (79) r2 = *(u64 *)(r3 +8)        ; R2=scalar() R3=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-24=mmmmmmmm
; if (linger_time < send_info[subflow->backup].linger_time) {
128: (3d) if r1 >= r2 goto pc+13      ; R1=scalar() R2=scalar()
; send_info[subflow->backup].subflow_id = i;
129: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].subflow_id = i;
130: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].subflow_id = i;
131: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
132: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
; send_info[subflow->backup].subflow_id = i;
133: (07) r3 += -32                   ; R3_w=fp-32
; send_info[subflow->backup].subflow_id = i;
134: (bf) r4 = r3                     ; R3_w=fp-32 R4_w=fp-32
135: (0f) r4 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].subflow_id = i;
136: (63) *(u32 *)(r4 +0) = r6        ; R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) R6=2 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
; send_info[subflow->backup].linger_time = linger_time;
137: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].linger_time = linger_time;
138: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].linger_time = linger_time;
139: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
140: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].linger_time = linger_time;
141: (7b) *(u64 *)(r3 +8) = r1        ; R1=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
142: (55) if r6 != 0x7 goto pc-54     ; R6=2
; mptcp_set_timeout(sk);
89: (79) r1 = *(u64 *)(r10 -40)       ; R1_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R10=fp0 fp-40=trusted_ptr_
90: (b7) r3 = 16                      ; R3_w=16
91: (0f) r1 += r3                     ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R3_w=16
; if (!data->contexts[i])
92: (bf) r2 = r9                      ; R2_w=16 R9=16
93: (0f) r2 += r3                     ; R2_w=32 R3_w=16
94: (79) r3 = *(u64 *)(r10 -48)       ; R3_w=trusted_ptr_mptcp_sched_data(off=8,imm=0) R10=fp0 fp-48=trusted_ptr_
95: (0f) r3 += r2                     ; R2_w=32 R3_w=trusted_ptr_mptcp_sched_data(off=40,imm=0)
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
96: (07) r6 += 1                      ; R6_w=3
; if (!data->contexts[i])
97: (07) r9 += 8                      ; R9_w=24
; if (!data->contexts[i])
98: (79) r2 = *(u64 *)(r3 +0)         ; R2=ptr_mptcp_subflow_context(off=0,imm=0) R3=trusted_ptr_mptcp_sched_data(off=40,imm=0)
; if (!data->contexts[i])
99: (15) if r2 == 0x0 goto pc+43      ; R2=ptr_mptcp_subflow_context(off=0,imm=0)
; subflow = data->contexts[i];
100: (0f) r1 += r9                    ; R1_w=trusted_ptr_mptcp_sched_data(off=40,imm=0) R9=24
101: (79) r7 = *(u64 *)(r1 +0)        ; R1_w=trusted_ptr_mptcp_sched_data(off=40,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; return subflow->tcp_sock;
102: (79) r8 = *(u64 *)(r7 +192)      ; R7_w=ptr_mptcp_subflow_context(off=0,imm=0) R8_w=ptr_sock(off=0,imm=0)
; if (!mptcp_subflow_active(subflow))
103: (bf) r1 = r7                     ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
104: (85) call mptcp_subflow_active#153119    ; R0_w=scalar()
; if (!mptcp_subflow_active(subflow))
105: (16) if w0 == 0x0 goto pc+36     ; R0_w=scalar()
; pace = subflow->avg_pacing_rate;
106: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
107: (bf) r2 = r1                     ; R1_w=scalar(id=136) R2_w=scalar(id=136)
108: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
109: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace) {
110: (56) if w1 != 0x0 goto pc+7      ; R1_w=scalar(id=136,smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
111: (79) r1 = *(u64 *)(r8 +456)      ; R1_w=scalar() R8_w=ptr_sock(off=0,imm=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
112: (7b) *(u64 *)(r7 +16) = r1       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
113: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
114: (bf) r2 = r1                     ; R1_w=scalar(id=137) R2_w=scalar(id=137)
115: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
116: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace)
117: (16) if w1 == 0x0 goto pc+24     ; R1_w=scalar(id=137)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
118: (61) r1 = *(u32 *)(r8 +336)      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R8_w=ptr_sock(off=0,imm=0)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
119: (67) r1 <<= 32                   ; R1_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; return dividend / divisor;
120: (3f) r1 /= r2                    ; R1_w=scalar() R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (linger_time < send_info[subflow->backup].linger_time) {
121: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; if (linger_time < send_info[subflow->backup].linger_time) {
122: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; if (linger_time < send_info[subflow->backup].linger_time) {
123: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
124: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
;
125: (07) r3 += -32                   ; R3_w=fp-32
; if (linger_time < send_info[subflow->backup].linger_time) {
126: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
127: (79) r2 = *(u64 *)(r3 +8)        ; R2_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-24=mmmmmmmm
; if (linger_time < send_info[subflow->backup].linger_time) {
128: (3d) if r1 >= r2 goto pc+13      ; R1_w=scalar() R2_w=scalar()
; send_info[subflow->backup].subflow_id = i;
129: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].subflow_id = i;
130: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].subflow_id = i;
131: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
132: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
; send_info[subflow->backup].subflow_id = i;
133: (07) r3 += -32                   ; R3_w=fp-32
; send_info[subflow->backup].subflow_id = i;
134: (bf) r4 = r3                     ; R3_w=fp-32 R4_w=fp-32
135: (0f) r4 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].subflow_id = i;
136: (63) *(u32 *)(r4 +0) = r6        ; R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) R6=3 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
; send_info[subflow->backup].linger_time = linger_time;
137: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].linger_time = linger_time;
138: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].linger_time = linger_time;
139: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
140: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].linger_time = linger_time;
141: (7b) *(u64 *)(r3 +8) = r1        ; R1_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
142: (55) if r6 != 0x7 goto pc-54     ; R6=3
; mptcp_set_timeout(sk);
89: (79) r1 = *(u64 *)(r10 -40)       ; R1_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R10=fp0 fp-40=trusted_ptr_
90: (b7) r3 = 16                      ; R3_w=16
91: (0f) r1 += r3                     ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R3_w=16
; if (!data->contexts[i])
92: (bf) r2 = r9                      ; R2_w=24 R9=24
93: (0f) r2 += r3                     ; R2_w=40 R3_w=16
94: (79) r3 = *(u64 *)(r10 -48)       ; R3_w=trusted_ptr_mptcp_sched_data(off=8,imm=0) R10=fp0 fp-48=trusted_ptr_
95: (0f) r3 += r2                     ; R2_w=40 R3_w=trusted_ptr_mptcp_sched_data(off=48,imm=0)
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
96: (07) r6 += 1                      ; R6_w=4
; if (!data->contexts[i])
97: (07) r9 += 8                      ; R9_w=32
; if (!data->contexts[i])
98: (79) r2 = *(u64 *)(r3 +0)         ; R2_w=ptr_mptcp_subflow_context(off=0,imm=0) R3_w=trusted_ptr_mptcp_sched_data(off=48,imm=0)
; if (!data->contexts[i])
99: (15) if r2 == 0x0 goto pc+43      ; R2_w=ptr_mptcp_subflow_context(off=0,imm=0)
; subflow = data->contexts[i];
100: (0f) r1 += r9                    ; R1_w=trusted_ptr_mptcp_sched_data(off=48,imm=0) R9_w=32
101: (79) r7 = *(u64 *)(r1 +0)        ; R1_w=trusted_ptr_mptcp_sched_data(off=48,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; return subflow->tcp_sock;
102: (79) r8 = *(u64 *)(r7 +192)      ; R7_w=ptr_mptcp_subflow_context(off=0,imm=0) R8_w=ptr_sock(off=0,imm=0)
; if (!mptcp_subflow_active(subflow))
103: (bf) r1 = r7                     ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
104: (85) call mptcp_subflow_active#153119    ; R0_w=scalar()
; if (!mptcp_subflow_active(subflow))
105: (16) if w0 == 0x0 goto pc+36     ; R0_w=scalar()
; pace = subflow->avg_pacing_rate;
106: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
107: (bf) r2 = r1                     ; R1_w=scalar(id=139) R2_w=scalar(id=139)
108: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
109: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace) {
110: (56) if w1 != 0x0 goto pc+7      ; R1_w=scalar(id=139,smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
111: (79) r1 = *(u64 *)(r8 +456)      ; R1_w=scalar() R8_w=ptr_sock(off=0,imm=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
112: (7b) *(u64 *)(r7 +16) = r1       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
113: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
114: (bf) r2 = r1                     ; R1_w=scalar(id=140) R2_w=scalar(id=140)
115: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
116: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace)
117: (16) if w1 == 0x0 goto pc+24     ; R1_w=scalar(id=140)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
118: (61) r1 = *(u32 *)(r8 +336)      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R8_w=ptr_sock(off=0,imm=0)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
119: (67) r1 <<= 32                   ; R1_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; return dividend / divisor;
120: (3f) r1 /= r2                    ; R1_w=scalar() R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (linger_time < send_info[subflow->backup].linger_time) {
121: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; if (linger_time < send_info[subflow->backup].linger_time) {
122: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; if (linger_time < send_info[subflow->backup].linger_time) {
123: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
124: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
;
125: (07) r3 += -32                   ; R3_w=fp-32
; if (linger_time < send_info[subflow->backup].linger_time) {
126: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
127: (79) r2 = *(u64 *)(r3 +8)        ; R2_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-24=mmmmmmmm
; if (linger_time < send_info[subflow->backup].linger_time) {
128: (3d) if r1 >= r2 goto pc+13      ; R1_w=scalar() R2_w=scalar()
; send_info[subflow->backup].subflow_id = i;
129: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].subflow_id = i;
130: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].subflow_id = i;
131: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
132: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
; send_info[subflow->backup].subflow_id = i;
133: (07) r3 += -32                   ; R3_w=fp-32
; send_info[subflow->backup].subflow_id = i;
134: (bf) r4 = r3                     ; R3_w=fp-32 R4_w=fp-32
135: (0f) r4 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].subflow_id = i;
136: (63) *(u32 *)(r4 +0) = r6        ; R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) R6_w=4 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
; send_info[subflow->backup].linger_time = linger_time;
137: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].linger_time = linger_time;
138: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].linger_time = linger_time;
139: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
140: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].linger_time = linger_time;
141: (7b) *(u64 *)(r3 +8) = r1        ; R1_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
142: (55) if r6 != 0x7 goto pc-54     ; R6_w=4
; mptcp_set_timeout(sk);
89: (79) r1 = *(u64 *)(r10 -40)       ; R1_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R10=fp0 fp-40=trusted_ptr_
90: (b7) r3 = 16                      ; R3_w=16
91: (0f) r1 += r3                     ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R3_w=16
; if (!data->contexts[i])
92: (bf) r2 = r9                      ; R2_w=32 R9_w=32
93: (0f) r2 += r3                     ; R2_w=48 R3_w=16
94: (79) r3 = *(u64 *)(r10 -48)       ; R3_w=trusted_ptr_mptcp_sched_data(off=8,imm=0) R10=fp0 fp-48=trusted_ptr_
95: (0f) r3 += r2                     ; R2_w=48 R3_w=trusted_ptr_mptcp_sched_data(off=56,imm=0)
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
96: (07) r6 += 1                      ; R6_w=5
; if (!data->contexts[i])
97: (07) r9 += 8                      ; R9_w=40
; if (!data->contexts[i])
98: (79) r2 = *(u64 *)(r3 +0)         ; R2=ptr_mptcp_subflow_context(off=0,imm=0) R3=trusted_ptr_mptcp_sched_data(off=56,imm=0)
; if (!data->contexts[i])
99: (15) if r2 == 0x0 goto pc+43      ; R2=ptr_mptcp_subflow_context(off=0,imm=0)
; subflow = data->contexts[i];
100: (0f) r1 += r9                    ; R1_w=trusted_ptr_mptcp_sched_data(off=56,imm=0) R9=40
101: (79) r7 = *(u64 *)(r1 +0)        ; R1_w=trusted_ptr_mptcp_sched_data(off=56,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; return subflow->tcp_sock;
102: (79) r8 = *(u64 *)(r7 +192)      ; R7_w=ptr_mptcp_subflow_context(off=0,imm=0) R8_w=ptr_sock(off=0,imm=0)
; if (!mptcp_subflow_active(subflow))
103: (bf) r1 = r7                     ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
104: (85) call mptcp_subflow_active#153119    ; R0_w=scalar()
; if (!mptcp_subflow_active(subflow))
105: (16) if w0 == 0x0 goto pc+36     ; R0_w=scalar()
; pace = subflow->avg_pacing_rate;
106: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
107: (bf) r2 = r1                     ; R1_w=scalar(id=142) R2_w=scalar(id=142)
108: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
109: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace) {
110: (56) if w1 != 0x0 goto pc+7      ; R1_w=scalar(id=142,smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
111: (79) r1 = *(u64 *)(r8 +456)      ; R1_w=scalar() R8_w=ptr_sock(off=0,imm=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
112: (7b) *(u64 *)(r7 +16) = r1       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
113: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
114: (bf) r2 = r1                     ; R1_w=scalar(id=143) R2_w=scalar(id=143)
115: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
116: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace)
117: (16) if w1 == 0x0 goto pc+24     ; R1_w=scalar(id=143)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
118: (61) r1 = *(u32 *)(r8 +336)      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R8_w=ptr_sock(off=0,imm=0)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
119: (67) r1 <<= 32                   ; R1_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; return dividend / divisor;
120: (3f) r1 /= r2                    ; R1_w=scalar() R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (linger_time < send_info[subflow->backup].linger_time) {
121: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; if (linger_time < send_info[subflow->backup].linger_time) {
122: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; if (linger_time < send_info[subflow->backup].linger_time) {
123: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
124: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
;
125: (07) r3 += -32                   ; R3_w=fp-32
; if (linger_time < send_info[subflow->backup].linger_time) {
126: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
127: (79) r2 = *(u64 *)(r3 +8)        ; R2_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-24=mmmmmmmm
; if (linger_time < send_info[subflow->backup].linger_time) {
128: (3d) if r1 >= r2 goto pc+13      ; R1_w=scalar() R2_w=scalar()
; send_info[subflow->backup].subflow_id = i;
129: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].subflow_id = i;
130: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].subflow_id = i;
131: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
132: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
; send_info[subflow->backup].subflow_id = i;
133: (07) r3 += -32                   ; R3_w=fp-32
; send_info[subflow->backup].subflow_id = i;
134: (bf) r4 = r3                     ; R3_w=fp-32 R4_w=fp-32
135: (0f) r4 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].subflow_id = i;
136: (63) *(u32 *)(r4 +0) = r6        ; R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) R6=5 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
; send_info[subflow->backup].linger_time = linger_time;
137: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].linger_time = linger_time;
138: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].linger_time = linger_time;
139: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
140: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].linger_time = linger_time;
141: (7b) *(u64 *)(r3 +8) = r1        ; R1_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
142: (55) if r6 != 0x7 goto pc-54     ; R6=5
; mptcp_set_timeout(sk);
89: (79) r1 = *(u64 *)(r10 -40)       ; R1_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R10=fp0 fp-40=trusted_ptr_
90: (b7) r3 = 16                      ; R3_w=16
91: (0f) r1 += r3                     ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R3_w=16
; if (!data->contexts[i])
92: (bf) r2 = r9                      ; R2_w=40 R9=40
93: (0f) r2 += r3                     ; R2_w=56 R3_w=16
94: (79) r3 = *(u64 *)(r10 -48)       ; R3_w=trusted_ptr_mptcp_sched_data(off=8,imm=0) R10=fp0 fp-48=trusted_ptr_
95: (0f) r3 += r2                     ; R2_w=56 R3_w=trusted_ptr_mptcp_sched_data(off=64,imm=0)
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
96: (07) r6 += 1                      ; R6_w=6
; if (!data->contexts[i])
97: (07) r9 += 8                      ; R9_w=48
; if (!data->contexts[i])
98: (79) r2 = *(u64 *)(r3 +0)         ; R2_w=ptr_mptcp_subflow_context(off=0,imm=0) R3_w=trusted_ptr_mptcp_sched_data(off=64,imm=0)
; if (!data->contexts[i])
99: (15) if r2 == 0x0 goto pc+43      ; R2_w=ptr_mptcp_subflow_context(off=0,imm=0)
; subflow = data->contexts[i];
100: (0f) r1 += r9                    ; R1_w=trusted_ptr_mptcp_sched_data(off=64,imm=0) R9_w=48
101: (79) r7 = *(u64 *)(r1 +0)        ; R1_w=trusted_ptr_mptcp_sched_data(off=64,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; return subflow->tcp_sock;
102: (79) r8 = *(u64 *)(r7 +192)      ; R7_w=ptr_mptcp_subflow_context(off=0,imm=0) R8_w=ptr_sock(off=0,imm=0)
; if (!mptcp_subflow_active(subflow))
103: (bf) r1 = r7                     ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
104: (85) call mptcp_subflow_active#153119    ; R0_w=scalar()
; if (!mptcp_subflow_active(subflow))
105: (16) if w0 == 0x0 goto pc+36     ; R0_w=scalar()
; pace = subflow->avg_pacing_rate;
106: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
107: (bf) r2 = r1                     ; R1_w=scalar(id=145) R2_w=scalar(id=145)
108: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
109: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace) {
110: (56) if w1 != 0x0 goto pc+7      ; R1_w=scalar(id=145,smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
111: (79) r1 = *(u64 *)(r8 +456)      ; R1_w=scalar() R8_w=ptr_sock(off=0,imm=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
112: (7b) *(u64 *)(r7 +16) = r1       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
113: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
114: (bf) r2 = r1                     ; R1_w=scalar(id=146) R2_w=scalar(id=146)
115: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
116: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace)
117: (16) if w1 == 0x0 goto pc+24     ; R1_w=scalar(id=146)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
118: (61) r1 = *(u32 *)(r8 +336)      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R8_w=ptr_sock(off=0,imm=0)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
119: (67) r1 <<= 32                   ; R1_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; return dividend / divisor;
120: (3f) r1 /= r2                    ; R1_w=scalar() R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (linger_time < send_info[subflow->backup].linger_time) {
121: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; if (linger_time < send_info[subflow->backup].linger_time) {
122: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; if (linger_time < send_info[subflow->backup].linger_time) {
123: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
124: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
;
125: (07) r3 += -32                   ; R3_w=fp-32
; if (linger_time < send_info[subflow->backup].linger_time) {
126: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
127: (79) r2 = *(u64 *)(r3 +8)        ; R2_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-24=mmmmmmmm
; if (linger_time < send_info[subflow->backup].linger_time) {
128: (3d) if r1 >= r2 goto pc+13      ; R1_w=scalar() R2_w=scalar()
; send_info[subflow->backup].subflow_id = i;
129: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].subflow_id = i;
130: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].subflow_id = i;
131: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
132: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
; send_info[subflow->backup].subflow_id = i;
133: (07) r3 += -32                   ; R3_w=fp-32
; send_info[subflow->backup].subflow_id = i;
134: (bf) r4 = r3                     ; R3_w=fp-32 R4_w=fp-32
135: (0f) r4 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].subflow_id = i;
136: (63) *(u32 *)(r4 +0) = r6        ; R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) R6_w=6 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
; send_info[subflow->backup].linger_time = linger_time;
137: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].linger_time = linger_time;
138: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].linger_time = linger_time;
139: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
140: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].linger_time = linger_time;
141: (7b) *(u64 *)(r3 +8) = r1        ; R1_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
142: (55) if r6 != 0x7 goto pc-54     ; R6_w=6
; mptcp_set_timeout(sk);
89: (79) r1 = *(u64 *)(r10 -40)       ; R1_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R10=fp0 fp-40=trusted_ptr_
90: (b7) r3 = 16                      ; R3_w=16
91: (0f) r1 += r3                     ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R3_w=16
; if (!data->contexts[i])
92: (bf) r2 = r9                      ; R2_w=48 R9_w=48
93: (0f) r2 += r3                     ; R2_w=64 R3_w=16
94: (79) r3 = *(u64 *)(r10 -48)       ; R3_w=trusted_ptr_mptcp_sched_data(off=8,imm=0) R10=fp0 fp-48=trusted_ptr_
95: (0f) r3 += r2                     ; R2_w=64 R3_w=trusted_ptr_mptcp_sched_data(off=72,imm=0)
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
96: (07) r6 += 1                      ; R6_w=7
; if (!data->contexts[i])
97: (07) r9 += 8                      ; R9_w=56
; if (!data->contexts[i])
98: (79) r2 = *(u64 *)(r3 +0)         ; R2=ptr_mptcp_subflow_context(off=0,imm=0) R3=trusted_ptr_mptcp_sched_data(off=72,imm=0)
; if (!data->contexts[i])
99: (15) if r2 == 0x0 goto pc+43      ; R2=ptr_mptcp_subflow_context(off=0,imm=0)
; subflow = data->contexts[i];
100: (0f) r1 += r9                    ; R1_w=trusted_ptr_mptcp_sched_data(off=72,imm=0) R9=56
101: (79) r7 = *(u64 *)(r1 +0)        ; R1_w=trusted_ptr_mptcp_sched_data(off=72,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; return subflow->tcp_sock;
102: (79) r8 = *(u64 *)(r7 +192)      ; R7_w=ptr_mptcp_subflow_context(off=0,imm=0) R8_w=ptr_sock(off=0,imm=0)
; if (!mptcp_subflow_active(subflow))
103: (bf) r1 = r7                     ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
104: (85) call mptcp_subflow_active#153119    ; R0_w=scalar()
; if (!mptcp_subflow_active(subflow))
105: (16) if w0 == 0x0 goto pc+36     ; R0_w=scalar()
; pace = subflow->avg_pacing_rate;
106: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
107: (bf) r2 = r1                     ; R1_w=scalar(id=148) R2_w=scalar(id=148)
108: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
109: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace) {
110: (56) if w1 != 0x0 goto pc+7      ; R1_w=scalar(id=148,smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
111: (79) r1 = *(u64 *)(r8 +456)      ; R1_w=scalar() R8_w=ptr_sock(off=0,imm=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
112: (7b) *(u64 *)(r7 +16) = r1       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
113: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
114: (bf) r2 = r1                     ; R1_w=scalar(id=149) R2_w=scalar(id=149)
115: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
116: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace)
117: (16) if w1 == 0x0 goto pc+24     ; R1_w=scalar(id=149)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
118: (61) r1 = *(u32 *)(r8 +336)      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R8_w=ptr_sock(off=0,imm=0)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
119: (67) r1 <<= 32                   ; R1_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; return dividend / divisor;
120: (3f) r1 /= r2                    ; R1_w=scalar() R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (linger_time < send_info[subflow->backup].linger_time) {
121: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; if (linger_time < send_info[subflow->backup].linger_time) {
122: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; if (linger_time < send_info[subflow->backup].linger_time) {
123: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
124: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
;
125: (07) r3 += -32                   ; R3_w=fp-32
; if (linger_time < send_info[subflow->backup].linger_time) {
126: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
127: (79) r2 = *(u64 *)(r3 +8)        ; R2_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-24=mmmmmmmm
; if (linger_time < send_info[subflow->backup].linger_time) {
128: (3d) if r1 >= r2 goto pc+13      ; R1_w=scalar() R2_w=scalar()
; send_info[subflow->backup].subflow_id = i;
129: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].subflow_id = i;
130: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].subflow_id = i;
131: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
132: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
; send_info[subflow->backup].subflow_id = i;
133: (07) r3 += -32                   ; R3_w=fp-32
; send_info[subflow->backup].subflow_id = i;
134: (bf) r4 = r3                     ; R3_w=fp-32 R4_w=fp-32
135: (0f) r4 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].subflow_id = i;
136: (63) *(u32 *)(r4 +0) = r6        ; R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) R6=7 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
; send_info[subflow->backup].linger_time = linger_time;
137: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].linger_time = linger_time;
138: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].linger_time = linger_time;
139: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
140: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].linger_time = linger_time;
141: (7b) *(u64 *)(r3 +8) = r1        ; R1_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
142: (55) if r6 != 0x7 goto pc-54     ; R6=7
; if (send_info[SSK_MODE_ACTIVE].subflow_id == MPTCP_SUBFLOWS_MAX)
143: (61) r6 = *(u32 *)(r10 -16)      ; R6_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0 fp-16=mmmmmmmm
; if (send_info[SSK_MODE_ACTIVE].subflow_id == MPTCP_SUBFLOWS_MAX)
144: (61) r8 = *(u32 *)(r10 -32)      ; R8_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0 fp-32=mmmmmmmm
145: (79) r9 = *(u64 *)(r10 -56)      ; R9_w=trusted_ptr_mptcp_sock(off=0,imm=0) R10=fp0 fp-56=trusted_ptr_
; mptcp_set_timeout(sk);
146: (bf) r1 = r9                     ; R1_w=trusted_ptr_mptcp_sock(off=0,imm=0) R9_w=trusted_ptr_mptcp_sock(off=0,imm=0)
147: (85) call mptcp_set_timeout#153142       ;
; if (send_info[SSK_MODE_ACTIVE].subflow_id == MPTCP_SUBFLOWS_MAX)
148: (56) if w8 != 0x8 goto pc+1      ; R8_w=8
149: (bc) w8 = w6                     ; R6_w=scalar(id=150,umax=4294967295,var_off=(0x0; 0xffffffff)) R8_w=scalar(id=150,umax=4294967295,var_off=(0x0; 0xffffffff))
150: (bf) r6 = r9                     ; R6=trusted_ptr_mptcp_sock(off=0,imm=0) R9=trusted_ptr_mptcp_sock(off=0,imm=0)
; if (send_info[SSK_MODE_ACTIVE].subflow_id < MPTCP_SUBFLOWS_MAX)
151: (26) if w8 > 0x7 goto pc+6       ; R8=scalar(id=150,umax=7,var_off=(0x0; 0x7))
152: (b7) r1 = 16                     ; R1_w=16
153: (79) r2 = *(u64 *)(r10 -40)      ; R2_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R10=fp0 fp-40=trusted_ptr_
154: (0f) r2 += r1                    ; R1_w=16 R2_w=trusted_ptr_mptcp_sched_data(off=16,imm=0)
; subflow = data->contexts[send_info[SSK_MODE_ACTIVE].subflow_id];
155: (67) r8 <<= 3                    ; R8_w=scalar(umax=56,var_off=(0x0; 0x38))
156: (0f) r2 += r8                    ; R2_w=trusted_ptr_mptcp_sched_data(off=16,umax=56,var_off=(0x0; 0x38)) R8_w=scalar(umax=56,var_off=(0x0; 0x38))
157: (79) r7 = *(u64 *)(r2 +0)
R2 is ptr_mptcp_sched_data invalid variable offset: off=16, var_off=(0x0; 0x38)
processed 4748 insns (limit 1000000) max_states_per_insn 10 total_states 174 peak_states 113 mark_read 12
-- END PROG LOAD LOG --
libbpf: prog 'bpf_burst_get_subflow': failed to load: -13
libbpf: failed to load object 'mptcp_bpf_burst'
libbpf: failed to load BPF skeleton 'mptcp_bpf_burst': -13
test_burst:FAIL:bpf_burst__open_and_load unexpected error: -13
#141/6   mptcp/burst:FAIL
#141/7   mptcp/stale:OK
#141     mptcp:FAIL

All error logs:
libbpf: prog 'bpf_burst_get_subflow': BPF program load failed: Permission denied
libbpf: prog 'bpf_burst_get_subflow': -- BEGIN PROG LOAD LOG --
reg type unsupported for arg#0 function bpf_burst_get_subflow#38
0: R1=ctx(off=0,imm=0) R10=fp0
; int BPF_STRUCT_OPS(bpf_burst_get_subflow, const struct mptcp_sock *msk,
0: (79) r5 = *(u64 *)(r1 +8)
func 'get_subflow' arg1 has btf_id 33984 type STRUCT 'mptcp_sched_data'
1: R1=ctx(off=0,imm=0) R5_w=trusted_ptr_mptcp_sched_data(off=0,imm=0)
1: (79) r9 = *(u64 *)(r1 +0)
func 'get_subflow' arg0 has btf_id 152912 type STRUCT 'mptcp_sock'
2: R1=ctx(off=0,imm=0) R9_w=trusted_ptr_mptcp_sock(off=0,imm=0)
; if (data->reinject)
2: (71) r1 = *(u8 *)(r5 +12)          ; R1_w=scalar(umax=255,var_off=(0x0; 0xff)) R5_w=trusted_ptr_mptcp_sched_data(off=0,imm=0)
3: (7b) *(u64 *)(r10 -40) = r5        ; R5_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R10=fp0 fp-40_w=trusted_ptr_
; if (data->reinject)
4: (16) if w1 == 0x0 goto pc+51 56: R1_w=0 R5_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R9_w=trusted_ptr_mptcp_sock(off=0,imm=0) R10=fp0 fp-40_w=trusted_ptr_
; if (pick)
56: (b7) r1 = -1                      ; R1_w=-1
; send_info[i].linger_time = -1;
57: (7b) *(u64 *)(r10 -8) = r1        ; R1_w=-1 R10=fp0 fp-8_w=-1
58: (7b) *(u64 *)(r10 -24) = r1       ; R1_w=-1 R10=fp0 fp-24_w=-1
59: (b4) w6 = 8                       ; R6_w=8
; send_info[i].subflow_id = MPTCP_SUBFLOWS_MAX;
60: (63) *(u32 *)(r10 -16) = r6       ; R6_w=8 R10=fp0 fp-16=8
61: (63) *(u32 *)(r10 -32) = r6       ; R6_w=8 R10=fp0 fp-32=8
; if (!data->contexts[i])
62: (79) r1 = *(u64 *)(r5 +16)        ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0) R5_w=trusted_ptr_mptcp_sched_data(off=0,imm=0)
; if (!data->contexts[i])
63: (15) if r1 == 0x0 goto pc+22      ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0)
64: (7b) *(u64 *)(r10 -56) = r9       ; R9_w=trusted_ptr_mptcp_sock(off=0,imm=0) R10=fp0 fp-56_w=trusted_ptr_
65: (b7) r2 = 16                      ; R2_w=16
66: (bf) r1 = r5                      ; R1_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R5_w=trusted_ptr_mptcp_sched_data(off=0,imm=0)
67: (0f) r1 += r2                     ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R2_w=16
68: (b7) r9 = 0                       ; R9_w=0
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
69: (07) r5 += 8                      ; R5_w=trusted_ptr_mptcp_sched_data(off=8,imm=0)
70: (7b) *(u64 *)(r10 -48) = r5       ; R5_w=trusted_ptr_mptcp_sched_data(off=8,imm=0) R10=fp0 fp-48_w=trusted_ptr_
71: (b7) r6 = 0                       ; R6_w=0
72: (05) goto pc+27
; subflow = data->contexts[i];
100: (0f) r1 += r9                    ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R9=0
101: (79) r7 = *(u64 *)(r1 +0)        ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; return subflow->tcp_sock;
102: (79) r8 = *(u64 *)(r7 +192)      ; R7_w=ptr_mptcp_subflow_context(off=0,imm=0) R8_w=ptr_sock(off=0,imm=0)
; if (!mptcp_subflow_active(subflow))
103: (bf) r1 = r7                     ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
104: (85) call mptcp_subflow_active#153119    ; R0_w=scalar()
; if (!mptcp_subflow_active(subflow))
105: (16) if w0 == 0x0 goto pc+36     ; R0_w=scalar()
; pace = subflow->avg_pacing_rate;
106: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
107: (bf) r2 = r1                     ; R1_w=scalar(id=127) R2_w=scalar(id=127)
108: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
109: (77) r2 >>= 32                   ; R2=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace) {
110: (56) if w1 != 0x0 goto pc+7      ; R1=scalar(id=127,smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
111: (79) r1 = *(u64 *)(r8 +456)      ; R1_w=scalar() R8=ptr_sock(off=0,imm=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
112: (7b) *(u64 *)(r7 +16) = r1       ; R1_w=scalar() R7=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
113: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
114: (bf) r2 = r1                     ; R1_w=scalar(id=128) R2_w=scalar(id=128)
115: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
116: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace)
117: (16) if w1 == 0x0 goto pc+24     ; R1_w=scalar(id=128)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
118: (61) r1 = *(u32 *)(r8 +336)      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R8=ptr_sock(off=0,imm=0)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
119: (67) r1 <<= 32                   ; R1_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; return dividend / divisor;
120: (3f) r1 /= r2                    ; R1_w=scalar() R2=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (linger_time < send_info[subflow->backup].linger_time) {
121: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7=ptr_mptcp_subflow_context(off=0,imm=0)
; if (linger_time < send_info[subflow->backup].linger_time) {
122: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; if (linger_time < send_info[subflow->backup].linger_time) {
123: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
124: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
;
125: (07) r3 += -32                   ; R3_w=fp-32
; if (linger_time < send_info[subflow->backup].linger_time) {
126: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
127: (79) r2 = *(u64 *)(r3 +8)        ; R2_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-24=-1
; if (linger_time < send_info[subflow->backup].linger_time) {
128: (3d) if r1 >= r2 goto pc+13      ; R1_w=scalar() R2_w=scalar()
; send_info[subflow->backup].subflow_id = i;
129: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].subflow_id = i;
130: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].subflow_id = i;
131: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
132: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
; send_info[subflow->backup].subflow_id = i;
133: (07) r3 += -32                   ; R3_w=fp-32
; send_info[subflow->backup].subflow_id = i;
134: (bf) r4 = r3                     ; R3_w=fp-32 R4_w=fp-32
135: (0f) r4 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].subflow_id = i;
136: (63) *(u32 *)(r4 +0) = r6        ; R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) R6=0 fp-16=????mmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
; send_info[subflow->backup].linger_time = linger_time;
137: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].linger_time = linger_time;
138: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].linger_time = linger_time;
139: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
140: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].linger_time = linger_time;
141: (7b) *(u64 *)(r3 +8) = r1        ; R1_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
142: (55) if r6 != 0x7 goto pc-54     ; R6=0
; mptcp_set_timeout(sk);
89: (79) r1 = *(u64 *)(r10 -40)       ; R1_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R10=fp0 fp-40=trusted_ptr_
90: (b7) r3 = 16                      ; R3_w=16
91: (0f) r1 += r3                     ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R3_w=16
; if (!data->contexts[i])
92: (bf) r2 = r9                      ; R2_w=0 R9=0
93: (0f) r2 += r3                     ; R2_w=16 R3_w=16
94: (79) r3 = *(u64 *)(r10 -48)       ; R3_w=trusted_ptr_mptcp_sched_data(off=8,imm=0) R10=fp0 fp-48=trusted_ptr_
95: (0f) r3 += r2                     ; R2_w=16 R3_w=trusted_ptr_mptcp_sched_data(off=24,imm=0)
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
96: (07) r6 += 1                      ; R6_w=1
; if (!data->contexts[i])
97: (07) r9 += 8                      ; R9_w=8
; if (!data->contexts[i])
98: (79) r2 = *(u64 *)(r3 +0)         ; R2_w=ptr_mptcp_subflow_context(off=0,imm=0) R3_w=trusted_ptr_mptcp_sched_data(off=24,imm=0)
; if (!data->contexts[i])
99: (15) if r2 == 0x0 goto pc+43      ; R2_w=ptr_mptcp_subflow_context(off=0,imm=0)
; subflow = data->contexts[i];
100: (0f) r1 += r9                    ; R1_w=trusted_ptr_mptcp_sched_data(off=24,imm=0) R9_w=8
101: (79) r7 = *(u64 *)(r1 +0)        ; R1_w=trusted_ptr_mptcp_sched_data(off=24,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; return subflow->tcp_sock;
102: (79) r8 = *(u64 *)(r7 +192)      ; R7_w=ptr_mptcp_subflow_context(off=0,imm=0) R8_w=ptr_sock(off=0,imm=0)
; if (!mptcp_subflow_active(subflow))
103: (bf) r1 = r7                     ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
104: (85) call mptcp_subflow_active#153119    ; R0=scalar()
; if (!mptcp_subflow_active(subflow))
105: (16) if w0 == 0x0 goto pc+36     ; R0=scalar()
; pace = subflow->avg_pacing_rate;
106: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
107: (bf) r2 = r1                     ; R1_w=scalar(id=130) R2_w=scalar(id=130)
108: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
109: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace) {
110: (56) if w1 != 0x0 goto pc+7      ; R1_w=scalar(id=130,smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
111: (79) r1 = *(u64 *)(r8 +456)      ; R1_w=scalar() R8=ptr_sock(off=0,imm=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
112: (7b) *(u64 *)(r7 +16) = r1       ; R1_w=scalar() R7=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
113: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
114: (bf) r2 = r1                     ; R1_w=scalar(id=131) R2_w=scalar(id=131)
115: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
116: (77) r2 >>= 32                   ; R2=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace)
117: (16) if w1 == 0x0 goto pc+24     ; R1=scalar(id=131)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
118: (61) r1 = *(u32 *)(r8 +336)      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R8=ptr_sock(off=0,imm=0)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
119: (67) r1 <<= 32                   ; R1_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; return dividend / divisor;
120: (3f) r1 /= r2                    ; R1_w=scalar() R2=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (linger_time < send_info[subflow->backup].linger_time) {
121: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7=ptr_mptcp_subflow_context(off=0,imm=0)
; if (linger_time < send_info[subflow->backup].linger_time) {
122: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; if (linger_time < send_info[subflow->backup].linger_time) {
123: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
124: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
;
125: (07) r3 += -32                   ; R3_w=fp-32
; if (linger_time < send_info[subflow->backup].linger_time) {
126: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
127: (79) r2 = *(u64 *)(r3 +8)        ; R2_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-24=mmmmmmmm
; if (linger_time < send_info[subflow->backup].linger_time) {
128: (3d) if r1 >= r2 goto pc+13      ; R1_w=scalar() R2_w=scalar()
; send_info[subflow->backup].subflow_id = i;
129: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].subflow_id = i;
130: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].subflow_id = i;
131: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
132: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
; send_info[subflow->backup].subflow_id = i;
133: (07) r3 += -32                   ; R3_w=fp-32
; send_info[subflow->backup].subflow_id = i;
134: (bf) r4 = r3                     ; R3_w=fp-32 R4_w=fp-32
135: (0f) r4 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].subflow_id = i;
136: (63) *(u32 *)(r4 +0) = r6        ; R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) R6=1 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
; send_info[subflow->backup].linger_time = linger_time;
137: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].linger_time = linger_time;
138: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].linger_time = linger_time;
139: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
140: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].linger_time = linger_time;
141: (7b) *(u64 *)(r3 +8) = r1        ; R1=scalar() R3=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
142: (55) if r6 != 0x7 goto pc-54     ; R6=1
; mptcp_set_timeout(sk);
89: (79) r1 = *(u64 *)(r10 -40)       ; R1_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R10=fp0 fp-40=trusted_ptr_
90: (b7) r3 = 16                      ; R3_w=16
91: (0f) r1 += r3                     ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R3_w=16
; if (!data->contexts[i])
92: (bf) r2 = r9                      ; R2_w=8 R9=8
93: (0f) r2 += r3                     ; R2_w=24 R3_w=16
94: (79) r3 = *(u64 *)(r10 -48)       ; R3_w=trusted_ptr_mptcp_sched_data(off=8,imm=0) R10=fp0 fp-48=trusted_ptr_
95: (0f) r3 += r2                     ; R2_w=24 R3_w=trusted_ptr_mptcp_sched_data(off=32,imm=0)
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
96: (07) r6 += 1                      ; R6_w=2
; if (!data->contexts[i])
97: (07) r9 += 8                      ; R9_w=16
; if (!data->contexts[i])
98: (79) r2 = *(u64 *)(r3 +0)         ; R2_w=ptr_mptcp_subflow_context(off=0,imm=0) R3_w=trusted_ptr_mptcp_sched_data(off=32,imm=0)
; if (!data->contexts[i])
99: (15) if r2 == 0x0 goto pc+43      ; R2_w=ptr_mptcp_subflow_context(off=0,imm=0)
; subflow = data->contexts[i];
100: (0f) r1 += r9                    ; R1_w=trusted_ptr_mptcp_sched_data(off=32,imm=0) R9_w=16
101: (79) r7 = *(u64 *)(r1 +0)        ; R1_w=trusted_ptr_mptcp_sched_data(off=32,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; return subflow->tcp_sock;
102: (79) r8 = *(u64 *)(r7 +192)      ; R7_w=ptr_mptcp_subflow_context(off=0,imm=0) R8_w=ptr_sock(off=0,imm=0)
; if (!mptcp_subflow_active(subflow))
103: (bf) r1 = r7                     ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
104: (85) call mptcp_subflow_active#153119    ; R0_w=scalar()
; if (!mptcp_subflow_active(subflow))
105: (16) if w0 == 0x0 goto pc+36     ; R0_w=scalar()
; pace = subflow->avg_pacing_rate;
106: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
107: (bf) r2 = r1                     ; R1_w=scalar(id=133) R2_w=scalar(id=133)
108: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
109: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace) {
110: (56) if w1 != 0x0 goto pc+7      ; R1_w=scalar(id=133,smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
111: (79) r1 = *(u64 *)(r8 +456)      ; R1_w=scalar() R8_w=ptr_sock(off=0,imm=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
112: (7b) *(u64 *)(r7 +16) = r1       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
113: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
114: (bf) r2 = r1                     ; R1_w=scalar(id=134) R2_w=scalar(id=134)
115: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
116: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace)
117: (16) if w1 == 0x0 goto pc+24     ; R1_w=scalar(id=134)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
118: (61) r1 = *(u32 *)(r8 +336)      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R8_w=ptr_sock(off=0,imm=0)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
119: (67) r1 <<= 32                   ; R1_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; return dividend / divisor;
120: (3f) r1 /= r2                    ; R1_w=scalar() R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (linger_time < send_info[subflow->backup].linger_time) {
121: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; if (linger_time < send_info[subflow->backup].linger_time) {
122: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; if (linger_time < send_info[subflow->backup].linger_time) {
123: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
124: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
;
125: (07) r3 += -32                   ; R3_w=fp-32
; if (linger_time < send_info[subflow->backup].linger_time) {
126: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
127: (79) r2 = *(u64 *)(r3 +8)        ; R2=scalar() R3=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-24=mmmmmmmm
; if (linger_time < send_info[subflow->backup].linger_time) {
128: (3d) if r1 >= r2 goto pc+13      ; R1=scalar() R2=scalar()
; send_info[subflow->backup].subflow_id = i;
129: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].subflow_id = i;
130: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].subflow_id = i;
131: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
132: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
; send_info[subflow->backup].subflow_id = i;
133: (07) r3 += -32                   ; R3_w=fp-32
; send_info[subflow->backup].subflow_id = i;
134: (bf) r4 = r3                     ; R3_w=fp-32 R4_w=fp-32
135: (0f) r4 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].subflow_id = i;
136: (63) *(u32 *)(r4 +0) = r6        ; R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) R6=2 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
; send_info[subflow->backup].linger_time = linger_time;
137: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].linger_time = linger_time;
138: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].linger_time = linger_time;
139: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
140: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].linger_time = linger_time;
141: (7b) *(u64 *)(r3 +8) = r1        ; R1=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
142: (55) if r6 != 0x7 goto pc-54     ; R6=2
; mptcp_set_timeout(sk);
89: (79) r1 = *(u64 *)(r10 -40)       ; R1_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R10=fp0 fp-40=trusted_ptr_
90: (b7) r3 = 16                      ; R3_w=16
91: (0f) r1 += r3                     ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R3_w=16
; if (!data->contexts[i])
92: (bf) r2 = r9                      ; R2_w=16 R9=16
93: (0f) r2 += r3                     ; R2_w=32 R3_w=16
94: (79) r3 = *(u64 *)(r10 -48)       ; R3_w=trusted_ptr_mptcp_sched_data(off=8,imm=0) R10=fp0 fp-48=trusted_ptr_
95: (0f) r3 += r2                     ; R2_w=32 R3_w=trusted_ptr_mptcp_sched_data(off=40,imm=0)
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
96: (07) r6 += 1                      ; R6_w=3
; if (!data->contexts[i])
97: (07) r9 += 8                      ; R9_w=24
; if (!data->contexts[i])
98: (79) r2 = *(u64 *)(r3 +0)         ; R2=ptr_mptcp_subflow_context(off=0,imm=0) R3=trusted_ptr_mptcp_sched_data(off=40,imm=0)
; if (!data->contexts[i])
99: (15) if r2 == 0x0 goto pc+43      ; R2=ptr_mptcp_subflow_context(off=0,imm=0)
; subflow = data->contexts[i];
100: (0f) r1 += r9                    ; R1_w=trusted_ptr_mptcp_sched_data(off=40,imm=0) R9=24
101: (79) r7 = *(u64 *)(r1 +0)        ; R1_w=trusted_ptr_mptcp_sched_data(off=40,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; return subflow->tcp_sock;
102: (79) r8 = *(u64 *)(r7 +192)      ; R7_w=ptr_mptcp_subflow_context(off=0,imm=0) R8_w=ptr_sock(off=0,imm=0)
; if (!mptcp_subflow_active(subflow))
103: (bf) r1 = r7                     ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
104: (85) call mptcp_subflow_active#153119    ; R0_w=scalar()
; if (!mptcp_subflow_active(subflow))
105: (16) if w0 == 0x0 goto pc+36     ; R0_w=scalar()
; pace = subflow->avg_pacing_rate;
106: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
107: (bf) r2 = r1                     ; R1_w=scalar(id=136) R2_w=scalar(id=136)
108: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
109: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace) {
110: (56) if w1 != 0x0 goto pc+7      ; R1_w=scalar(id=136,smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
111: (79) r1 = *(u64 *)(r8 +456)      ; R1_w=scalar() R8_w=ptr_sock(off=0,imm=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
112: (7b) *(u64 *)(r7 +16) = r1       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
113: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
114: (bf) r2 = r1                     ; R1_w=scalar(id=137) R2_w=scalar(id=137)
115: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
116: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace)
117: (16) if w1 == 0x0 goto pc+24     ; R1_w=scalar(id=137)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
118: (61) r1 = *(u32 *)(r8 +336)      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R8_w=ptr_sock(off=0,imm=0)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
119: (67) r1 <<= 32                   ; R1_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; return dividend / divisor;
120: (3f) r1 /= r2                    ; R1_w=scalar() R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (linger_time < send_info[subflow->backup].linger_time) {
121: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; if (linger_time < send_info[subflow->backup].linger_time) {
122: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; if (linger_time < send_info[subflow->backup].linger_time) {
123: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
124: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
;
125: (07) r3 += -32                   ; R3_w=fp-32
; if (linger_time < send_info[subflow->backup].linger_time) {
126: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
127: (79) r2 = *(u64 *)(r3 +8)        ; R2_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-24=mmmmmmmm
; if (linger_time < send_info[subflow->backup].linger_time) {
128: (3d) if r1 >= r2 goto pc+13      ; R1_w=scalar() R2_w=scalar()
; send_info[subflow->backup].subflow_id = i;
129: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].subflow_id = i;
130: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].subflow_id = i;
131: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
132: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
; send_info[subflow->backup].subflow_id = i;
133: (07) r3 += -32                   ; R3_w=fp-32
; send_info[subflow->backup].subflow_id = i;
134: (bf) r4 = r3                     ; R3_w=fp-32 R4_w=fp-32
135: (0f) r4 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].subflow_id = i;
136: (63) *(u32 *)(r4 +0) = r6        ; R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) R6=3 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
; send_info[subflow->backup].linger_time = linger_time;
137: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].linger_time = linger_time;
138: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].linger_time = linger_time;
139: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
140: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].linger_time = linger_time;
141: (7b) *(u64 *)(r3 +8) = r1        ; R1_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
142: (55) if r6 != 0x7 goto pc-54     ; R6=3
; mptcp_set_timeout(sk);
89: (79) r1 = *(u64 *)(r10 -40)       ; R1_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R10=fp0 fp-40=trusted_ptr_
90: (b7) r3 = 16                      ; R3_w=16
91: (0f) r1 += r3                     ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R3_w=16
; if (!data->contexts[i])
92: (bf) r2 = r9                      ; R2_w=24 R9=24
93: (0f) r2 += r3                     ; R2_w=40 R3_w=16
94: (79) r3 = *(u64 *)(r10 -48)       ; R3_w=trusted_ptr_mptcp_sched_data(off=8,imm=0) R10=fp0 fp-48=trusted_ptr_
95: (0f) r3 += r2                     ; R2_w=40 R3_w=trusted_ptr_mptcp_sched_data(off=48,imm=0)
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
96: (07) r6 += 1                      ; R6_w=4
; if (!data->contexts[i])
97: (07) r9 += 8                      ; R9_w=32
; if (!data->contexts[i])
98: (79) r2 = *(u64 *)(r3 +0)         ; R2_w=ptr_mptcp_subflow_context(off=0,imm=0) R3_w=trusted_ptr_mptcp_sched_data(off=48,imm=0)
; if (!data->contexts[i])
99: (15) if r2 == 0x0 goto pc+43      ; R2_w=ptr_mptcp_subflow_context(off=0,imm=0)
; subflow = data->contexts[i];
100: (0f) r1 += r9                    ; R1_w=trusted_ptr_mptcp_sched_data(off=48,imm=0) R9_w=32
101: (79) r7 = *(u64 *)(r1 +0)        ; R1_w=trusted_ptr_mptcp_sched_data(off=48,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; return subflow->tcp_sock;
102: (79) r8 = *(u64 *)(r7 +192)      ; R7_w=ptr_mptcp_subflow_context(off=0,imm=0) R8_w=ptr_sock(off=0,imm=0)
; if (!mptcp_subflow_active(subflow))
103: (bf) r1 = r7                     ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
104: (85) call mptcp_subflow_active#153119    ; R0_w=scalar()
; if (!mptcp_subflow_active(subflow))
105: (16) if w0 == 0x0 goto pc+36     ; R0_w=scalar()
; pace = subflow->avg_pacing_rate;
106: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
107: (bf) r2 = r1                     ; R1_w=scalar(id=139) R2_w=scalar(id=139)
108: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
109: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace) {
110: (56) if w1 != 0x0 goto pc+7      ; R1_w=scalar(id=139,smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
111: (79) r1 = *(u64 *)(r8 +456)      ; R1_w=scalar() R8_w=ptr_sock(off=0,imm=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
112: (7b) *(u64 *)(r7 +16) = r1       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
113: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
114: (bf) r2 = r1                     ; R1_w=scalar(id=140) R2_w=scalar(id=140)
115: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
116: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace)
117: (16) if w1 == 0x0 goto pc+24     ; R1_w=scalar(id=140)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
118: (61) r1 = *(u32 *)(r8 +336)      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R8_w=ptr_sock(off=0,imm=0)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
119: (67) r1 <<= 32                   ; R1_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; return dividend / divisor;
120: (3f) r1 /= r2                    ; R1_w=scalar() R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (linger_time < send_info[subflow->backup].linger_time) {
121: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; if (linger_time < send_info[subflow->backup].linger_time) {
122: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; if (linger_time < send_info[subflow->backup].linger_time) {
123: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
124: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
;
125: (07) r3 += -32                   ; R3_w=fp-32
; if (linger_time < send_info[subflow->backup].linger_time) {
126: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
127: (79) r2 = *(u64 *)(r3 +8)        ; R2_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-24=mmmmmmmm
; if (linger_time < send_info[subflow->backup].linger_time) {
128: (3d) if r1 >= r2 goto pc+13      ; R1_w=scalar() R2_w=scalar()
; send_info[subflow->backup].subflow_id = i;
129: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].subflow_id = i;
130: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].subflow_id = i;
131: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
132: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
; send_info[subflow->backup].subflow_id = i;
133: (07) r3 += -32                   ; R3_w=fp-32
; send_info[subflow->backup].subflow_id = i;
134: (bf) r4 = r3                     ; R3_w=fp-32 R4_w=fp-32
135: (0f) r4 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].subflow_id = i;
136: (63) *(u32 *)(r4 +0) = r6        ; R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) R6_w=4 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
; send_info[subflow->backup].linger_time = linger_time;
137: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].linger_time = linger_time;
138: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].linger_time = linger_time;
139: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
140: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].linger_time = linger_time;
141: (7b) *(u64 *)(r3 +8) = r1        ; R1_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
142: (55) if r6 != 0x7 goto pc-54     ; R6_w=4
; mptcp_set_timeout(sk);
89: (79) r1 = *(u64 *)(r10 -40)       ; R1_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R10=fp0 fp-40=trusted_ptr_
90: (b7) r3 = 16                      ; R3_w=16
91: (0f) r1 += r3                     ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R3_w=16
; if (!data->contexts[i])
92: (bf) r2 = r9                      ; R2_w=32 R9_w=32
93: (0f) r2 += r3                     ; R2_w=48 R3_w=16
94: (79) r3 = *(u64 *)(r10 -48)       ; R3_w=trusted_ptr_mptcp_sched_data(off=8,imm=0) R10=fp0 fp-48=trusted_ptr_
95: (0f) r3 += r2                     ; R2_w=48 R3_w=trusted_ptr_mptcp_sched_data(off=56,imm=0)
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
96: (07) r6 += 1                      ; R6_w=5
; if (!data->contexts[i])
97: (07) r9 += 8                      ; R9_w=40
; if (!data->contexts[i])
98: (79) r2 = *(u64 *)(r3 +0)         ; R2=ptr_mptcp_subflow_context(off=0,imm=0) R3=trusted_ptr_mptcp_sched_data(off=56,imm=0)
; if (!data->contexts[i])
99: (15) if r2 == 0x0 goto pc+43      ; R2=ptr_mptcp_subflow_context(off=0,imm=0)
; subflow = data->contexts[i];
100: (0f) r1 += r9                    ; R1_w=trusted_ptr_mptcp_sched_data(off=56,imm=0) R9=40
101: (79) r7 = *(u64 *)(r1 +0)        ; R1_w=trusted_ptr_mptcp_sched_data(off=56,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; return subflow->tcp_sock;
102: (79) r8 = *(u64 *)(r7 +192)      ; R7_w=ptr_mptcp_subflow_context(off=0,imm=0) R8_w=ptr_sock(off=0,imm=0)
; if (!mptcp_subflow_active(subflow))
103: (bf) r1 = r7                     ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
104: (85) call mptcp_subflow_active#153119    ; R0_w=scalar()
; if (!mptcp_subflow_active(subflow))
105: (16) if w0 == 0x0 goto pc+36     ; R0_w=scalar()
; pace = subflow->avg_pacing_rate;
106: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
107: (bf) r2 = r1                     ; R1_w=scalar(id=142) R2_w=scalar(id=142)
108: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
109: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace) {
110: (56) if w1 != 0x0 goto pc+7      ; R1_w=scalar(id=142,smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
111: (79) r1 = *(u64 *)(r8 +456)      ; R1_w=scalar() R8_w=ptr_sock(off=0,imm=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
112: (7b) *(u64 *)(r7 +16) = r1       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
113: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
114: (bf) r2 = r1                     ; R1_w=scalar(id=143) R2_w=scalar(id=143)
115: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
116: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace)
117: (16) if w1 == 0x0 goto pc+24     ; R1_w=scalar(id=143)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
118: (61) r1 = *(u32 *)(r8 +336)      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R8_w=ptr_sock(off=0,imm=0)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
119: (67) r1 <<= 32                   ; R1_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; return dividend / divisor;
120: (3f) r1 /= r2                    ; R1_w=scalar() R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (linger_time < send_info[subflow->backup].linger_time) {
121: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; if (linger_time < send_info[subflow->backup].linger_time) {
122: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; if (linger_time < send_info[subflow->backup].linger_time) {
123: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
124: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
;
125: (07) r3 += -32                   ; R3_w=fp-32
; if (linger_time < send_info[subflow->backup].linger_time) {
126: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
127: (79) r2 = *(u64 *)(r3 +8)        ; R2_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-24=mmmmmmmm
; if (linger_time < send_info[subflow->backup].linger_time) {
128: (3d) if r1 >= r2 goto pc+13      ; R1_w=scalar() R2_w=scalar()
; send_info[subflow->backup].subflow_id = i;
129: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].subflow_id = i;
130: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].subflow_id = i;
131: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
132: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
; send_info[subflow->backup].subflow_id = i;
133: (07) r3 += -32                   ; R3_w=fp-32
; send_info[subflow->backup].subflow_id = i;
134: (bf) r4 = r3                     ; R3_w=fp-32 R4_w=fp-32
135: (0f) r4 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].subflow_id = i;
136: (63) *(u32 *)(r4 +0) = r6        ; R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) R6=5 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
; send_info[subflow->backup].linger_time = linger_time;
137: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].linger_time = linger_time;
138: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].linger_time = linger_time;
139: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
140: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].linger_time = linger_time;
141: (7b) *(u64 *)(r3 +8) = r1        ; R1_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
142: (55) if r6 != 0x7 goto pc-54     ; R6=5
; mptcp_set_timeout(sk);
89: (79) r1 = *(u64 *)(r10 -40)       ; R1_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R10=fp0 fp-40=trusted_ptr_
90: (b7) r3 = 16                      ; R3_w=16
91: (0f) r1 += r3                     ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R3_w=16
; if (!data->contexts[i])
92: (bf) r2 = r9                      ; R2_w=40 R9=40
93: (0f) r2 += r3                     ; R2_w=56 R3_w=16
94: (79) r3 = *(u64 *)(r10 -48)       ; R3_w=trusted_ptr_mptcp_sched_data(off=8,imm=0) R10=fp0 fp-48=trusted_ptr_
95: (0f) r3 += r2                     ; R2_w=56 R3_w=trusted_ptr_mptcp_sched_data(off=64,imm=0)
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
96: (07) r6 += 1                      ; R6_w=6
; if (!data->contexts[i])
97: (07) r9 += 8                      ; R9_w=48
; if (!data->contexts[i])
98: (79) r2 = *(u64 *)(r3 +0)         ; R2_w=ptr_mptcp_subflow_context(off=0,imm=0) R3_w=trusted_ptr_mptcp_sched_data(off=64,imm=0)
; if (!data->contexts[i])
99: (15) if r2 == 0x0 goto pc+43      ; R2_w=ptr_mptcp_subflow_context(off=0,imm=0)
; subflow = data->contexts[i];
100: (0f) r1 += r9                    ; R1_w=trusted_ptr_mptcp_sched_data(off=64,imm=0) R9_w=48
101: (79) r7 = *(u64 *)(r1 +0)        ; R1_w=trusted_ptr_mptcp_sched_data(off=64,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; return subflow->tcp_sock;
102: (79) r8 = *(u64 *)(r7 +192)      ; R7_w=ptr_mptcp_subflow_context(off=0,imm=0) R8_w=ptr_sock(off=0,imm=0)
; if (!mptcp_subflow_active(subflow))
103: (bf) r1 = r7                     ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
104: (85) call mptcp_subflow_active#153119    ; R0_w=scalar()
; if (!mptcp_subflow_active(subflow))
105: (16) if w0 == 0x0 goto pc+36     ; R0_w=scalar()
; pace = subflow->avg_pacing_rate;
106: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
107: (bf) r2 = r1                     ; R1_w=scalar(id=145) R2_w=scalar(id=145)
108: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
109: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace) {
110: (56) if w1 != 0x0 goto pc+7      ; R1_w=scalar(id=145,smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
111: (79) r1 = *(u64 *)(r8 +456)      ; R1_w=scalar() R8_w=ptr_sock(off=0,imm=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
112: (7b) *(u64 *)(r7 +16) = r1       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
113: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
114: (bf) r2 = r1                     ; R1_w=scalar(id=146) R2_w=scalar(id=146)
115: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
116: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace)
117: (16) if w1 == 0x0 goto pc+24     ; R1_w=scalar(id=146)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
118: (61) r1 = *(u32 *)(r8 +336)      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R8_w=ptr_sock(off=0,imm=0)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
119: (67) r1 <<= 32                   ; R1_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; return dividend / divisor;
120: (3f) r1 /= r2                    ; R1_w=scalar() R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (linger_time < send_info[subflow->backup].linger_time) {
121: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; if (linger_time < send_info[subflow->backup].linger_time) {
122: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; if (linger_time < send_info[subflow->backup].linger_time) {
123: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
124: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
;
125: (07) r3 += -32                   ; R3_w=fp-32
; if (linger_time < send_info[subflow->backup].linger_time) {
126: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
127: (79) r2 = *(u64 *)(r3 +8)        ; R2_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-24=mmmmmmmm
; if (linger_time < send_info[subflow->backup].linger_time) {
128: (3d) if r1 >= r2 goto pc+13      ; R1_w=scalar() R2_w=scalar()
; send_info[subflow->backup].subflow_id = i;
129: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].subflow_id = i;
130: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].subflow_id = i;
131: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
132: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
; send_info[subflow->backup].subflow_id = i;
133: (07) r3 += -32                   ; R3_w=fp-32
; send_info[subflow->backup].subflow_id = i;
134: (bf) r4 = r3                     ; R3_w=fp-32 R4_w=fp-32
135: (0f) r4 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].subflow_id = i;
136: (63) *(u32 *)(r4 +0) = r6        ; R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) R6_w=6 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
; send_info[subflow->backup].linger_time = linger_time;
137: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].linger_time = linger_time;
138: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].linger_time = linger_time;
139: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
140: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].linger_time = linger_time;
141: (7b) *(u64 *)(r3 +8) = r1        ; R1_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
142: (55) if r6 != 0x7 goto pc-54     ; R6_w=6
; mptcp_set_timeout(sk);
89: (79) r1 = *(u64 *)(r10 -40)       ; R1_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R10=fp0 fp-40=trusted_ptr_
90: (b7) r3 = 16                      ; R3_w=16
91: (0f) r1 += r3                     ; R1_w=trusted_ptr_mptcp_sched_data(off=16,imm=0) R3_w=16
; if (!data->contexts[i])
92: (bf) r2 = r9                      ; R2_w=48 R9_w=48
93: (0f) r2 += r3                     ; R2_w=64 R3_w=16
94: (79) r3 = *(u64 *)(r10 -48)       ; R3_w=trusted_ptr_mptcp_sched_data(off=8,imm=0) R10=fp0 fp-48=trusted_ptr_
95: (0f) r3 += r2                     ; R2_w=64 R3_w=trusted_ptr_mptcp_sched_data(off=72,imm=0)
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
96: (07) r6 += 1                      ; R6_w=7
; if (!data->contexts[i])
97: (07) r9 += 8                      ; R9_w=56
; if (!data->contexts[i])
98: (79) r2 = *(u64 *)(r3 +0)         ; R2=ptr_mptcp_subflow_context(off=0,imm=0) R3=trusted_ptr_mptcp_sched_data(off=72,imm=0)
; if (!data->contexts[i])
99: (15) if r2 == 0x0 goto pc+43      ; R2=ptr_mptcp_subflow_context(off=0,imm=0)
; subflow = data->contexts[i];
100: (0f) r1 += r9                    ; R1_w=trusted_ptr_mptcp_sched_data(off=72,imm=0) R9=56
101: (79) r7 = *(u64 *)(r1 +0)        ; R1_w=trusted_ptr_mptcp_sched_data(off=72,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; return subflow->tcp_sock;
102: (79) r8 = *(u64 *)(r7 +192)      ; R7_w=ptr_mptcp_subflow_context(off=0,imm=0) R8_w=ptr_sock(off=0,imm=0)
; if (!mptcp_subflow_active(subflow))
103: (bf) r1 = r7                     ; R1_w=ptr_mptcp_subflow_context(off=0,imm=0) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
104: (85) call mptcp_subflow_active#153119    ; R0_w=scalar()
; if (!mptcp_subflow_active(subflow))
105: (16) if w0 == 0x0 goto pc+36     ; R0_w=scalar()
; pace = subflow->avg_pacing_rate;
106: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
107: (bf) r2 = r1                     ; R1_w=scalar(id=148) R2_w=scalar(id=148)
108: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
109: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace) {
110: (56) if w1 != 0x0 goto pc+7      ; R1_w=scalar(id=148,smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
111: (79) r1 = *(u64 *)(r8 +456)      ; R1_w=scalar() R8_w=ptr_sock(off=0,imm=0)
; subflow->avg_pacing_rate = ssk->sk_pacing_rate;
112: (7b) *(u64 *)(r7 +16) = r1       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
113: (79) r1 = *(u64 *)(r7 +16)       ; R1_w=scalar() R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; pace = subflow->avg_pacing_rate;
114: (bf) r2 = r1                     ; R1_w=scalar(id=149) R2_w=scalar(id=149)
115: (67) r2 <<= 32                   ; R2_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
116: (77) r2 >>= 32                   ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!pace)
117: (16) if w1 == 0x0 goto pc+24     ; R1_w=scalar(id=149)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
118: (61) r1 = *(u32 *)(r8 +336)      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R8_w=ptr_sock(off=0,imm=0)
; linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
119: (67) r1 <<= 32                   ; R1_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
; return dividend / divisor;
120: (3f) r1 /= r2                    ; R1_w=scalar() R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (linger_time < send_info[subflow->backup].linger_time) {
121: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; if (linger_time < send_info[subflow->backup].linger_time) {
122: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; if (linger_time < send_info[subflow->backup].linger_time) {
123: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
124: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
;
125: (07) r3 += -32                   ; R3_w=fp-32
; if (linger_time < send_info[subflow->backup].linger_time) {
126: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
127: (79) r2 = *(u64 *)(r3 +8)        ; R2_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-24=mmmmmmmm
; if (linger_time < send_info[subflow->backup].linger_time) {
128: (3d) if r1 >= r2 goto pc+13      ; R1_w=scalar() R2_w=scalar()
; send_info[subflow->backup].subflow_id = i;
129: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].subflow_id = i;
130: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].subflow_id = i;
131: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
132: (bf) r3 = r10                    ; R3_w=fp0 R10=fp0
; send_info[subflow->backup].subflow_id = i;
133: (07) r3 += -32                   ; R3_w=fp-32
; send_info[subflow->backup].subflow_id = i;
134: (bf) r4 = r3                     ; R3_w=fp-32 R4_w=fp-32
135: (0f) r4 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].subflow_id = i;
136: (63) *(u32 *)(r4 +0) = r6        ; R4_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) R6=7 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
; send_info[subflow->backup].linger_time = linger_time;
137: (71) r2 = *(u8 *)(r7 +88)        ; R2_w=scalar(umax=255,var_off=(0x0; 0xff)) R7_w=ptr_mptcp_subflow_context(off=0,imm=0)
; send_info[subflow->backup].linger_time = linger_time;
138: (57) r2 &= 1                     ; R2_w=scalar(umax=1,var_off=(0x0; 0x1))
; send_info[subflow->backup].linger_time = linger_time;
139: (67) r2 <<= 4                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10))
140: (0f) r3 += r2                    ; R2_w=scalar(umax=16,var_off=(0x0; 0x10)) R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10))
; send_info[subflow->backup].linger_time = linger_time;
141: (7b) *(u64 *)(r3 +8) = r1        ; R1_w=scalar() R3_w=fp(off=-32,umax=16,var_off=(0x0; 0x10)) fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm
; for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
142: (55) if r6 != 0x7 goto pc-54     ; R6=7
; if (send_info[SSK_MODE_ACTIVE].subflow_id == MPTCP_SUBFLOWS_MAX)
143: (61) r6 = *(u32 *)(r10 -16)      ; R6_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0 fp-16=mmmmmmmm
; if (send_info[SSK_MODE_ACTIVE].subflow_id == MPTCP_SUBFLOWS_MAX)
144: (61) r8 = *(u32 *)(r10 -32)      ; R8_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0 fp-32=mmmmmmmm
145: (79) r9 = *(u64 *)(r10 -56)      ; R9_w=trusted_ptr_mptcp_sock(off=0,imm=0) R10=fp0 fp-56=trusted_ptr_
; mptcp_set_timeout(sk);
146: (bf) r1 = r9                     ; R1_w=trusted_ptr_mptcp_sock(off=0,imm=0) R9_w=trusted_ptr_mptcp_sock(off=0,imm=0)
147: (85) call mptcp_set_timeout#153142       ;
; if (send_info[SSK_MODE_ACTIVE].subflow_id == MPTCP_SUBFLOWS_MAX)
148: (56) if w8 != 0x8 goto pc+1      ; R8_w=8
149: (bc) w8 = w6                     ; R6_w=scalar(id=150,umax=4294967295,var_off=(0x0; 0xffffffff)) R8_w=scalar(id=150,umax=4294967295,var_off=(0x0; 0xffffffff))
150: (bf) r6 = r9                     ; R6=trusted_ptr_mptcp_sock(off=0,imm=0) R9=trusted_ptr_mptcp_sock(off=0,imm=0)
; if (send_info[SSK_MODE_ACTIVE].subflow_id < MPTCP_SUBFLOWS_MAX)
151: (26) if w8 > 0x7 goto pc+6       ; R8=scalar(id=150,umax=7,var_off=(0x0; 0x7))
152: (b7) r1 = 16                     ; R1_w=16
153: (79) r2 = *(u64 *)(r10 -40)      ; R2_w=trusted_ptr_mptcp_sched_data(off=0,imm=0) R10=fp0 fp-40=trusted_ptr_
154: (0f) r2 += r1                    ; R1_w=16 R2_w=trusted_ptr_mptcp_sched_data(off=16,imm=0)
; subflow = data->contexts[send_info[SSK_MODE_ACTIVE].subflow_id];
155: (67) r8 <<= 3                    ; R8_w=scalar(umax=56,var_off=(0x0; 0x38))
156: (0f) r2 += r8                    ; R2_w=trusted_ptr_mptcp_sched_data(off=16,umax=56,var_off=(0x0; 0x38)) R8_w=scalar(umax=56,var_off=(0x0; 0x38))
157: (79) r7 = *(u64 *)(r2 +0)
R2 is ptr_mptcp_sched_data invalid variable offset: off=16, var_off=(0x0; 0x38)
processed 4748 insns (limit 1000000) max_states_per_insn 10 total_states 174 peak_states 113 mark_read 12
-- END PROG LOAD LOG --
libbpf: prog 'bpf_burst_get_subflow': failed to load: -13
libbpf: failed to load object 'mptcp_bpf_burst'
libbpf: failed to load BPF skeleton 'mptcp_bpf_burst': -13
test_burst:FAIL:bpf_burst__open_and_load unexpected error: -13
#141/6   mptcp/burst:FAIL
#141     mptcp:FAIL
Summary: 0/6 PASSED, 0 SKIPPED, 1 FAILED
'''

Thanks,
-Geliang

> 
> > 
> > > that we avoid the 'mptcp_subflow_tcp_sock()'
> > > call entirely.
> > 
> > No need to avoid "mptcp_subflow_tcp_sock", we need to access both
> > 'subflow' and 'ssk' below.
> 
> Yup, typo on my side above. I'm trying to avoid
> bpf_mptcp_subflow_ctx().
> 
> 
> Cheers,
> 
> Paolo
> 
