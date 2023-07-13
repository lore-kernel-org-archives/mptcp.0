Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18ACF9DF
	for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 09:02:08 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3159d75606dso566000f8f.1
        for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 02:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689238927; x=1691830927;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xf0RKWG4bWhgTAiugUcQRuuVXkgjMH8yzpXJIyc5598=;
        b=WFwRlWvFx6qDvWhFmhnLqXI2q6DmXqwC8XLMdDPtAu7CuDdIjU+epwF9RQ9+VCGg0o
         ZXnp+FT7EkwBcj6PDOmlUZmRUZ07Hj8Uj+2ZwqHOlrFxyX+IipGUhcf7ZCUOnk3kHnPy
         FFFZEy2dNlR+ZIlai4HwfYtQxvKiOHCtfgZ0f6EtNLfA2P8OVyGwavgmd9oeURxXB2rL
         2Ec6I8+TqN5CI8sjPVBzfSyLJ9ydCOOHRY3k16Auct83KYfTKfM0TH6MgcZIRs66e7nI
         ZrPx/N2J3D9I0C6jzTTZZWyzZLJ+1w+MANRhKR18fol5WZOtQShiyhp/XoSOZIs9pcch
         6CrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689238927; x=1691830927;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xf0RKWG4bWhgTAiugUcQRuuVXkgjMH8yzpXJIyc5598=;
        b=DqLlAsB1A9Er0uRWScK4JEx7WGYaB1ZPqeLOdvVR2EPktgopDdq+tacxLt7yukKqP5
         eKCqAzxlYGzZKHqWD1/Co42ou8AbBEIODllAgB4B1CSWG6gPfGEEZOAmQlQuGQkpH2rH
         PLLGkTQn/b0ttxyEFTkPjzNuezeUR/qmMucOL4sNKKJQTL1n4q0HDqVnwUPqmArhUrc3
         Irb9c3Cnxdr+xxB7z+VziGCtDhGk8XS8nmmX/6XuZSn/dytukhJ1sQkEfa1xr5+WZz+3
         hziQGw/pgHjdQEXSrtELFaPZRgtiKQKmGJHKOGifO7bLjFlMyY77KZZRnS2W+Mq6wmfk
         wjsg==
X-Gm-Message-State: ABy/qLY1e5RxewqPOTFmh93C+vOz6XxnHKd4zSxDay3TEVFeoK3Hgo7I
	NWQxAPuaOqxFVGdnwEk+lbCxRINcYpbHJZW62TqpyUVC
X-Google-Smtp-Source: APBJJlEkBbfNpsIxvDdMMZUaUm0UXf0zWz3kBHrkfzgKzzGgQaTvDAtk3kNeia4CzOw/BIzZb/qZ8g==
X-Received: by 2002:a5d:66c5:0:b0:315:a34f:b520 with SMTP id k5-20020a5d66c5000000b00315a34fb520mr788959wrw.71.1689238926696;
        Thu, 13 Jul 2023 02:02:06 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c2e6:680:ced7:5e59? ([2a02:578:8593:1200:c2e6:680:ced7:5e59])
        by smtp.gmail.com with ESMTPSA id c3-20020a5d4cc3000000b00311299df211sm7342402wrt.77.2023.07.13.02.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 02:02:06 -0700 (PDT)
Message-ID: <5b02d760-9820-31c2-6e2f-65560673cdc9@tessares.net>
Date: Thu, 13 Jul 2023 11:02:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next 01/14] mptcp: more accurate NL event
 generation.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>
References: <cover.1688993569.git.pabeni@redhat.com>
 <2dff178d492953373f5d7215aea15676b0e6079c.1688993569.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2dff178d492953373f5d7215aea15676b0e6079c.1688993569.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 10/07/2023 14:54, Paolo Abeni wrote:
> Currently the mptcp code generate a "new listener" event even
> if the actual listen() syscall fails. Address the issue moving
> the event generation call under the successful branch.

Good catch!

> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> this could possibly go via -net, but is used by later patches and
> is not really critical IMHO.
> Eventually the additional tag would be:
> Fixes: f8c9dfbd875b ("mptcp: add pm listener events")

I think it makes sense to send this to -net. If it is OK for Mat, I can
already apply this patch.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
