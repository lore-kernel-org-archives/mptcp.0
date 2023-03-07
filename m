Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42EAD49
	for <mptcp@lists.linux.dev>; Tue,  7 Mar 2023 16:28:24 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id j2so12713288wrh.9
        for <mptcp@lists.linux.dev>; Tue, 07 Mar 2023 08:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678206502;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YbPa9NG6YZ+6QFSJKdFt+Rlg+w9tRCHbY5XzPDlPPVY=;
        b=F+fCv/gHSf8u1C7ESUH96fd8d0s0sxtiK7dLqrj2VbgXfSBgECE4ucI0dWBdMTg/Bm
         3KmszNnK0uieKHJweegKLYgU3mULOO46HYdixVdvc2DpByn9bs4iiFKW9qNrJ+qUZbJn
         yvu0zXKGFmteV3zOtDPfNJmDZfWxMxdAahoTDioy42c2/MvJDoV8PyGclyOtt+OxSgUH
         IcCtEXR+zJ1lKPpBs6MF6lUiG2l+WVbIaNlXIig+iRgwCHD5H1zfTlNwvSBQxmg1j6LO
         hcOM72ZBg3SMA9ppLu154vyL1TLKZ3nA/9VQmA7yc/otms2IQdhqwlMfBTg4kdeIUiYu
         83Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678206502;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbPa9NG6YZ+6QFSJKdFt+Rlg+w9tRCHbY5XzPDlPPVY=;
        b=AXUTIj1qCUSA2X9roOUrUf+ML/Pbdr6Big0atmhdX85dsGcZu1bA9U5p4K3z7DSQkS
         auHlCz34nwoDNSdmT+/FZY9o3eyZzeenJes+fKK1NsBQxU+2CUUuTL/AWYLHt3kGWuiS
         a1xfC8qWXPBmn+jiaGQxEaFGCXLM/D7RxHzoR9OXSEillw2XeehxBAjUTLzV9kQoGkW8
         C/K3vO+n1iCAO0LqEGSXfvuWHToEyKaX/syW1pc6xLXSQnP/Wv6PXSjruNCC2Qb/ujKf
         DAUafvI4N51tkfLclSU4cfJkXQusWOamIeql1aFNGsaIEXBUx1WkWsObfNf51hcWitix
         oZUQ==
X-Gm-Message-State: AO0yUKXkd01od/2z3aPbb6KwvaGqVsbsS7CW9PrL9udD+MBz5i0+M1zq
	vPlil2/eYS0KlXGBqMJSfKX5nA==
X-Google-Smtp-Source: AK7set9RD7OanAcBPYD0KMUJdQfTvUYbvWwT4aNvOJ3TpFAzAYFVNb1s4YpGa+LxJ6z33FUmHRjhjw==
X-Received: by 2002:a5d:6310:0:b0:2c7:84e:1cfa with SMTP id i16-20020a5d6310000000b002c7084e1cfamr8909985wru.40.1678206502420;
        Tue, 07 Mar 2023 08:28:22 -0800 (PST)
Received: from [192.168.3.222] ([213.211.148.158])
        by smtp.gmail.com with ESMTPSA id z4-20020a056000110400b002ce3b31753fsm12023718wrw.26.2023.03.07.08.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 08:28:22 -0800 (PST)
Message-ID: <6178db74-0816-a53c-e339-89e5ca401fce@tessares.net>
Date: Tue, 7 Mar 2023 17:28:21 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-next 1/2] mptcp: avoid unneeded address copy
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1678122760.git.pabeni@redhat.com>
 <e341fae478d52cb3233e56496aa1d331e40d7073.1678122760.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <e341fae478d52cb3233e56496aa1d331e40d7073.1678122760.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for this patch!

On 06/03/2023 19:30, Paolo Abeni wrote:
> In the syn_recv fallback path, the msk is unused. We can skip
> setting the socket address.

Should this go to -net with a Fixes tag?

Or not needed, not to have to delay the next patch?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
