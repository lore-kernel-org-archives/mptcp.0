Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD7E3FC8
	for <mptcp@lists.linux.dev>; Thu, 23 Sep 2021 16:35:40 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id v22so24688171edd.11
        for <mptcp@lists.linux.dev>; Thu, 23 Sep 2021 09:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lqo4MBw88zF9AzQoDdyH/3PMZsvznYPqynbAIqkV7tw=;
        b=o5tlfYNYUi/ot9NRPBParKbbLjYwlbkj2xq8NuFLjBOU+Pa7rpRu4m4cn0BEtvWRiP
         eGtpHC7+Wp605foqRIH1yOuXUfVVEEgVaNiBzxBfVTi8RRFS1PAkOZHJvUb2pX2Re2/T
         phS3KuOEf4X1HupcyhgMuW5ozuvXBIXjYkn8J4JPU4DmXOdQyv00LJdREt3oWIiNGLV0
         V4njZePVxhs//t3xFYVq2jU5MqxFOclYCrVA3+oczrCuNbLc7Vycz5bR4MTbR2JX1obE
         lOPnWvXuRPxGVUFl+daOV7knFdn8oKndl+6nydBq5J7CnLHRN+KFIKDGClZP+4eWrurw
         QnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lqo4MBw88zF9AzQoDdyH/3PMZsvznYPqynbAIqkV7tw=;
        b=dZFAh9e2zi60Q1UhZ2XdGaBFXn8ZOka0Kiwua7Vgpc+t4MoJskME7aG8Sm2RsSOArw
         lLEgMXYk1zA3lUUepgiaWAeyItXa9EK4RPZHdKOIpX4XkYALsoTBbIEFLXBQ2KeZ7JQg
         MCJ8DnqA0c0T5IgL1ZFVh1tRDzN/AqOejBhQdWGCD+NQ14f/ASKQBax11vbhQzQo7nne
         P4sZgfAYff/YhYYAbQxO71XrWgOYR7JowVSY69rnyii8LhrMBzRz/muz8M25NeNFIxfa
         ZZntfDx8nUq48v2m3DBoeIKWNvQHj2Q8qEuNr+pp7VdK68h4avksSR8ZeFu4PoL6SXWB
         GM4A==
X-Gm-Message-State: AOAM530PrSJHTkIUA0HinzfluGtZ3uAXJeqzW37nLT+EF7CNSvRJL5gW
	gpOQWLwuhEd3x2zB7JEixVvepLWdo9oElgAA
X-Google-Smtp-Source: ABdhPJzk9FHnomSCpVl0lvEm2Ad6UHnxxqUjjmc0Amo17HlgAxFD5xFE+CaDzCKuSdMrEA/iqjfTlQ==
X-Received: by 2002:a05:6402:6d6:: with SMTP id n22mr6698162edy.257.1632414938775;
        Thu, 23 Sep 2021 09:35:38 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.102.72.dyn.edpnet.net. [94.105.102.72])
        by smtp.gmail.com with ESMTPSA id x7sm3776670ede.86.2021.09.23.09.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:35:38 -0700 (PDT)
Subject: Re: [PATCH mptcp-next v2 0/3] mptcp: tx refactor update
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <cover.1632217366.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <9e3ef117-9094-2bce-5ea6-652c4ca526df@tessares.net>
Date: Thu, 23 Sep 2021 18:35:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1632217366.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 21/09/2021 13:39, Paolo Abeni wrote:
> This are updates to the tx refactor patches as asked by Eric.
> Note that patch 3/3 should replace completely the existing
> 'Partially revert "tcp: factor out tcp_build_frag()"'
> patch. I opted for this solution as the git repo mangling looked
> easier this way; @matttbe: please tell me if other options are
> preferred instead.
> 
> Additionally patch "chtls: rename skb_entail() to chtls_skb_entail()"
> should be dropped.
> 
> v1 -> v2:
>  - drop unintended chunk in patch 3/3 [mat]
> ---
>  include/net/tcp.h | 2 +-
>  net/ipv4/tcp.c    | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Thank you for the patches and the reviews!

I just reverted the original series (5 patches) and sync with net-next
(4+1 patches are already there).

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210923T163341
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210923T163341

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
