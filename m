Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7F17A
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 14:50:05 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id qx21so4821155ejb.13
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 06:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IJDx1gttoPXIcMFqoVrCSgQAkZHk45zYp/j09f4RY6w=;
        b=gm2Q+UFaFKmwzOM4pQXDF8SWZktVfKAuL3/CYKunS+O1RN2QQqmjx6nK4GDCB2QZcR
         6eKxbrSNd1JYBqFo4YJbA7IRAi49hBTVlur6ZcVKJALouegqK9j6ZZu1GMOMSU7GI8fj
         DZXPltpormPE6kq0c9S4n2rU4Vf6BFaQK8J/2ZkY45x9oviWBfUiD1r/MdG2C9O5n+aJ
         6JIot0lRZzOlpp0cZX+81INCWvJvTV5IigtlCjwTk+iiIGBuhm0UpdqpJslw/ciDpvfw
         nAO5rWFe9CQoeN5kNQ0LN6IMe9Wb/b2eVBrSiGpufeKVOi5wKL3jJQsKWPH20OHURkr3
         9ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IJDx1gttoPXIcMFqoVrCSgQAkZHk45zYp/j09f4RY6w=;
        b=mfJ7SI15a2o7Vi4AOu/KGlX0A36gCua1erz5ktuvJKnpmtRqb6vgFzp4oP5NUZa0pa
         fh9qN+8Pt4WKGaSA8bEhLB3mTStvcBHLKiKCx5fr4w9zTK9mTAVoSPAVCO2p5Gh5QrYm
         9KGWUifzct7ggrn/N01BBd5nY2rOCwLjzv52cWU7bTYk4do12nkOXt44scONSMisQDnm
         jwpG0akkj1wHtKIp5qqGXDMQmHgxXPY3xvAREmY2d3WlVdvHO3NAk1MyCRAcvRqv5eJq
         DaY9a0vQoM+JBmsOwsJS+NoGnN1xa6Dd2DLDfNFB8uE56zSy36YDCpw6yNlSAsnhuM4i
         V48w==
X-Gm-Message-State: AOAM533TYWajHjrh4gW2j+08n/Th5R3gG6Onor2sPJaCZ7ca2QMeklA9
	Wevo2QtsDHV7e5TjUiQV2qdV0ujq/p7eWNokMdY=
X-Google-Smtp-Source: ABdhPJwqUgllYNyaziWJYgANGX5dkkD8NaKveBNtL7IE3IS2jj75g8PbWJPzoqftCzHj/EwE5k5ynw==
X-Received: by 2002:a17:907:6006:b0:6cd:efc0:3d67 with SMTP id fs6-20020a170907600600b006cdefc03d67mr2597653ejc.32.1645714203884;
        Thu, 24 Feb 2022 06:50:03 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id p21sm1447633edu.107.2022.02.24.06.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 06:50:03 -0800 (PST)
Message-ID: <ded883a9-0c56-13ef-6ce0-fce83534a20e@tessares.net>
Date: Thu, 24 Feb 2022 15:50:02 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next v3 12/12] selftests: mptcp: join: helper to
 filter TCP
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20220224135619.2523272-1-matthieu.baerts@tessares.net>
 <20220224135619.2523272-13-matthieu.baerts@tessares.net>
 <CA+WQbwvVkYTo6ARse6J8EvSZkJ=tpcUMipUFOLj+zFLBi0RKFA@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwvVkYTo6ARse6J8EvSZkJ=tpcUMipUFOLj+zFLBi0RKFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 24/02/2022 15:39, Geliang Tang wrote:
> Hi Matt,
> 
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2022年2月24日周四 21:57写道：
>>
>> This is more readable and reduces duplicated commands.
>>
>> This might also be useful to add v6 support and switch to nftables.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 20ec31b05990..977e5eb28ba4 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -624,6 +624,15 @@ pm_nl_check_endpoint()
>>         fi
>>  }
>>
>> +filter_tcp_from()
>> +{
>> +       local ns="${1}"
>> +       local src="${2}"
>> +       local target="${3}"
>> +
>> +       ip netns exec "${ns}" iptables -A INPUT -s "${src}" -p tcp -j "${target}"
> 
> How about being compatible with ip6tables too, like in
> reset_with_add_addr_timeout().

I started to add it but because there were no need for the moment, I
only added a comment in the commit message. It can easily be added in
one place later.
Or do you think it should be done now?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
