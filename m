Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8B5173
	for <mptcp@lists.linux.dev>; Tue, 18 Jan 2022 14:15:18 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id b13so80334896edn.0
        for <mptcp@lists.linux.dev>; Tue, 18 Jan 2022 06:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4rWLPTnXbE2POaIxrL2Z5zcQ3qFmA8nijPc5mGn6HE4=;
        b=UGx/4Iq4q2W+W6BHgnxe5MgWJz07RUgBTLr7/ddo5nxeBWJv/a2TvKd+C2BInLJE7I
         Gp3W7XmkoNV3D7a4YgFR7q+EwaE7YrrvABHl6i/GrlQlL+mlIOikxJM1nhJdG4hcFlW3
         tPGTLyRZddIcAmYwW4cSGdrwVSV9oLGTDW+gWPczXC/tBF9nncfRDRUmGhD7aUaFeurp
         AtIP5ZZQ2xsaJc6EhG2P1ZspVp1PJmEPQpBvT0cBkBXddmAXAQw6k71CKHELpdWfKjpu
         pl4oAue9mY49wO5OvN7cm+8O++HX5PrmiZD5520Er2Ahc7HGkw548qDaazEsZfVMAsjG
         qy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4rWLPTnXbE2POaIxrL2Z5zcQ3qFmA8nijPc5mGn6HE4=;
        b=CeaZd92zf/lzetcigzFTdiw/4BRt8sWbLvanreumFIg1uKoFnPK37Zm1d8H9/ha7ne
         svocmjfZILQPf2bXNYF1sJUVPUZboP1R0cSeNl0UEjf8r2ltJfZPLTgsSDG5MAkjr6Jt
         NkwsIKSfKpnTVjBlrn/iMRn32ul++7cVrJuF4g8NVWxMZimpFEqJS2IyYcFkxgJjfwo5
         +g0XazxR4EWP9yX5rVBKdTSPvtzVQpw7BSeAp01AupjkdYb71+YkSIMc74pi9wAxETrn
         Tvah1X5tfoiiC89ZHSLLKCXYH8fCX6mocgrIhE9LsZBNYtdmRoItvFCe1fvk4VzLOqFK
         XvPA==
X-Gm-Message-State: AOAM532aSI+1N6V4e3iCbg2Jf3N3A2huT6IErxNYH++ugPuVreX1w1Ox
	7shFscGDubIDqwdP3ALCvvNx0A==
X-Google-Smtp-Source: ABdhPJxe9kNHg5VPEyt/k7ZicoAoereSqaoEQI3Xu0651jywXVGfjWbsOi1Fhexj1TOuakvE1Ijiew==
X-Received: by 2002:a05:6402:14f:: with SMTP id s15mr25452077edu.118.1642515316578;
        Tue, 18 Jan 2022 06:15:16 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:bff9:791e:ed5a:bb3e? ([2a02:578:8593:1200:bff9:791e:ed5a:bb3e])
        by smtp.gmail.com with ESMTPSA id c1sm5380981ejf.92.2022.01.18.06.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 06:15:15 -0800 (PST)
Message-ID: <eb7a9238-6fda-761e-23e9-47fbe332705f@tessares.net>
Date: Tue, 18 Jan 2022 15:15:14 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v9 5/5] selftests: mptcp: add mp_fail testcases
Content-Language: en-GB
To: Davide Caratti <dcaratti@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
 Geliang Tang <geliang.tang@suse.com>
References: <cover.1641804767.git.geliang.tang@suse.com>
 <a0f7ec766ca99a5f2e2aa27a358f45fc06f6cc78.1641804767.git.geliang.tang@suse.com>
 <ea44a519-11b9-175-cceb-abb69232abbd@linux.intel.com>
 <a1679740-24ed-c788-46df-ad195068dd37@linux.intel.com>
 <CAKa-r6sgL1UUES5WYryNYedLJuq0_dEsO=X1263GFPOExci6BQ@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAKa-r6sgL1UUES5WYryNYedLJuq0_dEsO=X1263GFPOExci6BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Davide,

On 18/01/2022 14:32, Davide Caratti wrote:
> hello,
> 
> started looking at this, but the wild-guess is that the problem should
> be fixed with [1]: I'll do a quick test on my VM now.
> 
> [1] https://lore.kernel.org/netdev/20220110094750.236478-1-eric.dumazet@gmail.com/

Good point, it might be linked to that.

This commit is not in net-next yet, hence not in our tree ("export"
branch). I can easily add it there if needed.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
