Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59263FC3
	for <mptcp@lists.linux.dev>; Thu, 16 Sep 2021 16:21:46 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id v22so14663291edd.11
        for <mptcp@lists.linux.dev>; Thu, 16 Sep 2021 09:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GDKlP/UqsPRkxeTGKCu1PIXMFQ+1mfEXMEM0x0Kkr2k=;
        b=5I6QawT+7rdsh+u3LOOwbtjJWGlze4GDhi2iDklTZm2GwfEg1yqkGYohBIsrkXgRJ4
         BSz1hD/b+NQw348KrisDdR58mcnHsLvOHZ6R5rneLedHQ2gBWk1UY3s+ET5l66ZHaDLS
         WSwluEY6GURPDxqGjoiF2H/wmxuR5MBTRIu4d+NOS71I0T7OH7NWmP++ZMVTiXdalWEe
         g5+k4Bil84PtqaPG3eFLj8B9POIWVIpHOXF4m9SA3dluNCzrwrlk2LimUsBbkmtlM1oR
         YFk2IdTl8hSX99JwnWW/BAEYi6wvDeGE7HzFiL+0QMbc9VYeT/feDRtYcLL7/YqAMKZB
         ajmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GDKlP/UqsPRkxeTGKCu1PIXMFQ+1mfEXMEM0x0Kkr2k=;
        b=dF0vF1d5y4jipTeOTrqIUqpfrD3Qp6T9pwak8XhJVTRt0AANVK/rxwNfiI+d+1F3Wh
         UomL02XhayuTd7XE4RcXuV+BHugZ3QeC2ETcogDM9iiNKGzdldq+qH93WZHGKeBpOxj6
         C3KnBp0pBettrXCH9ubWlKGzz3BKKBr5ttPmXdGX115/j/QusH2pNklV0LhqPBpQaJOG
         W5xePac58iBxw4V3Hc9MIe+bUM46kLyaK0x0jPI0pALJ4XnVFq9VsNTxJD9nXZhrTBzr
         6LaBHOv52wO8Tn0Jk/pMXnKdgGzxlKwL7g0UNFHchv0O/DU548isiGjzFXQvmepVFmNq
         V/rQ==
X-Gm-Message-State: AOAM533WbQnXK87pElB1pAjCNkRevuT2zzYIckqJruj7/JskrtihnDhy
	K43M+BiviHXJjT2pAnelRi97csWnevws4GpW
X-Google-Smtp-Source: ABdhPJx7elSBG18HHjU6V/2jzAo6ShQOKkAgWoeLvV7WXdRmnUsS4GVPO6TtFll3xkhi2dAaX7H4rA==
X-Received: by 2002:a17:906:d04d:: with SMTP id bo13mr7078437ejb.351.1631809304522;
        Thu, 16 Sep 2021 09:21:44 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.102.72.dyn.edpnet.net. [94.105.102.72])
        by smtp.gmail.com with ESMTPSA id c2sm1531951edk.50.2021.09.16.09.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 09:21:44 -0700 (PDT)
Subject: Re: [PATCH mptcp] mptcp: don't return sockets in foreign netns
To: Florian Westphal <fw@strlen.de>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20210915121144.9891-1-fw@strlen.de>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <46aeeb66-127a-db34-eaf3-bcdb6373934c@tessares.net>
Date: Thu, 16 Sep 2021 18:21:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210915121144.9891-1-fw@strlen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Florian, Mat,

On 15/09/2021 14:11, Florian Westphal wrote:
> mptcp_token_get_sock() may return a mptcp socket that is in
> a different net namespace than the socket that received the token value.
> 
> The mptcp syncookie code path had an explicit check for this,
> this moves the test intp mptcp_token_get_sock() function.
> 
> Eventually token.c should be converted to pernet storage, but
> such change is not suitable for net tree.

Thank you for the patch and the review!

Now applied in our tree (fix for -net) with Mat's RvB tag, a Fixes tag
and without a small typo (s/intp/into).

- 711ea7c216d7: mptcp: don't return sockets in foreign netns
- Results: c76567ae64fc..f05d3f3e1d3f

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210916T162130
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210916T162130

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
