Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6A52EA748
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194624; cv=none; b=PZjuN6WZQYcXErX5Pir7GcEAXb3UPCRRgFFiB6r4GX1izKpKf8b8TfG1CTHtnYo9TAZQBZ48XhUiQSGGLM3I8GxcBfkzECmAYmvemjC3sum+apg56Lw38uWZkKUVrQXoayqGIlKTiCOZhqgXkIoGvcfOd5CL3FMqXVEDeZSTAQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194624; c=relaxed/simple;
	bh=g8o6ReDW6MUKFXt64vm9RKofRiF0JKVVbYD+Mf8uO7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHud9J/p/ZUPffStpG/fCG8yRwNFo3hIHgoyDLJg4ohLx3iaxkeoqID5dLoM+MKqWev2yAMMBbrONL9IBwYMKl+4RdSxw+UM7NltXWIrseuFhmIO9/LJXN/2xBb3vO+EPshIo91LMBy7jIEDK/VJ9oyrztncIKLomnFFXZe2QRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j3eooSfV; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j3eooSfV"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4abc0a296f5so48639521cf.0
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 07:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753194621; x=1753799421; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zs6B7ByVFqNhd4M7cO2OVqmSjId/nOtkp1oMTcQiG7s=;
        b=j3eooSfVAFirzz8CvQAqkd5+IIfYlB5rmw75/oJn6NS00GFRcykjnNv5Y1qrZhlRJf
         k6ky+S3xP79Mg73RI8IdWWvWF8peDuOUAxBbJ6I7B4zwj6/PjzY13P0rEPMhnmLdy9zw
         uanKpicItC+/lHdGtzOnKmQkWC9Gb7BPKauM0zqCF6GvFjk2bC8//IpZBwal2ehXImZB
         4ojJa4Ruuzugx5gRCcIUeurSSPqKwjM5x1PvKHmFQH9a2qi9WWL78hhFqV1P0sKTlIQO
         sq0NwDkRb6X48/SJXuDobdLn70BoQibybjeVG8IWip3cuznnIIwq4VXPx/Rh11+RvInE
         Jn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194621; x=1753799421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zs6B7ByVFqNhd4M7cO2OVqmSjId/nOtkp1oMTcQiG7s=;
        b=iBEFLliIrRdw3MbW6+pwC5VSXUtWLSkfK9ynnJagXNYWz5TQAOBRhB/KlCDJbvykVx
         o41SX/lyfTvKPYG7rv2eUFIdj3F1yKNs+9G2pt9ieEU4zK4UEnfhF19u3QXof8WXW58z
         zqtbQglqmBabsQA29Naxlt5pDvHMg+PsuxQu0Qlo2oU9nz32H1hP28r00KPJ7NfnYB1g
         o49YkrB3D5nwdP/RhCGz9Er+elCYYE3SiGhPgZxWp43dN0y8+1Idbsb2zQrWkeSPjcz3
         sUAt0y/VD5DieZHkGpEtkVuyKvTAFN44tEzD0PX4bW9slt3+ZXPiVjUzYqk6gASe5SLU
         NzUg==
X-Forwarded-Encrypted: i=1; AJvYcCWYivotvPDWDv91eXqWXGzo7P6/yIWl+aUtQB2/B9Njtb07i5m5O68D72W4Ydk4BNXh5hSJnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxA5DzfTXq8Ph8x46u9m5faCr4zzqmVXAZaUIeVkPWekNAr1ewV
	3++bacbFX1O6Vv8gbZfJlW+v5Uva++uQoOtgDhXfftokA1rhdTx9jLLvZr91/86ek0fRH06Jxq+
	p4Ak1AlSGfq/AVPP6JIAsKYFZbVGDTqKcRBUVYpOk
X-Gm-Gg: ASbGncsQCQ/ZTwfbguYTb984n2GjdurQCE4VksA0TnqSqrRhpdf8Pg4mj7CtnStvnlJ
	M8KCPOvwoC/uQuhW/8AEdMx5B8fjJnhTI60c+kvb/ugRDtpfAlOGmSgs3o6JnLIWo0wUiboM9h8
	jItS2pZZcqsbGT8sYyDIEpZ7WxLQvW+4UOX4ymK2Ju3HcZjqFsQcI1adj0HDlERWtJHYveu4YHt
	VBVQZXw0FCXb1ar
X-Google-Smtp-Source: AGHT+IHQ1F/XNS6EEtYUtpk/olOEZA/Va6cGJiS4hiBQzXMnDQFWPRfhrIeUbeCE+v3wAGiJbMRJO1Xiv4/aKrsvrGs=
X-Received: by 2002:ac8:5d4c:0:b0:49b:eb1d:18ad with SMTP id
 d75a77b69052e-4ab93dbed7cmr383658691cf.41.1753194620995; Tue, 22 Jul 2025
 07:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-2-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-2-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:30:09 -0700
X-Gm-Features: Ac12FXzou9QrF6H0tl3cLlJlr49JVeNU-g_6k8oOer2kAmc56xaiC2vvAezaFAw
Message-ID: <CANn89iJQ_CDgAsDQ_cZC=fJJ9Vk5+Yk=RmmS=r3ds9abOqr-nw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 01/13] mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
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
> When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
> sk->sk_memcg based on the current task.
>
> MPTCP subflow socket creation is triggered from userspace or
> an in-kernel worker.
>
> In the latter case, sk->sk_memcg is not what we want.  So, we fix
> it up from the parent socket's sk->sk_memcg in mptcp_attach_cgroup().
>
> Although the code is placed under #ifdef CONFIG_MEMCG, it is buried
> under #ifdef CONFIG_SOCK_CGROUP_DATA.
>
> The two configs are orthogonal.  If CONFIG_MEMCG is enabled without
> CONFIG_SOCK_CGROUP_DATA, the subflow's memory usage is not charged
> correctly.
>
> Let's move the code out of the wrong ifdef guard.
>
> Note that sk->sk_memcg is freed in sk_prot_free() and the parent
> sk holds the refcnt of memcg->css here, so we don't need to use
> css_tryget().
>
> Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent cgroup")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
