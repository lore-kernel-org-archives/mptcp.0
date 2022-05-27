Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3DA1FA5
	for <mptcp@lists.linux.dev>; Fri, 27 May 2022 15:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653665232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rXHJoLL1+TAIJJBRCJuXciE0h5O7aOgKMWes9ablyGY=;
	b=NP97Jz95ova+wp8o1nlgWZ+TCAESLuMXH1nhei8lsAVLlewWOUitgbTRbfh7DcRPqqQRfb
	mYKfUtAelV4Ilw0CTVPktaJnG4WvhPY1dIEyVzA+Uxtr/dsbx9DnzGEehIh3PhWDZWkNpz
	+wvQFfBNdW461KFOvZfSfBHWwUp9Ns4=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-44-2JPLie9JMzemn37afWnnIw-1; Fri, 27 May 2022 17:27:11 +0200
X-MC-Unique: 2JPLie9JMzemn37afWnnIw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1ej0eUzi3RtjLrVF6C7CxCiuF6koRSUy/XhZAZP6wgRW7XLCxb8VXYRYd/DbfBlbDsXIx6WhUQ3T9Q4xGzuR0esfPw4efTzrtQHIuaCPDDWnbrO4w8YdRMTi+7p1KLsErG+MPLU9QMSH7MeQLKA0yCX5IJuKhAHP88xJe0Venq8uMciKeQYrvLxhXjBwWtyWKm6tlc22z09aac7BclywJhpOhVbgn6klEc37HUPGrwvdtTcI2YJ8mcsuYm3zuyxNGN8a2M/S42x3CBjQ58xllYpuGZWywQMeOIkiokVePB0916V0OKOPCEymoAbKwYow2yazGKAnA2exGnH3JfzbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXHJoLL1+TAIJJBRCJuXciE0h5O7aOgKMWes9ablyGY=;
 b=aJmqbRlOQ+qZ2CoMiwUGybYwHL7/D9bx+BPJwwraQPIsvlbqSOr4Cb1yDDJZbqwTQHOZSGeD4asn5utYW60wRDWLTZCeP5sJY2iAxStKlTMhkNPJUlsfiIvxH4FkvlpQpm8Q2FgfuDbVTc66JvMRMmPXT3/rIOpldKHjs0kzVYiz8QK93gc9zAoLFBuy5FSOAzGywJCiwUH5ue5m02umFN2PpBGq+ypRmHhYECS3D0bZ4d8oxnpa9zp2Ugri0TcytAMCDLoLbp0eGeXndpq7yRbO6OTO0Y8cb9mWWeDWi2RF497UJwKH6PuI0bEde9XJ/utLDayD4oWCmb0UzChcTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8918.eurprd04.prod.outlook.com (2603:10a6:10:2e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Fri, 27 May
 2022 15:27:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.022; Fri, 27 May 2022
 15:27:09 +0000
Date: Fri, 27 May 2022 23:27:18 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 3/5] Squash to "mptcp: add get_subflow
 wrappers"
Message-ID: <20220527152717.GA19642@bogon.HOST>
References: <cover.1653305364.git.geliang.tang@suse.com>
 <e0034f846f86901bd0c996bca6693c4036602750.1653305364.git.geliang.tang@suse.com>
 <294011b7-28d5-5549-c138-e6e674b18b9e@linux.intel.com>
 <20220526121659.GA2665@bogon.HOST>
 <92789df9-f9e7-9d31-e859-eef24b938919@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92789df9-f9e7-9d31-e859-eef24b938919@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0214.apcprd02.prod.outlook.com
 (2603:1096:201:20::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bdb9cb0-4caf-4fdc-a6a9-08da3ff55d56
X-MS-TrafficTypeDiagnostic: DU2PR04MB8918:EE_
X-Microsoft-Antispam-PRVS:
	<DU2PR04MB891897417C330D96E72248CAF8D89@DU2PR04MB8918.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w5vV+K2opmcjOUM715UEFLDI5yJQdxkPE7TyuQ4Cu9R2OwbvchyPHJko/jgtDgYdfU48hFxQYXYXHKgTZDgQUwLEjqwb5EbtH/SAa/pXOig0ib6xro49MPJwXKO/j+Xbvqi/Ki3D123Mh/+o7oKGmt2kEKT09QNceCxkp9f2GMAmHZFe0o25acrppUVthNHs35HfYRn3fJrQniJ7d9XMCTYEghrJBkPsalkeXhiIl6BRkAF3B8EiUijyPH+IgkMCFkGfP/5Tj9w5Vn7i42BB3MauWI+qIlKrsnVWPYOx/FEx35nGa7F26Y+VZWt5miIJI2goB7vPus+xA3vlGZ/wGduinj91IR8uYYaUQrbwf58Vgg/GA6BrDI6IFLyPiX5C0v44ASK1JzkJRRXf9OWRVQbxpS/h1zrAK15juzXI+O45EjBO/GJDHUxSNFRUVqenO4bVVq08MPpprCPAkI91MW95q1S0CA2RgpX7Vj9xGMNO/MlZHP9dCucj4ZiLzM9IkxyyxaUaAtzH2buca/gejYj1Tx8ibhGwK7sHnF5x6XUAxfCVmb/rhsyx20m6Rf+YzC7iJwgyOnY78Ib1V4Rmiho2USoIamqJjocqRsGOcjqKg20NtC3DbmUAjOipBoR+3hlPn+CNZGJB9hSvuHYgp3zWGllO8Y/7o8zA8oDWqGwy8/y79awijDlgw73sUsKh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6506007)(38100700002)(6486002)(33656002)(186003)(316002)(1076003)(44832011)(36756003)(6916009)(66946007)(66556008)(8676002)(8936002)(4326008)(66476007)(86362001)(83380400001)(2906002)(6666004)(5660300002)(508600001)(6512007)(9686003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SUBtgdZ5mp1nAhdxvzlVC7IpDBIJYEu/Y5nndtcKGqFZbfIvlsM+3RboPo2Q?=
 =?us-ascii?Q?Km8DVgfmFrEKxhpj2fWptb7l5n/HCnU0Xw5UE8I8Ym5v3++tyFmcZyVa5Og2?=
 =?us-ascii?Q?alC3Hc6iGYXoWw020Dwclj8ZDvHRhtPRizQzO2dRVpdEz2Cyrkh1R0D8JGm4?=
 =?us-ascii?Q?heAULoSaenV7MWC2U5dLy9omYyBCQGuO0eMNpiH0S9yvy9Ie3qkjJu2YsBj1?=
 =?us-ascii?Q?KMdKjFiD+Sq6lRTCWxW9UOF8xcsaQVDmQOA041B51IUbMFbKoYBq8HzqltyX?=
 =?us-ascii?Q?6drMZ4qhftXy5N8j0hW/r7c4oP6XOYZ/rkFSp0RuVAY3DvcYnvJQ1KXzAYp0?=
 =?us-ascii?Q?2aWADqfBLbkXkrz7pczJcMDHrPhM6TGXsAl0iGzUauG65p3fHYrfznqhlKCe?=
 =?us-ascii?Q?ElRfL9EtB4DQSzCRyWuTOgEJTtOeCKBf9wuVZvqJGE4/Jqthl/REkfMz4RF7?=
 =?us-ascii?Q?PfB6xJ60YCAq0mAc3pzWg71C+q3ju1WeGHm3IqB3U6weLo66i0AEMUVcA7M3?=
 =?us-ascii?Q?9fq//JFmzIkTLywLB5pUe8GPFe8qUJtpBGNLywj1Hd9Cd+hpqKuodMeF3cIM?=
 =?us-ascii?Q?tLx4jy9WHJOvbqKYpBuBe7sRqlHcpS1iik0Sq6/6m/3FXXyYHMhgwTQK+KE+?=
 =?us-ascii?Q?tMVyfNCjpV3XHIsPIJI/ZIzIhS86xI4jAeNs8uP9o8huEwf199WCQpbUm89d?=
 =?us-ascii?Q?MSip7/tB5GRlO+MoFZldcQwcbMD/d2NXecHR+zqz+HfWmWSENBYLbtus+q6t?=
 =?us-ascii?Q?MrvRhscYHd5+fG4jX14WW/SsGRQOXLlKLcMikSqCb3FRlRRZeu1hv/AA0AKu?=
 =?us-ascii?Q?EXpC/yNdaYVNuJnNlCQoSYQriq4sKoDsP6XSYwaFfNbgIlLtWipdsTuseRG+?=
 =?us-ascii?Q?T0b2oGK8aDm9KNyszNfpf5tSltfoHwq65zRsdSuXOlFPmMpm69B9EzppzUOY?=
 =?us-ascii?Q?KnZ1LlZrRwKkRl5MD6HeQ6z4S/7yteTehh+c0Vw/oFQ4OjaV1nNTEKtZS74f?=
 =?us-ascii?Q?Tjg12LSReVPURSiCemQSyEdjTbCT8RO9FqHI/Z7bU9t6WrAsOQFpa5IjYaq1?=
 =?us-ascii?Q?XJqtcu6Hc8qtMbQDcqZNjUXKyoc/ORs4a9TOK91FTq578a6R1shvGP0EymaL?=
 =?us-ascii?Q?cVfWvbjyQbv+TbugMvqCfzC/PlLPlFgYbIItUPEEVJVMJZ+6mPXWTusnkJ8R?=
 =?us-ascii?Q?in/WXUE2c1+LRKEZiujnhsuvNfhbhcUJJu0XZ56ERwCfwtdco/FJHfIAqdXv?=
 =?us-ascii?Q?agxcC0wZP4xmGjDDBdZl9vhVVT8cTK17Nyg6YYjhZsMgNB6vDouXd+4UfwtV?=
 =?us-ascii?Q?ApReavsz9sium4s2E3O3vcYrEScSsFY/1Y0KwHJtnckomZwWpYhfG4uXxJDm?=
 =?us-ascii?Q?Ve4VD267KODUNVPskoUBA3+5d2LQA3cnFPkb5d7S3hm24/Cq12xp3kRwBHpk?=
 =?us-ascii?Q?oytHrpORKoX1byqRUNitZy3v08PxTB9ywgIWpmD/nvgave3xWkBAN/DV409l?=
 =?us-ascii?Q?BxwjOMAXcUE5UOdpX9Xp+NF/dKaP94IK2N+LBOwp6uoukCVe3sY/Aqr142oe?=
 =?us-ascii?Q?Q8odadAKNsYjTowhv0XgfpUE/v8p90JIReZiNStz+JHybKA1Y8jYhszJ+yo7?=
 =?us-ascii?Q?9UXbgtLZ2tM5iKdQucjRdGh/rucoYGFTV4WvMlJCFqgDLHVv8byNnxWs9/IM?=
 =?us-ascii?Q?94oGcADfXFAutLlDfOeSm+HFzIwsINa1JW4aPUg5aMaT3a8qzHwkEhj68/z5?=
 =?us-ascii?Q?w8eGcSkVawMxxYmsh4Ad3cCyZPT12g8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdb9cb0-4caf-4fdc-a6a9-08da3ff55d56
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 15:27:09.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Unj5eoJ+Mvx4xEHzFq4rRmjYBrp1/u37qoS0lTOByGePKVOzpqjUKeonQsYWtJ9JTzNoZ7X+kj54wOpU8SIpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8918

Hi Mat,

On Thu, May 26, 2022 at 04:48:41PM -0700, Mat Martineau wrote:
> On Thu, 26 May 2022, Geliang Tang wrote:
> 
> > Hi Mat,
> > 
> > On Mon, May 23, 2022 at 06:01:03PM -0700, Mat Martineau wrote:
> > > On Mon, 23 May 2022, Geliang Tang wrote:
> > > 
> > > > Please update the commit log:
> > > > 
> > > > '''
> > > > This patch defines two new wrappers mptcp_sched_get_send() and
> > > > mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.
> > > > Use them instead of using mptcp_subflow_get_send() or
> > > > mptcp_subflow_get_retrans() directly.
> > > > 
> > > > Set the subflow pointers array in struct mptcp_sched_data before invoking
> > > > get_subflow(), then it can be used in get_subflow() in the BPF contexts.
> > > > 
> > > > Get the return bitmap of get_subflow() and test which subflow or subflows
> > > > are picked by the scheduler.
> > > > '''
> > > > 
> > > > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > > > ---
> > > > net/mptcp/sched.c | 47 +++++++++++++++++++++++++++++++++++++++--------
> > > > 1 file changed, 39 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> > > > index 3ceb721e6489..0ef805c489ab 100644
> > > > --- a/net/mptcp/sched.c
> > > > +++ b/net/mptcp/sched.c
> > > > @@ -91,8 +91,19 @@ void mptcp_release_sched(struct mptcp_sock *msk)
> > > > static int mptcp_sched_data_init(struct mptcp_sock *msk,
> > > > 				 struct mptcp_sched_data *data)
> > > > {
> > > > -	data->sock = NULL;
> > > > -	data->call_again = 0;
> > > > +	struct mptcp_subflow_context *subflow;
> > > > +	int i = 0;
> > > > +
> > > > +	mptcp_for_each_subflow(msk, subflow) {
> > > > +		if (i == MPTCP_SUBFLOWS_MAX) {
> > > > +			pr_warn_once("too many subflows");
> > > > +			break;
> > > > +		}
> > > > +		data->contexts[i++] = subflow;
> > > > +	}
> > > > +
> > > > +	for (; i < MPTCP_SUBFLOWS_MAX; i++)
> > > > +		data->contexts[i++] = NULL;
> > > > 
> > > > 	return 0;
> > > > }
> > > > @@ -100,6 +111,9 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk,
> > > > struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
> > > > {
> > > > 	struct mptcp_sched_data data;
> > > > +	struct sock *ssk = NULL;
> > > > +	unsigned long bitmap;
> > > > +	int i;
> > > > 
> > > > 	sock_owned_by_me((struct sock *)msk);
> > > > 
> > > > @@ -114,15 +128,25 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
> > > > 		return mptcp_subflow_get_send(msk);
> > > > 
> > > > 	mptcp_sched_data_init(msk, &data);
> > > > -	msk->sched->get_subflow(msk, false, &data);
> > > > +	bitmap = msk->sched->get_subflow(msk, false, &data);
> > > > 
> > > > -	msk->last_snd = data.sock;
> > > > -	return data.sock;
> > > > +	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> > > > +		if (test_bit(i, &bitmap) && data.contexts[i]) {
> > > > +			ssk = data.contexts[i]->tcp_sock;
> > > > +			msk->last_snd = ssk;
> > > > +			break;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return ssk;
> > > 
> > > The commit that this gets squashed too also ignores call_again, so is this
> > > code that just returns the ssk for the first bit in the bitmap also
> > > placeholder code?
> > 
> > Yes. Since the redundant scheduler is still under development and there's
> > still a lot of work to be done, I plan to support single subflow schedulers
> > in this series first. The multiple subflows schedulers will be added later.
> > 
> > > 
> > > 
> > > It also seems like correlate the bitmap bits with the data.contexts array
> > > makes the bitmap require extra work. What do you think about using an array
> > > instead, like:
> > > 
> > > struct mptcp_sched_data {
> > >        struct mptcp_subflow_context *context;
> > >        bool is_scheduled;
> > > };
> > > 
> > > And passing an array of that struct to the BPF code? Then the is_scheduled
> > > flag could be set for the corresponding subflow.
> > > 
> > > Do you think that array-based API would be clearer than the bitmap to
> > > someone writing a BPF scheduler?
> > 
> > I tried to implement this array-based API, but it's not going well. Array
> > parameters are not easily supported in BPF functions. And the write access
> > permissions of array members is not easy to allow in BPF. I haven't found
> > a solution to these two issues yet. Here are codes and error logs in the
> > attachment.
> > 
> 
> Yeah, after looking at your logs and trying a few experiments, I definitely
> agree that array parameters are not well supported by the BPF verifies.
> 
> It looks like the bpf verifier was inspecting the args for get_subflow in
> mptcp_sched_ops:
> 
> void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
> 		    struct mptcp_sched_data contexts[]);
> 
> and thinking 'contexts' was a pointer to a single struct mptcp_sched_data
> instance, instead of an array. The verifier can't guarantee safe access for
> a variable-length array so that does make some sense.
> 
> I tried changing the code to:
> 
> void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
>                     struct mptcp_sched_data (*contexts)[MPTCP_SUBFLOWS_MAX]);
> 
> so the third arg was a "pointer to array of structs, with MPTCP_SUBFLOWS_MAX
> elements in the array". The verifier didn't like that either:
> 
> """
> func 'get_subflow' arg2 type ARRAY is not a struct
> """
> 
> That error message is printed by btf_ctx_access(). It might be possible to
> customize bpf_mptcp_sched_verifier_ops to handle that, but it seems
> complicated.
> 
> 
> We could instead use mptcp_sched_data to contain all the parameters
> (including an array of structs):
> 
> struct mptcp_sched_subflow {
> 	struct mptcp_subflow_context *context;
> 	bool is_scheduled;
> };
> 
> struct mptcp_sched_data {
> 	/* Moving the msk and reinject args here is optional, but
> 	 * it seemed like a good way to group all of the data
> 	 * for a bpf scheduler to use */
> 	const struct mptcp_sock *msk;
> 	bool reinject;
> 	struct mptcp_sched_subflow subflows[MPTCP_SUBFLOWS_MAX];
> };
> 
> struct mptcp_sched_ops {
> 	void (*get_subflow)(struct mptcp_sched_data *data);
> 
> 	char			name[MPTCP_SCHED_NAME_MAX];
> 	struct module		*owner;
> 	struct list_head	list;
> 
> 	void (*init)(const struct mptcp_sock *msk);
> 	void (*release)(const struct mptcp_sock *msk);
> } ____cacheline_aligned_in_smp;
> 
> It looks like btf_struct_access() and btf_struct_walk() know how to handle
> an array *inside* a struct, so MPTCP would not need as much custom verifier
> code. This seems like a better fit than my array idea - hopefully it's more
> workable.

It's hard to get the write access to is_scheduled in this case.

If we add another member bitmap in mptcp_sched_data like this:

struct mptcp_sched_subflow {
	struct mptcp_subflow_context *context;
	bool is_scheduled;
};

struct mptcp_sched_data {
	struct mptcp_sched_subflow subflows[MPTCP_SUBFLOWS_MAX];
	const struct mptcp_sock *msk;
	bool reinject;
	unsigned bitmap;
};

It's easy to calculate the offset in bpf_mptcp_sched_btf_struct_access():

	switch (off) {
	case offsetof(struct mptcp_sched_data, bitmap):
		end = offsetofend(struct mptcp_sched_data, bitmap);
		break;

But it's hard to calculate the offsets of is_scheduled, we need to have
write access for 8 different offsets.

We may calculate them like this:

data->contexts[0].is_scheduled	offset = 0 + sizeof(struct mptcp_subflow_context)
data->contexts[1].is_scheduled  offset = 1 * sizeof(mptcp_sched_subflow) + sizeof(struct mptcp_subflow_context *)
data->contexts[2].is_scheduled  ...
data->contexts[3].is_scheduled  ...
data->contexts[4].is_scheduled  ...
data->contexts[5].is_scheduled  ...
data->contexts[6].is_scheduled  ...
data->contexts[7].is_scheduled  offset = 7 * sizeof(mptcp_sched_subflow) + sizeof(struct mptcp_subflow_context *)

But it doesn't work. I haven't found a solution yet.

Maybe we also need to consider the actual number of subflows, which makes
it more complicated.


If we make the array read only, just write the bitmap member or return a
bitmap, we can avoid dealing with these complex offsets.


Anyway, I will continue to solve this write access issue, but I also want
to hear your opinion.

Thanks,
-Geliang

> 
> Do you think this seems like a reasonable interface for BPF scheduler code?
> 
> 
> --
> Mat Martineau
> Intel
> 

