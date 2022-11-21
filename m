Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541A37E6
	for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 10:30:20 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id e13so15588907edj.7
        for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 02:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h73wryRxw3m87A97zBmMMF4DxuqYWYTCSaetzbmp6YQ=;
        b=QHyzFyOJPIVxCHdUoBWhEyMeK0pg4rSYNzRsBxJvO2zXbHuyc86cZQyTqWl4qIUW+I
         7ulv5htGz1Xq6qFO+2QddmLq/9Ek57BmMB5ia6MBeJ9z2F1Si0VGYVzgP8+lyhwrIyA1
         NX0UfDXVUfY4TnLICPDOJUKYWCcco+TNG+fbGN4bs3zuZ14gWXAMuHAdpMwjR0WgRlrf
         7LzrhuhU++YteC8Fso7Mun8bAZUa9AMVXU4BjnmJDGxjxetRv5Oy6QEuDKlUok0ZChXU
         bcRpZw1EHZIepys1RbTA0bsEqxFH9qtcVtVAuJ2ZeZvcZ18v8Bj3ZHuFFDkEtXY9qx1X
         2z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h73wryRxw3m87A97zBmMMF4DxuqYWYTCSaetzbmp6YQ=;
        b=SydOfly4IfrHZvDhzxMFCul1XCavvbpRDMXDOjrQ0TA6rJVG4kn6Q9CETF/HXoTT1u
         CquKDYzCIQ1FigwIXHv6dUwy5CYzFdwgqtrSa/QMFWxY8ZJ0JpxlUtFEPu+u8wzMUe/8
         q5BxLrjYYTprpHng+1Jx+0aItShr1hJhLNM6NkrJoHG6CDa3jClUIRT9XI84yw3RVQuF
         xUnRH5BLOE1lB9k9o8mLugZxPQyXg49YBRTpaaWtc5pFNYcB5/wWs4RFaYsRK05htwBa
         Qzqr3dHpEbpqW7i+RuisgEeBMFfO8UdROwU/I6qSxvQMQ+faye2KNBwgweJ6/Xn3ZaQi
         Tdhg==
X-Gm-Message-State: ANoB5plQfSy0AmipcEiT+ATOvzuQzBJly+K+b7zLechr00sd+CBSM+Zo
	m4GSQIwyjYCdTgahDSuvFSURObBnSmSvXA==
X-Google-Smtp-Source: AA0mqf7r26fbwvm0KVfhG9MojyELQvfJwN7j/A9Dfdw2lDYK1KBWuedWt8JjhydZwaA9SXWj6875JA==
X-Received: by 2002:aa7:c841:0:b0:45d:2a5:2db8 with SMTP id g1-20020aa7c841000000b0045d02a52db8mr520059edt.105.1669026618513;
        Mon, 21 Nov 2022 02:30:18 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id jr6-20020a170906514600b0078d21574986sm4860888ejc.203.2022.11.21.02.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:30:18 -0800 (PST)
Message-ID: <767966fa-05ea-0b9b-f310-b2c3c5f85414@tessares.net>
Date: Mon, 21 Nov 2022 11:30:17 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: add sched_data_set_contexts
 helper"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <20221118221251.4330-1-geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221118221251.4330-1-geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 18/11/2022 23:12, Geliang Tang wrote:
> Fix this warning when compiling with W=1:
> 
>  $ make W=1 net/mptcp/sched.o
>  net/mptcp/sched.c:97:6: warning: symbol
> 'mptcp_sched_data_set_contexts' was not declared. Should it be static?

Thank you for the fix and the suggestion!

I reverted my workaround and applied this patch:

- 5ee2ef57cd35: Revert "tg: tmp workaround to avoid CI error"
- a376f74a8a99: "squashed" in "mptcp: add sched_data_set_contexts helper"
- Results: 33c2d9f3290e..839f235881d8 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221121T102509

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
