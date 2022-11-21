Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC1EA6
	for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 10:14:38 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id s5so15487818edc.12
        for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 02:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6bixeaqU6zHnO7BNpA0d4mTlL3u3C+h4HCuInUMUUc=;
        b=sMMFmYfXyWU5p93sq5fqM5BcERkuxxhXLxNiY/vgy/hgCbTQcIu2AGVOLySje+P0Wf
         ZZUdoXjp+WQw/cOJgwYUzoUSUwH0F+PBJvmYWLKuMLIfgnOI6+wy/TG0sQcbmZQKsg1I
         jUgDpUQrgJLUtyx4l2U83kN3H4xIMkeg/fTIiBoksMLjU/oRKdQJCRNBcL6vmR2kXJGx
         +h4i8Wshjb92bsK3OGo/Cd0EV54I3sfgIBdhJA0DsSdRUtio1ufCUASmCmyNlJILNRCz
         nC37Yh8T2k+4sl0xthi74PrkWXFjGT92aWhCdJlrjHpWHYOssG5bjbDYoheONIQqAKsb
         6g+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6bixeaqU6zHnO7BNpA0d4mTlL3u3C+h4HCuInUMUUc=;
        b=pmNmnGvFKkXv+fQmXGSGEY7T5N2JqCELKOmnLoOs45jionlrwcLBPXxaJZrTmwuDzu
         L4FxH/mVT5PP3tLE7Gy6JZSqE13SaYgFOqxz/i9YyOLcU0foi73KUPjfi7M0aQQtGWwO
         KwAjxL++0o75S1Y6uk/qIKKUtMKC1U7iSWGdwje+JLXcxr3ZNbK1xEmJYD9jH1U/zvDC
         9/lfJ2slkWr6rpQsVZnQmuQvtVLdhSxFdfTy+LZGw49+2te2/BDkmGYtiaC6GZ40Y0/+
         ZrETszeD9nTKVlaXiwQ3PYXKDUx5VR8WmzygOALXgZVdwhiQk1wJnz1kSOtDdUX6XqkX
         8q+g==
X-Gm-Message-State: ANoB5pkPrhSkb5EBcJi8oTfiT4S0wq7CEIIMC8JMIc76qJJkWiHvBXxQ
	SDA/OVlg6Flm8gEYwNYfwDahoA==
X-Google-Smtp-Source: AA0mqf66G1fhegilgURNia9D3aj3yogHoqpLcLUhxNmMpBBH7h57t+3cXK4od/hjgZGVxhf+v1U2/g==
X-Received: by 2002:aa7:c84d:0:b0:468:354b:280d with SMTP id g13-20020aa7c84d000000b00468354b280dmr15879872edt.178.1669025676274;
        Mon, 21 Nov 2022 02:14:36 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id p5-20020a170906614500b0079800b81709sm4866289ejl.219.2022.11.21.02.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:14:35 -0800 (PST)
Message-ID: <fc92afa1-b26f-512f-3f7f-ed88c8871140@tessares.net>
Date: Mon, 21 Nov 2022 11:14:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-net v2] mptcp: don't orphan ssk in mptcp_close()
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, menglong8.dong@gmail.com,
 mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>,
 Biao Jiang <benbjiang@tencent.com>, Mengen Sun <mengensun@tencent.com>
References: <20221121034140.548112-1-imagedong@tencent.com>
 <11f993d24e509bd92e850415e6c96975c40a7460.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <11f993d24e509bd92e850415e6c96975c40a7460.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 21/11/2022 11:03, Paolo Abeni wrote:
> On Mon, 2022-11-21 at 11:41 +0800, menglong8.dong@gmail.com wrote:
>> From: Menglong Dong <imagedong@tencent.com>
>>
>> All of the subflows of a msk will be orphaned in mptcp_close(), which
>> means the subflows are in DEAD state. After then, DATA_FIN will be sent,
>> and the other side will response with a DATA_ACK for this DATA_FIN.
>>
>> However, if the other side still has pending data, the data that received
>> on these subflows will not be passed to the msk, as they are DEAD and
>> subflow_data_ready() will not be called in tcp_data_ready(). Therefore,
>> these data can't be acked, and they will be retransmitted again and again,
>> until timeout.
>>
>> Fix this by setting ssk->sk_socket and ssk->sk_wq to 'NULL', instead of
>> orphaning the subflows in __mptcp_close(), as Paolo suggested.
>>
>> Reviewed-by: Biao Jiang <benbjiang@tencent.com>
>> Reviewed-by: Mengen Sun <mengensun@tencent.com>
>> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> 
> Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
> Reviewed-by: Paolo Abeni <pabeni@redhat.com>
> 
> @Mat: could you please add even the fixes tag when applying this one?

Sure! (b4 will add it automatically)

> 
>> ---
>> v2:
>> - setting ssk->sk_socket and ssk->sk_wq to 'NULL' in __mptcp_close(),
>>   as Paolo suggested.
>> - remove the unnecessary 'SOCK_DEAD' check in mptcp_data_ready()
>> ---
>>  net/mptcp/protocol.c | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 3796d1bfef6b..a4fd971a7aa4 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2352,12 +2352,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>>  		goto out;
>>  	}
>>  
>> -	/* if we are invoked by the msk cleanup code, the subflow is
>> -	 * already orphaned
>> -	 */
>> -	if (ssk->sk_socket)
>> -		sock_orphan(ssk);
>> -
>> +	sock_orphan(ssk);
>>  	subflow->disposable = 1;
>>  
>>  	/* if ssk hit tcp_done(), tcp_cleanup_ulp() cleared the related ops
>> @@ -2940,7 +2935,11 @@ bool __mptcp_close(struct sock *sk, long timeout)
>>  		if (ssk == msk->first)
>>  			subflow->fail_tout = 0;
>>  
>> -		sock_orphan(ssk);
>> +		/* detach from the parent socket, but allow data_ready to
>> +		 * push incoming date into the mptcp stack, to properly ack it
> 
> Nit:                             ^^^^
> 
> should be 'data'
> 
> @Mat: could you please fix it while applying or do you prefer a v3 or a
> squash-to patch?

Yes, no need to send a v3 ;-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
