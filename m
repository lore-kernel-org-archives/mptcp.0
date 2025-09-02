Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F772274FDF
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 22:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756851680; cv=none; b=gqe5j3REBHARIqDQ8TCEz6Qqd1VDlOQBR7QsuXZKUxuZc5xb1KiYRqHTxG+UdUfrfsPG1FzYtubLIhOf5vw7PYFQs3Pw4Y3Lgu98EWFBFm5WSvSyvgkWjY/r492JBFPM+wuzZIph2AGEPVmQB8iKfqUOtYAwHXLvPDNKxl0ckPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756851680; c=relaxed/simple;
	bh=uhrGdUwtX0TRrHmzp18ffizdjSUfmH13xn/mmFzf3K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scbQzWKQPdp7FfXsMNw3B6xhfagQPxcI/vM+8Ijdd2Mz3NlUk8vpIyd8bWSN8wfYoEMa6VSZ79muSyiDqBhmMSf16URZH06ggf2WF8ZzQCWYObukscLlCqFFdCMjmOkBPUqo9RK9cD5Nh435e0pMa6UcjTDrF4AYQ2V7L4zY31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=eBLrrrSJ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="eBLrrrSJ"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f6b0049fbso4926897e87.0
        for <mptcp@lists.linux.dev>; Tue, 02 Sep 2025 15:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1756851677; x=1757456477; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhrGdUwtX0TRrHmzp18ffizdjSUfmH13xn/mmFzf3K0=;
        b=eBLrrrSJJ5MdeRvpR7iV0XtgWDqx/ApH7r2RWw0VZk3yxpZhDENnRQ4oi4wI0Y7i0P
         gkCyJ8nfFsTjm0vPPlY5+fmhUzZzGjjUL0nMsfgJZMUgLjhzDGhglTHeKqr7Hrm6XQ8s
         yBHQrwT/1wvdKQ9LnpLAkCGfZo0PCv/WPcqe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756851677; x=1757456477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhrGdUwtX0TRrHmzp18ffizdjSUfmH13xn/mmFzf3K0=;
        b=vBInuMq+g5rOXD6IkGsF08kzDyN1BK3FOOcdXpg+q79rXkiSTklSP/NIZxaqtXDMOl
         oEmexrVwHjgt7BeIEeKqvSmUUwY/JLqmIjuBl0gkexBK9rHiVsjxeHNCUz7adVJu9YYk
         QXvLlgU8BItBs7bekCgvJmghfQNxk9eQ+MTznlrRYVni/xnh0Pea8AkQmzUWvMd/kYkT
         52mmz2v4NSKrP8fzS6CaAluWyLEqiD1xVdHzJGfP/6qHyuotpnG8AWjIspVdIlj11utx
         rJYHKAHwgAUyCiewCQlWc9tJkRnyURE5CizRVeWFccBqb3MmnR2CHvtYZbq5k3VLhdgf
         YGiA==
X-Forwarded-Encrypted: i=1; AJvYcCUOcZONKeN397I26OHxZZfeVKKH4eTt7d/cAB2OTq4dNUrm7fDToHG7aMVGIvj68COh81kGUw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxdgr5wrSiCsNHcoaZotVB34c/GYjiBY97DmJ+uT4P4qgLIHu5+
	h8yWvCifzxUaZq1G4bJg4iU6rnVWy+d6hXN7Ccn+IQiAjjSsMoEtyfzDtF1hptysPdwUuNvNaaR
	eiUUkx6L5U3ZqODkrObGoq2STFVDgGyrybX52wt+gww==
X-Gm-Gg: ASbGncurGRA6J+iQ7QGx+QkW3vzSXuqITSXjSZgHpwTCafLZqnej38Vk80ZAcOB4OT2
	bF1N4dKkJLDS2hBQI6tpKKrZzIyUF6HN7o+S6M/PKzVgbYiiuLwjZVeagxVjrAYvt8R8JPoCrVc
	DvKzREkvEC3VJquG9PRgWtPvlMigG4zpV0Wt/ZMXfW90GiYqh8GdMwj0Q1l0LloCndtACtTLIq3
	J5yNy1OmZEyYQvgUg4gzFDy2kDsp175sE08TULPVvmNHSxcs0yXYh8=
X-Google-Smtp-Source: AGHT+IFBza3hqagc0puDleD+Unkl9olkJ3klet94+JtsC9LdhtggFejId/AtdG7cn9nz3QYINpZRSm2wOlqELxCKl/Q=
X-Received: by 2002:a05:6512:1389:b0:55f:6fcc:6f4e with SMTP id
 2adb3069b0e04-55f7089c3a6mr4162223e87.7.1756851677166; Tue, 02 Sep 2025
 15:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org>
 <20250902072600.2a9be439@kernel.org> <834238b4-3549-4062-a29b-bf9c5aefa30f@kernel.org>
 <20250902082759.1e7813b8@kernel.org> <aLc2hyFAH9kxlNEg@arm.com>
 <d4205818-e283-4862-946d-4e51bf180158@kernel.org> <aLdfOrQ4O4rnD5M9@arm.com> <739c86b1-5cf5-4525-919f-1ca13683b77f@kernel.org>
In-Reply-To: <739c86b1-5cf5-4525-919f-1ca13683b77f@kernel.org>
From: Christoph Paasch <cpaasch@openai.com>
Date: Tue, 2 Sep 2025 15:21:06 -0700
X-Gm-Features: Ac12FXxOi9AsViKZtjtWxiVRlAl5eHnNmsfESqGUjGTMg6KF47joBlOhH8IUoMY
Message-ID: <CADg4-L-5f3a=3XCv5UaZG+47DHaO3NTk5+4mp-nWJ2rFXx-5WQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] mptcp: misc. features for v6.18
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Eric Biggers <ebiggers@kernel.org>, Gang Yan <yangang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 2:38=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> 2 Sept 2025 23:18:56 Catalin Marinas <catalin.marinas@arm.com>:
>
> > On Tue, Sep 02, 2025 at 08:50:19PM +0200, Matthieu Baerts wrote:
> >> Hi Catalin,
> >>
> >> 2 Sept 2025 20:25:19 Catalin Marinas <catalin.marinas@arm.com>:
> >>
> >>> On Tue, Sep 02, 2025 at 08:27:59AM -0700, Jakub Kicinski wrote:
> >>>> On Tue, 2 Sep 2025 16:51:47 +0200 Matthieu Baerts wrote:
> >>>>> It is unclear why a second scan is needed and only the second one c=
aught
> >>>>> something. Was it the same with the strange issues you mentioned in
> >>>>> driver tests? Do you think I should re-add the second scan + cat?
> >>>>
> >>>> Not sure, cc: Catalin, from experience it seems like second scan oft=
en
> >>>> surfaces issues the first scan missed.
> >>>
> >>> It's some of the kmemleak heuristics to reduce false positives. It do=
es
> >>> a checksum of the object during scanning and only reports a leak if t=
he
> >>> checksum is the same in two consecutive scans.
> >>
> >> Thank you for the explanation!
> >>
> >> Does that mean a scan should be triggered at the end of the tests,
> >> then wait 5 second for the grace period, then trigger another scan
> >> and check the results?
> >>
> >> Or wait 5 seconds, then trigger two consecutive scans?
> >
> > The 5 seconds is the minimum age of an object before it gets reported a=
s
> > a leak. It's not related to the scanning process. So you could do two
> > scans in succession and wait 5 seconds before checking for leaks.
> >
> > However, I'd go with the first option - do a scan, wait 5 seconds and d=
o
> > another. That's mostly because at the end of the scan kmemleak prints i=
f
> > it found new unreferenced objects. It might not print the message if a
> > leaked object is younger than 5 seconds. In practice, though, the scan
> > may take longer, depending on how loaded your system is.
> >
> > The second option works as well but waiting between them has a better
> > chance of removing false positives if, say, some objects are moved
> > between lists and two consecutive scans do not detect the list_head
> > change (and update the object's checksum).
>
> Thank you for this very nice reply, that's very clear!
>
> I will then adapt our CI having CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF
> to do a manual scan at the very end, wait 5 seconds and do another.

FWIW - I am able to pretty reliably reproduce the kmemleak. However, I
also tried adding an inline kmemleak scan to the test harness (did it
once with, once without a sleep). When I do that the kmemleak
disappears :-)

(not saying that adding the scan isn't useful, just pointing out that
this particular leak seems to be related to how quickly we iterate
over the testcases)


Christoph
