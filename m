Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC7A7C
	for <mptcp@lists.linux.dev>; Thu,  9 Jun 2022 01:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654737847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tU8RpZFL9w7sPPHXnF5zvpknQqRm5pt/Xldn9a2g0mE=;
	b=WDUgPHOC1WQ3GNVUK5Cm7picPlKdCge841ugdwsqEI4M6tZSlhYCHntNrcU93GOmAaMmXm
	vwa+97w/x1g1W/qkSIcQ5TsAYjBcQyoE/aSG2ypYM7BBxNsIA43QnyBYO03X2i9ScGH4OB
	vZnDhuuizHp7RH3KQ54nF9+RweexyAw=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2110.outbound.protection.outlook.com [104.47.17.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-9Y0Gx-PUO1ymjsSOfurIGQ-1; Thu, 09 Jun 2022 03:24:07 +0200
X-MC-Unique: 9Y0Gx-PUO1ymjsSOfurIGQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZVHkkAz++1MVl6Qd6nu7GPFuNvdjbL4mqqUQgy6Rj+uWHyUk1L/YIlcTV74BMY4SOfsuOZueHzAgaN6NC4PQYdkltIEhzF+cR2uwJTtletTA1GiyiwCUKPlaLCTat8hrTw3d84FBQNvNSkT3LEumA4slTdIdmVTeBNWxlJ24/HBbYK93MhL9TAPKp+FblfNDuv8LP0F/UQNPI5zf1CYS7CtKB8wLKrTjJfZEe2cAQxSyYzW/6IHSFikv2MPIE/LnMWcAHw876G87ZBkITppyuih9JBN+uFV79EPxMA2dMVQpv/yntXpkMw0P5DBojWJG8+kx9+k9AKBADk4L310Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU8RpZFL9w7sPPHXnF5zvpknQqRm5pt/Xldn9a2g0mE=;
 b=aPHFASARTSz353FJxupo1MZCvO41LDm0ACmt5KP7/yTOomN8RLtDm1a05/B/3GQfblZPCUIlFBpYD7zFBoLHSJ5s1xrKAr9iSIolFygvcweIpX3fMz6KphUOBfJ7OifkGbh5kilHwhEWd5Q48QHsQb/6OfhsTDnM+RknLYRcx2LMLI45adAxo9ou5i+edFtSS5PSyeo4CXtwX/dzm0tsJoFKgOUQuHVXRhGJ7fYu0Ej84nCg/Ls264UDvg6NSEA0kGe+jJhgbBdhzXL2sLfNwpX8TqFctkvPNunvUcWTLePbf/dfyQ/+Rw52BGPl2E8eK1uL4h8zVcgAMvm4JnCDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU8RpZFL9w7sPPHXnF5zvpknQqRm5pt/Xldn9a2g0mE=;
 b=VwRKTdx5z2d/3y+vru9yPbPq5Uzff4S+gzd6scdsZWOLcwxmdbsnlLTuZXuSa2ly3VxYyL7qZx7j9ssBCKAoZX8igVhAaOFab6YaG9OiNowLUk81CwcqNv/PbpnLVEQqPcpHV5hgyq7Md6cBwnKGwmiVk2BDwCBVayRcxCpTVW3ZoY4l0XfZc3Hr/2bKIO/8tmu/LWpRa4oQQWX0PHT4GzhkCAp9eFJfzX9MNCpQ25LFNV9vNfygSj/LV/Ak3hHzvI6DyD/JsNtTViTyRrx6tzBfnlf+dyDgkAC+ZZivGvb5MsdHOERkvo68cV5JqcO4FL9vMQ2hkEMTu3xrVT3BuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8483.eurprd04.prod.outlook.com (2603:10a6:20b:34b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 01:24:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 01:24:04 +0000
Date: Thu, 9 Jun 2022 09:23:58 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 2/2] mptcp: trace MP_FAIL subflow in
 mptcp_sock
Message-ID: <20220609012358.GA19426@bogon.HOST>
References: <cover.1654732564.git.geliang.tang@suse.com>
 <005b6c1dda2ecb334cc9f6b07053aa59b69b5613.1654732564.git.geliang.tang@suse.com>
 <3ebc14e-ae9-a4ea-f0e0-4a9652a38f3d@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ebc14e-ae9-a4ea-f0e0-4a9652a38f3d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73a0f57c-bd58-493c-ed86-08da49b6bdd8
X-MS-TrafficTypeDiagnostic: AS8PR04MB8483:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB84832C06BF088CC6A930D09CF8A79@AS8PR04MB8483.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aPzOz1bTIRZ4qWOgiYqsxq9ZYJS4TJTuKeKYUW+7WcqPdMFYO18nz22CG7b4GHLt0GXs5CXxmbDLQUsscYcgtJCZSJXaxORvT8g287G5FY0Xj1Or+VMwiBZOaJ9Vznk9A7idiA0yYbDVWDoMKz7jLH1SVrJcyEcu4yma5UIaAfxiLOO0Tu0FUclxo0EErsIBTufJWOeQkHFV+uQljPAjHv9yNJ0+gJNEXvHtzhFtP7f0yJ/ZQn76UNFyyxy1n5hK+/SUoOE5nYQPMHXfrRehahSaVpmBcRP2LZpsyX8LP+D35YBS6wd2P561ECMkZ4Bqy0Iv45EhO07qOVtpfk7OGr33MnBc6JayczMAlnHtpgG5elma78otxzbg0qhmF4lHNkdV5/YKkN9zOohb8b5LnuDR0APvrwamDb12FNaXBzAa2xBccvTjGL39/MbO8Exbr6RruIyG703ws0MYI/JbUvsEvt1xYIrLp2VIbSQ/E7a47Y6Pvs8iuvDpNcOoAEg4lAXa9GN6JW8R1LQY9CCxCfttju8dtSsgg/4ptVrFI7zK2hsrFG3iRBdbMRwCR+BFpOi+IzDqYjLjTJE/qZtpvFx47DaLkVt247sXL094TadtjTqzDsTvb1Hy0pso2m9xPbLRSxLDtapCmIJneqKhLo0jd2I2moG3DG6DSdk/PVN4PxwQqYaFp+wMDwnyq/1r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(36756003)(6916009)(38100700002)(26005)(9686003)(6512007)(316002)(86362001)(186003)(6506007)(6486002)(66476007)(4326008)(66946007)(8676002)(2906002)(66556008)(83380400001)(8936002)(44832011)(33656002)(508600001)(5660300002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TI1Wdod4RemWoQ5AnkVLEcLfT/fDEDQ6Qd/C3QP8juGw9ImMUeys9+TWUC9H?=
 =?us-ascii?Q?cYam9IvfzAOOcYGXgxM3Mdd2Ivx7+bImVU5b4zyVM1lqXt+pjj31QMxLBBis?=
 =?us-ascii?Q?e+J/DAwjv6jhm0f49ff93gl7WQ7cNTKLjHkeRALmcB9NmHfZPhZWe6szL8xr?=
 =?us-ascii?Q?ZKa+O9niGV8gHe/bFdpYcSvgQQMV32TdrjLYEUJ1VdHIDIYc4GDtrlDU4ayp?=
 =?us-ascii?Q?Qqsq5Ln2VYLOXZfkBKwgs7pJBNvouCDN/SYjhJPthasJW0HKGCRSsmnkHrSz?=
 =?us-ascii?Q?BRohIUvJGuhZDFzZGQAfb+xPKyBGVn8V2ahuc+15bdQRdML/uOKG4VGaLVgI?=
 =?us-ascii?Q?qI1Dr9OvdU0kCXdZk3Obwzs63k7l3+2sT7M6xu/I2wq3ehTbl+j8IruOVVk6?=
 =?us-ascii?Q?xs+RNdZRPmilJsH4w4gU4utW4L9VCONzAFLLXlpnJi+c6XPGIz6xsA/CZBFc?=
 =?us-ascii?Q?szOMvTQzVRJMKDrIEia87n2bK5TrxypY9NkAQ29ij2wBAGxHBtFi/xQ8Ga9/?=
 =?us-ascii?Q?16WbeE+Gjl8mCX4Ci/uFEu43ozhR4Vx2C9bgIm8KwcQHCuHPoOq4YNQ2bLjT?=
 =?us-ascii?Q?+icQ2Lr7xSSr91ozpb6rlMf9YfMMV9EEAAkw/GShtoQbNSFFj7vXJDlngSuh?=
 =?us-ascii?Q?xZJhzmzPFgzQiVODtwQ2HinXYT3Hu+1TorjLd2U1NIW0IQ7ChukMhFacLOC3?=
 =?us-ascii?Q?xdZrh02K9DQb/kmgI+GHk3GRAZyuSv4yFJpFcaVQeMD7LeWcLuHkbuoUf/Q5?=
 =?us-ascii?Q?6bD/eIPHLEKuaGwCtKGpEAjIe/fs9bBApO/jRHSDxMjBLhiitUZr05uFOpbw?=
 =?us-ascii?Q?8LWkfAfJLpRDeRccQ0upNJaKZHQAHll2okGkYRk8lMQmWhCatwEYpadICOG6?=
 =?us-ascii?Q?YjxZEHX4qi1Osqb1WUagvx/ewX/aWM4vm4dyMBIRh7XsJcSttmb+yUgVslpQ?=
 =?us-ascii?Q?JS+PEsSfzYAyWurJ3cnLlZ2DgKv1BZDR8h2WussxXIh0lSxjChswRiGFohEZ?=
 =?us-ascii?Q?jUvQy6yjOeXItauhriMYkLUZRll0RVdaxf3F2+xqhA3XioIY+w9KOrEPMOMk?=
 =?us-ascii?Q?y9GPm3UmvnxVQ9xbdgruMNPt2ncB0HwwQqOqE0w9n7UMzbawGUGfij6h3GLk?=
 =?us-ascii?Q?lFLBn8eOTUGworvpiFl86srThQKVZgx56vrq1NokZD0AzoHhDsg1Z9SaNW4z?=
 =?us-ascii?Q?TzGKSFFgXnOROvbPOn59+42yJHSKCfoyDnnACwDyxHl5jQBdIAPnkJfLKep9?=
 =?us-ascii?Q?ZVm9VkzOFYGRTaCFKQsTWyiKtwZgcfHDME6U4qWl4oNrRmXynUMqEtriucZ6?=
 =?us-ascii?Q?uuXtw1XVzzX5XIuATR2SF09sesfSW++XgDBKvmistiACW8BOCGR4sW8DllUl?=
 =?us-ascii?Q?Z/+mAselA2L6ihZ1XWBM/qwBptbAjOnxko5m8JU0Is/gitZfEryD3WUqxcN4?=
 =?us-ascii?Q?P+ziRIHOrWG527TRyjO5WTmnfKl5woG2cOET0Lsuo2P4cN+/dok3EBAIP1Qu?=
 =?us-ascii?Q?jAeBDLjE3uTQq6gXPX6vQT+liVdvLiVXbfGiLLR/JDS4//B+RCdz0VbT7nd0?=
 =?us-ascii?Q?VDcq7ZB3bM3xlWIhMuUWVmz+N5CrrfLKT1bkuyJlv7gBnnwDN7qv8BIxq07R?=
 =?us-ascii?Q?40LV1d7gwFvDSROdadAw1wzRUhmDWOsmTDtIi5gNmYJmUQrgcSYZ9xk4S4OP?=
 =?us-ascii?Q?4s2O81OdEulCY0bXN3i9bAdwwGC3zIfnCF62A78OK3cljdgw7yqikEAjBOML?=
 =?us-ascii?Q?JnTRzsB+9tlmh8h4o2wiiVzxGg4JBbw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a0f57c-bd58-493c-ed86-08da49b6bdd8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 01:24:04.6832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1hf1d+ZDotuO1xdHRxyAH8SV0GeMEIcr3wRt513ihZ8P72HSeCdADk6MYZr4wTFWKjVbC9gvsz6oI/04pVg7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8483

On Wed, Jun 08, 2022 at 05:31:00PM -0700, Mat Martineau wrote:
> On Thu, 9 Jun 2022, Geliang Tang wrote:
> 
> > This patch adds fail_ssk struct member in struct mptcp_sock to record
> > the MP_FAIL subsocket. It can replace the mp_fail_response_expect flag
> > in struct mptcp_subflow_context.
> > 
> > Drop mp_fail_response_expect_subflow() helper too, just use this fail_ssk
> > in mptcp_mp_fail_no_response() to reset the subflow.
> > 
> > Acked-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> > net/mptcp/pm.c       |  2 +-
> > net/mptcp/protocol.c | 35 +++++++++--------------------------
> > net/mptcp/protocol.h |  2 +-
> > net/mptcp/subflow.c  |  2 +-
> > 4 files changed, 12 insertions(+), 29 deletions(-)
> > 
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index 45a9e02abf24..2a57d95d5492 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -305,7 +305,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> > 	if (!READ_ONCE(msk->allow_infinite_fallback))
> > 		return;
> > 
> > -	if (!READ_ONCE(subflow->mp_fail_response_expect)) {
> > +	if (!msk->fail_ssk) {
> > 		pr_debug("send MP_FAIL response and infinite map");
> > 
> > 		subflow->send_mp_fail = 1;
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 917df5fb9708..58427fabb061 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2167,21 +2167,6 @@ static void mptcp_retransmit_timer(struct timer_list *t)
> > 	sock_put(sk);
> > }
> > 
> > -static struct mptcp_subflow_context *
> > -mp_fail_response_expect_subflow(struct mptcp_sock *msk)
> > -{
> > -	struct mptcp_subflow_context *subflow, *ret = NULL;
> > -
> > -	mptcp_for_each_subflow(msk, subflow) {
> > -		if (READ_ONCE(subflow->mp_fail_response_expect)) {
> > -			ret = subflow;
> > -			break;
> > -		}
> > -	}
> > -
> > -	return ret;
> > -}
> > -
> > static void mptcp_timeout_timer(struct timer_list *t)
> > {
> > 	struct sock *sk = from_timer(sk, t, sk_timer);
> > @@ -2507,19 +2492,16 @@ static void __mptcp_retrans(struct sock *sk)
> > 
> > static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
> > {
> > -	struct mptcp_subflow_context *subflow;
> > -	struct sock *ssk;
> > +	struct sock *ssk = msk->fail_ssk;
> > 	bool slow;
> > 
> > -	subflow = mp_fail_response_expect_subflow(msk);
> > -	if (subflow) {
> > -		pr_debug("MP_FAIL doesn't respond, reset the subflow");
> > +	pr_debug("MP_FAIL doesn't respond, reset the subflow");
> > 
> > -		ssk = mptcp_subflow_tcp_sock(subflow);
> > -		slow = lock_sock_fast(ssk);
> > -		mptcp_subflow_reset(ssk);
> > -		unlock_sock_fast(ssk, slow);
> > -	}
> > +	slow = lock_sock_fast(ssk);
> > +	mptcp_subflow_reset(ssk);
> > +	unlock_sock_fast(ssk, slow);
> > +
> > +	msk->fail_ssk = NULL;
> > }
> > 
> > static void mptcp_worker(struct work_struct *work)
> > @@ -2562,7 +2544,7 @@ static void mptcp_worker(struct work_struct *work)
> > 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
> > 		__mptcp_retrans(sk);
> > 
> > -	if (time_after(jiffies, msk->fail_tout))
> 
> Hi Geliang -
> 
> This condition could be unexpectedly true depending on how close 'jiffies'
> is to wrapping around, if msk->fail_tout remains at its default 0 value...
> 
> > +	if (msk->fail_ssk && time_after(jiffies, msk->fail_tout))
> 
> ...so it's important to fix it like this!
> 
> I think the two patches should be re-squashed to avoid introducing the issue
> in the previous commit. Sound good?

Sure. Please update the subject and commit log when squashing this patch:

'''
mptcp: refactor MP_FAIL response

mptcp_mp_fail_no_response shouldn't be invoked on each worker run, it
should be invoked only when MP_FAIL response timeout occurs.

This patch refactors the MP_FAIL response logic.

Add fail_tout in mptcp_sock to record the MP_FAIL timestamp. Check it
in mptcp_worker() before invoking mptcp_mp_fail_no_response(). Drop
the code to reuse sk_timer for MP_FAIL response.

Add fail_ssk struct member in struct mptcp_sock to record the MP_FAIL
subsocket. It can replace the mp_fail_response_expect flag in struct
mptcp_subflow_context. Drop mp_fail_response_expect_subflow() helper,
just use this fail_ssk in mptcp_mp_fail_no_response() to reset the
subflow.
'''

Thanks,
-Geliang

> 
> Also, I think the change should be for mptcp-net so we can get the fix in to
> 5.19-rcX
> 
> Thanks!
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> 
> 
> > 		mptcp_mp_fail_no_response(msk);
> > 
> > unlock:
> > @@ -2590,6 +2572,7 @@ static int __mptcp_init_sock(struct sock *sk)
> > 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
> > 	WRITE_ONCE(msk->allow_infinite_fallback, true);
> > 	msk->recovery = false;
> > +	msk->fail_ssk = NULL;
> > 	msk->fail_tout = 0;
> > 
> > 	mptcp_pm_data_init(msk);
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index f7b01275af94..bef7dea9f358 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -306,6 +306,7 @@ struct mptcp_sock {
> > 
> > 	u32 setsockopt_seq;
> > 	char		ca_name[TCP_CA_NAME_MAX];
> > +	struct sock	*fail_ssk;
> > 	unsigned long	fail_tout;
> > };
> > 
> > @@ -469,7 +470,6 @@ struct mptcp_subflow_context {
> > 		local_id_valid : 1, /* local_id is correctly initialized */
> > 		valid_csum_seen : 1;        /* at least one csum validated */
> > 	enum mptcp_data_avail data_avail;
> > -	bool	mp_fail_response_expect;
> > 	bool	scheduled;
> > 	u32	remote_nonce;
> > 	u64	thmac;
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 866d54a0e83c..5351d54e514a 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -1235,7 +1235,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
> > 				while ((skb = skb_peek(&ssk->sk_receive_queue)))
> > 					sk_eat_skb(ssk, skb);
> > 			} else {
> > -				WRITE_ONCE(subflow->mp_fail_response_expect, true);
> > +				msk->fail_ssk = ssk;
> > 				msk->fail_tout = jiffies + TCP_RTO_MAX;
> > 			}
> > 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
> > -- 
> > 2.35.3
> > 
> > 
> > 
> 
> --
> Mat Martineau
> Intel
> 

