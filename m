Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC42C9C
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 11:38:35 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id ka4so6345737ejc.11
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 03:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9GHrbmSnjbgkLkmIKeBe0FZurvg10eDe/dQmYpAmv2g=;
        b=cecKO55JpVQpXVE7dLTL1b/DMU3hUDWCgvQozFlhz/b31ldL3NVC2D0edTbRFV71TW
         1N2RTKGGddDzd7E/j5Et4ek5AYzzcnbIpP3pFhJrnhjJKYj1GvH2eLiOzwOfLQDDiz3/
         53f/V8mNjTS3pFSomwtmYtM4tFlxWH17Bmxm8vWco/LgxLvVpICgWBkKvbn7Eul4v7Rd
         +JAzKov23l1JazyB52A2XE7GQ5EmXdWubWzgV6U0R1Eq0m6ql6cXybb0TqvTQEMdA7dl
         g7lgKnb9CBEKOytnFFwahjyX0FGnruhrZifNk5+cSGRjYDgW/i09Gw9fwoWDWlKGCDqF
         deAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9GHrbmSnjbgkLkmIKeBe0FZurvg10eDe/dQmYpAmv2g=;
        b=L9tioLC4u8kigYzMcULHXterYClu6oMhu60mGtsOL/C/pqrm9jZodITJYkQNNwJ7Hi
         imdOZhQKRg6fPWGczd1i3fiqZjZ0lKdhof7VT2VzEWmPMItCBFFlgfVOLuuoyWctlKdH
         Bm8+JfcEBhtGbm6ZiDysEF7JscL+Z4q7V1cUiMoAbQjA7U2kouWQOThkGzuez8C9k1B4
         TkMZ4pTgkmp+KEzCY6iIb2iT730N8JT1F34/O9sDVfBTQkB3Xoy8ap+uKjDCeh/XxFEP
         Je+2xyZ3HwH5pK+kvNQDoUaXMDGoKcXeY8MB0RW+gD7xIL4B4jSxvdx8j4qJ+kY/s6O9
         mUdg==
X-Gm-Message-State: AOAM531YnbPpClVS9n5Z6YdE5J25oDiAeoyut3stYx2/wNieceYgs2gk
	jRHXOpKRJj2wqQDuQ8+AQkCgCyaKPH45fg==
X-Google-Smtp-Source: ABdhPJwkTi84ns8DMMJcCwZ93+Q2U28KfZQfXK3rGKGYs1ygU2dPnWiSCwDyLd5Yr2U3bs8bBEr0Rg==
X-Received: by 2002:a17:906:6a0f:: with SMTP id qw15mr1565788ejc.66.1644406713341;
        Wed, 09 Feb 2022 03:38:33 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:7367:f707:bfa2:c077? ([2a02:578:8593:1200:7367:f707:bfa2:c077])
        by smtp.gmail.com with ESMTPSA id r1sm4802807ejh.52.2022.02.09.03.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 03:38:32 -0800 (PST)
Message-ID: <25b23d1e-2339-bd03-366b-16f9336beaa0@tessares.net>
Date: Wed, 9 Feb 2022 12:38:32 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next 1/4] mptcp: drop port parameter of
 mptcp_pm_add_addr_signal
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1644318561.git.geliang.tang@suse.com>
 <d34da01837f0f01060a0240c00870df9372c2e39.1644318561.git.geliang.tang@suse.com>
 <1457fe5a-2037-6375-5b5d-1ae6c7dac871@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <1457fe5a-2037-6375-5b5d-1ae6c7dac871@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 09/02/2022 02:20, Mat Martineau wrote:
> On Tue, 8 Feb 2022, Geliang Tang wrote:
> 
>> Drop the port parameter of mptcp_pm_add_addr_signal() and reflect it to
>> avoid passing too many parameters.
>>
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> 
> For this patch, looks like a helpful bit of cleanup. Thanks!
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the patch and the review.

I just applied this patch in our tree (not the rest of the series) with
Mat's RvB tag:

- 3afdb53fb2eb: mptcp: drop port parameter of mptcp_pm_add_addr_signal
- Results: e0f3a1a43be7..56333e0f13bc

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220209T113813
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
