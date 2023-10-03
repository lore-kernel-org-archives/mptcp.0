Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94625D2EB
	for <mptcp@lists.linux.dev>; Tue,  3 Oct 2023 16:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C66C433C7;
	Tue,  3 Oct 2023 16:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696352390;
	bh=BX1lvpezTqmvgrUexwjn4L51l4g+ESAIdiyku86MTLE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OJi30JtmekFTzYgYKScR9Sdx0bzXDDoeMsgYyNraRUIzIoVyf+ncRgh4SQCqD3z6D
	 Ysyy8GhTWJYtLckB3uvTmwSxBxWZCwB8tW56/ks8AkNz3XNSfyfjPslngadIaUZY4w
	 Wi7wSMDziR/48Pod0rQLxUDfSHtdvc9412uJqeAx71Qjwgl+wsvl0Oiu7oO8KlKsxW
	 K3TilPipKj0XH+Ihm3bCvCuYEPitSuLK550qzjByVGRXTIzPNgs7Pdpr3IKQDPr/Z+
	 QozFlrDEgirU8kuCcxGAoS4CBI9CLnHCFuw7sRGW28Fzp30fpGuQc7jEsd/Sz8pcmU
	 djnrkGzsNOdVg==
Message-ID: <27be4fdf-16b7-43b8-a79c-d950b69ba842@kernel.org>
Date: Tue, 3 Oct 2023 18:59:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2 2/2] Squash-to: "mptcp: give rcvlowat some
 love"
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <c71297499300a20bc41fe9c526d4a6cad08c176f.1696237983.git.pabeni@redhat.com>
 <21dd84bd44a8d0839564bed351e7d77a16b68474.1696237983.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Organization: Tessares
In-Reply-To: <21dd84bd44a8d0839564bed351e7d77a16b68474.1696237983.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 02/10/2023 11:13, Paolo Abeni wrote:
> Christoph reported a couple of serious splat caused by
> the mentioned patch.
> 
> mptcp_set_rcvlowat() can use msk->scaling_ratio, before
> such field is initialized, causing a divide by zero: we
> need to init it in the sock constructor.
> 
> Additionally the same function bogusly cast an msk to a
> tcp_sock, causing memory corruption. The reproducer likely
> clears the sk refcount for the next msk allocated into the
> same slab.
> 
> The intent was to properly propagate the rcvbuf changes to
> the subflows. Let's do that explicitly.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> --
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/442
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/443

Thank you for the patches!

Now in our tree (I added patch 1/2 just before "mptcp: give rcvlowat
some love")

New patches for t/upstream:
- 3a6e7c602676: tcp: define initial scaling factor value as a macro
- 4b8e173a713a: "squashed" patch 2/2 in "mptcp: give rcvlowat some love"
- Results: 3cbb19268039..ad8e597b726a (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20231003T165758

Cheers,
Matt
