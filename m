Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6947E
	for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 15:56:54 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id i5-20020a1c3b05000000b003cf47dcd316so11073463wma.4
        for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r8GeiBb/VS2wuuybYAo3rQn67mxNBejaRzsJUrAQu2I=;
        b=bIikGLulSbY0Gm50Q+1ldqAoDOk+eRX7X26JxIjq8uo03c00ahJ/Zekx2zpNKERHfr
         YwmoZxkUTX+j/JvzjWcEjJaMNLJ0+1HSE7bG664Og6YYgq7WvViJ7soEjeiAHt6TlD0K
         /v2k0S94twxL0MH5fNN19mDWncZTVuOoEua1XphWpcD0tKmZoDYRp11T7SeL+fgFhE+r
         JFrtn0YhRtIAmQpHZ930pqKjfYJlpf5knNVuy7cOtdo9e/b9c3vejlu8Eot2ZZBVKkCf
         333vmjfePM7vmQJQD5zcWNNdIbSxGSs8tlxf4M96oQD0wQnVsKw7hPJKE1JQoBVVVnXD
         b3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r8GeiBb/VS2wuuybYAo3rQn67mxNBejaRzsJUrAQu2I=;
        b=Zj7fmjyIbMzeNa9tdBzoZ3PxqoS4iz68cwXbmHndeyYFGK8xS/5yG7ccRdxMagSB44
         UJh5Az2IJl3//V/P5z1aFiPFPOGfH2ISSGWvqUTw/H1LTZ/0ENfXAnWZXuiLDq3IAcdh
         AWrYjUqeDrhso+5U6pHR8vpepFnEO0MjFTkHuvWOKrejt8uLR7qPBGSlnHHfV4ZPLYV/
         iQG1A+5ffVFaR3Ph4w0Q+R+CO7ceqVXFHVB8foo9F7GZsbWWkrW3Dzx8TsMH2nR97I5u
         SWE7Q1Dq7RPKR4gXa9CjlBnRtOj4Iwq6nKY9ZaukQEQUs7gNzgrShU62C7H58iR+ygG5
         I9aQ==
X-Gm-Message-State: ACrzQf1jdwJBsv/CaU54t995AJYxYEmz5etMH+Glc2bgiuyEr3Y3idh2
	YQ3xUIwfBUbPuQPts/3Ooqlc7Q==
X-Google-Smtp-Source: AMsMyM6MhcBVxekEusI6U0c/SsxfkcZ/oFReswo6gEDI2qYZVbIxGnnoy04ldEg2aoqdAArlLlNFWA==
X-Received: by 2002:a05:600c:3642:b0:3cf:700e:6533 with SMTP id y2-20020a05600c364200b003cf700e6533mr4316433wmq.8.1667231812578;
        Mon, 31 Oct 2022 08:56:52 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id bj12-20020a0560001e0c00b0022e55f40bc7sm7483551wrb.82.2022.10.31.08.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 08:56:52 -0700 (PDT)
Message-ID: <20008ae2-699d-0bf3-18a2-3ceaa334ba31@tessares.net>
Date: Mon, 31 Oct 2022 16:56:51 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-next v3] mptcp: get sk from msk directly
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20221025032610.17496-1-geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221025032610.17496-1-geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 25/10/2022 05:26, Geliang Tang wrote:
> Use '(struct sock *)msk' to get 'sk' from 'msk' in a more direct way
> instead of using '&msk->sk.icsk_inet.sk'.

Thank you for the patch and the review!

Now in our tree (feat. for net-next) with Mat's RvB tag:

New patches for t/upstream:
- 4e306bab073d: mptcp: get sk from msk directly
- Results: d708694301f4..c760a79c8d57 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221031T155336

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
