Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD062F25
	for <mptcp@lists.linux.dev>; Fri,  4 Feb 2022 18:17:39 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so13843559pju.2
        for <mptcp@lists.linux.dev>; Fri, 04 Feb 2022 10:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BfFZIQTRH2UUsr3td2AHbdYy6Sul28JyqcO6oZD6K/Y=;
        b=R8LlpGdQfsJpJ367KMkVW3O4NW2+lXtmKHm8fztzosq8QoOmY/h1A5bNXMAcrWd3IB
         /WWykBUYTThRQ0MlY+1xp0zxTMgNsKwCXi7UUYJRaJrXnc7gARUlm3GY9uNF21ciBXYz
         21URdcLsz0kGxhPEl2/qzOZgh+FPd0jB01YMZLjZh9gJ3AHl8T0ucFMkOWIlAvzVh+fT
         Y+Fg9Z2fjoYZOqu1m2MetZNS/ErTdb2XcvDjjzpz0mKHddvy3wzfO/Vs+9F7kIKloCeF
         efxYBtZMOmaZ91Wbcmyt7XGDV6GCE4ZZA2oXXDSA0agvXsUlf8CG+4oZz62L9saD2yZ9
         +9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BfFZIQTRH2UUsr3td2AHbdYy6Sul28JyqcO6oZD6K/Y=;
        b=uXAwfF/VWA8gjSa+1AXVmU5G0smCHPos6QeW4dUrXHZmHpH3E4cYnOWt60qHdwjPp2
         Eu8mZRfcjW+CQp/RY9wMfTWau06StxqdEaWrb9SD8WK4ceaTU5DuqdZ4IZM3+MycN8Vk
         KQWI1lr9mzjUz1szdDE2mEnXFdSS9AsSMKnAlSYs7iIQ/VyMa7yLrRMKZ+JXnfnEivFH
         YxKYndGnkOjkYeOl8r9XIcl1BOv5O60nuLZuR188c/34ih4xv6MzEN98oszOZcP6kFg5
         DaPkvRL69EoMOWF/02Tz8IhRMrQSeppwQaLk9Z36VMvWwVtJ3vaaSO7vk2fzl2TmrIf9
         yHRQ==
X-Gm-Message-State: AOAM533GB5+JwaZ8BasdlmyDwjsBudLNFOGjVHdSz92r1hypNdB7rlJQ
	Go5/UAXJCodvvBY4W1r9hcAPmQ==
X-Google-Smtp-Source: ABdhPJzkR7WtvFG7sjCXEhla5WRLWlR1KKgFyoXvDgI208wW4XYOiDs+2nlVVFcGgmRPEPvJEvSR7w==
X-Received: by 2002:a17:902:c215:: with SMTP id 21mr4306910pll.134.1643998658710;
        Fri, 04 Feb 2022 10:17:38 -0800 (PST)
Received: from hermes.local (204-195-112-199.wavecable.com. [204.195.112.199])
        by smtp.gmail.com with ESMTPSA id 8sm13328025pjs.39.2022.02.04.10.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 10:17:38 -0800 (PST)
Date: Fri, 4 Feb 2022 10:17:34 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Geliang Tang <geliang.tang@suse.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>, Mat Martineau
 <mathew.j.martineau@linux.intel.com>
Subject: Re: [PATCH iproute2-next] mptcp: add the fullmesh flag setting
 support
Message-ID: <20220204101734.1a560400@hermes.local>
In-Reply-To: <49c0f49f6aabf0f55a16034b79d30fbceb1bc997.1643945076.git.geliang.tang@suse.com>
References: <49c0f49f6aabf0f55a16034b79d30fbceb1bc997.1643945076.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Feb 2022 11:29:03 +0800
Geliang Tang <geliang.tang@suse.com> wrote:

> This patch added the fullmesh flag setting support, use it like this:
> 
>  ip mptcp endpoint change id 1 fullmesh
>  ip mptcp endpoint change id 1 nofullmesh
>  ip mptcp endpoint change id 1 backup fullmesh
>  ip mptcp endpoint change id 1 nobackup nofullmesh
> 
> Add the fullmesh flag check for the adding address, the fullmesh flag
> can't be used with the signal flag in that case.
> 
> Update the port keyword check for the setting flags, allow to use the
> port keyword with the non-signal flags. Don't allow to use the port
> keyword with the id number.
> 
> Update the usage of 'ip mptcp endpoint change', it can be used in two
> forms, using the address directly or the id number of the address:
> 
>  ip mptcp endpoint change id 1 fullmesh
>  ip mptcp endpoint change 10.0.2.1 fullmesh
>  ip mptcp endpoint change 10.0.2.1 port 10100 fullmesh
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

I don't see  any parts in here to show the flag settings?
