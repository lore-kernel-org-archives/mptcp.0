Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D82BA40
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 07:57:38 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id rk17so12210630ejb.1
        for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 00:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=w3RNAKrlkG669nLcStjtN6rZF5yQ29mjiPM/i6Syc7I=;
        b=RLFKmPt1zqX+SXWJzwgWUwaymvBXkfeO1F59ikQbjfhB6EJzfSx9zigBwTVCW0Unf9
         8O1ppUCAJPDmQTMMTNsvcDinNJL48wPD0boDWY8cVX+JExeM4gtVfbJv6bcJmJ/ToVzS
         giY0522Gm6U3RVx67mMrQQSibj8CI4GvWl+qPnwffyY+aj1kKSRuIF3/HIMGTpo2hWVg
         78wbaHfc2VTyMKAwGnola6RjclAtDTDWiz4pLn8jtitjUBCPh+fHQS4bIQOjzOG/hdz2
         CIzKtQPvcIE9+P/AcB1O6daNkoDKemZ+NZjRMi4cz1maIrXJBIvLossVuanV5TdhgEUN
         6KOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=w3RNAKrlkG669nLcStjtN6rZF5yQ29mjiPM/i6Syc7I=;
        b=LJTe8hDEDZACt3R9LoD91vN0mW5267f5TR8kpEbx2a4xzlly2A4RgyVlWDCiyHfolq
         VF5sVuaZwWgWvKQIRcnvWxc7rEP9imqyeOBTf77Y0UrvO76JSdixYvs3CvNB6NmcX9CN
         HdpOTCPIupTIeAEq5x74Za2CxIBooRtgX9wUSN/hxhNxattDlzNDfe0cU8cgSstpxXl4
         qO6OrdFF3w9ivke0JvP2mS7FstzgUjNgdQ3wIqXiFVo+FDhR0UeSRrVhRl0/sjnv0+Tr
         G3eWBFLkyguaYoankdhA6HGdkn2lXuLc/YD/j6gmqF3eTwxReCQp+tgTiKtUgTYXgl/t
         u82w==
X-Gm-Message-State: ACrzQf0UL+RQV7IWVzzCSzcH45ahxPpqYZZD3AbwKMeniLkW1S9dcbrj
	iZXvMNNJdpIygGIV52uBrbmIFw==
X-Google-Smtp-Source: AMsMyM7R0vOsQ6x5OrZWglSNFnnzWzU348lu3XxSqLI7OYbm4j6uhbB5RUr7wyJ+QXbTsJ2kGIjSLw==
X-Received: by 2002:a17:907:749:b0:782:3e85:97c4 with SMTP id xc9-20020a170907074900b007823e8597c4mr26485473ejb.446.1664351857040;
        Wed, 28 Sep 2022 00:57:37 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6518:6c3b:2826:5305? ([2a02:578:8593:1200:6518:6c3b:2826:5305])
        by smtp.gmail.com with ESMTPSA id d17-20020a50f691000000b0044e6802623dsm2868654edn.18.2022.09.28.00.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 00:57:36 -0700 (PDT)
Message-ID: <ec408186-402e-4278-4e2b-ac3780851dbe@tessares.net>
Date: Wed, 28 Sep 2022 09:57:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH mptcp-next 1/2] mptcp: sockopt: make
 'tcp_fastopen_connect' generic
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <20220927150306.1552795-1-matthieu.baerts@tessares.net>
 <20220927150306.1552795-2-matthieu.baerts@tessares.net>
 <f348f260d1c2c988fd96e5079b18e9468ff8cb3b.camel@redhat.com>
 <1eb00480-b89d-914e-bbd9-11c185448ef0@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <1eb00480-b89d-914e-bbd9-11c185448ef0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat, Paolo,

Thank you both for the reviews!

On 27/09/2022 21:59, Mat Martineau wrote:
> On Tue, 27 Sep 2022, Paolo Abeni wrote:
> 
>> On Tue, 2022-09-27 at 17:03 +0200, Matthieu Baerts wrote:
>>> There are other socket options that need to act only on the first
>>> subflow, e.g. all TCP_FASTOPEN* socket options.
>>>
>>> This is similar to the getsockopt version.
>>>
>>> In the next commit, this new mptcp_setsockopt_first_sf_only() helper is
>>> used by other another option.
>>>
>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>> ---
>>>  net/mptcp/sockopt.c | 11 ++++++-----
>>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>>> index c7cb68c725b2..8d3b09d75c3a 100644
>>> --- a/net/mptcp/sockopt.c
>>> +++ b/net/mptcp/sockopt.c
>>> @@ -769,17 +769,17 @@ static int
>>> mptcp_setsockopt_sol_tcp_defer(struct mptcp_sock *msk, sockptr_t optv
>>>      return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT,
>>> optval, optlen);
>>>  }
>>>
>>> -static int mptcp_setsockopt_sol_tcp_fastopen_connect(struct
>>> mptcp_sock *msk, sockptr_t optval,
>>> -                             unsigned int optlen)
>>> +static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk,
>>> int level, int optname,
>>> +                      sockptr_t optval, unsigned int optlen)
>>>  {
>>>      struct socket *sock;
>>>
>>> -    /* Limit to first subflow */
>>> +    /* Limit to first subflow, before the connection establishment */
>>>      sock = __mptcp_nmpc_socket(msk);
>>>      if (!sock)
>>>          return -EINVAL;
>>
>> Crazy idea: if we add another int argument e.g. 'default_reval', we can
>> use this helper even for mptcp_setsockopt_sol_tcp_defer()
>> (default_retval == 0, while here default_reval == -EINVAL) ;)
>>
>> Not a big deal, I'm fine even this way.
> 
> Or do something similar without adding the extra int argument: just have
> the call site for TCP_DEFER_ACCEPT in mptcp_setsockopt_sol_tcp() ignore
> the return value of mptcp_setsockopt_first_sf_only(), and remove
> mptcp_setsockopt_sol_tcp_defer()?
> 
> That would be a third patch to use the new helper, so if you (Matthieu)
> want to make that change I think these two patches are good as-is:

I thought about supporting the tcp_defer case but I didn't think about
just ignoring the error, good idea!

I can apply the two patches and send an extra one

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
