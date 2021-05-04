Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DE371
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 06:50:28 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id l4so11455305ejc.10
        for <mptcp@lists.linux.dev>; Mon, 03 May 2021 23:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8RW7aaYMt7DLs+TWYQHkYXLru+Dv6vkjbZhvcJ6dWdU=;
        b=DEFwO7aT3/30tKfAVRhS0OpaofRjisQGqbaV38p3195jhpqyim2dIcNWFkYA0nR125
         121WQmrXYPP+GlroAUD1nyvcHIHkEQYHtDjYWFjVhbP2vO5+e59qxUR+JihkTTOP7wAf
         6J0m0VPWDAbQJT3hFJwyGOIP/eb63nvsTDZCq6EwVuyNVXDSOv+gZu2lsJefjgXNQxtv
         iSZgn1eDWPKbFcGBkJ2iZamnllH8tpnmEO+uG8ls2Gb3xdzNWgAJoNMndr2xOuVGR6/n
         xg3+8dvvMdjsfllG6kdJW2M/adtbJvFcIyulsmZ9jKT5Rl9VWjFbBTTHyH6nZIaPH3Tx
         bgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8RW7aaYMt7DLs+TWYQHkYXLru+Dv6vkjbZhvcJ6dWdU=;
        b=hHlF8/Y+Hc83flKRjv1jnFmRwkHybP28GCi4XDAp55N6/3LiU976Avzkw7dId1S47j
         uA8mW2kOyf9TIJCgVJnCb1It3djgSjGHTK7gDF92r9XgWcf8TJg8YBzsV0pi0hFtfOi3
         SvlqNQAZtRaGxx6EMyamnv1fi8HsoA8FIFvqAF7y4uuuKkkp9bp6NciXI2GAbQ4R4MRW
         /mclPcAAH+I3oc6S4VAWw4OcSFb8L7vJL82Bvi8jWh907gpLFLrYA13coMsTKqIXXQmC
         jwCYdcKgmnfOJcYckX7IEPLMTDJoVUvNMkIVP4ayCNuR5YjpcSMrKQvIz+YHEIb8v5Cy
         n+Bw==
X-Gm-Message-State: AOAM531q3k+vlJPOZarh6gbEg2uZUUTycUkIwUEhP6d4AnSoTo2Na91j
	Yh0UXRa4TegaeKLNNDuEFCDA8TfIUEsidgri
X-Google-Smtp-Source: ABdhPJwn70kQVERMb/UKjklcm3RT4YSpLXFUtHrpFEKFHN1B30DuVZ4FNF/F6mRSET3H9zPLT5X4jQ==
X-Received: by 2002:a17:906:5ad1:: with SMTP id x17mr19931997ejs.257.1620111026962;
        Mon, 03 May 2021 23:50:26 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:9816:d200:6718:3177])
        by smtp.gmail.com with ESMTPSA id y20sm13970731edw.45.2021.05.03.23.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 23:50:26 -0700 (PDT)
Subject: Re: [PATCH] mptcp: fix splat when closing unaccepted socket
To: Florian Westphal <fw@strlen.de>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20210503100224.22433-1-fw@strlen.de>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <26bb7e4b-ea03-22db-20ee-b96309229399@tessares.net>
Date: Tue, 4 May 2021 08:50:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210503100224.22433-1-fw@strlen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Florian, Paolo, Mat,

On 03/05/2021 12:02, Florian Westphal wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> If userspace exits before calling accept() on a listener that had at least
> one new connection ready, we get:
> 
>    Attempt to release TCP socket in state 8
> 
> This happens because the mptcp socket gets cloned when the TCP connection
> is ready, but the socket is never exposed to userspace.
> 
> The client additionally sends a DATA_FIN, which brings connection into
> CLOSE_WAIT state.  This in turn prevents the orphan+state reset fixup
> in mptcp_sock_destruct() from doing its job.
> 
> Fixes: 3721b9b64676b ("mptcp: Track received DATA_FIN sequence number and add related helpers")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/185
> Tested-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and the review.

Now in our tree with Mat's RvB tag:

- eb5185213368: mptcp: fix splat when closing unaccepted socket
- Results: f6df9e9d3336..9c59ba276e75

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210504T064955
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210504T064955

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
