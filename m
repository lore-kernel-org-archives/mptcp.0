Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEA16E
	for <mptcp@lists.linux.dev>; Fri, 19 Mar 2021 19:08:43 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id u9so11421112ejj.7
        for <mptcp@lists.linux.dev>; Fri, 19 Mar 2021 12:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oQmQSS60x65z6dWBIVnjzdQBp74/xdyS/baf8xqTOg8=;
        b=BPNm2fv9LQTjwZtcDwgbOS626Q+CvkD8ZVslZjs4D5t3BaWmnNvHMtvLF1BGHS0EVm
         WHqQM7hmn2+wJqXewrkUf/vjFHL6Ir3DO3HETn6/oBzni0T9rJkUlEtO4wseK3wCAsOl
         OefVbEiobJEPSp9KAmp8SdkaPOnr3mSHFco5fH3G/KQUW08LZJzY64CXy09r0CS7tc43
         8uYiJkfPwN5RWl6ea4mcT7Z9fq3XNkV7WRqz/+YZXtN0tMu8OLlpSkGMpsI1egsGLx16
         RdwPtAPca4Rqkta3HZRlPLqkl1z8iusNWtilXhfxnF1WK2mjFsecnxrpC5HFBNfx42Rt
         omDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oQmQSS60x65z6dWBIVnjzdQBp74/xdyS/baf8xqTOg8=;
        b=e0/2CaTcNsPfK8ZebID37N9M1KxH54pfxj6EDqbXn8fEDudyoCB1vqcwbPacqTE+K4
         CPDMwyrNFtetHqzo42wjotqpomnabwVPGEO/miRB5qeqyU/hD6n5bPT6bakQ2MaqccG7
         poRIm/xAFD8TblBgb1IgEPT+OSGls3kq/E/vRTXO2//sBrNnJPKZgaaV7hWPrOnac810
         G6igpRhhcnbFzHXMK2s8botOHDCVqGqcoZ9iEWx3PDGHt7+0C/b38WoQZYycPKVC2p3m
         VrCn3xHoO+ad9NNYmhwADX9GFIj6lfx1Tz0Q7HEkfrkafJwNwtkKPt53Tw8JkhBUcVPg
         n4EQ==
X-Gm-Message-State: AOAM5324ZTxYEgQ5GriCwmV+hH3UKC7eBrgbjORE8PfwjT8hO2Dl/ira
	G33dMSuVH2vH6Iv7wh07yRUjYoruMkxv6w==
X-Google-Smtp-Source: ABdhPJzWS2Oi5G5CdkXBVohcpYMv4dzZY/i/Ecl5ydSp5NeXM4ANqpsCRkulBV93ajqSy980nqu7BA==
X-Received: by 2002:a17:906:8147:: with SMTP id z7mr5930344ejw.436.1616180921711;
        Fri, 19 Mar 2021 12:08:41 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:9d6d:4da8:8a04:dafa])
        by smtp.gmail.com with ESMTPSA id sb4sm4186625ejb.71.2021.03.19.12.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 12:08:41 -0700 (PDT)
Subject: Re: [PATCH net] mptcp: Change mailing list address
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, mptcp@lists.01.org,
 mptcp@lists.linux.dev
References: <20210319183302.137063-1-mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <0ef86230-bb2b-a35c-3bd9-341d2e7de133@tessares.net>
Date: Fri, 19 Mar 2021 20:08:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210319183302.137063-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Mat,

On 19/03/2021 19:33, Mat Martineau wrote:
> The mailing list for MPTCP maintenance has moved to the
> kernel.org-supported mptcp@lists.linux.dev address.
> 
> Complete, combined archives for both lists are now hosted at
> https://lore.kernel.org/mptcp
> 
> Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the patch!

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
