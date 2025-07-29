Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA8F1A83ED
	for <mptcp@lists.linux.dev>; Tue, 29 Jul 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753798972; cv=none; b=rnOh/u+Ps4CMwqnC96sMizhEmU3WvpTnotdDBNDaAH335MN9QYFH2rZnOPQOL4jje3+avpAPQYJoHMjDBlLn42VBKzYexLSCndllVD7dHsaasgP4N24yVdo3mBhQ3xz+szsmcN6jNH8PNGYVDR75eg0LtfeMAdI38XP17rnw7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753798972; c=relaxed/simple;
	bh=n/B1V47tIX2IzjUKv7W7NbvhxGtBrYglLmbZLfK4Y84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMkyUl0O4a0hK8y5Qyk2iPljfNA669CrmuYSqWjTnJGmf3IykgpvRs4sbJIRsz3yDR2puTWOM+yaVSxySCyu+MusVkc9oFZisasXClU85k/00v3cBSIlWHXc5TrYAeiz3xfhFYxRTk8FMvroIsg08ae0vJSufr8JYvhm5Z73b8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=vqlIU1dp; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="vqlIU1dp"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab39fb71dbso58128541cf.3
        for <mptcp@lists.linux.dev>; Tue, 29 Jul 2025 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1753798969; x=1754403769; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=COkIEuiWzegLgJMToflCtnJ3/8gZZNZmKmrpqxdoDwA=;
        b=vqlIU1dp6VNLHHdtpnQoBwg9aeimJbeFO1GRRBh/WAx11KzQ6IurNUErydUKEC6ssM
         j28Vgurkgq7MZm2YasNO+xqntD2o0EC8XIf2mIhE34+XL8cF8Q4J/7nngPSQkvVmtsd8
         nP1SvSbR9FCBFJQ6d7n4jmL8WnsfshbcuktIZe4/ahHStCVT/I4WEWxLTR2KewVoN23v
         +WKdCaKzQkTj0z77gXCoQL/EtseGvi/Th0Eh5adSTxMbwQO/G0km8y/qIO+QzkfQFLMI
         HN/KxS3jI/v3l4Xkkb+BdYE11eAxdHz3n3vWyfzkn5TBaW51aGJYlPrMFZVirSFli6gu
         mZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753798969; x=1754403769;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COkIEuiWzegLgJMToflCtnJ3/8gZZNZmKmrpqxdoDwA=;
        b=YkbL1cBjai3Ji66rVfFA9HG65vuAEbO2zKGrNu9JsG9bLQnRw7Q4SuBv8uT4JnUSNE
         zlwqgWG1ckKRqsyxPIobXPePxzT2FPl4/0ncMemy4uAljLAWcEzvbZ9Vcbhs7HDeP4Sl
         VlzoLHZUK9TbVemRlZ1UklRbN6LmQTqEve+l1JSwECIetj2a69lJiEyAFe+reH4iB3py
         BX14RuxPreoRf6Crf/GeORZmryYfcmrURidiw8gxIUZV3rpBv2XJ8/s62sR11ELd/j20
         Wur2PoDRYl7dJpIEudZoFnS6oj+qWthVOaa4ZQG/eawGGKfGoBklSINUwK+osMRi6OAA
         Erxw==
X-Forwarded-Encrypted: i=1; AJvYcCX3EADSmUkkSRybBTOXt6yfw916MHBSQSUm6nVIj76yUhpaAQUFYvK8b1JfGx7m5h+ObsKJoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9i8VFrU0qJEsQ+gvI75b21eQwUrkzDUpgbmunBCrGkuT4CXGN
	kx+JI9ZKnwVkszzDXmFQnyeMShol2HhZ9VDj01jJiBUEidbOqdkeR/WotbljDMPCz8M=
X-Gm-Gg: ASbGncsZK8KK7XTDb5OsjuTIgblv+SFlzlNWPtLDV6y2Mjv8IwkXepUOFpPeA4FjcIS
	egxgLRIuK5plRuoYqHr38+n+yHdqb2lhj5IoWNvz+QLg0gp0c6Ysgecv+rEk69kXdNMKZo/wQC2
	6FSgxoNKTneOgX0+9CQNE6ncMo8jGVzEag/eswmXjrNF0Mer6IlKi3ID6UlduE2Y7HSmOz5KlPx
	CLq/IaCx0RHKumY65f8kGB0hKfn/9I0Zj6z45cAvmfv0tsjUeNerFyqHTL09NslgiSPkKbRZD10
	L0/xlw21ymfyOJWcChSUSVjoWdgkStqGRPNbbgfdOovonWLEcWRZC2fv20eW7RxrJmMBkeMw3YX
	kYHtee1PANy8OxTq1HtozpsEP39JMQc84
X-Google-Smtp-Source: AGHT+IEUceVkl40iNUbmH8CG0B9SvtBCZGSM71xkMe4dIMOtKKEAU9bj+x0vh8grcAXbbZcW59/UVg==
X-Received: by 2002:a05:622a:3:b0:4a9:7725:b1be with SMTP id d75a77b69052e-4ae8ef406d4mr180745941cf.8.1753798968930;
        Tue, 29 Jul 2025 07:22:48 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4aea7d724d0sm38853931cf.23.2025.07.29.07.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:22:48 -0700 (PDT)
Date: Tue, 29 Jul 2025 10:22:46 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
Message-ID: <20250729142246.GF54289@cmpxchg.org>
References: <20250721203624.3807041-1-kuniyu@google.com>
 <20250721203624.3807041-14-kuniyu@google.com>
 <20250728160737.GE54289@cmpxchg.org>
 <CAAVpQUBYsRGkYsvf2JMTD+0t8OH41oZxmw46WTfPhEprTaS+Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUBYsRGkYsvf2JMTD+0t8OH41oZxmw46WTfPhEprTaS+Pw@mail.gmail.com>

On Mon, Jul 28, 2025 at 02:41:38PM -0700, Kuniyuki Iwashima wrote:
> On Mon, Jul 28, 2025 at 9:07 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Mon, Jul 21, 2025 at 08:35:32PM +0000, Kuniyuki Iwashima wrote:
> > > Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> > > buffers and charge memory to per-protocol global counters pointed to by
> > > sk->sk_proto->memory_allocated.
> > >
> > > When running under a non-root cgroup, this memory is also charged to the
> > > memcg as sock in memory.stat.
> > >
> > > Even when memory usage is controlled by memcg, sockets using such protocols
> > > are still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).
> > >
> > > This makes it difficult to accurately estimate and configure appropriate
> > > global limits, especially in multi-tenant environments.
> > >
> > > If all workloads were guaranteed to be controlled under memcg, the issue
> > > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> > >
> > > In reality, this assumption does not always hold, and a single workload
> > > that opts out of memcg can consume memory up to the global limit,
> > > becoming a noisy neighbour.
> >
> > Yes, an uncontrolled cgroup can consume all of a shared resource and
> > thereby become a noisy neighbor. Why is network memory special?
> >
> > I assume you have some other mechanisms for curbing things like
> > filesystem caches, anon memory, swap etc. of such otherwise
> > uncontrolled groups, and this just happens to be your missing piece.
> 
> I think that's the tcp_mem[] knob, limiting tcp mem globally for
> the "uncontrolled" cgroup.  But we can't use it because the
> "controlled" cgroup is also limited by this knob.

No, I was really asking what you do about other types of memory
consumed by such uncontrolled cgroups.

You can't have uncontrolled groups and complain about their resource
consumption.
