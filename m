Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440A28EA
	for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 08:28:14 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id a26so26377593ejc.4
        for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 01:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QezEKz77/Db/GC+vdqhiQIwuhY+qNfYlF6o+mILXDdY=;
        b=k3xKkqK8d6xfCj8E+OcF6B57KkJM4PkkFSPrCN8YRj8etjrJ2J8YzY825ZZU8dxHwL
         A+MPdmk3bf2WsT1rXQIDlNruJhs03w+hTzKmKMMnt738/sd+Peg/rj/IgXLmdH2y94o7
         1cjPh1h6pFjTlzwjGY4NDb6z+53VjEkcKdUqC7cIEMDUErSVdrxd/wUbDsIZ5/7kXZhR
         ozh4KghWE2CABfnkoSLFLL63nDyFO4MGWt5CTkUNxiViz3+ZquowLQqEDwRdrAiOFrRx
         Hy8r22W8r5Fhsc42ShLeiF9o3KV+Cp4AKLOOAcshSRXhsO7mBK9TYAc6XoDB2DdXi8eV
         o4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QezEKz77/Db/GC+vdqhiQIwuhY+qNfYlF6o+mILXDdY=;
        b=kjTqvVy3iCudI8AFv+cA1umEHpkd2l3EvOBp3T4ygOxr1nLAiLcR8FSinH6Oub3rTC
         TV+H0ovvIrgw6zESnXvYRvHWmcA2Y9bAtrmiKI+oBVcbNXo8G3GHte1dtFHWSf1UaJIW
         ICkNggMBB/Yk2WSV5YF/IWBS0lbwIQiBawwW9+1r6p+HWfUITjOGLK84A0qREeI86GAJ
         CxrVHsGTM3LyI+p0Ns1AHHgFygKbljLBaCPfqYx0zoQOkeTWUGQgSflTfqEk9VMYpY+D
         eILhiEBwBnUy629GW7P2dKNDdI2ca6zayEim6ElnpnL1AZw4Nj4tSeE1Pr5CXZR9J14I
         zbyw==
X-Gm-Message-State: ACrzQf01vZ9UoXOie2eeNDPF8RR49yf988T6IwJV1eHvSZ+tWfeCPYq9
	2JO/EMxUlE4xatvHOa71SyggmA==
X-Google-Smtp-Source: AMsMyM6qOD/x5bbY9+p6d3Z6Xp/kb+CsMY8Y5mdn24hKcbasvvISebmD2bgJKHB0R1CScIPpjJ0mvA==
X-Received: by 2002:a17:906:8454:b0:772:7b02:70b5 with SMTP id e20-20020a170906845400b007727b0270b5mr6092325ejy.114.1663921692676;
        Fri, 23 Sep 2022 01:28:12 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:5e2b:69ae:ba71:ae54? ([2a02:578:8593:1200:5e2b:69ae:ba71:ae54])
        by smtp.gmail.com with ESMTPSA id t22-20020a056402021600b00443d657d8a4sm5050904edv.61.2022.09.23.01.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 01:28:11 -0700 (PDT)
Message-ID: <1ccfd999-7cb6-3243-20c6-54299bc1b8a1@tessares.net>
Date: Fri, 23 Sep 2022 10:28:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 David Miller <davem@davemloft.net>, Networking <netdev@vger.kernel.org>,
 Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <20220921110437.5b7dbd82@canb.auug.org.au>
 <2b4722a2-04cd-5e8f-ee09-c01c55aee7a7@tessares.net>
 <20220922125908.28efd4b4@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220922125908.28efd4b4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 22/09/2022 21:59, Jakub Kicinski wrote:
> On Wed, 21 Sep 2022 11:18:17 +0200 Matthieu Baerts wrote:
>> Hi Stephen,
>>
>> On 21/09/2022 03:04, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Today's linux-next merge of the net-next tree got a conflict in:
>>>
>>>   tools/testing/selftests/drivers/net/bonding/Makefile
>>>
>>> between commit:
>>>
>>>   bbb774d921e2 ("net: Add tests for bonding and team address list management")
>>>
>>> from the net tree and commit:
>>>
>>>   152e8ec77640 ("selftests/bonding: add a test for bonding lladdr target")
>>>
>>> from the net-next tree.
>>>
>>> I fixed it up (see below) and can carry the fix as necessary.  
>> Thank you for sharing this fix (and all the others!).
>>
>> I also had this conflict on my side[1] and I resolved it differently,
>> more like what is done in the -net tree I think, please see the patch
>> attached to this email.
>>
>> I guess I should probably use your version. It is just I saw it after
>> having resolved the conflict on my side :)
>> I will check later how the network maintainers will resolve this
>> conflict and update my tree if needed.
> 
> I took this opportunity to sort 'em:
> 
> - TEST_PROGS := bond-break-lacpdu-tx.sh
> - TEST_PROGS += bond-lladdr-target.sh
>  -TEST_PROGS := bond-break-lacpdu-tx.sh \
>  -            dev_addr_lists.sh \
>  -            bond-arp-interval-causes-panic.sh
> ++TEST_PROGS := \
> ++      bond-arp-interval-causes-panic.sh \
> ++      bond-break-lacpdu-tx.sh \
> ++      dev_addr_lists.sh
> + 
> + TEST_FILES := lag_lib.sh
> 
> Here's to hoping there are no more bond selftests before final..

Good idea to sort them!

It looks like you accidentally removed 'bond-lladdr-target.sh' from the
list. Most probably because there was yet another conflict in this file,
see commit 2ffd57327ff1 ("selftests: bonding: cause oops in
bond_rr_gen_slave_id") :)

Or maybe because you were again disappointed by Lewandowski's
performance yesterday when you were resolving the conflicts at the same
time :-D

Anyway I just sent a small patch to fix this:

https://lore.kernel.org/netdev/20220923082306.2468081-1-matthieu.baerts@tessares.net/T/
https://patchwork.kernel.org/project/netdevbpf/patch/20220923082306.2468081-1-matthieu.baerts@tessares.net/

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
