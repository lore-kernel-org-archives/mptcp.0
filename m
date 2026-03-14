Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC426AAAB;
	Sat, 14 Mar 2026 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773500489; cv=none; b=C3k/6e0dtTIjyrAsu4+YG4uyUGp+0+xmz8a29QsgRG6pAPYGlhKHtYdx4yCQwsZHyN1Ksab3HUPeFYllkKpSToZOR+UnZmX38Rj8agGbz1ZePHzg1a4UhnXdXbRFwe9eJ0gz1KdJrr/gbgf6fK7UyI4x1AQqbtE4ceIXeydbC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773500489; c=relaxed/simple;
	bh=z7quPe0rAnb5gy0IrP1jE1rt857r2N1nCt5JlTUcjHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWVmY+PYrvkoZQG/ZoSLM21uM+WnqJZfKkf/a6jyWGwnK1VjB+T0405kxFVcYtWWEbHs7JL7VWG3HRNTav/9RfRoVbxtPdftrno5cj2IkLIEZLxDzKgHmw3NUJ4lPZL0OiGOA/mOMqFatkbyIjHXcHze5iMkO8EQAb5W3CIKHOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvUhqRwN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvUhqRwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F61EC116C6;
	Sat, 14 Mar 2026 15:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773500489;
	bh=z7quPe0rAnb5gy0IrP1jE1rt857r2N1nCt5JlTUcjHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DvUhqRwNpd2qyK1AKASFLQ2+I6HhiPb41EywsmqJ0CLH95QP1y+R5WL+VZivP05Jd
	 /3Jsat1NXfVNwb6oieEez3wP3NhPzhlNjm1JOj0sjDc7vSdIfeVie6HncrXj3s1uQP
	 n5BPuFaxYAPD7vrZggtP+2d82OOPBBVFbM1iJVFxco2UCfEwl+ZmPix6U1sMxrZqY3
	 s+p0c/oGuMvEDrr5TG6m0LyLAuezr6Lil8J0ALVguiO7oJ8otHVKZG+QhIEb47T8oN
	 6W1eSWoC+llzhKIQc1IYS3bZRcJHjCr7suPnRs0VHv+yuWcER8vvt8iNEWEgvoYqtA
	 M+22JSVOgCYPQ==
Date: Sat, 14 Mar 2026 08:01:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Simon Baatz <gmbnomis@gmail.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>, Jon Maloy
 <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>,
 mfreemon@cloudflare.com, Shuah Khan <shuah@kernel.org>, Stefano Brivio
 <sbrivio@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v3 6/6] selftests/net: packetdrill: add
 tcp_rcv_neg_window.pkt
Message-ID: <20260314080127.633fb3cb@kernel.org>
In-Reply-To: <CANn89i+sEmZxcYDXHE=jtjNxoitGE-z4qkcS_eWSbiWHyNTs2w@mail.gmail.com>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
	<20260309-tcp_rfc7323_retract_wnd_rfc-v3-6-4c7f96b1ec69@gmail.com>
	<CANn89i+PypF1cK4mnp8L_eCG_z+3Aj6uxJoohm_=DwGfR1=4FA@mail.gmail.com>
	<abCkmiCSPkmxzECa@gandalf.schnuecks.de>
	<CANn89iKYxs644ardFFSKo8d0EXL_2A5eUQjWZ3yp9-Q4tVLKzQ@mail.gmail.com>
	<CANn89i+sEmZxcYDXHE=jtjNxoitGE-z4qkcS_eWSbiWHyNTs2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Mar 2026 15:55:35 +0100 Eric Dumazet wrote:
> On Sat, Mar 14, 2026 at 4:58=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> > Then add my
> > Reviewed-by: Eric Dumazet <edumazet@google.com> =20
>=20
> BTW, this can be done in a followup.
>=20
> Jakub/Paolo feel free to apply v3 series if this is still possible.

Roger that!

For the record I'll fix the trailing white space on patch 4 when
applying.
