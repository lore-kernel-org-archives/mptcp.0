Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907FC17580
	for <mptcp@lists.linux.dev>; Thu,  6 Jun 2024 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717640021; cv=none; b=X3jyBrjcMycI6dJ90X3VbKqsApxBrcDRJjkwN5z5Oz6lzttzYXruNehnReeMk1h/iPoF4IdaI6GSNUdRUnLCARWAxo5Yel8YKkCruZbtbDZK/5fe330hz/8Qs4xB0OGK52Vcgwvl/1Wf5O3/UnYQOImuYQaCw1iH/aCDX1cdEaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717640021; c=relaxed/simple;
	bh=dH5Lo1JA8dLCZsYd45JVwDzDzX4JrpI0pIOa2GxHYEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjNUH0hCW3TSTutl+nFpjeE2w4Pbw00JboWOu8vzix+Xuv3kE0rs7v4PAdDIY4yQPgy7gKFwG4U9WfFoOo4ckfa1mky6d/MPRIj8hy0enxJM5nbfKA6v3dZNscm2BDAmYuGLbRmb8RPx+9HbEecPl0lp1tCy3F87ZYyEUGIhe7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzQKnNQg; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzQKnNQg"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f64ecb1766so4210245ad.1
        for <mptcp@lists.linux.dev>; Wed, 05 Jun 2024 19:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717640020; x=1718244820; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fRVnmlsc7QNkh6mX1rqWyPONrK5lstvoABVQOrhbpTU=;
        b=PzQKnNQgBiHRcSE6mPTzqdFJjEp6cifBBfZbX+pRguthV3jimPhZKFQ8pUcr4wKFZ9
         elInQI3+FIYtCZZtfoqhbolDs+oD2RDwzI2NF+/vDUp+UvTGIsC+vZ0cPSN69Ib0VlxA
         gEIhTM3E5qAkC2pfc/TjqL/yuxPYzkT64pQ3j47NivrMAmpJyMSPMs57zmUv2/oene6C
         v1DAY/PGaoWm1WqoKk6NDGyqvgsnU38x/sm7lw+wiCIf9KjlCEnutcqQBqcD8Pz03O0J
         kSsMU4Ny9JI+icfZuidsaJUYjM7BOiDsrf6+rX9pkuUagPRxAZKMNBvsEzgcmKbxbNUA
         59WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717640020; x=1718244820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRVnmlsc7QNkh6mX1rqWyPONrK5lstvoABVQOrhbpTU=;
        b=jTAaecEXb1paty39/eJbItLyw+rlMCZJAubob5tf1JxvWhzKlbg1Kh8FOXvqb6WkIi
         DBqrn0GPT2JxkYqE9ecdt//HkbluiYThD10xVxu0pk7IlKcSQERqWhy1+shRa/OqtJs5
         lvOwZzZ5RDKGllJmQnSTxvsSqO9Sp8cJLoH45yMtQx+P7mBwXoRgLz/bsduRTUsGKdI4
         2Oquw+hwt93Q680JobPU22wMlb8QUAMmf8gDr5F4Zd/a6rBlYk1IKAYsq5yPljGGqLDT
         I+CTkc3/Y2bqvTO5yYeCmmoLnQXPZC0dhVeTfbkAmpqpONQ5G4CGPKug9pB24xljTwn4
         Q8HA==
X-Gm-Message-State: AOJu0YyZj3sbpnvM9WxyCg/lm9t6QvQRcuZBrlw00a2A/Nf9hQ4lSpa3
	TLexAKHOR1fNkwz72tGVlCn8wGb2cqmhCuQrVNBcQF47HjfR13BJ
X-Google-Smtp-Source: AGHT+IHNnmRW3asdFRMsFQH79iiIi8CETXvV5SMOdyD/clYI1911oYDaeGIPIpoRJH1VtdOoodH6lg==
X-Received: by 2002:a17:902:da87:b0:1f6:673c:ff2f with SMTP id d9443c01a7336-1f6a5a8785fmr47274225ad.68.1717640019818;
        Wed, 05 Jun 2024 19:13:39 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:782b:80e0:aaca:87fa:f402:cc0f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7ccfacsm2226765ad.167.2024.06.05.19.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 19:13:39 -0700 (PDT)
Date: Thu, 6 Jun 2024 10:13:34 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Geliang Tang <geliang@kernel.org>
Subject: Re: [PATCH net 3/3] selftests: net: lib: set 'i' as local
Message-ID: <ZmEbTvuUOGxc-quG@Laptop-X1>
References: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-0-b3afadd368c9@kernel.org>
 <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-3-b3afadd368c9@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-3-b3afadd368c9@kernel.org>

On Wed, Jun 05, 2024 at 11:21:18AM +0200, Matthieu Baerts (NGI0) wrote:
> Without this, the 'i' variable declared before could be overridden by
> accident, e.g.
> 
>   for i in "${@}"; do
>       __ksft_status_merge "${i}"  ## 'i' has been modified
>       foo "${i}"                  ## using 'i' with an unexpected value
>   done
> 
> After a quick look, it looks like 'i' is currently not used after having
> been modified in __ksft_status_merge(), but still, better be safe than
> sorry. I saw this while modifying the same file, not because I suspected
> an issue somewhere.
> 
> Fixes: 596c8819cb78 ("selftests: forwarding: Have RET track kselftest framework constants")
> Acked-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/lib.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index e2f51102d7e1..9155c914c064 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -27,6 +27,7 @@ __ksft_status_merge()
>  	local -A weights
>  	local weight=0
>  
> +	local i
>  	for i in "$@"; do
>  		weights[$i]=$((weight++))
>  	done
> 
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
