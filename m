Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F1111BF
	for <mptcp@lists.linux.dev>; Fri, 25 Jul 2025 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469471; cv=none; b=K4qgGGafRvII9yOFtOUvL2HQzWXPc5c2qUHYO0hDhwEGlRUvOynKUHMeO04y1HfOvPFPfKWOvqtnQmNbvrbcakvbswl73iisgD4np0U7UkEybb87TDd4QiYp+raMbKEI/rT856xgJiAlGWEctSS9LzLbciDV+1pfXMWZf5PwcCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469471; c=relaxed/simple;
	bh=TQHVoOjY1yX/FYnoBKnhFCXugdVzoqtPM2+jcNrGPTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZEkTgQtEOWUmWrU02zjLCZU65F1D8IZOCxRMJnK56R8GTbJ8ED52mi6e4y4pNR+asiSYoG9wr6LCoczyEv9amma4QcsdNIjLdi2w3fXklZQMAFkDpGl9lKiHfCfcrRk7CmChbj9qmyjqZ2auv8Qf8eJ13YlDhE6NG0lowdPjB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=acEj+slr; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="acEj+slr"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31c4a546cc2so2035671a91.2
        for <mptcp@lists.linux.dev>; Fri, 25 Jul 2025 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753469469; x=1754074269; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZ6hAPUzBtzPSujGKOEvPiaHOeXzLH+v0q9XD3SFU4w=;
        b=acEj+slrqI8IKg0v8asVn4aJvS5y0TVxQa/JGQTL808Gv8K+ym4t6mJPneDP2O4aHv
         j+fp3/kl940GodKNDy/r/7BBjZd9lcAuI4WAMD4mXksQsgF32/jMCUcBU/8MVZZmbqVn
         Deqf5zplPMd8y2W8wT47W3SwQ/z9yuk4xBdBeyQ5nZKQDMObklGlRARiFDmzjNhvarn+
         TjEVb0NiOCJPJu3JNIuzQntxPd7JHHjb09naZoqU/CJBMiJUrHcLqJYHMP73oLqeLzau
         xuW/V8Hxx55sg15oyiqqZjflcIo9EBcVgmA1C0LXzNpg3XTz4Q0pYhkKWuEMgnTzZIv9
         6jGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469469; x=1754074269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZ6hAPUzBtzPSujGKOEvPiaHOeXzLH+v0q9XD3SFU4w=;
        b=aaXKu/6eRDYqGj0CjG/Ft+i0PzH4TTtlQzNto3kNgA7ZUjH5qncPql2Ccue/YT4ygO
         nzbMo0vZ4P8whA0mMw791eXa+5Cpy8tBnFXuB1qGMXmdGqJnCEH1RwlJ0NNQcb+tEMu2
         FcjY0hmfZbous+5GxTcmwbRyHKfp1aUbAhaKJAAD59lyYIdDGZ+NTsc+OMP7qoRdjBqO
         aJFiEjG7A9MAqIBqn5mnQG4Wnx7t76eW9nciihAWA6wR2OESn0UX+swecdwY1Ke+RmIb
         mQj4s5Oz9qqzbUQScMvK6FL3YbzBYot3vuuQb32vrF2pw6rbuzGEXCybTtj3pRmqHKGl
         I1QA==
X-Forwarded-Encrypted: i=1; AJvYcCVtV9zoNhvB90PVCCfgsbsHb0A3JJq7GZ/EaBrsmAXWdgKhjBClklooKy2Nt47a5BT47V/uAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzF0nFYwg3y1bAbTGdx4qwcV3orxnDW/ud9qZ4RhbBlkOdNPqch
	5sxqVgmCDP903SrfW1iyE2MitRFbfyozUq3FRIdMm7imfhPY8xHFqZKhbPhQLpqP2EMRfIz72B/
	CrQMoo1s8VIOH0LujItlyQm5kzj9z6tjUGlDg/q+9
X-Gm-Gg: ASbGncvGg0Mr9XJws9BUha37e871j8P8F5za8vQTnIKz2y9G+Ja72VZrWV9908R68nD
	3mM1X8AxHF6mCEc9Ayd8+tCC4BNVmU3J3jekv+NSnCwfo2UZPPAdWfaQHWMETaxgKgYjtSRrX5B
	d1WebjY3TcUB3flFhXnrwXJ4R0QXkOtKIdjwUwWqx0btHJhK3n1evxSD/XBMt6pZd94gKRbdFN9
	jYBihasuqNapCD4s5OP2w8IKNx3cBW5Yp2MGnE6vBm2DxsiR0k=
X-Google-Smtp-Source: AGHT+IFEO1MlBFe5fjVyy37Qgo8ReyTHSJ+VMkvacLifnhThyPfeUMVv64i2gb7SZvTFd27/Wgo6PmPyxhgCmiXTHZ4=
X-Received: by 2002:a17:90b:4ac5:b0:315:cc22:68d9 with SMTP id
 98e67ed59e1d1-31e77a4af86mr3944453a91.31.1753469468550; Fri, 25 Jul 2025
 11:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
 <CANn89iLg-VVWqbWvLg__Zz=HqHpQzk++61dbOyuazSah7kWcDg@mail.gmail.com>
 <jc6z5d7d26zunaf6b4qtwegdoljz665jjcigb4glkb6hdy6ap2@2gn6s52s6vfw>
 <CAAVpQUAJCLaOr7DnOH9op8ySFN_9Ky__easoV-6E=scpRaUiJQ@mail.gmail.com>
 <p4fcser5zrjm4ut6lw4ejdr7gn2gejrlhy2u2btmhajiiheoax@ptacajypnvlw>
 <CAAVpQUAk4F__D7xdWpt0SEE4WEM_-6V1P7DUw9TGaV=pxZ+tgw@mail.gmail.com>
 <xjtbk6g2a3x26sqqrdxbm2vxgxmm3nfaryxlxwipwohsscg7qg@64ueif57zont>
 <CAAVpQUAL09OGKZmf3HkjqqkknaytQ59EXozAVqJuwOZZucLR0Q@mail.gmail.com>
 <jmbszz4m7xkw7fzolpusjesbreaczmr4i64kynbs3zcoehrkpj@lwso5soc4dh3>
 <CAAVpQUCv+CpKkX9Ryxa5ATG3CC0TGGE4EFeGt4Xnu+0kV7TMZg@mail.gmail.com>
 <e6qunyonbd4yxgf3g7gyc4435ueez6ledshde6lfdq7j5nslsh@xl7mcmaczfmk>
 <CAAVpQUDMj_1p6sVeo=bZ_u34HSX7V3WM6hYG3wHyyCACKrTKmQ@mail.gmail.com> <20250724184902.139eff3c@kernel.org>
In-Reply-To: <20250724184902.139eff3c@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 25 Jul 2025 11:50:57 -0700
X-Gm-Features: Ac12FXzjvKxZZ0TfulEtz2NxOb7G3ZS4IGZwElHwLN2QtXZe6QR7perh8RBHOCY
Message-ID: <CAAVpQUD36Wq7xcmdpeqCb3qpTzR7ZUDa=U4rUrfy7+JiE47Rsg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Eric Dumazet <edumazet@google.com>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Neal Cardwell <ncardwell@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 6:49=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 23 Jul 2025 11:06:14 -0700 Kuniyuki Iwashima wrote:
> > > 3. Will there ever be a reasonable use-case where there is non-isolat=
ed
> > >    sub-tree under an isolated ancestor?
> >
> > I think no, but again, we need to think about the scenario above,
> > otherwise, your ideal semantics is just broken.
> >
> > Also, "no reasonable scenario" does not always mean "we must
> > prevent the scenario".
> >
> > If there's nothing harmful, we can just let it be, especially if such
> > restriction gives nothing andrather hurts performance with no
> > good reason.
>
> Stating the obvious perhaps but it's probably too late in the release
> cycle to get enough agreement here to merge the series. So I'll mark
> it as Deferred.

Fair enough.

>
> While I'm typing, TBH I'm not sure I'm following the arguments about
> making the property hierarchical. Since the memory limit gets inherited
> I don't understand why the property of being isolated would not.
> Either I don't understand the memcg enough, or I don't understand your
> intended semantics. Anyway..

Inheriting a config is easy, but keeping the hierarchy complete isn't,
or maybe I'm thinking too hard :S

[root@fedora ~]# mkdir /sys/fs/cgroup/test1
[root@fedora ~]# mkdir /sys/fs/cgroup/test1/test2
[root@fedora ~]# echo +memory > /sys/fs/cgroup/test1/cgroup.subtree_control
[root@fedora ~]# echo 10000 > /sys/fs/cgroup/test1/test2/memory.max
[root@fedora ~]# echo 1000 > /sys/fs/cgroup/test1/memory.max
[  108.130895] bash invoked oom-killer: gfp_mask=3D0xcc0(GFP_KERNEL),
order=3D0, oom_score_adj=3D0
...
[  108.260164] Out of memory and no killable processes...
[root@fedora ~]# cat /sys/fs/cgroup/test1/test2/memory.max
8192
[root@fedora ~]# cat /sys/fs/cgroup/test1/memory.max
0
