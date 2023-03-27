Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C803C0F
	for <mptcp@lists.linux.dev>; Mon, 27 Mar 2023 15:33:36 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id eg48so37774673edb.13
        for <mptcp@lists.linux.dev>; Mon, 27 Mar 2023 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1679931215;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7BpBQs9x4EXamv5MAsF7reiYJD9ZZh3ggnlHQmaA69I=;
        b=ZVPhXG9/zH4lLegKEoJS57mR8SXfIQK2kOh2hJOjEAwJ0lLVtmiWbNAG+tBxkVBAug
         TXyB7ModTCEXGA6SJ0cBIwBsSAlxssK3wcUy3lOJnlUo+6wwar8wUfKJMOM2v+Mw5fk6
         LiqRudPL3l3kWQU/JUKlLkK6iU/RWpwVXjMml01EBdXifaUulaCMP21VKTrcm4oswkqL
         d3oyFL/aiU4uNiMy2tG0+ieVRv12tIHPTgBkxkpb6zRfexBzQ61fBRVwEB+wv9OfyfNr
         8wlY88pnZwoAP5aDYlGDLYLWHLW1jf7LPbFwHYpEWUMw1xVP0+08AZkKUs8X5M+c2+x/
         b8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679931215;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BpBQs9x4EXamv5MAsF7reiYJD9ZZh3ggnlHQmaA69I=;
        b=52/EyaLuNwb5G0eOSXiYZWR4haCwn7Nc/ao9iMmEPJBOogWIF1VvP6eyX7TVndPZeQ
         fAhIKXRFqdawrnR6BMvW5yeWRNQGFzCmlpXGQ+Ib46uASD/XQ7mDNmlXLTsLWsm3gH/K
         EoRxNzKN9msP/L6H0T9frIe51t28r2gI4MlJ0ZR29g8Hlg0j50sBQ40WoXjhRTK5Hvrf
         gSXUTQnO4cxUels8zeq3/N30pRyBBHxHjq2ifEF2Gq2Vx/h+5cjSJibutGagf/4vycpD
         bv566JYvm515Afb2FUVFTVHQoZledXn4/u6DCvstxFhPZ3Q8RPc8h/zMNRqNAt7W2vCE
         kFFA==
X-Gm-Message-State: AAQBX9dbFL6E+vsx0ZVzabNyg5ej40PFJKJknea8tXmLF1nUfcL1HSRF
	GeGIlvK/Va91w8Pe6xL9i5FHdmf+EhSs9TuGkVed0g==
X-Google-Smtp-Source: AKy350YsQfQCO3xVktWrMfd4e7CVf/p2bQTy5ruqDm+KNuZWyEPPYJrabFlNtibJ/eExGhC6gY3d3Q==
X-Received: by 2002:a17:907:8b96:b0:941:1cf6:dbe3 with SMTP id tb22-20020a1709078b9600b009411cf6dbe3mr7726861ejc.7.1679931214820;
        Mon, 27 Mar 2023 08:33:34 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id ce20-20020a170906b25400b00929fc8d264dsm14310037ejb.17.2023.03.27.08.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 08:33:34 -0700 (PDT)
Message-ID: <c85f57bd-56f0-9c92-3a63-cb51c8b0de5f@tessares.net>
Date: Mon, 27 Mar 2023 17:33:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH mptcp-net 2/2] mptcp: stricter state check in mptcp_worker
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <9aa2681941d55c2ae198167c86c3d0b8ecfbf551.1679654040.git.pabeni@redhat.com>
 <10b158069455d831d9efc547bcdb3a6379234f1c.1679654040.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <10b158069455d831d9efc547bcdb3a6379234f1c.1679654040.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 24/03/2023 11:34, Paolo Abeni wrote:
> As reported by Christpher, the mptcp protocol can run the
> worker when the relevant msk socket is in an unexpected state:
> 
> connect()
> // incoming reset + fastclose
> // the mptcp worker is scheduled
> mptcp_disconnect()
> // msk is now CLOSED
> listen()
> mptcp_worker()
> 
> Leading to the following splat:

(...)

> This change address the issue explicitly checking for bad states
> before running the mptcp worker.
> 
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/374
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the two fixes! They look good to me:

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

As I said on IRC, it looks like your patch 1/2 could also include the
commit with the same title we have queued for net-next, in our export
branch[1]. Please tell me if you are OK with that.

[1] https://github.com/multipath-tcp/mptcp_net-next/commit/58e381ebe218

I just applied the two patches in our tree (fix for -net):

New patches for t/upstream-net and t/upstream:
- f5fbf4c258e7: mptcp: use mptcp_schedule_work instead of open-coding it
(net)
- e8fc17094d85: mptcp: stricter state check in mptcp_worker
- Results: ad9a6d9ee2fb..c50cadb14dbb (export-net)
- Results: 3ab8c05f4350..3dca512f38c6 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230327T152231
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230327T152231

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
