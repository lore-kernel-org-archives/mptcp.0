Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C95C8CE
	for <mptcp@lists.linux.dev>; Mon, 15 May 2023 15:58:34 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-965d2749e2eso1957996966b.1
        for <mptcp@lists.linux.dev>; Mon, 15 May 2023 08:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684166312; x=1686758312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MdPIhWdY7lRRIACXgf+v9kg8dZwjI+OM3n64EjIL20g=;
        b=73uBCyAG5gTmkidTPYgl8/l+5ejaPghANNTp/gb7qn+hSUgwdD3J8ZWUc8kjH3RGU/
         ZF71fDfo9LOKuecFYbBDieBDU7Y7tZ7KArVZB5XXQtgGnrsonjHsLGLnEUGTSp5g7nsg
         ooZNL7mZcGlUoDIYUgrm+FOBqaRMmYNjx25WiGZZvTGGvdakmn7kDyKglsBKZURfTgqa
         0A3rHNkSwt5Bbwfc0XkkANQMys5HezW/E/Bs6NkxCi6k9OIy62KGqfcevXPcYYST7OVb
         y3/5ox3nxAQKa6wKh5P/Qha0ltvCJ4qY6qxcW7GJh7xZDXNysi/+L+nXbg7eC/oDmtds
         TU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684166312; x=1686758312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdPIhWdY7lRRIACXgf+v9kg8dZwjI+OM3n64EjIL20g=;
        b=E3XoNS0c3K0xzXNeQVKGl8xoLqca9O3VrySeo4l6jBevhk48RTHC2uHlbajpHHiENv
         spFzaSb0WBllG0HGi6VAbURWM+roGDENaPdAWQSfcwykOqkGz3Bj0dUQVQLvZzQLeg+Y
         TSXv4EiMD7r9abdtD74ptKkZrW/4Jh+WYD6KVPRbzXhkSHHlznBYzAbyXzePy5QT845j
         gvotGDo6PSK71xJ20dyYP3oaAK+MEP7WirbQ4lqALdrVqNBP2+C0LWR/20rXKd9rIiIJ
         tAuVpI4dggleC7zno7q0siur60jxbxKlvOx9BYJP2DXKIcgMPzNJMHc62v5o6DBp9JQb
         +vXw==
X-Gm-Message-State: AC+VfDyKa7pMfgsDApB1bqr0Iiza7JjYBx/DpUC8PvZCzdaqqVbW6MLW
	jM6ptSHbcheKHLlFN3jsJBJ3ig==
X-Google-Smtp-Source: ACHHUZ4sX7vbQF+vUba5wCOU/2/V/Z7WNNazWBzmPi0lJ5SZWgWJKWcaJ/Eg3x2IcaEL60z0B8Fybg==
X-Received: by 2002:a17:907:2d1f:b0:968:db2f:383 with SMTP id gs31-20020a1709072d1f00b00968db2f0383mr24261250ejc.53.1684166312414;
        Mon, 15 May 2023 08:58:32 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906319a00b00966056bd4f4sm9612722ejy.28.2023.05.15.08.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 08:58:32 -0700 (PDT)
Message-ID: <6390ce18-eabd-74f6-b7c7-3eec0b534d5e@tessares.net>
Date: Mon, 15 May 2023 17:58:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-net] mptcp: fix connect timeout handling
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, mptcp@lists.linux.dev
References: <ea1b196b90f42f6308cf82a830ac7ba5536d803d.1683315117.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ea1b196b90f42f6308cf82a830ac7ba5536d803d.1683315117.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 05/05/2023 21:34, Paolo Abeni wrote:
> Ondrej reported a functional issue WRT timeout handling on connect
> with a nice reproducer.
> 
> The problem is that the current mptcp connect waits for both the
> MPTCP socket level timeout, and the first subflow socket timeout.
> The latter is not influenced/touched by the exposed setsockopt().
> 
> Overall the above makes the SO_SNDTIMEO a no-op on connect.
> 
> Since mptcp_connect is invoked via inet_stream_connect and the
> latter properly handle the MPTCP level timeout, we can address the
> issue making the nested subflow level connect always unblocking.
> 
> This also allow simplifying a bit the code, dropping an ugly hack
> to handle the fastopen and custom proto_ops connect.
> 
> The issues predates the blamed commit below, but the current resolution
> requires the infrastructure introduced there.
> 
> Fixes: 54f1944ed6d2 ("mptcp: factor out mptcp_connect()")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/399
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the fix and the review!

I just applied it in our repo with Mat's RvB tag. I also added Ondrej's
Reported-by tag.

New patches for t/upstream-net and t/upstream:
- 59d33b72ee59: mptcp: fix connect timeout handling
- 8d8fd087a52c: tg:msg: add Ondrej's Reported-by tag
- Results: 8ecd3b5ba105..fa4a5780caa4 (export-net)
- Results: d9d25c574c4e..b8e056f78785 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230515T155446
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230515T155446

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
