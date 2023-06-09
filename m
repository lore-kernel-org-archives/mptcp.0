Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0814317741
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 13:59:31 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5151934a4e3so2750301a12.1
        for <mptcp@lists.linux.dev>; Fri, 09 Jun 2023 06:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686319170; x=1688911170;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/vvSs7JMvACMBUHgQcTFv60ikQ1sCFCwCe7aHgV1+Ig=;
        b=vR+vQhaxHY5xkskYIrcipmtUeqRFbsmxiPMaSiA3OmAp7Abg1aacWa27rip2XDasTL
         9XhNop86mLfruAUAUU+aS+22BpjSHXUD8pQjAjgy6pz8CEAZlWpUIpwkj6n5AtJvT0q/
         eR6M4SMuqwYUuS5Bec3pdh874vkDgS8EE1ywYMFU7WPu1FMso/GCTJqixlT+Uk7FQUoc
         3T4SEyDHnzmR+EJM5zjI2Wyh0MbJhJXMCOmKiWAm3i0Nlt5HX3022qbJwYdpxJYSB1io
         KW7LzutTEdLaGVWB3YPt8Q+5ndiG2IkVumz3wytPoJhfOAO3/vYz9QzPcCRZLD3cR8SA
         dT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319170; x=1688911170;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vvSs7JMvACMBUHgQcTFv60ikQ1sCFCwCe7aHgV1+Ig=;
        b=eoAarKQxw0lcIQ9jLKqtBubok6wrZfEw63vL/3Rtus+cKCmMx3IzJVLkm3HKg/uAxF
         ktdg1dk0D4I7YApJmL6YD6Um90bx7o4rG8T9Qt5xslslxjBdtnY8xEkgKV1GYM5emXXy
         pVUl0SG5JhX5SzfFVeltP6NpALbk6BKE8Tg80f4qZwRu6vdInKS+LTia/AWkk+7Q6cNf
         YCFNfU8quaOCoPtiSe0ar+TdXGtSn3hGD0V335mDi6/TdZpTD7Xj1jEhZB82EenKn9ve
         mK2f4ghm51fAFNs+zr3bgFPLTE1ebmLRgO4bRioDJzrN+FmTKRa74W+gXcMH2cQKxcqJ
         2sKg==
X-Gm-Message-State: AC+VfDwqcM+Fk1YMIxX1S5VWygESwgUcbJpI2rSs//t76guyh7JAOvK+
	qvNTamqUtFe85TkYBZfhwX6OhqJKilDI4pgfaJMpBw==
X-Google-Smtp-Source: ACHHUZ6kAu3JaM0beAf1ljrXwjHLtua7z6CuPzJwA9GYZKmwGHJ3QMi3yHVr2q69Xm20gUIPF71IjQ==
X-Received: by 2002:a17:907:31ce:b0:957:2d2a:e8a2 with SMTP id xf14-20020a17090731ce00b009572d2ae8a2mr1726291ejb.27.1686319169850;
        Fri, 09 Jun 2023 06:59:29 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id f16-20020a170906825000b0096ace550467sm1330958ejx.176.2023.06.09.06.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 06:59:29 -0700 (PDT)
Message-ID: <4996caaa-dce1-bf57-e224-2496b8231be0@tessares.net>
Date: Fri, 9 Jun 2023 15:59:29 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next] mptcp: consolidate transition to TCP_CLOSE in
 mptcp_do_fastclose()
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <ca4ee22bcb340d3c07778259ce6c08b4d39e89d0.1686155634.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ca4ee22bcb340d3c07778259ce6c08b4d39e89d0.1686155634.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 07/06/2023 18:34, Paolo Abeni wrote:
> The MPTCP code always set the msk state to TCP_CLOSE before
> calling performing the fast-close. Move such state transition in
> mptcp_do_fastclose() to avoid some code duplication.

Good idea! Looks good to me.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
