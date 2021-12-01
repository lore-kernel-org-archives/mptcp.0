Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459122C82
	for <mptcp@lists.linux.dev>; Wed,  1 Dec 2021 11:23:06 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id g14so100193167edb.8
        for <mptcp@lists.linux.dev>; Wed, 01 Dec 2021 03:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BSTLXcfZGsA8R7F7Gq3WJiMw6tdZXMQBaCG+JEhiXAQ=;
        b=5HQ3hPS2P672N5J7cW1qTo/1OQ5s/b6C5dwp4rtxmJnKgFfgdY3JVum2KDofw4goor
         ij9TywNR3qS3NJmn2diA7Ucvbm4LluBZZMgBmcFjtfP11LsAJ1XOHCLfOi2WFrIdSt8W
         zwlB7Twg+OcfcfUlWg5CBhfT2R1jlyIITz6sFUKk30ma3a0Add6MdvdBtyaMdJE1P3CG
         ctN5WavubbPPx63QJx+x/3RE03fp+YxQCyXt2mTyGEl6cetGqCY/fexTMEGPKD3zPLWg
         J8TcpghhAXki963cAUEIGbD5dfaJzACS5xEvrmNBUVAMzM1nH9cmevrHf1sS2ypCRZm/
         J/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BSTLXcfZGsA8R7F7Gq3WJiMw6tdZXMQBaCG+JEhiXAQ=;
        b=BLPbsoLK6jdrA9qyuqVru7ptlL7uqGauCdDAas9Rqvso0SNU81t9x7Dc50+UuX+zhz
         uqk3E0/Pc5ucdOzuAdCA6FofomYOF0U+0JEmcdP67lWybeEp0iFnLANLZzVqHlSdDosq
         rnqH+QgD2d4QRDPqIzCJP/dCErSMz3u0oQKZByO200SrbUyj7xj4Nt3NvYLQWjECa6/F
         KtvYTdzlI1gNBAt2FwjQmkCk9Ndhb2NGAgrUDuEvIvaTc/VzyO6lzm5YdWauvEsR9sla
         QnKfIkvypL1enVjRRFqsUmSYHmAY/n7/iqUuwoEqcevcUMz36Rdke9pnHZSvN7Y2kJ0E
         n7xg==
X-Gm-Message-State: AOAM530vr1zxBer32uN9JutFOfLMyczZ6Uk9bJBqJdbnNwJP0rrmoUoV
	bh958VrfA04nyQQu6ieKWyQh/g==
X-Google-Smtp-Source: ABdhPJyjYBDAZop6P2/5N9uRoNkjuTR4dBKJevvpkkkeTlJQR7P+9UEpiBsJcfUmKb+eWM3S3mMZJg==
X-Received: by 2002:a17:906:f894:: with SMTP id lg20mr6437122ejb.33.1638357783678;
        Wed, 01 Dec 2021 03:23:03 -0800 (PST)
Received: from [192.168.178.33] ([213.211.142.51])
        by smtp.gmail.com with ESMTPSA id gt18sm10751034ejc.88.2021.12.01.03.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 03:23:03 -0800 (PST)
Message-ID: <bc4304c9-12f3-3961-de6a-7549034eb932@tessares.net>
Date: Wed, 1 Dec 2021 12:23:02 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: implement fastclose xmit
 path"
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <e7427851-a812-05b7-6441-cb9e6f61e65c@tessares.net>
 <20211130165527.1506827-1-matthieu.baerts@tessares.net>
 <05864fd724521fcde2e7e40b95a825f5e21a3e2c.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <05864fd724521fcde2e7e40b95a825f5e21a3e2c.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Geliang,

On 01/12/2021 11:40, Paolo Abeni wrote:
> On Tue, 2021-11-30 at 17:55 +0100, Matthieu Baerts wrote:
>> This is linked to Geliang's patch with the same title.
>>
>> If I understand the RFC properly, we can use MP_RST with an MP_FASTCLOSE
>> and an MP_FAIL (or none of them) but we cannot use MP_FASTCLOSE and
>> MP_FAIL together.
>>
>> This patch implements this logic in both mptcp_established_options() and
>> mptcp_write_options(). Before this patch, the first function was not
>> allowing any of these 3 options to be used at the same time while the
>> second one was allowing MP_FAIL to be used with either MP_FASTCLOSE or
>> MP_RST.
>>
>> Small note: I tried to keep Paolo's idea of reducing conditions for
>> "normal" options by moving MP_RST at the end and allow to jump there
>> from MP_FAIL and MP_FASTCLOSE but I'm not sure it makes it easy to read
>> and really improves perfs. We can also move MP_RST check at the
>> beginning.
>>
>> @Geliang: feel free to re-use this patch if it looks OK to you.
>>
>> PS: I didn't try this patch, just quickly wrote it to better explain
>> what I had in mind.
>>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Geliang Tang <geliang.tang@suse.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>
>> Notes:
>>     to be squashed in "mptcp: implement fastclose xmit path"
>>
>>  net/mptcp/options.c | 62 +++++++++++++++++++++++++++------------------
>>  1 file changed, 37 insertions(+), 25 deletions(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 8a1020e4285c..07091971a51a 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -829,11 +829,17 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>>  
>>  	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
>>  		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
>> -		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
>> -		    mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
>> +		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
>>  			*size += opt_size;
>>  			remaining -= opt_size;
>>  		}
>> +
>> +		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
>> +		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
>> +			*size += opt_size;
>> +			remaining -= opt_size;
>> +		}
>> +
>>  		return true;
>>  	}
>>  
>> @@ -1257,21 +1263,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
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
>> -
>> -	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
>> +	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and FAIL are mutually exclusive,
>>  	 * see mptcp_established_options*()
>>  	 */
>>  	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
>> @@ -1458,19 +1450,39 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
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
>> +
>> +		if (OPTION_MPTCP_RST & opts->suboptions)
>> +			goto mp_rst;
>> +		return;
>> +	} else if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
>> +		/* MP_FAIL is mutually exclusive with others except RST */
>> +		const struct sock *ssk = (const struct sock *)tp;
>> +		struct mptcp_subflow_context *subflow;
>> +
>> +		subflow = mptcp_subflow_ctx(ssk);
>> +		subflow->send_mp_fail = 0;
>> +
>> +		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
>> +				      TCPOLEN_MPTCP_FAIL,
>> +				      0, 0);
>> +		put_unaligned_be64(opts->fail_seq, ptr);
>> +		ptr += 2;
>> +
>> +		if (OPTION_MPTCP_RST & opts->suboptions)
>> +			goto mp_rst;
>> +		return
> 
> As the CI spotted, missing ';' here.

Yes sorry, I quickly did it before having to go.

> Otherwise LGTM!

Thank you for the review!

@Geliang: do you prefer to use this diff -- without the missing ';' --
in a new version or do you prefer if I apply it with the fix directly?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
