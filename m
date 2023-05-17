Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA9B31128
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 14:27:17 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-307664010fdso867537f8f.0
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 07:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684333635; x=1686925635;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XyH28NhQeZA4jw9rzyyqsGMVjHc/0vTLKpbZqTGqBak=;
        b=6OplKEt3Z25Ze4xUo8GT8X6LTvtwwGwvIu9vUISP31Rh4XvuN5h3nUji/DybO/d6XX
         m2tB/Re6ADf3Kyh2qFyP+aNN7HgUUYfMKU+cLlh83RyBbVHR2ZWFoSsh2hBmUZH525eU
         7vjYJ56nsLvhX+mheOPReYmZzg3rzoRxINNnDhFb9xlFEKD55UR0vcRCV0u2xMGnwzpa
         pEZRbIW8hea7HVEP+uZelL0yKwbNtQHmOopmScFdQljA3yK/1bUYUtb5A/4xFp8p6jSd
         b3gS4X9cDHxRm3cqohTGrxXQUe/p6TV1L3bP5ZMk2nAbTDvY6f8SotnYvGaeS1bPcKlX
         OGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684333635; x=1686925635;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyH28NhQeZA4jw9rzyyqsGMVjHc/0vTLKpbZqTGqBak=;
        b=AtEA5sH0CdEPcwvDVuh47w1sA+nahQFyq7gkl6+RiDasLUtLmko6UbMu8wYmiQS9G7
         BYiVxlJqKYUvS5YC1Waz+dKluAyau5+E5kbuNOS7OGlG64yZzHPps8AWde8lK056nnTs
         frOi7NFEUh0DCWh5/tXAutsAZVBrOmfEXq3WbzRqo/wP8utNktO/c7ZKuCbZgvzNNRg1
         O4benjpkvrKlOyxu6JwjCjAYC/sX0sPrC92in2aSu/kj5Ls37Tg2+NxgJkSawFYkMprz
         49HhE1kMv69CXvGbVK5x6C/RGnRBIRGCHIlb/ydzjf8m2L2+AemwN2YjqtypOBGj2Nc6
         ZtaA==
X-Gm-Message-State: AC+VfDzZ5mlLs7/v0dvPk+I6gWh2FH6hvnUM/76r7tGwU+ZXV3DxltJS
	/YSSq5q4PugfFypqaK9a9EjA1VNy68NqoAfMyY0=
X-Google-Smtp-Source: ACHHUZ7T2QYTJn9gwy+29jX39yPNEavtoxa5li6epVQ7HGyg62UGeRQ4VAco0HsUkvH7u0LCcSfa+w==
X-Received: by 2002:adf:ef0d:0:b0:306:772:5c2e with SMTP id e13-20020adfef0d000000b0030607725c2emr723435wro.70.1684333635532;
        Wed, 17 May 2023 07:27:15 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a66b:672f:3b69:b6da? ([2a02:578:8593:1200:a66b:672f:3b69:b6da])
        by smtp.gmail.com with ESMTPSA id e2-20020adfe382000000b00304832cd960sm3007498wrm.10.2023.05.17.07.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 07:27:15 -0700 (PDT)
Message-ID: <9f2a2ed9-ed67-a55a-3868-c5183fa2123f@tessares.net>
Date: Wed, 17 May 2023 16:27:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next 4/4] selftests: mptcp: explicitly tests
 aggregate countes
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1683212362.git.pabeni@redhat.com>
 <b616382e36ea891a36f74a7508a004593afa8a59.1683212362.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b616382e36ea891a36f74a7508a004593afa8a59.1683212362.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 04/05/2023 18:40, Paolo Abeni wrote:
> Update the existing sockopt test-case to do some some
> basic checks on the newly added counters.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  .../selftests/net/mptcp/mptcp_sockopt.c       | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> index ae61f39556ca..0c58de3ef339 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> @@ -51,6 +51,11 @@ struct mptcp_info {
>  	__u8	mptcpi_local_addr_used;
>  	__u8	mptcpi_local_addr_max;
>  	__u8	mptcpi_csum_enabled;
> +	__u32	mptcpi_retransmits;
> +	__u64	mptcpi_bytes_retrans;
> +	__u64	mptcpi_bytes_sent;
> +	__u64	mptcpi_bytes_received;
> +	__u64	mptcpi_bytes_acked;
>  };
>  
>  struct mptcp_subflow_data {
> @@ -83,6 +88,7 @@ struct mptcp_subflow_addrs {
>  
>  struct so_state {
>  	struct mptcp_info mi;
> +	struct mptcp_info last_sample;
>  	uint64_t mptcpi_rcv_delta;
>  	uint64_t tcpi_rcv_delta;
>  };
> @@ -320,6 +326,7 @@ static void do_getsockopt_mptcp_info(struct so_state *s, int fd, size_t w)
>  
>  	assert(olen == sizeof(i));
>  
> +	s->last_sample = i;
>  	if (s->mi.mptcpi_write_seq == 0)
>  		s->mi = i;
>  
> @@ -556,6 +563,19 @@ static void process_one_client(int fd, int pipefd)
>  	do_getsockopts(&s, fd, ret, ret2);
>  	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)
>  		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64, s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - ret);

To support old kernels, I guess the best is to store the "length" of the
getsockopt(MPTCP_INFO) and only check these new following conditions if
the "length" received from the kernel is bigger than a certain size (by
looking at the offset of the mptcpi_retransmits field in the mptcp_info
structure I suppose)?

> +	if (s.last_sample.mptcpi_bytes_sent != ret2)
> +		xerror("mptcpi_bytes_sent %" PRIu64 ", expect %" PRIu64,
> +		       s.last_sample.mptcpi_bytes_sent, ret2,
> +		       s.last_sample.mptcpi_bytes_sent - ret2);
> +	if (s.last_sample.mptcpi_bytes_received != ret)
> +		xerror("mptcpi_bytes_received %" PRIu64 ", expect %" PRIu64,
> +		       s.last_sample.mptcpi_bytes_received, ret,
> +		       s.last_sample.mptcpi_bytes_received - ret);
> +	if (s.last_sample.mptcpi_bytes_acked != ret)
> +		xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64,
> +		       s.last_sample.mptcpi_bytes_acked, ret2,
> +		       s.last_sample.mptcpi_bytes_acked - ret2);
> +

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
