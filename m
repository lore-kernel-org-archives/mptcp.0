Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA7C29CA
	for <mptcp@lists.linux.dev>; Thu, 27 Jan 2022 17:09:23 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id d10so7208696eje.10
        for <mptcp@lists.linux.dev>; Thu, 27 Jan 2022 09:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZPHRE+C/v2gNlL2a7HeYHesyem4JYDq+ldUsKhvfG1s=;
        b=IHyD5WRqTbUmmWI8+vLcD4Kp6ngG/OB8pKAAOgJJT1cqDAgmMAfMCxRRMAjkCmbCmK
         BGW8YA0lugwhkzVlFTO+ZBSANh7Rtbu1d9XfrtjZmy4gfSme3QuwU4TEleL/YwPSrcp5
         ZA/xcOCNd+GC4oEr2beUZ/SzDzx2NHWjjJ+L5hDd557MIIvVO3hsY77c1JOrxkVPCgzg
         fWznPX0556UbEpR11kbtVVLOavD+Dxs9DAkSv5y+PJdPT2u4by8g1fMtwxIu0jeB+px+
         XphWUOdxCfFgWr697LXR41+ykxk6Mk03fkb5J4J6wRut4+5OalmuFrReeeune1W/bJXT
         dCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZPHRE+C/v2gNlL2a7HeYHesyem4JYDq+ldUsKhvfG1s=;
        b=PojINeO5HvGehjNtqwojiXvgaRPKrijvIv+oVYUP/QwD+eqgb+hbKihogAkjaRxYk5
         /lDLMUGLNWxRnHR0VwOrxot6mPOaP6chn62kP5WEoWq6g+1OZhHQ3IY197LneX9fwROc
         MncWrOQ4GKYppFsr9/iNr8g0NvsMDXwOXtv7qxdx+A3L3KyaHkG1sbTUoWsCJLhSxXgY
         ZVciJSeJA3z7nL5LnpEbpl9F5NuIcQiYy8B2oDcQUPjK6U7jccWTCYb1nDjsJP+IpIlB
         kHU1A6WmvA4ltiF9O3lt3dQWytWcGKlAFNwUbdp2xFNq/d1/MdKwX2zTkfckG2wi9iTn
         7e/A==
X-Gm-Message-State: AOAM5334EirOgYXi+YOv0g5Vl5anPu/tWJtaPxcnvrcCILtA07RbQnO+
	HKQjYsIC1GWh/h3BJmyS34BIwg==
X-Google-Smtp-Source: ABdhPJw3UvX1SmRdPOm2ASisWcPsdzNnny+A9/yUDLRkyoFTSQ5UbF9BZr6ucKYXwfZqvt8dVzT5mw==
X-Received: by 2002:a17:906:b116:: with SMTP id u22mr3667402ejy.427.1643303361918;
        Thu, 27 Jan 2022 09:09:21 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:fe1f:d9d6:8db5:a255? ([2a02:578:8593:1200:fe1f:d9d6:8db5:a255])
        by smtp.gmail.com with ESMTPSA id c1sm8927832ejs.29.2022.01.27.09.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 09:09:21 -0800 (PST)
Message-ID: <1825f5e8-6d13-a317-4a96-f4a4fcf07409@tessares.net>
Date: Thu, 27 Jan 2022 18:09:20 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH net-next 3/3] net/smc: Fallback when handshake workqueue
 congested
Content-Language: en-GB
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <cover.1643284658.git.alibuda@linux.alibaba.com>
 <ed4781cde8e3b9812d4a46ce676294a812c80e8f.1643284658.git.alibuda@linux.alibaba.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ed4781cde8e3b9812d4a46ce676294a812c80e8f.1643284658.git.alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

(+cc MPTCP ML)

On 27/01/2022 13:08, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> This patch intends to provide a mechanism to allow automatic fallback to
> TCP according to the pressure of SMC handshake process. At present,
> frequent visits will cause the incoming connections to be backlogged in
> SMC handshake queue, raise the connections established time. Which is
> quite unacceptable for those applications who base on short lived
> connections.

(...)

> diff --git a/net/smc/Kconfig b/net/smc/Kconfig
> index 1ab3c5a..1903927 100644
> --- a/net/smc/Kconfig
> +++ b/net/smc/Kconfig
> @@ -19,3 +19,15 @@ config SMC_DIAG
>  	  smcss.
>  
>  	  if unsure, say Y.
> +
> +if MPTCP

After having read the code and the commit message, it is not clear to me
 why this new feature requires to have MPTCP enabled. May you share some
explanations about that please?

> +
> +config SMC_AUTO_FALLBACK
> +	bool "SMC: automatic fallback to TCP"
> +	default y
> +	help
> +	  Allow automatic fallback to TCP accroding to the pressure of SMC-R
> +	  handshake process.
> +
> +	  If that's not what you except or unsure, say N.
> +endif

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
