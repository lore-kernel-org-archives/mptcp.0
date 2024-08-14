Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13EF1CD00
	for <mptcp@lists.linux.dev>; Wed, 14 Aug 2024 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601523; cv=none; b=gUJMTQok5oBtb5Q2hwAxIeF8+n2hd2sbl+qMJgJ6PN8w5FtiinOUVirtXUhF3zxQO8Pr4equ0LrLs2yiik4LbhpEYFPufUYfZR2rF6A00bEf54HHfq44j1jLady1BWoD5wKkt3TI9ZjRw2nHKK/UpWU7IIhjlO8rERQadE626hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601523; c=relaxed/simple;
	bh=qjWNxatVepm9lmO+9FgXCva7g5Nu5Dg8pKaKKJ0IaZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE+keru5zwvK/obBDWl70QIGFogcd5vhY/16npg6qoPiMdSeSiwQA53rdGcllKgrwwCqThANzGxMcQueGlsXzLMz7QpxXaSMTs2jV2pK+kppjBq4LM/34/kA6P3tCIB+4Jgp8sRwEyCh+hL4Xv0EwgOL5TAwZiKXgjJq0WParWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ii6ZGe+N; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii6ZGe+N"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-710dc3015bfso345786b3a.0
        for <mptcp@lists.linux.dev>; Tue, 13 Aug 2024 19:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723601521; x=1724206321; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wgQt2+VGAGY/RroWfxhoKY1UxciJC2B6QVwLu16mYH0=;
        b=ii6ZGe+NWRKFlEIP3GrDwn69cAVTp5ZeN/iFy5/2e2Q7UWwsOGLXAvxzNwWFoabHFi
         ug+0tWl+hm+cX929R0tjvXw6e9lqLJm3kOthQXWEA8/vDCqe8lT2WDuAfS1uvDmk2YAn
         +8JHUejfbe4izUAAmwXG3HCIvMsiUO70d8at5n23YpzjJ+GbVCKOdXF0q534h3L9yGVK
         eSmWjS+y/RGiPRcfOH8AboFMpoepbfaa2Mf69LERVarI2P7AkLazv8anFMR3QboIPZpX
         25erZD38pXd+tHJSsiLnW/cLtLmjOMJBMKn5QL2019zq0Rq72i3B0T6a+5PwB+XHB2ac
         D6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723601521; x=1724206321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgQt2+VGAGY/RroWfxhoKY1UxciJC2B6QVwLu16mYH0=;
        b=LiRq5bxOOq3ZHCAar2vV0y8Sv7y/Xljs89kxr2iUYe7/34CqhuLY/Nu3sfRY2ILiT7
         Wo9eIE16aY1Y4CvgGI7u+ZD7ePAQictuit+3fs+z2aKGdIKI0S09R7c1V51Ro1LyRiTt
         sV9u7jRXFWrBT+sXEk6jRokAm20jBZltdQv3w+iFPBD7qqelb21PUo6iSgpcR5NqJm+M
         rZreDcSg9imolQ/a7r969KBW7mIBawAzYFgURCGsql5M5RnW4r0TH6OEdyBduyLND9Xu
         3L2p8+xu7BSlpitEu++VC6YwU0U30J5fCbl2o2ziET1tphLU0Lr2BO6iEPeQ0qhP3mSQ
         W34Q==
X-Gm-Message-State: AOJu0YwUu3zMqplHhNZo+xD0fO/BJHfqRthcXzoPEvhQ9KwxXRBRb2gH
	ow0Vy76qbbLtIGrk10A2RyrA25oOwaUM5fxQcUW/qiMSRCREPUUi
X-Google-Smtp-Source: AGHT+IE+JEWKhfRkf5F4tu2TR4+I4T+y1Sh8oOhAQItB9Y0LNz4oM5JPDKC3DoLO2lBxGaMuMQmtkw==
X-Received: by 2002:a05:6a20:c889:b0:1c4:779b:fb02 with SMTP id adf61e73a8af0-1c8ee9c68fcmr1101408637.21.1723601520808;
        Tue, 13 Aug 2024 19:12:00 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58a99acsm6363636b3a.71.2024.08.13.19.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 19:12:00 -0700 (PDT)
Date: Wed, 14 Aug 2024 10:11:48 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mat Martineau <martineau@kernel.org>
Subject: Re: [PATCH net] selftests: net: lib: kill PIDs before del netns
Message-ID: <ZrwSZGj-BgJJADaG@Laptop-X1>
References: <20240813-upstream-net-20240813-selftests-net-lib-kill-v1-1-27b689b248b8@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813-upstream-net-20240813-selftests-net-lib-kill-v1-1-27b689b248b8@kernel.org>

On Tue, Aug 13, 2024 at 03:39:34PM +0200, Matthieu Baerts (NGI0) wrote:
> When deleting netns, it is possible to still have some tasks running,
> e.g. background tasks like tcpdump running in the background, not
> stopped because the test has been interrupted.
> 
> Before deleting the netns, it is then safer to kill all attached PIDs,
> if any. That should reduce some noises after the end of some tests, and
> help with the debugging of some issues. That's why this modification is
> seen as a "fix".
> 
> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
> Acked-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/lib.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index d0219032f773..8ee4489238ca 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -146,6 +146,7 @@ cleanup_ns()
>  
>  	for ns in "$@"; do
>  		[ -z "${ns}" ] && continue
> +		ip netns pids "${ns}" 2> /dev/null | xargs -r kill || true
>  		ip netns delete "${ns}" &> /dev/null || true
>  		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
>  			echo "Warn: Failed to remove namespace $ns"
> 
> ---
> base-commit: 58a63729c957621f1990c3494c702711188ca347
> change-id: 20240813-upstream-net-20240813-selftests-net-lib-kill-f7964a3a58fe
> 
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 

Thanks for the fix

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
