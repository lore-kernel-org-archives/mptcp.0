Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4C62D3A86
	for <mptcp@lists.linux.dev>; Mon, 17 Nov 2025 10:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374916; cv=none; b=Q1i6TyniOTNvHb20msttGnrh9+7k4UeUSxn0/pu7iKNQbAeH1j0pPu3dTfdNxdh58ZK9SsG6lGvPQcvcTXX3IlUcBYrcQoyuDUyIuoSA6TO8qtYPeWcMZoeaWJkQ1MjveUD/V7MRU5UCjeZ5JdZtgD3drxAjRQPawgLqwurdKaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374916; c=relaxed/simple;
	bh=CscepbcOC8+QzaBdcyDmuDNMM7WVrlZmU0atPfWVUdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFF4dBbUdfZhQjd7nmaLQ8wLwkjVoWMisd2PwkhvUqqRStHSF+aX5RKLC43WaGoqVWiYciG5I/bZtpSPHVv8yPv/mgBTKHitYzCF0GHIk4zszm92UTm00TMZgZFDF4d7myu6XgotvRpkjtoOyi4TjjPvwUczzxNA/ZUdmxAUTeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JtGrdsbl; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JtGrdsbl"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4eddfb8c7f5so41559471cf.1
        for <mptcp@lists.linux.dev>; Mon, 17 Nov 2025 02:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763374913; x=1763979713; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CscepbcOC8+QzaBdcyDmuDNMM7WVrlZmU0atPfWVUdI=;
        b=JtGrdsblkZGXtFtVu3X3+Z7nKfhcKFpl5ktdaC567oI3OX/4kSKUCz1zARHcM8eQGe
         v/t4kqyeDM3YWCKt7jGg4xD+JSWq3acXlSgJ7N+isnPcEjYvuy3UoONnwsPacFX8iR2s
         iLBIf9j0AVufTYrpqt/B6VhIk2NW3gHg+1h/+L364hhfBZJecSjYPYSrhCOOd7vkwFWh
         QcTt0D2mlG0t+SbnGnQi8Os2uIxRYd6rsIHnTTGswita3laB0hm1jAGxXQM20WU7vrzb
         jWGjisfpgn0H2LkC4BoZBaxtdDSyX0LoRApObQa6+Li1mlgPveNIPeUUAmE09CsIj4eh
         daNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763374913; x=1763979713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CscepbcOC8+QzaBdcyDmuDNMM7WVrlZmU0atPfWVUdI=;
        b=OHW8NNaG2QS6KXUAqQrAfwybFleTD2oyMX88nC/NjGGoIRTLNTUq+zs5lo5Di1cUb7
         +TAHIbmO0/ozjVSqScWqz7yq4hkh6eG+8e1OLu91zPROKd/YVh7k4s3DwHyrt0Muk8En
         24Z4aZNGaaQV7W1sicNB6vNVpelWz7JNp6RzLsw0Dv1+eG8aJWkwkQ6uOWRXTzD5DAGc
         zeTnDD92mGBrnG5JAsYyAC7tkj5uyvRydOjgE/WYMy3fBxAGZ8o6vc0mN56rxgKqLsOu
         QCuiAQK7SNeMwmwi0ieL2cGQeEIZS+WizBADCljj/nQY3Ja4iMhvD3iYUa3GZqtub7OG
         /IyA==
X-Forwarded-Encrypted: i=1; AJvYcCWSuTeH7s97YAwhEQjBJfZGTuhrHrC+K+khzZDSjaAGwFFC5HndBbsBA5VSloZ9Vx5VDerd6A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7vxWBADEoF8XHkiYxRddhJj7JEEM0QoQdKsT2QuVcksuMMAjB
	O1G2Slxquz/E83xXpYM//gBkl6AZkO7laHE6lBuKH26w+r+rTzXgMFah1l/uhYa2A74rI0K40vm
	Q6kfk10cIYxmV1D4KvZhRcjZ4DylHPdIMedpOGxMj
X-Gm-Gg: ASbGnctkDtSeiZOuyext2grKPjl5vpRsoZk8jQtd+znkzT60+G9rBSzNrXSSTGsB0E+
	JKOZF+9jLCU5C03BwWAOK7VSjdUQupvAHUg5erL1tUmMF/xdlxP7os+4mYYdjL9Gr4YsAt4AUxz
	om3dwJ9uA0anK1dUJNkdP1jVi6aH3hO6z1vmAn8DSblaxwJlUZyR0KGvtFM0H+MJCMMW/9s5arr
	mdJiXs/sz4DtYXVQCLviJYAm6sJSSk8mYQVptoI0KXaI8BHsj9iiSgNWXlmFaeiUiJFfd4=
X-Google-Smtp-Source: AGHT+IFuyeGLLK13zsnocUzaJFJkkgmncQZ5EJyPpMfJYBBiLNIQzzaWJF6Xzmc1TFVxKe5vOTDTGf7jMugC9Qgz+cc=
X-Received: by 2002:ac8:7dd3:0:b0:4ee:2541:6540 with SMTP id
 d75a77b69052e-4ee2541b583mr19702501cf.55.1763374911520; Mon, 17 Nov 2025
 02:21:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251117100745.1913963-1-edumazet@google.com> <c378da30-4916-4fd6-8981-4ab2ffa17482@kernel.org>
In-Reply-To: <c378da30-4916-4fd6-8981-4ab2ffa17482@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Nov 2025 02:21:40 -0800
X-Gm-Features: AWmQ_bnU5NstPoC22fhtPKBluYRKne26knFThnGv-8-dn_lLDtNWHNSVtBVnj30
Message-ID: <CANn89iLxt+F+SrpgXGvYh9CZ8GNmbbowv5Ce80P1gsWjaXf+CA@mail.gmail.com>
Subject: Re: [PATCH v2 net] mptcp: fix a race in mptcp_pm_del_add_timer()
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@linux.dev>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+2a6fbf0f0530375968df@syzkaller.appspotmail.com, 
	Geliang Tang <geliang@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 2:15=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Eric,
>
> (+cc MPTCP ML)
>
> On 17/11/2025 11:07, Eric Dumazet wrote:
> > mptcp_pm_del_add_timer() can call sk_stop_timer_sync(sk, &entry->add_ti=
mer)
> > while another might have free entry already, as reported by syzbot.
> >
> > Add RCU protection to fix this issue.
>
> Thank you for the report and even more for the fix!
>
> > Also change confusing add_timer variable with stop_timer boolean.
>
> Indeed, this name was confusing: 'add_timer' is in fact a (too) short
> version of "additional address signalling retransmission timer". This
> new 'stop_timer' boolean makes sense!
>
> > syzbot report:
>
> (...)
>
> > Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
> > Reported-by: syzbot+2a6fbf0f0530375968df@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/691ad3c3.a70a0220.f6df1.0004.GAE=
@google.com/
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Geliang Tang <geliang@kernel.org>
>
> The modification looks good to me:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> While at it, just to help me to manage the backports:
>
> Cc: stable@vger.kernel.org
>
> > v2: Updated/Added Reported-by:/Closes: tags now syzbot report finally r=
eached netdev@ mailing list.
>
> Out of curiosity, is it not OK to reply to the patch with the new
> Reported-by & Closes tags to have them automatically added when applying
> the patch? (I was going to do that on the v1, then I saw the v2 just
> when I was going to press 'Send' :) )

I am not sure patchwork has been finally changed to understand these two ta=
gs.

>
> I don't mind having a v2, it is just to save you time later, but maybe
> there is another reason.
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
