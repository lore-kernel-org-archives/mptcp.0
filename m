Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62338361DDF
	for <mptcp@lists.linux.dev>; Tue, 10 Mar 2026 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132763; cv=pass; b=Yze/p76f81TFmoBglCKHaBF+iCej4KcvuJFe0Ys8koPCUP/vySJTB86H2AyCMQKYIqWTukNKAtrY1NB3H1wqaRtngAU3vGCvm/4JmMo4zpiuJSNA6dzy890ZE/CVmJhPzORjt5eoxRfvelv+RrmIL0e3BnNL4Sls7xw6Kd19dv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132763; c=relaxed/simple;
	bh=GWZ/M5s5NCER/oau2EA9WTqeml+PkjCSZzT7Gq/KoYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jD6Vr2SZgp0AMBcCOno6bFookJo6H2uf8lhW1lZ+4fuLhRYkbXOv09ugUI0c2vi99+eutMRK5Ifw+MKY9qj+sPg4v14CR3RnczRglw6CsmvMQ2gQnFEHyXl+RgfBsKv2oZrY+ydaXI74T0W9Ap8wU87y6dIYYU1cy579WxEfrDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KnkB1p+S; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KnkB1p+S"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-509134ab2d2so20243801cf.0
        for <mptcp@lists.linux.dev>; Tue, 10 Mar 2026 01:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773132761; cv=none;
        d=google.com; s=arc-20240605;
        b=FIN/iYiEyUR7rREvaVy6RvO8ldnx0p0WuVhmWP8U55njAmzWE791KcQdwXfFabmn23
         bToQFwwKvIk1tMHk5BAnpo8taNeHtDJwmEGML/hrs1RAZHsoPZGUNMKvQkbq6+vTseZo
         JlPbn7x+IvZtqrX26pYFy74lJmsb2jyrymHs/8EC5N06M5Ww/6s7BVSv09Ziz+PyZE6N
         Mi4B4hi58IQ7Re1mq+c/452A0hagVCbq9WdFR/4PFp2DxWSuKPaxbZNmrmGXrnoqAISU
         lDpR8KFkLaJ+w9U1EqJQeWxlMaCboomI9HoNiM+3Ake/9X59k55s7UpRaVcM0A5uhcmw
         /ctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GWZ/M5s5NCER/oau2EA9WTqeml+PkjCSZzT7Gq/KoYs=;
        fh=DVnWaM1DsYBqpQjxEPSuBW5WoCx+DsBSWIlCay8dlLM=;
        b=ZVYd2xB838golID4z+oivIszYiZTDli6jD6XZjq5yFqT9kzi9V3zxVnncR9IZCXCxI
         KKfJ8Q+oa8k8ZuE4R2scl9aijMe4w1y5xGJFNZwLla/GyafkSEw0C4Pn42G3pxBy76WC
         YzGfg+QDYl6J4dJAr+ZZgXasO8P2h4xiBKUH1dNQBkixUm2P/NlH34aHY7y9dqvw7E1v
         cKTXhvIzp1txWZLX8ubOPvvSSODHRe7ZFsU/UFo+tFawjal1wTdOYvSDma6aEZ3t6tbq
         w9pcgAjldyJQfuylNYVM/vv3npUKvoXDvWaGP/pLn9Cl0yyFDqnSD5nwD+cJVJE30zU4
         7AzQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773132761; x=1773737561; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWZ/M5s5NCER/oau2EA9WTqeml+PkjCSZzT7Gq/KoYs=;
        b=KnkB1p+Sd91n/+vpes4Vh2Yji0lenakZGbVpvtnC2Q9RUJ7KamfYmN0lrjfMZvD96q
         0eY9/UeOTv9KAkQXmwkeiDKyuQU2qhLqLFEIzinZwMzJQ9dxjNklcfLmISCcgJtLyu4s
         mzYayPRnsS84Fg3hwBzzcEX4SZ5G1803WpH6YjwUjD7kXikViq6yoggojNWp71BsFAjm
         mzxJConDRsiIClC7LYG2m6o+0SoGkj0wyrEeejKcxqYu2h2WLERjV3CSEGYJYzI/bKxF
         fL16u/dBdrSsyhzrYtgXqKUiYxJt50116Yv14lb2/FW03r4FQ+tRbyyL9+WCCziFF4jx
         VArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773132761; x=1773737561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GWZ/M5s5NCER/oau2EA9WTqeml+PkjCSZzT7Gq/KoYs=;
        b=Zqnv4lgwZ+Tkp0uGYDETsC1f9g6RYvSEo4s7UhCYE6+XgxowfhsjC8/WhwUjgKfVw/
         DRlR37oYW5RM49Ib7yvueo8vBsIcYFT8qXQnw7WsU4S/ObqAju9oGMiVQX4mgNlCLIP2
         rtFp7Spykyg1K7eSzPtOTDiE625bn4Ny+5PQXYyWziCO/aId9pO/2VuKY/Ed2iX2KAIN
         xoD1va2YSdm25grobiwgzePtPk0nWvMDSI6TF46LD3GwZfInwAWR0sYqX4M/oUefQ9zo
         r6r1iW3zrP9B7LDU/KSznvkqgMP10eZG+c0PZlGrIqLSFTJMYISFSXrT+TzBBaCo/Pl8
         vC2g==
X-Forwarded-Encrypted: i=1; AJvYcCW/qxaorRq7CtPE/z9us2gFC/mg1XXqRHFHvQbP9aeFYI2y+TiCs3YxQ4c0w30X+xlSYBbSgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxK/DbiLMY9nvb2RejrY5uknY7b0jBHIoVd0tzBf2yKq+M9PXOf
	h3o4Y2TnoD0TSEEYtxoBR6gHXrpCwtvz3hu1jDxI81ys+dEDJhTb/uzF8Q9O1EVdbI2XV8dNWNO
	27M11NkXc3+R89PmrAuEncKmZ+pBeX4ehuK8d+c6N
X-Gm-Gg: ATEYQzyRSW1k14e5fmE8zXfhYTQlbCtQwxx39GqOABLFvDyK9z5mu6+NeIWuimAjwdW
	RYzeDQH6//Ek+pioOltd+pd1k8dingRHzM32FQSJpKTSlDHJjxBcxGpG8QNLtAQbKnsLv+C/NNM
	Y2OR2fQ8Pri2KKnq3nLHnVW2Ch0kWZk+X2QFhq5uwjOD/Qy8lIBZQjLnQwHw9Hy4s0Cb0u0qJ5N
	7cQGx8eO/u7mSm+NPHIbcHW+lQQuda28zPCxwzAY1PRieFG9bUK+4HVF63w6AzeXY8MEAg+0tvv
	SBVLzO4=
X-Received: by 2002:a05:622a:1495:b0:509:f36:496d with SMTP id
 d75a77b69052e-5090f364cfemr113018421cf.33.1773132761084; Tue, 10 Mar 2026
 01:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com> <20260309-tcp_rfc7323_retract_wnd_rfc-v3-5-4c7f96b1ec69@gmail.com>
In-Reply-To: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-5-4c7f96b1ec69@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 09:52:29 +0100
X-Gm-Features: AaiRm53cOsmiV2tykYX4dD4wvI_-2esZ5FOIQTDvQaaas49mugfLK5wzrAfT4QA
Message-ID: <CANn89iJCR+nO6ZdggkCGACfQ-Tbru1nq3_q8q4QTp93faoCPug@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/6] selftests/net: packetdrill: add tcp_rcv_wnd_shrink_allowed.pkt
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
> This test verifies the sequence number checks using the maximum
> advertised window sequence number when net.ipv4.tcp_shrink_window
> is enabled.
>
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
