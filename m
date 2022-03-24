Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20A67E
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 17:05:06 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id r23so6408687edb.0
        for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 10:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=aDIf7xktDLd/MJBWarDkivA9rTcdtF14N7SNEXf4fw4=;
        b=Vgu5XNfGwI51VVvyjI3swqr5Z7l14/bH+pc20QRYzIYQE97f6LRc5neYezcKyg2hqI
         kg0F0o9kFUF1jKjF9DxB8zT8qTEoChL6Ebjhj1WTJ6JrEYDqkcd0LR+2LjIpUio0HcB3
         Bzcn2bZJw+QpjgkcmYDjJ5nYKue+JTQ9RarJzoW2NH7/2v/rIZyQlsjjCgghnHnv/Bfa
         00fiZKZ1/fPg923zrScULVvjDTNc8vyVBaSxQS1kWF8kdpRFOAcllbIHWoZWxIEdnVyz
         FfHEMteSFj6ii8beHQOcvMYzb+PL346Xm74ZIhFYucqe9tUWgvqIeuMW4JC/3vlft4Ri
         wUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aDIf7xktDLd/MJBWarDkivA9rTcdtF14N7SNEXf4fw4=;
        b=fMwB2+o4jYJ2TaWqMhCx+3T+vPqhFwiU5HstRnvNR1oRTBFdFaEZTCI7AajV/Y9gRH
         APxc+uGdzPnfxSzAR+4xfy8ecwzdDcrxrwz4N829vP2k/jACEAUyKMYT3Phz8KGLkUGx
         TW028JnsXWdiNL2+OhmIH6Ua9RUEFwWTIPQ+hEcq2awF5jULNH9d4GiChISWJjhq/vzK
         PNM7MeLVwkXe3fnIRI2j5YipxAgUDHPZy7GTQ81K6y1419UoT9SkK/jDHmS61QpUtNSH
         /+IgNvdkEMcHqiKXcj+F8ti6E23QNdeamAkFqUnnNfJ6b4OwZX+lDCOafkZf835f+MNW
         GyaQ==
X-Gm-Message-State: AOAM533B1fQeLxPjtXXFbvSC3p5rNYMilU/orJ6ApLTqbemTa7Rkq8jT
	5Zsfrcxt6v3E7///aPliIt2UF6HWYdJm3dHz
X-Google-Smtp-Source: ABdhPJxOY33lsyjfGFDgmsJt39L3WDHgc06bf63xWYAReaBcDCBARqM6/OuCgCK3Sw5GJzAYEhCDog==
X-Received: by 2002:a05:6402:11d4:b0:419:5a50:75a4 with SMTP id j20-20020a05640211d400b004195a5075a4mr7905742edw.226.1648141504542;
        Thu, 24 Mar 2022 10:05:04 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ec2:fe0:d538:762b? ([2a02:578:8593:1200:ec2:fe0:d538:762b])
        by smtp.gmail.com with ESMTPSA id bx5-20020a0564020b4500b00418fca53406sm1622210edb.27.2022.03.24.10.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 10:05:04 -0700 (PDT)
Message-ID: <36294a41-8c56-0e96-8ee2-675945fb177b@tessares.net>
Date: Thu, 24 Mar 2022 18:05:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next v12 2/5] Squash to "selftests: bpf: add MPTCP
 test base"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1648128255.git.geliang.tang@suse.com>
 <3fca1327933734f25222c16e4fb5c473630e91ec.1648128255.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <3fca1327933734f25222c16e4fb5c473630e91ec.1648128255.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for this new version!

On 24/03/2022 14:28, Geliang Tang wrote:
> fix libbpf 0.8 build break:
> 
> prog_tests/mptcp.c:176:2: error: 'bpf_prog_load_xattr' is deprecated: libbpf v0.8+: use bpf_object__open() and bpf_object__load() instead [-Werror=deprecated-declarations]

These modifications seem good but while updating this test to sync with
what has done upstream recently, maybe it would also be good to use
macros that seem to be used in many places now, WDYT?
Please see below:

(...)

> @@ -44,28 +40,46 @@ static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_mptcp)
>  
>  static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
>  {
> -	int client_fd, prog_fd, map_fd, err;
> +	int client_fd, prog_fd, map_fd;
> +	const char *file = "./mptcp.o";
> +	struct bpf_program *prog;
>  	struct bpf_object *obj;
>  	struct bpf_map *map;
> +	int err = 0;
>  
> -	struct bpf_prog_load_attr attr = {
> -		.prog_type = BPF_PROG_TYPE_SOCK_OPS,
> -		.file = "./mptcp.o",
> -		.expected_attach_type = BPF_CGROUP_SOCK_OPS,
> -	};
> +	obj = bpf_object__open(file);

Does bpf_object__open() not take two parameters?

> +	if (libbpf_get_error(obj))

I was surprised not to see a check 'obj != NULL', e.g.

  if (!ASSERT_OK_PTR(obj, "bpf_obj_open"))

like it is done in some other selftests but I see in other selftests
they use libbpf_get_error() like here.

I guess that's fine but I don't find a proper doc explaining what to use
here :)

I would still recommend to use ASSERT_OK_PTR(), at least to have a clear
error message.


> +		return -1;
>  
> -	err = bpf_prog_load_xattr(&attr, &obj, &prog_fd);
> +	err = bpf_object__load(obj);
>  	if (err) {

Should you use ASSERT*() and CHECK() macros to include the 'log_err()'
below?

  if (!ASSERT_OK(err, "bpf_obj_load")) {

In 2020, these macro were not common but it looks like there are more
and more used now, e.g. check commit 186d1a86003d ("selftests/bpf:
Remove all the uses of deprecated bpf_prog_load_xattr()")

>  		log_err("Failed to load BPF object");
> -		return -1;
> +		err = -1;

I see some selftests returning "-EIO", maybe better here?
(same below)

> +		goto close_bpf_object;
>  	}
>  
> +	prog = bpf_object__next_program(obj, NULL);

It seems more common to use bpf_object__find_program_by_name() just in
case a new program is added later I guess. But maybe fine now?

> +	if (!prog) {> +		log_err("Failed to get BPF program");

Maybe good to use:

  CHECK(!prog, "find_prog", "mptcp prog not found\n")

> +		err = -1;
> +		goto close_bpf_object;
> +	}
> +
> +	prog_fd = bpf_program__fd(prog);
> +
>  	map = bpf_object__next_map(obj, NULL);

Similar here: maybe better to use bpf_object__find_map_by_name()?

> +	if (!map) {> +		log_err("Failed to get BPF map");

Maybe good to use CHECK() here?

> +		err = -1;
> +		goto close_bpf_object;
> +	}
> +
>  	map_fd = bpf_map__fd(map);
>  
>  	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
>  	if (err) {
>  		log_err("Failed to attach BPF program");

And use CHECK() here as well?

> +		err = -1;

'err' should already be != 0 here. Do you need to set it explicitly to -1?


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
