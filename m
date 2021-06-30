Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5F17F
	for <mptcp@lists.linux.dev>; Wed, 30 Jun 2021 13:20:07 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id l1so2034600wme.4
        for <mptcp@lists.linux.dev>; Wed, 30 Jun 2021 06:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zhaTOxwiv0G5pOoKD1haOhhYSHrm2ybALBhLQmjGz2o=;
        b=cLZC+U55FdGehnaXGYZ74WBciK5NY8a6KgcHwuVo5kdD9nnCl/cQpX+RDDCYYTJDoc
         mdwS7hXiQ6iXdflU8/mSQUU8JuOfC8TJM7vlGiuKon5Wm5SlilMT92wjf3lmWo4aQYWY
         2E6Nmst1nG3piBQVJfNlymXdhHfquYETcm6asNw1PSdyz0c+8OGDT9ky4u3IKAWuTNBR
         hUIgoC/HkevTl/zup/wNtZlDcxrIuqsmWqY3fLJk6J2oSTTe+d9yEZlgWmDQoek/xyfq
         0u7YqFo1LtCuH+BDgG/mOvNWKd9GFjC7j1iiJMO2ueJlvG/zQky0NZ+AV2Mcj7qL4IvT
         QuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zhaTOxwiv0G5pOoKD1haOhhYSHrm2ybALBhLQmjGz2o=;
        b=Yp1EcTg3l4IhEFQVFC181qUzTA6KOZ7AiW3hZpn5cVH8nqaJPwWxoU5M6yiK2tVS6X
         4O/AJ+GF0rmXrCw33wJv+w7IFZ0ixugNdm6n6QeNJhNQO89Rh0XOAaegHIjNHno/DKRF
         IBnHjIW48dPQ9gctz4kDtreuI81mXAwQ2pEodBORlA3Ax7n4nTub4KWyljH1bKHlS/2M
         XeG1oSegyzZDHB+pnfUL9PH0gxq1O96OQSVpow3MdNRr9Prhmjwm5VddH518NQttlnB7
         ujJ58v0z0rUuiYdgHOQ950J66P7PyRl6bGYIc8jtKhoksdXGaHG7WLX/qsFbc9y2E2Ei
         EmZQ==
X-Gm-Message-State: AOAM532K724mnnzL3weBavaWfegyMw7CAdXIy3RjrpLqel0X3a49q3ct
	0ey5R9NpBYqIPB3cz7JsX+iac691zoc=
X-Google-Smtp-Source: ABdhPJyXjbPjcO7ISDSJx3gWb6XKmaF94FzVUMS/hIJNmE8pUho63dsIJ2Qd/nbGcGFDyZDQRVo4vQ==
X-Received: by 2002:a7b:c092:: with SMTP id r18mr15918234wmh.181.1625059206010;
        Wed, 30 Jun 2021 06:20:06 -0700 (PDT)
Received: from [192.168.98.98] (80.17.23.93.rev.sfr.net. [93.23.17.80])
        by smtp.gmail.com with ESMTPSA id n8sm21903934wrt.95.2021.06.30.06.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 06:20:05 -0700 (PDT)
Subject: Re: [PATCH net] tcp: consistently disable header prediction for mptcp
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Davide Caratti <dcaratti@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
References: <7f941e06e6434902ea4a0a572392f65cd2745447.1625053058.git.pabeni@redhat.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <4638ad50-5495-aad2-86e9-8e89273a74a8@gmail.com>
Date: Wed, 30 Jun 2021 15:20:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7f941e06e6434902ea4a0a572392f65cd2745447.1625053058.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 6/30/21 1:42 PM, Paolo Abeni wrote:
> The MPTCP receive path is hooked only into the TCP slow-path.
> The DSS presence allows plain MPTCP traffic to hit that
> consistently.
> 
> Since commit e1ff9e82e2ea ("net: mptcp: improve fallback to TCP"),
> when an MPTCP socket falls back to TCP, it can hit the TCP receive
> fast-path, and delay or stop triggering the event notification.
> 
> Address the issue explicitly disabling the header prediction
> for MPTCP sockets.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/200
> Fixes: e1ff9e82e2ea ("net: mptcp: improve fallback to TCP")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---

SGTM, thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>

