Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB0723A5
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 10:17:16 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id bo30so9684019wrb.0
        for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 02:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SM1RcPm5LW0SOhN+ekCE6Mz8oETeJiZWG11H8NNN+0Y=;
        b=iMRhTSXtNQijeLDd/PDkG3gyDHr2u4FekY9/cOYekQksdkPjpHcGQDNr6uB9ShdxF3
         gOmluninYSFVco7gonW9qepuBOk3mGMnEht5X2sxPzHgijXDQcaEiio2N48qXIj7byKZ
         4fC0OUfemaXEvffkQuyEcrBoFjD3LwNrgVMT//ct5r0mT7+n29F5TqeNPpkYbRw8bHTv
         HPhrYL4nudeRXjfVY6A4VPWKHfcF5kF7bt2jbFqEnMx8pQyywB4AwNUtEabc2pTJSoXE
         uzX1X3dwX/rJ2yQfK4oWFPvCDtCqoGhF1+D5TWBQzQvTSoDh2KTnqeV59Onns8AcB8J5
         w7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SM1RcPm5LW0SOhN+ekCE6Mz8oETeJiZWG11H8NNN+0Y=;
        b=TXptpr/NznTjqXZ+sPSJV9SmHVF4YzIMSxo0WlkTTqQeSurm1LSScbgxJa5XQXD52s
         I99A5S4JwLAYPVQKgNIKRYPzAA2AChJTt+cE6zk4il2hX03bNrnFG7XvNKQOAY7a5I6b
         4p/kkyJy8iEkqJCZp/cxxbHIwHmz2bgyqp0UaKnoEJT4kVuJclzqCqN6NX1YzbceGTpd
         67+acuP1PBBg7jlP9P2Zy2FDbgkMMoBrhjbk2miRx+pIS0xjs0WnP1BGMxfxrwY3XgQv
         3nVzQgZ1SLEeeO4oyrBlKApQHAyYr7m9eI+dQIG50dhnDYjRqcgHLqvsC/cE1ckKz3Js
         csMA==
X-Gm-Message-State: AO0yUKVngmzShKJmT+t7kJEzjiAszs80C3LEfW8RALC2PFLoZIC15oS5
	va88DaW3JTEU/PuGmMIFYEH7HA==
X-Google-Smtp-Source: AK7set/eJfBieSEfF7lxWclqaZg3crMFBfPBssN8ulpvOjOOb9EOVDBID9DWEux5VQwtEL6kLbmHow==
X-Received: by 2002:a5d:56c9:0:b0:2c3:e07d:46cc with SMTP id m9-20020a5d56c9000000b002c3e07d46ccmr10442788wrw.41.1677147434374;
        Thu, 23 Feb 2023 02:17:14 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:b5a0:3898:2dad:3d15? ([2a02:578:8593:1200:b5a0:3898:2dad:3d15])
        by smtp.gmail.com with ESMTPSA id t4-20020adff044000000b002c5694aef92sm9586601wro.21.2023.02.23.02.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 02:17:14 -0800 (PST)
Message-ID: <3aee0b40-c744-77d9-5bd5-41651bc2c2b0@tessares.net>
Date: Thu, 23 Feb 2023 11:17:13 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mptcp-next v3] mptcp: update userspace pm mptcp_info
 fields
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <7f695489e0ecba3f0951193be81a1620b1f8e6e7.1675410794.git.geliang.tang@suse.com>
 <691e7dde-be9d-ee56-73dd-e6e6ede37d06@tessares.net>
 <20230223055328.GA24434@localhost.localdomain>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230223055328.GA24434@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 23/02/2023 06:53, Geliang Tang wrote:
> On Wed, Feb 08, 2023 at 06:43:58PM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> Thank you for this v3.
>>
>> On 03/02/2023 08:55, Geliang Tang wrote:
>>> Increase pm subflows counter when userspace pm creates a new subflow,
>>> and decrease the counter when it closes a subflow.
>>>
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/329
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/330
>>
>> Sorry, the description of #330 was not clear: pm.subflows is not
>> incremented for the server side when using the in-kernel PM if I'm not
>> mistaken. I just updated the ticket to make it clearer. So this patch is
>> not fixing #330.
> 
> Matt, how can I reproduce the issue you mentioned in #330? In my test,
> pm.subflows is incremented for the server side. My test patch is as
> follows:
> 
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -981,6 +981,12 @@ do_transfer()
>                 done
>         fi
>  
> +       ip netns exec ${listener_ns} ss -version
> +       echo "listener_ns ss"
> +       ip netns exec ${listener_ns} ss -inmHM
> +       echo "connector_ns ss"
> +       ip netns exec ${connector_ns} ss -inmHM
> +
>         wait $cpid
>         local retc=$?
>         wait $spid

Good idea to use 'ss'!

These info are also exported via:

  getsockopt(..., SOL_MPTCP, MPTCP_INFO, ...);

But easier to use 'ss' indeed!

> The output is:
> 
> -----

(...)

> -------
> 
> You can see that the subflows are updated for both sides.

Indeed, my bad. I thought there was an issue, probably I looked at the
wrong time (too early/late) or at the wrong fd. Then when reading the
code, I saw "pm.subflows" was only incremented for the "client" side in
"pm_netlink.c". But I missed "mptcp_pm_allow_new_subflow()" from "pm.c",
doing "++pm->subflows" :)

Thank you for having checked!

> This ss -version is a bit strange. If it is removed, the test will fail.

Maybe just a question of timing? Without it, 'ss' is launched too early:
before the creation of the additional subflows. I guess that kind of
check should be done in the middle of the connection, probably not easy
to do that for all tests not knowing in advance how many subflows will
be created, how long you can wait.

> Anyway, I think it's necessary to add a testcase for this mptcp_info
> fileds. WDYT?
Yes, good idea!

It could make sense to do that in diag.sh selftest but only one subflow
is created there, so not very useful.

Maybe good to modify do_getsockopt_mptcp_info() from mptcp_sockopt.c to
check more fields? Not so many fields are being checked so far.

Or chk_subflow_nr() from mptcp_join.sh to add an additional check where
MPTCP info would be read?

And maybe in userspace_pm.sh to add some coverage for the userspace PM
case, what you are fixing here in this v3 patch?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
