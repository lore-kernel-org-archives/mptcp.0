Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDB51F18E
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 16:04:06 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5147dce372eso6738295a12.0
        for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 09:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686585845; x=1689177845;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kl6MQh+QZ1H9bnWMUS/NuuWuTjBNo1CMjdcPekEvkUk=;
        b=wPmP6X7oaOWIT+9Oy5Ol6rkvYV3iD9Zq0iY2iZwibUO2UYZof61E+JBGDpmJaKLHor
         bYcUr70X/JuCtYX2YOD19Fr7rub2nnuM5mih/VX+JVW53EEnctuvMoVKvyJTLco9/xPK
         qfFIbWoGAL9kp7HRE23we0NZdn+CZkR9yhl2OUYGV/83VZKZeTV3rdWiaSR5dRcTNcBM
         qDlJD3NSGoAKVBReHCa3Ncv8bXOiQc0B4/vHJaShFsL+AyCulLOJZuipghAIQ8s8gSjd
         RGlz18VUXIxvVHeb0ZPHtrZBibIzZ2GfDZ/TVAMIxGt9yw0FGLeYK47ZXADqo6L332e4
         6W8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686585845; x=1689177845;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kl6MQh+QZ1H9bnWMUS/NuuWuTjBNo1CMjdcPekEvkUk=;
        b=KefuZ9nTmYhR63FDNSPuCa/Cg5ZnY1TPcvmcdJqtLOE7XLYrUGtH749xQnejyHOFyZ
         yguPu6PU2FSWssogWD1G5AdPzNkfw0URlswyuwR16oF1mZNWdt8nPenA3sA17xkn6Tw5
         W8WcDFtOjfKkCQQZDh+yw0Hx3QW/glmu3ZKeuNEoeyob3XugYaaCoCgGTpKXdFwlq78v
         7sVDQGgQhDz9SX02urafyiuDvGNcMGyqZPkn4n2yWGzeg+iG+iQkiD8kZT0012nC7CFE
         X9TXA5KnUkN6+UM6wULDXZ66Ez7VkxnyBQ9ML7H4uUG76PzTwRP3LvNbDycVWWNtqNpI
         sNXg==
X-Gm-Message-State: AC+VfDwgxBFsVE+ik+aq9BkZ+wAjUQsg4BPKjN87dHd3rJrpDl5ZmtPY
	JZm6WRwBnT6KPNnCTctkuiC+Av3wePVINkS44Qc=
X-Google-Smtp-Source: ACHHUZ6JR8tTDUlTeXf06gYMmnt5MkAhKKzMx7uqHMd1tkjL4G2Pxcw3Hxy/V8+eDBIZwjPauAdLzw==
X-Received: by 2002:a05:6402:6d3:b0:50d:88f3:2e30 with SMTP id n19-20020a05640206d300b0050d88f32e30mr5690753edy.13.1686585844834;
        Mon, 12 Jun 2023 09:04:04 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id n12-20020a05640204cc00b0051631518aabsm5182072edw.93.2023.06.12.09.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:04:04 -0700 (PDT)
Message-ID: <264d88a5-e895-dfdd-5475-8b6c75b70b33@tessares.net>
Date: Mon, 12 Jun 2023 18:04:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v18 3/7] selftests: mptcp: check subflow and
 addr infos
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1686554287.git.geliang.tang@suse.com>
 <cc9df9ec7d422a3b862d440e511b800cf8e97bd0.1686554287.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cc9df9ec7d422a3b862d440e511b800cf8e97bd0.1686554287.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the update!

On 12/06/2023 09:19, Geliang Tang wrote:
> This patch adds more arguments for chk_mptcp_info() to check subflows,
> add_addr_signal and add_addr_accepted infos of different namespaces. And
> invokes chk_mptcp_info() to check subflows infos of userspace PM tests
> and endpoint tests.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 47 ++++++++++---------
>  1 file changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 556d21c4b7a5..1697b0b89d9c 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1832,31 +1832,25 @@ chk_subflow_nr()
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
> -		fail_test
> -		return 1
> -	fi
> -
> -	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
> +	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info1:$info2=$nr1:$nr2"
>  
> -	cnt1=$(ss -N $ns1 -inmHM | grep "$info:" |
> -		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
> -	[ -z "$cnt1" ] && cnt1=0
> -	cnt2=$(ss -N $ns2 -inmHM | grep "$info:" |
> -		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
> -	[ -z "$cnt2" ] && cnt2=0
> -	if [ "$cnt1" != "$nr_info" ] || [ "$cnt2" != "$nr_info" ]; then
> -		echo "[fail] got $cnt1:$cnt2 $info expected $nr_info"
> +	cnt1=$(ss -N $ns1 -inmHM | grep "$info1:" |
> +		sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
> +	cnt2=$(ss -N $ns2 -inmHM | grep "$info2:" |
> +		sed -n 's/.*\('"$info2"':\)\([[:digit:]]*\).*$/\2/p;q')
> +	if [ -z "${cnt1}" ] || [ -z "${cnt2}" ]; then
> +		mptcp_lib_fail_if_expected_feature "$info1:$info2 SS counter"

This check looks good to me but it seems like the CI found an issue with
it, see:

https://api.cirrus-ci.com/v1/artifact/task/4717958065291264/summary/summary.txt

I suspect that the connection has been closed and the output of "ss" is
empty, no?

Maybe it is required to do this in two steps? Then best to have a
dedicated function I think, e.g.

  get_ss_counter()
  {
      local ns="${1}"
      local info="${2}"
      local cnt

      cnt="$(ss -N $ns -inmHM)" ||
          mptcp_lib_fail_if_expected_feature "error with ss -inmHM"

      # no more connection: counter is then 0
      if [ -z "${cnt}" ]; then
          echo 0
          return
      fi

      cnt="$(echo "${cnt}" | grep "${info}:" |
             sed -n 's/.*\('"${info}"':\)\([[:digit:]]*\).*$/\2/p;q')"
      if [ -z "${cnt}" ]; then
          mptcp_lib_fail_if_expected_feature "${info} SS counter"
          return 1
      fi

      echo "${cnt}"
  }


  (...)
  cnt1=$(get_ss_counter "${ns1}" "${info1}")
  cnt2=$(get_ss_counter "${ns2}" "${info2}")
  if [ -z "${cnt1}" ] || [ -z "${cnt2}" ]; then
      echo "[skip]"
  elif [ "$cnt1" != "$nr1" ] || [ "$cnt2" != "$nr2" ]; then



> +		echo "[skip]"
> +	elif [ "$cnt1" != "$nr1" ] || [ "$cnt2" != "$nr2" ]; then
> +		echo "[fail] got $cnt1:$cnt2 $info1:$info2 expected $nr1:$nr2"
>  		fail_test
>  		dump_stats=1
>  	else

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
