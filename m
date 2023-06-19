Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17EC8BE5
	for <mptcp@lists.linux.dev>; Mon, 19 Jun 2023 15:04:24 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-978863fb00fso583864466b.3
        for <mptcp@lists.linux.dev>; Mon, 19 Jun 2023 08:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687187063; x=1689779063;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t6QvF3m1QxYekAdGWxRWM/Tfd4hV+VS8NUVo31P5HoU=;
        b=HrhnxicbpHdORGmgVGegB6SVELJIjtgKa5bwWTNLIzXuyxh1toqM8Nan8NkLO6T7A2
         l/fOymUbOY58A54CQn4yWDi0OIcAGvUmkjIWJHCIN7fdqxPdPH7LTqR/lylRU69OQYgM
         f8jkXNhJlmnlw0WfOOHM05S+pYDxFhKJmnVdc6ErBtW3hgN5VmYNPlzQlWZWEC/NoCX9
         5uMV4MkO6AZFpB33o1nLZzlVv0BKZLxskmllhdsIbBz3HidcAaPvCzmvBxL9TJBvzjtJ
         LY/TieWP/M2kxnniC1MuNdlr/nXNrlbH5BZjRNm3XdioGzB5W23Y2z3YNfIqUK2ERuuL
         x0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187063; x=1689779063;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6QvF3m1QxYekAdGWxRWM/Tfd4hV+VS8NUVo31P5HoU=;
        b=bW17DxEWKKF02FK84kHrpo8JLGr3w5toO6CCiNw/LE/ETAj+UOC7FUJEn7291TLdmA
         rHf/QbhjqEcYRovCtvw1H72zBX8/i+y8U9E2N9LTTo2YSDWH7Wp0ImZoMMLKM6TrFq9y
         Ga77OMubUlx/nTPcPKVXb/bEjpMSAFx67SCIZQWI+lvmF0sYkxqMlSKJp6vTgsJ+KKZz
         cIjhVFJFWn0c+caqsmB7A/m5zpQIpGmdBF4AwRvmHoGG17GZSNNQi2ko7RVQiYcBn2/o
         hk2OFRlNEpq6hpsT8EsXA9US/mtWLR30dU8UGwhP4OMnqnQ5oQ3jUjJ1CvWYXo1AJo5Y
         VgVA==
X-Gm-Message-State: AC+VfDwNtX5rx0xC4/T2IRiWo4KUPGH66+wbHmHIuVTm7B8FBMirSD5H
	Nd3lUNELkq9MsCoqpU8KxYEfchvGP/pcDfDidiY=
X-Google-Smtp-Source: ACHHUZ7RnoMzUJ4Bph9lD25OxUXuSLcEUGSksx0tqe0b4VhJNpgFHlzurobBXZfFQWwd0NZdPnXd7A==
X-Received: by 2002:a17:907:86a4:b0:988:fea3:ae5a with SMTP id qa36-20020a17090786a400b00988fea3ae5amr366939ejc.47.1687187063050;
        Mon, 19 Jun 2023 08:04:23 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709064a1300b00988955f7b5esm1918211eju.157.2023.06.19.08.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 08:04:22 -0700 (PDT)
Message-ID: <921d34ce-ac77-00e0-190e-16fa672734a5@tessares.net>
Date: Mon, 19 Jun 2023 17:04:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v20 09/10] selftests: mptcp: pass fastclose to
 sflags
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1686900596.git.geliang.tang@suse.com>
 <70cf8f866f114c950f14febf9c41f0f09f4ea5c5.1686900596.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <70cf8f866f114c950f14febf9c41f0f09f4ea5c5.1686900596.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 16/06/2023 09:31, Geliang Tang wrote:
> Pass fastclose flag to the sflags argument instead of addr_nr_ns2.

Please *always* explain the reason(s) the commit message.
Here I guess you do that because it is clearer, right?

> Then the fullmesh flag setting can be moved into pm_nl_set_endpoint()
> from do_transfer().

Just to know, do you plan to simplify this part as well? e.g. to be able
to do something like:

  fullmesh=2 (...) \
      run_tests (...)

  if [ -n "${fullmesh}" ]; then
      flags="${flags},fullmesh"
      addr_nr_ns2=${fullmesh}
  fi

or:

  sflags=fullmesh addr_nr_ns2=2 (...) \
      run_tests (...)

and stop doing stuffs like:

  if [[ "${foo}" = "bar_"* ]]; then
      extracted_var=${foo:42}

>  		extra_args="-r ${speed:6}"
>  	fi
>  
> -	local flags="subflow"
>  	local extra_cl_args=""
>  	local extra_srv_args=""
>  	local trunc_size=""
> -	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
> +	if [[ "${sflags}" = "fastclose_"* ]]; then
>  		if [ ${test_linkfail} -le 1 ]; then
>  			echo "fastclose tests need test_linkfail argument"
>  			fail_test

Why not using a new "key"? e.g.

  fastclose=client \
      run_tests (...)

You would have here something clearer:

  if [ -n "${fastclose}" ]; then
      local side=${fastclose}

(not directly related but it is the same for speed_XX (e.g. speed_10),
we could pass speed=10 and even speed=slow but that's for a different
commit if you are interested to change that too ;) )

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
