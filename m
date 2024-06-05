Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C661C2E64C
	for <mptcp@lists.linux.dev>; Wed,  5 Jun 2024 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580652; cv=none; b=oC03NSdtKO1FjkAohWIEFvaHUtM57zXsk34eZqDaBkA2+ysExfaxD28Sd4bhMX/ct2q2ab0blPPKx4pWnb3i/Tk/lHwl8Wjqtj3oS3lVqdGrTBtQxqL6Vb5Di5mFchkHl1PKmWlU5tmBEMocOR5Fz4OEqLxFcEsL4exY2wafdn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580652; c=relaxed/simple;
	bh=7Bgdx7IqaGbveO1omriWFiC4m25biWloVy12Zy4BeMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLKFKvtvmGrcZb8iXSDgacZLfl6bmba2JgMVzlwWpwzuSng6yHjmClkZ8N09ul+GEkjR3Dqm39UIdbdGJ+t52H3+TNv4COq83qTdNFsfNkDUnJiNF7OAyGdR62AuHIuUJlnMSUJodBrmRQPUZHL/wrFLMee/R8ottOKGxTheGfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuidevWE; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuidevWE"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2508a32bb57so2587693fac.2
        for <mptcp@lists.linux.dev>; Wed, 05 Jun 2024 02:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717580650; x=1718185450; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gK79F04gd642egsqzJF+CSBzAbwsHZYo+7RIWwdUwAQ=;
        b=LuidevWEjUA+OrudRnQsoSJncXuigwAZKaSOgFCVXpWJ4thYS9wt3Io2Ku0XMVHGrt
         f2Qxoj3pOkpNz5Orv5HsUNpXXX8MxwbFca2LlnoYkBPZYBP5fFCxJN50bCcE0uEQmzzj
         Xl/MuK9RIzCyGRvFvxb0PVyUYsbzym8ovhwwf9Yes6nfpvQj8KWEIYJGkOZFHZAxgBUt
         wmSP1OUZ+GgP/MdF36FjwG2A7x0L8oOfytohNI6VMQ9TZqjKtVpkIsAbXlA1EHB8Cfqx
         9G12Zt6zhaA149RUBccj6tomfcfgF8dofo8UIiyhosPkxiH5Tt8Yk0745pZ9c+mrpxO3
         IVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717580650; x=1718185450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gK79F04gd642egsqzJF+CSBzAbwsHZYo+7RIWwdUwAQ=;
        b=JNL7eMZ7lQ+oDO74uJkNb4zFLVsUR8BfhjCSWi2fOu+P0jtWCacfBkuHtFsSicNjQD
         eLsdkqLEN4B/86bTIlC/ovtT54gJ9crjEbUyWsBirt+aHZ4oSD/7qZAGGliezwYURoZz
         MpbgaTtCAuu+FxCOIBbNqLB+Ni2M8ybZM2Dt0mtyc1KxDw5N1ZDqQv99CwEIi8K26ybk
         /8nanimP8KhD+nmWtgOc6H9sL4lkMP7v2saZ8DRPQ9Za5Qbbnh/JgGYZOFkTGxLuELX2
         AMkV2LAI60/eX5ivIqQAV3yIUggH8StTcJpJYUrDwBh6FFExaiRQCDSqLgIcrL/8GbQz
         802w==
X-Gm-Message-State: AOJu0Yy7F7gLy9BUN5wtHspwTrc2Pw9B+n4AGk0CXQxdQNPqhcX2GtiL
	COxqTjGMw8owTpyHbPDafGCFCCsoL57fIA7tfkkW6HF//FPD2zS4
X-Google-Smtp-Source: AGHT+IFaaRDnVhyOvSL7Tug0T39Td77AqPRbZu5+wRY+YQIvmBZMA+HYEQdgMdCZkXmHoAHJ9hatiQ==
X-Received: by 2002:a05:6870:5e14:b0:24c:b878:b515 with SMTP id 586e51a60fabf-2512208d4edmr2327156fac.49.1717580649622;
        Wed, 05 Jun 2024 02:44:09 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:782b:80e0:aaca:87fa:f402:cc0f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242aea177sm8288566b3a.110.2024.06.05.02.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 02:44:09 -0700 (PDT)
Date: Wed, 5 Jun 2024 17:44:03 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: Re: [PATCH net 1/3] selftests: net: lib: support errexit with
 busywait
Message-ID: <ZmAzY4eE9eaJ0IpE@Laptop-X1>
References: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-0-b3afadd368c9@kernel.org>
 <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-1-b3afadd368c9@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-1-b3afadd368c9@kernel.org>

On Wed, Jun 05, 2024 at 11:21:16AM +0200, Matthieu Baerts (NGI0) wrote:
> If errexit is enabled ('set -e'), loopy_wait -- or busywait and others
> using it -- will stop after the first failure.
> 
> Note that if the returned status of loopy_wait is checked, and even if
> errexit is enabled, Bash will not stop at the first error.
> 
> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")

Not sure if the fixes tag should be c5341bcc337c ("selftests: mlxsw: Add a
self-test for port-default priority"), so the fixes could be backported to
stable kernel for forwarding/lib.sh. Others looks good to me.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

> Cc: stable@vger.kernel.org
> Acked-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/lib.sh | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index edc030e81a46..a422e10d3d3a 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -67,9 +67,7 @@ loopy_wait()
>  	while true
>  	do
>  		local out
> -		out=$("$@")
> -		local ret=$?
> -		if ((!ret)); then
> +		if out=$("$@"); then
>  			echo -n "$out"
>  			return 0
>  		fi
> 
> -- 
> 2.43.0
> 
