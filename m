Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879BC2D052
	for <mptcp@lists.linux.dev>; Thu,  9 Jan 2025 04:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736396137; cv=none; b=R5LqNPJFEkM1nCMr5rVFB9YpfTwgX00cdXSjLVS/jCu5Uzxvpuc3sJDrP4EItL/JUhnj6113vOR+casdbKF/Q/Sq5DM8eZbYv/kTF4hp77rQiiJqEdurTGbF7kJ2hrtqImb5LSvNqo7AqhQulBjkUUvP8dg2y3w9w2cphKth+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736396137; c=relaxed/simple;
	bh=PdceZfMZkfPnind1NE3wIGtbImDEh9UVs+fj5FmaAUI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b5+48jP0sY0/6xtmuZ+fqLLQn54PQ0iayQEyoPW0jZ179fopkUwSJJTFv/X1q+CTH/N0kAthQqCHcnGudCWmTZl/sZgNQXYJiTcYHqecUypaI1oELtth0lpJK7q/1A9yfmZaQ5kOrRE4aBppLgnlQRyDXg850245LgGnZdxF5jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekK7t7XH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekK7t7XH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9DFC4CED2;
	Thu,  9 Jan 2025 04:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736396137;
	bh=PdceZfMZkfPnind1NE3wIGtbImDEh9UVs+fj5FmaAUI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ekK7t7XHmpmEdjmM8nGB2B8sNuKuMdGEiOB7x7xTgE68nMHLgG1mFcZaA/YR35pB7
	 b1lrgDvPUiO1Sm1lj3am/DpIhlpzJBBmb9EylB8mXg//8/xcw36B4HRR8MUoDwJCFY
	 KCdE2BayRokMVpe8Z4VQ6xDjB4K2P+uDb89d+a6hiF6vdINdMF9L81e83wfupudmUD
	 1y8GNDG96nxZEpf5XbsAT8AQaZNsBS1Yd5vK7i0WzgcMclb93BmWiIyHDiJR8bvway
	 Sf8p/7aBcK+PcUVDxofa0d9u2utyTivP4yTEdXi+vk6oKsNC8eARDeBU1/uItuMW5q
	 nw3peDCPDy/vg==
Message-ID: <e0bf78833216705521b8c0e4c696d39f1efba53b.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 7/8] mptcp: add mptcp_pm_addr_id_bitmap_t
 type
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 09 Jan 2025 12:15:32 +0800
In-Reply-To: <0a9019be-238d-4b02-ae7e-b510503ff6ac@kernel.org>
References: <cover.1734074788.git.tanggeliang@kylinos.cn>
	 <789602f25f9fc73043f85417b6e147c49d894b66.1734074788.git.tanggeliang@kylinos.cn>
	 <0a9019be-238d-4b02-ae7e-b510503ff6ac@kernel.org>
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

On Mon, 2024-12-30 at 17:30 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 13/12/2024 08:35, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Similar to defining types such as nodemask_t, dma_cap_mask_t and
> >    A. > > cpumask_t to simplify the use of bitmap, a new type for
> >       MPTCP
> > userspace pm id bitmap, mptcp_pm_addr_id_bitmap_t is defined to
> > easily modify dump_addr() interface of the path managers to accept
> > an mptcp_pm_addr_id_bitmap_t type parameter. It also allows this
> > parameter of dump_addr() can be modified by BPF program when
> > implementing this interface of a BFP path manager. Because a
> > dump_addr() interface that accepts an 'unsigned long *bitmap'
> > or 'unsigned long bitmap[]' parameter is difficult to implement
> > in BPF program.
> > 
> > In addition, this also makes it easier for us to implement similar
> > logic to mptcp_userspace_pm_append_new_local_addr() in BPF path
> > manager, because there's no way to use DECLARE_BITMAP macro in BPF
> > program, and it's not easy to reimplement it in BPF.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  include/net/mptcp.h      |  7 +++++++
> >  net/mptcp/pm_userspace.c | 14 ++++++--------
> >  net/mptcp/protocol.h     |  3 ---
> >  3 files changed, 13 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > index 814b5f2e3ed5..220b1f60e8c1 100644
> > --- a/include/net/mptcp.h
> > +++ b/include/net/mptcp.h
> > @@ -120,6 +120,13 @@ struct mptcp_sched_ops {
> >   void (*release)(struct mptcp_sock *msk);
> >  } ____cacheline_aligned_in_smp;
> >  
> > +/* max value of mptcp_addr_info.id */
> > +#define MPTCP_PM_MAX_ADDR_ID U8_MAX
> > +
> > +typedef struct {
> > + DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
> > +} mptcp_pm_addr_id_bitmap_t;
> 
> Why do you need to declare it here and not in protocol.h? Is it for
> the
> future BPF PM?

Yes, it's for the BPF PM. If we define a struct mptcp_pm_addr_id_bitmap
as in the previous version [1], we can indeed put it in protocol.h:

struct mptcp_pm_addr_id_bitmap {
DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
};

and just declare it in include/net/mptcp.h:

struct mptcp_pm_addr_id_bitmap;

But as your comments in [1], 'why do you need a
specific structure with only one field?'

This new version uses 'typedef' to define a new type, similar to
nodemask_t, dma_cap_mask_t and cpumask_t. I think this is a good way to
handle structures with only one field. But on the other hand, we can't
declare a 'mptcp_pm_addr_id_bitmap_t' in include/net/mptcp.h, we need
to move the entire typedef to include/net/mptcp.h, and the
corresponding MPTCP_PM_MAX_ADDR_ID also needs to be moved together.

Which one do you prefer, mptcp_pm_addr_id_bitmap_t or struct
mptcp_pm_addr_id_bitmap? I will use it in the next version.

Thanks,
-Geliang

[1]https://patchwork.kernel.org/project/mptcp/patch/344964d66ab0250ae027ffd46a0e6782d572c33d.1729588019.git.tanggeliang@kylinos.cn/

> 
> Maybe you don't really need this bitmap if it is only needed for the
> dump interfaces that are probably not needed with BPF?
> 
> Then maybe there is no need to change anything here?
> 
> Cheers,
> Matt

