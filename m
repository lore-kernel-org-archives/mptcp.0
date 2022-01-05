Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFDB168
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 10:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641378544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bP0ifQBPInceXdYTrlswaYOTDCW25JpU2racU9CxRgs=;
	b=i5GMlRhPPL1PJ4W7Zo8g+AiDlduIRPp24bgkdp64Y/q2puJ4vwogMo8lSaDdK4DtcWiXF9
	Ke0KNwzI+YBLbg++aND2Ho4wLXwlSvVb71RNr8gxdNEBpxT7dmVeuk4qXmtRa1+8IMNTJw
	+62kFO8V5mCOHROPm5dCLye/uGw2b7I=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-u4xc0_GcOjatGc-8jzuBPg-2; Wed, 05 Jan 2022 11:29:03 +0100
X-MC-Unique: u4xc0_GcOjatGc-8jzuBPg-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khzhSaHLH3mim/pax8HjPhqtsgMTA11LO2M9sXj/7WAtL9UqYiJUhD7qrS5rj9CTUxWdnH4FaqOCYOeEkg9/1a+Hqb9APQ6Z4uwJMeZlScttUjsICdo6NGpZ+jXWAFkzxbxtnnH+3RvaAjgYtQxcHioMcqEIFlsovSOB6usnBpvsDfwj3SOCqlY4+MHBnFzx5WhXZvni3iU8Kq/WMO8Pezk0kDdiVxDinNLqzRgjoc85zx3PKf2/0gFBu7oIz+yDsiFffs+m/Rz3JKwvldZaVJ/FHOOHVPVlSsyGIOrVXz23sEjuhDA4Nwr83uQa/FbGR87WDFHUTiazRltBOk2H3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP0ifQBPInceXdYTrlswaYOTDCW25JpU2racU9CxRgs=;
 b=EY46sLz6YMPeBgALk/x1WkgDSW80yqBsp8+FmV27loXok1Cdp+bTCWYowqm7mLkMjyYGXBxQ1TKmo3Lcs8oBQBlQPmilXZCNdKMlKcAIqQdh7dSZ4Eq0+rFVSwxOcVOHwgV+VdvtUVqRzIulDZFt6eGea2uBB9fMEH8ZKK88VtsTcskRN9Bx2xARQR2/Fp1Fe9vUG1n0H/wwYGu5DeuqMgHFmNvREU7vD2FKk6jvRCIkal8pVr/AcNf1AkpHwelV3QXeuaXcoGSA8p70AsaMSY4smy1NHK0yp78XLbXVVJgo72Ts6v0RPyqq5LGDqb8Y8dpv97+EZL9X1nXdvvFtgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3434.eurprd04.prod.outlook.com (2603:10a6:7:8d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 10:29:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 10:29:01 +0000
Date: Wed, 5 Jan 2022 18:28:48 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 1/4] Squash to "mptcp: implement fastclose
 xmit path"
Message-ID: <20220105102848.GA8074@dhcp-10-157-36-190>
References: <20211230191651.1831507-1-matthieu.baerts@tessares.net>
 <20211230191651.1831507-2-matthieu.baerts@tessares.net>
 <20220105085043.GA3255@dhcp-10-157-36-190>
 <9dcec4f1-26ea-ade8-7547-93fef53922b0@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dcec4f1-26ea-ade8-7547-93fef53922b0@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0171.apcprd02.prod.outlook.com
 (2603:1096:201:1f::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1a84cb7-d127-41d4-0a38-08d9d03630ae
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3434:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3434F5B8461D6678CC645B5BF84B9@HE1PR0402MB3434.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rydMlmTN8Mu9ROvtchBgiN5k38bLpDRpBH+MY9/beY1KIj9tY990K1M2c4lF+a3+Q1NBorNkjzN6jAgMM4zjHEVyWUI5WmPFY30bnUBa2izfjdHT5cNT09C13twLK9jJ0b2UI5OPptBUAIiHt0+dYYqtF6M95rzqGYR9PV1cnih4JGhqCzmSJ9JWU5Dyb8xYmwUxiUmFWQQH4QMgPwgXUMmyZ1rudPbbAUI1XFlfz/REMwOx+dqcrcmwQa6ZQiA68p0ryjkoTNCJm7vZ4mKndw5MTDK6KfLJ/98iR6j+OHNXKD7IWoI3a8AeUin+uloj3tO2ZvRbNjV0ZwuZoVbcBnyH8B09bfz7QMu/jhegPw7ByvLAUT4+rixrTHJz57YN1qiMF1Xt3w40WOT4Z+ihGwnXcL32dmaCjx72D2D4nUi0lFq7VME3Z9ffNHS+qApDreHg1e5ColTXclg/1M1WqaV3xICeFTy4dLvAJj45y2aOSCM9YhJm/wjgj5r3iKlawJNltiDkPc9ZWv/87tGCTeVAQu3RA1a881FNugRk7SonrOcC8DfEsk4ZjHwgeG6jw01pCcDsVck0hMXgYxopW1z2eV3zbGA7wWIXi8HmBUo+FgP8vtnyhqBzb+hqk+LeQ6EHtxbdU80Uf7HMWGxeWNhDG19rzU+T3ysrMmGyADJYmXFBqyOosj0U/6EJGOr5xJEY4qNV9EdgxlWakUhdnVo5Q83FQZvaTMp5OJJkZGk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(38100700002)(4326008)(33656002)(8676002)(5660300002)(86362001)(1076003)(6916009)(186003)(6512007)(9686003)(316002)(33716001)(66476007)(26005)(66556008)(6486002)(2906002)(8936002)(508600001)(44832011)(53546011)(83380400001)(6506007)(15974865002)(66946007)(6666004)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?52l/R52uZJehupiZdT44rEqONt7oTFhxT0aeEn7rVdUV5XQP1B1Ts6d4jQDt?=
 =?us-ascii?Q?QNjrrhfZ0MuGX3jPy8Uzdj6g8J2vWRNq8WlKdy/0uOw5fn09N2IhQ39FdAOk?=
 =?us-ascii?Q?qE0tSqAsJLKduCR2Vjp5LVvY6VMuQqYhSddmqG3wufQr2N5uG0WjQJ0CkJqI?=
 =?us-ascii?Q?pZ+DUZw8Gh0G0bfRrBaRI+fVJt1mOSqzC6LHHIkXCAxYa+2SErMiim0XchYf?=
 =?us-ascii?Q?EMGcf2my2vmk8q38Ew2JORw6P+rExoPfy/3hj2jor+E96A9w2YhuoWHhCp1T?=
 =?us-ascii?Q?qwIBMrrDb/SBlZ+me9aC0VTc26JPXEM8rgIQT4Bkn5SOHXWxkG722Z6R9T8N?=
 =?us-ascii?Q?C+/hVQ8oEcbbOQMixHCPUKwR44Pmfllx/6h7aH3E1paCFczlpiws9+EnPBob?=
 =?us-ascii?Q?Aq/LJNmk4POzB6zsCRupUojTUnix3s47gbhYcGSg810YCd7A8PwPs3VJU1+E?=
 =?us-ascii?Q?K+JiZvOasr2itxxhJpq7QlNYpZGT06Gvus7xv3bxtsiCkrMe3xkRRoWxz9LM?=
 =?us-ascii?Q?hGUL2s+/ywJREC2DuOFjcNvrEIpc56wG0wYzQ0IwKrSq00F1VjddBEtI5fhV?=
 =?us-ascii?Q?BuvTdCgvGr2rGVjJcbt4+YoKvu8k13qFOInKOxkuMc93jxyaW6rkh6AHpkSF?=
 =?us-ascii?Q?MZ2GT4dAVg9Wn6ZF7Lsw6E9Vp1IDxq2AGpKxx5GoV1QpjBZsIP4qB+OO7ivZ?=
 =?us-ascii?Q?1f+CbN09FbXgfDdV2GXHHHsSGTFEHrIrXVrVSCifubQtYroPdvIUDqDCVVOR?=
 =?us-ascii?Q?bTbjxPQJZFxvv31wDGhHMWxmbNKvGiPHhixCS+jMxwThaOWQ2Y8cfUf9cVM5?=
 =?us-ascii?Q?xxlf4wzEa+wfeqRpvYyLF4pMBFXlY5B75G/+CKgG579svlEDNHPnkzmGKaDa?=
 =?us-ascii?Q?0+n94ZGeI9BDd33ZKneGJIc0oks8EGz5iO52ufQ3wMH2bxilXi87N+z2O9n4?=
 =?us-ascii?Q?1udw/JPCK4UAY2jRYaoo8ro3BeRT6/+myT+CQfV+ixpxM/hMl8FuLg5u/nTQ?=
 =?us-ascii?Q?VLJbqOzMO7GBAn8RGlEn0NxpO8CVzuMi2TU38nUeHJjy6ps1TztJo002Gvk6?=
 =?us-ascii?Q?EULaGNP13/Ql15zBMGByXQ2iNNTUiMADout/OZkW1u/Wt868uxNROT9TvQra?=
 =?us-ascii?Q?Oi/FbkekS46DpO93bPjB7TJUAfE0hy/VnkHsDYbdoAfmJ6LWReoNtWr2aMpE?=
 =?us-ascii?Q?yi6UEG1KJGPJbnPPUtEKM/E98qMj0kfd2PUyokDC8WHmDPD0HPABYXf96h6/?=
 =?us-ascii?Q?ajDslTa5UORyFokgGzecqMpYKDm/Xo60oXkeC9Tqz4mU2Kgt4ztDF1PJO7qD?=
 =?us-ascii?Q?adfgM4C/gIHcXhwD7S95Ufe4RAIRteNj6FZ7cn9btFS9NizPxH+W5DWxOv+G?=
 =?us-ascii?Q?A1q8v1GiWlsJYv7wCww8sbaoVMDyphLc6dNkQH8rNvDCC3WpFy1HalEY56ZO?=
 =?us-ascii?Q?q40uK/7GUkMrkgEnFf4CPnAre3gODWS7TzLDAiqmzBSyTC4sdKl3UsSr0Iel?=
 =?us-ascii?Q?NPzY6a8mDgLxOTyPuxCV1HMSFOB5DN0vpclypBGK+z9kWvG8SRShplTNqOIH?=
 =?us-ascii?Q?TNxCG1DWSj+aSBRwa0VAvVIgkG66E6c/IzmJWvy7QIsF1haxBrXnI1Xdu9Ag?=
 =?us-ascii?Q?Xvf5EJSEO4Eayy9RCEEZmWg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a84cb7-d127-41d4-0a38-08d9d03630ae
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 10:29:01.6596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7L6vmOzbS8QLEGyF3hQQLvLsGck1NWPDG+PaERt2yfOFnr05D8Y/bFjhYTcWxgYR0OIWRuFnMoILR7XfMT63aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3434

On Wed, Jan 05, 2022 at 11:01:59AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 05/01/2022 09:50, Geliang Tang wrote:
> > On Thu, Dec 30, 2021 at 08:16:48PM +0100, Matthieu Baerts wrote:
> >> From: Geliang Tang <geliang.tang@suse.com>
> >>
> >> MP_FAIL could be sent with RST or DSS, and FASTCLOSE can be sent with
> >> RST too. So we should use a similar xmit logic for FASTCLOSE and
> >> MP_FAIL in both mptcp_write_options() and mptcp_established_options*().
> >>
> >> Cc: Paolo Abeni <pabeni@redhat.com>
> >> Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> >> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> >> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> >> ---
> >>  net/mptcp/options.c | 66 ++++++++++++++++++++++++++++-----------------
> >>  1 file changed, 41 insertions(+), 25 deletions(-)
> >>
> >> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> >> index c6726e8389ec..9d2c1c9edbe6 100644
> >> --- a/net/mptcp/options.c
> >> +++ b/net/mptcp/options.c
> >> @@ -829,8 +829,12 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> >>  
> >>  	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
> >>  		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
> >> -		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
> >> -		    mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
> >> +		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
> >> +			*size += opt_size;
> >> +			remaining -= opt_size;
> >> +		}
> >> +		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
> >> +		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
> >>  			*size += opt_size;
> >>  			remaining -= opt_size;
> >>  		}
> >> @@ -1257,21 +1261,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
> >>  void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> >>  			 struct mptcp_out_options *opts)
> >>  {
> >> -	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
> >> -		const struct sock *ssk = (const struct sock *)tp;
> >> -		struct mptcp_subflow_context *subflow;
> >> -
> >> -		subflow = mptcp_subflow_ctx(ssk);
> >> -		subflow->send_mp_fail = 0;
> >> -
> >> -		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
> >> -				      TCPOLEN_MPTCP_FAIL,
> >> -				      0, 0);
> >> -		put_unaligned_be64(opts->fail_seq, ptr);
> >> -		ptr += 2;
> >> -	}
> > 
> > Hi Matt,
> > 
> > Sorry, this patch doesn't work on my test. We write both DSS + MP_FAIL,
> > but MP_FAIL is lost on the received side. Only DSS is received.
> > 
> > If we write MP_FAIL + DSS like the orignal code, MP_FAIL and DSS will be
> > received correctly.
> > 
> > I haven't figured out why yet.
> > 
> > Could we just keep this MP_FAIL writting code still at the beginning of
> > the function just like the orignal code did?
> 
> Thank you for having tested and reviewed the series!
> 
> Is this issue here fixed by your patch you sent a couple of minutes ago
> (mptcp: fix a DSS option writting error)

No, the commit (mptcp: fix a DSS option writting error) can't fix this
issue. I haven't found a solution yet. But I noticed if we move the
MP_FAIL writting at the beginning of the function like the orignal code,
it works.

(MP_FAIL + DSS) works, but (DSS + MP_FAIL) doesn't.

> 
> That would make sense as the only thing I did was to send the MP_FAIL
> after the DSS option.
> 
> Do you mind if I send a v8 series with your new fix the missing 'ptr +=
> 2;' below and have the code moving the writing of the MP_FAIL option
> later in a dedicated commit?

Please send a new version, thanks very much.

By the way, you can use the commit ([mptcp-next,v5] selftests: mptcp: add
mp_fail testcases) to test this patch.

Run this command:

./mptcp_join.sh -F

In the multiple subflows testcase, make sure MP_FAIL + MP_RST are sent and
received correctly.

In the single subflow testcase, make sure MP_FAIL + DSS are sent and
received.

Thanks,
-Geliang

> 
> > 
> >> -
> >> -	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
> >> +	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and FAIL are mutually exclusive,
> >>  	 * see mptcp_established_options*()
> >>  	 */
> >>  	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
> >> @@ -1328,6 +1318,10 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> >>  						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
> >>  			}
> >>  		}
> >> +
> >> +		/* We might need to add MP_FAIL options in rare cases */
> >> +		if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions))
> >> +			goto mp_fail;
> >>  	} else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
> >>  		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
> >>  
> >> @@ -1460,19 +1454,41 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> >>  				ptr += 1;
> >>  			}
> >>  		}
> >> -	} else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
> >> -		/* RST is mutually exclusive with everything else */
> >> -		*ptr++ = mptcp_option(MPTCPOPT_RST,
> >> -				      TCPOLEN_MPTCP_RST,
> >> -				      opts->reset_transient,
> >> -				      opts->reset_reason);
> >> -		return;
> >>  	} else if (unlikely(OPTION_MPTCP_FASTCLOSE & opts->suboptions)) {
> >> -		/* FASTCLOSE is mutually exclusive with everything else */
> >> +		/* FASTCLOSE is mutually exclusive with others except RST */
> >>  		*ptr++ = mptcp_option(MPTCPOPT_MP_FASTCLOSE,
> >>  				      TCPOLEN_MPTCP_FASTCLOSE,
> >>  				      0, 0);
> >>  		put_unaligned_be64(opts->rcvr_key, ptr);
> > 
> > Here, 'ptr += 2;' is needed.
> 
> Good catch!
> 
> Note related to my modification but to "mptcp: implement fastclose xmit
> path" so it should be in this squash-to patch!
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

