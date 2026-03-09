Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F333133C51A
	for <mptcp@lists.linux.dev>; Mon,  9 Mar 2026 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048445; cv=pass; b=LqGX/CB+Q7LBylVpMTMrJRkxkupud8TKrM7RNTeBaEQfSQ0gh2TvBfufnYXRjpucm6wqGnhH5UTWJ8ztQ69QATiMdxE0B3P8BSHtegv1RkLUkA/iT0UjkS1nDARi/gVmQ0w2oMmIQQDXz6cAbz6RDom377AHYjQD1PN2sFKDREo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048445; c=relaxed/simple;
	bh=KRg67KYop4N0GYuq1ulIbzn25MYTnK5W2894J9F0VtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+t0uA+g3iiLhMaF7c10TK4mCmsmSL0r05ArI00ygh3+BaaW5yTgyXigOij6tsXhF+lisIc1JyBcfUG8V2trIEVjkolOhdV8KdOxBtSNZ1tg3aJry4OuTRB7FqKVGv+msijVA13cWTGMK1AK426pSiwxaBbYxrndc8WO+Z4QVDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2PbUDtn/; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2PbUDtn/"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5069b3e0c66so162455551cf.1
        for <mptcp@lists.linux.dev>; Mon, 09 Mar 2026 02:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773048443; cv=none;
        d=google.com; s=arc-20240605;
        b=TDGQXrLA5aOCUH080AERJ7dNV/MLIC3t5qvynsPGRhcX+F56sFQVlLotEisdPN/K22
         M6YuBi/uDYC9L79rkJSESYJ1jcSAJu8sfhX0O5PsLiw29LkO5sEcyuJiR2akuysvWazV
         9pmsOiViG65VgWy2vPlCTe8L+6iClYhJhHKrBBntjzWp0TIu9hDEZxAw5PvMcY9srU8U
         lRyJsLugWN0iSJ0TcZNJLrWrgCs6coHp50j3V4h4WfGMgz1w94tgtiZN8WwVNePeCaIK
         vAvVqiIBtDgMb1qgRfZ7wrpQKI0m8OhDab0hawMqjoPAz5PuBNsKj0ePoBppPph9VkuE
         M7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V689RnMNCiq5v9NKZp9UJyJzDdaI4f7fA+TJBBF1pOI=;
        fh=cqyH4/I/VrfkDoM0QrJVszjjbbPKJhoOiEkH00Tmjn4=;
        b=Cfb+2yMVEqLs3sOFemaCI0UFZMsUU+Ij1ORNtVFVS2EGXLpegsFetKT9NJuyT+NNU8
         aBa6b96A638uq1UfgSowsE653qhZcHKPhFMlGR+0GsX25DJzKmanWRB62BxvJ22TEnZL
         xrJkhQwT9Lb68A6knKqkAbQcoKjd6SSW4cDBc71J8gKNGNjU77o86H4XYng6QnyPVKZO
         7pxfrFqgEp4Lq169ZmWyFOzrWPxyGMyM1vrBDZcs4Jpmh3kurbmy86ddv7MstXRZoP9I
         aYPJ0xC5YMewySclIG4xcKaBeqjcygW87omAekr2UCPr/pYiIgyhLRyq/4Nqw0i2C+ZT
         C9sw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773048443; x=1773653243; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V689RnMNCiq5v9NKZp9UJyJzDdaI4f7fA+TJBBF1pOI=;
        b=2PbUDtn/OcGkvEhF0JpsEiYDJwdmDtbHsBeqVnxN7E7q+x6+YHfSyzNgbYxm8KKply
         5io6Abe1qN9pXqxIi/iBFdC3XvtTK5/el7q84t+3QYXKSzTaRkxIdqkLJEKORkAjsKn5
         XOJb7pKtNDTnd/sHPsV5X6ODFp7Fg4FtWLK46EgQmHMtuK/AdZOkoEtqfP+Vb9N8WGHg
         iSIAIozasKRonV8ILwSAeQGR077picfpqHX8K+2kaSXj7Vx1GtwcSIMvinX+Q/AcYtHg
         kod9et7QyoX2hklEi1vgQAJ6YzzQg/F1AacHfxTkyjduzbJ1szbydxsY45fZYpdPQrWa
         HeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773048443; x=1773653243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V689RnMNCiq5v9NKZp9UJyJzDdaI4f7fA+TJBBF1pOI=;
        b=IikHMlLMiYvls8juxiDaFYSj74+XcUeCnBoefXm0JvfEyqwh6IDccneIhy502rUfSn
         lv+A1Q6v1X6T3m/wdcsrcGp/w/jkypxWVkwYBPQb3CEjS/a1vlwyKxksmkK/+Z3bMJ2R
         DMnSQb0VIVRVkTxZ06v3X07R2m3oiHtrzIJn8qr/mhTuL4Vk6LTqP/ES+7LXwApd968U
         04wl9PQWCmdF9e+k8SSMZ4zcrodrXOkm2EEGOipsWjJ9rMIQzzUAY31rsVUejDZG73Ag
         MlmFrMITXynp1x4qo3ohJxFF73QUIYTAd8P7h2hTzw2umZty7yKGLbmaP9TK9uQv2MXS
         /CLA==
X-Forwarded-Encrypted: i=1; AJvYcCXhemq4fahj2D1Ajn1mQeSWs2NAoEKm3rMIeVoOUmyrVAhy7lh0WdViBVCBctfYSCMHiyz6cg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMP4OLgB4KVTi+e7yLw9llMSCd4n+Zcz7+XFwoFVp1f2eoECk+
	8jgX4s6WTVSQ9/3oSDJsMnmvVRH98JFdJFIV2+qV8x5tFs1ekgeXXiGsglQOkTTGMJ+QTZzCSSO
	bW1WA/qAyPNI/2dBl84LZ5R26A5HqQgnmAOhqxrG0
X-Gm-Gg: ATEYQzyU9aHAfSSzCa9nDjThUzYH7tWwaCq8d/Core74bz/at3x3MuWBoyU4GTsl57u
	DLkeXN2Hnvpjdvb78iZg5mevKrO9uBQWIBDkTI/IAbYz+HFAInMbS9gU4q2JjVI3ceb/M+tvzu2
	LQv7OPNdZXXeH+U0rTChSWS+ssk6rG1SFJla5lOJzadTDwA5t7m2sn2I+Nr21HxCpaQZ/rJDEDW
	neRi7+3Yhlly/KVISfVhAaL9PI9BJsSSSt9i7Yaf/yT0MpVTQym4jasAaz7oMOu6bqMVLoKJHXc
	niEkDHA=
X-Received: by 2002:a05:622a:211:b0:506:1e25:c0d3 with SMTP id
 d75a77b69052e-508f4b39629mr125560661cf.30.1773048442380; Mon, 09 Mar 2026
 02:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com> <20260309-tcp_rfc7323_retract_wnd_rfc-v3-3-4c7f96b1ec69@gmail.com>
In-Reply-To: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-3-4c7f96b1ec69@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 10:27:11 +0100
X-Gm-Features: AaiRm52XfGKozvuZyB36ujKchA9srFaJs8-SNxpJxUZoRWouiMvaeYGJTNLDzWM
Message-ID: <CANn89iLzOhZ_DbAQytwZrzoZ6cvkkvLPbvUF81k1C2tBYRSFDg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] tcp: increase LINUX_MIB_BEYOND_WINDOW for SKB_DROP_REASON_TCP_OVERWINDOW
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
> Since commit 9ca48d616ed7 ("tcp: do not accept packets beyond
> window"), the path leading to SKB_DROP_REASON_TCP_OVERWINDOW in
> tcp_data_queue() is probably dead. However, it can be reached now when
> tcp_max_receive_window() is larger than tcp_receive_window(). In that
> case, increment LINUX_MIB_BEYOND_WINDOW as done in tcp_sequence().
>
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---
>  net/ipv4/tcp_input.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 2e1b237608150c2e9c9baf73cf047ed0823ca555..e6b2f4be7723db14acf2ae528=
df17b6d106b9da9 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5678,6 +5678,7 @@ static void tcp_data_queue(struct sock *sk, struct =
sk_buff *skb)
>         if (!before(TCP_SKB_CB(skb)->seq,
>                     tp->rcv_nxt + tcp_receive_window(tp))) {
>                 reason =3D SKB_DROP_REASON_TCP_OVERWINDOW;
> +               NET_INC_STATS(sock_net(sk), LINUX_MIB_BEYOND_WINDOW);
>                 goto out_of_window;
>         }

Reviewed-by: Eric Dumazet <edumazet@google.com>
