Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E5B376E0
	for <mptcp@lists.linux.dev>; Fri, 23 Aug 2024 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416314; cv=none; b=LI137ZUrpYReeSPk3GtSIeP/aFfFEFIwDfLu4VCZkRAstp+WRKlfxI/YC5at3NbV4I0O1X59cco8h758l0k6uLnu2+RS/nnf65XRgynOZK8OqpBxKjaCLH2h2XPMPVoO8ww65tqr3nSf8DClE7nQ3WAqyYNT02YHbo73jnYGPCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416314; c=relaxed/simple;
	bh=uMYpzj4RLWejWozvzAZV7perGxNZ/fkbCqH0c1Hfyb8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lr/aNZ7fV+EpP0Q/vScdnx1Frw7sG94H/aBCBJ9jlSkOj1Nc4m3hYPGaSB8yarrfnrwVJXdVW/7yPt09znb5k1yedQxlakxYRN8y+1GUYhqP1yz+heLwk+yleqbVXqOGgjjXWYL5YeaN3QNzkP4Yo/6Xa/bnmBGFz0fK10z8Vwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIVoC4G0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIVoC4G0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD311C32786;
	Fri, 23 Aug 2024 12:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724416314;
	bh=uMYpzj4RLWejWozvzAZV7perGxNZ/fkbCqH0c1Hfyb8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jIVoC4G0lJIDbSVhqzEiiaHeXNYHyJCF24/VHDsxH5jjXaMhSgJv/QjkQFU+ikdjz
	 wDypQ9z6XTZTATvMy0ILqcggJS5dGQQ74G2XIMIZLxuda2UGxPQjgq6/lzuYnyWMCe
	 7emf+TUwvlNvC/DE3FzGTSxdgxKUskkgjn1NZLPB03PhSfRYDWwiTdRCRQOJZMb2VO
	 3rK/SEFlYhdIzgAPtA35vhxQEnMiZe9DGPPeLMer7+EQ1+I+tb8tKlSEnDMhTCBU1R
	 yRUaFfpNsXn4y9YuQF+ofBUd1qctKWhgyuKhnvtGCC7wHbwMxckbX+jVkuYOd+faO0
	 VUbJplVkaCaHA==
Message-ID: <a5615bc7bd48d6ff875b1ad22e77886bd74e6200.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 2/2] selftests/bpf: Add getsockopt to
 inspect mptcp subflow
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Martin KaFai Lau
	 <martin.lau@kernel.org>
Date: Fri, 23 Aug 2024 20:31:49 +0800
In-Reply-To: <1ed09f3d-fd1c-402a-b7fd-a5bdd8674b9f@kernel.org>
References: <cover.1724318341.git.tanggeliang@kylinos.cn>
	 <f4c969836e4c051f6752446a1bd26b763caa121c.1724318341.git.tanggeliang@kylinos.cn>
	 <c70ef113-0168-44f0-8e4e-ac5d7c75131d@kernel.org>
	 <1cfb8506929db74e0494966b3599ced60c58e51e.camel@kernel.org>
	 <1ed09f3d-fd1c-402a-b7fd-a5bdd8674b9f@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2024-08-22 at 16:48 +0200, Matthieu Baerts wrote:
> On 22/08/2024 15:31, Geliang Tang wrote:
> > On Thu, 2024-08-22 at 12:56 +0200, Matthieu Baerts wrote:
> > > On 22/08/2024 11:22, Geliang Tang wrote:
> > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> (...)
> 
> > > > diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > > > b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > > > index 782f36ed027e..70d9f5888976 100644
> > > > --- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > > > +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > > > @@ -4,9 +4,44 @@
> > > >  
> > > >  #include <vmlinux.h>
> > > >  #include <bpf/bpf_core_read.h>
> > > > +#include "bpf_experimental.h"
> > > >  
> > > >  #define MPTCP_SUBFLOWS_MAX 8
> > > >  
> > > > +static inline int list_is_head(const struct list_head *list,
> > > > +			       const struct list_head *head)
> > > > +{
> > > > +	return list == head;
> > > > +}
> > > > +
> > > > +#define list_entry(ptr, type,
> > > > member)					\
> > > > +	container_of(ptr, type, member)
> > > > +
> > > > +#define list_first_entry(ptr, type,
> > > > member)				\
> > > > +	list_entry((ptr)->next, type, member)
> > > > +
> > > > +#define list_next_entry(pos,
> > > > member)					\
> > > > +	list_entry((pos)->member.next, typeof(*(pos)), member)
> > > > +
> > > > +#define list_entry_is_head(pos, head,
> > > > member)				\
> > > > +	list_is_head(&pos->member, (head))
> > > > +
> > > > +#define list_for_each_entry(pos, head,
> > > > member)				\
> > > > +	for (pos = list_first_entry(head, typeof(*pos),
> > > > member);	\
> > > > +	     !list_entry_is_head(pos, head,
> > > > member);			\
> > > 
> > > I guess you cannot add 'cond_break' in the condition, because
> > > that's
> > > the
> > > equivalent of 'break', right?
> > 
> > Hi Matt,
> > 
> > This confuses me.
> > 
> > I used this in v2:
> > 
> > 	mptcp_for_each_subflow(msk, subflow) {
> > 		... ...
> > 
> > 		cond_break;
> > 	}
> > 
> > And you suggested to add "cond_break" into list_for_each_entry().
> > 
> > Do you mean that I should go back to v2?
> 
> No, sorry, I was just initially surprised to see 'cond_break' in the
> last part of the 'for', not in second part: the condition to stop the

Yes, you're right. It's better to add 'cond_break' in second part of
'for', not the last one. Updated this in v4. And v4 addresses your
other comments in v3 too.

Thanks,
-Geliang

> loop. But I then saw that 'cond_break' is a cryptic define, doing the
> equivalent of a "break", not just a simple condition, it has be where
> you added it.
> 
> I'm personally a bit annoy to see a copy of all these "define" for
> the
> list here in mptcp_bpf.h, but maybe it is normal, and accepted by BPF
> maintainers. Thanks to the 'cond_break' you added there, they look
> quite
> generic, and not specific to MPTCP. They could go elsewhere, but
> maybe
> nobody else needs to iterate a list in the BPF selftests. And they
> can
> always be moved later on I suppose. So no need to change that in the
> v4.
> 
> Cheers,
> Matt

