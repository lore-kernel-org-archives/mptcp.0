Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E91A5F
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 10:45:28 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id y14so39085393wrq.4
        for <mptcp@lists.linux.dev>; Thu, 06 Apr 2023 03:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680777927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/X5yNCoJN03FEX0s6l3ITYbIU68MMXGSTEXF+p6Dq0=;
        b=SIgEfc5jKNaB4oRrbei81KNYV23ULzlmk0FISTdIu/sR851YFNMw6NHHF9UDgBz+Vv
         WwWloRAsLPMy0T+PFKCewRQ+iK1/V4NL/EJvdxqwsoD2VT+aGnLAWTldg1fnSImIspvy
         tgKU/nwMHEQnGzxMprA3lA2NPgdJv6CApzP7Gghpcjzve/X6TLrTalmweL2EYEHIgs6O
         b4SM/MX9UAw17MrIknAKUWfkdTHn327HIFav7Z20QxE4W1+BhwEhpqBbfkJTL1HPGGAK
         P7mMOaNrDpPwHyY3SHqHPQF0uB2mgAiXkZyKLFdodmAPrICLaWJzhKOZ+1918w/rxfMs
         IBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680777927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/X5yNCoJN03FEX0s6l3ITYbIU68MMXGSTEXF+p6Dq0=;
        b=MESvfhoQ8SBFERUznL96aKZ99ep8aCo1000jhT2PtFDQ9j3xczcvkcVWbKRYmdXD0P
         ZfeaW0sHuCREYHNpyR1VOYhzaTGH5MfzyPA071Is4GhMPrb1omTGpSvrV2nX+eIXGD9K
         HcTkiuowikvso6cCnSGFecPO3vhBqPiS7vl8gF+vQ7ti+RXIop/sBh/3SiLSUsJlSSDt
         dPSTBUh1vD+2DMTawIo056w/wAvck58EVcc4LEpy0HN0Kwjg3Xt8fO02KOLx0PN9xMM0
         nZE6+K+rLsK6WcjCoMj+tmMHLsXbApnOsD4jRmHbEfqU+cPdpbPPBNlLilqt6uS41kHe
         lnhQ==
X-Gm-Message-State: AAQBX9fHJgtM0efR/zCZXxcE1CiPo9kTUztHUzoWcO8aZQSI72bxtizn
	3oXWsM9OZ3QO8SMPX0c3n2pt+Q1K75EBa5JAiYRhYg==
X-Google-Smtp-Source: AKy350aTJGjsCyrbFrhZ6rG/1VD6V3MRZN/K493i9Qikh/wyFp+nbHNea8eYHgMH9QrioMT4WeYJMQ==
X-Received: by 2002:adf:ce0a:0:b0:2c8:9cfe:9e29 with SMTP id p10-20020adfce0a000000b002c89cfe9e29mr5978111wrn.38.1680777926732;
        Thu, 06 Apr 2023 03:45:26 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f3b0:f2cb:5057:6981? ([2a02:578:8593:1200:f3b0:f2cb:5057:6981])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d5587000000b002cf8220cc75sm1435672wrv.24.2023.04.06.03.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 03:45:26 -0700 (PDT)
Message-ID: <ca12e402-96f1-b1d2-70ad-30e532f9026c@tessares.net>
Date: Thu, 6 Apr 2023 12:45:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH net,v2] uapi: linux: restore IPPROTO_MAX to 256 and add
 IPPROTO_UAPI_MAX
Content-Language: en-GB
To: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, mathew.j.martineau@linux.intel.com,
 mptcp@lists.linux.dev
References: <20230406092558.459491-1-pablo@netfilter.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230406092558.459491-1-pablo@netfilter.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Pablo,

Thank you for sharing the v2 of this patch taking into account MPTCP!

On 06/04/2023 11:25, Pablo Neira Ayuso wrote:
> IPPROTO_MAX used to be 256, but with the introduction of IPPROTO_MPTCP
> definition, IPPROTO_MAX was bumped to 263.
> 
> IPPROTO_MPTCP definition is used for the socket interface from
> userspace (ie. uAPI). It is never used in the layer 4 protocol field of
> IP headers.

(similar to IPPROTO_RAW which is < IPPROTO_MAX)

> IPPROTO_* definitions are used anywhere in the kernel as well as in
> userspace to set the layer 4 protocol field in IP headers as well as
> for uAPI.
> 
> At least in Netfilter, there is code in userspace that relies on
> IPPROTO_MAX (not inclusive) to check for the maximum layer 4 protocol.
> 
> This patch restores IPPROTO_MAX to 256 for the maximum protocol number
> in the IP headers, and it adds a new IPPROTO_UAPI_MAX for the maximum
> protocol number for uAPI.
> 
> Update kernel code to use IPPROTO_UAPI_MAX for inet_diag (mptcp
> registers one for this) and the inet{4,6}_create() IP socket API.

The modification in the kernel looks good to me. But I don't know how to
make sure this will not have any impact on MPTCP on the userspace side,
e.g. somewhere before calling the socket syscall, a check could be done
to restrict the protocol number to IPPROTO_MAX and then breaking MPTCP
support.

Is it not safer to expose something new to userspace, something
dedicated to what can be visible on the wire?

Or recommend userspace programs to limit to lower than IPPROTO_RAW
because this number is marked as "reserved" by the IANA anyway [1]?

Or define something new linked to UINT8_MAX because the layer 4 protocol
field in IP headers is limited to 8 bits?
This limit is not supposed to be directly linked to the one of the enum
you modified. I think we could even say it works "by accident" because
"IPPROTO_RAW" is 255. But OK "IPPROTO_RAW" is there from the "beginning"
[2] :)

WDYT?

Cheers,
Matt

[1] https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml
[2]
https://github.com/schwabe/davej-history/blob/9cb9f18b5d26bf176e13edbc0c248d121217c6b3/include/linux/in.h
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
