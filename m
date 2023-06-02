Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A51015BF
	for <mptcp@lists.linux.dev>; Fri,  2 Jun 2023 12:43:20 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f70597707eso72035e9.0
        for <mptcp@lists.linux.dev>; Fri, 02 Jun 2023 05:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685709798; x=1688301798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRXpWCFDEJuFO+sgap5Gq9jFXAcAG+6Y5CPTtnqvosQ=;
        b=HgyMQgDK0VLmj5VwU1m4cMsJeVTDKjrin1Y7NCOXW0eXEKwgB5b4vqFhkcv/NMlRi6
         TADoh1uh/dN7xMGNHNT8q/w4PdTGuaIWeCRjbkMDUOupFy8lAf3g12h79RDDmz9XsCb/
         /SBOunWu8t6rJIGuaiZUKMPGFsQDV24n9PfN0Cn6bC7vzy9x8PatddFxCY5OsnpOzRiZ
         wD8uiNY/fyDqwtPziz03ayQRYHBmGTBrlTL9/SLoGurtOb4JkLpoLmVGHL2XXy1SNjI0
         3tI2rP0VRRNMeXgsbIStgMVLNcm1NfvL4yIxF/pGiKRf1t1DwPiNC+VqFxg0vNOd4/VU
         +3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685709798; x=1688301798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRXpWCFDEJuFO+sgap5Gq9jFXAcAG+6Y5CPTtnqvosQ=;
        b=hAb8KrRcJ1Pa3G83miNQxIwqZ+VEQ2gOS5OfKywtti9WTokN17VsyzyQAdcdDpp3r7
         JQLEX37JdfG7+EEyQ4pVipFMit+s592W5LCvEmhPDttJEExsvS4xDX8/EyMS5EVqrVV+
         +O8siwySW9bvHiyPYnE9cojuXSKJPLtjuqrr5A3XEQL7ZhLzfnA0PK+Jdje0v2sGheGp
         Kh+slUvasYAtEP56SibD/54zsPlnGE2I2sUxuhWjhFijFOxohnQCxaLF85TOl8k1QPVc
         701qmTGVChcny2os3tmMZMGLtIL6Nfos439yJLy+d8oCWd/Kqo9OG8owjwH+VYo/Z3Fh
         RzCw==
X-Gm-Message-State: AC+VfDwmr6maJ9GOB3VHAusg2YOXEeAYxVj2Uyh6A3pARZl4GHPA0RZE
	JzMch3Zvo8RCDxnLWK4Ke8Z8RIsb1mHmOlfuo6uZrA==
X-Google-Smtp-Source: ACHHUZ71kbqY05Q45BEhjVeKEoDQw6BA+JYl5z60gPhCXFtqcUlevfebxuImf199eurulm8psbO/xNTo8DTU+jyynII=
X-Received: by 2002:a05:600c:3b97:b0:3f1:6839:74a1 with SMTP id
 n23-20020a05600c3b9700b003f1683974a1mr192782wms.6.1685709798352; Fri, 02 Jun
 2023 05:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230601-net-next-skip_print_link_becomes_ready-v1-1-7ff2b88dc9b8@tessares.net>
In-Reply-To: <20230601-net-next-skip_print_link_becomes_ready-v1-1-7ff2b88dc9b8@tessares.net>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 2 Jun 2023 14:43:06 +0200
Message-ID: <CANn89iKrpE7TVb8pTC+pWFDPJ2xcL3s9BhFB6DPxjK34he5RwQ@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: lower "link become ready"'s level message
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 2, 2023 at 11:36=E2=80=AFAM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> This following message is printed in the console each time a network
> device configured with an IPv6 addresses is ready to be used:
>
>   ADDRCONF(NETDEV_CHANGE): <iface>: link becomes ready
>
> When netns are being extensively used -- e.g. by re-creating netns' with
> veth to discuss with each others for testing purposes like mptcp_join.sh
> selftest does -- it generates a lot of messages like that: more than 700
> when executing mptcp_join.sh with the latest version.
>
> It looks like this message is not that helpful after all: maybe it can
> be used as a sign to know if there is something wrong, e.g. if a device
> is being regularly reconfigured by accident? But even then, there are
> better ways to monitor and diagnose such issues.
>
> When looking at commit 3c21edbd1137 ("[IPV6]: Defer IPv6 device
> initialization until the link becomes ready.") which introduces this new
> message, it seems it had been added to verify that the new feature was
> working as expected. It could have then used a lower level than "info"
> from the beginning but it was fine like that back then: 17 years ago.
>
> It seems then OK today to simply lower its level, similar to commit
> 7c62b8dd5ca8 ("net/ipv6: lower the level of "link is not ready" messages"=
)
> and as suggested by Mat [1], Stephen and David [2].
>
> Link: https://lore.kernel.org/mptcp/614e76ac-184e-c553-af72-084f792e60b0@=
kernel.org/T/ [1]
> Link: https://lore.kernel.org/netdev/68035bad-b53e-91cb-0e4a-007f27d62b05=
@tessares.net/T/ [2]
> Suggested-by: Mat Martineau <martineau@kernel.org>
> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> Suggested-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
