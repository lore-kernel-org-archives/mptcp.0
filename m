Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1B2C80
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 17:42:34 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id q25so48036357edb.2
        for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 09:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vly6AibrbgPTMdAzZJ8MIGQjBdGPAKf3iZ7QD4IlYyg=;
        b=k01KGTMtTURYttD/IaSzmUglEYi1L5U83qIgeoXFtCxoAaCyu028NuHiIbrq3Ek0r4
         t19zvQjZfaTTvWkh0ztbOVlHkz9ktjv1k8W1Ggimi86TssM0h1wKheWQ7SnISgst6iKW
         73tNPCMeu8SomkYW48MdFwoY7VGu4fWTR6umb8VObX9vWyCohCRFeuUtuf7ZfFcZC8bD
         JepVk+2nCUcdnbAviPSrFtxqopo7gYRJ2iDr0k4nH7EnI/cHFBc4iq7VBh9fV+7qeCNg
         7GWnUPAvnA/h6cv0bikXW9SJyEorUMmDf/7mbmxT5lr8rB7wXsEvQC4Drxv2j8D/gN6d
         dF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vly6AibrbgPTMdAzZJ8MIGQjBdGPAKf3iZ7QD4IlYyg=;
        b=DQnWcbmFB7YVYJP5KPma9VtiUfrb2qJcKesWmp2sH9CTXmEL7eQ7te+n38huE1sqz+
         fghQI9cwrmN3ce1I5RHODnY25kfumLQdWFZqn7OoD6OzPY+VXO+Sv66qJ0K7EeIGacIQ
         MtVu2GTLHjQjLOpaA3ZHWPvZ4ID9dSCDCND7okYU0LagVwyS2OVaVG3Q6tKYfxKVzcaE
         qYbFq1Ef5CfmMZa+xR4Ps5K40N3UsI2NwpViw6RjeWXR1cIgtF3d2Y14/6vXEoyttpqw
         bPQMOTDtXsi4Kwpv0nnKlJ35YZqJBJVQRYM4WZNVYqxpJY+BwtDL5+ESdm2VeMs3L1lI
         A6xg==
X-Gm-Message-State: AOAM531ftiTUniCVYps7rk4us29uiGtjKxPA8xq4mPIWORHdlGCTJvv1
	PEDu6615tnKs+algEM4X65nEwg==
X-Google-Smtp-Source: ABdhPJxb79k9+9kOZrYL1r8BIBnFQzPzUR5zpuGSepgBhTiAAIF+yzbaHIGDuozDS2Vl6B2WkW7KhA==
X-Received: by 2002:a17:907:7f9e:: with SMTP id qk30mr685680ejc.124.1641836552267;
        Mon, 10 Jan 2022 09:42:32 -0800 (PST)
Received: from [10.120.18.111] ([84.17.46.9])
        by smtp.gmail.com with ESMTPSA id o22sm3924505edw.50.2022.01.10.09.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 09:42:32 -0800 (PST)
Message-ID: <051abada-0cbb-a8dc-eef7-a733bd3621d2@tessares.net>
Date: Mon, 10 Jan 2022 18:42:30 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-next v8 4/8] mptcp: reduce branching when writing
 MP_FAIL option
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
References: <20220105155702.165123-1-matthieu.baerts@tessares.net>
 <20220105155702.165123-5-matthieu.baerts@tessares.net>
 <ebff9b40-1e42-ec9-1cc5-6fbb8b5784dd@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ebff9b40-1e42-ec9-1cc5-6fbb8b5784dd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

Thank you for the review!

On 08/01/2022 01:54, Mat Martineau wrote:
> On Wed, 5 Jan 2022, Matthieu Baerts wrote:
> 
>> MP_FAIL should be use in very rare cases, either when the TCP RST flag
>> is set -- with or without an MP_RST -- or with a DSS, see
>> mptcp_established_options().
>>
>> Here, we do the same in mptcp_write_options().
>>
>> Co-developed-by: Geliang Tang <geliang.tang@suse.com>
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>> net/mptcp/options.c | 39 ++++++++++++++++++++++++---------------
>> 1 file changed, 24 insertions(+), 15 deletions(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index bbf61dedb4b5..2f94069808a4 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -1264,21 +1264,7 @@ static u16 mptcp_make_csum(const struct
>> mptcp_ext *mpext)
>> void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>>              struct mptcp_out_options *opts)
>> {
>> -    if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
>> -        const struct sock *ssk = (const struct sock *)tp;
>> -        struct mptcp_subflow_context *subflow;
>> -
>> -        subflow = mptcp_subflow_ctx(ssk);
>> -        subflow->send_mp_fail = 0;
>> -
>> -        *ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
>> -                      TCPOLEN_MPTCP_FAIL,
>> -                      0, 0);
>> -        put_unaligned_be64(opts->fail_seq, ptr);
>> -        ptr += 2;
>> -    }
>> -
>> -    /* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually
>> exclusive,
>> +    /* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and FAIL are mutually
>> exclusive,
> 
> Seems like the comment was ok as-is? As you note in the commit message,
> DSS and FAIL can occur together.

Yes indeed, in some conditions.
I removed this comment after but it is true we should not modify it here.

I see Geliang fixed that in the v9, thanks.

> 
>>      * see mptcp_established_options*()
>>      */
>>     if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
>> @@ -1336,6 +1322,10 @@ void mptcp_write_options(__be32 *ptr, const
>> struct tcp_sock *tp,
>>             }
>>             ptr += 1;
>>         }
>> +
>> +        /* We might need to add MP_FAIL options in rare cases */
>> +        if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions))
>> +            goto mp_fail;
>>     } else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
>>         u8 len, flag = MPTCP_CAP_HMAC_SHA256;
>>
>> @@ -1476,6 +1466,25 @@ void mptcp_write_options(__be32 *ptr, const
>> struct tcp_sock *tp,
>>         put_unaligned_be64(opts->rcvr_key, ptr);
>>         ptr += 2;
>>
>> +        if (OPTION_MPTCP_RST & opts->suboptions)
>> +            goto mp_rst;
>> +        return;
>> +    } else if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions))
>> +mp_fail:
>> +    {
> 
> Formatting quibble: seems better to put the '{' at the end of the line
> before the mp_fail label, like the existing code does just before the
> mp_rst label just below this block of code.

I had to do that if I wanted to keep declaring the two "const" variables
just below, only in case of MP_FAIL.

The other solution is to always declare them at the beginning of the
function like Geliang did in the v9.

Cheers,
Matt

> 
>> +        /* MP_FAIL is mutually exclusive with others except RST */
>> +        const struct sock *ssk = (const struct sock *)tp;
>> +        struct mptcp_subflow_context *subflow;
>> +
>> +        subflow = mptcp_subflow_ctx(ssk);
>> +        subflow->send_mp_fail = 0;
>> +
>> +        *ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
>> +                      TCPOLEN_MPTCP_FAIL,
>> +                      0, 0);
>> +        put_unaligned_be64(opts->fail_seq, ptr);
>> +        ptr += 2;
>> +
>>         if (OPTION_MPTCP_RST & opts->suboptions)
>>             goto mp_rst;
>>         return;
>> -- 
>> 2.33.1
>>
>>
>>
> 
> -- 
> Mat Martineau
> Intel

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
