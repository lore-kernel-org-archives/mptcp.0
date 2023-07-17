Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83188F7D
	for <mptcp@lists.linux.dev>; Mon, 17 Jul 2023 13:58:34 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso41133005e9.0
        for <mptcp@lists.linux.dev>; Mon, 17 Jul 2023 06:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689602313; x=1692194313;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xeUgvMA9RQfBfyHCcV8x7qZeLd22o/gOiCvQnOOXUKs=;
        b=gbFSYsigWbZ3ko6RcAUsOFWV/4Wh7vKX+cG1uWBGq2eFWMzxjk9G/Qx8WRCwmMgnhh
         8/NwZhyGaNg5XrJiC+8Fbd7XROEPp5+qj75f4w8u28lYpl3PaX3L9GrCnbRVY3DFepG1
         jTS0E1PjgUXqfEjUKX15kerxZiVA6r2YvW3RG0JE40Zq26vIRydamadG1cktgEOPKJmn
         IfQgZZaCuUGcx2+h1IR2B8vkm33pJLOoGSp7EDjPjme3xJXAx5JN7lHZ9hYzf1YB2pP2
         oQfBwkHRrly38vlAEjdBw+HZY9llVrzgwvPJC7vjFUTYYaOaHp6K14vTw0dVZb0yhFif
         RyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689602313; x=1692194313;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xeUgvMA9RQfBfyHCcV8x7qZeLd22o/gOiCvQnOOXUKs=;
        b=g2Hy2zCiD2J6xDq13jQAZZ0p3g2KfZcb6qVYWfsVaoJFtkKq1d/vE7HGQKCxpfY4+8
         Lz8Z2f9DFuqe6GEo9dXk0i594WbmXgPa/eLkq9CRXb/lEpX3m9S6fPR/3YdNlbVV1dOD
         XNW8dq92EB2UYF5xZgL83yuWmWcMRSsVbJhdSdsATGKEPWtIVFKk8/ws42HwEp3lWU3v
         8Af+8Ittfubid8Wgp7pJzr2Lq//bBTX04veezEgBHzvEJ9NC7sfknRddLjBPVDMf0ywa
         Yq/GrhTijgoMDiDtvPag2aga2EY6P9PA+ZoJ+m7eXRNlNri0knQE5HLmZLzQFjfni7dB
         /5iA==
X-Gm-Message-State: ABy/qLZB+guu1BqntuwBPo4tv8vIPkHIQ2jSQKuOy0rD6RuZtzCKl72G
	0u+ttDdop7Wzk1VSoXWuP923uQ==
X-Google-Smtp-Source: APBJJlG7S+lMM8qSHthG4tTV4lcsbYqz5qJNKs5mvW+gyGXbJmt0QoO02DWhAhJokShBj2xIUq5iNw==
X-Received: by 2002:a05:6000:10c1:b0:314:475:bc47 with SMTP id b1-20020a05600010c100b003140475bc47mr9369537wrx.69.1689602312914;
        Mon, 17 Jul 2023 06:58:32 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id z13-20020adfe54d000000b003143ac73fd0sm19498262wrm.1.2023.07.17.06.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 06:58:32 -0700 (PDT)
Message-ID: <c1a76061-9ae3-0a9a-5481-dbdd981c7460@tessares.net>
Date: Mon, 17 Jul 2023 15:58:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 mptcp-next 00/13] mptcp: get rid of msk->subflow
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1689334116.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1689334116.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 14/07/2023 13:29, Paolo Abeni wrote:
> The mptcp protocol maintains an additional struct socket per connection,
> mainly to be able to use easily tcp-level struct socket operations.
> 
> That lead to several ill side effects, beyond the quite unfortunate/
> confusing field name
> - active and passive sockets behavior is incosistent, as only active
>   ones have not NULL msk->subflow, leading to different error handling
>   (and different error code returned to the user-space) in several
>   places.
> - active sockets uses an unneeded, larger amount of memory
> - passive sockets can't successfully go through accept()/disconnect()
>   accept()
> 
> This series address all the above finally getting rid of the blamed
> field. The first patch is a minor clean-up, in the next 11 patches
> msk->subflow usage is sistematically removed from the mptcp protocol,
> replacing it with direct msk->first usage, eventually introducing new
> core helpers as needed.
> 
> The final patch finally dispose the field, and it's the only patch in
> the series intened to produce functional changes.

Thank you for the patches and the reviews!

Now in our tree (feat. for net-next) with Mat's RvB tag:

New patches for t/upstream:
- 26b3767aaa72: mptcp: avoid unneeded mptcp_token_destroy() calls
- ae27baea9cbe: mptcp: avoid additional __inet_stream_connect() call
- c52207f85c8f: mptcp: avoid subflow socket usage in mptcp_get_port()
- a3beb4bf1bf4: net: factor out inet{,6}_bind_sk helpers
- f805626e3cf4: mptcp: mptcp: avoid additional indirection in mptcp_bind()
- 5bbcd109ff64: net: factor out __inet_listen_sk() helper
- 86211f9d790c: mptcp: avoid additional indirection in mptcp_listen()
- 4e7fe9d2245f: mptcp: avoid additional indirection in mptcp_poll()
- 36d4933b1c0a: mptcp: avoid unneeded indirection in mptcp_stream_accept()
- 6684c443b5a9: mptcp: avoid additional indirection in sockopt
- ac388877cff7: mptcp: avoid ssock usage in
mptcp_pm_nl_create_listen_socket()
- 3bdc46b9f3dd: mptcp: change the mpc check helper to return a sk
- 0b266479d09c: mptcp: get rid of msk->subflow
- Results: 87ca9f6d4f74..a989acf037d0 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230717T135639

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
