Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120801AF0C6
	for <mptcp@lists.linux.dev>; Mon,  4 Nov 2024 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711544; cv=none; b=bYMziZDkQCt5+U5DwUtL0gQWp8scI0ckKNGtYiHXABF7qOQZ84qpmVboo6MGqjV+MA4N6EXsw5vmGNyCW5OMxN4WhJMgrMgIheCy25ekBY5vFhKXhk/a0IRrMVYQzVeQqLvnlCGjsbyjPpQEgqu+i1Nonvmk9I1ebLiojUDxMn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711544; c=relaxed/simple;
	bh=pM/mmO0A5huIBHVdUFTY5dFuZgBykqYGXi6YxLB9yL8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PHx367NTk2qvcsX84q8Trdti+15spA8LIIOThpt+9K1VaRIYFAWP0WvIazerhdV9/dgHLhdsOD+U24YQ1xl+EFKEHy/fU2ZHzXRxJ8225E18+pTpz/tCmf+CVQwvw9tSo/Fqt9ucv7w8btEL8Hj4+O9qZGoLYPyoIV2CNo+9d0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSU8hTkW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSU8hTkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659A1C4CECE;
	Mon,  4 Nov 2024 09:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730711543;
	bh=pM/mmO0A5huIBHVdUFTY5dFuZgBykqYGXi6YxLB9yL8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hSU8hTkWImflLqeIY1vkrTj2asWujPePZAyLwBoul8D33Q+uU4+xzOr+6p9VJNi7J
	 KChDbRQpVltvqfJdlR4ElbAf/Id6sUUo4EV8v/Np7okpX937Xf/5j1MxSjD6WHWGhB
	 N3gPlZvM2m2XzhZkQb8y9YlOn9EC6UkYdSyUl+UqI68uXxC8/ksRK43NlgOT2jKWk1
	 AdxN6nJntdLWUWKDqDPX1RUbic53pLTvcdRgy+qA45UjurxtVCu+ugro6Ro5vQ2t3t
	 +Nuwju/hXaBC5m+3Mh+v/LhV2KY2SXW+8o4l0FqGhwhxdUqgGfqB5zRwlXncEFu+hm
	 YEtZMxBlfp6Pg==
Message-ID: <d44a000cfe49a9fb2c868833694f4da61a457d16.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 13/36] mptcp: add struct mptcp_id_bitmap
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 04 Nov 2024 17:12:16 +0800
In-Reply-To: <cbd9eaa2-e236-421e-82e9-784ae7054dca@kernel.org>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
	 <344964d66ab0250ae027ffd46a0e6782d572c33d.1729588019.git.tanggeliang@kylinos.cn>
	 <cbd9eaa2-e236-421e-82e9-784ae7054dca@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2024-10-31 at 19:45 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 22/10/2024 11:14, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > A new struct mptcp_id_bitmap is defined to unify all bitmap type of
> > address
> > IDs for both in-kernel PM and userspace PM.
> > 
> > This type can be used to easily refactor dump_addr() interface of
> > the path
> > managers to accept an mptcp_id_bitmap type parameter. It also
> > allows this
> > parameter of dump_addr() can be modified by BPF program when
> > implementing
> > this interface of a BFP path manager.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> 
> (...)
> 
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 8282a6355765..4358a9a21270 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -211,6 +211,10 @@ enum mptcp_addr_signal_status {
> >  /* max value of mptcp_addr_info.id */
> >  #define MPTCP_PM_MAX_ADDR_ID		U8_MAX
> >  
> > +struct mptcp_id_bitmap {
> 
> This name is too generic, while here this bitmap is specific to the
> path-manager and its PM address:
> 
>   mptcp_pm_addr_avail_id?
> 
> > +	DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
> 
> Sorry, I'm not sure to understand this modification: why do you need
> a
> specific structure with only one field? I didn't check the next
> patches
> yet, but I saw that at the end of the series, the structure still
> only
> has one field.
> 
> Do you require this dedicated structure because of a limitation of
> BPF?

Yes, defining dump_addr interface as either

int userspace_pm_dump_addr(struct mptcp_sock *msk,
                           unsigned long *bitmap)

or

int userspace_pm_dump_addr(struct mptcp_sock *msk,
			   unsigned long id_bitmap[4])

is not allowed by BPF.

> Can we not use a typedef, a macro or something else to avoid all
> these
> modifications here?

In v3 I defined a type using typedef like this:

typedef struct {
        DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1); 
} mptcp_pm_addr_id_bitmap_t;

and only used it in the parameters of the dump_addr interfaces. The
rest of the places continue to use DECLARE_BITMAP. It works well, the
only downside is that checkpatch.pl complains about it:

$ ./scripts/checkpatch.pl 0001-mptcp-add-mptcp_pm_addr_id_bitmap_t-
type.patch 
WARNING: do not add new typedefs
#31: FILE: include/net/mptcp.h:124:
+typedef struct {

total: 0 errors, 1 warnings, 0 checks, 40 lines checked

We can ignore this warning.

WDYT?

Thanks,
-Geliang

> 
> > +};
> > +
> >  struct mptcp_pm_data {
> >  	struct mptcp_addr_info local;
> >  	struct mptcp_addr_info remote;
> > @@ -231,7 +235,7 @@ struct mptcp_pm_data {
> >  	u8		pm_type;
> >  	u8		subflows;
> >  	u8		status;
> > -	DECLARE_BITMAP(id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> > +	struct mptcp_id_bitmap id_avail_bitmap;
> >  	struct mptcp_rm_list rm_list_tx;
> >  	struct mptcp_rm_list rm_list_rx;
> >  };
> 
> Cheers,
> Matt

