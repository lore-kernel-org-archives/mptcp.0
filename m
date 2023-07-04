Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3847620
	for <mptcp@lists.linux.dev>; Tue,  4 Jul 2023 02:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7LUk5e3j9MIhEULrWnIf81Emuovf+9YgKqC/HvjUBC/z5JbKjG8m8rwIXMmhGHkZnqBVxkDGtoVHSfMScaO4W/9yN/K/oFK3q+SAJT5d7e4aRLpRfiGD/H0xMX4/m32CWdxnuFSz35j4UkfPSPHRVV7TDOOXg6AfxW6f+CpLJQdxWsEiS0NOBbav7kUcl7ipv7drFikJVNOaCwt2RxSd8zWc3LeHDWKgTVEt7KnT3dLeQctQcBa2M53HofwITxkB0BozB++oiXgIfW7F79Roa8WQNtBp3vNrQ2yuWpsDwwUgFDKIS8UVYqF6ddaKTYuWOdUj5STR9Zxb8ekGmUTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yLa/b2O00bBb7r79kCAGDl3YDP4pffw2x611h29Mtw=;
 b=Jv6kudzL3FRnyxSKo4viwR0pF5orjV/nCfigJoKtVwNLApkS0U0kW0tq5nbR0DKgUmrllKNbJPtH9rabEX//uWifL3XvMuHoogLRvQ71SNp+CWRyQh7Ql4B4kpfhGEQITOebNzo0XBiRF1RYHfSYzJQQc4ZwBMmO1yzPsIdCAMRZMZMKRPDGeia2bl1OvXAZSWUycpK2iW7il+PRueuKxxH5fU07CRj8xl8BcksuPtPDIsVWsrzFoeejZ7wu6hHqcR3Q1Dfx6RQLGNF4KmusRhGtdnJP0noB8VBicOduYpT8jQrXmk5IekfD+PI9pESBd3L9CCi0TGAikaGBxI9TFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yLa/b2O00bBb7r79kCAGDl3YDP4pffw2x611h29Mtw=;
 b=Poz+1G8vxxIoFIpwj2psNNpqEtiH3L6h/4UrdeGmKUCmSL3Gs08nVIRyb6H1ETqJ9GOPtR71tCM1iP1KUzwcLcRwjde+hjqEaMN273lRKfECiaYS8uoc5poJ49T02O8nOF2bHDURZjt2Hb8FnGipF+0mpQiwVevz+FAaD2Q3CG1kZix0nYmJWvQFw2OiuIoYgkNQVCuDK8fGoSxGs530/cHWP/9qsQHPJ87KwjuapbymH+HqMFy4SwMDCBIJg+YYaQAdYHLYIvbio6ABqTrkHcv6A/jS7A3o6iiLhha3+fHgpQdVUCX6A1v06Kk6l3dw1kDrlXL5YcTdkVWciEfovA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9779.eurprd04.prod.outlook.com (2603:10a6:150:111::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 02:06:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 02:06:53 +0000
Date: Tue, 4 Jul 2023 10:06:54 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v11 10/11] Squash to "selftests/bpf: Add
 bpf_rr scheduler"
Message-ID: <20230704020654.GA27381@localhost>
References: <cover.1687827857.git.geliang.tang@suse.com>
 <664d3df8d7d05c3cf5d092b6fe5c8e418a44cb16.1687827857.git.geliang.tang@suse.com>
 <d005f0e6692d6fdb175b5366c1b7afe253f7930e.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d005f0e6692d6fdb175b5366c1b7afe253f7930e.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYAPR01CA0168.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9779:EE_
X-MS-Office365-Filtering-Correlation-Id: c28adf37-fcbd-4171-6b6f-08db7c335623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vzlrHkiO/3/sMsfK+hYNy2uO5L9e88fNS82Z9srHP2dPGOIsyHaezXuZ3m2aO5JKbsFgGw0Gmdb8qNufbhu23Jol0TcgNbfG99j4CfoNqfr1jUUZfsPFFaygOp9qOTdEFhWC5MFcZetAJMr4Qy8RuDuVcrKITd2Ynv5U6eBHAi5YScQ1PYyQnCn5KR6QxoyqDJXFnzhDNheSZG3ff02kSFVf1yErxaKUVKp9GiM1IRKSnXhuYarwNxfS/zd+bTmzuKYxwECDc68LS4PcTwApMH0/aj05in8JXxuC3D79mOMqPN6y9BcOBqMYWCzkTL5WwwVAB1H+zpZIPry2wwIVif6IejRhDuNf4VqqB5kPaw4P9ZOnOAF21dK/KDo4pjQHMKzTJZ6GxswGP0O4lMRDQXgMPmOFXQBhV3ToVFeePZPAabLsDUnO+FwyNy1I1LQaDJ0BZBRTR682rw9jDPgBUmWTginrAe58Uu9H6JKTjy7FCsS4hg7M1W2XVNrGyu9vwqITfzrpem8ZSqLwZ6ZgJbRgyxJiuZvKbJLHBGsanek=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(6506007)(6512007)(1076003)(66556008)(66476007)(316002)(6916009)(66946007)(38100700002)(4326008)(33716001)(83380400001)(186003)(26005)(9686003)(478600001)(8936002)(8676002)(44832011)(2906002)(6486002)(5660300002)(966005)(86362001)(41300700001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X0u6K8QIL/gd3HoAtI4IwA0+bPB9RhskXjZdgUpSDU9G3qPYOruFlJd6zpBI?=
 =?us-ascii?Q?+F+onVu2TrPMtqhR4HQmuWkZvHOyv80aX5tP1/4McJ6lElRPrLYMLvbloahP?=
 =?us-ascii?Q?3gcgThbw1U0ckTPA6atkPr7tbMXZiPcXUVUaUc/AWAp7WS4hpDpoUebVbtMc?=
 =?us-ascii?Q?20eyhBSDcF5HXPMJVuoKpIO9jVaorzJS8Zr4SkAZ+J3Cr4D6pCJ51gzxR95i?=
 =?us-ascii?Q?U+ZucuKcBs/3hPpPIv9ttTrUrQi+EjuS+nyOrJeZLv48Z1oWOnvwK3eRXUqV?=
 =?us-ascii?Q?eAl/noaQgYfg+LDHvbYzU4cUj54dOOCA3qYqBli9QzlJUeDJ+YwecGEczBYB?=
 =?us-ascii?Q?4iLS9aVyEDAt02Nbfo8uG/ODfKLs8XZd+JG52LqH4dZzJTZdJ5PTTk5i5mX0?=
 =?us-ascii?Q?KT+ie2VhcLmFjLVDpaSUKPExGfqLSWA3RDzmKib+5GNrilPzMcLja74qvvac?=
 =?us-ascii?Q?SzbYUlJgYyL5hRlc+ShapKCqPLZhtMflkMrzON+8Df1nNQao7LUOm+kg9kwJ?=
 =?us-ascii?Q?evf8Yg3aTFGDmzbvs0arejWJ2D0xuDDvE4APZUHFus9J250RllGEl0kLYE5D?=
 =?us-ascii?Q?kcGWWoidHliCVZ+L1K+KXHEX5Ayn6gdQethQvJP24MajLtQ/8IZJu6t48+uW?=
 =?us-ascii?Q?AOsV1w8SzhJmhbQm5TqMJY+y6yUxaEHUTrLqOrWnnpPpd6r/MO8aEdCeY4qo?=
 =?us-ascii?Q?N5IY9PocDgQOhPc3Z3txMKEH+irHn02y3GEsNsagiJucrghsIEK9Bn0d58Tb?=
 =?us-ascii?Q?kfvkng+Ok8D4V+HM2+NM0f0LL+XI7wYhjNGo51F77+Quyx3Zs2gsJIcWYnDK?=
 =?us-ascii?Q?3k8SiAnSSyy6UKUy0Gjy2znBg38dH39lIonq6zqt9v2EjioU22rJiLVIICVM?=
 =?us-ascii?Q?YUJSEIWJSauXT96VYGiYf8AHbnJrH/N/3oWiHxTURSa9NyGJICb33nD3QIru?=
 =?us-ascii?Q?o88A6JiV2i7fIWoTJeVyeb13+FPFy4ZH/q2PavwZBYyHIigba7Tz2bqTEYl7?=
 =?us-ascii?Q?wfd8XrPeQ0/X5vQPnbMUSbTs/qlNJY2NaY9j57ne4slRK1yVHl/vL5DxEbf4?=
 =?us-ascii?Q?sRGBvmAnAw+YoRH6GD5z9VFXYTyjP6EOkLmJMxgzc/thkClYywO7qbYcWVdr?=
 =?us-ascii?Q?0GBVU5ADtwd3aXeoWWzc7cTaI6rrFFbmhY/o6SY0st9Xw9JniGRuT9lRmqJY?=
 =?us-ascii?Q?uq5wDXde91H7zUqr9kuU5hOURidvMpz29firvh8Mgw3Wso0uHBeOdq5qC82p?=
 =?us-ascii?Q?ER8mqvsFs2xUNsbnlih5Nt5mg+iZhysqvQ3unLPGfEeV5lmSo0T0+Do+W1eG?=
 =?us-ascii?Q?bgXo+8vjBXR6c5SfoJ6v+fdXREJMPnfUTwPYaD6UKeEcKU6s/FJE19/t0S0v?=
 =?us-ascii?Q?MEslShFiJ92+XwE6mC5X7LJpM5Llt2LFbAGaurQepRtesYjvCQVuXatNhpJJ?=
 =?us-ascii?Q?160WiDwrNmaLzksS4+Sj1TpeWh4ESWr/pkoE7pYLsO9+wDTCEkYn7KkJLocE?=
 =?us-ascii?Q?fVzRAI6gEfyeLJOSkSrBg2pPN69j5Gutg783rCbw6COdWuXGP5GeWIUTl7hj?=
 =?us-ascii?Q?4DApgnUIJJ8T8UM5wSFvwX7z7nXH+c7GcP5Hdu2U?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28adf37-fcbd-4171-6b6f-08db7c335623
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 02:06:53.7277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNZne4+QMfC28e75q3YjoT/31u+5To51MImF3lEnM2eVgrmjhWGKUx3XCv+qYra5eme+SVonAp9NmD7HL40apQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9779

On Mon, Jul 03, 2023 at 05:38:39PM +0200, Paolo Abeni wrote:
> On Tue, 2023-06-27 at 09:06 +0800, Geliang Tang wrote:
> > Use sk_storage to store last_snd, instead of using msk->last_snd.
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  tools/testing/selftests/bpf/bpf_tcp_helpers.h |  6 ++-
> >  .../selftests/bpf/progs/mptcp_bpf_rr.c        | 44 ++++++++++++++-----
> >  2 files changed, 39 insertions(+), 11 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> > index b4b766c7a68f..945dd46c98c0 100644
> > --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> > +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> > @@ -259,7 +259,6 @@ struct mptcp_sched_ops {
> >  struct mptcp_sock {
> >  	struct inet_connection_sock	sk;
> >  
> > -	struct sock	*last_snd;
> >  	__u32		token;
> >  	struct sock	*first;
> >  	char		ca_name[TCP_CA_NAME_MAX];
> > @@ -271,5 +270,10 @@ extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
> >  					  struct mptcp_sched_data *data) __ksym;
> >  extern struct mptcp_subflow_context *
> >  mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
> > +static inline struct sock *
> > +mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
> > +{
> > +	return subflow->tcp_sock;
> > +}
> >  
> >  #endif
> > diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> > index e101428e5906..21144e96ba56 100644
> > --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> > +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> > @@ -6,33 +6,49 @@
> >  
> >  char _license[] SEC("license") = "GPL";
> >  
> > +struct mptcp_rr_storage {
> > +	struct sock *last_snd;
> > +};
> > +struct sock *last_snd;
> > +
> > +struct {
> > +	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
> > +	__uint(map_flags, BPF_F_NO_PREALLOC);
> > +	__type(key, int);
> > +	__type(value, struct mptcp_rr_storage);
> > +} mptcp_rr_map SEC(".maps");
> > +
> >  SEC("struct_ops/mptcp_sched_rr_init")
> > -void BPF_PROG(mptcp_sched_rr_init, const struct mptcp_sock *msk)
> > +void BPF_PROG(mptcp_sched_rr_init, struct mptcp_sock *msk)
> >  {
> >  }
> >  
> >  SEC("struct_ops/mptcp_sched_rr_release")
> > -void BPF_PROG(mptcp_sched_rr_release, const struct mptcp_sock *msk)
> > +void BPF_PROG(mptcp_sched_rr_release, struct mptcp_sock *msk)
> >  {
> > +	bpf_sk_storage_delete(&mptcp_rr_map, msk);
> >  }
> >  
> > -void BPF_STRUCT_OPS(bpf_rr_data_init, const struct mptcp_sock *msk,
> > +void BPF_STRUCT_OPS(bpf_rr_data_init, struct mptcp_sock *msk,
> >  		    struct mptcp_sched_data *data)
> >  {
> >  	mptcp_sched_data_set_contexts(msk, data);
> >  }
> >  
> > -int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
> > -		   struct mptcp_sched_data *data)
> > +int BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk,
> > +		   const struct mptcp_sched_data *data)
> >  {
> > +	struct mptcp_subflow_context *subflow;
> > +	struct mptcp_rr_storage *ptr;
> >  	int nr = 0;
> >  
> > -	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> > -		if (!msk->last_snd || !data->contexts[i])
> > +	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
> > +		subflow = mptcp_subflow_ctx_by_pos(data, i);
> > +		if (!last_snd || !subflow)
> 
> It looks like this is accessing a global variable ('last_snd'), which
> is probably not very safe.

Yes, it's should be a local variable. I just sent a patch to ML to fix
this:

https://patchwork.kernel.org/project/mptcp/patch/0b57bf87dc30e15782ba1fe2e925a7ce6ef0fc90.1688434547.git.geliang.tang@suse.com/

> 
> I think you could instead use inet_csk(msk)->icsk_ca_priv - currently
> unused.
> 
> As this is the only comment I have, no need to send a whole v12. I
> think we can merge the series as-is and then squash the needed change
> to replace the global variable and map used here with inet_csk(msk)-
> >icsk_ca_priv.

One of the purposes of this test is to demonstrate an example of using a
bpf map to store persistent schedulers data, so I prefer to use the bpf
map to implement it here.

Using inet_csk(msk)->icsk_ca_priv is much more complex. We need to add
the special write accesses for icsk_ca_priv.

Thanks,
-Geliang

> 
> Thanks!
> 
> Paolo
> 
