Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527A3FCB
	for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 17:59:34 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id 17so3539109pgp.4
        for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GhBgnSi2Lr9WzFotw0hevOMRnfvJcBKLLPZ2j+fhlrU=;
        b=QmCOXOIEvxjz8nTxorKfxdzyoOYK0FfhmJERTBLkT9M8BWHVnPZVSRg2oYXOLb1Wm9
         PuWary6cA/xQakqAdQPQ42ptvkT8IK4dUd3w4W8f23UiQbHfhZq464APLpQfTExgvl3E
         3u/J93Reu1GK+PhSIdNdVk964auhEqY0E2NHynt7zEfMJUKRpHglStnz3lvyaxL9LYme
         QoIkI9flkejMrsfwz7flSbtkVmIN1DvwtnaBu7rPqyLoAK0dCSPQPl+8lRKjlbbStQHa
         r3KGBpr6FPhLNQHujQYiPSUSMsXjLQsazD2oPjp58IY8IEF+1Z1bHz9jJmir3nkGXxyt
         7+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GhBgnSi2Lr9WzFotw0hevOMRnfvJcBKLLPZ2j+fhlrU=;
        b=n1ufd5B1p7TMNcmWZ51mGJO52IB7IjY7r64IB2DAs1nu7Yr4z/Kua+Hf0bF7e00B9L
         pp1diADtUD3vsKcqXzT+NvlanBLLlAQOB3llKeVyG9G0j5G9wBB/gLEW9dOnOSsJIdbu
         CYNvuKkytPZ/YNCDoyZRDEr753lNFffOTAVPmKVewd9nqmV9vrTRHh3TXXQd2zcE7k3b
         SthczYBkFBX3Yn5EdBPs6NbCtv4nqM9wAO+pUVT0kMjPvFP318AaZV1M0mRbq11wWY0p
         cy4To1pwetJHjGA2pHtP2akJgPbskEqsZ+PdhplCGXYF+AUxBKcxhnrUfqlRgspYbPfR
         CP2g==
X-Gm-Message-State: AOAM531189yQpTEBMXzeY3hjtMWWzTnW1PBIzHjUdAb5E3z3RzREi7tJ
	w6/FBUUmO47RUXST+0Yp2X6cDMmNTcY=
X-Google-Smtp-Source: ABdhPJyfvnWTFsWrjbx/qytEzysk2V8EfH3+3Ak19TFm+sLAuVkiffkFFlKYDkOrSOh9bBEiKdteSg==
X-Received: by 2002:a63:b046:: with SMTP id z6mr205719pgo.106.1632333572483;
        Wed, 22 Sep 2021 10:59:32 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-58.hsd1.ca.comcast.net. [73.241.150.58])
        by smtp.gmail.com with ESMTPSA id e7sm2998344pfv.158.2021.09.22.10.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 10:59:32 -0700 (PDT)
Subject: Re: [PATCH net-next 1/4] tcp: expose the tcp_mark_push() and
 tcp_skb_entail() helpers
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Eric Dumazet <edumazet@google.com>, mptcp@lists.linux.dev
References: <cover.1632318035.git.pabeni@redhat.com>
 <c7a97cc05d33a43991f5789469f254f78aa78ebf.1632318035.git.pabeni@redhat.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <80871d69-a8e1-16c6-4576-f07d624e5bd7@gmail.com>
Date: Wed, 22 Sep 2021 10:59:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c7a97cc05d33a43991f5789469f254f78aa78ebf.1632318035.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 9/22/21 10:26 AM, Paolo Abeni wrote:
> the tcp_skb_entail() helper is actually skb_entail(), renamed
> to provide proper scope.
> 
>     The two helper will be used by the next patch.
> 
> RFC -> v1:
>  - rename skb_entail to tcp_skb_entail (Eric)
> 
> Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

