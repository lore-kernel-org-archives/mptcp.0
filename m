Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24C4168
	for <mptcp@lists.linux.dev>; Thu,  6 Jan 2022 11:45:53 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id y22so8460101edq.2
        for <mptcp@lists.linux.dev>; Thu, 06 Jan 2022 03:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nQjRLTkEL1j3zeT2hjE0hyKrqkRdtsOxdt96G4W1eFo=;
        b=56H9pegQYY7y6uNkGSI2SkrpeC7ceGrO2wQ3c5zWdRgfUdKNthnsXj1kK5U6VAH0BC
         9sfypi8Y1+y6wtvbk50F4VB5i4OmfI3cRjoLgwJE9N9WoJJlLouQ5SPzWegGtl3+HCe+
         Y71OVD2AF/JJMwywbP2scFLJreMDAm8zZJAAZeznG6pRnvMapFgfhZ0EqTPLlWyLj1F7
         8uOOc8HiOWYBH8pHlnC43SxvByZo7Dt/h1qN6TWShiJNyfpcpi9ukZfAq0a4EbeqAn+t
         edic7yz9PVL3Nx7Q/JkK+SKARkqRzV6k1kbCxybBopU4VvZpQirw952q99tprW22gZMS
         SF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nQjRLTkEL1j3zeT2hjE0hyKrqkRdtsOxdt96G4W1eFo=;
        b=x43bR1Ht76HxMKpIQGj7Xp6+anebfpAJNQDsrMRixZwaeTBbpGnWY+KQwobmsjlj5S
         r1phu/prihDhY5NEGKj9MIiJBJpd5B5n5ryqZWDmV3IWkQkdljh9sLcBP44Grg/X5QZo
         rvBhjJqRYqqobY1rIkRNLbOaylyDw5zyC2Pyo4QL7vqbBJ+8kU17gX+f1HY+pJPEEt88
         bQlB1iSY609e42CGSj6eLUDM4o7S7QjenigCRy+YiNEOer8bNQ1Ts6qxvNlJdeTCV5yi
         5tnrwi3q1uLjDVx27Ur1d/riiXnoDoKotBUQslBVvPVnk3xcvYA1Rw0q65aFzgcCDTjj
         R0pQ==
X-Gm-Message-State: AOAM532Pv+PN7U6pBjTqptaUrFX5mYSf89bLu3uEAzR5yZGeHPUIMlKq
	0+jwe0xDW0fY6TURqW38/66fdw==
X-Google-Smtp-Source: ABdhPJxhViPIGG1/DLGsKd8GxsVObjZeThA7V6XVIri73MlUI/PW4sZtn8SckVA5VFScHIejAtA+eA==
X-Received: by 2002:a17:906:b151:: with SMTP id bt17mr46653469ejb.193.1641469551932;
        Thu, 06 Jan 2022 03:45:51 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:f806:b935:3199:df74? ([2a02:578:8593:1200:f806:b935:3199:df74])
        by smtp.gmail.com with ESMTPSA id f6sm436096ejf.69.2022.01.06.03.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 03:45:51 -0800 (PST)
Message-ID: <8f6c0ebc-a9e7-e007-fa84-a49abfbffda2@tessares.net>
Date: Thu, 6 Jan 2022 12:45:51 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-next v8 0/8] Clarify when options can be used
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20220105155702.165123-1-matthieu.baerts@tessares.net>
 <CA+WQbwuF4REjgiEveFYs6=Dz9_fzMQaqorNepNJMBjfr_fWt=g@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwuF4REjgiEveFYs6=Dz9_fzMQaqorNepNJMBjfr_fWt=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 06/01/2022 03:58, Geliang Tang wrote:
> Hi Matt,
> 
> Thank you so much for this new version. Good catch on patch 2. It works on
> my test and all looks good to me...
> 
> Acked-and-tested-by: Geliang Tang <geliang.tang@suse.com>

As discussed in another thread on the ML, I just applied the 3 first
patches:

- 62aa763b1676: "squashed" patch 1/8 in "mptcp: implement fastclose xmit
path"
- 5c6f43e1c2c0: "Signed-off-by" + "Co-developed-by"
- Results: 720eaaa70083..02e9b8087979

- 55c56c19c276: mptcp: fix opt size when sending DSS + MP_FAIL
- 025c1fcd8fa3: mptcp: fix a DSS option writing error
(- 73463b55be2a: mptcp: Check reclaim amount before reducing allocation)
- Results: 02e9b8087979..d500488d62db

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220106T114429
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
