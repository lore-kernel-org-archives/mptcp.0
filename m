Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9C43CB2CC
	for <mptcp@lists.linux.dev>; Tue, 10 Mar 2026 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132431; cv=pass; b=rFSMYOYK1qg4spW79bAqDnS5JBByrpKMz61HtGrNgZCxIk/bYUSrgQg5LE621rhKiMyInDPP5HQwPgktokiVj1HzXHhna1q3TGpiLXfKSlyV7PNXXrAN1830Taa3rsiztovrGFDsiPQlz3CiT33CApNwr/GQN3lz1s45kzzXUMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132431; c=relaxed/simple;
	bh=d4ku0rUPq2W2b4nzjW/2a3G+pwxDd6NAsRFLOoSQPRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGCE0nY6MG+OfUWAqxNbngFnF+VTqMXLlJdL8AbRX4OZ4rG4cvqHQjuXVFWKL2zDQNSDtWi81mjuizVdFjWf4Z3lgJUatk1hZWP/WetrQdt7PbMmInd4vyGPObcRUw/vHU0rTn9cDEwjNQMEgR0Y3ZGjurzn/E8MHCUjUFO65uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KFPeRuFF; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KFPeRuFF"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899f79df682so95638946d6.2
        for <mptcp@lists.linux.dev>; Tue, 10 Mar 2026 01:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773132429; cv=none;
        d=google.com; s=arc-20240605;
        b=A4BwsfXO+Eg9Dxhl7yQdD3Ugo450ij42BeJo4hpCkJu3drVFvb7a+qiED4oY5Yh26J
         ZbFd1df+McfJOAvASmMW1Irhh+vxO6NjOoPmUcc5Qlx6ldRxCupKd3hnn8uFG4IaOMnS
         R6EajtolJdMUfgjFqHTAmeD2AfW2iFUA8xxyPIIzWry+cRF8aP03RipUT0tm2hih9BAk
         JwJ2iUxrBeJeXUeZkB+WE8G5e5nMxD0/WFCwQXjfu0akFps9nak5ziqRQEWp/IuvcvdN
         Ye2/MiipxkCDB6oWoUAg13STUI3INI5N6fVCMsreMKpRuMpwGd242a8T+I+hThg4mqc3
         f6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S/YKfuwEjoceIF72ASHR08YC1df1DlHUUca2FdDvmBo=;
        fh=eutQ5ORLoTK6p7bYhpAHNlQ8SCiAkBc3Ry11JYurOYQ=;
        b=ie7GB4PhSz7KxCmgXX8xnZlcPF3y0ALIUzzQD5cBE9NPYGu0JjJfK2eM0wWousDBIo
         zqIVkfDTo+nayCtT2/52YJJeMrtLMWXUXRV6qn8uWclcNXi50OQ0S9GLwh2ya0mfXe5U
         lEl1nflos4YxD9uLDwQVuBYA532ad+8CM/253+DFPJYLfAMFQ6NKAJfafOLae6qf6k9N
         YF0/SZUYVajxWR50ijTc7sPLPFcix/J/irnVi7XoHFpoTpnvuxKFuyOKOXTmzn6pWzv0
         ijT7xHtbpzeO12DnS2EX4XAqZ44LoWu3ujG1VYEP8t/7Ng2rODPb8Tf8Ojlve6AmSGqd
         w4yw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773132429; x=1773737229; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/YKfuwEjoceIF72ASHR08YC1df1DlHUUca2FdDvmBo=;
        b=KFPeRuFFLkVC0YRbZ8dZocLi6zN/cIVIUCBQdEUiZdbMP+8RSjoNvRJ6niu1Cr/sVp
         41ycn1vFaf1EqidJarxxPYQo8cWduZBrECVixEtSarLdDUB1lGwFR3Bln20HS0D0WfwC
         mysc//tUBCqK/YDHTwfF7aD4DiKVyYPOZRlVg1bzml/n2zbcYhBk1XNUjxoSX8tBU3OZ
         aFKL7QecpkH+ix26nVI1SdrCUAC28BGfKJ0g0aCpQct0V2aQDU/X+cKzzAcO3BOYIQZ1
         CEGnBPPbsonbEwOEDVxG7RkJRHNwyFzAmlGMKHpjcRlBCGBAlqX20Fa7WXaRCHTM1ldu
         8DzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773132429; x=1773737229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S/YKfuwEjoceIF72ASHR08YC1df1DlHUUca2FdDvmBo=;
        b=CnhfYbc78vpe1KZ8llINuzIfVGBETJPkL6sRo0iokRx6yHm4nQYYRrupttDYd3jbaS
         hKfattiJRBHkNChtjbNioi3FhVJL7/aLHNCP2dyzE083iIZf949FeBVV+daKcEx0IgUT
         v6OXwcZiOOJULizCgUxP3Te89X0wjniTRVeHZAlk87epcg2IbchjgtzFg6sJqPUtasaM
         7u5WyHf3bN454+901Mt6ZWUKkXeXusjhmLUTvZB+7nsZPV2PhI4zw97Cf0k8QiDZNu/h
         o62wIz+gTYpOkNi3gpu2hFLAxxKPoNv/gj+ZPFHcRB3RMkgsJ6jrki7ToMJM6OGMAc3Y
         uD3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzqtp3flijWc1x99yaxsN/7n5/d9gbiDauLQJn1iYpp8v+Nkj2ZgxMY0PKWoaZeTnGWL05LA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZJ3GFr7txVzNrBPEYWR7IfCx4NWhhfZ5rpDe3vE/L87ElFMKn
	QgydykwYedx57ZvkI2MF77Yuz2q8TksOTZflSN52SoX0fEuZrzsRUiwGR76208HxgmTubq/ryKG
	MLUlfABV3B2r7zI61nxm1j4UKo1DChjtruZZeuszX
X-Gm-Gg: ATEYQzzzPoNTG5zSfCodft6Qu7HZJFoWRHOMxx6jrwyelRN7l0bW+2NJ6eKa6wueX3D
	JEdA5jw2Prf6X4DkXjQM2x7gwmUdoVHANwbQmR0tU4Jy5a+Gvoc7Qu5i9veqQqtdeaQ26pylMFX
	CDF+Cg4DdvxXExLK6QrJRcSP3ZSe5bG0FbkOYrbcyZa8QAXl2GDb0UTa7ox7aoz26OEkCWde8x6
	zWSzwcYH1K5lApHdlAPqRyTEMSRpzkxsKphJVnVFkxE1LoRuttQznLKMocRelR00UsOLebSO/1k
	YRVGw2o=
X-Received: by 2002:ad4:5fcb:0:b0:89a:13a5:77c4 with SMTP id
 6a1803df08f44-89a30a809dbmr212994566d6.29.1773132428381; Tue, 10 Mar 2026
 01:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com> <20260309-tcp_rfc7323_retract_wnd_rfc-v3-4-4c7f96b1ec69@gmail.com>
In-Reply-To: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-4-4c7f96b1ec69@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 09:46:57 +0100
X-Gm-Features: AaiRm515yCYx-zywRXphow2t71Syn2XmFVDbg53R2r2K3-5MlWrmIcf8VHqN2p8
Message-ID: <CANn89iLrpBui8OGtPTV+Vkane7xHNErPB8a3AgOEawpi7CLU3g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/6] selftests/net: packetdrill: add tcp_rcv_wnd_shrink_nomem.pkt
To: gmbnomis@gmail.com
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

On Mon, Mar 9, 2026 at 9:03=E2=80=AFAM Simon Baatz via B4 Relay
<devnull+gmbnomis.gmail.com@kernel.org> wrote:
>
> From: Simon Baatz <gmbnomis@gmail.com>
>
> This test verifies
> - the sequence number checks using the maximum advertised window
>   sequence number and
> - the logic for handling received data in tcp_data_queue()
>
> for the cases:
>
> 1. The window is reduced to zero because of memory
>
> 2. The window grows again but still does not reach the originally
>    advertised window
>
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

> +// Ooo partial segment, in adv. window -> accept
> +   +0 < P. 1040001:1042001(2000) ack 2001 win 257
> +   +0 > .  2001:2001(0) ack 1042001 <nop,nop,sack 1040001:1041001>
> +
> +// Ooo segment, in max adv. window, beyond adv. window -> drop (SKB_DROP=
_REASON_TCP_OVERWINDOW)
> +   +0 < P. 1105001:1106001(1000) ack 2001 win 257
> +   +0 > .  2001:2001(0) ack 1042001
> +// Ooo segment, beyond max adv. window, beyond adv. window -> drop (SKB_=
DROP_REASON_TCP_INVALID_SEQUENCE)
> +   +0 < P. 2000001:2001001(1000) ack 2001 win 257
> +   +0 > .  2001:2001(0) ack 1042001
> +// Check LINUX_MIB_BEYOND_WINDOW has been incremented twice
> +   +0 `nstat -s | grep TcpExtBeyondWindow | grep -q " 4 "`
> +
> +// We are allowed to go beyond the window and buffer with one packet
> +   +0 < P. 1042001:1062001(20000) ack 2001 win 257
> +    * > .  2001:2001(0) ack 1062001
> +   +0 < P. 1062001:1082001(20000) ack 2001 win 257
> +    * > .  2001:2001(0) ack 1082001 win 0
> +
> +// But not more: In order segment, in max adv. window -> drop (SKB_DROP_=
REASON_TCP_ZEROWINDOW)
> +   +0 < P. 1082001:1083001(1000) ack 2001 win 257
> +    * > .  2001:2001(0) ack 1082001
> +// Check LINUX_MIB_TCPZEROWINDOWDROP has been incremented again
> +   +0 `nstat -s | grep TcpExtTCPZeroWindowDrop| grep -q " 3 "`
>
> --
> 2.53.0
>
>
