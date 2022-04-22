Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F602901
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 15:18:59 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id ks6so17076621ejb.1
        for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ABA/Fiyk+vkWql/jfMJsIt6iBH8m8N6STsuDcUGUJMs=;
        b=1TSZE7sI1kvq/rabqrkg07nqkEZWdz4yr7cHHXEZSjjew0k4IZpe7fTyesv7gH5vDp
         Hwteh4dfameYQyXI2FEOJMQkdfBIzNd6oy9JfVvQj8NH/CCE99TMCui2hTlA1Taj/uZ+
         gdlGXRc3QBG/bWNYmxEpfbq9qFFDwtP9qr0TnJJcYzGY4rr0YdyuAW6Zr1wOzYsLpG01
         DZLSBFXkZca9EQQZkD10nT42gHdbCRCkLrtLkNXbIy7+xrCr6IchA3GwFeVKtG7flHvT
         ptBDTsTwbzVG2ZSPW3VHozCdBpVOSvVmcMBbBBexzQ7FTix7ddbtcioGePebY6dCOXbR
         8pzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ABA/Fiyk+vkWql/jfMJsIt6iBH8m8N6STsuDcUGUJMs=;
        b=lPe6zIy2leaSOQvMwle28GXQoZMkUTT07N3zCjsc3oAEaA02ouJhpWkYOaGi3n4Dew
         rprjiFc9QXbM/8eFLbBk6zh+1sZWHZLxBAGHUsCbMdGQ+xzweu6AiY7IMSCO63DSb5jl
         WxpKCasoB4TsqEaqeAtqzlBoABp/O/RDVxblMQzk7YWLJ2rNd1eJGqIovapXfDBu7RFR
         o1NJw69oc9FzVXn3C+mREASP6fCJBT1KQBFY/H0EfKtc7IpRsFgI17ANqt2FNZ688A5+
         OwFLwTFFOeYO4TyF2Qv7s2DE+wsinWsOIqoKAFrcysDLKjR6K1UC4HsGgPfNUGSruGEG
         nhPg==
X-Gm-Message-State: AOAM533qOwhdJ2otNHkPOzULpzTYrtVJxlgbSqD9wmVby9UNt23y+XeY
	ezsoZzfRzFdl3lgOz4Mq8w+t+kX6eVfDYwHG
X-Google-Smtp-Source: ABdhPJzgtILdaJ2BAI9USy2MldvLorI2vwrR+om/r0ElH8CDUc8HmQRmKEjfPW0SASM8Dj44yRTKXQ==
X-Received: by 2002:a17:907:2d21:b0:6f0:7dd:7490 with SMTP id gs33-20020a1709072d2100b006f007dd7490mr4396348ejc.702.1650640737844;
        Fri, 22 Apr 2022 08:18:57 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id j2-20020a056402238200b0041f351a8b83sm1020219eda.43.2022.04.22.08.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 08:18:57 -0700 (PDT)
Message-ID: <5334c79a-d0a8-e52f-1053-eacd5db0e118@tessares.net>
Date: Fri, 22 Apr 2022 17:18:56 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/5] mptcp: improve mptcp-level window tracking
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1650550242.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1650550242.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 21/04/2022 16:20, Paolo Abeni wrote:
> I've been chasing bad/unstable performances with multiple subflows
> on very high speed links.
> 
> It looks like the root cause is due to the current mptcp-level
> congestion window handling. There are apparently a few different
> sub-issues:
> 
> - the rcv_wnd is not effectively shared on the tx side, as each
>   subflow takes in account only the value received by the underlaying
>   TCP connection. This is addressed in patch 1/4
> 
> - The mptcp-level offered wnd right edge is currently allowed to shrink.
>   Reading section 3.3.4.:
> 
> """
>    The receive window is relative to the DATA_ACK.  As in TCP, a
>    receiver MUST NOT shrink the right edge of the receive window (i.e.,
>    DATA_ACK + receive window).  The receiver will use the data sequence
>    number to tell if a packet should be accepted at the connection
>    level.
> """
> 
> I read the above as we need to reflect window right-edge tracking
> on the wire, see patch 3/4.
> 
> - The offered window right edge tracking can happen concurrently on
>   multiple subflows, but there is no mutex protection. We need an
>   additional atomic operation - still patch 3/4
> 
> This series additionally bump a few new MIBs to track all the above
> (ensure/observe that the suspected races actually take place).
> 
> I could not access again the host where the issue was su much
> noticeable, still in the current setup the tput changes from
> [6-18] Gbps to 19Gbps very stable.

Thank you for the patches and reviews!

Now in our tree (feat. for net-next) with Mat's RvB tag:

New patches for t/upstream:
- 61ed3e818378: mptcp: really share subflow snd_wnd
- d5b00c55441f: mptcp: add mib for xmit window sharing
- 0b814d52c6bb: tcp: allow MPTCP to update the announced window
- 87ce505746f5: mptcp: never shrink offered window
- dac3ff7c87fe: mptcp: add more offered MIBs counter
- Results: 9709ecfa06e8..5b7d53ca0bd1 (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220422T151603
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
