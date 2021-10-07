Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54F32C81
	for <mptcp@lists.linux.dev>; Thu,  7 Oct 2021 14:55:58 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id y12so10791650eda.4
        for <mptcp@lists.linux.dev>; Thu, 07 Oct 2021 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=o7Quirsiay+jYsHNX0/zvBb2r04HTt0GnRQQtnTodnA=;
        b=aEImpJ5+b07/JiUX++pNiuTTbxOfeBoiJ/AXtHgcy6QTrnqdtd1JAzqQiEuNQAL2Hx
         w4kNHgEza2dK5MuDOu2pQr7iD17f0nYhIEcmxri+UFXxmmbgPEbmE4pbJDIMIrQTZWNX
         OIQKcgX/yPoUmURcecaGGRl+YgqLUqLnpRU9+Gsza9tpLobdn77zVrYVKB150RRYqHpt
         TcTbMkSXxW9oDEKHb3DGYicGhcpbeJ/UPw4i5FrbPqFOoRmUiv+0BwVGhV6QvU1QRkoh
         X2VuA/6jMYC4NKzTeTwkhyltokOh3GXfW1OojKhBAKeZmCK1opMlN5JYb/lR4I4MUbKL
         WkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=o7Quirsiay+jYsHNX0/zvBb2r04HTt0GnRQQtnTodnA=;
        b=oEj5qx7iK9+l0llkQXsC8AYu1TEv/BKJszp92Kii9mbMoGzMlx4yLKjuAxu6Cg3wsg
         mSF90QtKpiNOnqAqPySa4CADqHb+oxmGTg6SoaLTCPUHc2QPj4Hx+pRLW1BGuLYwUgK4
         4gjCANweC3jpvtgg4pGP4gRE6yTFCj8NoYg/rWAXYd7QSkcMmRBJCf8eVcUh7kNo/sWv
         f3LkbWW4Cy2aRvDStZrP8CyRfP5ijM/dYxyhdX84SuwrEHFygNvl9QS7QfMUX3H8EmzV
         dvivCRmD3PtDf1K7WVGIp+YLHSI2pCRomsQxD1aq4oSJEHmAqDTp0irdAQHgQ3Ot1uzU
         7OTQ==
X-Gm-Message-State: AOAM531W/pLh49NlnRpUaxb0Ia9Crt9zbZ/6J4iezp80VA1/lQKCXIp1
	tSPeAOnEPtadTl+SUBD5Mul9JcWhYDlC7Q==
X-Google-Smtp-Source: ABdhPJzadwiamVViO5cFEVNNsCPnExDkPFlvSRpa4urNpoY0EDZq9XfunaY2u5wlJIz4GZzA/d8CzQ==
X-Received: by 2002:a17:906:2cc9:: with SMTP id r9mr6454292ejr.138.1633618557172;
        Thu, 07 Oct 2021 07:55:57 -0700 (PDT)
Received: from [192.168.178.46] (94.105.102.72.dyn.edpnet.net. [94.105.102.72])
        by smtp.gmail.com with ESMTPSA id e7sm9744652edv.39.2021.10.07.07.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 07:55:56 -0700 (PDT)
Message-ID: <4dd88f75-1671-69d1-fc85-ef7c18391273@tessares.net>
Date: Thu, 7 Oct 2021 16:55:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next] mptcp: Make mptcp_pm_nl_mp_prio_send_ack()
 static
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20211007000645.213221-1-mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211007000645.213221-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 07/10/2021 02:06, Mat Martineau wrote:
> This function is only used within pm_netlink.c now.

Good catch, thank you for the patch!

Do you think we need a "Fixes" tag? It looks like it has never been used
outside pm_netlink.c.

But maybe we don't want a "Fixes" tag because we don't want such patch
to be backported to stable? Or maybe we want to minimise the differences
by backporting "not risky" patches and ease future backports?

If we want one, I would suggest:

  Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
