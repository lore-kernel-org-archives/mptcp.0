Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FD61F922
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 15:30:00 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f607766059so20713385e9.3
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684855799; x=1687447799;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17JnXTKqvxAMNwvMkvN653FjVvGEMnKc3iUrxSlHOyE=;
        b=euwmctnxbzPjuxTbQa0qhssMaKld0grnoNsM/qQk6mt1g8uuYWdmWULfwY0gGx/HFv
         hr2ZD6Bi1gLklydbayrZNbE03dy+iQDL2LDsjKv6aqcmmqyhfPfPUkZ4yIN+yt57bc5q
         4ynXlZagLD051MOkYUkBLVN61khvFtbb0+1mrUjs44ZD9lpmWd3oPc2CqoXGQm7aUpL1
         DNmaU/BaaIoY9z8yKRcvMcPODolttq55KMrZkLO2gA06bgM5rtG4JKAU0lLSze3rsxrT
         xl2+zblAz3cfD/a/dfLb2+C/ls1cz14bimn310bI498RdsfT2MF3N6xXMq7J7XO/4YFZ
         FVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684855799; x=1687447799;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17JnXTKqvxAMNwvMkvN653FjVvGEMnKc3iUrxSlHOyE=;
        b=Nz6LI0ySeqSR352j4ugdVuT1Oxsr8RfSU3G5yYb8ssZIVcxc/ndvdZkqshpBXsIXsx
         dS1VRnH23PfZkuxxfG1UhDVm8Spg4TdjMos731zOhuYyP+mQ89yJLkpEN8e10rEJ6tik
         96I3ABw7bD20yuqG9cIoisE3YviaB6/M37+wD9zWf2EaQ8H5YMueCoBrmy97DOUCDw2M
         z1rmKbWe+57wuIy+EU774LArwjlbYGpMxdO/gzQE92jgmY898eka9Dh/4A05p+D+gVNB
         0aJjUkAhO3rUmYHaJex2f/NezkpU5T5V4e5HyhtFzTm+UpghKMtEYvG9V94glatyfwUZ
         DXHA==
X-Gm-Message-State: AC+VfDwEEUIfqzhQxBRjcOKjBKpRtK0dpqAstAPDal99yw6dBmGHweBM
	pcVvax4/Mw+B1J9fBNw7Fl2lb7TJ6q4/XgSzkA5fMCA7
X-Google-Smtp-Source: ACHHUZ6f390pZGAc7n0DYUtDGQ9nZI3ugD6TU9tINrhsEsfNAJnWFsk87MRSbizrf2IBEsR0nMbxuQ==
X-Received: by 2002:a7b:c411:0:b0:3f6:3bb:5129 with SMTP id k17-20020a7bc411000000b003f603bb5129mr5563327wmi.23.1684855798639;
        Tue, 23 May 2023 08:29:58 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6cb1:7d36:3be3:30d? ([2a02:578:8593:1200:6cb1:7d36:3be3:30d])
        by smtp.gmail.com with ESMTPSA id u3-20020a7bc043000000b003f4f89bc48dsm15319592wmc.15.2023.05.23.08.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 08:29:58 -0700 (PDT)
Message-ID: <7c0c7c6e-c3ba-bd6c-7dfc-c0d1de272a5a@tessares.net>
Date: Tue, 23 May 2023 17:29:57 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v2 5/6] selftests: mptcp: explicitly tests
 aggregate counters
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1684763196.git.pabeni@redhat.com>
 <7e32265ebe2ed650df1373c3774656c1b62f04d4.1684763197.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <7e32265ebe2ed650df1373c3774656c1b62f04d4.1684763197.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/05/2023 15:56, Paolo Abeni wrote:
> Update the existing sockopt test-case to do some some
> basic checks on the newly added counters.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  .../selftests/net/mptcp/mptcp_sockopt.c       | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> index ae61f39556ca..869c041c34f3 100644
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
> @@ -83,8 +88,10 @@ struct mptcp_subflow_addrs {
>  
>  struct so_state {
>  	struct mptcp_info mi;
> +	struct mptcp_info last_sample;
>  	uint64_t mptcpi_rcv_delta;
>  	uint64_t tcpi_rcv_delta;
> +	bool pkt_stats_avail;
>  };
>  
>  static void die_perror(const char *msg)
> @@ -320,6 +327,9 @@ static void do_getsockopt_mptcp_info(struct so_state *s, int fd, size_t w)
>  
>  	assert(olen == sizeof(i));

(see below)

> +	s->pkt_stats_avail = olen == sizeof(i);

Good idea, it is simple! But then we should remove the assert just above.

And maybe we should have here: olen >= sizeof(i), no?
Maybe we don't need to support newer kernels but it is just in case we
add more info later even if I guess we would modify mptcp_info if we does.

Also, maybe "struct mptcp_info" will be defined somewhere else and we
will not use the one defined here above?

> +
> +	s->last_sample = i;
>  	if (s->mi.mptcpi_write_seq == 0)
>  		s->mi = i;
>  
> @@ -556,6 +566,23 @@ static void process_one_client(int fd, int pipefd)
>  	do_getsockopts(&s, fd, ret, ret2);
>  	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)
>  		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64, s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - ret);
> +
> +	/* be nice when running on top of older kernel */
> +	if (s.pkt_stats_avail) {
> +		if (s.last_sample.mptcpi_bytes_sent != ret2)
> +			xerror("mptcpi_bytes_sent %" PRIu64 ", expect %" PRIu64,
> +			       s.last_sample.mptcpi_bytes_sent, ret2,
> +			       s.last_sample.mptcpi_bytes_sent - ret2);
> +		if (s.last_sample.mptcpi_bytes_received != ret)
> +			xerror("mptcpi_bytes_received %" PRIu64 ", expect %" PRIu64,
> +			       s.last_sample.mptcpi_bytes_received, ret,
> +			       s.last_sample.mptcpi_bytes_received - ret);
> +		if (s.last_sample.mptcpi_bytes_acked != ret)
> +			xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64,
> +			       s.last_sample.mptcpi_bytes_acked, ret2,
> +			       s.last_sample.mptcpi_bytes_acked - ret2);
> +	}
> +
>  	close(fd);
>  }
>  

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
