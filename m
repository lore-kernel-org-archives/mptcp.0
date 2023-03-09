Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA6C33ED
	for <mptcp@lists.linux.dev>; Thu,  9 Mar 2023 09:35:56 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id q16so1211227wrw.2
        for <mptcp@lists.linux.dev>; Thu, 09 Mar 2023 01:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678354554;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v5SB99vpNB/CkKCBkv8PK4kIblB2D3NccDH+3gblFmA=;
        b=J7NeI6H1ezY8OSB8Dg43wMDeMYOQtRB0DVzAi+xpwFY1uNiyG7B7Mag1tig1l3We49
         HXGoD/mnJlL0b1xqH/+BdUSLSWFtrpT6ADfvc3z1JwxxYHrybf3WPdufA5R/7WqZLEPn
         A32dvxDyXDSxgwicWm76KRUbrAu6530pVKXNk8AlXRKJj3CQWuwjs9RGsCpMhSku6d9T
         hQDxUrlDBSjmiU7qcbzLSP9NdFhL95As99vCk0aIWKZ4ggJpqkA7+avFOlKFlyUsrAjt
         9Vhik4nE2tBh1YWPRitu7mUfaW4L+ScqnnW4RPnpQe5ZFvPLxVNnWwxl+YCGhKyPWAUX
         JbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678354554;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5SB99vpNB/CkKCBkv8PK4kIblB2D3NccDH+3gblFmA=;
        b=eb7tmfOtvvNlAyt9WUwSrddrqFYwYkXn3U+/yQqmwh4vfFSokgHfV0hy+kpl6Li87A
         CG9EPzgpk59ht/BjelUyIial0JoRM66qq8bPqdMxWjUStVcouNalCKQMarmFQ2XClo3E
         JCORTyqY4+FKM8PugUEKsRlG0Oujc6L9Esx58E41GqYeTSoYZS7ZiEo0oIovPxLjrT9G
         q4RN2tCPcvWFgUloJ3jmT6hsPlEEHRd3w13RoTfQu9DJ0W2LtjLHqKLDWnANcEDx+x9X
         V5Vi2xFj5PO0sxqlRaV0FLXx45pIcgugQq1opcVN0OoNoW/vf5wr9YkuMy/UVig7zoO9
         AZmQ==
X-Gm-Message-State: AO0yUKWuMcczwGZtTcVL2mlQ42y58Hud6JvjKEYqeVW8ritUxfpIg+VE
	3HKS1WwEc5758NGfbBAGp8hFStsYHwYBUl/MmUgd9A==
X-Google-Smtp-Source: AK7set+jmiXMGJmiBrC4KfZFYigfUgTwV51Fu/meySWOQj/rcDICQ2axTIgJO2TIF8GslABpN++rrA==
X-Received: by 2002:a5d:6912:0:b0:2c8:14ba:4589 with SMTP id t18-20020a5d6912000000b002c814ba4589mr12781323wru.42.1678354554145;
        Thu, 09 Mar 2023 01:35:54 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:cf48:2681:518b:ac83? ([2a02:578:8593:1200:cf48:2681:518b:ac83])
        by smtp.gmail.com with ESMTPSA id a13-20020a5d508d000000b002c54536c662sm17601037wrt.34.2023.03.09.01.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 01:35:53 -0800 (PST)
Message-ID: <cd9e989c-8ad1-6f42-685d-378c9ce83892@tessares.net>
Date: Thu, 9 Mar 2023 10:35:53 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-net] mptcp: do not fill info not used by the PM in
 used
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <20230223-mptcp-diag-info-limits-in-kernel-pm-v1-1-699561f9f9f4@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230223-mptcp-diag-info-limits-in-kernel-pm-v1-1-699561f9f9f4@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 23/02/2023 12:20, Matthieu Baerts wrote:
> Only the in-kernel PM uses the number of address and subflow limits
> allowed per connection.
> 
> It then makes more sense not to display such info when other PMs are
> used not to confuse the userspace by showing limits not being used.
> 
> While at it, we can get rid of the "val" variable and add indentations
> instead.
> 
> Fixes: 3fd4c2a2d672 ("mptcp: bypass in-kernel PM restrictions for non-kernel PMs")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Thank you for the review (on IRC).

Now in our tree (feat. for next) without the Fixes tag but with your ACK:

New patches for t/upstream:
- 5435c97679c1: mptcp: do not fill info not used by the PM in used
- Results: 6ce53727880d..fc5dcb18c972 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230309T093419

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
