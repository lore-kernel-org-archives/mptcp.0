Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200AF7C
	for <mptcp@lists.linux.dev>; Thu, 26 May 2022 12:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653567476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z7FyI/CKx86nNnowk99lSwpBLM5ZFFULNNiqqPY8gNc=;
	b=BgfnDBsgfKZexC1iJJMaElG9UULqf3j1132kYrEucZ64O7aGGzz6NsoTcO8+U16QFKwxaZ
	pE094afh99oxmdtk1/+cyd7+4gwNN3OkT6AaQQVgbU5hChKsSzHLdV32ZuRnVz4DGqEntC
	X3vWF0bBu5L52W+31bmmKCzsxf/3s+k=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-awXnxH1IO--_weeM2zxUEw-1; Thu, 26 May 2022 14:17:54 +0200
X-MC-Unique: awXnxH1IO--_weeM2zxUEw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5e8BaH7DaXZJxtnAKpKHQN4/5pVQv2SyIhZRqbN5JGYn1WIL0AaQMM8+jAQNZlPjZXEzyDpeFS3urTsc3owmisyEMxv7kngbeuEpebCgwN0tBqqLWhNJAS/lIZT2Z6Oy5deN/PuTBGSReCSPmzcTCbAGSPd5ZvGEekgxv94yt2KDr+uUzqZ/aoffD/OFVqRSDsHGtA+X6kpjIgELS27/gcKTM9Tw/VOWxXPUaDZFv3xSP3HL37oTjIL08x9KUK8PGyKVbX9L2G7HlKX/+Z4u8usyTemuIP6bcI2p8XqTfaqAAGxxF2jpJppf5i3Ruk60pa4eC4bn9uqaQEVMtGGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7FyI/CKx86nNnowk99lSwpBLM5ZFFULNNiqqPY8gNc=;
 b=SAz5qNs8vYSI0nm/JN55HMiVzV8y5Q2Pd8+PHoEmcrNgLl6JGZa7iuNT+L0gGQScQUd4bx+rYonmOy/AC3QAgbcr/Ko4mqPsxIvO1ij7I6eseKhYgWAGHbnx4efFlLiLQKj8HTny29P02R8hbufWPNKyu+nTXNKsUWCYVm1SSJoWX/bMoafBdx0UShkbbqmp6mkK835lMFrDm8JWCYIdqjjJNLpj38QBg7JXi/samk3LsPJbYtfh0XMCiUaXFs4CvVekoekzYm/YCuL7TVIx6IUhy3UDo+NP+Fv27Qzr2CNzO9+oLaFxoZTUXD/OgfhtbD3w25UYZZ1AmKjnSKqvWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7299.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 12:17:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.022; Thu, 26 May 2022
 12:17:53 +0000
Date: Thu, 26 May 2022 20:18:02 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 3/5] Squash to "mptcp: add get_subflow
 wrappers"
Message-ID: <20220526121659.GA2665@bogon.HOST>
References: <cover.1653305364.git.geliang.tang@suse.com>
 <e0034f846f86901bd0c996bca6693c4036602750.1653305364.git.geliang.tang@suse.com>
 <294011b7-28d5-5549-c138-e6e674b18b9e@linux.intel.com>
Content-Type: multipart/mixed; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <294011b7-28d5-5549-c138-e6e674b18b9e@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2001c697-998b-42e6-098c-08da3f11c209
X-MS-TrafficTypeDiagnostic: AM8PR04MB7299:EE_
X-Microsoft-Antispam-PRVS:
	<AM8PR04MB7299A1C8BBDAB0B246F6BC32F8D99@AM8PR04MB7299.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ooY4TmAe/q2A75S/tzYEIrk8Q0uzTJf0tC4kZ32VUxqryTinVf4sjrhtE2xxZNPFfY1eL0YR/JjWRIJc9SuvxYgYbak+puQlRWK3l4asveMFFks1eImKMR1vzyVUAu+XWm+ZyyIa//1zya25pbPmAdI+tjH3A+9lw3c73za428kEKsMCGGE7EOI9j2E1RFLBvue8yTPL9ErMNljqc8yo95JQyvmWmvY1B76RxCk7cGV69J9dMYE5FjM2c3IWqgRiFhRgqVc5QU0m8jmkONUBXXRbbpt5sCgMlICBOPF1mEJaUqiCOnIN3Avwer5G07sWWg4EoPQV2SWXOLMkw9xLZZIBUJf3UIgaY7uGt617wi+d6kpK791HbNpfpC+PXwGFOh0jRgdb9XI7gJVrU1F9zvvXnDOyC+C5FQf7ivpzKe0Kt6Dma5q7fkm6HFif/XYmakj6gLFi25KyqscCqNTORD6xw2hxrJ98DhDkUDG8/WmkMVamvrwF9NC2SfR3P2vz2gL5PtU9VBjfyxLKn9vKRROvB95/PApwEkUWQFWvp0LqZpYanI32tFZLhZawe8/GspLiUJgl+dFl6gVP2exv7N0K5pVYm/hFLJ0xjKh1yu4rdlKeENSyJyjoz5WTie7DI4CvreBjRfWSvrgP+hRz6keRrM1poDVpwFXHL97DGQWCJ0UkJY0dW31Sm0WBtNYWxWG7vmTkd0/s6Q6VbCt/TMSa+YyReZPi7dRBqsnUk3c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(9686003)(38100700002)(6506007)(44144004)(6512007)(44832011)(235185007)(36756003)(5660300002)(33656002)(2906002)(8936002)(66476007)(66946007)(66556008)(6916009)(86362001)(6486002)(316002)(4326008)(508600001)(6666004)(1076003)(186003)(83380400001)(21480400003)(8676002)(13296009)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gG+18Y4ZSnEf/Y4lk0OhpqquTWjg4O/JrOGB5Ywt9DVnbQLJZgSDghTjwMjN?=
 =?us-ascii?Q?mK+1ztIISwHO4PDTS0iAKNrXDDio5WHizPyKfETEocA3kSbKD/0CAvJMDsB/?=
 =?us-ascii?Q?fHSRxUElPr98LNP7i5x+LmWUMo9FDQLGqsMFI/Ppz9z8v7EZzpSsHSU/2bQx?=
 =?us-ascii?Q?27W7fMqeKo+krt6bOrx5PcawnWbhYhkfJGphUOafFytr6+PjEPZ7vYNyXlJO?=
 =?us-ascii?Q?+i60lBLXCjN3c8quO6ZiUHiqFCvRVqdEy222dnE+F7haCnvskagUUJf0gBzX?=
 =?us-ascii?Q?lPOMFYS0pHNWQILhfsp5SPN5KnqsbQ18RQ+jCzXuIhNcJaYnjltYRszuLjAu?=
 =?us-ascii?Q?uAOcK1bGi2lOtij+LqsVpUqzB2VN0PNJRjoTj/lWk8enG9pi39/hCPwd9SH2?=
 =?us-ascii?Q?8ML5TXf7INxb5nAt9Goc4/5zRyE7QU6d1QIGQ2vlazEPbI7daNDpzyD1NGoP?=
 =?us-ascii?Q?6yG20T9I7w/W5S0lG3pZ3fu2QM7NOd9skNmeDBbdiMmSZ9DOqMSzlkVX6PqO?=
 =?us-ascii?Q?Em3ZS8Ci0hjURI3DB79wXVbjDfmDBHKuWhi3bymteD8eo5sh6bQEt4g9Kso+?=
 =?us-ascii?Q?YscFTwcjsonTdHm+ulEZCd4KHIQhPvOztmv5yFgaZNX1g1ZTk/qlJxKnwHvt?=
 =?us-ascii?Q?smoMcmETh93A8drH3GnzBdI7kKf7yo7MzZbdy5wqd6sZTRtLyN7hLCeGg4zf?=
 =?us-ascii?Q?NJpKz9iUgGHTvX8jyRBqKiXu7mkIkt2mwxRFPV16BT+bWLLjeylq9rg4e7ia?=
 =?us-ascii?Q?qu7/p9S96pf0tJlAmAMXMkULOe0/Vz0aoOuIN3cqeO6DkPyOMzmVl/pY/9cI?=
 =?us-ascii?Q?E69Pa3c4l85p1lJR+u/0Kfjdqj1PprgNo9eTmE50gee0KwnjQhXEg67lei2d?=
 =?us-ascii?Q?GxDWaS3LW3XOBMuUZh5ci1vfpfgyWVRB13DkgnyU0Xn2lT1jKbch8gp1bMJf?=
 =?us-ascii?Q?1h0S01tdL8QoSLny9K2lxhML3bFGLdbXP7VGNhB6DvoMLhAdW+eTUBEYtOFK?=
 =?us-ascii?Q?oZYrOnGm0cq0ZkrKJQUo6m76bcM9EddbtN7poUujr6nFGpOnF/facNwICp4b?=
 =?us-ascii?Q?Xmi+Z81xr3AG4oEkqmu3bnV4zU+fsca/EBaPVIhQjdRqQlwhCic8tX6YDUOW?=
 =?us-ascii?Q?RSknnMOE47G7a1PXOjeqk+Zev00j0BtsTTKMG9iqILwNrcWVTQ5tDsSK9QT5?=
 =?us-ascii?Q?z54I4mhKWk4xDVF0e3XWHQ9wxMoPJYWWAw6uZHMEj6KXmO0kvh3Ct3pXyqmH?=
 =?us-ascii?Q?NcRfs24Ae5s5jQVjO++5Yci32KPtECUq3hs9NEFru4pJP4oIzAGEBB+Q4Zfc?=
 =?us-ascii?Q?GZ+YkX6DbEUeJ3tz7qa4Y0Umltb42Vuy+3baHxqkCTlFADXbq+6+V5J5qfZu?=
 =?us-ascii?Q?bFU6hSmgwhqt9oNr/4QqTgMnEnLncghhllYN7+x9nyf8aExiNHGQWh/tfQgd?=
 =?us-ascii?Q?PNHmGhaJY8Jr24ezngBWcjluTz5eBl+0t4MVxvC5y6MJCvNa2oFrqJoNXYw2?=
 =?us-ascii?Q?Xrcnw66rg2GAFW175AgTF4Zsy55eoPhfox7IqMciZ6kgX/xubMgjxZSucIWf?=
 =?us-ascii?Q?eKXTOhKo18qOmkYyLao1ytLxE+P16JHsN7QNI4Yjwp6H6qlgP3l25GDkCr3/?=
 =?us-ascii?Q?IeytK/tGboFKgVW+XFmi6yYa32zw2Cgb+I08gkHGGA2KFkEAN0lM7VMa/PNq?=
 =?us-ascii?Q?aOmB+jEQIAH00rBdY0yY4MPreGnOM7twgnTxBWH5nOBYR3PeVUTscMlq49sQ?=
 =?us-ascii?Q?0Qfhu/dKL4kYVf/OLDiw2wI6n1txpBU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2001c697-998b-42e6-098c-08da3f11c209
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 12:17:53.1837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTKQaVJUmJTWbGAn6dZ0600JtInvmqy8WeRDq1k+DPhY94VHD/RNfK6DNoz1IEvIxlAgmx6WJv+ov2gIfiygwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7299

--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mat,

On Mon, May 23, 2022 at 06:01:03PM -0700, Mat Martineau wrote:
> On Mon, 23 May 2022, Geliang Tang wrote:
> 
> > Please update the commit log:
> > 
> > '''
> > This patch defines two new wrappers mptcp_sched_get_send() and
> > mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.
> > Use them instead of using mptcp_subflow_get_send() or
> > mptcp_subflow_get_retrans() directly.
> > 
> > Set the subflow pointers array in struct mptcp_sched_data before invoking
> > get_subflow(), then it can be used in get_subflow() in the BPF contexts.
> > 
> > Get the return bitmap of get_subflow() and test which subflow or subflows
> > are picked by the scheduler.
> > '''
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> > net/mptcp/sched.c | 47 +++++++++++++++++++++++++++++++++++++++--------
> > 1 file changed, 39 insertions(+), 8 deletions(-)
> > 
> > diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> > index 3ceb721e6489..0ef805c489ab 100644
> > --- a/net/mptcp/sched.c
> > +++ b/net/mptcp/sched.c
> > @@ -91,8 +91,19 @@ void mptcp_release_sched(struct mptcp_sock *msk)
> > static int mptcp_sched_data_init(struct mptcp_sock *msk,
> > 				 struct mptcp_sched_data *data)
> > {
> > -	data->sock = NULL;
> > -	data->call_again = 0;
> > +	struct mptcp_subflow_context *subflow;
> > +	int i = 0;
> > +
> > +	mptcp_for_each_subflow(msk, subflow) {
> > +		if (i == MPTCP_SUBFLOWS_MAX) {
> > +			pr_warn_once("too many subflows");
> > +			break;
> > +		}
> > +		data->contexts[i++] = subflow;
> > +	}
> > +
> > +	for (; i < MPTCP_SUBFLOWS_MAX; i++)
> > +		data->contexts[i++] = NULL;
> > 
> > 	return 0;
> > }
> > @@ -100,6 +111,9 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk,
> > struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
> > {
> > 	struct mptcp_sched_data data;
> > +	struct sock *ssk = NULL;
> > +	unsigned long bitmap;
> > +	int i;
> > 
> > 	sock_owned_by_me((struct sock *)msk);
> > 
> > @@ -114,15 +128,25 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
> > 		return mptcp_subflow_get_send(msk);
> > 
> > 	mptcp_sched_data_init(msk, &data);
> > -	msk->sched->get_subflow(msk, false, &data);
> > +	bitmap = msk->sched->get_subflow(msk, false, &data);
> > 
> > -	msk->last_snd = data.sock;
> > -	return data.sock;
> > +	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> > +		if (test_bit(i, &bitmap) && data.contexts[i]) {
> > +			ssk = data.contexts[i]->tcp_sock;
> > +			msk->last_snd = ssk;
> > +			break;
> > +		}
> > +	}
> > +
> > +	return ssk;
> 
> The commit that this gets squashed too also ignores call_again, so is this
> code that just returns the ssk for the first bit in the bitmap also
> placeholder code?

Yes. Since the redundant scheduler is still under development and there's
still a lot of work to be done, I plan to support single subflow schedulers
in this series first. The multiple subflows schedulers will be added later.

> 
> 
> It also seems like correlate the bitmap bits with the data.contexts array
> makes the bitmap require extra work. What do you think about using an array
> instead, like:
> 
> struct mptcp_sched_data {
>        struct mptcp_subflow_context *context;
>        bool is_scheduled;
> };
> 
> And passing an array of that struct to the BPF code? Then the is_scheduled
> flag could be set for the corresponding subflow.
> 
> Do you think that array-based API would be clearer than the bitmap to
> someone writing a BPF scheduler?

I tried to implement this array-based API, but it's not going well. Array
parameters are not easily supported in BPF functions. And the write access
permissions of array members is not easy to allow in BPF. I haven't found
a solution to these two issues yet. Here are codes and error logs in the
attachment.

Thanks,
-Geliang

> 
> 
> - Mat
> 
> 
> > }
> > 
> > struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
> > {
> > 	struct mptcp_sched_data data;
> > +	struct sock *ssk = NULL;
> > +	unsigned long bitmap;
> > +	int i;
> > 
> > 	sock_owned_by_me((const struct sock *)msk);
> > 
> > @@ -134,8 +158,15 @@ struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
> > 		return mptcp_subflow_get_retrans(msk);
> > 
> > 	mptcp_sched_data_init(msk, &data);
> > -	msk->sched->get_subflow(msk, true, &data);
> > +	bitmap = msk->sched->get_subflow(msk, true, &data);
> > +
> > +	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> > +		if (test_bit(i, &bitmap) && data.contexts[i]) {
> > +			ssk = data.contexts[i]->tcp_sock;
> > +			msk->last_snd = ssk;
> > +			break;
> > +		}
> > +	}
> > 
> > -	msk->last_snd = data.sock;
> > -	return data.sock;
> > +	return ssk;
> > }
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

--VrqPEDrXMn8OVzN4
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-new-api.patch"

From 6b45c73f0621a3ba001712615b53bc89c47e9c80 Mon Sep 17 00:00:00 2001
Message-Id: <6b45c73f0621a3ba001712615b53bc89c47e9c80.1653401254.git.geliang.tang@suse.com>
From: Geliang Tang <geliang.tang@suse.com>
Date: Tue, 24 May 2022 16:57:53 +0800
Subject: [PATCH] new api

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                           |  7 ++--
 net/mptcp/bpf.c                               | 33 +++++++++++++++++++
 net/mptcp/sched.c                             | 33 ++++++++++---------
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 18 +++-------
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  9 ++---
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 13 ++++----
 6 files changed, 67 insertions(+), 46 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 24a9eb32c1dd..279b46536b64 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -100,12 +100,13 @@ struct mptcp_out_options {
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_sched_data {
-	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
+	struct mptcp_subflow_context *context;
+	bool is_scheduled;
 };
 
 struct mptcp_sched_ops {
-	unsigned long (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
-				     struct mptcp_sched_data *data);
+	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
+			    struct mptcp_sched_data contexts[]);
 
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 218f78514bdf..89b7fa68e363 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -18,6 +18,8 @@
 #ifdef CONFIG_BPF_JIT
 extern struct bpf_struct_ops bpf_mptcp_sched_ops;
 extern struct btf *btf_vmlinux;
+static const struct btf_type *mptcp_sched_type __read_mostly;
+static u32 mptcp_sched_id;
 
 static u32 optional_ops[] = {
 	offsetof(struct mptcp_sched_ops, init),
@@ -38,11 +40,33 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 					     u32 *next_btf_id,
 					     enum bpf_type_flag *flag)
 {
+	size_t end;
+
 	if (atype == BPF_READ) {
 		return btf_struct_access(log, btf, t, off, size, atype,
 					 next_btf_id, flag);
 	}
 
+	if (t != mptcp_sched_type) {
+		bpf_log(log, "only access to mptcp_sched_data is supported\n");
+		return -EACCES;
+	}
+
+	switch (off) {
+	case offsetof(struct mptcp_sched_data, is_scheduled):
+		end = offsetofend(struct mptcp_sched_data, is_scheduled);
+		break;
+	default:
+		bpf_log(log, "no write support to mptcp_sched_data at off %d\n", off);
+		return -EACCES;
+	}
+
+	if (off + size > end) {
+		bpf_log(log, "access beyond mptcp_sched_data at off %u size %u ended at %zu",
+			off, size, end);
+		return -EACCES;
+	}
+
 	return NOT_INIT;
 }
 
@@ -116,6 +140,15 @@ static int bpf_mptcp_sched_init_member(const struct btf_type *t,
 
 static int bpf_mptcp_sched_init(struct btf *btf)
 {
+	s32 type_id;
+
+	type_id = btf_find_by_name_kind(btf, "mptcp_sched_data",
+					BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	mptcp_sched_id = type_id;
+	mptcp_sched_type = btf_type_by_id(btf, mptcp_sched_id);
+
 	return 0;
 }
 
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 0ef805c489ab..83ea956cdb9d 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -89,7 +89,7 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 }
 
 static int mptcp_sched_data_init(struct mptcp_sock *msk,
-				 struct mptcp_sched_data *data)
+				 struct mptcp_sched_data contexts[])
 {
 	struct mptcp_subflow_context *subflow;
 	int i = 0;
@@ -99,20 +99,22 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk,
 			pr_warn_once("too many subflows");
 			break;
 		}
-		data->contexts[i++] = subflow;
+		contexts[i++].context = subflow;
+		contexts[i++].is_scheduled = 0;
 	}
 
-	for (; i < MPTCP_SUBFLOWS_MAX; i++)
-		data->contexts[i++] = NULL;
+	for (; i < MPTCP_SUBFLOWS_MAX; i++) {
+		contexts[i++].context = NULL;
+		contexts[i++].is_scheduled = 0;
+	}
 
 	return 0;
 }
 
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
 {
-	struct mptcp_sched_data data;
+	struct mptcp_sched_data contexts[MPTCP_SUBFLOWS_MAX];
 	struct sock *ssk = NULL;
-	unsigned long bitmap;
 	int i;
 
 	sock_owned_by_me((struct sock *)msk);
@@ -127,12 +129,12 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
 	if (!msk->sched)
 		return mptcp_subflow_get_send(msk);
 
-	mptcp_sched_data_init(msk, &data);
-	bitmap = msk->sched->get_subflow(msk, false, &data);
+	mptcp_sched_data_init(msk, contexts);
+	msk->sched->get_subflow(msk, false, contexts);
 
 	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (test_bit(i, &bitmap) && data.contexts[i]) {
-			ssk = data.contexts[i]->tcp_sock;
+		if (contexts[i].is_scheduled) {
+			ssk = contexts[i].context->tcp_sock;
 			msk->last_snd = ssk;
 			break;
 		}
@@ -143,9 +145,8 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
 
 struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
-	struct mptcp_sched_data data;
+	struct mptcp_sched_data contexts[MPTCP_SUBFLOWS_MAX];
 	struct sock *ssk = NULL;
-	unsigned long bitmap;
 	int i;
 
 	sock_owned_by_me((const struct sock *)msk);
@@ -157,12 +158,12 @@ struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	if (!msk->sched)
 		return mptcp_subflow_get_retrans(msk);
 
-	mptcp_sched_data_init(msk, &data);
-	bitmap = msk->sched->get_subflow(msk, true, &data);
+	mptcp_sched_data_init(msk, contexts);
+	msk->sched->get_subflow(msk, true, contexts);
 
 	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (test_bit(i, &bitmap) && data.contexts[i]) {
-			ssk = data.contexts[i]->tcp_sock;
+		if (contexts[i].is_scheduled) {
+			ssk = contexts[i].context->tcp_sock;
 			msk->last_snd = ssk;
 			break;
 		}
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 0f29b47260ff..cfa1fada3793 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -238,7 +238,8 @@ struct mptcp_subflow_context {
 } __attribute__((preserve_access_index));
 
 struct mptcp_sched_data {
-	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
+	struct mptcp_subflow_context *context;
+	bool is_scheduled;
 };
 
 struct mptcp_sched_ops {
@@ -247,8 +248,8 @@ struct mptcp_sched_ops {
 	void (*init)(const struct mptcp_sock *msk);
 	void (*release)(const struct mptcp_sock *msk);
 
-	unsigned long (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
-				     struct mptcp_sched_data *data);
+	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
+			    struct mptcp_sched_data contexts[]);
 	void *owner;
 };
 
@@ -261,15 +262,4 @@ struct mptcp_sock {
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
 
-#define _AC(X,Y)	(X##Y)
-#define UL(x)		(_AC(x, UL))
-
-static inline void set_bit(unsigned int nr, volatile unsigned long *addr)
-{
-        unsigned long *p = ((unsigned long *)addr) + (nr / sizeof(unsigned long));
-        unsigned long mask = UL(1) << (nr % sizeof(unsigned long));
-
-        *p  |= mask;
-}
-
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index e5dc53965642..739f34768664 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -16,13 +16,10 @@ void BPF_PROG(mptcp_sched_first_release, const struct mptcp_sock *msk)
 {
 }
 
-unsigned long BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
-			     bool reinject, struct mptcp_sched_data *data)
+void BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
+		    bool reinject, struct mptcp_sched_data contexts[])
 {
-	unsigned long bitmap = 0;
-
-	set_bit(0, &bitmap);
-	return bitmap;
+	contexts[0].is_scheduled = 1;
 }
 
 SEC(".struct_ops")
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index ef475bd33dd7..c2635fd14b0e 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -16,18 +16,18 @@ void BPF_PROG(mptcp_sched_rr_release, const struct mptcp_sock *msk)
 {
 }
 
-unsigned long BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
-			     bool reinject, struct mptcp_sched_data *data)
+void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+		    bool reinject, struct mptcp_sched_data contexts[])
 {
 	unsigned long bitmap = 0;
 	int nr = 0;
 
 	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!msk->last_snd || !data->contexts[i])
+		if (!msk->last_snd || !contexts[i].context)
 			break;
 
-		if (data->contexts[i]->tcp_sock == msk->last_snd) {
-			if (i + 1 == MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
+		if (contexts[i].context->tcp_sock == msk->last_snd) {
+			if (i + 1 == MPTCP_SUBFLOWS_MAX || !contexts[i + 1].context)
 				break;
 
 			nr = i + 1;
@@ -35,8 +35,7 @@ unsigned long BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 		}
 	}
 
-	set_bit(nr, &bitmap);
-	return bitmap;
+	contexts[nr].is_scheduled = 1;
 }
 
 SEC(".struct_ops")
-- 
2.34.1


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0002-new-api.log"

#106 mptcp:FAIL
test_base:PASS:test__join_cgroup 0 nsec
test_base:PASS:start_server 0 nsec
run_test:PASS:skel_open_load 0 nsec
run_test:PASS:skel_attach 0 nsec
run_test:PASS:bpf_program__fd 0 nsec
run_test:PASS:bpf_map__fd 0 nsec
run_test:PASS:bpf_prog_attach 0 nsec
run_test:PASS:connect to fd 0 nsec
verify_tsk:PASS:bpf_map_lookup_elem 0 nsec
verify_tsk:PASS:unexpected invoked count 0 nsec
verify_tsk:PASS:unexpected is_mptcp 0 nsec
test_base:PASS:run_test tcp 0 nsec
test_base:PASS:start_mptcp_server 0 nsec
run_test:PASS:skel_open_load 0 nsec
run_test:PASS:skel_attach 0 nsec
run_test:PASS:bpf_program__fd 0 nsec
run_test:PASS:bpf_map__fd 0 nsec
run_test:PASS:bpf_prog_attach 0 nsec
run_test:PASS:connect to fd 0 nsec
verify_msk:PASS:invalid token 0 nsec
get_msk_ca_name:PASS:failed to open tcp_congestion_control 0 nsec
get_msk_ca_name:PASS:failed to read ca_name 0 nsec
verify_msk:PASS:bpf_map_lookup_elem 0 nsec
verify_msk:PASS:unexpected invoked count 0 nsec
verify_msk:PASS:unexpected is_mptcp 0 nsec
verify_msk:PASS:unexpected token 0 nsec
verify_msk:PASS:unexpected first 0 nsec
verify_msk:PASS:unexpected ca_name 0 nsec
test_base:PASS:run_test mptcp 0 nsec
#106/1 mptcp/base:OK
test_first:PASS:bpf_first__open_and_load 0 nsec
test_first:PASS:bpf_map__attach_struct_ops 0 nsec
send_data:PASS:pthread_create 0 nsec
server:PASS:send 0 nsec
send_data:PASS:recv 0 nsec
send_data:PASS:pthread_join 0 nsec
#106/2 mptcp/first:OK
libbpf: prog 'bpf_rr_get_subflow': BPF program load failed: Permission denied
libbpf: prog 'bpf_rr_get_subflow': -- BEGIN PROG LOAD LOG --
R1 type=ctx expected=fp
0: R1=ctx(off=0,imm=0) R10=fp0
; void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
0: (b7) r3 = 0                        ; R3_w=0
; void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
1: (79) r2 = *(u64 *)(r1 +16)
func 'get_subflow' arg2 has btf_id 27881 type STRUCT 'mptcp_sched_data'
2: R1=ctx(off=0,imm=0) R2_w=ptr_mptcp_sched_data(off=0,imm=0)
2: (79) r1 = *(u64 *)(r1 +0)
func 'get_subflow' arg0 has btf_id 137236 type STRUCT 'mptcp_sock'
3: R1_w=ptr_mptcp_sock(off=0,imm=0)
; if (!msk->last_snd || !contexts[i].context)
3: (79) r4 = *(u64 *)(r1 +1448)       ; R1_w=ptr_mptcp_sock(off=0,imm=0) R4_w=ptr_sock(off=0,imm=0)
; if (!msk->last_snd || !contexts[i].context)
4: (15) if r4 == 0x0 goto pc+44       ; R4_w=ptr_sock(off=0,imm=0)
; if (!msk->last_snd || !contexts[i].context)
5: (79) r5 = *(u64 *)(r2 +0)          ; R2_w=ptr_mptcp_sched_data(off=0,imm=0) R5_w=ptr_mptcp_subflow_context(off=0,imm=0)
; if (!msk->last_snd || !contexts[i].context)
6: (15) if r5 == 0x0 goto pc+42       ; R5_w=ptr_mptcp_subflow_context(off=0,imm=0)
7: (b7) r4 = 1                        ; R4_w=1
; if (contexts[i].context->tcp_sock == msk->last_snd) {
8: (79) r1 = *(u64 *)(r1 +1448)       ; R1_w=ptr_sock(off=0,imm=0)
; if (contexts[i].context->tcp_sock == msk->last_snd) {
9: (79) r5 = *(u64 *)(r5 +176)        ; R5=ptr_sock(off=0,imm=0)
; if (contexts[i].context->tcp_sock == msk->last_snd) {
10: (5d) if r5 != r1 goto pc+8        ; R1=ptr_sock(off=0,imm=0) R5=ptr_sock(off=0,imm=0)
; if (i + 1 == MPTCP_SUBFLOWS_MAX || !contexts[i + 1].context)
11: (bf) r1 = r4                      ; R1_w=1 R4=1
12: (67) r1 <<= 4                     ; R1_w=16
13: (bf) r5 = r2                      ; R2=ptr_mptcp_sched_data(off=0,imm=0) R5_w=ptr_mptcp_sched_data(off=0,imm=0)
14: (0f) r5 += r1                     ; R1_w=P16 R5_w=ptr_mptcp_sched_data(off=16,imm=0)
15: (79) r1 = *(u64 *)(r5 +0)
access beyond struct mptcp_sched_data at off 16 size 8
processed 16 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
-- END PROG LOAD LOG --
libbpf: failed to load program 'bpf_rr_get_subflow'
libbpf: failed to load object 'mptcp_bpf_rr'
libbpf: failed to load BPF skeleton 'mptcp_bpf_rr': -13
test_rr:FAIL:bpf_rr__open_and_load unexpected error: -13
#106/3 mptcp/rr:FAIL

All error logs:
#106 mptcp:FAIL
test_base:PASS:test__join_cgroup 0 nsec
test_base:PASS:start_server 0 nsec
run_test:PASS:skel_open_load 0 nsec
run_test:PASS:skel_attach 0 nsec
run_test:PASS:bpf_program__fd 0 nsec
run_test:PASS:bpf_map__fd 0 nsec
run_test:PASS:bpf_prog_attach 0 nsec
run_test:PASS:connect to fd 0 nsec
verify_tsk:PASS:bpf_map_lookup_elem 0 nsec
verify_tsk:PASS:unexpected invoked count 0 nsec
verify_tsk:PASS:unexpected is_mptcp 0 nsec
test_base:PASS:run_test tcp 0 nsec
test_base:PASS:start_mptcp_server 0 nsec
run_test:PASS:skel_open_load 0 nsec
run_test:PASS:skel_attach 0 nsec
run_test:PASS:bpf_program__fd 0 nsec
run_test:PASS:bpf_map__fd 0 nsec
run_test:PASS:bpf_prog_attach 0 nsec
run_test:PASS:connect to fd 0 nsec
verify_msk:PASS:invalid token 0 nsec
get_msk_ca_name:PASS:failed to open tcp_congestion_control 0 nsec
get_msk_ca_name:PASS:failed to read ca_name 0 nsec
verify_msk:PASS:bpf_map_lookup_elem 0 nsec
verify_msk:PASS:unexpected invoked count 0 nsec
verify_msk:PASS:unexpected is_mptcp 0 nsec
verify_msk:PASS:unexpected token 0 nsec
verify_msk:PASS:unexpected first 0 nsec
verify_msk:PASS:unexpected ca_name 0 nsec
test_base:PASS:run_test mptcp 0 nsec
#106/1 mptcp/base:OK
test_first:PASS:bpf_first__open_and_load 0 nsec
test_first:PASS:bpf_map__attach_struct_ops 0 nsec
send_data:PASS:pthread_create 0 nsec
server:PASS:send 0 nsec
send_data:PASS:recv 0 nsec
send_data:PASS:pthread_join 0 nsec
#106/2 mptcp/first:OK
libbpf: prog 'bpf_rr_get_subflow': BPF program load failed: Permission denied
libbpf: prog 'bpf_rr_get_subflow': -- BEGIN PROG LOAD LOG --
R1 type=ctx expected=fp
0: R1=ctx(off=0,imm=0) R10=fp0
; void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
0: (b7) r3 = 0                        ; R3_w=0
; void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
1: (79) r2 = *(u64 *)(r1 +16)
func 'get_subflow' arg2 has btf_id 27881 type STRUCT 'mptcp_sched_data'
2: R1=ctx(off=0,imm=0) R2_w=ptr_mptcp_sched_data(off=0,imm=0)
2: (79) r1 = *(u64 *)(r1 +0)
func 'get_subflow' arg0 has btf_id 137236 type STRUCT 'mptcp_sock'
3: R1_w=ptr_mptcp_sock(off=0,imm=0)
; if (!msk->last_snd || !contexts[i].context)
3: (79) r4 = *(u64 *)(r1 +1448)       ; R1_w=ptr_mptcp_sock(off=0,imm=0) R4_w=ptr_sock(off=0,imm=0)
; if (!msk->last_snd || !contexts[i].context)
4: (15) if r4 == 0x0 goto pc+44       ; R4_w=ptr_sock(off=0,imm=0)
; if (!msk->last_snd || !contexts[i].context)
5: (79) r5 = *(u64 *)(r2 +0)          ; R2_w=ptr_mptcp_sched_data(off=0,imm=0) R5_w=ptr_mptcp_subflow_context(off=0,imm=0)
; if (!msk->last_snd || !contexts[i].context)
6: (15) if r5 == 0x0 goto pc+42       ; R5_w=ptr_mptcp_subflow_context(off=0,imm=0)
7: (b7) r4 = 1                        ; R4_w=1
; if (contexts[i].context->tcp_sock == msk->last_snd) {
8: (79) r1 = *(u64 *)(r1 +1448)       ; R1_w=ptr_sock(off=0,imm=0)
; if (contexts[i].context->tcp_sock == msk->last_snd) {
9: (79) r5 = *(u64 *)(r5 +176)        ; R5=ptr_sock(off=0,imm=0)
; if (contexts[i].context->tcp_sock == msk->last_snd) {
10: (5d) if r5 != r1 goto pc+8        ; R1=ptr_sock(off=0,imm=0) R5=ptr_sock(off=0,imm=0)
; if (i + 1 == MPTCP_SUBFLOWS_MAX || !contexts[i + 1].context)
11: (bf) r1 = r4                      ; R1_w=1 R4=1
12: (67) r1 <<= 4                     ; R1_w=16
13: (bf) r5 = r2                      ; R2=ptr_mptcp_sched_data(off=0,imm=0) R5_w=ptr_mptcp_sched_data(off=0,imm=0)
14: (0f) r5 += r1                     ; R1_w=P16 R5_w=ptr_mptcp_sched_data(off=16,imm=0)
15: (79) r1 = *(u64 *)(r5 +0)
access beyond struct mptcp_sched_data at off 16 size 8
processed 16 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
-- END PROG LOAD LOG --
libbpf: failed to load program 'bpf_rr_get_subflow'
libbpf: failed to load object 'mptcp_bpf_rr'
libbpf: failed to load BPF skeleton 'mptcp_bpf_rr': -13
test_rr:FAIL:bpf_rr__open_and_load unexpected error: -13
#106/3 mptcp/rr:FAIL
Summary: 0/2 PASSED, 0 SKIPPED, 1 FAILED

--VrqPEDrXMn8OVzN4--

