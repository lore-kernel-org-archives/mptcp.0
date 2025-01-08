Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270DE1FECD0
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353569; cv=none; b=BjWBrX2C7d84t7SFfhN/t8H8aVX9bYB7QmSWigeaennNv3//x1jpiAyhxnSk8jvWweRTlbEMXNVPf6szSgtswdrzTchDYIKYYPXqV459QXk9EVu1jBTngG3QW831necxPrWE595E8kA36ZAXvQZAhHkyiCYVs6Jw7aiYTGSs4VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353569; c=relaxed/simple;
	bh=Vrpja7gLp8wClJr7WGS7vASHEC8+FJW4qOfjHyBB1O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i17Xd4R6NkM46V9bDkLNpctWvK3kJXCfjF4f6d4PHM5gTB76OXHs1b/G3tOGvP9cnzVYrG+Drhxy2gygS2kgF+ymsQvOAPIribFDqxR3+eEh3veE0Lvofeb69nzGgBgJWXhpHIs+Qoi8V6GnmHZQEVY0RhZDZjceGXxfXRfxTqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M3Dm3E2S; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3Dm3E2S"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so29918127a12.0
        for <mptcp@lists.linux.dev>; Wed, 08 Jan 2025 08:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736353565; x=1736958365; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vrpja7gLp8wClJr7WGS7vASHEC8+FJW4qOfjHyBB1O0=;
        b=M3Dm3E2SchX1yOkQwp2CYawwQ1Mu9PZ7PnRlCNJnjfV3r86qMUgP39M6cRo2WZaNC2
         zBO1JH1otClQgBAWATyl0ZLFXr8V8PDEzbRm8A3cyR3XmNNTRuMWEZUyY9y5RmnLeKdj
         KSmzr2h+h5Oc1x/mNFza3up3uNO9OMVxAcx4FecczL8QsBO85q52Vb4yjK/bP+VZetDk
         HKBCSo+hv2mW+HUAbbSTk1ocy5jF1aqX1hbNLnz0H0rZOy6nnmuRpxF8lqBUswYNULgZ
         oQnJ9RZvH8zTq3Rb1+ut+NE83ux+EnpBu6wqLu/kyu6bEQVvN+n2rvtIDGR+Q+k9LOhC
         0HpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736353565; x=1736958365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vrpja7gLp8wClJr7WGS7vASHEC8+FJW4qOfjHyBB1O0=;
        b=ll80lLMgFGG51+zd4NkpAJGOZBS94ghb8E4Mizlh2pIuq6N7LfFie2borMZ/3WD00j
         lGFUCwvwrJXFLnnirkj+Ys8AoZD5OXACZJPZzFeBkimDecou6ycYeMfYGlaZFFp0MU80
         3Aj0dauErYaPQCqTU5WNbTZAVg0tPL81jHqJLv8J2XJZRKpN5S9At0137B/xdVOwiMbw
         5yy6f/GCXFm7gFvQRdcnK/S2Bu2Pa2/9zmsDW0XtloJKYGfNpngy5Tz8uuPcIFWhzvmV
         0WP44XVr1TxyOsRQ+4yDfEgeZPJUCOFD5/8rvJAoxdsX2RwmAvEhXVkj1grZg5EIcwHm
         OS/g==
X-Gm-Message-State: AOJu0YxRvr/npCj81d/UbRTi4PGgGSnwFqpcd/+jnLc2y36pDG/8LMJM
	hnGdz88sny6gHilSsGM1Ws4+4gWeTQ9XB6//Yi4a7mYnPbBIvi8Q0VPRLCXAOvdAarY3sPU1dD6
	h+nr8UePWiD60ZhAMGi0uZEQHKEjT8w4764C6
X-Gm-Gg: ASbGncthHkf8/Oqr97Q2piSovto8QqU3idspyy7IB4EXVU0wgy3Xq1GohgU7ArZ5Lr/
	4d72kdvtCmTFnRn+6aIqplDBGJOPE79iaOa+nABk=
X-Google-Smtp-Source: AGHT+IGeGF4vh8DxTEjN7tESfGNU41x6ofqkC+fyq/M8TSO5+w5+umwB8ua4y8BitM97QdgJt25Wf0pnzPSZGjKvuUs=
X-Received: by 2002:a05:6402:280e:b0:5d3:e9fd:9a15 with SMTP id
 4fb4d7f45d1cf-5d972e6f473mr3265028a12.32.1736353565288; Wed, 08 Jan 2025
 08:26:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250108-net-sysctl-current-nsproxy-v1-0-5df34b2083e8@kernel.org> <20250108-net-sysctl-current-nsproxy-v1-1-5df34b2083e8@kernel.org>
In-Reply-To: <20250108-net-sysctl-current-nsproxy-v1-1-5df34b2083e8@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Jan 2025 17:25:54 +0100
X-Gm-Features: AbW1kvaWCFc1GR9QJN1q6qk-A8PrW0sTYcPB5wSHtxPxsBwUlmaJfdU5wH_8KII
Message-ID: <CANn89iLPDTRYEGO0C=gtbHnM=OUPhfdK3RoLzzWMOMLEgmT0Tw@mail.gmail.com>
Subject: Re: [PATCH net 1/9] mptcp: sysctl: avail sched: remove write access
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Gregory Detal <gregory.detal@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Vlad Yasevich <vyasevich@gmail.com>, Neil Horman <nhorman@tuxdriver.com>, 
	wangweidong <wangweidong1@huawei.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Vlad Yasevich <vyasevic@redhat.com>, Allison Henderson <allison.henderson@oracle.com>, 
	Sowmini Varadhan <sowmini.varadhan@oracle.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Joel Granados <joel.granados@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 4:35=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> 'net.mptcp.available_schedulers' sysctl knob is there to list available
> schedulers, not to modify this list.
>
> There are then no reasons to give write access to it.
>
> Nothing would have been written anyway, but no errors would have been
> returned, which is unexpected.
>
> Fixes: 73c900aa3660 ("mptcp: add net.mptcp.available_schedulers")
> Cc: stable@vger.kernel.org
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
