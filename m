Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA58F5D
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 16:05:10 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id fy37so26968877ejc.11
        for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 08:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yk2+exeb3U28FiSTch2B/KSwN8PbFBLixR/OosdT9Eo=;
        b=d0Jo5wBYI1cqWXRgdc2wkUSe1QWf7X4FI3aiKQOoHPSL/LOpz3EyczjhhEz4XisM0L
         z7VjdAoI7oYPcAYdJpi4kd6L5UhX60l+d2pwNNzBigLD1dfs9obla8Fx/7rm7p2o1Eiv
         XmFLoPpgGSCDeOn22lt3V5xJ2aPT6T74pTqamVx1KsLxvflaLDSTEvI0ALHyCetmpgQO
         8ro477QUU1TAEA8dfP2mlnZF/RSbuCOxrB9zZAQ5Vwsw7Gfw0JY4ejN0qRCTJDJqST6j
         5mUvcTb1jVGBD9KMVN/fpR3hgm9yGx4qv55qOHewcEJUIk/poUsnKtj9+9qZtnsKXT5i
         X6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yk2+exeb3U28FiSTch2B/KSwN8PbFBLixR/OosdT9Eo=;
        b=0S3LDY8aIGkn4nYHlD40xIO4YRP74hzz0sHVXiAiUceS/7AuCh8aPfST01R81+Z9vd
         Qjw7TKW+g+CSz0C+zq7rxKuGa1iVkjxO1XIOd/Lp6YbPT/45BFupUWg3TuNyna7sTrQu
         HAw+EyUPRViugnQjbJxawKGBCpP3DmVRuyojnJHyFWbzYBu0Rg9srICId7NFuuAN4x85
         PfwtTzbs0tMssFNUTzgSgvVGkCYegLUphe9i+8DxYvS3c6C60PURXPDtY7us53HmV6zd
         e2OXoUEEDjzsF/TuOro51hDBMKWcAHe9OirbfFTZkXPrXBDKA2ukWbSUCpDT/5g0fTuH
         KapA==
X-Gm-Message-State: ANoB5plhXvCRjuJcFVnro4Yfu+VJvK58hEjiqRDg3gbJ583V7f59DLm6
	lvnRwLv735Sfnbw8dtvQLMs/lA==
X-Google-Smtp-Source: AA0mqf4UMWhg3xpsWz17jBb3n8RgEKbZyzSbego9K/FbN2Oo6RKuCP1LG4V7ShVm60JQzGAhjzKNFg==
X-Received: by 2002:a17:907:8c0d:b0:7ae:70f9:114 with SMTP id ta13-20020a1709078c0d00b007ae70f90114mr14801766ejc.44.1669651508277;
        Mon, 28 Nov 2022 08:05:08 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906201200b0077f20a722dfsm5086958ejo.165.2022.11.28.08.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 08:05:07 -0800 (PST)
Message-ID: <96ef2ca7-e207-be72-1552-33f3931de5d3@tessares.net>
Date: Mon, 28 Nov 2022 17:05:07 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next v7 4/4] selftest: mptcp: add test for mptcp
 socket in use
Content-Language: en-GB
To: menglong8.dong@gmail.com, mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
References: <20221122034923.804955-1-imagedong@tencent.com>
 <20221122034923.804955-5-imagedong@tencent.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221122034923.804955-5-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Menglong Dong,

On 22/11/2022 04:49, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> Add the function chk_msk_inuse() to diag.sh, which is used to check the
> statistics of mptcp socket in use. As mptcp socket in listen state will
> be closed randomly after 'accept', we need to get the count of listening
> mptcp socket through 'ss' command.
> 
> All tests pass.
> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
> v7:
> - check all processes exit in flush_pids()
> ---
>  tools/testing/selftests/net/mptcp/diag.sh | 54 ++++++++++++++++++++---
>  1 file changed, 49 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index 515859a5168b..4dd5dc1130ca 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh

(...)

> @@ -141,6 +159,25 @@ chk_msk_listen()
>  	nr=$(ss -Ml $filter | wc -l)
>  }
>  
> +chk_msk_inuse()
> +{
> +	local expected=$1
> +	local listen_nr
> +
> +	listen_nr=$(ss -N $ns -Ml | grep -c LISTEN)

Small detail: it is often recommended to always add {} around variable
names (e.g. ${ns}) and double quotes (e.g. "${ns}"), mainly to avoid
some unexpected behaviours and clearly spot variables.

> +	expected=$(($expected+$listen_nr))

Small detail: shellcheck will tell you it is clearer to drop '$' inside
the arithmetic operation, e.g.

   expected=$((expected + listen_nr))

> +	shift 1

Small detail: probably clearer to move this just after the first block
where you assign parameters given to this function.

> +
> +	for i in $(seq 10); do

Small detail: 'i' is declared as local. You can also use '_' if you
don't care about the value of $i

> +		if [ $(get_msk_inuse) -eq $expected ];then
> +			break
> +		fi
> +		sleep 0.1
> +	done
> +
> +	__chk_nr get_msk_inuse $expected $*
> +}
> +
>  # $1: ns, $2: port
>  wait_local_port_listen()
>  {

If you don't need to modify anything else in these commits after Paolo's
review, I can do the modifications myself when applying the different
patches (if I don't forget :) )

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
