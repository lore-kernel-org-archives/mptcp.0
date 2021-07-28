Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE9C70
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 10:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627468564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QBypjUdBiz4/kvPKwYMUXM8uSgx+PlC5AKFE8H4LqfI=;
	b=ir7CKSHVOjqHey8Z85HEMEoDRLupPXP0D4Xhe2SRPZQohb2EEy1AjxoGtHA1GymH5PZM3h
	3LMVFHLuuHwD/qiRonODsxslG/HWgzTKXlufrP9GqRL6J/h4uYigHeL/c2YBqVrVeeVDcK
	U7Wu1c/29LyyGPd63qa28j4iAx9cA/k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-u-YKr4vCPcuClj70FejgoQ-1; Wed, 28 Jul 2021 06:36:03 -0400
X-MC-Unique: u-YKr4vCPcuClj70FejgoQ-1
Received: by mail-wr1-f71.google.com with SMTP id u26-20020adfb21a0000b029013e2b4a9d1eso765929wra.4
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 03:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QBypjUdBiz4/kvPKwYMUXM8uSgx+PlC5AKFE8H4LqfI=;
        b=T9z8S/gsZ+KFINoNnTxnQTeB53HgHL0rxDe+jIAeSrOVFLg3jcTgLB8Cu8ssFmsPvN
         tD9BJUkgVvs0TG9/Ugy/L+w+Hg6S9WY237oEeqBjGUZBPwM+l9djz3USCYY0Ef2x5m21
         zKpO+bSv+84rz7Qi2o7t7gdAFHwx8U3EmQ37zsj9ydiK9R6FGi7+bUOTPXCxi7VkeE8m
         gLAeDJvYxop64jqaPfuQxyCYKAFK/3xrq4FwuSHExoFkIR1sRA+Emqxi9tmSkZJs54Uh
         zea+nYXNhC6Gr8ftKUq8Sj4BQWngbw8F25muRsVnU9PVVwQ6HoRdCJ74zMiAlu+MVqi2
         P/QQ==
X-Gm-Message-State: AOAM5303LvFoesRuI8vF5lILZcS518WSiK33sEh6Lc6YpOwZgmMOL9J/
	TYq2ZHNPq1+masA3ANrilsGzaV754oPlBf0QlxL/zc2rWo4hDTD80yDyyHKkLa3sJcGw1Hbrt6/
	OwSLotkQYesKaH+o=
X-Received: by 2002:adf:f6ca:: with SMTP id y10mr29066300wrp.211.1627468561827;
        Wed, 28 Jul 2021 03:36:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzx2JpEh6j3l+vLs8gjtPX9UOZGZGTs0uU2jBCr8gCQmrUYbsHiyqU+G0zcbZpDEIwNTxOGSg==
X-Received: by 2002:adf:f6ca:: with SMTP id y10mr29066289wrp.211.1627468561697;
        Wed, 28 Jul 2021 03:36:01 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id u11sm6148375wrp.26.2021.07.28.03.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 03:36:01 -0700 (PDT)
Message-ID: <eb3602e3f2a3550e9c1c27e2b5e3428562ac1010.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v6 mptcp-next 2/5] mptcp: MP_FAIL suboption
 receiving
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Wed, 28 Jul 2021 12:36:00 +0200
In-Reply-To: <a39b8f2a49c2798d4ff80ed527cd8990e64f8def.1627464017.git.geliangtang@xiaomi.com>
References: <cover.1627464017.git.geliangtang@xiaomi.com>
	 <277ac1e6d1fde4c180eba3f1bb1846ea58679915.1627464017.git.geliangtang@xiaomi.com>
	 <a39b8f2a49c2798d4ff80ed527cd8990e64f8def.1627464017.git.geliangtang@xiaomi.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Wed, 2021-07-28 at 17:35 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> This patch added handling for receiving MP_FAIL suboption.
> 
> Add a new members mp_fail and fail_seq in struct mptcp_options_received.
> When MP_FAIL suboption is received, set mp_fail to 1 and save the sequence
> number to fail_seq.
> 
> Then invoke mptcp_pm_mp_fail_received to deal with the MP_FAIL suboption.
> 
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  net/mptcp/options.c  | 16 ++++++++++++++++
>  net/mptcp/pm.c       |  5 +++++
>  net/mptcp/protocol.h |  3 +++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 2b15063c8009..cd9ec4acf127 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -336,6 +336,16 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>  		mp_opt->reset_reason = *ptr;
>  		break;
>  
> +	case MPTCPOPT_MP_FAIL:
> +		if (opsize != TCPOLEN_MPTCP_FAIL)
> +			break;
> +
> +		ptr += 2;
> +		mp_opt->mp_fail = 1;
> +		mp_opt->fail_seq = get_unaligned_be64(ptr);
> +		pr_debug("MP_FAIL: data_seq=%llu", mp_opt->fail_seq);
> +		break;
> +
>  	default:
>  		break;
>  	}
> @@ -364,6 +374,7 @@ void mptcp_get_options(const struct sock *sk,
>  	mp_opt->reset = 0;
>  	mp_opt->csum_reqd = READ_ONCE(msk->csum_enabled);
>  	mp_opt->deny_join_id0 = 0;
> +	mp_opt->mp_fail = 0;
>  
>  	length = (th->doff * 4) - sizeof(struct tcphdr);
>  	ptr = (const unsigned char *)(th + 1);
> @@ -1147,6 +1158,11 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  		mp_opt.mp_prio = 0;
>  	}
>  
> +	if (mp_opt.mp_fail) {
> +		mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
> +		mp_opt.mp_fail = 0;
> +	}
> +

Side note not specifically related to this patch: usually we get a
single MPTCP subopt per packet: a DSS. So we could optimize this code
path with something alike:

	if (unlikely(any subopt other than dss is present))
		// go checking all of them individually

To do the above we likely need to wrap all the 'mp_capable',
'fastclose', 'rm_addr' flags in a single bitmask. e.v. using a union.

/P

