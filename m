Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5351472
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 08:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636534120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+lPR6+pBE9Hnlazk3t4QEU8Q8QGCgEZ6SW6xNaGRf4=;
	b=TL52rjsCfaRqwNrvSKq9ppZD2/bsGU20e5Yf/4Zkey5zollQ/1dnUzACcKVFfj92VOtvxg
	hPPPMwqdzyNK61gdgh4FBhmtcBtFRYmIx/rDg9sMWuSbC4/PXS7/3Qq+iKA95t7cN4U8Oe
	PNiYJYBOqFN07jYjIFh8al778EJ+TVI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-yOpO5VA7OTa6AD-lCfYCqw-1; Wed, 10 Nov 2021 03:48:39 -0500
X-MC-Unique: yOpO5VA7OTa6AD-lCfYCqw-1
Received: by mail-ed1-f72.google.com with SMTP id w13-20020a05640234cd00b003e2fde5ff8aso1678958edc.14
        for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 00:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=J+lPR6+pBE9Hnlazk3t4QEU8Q8QGCgEZ6SW6xNaGRf4=;
        b=x1dKXFqExUzhp+oswlwf6K0/nOx+5v5qrHCyZ5RfeBW7XF4erdn/bbWylkjYNlGsiZ
         Gk2HztVGiINH0HtoqhzJp13afRKctwyT8wE5m5KB3pc9ZFTojg73k5B17pcfZWdSTL40
         c7RDkG98b2o+Eodw+3KhPvu3UdcZS9MCg0goHhMx/8N+6tV2wUaOa6+u8m2gepNYgi6r
         13r6n5N1iMPNj8Ts/Ww51PZfNbgtVg0+UytdxLYGoZgPIAuHtm7cVaSYYoamqTRilA6u
         cTIzrzrVjLydiZMEugTj61cAvDzlVcodXuqJfwTHFuIRbqK6ONZKek/HGUqFtGj4O3v8
         saWA==
X-Gm-Message-State: AOAM531wkXLFYvhPJfcbQJQ3fT7NovPM/l4wuWAJ8HwGeH5FETxCEUiV
	JBxzP2EzKOkiSPHUO0GFl7ZNc1E7WTKj8OWATiA/j5qtxnCi0WUOWbiB+w9yxr8lBm9kGEqprBM
	rlAVJllk17eYJ/mU=
X-Received: by 2002:a17:907:a426:: with SMTP id sg38mr18527719ejc.392.1636534117661;
        Wed, 10 Nov 2021 00:48:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxp0Zu6vrBLqsPJSKdTM05oTFrZmocirBt69lx+bkoZkOwqdGDC3PE5z1L1A+7d/i5eFPxSCw==
X-Received: by 2002:a17:907:a426:: with SMTP id sg38mr18527692ejc.392.1636534117424;
        Wed, 10 Nov 2021 00:48:37 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-224-97.dyn.eolo.it. [146.241.224.97])
        by smtp.gmail.com with ESMTPSA id m9sm10708405eje.102.2021.11.10.00.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 00:48:37 -0800 (PST)
Message-ID: <b467d2f950e6dd6c3f8e6c745b4c9a884625c77f.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 3/3] mptcp: add SIOCINQ, OUTQ and OUTQNSD
 ioctls
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Date: Wed, 10 Nov 2021 09:48:36 +0100
In-Reply-To: <20211108105711.16200-4-fw@strlen.de>
References: <20211108105711.16200-1-fw@strlen.de>
	 <20211108105711.16200-4-fw@strlen.de>
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35)
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
Content-Transfer-Encoding: 8bit

Hello,

On Mon, 2021-11-08 at 11:57 +0100, Florian Westphal wrote:
> Allows to query in-sequence data ready for read(), total bytes in
> write queue and total bytes in write queue that have not yet been sent.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  net/mptcp/protocol.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b4263bf821ac..29b6f57b917e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -22,6 +22,7 @@
>  #endif
>  #include <net/mptcp.h>
>  #include <net/xfrm.h>
> +#include <asm/ioctls.h>
>  #include "protocol.h"
>  #include "mib.h"
>  
> @@ -3260,6 +3261,56 @@ static int mptcp_forward_alloc_get(const struct sock *sk)
>  	return sk->sk_forward_alloc + mptcp_sk(sk)->rmem_fwd_alloc;
>  }
>  
> +static int mptcp_ioctl_outq(const struct mptcp_sock *msk, u64 v)
> +{
> +	const struct sock *sk = (void *)msk;
> +	u64 delta;
> +
> +	if (sk->sk_state == TCP_LISTEN)
> +		return -EINVAL;
> +
> +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
> +		return 0;
> +
> +	delta = READ_ONCE(msk->write_seq) - v;

This is under the msk socket lock and write_seq is protected by the
full/plain msk socket lock so READ_ONCE should not be necessary, I
think. The same for 'snd_nxt' below. 

'snd_una' instead is updated under the msk data lock, so the read once
there should be required.

Cheers,

Paolo

