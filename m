Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B3828E4
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 19:29:02 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id j15so17248197eje.9
        for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 12:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=vlGhf+BGHD6EEvDXNwBIfG2gH3nONKLTHHORlNo4unU=;
        b=JJpRki0Oe3D78lQ0Aecx1ssKXrMKHHUqM/leKcVrKFBQDDOsb/5RVEvbJRcohRdHQe
         eLQPLe2PRMDIjLVT/DDuOYsMoEVkr3cSGDDqWeHPOTIFzkkgGqR7iv/95DmGrwBML0HJ
         A1YW4lcBjXGShBFJQIimmf3Qk1gxSpYxLTlg+1zZb+FoLLwblehm9kQ1K2Iz20TyrSwD
         U8dDj0H14kLENHFN8Blr6Rw8e6NoQnruKBj7anKX8JZzkT4zyy7vsVr7fSDJIhrLI1QY
         xtxgrPK/GAzvyLYneYa5lWghCerHJRNEfcRcVgBk3aiItzXTm9RnlV0rdoUQtILWt5Y8
         2PMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vlGhf+BGHD6EEvDXNwBIfG2gH3nONKLTHHORlNo4unU=;
        b=a0z0tOLX9oyWNr41RUc0mo356YkmAjIxVexKeWudlb94gSzz1Q3PPoRR2OFNLSqgoX
         mvbso1Rh7LYN2mVQ83dHFcPHSDiDuTFw1WUMDSUMggThUQ/0mcImfTnb/YaF1P8NuFgo
         bhfC8VSMKzP//MsPjiOAnwegfJfhgLOiP7mTdEfQL7sHq0AA8nikSaHUhDRyDGik9Irq
         yB/pF0TvMk+WyPUn/9taHeFiJfZ9U8D2I+sIN3tJC7TJEED3sBmvKb+Zfhw67vTX2xBF
         clQUVnvaM76jPOA/MnbgYapfUjw/p4N6+6f+q4GGHJcMj9m/KUVWLFrd6OKXwxHzR04F
         nHrA==
X-Gm-Message-State: AOAM532scgkHT5diDq2jzIqlnzWCmA/zt9U81jgX0lGNY1WPxt2BnHE6
	fyZ4zB8AhpN3awUKzuDnWimdpIi+r/yiglHT
X-Google-Smtp-Source: ABdhPJzdzhbMvGzQuKnQ9lujiTxOa47Q8GZsitClzLrCr4Iqx4kSxxFpJXjFbm9ZViLJqi41X2uZ/Q==
X-Received: by 2002:a17:906:6693:b0:6cf:3cb:89c9 with SMTP id z19-20020a170906669300b006cf03cb89c9mr13716301ejo.23.1648236540854;
        Fri, 25 Mar 2022 12:29:00 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:2d7e:bb45:3614:8dd9? ([2a02:578:8593:1200:2d7e:bb45:3614:8dd9])
        by smtp.gmail.com with ESMTPSA id v2-20020a509d02000000b00412d53177a6sm3293749ede.20.2022.03.25.12.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 12:29:00 -0700 (PDT)
Message-ID: <ee1770c6-f849-0a1e-043b-9738bb12090b@tessares.net>
Date: Fri, 25 Mar 2022 20:28:59 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next v13 2/5] Squash to "selftests: bpf: add MPTCP
 test base"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1648202310.git.geliang.tang@suse.com>
 <ad72e534750a7839349cb6a83ccb33eb722aac26.1648202310.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ad72e534750a7839349cb6a83ccb33eb722aac26.1648202310.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/03/2022 11:10, Geliang Tang wrote:
> fix libbpf 0.8 build break:
> 
> prog_tests/mptcp.c:176:2: error: 'bpf_prog_load_xattr' is deprecated: libbpf v0.8+: use bpf_object__open() and bpf_object__load() instead [-Werror=deprecated-declarations]
> 
> Some cleanups.

Thank you for the update!

> @@ -45,49 +41,64 @@ static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_mptcp)
>  static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
>  {
>  	int client_fd, prog_fd, map_fd, err;
> +	struct bpf_program *prog;
>  	struct bpf_object *obj;
>  	struct bpf_map *map;
>  
> -	struct bpf_prog_load_attr attr = {
> -		.prog_type = BPF_PROG_TYPE_SOCK_OPS,
> -		.file = "./mptcp.o",
> -		.expected_attach_type = BPF_CGROUP_SOCK_OPS,
> -	};
> +	obj = bpf_object__open("./mptcp.o");
> +	if (libbpf_get_error(obj))
> +		return -EIO;
>  
> -	err = bpf_prog_load_xattr(&attr, &obj, &prog_fd);
> -	if (err) {
> -		log_err("Failed to load BPF object");
> -		return -1;
> +	err = bpf_object__load(obj);
> +	if (CHECK_FAIL(err))

I think it would be nice to add specific messages for each errors but if
it is done like in other BPF selftests and it is fine for BTF
maintainers, fine for me because at the end, these errors you would get
here and below will not be linked to MPTCP code.

> +		goto out;
> +
> +	prog = bpf_object__find_program_by_name(obj, "_sockops");
> +	if (CHECK_FAIL(!prog)) {
> +		err = -EIO;
> +		goto out;
> +	}
> +
> +	prog_fd = bpf_program__fd(prog);
> +	if (CHECK_FAIL(prog_fd < 0)) {
> +		err = -EIO;
> +		goto out;
> +	}
> +
> +	map = bpf_object__find_map_by_name(obj, "socket_storage_map");
> +	if (CHECK_FAIL(!map)) {
> +		err = -EIO;
> +		goto out;
>  	}
>  
> -	map = bpf_object__next_map(obj, NULL);
>  	map_fd = bpf_map__fd(map);
> +	if (CHECK_FAIL(map_fd < 0)) {
> +		err = -EIO;
> +		goto out;
> +	}
>  
>  	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
> -	if (err) {
> -		log_err("Failed to attach BPF program");
> -		goto close_bpf_object;
> -	}
> +	if (CHECK_FAIL(err))
> +		goto out;
>  
>  	client_fd = is_mptcp ? connect_to_mptcp_fd(server_fd, 0) :
>  			       connect_to_fd(server_fd, 0);
>  	if (client_fd < 0) {
> -		err = -1;
> -		goto close_client_fd;
> +		err = -EIO;
> +		goto out;
>  	}
>  
>  	err += is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", 1) :
>  			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
>  
> -close_client_fd:
>  	close(client_fd);
>  
> -close_bpf_object:
> +out:
>  	bpf_object__close(obj);
>  	return err;
>  }
>  
> -void test_mptcp(void)
> +void test_base(void)
>  {
>  	int server_fd, cgroup_fd;
>  
So:

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>

@Mat: OK for you? :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
