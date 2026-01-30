Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEE42D7395
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769781247; cv=none; b=t6Ge6ZGs1B/iLfhdsmUhatP2r+F1cuTXMFFaSzhgR/+tvvWugrJu7nTDDTAXOcH9xFuPL7UWlCWdfLLx9hyg7H8IzQ4OD3hzktTFJzDUZIi4pZBW81Umwp3m6OrowQtjEuFbxMTQvDkdLlGaJY4KpfRxHEYODhPEH1plnijOL8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769781247; c=relaxed/simple;
	bh=homh0TA6eW0HLbyEpL0SYwezrAulzyJk5zAYoJfIpK8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XfjkUyp/wA+cq6IqtpIAZwABPn9pWOVraVAKH9SMiarnIYc8EkcFKuK1F0suzHS1dcZEx5J8hnl+x+g3METSL0JC2T9PhfvegckHGC3e27P9J1mxuSdERJUr0kSDfVI2obcooftkpAeZTrZxGLNmIhpQsWnq7noS1F/OYuAt1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoqFc1Sg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoqFc1Sg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EC2C4CEF7;
	Fri, 30 Jan 2026 13:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769781246;
	bh=homh0TA6eW0HLbyEpL0SYwezrAulzyJk5zAYoJfIpK8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZoqFc1SgKum32LsZpwe8QeOAUXdEjK6narUTWCstazIUQ80bqOX9aqSX+75/jl2MZ
	 Ns/Pv2uzEv5KwtWAtDnPhTtn3A5vP8Jhcn2BaMOt7qpAczgRpECUBZe524UOzqqBv9
	 D0KWNRjl9X1Gks/VOvWVW0S6QECQtOgOwTErf/TziM3oe84+sc19X9naPdPKAB6oKP
	 JHRvzZafXPOiNP3Bn4awWGpL9v5SM8TX+NQaxX9Xat63Ks/d3faSfLnNle0/qyrflJ
	 CHGRI3uZFZ1alfAqh1kh8/feoYBCc2SPXOs8B89Zdb67V8i7Qmu5Mtv5Ta8sTXUquk
	 o8yVHhdenz0jg==
Message-ID: <bfd9ef7479eb2696b8606ba1e34702303dd01fe1.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v15 4/6] mptcp: implement .splice_read
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 30 Jan 2026 21:54:03 +0800
In-Reply-To: <24a4b887-393c-46af-9166-ab7b6c0e3762@kernel.org>
References: <cover.1765023923.git.tanggeliang@kylinos.cn>
	 <eb8faceedfba8da224fa5467dd80d0c7f99cfd3f.1765023923.git.tanggeliang@kylinos.cn>
	 <24a4b887-393c-46af-9166-ab7b6c0e3762@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Fri, 2026-01-30 at 08:19 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 06/12/2025 13:33, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch implements .splice_read interface of mptcp struct
> > proto_ops
> > as mptcp_splice_read() with reference to tcp_splice_read().
> > 
> > Corresponding to __tcp_splice_read(), __mptcp_splice_read() is
> > defined,
> > invoking mptcp_read_sock() instead of tcp_read_sock().
> > 
> > mptcp_splice_read() is almost the same as tcp_splice_read(), except
> > for
> > sock_rps_record_flow().
> 
> (...)
> 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 01d602f0d556..334fdb10fdf3 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> 
> (...)
> 
> > @@ -4423,6 +4535,7 @@ static const struct proto_ops
> > mptcp_stream_ops = {
> >  	.mmap		   = sock_no_mmap,
> >  	.set_rcvlowat	   = mptcp_set_rcvlowat,
> >  	.read_sock	   = mptcp_read_sock,
> > +	.splice_read	   = mptcp_splice_read,
> 
> When looking at this patch in more details (after the issue with
> kdoc),
> I was wondering: is it not needed to also implement .splice_eof,
> similar
> to tcp_splice_eof()?

Thanks for the reminder, I'll try to implement mptcp_splice_eof later.

-Geliang

> 
> Cheers,
> Matt
