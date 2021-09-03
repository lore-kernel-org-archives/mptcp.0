Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CABF72
	for <mptcp@lists.linux.dev>; Fri,  3 Sep 2021 17:47:29 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id v5so56830edc.2
        for <mptcp@lists.linux.dev>; Fri, 03 Sep 2021 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=qIyPtZul2NKkHff4EQTo+IWkNiZMnHrjE6rRuHNmSzU=;
        b=DezwmNXyBi+R3YPXIm+rDKofDDok9YGCnk5CmvmFph5C9z5cihM4RvepI8pwudatk1
         5EnlaOYXGgzh0RDNp23Z1m2tui0gsXaaq2WmDGLy5r0CCR0ahnnXPAVokmp2ps/UJXlK
         y9ZbSbZWOO7OfWrr/U3YAHF2ugfM4rUUFHL80znGK8DDOXB/6b86aoKL1WZgs9+qXpyR
         o3el7ar1X4FxuFVqpOYkfZtXIJvQjXIOnz7USGrQtsB5vP/lRiOxb2kRxBC0NX6UVXbM
         tdTkdUw+mio6ZPPaCgvKDq20/59Jbz6XpUyEtSEDOQtTx60Un3ifUrRe4rdJ8XeZkK84
         8rOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=qIyPtZul2NKkHff4EQTo+IWkNiZMnHrjE6rRuHNmSzU=;
        b=lJoys5x3EzULPHM0ToK5XCCAAODwWllf7TXgFtu6tvdXd+EpFM1HlKTYrbaaAfVrm2
         h4b1sAZ/SFNhSN/wOhO/FHRXzNSNrmCa/hpki/VmQAdy2fvAqpS/cQbpua1BQibQ+0zP
         8lBFGSwsPqyWsvjKttyRlMUw3Ut0dEOneXgzLPjsZbTlRLoCvmQI6F1bVp/V3+VFDmMi
         ODX5GMdx0mlKEIHs/RsFQI4Fvm9ClEkQUCDCcSfk7Ts1uZ9htP8VXwOanCcJEImJ+bDt
         gYPkV/kfYi+CnwtjbzXSWAjEHEokfjPmRKoxjmm3NixHgckjRYNtDuWEMRffIiIuV8Dk
         0efQ==
X-Gm-Message-State: AOAM532uElsmee5jGPlNOht+iGuoDntkq+MSItw63suUxjy/MmLbdZwK
	NQUGRBQVG6jhPeEcmWSGb7gI4/q27457Lw==
X-Google-Smtp-Source: ABdhPJzPcTpYks6rWgU3CP6H7jpAvxqM2FkGzlW96XNi8MUutYra8RzD9yI1Brqz0OPLQpxjO4UNDQ==
X-Received: by 2002:a05:6402:4d:: with SMTP id f13mr143897edu.275.1630691247388;
        Fri, 03 Sep 2021 10:47:27 -0700 (PDT)
Received: from [127.0.0.1] ([185.232.21.132])
        by smtp.gmail.com with ESMTPSA id b15sm3110721ejq.83.2021.09.03.10.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 10:47:27 -0700 (PDT)
Date: Fri, 3 Sep 2021 17:47:24 +0000 (UTC)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Message-ID: <00868f46-7e1c-43d5-b814-fe5412cf072f@tessares.net>
In-Reply-To: <fc52b567c60d4908a148dee8fd08c3d6b3ff3454.camel@redhat.com>
References: <cover.1630595171.git.pabeni@redhat.com> <ae127a2e3d2fb31e6f1687cb96128d39490f6be0.1630595171.git.pabeni@redhat.com> <f01b372a-7145-3df4-6958-0eba522af05b@tessares.net> <fc52b567c60d4908a148dee8fd08c3d6b3ff3454.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next 2/4] mptcp: stop relaying on
 tcp_tx_skb_cache.
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <00868f46-7e1c-43d5-b814-fe5412cf072f@tessares.net>

3 Sep 2021 19:18:33 Paolo Abeni <pabeni@redhat.com>:

> On Fri, 2021-09-03 at 13:28 +0200, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 02/09/2021 17:52, Paolo Abeni wrote:
>>> We want to revert the skb TX cache, but MPTCP is currently
>>> using it unconditionally.
>>
>> One one small detail if you have to resend a new version: for the title,
>> s/relaying/relying/
>>
>> =C2=A0 mptcp: stop relying on tcp_tx_skb_cache
>
> I guess/hope a repost is not needed, would a squash-to patch and/or
> direct edit while merging be enough?

Sure I can directly edit the commit title.

I can apply the series if it is OK for Mat.

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
