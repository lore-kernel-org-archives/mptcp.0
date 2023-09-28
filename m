Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD6515BA
	for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 20:54:56 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9adca291f99so1724045366b.2
        for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 13:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695934495; x=1696539295; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=If3zzTuQox6klgPTiONCSaZmvw9nCpdZZO2UC0XFde0=;
        b=PyPTQbFsG8SezQHUNaPTmjtIrrAgt4VZlp3NI0+5iNuOaVVnvapIpBpofXZuFbpJs8
         aUvwozR98Pv7H5EkNMY9G+Gi2eaMNUukpVWfwHn+Z+QIRsig2W5EuH6DGVrLjzDnMKDU
         +12wyeAD3ieKcUfNDwR0ohZ4Ivqjrg2qBFKNZikn5obKXnzrFgVyjonilXSj7ZTI0MuT
         6o3LwtqLnKNjUCKZaIHkFnL+pP0cY/mIm2rOLzA867Aub93K+fmsDuU8PDvIXfqiTyEm
         GxnO9KQaBYowgRqUkO/qZgZtIiKWG6gZCHVKjLqz6UNkyQJ/sbt4NMGzASaQ6COTvM0Y
         tf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695934495; x=1696539295;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=If3zzTuQox6klgPTiONCSaZmvw9nCpdZZO2UC0XFde0=;
        b=tpTXIeoSmdclmxMnBQKoxnQHl5ec5VAnznJo8HEJIlhvtJ4TKrMTDGZp7i/jpnNmB1
         BFRAwsWgeIRxSEpNCJL75slJhiFNYBQvxUghB7SXO6D88YBDePoRX1ItFTU9+5UcszpF
         CvqEHj61dg1XTg1xBFSUL51uzUsdj9JLxq5AfzSghb1P5P88p3TK5E9NDScNbdPoLxAj
         +/gnimI2DpP+SHR+QqaM+aPHi56X0Z10gmnCsik72gAsSwnS8gw2UjFWY6flFPz5t+YS
         SGa9mTQooyk7kW/91VfrrMiBmzxrSeock3+69tLTc2z7iksar0t6CMp9R+b+ojqMoj9R
         kEKw==
X-Gm-Message-State: AOJu0YxniqVmHw+kEuYJD71LoaMS5ecctrbqNMNskIRFD8J1fBFuQl8i
	xp8Mo9wZsi1ODbUEwSfRaC8DbUM1fEURqWf8//wryA==
X-Google-Smtp-Source: AGHT+IFK7RemfIPsiLjS9fVoqz8lfYZApzH9BPacdODL4uXt0GkXtoD2GqplUkEX04u2i8lglGa15g==
X-Received: by 2002:a17:906:74ca:b0:9b2:94a8:df5 with SMTP id z10-20020a17090674ca00b009b294a80df5mr2146771ejl.35.1695934495080;
        Thu, 28 Sep 2023 13:54:55 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ff86:e30:98cd:120? ([2a02:578:8593:1200:ff86:e30:98cd:120])
        by smtp.gmail.com with ESMTPSA id y16-20020a1709064b1000b0099bd453357esm11333547eju.41.2023.09.28.13.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 13:54:54 -0700 (PDT)
Message-ID: <d656468d-b34f-4d9a-a87d-0392f68a9abc@tessares.net>
Date: Thu, 28 Sep 2023 22:54:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 07/29] selftests: mptcp: display simult in
 extra_msg
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1695631132.git.geliang.tang@suse.com>
 <8b0cb915b2b9c6c90751f5503df1721157880d1a.1695631132.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <8b0cb915b2b9c6c90751f5503df1721157880d1a.1695631132.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/09/2023 10:41, Geliang Tang wrote:
> Just like displaying "invert" after "Info: ", "simult" should be
> displayed too when rm_subflow_nr dosen't match the expect value in
> chk_rm_nr():
> 
>       syn                                 [ ok ]
>       synack                              [ ok ]
>       ack                                 [ ok ]
>       add                                 [ ok ]
>       echo                                [ ok ]
>       rm                                  [ ok ]
>       rmsf                                [ ok ] 3 in [2:4]
>       Info: invert simult
> 
>       syn                                 [ ok ]
>       synack                              [ ok ]
>       ack                                 [ ok ]
>       add                                 [ ok ]
>       echo                                [ ok ]
>       rm                                  [ ok ]
>       rmsf                                [ ok ]
>       Info: invert
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index ee1f89a872b3..d02e53be8b31 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1766,7 +1766,9 @@ chk_rm_nr()
>  		# in case of simult flush, the subflow removal count on each side is
>  		# unreliable
>  		count=$((count + cnt))
> -		[ "$count" != "$rm_subflow_nr" ] && suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
> +		[ "$count" != "$rm_subflow_nr" ] && \
> +			suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]" && \
> +			extra_msg="$extra_msg simult"

Good idea!

I think it would be clearer to use an explicit "if":

  if [ "$count" != "$rm_subflow_nr" ]; then
      (...)

I can do the modification when applying the patch if needed.

Cheers,
Matt

>  		if [ $count -ge "$rm_subflow_nr" ] && \
>  		   [ "$count" -le "$((rm_subflow_nr *2 ))" ]; then
>  			print_ok "$suffix"

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
