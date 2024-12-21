Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0251799B
	for <mptcp@lists.linux.dev>; Sat, 21 Dec 2024 02:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734747231; cv=none; b=mhaReMYu1qIS36Yp28rKnjq/E+7sxWGyNSTwtLC7vMdWrh+paQVRUPy1IM4KcKjCaiScHa05FYAs3CQ488y7sUc5DtToiSwLZoEZUbjSiVrNwFGq+mzZ+PB9N91Ff0Tc5nBx/CuqF3o68HOHaNoBqJIT2xOp+Kin+vwX8HHFGfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734747231; c=relaxed/simple;
	bh=h1REstVmm/2nr1Dx5BzeVAs1Z+yl8BgQyNUJ5ov7sXk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FzVljEvHeb60MjYavJT2g3lMcdEcd2pO66ps2a1YckhGHjuuOWk4Q22J2J0S09ZF5FJU3ytLV6gAWC1N/jaOFr58NAABoTzRRTERQqzV4mEdrJrK2bI1kay7ysdA+DqSQJ84ERZCyuTBjimvss206RIK1jH846IrkHDIqKoUY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT1d654K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT1d654K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F0AC4CECD;
	Sat, 21 Dec 2024 02:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734747230;
	bh=h1REstVmm/2nr1Dx5BzeVAs1Z+yl8BgQyNUJ5ov7sXk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=WT1d654KPOBTfUNla8E5XTq/9Exx9QqiwQKyM4/jAc5s/am1SxIHQIaM7kPIFcmSB
	 9HancaRD+RjtoWvujj7P9U6yf78bU+g1hbPe1r5HXpssWp1bOCWEPihtYSpBAofIGF
	 zzYsedNlCKrUL0u0lvS/gj5wNKv5LwJUaOBlrW9tzYkAUgJt5ScHoTbBbTakEFGt3d
	 +gWL1hpNmZsFwnlXMGYSY9wfQmpxuhmo5LaHrtvLMFv4n9/T/6MKR0BmhUP+NT3RH4
	 T+DOO4P7TFBWQU3Y61hCcmsoxGGraWOMTRtiQzKNDTXpUwoCMu6gPrvST0B269AJE+
	 AzpsWEX9oyVig==
Date: Fri, 20 Dec 2024 18:13:49 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/2] mptcp: rx refactor follow-ups
In-Reply-To: <cover.1734022547.git.pabeni@redhat.com>
Message-ID: <3e426ce7-aedc-df66-80f2-e541423ba4e9@kernel.org>
References: <cover.1734022547.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 12 Dec 2024, Paolo Abeni wrote:

> a couple of incremental improvements on top of the pending rx path
> refactor: patch 1 dismiss __mptcp_rmem(), patch 2 optimize a bit
> __mptcp_move_skbs()
>

Both LGTM, thanks Paolo.

Reviewed-by: Mat Martineau <martineau@kernel.org>

> Based-on: <cover.1733486870.git.pabeni@redhat.com>
>
> Paolo Abeni (2):
>  mptcp: dismiss __mptcp_rmem()
>  mptcp: micro-optimize __mptcp_move_skb()
>
> net/mptcp/protocol.c | 113 +++++++++++++++++++------------------------
> net/mptcp/protocol.h |  13 ++---
> 2 files changed, 55 insertions(+), 71 deletions(-)
>
> -- 
> 2.45.2
>
>
>
