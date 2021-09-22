Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849C03FCB
	for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 18:00:39 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id h3so3539374pgb.7
        for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 11:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/E+ZaJAcGZZai2xg7IKnGdqCdVN4fWT167FC5R51m5o=;
        b=lISvdFb1HKDLHkCa6OJs1qTxWFQHWX6pa5mN74G9Uch6+uFqZEira4oXt/SczkuOyv
         feUErMfHjqzgu7VUAw4iZeLjSqpLUQrBpwdi9MAtG2qM+eMsvitEAIfC0a4lClX5i9F1
         UwN9LLSId3zHLCE+4SQBND5dv9HmEvndUwXWYdFDof9YAIDGpm7uqn/I+auVpE9eGsxc
         YAIcvAaITxs/xMkZT7iqBRLUSxnf4xPyyWKvazoKz0KwfSmXtD2nkF0BwamxIN0l4Txi
         Lx927o65ae02strOWTlwZNopyRoJJk+M9dTNKmuOn3ABO74oFRStECkr68Et3768rcp2
         Ihrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/E+ZaJAcGZZai2xg7IKnGdqCdVN4fWT167FC5R51m5o=;
        b=Z/+kvxuj2RBZxwR7T5malJ9S4W8GaONifmC4eP8LNxGLEGGqr62k7JoWt4P1Az9A6l
         XYVWA46ZIxroKb4OsiZ7Vz35hrF136k9PZsV08reLM7+BzlsRHUWiqZmvY/Uau3JM/dl
         i7bC4PeGlnB2JCNwMvNY1Q2deAAUDfRYzFLcCqUQr75Elwi0VD2Ixm6f2ZfZrsIqs7ru
         sDhyLat6On9kLSeKdlgkXhl0cn5aYw7Aap57JkvWUTB79kagAlhmcbi1ldejOJPfxmMy
         vuSHto2YQho6vo+bqoM3DjhD3EzFiFLB6nrcn2b4oWF8DHGlbDN/ZGGHDaFF4MfNfLvQ
         0dwQ==
X-Gm-Message-State: AOAM530o40qfASFMPd5VaTkBvk94yJqE2AYzHYUQYaiESoz0R/g5yfYC
	e+Cx5iOjvZvS7R6tngey9iIwz0s4dOc=
X-Google-Smtp-Source: ABdhPJwUkVp99pguDE5xZb5iTNztIvhZvfZ6P6cgfNqCfcUxUHf45oGeFt8Ja7482uRXhf8y93zVBw==
X-Received: by 2002:a63:a74e:: with SMTP id w14mr209741pgo.104.1632333639036;
        Wed, 22 Sep 2021 11:00:39 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-58.hsd1.ca.comcast.net. [73.241.150.58])
        by smtp.gmail.com with ESMTPSA id w18sm3168805pff.39.2021.09.22.11.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 11:00:38 -0700 (PDT)
Subject: Re: [PATCH net-next 3/4] tcp: make tcp_build_frag() static
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Eric Dumazet <edumazet@google.com>, mptcp@lists.linux.dev
References: <cover.1632318035.git.pabeni@redhat.com>
 <5e04e52a27a272a19d23162ea20ef62fd91c94b4.1632318035.git.pabeni@redhat.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <8c1c80c5-c802-78b1-a92f-480f5dfcacf6@gmail.com>
Date: Wed, 22 Sep 2021 11:00:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5e04e52a27a272a19d23162ea20ef62fd91c94b4.1632318035.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 9/22/21 10:26 AM, Paolo Abeni wrote:
> After the previous patch the mentioned helper is
> used only inside its compilation unit: let's make
> it static.
> 
> RFC -> v1:
>  - preserve the tcp_build_frag() helper (Eric)
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !
