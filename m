Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF242C81
	for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 13:12:34 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id h7so10373839ede.8
        for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 06:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2yHwVrSFNuqlkG3lA1boffwxIt2SWeciZXkOoTOOWk8=;
        b=irHtIppU0goRenhg+uOkMvnuQFYoR5NyPy81RoTf8mT/oSaTWMgJSkqvIe47YtkgNE
         qfLm5e2V/n3PzzJFlIluWA+8yVyNVBUVGcXpqdmdvqjq6QZbeATKZgGKXGtOFM0S9iA0
         8DuR28Xn1A02VkBg+m8ZUEhF/1budhYqgrAjVOcMsRGTXpHU7y7NgwMMUrRiH7rpMvE7
         P+H+y//wsuv6lCwtDSrCkgs9lt4Uz0ZumEoRviYuexZRD4sm0mqzC7lCHqBM3H+F/Y9/
         R03LlZbsgn0yl1VrDHNg8kN78WcxNgvK7S/6LDrj5Z5VDzOLgkbY+WsbMRo/knVM7uQI
         zhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2yHwVrSFNuqlkG3lA1boffwxIt2SWeciZXkOoTOOWk8=;
        b=BMz0gLS6HxG2yXEAPyTiPRJ1NbDBw7y9zCBl7En6ptOG8BUxp1wx/EXDeUAg2L5dTk
         bc52KOQf1TXXGtGkLhoigxqid/TVtdEgnxxZhXHsJfkyZIpzVzfW6bTG0FSrKrNumhcB
         xS/REjE2lBJ+atMOIY6gSLMXkCvvKucnmFwMJJi8YM4mW3ksQ3sxzsyriaNHX5TwwW6Q
         2ID273DhzoiuZhCPWSqYR18TyAcJejabUJZnliQcEJBMKjpTMZB4bv6NgRMa33Q+r3kn
         5JtgAx5YFgYvl0y3qdM7Yta+AMdCYOtZp9IF6mysklWXXsSKV3ohbo+aqTLtB/DuBMMH
         2hRw==
X-Gm-Message-State: AOAM532yPw8Om1kOc7jkCrOFLSERPhZR4AmuruiHZ+Sq2EAsvDGQ7nxk
	9Sm+uDj/T8RP7cf6NRH5IBkvRw==
X-Google-Smtp-Source: ABdhPJzNfskc1DdUwLMl+a3klShXxV6oz0haDe+POSdcchEK4zRBU+Q86qsgHaavlFffrYLDgBeA5A==
X-Received: by 2002:a50:e184:: with SMTP id k4mr44823445edl.217.1635340352350;
        Wed, 27 Oct 2021 06:12:32 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id nb1sm6080599ejc.56.2021.10.27.06.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 06:12:32 -0700 (PDT)
Message-ID: <a53df65d-9a09-0a90-b49d-5e529da05d31@tessares.net>
Date: Wed, 27 Oct 2021 15:12:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next] selftests: mptcp: add mp_fail testcases
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
References: <98ce131530c3ae91bf2ca29e6566ca1f7debe202.1635330390.git.geliang.tang@suse.com>
 <0014ae81-c8b1-e3d1-4580-40bb299c17f4@tessares.net>
 <20211027130800.GA3518@bogon>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211027130800.GA3518@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 27/10/2021 15:08, Geliang Tang wrote:
> On Wed, Oct 27, 2021 at 01:07:20PM +0200, Matthieu Baerts wrote:
>> On 27/10/2021 12:26, Geliang Tang wrote:
>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> index 7ef639a9d4a6..8bf38db1d54c 100755
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> @@ -232,6 +232,20 @@ link_failure()
>>>  	done
>>>  }
>>>  
>>> +checksum_failure()
>>> +{
>>> +	tc -n $ns2 qdisc add dev ns2eth2 clsact
>>> +	tc -n $ns2 filter add dev ns2eth2 egress \
>>> +		protocol ip prio 1000 \
>>> +		flower ip_proto tcp \
>>> +		action pedit munge offset 148 u32 invert \
>>> +		pipe csum tcp
>>> +
>>> +	sleep 1
>>
>> This looks dangerous to me. We should probably check tc counters to see
>> if the pedit action did something, no?
> 
> I don't know how to use tc counters, could you please tell me?

Davide suggested to use something like:

  tc -n $ns2 -s action show action pedit

But I didn't try.

Thank you for having looked at the other points!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
