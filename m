Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9DB1A4F1F
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 03:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736478356; cv=none; b=ndEhe50bkKCPzRwKljkZHlGwzWJgWZOkYW2tXGshv3dfJTj04OIYZ+3qblpyCF5Qp3NiBlUnhoVUc6Dj0+hlcXxdB18N6iZ4LjfUXvtdlpJ7vDHGKGd3ykk4aEg3qpas2Fk0Q+ERjnzB/cbIxbrqOlGRQe2f8F7GzpFiosx5S5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736478356; c=relaxed/simple;
	bh=dHvYDTOKhgshWKWCyZr1M4gmoz+XA/96YzgKg9eddGk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hDd75F8CSjKmnrKPgBb2vcGUBT5NIMeFTppYBUnUekywldDQKeCh1PQokN4Yq0NoVrxpTy2NTSIrqbVfBCQauXJ5gH2YGkhmwG4X944A2nvSR85ruIVI0m71MARqAhoBqfGADgEFN3ijs/qJuEuYiBcGhSH0f+c4O7jKAZyNpyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9f+ZOU/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9f+ZOU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D369C4CED2;
	Fri, 10 Jan 2025 03:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736478356;
	bh=dHvYDTOKhgshWKWCyZr1M4gmoz+XA/96YzgKg9eddGk=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=W9f+ZOU/LiwLVgFZf3ICRxQ6z+BlsN33pC3VfyZrOeSwHI//5e9rGkBOtJfD3TwNg
	 nUhpUw+KLmM+6zgkyCsgVbZ0h51qnwPCYnjgcUffDz4+DQHX5P2kYrd/vDR0z+VVow
	 C7JwPUuOON/U9Yxi1erejDh9IqnjqxNn+3ftJA3eAn2S8QZNB5FA0Eb7zrbAz4nt89
	 xHgH7xxxDvzsVCNGG0cEmyxaWo39+RPuv8EpcmmbNb36TiPCUsCmsfzxaXtIlDM+1K
	 2tvqyZ/jLM0qjR85ZppvfWNTE9CoxIjRuVk2n0Kvry+mobFbyLHnWeG3MtGhtMcNom
	 bw4Zpl43xuDxA==
Message-ID: <6ab2dcae2afd42c914f7e6b2611151581ccd47d6.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 2/5] selftests: mptcp: move stats info in
 case of errors to lib.sh
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Fri, 10 Jan 2025 11:05:51 +0800
In-Reply-To: <a8575ecc-5602-464b-acf4-2e44d5489066@kernel.org>
References: 
	<20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
	 <20250108-slft-mptcp-conn-misc-impr-v1-2-bdfbdba48a1f@kernel.org>
	 <29b3e04b00e3d1dcaa59f589d43eed7e0c107a96.camel@kernel.org>
	 <a8575ecc-5602-464b-acf4-2e44d5489066@kernel.org>
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

On Thu, 2025-01-09 at 16:30 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for your review!
> 
> On 09/01/2025 10:24, Geliang Tang wrote:
> > Hi Matt,
> > 
> > Thanks for this set.
> > 
> > On Wed, 2025-01-08 at 19:40 +0100, Matthieu Baerts (NGI0) wrote:
> > > A few MPTCP selftests are using the same code to print stats in
> > > case
> > > of
> > > error. This code can then be moved to mptcp_lib.sh.
> > > 
> > > No behaviour changes intended, except to print the error in red
> > > and
> > > to
> > > stderr, like most error messages.
> 
> (...)
> 
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > > b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > > index
> > > 975d4d4c862afff2e685e86dc08a892dbd09d783..50ca64357053b14cd4989e6
> > > 647d
> > > 825337978fdba 100644
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > > @@ -107,6 +107,27 @@ mptcp_lib_pr_info() {
> > >  	mptcp_lib_print_info "INFO: ${*}"
> > >  }
> > >  
> > > +# $1-2: listener/connector ns ; $3 port ; [ $4-5
> > > listener/connector
> > > stat file ]
> > > +mptcp_lib_pr_err_stats() {
> > > +	local lns="${1}"
> > > +	local cns="${2}"
> > > +	local port="${3}"
> > > +	local lstat="${4:-}"
> > > +	local cstat="${5:-}"
> > 
> > I think it's better to add a separate patch to add
> > 
> > 	cat /tmp/${listener_ns}.out
> > 
> > and
> > 
> > 	cat /tmp/${connector_ns}.out
> > 
> > in mptcp_sockopt.sh,
> 
> mptcp_sockopt.sh currently doesn't have such file. I hesitated to add
> them using the content of nstat like in the other ones, but I didn't
> really see how it would help to fix issues with socket options. Or do
> you have something in mind?
> 
> I guess we could add them "just in case", but...

I just sent a patch named "selftests: mptcp: sockopt: save nstat infos"
to do this.

> 
> > then we can drop the last two arguments "lstat"
> > and "cstat" of this helper.
> 
> ... sorry, I'm not sure to understand what you meant here. We still
> want
> to print the content of these files if available.

And a squash-to patch for this.

Thanks,
-Geliang

> 
> 
> Cheers,
> Matt

