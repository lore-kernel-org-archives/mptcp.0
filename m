Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA675BE71
	for <mptcp@lists.linux.dev>; Mon, 19 Jun 2023 09:28:18 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso3288116a12.3
        for <mptcp@lists.linux.dev>; Mon, 19 Jun 2023 02:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687166897; x=1689758897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=upKg2HKxFrd55tB8VQFS2TrQm9XBJRNF3Q3EFJOvwlQ=;
        b=nlftjA7buZUGgB4y2kZPtx+HMzlW1BbIgtQwDXHtXq+z+zD/lc6byz7SQbYTYjfjxl
         JsaodkWTFmBaa2EUDulLDEgYl0aig9suPeNm11qj/wRWfQrTNuIfiPDAdaUehecloeac
         WQ7rlTSPiNvz0KSqLQQjwZ9cZi5v/IQWDGEj6ppywrOMm7i1ETTYizj5dAD/Rvc+hlvO
         2MwkFVRgiWUJRkFYHtpZ6PqALBLwBWIH4uLSMygXDLx80LEMzWboFanDCAW3frBCQHdj
         sevvnGKUfrmK+jUue7dkiT3GvN7I0Gt20vB/XPhbiCIA+UmxQ8OFccCU7ywEb/sjm+ZV
         Erlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687166897; x=1689758897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upKg2HKxFrd55tB8VQFS2TrQm9XBJRNF3Q3EFJOvwlQ=;
        b=DAflE2GPKF7YhWHP4Hir+KAbIqHu35LRF2Cmq3BtRFMiOUtuZVJVA9zp/B/9ksRCQ+
         IuPsNzThcdhHfjkmf++6sGr4meY/bNCq3GbWs4U/wgqX1r7m1R+mdMEOngFRCd8XJx6S
         KYSfx6aaflhMowFCb2wkh+nPWJtYqTFePSQ7i+M/csJklNQGt2U46235/vkk91y2Y992
         werAo2NYX27LF+2vxPixE5Z2Er9AtWVV/8HhVjj7aCy1arxVrAsiiPD8FP6W7ai2zuuy
         8u8w1S44CNcMn3nn4WuvNCD0TzQohn5tjt/PJQEy4RtXQVZy7SDjuGx4PYp5Xp+Kl4ox
         yriA==
X-Gm-Message-State: AC+VfDx6Em+c+hO8oZ7l+Jlv8ESAl7UeoijUrj83CvGhh+4i22s4HosS
	gA0Blkf3S6KYhK5k9W723blULw==
X-Google-Smtp-Source: ACHHUZ4ZQlss623x0EW1Z32QUzOHK5oBJw/cAN7KVxJdVTBEghprGgO8ZCdSwWJDhIt0425mi9Xt5A==
X-Received: by 2002:aa7:d951:0:b0:51a:53e8:f579 with SMTP id l17-20020aa7d951000000b0051a53e8f579mr1532655eds.0.1687166896517;
        Mon, 19 Jun 2023 02:28:16 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id c7-20020aa7df07000000b00514b854c399sm12829577edy.84.2023.06.19.02.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 02:28:16 -0700 (PDT)
Message-ID: <339738ae-a163-6f2b-0e5a-cd4f6da65cfd@tessares.net>
Date: Mon, 19 Jun 2023 11:28:15 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-net] mptcp: ensure listener is unhashed before
 updating the sk status
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <b96e12c9dd08dca94ce2539b01d0e609d472a22a.1686754464.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b96e12c9dd08dca94ce2539b01d0e609d472a22a.1686754464.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 14/06/2023 16:54, Paolo Abeni wrote:
> The MPTCP protocol access the listener subflow in a lockless
> manner in a couple of places (poll, diag). That works only if
> the msk itself leaves the listener status only after that the
> subflow itself has been closed/disconnected. Otherwise we risk
> deadlock in diag, as reported by Christoph.
> 
> Address the issue ensuring that the first subflow (the listener
> one) is always disconnected before updating the msk socket status.
> 
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Thank you for the patch, it looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

I didn't take the modifications in mptcp_join.sh because it looks like
temp debug you added. It makes sense to add that but we should probably
first print the "[fail]" message and then more info (without the
trailing whitespace reported by checkpatch.pl). Do you plan to do that
in a later commit?

> ---
> should close issues/407 for good

(for b4)

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/407

Applied in our tree (fixes for -net) with my RvB tag:

New patches for t/upstream-net and t/upstream:
- 126826def96d: mptcp: ensure listener is unhashed before updating the
sk status
- Results: 3aa564399c36..7fe37662a6a8 (export-net)
- Results: 0cf78b82b67f..9c3e1c09dbd3 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230619T092329
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230619T092329

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
