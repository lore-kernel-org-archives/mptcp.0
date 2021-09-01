Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15F672
	for <mptcp@lists.linux.dev>; Wed,  1 Sep 2021 17:19:11 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id e21so577569ejz.12
        for <mptcp@lists.linux.dev>; Wed, 01 Sep 2021 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eq5Vg9W6sGnKD0EHXOKdtWvtTSLKbCF83MIL/W3N0fU=;
        b=YeoowJ1oD0AjxPC6rG4kVaDATZ6L6f1Uu9+fQHYmZvaxopiEX0msbU4g2f1thzcAPJ
         pJ+uxSRA4/Qx/98p5QMlxR1ZlIMrC4T3GsCu7oYMoKASgapJKV/PsUJqjQeU3cNf+VRU
         NnB4EJ5ekxKrWLXTffsOsZIfSkqSxZTUc8TE/nmLApwyGRxtjubZNATA5p7wGBDzSLjk
         sny9vLJuySz89yYy1vTFfS+CIrvxF9rd85+doxOf6EvhPr4lHVImkWOChd2Xm4HsK3zf
         Fl+oIrtA98NS+xXGFvKTnzUbTmctbOYz7A5CeZ9QW3AGekL+8bzYnviROo67/ManK7Fb
         dTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eq5Vg9W6sGnKD0EHXOKdtWvtTSLKbCF83MIL/W3N0fU=;
        b=lX4A7v1tqgtkTY/WtsZF8l8zx546REbJaeLq1RBUzW7hnYlbOefux5wBn+5bPgFNZS
         MWz90gJhs1VOqjb18nZVBBRrHSK3X1BhQvhdEkn069a8cZh5gogLa4q3iEt0IqpKJ12l
         3ymLncSa6voyOCjNNTZU2/pQuBmFpfEfWL0ahcEr3lYqLfy3WaAhdkVf6YfUG8RpjECO
         J2ByXB74/4IQknG7ILEvOg2+QlsXe4m360DQHOIw/oQsw6b0Te/bwtGKeZEvsCteNU4Q
         xm2zLlEXy3ycVGMaZngNe7eTI22UR1eHWjRFJucaCGpwUsEQ76pFXLiVRLGDkGqZgi9r
         iU1g==
X-Gm-Message-State: AOAM533SaalbalvNEO5+qONR9UQnTbDJ7WBlz5bhwAdncsY8xVR04SbC
	0MMwsB9AW2bF/uRl5rtSVGPJ5g==
X-Google-Smtp-Source: ABdhPJxrn2jcdQJQWWys1OBFPMojsRHsQIMzMyxT2gE1rBQzIXFiQ2XH/8zNlPl2qw+w3A4uqyR3qA==
X-Received: by 2002:a17:906:9b1:: with SMTP id q17mr561718eje.546.1630516750184;
        Wed, 01 Sep 2021 10:19:10 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id p18sm156845edu.86.2021.09.01.10.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 10:19:09 -0700 (PDT)
Subject: Re: [PATCH net v2 0/2] mptcp: Prevent tcp_push() crash and selftest
 temp file buildup
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, mptcp@lists.linux.dev,
 Mat Martineau <mathew.j.martineau@linux.intel.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <20210831171926.80920-1-mathew.j.martineau@linux.intel.com>
 <b9fa6f74-e0b6-0f61-fc5a-954137db1314@tessares.net>
 <20210901101613.50a11581@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <146f94a7-77e8-ced9-fcb3-adc2d33ff0aa@tessares.net>
Date: Wed, 1 Sep 2021 19:19:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210901101613.50a11581@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 01/09/2021 19:16, Jakub Kicinski wrote:
> On Wed, 1 Sep 2021 18:09:52 +0200 Matthieu Baerts wrote:
>> Git auto-resolves conflicts. Is it why it is considered as "Not
>> Applicable" or did we miss something else?
> 
> We don't enable 3-way merges for patches applied from the list, usually.

Thank you for your reply, we didn't know that, that's clearer!

>> Do we just need to resend these patches after a rebase?
> 
> Yes please.

Just did, thank you!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
