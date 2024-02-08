Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DDA6BFC5
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386849; cv=none; b=ag9AwvehqvIuYaFLutVwdWQTzdU/uvdMvMTKiQjdaxjfkoaLaIHEJdOgaSnAb1m3+zpMoG7l8D82UxvfsOx0JP7Wqxd3MRxQin7kHdnshI5QobqgTlzsdkuoNNMrzF6igxerlt8nNOdsIRQesQsSmvUnAR6IulXi6da+qIVMYXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386849; c=relaxed/simple;
	bh=jB9/BC0KMkISJGJGxdjiwmcbZeYiwh1v7CGd7yKWecE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJeq9r0dwrMgLiCdikH3JJ5wy9AbWQ3Aq/EdwuLkAlWAZM1+g4WSlh1pSdxD04cf+5/df6g3x61h7d7EhtmtJ1zKeEsMpsWtaZHfxXwVMuBPtUTvGyV/+fBbD2Q+fPBGI8EOgRytVuN/aXgD1M80jPscllV+Kf2CqGZteowGFqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7kktOOf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7kktOOf"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a38271c0bd5so213467566b.0
        for <mptcp@lists.linux.dev>; Thu, 08 Feb 2024 02:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707386845; x=1707991645; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o8fb+YvBsdVcnnHkzFxUln74tRjF4QqHKhCUF3xZSnA=;
        b=F7kktOOfpwRNXPKMoeWSLKvGGZexzyDmVqzPSGq+7yRwMHeNPY5D72jQyfkBCkEVnC
         upfAIjggred7AI6I5x+6YqDxXkrEr6x9r5sbwTKGllaS9IXFAUX4VqytlIj/Lxic/xBt
         lstkhUrinEm9hfNP+Y5yGYNHWBPw8GAD+rvLwQ5LngTE5lP32NcgHviyhhOIc0BqkJ07
         0dppyJJjhzcaamjq+FN2o0/+h8hyE0BoLpWebwYTN1Cl6T9hT6hkcY6SMzFPUu3heFAm
         Q4pk7atxozCF4ypy90Gn8OiqiVBDghEWTKkxz3qSzffpzvkC+7LyZW7vCB1V4BQUIdV4
         OyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386845; x=1707991645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8fb+YvBsdVcnnHkzFxUln74tRjF4QqHKhCUF3xZSnA=;
        b=bf+KWiu3ypw2uWON1ZCzIUGGHOrTQy1DB9yMkkxmVO7YyKDj1LCM1l+vtNyHTgC796
         f+KgWrCOY81Zomb6B3DJMBznp1fEfvb1gwifU2NujrDK6Ygmjatk12d2i1WHyDm4wa6+
         B/4mIiFjvzWQ7qCE/w2mvBiEuqBqpWdlQtv/WzaO/mW3+u2/3TAGpgSsgiOsceknIhE2
         SYHWHD/cqnytRaPRgcVP4gDgf2kp5L8906V7SpnSLKQG9/Dd+oZhZAxcJvwngqOabnjb
         wJqf2OX87yt45d5apEhGlIClXpBAjKHMpP6b+ze3JdVp103ovhUUSywZoFzn/xMYaC3q
         mqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiDqdN/4zXKmYCBOehyy1in6VSYBIkI1SJta/o83C1yhkhqXlTTVYSnLtE35+6tqMDa99x+JGs3wY+vV0hdd+VOY4EhGs=
X-Gm-Message-State: AOJu0Yzq0v6nxKL1vjgQZz9lU+qZzlgcRHugtCeApz1NfdxX4hoR3VWH
	P+wThdmh72y6Wi9DWBhfJAla5XAfrA/RCOHbZNgIwn5g2cEtWz0g
X-Google-Smtp-Source: AGHT+IG3YEfJvenvjYmPoz9ZAmBu+ajib2nUKE9CVt+jzDQyS5/dC4bSLRRLFeOxvF07b0Lv9X9cCg==
X-Received: by 2002:a17:906:5291:b0:a31:7dc1:c7c1 with SMTP id c17-20020a170906529100b00a317dc1c7c1mr6092311ejm.65.1707386845409;
        Thu, 08 Feb 2024 02:07:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDrjgrvUu/tIXuK8aQIZVYawKnPek0WndjeQ5aWBgAFoUaMf/pel+v5gbQHA/xz/XmW98cvcVhEpWBvdQX8tuOXuAngA6T6C5K3mkmTxdttBKHX8DsSXqH/UXJRXEVS2sy4YSkJNLFvxWYVa8IyNxA/mtopsZvb1k16AxWtJOAZHB20tceHw5ritC3gZyPyzu6GU/LBD6yHZhBSzJeQocJC2TE6no4DudJFHbKORXgXYW7oFN1AvDKZumt6MQ4RsAl/mJpBwlDADAMBISHwcpyA11Jde/xPtPUc2jKdli0MJPlk+KTCsrHE1kcBux4zafP/f1c7v63Ap26inwZ0/BM3pTzlo+P7MSZqiPe0H63wdW/vEMnMgKU3I5xx1mS5Qpr0au7rLygeuvi1f4m5qGrXmOefQFDYwyeYcJA/a0nXtKNygjtqIFgQkIdPEeh/+YO3MQ=
Received: from krava ([144.178.231.99])
        by smtp.gmail.com with ESMTPSA id vb9-20020a170907d04900b00a3891fb4c0esm1231657ejc.107.2024.02.08.02.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:07:25 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 8 Feb 2024 11:07:23 +0100
To: Geliang Tang <geliang@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH bpf-next v5 2/3] bpf, btf: Add check_btf_kconfigs helper
Message-ID: <ZcSn24Isfsg45jBJ@krava>
References: <cover.1707373307.git.tanggeliang@kylinos.cn>
 <fa5537fc55f1e4d0bfd686598c81b7ab9dbd82b7.1707373307.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa5537fc55f1e4d0bfd686598c81b7ab9dbd82b7.1707373307.git.tanggeliang@kylinos.cn>

On Thu, Feb 08, 2024 at 02:24:22PM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch extracts duplicate code on error path when btf_get_module_btf()
> returns NULL from the functions __register_btf_kfunc_id_set() and
> register_btf_id_dtor_kfuncs() into a new helper named check_btf_kconfigs()
> to check CONFIG_DEBUG_INFO_BTF and CONFIG_DEBUG_INFO_BTF_MODULES in it.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  kernel/bpf/btf.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 16eb937eca46..e318df7f0071 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7738,6 +7738,17 @@ static struct btf *btf_get_module_btf(const struct module *module)
>  	return btf;
>  }
>  
> +static int check_btf_kconfigs(const struct module *module)
> +{
> +	if (!module && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
> +		pr_err("missing vmlinux BTF, cannot register kfuncs\n");
> +		return -ENOENT;
> +	}
> +	if (module && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
> +		pr_warn("missing module BTF, cannot register kfuncs\n");
> +	return 0;
> +}
> +
>  BPF_CALL_4(bpf_btf_find_by_name_kind, char *, name, int, name_sz, u32, kind, int, flags)
>  {
>  	struct btf *btf = NULL;
> @@ -8098,15 +8109,8 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
>  	int ret, i;
>  
>  	btf = btf_get_module_btf(kset->owner);
> -	if (!btf) {
> -		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
> -			pr_err("missing vmlinux BTF, cannot register kfuncs\n");
> -			return -ENOENT;
> -		}
> -		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
> -			pr_warn("missing module BTF, cannot register kfuncs\n");
> -		return 0;
> -	}
> +	if (!btf)
> +		return check_btf_kconfigs(kset->owner);
>  	if (IS_ERR(btf))
>  		return PTR_ERR(btf);
>  
> @@ -8214,15 +8218,8 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
>  	int ret;
>  
>  	btf = btf_get_module_btf(owner);
> -	if (!btf) {
> -		if (!owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
> -			pr_err("missing vmlinux BTF, cannot register dtor kfuncs\n");
> -			return -ENOENT;
> -		}
> -		if (owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
> -			pr_warn("missing module BTF, cannot register dtor kfuncs\n");

nit, we do lose the 'dtor' from the message but I think it's ok,
for the patchset:

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> -		return 0;
> -	}
> +	if (!btf)
> +		return check_btf_kconfigs(owner);
>  	if (IS_ERR(btf))
>  		return PTR_ERR(btf);
>  
> -- 
> 2.40.1
> 
