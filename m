Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3F5168
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 10:02:01 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id n30so47590942eda.13
        for <mptcp@lists.linux.dev>; Wed, 05 Jan 2022 02:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HvVqJ5Wa3XcRYt6aah3gsAIOiSmtUShJLrbo4hPmX54=;
        b=4j4hi3QDhmGXoAJcl9yQnlte36WRWddJzfybk269V0011cgjSfw8iDA9wLyXjntsPJ
         1KJWw33sBPSaHW6YcPo2EkF7MLDbtf0gQT8afyTDhWAbusWmUf+JcvZ2G3qrk+ex+ic6
         navP47+lktxyAgIZgcORv77jkBdysufq5peOSnW8tfUv4UhxA0aKQknhN9bhuwXo2Uvl
         8nLurH82jgHiLsFyZ974dJm8QHpdpltDRyQ3kfjuOyCOeNf8fseft2WSWPsOLiOd+F9v
         4Zw4DqYGNHAD7+hY5kWga1KxrWGGK2axZTZfcNLac5Ijzb4vv+jZXqIGRhG7ri3hw0c/
         Gxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HvVqJ5Wa3XcRYt6aah3gsAIOiSmtUShJLrbo4hPmX54=;
        b=DoKhqMoScVKfDCJUHPYsn7BB7tgme0w8Io5/4hbHGh7tswMd9JEoQkBS4Th2+Uhba8
         sv23/IUUMH9dtLn9XEytn8AiMTiI0RuEk8pqY6oPwCCHULstfaH607YrojB/yTcgmFsP
         z8KWU8hQNGo4oIqFCMguh8ulUZiEy1llHJwM3qM3VweNniWzUomCwVcFhhdXVTY0Rq+j
         eKPpD4dNZdFhspdbpZTlPY1UKFUjzD0puFoFrfz7ZY6khXgsQC+KAmKTIjBVopVFZMQF
         icMG+go+kuyohFDhRoCNwxZv7JFBDYx5wAxReX+ihazIyLWG4tZuyufPVIzLZRWKkP4Q
         DRxQ==
X-Gm-Message-State: AOAM5310ya5O+s6mgb/5x6/3P7N5GZV4rg6gx6bVxbbq8ZloBSpQCWzP
	Xio5WW6ex0v5kqzSQ8fMdjTXXo8wx+ELZoIBSFg=
X-Google-Smtp-Source: ABdhPJx1/MrOD1krcBX3bigeN+zw99DPVhS7EnnPel2wMW0GmyLeJPnM7ENYoGvci7sqGPnZIdWzeQ==
X-Received: by 2002:a05:6402:348b:: with SMTP id v11mr48322219edc.309.1641376920183;
        Wed, 05 Jan 2022 02:02:00 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:598b:ca7f:8757:e7e1? ([2a02:578:8593:1200:598b:ca7f:8757:e7e1])
        by smtp.gmail.com with ESMTPSA id c8sm15487678edu.60.2022.01.05.02.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 02:01:59 -0800 (PST)
Message-ID: <9dcec4f1-26ea-ade8-7547-93fef53922b0@tessares.net>
Date: Wed, 5 Jan 2022 11:01:59 +0100
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
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220105085043.GA3255@dhcp-10-157-36-190>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 05/01/2022 09:50, Geliang Tang wrote:
> On Thu, Dec 30, 2021 at 08:16:48PM +0100, Matthieu Baerts wrote:
>> From: Geliang Tang <geliang.tang@suse.com>
>>
>> MP_FAIL could be sent with RST or DSS, and FASTCLOSE can be sent with
>> RST too. So we should use a similar xmit logic for FASTCLOSE and
>> MP_FAIL in both mptcp_write_options() and mptcp_established_options*().
>>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>> ---
>>  net/mptcp/options.c | 66 ++++++++++++++++++++++++++++-----------------
>>  1 file changed, 41 insertions(+), 25 deletions(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index c6726e8389ec..9d2c1c9edbe6 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -829,8 +829,12 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>>  
>>  	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
>>  		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
>> -		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
>> -		    mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
>> +		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
>> +			*size += opt_size;
>> +			remaining -= opt_size;
>> +		}
>> +		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
>> +		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
>>  			*size += opt_size;
>>  			remaining -= opt_size;
>>  		}
>> @@ -1257,21 +1261,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
>>  void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>>  			 struct mptcp_out_options *opts)
>>  {
>> -	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
>> -		const struct sock *ssk = (const struct sock *)tp;
>> -		struct mptcp_subflow_context *subflow;
>> -
>> -		subflow = mptcp_subflow_ctx(ssk);
>> -		subflow->send_mp_fail = 0;
>> -
>> -		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
>> -				      TCPOLEN_MPTCP_FAIL,
>> -				      0, 0);
>> -		put_unaligned_be64(opts->fail_seq, ptr);
>> -		ptr += 2;
>> -	}
> 
> Hi Matt,
> 
> Sorry, this patch doesn't work on my test. We write both DSS + MP_FAIL,
> but MP_FAIL is lost on the received side. Only DSS is received.
> 
> If we write MP_FAIL + DSS like the orignal code, MP_FAIL and DSS will be
> received correctly.
> 
> I haven't figured out why yet.
> 
> Could we just keep this MP_FAIL writting code still at the beginning of
> the function just like the orignal code did?

Thank you for having tested and reviewed the series!

Is this issue here fixed by your patch you sent a couple of minutes ago
(mptcp: fix a DSS option writting error)

That would make sense as the only thing I did was to send the MP_FAIL
after the DSS option.

Do you mind if I send a v8 series with your new fix the missing 'ptr +=
2;' below and have the code moving the writing of the MP_FAIL option
later in a dedicated commit?

> 
>> -
>> -	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
>> +	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and FAIL are mutually exclusive,
>>  	 * see mptcp_established_options*()
>>  	 */
>>  	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
>> @@ -1328,6 +1318,10 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>>  						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
>>  			}
>>  		}
>> +
>> +		/* We might need to add MP_FAIL options in rare cases */
>> +		if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions))
>> +			goto mp_fail;
>>  	} else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
>>  		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
>>  
>> @@ -1460,19 +1454,41 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>>  				ptr += 1;
>>  			}
>>  		}
>> -	} else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
>> -		/* RST is mutually exclusive with everything else */
>> -		*ptr++ = mptcp_option(MPTCPOPT_RST,
>> -				      TCPOLEN_MPTCP_RST,
>> -				      opts->reset_transient,
>> -				      opts->reset_reason);
>> -		return;
>>  	} else if (unlikely(OPTION_MPTCP_FASTCLOSE & opts->suboptions)) {
>> -		/* FASTCLOSE is mutually exclusive with everything else */
>> +		/* FASTCLOSE is mutually exclusive with others except RST */
>>  		*ptr++ = mptcp_option(MPTCPOPT_MP_FASTCLOSE,
>>  				      TCPOLEN_MPTCP_FASTCLOSE,
>>  				      0, 0);
>>  		put_unaligned_be64(opts->rcvr_key, ptr);
> 
> Here, 'ptr += 2;' is needed.

Good catch!

Note related to my modification but to "mptcp: implement fastclose xmit
path" so it should be in this squash-to patch!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
