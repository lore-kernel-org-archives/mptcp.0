Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9B444A40B
	for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977139; cv=none; b=YfPDB8oIBoqb+CSIs1P3aizVF1ScRi906VoCnmaH6Tzm65wqu4mKyoDqTWFAsinyL6+FOeNDevywLIlb8w0qw+6TN2FDMnHNbcXvMKJT6snzV/9VawFHCboAuVx2JzN7mG4EDnTZ1OW/FhgVWICeQ8ijpHO7C1CXkk0xXvbdzPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977139; c=relaxed/simple;
	bh=H9sZC47ItOBcl28PI3WJAyTegv8/MJ+QPXwiD0dec+E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nn8qzHpRlHY2DOPfvqKNiBmZBMmasi6ixLD26bGYcg/mW0/IxRMnawwacm2/cCuMkTgQN88jaPkyLMf6aOMjcl8kVepVu7FhmhEwY3X0nqfYzpOF2+ni+i2dWCG/cDgBQgaqHW5hbY+majhcdWm5QOR5i97t7ZZxL62CP6ZuaSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeKI6W+/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeKI6W+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD321F000FF;
	Mon, 21 Sep 2026 07:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789977137;
	bh=soAukcLPeu1qnXONfMitI0losCcYi72Zbpgg5kPRIhc=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=KeKI6W+/4H+nYz6ZTOgDL4IqtuyR/XuloDLHruv5aZI5yU534w0DcZEFRBtycDgxr
	 /OBD1SnUAD8IbMS7P43NydWTNbEJk6ZyaPCD8SrkupRUPMwEviyNVryRjhvrpN78uH
	 La83Vsr2WKd3Ezm3std4/tfBlE0l3eMsbWVfrmCcHpQAKeXWMYyOmPuZeEry2do05d
	 NR+M+33WL6YlS42ylyCughG6g5ETEoVrpljQU2i76tjcbvUPQjSUfS+ITRDhoPWYDo
	 0hejFhiJKPAhvbsvhJftsAx0FFETZS5ay2K6wv1RWBDSDJ10lsaPXcbCIzGeBILE/0
	 eGaNqMpD2/ptw==
Message-ID: <7ad218abd5b68ac34bc34b607af3bb4c7163f60b.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3] selftests: mptcp: print stats before
 socket closure
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
Date: Mon, 21 Sep 2026 15:52:13 +0800
In-Reply-To: <735a6655-b3ac-4352-8a35-0e54ac2c7ffd@kernel.org>
References: <20260815-sft-mptcp-stats-b4-close-v3-1-ccd9af14cf73@kernel.org>
	 <24e7da3ea0b33d5dca970449cf615a4c95ecceb8.camel@kernel.org>
	 <735a6655-b3ac-4352-8a35-0e54ac2c7ffd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

Sorry for the delayed reply.

On Tue, 2026-09-08 at 19:52 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 05/09/2026 10:26, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Sat, 2026-08-15 at 00:28 +0200, Matthieu Baerts (NGI0) wrote:
> > > In case of poll timeout, it might be too late to print the stats
> > > after
> > > the socket closure.
> > > 
> > > Now, in case of poll timeout, 'ss' and 'nstat' are invoked from
> > > mptcp_connect to print the stats before exiting. This should help
> > > debugging poll timeout issues.
> > > 
> > > Note: for this "workaround", system() is used for debugging
> > > purposes
> > 
> > This print_err_stats() implementation is basically the same as
> > mptcp_lib_pr_err_stats() in the shell, right?
> 
> Correct.
> 
> > I think it's better to use mptcp_lib_pr_err_stats() in the shell to
> > print the information. In mptcp_connect.c, when a poll timeout
> > occurs,
> > we send a signal to the shell and don't close the socket
> > immediately -
> > we wait for the shell to finish printing the information before
> > closing
> > it. What do you think of this approach? There's a reference
> > implementation in the attachment, but I haven't tested it.
> Thank you for your review. I agree that what you suggested is better
> for
> a tool that would be used in production. But here with the selftests,
> I
> don't think we need your long patch with a higher complexity, just
> for
> the selftests. I think it is fine to have some "system()" calls with
> the
> same ss/nstat commands compared to a patch of 50+ lines to get the
> same
> result. No?

I agree with you - simplicity is a plus as well.

I tested it and it works. So LGTM!

    Reviewed-by: Geliang Tang <geliang@kernel.org>


However, we need to handle something in mptcp_connect.sh afterwards.
Otherwise, when a timeout occurs, we'll get two duplicate outputs: one
from mptcp_connect, which is the log added by this patch, and one from
mptcp_connect.sh, which is an invalid log. I think in this case we
should ignore the latter, for example by adding the following to
mptcp_connect.sh:

do_transfer()
{
  ...
  mptcp_lib_pr_fail "client exit code $retc, server $rets"
  if [ ${rets} -ne 2 ] && [ ${retc} -ne 2 ]; then
    mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}"
  fi
  ...
}

What do you think? If you don't have time, I can submit this follow-up
patch as well.

Thanks,
-Geliang

> 
> Cheers,
> Matt
