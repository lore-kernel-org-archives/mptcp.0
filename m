Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB9B7B
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 14:48:59 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id c20so3154772edr.8
        for <mptcp@lists.linux.dev>; Wed, 09 Mar 2022 06:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=tL1ieTiWjIkI0LrVqyFuh0esRAvg8BWHoJ5+16MjAp8=;
        b=pze5vpFDf4rCqYivSYgoIbfRUqk1bjVhc2mymzC5/wsfidrk1DIDcde3bZJ8EJRGlC
         HbwZ1LjFRMwqwY1EGtuwqdP+MIwTHdgOcmPQcqeoRbVRAQt9Y/xA6bZnI0QNo91aXzJF
         6iDoXiqYJER35/3Cz24Akhh6xCoaBkspDjTNM7Cr/6v2Ve52VcnYdLn/vkHGAa0u8vgi
         mz878e39ONJbvtHF+OAnbdByt6igEQEYPLCKnBKudEm78LzefZP2vMDn5cKUWQPLdMHK
         75xkQalhdH6zUw1tIiDNBbWxTougm/4pEbL1PlN10DPa54B1xtxjSJVGNW/FFCV4zkWk
         UkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tL1ieTiWjIkI0LrVqyFuh0esRAvg8BWHoJ5+16MjAp8=;
        b=KteOnRFEOyiFjmNbJ3pHM6cuUMoXtj8QdzhMnyhvvAyVioJPqMpaWZRc6NMZzOtsfe
         aLzi41rr9KzDY6zZkezG2hsa06PSXu41k/zdxSCXgWfYb09GlP/HqJzBy6ZdK7CTdRSY
         Wbx6zr7NSiyHsh+kYyuqwIFoZp2kFwVeznc9seTHDanl+j0P07ia4RtG/HSOf/nqwGeR
         VBwp8tojujecFFXO4HYcuPL0EOcfbwhQcVNgy4LiAjPV9ZDEWyRQolODVISlXtZhqZRd
         Bael5Ua33sQw9uJsokxu6yvEqAmEoAJx/z/OoLFsNmE1YfX1ipDTELbZVaVWbjoZd8Er
         EYgg==
X-Gm-Message-State: AOAM5314lpMHMyujuxXSDP9pCKibNIM291o1+UQU36mZv4qf5kSOkIWD
	TanN+HeaOnzHoxUjN+s4HUEx1pddtfizfCaR
X-Google-Smtp-Source: ABdhPJxeFDU1yCeRKJNDLgMfNOfIAbJHGF/HRAUsLuqnp0nDRPL/l/HmggI72wD+cfZtX5MHdKANjg==
X-Received: by 2002:a05:6402:4316:b0:416:6770:11de with SMTP id m22-20020a056402431600b00416677011demr9405681edc.316.1646837337340;
        Wed, 09 Mar 2022 06:48:57 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:97a3:de20:f4e3:f1b? ([2a02:578:8593:1200:97a3:de20:f4e3:f1b])
        by smtp.gmail.com with ESMTPSA id k23-20020a1709062a5700b006ccd8fdc300sm802459eje.180.2022.03.09.06.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 06:48:56 -0800 (PST)
Message-ID: <a28fe12f-261e-82dd-8b0d-bd66cffb3524@tessares.net>
Date: Wed, 9 Mar 2022 15:48:55 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next v10 0/5] add add skc_to_mptcp_sock
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1646796538.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1646796538.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 09/03/2022 04:35, Geliang Tang wrote:
> v10:
>  - merge the squash-to patch.
>  - update patch 3 as Matt suggested.
>  - add sync() in get_msk_token() before read().
>  - add a comment for get_msk_token().
>  - update subjects and commit logs.

Thank you for this new version! It looks good to me!

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>

I'm looking at rebuilding the TopGit tree. I will apply this just after.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
