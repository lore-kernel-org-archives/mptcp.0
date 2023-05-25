Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303A6182C1
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 15:22:13 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-30959c0dfd6so2200106f8f.3
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 08:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685028131; x=1687620131;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+pcS5LsFkQnW1dDexrowpJWJqQki0CEgSvwZQz7Fiag=;
        b=QVu3hQPlPOWDHJJF8wpzpDpgXfH2Zz9Ns6MmPuGqtMzO6J+fOVb0tk+l1LRDnibnt7
         4UHa/aywfDUANR+0WaQg3+UC4K2pcnV1mBdsJEc8WWfUqFEt1mWJIJq0lEWTYJX2gexe
         U/Mg2nYqhwMkaOlH/MQU3gPX2mmdlzEBXKWwkmngWK9ziviK2MvfBnzj5+ZNXqj2FN2a
         LGPtreLBxalMD1vWA/Sd/Is51m6fZ5voHoy6YGkPApCzDQL64GiLfYO41RVQ8IkO7MY/
         d+i/GHp7/WasiTQACKqY/KhCqFcUr8GA7MLkcVGPJJmf2mjLUxqoKMXgYGBo4b59JCgK
         nsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685028131; x=1687620131;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pcS5LsFkQnW1dDexrowpJWJqQki0CEgSvwZQz7Fiag=;
        b=WnZpzTrP/2n4HJWyH2DpmdGN4yHZtmZpXZUyaZ+Vad5a4+b4RwHNqwXIQSU08OswzC
         nqchLm73o0qn3j1vmmBpp0m+WNyltSBeaXe+vmwjrNz5IiETimMlYhSDal/e4FY7E4Ee
         ccbuDzpg+4Ngy/UYYMrC3a9L9vOHDMv/q/ZV5hgMu3SKvvsoD9fr9nJN26LIdo69P9XM
         5B3/iCtoRM3+zzxH5RMEehp9wfsa19MImDcr7sLngTmK8sQ09q/lPSso14zLZG+OQpcq
         Q/AjqOuBKIzLxbxRE/GSnEjWVQH+Um1dxMoq2r15SnGk8ZC9IhgOcf3ut0VBb4Va6JkY
         EbMg==
X-Gm-Message-State: AC+VfDzhDm6h6mngOvvarG0iyHAxdlHYXjtNzKZf9ytHKdun1/uOtZk0
	8lnbtT0ywnS0jw3LFVVoyhIJBQ==
X-Google-Smtp-Source: ACHHUZ66Ah8M4gBODDsIJPjITUOLKKhKy5nAf4O2RDEYUB6svrNOp1wjgE7H0GtCgca1q13PV0ozZg==
X-Received: by 2002:adf:f310:0:b0:309:48b3:3ad6 with SMTP id i16-20020adff310000000b0030948b33ad6mr2679128wro.47.1685028131279;
        Thu, 25 May 2023 08:22:11 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f7f1:b30b:79e4:1a7e? ([2a02:578:8593:1200:f7f1:b30b:79e4:1a7e])
        by smtp.gmail.com with ESMTPSA id d16-20020adff850000000b0030903d44dbcsm2113847wrq.33.2023.05.25.08.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 08:22:11 -0700 (PDT)
Message-ID: <d26ed3cb-3dc3-0c7c-af56-ae0e62c403a6@tessares.net>
Date: Thu, 25 May 2023 17:22:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 mptcp-next 6/6] selftests: mptcp: add MPTCP_FULL_INFO
 testcase
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
References: <cover.1684997011.git.pabeni@redhat.com>
 <576f5cf229e5b91d27e8411fab1ba7223cec0c17.1684997011.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <576f5cf229e5b91d27e8411fab1ba7223cec0c17.1684997011.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 25/05/2023 09:17, Paolo Abeni wrote:
> Add a testcase explicitly triggering the newly introduce
> MPTCP_FULL_INFO getsockopt.

(...)

> +static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
> +{
> +	size_t data_size = sizeof(struct mptcp_full_info);
> +	struct mptcp_subflow_info sfinfo[2];
> +	struct tcp_info tcp_info[2];
> +	struct mptcp_full_info mfi;
> +	socklen_t olen;
> +	int ret;
> +
> +	memset(&mfi, 0, data_size);
> +	memset(tcp_info, 0, sizeof(tcp_info));
> +	memset(sfinfo, 0, sizeof(sfinfo));
> +
> +	mfi.size_tcpinfo_user = sizeof(struct tcp_info);
> +	mfi.size_sfinfo_user = sizeof(struct mptcp_subflow_info);
> +	mfi.size_arrays_user = 2;
> +	mfi.subflow_info = (unsigned long) &sfinfo[0];
> +	mfi.tcp_info = (unsigned long) &tcp_info[0];
> +	olen = data_size;
> +
> +	ret = getsockopt(fd, SOL_MPTCP, MPTCP_FULL_INFO, &mfi, &olen);
> +	if (ret < 0) {
> +		if (errno == EOPNOTSUPP) {
> +			perror("MPTCP_FULL_INFO test skipped");
> +			return;
> +		}
> +		xerror("getsockopt MPTCP_FULL_INFO");
> +	}
> +
> +	assert(olen <= data_size);
> +	assert(mfi.size_tcpinfo_user == mfi.size_tcpinfo_kernel);
> +	assert(mfi.size_tcpinfo_user == sizeof(struct tcp_info));
> +	assert(mfi.size_sfinfo_user == mfi.size_sfinfo_kernel);
> +	assert(mfi.size_sfinfo_user == sizeof(struct mptcp_subflow_info));

Similar to the patch I sent to support old kernels, we cannot do these 4
last assert(), see:

https://patchwork.kernel.org/project/mptcp/patch/20230406-mptcp-issue-368-selftests-old-kernels-v2-17-50313e4f83ab@tessares.net/

Because we cannot guess the size of these two structures in the kernel,
I suggest to do this:

  assert(mfi.size_tcpinfo_user > 0);
  assert(mfi.size_tcpinfo_kernel > 0);
  assert(mfi.size_sfinfo_user > 0);
  assert(mfi.size_sfinfo_kernel > 0);

Better than nothing... In case of error, one would be set to 0 or we
would not get info from these structures below.

> +	assert(mfi.num_subflows == 1);
> +
> +	/* Tolerate future extension to mptcp_info struct and running newer
> +	 * test on top of older kernel.
> +	 * Anyway any kernel supporting MPTCP_FULL_INFO must at least include
> +	 * the following in mptcp_info.
> +	 */
> +	assert(olen > (socklen_t)__builtin_offsetof(struct mptcp_full_info, tcp_info));

Likely, this should always be correct because 'mptcp_info' is after
tcp_info, no? On the other hand, hard to do better  if we need to
support old kernels... So fine to keep it I suppose.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
