Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A657B289812
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196341; cv=none; b=dyeQrB37wlp5vC/CNj/hlGAZ1zdxuKeN+J1zklU29rRJVObB4D392dd1KWuL2rZkC63uJdQLrnFxOs9wui48zIUuAtSFKsu1iOCMpMj0d4qBrLeMiaV353oiEGvnmk6kjBmuQH08JoocXxrEDq1OOFduq1LYH3G+gfk5n7EgX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196341; c=relaxed/simple;
	bh=CiqwsXqS9XffgcdUNt4OEyIxE8kyMoj+z790mtcu3ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/k4BuH7WoPA9ux8GOQbrw1b30NINkk0VUaK07SoHonldWzFeC0+gP5gGVWoPBe7kpow+CZRmKFDGfXPuAZ8n5otgKTCFzD0AT7J9XsjAqD+N4RFAkeiLZW1e0nOXts3aBThfMLOuRiDJ5FXXwHJTvxnkDh0EwYenaX4TdYT+9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C10Ev3A6; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C10Ev3A6"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4abac5b1f28so49939391cf.0
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753196338; x=1753801138; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiqwsXqS9XffgcdUNt4OEyIxE8kyMoj+z790mtcu3ik=;
        b=C10Ev3A6PY5gQJTixgatQizgK0/50SfZF0+2L1F4e+7f4wqt+RDDjBkZJmuVhzAj1X
         VoTf4L+0ISraLzu9xBmNa9IknjltJ/Zj6UfpByrMK7yjddTyvj7v3VDIVGtsAo8ekukB
         5YbEYSugbUiFi3RPsYaxWBfsKZSe0EclxJcr7pnkY5WD45CilwlVo3QLGQYLVi+LHb5V
         QYOaqMgmIemPdq+PS1GvmOs7nD4Hot/0yrSCftxwFhNwNeqFiIsqp6BxQWCUMQwS9h0P
         huXYvWaJ5vLv2dagBP5lvJk7yrtPHoxxLzee1RVdYEzbmvrbwe2XgHzyUwU2Wz+zXRMF
         V2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196338; x=1753801138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiqwsXqS9XffgcdUNt4OEyIxE8kyMoj+z790mtcu3ik=;
        b=h4jM4ehmUACfHJb2CJJDo6rtyTL9riMwos1+uVys+QlLdLZJOHurFC1WOM/W0Oqh1d
         jQX9LFan557DlyIBwfR2JPwJcj88R+Re4IupW+y2W1N1ObpUk2Pq9KMddpun1grAyUBN
         bjbtOrq3NdS6QrRuyPNdgrsj50oK+DvL5HSyJ3jreMnu5+QXVnyU2wje+huM7EN7Inu0
         Uun+bcRy4mYkxYeWjH45wWEyth2xfHud+NvXt1+u+qcUQ0ieSDEbHTVDmBiGHgWp08c5
         AGvZPaTNZW5FAaAnTL4Le57kvMdOCNUrYSc3+yzJxs0/3iyWTXq5vvJpFVtQCkYq1xhL
         OqAg==
X-Forwarded-Encrypted: i=1; AJvYcCWzs4EZShUKGcZewOyfEcvYGUYfI1SJla7YQs4NmV2SACQ0x2FhuRI6tFf2LEszvfMrx+vGqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDj6XopfNG9rDsfjojR3QfdkBLP87sM1ZW617Q/5MIJYe73H+m
	MqQ6pYnRx3+wN4otnebG1sPN/k0fPCFgoa+xBYbhWx4fAauOS4CI5uvbPfQ6ymFJluXTpiYpXNS
	Fdds3Cd69Kz0rN8LeZ5cBjRn6sWsued6DJgLqmZUZ
X-Gm-Gg: ASbGncsoJdXppqOkc7/BXsqYwsMgJEorfvo/HbvAGm+xCFYDxERfrEFY9PxF3UdZfdf
	mhk+dcXzAbCVqllZSiK2B/iSrdL+3PEWr7Kku/HpxcsQwRt9TYmw9I255Us7EoNPHWfuDFbF2yB
	2YGCaroG+cvrtRJxEsOlXX8J1eLPFdIm6SZrfsj3SDmGQTWRF8MIsphiqQNocXEXk57fY55kRc7
	SlxEg==
X-Google-Smtp-Source: AGHT+IG2yg147JK4Oinx02ez69SdDMukiZsmWmT/iPx1WpvOc0p35m3lKJjL6O102z1pXoYruFzug+iTBIemqmhssxc=
X-Received: by 2002:ac8:7d12:0:b0:4ab:7125:99aa with SMTP id
 d75a77b69052e-4aba3e33f4bmr306580691cf.49.1753196338060; Tue, 22 Jul 2025
 07:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-11-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-11-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:58:46 -0700
X-Gm-Features: Ac12FXxT4R5nqDZoq6He5N2XHgjugFXTSeJd14lK7mmXsqA2ix7EK8BukOpBfNg
Message-ID: <CANn89iKo45xre19BCkTRQSym7WCWxAbXOD77+F35OJ0eubmdew@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 10/13] net: Define sk_memcg under CONFIG_MEMCG.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 1:36=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> Except for sk_clone_lock(), all accesses to sk->sk_memcg
> is done under CONFIG_MEMCG.
>
> As a bonus, let's define sk->sk_memcg under CONFIG_MEMCG.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
