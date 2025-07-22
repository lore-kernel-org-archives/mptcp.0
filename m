Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606AA7F9
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195161; cv=none; b=ZUlRU95wlcBMOUd7RtTiSJs+c2X3u5A0I3VBsrsbyFOdkhbu0XkkXqDk6y0t3CBq729ACffirQPzchXvZpbnR6B6/nnzF0jK+fJA3s6GBfbVIi12lviaE2POmM/jx8Tq0IE5buXcb7+n/9Ta2rpM98ydv1iayvEMrGS9eQ0ACw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195161; c=relaxed/simple;
	bh=TfOWjAAjxzaPD6O6dTqgvPQKFnlN87Rl+iS0j68i0zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AF9J773aNKwKl6fdeIOpAGFtHPfKEEA/r+1MAJkmhNHodYXMhenBcEIMDWM83fn2gc++v9r1WqB2OILmd8hZqodxk7vsjqCqsfxrkBdjRVZNM7wnj0WlXjWWOKMUOFRbfnzD0vYkiKui3gRiX9dupwBn/6ZbNgpKM5XFHIzTfz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3yF+Yr5p; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3yF+Yr5p"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab39fb71dbso66454401cf.3
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 07:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753195159; x=1753799959; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfOWjAAjxzaPD6O6dTqgvPQKFnlN87Rl+iS0j68i0zQ=;
        b=3yF+Yr5poeygx1IESvJ5E4Hf87OeXFngUVjROf/xzQjMqxqVMCA4DsnL8nwpVS5MJz
         hccAKIWUIVEbDiFhfNYw8IFXhw1By893X6Nae0GlEBEGSB2/+w0MdqbTvmdW0lxDSVxZ
         rRVcr2N0s8dRkKcUu4Vdp8+Ye8+DVPdaRJ63F9O9lOs2+YhsBfHLRPyoKypffdfNPnAk
         3+0+HQHQ5ArJ1aX1juw+/kYlJprfKdzLPVeTz5u/V5uXj86B6Gfb5E6T0zMxfoO7Df4F
         VNZ8Bz9nD8jrWt7qJuI6/np4xx+AEur3+ziL8pjJjXwNhtu8Gg828D3oRCheVlPNDROr
         PNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195159; x=1753799959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfOWjAAjxzaPD6O6dTqgvPQKFnlN87Rl+iS0j68i0zQ=;
        b=NYN08OHN2xBDZ6t9ET+aCstyXfNe/Tlo0K3E299zgkN4OFCO1ILxIf/lgWS+HEYsjP
         Q0n/FwvO+/qgnXFAE4VXgtQLAN6WfDEmTwXYgqb8We9AMOZtbS28vVjeJtOVYFwBJD7V
         k9rFhkjyLN0fh/IYc2MzuAmIOvRWTpzPUHRUw603xvOClIis6Huo8bwFoPTPCLGNSO4U
         qye+ja0y5KtNePaArjKeVMM17E0lUvJKCxbdhRc2a+qAROiRTHrw9WvRTTu+e7oItYdL
         fxxyKSndsxg6e4WmZ473G1ivSfpUG0pbyoKXfSH+8HnMZz2pCgISb9503K/FuC+bxVqO
         tt+w==
X-Forwarded-Encrypted: i=1; AJvYcCUVPNFTsPwiOb4p0FCz2pM4TmG3WkmaIB1XCxFd3FMK58bwDF76cdYP5NXGZEpZliuwaUXYVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsvQid9SBYpxOGroL2vSQG3k0cfBMgkDJFf+9B0XO8Vz0yOrcP
	ac7ZE+VdS5Jhn8aQ8Goc5F4eQPsG+/IXQmG1u9UFsuVFpatBBsplO2J9n+1zVt+xOqvcvTDf79Z
	/OEreU403NysUIucXxPSBy2RDfzuDA9lOwqzn+kNa
X-Gm-Gg: ASbGnct/WAZqFRjIo6x5jqxdfFT9Nj6kdz2N9fa/ABNnPZwRsCNCZOkcB7H2d8kUvbi
	R60rO3uid5swLDaUGENN3UUbD/DAFM1QpYv7AfjlteQKxo+jk5wD12KFa1TQoauq4veKTqjwVti
	/1tUxJ/Tq/c46CSyTiY1IOGkRpp/+Vzj+66DWIATGoFOnqVOf4q+XfgbZDRHhzNq3eAVo0hWlCc
	DuxPaCHc/5KNq0e
X-Google-Smtp-Source: AGHT+IF/6P41Pb82F2ptVRkEzRWcH/wqc08aOFULaIn2GgGXH6mVUvBywwrKZk8BZMD9A0/6nMaxFzoslrPlJkLFRIo=
X-Received: by 2002:a05:622a:2303:b0:494:b1f9:d683 with SMTP id
 d75a77b69052e-4ab90cb6a40mr389467931cf.49.1753195158828; Tue, 22 Jul 2025
 07:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-7-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-7-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:39:07 -0700
X-Gm-Features: Ac12FXzzmBrUziOnhdn3RLzTJezLALGw-_Gmb0DoUXsN9KTiXNdnxPTcE5y2_MU
Message-ID: <CANn89i+qss82KMGJHKf-uMgrwFHXap9fs67+2azrNeBVpsVodA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 06/13] net-memcg: Introduce mem_cgroup_from_sk().
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
> We will store a flag in the lowest bit of sk->sk_memcg.
>
> Then, directly dereferencing sk->sk_memcg will be illegal, and we
> do not want to allow touching the raw sk->sk_memcg in many places.
>
> Let's introduce mem_cgroup_from_sk().
>
> Other places accessing the raw sk->sk_memcg will be converted later.
>
> Note that we cannot define the helper as an inline function in
> memcontrol.h as we cannot access any fields of struct sock there
> due to circular dependency, so it is placed in sock.h.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
