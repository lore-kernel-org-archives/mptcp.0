Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80071.outbound.protection.outlook.com [40.107.8.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E495E15A8
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 10:37:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYXCaZiobJZOJbpgWiptMoPc8DrDYUeVpRxdxP5A+TrFfQdDQJSFAVw6ObiMwbzCT6h6qf/Q15i90Y8aXiqI/Kbb54c2EiesPZtXGTiE2c+PrimAa76WyDQnlS5/WXg0i51oJMjDy2LaNDL85Py64vUC8ZgS9t8d2/lBdUN482kR/34gmIoZuKQzygjTJej8lp8uJh1BLh9OZ3xqVM+d+71XfpOg7cT5XySlJj0MGTxzuKrF/Z04C8HLaK2fLMT57rlTxSUIyoC0omYQzHt7ufSwuGdYAtvEsaSf1N2E0q3HtY3Clg+AN5P3hVDJVGXkBqEqGuP86xZBLqng0YQiRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+jhyo5EZo0VWBYZAnixwlZK3istrO65GahkGCoP5oE=;
 b=jqLrSPR7R5GQu+ioRH6hp/d5Q+URopN6c/3Dn06dYxRdYWMVmWVI0sQXfBwyBsTv0I/9nNoj58obhlRIso4grLM0iEe7WvYgdHGi6i0DnA5kT408Nrptthf1djg0Rx77fYdBmYBFvkMACbTnakpOz1Ed9R3uf0YM8fg+ELmcb/bE4grbR614VbJxXs4WfkFTl1hGcXbCv1g696SRFM/Y0EAFucuHpT6S3LvSo9N/PfIu2IJR+xWBDRW7/YnKHdvP9QRoqreaI/eLK25ETz9fE/zn0gtTPCyUfudTnk9bMmXUNeEa1LLnAQm7ZrhhEnvSV69IC9TdgUBskBP2TVp12g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+jhyo5EZo0VWBYZAnixwlZK3istrO65GahkGCoP5oE=;
 b=K1kJIK49ss77lOfqo0mzp9wwsOlgQ5VJJPICNvU0t88PjL/de3tZe9pIqvv/fd1dgCyC0JtwfJzWaafkHyZ9dlH7zj0TPAH6O4fD6WcFpPw8tjrN8xYZ7rTTlP+3jk/109c981qGMgDZN6GpcwznRb6jhLytp8yqZ/E19OyheWWISspiCUIS5T8XEFuGHNMqGmFkhiNYmxJH1aCL2/1Muq4X8b+N+8kP0A6X2uHDRx14F4DII5MfGi80KtO/6Dqniiw9lDjIK9RnPA9Fg7o6poBjwI0ti9wE4ki7s/w7RWqcQtmVn2u9XlhOeh/xVHO+TUc0HtRsXQHp8YoGY+MPtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7905.eurprd04.prod.outlook.com (2603:10a6:20b:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 10:37:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 10:37:02 +0000
Date: Wed, 12 Oct 2022 18:36:51 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v6 06/13] mptcp: multi subflows push_pending
Message-ID: <20221012103651.GA15335@bogon>
References: <20221011120137.5475-1-geliang.tang@suse.com>
 <20221011120137.5475-7-geliang.tang@suse.com>
 <d2926dc5-f72d-f104-d982-78215924d96e@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2926dc5-f72d-f104-d982-78215924d96e@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:4:188::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: d61fbe26-3630-45f6-f4ad-08daac3db2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XeUOHKt2FAqxQxkLeLUD9Qi8IoS+diXjCDhCcwuk7jZgRE3ERtXNiqC+T4LtJnK/CboxN/ZN+AD66kSJJ4uztguFhpQkqg/ZZxQajyxB61gEacIXneBs3cf9h0xAZg2S6i8Y/JwNoQreCxDHi/spd8jORXXvA36dAkxzYIvGvR3FnQpI4Ou4zlt5qaTk6zpobb0n7rELtj8MYDUAFsl8s04PyWw++XDwk5/eyJP9QD/msVnjDD+ujbPABvqXpH/hu0Otq6pX2Lmo1Azku08xUgNcvfI5qPF4+uoFbXou7H9jE/bnQyCikPw0eLQPkLOTQvXShCxwg5q/YwVXBBDUhF8IAGSTb3FzYYUbWvsi96Ko56PR8q6/yPXpcSuT3dtokG/KQWFoc+hf8/XCxsKtQfKJ5G3ohUoa90NW5qWs7pWakSJI9JP+nZShBaMOlF/XBN2jdvCDIN/1jFDcgQ66DnGgRy/vqRt7jKEPh7FZ5ZI23aPpUxZ9rOeBZ3Wlek6SwY+yi9HVZAj/+Zd0jCFJJ2fSkVQlWvPtMUshiFzNQaN6Xnb5pjVoCqz6cxu2EdB0JHNECPq3hBOwYlHiQ0LSpx8cXgLJnewN0bjCm40u23g0mdqaIYVb0ZbhVKZGOyYNRjWwTLzt/9DfrVnA/bhVmP0NUw1UXue1DRFpsoNgWIsQ/MHslgw+I6wgrvW3B6zaYsPEUtgcx2cPhepo29LP4WGJTJyfZrGom3RcsdFmjrE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199015)(1076003)(186003)(83380400001)(8676002)(26005)(5660300002)(38100700002)(6512007)(4326008)(41300700001)(33716001)(44832011)(6486002)(316002)(6506007)(6666004)(9686003)(66476007)(66556008)(66946007)(8936002)(6916009)(2906002)(478600001)(86362001)(33656002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zEH1I2J5um8CxQvr6QQGirLbQ6wC975ccUkaPty2ew61fhkXDqmUP0TfpOkA?=
 =?us-ascii?Q?dHkDHLxug23oGZg5Rv3Kz7zNeeLKrOBrwMYu4MFRqxocY0LSjmpo3QBdccfh?=
 =?us-ascii?Q?71Jx79l6hKNquWwxK1tQ5XWHU71LbwuWqzptivuOnqYBTe3jG1dK1brPENzQ?=
 =?us-ascii?Q?+8TUYmPlJvuscN0BsWkRzlPLV28TZK5lNDUmWeorrggYSOxD1r33hRpkzho7?=
 =?us-ascii?Q?+H2bQ7GFIs3r3OF2TWAzK9Ief9lW7qFLgeEuJOfdjzmAuNs2fQ/fVlGf/+kH?=
 =?us-ascii?Q?NKvK4a/Y9WB+/RVOIPcZpFqoJMvG5h3QPlHyOAZxKUtBo201IKahV2uCYLIg?=
 =?us-ascii?Q?Gpnb8pLFgrhC3pQqa7WzzMBHBHqDW8Y7rX2cRskb0k1aizPNuWMMxaYtVuO0?=
 =?us-ascii?Q?cp37xN1sbhpRU7X5kqGk3jgzjxK1BhjBdlEVEN1xziQLFD3T+AhMS1WJiGqB?=
 =?us-ascii?Q?GP0m9sOL+eq1NePJBnSoWa3k8SqMoTJ7XW1BDT9JcGHl70Gk4UzvtxRqS0LH?=
 =?us-ascii?Q?PflAUJLHU2fsphxrQjzfPavSxADbHL9iGGxP1kk5fGjA3b71VHdSbJA1aL5f?=
 =?us-ascii?Q?adIQqY0I2okxtMOuZb32PRib5A5+y+tX9kTy9/nNgbzXSIPMT0qlWv+GgTN8?=
 =?us-ascii?Q?ckadjMQvCH91qO2InRVBg7aJpV7L81864uNZ5Kgc/cw5yCYDYGyF/V6IttGC?=
 =?us-ascii?Q?CMF7kAHaH2Uyw5/yX5zUCsS7R3+dkQP3e9BB+4JC4oRMRtE4dXq8vB13gRti?=
 =?us-ascii?Q?tAOSjUxX/oVmtqBOHZhrH8cxMOEWNNocuCsUQV6wyRNeW/rFuzOEsLZ3M1TY?=
 =?us-ascii?Q?VGkVJhWFfIAYBseuSCEnVCcWNsl6MaUTytNYNzaZEH2UuXeiGdbeqdJ/Putz?=
 =?us-ascii?Q?xTSk3mnY7Jl0gd2hdxwaP+FT2Kn3nZxXQLZvoCNB4oa0OtdApuL2itmZtPSi?=
 =?us-ascii?Q?jnheaje/4LpStBWmqzgsLwAWFqvc6iTVLXabqDEWIgSA0uhHrBxVXNIrcp33?=
 =?us-ascii?Q?4pLs4pIpIkkH6mYtxH4Ne1y4SuknAdGVZm3SlnCqkOvGMFirpIz/veCi2DZK?=
 =?us-ascii?Q?+aPfxjtNa1dSEroLMJLXpVRz1cze6jp7odmCxnTQCMcNACgGQoXgDKdmWkeX?=
 =?us-ascii?Q?3zrmNDpYjBfShvBfbFavex/TxBgZ1cEN3r0IQkYxXC4WK9fgh66qfgBZGO4M?=
 =?us-ascii?Q?WRx7fbqUVOu/CtaNZzP1KLPOecyMm8zldt6bANLmuz1AJjVysokbx/S6NCDj?=
 =?us-ascii?Q?zhv4xON3BCXggwQL5rxgPZTzUvCUOdPcMd4tH8Ll7TXe6SMBG7wViOpQfwEc?=
 =?us-ascii?Q?Uuq4KfS8vuA0OObs2pVWv6sMBAxs0PLiK2CelnZ6MinIVjiZKTm1jkIcQkmK?=
 =?us-ascii?Q?SblbXo2rXuAtcO9zEfoCdjwy7vIwoVBP8w1uOW3ATquK575GLfJOgEaCwnpa?=
 =?us-ascii?Q?NVxZINEDcgh+uVu7PvSAL3gpiTOcViRkoBxx/H8QGzBsHBuRzbHESfyCyOVY?=
 =?us-ascii?Q?qoTFv1krPjr4bwoXkghIaGEOr039twn6FrdRTAoOnTUQeYTUw0KS/ACcG7ur?=
 =?us-ascii?Q?Tpgb+5P9/e+043eEZVK2m184RO+mjHsPQyKD8pkji6kdTN48O/Hi9Lgkseum?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61fbe26-3630-45f6-f4ad-08daac3db2af
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 10:37:02.1110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBWvpjmDptLo8kPrAIH1hFsAJj2iKM/I9yXxfo75cpZEn9Inja96zeNNbaWw/Hdoyua70hqBbvaPzjguRjcGLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7905

On Tue, Oct 11, 2022 at 03:30:43PM -0700, Mat Martineau wrote:
> On Tue, 11 Oct 2022, Geliang Tang wrote:
> 
> > This patch adds the multiple subflows support for __mptcp_push_pending().
> > Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send() in
> > it.
> > 
> > Check the subflow scheduled flags to test which subflow or subflows are
> > picked by the scheduler, use them to send data.
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> > net/mptcp/protocol.c | 32 ++++++++++++++++++++------------
> > 1 file changed, 20 insertions(+), 12 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 817e539d1d12..86ac38d10bc4 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1561,22 +1561,30 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
> > void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> > {
> > 	struct mptcp_sock *msk = mptcp_sk(sk);
> > -	struct mptcp_sendmsg_info info = {
> > -				.flags = flags,
> > -	};
> > -	struct sock *ssk;
> > 	int ret = 0;
> > 
> > again:
> > -	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk))) {
> > -		lock_sock(ssk);
> > -		ret = __subflow_push_pending(sk, ssk, &info);
> > -		release_sock(ssk);
> > +	while (mptcp_send_head(sk) && !mptcp_sched_get_send(msk)) {
> > +		struct mptcp_subflow_context *subflow;
> > +		struct mptcp_sendmsg_info info = {
> > +			.flags = flags,
> > +		};
> > 
> > -		if (ret <= 0) {
> > -			if (ret == -EAGAIN)
> > -				goto again;
> > -			goto out;
> > +		mptcp_for_each_subflow(msk, subflow) {
> > +			if (READ_ONCE(subflow->scheduled)) {
> > +				struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> > +
> > +				lock_sock(ssk);
> > +				ret = __subflow_push_pending(sk, ssk, &info);
> > +				release_sock(ssk);
> 
> Geliang -
> 
> It seems like this doesn't allow for redundant transmits, since
> __subflow_push_pending() updates msk->first_pending. Did you find that
> redundant sends were working correctly (maybe I've misunderstood)?

Hi Mat,

Redundant sends are not support in this series yet. It will be added in
this __subflow_push_pending() function in the next series with the
selftests patches.

There are still some issues that haven't been solved in the redundant
support patches. I'm still working on them.

Thanks,
-Geliang

> 
> - Mat
> 
> > +
> > +				if (ret <= 0) {
> > +					if (ret == -EAGAIN)
> > +						goto again;
> > +					goto out;
> > +				}
> > +				mptcp_subflow_set_scheduled(subflow, false);
> > +			}
> > 		}
> > 	}
> > 
> > -- 
> > 2.35.3
> > 
> > 
> > 
> 
> --
> Mat Martineau
> Intel
