Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF7E1E8342
	for <mptcp@lists.linux.dev>; Sun, 19 Apr 2026 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776592329; cv=none; b=CpD12qqDBOUCxZIWclPNU2y+WZcHMXtQfmHbGkOo9pmjjP64UD0dHv5Qusx4uRyvqr9O8fKgL4/tYR7p6goLEAg3CyuC5nhrLdq/kxR8gq2NEYe8upUYxtSldAs4EzEaMtP48M2Zx29vNolDlSicNTpio/QfRHJy3Red9d7JErk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776592329; c=relaxed/simple;
	bh=x5IouHTJtW3DfdyihFAOCdEe97drV7RtXJLrh8Dbmq8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fvAm4wXODQZtBSuqNZLuk418exSesaFTi0Dl5lnT+CKCmtAGtrkSvIAeNh4sgNePcRMoiGZxigY3DRNZSUgw7PjnE603pBNh92IezOk50XQqb6OLiLVT2pBnCSYy3cnKrBeb10qF2joXP94z9nDS3BMwx28W9mK/DAWLd6zdmlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCWegSoh; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCWegSoh"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2d832f2f44cso2310400eec.0
        for <mptcp@lists.linux.dev>; Sun, 19 Apr 2026 02:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776592328; x=1777197128; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNbDpXxBmda7i9Siqc5i89PbvpK5U76PasTjM+CK90c=;
        b=JCWegSohvs8+X83DIZlz8+TgqjJWsHY68g0FGUOkJ5Mr326BsHiqs8lQUiO/219nRM
         S3c8Q7XQHMZCXA6lSe58yfWK1pPJrQg7y4TxGM89aDqJ4QxlJ/kpIbwh1+RATB1dMTIL
         UzLSxlsb1VU5epRDcwjq1XX9tuyTCnu9oiwBkiRTCxnN0aTk0tEL94raIHgtztBhyt8x
         RVPAOUmS54HqVep4/+R1gu3hbqG6FrcZ/Ho4GMBezB87PEiZGISE90vFgg1crQP2b3M9
         K0SMEBrsXue1rWg7Iv/VOoezLe46jsjHI9Uz2/L8RwmcgVm8e6kaBzGcQpoWOJTHfsl2
         BuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776592328; x=1777197128;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNbDpXxBmda7i9Siqc5i89PbvpK5U76PasTjM+CK90c=;
        b=rrY/KSKPiLjFVYspFTP9dvFnSQhDtgjweeEUFMewtoid/9mGgjpkY/6DK4N8YnHEJd
         hE/z8bPVhVZfgCsHxWAoRF4frgpOjsG4+4XQAHdgBhKzg5QWWKbwj9PlkoFA7IhTKGBA
         PyDC9C/Zu6xOkkJhtK8AR09WGL3vq664GsqVXRE8KqVbwTOumhC2NOSkBLARMXMSjh8J
         veS9AwF0xFXW5rCdDsTSN6Y73Ec6uzSKe5UaZkLS8hvgoC9lpbwAZFom0YIZJvRFF+qU
         N/EQ1aJzGMBFy0XEsJvAfsP6CHp78igsfU3opK5GMZxk2sGMTQUOPHj8Erq4Tv3cfd28
         k/3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9riQUEoII274BfKFP7CBcXo9rpy+Upz3/WS9qCXruB0D6IfjsruJn39Wp/pInMR8bP09aaVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxztDW+qsjP6hFQeeTV20C8z2mo8L/I5tjykyaOlXjfeFgNwzhw
	D3lwoTTmQXRgHyYqTjMoYisKubT75711Z+P7+j1EQ9jks5G+zDBEvHQr
X-Gm-Gg: AeBDieuZbmRKRbb1FRpoMDuM3pTtfdQhivlitMy9rR+UARliGnIbA0zK6seRguElBNs
	Ol3PHQpRkK9VDLqFzaIddzkLUoCXwyROLdfe20zkkDtJiQOWBF/yuTC7vcLq1mjCFzBZpoaJAYa
	1qDwGtjv2QaZlf0kC3GUp6/1q2ayN+SpVmA0ayG22vhNSvdmwbKNXUeq5lBwmI5nje9kJn3r7n9
	jka7SkzqCAmNKUYeTl5yV2fp9Utg6ldyAYye2a1LeSVkveV+CfIvk6MZ2715pGVFcVVQcfABHhV
	Z+F71AKZ3DtFraUN8/B8pibcz9kFG00ejansjZCfWiZPJE2HOgK3jbSgBcjNgJRlt45f2nuH9D4
	riZVTskfwjpB1hj8AQ3lWUHKgt7KN0NzE3rykZFBmndx5nAR7Uru88xMRlhGweeH3pk21WGPz/D
	7LP6WZGiJG80BWcbQyXgZhnAvFMb/Pd1g1B9IWQew/y7SE/ZQ=
X-Received: by 2002:a05:7022:12b:b0:128:d2f2:5cf8 with SMTP id a92af1059eb24-12c73fa8d16mr4469503c88.34.1776592327435;
        Sun, 19 Apr 2026 02:52:07 -0700 (PDT)
Received: from [10.0.0.2] ([169.235.25.186])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c749c422csm9967262c88.3.2026.04.19.02.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 02:52:07 -0700 (PDT)
Message-ID: <05a19f8d-360e-41d1-bc8a-0b4caab3d354@gmail.com>
Date: Sun, 19 Apr 2026 02:51:50 -0700
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: yuantan098@gmail.com, Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com,
 dsahern@kernel.org, martineau@kernel.org, geliang@kernel.org,
 daniel@iogearbox.net, kafai@fb.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, caoruide123@gmail.com,
 enjou1224z@gmail.com
Subject: Re: [PATCH net 1/1] mptcp: hold subflow request owners when cloning
 reqsk
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Matthieu Baerts <matttbe@kernel.org>
References: <cover.1776149210.git.caoruide123@gmail.com>
 <86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123@gmail.com>
 <5f06a4e8-0b49-4119-94f9-3a8a1e430e0d@kernel.org>
 <CAAVpQUDzh-dGsQpBCZjN3rUsoDc2QjzWh-o5yVWoBWDQNXbjmQ@mail.gmail.com>
From: Yuan Tan <yuantan098@gmail.com>
In-Reply-To: <CAAVpQUDzh-dGsQpBCZjN3rUsoDc2QjzWh-o5yVWoBWDQNXbjmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/16/2026 11:48 AM, Kuniyuki Iwashima wrote:
> On Thu, Apr 16, 2026 at 10:45 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>> Hi Ren,
>>
>> On 15/04/2026 11:31, Ren Wei wrote:
>>> From: Ruide Cao <caoruide123@gmail.com>
>>>
>>> TCP request migration clones pending request sockets with
>>> inet_reqsk_clone(). For MPTCP MP_JOIN requests this raw-copies
>>> subflow_req->msk, but the cloned request does not take a new reference.
>>>
>>> Both the original and the cloned request can later drop the same msk in
>>> subflow_req_destructor(), and a migrated request may keep a dangling msk
>>> pointer after the original owner has already been released.
>>>
>>> Add a request_sock clone callback and let MPTCP grab a reference for cloned
>>> subflow requests that carry an msk. This keeps ownership balanced across
>>> both successful migrations and failed clone/insert paths without changing
>>> other protocols.
>> Thank you for this patch!
>>
>> Indeed, it looks like this path has not been covered by the MPTCP test
>> suite so far.
>>
>> By chance, do you have any simpler reproducer using packetdrill? (the
>> MPTCP fork)
>>
>>   https://github.com/multipath-tcp/packetdrill
>>
>> Also, I see Sashiko is pointing to a potential issue with MP_CAPABLE and
>> the token, also only visible with net.ipv4.tcp_migrate_req=1:
>>
>> https://sashiko.dev/#/patchset/86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123%40gmail.com
>>
>> Are you also looking at that?
>>
>>> Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
>>> Cc: stable@kernel.org
>>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>>> Signed-off-by: Ruide Cao <caoruide123@gmail.com>
>>> Tested-by: Ren Wei <enjou1224z@gmail.com>
>>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>>> ---
>>>  include/net/request_sock.h      |  2 ++
>>>  net/ipv4/inet_connection_sock.c |  3 +++
>>>  net/mptcp/subflow.c             | 13 +++++++++++++
>>>  3 files changed, 18 insertions(+)
>>>
>>> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
>>> index 5a9c826a7092..560e464c400f 100644
>>> --- a/include/net/request_sock.h
>>> +++ b/include/net/request_sock.h
>>> @@ -36,6 +36,8 @@ struct request_sock_ops {
>>>                                     struct sk_buff *skb,
>>>                                     enum sk_rst_reason reason);
>>>       void            (*destructor)(struct request_sock *req);
>>> +     void            (*init_clone)(const struct request_sock *req,
>>> +                                   struct request_sock *new_req);
>> @TCP/INET maintainers: are you OK with this new function pointer?
>>
>> Currently, MPTCP is the only user, and "req" is not used, see below.
>>
>>>  };
>>>
>>>  struct saved_syn {
>>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
>>> index e961936b6be7..140a9e96ad58 100644
>>> --- a/net/ipv4/inet_connection_sock.c
>>> +++ b/net/ipv4/inet_connection_sock.c
>>> @@ -954,6 +954,9 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
>>>       if (sk->sk_protocol == IPPROTO_TCP && tcp_rsk(nreq)->tfo_listener)
>>>               rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
>> (Maybe TCP with fastopen could be this other user to call
>> rcu_assign_pointer()? (net-next material))
>>
>>> +     if (req->rsk_ops->init_clone)
>>> +             req->rsk_ops->init_clone(req, nreq);
> I think a simple direct call is better.
>
> #ifdef CONFIG_MPTCP
>     if (tcp_rsk(req)->is_mptcp)
>         mptcp_reqsk_clone(nreq);
> #endif
>
 Thank you very much for your suggestion. We will use this approach in
the next version of the patch. Would you like us to add your
Suggested-by tag?


>>> +
>>>       return nreq;
>>>  }
>>>
>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>> index 4ff5863aa9fd..5f4069647822 100644
>>> --- a/net/mptcp/subflow.c
>>> +++ b/net/mptcp/subflow.c
>>> @@ -47,6 +47,17 @@ static void subflow_req_destructor(struct request_sock *req)
>>>       mptcp_token_destroy_request(req);
>>>  }
>>>
>>> +static void subflow_req_clone(const struct request_sock *req,
>>> +                           struct request_sock *new_req)
>>> +{
>>> +     struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(new_req);
>>> +
>>> +     (void)req;
>>
>> Note: if 'req' is not used, and MPTCP is currently the only user of this
>> new init_clone() callback, perhaps enough to pass only 'new_req' for the
>> moment? 'req' can be added later if other users need it, no?
>>
>> With only init_close(nreq) in a v2, or if TCP maintainers prefer to keep
>> it, feel free to add:
>>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>
>>
>> Cheers,
>> Matt
>> --
>> Sponsored by the NGI0 Core fund.
>>
