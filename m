Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2084.outbound.protection.outlook.com [40.107.103.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3402C1C02
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 13:17:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAQfcsRJSKfGqROm6tA42UNbjXthKHdToR1u8+vd5jG+EMZ+bkMyALPOYFTn8tar37qY/cEBabcIXY/45HSviDehn+KsSwHyToMcolWrVwF4zUFXGVxr1w+1GSGvq/NgpebL2r9yEbCm8DBgVLC793tU+NVmsOeTPWHECCWg2Zj8y9LlbiPpdXd/0h1aEFm8z2UNZrLh9FSCUGT76OmxMgag1VGlE6IhJeMdPmj6GEdufLr+vNaEmwQhFp0i9yZZhhfYJxZy1rR7oinOUcxljJKkS1E2RtDiao/BKs2vHxB4PDFTs7DwM6RQmM6foolcDZs26IZ07+sORk/vhjbe+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9t5rzLAXIxv3ZXKwejzJyeJTzWevSUVp8bzrLpcGYgs=;
 b=nMOaB3cJ0a9/8yNDtP/3qbNkQX9InOWpafPI+8U5x04dSzXnantaRXdxdtgv1zad8yVVOErTC9y2lW4SuwaAfwpdtTt42pQhQ8h8clmUDVVB9vJ1nIH8FcSKOX/DcEOe+cB16xuZN/R5FiAFpFXy6pjBMRh3GqBOG6XQN+GkCxKx5cLNDtRPpIf8bgtl5fUPYzRwMHoyft+eYgMq/axDivG7QGKP1Cv1kip9MrJb1bOAJDAtxKKOdCF73+lr4Pep1oOgfmwHmlGehw4M5Wg75w2QmcsMNkivAInuIm3FDqokwVmp/YKXi/shRiKqqFwDBPGJ5TXbbqhvvxwMBXszVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t5rzLAXIxv3ZXKwejzJyeJTzWevSUVp8bzrLpcGYgs=;
 b=P3DcOG0FgBrCoM1vIMvs/rrODGd/yVlyfTuGFFw22DETGHWQ1qjCI5tTJsmcom5cfAKEFUkt5HLEFMDUEQNvE105z+w1yM6dZp0RgQxFu5AN7nrIzj3swpZUnzqX0FXY1gYJPbIHZUq5WTgIrp1swkBReIPHlSDf9gE7BrTpHzqMxrUR6oD3i8QVClYUNvZxYoSLGn7yySi0Qm+Nd0ZzbD1gLT/StWhvg/+qKU5RIraGJWYFIlELYZ7XN3RCDy/LjuT7JUfgBoa0RO6GH+5xha2qVNldKTVp1gahSu5Qdb0TNdnkgtPsGOY3GE8RcZShUHRusd1S59wehs1XQEaboQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8365.eurprd04.prod.outlook.com (2603:10a6:102:1cf::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 13:17:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 13:17:16 +0000
Date: Mon, 19 Dec 2022 21:17:31 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 2/2] mptcp: retrans for redundant sends
Message-ID: <20221219131731.GA4625@localhost.localdomain>
References: <cover.1670724098.git.geliang.tang@suse.com>
 <aa989fcaf2c6471ce82d59fffd0d09c78191ba2e.1670724098.git.geliang.tang@suse.com>
 <86277516-113d-53cf-aded-10e3224f59e9@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86277516-113d-53cf-aded-10e3224f59e9@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCPR01CA0125.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 885af2de-07c7-46b0-da7a-08dae1c3598d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b4J9PwwMFo4d0dnml1drtpLkuVKcq9BWILjLZ606z40v1EQIet0tqqQ+nG8soRSKQfotxOMBlb3HKUKLD45VvD0A7mIEihJvmtw6o2Ef8uVJkVkeYyC9WkRPJEDCYjg3cjdNQ4/9x7I1WBcMY//qHFJaW+VMtlUTghFxWnZQUWnKKRtPOwF1nzLC45FWI94BY9jdYvEkcK1k5qUW/MfM73j1JuOmtyt7Yvl2CleNAtDLresGNMnKQjWWVwsbOzflbWxR78NXnD/E4XxWcLpcEQQu34G26WRx6OhsKZ8KAVpadYuKwgdBM1VAL6mvnWsH9JfVLSuxPIglOaJVSLOeqiKAejPSC+jr2yXWGxeoP9m1iiI/+K97CFsBD1Y0vy1An0Dbx/NHMS7EoUkyTh8h+G90qjvcXlv72u5HQOV5O/zGFEkhJ1BiZ58ZZ/vUe8rFOap/LtTx/hLYBg7MRx5cwO9PsCliC2OnXbNTRQeWiLy1jXuapdU91G/1cKWxbsBXVic9oOyAfnK6+gkNV78qEVRqV6QNfc4BFjBmZ41KD8Q/3rraEEfo4XrI8sYdrp2mxBUHN0zbQvaYKvV6fwNsO8+Mv/3MxGwP1PU2hCFQaFv9KAytMu4PrxeLVKDyJ/hDnhcmbAczSDQ+Hn5wG4tOsg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199015)(8676002)(41300700001)(4326008)(1076003)(38100700002)(5660300002)(8936002)(83380400001)(2906002)(44832011)(33656002)(6506007)(6666004)(478600001)(6486002)(86362001)(66946007)(6916009)(316002)(26005)(66556008)(66476007)(186003)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LFJEuizcJReMAdoqWYUy5ZV54Rod9lRGG8gPCjk2KjJZ6FXk8UMnG6SWZMAD?=
 =?us-ascii?Q?I1XuaBM99YO9mW79gffVyKhewQ+O4yOTzaLBv+ikgkmUGTljmcgYvMdrJedV?=
 =?us-ascii?Q?wsp0W2NLEsmR50iGA/uOKBf8dEHOPBVRQBm/RI0KjHstU8fGc7xKEStBetdJ?=
 =?us-ascii?Q?ycJKB2ODdiHt7T/zX8QGEakfVXXLRgHLktPOrKWC/8j0uRGDEmZ0KoTN+OQo?=
 =?us-ascii?Q?DMDqi6wWaLt0AgDE0CoVyykBIjSrI0ZFtdqvmNE4lD+spw8hu4JABaOUngqk?=
 =?us-ascii?Q?uhDoM0e5sApQitgCivmabmipw6js57vSuAXbuU9Kv4nGj6nu1W9lidplcfST?=
 =?us-ascii?Q?5BfVoeO4bGSlHI0Uq7iFICmOmRcmFlIRjXQNuX5KBVcN8IteGczXHnu7VzYb?=
 =?us-ascii?Q?FfCSKQ/8GbHzyJuGZyby5dWMsuVL/bLVlBfJjLu8HiWgkdJIhp0S7sQ6ALc1?=
 =?us-ascii?Q?Y4FsyZr9BJwnMOKf+KIUKmKpJeNuVqOXQZDZMDA607p7IPuwZSMBmQqGbncN?=
 =?us-ascii?Q?gfb4Gj489nfwi5fENzO7/QHd234IcLS2R0ibP5bYnYVDb9uM842xsmSEboP7?=
 =?us-ascii?Q?yBULJ0CEXb5clZ9x7PqITnHKd+iNTLITGZRiMSHGyRwGXbj5seyhhV9RkAkZ?=
 =?us-ascii?Q?WGwIiuLThnkX5OvRQJ2G2sYHTfa7oaKj4s2D1DzkqlPiQgee5He+YDeaU1g7?=
 =?us-ascii?Q?45Rs3fE0I27PhOgmDNOhj6dgXTv7eTZ0aLg7xnFEaLdk9tA4tYkn2WlUtkeI?=
 =?us-ascii?Q?uzypo6Ipaeu5Wzg+2tsjnEejLtENcFjDr9lAPrsBaff0DFS7Yqx71hV7QVie?=
 =?us-ascii?Q?O4pxE4VW4eT88c4WtBkhTXQVSqWfglUPCZgn2kyJyzFySV0e2LEomBBOW16K?=
 =?us-ascii?Q?QsFQ25lw7GEYBGcq1DJEm05rzl6vXj5C1Q+X9tUxP8IRJYLqX8PSNHmWvKcK?=
 =?us-ascii?Q?YfzHienwzkRFtK3Nm55f3J/WVrddwB7wmuPL4VYd4y8adgHtDrrsO1Q6lgbP?=
 =?us-ascii?Q?MaRtyI38kAGSd4Q45YaUA/iFmN9z17E41rX/9o05+IZAgUOXmT10JpeIp+lj?=
 =?us-ascii?Q?zEkn+EBX1rML3zy85dbFMamkrneIx2xmrN2ncANDd/CHuTfx34z6wlInJMLs?=
 =?us-ascii?Q?TQXQoEl2DinP7l8fKVcTwu3l3LJcqdDPQchwvaVsuVbCeGNY24HVem7QGRf4?=
 =?us-ascii?Q?gBSsS5KTrAK4slL9e7RbzN+hBq182CRIqHtvjjySvqj0aCybft6+U30RvnNr?=
 =?us-ascii?Q?Pagp6h7Fh6NqXga4BhhB2vMMoOWc8M7Ol/9inm5LNqo/KWDDs6khtXh9DhCE?=
 =?us-ascii?Q?LlWBDgYoT88zX69xcnFOI3DmEKIVncGUx4ug9wLq4GIbNUCIP27uoEh+FQhl?=
 =?us-ascii?Q?t9VbulVQodZ3t/PsuQaHLUxBCYDBbuQD0T+eBfpaso7SnrsDUR5Jw+vcX0Lq?=
 =?us-ascii?Q?mNzDkTVIc1pVGqUshKMrOuBZnt5QJDGclQTqXfBdSPuNz9ceQBOYxDhT1LxI?=
 =?us-ascii?Q?IkR+cyFBDCG0xVMTEl8UG8rEPCzEYYuAqWu8WXBZOUOBn9v7evG4vzyldIsf?=
 =?us-ascii?Q?Hn6whutNyVXTS9sUDK+SkErO9OmsiZWJiGaPJuqwO2WfRywAhO9oSqexfC3W?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885af2de-07c7-46b0-da7a-08dae1c3598d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 13:17:16.8062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k94rworH9lPCy0XTD+LcslPNCRliUk5NaU5kRLy0MAJZ+mMbs1ujX/jDeU9abNVpoVZ4gquip1nc8qiSTVqC2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8365

On Wed, Dec 14, 2022 at 05:47:12PM -0800, Mat Martineau wrote:
> On Sun, 11 Dec 2022, Geliang Tang wrote:
> 
> > Redundant sends need to work more like the MPTCP retransmit code path.
> > When the scheduler selects multiple subflows, the first subflow to send
> > is a "normal" transmit, and any other subflows would act like a retransmit
> > when accessing the dfrags.
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> > net/mptcp/protocol.c | 45 ++++++++++++++++++++++++++++++++++++++++----
> > 1 file changed, 41 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 2342b9469181..4c07add44b02 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -45,6 +45,7 @@ static struct percpu_counter mptcp_sockets_allocated ____cacheline_aligned_in_sm
> > 
> > static void __mptcp_destroy_sock(struct sock *sk);
> > static void __mptcp_check_send_data_fin(struct sock *sk);
> > +static void __mptcp_retrans(struct sock *sk);
> > 
> > DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
> > static struct net_device mptcp_napi_dev;
> > @@ -997,7 +998,7 @@ static void __mptcp_clean_una(struct sock *sk)
> > 
> > 		if (unlikely(dfrag == msk->first_pending)) {
> > 			/* in recovery mode can see ack after the current snd head */
> > -			if (WARN_ON_ONCE(!msk->recovery))
> > +			if (!msk->recovery)
> > 				break;
> > 
> > 			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> > @@ -1012,7 +1013,7 @@ static void __mptcp_clean_una(struct sock *sk)
> > 
> > 		/* prevent wrap around in recovery mode */
> > 		if (unlikely(delta > dfrag->already_sent)) {
> > -			if (WARN_ON_ONCE(!msk->recovery))
> > +			if (!msk->recovery)
> > 				goto out;
> > 			if (WARN_ON_ONCE(delta > dfrag->data_len))
> > 				goto out;
> > @@ -1111,6 +1112,7 @@ struct mptcp_sendmsg_info {
> > 	u16 sent;
> > 	unsigned int flags;
> > 	bool data_lock_held;
> > +	struct mptcp_data_frag *last;
> > };
> > 
> > static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
> > @@ -1526,6 +1528,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
> > 		info->sent = dfrag->already_sent;
> > 		info->limit = dfrag->data_len;
> > 		len = dfrag->data_len - dfrag->already_sent;
> > +		info->last = dfrag;
> > 		while (len > 0) {
> > 			int ret = 0;
> > 
> > @@ -1562,14 +1565,19 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> > 	struct sock *prev_ssk = NULL, *ssk = NULL;
> > 	struct mptcp_sock *msk = mptcp_sk(sk);
> > 	struct mptcp_subflow_context *subflow;
> > +	struct mptcp_data_frag *head, *dfrag;
> > 	struct mptcp_sendmsg_info info = {
> > 				.flags = flags,
> > 	};
> > 	bool do_check_data_fin = false;
> > 	int push_count = 1;
> > 
> > +	head = mptcp_send_head(sk);
> > +	if (!head)
> > +		goto out;
> > +
> > 	while (mptcp_send_head(sk) && (push_count > 0)) {
> > -		int ret = 0;
> > +		int ret = 0, i = 0;
> > 
> > 		if (mptcp_sched_get_send(msk))
> > 			break;
> > @@ -1578,6 +1586,19 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> > 
> > 		mptcp_for_each_subflow(msk, subflow) {
> > 			if (READ_ONCE(subflow->scheduled)) {
> > +				if (i > 0) {
> > +					WRITE_ONCE(msk->first_pending, head);
> > +					mptcp_push_release(ssk, &info, do_check_data_fin);
> > +
> > +					while ((dfrag = mptcp_send_head(sk))) {
> > +						__mptcp_retrans(sk);
> > +						if (dfrag == info.last)
> > +							break;
> > +						WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> > +					}
> > +					goto out;
> > +				}
> > +
> > 				mptcp_subflow_set_scheduled(subflow, false);
> > 
> > 				prev_ssk = ssk;
> > @@ -1605,6 +1626,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> > 						push_count--;
> > 					continue;
> > 				}
> > +				i++;
> > 				do_check_data_fin = true;
> > 				msk->last_snd = ssk;
> > 			}
> > @@ -1614,6 +1636,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> > 	/* at this point we held the socket lock for the last subflow we used */
> > 	mptcp_push_release(ssk, &info, do_check_data_fin);
> > 
> > +out:
> > 	/* ensure the rtx timer is running */
> > 	if (!mptcp_timer_pending(sk))
> > 		mptcp_reset_timer(sk);
> > @@ -1628,13 +1651,18 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
> > 	struct mptcp_sendmsg_info info = {
> > 		.data_lock_held = true,
> > 	};
> > +	struct mptcp_data_frag *head;
> > 	bool keep_pushing = true;
> > 	struct sock *xmit_ssk;
> > 	int copied = 0;
> > 
> > +	head = mptcp_send_head(sk);
> > +	if (!head)
> > +		goto out;
> > +
> > 	info.flags = 0;
> > 	while (mptcp_send_head(sk) && keep_pushing) {
> > -		int ret = 0;
> > +		int ret = 0, i = 0;
> > 
> > 		/* check for a different subflow usage only after
> > 		 * spooling the first chunk of data
> > @@ -1659,18 +1687,27 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
> > 			ret = __subflow_push_pending(sk, ssk, &info);
> > 			if (ret <= 0)
> > 				keep_pushing = false;
> > +			i++;
> > 			copied += ret;
> > 			msk->last_snd = ssk;
> > 		}
> > 
> > 		mptcp_for_each_subflow(msk, subflow) {
> > 			if (READ_ONCE(subflow->scheduled)) {
> > +				if (i > 0) {
> > +					WRITE_ONCE(msk->first_pending, head);
> > +					if (!test_and_set_bit(MPTCP_WORK_RTX, &msk->flags))
> > +						mptcp_schedule_work(sk);
> 
> Hi Geliang -
> 
> It's not going to perform well enough to use the work queue for redundant
> sends.
> 
> MPTCP_WORK_RTX works ok for retransmissions because that is expected to be
> infrequent. A redundant scheduler would be sending everything on multiple
> subflows.
> 
> The retransmission code has some ideas for making redundant sends work, but
> redundant sending is different:
> 
> 1. I think the scheduler will need to store some sequence numbers at the msk
> level so the same data is sent on different subflows, even on the
> __mptcp_subflow_push_pending() code path. This is a change for regular (not
> redundant) schedulers too, and lets the schedulers select which subflows to
> send on AND what data to send.

Sorry, Mat, I didn't get this idea yet. Please give me more details
about it. We should add sched_seq_start and sched_seq_end in struct
mptcp_sock, right? These sequence numbers should be set in the BPF
context by the users, so we need to add sched_seq_start and
sched_seq_end in struct mptcp_sched_data too. Something likes:

        for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
                if (!data->contexts[i])
                        break;

                mptcp_subflow_set_scheduled(data->contexts[i], true);
		data->sched_seq_start = SN;
		data->sched_seq_end = SN + LEN;
        }

How can the users know what sequence number (SN) to write from? The
sequence number is generated in the kernel?

We can use (msk->sched_seq_end - msk->sched_seq_start) to replace
"msk->snd_burst", but I still don't know how to check these sequence
numbers in __mptcp_subflow_push_pending().

Thanks,
-Geliang

> 
> 2. The redundant send code should not behave exactly like retransmit. For
> example, don't call mptcp_sched_get_retrans() or use the retransmit MIB
> counters. Maybe it's simpler to have a separate function rather than add a
> bunch of conditionals to __mptcp_retrans()?
> 
> 3. When using the __mptcp_subflow_push_pending() code path, the
> MPTCP_DELEGATE_SEND technique should be used repeatedly until all
> redundantly scheduled subflows have sent their data.
> 
> 
> I'll check with other community members at the meeting tomorrow to see if
> some other ideas come up.
> 
> 
> > +					goto out;
> > +				}
> > +
> > 				mptcp_subflow_set_scheduled(subflow, false);
> > 
> > 				xmit_ssk = mptcp_subflow_tcp_sock(subflow);
> > 				if (xmit_ssk != ssk) {
> > 					mptcp_subflow_delegate(subflow,
> > 							       MPTCP_DELEGATE_SEND);
> > +					i++;
> > 					msk->last_snd = xmit_ssk;
> > 					keep_pushing = false;
> > 				}
> > -- 
> > 2.35.3
> > 
> > 
> > 
> 
> Thanks,
> 
> --
> Mat Martineau
> Intel
