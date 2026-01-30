Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00FE2FDC38
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769804188; cv=pass; b=r3Pzn/08xPrsJumEDqxZUnwG8e6avOtiVuRt7IciStQJdD9tAfsZIRSG5Fs3+n91RsLxT6i+P+NvweTpwcw87eST87gLODtz5byTyXihoMUSazmjvygo/cwCT9WHJuirUIx9Rp55IwL+uRzVpu761mxwTy3gJZMX5OloWvhEAxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769804188; c=relaxed/simple;
	bh=0t0nq4izqsf4GvgNU/9Cuo4KWBgcrjRZN6raZ3fmXTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfXVYT3JyW6cTgbmEzR5zQCev/rmw1/PnASseMLelYJYWN00/2WKDp3fAhNHf8lhfBAaL3lvn49gW0rcJI80dgkwdzSGQbPdHZL8LIQuOq6zVX+9oNAe+Y0kcU6cMvAErKDwu2dzE4oxTqoT0EK+HdhmAAtJrxEAasI2rdsj4LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q0NjF9dK; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q0NjF9dK"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50331ac1fedso29397921cf.0
        for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 12:16:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769804185; cv=none;
        d=google.com; s=arc-20240605;
        b=TmIA6kiytrIdBnqa0i4aA0ZjRS8j6qQnXy/hBCRh4FUSlm6tPRxQpLu+LR86YT5k38
         vk/+cHfbiGGyECir8kD+VgC8V15ns+An2MNloARo7VOVncX91/y3SWccpvXB7pduqaL/
         le5NTgQkElEcOj5uh62GC4xCc+KbroDyUPfM3fVyQreB8Xeb8AgImao3kwlHWmtOoGAv
         yk2c4Hm466D+UbhUcHac/es0FKObY2qCPABPITCkNiVL6lguf9KB3gb8VEIjMlrbhJ9j
         0ELqD7ao4oQSrBUeG300pnwPS8QfaZJK0t73a58McaiVn9V5ZS12RCHelw3LRyALNGTz
         KgLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0t0nq4izqsf4GvgNU/9Cuo4KWBgcrjRZN6raZ3fmXTQ=;
        fh=qtPjZr78ONVEycpEpiVVyf1kZ62YVG69I+o98Sw8aSk=;
        b=aOOAk2DX6TAOP35b49tC258ZgxMiIreTdIQLurbH6SQ076Xw3eNfZr8tHa9t+0Xajv
         Igz/uWi6awhPHYDLqmxcKDtu2OtpnFjyTm4SbYLClD8FFQQ/F/GgsttBX8vBuT0Q3Ai8
         8NZW0Zj9XaaXaBSCBL7JIyqtp6a+ZokksUSx5l6Ulp2KULDmn4fqAXgJt75vCJyvWGRv
         oQaqvfbVbYnCaK7NQd17gI2dygF2MUq8l+1C7r3Mp+sYk7T+V3pNTc7Wz54jNvySviG8
         IxTRUCtgr5V2K6tXwtw4x1wf5HwWjyPrnweGbPjDNsRSibsVrtKO8e4OauUa8Kqjh0Aj
         reHw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769804184; x=1770408984; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0t0nq4izqsf4GvgNU/9Cuo4KWBgcrjRZN6raZ3fmXTQ=;
        b=q0NjF9dKPUCp5z5VjaAR8UEDS2ifLfu7dcv631KGQ2tkxOt21IH8EhxTwPFM0kbZK4
         6qnMY9FesNWOj5AfRRX4St6dc+zgDMabmIrlcU4Ro8aVI+Pd6R+l3IQKCcfoMZfJExFl
         RC+kE+l3rn0iPuSuYKOWczM1Tgo7rAXIi6zMUoI9b6f0FQWY/8Dya5hKcJAkhWAx+lN4
         cyoBmGm3akEQXliO7FZsvzLOhc/Hh5XqNkO4KdifVeyJNYHrvCm/ksokhVZmShbDCQnz
         uyw/nFUXUqt0GAxtq8KbuoyHs6ZZnY/wyNmjJkIhimbVi34/2kR52sVg700uMeRL/uQH
         eiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769804185; x=1770408985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0t0nq4izqsf4GvgNU/9Cuo4KWBgcrjRZN6raZ3fmXTQ=;
        b=XWh7AH90sbGf4YCagrlfxRmeO2ak/I+/jrDnq0WrwvUJl/TMJB4RfRk8OHEUZ2ntPy
         QgP4cjoJhV231m0iyOJe2/mWo9wYlAzQwZFElSZfJmXwDpONk3WSA4hzO9MsP4WjYO7J
         YuHrxC8Y9G2bAAISzKDNEEepft5u0fsA9V8Ec9NMn+0spYmUmvmtTdkAOnQYanB2nsHy
         fVTM7twU8xkGcZ3tRW4ocjoN7xwCoUdlzaFGWZRDfV4HuiG+ebX1IM13zkUyKD/jOEfr
         Fr9Owg1Y9Nz4x2jq5GopzzEgBkCdxm7rRupElTcO0bxutGalOLeyMhS3i+Nuh3bOLEH8
         8IUw==
X-Forwarded-Encrypted: i=1; AJvYcCVj3tiGXnKckaEGJEVtohBFenjxoMlfipu18mSDLz5Cbs5aMIJyFGrhF6UvFmhiqQEFpSNkKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yym03dA07V1dfcfYL+OOSdhvpWGJQuCRc5QyjI/vIPtG4RGPz95
	JSceCjQ+bKnGTMm5ukHKTerNES4oIJa2GCUOyFSLhlAYYZ/hAiBg79oYdsMfc0qos11IMiNYB+K
	yXiyYVN4FY+eaRgMNc+1g8irbgVAgk1JlA4NqSr7L
X-Gm-Gg: AZuq6aLDKbDivvUIacBTYA76upJqHvEXsTL+qXYeuafRO+H5EI6SXrw8B9ZkD2WES5x
	3m40zV8RaUwtrsz04FXHinRyYOO1vS0zBnxJwrVhjQmLOCQb6euZKPwQny5f0dpnFutb+gF8pXx
	a5KIeOHNYM+fLuf+Mm6DgKxySezynqzMdaAqbdSuan3KHCNdAIWjorFTN2j8V+2inSPlaJ+oQzA
	TDnJaH/P8m99ZMbrN7u93cSUUPWvGK0E97fauz2F9QLhbq9cImZy0NZuMa0yAxOjOtefoQ=
X-Received: by 2002:ac8:5754:0:b0:501:4420:62d1 with SMTP id
 d75a77b69052e-505d226f589mr60062871cf.48.1769804182889; Fri, 30 Jan 2026
 12:16:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260130-net-next-mptcp-splice-v2-0-31332ba70d7f@kernel.org> <20260130-net-next-mptcp-splice-v2-1-31332ba70d7f@kernel.org>
In-Reply-To: <20260130-net-next-mptcp-splice-v2-1-31332ba70d7f@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 30 Jan 2026 21:16:11 +0100
X-Gm-Features: AZwV_QhPfbD3TZKlMJ_xVQRsXqSJjU6kBe-oa26mxAqnC8KtZaJD8P46JjJ950c
Message-ID: <CANn89iJtTCAj7h2gsAGsu0J5E7KNXtqCgNR5Cp0rJB6ifnMvHQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/6] mptcp: add eat_recv_skb helper
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 8:24=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> This patch extracts the free skb related code in __mptcp_recvmsg_mskq()
> into a new helper mptcp_eat_recv_skb().
>
> This new helper will be used in the next patch.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
