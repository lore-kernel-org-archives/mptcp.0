Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740C168
	for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 09:55:19 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id w1so7758414edc.6
        for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 01:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EAkRkC56ncYrqWKBQT7PNUlpqQiG+y91qXVi5CCpbR0=;
        b=pX8UFSZHeeE1vyauffzWu1RybVYDK1vgapVcBN2F2Zu6cmCvPXuFEaHdQBWupXseMK
         S6VxSx6aWosDp3433/JBV/qzpV8BjmYQKQbLGrTmEpbLqOxH4dxLVjH9ri4tqDwzdNzx
         jgYJIEy03u/V9GKGOet1RpN+fNtaVJCxB2lc0oIzAvYLhTURgczXmg0BAESCgmlpFYVH
         1qPjkSmbcR3wma8ty4/8U/Dco+Fe5h306tctztnIjlF6sdYYYJk1rPUL2QlHDfGiKCEi
         A6iIobGhr2ocUfWBJbzqdurnBrHpQAQ4lFVWfcWdnmJkE2dJWXmDidkOJyBdMIQy/T9s
         8M1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EAkRkC56ncYrqWKBQT7PNUlpqQiG+y91qXVi5CCpbR0=;
        b=7B6Ar9pEDvBsrWUHTjFYtwDww2NQMGZOVA9xsZR2QF/1Syk8as8UNFMqBEfkF3Erwm
         9HUWLdjpq2Pegdl05ZlePgwWfs9087sqis079uIuxmpMMIru8bYZnBBsPuJ3yK/y/g/n
         2z1OJRt214Juc7W5Jycp9lC+jsSMS4gE86v2L6zIRLwWyQw98KnuXS52n5YftrkCJXSk
         tqk0V+DzuDpGu90aVJzU46iNDYK1g8ECeJfAYyOTaJ5t4wlcJDlEeQgk9gJ83HNjcAbq
         Oxqq9fw4hy07/ArAZDwfpIcwc1nSGuAGkMRSS5JEbWGmjrel3TXL8mfCA4LNXklX1m+v
         QJRQ==
X-Gm-Message-State: AOAM532HVn41oZfBXMAQUceegaggowhKZJ/Xr+JhNUVmU3emBlrxTUJP
	voAntn7Je+AqAKLMDg/QIRm/kQ==
X-Google-Smtp-Source: ABdhPJwAjjyUvbr5iHY4GYqVVSH9iqWKeTKqrfYiGA2Blc5GP2yu76zpg88575JJ86CKaEJsZemZjw==
X-Received: by 2002:a17:906:f6c2:: with SMTP id jo2mr17622939ejb.496.1637747717642;
        Wed, 24 Nov 2021 01:55:17 -0800 (PST)
Received: from [192.168.178.33] ([213.211.139.36])
        by smtp.gmail.com with ESMTPSA id ar4sm6418664ejc.52.2021.11.24.01.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 01:55:17 -0800 (PST)
Message-ID: <39669a68-eb6f-6602-1469-886266346e48@tessares.net>
Date: Wed, 24 Nov 2021 10:55:16 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH mptcp-next 2/3] mptcp: do not block subflows creation on
 errors
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
Cc: Phil Greenland <phil@quantulum.co.uk>, mptcp@lists.linux.dev
References: <cover.1637684792.git.pabeni@redhat.com>
 <c080cc1785cbe3bb3c049a683f2cc6d55f95f17a.1637684792.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <c080cc1785cbe3bb3c049a683f2cc6d55f95f17a.1637684792.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 23/11/2021 17:37, Paolo Abeni wrote:
> If the MPTCP configuration allows for multiple subflows
> creation, and the first additional subflows never reach
> the fully established status - e.g. due to packets drop or
> reset - the in kernel path manager do not move to the
> next subflow.

Thank you for looking at that!

Why the PM could not try to establish all possible paths "in parallel"?
Is it because we have this limit of allowed subflows and we wait to know
if a path is established to count it as used subflow? But if here we
mark a path as established if it has an issue, does it still make sense?
I probably missed something here :)

> Let's trigger subflow creation on both the above event.
> Note that we don't need an additional timer to catch timeout
> and/or long delay in connection completion: we just need to
> measure the time elapsed since the subflow creation every
> time we emit an MPJ sub-option.

Just to be sure: can we do that because we always expect a retransmission?
> @@ -1382,6 +1382,19 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>  		/* MPC is additionally mutually exclusive with MP_PRIO */
>  		goto mp_capable_done;
>  	} else if (OPTIONS_MPTCP_MPJ & opts->suboptions) {
> +		if (ssk) {
> +			subflow = mptcp_subflow_ctx(ssk);
> +			if (subflow->start_stamp &&
> +			    unlikely(after(tcp_jiffies32, subflow->start_stamp + HZ/10))) {

Small detail: checkpatch asks to have space around "/". I can add them
when applying the patch if only this needs to be modified.

> +				/* we are not established yet and "a lot" of time passed
> +				 * e.g. due to syn retranmissions. We can attempt next
> +				 * subflow creation

That's strange to tell the PM "yes, the subflow is established now"
while there is potentially (or clearly in case of error (RST) below) an
issue :)

Should we eventually have another function name doing the same and
resetting the stamp variable?

> +				 */
> +				mptcp_pm_subflow_established(mptcp_sk(subflow->conn));
> +				subflow->start_stamp = 0;
> +			}
> +		}
> +
>  		if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
>  			*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
>  					      TCPOLEN_MPTCP_MPJ_SYN,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 0f90bd61de01..85986f3b58ed 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1273,7 +1273,16 @@ void __mptcp_error_report(struct sock *sk)
>  
>  static void subflow_error_report(struct sock *ssk)
>  {
> -	struct sock *sk = mptcp_subflow_ctx(ssk)->conn;
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +	struct sock *sk = subflow->conn;
> +
> +	/* subflow aborted before reaching the fully_established status
> +	 * attempt the creation of the next subflow
> +	 */
> +	if (unlikely(!subflow->fully_established && subflow->start_stamp)) {
> +		mptcp_pm_subflow_established(mptcp_sk(sk));
> +		subflow->start_stamp = 0;

Detail: do you need to set it to 0 here?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
