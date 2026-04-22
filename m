Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A614C223DE7
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 21:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776894878; cv=pass; b=W4w6C6kSix4bS1QK1DZoto0QVlB1hLVBRChY2JP9j+p0VtozY/FfLl9JrL4KdF+fuKWvUuFBYPcQscoRkX/04hSYvtyu1kx/tAC1Ldcepb5eNH9ZHaffenvtyotxKB1W8a6D9KwhqJaNKNl52WE+EmH7DaO9ygN/1cqXK2qSw5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776894878; c=relaxed/simple;
	bh=JIFvm00ItPpRR1vTcR6+G1w557SPIg3zLxpm238TRXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRbDZSD5bRhBakRbQxA8ylx0KP1DCAIkEFFMituw4ydU7hBjOhAn809BkR5jvWywJ10YW2VR4sAAK06YbqxrgwboSmlTPY5CXMbc8UbHgI67CJdgvzJB5thC6vAvQlm8JDvpLYijTF7Ayi4l5WTVupiTcMXDtrIAMfeAbeGVC5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0xTWIYP; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0xTWIYP"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-673ee2a98b1so3327493eaf.0
        for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 14:54:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776894876; cv=none;
        d=google.com; s=arc-20240605;
        b=Gv0ad+oa3eR2XaZYYZkmFTgpsSGhiVc41hu8h5z+4Yu/Ke6cBMP2xnz/QG/PwBSgZc
         hEulGrkqaQreKZsb8Xjly//qJG35YPMkpIxqmP0STyDreHUApYPNVZI+D05qxZXXk15r
         ZWWTQStNnVLZCweNcyU5CthBdYTH/hkjXFQtVkJJ9cu0sFv7G5eW7hs6dZM03wOBh8in
         CCkDP5BDFBl571yZ61DPiQ2xcIVuqwSA07IuUDUQjEY+ipnKsgD1gxgFbEhruzeVRDdW
         BCz/GYxqaAa1kUWExFNUrS7xdZFmm1tzON2XOYfMXZoNjA5YWhn0X4/Lj3/0mw6xOY/q
         lugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YF0/JskkUjs52RwQXyXnLcpc0bdNSBFAVdfKz7vRO74=;
        fh=t5+JejTJfYR2N5XavZav/15Z9iEcC/cS8sfhXtVvnzg=;
        b=GJPWXX47/GlddpZ1KJvCkOgQaGdVQZ9kwmYwAUhdQyreH446HVodr4DrAsoUijnMi2
         mG8kRl/fWXj0bF4oQzkxCtsw46x09i761+4O4JpKokeqL/kvNztmn4lXDUAEYALsIFAC
         rniZ9TjOSqGHB7qvLmcXT0UWjbYTzcTyfRKS7kpFRE94r+gxQO5cCBGjCog14/oJib2w
         tcxM5gTL+Jg2MRsk4m5GvXJvV3HI8l3srYhwrhpqh+oDsRJ7ybhCXXZjI+pPBvg6T3Zp
         LtWfNMOiBYoCs+Q+0aismZIWLWqAj78J1aDPlgGshX0+pnPYLEdgJakRVmR5gKE3YOwd
         kA0w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776894876; x=1777499676; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YF0/JskkUjs52RwQXyXnLcpc0bdNSBFAVdfKz7vRO74=;
        b=o0xTWIYPsq1CYbbfIQdmtQ/n88v47sGd6OyZ3b1t0v+GUVVlWC9TWucLwcJCtu6C2S
         Wi6GQsQaQ0K3HiyIbPcwgedeQFkZJkK6KxTI6o1cN5iTwbzOvSb1eUCqodsz/7S9I6Qw
         yg01Z4MNZUGyyjWZZznfVREFMMNf8oKoaILjO5zPWBUSs10AMVx427GyRIyEixO9npri
         GSsxfqXnSna7x1bMJ5NsjyK7fBy8BPx8SK1kjPQGn9xOLQhpQo0RoyBrUg/p9Zcpf8Uu
         CxDEQKhVdgzRCjUZ/Q3+VetHyQgvHZuD2G0e5pBdEdY8bPLtJpLDhRBUxRlcAiqKGySZ
         B+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776894876; x=1777499676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YF0/JskkUjs52RwQXyXnLcpc0bdNSBFAVdfKz7vRO74=;
        b=pJM5+UZ6zEhMbxl46M7/gAHu7f5HP5KW7gxg4/4OSNn/8udXJZ14zoCwDGWxcDOi7K
         vUhiZ54fApcGPnLdjFE9jWurR5qiqjUcmE0rYCZ0I8Cd3ZKuGplOHI8eYyHJkVJW0jLe
         Va7p/6bHYNbq/ikK0OEbqu0+ZUWiy8QWatLWYaKkeugRHkrZQ+WJVIUhrAXH2VOGnOxs
         dQK6rVDaC8KLe6hFZ69JcyTnlm6Qj1h/BTc8fBOW1lf3FTbucxbIws3mTwzvUhzxQ7Rb
         hkmXV7rbSIU1+/xSBAqXrq064X5pn4wRrfeUvrOXehtFFBCmFH6jRluQxVdfsn6KFZYE
         mFKA==
X-Gm-Message-State: AOJu0YzYlSGe25SKm6naYO1WgaKqE5VZWVnkB50C4Qga7QpkENadL5r/
	4SBTlEqrR353hP+7JJ7zKzMMeF9fWEFbY3yTtw7gHKN4qB0j1ol9yuplFouACQIkPbtE/HFbSB1
	wdnBNZOZ9A6ZpkqhGnDJrwIqXY1QYZvsnvtgAA8g=
X-Gm-Gg: AeBDieu77b9vGgn/FfWZGVRBgl+27nhIqjjPIPYwy10aqG9sEv7zm1vIHZ+9onSeShw
	qUxRZdmea+K+WeVz2jbwh8y1/U0t8czYN5FaXmFJ38D6MIhcZFssLALlMevHtOk5FuaR62iEyiI
	FY99a9hjZauA/o10r8EVOAZaZtiytG0KmLhanM5i7wwEqY43BxMnujc52RvoZp0WTgLFaKXxv6Y
	SL0TbazXuy01rPExZrecRBBmK/CskuyBwPn+fG9D/5JmZmd4ua/N2tom+yiscTBdJoe8F3CAGYU
	oGLlr5xq+p8InIEgl/S9/Yslx8Yc+mB47+avaEAKp1H4ARBgpX1+ncfn7Qk=
X-Received: by 2002:a05:6820:2005:b0:694:a17f:759a with SMTP id
 006d021491bc7-694a17f77a0mr3707165eaf.32.1776894876592; Wed, 22 Apr 2026
 14:54:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260421223338.52743-1-devnexen@gmail.com> <20260421223338.52743-3-devnexen@gmail.com>
 <c730724c-6bc4-4b24-ac45-50ae1662ef97@redhat.com>
In-Reply-To: <c730724c-6bc4-4b24-ac45-50ae1662ef97@redhat.com>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 22 Apr 2026 22:54:26 +0100
X-Gm-Features: AQROBzCHxivowhwzX3oMmdxHmotj0A-EGpcaYKykvyopqXgz6BGMEzAlMxSr9dg
Message-ID: <CA+XhMqyX7r2Yh-sDGFg8D=-Cd5aJYQrwuOc_O0tGCjDN=KGVkQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: support MSG_ERRQUEUE on the
 parent socket
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 On 4/22/26 10:28 AM, Paolo Abeni wrote:
  > Reverse christmas tree above.

  Ack.

  > Avoid reordering the code [...] use goto/label to consolidate the
  > return path.

  Ack.

  > More important: am not sure propagating subflow errors to the main
  > socket is the right thing. [...]

  The sk->sk_err propagation stays gated on the existing
  SYN_SENT/fallback condition =E2=80=94 the patch only adds errqueue skb
  handling (ICMP, timestamps, zerocopy completions), whose cmsg
payload
  identifies the originating peer. So fatal-error semantics are
  unchanged.

  > _If_ error propagation makes sense, you should probably try to
move
  > the err skb from the subflow error queue into the msk one at
  > sk_error_queue() time.

  Yes =E2=80=94 I'll splice from subflow_error_report() onto
  msk->sk_error_queue. mptcp_poll() then just adds a
  !skb_queue_empty_lockless() check, recvmsg(MSG_ERRQUEUE) stays a
plain
  inet_recv_error(), and the subflow walk + data-lock go away. Does
that
  match what you had in mind?
