Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D51617757
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 15:32:49 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9768fd99c0cso646572966b.0
        for <mptcp@lists.linux.dev>; Fri, 09 Jun 2023 08:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686324767; x=1688916767;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qTACBSsjQn9IE2cvGFrqTLU4E4a54w3c9iXfRkWcrXo=;
        b=Q16ofLOMxAIYBkqMpY6NclN0oehuphacJCvKijJhrhq5+zu6Vq1GduIn/jCJNHQm2j
         0HQ71inZ39iBNzRqzDn1PUcHHKhVtJ3MLdxT7kHx5SGbW65pFUpnpCUvO3BcXu4fqVmi
         PVygpLwmxyD6Rr0OwjjAvB296yxVM9R5eUmWTKpgwsmoeqxkfG+daE7CWGYcjzwlycDr
         YuNRD6XtNpae9Vgi8mR3kCUy71VRe5FhokBMmkoNlhbaaCFwBR7IzKLoMV8diFj3WMvW
         FBuxFe/nKUnJDfNRlmEJwVuvOdfU/sINWwi8Xo2xdbPXzzjovBlj1JOXaUZcKSSLBqKE
         Gl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686324767; x=1688916767;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTACBSsjQn9IE2cvGFrqTLU4E4a54w3c9iXfRkWcrXo=;
        b=FHSbOXKPqO1+A6PQon/yahoRQJVXWx4OSapio7kwP+2T4QMap1TUR1rHhfMOB6Vzr+
         H/f2xkPdpjjS2v/i1ThOUMd/BZRplxgX6V69OO+hf19Vv663BEmsIBsgk+OUQmmWf9FU
         LhxVURaJ2H58ohYWWlv/szKpRdh+yiKCW/rycPRsHXkW+f5y81XhIW7e/kZ/Q3TKK2uP
         c3ge1k/dn5MyW7PdlrvIriyRZVqzfIVvUIbNS2oGZSZRkA8ae3JpiJbanNvZBZ7SxwHn
         wSVTPABZxHwW5js0y0DgpPv0Qy+1rJTBEVTjwBc+ajqbI5yPPXhkuM1T2UsI0Yenw6g6
         mF2w==
X-Gm-Message-State: AC+VfDynYillLi4LaiW5+/pJY3LADz1ZLM/auCUNNzzYdrSzKvrUlPxw
	lxlxmq/TLhMBXof0FXN2MWXAHg==
X-Google-Smtp-Source: ACHHUZ5X2Wjj8igKCC1AwjQNlAlV8WIQOR9+gg3Qt/985AoFDjPfhkzuXZwykUUjVcDInKbYx4Z55w==
X-Received: by 2002:a17:907:7f0b:b0:976:f2e:ad6a with SMTP id qf11-20020a1709077f0b00b009760f2ead6amr2569501ejc.28.1686324767551;
        Fri, 09 Jun 2023 08:32:47 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id kj24-20020a170907765800b0096f920858afsm1406395ejc.102.2023.06.09.08.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:32:47 -0700 (PDT)
Message-ID: <0097924b-3275-6b09-51ad-69e1bdce1199@tessares.net>
Date: Fri, 9 Jun 2023 17:32:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-net 2/2] mptcp: fix potential msk leak
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <f88902bdf5168d86a858575a95882e3fbbadf556.1686155270.git.pabeni@redhat.com>
 <d9dcf7a0fd779b3d24d7c10cb21b881d62b1fdc7.1686155270.git.pabeni@redhat.com>
 <a0a3cc11-8ea1-f9ca-ebd9-0bc3d7a3bae9@tessares.net>
 <bbb5825bc0b0d5fd9755de885ba28c900f78efac.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <bbb5825bc0b0d5fd9755de885ba28c900f78efac.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 09/06/2023 17:31, Paolo Abeni wrote:
> On Fri, 2023-06-09 at 16:52 +0200, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 07/06/2023 18:33, Paolo Abeni wrote:
>>> An orphaned msk releases the used resources via the worker,
>>> when the latter first see the msk in CLOSED status.
>>>
>>> If the msk status transitions to TCP_CLOSE in the release callback
>>> invoked by the worker's final release_sock(), such instance of the
>>> workqueue will not take any action.
>>>
>>> Additionally the MPTCP code prevents scheduling the worker once the
>>> socket reaches the CLOSE status: such msk resources will be leaked.
>>>
>>> The only code path that can trigger the above scenario is the
>>> __mptcp_check_send_data_fin() in fallback mode. Address the issue
>>> simply removing the dangerous state change: the msk will be closed
>>> soon by the worker itself, triggered by MPTCP_WORK_CLOSE_SUBFLOW.
>>>
>>> Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>>  net/mptcp/protocol.c | 10 ++++------
>>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 94229a318fc1..e93a678d057f 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -2936,16 +2936,14 @@ static void __mptcp_check_send_data_fin(struct sock *sk)
>>>  	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
>>>  
>>>  	/* fallback socket will not get data_fin/ack, can move to the next
>>> -	 * state now
>>> +	 * state now. But can't set TCP_CLOSE here, as this code path is
>>> +	 * reachable from the mptcp_release_cb(). Anyway the subflow will
>>> +	 * close soon and the msk state will follow via WORK_CLOSE_SUBFLOW.
>>>  	 */
>>>  	if (__mptcp_check_fallback(msk)) {
>>>  		WRITE_ONCE(msk->snd_una, msk->write_seq);
>>> -		if ((1 << sk->sk_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {
>>> -			inet_sk_state_store(sk, TCP_CLOSE);
>>> -			mptcp_close_wake_up(sk);
>>
>> Where are we going to wake up the userspace if we don't do it here for
>> fallback connections?
>>
>> Via subflow_state_change() which will set MPTCP_WORK_EOF flag?
> 
> Uhm... that could be problematic, as subflow->rx_eof could be already
> set and mptcp_subflow_eof() will not trigger. So this patch is not
> correct.
> 
> Additionally that eof notification looks rendundant. I need to think a
> bit more how to clean things up.

Thank you for having looked at that!

Do you want me to already applied the first patch?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
