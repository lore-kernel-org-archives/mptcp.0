Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E202182D4
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 15:31:12 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-977d55ac17bso341604766b.3
        for <mptcp@lists.linux.dev>; Fri, 09 Jun 2023 08:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686324671; x=1688916671;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ihwRCqoGvlePyuQ7UUgbXw/4o1efyjK1Dmp39qNpDQA=;
        b=nqTx25AjCm4Gf0Rub8MNXiFe/nj9ZnxwmYaVzC8Rorf/lx1dYwITaCaGusWTztOQ98
         mZ2PSDsi98MeZM663eD2peihpTf+PJ6iMzyxJTIXu+I6NRqxKvvNsxri6/5AiwQsH56x
         7zKhm/aNp6nNHGKieIGMKCQ+M1n6m+4B6Y1FrBhvhwqPv8TofDJqe2mjMmbQKWGFXops
         9msPn5513b/SXQuGKOZysj1CHmaxIOB4kZZkAHZd6PfzsN9oaApEPnPyn0ZfZqF7QXhH
         Mt/MgB5WbuiHZLZ4PoKi6e024nZTT2Hx8xyDJgP48sbxdDjWLrh4yCvaVByqYaxFi1RL
         hUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686324671; x=1688916671;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihwRCqoGvlePyuQ7UUgbXw/4o1efyjK1Dmp39qNpDQA=;
        b=HbU+Qax6QIFtAJIFVI05a5yc7J/1+lODth3NqnISkO7+Dul+Z5qFt7dYZK9tUAdWCv
         a5m4iyjJtyoiSVd0kqPbn+fqW57WB+ZQz24MSqGbaLziDLVWuzlPu13RHivXxlDygEtf
         N1k+DbIERZQ/fGzmZWyU4qVUK8O9UVJ639fcux1d89JCkw1r48ctkjBSJT7k3I45PFic
         TkbmHKykm3CEIkJdf9mvYDDUWH+xC74It7qM2rDOkTIu7iGu3dV/sS/aKVK5J2EkrC2I
         pOmGt2TXGkkKvOqwyAkOFR9xUEmnI0g5r9xrvZ8t8ek3G0r2DaRQRAU0IevMt9EvGOLW
         yJuQ==
X-Gm-Message-State: AC+VfDwhHAq/cKjrYCeXP0aeD1AzzpeTMwn3bNNXPGFDSdX3Im2EfDSW
	jZhOxPRcIjaxIsHLvoZD1b33a0bGeyW+XWzhGj8KVQ==
X-Google-Smtp-Source: ACHHUZ53rTROEMPtyNYrX4gRayP3fwXLU8tyjCyZETC/YKk3OuBztDeQU+X1OPI4g1xX1zib1IIDqw==
X-Received: by 2002:a17:907:7202:b0:96f:cb13:8715 with SMTP id dr2-20020a170907720200b0096fcb138715mr2063583ejc.69.1686324671062;
        Fri, 09 Jun 2023 08:31:11 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id oq19-20020a170906cc9300b00977e0bcff1esm1464873ejb.10.2023.06.09.08.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:31:10 -0700 (PDT)
Message-ID: <f76f508b-c22d-acab-eb96-77dc0e666873@tessares.net>
Date: Fri, 9 Jun 2023 17:31:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v17 3/7] selftests: mptcp: check subflows infos
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1686138130.git.geliang.tang@suse.com>
 <82ed5b57d2fba7c1a5ef35de4f390ad7409c3c40.1686138130.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <82ed5b57d2fba7c1a5ef35de4f390ad7409c3c40.1686138130.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 07/06/2023 13:44, Geliang Tang wrote:
> This patch adds more arguments for chk_mptcp_info() to check subflows
> info of different namespaces. And invokes chk_mptcp_info() to check
> subflows infos of userspace PM tests and endpoint tests.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 39 +++++++++++--------
>  1 file changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 6684a60dad50..119a309bf96f 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1812,31 +1812,31 @@ chk_subflow_nr()
>  
>  chk_mptcp_info()
>  {
> -	local nr_info=$1
> -	local info
> +	local info1=$1
> +	local nr1=$2
> +	local info2=$3
> +	local nr2=$4
>  	local cnt1
>  	local cnt2
>  	local dump_stats
>  
> -	if [[ $nr_info = "subflows_"* ]]; then
> -		info="subflows"
> -		nr_info=${nr_info:9}
> -	else
> -		echo "[fail] unsupported argument: $nr_info"
> +	if [ $info1 != "subflows" ] ||
> +	   [ $info2 != "subflows" ]; then
> +		echo "[fail] unsupported argument: $info1:$info2"
>  		fail_test
>  		return 1
>  	fi

Do you still need to check the arguments? That's just internal and we no
longer extract info from the variable. Maybe we can remove this block now?

> -	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
> +	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info1:$info2=$nr1:$nr2"
>  
> -	cnt1=$(ss -N $ns1 -inmHM | grep "$info:" |
> -		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
> +	cnt1=$(ss -N $ns1 -inmHM | grep "$info1:" |
> +		sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
>  	[ -z "$cnt1" ] && cnt1=0

I see below that you are checking the values in more places. Some old
kernels might not have these counters, no?

Should we not have something like:

  cnt1=$(...)
  cnt2=$(...)
  if [ -z "${cnt1}" ] || [ -z "${cnt2}" ]; then
      mptcp_lib_fail_if_expected_feature "${info1} SS counter"
      echo "[skip]"
  elif [ "$cnt1" != "$nr1" ] || [ "$cnt2" != "$nr2" ]; then
      <fail>
  else
      <ok>
  fi

No?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
