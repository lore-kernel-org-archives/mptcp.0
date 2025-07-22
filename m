Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214022EACFE
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196230; cv=none; b=esafyMp7/7X9tnApVw3Bk3XSRjOjsRBP6wcS+2KMBjsL5hZd/9C5x2E5L7N3nxgPEla1XzejYkaaobfLlg+4JE6NRKqqjESBmVDhRbO9uSWUwU8S6MnpHk58pCgD/wL3Nz57MORP3LjX/C4AG6hrGC0Jujmy+73IX+C36wPG2T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196230; c=relaxed/simple;
	bh=m0AktCLJK+ZUuWGfQ+iSpRiQx815PM7rgLaWcjzgcEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODK/3hDhOPyUmK0bmp+Tt1fggfeKnDoqqKy6uqA9oM0XRlspcpbC8pIwU/qD+qp9fuYn+WnzxYhBmQtBpiYtSZLlNWQyHLB67TvVhH1lGC5vLilAsKqOJEQefuPg4YG5rvcauxiqKJ3bH/1afETG7S3o2d0IjmIFS3oQmWGqHgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aXl1bJdB; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aXl1bJdB"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab9ba884c6so69941631cf.0
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753196228; x=1753801028; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0AktCLJK+ZUuWGfQ+iSpRiQx815PM7rgLaWcjzgcEA=;
        b=aXl1bJdBRidRUlNc9LFXmqtOOpIVbMWfMFhO29jaT99qNozECY3liu36WnxNbNhgi0
         t3Dy/7ft/cB5a2b+pp0TvXW9XUxCPGO3q+mhdDlNvp4FZu2duRmpRV5PWoBkKIgowaUx
         kOA1QrWg0Jn5Lm3QaKmLHP8UPEywA6s0jD9zq10btZ4fbBK67p58TuM7rfqGbmzT8JrY
         OMtT2cXAvwi1PzI6t3P+7hfweXxklp98W8w865GN1ZpLPlCVd4R45pB1+YIdlcd9hCbS
         GnQYTjU7Luq5J8b2lHzlv5HAB5pHEp2HAExsTqtulOZ1xQH2BZ10n2jvT6yCwUNSaygL
         9YOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196228; x=1753801028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0AktCLJK+ZUuWGfQ+iSpRiQx815PM7rgLaWcjzgcEA=;
        b=miveGam/KSPvoNcsUOnwYwurN6DlUrB4S8FHRSqR/WMVaIng2QIYkY6WbgMz69vqqs
         isThB8UVStxYyrchkez3iHhS48YIpBXKQfVwL5BhfWMpJ2wFANCDl7jAuVzJkDSoOXSZ
         EArdex31ipQnRY9vSFI+JxEf5jqzzKoPPJpgvJ/jinkaJKcY/iJWwkx6wWtJG42jqPPY
         o24CfNCmB4sQA0ehla0X2xFpXqOM8YMgjQhwLQAwNRZfSRXCfJSIUgU/YMAt7b4wynBx
         Dc8wuW4F1ZppMShYYp753ztrXbgT1HO1QyEH1Xlul4epzD0oktSl6evIlN90kG4o4kuZ
         rXKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGWPe7AJBmfir6SlIPVRjvWJbXgdtwgZv1qiAwjJQ/xSNDJrljyV5yd43ypICwJ2H9oQ0evg==@lists.linux.dev
X-Gm-Message-State: AOJu0YziOuUKl6mLFAQMrGLTBkk6Q/1ZqiiFtxPDRO/vlwlY8kZO9Buv
	tfdMdwFq5XVbQE/flrxEgxNqvb7ndqOhBUQ45iRuZy77N9g2Jn9VQHpb6D7GwHGhJfCd8VLrojo
	ExgkRJtQzP+JnpN9YQAYEXmu7pYDBnXwEGYKElrMW
X-Gm-Gg: ASbGncsN9T+jzaQ43zhVKw1OxmebjfK4yQC8mfr4wLI7R+YjanAmkcFTn+k7v57EiwR
	6O+4S712V1Le+9iPCfnAU7Xpa2qm/8N5IX67rq6W0WpZGUIw2jkIXYUHhus73m/oc44pUipi9ax
	FVDHTDkvsaOXLJOCug0B1lVXosStxTzLQCHONZkDOlvB67XjkGg9AkYhwmgp80jobQBCq1/nc0l
	NjQYA==
X-Google-Smtp-Source: AGHT+IEsEV3GGTDTdmiKaik3AqH1VA1TZx7fA6+/n168ze76wf/ZMKc7syZqUWj6LZzqN2/qXmVi5AZltoQwXWaeFfU=
X-Received: by 2002:a05:622a:5514:b0:4ab:6e3d:49b4 with SMTP id
 d75a77b69052e-4ae5b776852mr47163651cf.7.1753196227557; Tue, 22 Jul 2025
 07:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-9-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-9-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:56:56 -0700
X-Gm-Features: Ac12FXzomuVijK6Zq5KT2dKkSJnghXUcZpgHafRcifrYJKvhd0CQdjVZBQvvh-E
Message-ID: <CANn89iKC-RJg8Xi1o6Ks4iCgrrwhvYFxDGwtXN0q0KM6HqAs6w@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 08/13] net-memcg: Pass struct sock to mem_cgroup_sk_(un)?charge().
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
> Then, we cannot pass the raw pointer to mem_cgroup_charge_skmem()
> and mem_cgroup_uncharge_skmem().
>
> Let's pass struct sock to the functions.
>
> While at it, they are renamed to match other functions starting
> with mem_cgroup_sk_.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
