Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5578072
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 17:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627492089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V++pqimZPMHlFt9V3attYvjzjaFEDmiZpmLBYbXjIyI=;
	b=G2taQ+VYI9caBJlTiZEdFBxIqm3AZbqhCqT3imA86vqfeK7Qz/+QeRM3huw2Vh3lFWR9g0
	xFMoBU0HB1IWkYPsTvNvV0tVBLcoajz44+YiDpTC/P806kS0731aOpx0zCi7i4UGqCDYpK
	E6rSkBn1IXn1pqMV7JUCrDBJjCm1cFQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-YG2ZRserPTiweOefWY_epw-1; Wed, 28 Jul 2021 13:08:05 -0400
X-MC-Unique: YG2ZRserPTiweOefWY_epw-1
Received: by mail-wm1-f69.google.com with SMTP id j11-20020a05600c190bb02902190142995dso1570581wmq.4
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 10:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=V++pqimZPMHlFt9V3attYvjzjaFEDmiZpmLBYbXjIyI=;
        b=E62TWaKBx5d9HMWdKfXPtvE10xkQai/U/5JCZxGPTRPieekSqPLGqmZ5irP4gPU1dj
         /L1uKxUabtGY5/AYBC3kBVy4OJ1fLJmeIuqtL9fBsTjOd5XihQmz4off1fbMIf6bNB01
         Li3ORZVNQTl/NjmN6bpLvE62bV42NCEDg8YR6js9oElbTh1vMhhwlLOfSdvNlVadtW2A
         XyEVeimF0dtLqD6INCQJs9zBOMyAElBgM9mYvUiFYh73O9KitcLL7n4ZNED/PAFEGiZW
         uuPhaPusjUKEez8BD+9sgmTZf/0pi1QLu5pemoyOqCOTXqSVghsQSNApT+Qb4NsIJqyR
         snYg==
X-Gm-Message-State: AOAM530HivsuZZP70cUaapzoSN2yVYUKkMYA7Zn77Ar8A+CTxCWypfnJ
	tYuXOZ0jAqmK9oFjcjAIpaHW5jacLLYryL1lOaBzOacpm9aUyGk/Q4SyoZ2fzx8BKphCPnHjEGd
	8wBxTpK9rzY2iLGs=
X-Received: by 2002:a5d:5412:: with SMTP id g18mr384885wrv.301.1627492084451;
        Wed, 28 Jul 2021 10:08:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+F+eLq6fZqR7yzIqFjUqyHwMt4/9wCz533KYM571JN8TzFCeU4tH+zWjRunyZCdyWdY5P7g==
X-Received: by 2002:a5d:5412:: with SMTP id g18mr384861wrv.301.1627492084232;
        Wed, 28 Jul 2021 10:08:04 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id d5sm389108wre.77.2021.07.28.10.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:08:03 -0700 (PDT)
Message-ID: <a84e9c0bfea4af8555bcd6204b0ee9581f143e5e.camel@redhat.com>
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: MP_FAIL suboption
 sending"
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Wed, 28 Jul 2021 19:08:02 +0200
In-Reply-To: <04121bcd7e28251f4a3e1b17774b8ef5402f2431.1627470720.git.geliangtang@xiaomi.com>
References: <04121bcd7e28251f4a3e1b17774b8ef5402f2431.1627470720.git.geliangtang@xiaomi.com>
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

On Wed, 2021-07-28 at 19:13 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> Drop the use_ack check, and add a likely tag.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  net/mptcp/options.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 2b15063c8009..6db24cf72ac0 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -788,7 +788,7 @@ static bool mptcp_established_options_mp_fail(struct sock *sk,
>  {
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>  
> -	if (!subflow->send_mp_fail)
> +	if (likely(!subflow->send_mp_fail))
>  		return false;
>  
>  	if (remaining < TCPOLEN_MPTCP_FAIL)
> @@ -835,12 +835,10 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>  		ret = true;
>  	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, remaining, opts)) {
>  		ret = true;
> -		if (opts->ext_copy.use_ack) {
> -			if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
> -				*size += opt_size;
> -				remaining -= opt_size;
> -				return true;
> -			}
> +		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
> +			*size += opt_size;
> +			remaining -= opt_size;
> +			return true;
>  		}
>  	}

LGTM, thanks!

/P

