Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34102624
	for <mptcp@lists.linux.dev>; Sat, 16 Nov 2024 03:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731729180; cv=none; b=Po57jhNKK3dIXh86XOdY+euyUCMeI9U9zmx812ENLvXIraztbCxFhGFuvTibSLTiLWVO/UjhJeab1HSf3i5CrhVWMrEqlfzswtxP2H6ezzQRPWmJ6I+nWLsNfIkEdrjbv9W1is0v0NN9RJ3mrCFpyrHIjEaI3O2n1gvaOqzJvSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731729180; c=relaxed/simple;
	bh=a3ziXhQhmHQ0vA7AjZjsO6DPSj0qovCeoArD26q9LA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWOYlek9749rUg8ujlObogEVHLwwIT8Epafvw/l3e4Y+bmajllDAyKHuPpACXrtDu4tYvxhI+67pddGw13VsgPb3xM38sWGV9JFhHARMT9x+pOdN5R5jejXn4MguC82KdMa74o7xa+0/sqaOWoQ/s8n2CYRsqKUd8D0/GkTRPiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9YJMQep; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9YJMQep"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ea39f39666so100199a91.2
        for <mptcp@lists.linux.dev>; Fri, 15 Nov 2024 19:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731729178; x=1732333978; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0a1LFZe7mhPiCdYnydxfbs4tmbiylajqw5WUGlsha3I=;
        b=M9YJMQepevmNV3X2FdTkERlxmH2SUZ0PbLoa2XuoqunOtw010LznAgxOI9KWwj5dYM
         xJ2bwn8VdrDUVGmG/jj7lilgbtVgG1QbgBFGRrj9uMkJF08jPfSQnBOWYM6kfcs5QyRP
         ktS9QnM7t0b7mMOe8F+pMvIioBOqjquR3mN3Bt3+jHrN9L6EEpjYYK9tb5lU2vpu35Ia
         fuA7+hoXwMgvDpCCQh3USkboD+9szMiK0U9HEQ6l8BSFC5aJZgcPXtrPbB1gfX30rubK
         5XBRhRVcX87gSiNLRNYWvMvRBQf9W7Mo2W/SU2ba+aCxWm9DI7CBBwH9rFtme8vCJ9l1
         GmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731729178; x=1732333978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0a1LFZe7mhPiCdYnydxfbs4tmbiylajqw5WUGlsha3I=;
        b=fqPa+uLdW/yC8YXcHAio431zTqg1TE2yXXB9H20hRwyE7tM5vj+bNk7CW3iusLSmag
         b0oaQAZnpwWCEjU0go/ZtdmrWhK8+nAgC94g9cZayT51w2stahlXmHrqkcDF3ttS4iba
         4/S+LNLIZVFgj/Z01+LOCFJpax5t5Lu4XkKjLE2eX91ktH7vKyP/j2UCqgQPAyG+Cdxj
         6Me4PNlMwJzusVf13aC/9klDoMDzY08Es/gPJli2Q7/a/mYOs51T2yTbQSKvcie3yaqn
         QGbZQwAK+BcZ2BZwTmF5yWfgPStA0q9Z3TeHqJW2cSnUs+Z3mq9i63EpVVkpIpNkFWhf
         Az1A==
X-Forwarded-Encrypted: i=1; AJvYcCX7zLJ0nL7G8gZI2Mn4g/CUNcw/wqgQOa+lRqn5b5avr9Ca3dz+o86XmKQ1FjMRrBZfDZjchg==@lists.linux.dev
X-Gm-Message-State: AOJu0YysBDfLKdvktkVm5X+bf6HoQudPEp32hEqXhDhOm+a0lb691Xe+
	tbI7UB+qtLQ24WhqCUraik30oyZJX/KX0zsfzLxUTlVWHj8CFS1xKIc6bIEzmOF7DZGed0lq+Bh
	I1otsW/tv2bxOyaCaeZuD7lJdjms=
X-Google-Smtp-Source: AGHT+IEFUKFM2wbR8eLssBH3u61VGNgNPx8MQA8aMhcofW24BafDDbKsmR7m0RlbzXs89pxamk77eCK3z2P+QVEDy3g=
X-Received: by 2002:a17:90b:2402:b0:2ea:2a8d:dd2a with SMTP id
 98e67ed59e1d1-2ea2a8dee1fmr2837292a91.27.1731729178457; Fri, 15 Nov 2024
 19:52:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
 <20241115160816.09df40eb@kernel.org> <CAJwJo6ax-Ltpa2xY7J7VxjDkUq_5NJqYx_g+yNn9yfrNHfWeYA@mail.gmail.com>
 <20241115175838.4dec771a@kernel.org>
In-Reply-To: <20241115175838.4dec771a@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Sat, 16 Nov 2024 03:52:47 +0000
Message-ID: <CAJwJo6YdAEj1GscO-DQ2hAHeS3cvqU_xev3TKbpLSqf-EqiMiQ@mail.gmail.com>
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ivan Delalande <colona@arista.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Davide Caratti <dcaratti@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Nov 2024 at 01:58, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Sat, 16 Nov 2024 00:48:17 +0000 Dmitry Safonov wrote:
> > On Sat, 16 Nov 2024 at 00:08, Jakub Kicinski <kuba@kernel.org> wrote:
> > > Would it be too ugly if we simply retried with a 32kB skb if the initial
> > > dump failed with EMSGSIZE?
> >
> > Yeah, I'm not sure. I thought of keeping it simple and just marking
> > the nlmsg "inconsistent". This is arguably a change of meaning for
> > NLM_F_DUMP_INTR because previously, it meant that the multi-message
> > dump became inconsistent between recvmsg() calls. And now, it is also
> > utilized in the "do" version if it raced with the socket setsockopts()
> > in another thread.
>
> NLM_F_DUMP_INTR is an interesting idea, but exactly as you say NLM_F_DUMP_INTR
> was a workaround for consistency of the dump as a whole. Single message
> we can re-generate quite easily in the kernel, so forcing the user to
> handle INTR and retry seems unnecessarily cruel ;)

Kind of agree. But then, it seems to be quite rare. Even on a
purposely created selftest it fires not each time (maybe I'm not
skilful enough). Yet somewhat sceptical about a re-try in the kernel:
the need for it is caused by another thread manipulating keys, so we
may need another re-try after the first re-try... So, then we would
have to introduce a limit on retries :D

Hmm, what do you think about a kind of middle-ground/compromise
solution: keeping this NLM_F_DUMP_INTR flag and logic, but making it
hardly ever/never happen by purposely allocating larger skb. I don't
want to set some value in stone as one day it might become not enough
for all different socket infos, but maybe just add 4kB more to the
initial allocation? So, for it to reproduce, another thread would have
to add 4kB/sizeof(tcp_diag_md5sig) = 4kB/100 ~= 40 MD5 keys on the
socket between this thread's skb allocation and filling of the info
array. I'd call it "attempting to be nice to a user, but not at their
busylooping expense".

> > > Just putting the same attribute type multiple times is preferable
> > > to array types.
> >
> > Cool. I didn't know that. I think I was confused by iproute way of
> > parsing [which I read very briefly, so might have misunderstood]:
> > : while (RTA_OK(rta, len)) {
> > :         type = rta->rta_type & ~flags;
> > :         if ((type <= max) && (!tb[type]))
> > :                 tb[type] = rta;
> > :         rta = RTA_NEXT(rta, len);
> > : }
> > https://github.com/iproute2/iproute2/blob/main/lib/libnetlink.c#L1526
> >
> > which seems like it will just ignore duplicate attributes.
> >
> > That doesn't mean iproute has to dictate new code in kernel, for sure.
>
> Right, the table based parsing doesn't work well with multi-attr,
> but other table formats aren't fundamentally better. Or at least
> I never came up with a good way of solving this. And the multi-attr
> at least doesn't suffer from the u16 problem.

Yeah, also an array of structs that makes it impossible to extend such
an ABI with new members.

And with regards to u16, I was thinking of this diff for net-next, but
was not sure if it's worth it:

diff --git a/lib/nlattr.c b/lib/nlattr.c
index be9c576b6e2d..01c5a49ffa34 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -903,6 +903,9 @@ struct nlattr *__nla_reserve(struct sk_buff *skb,
int attrtype, int attrlen)
 {
  struct nlattr *nla;

+ DEBUG_NET_WARN_ONCE(attrlen >= U16_MAX,
+     "requested nlattr::nla_len %d >= U16_MAX", attrlen);
+
  nla = skb_put(skb, nla_total_size(attrlen));
  nla->nla_type = attrtype;
  nla->nla_len = nla_attr_size(attrlen);
--->8---

Thanks,
             Dmitry
