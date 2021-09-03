Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330873FCD
	for <mptcp@lists.linux.dev>; Fri,  3 Sep 2021 11:28:37 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id jg16so8291228ejc.1
        for <mptcp@lists.linux.dev>; Fri, 03 Sep 2021 04:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AArP9OdI4FDKpsnauDTnk7rmjVF5sNaa+jzvm19y7TY=;
        b=ZvWTb0BhgOx0fO/nNIIXR2GG/uisVMXXpPAPof+dLNXl9BNlvk0KNCnllLupMIbp2X
         wC2sOhgo3ccff42jb0u2qqHQ1MLRQsE7DwcpKmm9dVqaMuOHa59x3FU3YDIHAcKIjE30
         7qni9klmPayugELhPJdHFHydy5EOSR5JCL57FYjkzglgtHT5VII5xNsfAeV2XNtb7wKH
         zvKCm40/3gsIWsI7u9nOLLQUKfAh703vGch6HiOxmLJZt2E4OajVVYtKvBbS7y5mEr6k
         WUsLywsFavFBYdNDNRoJyOB00J0rhQwAExeHLtX0mLiSUU7xy/Ja0FQAslV9l3AQnZLQ
         uL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AArP9OdI4FDKpsnauDTnk7rmjVF5sNaa+jzvm19y7TY=;
        b=WdHMgkML1eyApo8KsLcVfs9EMR5hLkiY/PY/shTSgkqu1E46ReezK+sqKJNjfG+DXA
         qkjVV8Uv0AAQGp5BvBKmJm7UQzhD+LMqXagGBDpo5OxiBReDO+kkhcY5rMF8q23QhILD
         PJXZorPyI6cYb8aDJy6byPXfbkXKF7Ms/Vel0tRDheqRKSb2BR6YrpKh5smtMtpyjIGi
         xa/XGhn/2v6DyvG4h6AyO/aC7mmbwk8uWDV5iq4OP6VUtF/rgkyhBo4RVb0RTG3GA4vB
         ja3XMEVIezPIPE71QfjdVH00wiYZrA1ac04ZelD6eVKrOhZ/zLOBkA5Tr5+4kYRtq+TK
         VxxA==
X-Gm-Message-State: AOAM5319KCzigHGD5lPZ30iwBA45+I72L0F4MuzYGWG99AchQjFIizXQ
	NSjVJBQi4e/dhZSXwCk85Hq7oDJ8pGb13Q==
X-Google-Smtp-Source: ABdhPJzg56KdZyErB2HxNV2RSM1TtWcJ/Z1otQPs5Rk2XJpayaI3o7TsAalluGjYGGLP619LqjOp+Q==
X-Received: by 2002:a17:906:12d8:: with SMTP id l24mr3774333ejb.126.1630668516118;
        Fri, 03 Sep 2021 04:28:36 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id s18sm2615162ejc.52.2021.09.03.04.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 04:28:35 -0700 (PDT)
Subject: Re: [PATCH v2 mptcp-next 2/4] mptcp: stop relaying on
 tcp_tx_skb_cache.
To: Paolo Abeni <pabeni@redhat.com>
References: <cover.1630595171.git.pabeni@redhat.com>
 <ae127a2e3d2fb31e6f1687cb96128d39490f6be0.1630595171.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <f01b372a-7145-3df4-6958-0eba522af05b@tessares.net>
Date: Fri, 3 Sep 2021 13:28:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ae127a2e3d2fb31e6f1687cb96128d39490f6be0.1630595171.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 02/09/2021 17:52, Paolo Abeni wrote:
> We want to revert the skb TX cache, but MPTCP is currently
> using it unconditionally.

One one small detail if you have to resend a new version: for the title,
s/relaying/relying/

  mptcp: stop relying on tcp_tx_skb_cache

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
