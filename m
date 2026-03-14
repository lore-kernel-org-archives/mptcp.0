Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919B637CD4F
	for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773500150; cv=pass; b=Le7QNYwHktJX+/FX2c3hjJnRZjhe+gKYq7DMAypkw9NNc1zfkFf5fJSoO2rF1ZgpIz/rxxIMKfn9i1rttg6V1L53ZfmbpGCT3ZwVOsnsLPvbwPgMzLNIFX3taWAWtqzCkjQt070q3Gw2F9JMHRDqoGAHAPjnDXxdrCfPkywRw0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773500150; c=relaxed/simple;
	bh=Ca5kh9peUXUreTgn89AvAH7iYz5iRwVMohpHmv4hihs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFuc+ni02oaM/3HSGRO7rkmX5LoPRcHGjVnLtP/E/OywSkFAbmNzOBNcH3gcRkuQKqA4gYN3S5yTiX/40QtS3kLgMd5fS4P7aUgQ3VdYGk+if4J6fWVlsy1mCHDMIMNE3m4+8KicHVY2RNubc64caAUG+bVA+73SCYOphILzF7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X50lsEUd; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X50lsEUd"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-509149ab7d7so26466631cf.2
        for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 07:55:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773500147; cv=none;
        d=google.com; s=arc-20240605;
        b=Y/oSmxsDxJRWouK6v3vrDMnUQ4ob2qET/1+NTEBSBmxfBFK7Ugxqy/v2M+IvvuirFQ
         jR/ennm2bgPRgs3Z17Aqwn2flMYpz1uONSqaR4VeqS31Q47/RQxUw0FEURMIUVuk4aGo
         tqDSQDVH0NIG6m29CJeIHlsaKaUDoCXUMfUT9P1weyDkIo2xBl638E0nTh8k4K7p8dmq
         J4c6Udzhu62pNUDBEuVmc+ZlAk3Il+/n1VBePBQcfbVOhsNbALjT1ZjsRID/IF07yBPS
         /GpZttkNLyP3gaUro7CozRM90+Vd7sm6Cy8TAvUozCEfMMfxn9700k4T7JlL9GzZIXU2
         0qcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ca5kh9peUXUreTgn89AvAH7iYz5iRwVMohpHmv4hihs=;
        fh=0UTFCQCmjFf0fRra04G++FbVSlVjjuVKPJm6Qad/qlA=;
        b=hygGN4iFSSAX/lpKYYF8pA/aX8YAHPdycbF3H1ObMuWB/BciJqDv+X9Bfik67q5nD+
         EcxP2Z5jXHah65lCCA8dliONj7PY67TTmyCkhzoT9tuR8sJ+2EXWEWxp9hTA0QgOgdyW
         a68m6he2LbOelF4029RmGqh9ZseEvjXJF+2P3FADNpx97/awiVokkGpB2s89gfNRItVU
         Vs7S/XhZ/DIwdnMQY4PDsLJLJF/v4RA12M7Pykz6cIaa1kPA2aQuNBiVHtbhZ1Y4XJ52
         BHiJL98p2jbG0jEdQKHRae+ByDimMvhLcG9X7WVIbMYeN2iyKPmm4BNjeLA5uxqtg45v
         ZNDw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773500147; x=1774104947; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ca5kh9peUXUreTgn89AvAH7iYz5iRwVMohpHmv4hihs=;
        b=X50lsEUdJ1eRREEx59LFbH5FBeseyhrkyd5hRpAs1vAEHAWCY7P7yNhJeeMf3kI6tX
         Wiu9uuB8oUF0Idkx29XBf63dU3rLwuZhcv9/nYs3MgdmzPdVjPoL9rIwdlN5uYKMQSiP
         WhxNSWXIZzf/PovXoiIS4l9R07ZW+5vezbhp8831Oos4vS4zcEwiw1mZys8W7WMmycP4
         UU5vE9iYvTf3lEHS4IcjSCRrWCLLtH5kHSLaJKeKTpcLLf2h5ZL0YB94yTJokxvhvX1/
         5MZetwTKinlAe9aS1U7cs0hpS2uzo6/da2fTfwQJs6eKOEQ014sPWdiKTlcf6seRf1EO
         CVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773500147; x=1774104947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ca5kh9peUXUreTgn89AvAH7iYz5iRwVMohpHmv4hihs=;
        b=GoGn5g+wdahBWjnkARoZ2dV4rksL0azGYQThcTk55TMXLV0Db8+qqF17XmfBnbGZfM
         j4/JozuOST3c1oFTEOcKibvSS31yrI3sRNoq9qZNT1f3MvdRGStwqIm6Q1N77nvrdV2O
         CcDaA8OilxF5YagEWR0f5l/mRHyLhC4LR6L7YDNHe22ktkZkODY1nCaIReoVS8pIceXJ
         inGj3dw3OwRM5TL4Bx9ipat8rga3I/8fPo52JT1yLaKUnhQGdocGnR3BplcbYGfVsa0R
         CIEgFoPsOuObqY2ITUkDomP4+YBk0gj0nqb347k5JQbfngp9s5zJbBVxmCUwBy8cn+A3
         rf0w==
X-Forwarded-Encrypted: i=1; AJvYcCUAgN6ijHWZrV6ya4997tcc4VzC5FTWW2l8jaRiN3LhmNqEaOqtaIiVcO7sfZCydYKGdSH8yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzL97bwmMIDE86chx5sNSpkRNQ21iLgre3Fad4inalIeAU/VQdW
	TeHADuckd5FhRXN5Z/wOPEspdh1HQGFt/Fh4Y6fG5lJ4cxVPzge94hDsYOOnN1NCE8YuBA4BtTK
	XzPgiM1YZYLr+Mj3NOWvJS+P6yYfCHkiIaFX2T5Wt
X-Gm-Gg: ATEYQzx5Ru5+tpJmJJd18Xt9o+W3YeSHYT1djKQc4hjHZEwf4Xs2RcxuCph48BN4noh
	XzJdqbr4AjT+ILsKFM/DQcjX2YblIIMknzdhUVZlwQN8yjBgBTl2wT5WMg5XcrM6MTCRoRyt6W+
	uvVcW6+STP2Pv1gqv929O8NRjd05Lp+kxcysrxFBvTMW7EVi0Z55OInTY0g+rxeC0+74Awrt8j0
	8JcOBlJNftpBwQ1ObJedCCbrRiuAV2ayNImJD0pzGSuKDv6LlE2u+PA6d2/aaxbUfxE91JN0ult
	Yr3uwjY=
X-Received: by 2002:ac8:7c4d:0:b0:509:1009:e7a6 with SMTP id
 d75a77b69052e-50957de8d93mr94929211cf.43.1773500147029; Sat, 14 Mar 2026
 07:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-6-4c7f96b1ec69@gmail.com>
 <CANn89i+PypF1cK4mnp8L_eCG_z+3Aj6uxJoohm_=DwGfR1=4FA@mail.gmail.com>
 <abCkmiCSPkmxzECa@gandalf.schnuecks.de> <CANn89iKYxs644ardFFSKo8d0EXL_2A5eUQjWZ3yp9-Q4tVLKzQ@mail.gmail.com>
In-Reply-To: <CANn89iKYxs644ardFFSKo8d0EXL_2A5eUQjWZ3yp9-Q4tVLKzQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 15:55:35 +0100
X-Gm-Features: AaiRm50YYJlq5QX8gZcwi86mWXpn3wuRkajMKwpZDqBSmkf1bay96mdoaMNxTlo
Message-ID: <CANn89i+sEmZxcYDXHE=jtjNxoitGE-z4qkcS_eWSbiWHyNTs2w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/6] selftests/net: packetdrill: add tcp_rcv_neg_window.pkt
To: Simon Baatz <gmbnomis@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>, 
	Jon Maloy <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, 
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 4:58=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>

>
> Then add my
> Reviewed-by: Eric Dumazet <edumazet@google.com>

BTW, this can be done in a followup.

Jakub/Paolo feel free to apply v3 series if this is still possible.

Thanks !
