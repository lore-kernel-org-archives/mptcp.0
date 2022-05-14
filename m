Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02853362
	for <mptcp@lists.linux.dev>; Sat, 14 May 2022 08:26:59 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id w24so12434786edx.3
        for <mptcp@lists.linux.dev>; Sat, 14 May 2022 01:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=SKsGCHR5ROGQhiCNQEVtW6jmNWaH3PTbGWZ7x8w58RQ=;
        b=uxhVKAx9V6EOJaI+F+Rlbb3cxZC68SuLfpwcyV3b0jR1oh4W49+NbHeTB2BRsAJyR+
         adhh1jzHhc78o036Uv6/l4IOgeKTr8B23o5bEo9U1Fj1UAAaki1SXuuWxbovMtIcSkWH
         YlZ442FAV2S5QiY9Efnm+DDzKCaBkda0vo7fMc6xZAR8P1Cq/RG6sM5RZjEX3R8RckF4
         RUbIGdgSz49QXmufAXt8Jipz/AQiVN6g7BrBg5bcC11IiX1tmPviKZSSTVufWVCazlS+
         2+vvYnrsnFqfdCH6+/DGigUqvXhDWBJiEbUcfNBhce9c56C5cRmT9/r32ohbBz78LZRQ
         KdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SKsGCHR5ROGQhiCNQEVtW6jmNWaH3PTbGWZ7x8w58RQ=;
        b=GLsle+fr/Q1hU/sXseYxtNa3KWE+1nDKzBiPoMh7x3ReVB/gznY9cgsLEk9NAo0IVZ
         fL2pQUbzQsizwGnpUuewSlPiMEPxb6Fj3E8thZveql8zYld8mYcj6OYapbuSAcJn66tV
         oQD1p3QTcTMC/R2mx070R0iZwPT7ywz2he4gb8IopobIZhBlO72GgnpJFBMIgKyM3JMu
         kvG8bnCiVRqT2Zlev3H4n9l073dYY994tHmrwtfwFYqDv1eHCcadyOHXDgGZTDz8K4Ra
         8JqLFKcrURIEe9ddkfhlx2/Q+wmc7gu9oLE0HaGIC6qQUbkoJyt30CT8yLATWjrihqz9
         4+Ew==
X-Gm-Message-State: AOAM531DrF9QL+WR5e5W/7HO5b9vRzCCUXbDhEe1b3V6jRWY5xPEJuLn
	P2RCQnD5kEetkv8Qc60ZVMmcL6ddsFGq7YmU6xo=
X-Google-Smtp-Source: ABdhPJzFe61vUW9FlZd28YcA7C9qSaFtOZt9xALFL0bOBhzYhW+xy3JFTFVKedfIwuanDID3UFmlOw==
X-Received: by 2002:a05:6402:641:b0:42a:6266:3f19 with SMTP id u1-20020a056402064100b0042a62663f19mr2546833edx.422.1652516817658;
        Sat, 14 May 2022 01:26:57 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:9bf0:c219:c2f6:9f52? ([2a02:578:8593:1200:9bf0:c219:c2f6:9f52])
        by smtp.gmail.com with ESMTPSA id c25-20020a1709063f1900b006f3ef214e42sm1511463ejj.168.2022.05.14.01.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 01:26:57 -0700 (PDT)
Message-ID: <e521ccd1-fab2-fe14-85c4-91e7e17cbd97@tessares.net>
Date: Sat, 14 May 2022 10:26:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: add MPTCP test base"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <6f5f38cec460bdd53b7d0f179816a1248c3db0ee.1652487491.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <6f5f38cec460bdd53b7d0f179816a1248c3db0ee.1652487491.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 14/05/2022 02:19, Geliang Tang wrote:
> This code using ASSERT_* instead of CHECK_FAIL should be
> squashed into patch #3, it shouldn't be in patch #4.
> 
> Squash to "[mptcp-next,v2,03/14] selftests/bpf: add MPTCP
> test base" in "update bpf patches on export branch" series.

Good catch, thank you!

- 6e72fba9dc4f: "squashed" in "selftests/bpf: add MPTCP test base"
- Results: c9545a538777..71f8702ac0b2 (export)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
