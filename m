Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0812C9C
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 11:03:48 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id y22so160449328edq.2
        for <mptcp@lists.linux.dev>; Wed, 05 Jan 2022 03:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XN0+lw9Y6g0eHczpL2pT2c58oJDfml4xv7mRNS8biG8=;
        b=MJOWKv8NOWJNUgN1eh3I8zGayQeus94j3Fi9p3t7K5Ew3K6Mz9PGlJ2hCATSt9a/AO
         IggvKAJ3OGyDLVOOMrB6JDIiF3+4q1xSB1srCN767XF6y4xnkFOaH7C7blpa7LnmnZVE
         7OTvS4UJgTPGwJQ5eSS8751WScLlNnX5UnFaDmiPXojPxb1+5gh1s9UbUq7Jn/lXpeyP
         PdN3bbkwB2+N7CwK/vlUhbPY8uN+saoTeTE7/x5e8Hd5whuTjTDY15fdlq4oOeLD4+Bv
         vS+6nMlLWXPrt8V0gIu+qqIvh69p2LKxmzP2I+TEJ11FOv77DcmQ3u3YC7VTpel6dQnC
         iiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XN0+lw9Y6g0eHczpL2pT2c58oJDfml4xv7mRNS8biG8=;
        b=XlhD1a4kiQTETZEBdxxg7iszZg3DejA4eEj81h9cN6JLLe48eDvEWHFFFQkTZFUxH0
         QokX7K48ZkDcLtlQLNf2UvIyFwGsIp5jtCYIqSkPF3A+KxwXbzGnCZZt9EQ/9Spb2YSc
         AhY/+/0U1wCbg02Sne1htr6Es3M6qPV3sse8fye/4Klmm+P9eqSbBiUF76xeG6lYVMKV
         omFfpO9JonviKIstbIjAz9Me8aNJS5ErTTMZTzVBP+XaqQudfVW2HJ9uo7AvdD0V+A/T
         MpBVpz43geroWBMMi0fWAkGFyFluub4wc4s8RnfViCedHSXWtyYiJXHVncNLXeg1JWjz
         dB2w==
X-Gm-Message-State: AOAM531MesTtE5wsDau+Gg8bpaIcvIDA/df4QJo2MvoaK5C8BlgS63Au
	Mb/GPT1GNPWsbk3FG7MbFqJJ0oD4GVHtTcZdvn8=
X-Google-Smtp-Source: ABdhPJzY9+1vcTA4NrXyRIbw+Mns2VDy0Hq2C7aP2y0BJHQvs6lMihCtf1wf7dwnGCtg51TPREojsA==
X-Received: by 2002:a17:907:1701:: with SMTP id le1mr927813ejc.608.1641380627165;
        Wed, 05 Jan 2022 03:03:47 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:598b:ca7f:8757:e7e1? ([2a02:578:8593:1200:598b:ca7f:8757:e7e1])
        by smtp.gmail.com with ESMTPSA id j21sm12074547ejj.133.2022.01.05.03.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 03:03:46 -0800 (PST)
Message-ID: <20daee9c-26ff-56ce-2501-23e66f2236db@tessares.net>
Date: Wed, 5 Jan 2022 12:03:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-next v7 1/4] Squash to "mptcp: implement fastclose
 xmit path"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <20211230191651.1831507-1-matthieu.baerts@tessares.net>
 <20211230191651.1831507-2-matthieu.baerts@tessares.net>
 <20220105085043.GA3255@dhcp-10-157-36-190>
 <9dcec4f1-26ea-ade8-7547-93fef53922b0@tessares.net>
 <20220105105540.GA9181@dhcp-10-157-36-190>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220105105540.GA9181@dhcp-10-157-36-190>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 05/01/2022 11:55, Geliang Tang wrote:
> On Wed, Jan 05, 2022 at 11:01:59AM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 05/01/2022 09:50, Geliang Tang wrote:
>>> On Thu, Dec 30, 2021 at 08:16:48PM +0100, Matthieu Baerts wrote:
>>>> From: Geliang Tang <geliang.tang@suse.com>
>>>>
>>>> MP_FAIL could be sent with RST or DSS, and FASTCLOSE can be sent with
>>>> RST too. So we should use a similar xmit logic for FASTCLOSE and
>>>> MP_FAIL in both mptcp_write_options() and mptcp_established_options*().
>>>>
>>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>>> Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>>> ---
>>>>  net/mptcp/options.c | 66 ++++++++++++++++++++++++++++-----------------
>>>>  1 file changed, 41 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>>> index c6726e8389ec..9d2c1c9edbe6 100644
>>>> --- a/net/mptcp/options.c
>>>> +++ b/net/mptcp/options.c
>>>> @@ -829,8 +829,12 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>>>>  
>>>>  	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
>>>>  		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
>>>> -		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
>>>> -		    mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
>>>> +		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
>>>> +			*size += opt_size;
>>>> +			remaining -= opt_size;
>>>> +		}
>>>> +		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
>>>> +		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
>>>>  			*size += opt_size;
>>>>  			remaining -= opt_size;
>>>>  		}
>>>> @@ -1257,21 +1261,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
>>>>  void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>>>>  			 struct mptcp_out_options *opts)
>>>>  {
>>>> -	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
>>>> -		const struct sock *ssk = (const struct sock *)tp;
>>>> -		struct mptcp_subflow_context *subflow;
>>>> -
>>>> -		subflow = mptcp_subflow_ctx(ssk);
>>>> -		subflow->send_mp_fail = 0;
>>>> -
>>>> -		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
>>>> -				      TCPOLEN_MPTCP_FAIL,
>>>> -				      0, 0);
>>>> -		put_unaligned_be64(opts->fail_seq, ptr);
>>>> -		ptr += 2;
>>>> -	}
>>>
>>> Hi Matt,
>>>
>>> Sorry, this patch doesn't work on my test. We write both DSS + MP_FAIL,
>>> but MP_FAIL is lost on the received side. Only DSS is received.
>>>
>>> If we write MP_FAIL + DSS like the orignal code, MP_FAIL and DSS will be
>>> received correctly.
>>>
>>> I haven't figured out why yet.
>>>
>>> Could we just keep this MP_FAIL writting code still at the beginning of
>>> the function just like the orignal code did?
>>
>> Thank you for having tested and reviewed the series!
>>
>> Is this issue here fixed by your patch you sent a couple of minutes ago
>> (mptcp: fix a DSS option writting error)
>>
>> That would make sense as the only thing I did was to send the MP_FAIL
>> after the DSS option.
>>
>> Do you mind if I send a v8 series with your new fix the missing 'ptr +=
>> 2;' below and have the code moving the writing of the MP_FAIL option
>> later in a dedicated commit?
> 
> Hi Matt,
> 
> I think about it again. How about just using the v2 of this patch
> (https://patchwork.kernel.org/project/mptcp/patch/5a8c6024481d6106c662c3e892ae5e499b4a7f76.1638156809.git.geliang.tang@suse.com/)
> as a squash-to patch (We have reached an agreement on this part), and move
> all the other code in this v7 as a new patch (It still needs to be
> improved)?

Yes, I was thinking about something similar except that we also need to
modify mptcp_write_options() to allow sending a RST and a FC together.

I just made the split and for this afternoon, I'm hoping to launch the
new tests you added and try to understand the issue. But if you prefer I
already sent the v8 I have, I can.

Thank you for the instructions from your previous email!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
