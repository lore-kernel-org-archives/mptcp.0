Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968DC440F
	for <mptcp@lists.linux.dev>; Fri, 19 Aug 2022 15:20:54 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id gk3so9400243ejb.8
        for <mptcp@lists.linux.dev>; Fri, 19 Aug 2022 08:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=i8q1GegoN+sP33ccaU6zv78I0cAcWc0q0JE7i0pJirQ=;
        b=lKqJZxvBoPBhdI3jjDh1Mr3I5ysANspyrVXVlFexKwDUlghU7ZB5Kwn7wWYjDnTZZ2
         kfj8b7yLnLUxdXwPGol8UJ0OJB4dszvgH9HG9J2sF3ENIyQ5aDGJtUQk7TXmyOMEcdhW
         uj+hm8ruaoSZZ/EQ8QDZ8KWNtW+CkF94rtyArsKT7XD19yizp3B3LfslSnIby7BE3VFN
         BUT+UelGQ04t/868g2w7GuIpnfdU9H7jQeT8hfJ4iqQWcSKY1wh+5Cy27a/2bcOP8bng
         1NDsDf1NS/TsCchJcA8D0o5HXzg1riIfVHG3dhlT95zHU+CCjd/aeRlAd8txh6YOAELu
         p3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=i8q1GegoN+sP33ccaU6zv78I0cAcWc0q0JE7i0pJirQ=;
        b=0RdqAP/jSXvW9CVv0/01iPZbAry+gjtuh3Pcvp73QGr6nfWK142qWzizFb3C8jWJE6
         I230UbYbB5wONYytulMbYhzkgaoL6muTjmSu9FAfkTXgUpgREPVvsMGz2Dw+cnRORRw9
         NdB6nMg8Y7hDINhyRRRfXwfUtrrmhL0ditkPFJwLp3WIYYZai2l+/6naWGEjw8heNw8v
         Yjw8FSpJvAijb/UmfbbP6cSyFLZkKxWEBcIAZyQmA8oXQttpPHBR8Cl0HRBmUFF/+cVm
         erO7Njwe2gbUTX+cbA0TP4wPzTfE8AYFX01sCVcxpocq6IzFu9in98HWLrHerRNLYk4r
         B7Hg==
X-Gm-Message-State: ACgBeo3jD7RtpvgcLcA0w4eGdfL8YiAnXF2gWr1v3JTXgvNs09VX/Wiz
	38LHmwZW/hmVMn4FumjC6+gx+A==
X-Google-Smtp-Source: AA6agR6YJo01NQyAY3zBrhNOBNbbOV2cVKRhgoN5eBBkfbJvMWSp9BtVbXZyzPJb/0bpiUuFI9DMmA==
X-Received: by 2002:a17:907:6e14:b0:730:a229:f747 with SMTP id sd20-20020a1709076e1400b00730a229f747mr5507174ejc.202.1660922452232;
        Fri, 19 Aug 2022 08:20:52 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:1cec:2730:4dc0:d9b0? ([2a02:578:8593:1200:1cec:2730:4dc0:d9b0])
        by smtp.gmail.com with ESMTPSA id i23-20020a170906a29700b0073073ce488asm2465382ejz.45.2022.08.19.08.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 08:20:49 -0700 (PDT)
Message-ID: <361c7c0e-29bf-af9a-8ce0-e9668f9e2267@tessares.net>
Date: Fri, 19 Aug 2022 17:20:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH RFC mptcp] net: tcp: prevent transition to FIN_WAIT2 when
 mptcp has unacked data_fin
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>
References: <20220818162123.30198-1-fw@strlen.de>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220818162123.30198-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian,

On 18/08/2022 18:21, Florian Westphal wrote:
> When an mptcp connection closes down, a MPTCP-level DATA_FIN (flag in mp tcp
> options) is sent.
> 
> We should wait until we can be sure the peer has received the mptcp-level ack of
> that DATA_FIN.  Else, we can end up with the last mptcp subflow in FIN_WAIT2 state.
> 
> In that state, TCP won't respond to incoming ACK anymore, because no
> progress happens from TCP point of view.

Thank you for looking at that!

(...)

> Its possible to either change tw_sk to have enough mptcp context to be
> able to send a packet back

Do you think changing tw_sk would be accepted upstream?

That would be good for MPTCP from a perf point of view I suppose. Or
maybe not worth it?
If it is worth it, could we have a 'struct mptcp_timewait_sock' for
MPTCP case, extending 'struct tcp_timewait_sock'? But then I guess the
"annoying" thing for upstream is that we might have to modify or split
functions from tcp_minisocks.c if we cannot add more indirections.

> or we can supress/delay the tw_sock
> transition.

All the time for MPTCP sockets?
Do you think it the impact will just be minor?

> This is what classic TCP is doing when it receives another
> FIN while in FIN1 state.
> 
> This change makes the test case work (another dss ack is sent), but
> there may be other corner cases where we need to delay the sk ->
> tw_sk transition.

We didn't hear anything about other cases so far, we can also see case
by case for this situation (corner cases at the end of a connection) :)

> If the general idea looks ok, perhaps its better to replace
> 
> tcp_time_wait(sk, skb, ..
> 
> with a mptcp aware helper, e.g.  tcp_time_wait_check(sk, skb, ..
> and place the option parsing for mptcp-subflows there?

Would it be better because we would put this in tcp_minisocks.c? Or just
to isolate MPTCP specific function in a small and dedicated function?
I don't have any strong opinion about one or the other.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
