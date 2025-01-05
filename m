Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D20143C5D
	for <mptcp@lists.linux.dev>; Sun,  5 Jan 2025 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736095954; cv=none; b=f1rEszPZ4ENw5Mc8TYpVSMc8Is4UnhAqJDutQ7tT7AiFr8YxWSF0kAyDJY7o2pLp1hyp6UP4B/Ed/eL61Dpiq0cRGb2nVCTwK90yDQCBzR54K5qdfxZ2Lr6EYyUZsL+/PUx1ntIDUxrIW9xM6kvnQztFl91v/AzRfrt0cUrpiHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736095954; c=relaxed/simple;
	bh=Dtugm41CHFmw25wsp1PeXN9gbITuWzhW/lNcqTncoqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgJxOT7d6ptKmGI/SOgjDKXiudZAFv181EnU4KXpg6u6lpfrp/KIfnCC3DsWoveGqZ9FPKMrXr8sEhbv/9Nx8tPWoSwZ2I6wlxavqziOpXqgbAv7eQGBOuCBUIfjt0M9MOIveHQJuQhsdJezlIidCW/qu7YUpx8JPpxlQRtp1LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iPtcoQCb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPtcoQCb"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaec61d0f65so2277771766b.1
        for <mptcp@lists.linux.dev>; Sun, 05 Jan 2025 08:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736095951; x=1736700751; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dtugm41CHFmw25wsp1PeXN9gbITuWzhW/lNcqTncoqg=;
        b=iPtcoQCbRsq0Uzh8wcsXPh71JOvj7JWe3co2k/g5wJ6N3K43MUawLt2KQuDoVF0Q/g
         rZhIDusSi9wEoDesjLoqaq+lhNOfM4z2Ky4NUoYJv7Q6WF+nhfytJQgAg4ve/52kobqS
         YUo4+BKmH/3zLRfY/jxYzYCtug3L7ZrBzEOSMCjmjZmsCk+6m5KTtW8F5Wdwalzr/vLL
         XYI7mBswhgy8bmAfgLQGdLBlCPxlJtww2NHK5wfhtd4FD941+KQ8fA7PdFB6hqfhHC4J
         ohbEtSt1WGPFIAZR/c43xN41Q4dcRbRy06CpceQo6CAB7xsK+++BiMXKwGJdvuqrymzD
         ohPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736095951; x=1736700751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dtugm41CHFmw25wsp1PeXN9gbITuWzhW/lNcqTncoqg=;
        b=Z3PURckyMPkomT3RLjXI6qBLgkZsEZ5wkKNrgX6nvaKuSrgXU5Zi1Q7IZtpwFQpRQ0
         qYrj7QoCar3w3Napetmx5wLUICGrdqWEzupNQPKy8EMoNZzNVUkRC8sa2Nb3rUl2Y5S3
         pTWXysAgi/FTWNIM5R0W297TQJep9jWPMwWDHgG54aAuFJsnCy78tyzjtXeZ+9njlLX/
         XYOx1Ks/VZdYjLbR23rqEt6aiaKlUg+kFAgktWVZezd/WIw+fdkGrxQLgjNN85/NXJ+f
         Za5QUla5wROIpYo1Zxh6h14Ab2bcWarNxQiRpHLE9o2j9LjBd7b/+HOItHpeo4rXP4Xn
         PKqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaZAyW8U7KAvLDr3qVLCGXS6s5IbT6oMXSaKpMTjkqZg+iHeFeIrXRUTy0jGdXINzwXRR2jQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnsMCiDr3jzdoySqIfDRaaJroo032A35EEqvs5oHxjfUNXasW7
	bK2RAc1oSc1pTmguNlrrE0sBesUXwfPxcUdB6BaI7CvyJGiNbRwyeOMxCNX9MGA+8LaP3sBxa6/
	m3RGnycWnY+LoM+eTJHaSkSjC+DqHaVc+4v12
X-Gm-Gg: ASbGncuIUHxMiOIMwUBvnYPn4LymNIi0LcPU0424fhgiFqMyrIjvntOCK+P5kJv9IsP
	LfFk3AI/SC91eLJ02Ww3xIS+pryzy0GOB/wDm
X-Google-Smtp-Source: AGHT+IFpVe57pf6uqdx1jNk+2HFr/fDmVd030sEXi/vTLW2PwQOIIktibZHMK/bEEbPc0zMwr/a5yGRXKHTGw866Yxw=
X-Received: by 2002:a17:906:7311:b0:aac:278:98fd with SMTP id
 a640c23a62f3a-aac2ad80073mr5265928566b.17.1736095950991; Sun, 05 Jan 2025
 08:52:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <67769ecb.050a0220.3a8527.003f.GAE@google.com> <CANn89iKVTgzr8kt2sScrfoSbBSGMtLLqEwmA+WFFYUfV-PS--w@mail.gmail.com>
 <cf187558-63d0-4375-8fb2-2cfa8bb8fa03@kernel.org> <CANn89iJEMGYt4YVdGkyb-q81TQU+UBOQaX7jH-2zOqv-4SjZGg@mail.gmail.com>
 <20250104190010.GF1977892@ZenIV> <89c2208c-fe23-43eb-89ef-876e55731a50@kernel.org>
 <20250104202126.GH1977892@ZenIV> <CANn89i+GUGLQSFp3a2qwH+zOsR-46CyWevjhAQQMmO5K9tmkUg@mail.gmail.com>
 <20250105112948.GI1977892@ZenIV>
In-Reply-To: <20250105112948.GI1977892@ZenIV>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 5 Jan 2025 17:52:19 +0100
Message-ID: <CANn89i+L619t94EybXKsGFGQjPS7k-Qra_vXG-AcLJ=oiU2yYQ@mail.gmail.com>
Subject: Re: [syzbot] [mptcp?] general protection fault in proc_scheduler
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthieu Baerts <matttbe@kernel.org>, davem@davemloft.net, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 5, 2025 at 12:29=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sun, Jan 05, 2025 at 09:32:36AM +0100, Eric Dumazet wrote:
>
> > According to grep, we have many other places directly reading
> > current->nsproxy->net_ns
> > For instance in net/sctp/sysctl.c
> > Should we change them all ?
>
> Depends - do you want their contents match the netns of opener (as,
> AFAICS, for ipv4 sysctls) or that of the reader?

I am only worried that a malicious user could crash the host with
current kernels,
not about this MPTP crash, but all unaware users of current->nsproxy
in sysctl handlers.

Back to MPTCP :

Using the convention used in other mptcp sysctls like (enabled,
add_addr_timeout,
checksum_enabled, allow_join_initial_addr_port...) is better for consistenc=
y.
