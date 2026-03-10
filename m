Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340E9439011
	for <mptcp@lists.linux.dev>; Tue, 10 Mar 2026 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132912; cv=pass; b=kJUtK/3ydKONUqUGVCoxQXu903FtRKmsClJRyX87lrYQzqoN2ZlPc4GpZrLOsMO/z8B3nVpuWpv8XUtbLLm26CcdffkVNGtRaZgeMta2+bELZbgs3b70f4Uk6aaLaFrHs6jVAkDeg825RREU4UNa7WAnv0KIp250/VBvpb7Dhdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132912; c=relaxed/simple;
	bh=MTpfFIjKFrgdOM/fNUp2/tdXoh0iY9f5YiOgrsaFrPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xp+T+cHQEne5UFQBrl4thekjic0rQepLc70xbfU4FQIlQDbyVVLGS3B2LhwqBcf9oLbOWv0cEI+nGvXJlmX4KxVIrZTOghZzN9BDwYmwCXmkhJfDSuuhTw7IyRDIpIwNM/tGuVPu3FXtSrSTAOvlRv9ndzc58hahd7i/0wm2U+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=URik4IvC; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="URik4IvC"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506bcb23a78so110358321cf.3
        for <mptcp@lists.linux.dev>; Tue, 10 Mar 2026 01:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773132910; cv=none;
        d=google.com; s=arc-20240605;
        b=lzQBbX6l2Sp2WpFO90FY6gosjbZCkXTjSBB2Po9iACl8uiH3VYYDReRfstRMpyt/Jo
         //IoTEGVYVJPC1xTH/FwwilWTNAS6xCNzQ/8lwH5suuhLFmwTjI+/S6cot540gl0u5Bq
         SRyRd0FAgNTR5khCxbavOX8h23Cjq47MeNc2z64XvuqilMA7BaRiUwWLgpu6wXeSn91d
         FJ7Y5J4wIYSj/+bTaFYAjA+EDW6H/m0l5azjbzQtYrLyTz8u6orJyGuaTB/Zzlk8mJ8d
         mTzrApRRt+EvU0rM90FsYuvikkLp5lALeZxPFXUTGnmT0+EoSL6k2pr+OXGVcm9j9eyQ
         qefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=57HCSNZqdX/pE4pNruhHCDIUKjmgpBGDki8+akqS8UU=;
        fh=rS5BIeYqqi92o2GD3oKpoz5dmEts7CdRiacccPrq+4s=;
        b=XxVorNZchut7+x4+Da0OhAwCJnKICabaRb5JvMzi/e+CTEnes2IzyXGJ3KJmR1y/i9
         zjuySgQ8+RgpUHw1GWsKdlaLxkWwf/IWJSObd0LOkWL2J9BlZwnDxK5/ZopWHcg+fSiZ
         Sydfz8Lip+9tIw8V3JjN2C3cWp8EYByhyYBZiQhEPn8EQA0p9tvXB+j8+uiUr3OXmJQF
         Foom2+TnhQFEI7KFSzBCykXtcGDZs4od42egtO6FOEVsSqI01U6pN+uApsm9ZModytxM
         1i34bdobF2ylrnTNJuzsWEtdCCQ+8JyYxHO9NMMqUOKmZgFfPeoOsGk4+hdf76AeuU6O
         FSLg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773132910; x=1773737710; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57HCSNZqdX/pE4pNruhHCDIUKjmgpBGDki8+akqS8UU=;
        b=URik4IvCe8wgvGSZ8qNueqnpRLsiEJREu7qqkSEYOctgqKnCJ59PG8204QJPi2HIW4
         PfyMr/B9jNn9eIig3gVygPCLv+ppeo4DVOnWB20TYvrdrEtpwxe7FxN3PTCdX7b44fyS
         sZlKG6ZcrtRlHIlNkxHO9t0TDaKayskMQhNqpTY+bwKTlc0YMszROUjTsMy25Joz/Drs
         UQNKcLMYwreU6kw/g9eZlkhVvKvTV0Pucw7sXdr9v8Ig3edFCuu8VLyJUt7IHu7wY846
         8sG1g8s+gGAwwIKq3mrC3Slcnva3jMm3E7imNtEnt6iP4jRTc2AeeuEntdZKoWEUZdOT
         NEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773132910; x=1773737710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=57HCSNZqdX/pE4pNruhHCDIUKjmgpBGDki8+akqS8UU=;
        b=R1yMITUBOxaZYVfnCIUxu3wOZgzJJ54/oL+3kvFXj6cpwGj9sNlfKERtjSb9SoxQ2Y
         nbDPwppp4DSv2CjdcBUjKD3PnbEDgQEpLK4BvNoCkPQMBtcBFInK9lTEA36J4if/CeR+
         NouCi+6TpkY4ipeIr3CSwBrqp1zlPFiS9zH+JTtAB6IAySS7nE7zdZZUvRN2qQmJ+bjs
         lghetWG1VuRC0486Ac5iAqpZuL7U9iSbW+FeyJwKatFfwLbIuaqogxf0DBZBEySzrLzn
         1LyuNFvAzA5RTG3T6V/n9tCEIz9cOMlKmTOafbOT4ydCdZdgVz2mb1kUfzxeRTttdD0/
         J+cA==
X-Forwarded-Encrypted: i=1; AJvYcCVMMhvpXGvZGSpakgUgsCDV8dCPNfBPb4eVC8b0JLvMXaLthjyBFSw588Q9kYjq2V/uz5P8Dg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXaRl6Gck0H+i8YxFw5Ed0Vu3j2Z4j84Em1jVj9C++pbWGzCOo
	O7piUKHxrMCNzX8S4rSmj+OxBbLhd0vqr/UIIEQdzr9YREIAxYsfWm1patyowNaocJeCHe7xGXq
	JmzqoaImV3zKshcUTyw7aqZHsPX7I8N0drpvUpwR0
X-Gm-Gg: ATEYQzxBJrpUyNaafwXaomkuq9TCyLLUKuE6slZGbXc7ONrX7RgT8XEXOK2PGQIlN/0
	S8hixbCocxdUMZ2pDCOzuw3fyOaFjaaSU8Pz0hSnycfySMHJlgqyST+fRncQM66x63jzZcg7Qkd
	HCt3+GXzo3C65f+OLyg0ATD8eC0qF0UZoTuCHIC9d003VUDgRD/3uFXsuBRr5eaik/wMpxgF7Fl
	BNF5u+mtqyTQDPvO2WDTnnH3BDHSzWq4Bq2yYbqWmP+OvXDOVdZJd3mOhENbHpwWZA4kkz7pxr8
	Yi/UNCw=
X-Received: by 2002:a05:622a:283:b0:509:272b:b3ef with SMTP id
 d75a77b69052e-509272bb73bmr26369351cf.35.1773132909710; Tue, 10 Mar 2026
 01:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com> <20260309-tcp_rfc7323_retract_wnd_rfc-v3-6-4c7f96b1ec69@gmail.com>
In-Reply-To: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-6-4c7f96b1ec69@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 09:54:58 +0100
X-Gm-Features: AaiRm52hpqwFLhiGxunf2HDckqwt_QrtXyTul6g4VBswXcYgEk1a2sH7NGzoxSg
Message-ID: <CANn89i+PypF1cK4mnp8L_eCG_z+3Aj6uxJoohm_=DwGfR1=4FA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/6] selftests/net: packetdrill: add tcp_rcv_neg_window.pkt
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
> The test ensures we correctly apply the maximum advertised window limit
> when rcv_nxt advances past rcv_mwnd_seq, so that the "usable window"
> is properly clamped to zero rather than becoming negative.
>
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---
>  .../net/packetdrill/tcp_rcv_neg_window.pkt         | 26 ++++++++++++++++=
++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.p=
kt b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> new file mode 100644
> index 0000000000000000000000000000000000000000..15a9b4938f16d175ac54f3fd1=
92ed2b59b0a4399
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +--mss=3D1000
> +
> +`./defaults.sh`
> +
> +// Establish a connection.
> +   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> +   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> +   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [20000], 4) =3D 0
> +   +0 bind(3, ..., ...) =3D 0
> +   +0 listen(3, 1) =3D 0
> +
> +   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
> +   +0 > S. 0:0(0) ack 1 win 18980 <mss 1460,nop,wscale 0>
> +  +.1 < . 1:1(0) ack 1 win 257
> +
> +   +0 accept(3, ..., ...) =3D 4
> +
> +// A too big packet is accepted if the receive queue is empty
> +   +0 < P. 1:20001(20000) ack 1 win 257

We do not see the answer, it seems this test is not complete ?

> +// Send a RST immediately so that there is no rcv_wup/rcv_mwnd_seq updat=
e yet
> +   +0 < R. 20001:20001(0) ack 1 win 257
> +
> +  +.1 %{ assert tcpi_state =3D=3D TCP_CLOSE, tcpi_state }%
> +
>
> --
> 2.53.0
>
>
