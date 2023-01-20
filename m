Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1EBD3F
	for <mptcp@lists.linux.dev>; Fri, 20 Jan 2023 09:54:56 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id ss4so12500106ejb.11
        for <mptcp@lists.linux.dev>; Fri, 20 Jan 2023 01:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zlmOE3LY+NnEssmKwDWE/zQ4siHapINLKqER/QeAebg=;
        b=EUDhje+Rbi6NLH3d3wOo2+Obi/fWd9Bh8AUKFcGQvfWznsaGcj1TKDD2LvnkbTFnMe
         bc7nCMIYF6IPTK17UnklPWLxdBn8hX1dr7l7vD+0IfchVGqigRfqbxpFYo+7aAMEXT9Q
         oM/JHxi7/EMrTYkp8dcFtdGEKf5PTVLBlHJK0h2D5CI4kHyc2jR7Qb/BNyqZMV6MUQ9b
         cVxgC88+gLuqcPeXoJerI/QOvB/4zxzWN4HLAfhg1GEwOsjSuPuH4vF2rme592k1h4fu
         pGSvef/Hj2tJaZxVKNq3r5zJxVckPmgYpM8jnpvSwYEi+WzMy6F2j/6XgbUulX/1J94y
         k1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zlmOE3LY+NnEssmKwDWE/zQ4siHapINLKqER/QeAebg=;
        b=Zkt4tLdYM6yeGYvGbQ56c7uwFNHAcAAS+lLERrijbiYxEzQu5xvxz3Xi4FBEch4eux
         TDQ32SL/w4YvTER7Ge0u6EMBCo1AJG46UaS3stmKG2Kdb5tSt16d5Ae3Fza0mEmHq6hY
         wR2Hor7963G9ShO9Dmn4seb7mL8wpsNK42hT0D+QK3o37bSqmcGPtFwu5gPv2fAv8ZL4
         tIK/D9CmZkj3RQGNuBcRh0fDsWpcuzTL/JOQ6dcXDCH7FKIdAyjdoN4QshpOuUNO0qdJ
         4XFgZLSm/pODGZIZZCZ5movSlfsIYHtA13+uGvdk8s6xDxo/3U5v8/CCa2RkawqxGMID
         F5aA==
X-Gm-Message-State: AFqh2kq+Y7MsQtXROFH5VRCVGEC7L9cgXRU68H0ahiB0z/ebS+Mukohz
	fFluPm0dB14c4axwUI8q1fLpY3Qo0iB+P81cm6E05Q==
X-Google-Smtp-Source: AMrXdXsgWvESRJ7+9BjTGQY2pDAsB/Szn+E47lmrnQdVoLdnE85Q6LtjBDDtYgr75iQyKl0KpBpPVQ==
X-Received: by 2002:a17:907:8a1d:b0:86f:950a:32ce with SMTP id sc29-20020a1709078a1d00b0086f950a32cemr18853003ejc.75.1674208494785;
        Fri, 20 Jan 2023 01:54:54 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id gh9-20020a170906e08900b0086f4b8f9e42sm7810194ejb.65.2023.01.20.01.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 01:54:54 -0800 (PST)
Message-ID: <702d73af-1306-2210-0e9f-af3f8bad6049@tessares.net>
Date: Fri, 20 Jan 2023 10:54:54 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mptcp-net] MAINTAINERS: Update MPTCP maintainer list and
 CREDITS
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
References: <20230119224411.24410-1-mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230119224411.24410-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 19/01/2023 23:44, Mat Martineau wrote:
> My responsibilities at Intel have changed, so I'm handing off exclusive
> MPTCP subsystem maintainer duties to Matthieu. It has been a privilege
> to see MPTCP through its initial upstreaming and first few years in the
> upstream kernel!

It has been a privilege to support you maintaining MPTCP!

Thank you for all the hard work you did to have MPTCP upstreamed! I hope
you will enjoy your new responsibilities!

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
