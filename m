Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E184624
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 21:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645133829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N0YaEmVlJi8ieDbCVnbKAfmmzz00Bbf5d3sleEQeAmQ=;
	b=OKx4VzhlBL4Idswxc/dV90ErfNIDg0zwjxfsrRb1dsDgD0nIZGUH1FxoyJ4flYGa0vhmnD
	v/tFegSwKSS77cPyAuim/56m3Z27OW4qr3IKI7HZxF8i969HXQOCbbe/xk/fGwO+X577V3
	0pZwYpbsd0yYzV7VcSa+HZtPks+sNL0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-xabWva7zNJe24dpqa9DzGw-1; Thu, 17 Feb 2022 16:37:04 -0500
X-MC-Unique: xabWva7zNJe24dpqa9DzGw-1
Received: by mail-wr1-f71.google.com with SMTP id u9-20020adfae49000000b001e89793bcb0so1349013wrd.17
        for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 13:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=N0YaEmVlJi8ieDbCVnbKAfmmzz00Bbf5d3sleEQeAmQ=;
        b=XNfizXwWKaWIie8u5T9XPQGLem4bazZddfBpok01EDq+mflG2W76pC0zom9MUgEcrj
         W9yRVYbi+aEaqqe0e2gc7tfOxFGjqKxPAVqGghUMUdmOeTwyu49MQ1agzcvShaGeKuEC
         2th6SCvtE77iQKB5o9fiHcKf3DPXwmZe/gOS6PYUTSLAsaz6LbHCtmz4o+DmvANVvss6
         5m3Df9/ogRlCLXkhiBIgFwFJEA4ytZl07LsVBGhtrEWFsECtihh+kqjkgZqcl+7J/Rv1
         f3Q0kF6kY2ZBImL4SsjlG29RviONYSLDbtB9wi7wkQHV69p9+jrEMFwOtv2ZXQsF3gqL
         skHg==
X-Gm-Message-State: AOAM5321d+yhD6t47kLGEn5O3eEDfXYgw1eOLurvOzWtKT04sgmVO7iM
	pAQb+o4rV6aKR9JYTTdNEFVhDBRGiIGFiIrJp8OWLjGn2bJWlftD6KxDIBewyvy+/VNibj6lFpW
	dcxI0D5ALlxYtpjc=
X-Received: by 2002:adf:f408:0:b0:1e3:148c:375 with SMTP id g8-20020adff408000000b001e3148c0375mr3674713wro.464.1645133822885;
        Thu, 17 Feb 2022 13:37:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDQfQkqxorwhwctQ1JoOtkL33evSEIAmHMEK7QPcMVbzNVH4vwvdN237qajcOpXBT+0nhiNg==
X-Received: by 2002:adf:f408:0:b0:1e3:148c:375 with SMTP id g8-20020adff408000000b001e3148c0375mr3674706wro.464.1645133822662;
        Thu, 17 Feb 2022 13:37:02 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-112-206.dyn.eolo.it. [146.241.112.206])
        by smtp.gmail.com with ESMTPSA id t187sm2257592wma.22.2022.02.17.13.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 13:37:02 -0800 (PST)
Message-ID: <4301e70ec02a98f657caf32590773e789d117f21.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: Correctly set DATA_FIN timeout when
 number of retransmits is large
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Date: Thu, 17 Feb 2022 22:37:01 +0100
In-Reply-To: <20220212010447.119486-1-mathew.j.martineau@linux.intel.com>
References: <20220212010447.119486-1-mathew.j.martineau@linux.intel.com>
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2022-02-11 at 17:04 -0800, Mat Martineau wrote:
> Syzkaller with UBSAN uncovered a scenario where a large number of
> DATA_FIN retransmits caused a shift-out-of-bounds in the DATA_FIN
> timeout calculation:
> 
> ================================================================================
> UBSAN: shift-out-of-bounds in net/mptcp/protocol.c:470:29
> shift exponent 32 is too large for 32-bit type 'unsigned int'
> CPU: 1 PID: 13059 Comm: kworker/1:0 Not tainted 5.17.0-rc2-00630-g5fbf21c90c60 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Workqueue: events mptcp_worker
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  ubsan_epilogue+0xb/0x5a lib/ubsan.c:151
>  __ubsan_handle_shift_out_of_bounds.cold+0xb2/0x20e lib/ubsan.c:330
>  mptcp_set_datafin_timeout net/mptcp/protocol.c:470 [inline]
>  __mptcp_retrans.cold+0x72/0x77 net/mptcp/protocol.c:2445
>  mptcp_worker+0x58a/0xa70 net/mptcp/protocol.c:2528
>  process_one_work+0x9df/0x16d0 kernel/workqueue.c:2307
>  worker_thread+0x95/0xe10 kernel/workqueue.c:2454
>  kthread+0x2f4/0x3b0 kernel/kthread.c:377
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>  </TASK>
> ================================================================================
> 
> This change limits the maximum timeout by limiting the size of the
> shift, which keeps all intermediate values in-bounds.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/259
> Fixes: 6477dd39e62c ("mptcp: Retransmit DATA_FIN")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
>  net/mptcp/protocol.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3324e1c61576..a4171236091a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -466,9 +466,12 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
>  static void mptcp_set_datafin_timeout(const struct sock *sk)
>  {
>  	struct inet_connection_sock *icsk = inet_csk(sk);
> +	u32 retransmits;
>  
> -	mptcp_sk(sk)->timer_ival = min(TCP_RTO_MAX,
> -				       TCP_RTO_MIN << icsk->icsk_retransmits);
> +	retransmits = min_t(u32, icsk->icsk_retransmits,
> +			    ilog2(TCP_RTO_MAX / TCP_RTO_MIN));
> +
> +	mptcp_sk(sk)->timer_ival = TCP_RTO_MIN << retransmits;
>  }
>  
>  static void __mptcp_set_timeout(struct sock *sk, long tout)

LGTM!

Acked-by: Paolo Abeni <pabeni@redhat.com>

(I think the the suggested-by tag could be dropped here)

