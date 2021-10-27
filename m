Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C022C82
	for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 19:06:35 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id g10so14322703edj.1
        for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 12:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=b6c767dc+TOs8a9R9Vpfb0rpekUiDNJQTMbnPAATLzk=;
        b=MtxlYL4869fnznWou5R/IVme35jies+vYQWeHQfkjCEkSUMOsSCzWRfdVjVMqcI6Dj
         69//0cJG16cMBAT2sgHjE1MfoO7VaHBTL3/e1yZiyRACh/7wkVVp+TAwZJgNaDB/1fdX
         1irYHSVe6gmuG2eL2j0XrkbXsEmklbPrxyHNVN0Zk1saXEPNBiNY02ZlNZBk4AmR+ZOv
         6isOJvyyosoG3vZafkf0TiOZTvL8B3ytP9pnTE6uh1erygggfGDSCD5HDVur7y+RBOho
         S50OfBJUeakGyZOIIWDN+0QJLWH1MlB1v9vGlI52qyGEwhYfzlw+n3gUkEINDy5Ew1EY
         LBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b6c767dc+TOs8a9R9Vpfb0rpekUiDNJQTMbnPAATLzk=;
        b=LtammFaUS3PYVDCbKbqIfzzZKnbv4ETyWqYMFnca46rAyy2kJEznHsUGSxBoVOxRkT
         4Id6aSJoHbXN4AQdN/1SZBSTBILTBcSq2DLfL11hkLAtDm1j7w/LMukzoo1uwwIwfbn5
         CFolTmg05hgE/VpqGZgj30NXdUGgI30lLByEjKdsRBmtRpTvcYb/shMTjDxtdzgHcztr
         l0SrR+xJ4zUeyz/i6dlt+n0hJF5wBx9CtMU+abS42eCRQOsxOt2NxLJaCjgPb2iAM2Xb
         dvehJ95Ts622uRmKrZBCXUOrbim5id2ISmzKoJVtMyJ4DzjXzNFrMvPE1rKYCqUL0/wV
         kK4w==
X-Gm-Message-State: AOAM530FZUPBS+/kjv7awS4dR+V9Fr1OKHbDWqlEp4ZicGV9Lqgmv9QJ
	H2DhxknGJfWKT61/OvStfMyTGQ==
X-Google-Smtp-Source: ABdhPJzmyT7j2FUekWk32rv4wO0xeHOCqhfjLC9WFG6t3pZRUXM0oEa4reZD9OkP3IJiTn33+i4lLA==
X-Received: by 2002:a50:d841:: with SMTP id v1mr46530633edj.221.1635361593973;
        Wed, 27 Oct 2021 12:06:33 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id oz11sm360144ejc.72.2021.10.27.12.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 12:06:33 -0700 (PDT)
Message-ID: <feac89ea-42f0-1822-7780-666a9a838cf4@tessares.net>
Date: Wed, 27 Oct 2021 21:06:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-net v2] mptcp: fix corrupt receiver key in MPC +
 data + checksum
Content-Language: en-GB
To: Davide Caratti <dcaratti@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: psonparo@redhat.com, mptcp@lists.linux.dev,
 Paolo Abeni <pabeni@redhat.com>
References: <0ad4620ed5034e9267e579f71c060b312b3e2eee.1635258393.git.dcaratti@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <0ad4620ed5034e9267e579f71c060b312b3e2eee.1635258393.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Davide, Mat,

On 26/10/2021 16:27, Davide Caratti wrote:
> using packetdrill it's possible to observe that the receiver key contains
> random values when clients transmit MP_CAPABLE with data and checksum (as
> specified in RFC8684 §3.1). Fix the layout of mptcp_out_options, to avoid
> using the skb extension copy when writing the MP_CAPABLE sub-option.

Thank you for the patch and the review (sorry, I missed Mat's replies...)

Now in our tree (fixes for -net):

- 9ed907a911bc: mptcp: fix corrupt receiver key in MPC + data + checksum
- Results: 379d8f879e9a..0c31fd9a8970

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211027T190543
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
