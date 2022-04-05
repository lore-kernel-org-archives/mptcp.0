Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5722217D3
	for <mptcp@lists.linux.dev>; Tue,  5 Apr 2022 11:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649158649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EGmKsp6V7WXhk3wwchpibv86sGI4JAZUR3CKtUo2MZY=;
	b=G6UHFm1YCDkXiSNBegIhrSp1kBjVPwle7iMFKJZkUQjP2JL0Qp80UybAZswHtdwd6Q0DqG
	tUzrZCOVVz1fm2sMTq4KdIZ5/LGExoMmcByD1M2euqi93NB+SYi5E8akR9J3Ehdae+P/1O
	5vVttUN/dywTqJjzwEMcAuTkiXRcU3U=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-oa4XuyVTPVGf_bs4RGH8Rg-1; Tue, 05 Apr 2022 13:37:28 +0200
X-MC-Unique: oa4XuyVTPVGf_bs4RGH8Rg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ll4Hc2ij/ASUYdG+I5fowtU3P+KKAQMbPpZVpe9fXw5bzH51kHYDjK2lUfv81Xn6etOg0QL9BmVcCvYrtb4EZ9Wj7jrs9ZSyR49Fq4OHwaedBp1vkwu8vNu7KoNc8Qx4nVhoaYfp4VZmXhz0f1iAKpD9ZNRDE6qnJRZgm0j7R8VdhrVD4Bm+zuwWHl4ODvqmv9nyEohffQXo5f+tqEqAMQk0IcJ4Ecb/Mk/Hm4wxCsKeEZtPBR0vuY0uOsSoteRh1I26087YiU/r9Sf/wLxxZ1NXwNDSNcv/6W5KWZOcNByyCMx/AJXqOniNeygkgGERE8wRwssxKKSPZk0qw2q7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGmKsp6V7WXhk3wwchpibv86sGI4JAZUR3CKtUo2MZY=;
 b=go6/E04EUwHmjPA37B26Sv6IZqCmvbdYlIt0+sbY47M2e6iSJzaK/8URqpjYHGmavZSNZAOKtkN4KRzCfCTMDKhMR8IGkweSmQQkBY7Hz4vrHQHIXuQ8C7FwJbYor09QubAxb3JJ3P8Nf+qgNClpQFEEejxI9ts2is3tRGM+BvxHoPhdLjXJC4fsrfNMPgSvwf2Q+u9siokPw5xx3BExsM/L7VrauGKGlliJ19fBQklh5kYT8TwWC6sQRE0JtbWWdZp4hJxySbrs0GHTnyn0nCDgf7lYcRz59eXA6D25qcuuWGfZgwv2dayjFa8+1yLNnB1D9szieYsktKiz1zX0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5272.eurprd04.prod.outlook.com (2603:10a6:20b:5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 11:37:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 11:37:23 +0000
Date: Tue, 5 Apr 2022 19:37:27 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v9 6/8] mptcp: add bpf_mptcp_sched_ops
Message-ID: <20220405113727.GA4058@localhost>
References: <cover.1649037838.git.geliang.tang@suse.com>
 <31b426d5e4d7ccb318ee96f122bc1ac0421d5162.1649037838.git.geliang.tang@suse.com>
 <6d9a111-77a4-e693-df67-a18e873e7c21@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d9a111-77a4-e693-df67-a18e873e7c21@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCPR01CA0009.jpnprd01.prod.outlook.com (2603:1096:405::21)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d8a32e4-008d-4e23-5137-08da16f8a6b9
X-MS-TrafficTypeDiagnostic: AM6PR04MB5272:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB527275A4CE7E117C2E786B56F8E49@AM6PR04MB5272.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ABxXAx5bGEQtf9mbgItD+nk3y/4O0L0o1pkCFBMd/KYjuytE1L2KmIonjF+IFQXZ0k8AHJFes6so/Q+2mAWL7pSwSBpAM+Di80MtVrPTRaGXRALHY4YliZpKn5Ix3YI+WLnCS3b+EaLF5BBFfpiiLu/og6pMOZTyq2mPFFMqLmB2CiUOyX+2NB5ZQfLvlQzBGFQ07d7yodBRDMoceOkFv5SQW0RG/5uWSI9yXLurhhT/SQRjIEsAKTwz3T+c65pV1NQapAicjZs3I24BveHK4iBbTk68RfkbLT8cabRKUQ8bXnIF7evYcRqI4nCgazHe2Dy8JqGNRoOh7pdixzWc4hng6wbF/8vEdY7wACs+/tXj6ytInugDHIbEJ07mglRcNvsdUsQkjdCNNaThU1NztrhwoGXRCUYBn8J6kKR3mr2FtmwHeAC2uTYR+yHXbteYOtZRM0J/5hnW6+HFS4iJZJ8ft6uH0u+ODKcib8l4hczHvQqrPTEhv4H0iLXGe505Pw18SGK4Gu6QjDfaNAPnOm+FNlWGL9U7zwpuclNL0F6gmmM7QVLIou9ByCCyMPJTfQaE1EEH7IdL7op1Ksdfn87LH+2mkRw0dTULF31TSVQ+B5swacvOj853tMpVwq8I1Q6A0TtHly84KRZ9fOvpTbVtyVZXG7hrQiu3GG7H8A800nKVtlPB1ZSz01s4mW7D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6512007)(4326008)(8676002)(66556008)(5660300002)(86362001)(9686003)(66946007)(6506007)(6486002)(33716001)(66476007)(1076003)(2906002)(44832011)(508600001)(38100700002)(316002)(83380400001)(6916009)(186003)(26005)(8936002)(33656002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AzkN0lj4eirEIs69al872059hAcmc+dq4KI4Tsh81aCZDhiW3KIZUADYGdA1?=
 =?us-ascii?Q?Nz1MM7YjHPWL2hARdeItLB4aOdXb4dur4iS3zHPBybxIaLaBTiYOd+gClpjS?=
 =?us-ascii?Q?zjDPZJlmKwzxUaHh3cjRhu6tf6cnik2gYWk8bnfzcaJlTs8HmVD0clolYoRv?=
 =?us-ascii?Q?mxFIGb/Tep47pvQqhDAH10oKwHYFcyOMcC51VRnnB/3lpjlyc4UhvE1ss7ho?=
 =?us-ascii?Q?gQvCy1eSIGv0EnDyunwqvJLllY9UqfTzyZkWwtkEzRjSiWhGPRy2YUEEFMgs?=
 =?us-ascii?Q?B2gFDiHDvSYrL6wgfgyaAnW5hd2WLyZsVQQo+1kgSKT2w+MAO1RJxNd3jRJU?=
 =?us-ascii?Q?j3x/AwC84YahksWTR8hSPTiMUO+bAXGzG/Bt1qYcmoZE3Zy8IRBXPmaFMJXk?=
 =?us-ascii?Q?2syYhgYnEkqzeve9ScadFA2ktno8oiL7Xtyor55WzHXTMDeVXWf7r8OMLjJG?=
 =?us-ascii?Q?9ny2zw8jThHqEbdJTB97Pw23TygWfdZ5kJEkmUxZxANP8L6wPWbYn5kPcQkl?=
 =?us-ascii?Q?gHm4Rk2Kmqzk5CG9xqYDty6cJOR4HGrZfug8g+dMR45sNXVMlWtP3/aJBYvn?=
 =?us-ascii?Q?RFp/fWPKbe1luNtYBJjfh8t3jMYdB7wtFD9l5p9/pwoU/R/DOm9XgVS+5pg+?=
 =?us-ascii?Q?fDxR9VcrmUU7itGLsitKR775hOPz55p9NTd61opS4fW6lSiavlQIqcA3swiU?=
 =?us-ascii?Q?TCU0Pcx37ugo/aDgsW8d7IkS194b1Ck/g/vSVcgKD4rELBuuIoOU2RBtdDKs?=
 =?us-ascii?Q?bxYDgxRpCWyNW5LmNz7vPMuFkUl82K21EATjlTPMJpL+GPilfyoAayjEj8M4?=
 =?us-ascii?Q?HDurzcc4ZDt4iiXY88fwkFBI2MNBhLG05nGeS9jaK4JPZq4QYeOJBC3zT/jr?=
 =?us-ascii?Q?rwiACIeJpvORQ5oddV1RvkoNdhIb/jlB3C3DNxjmC+YSIyLtBmQPrdBUs90S?=
 =?us-ascii?Q?5Jxw9J4LYPEu4IzS7ZqAyjDw5R6i49uFEMwg/ChaKTn8uVc5L6oMPl60NfRm?=
 =?us-ascii?Q?9JUqKwiUeoTt3zuigYolB6v9ZOcehpInakwmTOGGL5hGCYozE81F9g72769w?=
 =?us-ascii?Q?hHVvKhCjekIYaE+FNg10270NUwANWk8Jh2OIFF6UzCXHJWu8OIU9rV+IRLJ4?=
 =?us-ascii?Q?H8MwUL138+DFDPAX7ksRJUKQajFs9D0anw8C8jUDVgMe5QD8OAwyere3+00r?=
 =?us-ascii?Q?eLudaKGSx3FK6in/+lHZQBHzqfaZ7CnNFN1ruhDhQrXjTqlaMVotJth+bt+T?=
 =?us-ascii?Q?cfSImw4QXGT+hsXAJa/zTMBnQdwZ1cqfO3lZoRpmFIUqSzyq0C/5JgmMEbKO?=
 =?us-ascii?Q?5RPReo0fVJnpmn9javPOEjyHDkmTMeKfROldRWrcW5KPOhQRBOVSIJmJ6dUc?=
 =?us-ascii?Q?pSALlvnuoweezw/TBdvX3Ohf1Uz63/PylWN7r91IJazLD1pqREskBr6YnSN0?=
 =?us-ascii?Q?FPUFT/zsQ7WkF/s8obX7uufxic35OJ/VmE4/gZsUah2QbBQyWnRqvW7zH9ix?=
 =?us-ascii?Q?X48H/EwiJH7NGlF5lZk6Z9Vftgo/ZxRsl0L27Q4NRBlKNnzVdcL9RginIAcl?=
 =?us-ascii?Q?Xf/9SW6qDqOkQzeJm/Adga7a7Db2Opa0ED6kiWQS50dBFFlTE1rq9UC5vOKD?=
 =?us-ascii?Q?9bEg7XFv1cNELX9Q1gH17wFRsxPY0KTcjA+iABroAO0AuLSCqYB2Jy2D8DHJ?=
 =?us-ascii?Q?a7K47VmN/iA2zJSe1PfCIiW4VtOlmntYd2a9f7G4vVKCAFxtcrGIKXfnN7v5?=
 =?us-ascii?Q?U8+Np/zACb1ex9x682ovqWKpyU5VNUA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8a32e4-008d-4e23-5137-08da16f8a6b9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 11:37:23.4490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19zJt4Wu0QBO/7py6D4HTm4jyvFCZWp/yq20jIJOjRlKRP/Qr/qRei4h1f4mfCT6OW6OitsNMriyJxAnDNX1iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5272

Hi Mat,

On Mon, Apr 04, 2022 at 05:29:43PM -0700, Mat Martineau wrote:
> On Mon, 4 Apr 2022, Geliang Tang wrote:
> 
> > This patch implements a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
> > Register and unregister the bpf scheduler in .reg and .unreg.
> > 
> > This implementation is similar to BPF TCP CC. And some code in this patch
> > is from bpf_tcp_ca.c
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> > kernel/bpf/bpf_struct_ops_types.h |   4 ++
> > net/mptcp/bpf.c                   | 102 ++++++++++++++++++++++++++++++
> > 2 files changed, 106 insertions(+)
> > 
> > diff --git a/kernel/bpf/bpf_struct_ops_types.h b/kernel/bpf/bpf_struct_ops_types.h
> > index 5678a9ddf817..5a6b0c0d8d3d 100644
> > --- a/kernel/bpf/bpf_struct_ops_types.h
> > +++ b/kernel/bpf/bpf_struct_ops_types.h
> > @@ -8,5 +8,9 @@ BPF_STRUCT_OPS_TYPE(bpf_dummy_ops)
> > #ifdef CONFIG_INET
> > #include <net/tcp.h>
> > BPF_STRUCT_OPS_TYPE(tcp_congestion_ops)
> > +#ifdef CONFIG_MPTCP
> > +#include <net/mptcp.h>
> > +BPF_STRUCT_OPS_TYPE(mptcp_sched_ops)
> > +#endif
> > #endif
> > #endif
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > index 535602ba2582..647cb174d917 100644
> > --- a/net/mptcp/bpf.c
> > +++ b/net/mptcp/bpf.c
> > @@ -10,8 +10,110 @@
> > #define pr_fmt(fmt) "MPTCP: " fmt
> > 
> > #include <linux/bpf.h>
> > +#include <linux/bpf_verifier.h>
> > +#include <linux/btf.h>
> > +#include <linux/btf_ids.h>
> > #include "protocol.h"
> > 
> > +extern struct bpf_struct_ops bpf_mptcp_sched_ops;
> > +extern struct btf *btf_vmlinux;
> > +
> > +static u32 optional_ops[] = {
> > +	offsetof(struct mptcp_sched_ops, init),
> > +	offsetof(struct mptcp_sched_ops, release),
> > +	offsetof(struct mptcp_sched_ops, get_subflow),
> > +};
> > +
> > +static const struct bpf_func_proto *
> > +bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
> > +			       const struct bpf_prog *prog)
> > +{
> > +	return bpf_base_func_proto(func_id);
> > +}
> > +
> > +static const struct bpf_verifier_ops bpf_mptcp_sched_verifier_ops = {
> > +	.get_func_proto		= bpf_mptcp_sched_get_func_proto,
> > +	.is_valid_access	= btf_ctx_access,
> 
> Hi Geliang -
> 
> I'm mostly comparing this code to bpf_tcp_ca.c to try to get a frame of
> reference for how BPF works.
> 
> Using 'btf_ctx_access' here seems like a less strict check than what the CA
> code uses. bpf_tracing_btf_ctx_access() has more constraints like only
> allowing READs. What's the reasoning behind the difference? I want to be
> sure access is not more open than it needs to be.

I agree, bpf_tracing_btf_ctx_access() is much better. I sent a squash-to
patch to fix this. I want to keep the accesses more generic, not do specific,
additional checks unless we need them in the future. So I uesd btf_ctx_access
and btf_struct_access.

Thanks,
-Geliang

> 
> > +	.btf_struct_access	= btf_struct_access,
> 
> Similar question here - bpf_tcp_ca.c has more strict checking.
> 
> - Mat
> 
> > +};
> > +
> > +static int bpf_mptcp_sched_reg(void *kdata)
> > +{
> > +	return mptcp_register_scheduler(kdata);
> > +}
> > +
> > +static void bpf_mptcp_sched_unreg(void *kdata)
> > +{
> > +	mptcp_unregister_scheduler(kdata);
> > +}
> > +
> > +static int bpf_mptcp_sched_check_member(const struct btf_type *t,
> > +					const struct btf_member *member)
> > +{
> > +	return 0;
> > +}
> > +
> > +static bool is_optional(u32 member_offset)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(optional_ops); i++) {
> > +		if (member_offset == optional_ops[i])
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +static int bpf_mptcp_sched_init_member(const struct btf_type *t,
> > +				       const struct btf_member *member,
> > +				       void *kdata, const void *udata)
> > +{
> > +	const struct mptcp_sched_ops *usched;
> > +	struct mptcp_sched_ops *sched;
> > +	int prog_fd;
> > +	u32 moff;
> > +
> > +	usched = (const struct mptcp_sched_ops *)udata;
> > +	sched = (struct mptcp_sched_ops *)kdata;
> > +
> > +	moff = __btf_member_bit_offset(t, member) / 8;
> > +	switch (moff) {
> > +	case offsetof(struct mptcp_sched_ops, name):
> > +		if (bpf_obj_name_cpy(sched->name, usched->name,
> > +				     sizeof(sched->name)) <= 0)
> > +			return -EINVAL;
> > +		if (mptcp_sched_find(usched->name))
> > +			return -EEXIST;
> > +		return 1;
> > +	}
> > +
> > +	if (!btf_type_resolve_func_ptr(btf_vmlinux, member->type, NULL))
> > +		return 0;
> > +
> > +	/* Ensure bpf_prog is provided for compulsory func ptr */
> > +	prog_fd = (int)(*(unsigned long *)(udata + moff));
> > +	if (!prog_fd && !is_optional(moff))
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static int bpf_mptcp_sched_init(struct btf *btf)
> > +{
> > +	return 0;
> > +}
> > +
> > +struct bpf_struct_ops bpf_mptcp_sched_ops = {
> > +	.verifier_ops	= &bpf_mptcp_sched_verifier_ops,
> > +	.reg		= bpf_mptcp_sched_reg,
> > +	.unreg		= bpf_mptcp_sched_unreg,
> > +	.check_member	= bpf_mptcp_sched_check_member,
> > +	.init_member	= bpf_mptcp_sched_init_member,
> > +	.init		= bpf_mptcp_sched_init,
> > +	.name		= "mptcp_sched_ops",
> > +};
> > +
> > struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
> > {
> > 	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
> > -- 
> > 2.34.1
> > 
> > 
> > 
> 
> --
> Mat Martineau
> Intel
> 

