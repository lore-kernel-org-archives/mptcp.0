Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09682D7380;
	Tue, 11 Aug 2026 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786488127; cv=none; b=EYELjTd/UqKg7R/SYydc4eCKIhUIdQRPo6vsyEHSjRxAvHbe92UPGAmH/SYSXezFGeTtYj5SRzPelvrZL692RQH26PsRgSHAyIA4ARZl4pzBNoV9Rcov9sr+Nr6pzQ59q+XXU5KTFoSmEG9h38o5syM2JgirBCz+CMlhcesjd3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786488127; c=relaxed/simple;
	bh=ssKEF1k7Nd/ngSJO3IhBUoPvqgf1dFagR3sJ1DsfA7c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=flWEvU22JJ4nhbqELKQIG9GNVbAu9AjUy52tCaLGqCrSebB0vb3suu3X4+AELOQqh7fp4L182rFbO38/mqb2h91SZUTuDGrk4EmuJRNp+shvhDVsPqffW3HzL7Mrl2ZN3FlIqiXqp7ti4FohbFMrgy9AzlnJggsMDFB4uZ8C0VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNU2KuKO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNU2KuKO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD7D1F000E9;
	Tue, 11 Aug 2026 22:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786488125;
	bh=F6t7g1L3FIZBc6jtDhdP0tDEykh3oBcFtDwQQAIP8ks=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oNU2KuKOhygInH3rpV/vhEyIz7pxb87UogxiAqv9LdG+JthTPDcScl7S2o+Iy0vd8
	 6qJ/6jnqk22wsHVXZ0DOQ4DEX9L+XsTCKEp6kQDaKA298nEDmmOUv1MDH8BMv/y10w
	 c+gsii4pCd+idZcr6lxgpanP+KIsgIfK/J7PWlkKiuk175IrZ+C4skZXV6TQlsQaFT
	 V2r4zMwIXMu6v2TXGvkpAl+5V2l69WZJibwhGwWv6kcjjf8xMvcDi3TWm4V78/aB4Z
	 P1p4h7kxaqMYoS1K0kQlbcVwLVVL5oItuhk7swaFeXcGlhc0OR/6sAXsZEYklpsLms
	 0iP4IKghc6nwQ==
Message-ID: <078f34213dd05a3fe519eca68313379d9c038805.camel@kernel.org>
Subject: Re: [PATCH v2 2/3] nvme-tcp: support IPv6 traffic class
From: Geliang Tang <geliang@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>,  David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>, Hannes Reinecke
 <hare@suse.de>, Geliang Tang <tanggeliang@kylinos.cn>, 
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Date: Wed, 12 Aug 2026 06:41:59 +0800
In-Reply-To: <anptYps5IoeGDCnt@devvm7509.cco0.facebook.com>
References: <cover.1786171863.git.tanggeliang@kylinos.cn>
	 <3f5e4c84d3fe41601b29468fa4128d4639d56685.1786171863.git.tanggeliang@kylinos.cn>
	 <anptYps5IoeGDCnt@devvm7509.cco0.facebook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Stanislav,

On Mon, 2026-08-10 at 17:32 -0700, Stanislav Fomichev wrote:
> On 08/08, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > The NVMe/TCP transport needs to configure the IPv6 traffic class on
> > its
> > queue sockets, but the fabrics option parser currently has no
> > corresponding
> > option.
> > 
> > Add the tclass option to the fabrics parser and store the validated
> > value
> > in struct nvmf_ctrl_options. Negative values are rejected, while
> > values
> > greater than 255 are clamped to 255, matching the valid range of
> > the IPv6
> > traffic class field.
> > 
> > Keep -1 as the default value to let the transport use its default
> > traffic
> > class.
> > 
> > The fabrics layer now supports parsing the tclass option, but the
> > NVMe/TCP
> > transport does not currently advertise or apply it.
> > 
> > Allow NVMe/TCP to use NVMF_OPT_TCLASS and set IPV6_TCLASS on each
> > queue
> > socket via ip6_sock_set_tclass() when a traffic class is specified,
> > keeping
> > the existing IPv4 TOS handling unchanged.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  drivers/nvme/host/fabrics.c | 18 ++++++++++++++++++
> >  drivers/nvme/host/fabrics.h |  3 +++
> >  drivers/nvme/host/tcp.c     |  8 +++++++-
> >  3 files changed, 28 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/fabrics.c
> > b/drivers/nvme/host/fabrics.c
> > index ac3d4f400601..643c03dc7bcb 100644
> > --- a/drivers/nvme/host/fabrics.c
> > +++ b/drivers/nvme/host/fabrics.c
> > @@ -695,6 +695,7 @@ static const match_table_t opt_tokens = {
> >  	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
> >  	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
> >  	{
> > NVMF_OPT_TOS,			"tos=%d"		},
> > +	{ NVMF_OPT_TCLASS,		"tclass=%d"		},
> 
> Do you really need new UAPI for v6? Any reason not to apply existing
> NVMF_OPT_TOS to ipv6 sockets?

Thanks for the feedback. I've given this careful consideration, and
you're absolutely right - there's no strong reason to introduce new
UAPI specifically for IPv6 when the existing NVMF_OPT_TOS can be
reused. I'll reuse it for IPv6 in v3 and drop this new "tclass" option.

Thanks,
-Geliang
