Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA91A221FCD
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 03:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757474804; cv=none; b=uDQgHw1NZFlFnJOvcKlBuKD3/2EM3ZFQ4vtqi2JhVkYrZUQbnJVPniDbBGqWDB3wXJgWauy+oJVuoACxtM++WTgKkpRIzt63bqDJDdUB3PZfvfZcNv0/pTqvDT77e59xNs7UHtwwrBTlsHS0V10vPvQRsyE8zYKifB/Yhp071BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757474804; c=relaxed/simple;
	bh=IT1HW4tirw6iimhMutE0H3D1oPPhidKrat40i4QIA2k=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bdcnInLt9f4WBIDubDEqntMcv26Xb/noylfhFnEbfaz2CxoYGHgoBOX/H1IItCY6o81qUhGvDHOzRElBVodPAJoyjugc8F6AvjbhXuMVfGOF1+xrEeckN3+1YByswnV0L2RJJDYcRJEl0fGufTmVAhUlODpH67awGHkJQ0aQUXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po+YrJ7a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po+YrJ7a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556D2C4CEF5;
	Wed, 10 Sep 2025 03:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757474803;
	bh=IT1HW4tirw6iimhMutE0H3D1oPPhidKrat40i4QIA2k=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Po+YrJ7aqIXswwyjPRTfAkaERsIdUCwwTZTy+lrauTf/CP+Mm4KV1L06yJPFoyUZI
	 8SY/Ec2Y1tDmCLOWsETFayooOmtjw8nnn8LWY2Xc2LBpdIgKPNMaNQmgV8QBMxKncf
	 wfgf0hox0xU7ZiuESPLbyOKl83OtmVqqh7wpijeHZh8BHQzi+8QgRsLcWvV0lawv+5
	 8TG8abynotz63fgNzk9yuFMKRxN80SRmt0kAU1FfOwHyaVCz/kHLsWFU+CWF3VkGKz
	 2tHjqx3F04k7wIgV1MJph5LXb2qSuB7Oe1r46fSw2Qu4xw6/ByeCm2WaqYHuDNo4cy
	 6TIRnvt3BilFA==
Message-ID: <9afac8fbd241a700aad614d61659985062154b76.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 4/5] selftests: mptcp: print trailing bytes
 with od
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 10 Sep 2025 11:26:40 +0800
In-Reply-To: <b396773f-65ed-4e15-960d-b3acc871f443@kernel.org>
References: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
	 <20250905-sft-mptcp-disc-err-v2-4-dfb3b6b4a877@kernel.org>
	 <0ebf9d7a70ebc16b66b6c609606b28791a145d04.camel@kernel.org>
	 <b396773f-65ed-4e15-960d-b3acc871f443@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sat, 2025-09-06 at 15:56 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 06/09/2025 01:42, Geliang Tang wrote:
> > On Fri, 2025-09-05 at 20:18 +0200, Matthieu Baerts (NGI0) wrote:
> > > This is better than printing random bytes in the terminal.
> > > 
> > > Note Jakub suggested 'hexdump', but Mat found out that this tool
> > > is
> > > not
> > > often installed by default. 'od' can do a similar job, and it is
> > > in
> > > the
> > > POSIX specs and available in coreutils, so it should be on more
> > > systems.
> > > 
> > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > Suggested-by: Mat Martineau <martineau@kernel.org>
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > > v2: switch to 'od', and no more check for its presence (Mat)
> > > ---
> > >  tools/testing/selftests/net/mptcp/mptcp_lib.sh | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > > b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > > index
> > > 09cd24b2ae466205dacbdf8289eb86c08534c475..d62e653d48b0f2ef7a01e28
> > > 9fa0
> > > be8907825667d 100644
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > > @@ -384,7 +384,7 @@ mptcp_lib_make_file() {
> > >  mptcp_lib_print_file_err() {
> > >  	ls -l "${1}" 1>&2
> > >  	echo "Trailing bytes are: "
> > > -	tail -c 27 "${1}"
> > > +	tail -c 32 "${1}" | od -x | head -n2
> > 
> > nit:
> > 
> > It shows more bytes (32) here, but it wasn't mentioned in the
> > commit
> > log.
> 
> Good point, I can add this when applying the patches:
> 
>   Show a few more bytes, just to fill in the two lines.
> 
> Would that be OK?

That would be great.

Thanks,
-Geliang

> 
> Cheers,
> Matt
