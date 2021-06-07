Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4007070
	for <mptcp@lists.linux.dev>; Mon,  7 Jun 2021 15:07:31 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id ce15so27241102ejb.4
        for <mptcp@lists.linux.dev>; Mon, 07 Jun 2021 08:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q0U2bcplrH/HGMPJzhoZSR2J5wR5unB838GT4JVbuHU=;
        b=0zR9Wwkf6jbLZlKikJqpN5HpphLxz1N1pHPX4sHtkNEFN9AY5hId3X533uQzJnyS0F
         qF9eKf+g/6EQ4A/sBFRsQneT/KD+qfT3Tig0nZXmhcRon3DGz/PsDfAm/KcK/4q65EZS
         s9MiliYQb29kjzNzmsP0gGaHqoYP8VCLiDdWagqBgdmDdHhxSULjTMmQls9hVbua7SJ1
         ll1FZNJDaR6IjgYbRKeeXA9N+wVcoAcXjn0taGaEfXSfjH39LUCzUnvhwWUJRl7L5Mf7
         RuyVLtLSG+mGukrLbs0zwtyp/eFwNgbQrpww6vxjOALExv39FK1HNYInqvkExJH3we5p
         V54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q0U2bcplrH/HGMPJzhoZSR2J5wR5unB838GT4JVbuHU=;
        b=MfNiIx0pVeXqZ0xpfGswp+RV9tptrJFY1l0IJyvQhFzpmmvV4Rc7j9W+JWVRXN2jAX
         TlOTh4qWEmHqLkugaGq4VYhqbceCleqzkLSNkfbVXf5F6IMHEb1dxPUtaaQtFx0K4zyJ
         25zyKrfh9XOMOasDiirXB/98HVSTLfWJ1Xv3TnMMs6xhYVTERwb5qx9dkD+ckUWq++VP
         9lFXuZSKzo2K3oHGqfDtKRqXiPl62PoQg5Uhzr1422A+yeJXRmAsdw/87uO+vDG/zpav
         +5SW9z0hMLXNIzXYJvIsvkROMrwzZkmY0IJ5rfzXQ+rOPtrCAB/Mw6XUVQI9olJX1j3Z
         /mVQ==
X-Gm-Message-State: AOAM533vJjuwvwnIc1wnauRWp06ptzpgdHGmOKoQqHIZSUSEGIPDWQcd
	vRoDPtxTxY9ujzIfTRARDKTBl5mzMZbIEbBN
X-Google-Smtp-Source: ABdhPJzuHHI1OxwUcbOYLia4KaT4VWuGuvWs/NzdtzUM3EjfY07cbPGsdXA+8pDE8FKIbxpVSBE5XQ==
X-Received: by 2002:a17:906:b307:: with SMTP id n7mr18174089ejz.261.1623078449665;
        Mon, 07 Jun 2021 08:07:29 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:b57e:3c04:9ae7:cda2])
        by smtp.gmail.com with ESMTPSA id l8sm3837594ejp.40.2021.06.07.08.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 08:07:29 -0700 (PDT)
Subject: Re: [PATCH v2 mptcp-next] mptcp: use fast lock for subflows when
 possible.
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <ef0582a975599149d8a127d6f6914760bb64f136.1622131853.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <76d1912f-a395-ee55-1aaa-c7ae2990cfb8@tessares.net>
Date: Mon, 7 Jun 2021 17:07:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ef0582a975599149d8a127d6f6914760bb64f136.1622131853.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 27/05/2021 18:11, Paolo Abeni wrote:
> There are a bunch of callsite where the ssk socket
> lock is acquired using the full-blown version eligible for
> the fast variant. Let's move to the latter.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and the review!

Now in our tree (without the dot at the end of the commit title ;-) )

- 60aec9b8f645: mptcp: use fast lock for subflows when possible
- Results: b01ac56d4eb3..e6629296aed2

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210607T150702
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210607T150702

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
