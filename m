Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B00F7E
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 15:16:28 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id l14-20020a05600c1d0e00b003c6ecc94285so959132wms.1
        for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 08:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8mbyz005k1ZCB0lm92YQ3sRD1pQLUKEAM6sS32v9xA=;
        b=c+3bVrBXYN4nrzsuDgmO2S8ltukeYMIfhDpvuO6yVJ0KxthTuANe4qDgs5yE/VtpAc
         T05OIoBGLS3C9dwTHlAkX+w05LkaSRsRF4CmHszCSuFoyKxTfpwDxM3dBJdFVWEc+2T9
         oe+nC6MjolXYnHB1I6aZzuSqt+yGA7+I4TxZXtBfKAgsu0fT2fG2ka2Fqj2BxWFypV1W
         io51YJRoXwW2haEiE+V0ALoFtPJBkoh9oZ7pO6q5wqg8YoNfgHRaw2V54RrHIY+f70rW
         UFkDSL1mp4qXGt9A1huaDbtwvjKxcbPM2DRzToEGOKXrjq46hUEqEmr80OoGOaAAVtnI
         DJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8mbyz005k1ZCB0lm92YQ3sRD1pQLUKEAM6sS32v9xA=;
        b=IeV9AylhlHA0cVSWTkjm/k21YEizmC2uFmb3aLJJpdqp3JJsQAu5AWJK0DN3JIkge1
         cv85rSt1CUtg9Mke6vIqzwqdLbUe6RBYT1HWANiiDKE444iaBkbfg8+gRD8cEMyUR0fA
         JAw0JPgRy3vaesZv+mvMcC3TWd8gxTi4rtQvJtPRBtIk/fe6Lp7NB0OrJXRbq10v+hML
         XeRj5kupgPPoDzcEehij6mygYfPABzW0pHhrg0mgLPKiGRx2zytumdLmE9FqFmEGhhEZ
         LnKnBjgqH7kYORxcOqLnkrsANrbpaTTkqlDWmZZim6cQV06+WK2H0rwnGkZJBRl9crBE
         YQCg==
X-Gm-Message-State: ACrzQf2wazmlJy490VnBv7YbXJ7FLILJZWEN6jAw0IFbzVHP2OceJXLV
	5ICjz86Z7K3xYDagoeuldsPjrQ==
X-Google-Smtp-Source: AMsMyM48se/OCyFP0vQ3MGzScXKz6W2eWWxuP1+zMUJDQ6tL6hFXXW18pp53YabhfymcZUiMtrWXVw==
X-Received: by 2002:a05:600c:15cc:b0:3c6:6ff5:21b8 with SMTP id v12-20020a05600c15cc00b003c66ff521b8mr5929774wmf.55.1666192586471;
        Wed, 19 Oct 2022 08:16:26 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:3000:72c0:ef02:f180? ([2a02:578:8593:1200:3000:72c0:ef02:f180])
        by smtp.gmail.com with ESMTPSA id u10-20020a5d468a000000b0021badf3cb26sm16757337wrq.63.2022.10.19.08.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 08:16:26 -0700 (PDT)
Message-ID: <9ec8db28-8b61-ce53-f247-b7ab7de7d5d6@tessares.net>
Date: Wed, 19 Oct 2022 17:16:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next 1/2] net: introduce and use custom sockopt socket
 flag
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 mptcp@lists.linux.dev, David Ahern <dsahern@kernel.org>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <cover.1666173045.git.pabeni@redhat.com>
 <b9ca7b78bec42047bc9935be2697328c7b71b391.1666173045.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b9ca7b78bec42047bc9935be2697328c7b71b391.1666173045.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 19/10/2022 12:02, Paolo Abeni wrote:
> We will soon introduce custom setsockopt for UDP sockets, too.
> Instead of doing even more complex arbitrary checks inside
> sock_use_custom_sol_socket(), add a new socket flag and set it
> for the relevant socket types (currently only MPTCP).

Good idea, it is clearer and it looks good to me!

For the modifications in MPTCP:

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
