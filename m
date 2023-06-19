Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6015E125CE
	for <mptcp@lists.linux.dev>; Mon, 19 Jun 2023 15:01:48 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-988689a5f44so169862566b.1
        for <mptcp@lists.linux.dev>; Mon, 19 Jun 2023 08:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687186907; x=1689778907;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6K33ctxnx96ohMAwLessJnzPHAXtfSwuNmGBOr61SYM=;
        b=LpqHHU8umGRnJ66RaMCwo30G0N8oGMsSGzNoxqeSziZ9Rd8ZliDkom4KOfzgwYqMzz
         YXHVYlhxOhHn89W7tMKfoAhH0mR/EH61Yv5a+CfLaw2VAbajtxwSdqCAABov+8kG0OEA
         wHuLoQeoiERsRupKBV98tYapSHV99k9s4EyND9peG9WtOojrCH0v9seaWyGuZeiSjEV8
         JFZ9GUDyDXjkfKf4eaIsL3uq/P3pExvOroAywfeH8agxMA7SggLloZNpQ/8s9FLYjDWC
         3WWAJWGRa8wt1hInAKb26aaO9qJJtedb52yHHlConFNmx7+QdlbY9Z7m7Ycayl37LnIG
         JkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687186907; x=1689778907;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6K33ctxnx96ohMAwLessJnzPHAXtfSwuNmGBOr61SYM=;
        b=eozbhLMsQj4QxUx1X0JJrdCOSduurlj8VTVfFAXLVNdwlChdcwjBzEp7N560iCt0kb
         yFsfXbSjUcAacXXta+N9705YTYQB/tx4H1EbkxRILLZiuE5OUGzfNZ/Shn9OW6jFHpsb
         rtUXSgroz2NrM/XTjCP0Jeb18mQd+DVAsAAGMmL5xnrVLbhJfJdMsJXiZuvhoMsok0Yq
         U8HHZyNHQ3tWU2TB42SWxvdMQJDBEkoay+kEB4s+hJwcvxP6r5Z4ZT1rXT6aRzooZdku
         /6ZHKhiUGpzjSL+fBAdWS/DrVjJVw6p8N0V6rkK4xtu0h8x34Mi7PHtwBNSaxWy5Q90Z
         kELQ==
X-Gm-Message-State: AC+VfDz3luwplIyD5VbbVTOsniAqgPOsYYpPer39RmKA6wkq6Z3xHWdP
	CT/1IJsjzKs4pQBsNXUH/GpqQiSR12ItCjD3aSI=
X-Google-Smtp-Source: ACHHUZ62oqNVL5JIbqCWr35tztuT0zLqQEFAZvQG1VbZLWmK7QmgWBmzdKAO2DCA5lO+yHb/HuF5NA==
X-Received: by 2002:a17:907:701:b0:974:6026:a316 with SMTP id xb1-20020a170907070100b009746026a316mr8757521ejb.19.1687186907062;
        Mon, 19 Jun 2023 08:01:47 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906360200b0096a27dbb5b2sm14614236ejb.209.2023.06.19.08.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 08:01:46 -0700 (PDT)
Message-ID: <bb2adfc9-640e-4c5f-ec46-87bd850e996f@tessares.net>
Date: Mon, 19 Jun 2023 17:01:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v20 03/10] selftests: mptcp: check subflow and
 addr infos
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1686900596.git.geliang.tang@suse.com>
 <91c10944663b947b6ccb8b3be5b2f8581295ba73.1686900596.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <91c10944663b947b6ccb8b3be5b2f8581295ba73.1686900596.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 16/06/2023 09:30, Geliang Tang wrote:
> This patch adds more arguments for chk_mptcp_info() to check subflows,
> add_addr_signal and add_addr_accepted infos of different namespaces. And
> invokes chk_mptcp_info() to check subflows infos of userspace PM tests
> and endpoint tests.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 48 +++++++++++--------
>  1 file changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 3baa6ac3b03e..3811a6c3dc5d 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1832,31 +1832,32 @@ chk_subflow_nr()
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
> +	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info1:$info2=$nr1:$nr2"
>  
> -	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
> +	cnt1="$(ss -N $ns1 -inmHM)"
> +	cnt2="$(ss -N $ns2 -inmHM)"

(I don't think we need "-m" but it was already there before)

> +	if [ -z "${cnt1}" ] || [ -z "${cnt2}" ]; then
> +		mptcp_lib_fail_if_expected_feature "$info1:$info2 SS counter"
> +		echo "[skip]"
> +		return

If I'm not mistaken, here, we are going to skip the check if:
- "ss -M" is not supported
- there is no (more) active MPTCP connection

I think that's not correct to skip the checks here because some features
are missing for these reasons:

- For "ss -M" support, it is probably best to do that in check_tools()
function, similar to what is done in diag.sh:

  if ! ss -h | grep -q MPTCP; then (...)

- if there is no more active MPTCP connection, we should then assume the
counter is 0 and not skip the check because maybe we have an issue if we
expect to have active connections.

In both cases, it is not linked to the info we are trying to grab and
the printed message that expected features are missing is confusing (and
wrong).

=> So I think it would be better to:
  - add a new patch checking if 'ss' supports MPTCP (can be done in
another series)
  - here: just assume the counter is 0 if 'ss' output is empty

Also, I just remembered 'ss' will only display the counters that are
different from 0... That's a nice thing to do to reduce the number of
info displayed by ss but it means we cannot use 'ss' to know if the
counter is supported by old kernels... On the other hand, all the
counters you are getting for the moment (subflow, add_addr_signal +
accepted) are present since kernel v5.9 so before the first LTS version
with MPTCP support so we are good. If one day we want to get new
counters, we will first need to check if the running kernel supports
such counters. We can do that later. So no need to skip the tests here
if it looks like features are missing.

=> In other words, sorry for the confusion but I think it would be
better to go back to what you were doing before: without the 'if' and by
retrieving info in one step:

  cnt1=$(ss -N $ns1 -inmHM | grep "$info1:" |
         sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
  # 'ss' only display active connections and counters that are not 0.
  [ -z "$cnt1" ] && cnt1=0

If there is no other modifications in this v20, I can do the
modification myself if that's OK for you. Or I can apply a Squash-to
patch if you prefer.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
