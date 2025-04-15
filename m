Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C63F4C9F
	for <mptcp@lists.linux.dev>; Tue, 15 Apr 2025 03:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744687092; cv=none; b=E5jGCjc1lNgcG6FnS5Y9/v7cYdWbVki3LKu8OLYtAcESPNQr74RzVvkLMNxCVuO/0zkEoDvGcnt42UkVpEvuWrfRc9vnyxziSo9YAA/wIAEeXppIXDEfvtz2tfFH33bVW4G8IZBr96bw8uy5L3qulOKAAagHIE3SvUVuLAYkmHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744687092; c=relaxed/simple;
	bh=2xYPNz8qM2quQTKrqsqSzFNp2/SkTKHatCPM1XWx4K0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oV6sX2qqdy4aM16SoQNEDT5XqvQSVOrnjZChv49GhW0MXZ8p97Y8T78th0Cq+SkSsC/lXOgDI90kCCtJrqzDzcTnSKagfOW4/9+Pn1PwpPiBBJDL4SgS13+YFNsxFDvURGHLIOE5lBv4SD+H2yiLWHh57cukozeGB+Z3aTYIBhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWEDro1Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWEDro1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F1AC4CEE2;
	Tue, 15 Apr 2025 03:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744687091;
	bh=2xYPNz8qM2quQTKrqsqSzFNp2/SkTKHatCPM1XWx4K0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AWEDro1Ziw5GCG8Atp3kLSXxs7Rs2kEoFiqmpz6PXzVxHS6utLyFtkHg/R3M6dFvn
	 IeSPA9KqvAfn3fCSzs8h5YTKqSP7nXTlKey0vp5kFajJqi6+VAiiUPLUG9ZLsaK0oI
	 ihY/aVvucHAzjaybXXa9VQfFjyE/EeNNXc3qeijNq9wcgOinRvtDXJLsgfI1P/Biou
	 dm095aJpVmbjislyicQu4ZQMOTz+vhWcWdFXiLgpljVjD99vVclbZwg3FjgO17z3w/
	 q+k9MWHq8zigFPTj7VbCyO4tKbyqlM5dawifrd9qkOEvbn4DsFKBSdi9X5i2AXixfn
	 704vcGXGFhkMQ==
Message-ID: <ce0591ec28905dd087a74ea5abd762fb684fb17e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v6 0/5] BPF path manager, part 6
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Date: Tue, 15 Apr 2025 11:16:36 +0800
In-Reply-To: <c81dfcab-0eee-45e2-8777-1b0c41e7f696@kernel.org>
References: <cover.1743133948.git.tanggeliang@kylinos.cn>
	 <c81dfcab-0eee-45e2-8777-1b0c41e7f696@kernel.org>
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

On Tue, 2025-04-08 at 20:13 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 28/03/2025 05:01, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > v6:
> >  - squash accept_new_subflow patches into one.
> >  - change "pm->subflows == subflows_max - 1" to
> > 	pm->subflows + 1 == subflows_max.
> >  - not to call accept_new_subflow under the PM lock.
> >  - add mptcp_pm_accept_subflow helpers.
> >  - drop READ_ONCE in mptcp_pm_worker.
> >  - clear all the pm status flags once in mptcp_pm_worker.
> 
> Thank you for the new version.
> 
> FYI, I'm still thinking about how to handle PM lock should be
> handled. I
> will come back to you later. I might suggest a new version with some
> modifications if that's OK, that might be easier.

Thanks for helping me think about this part around the PM lock. Look
forward to your feedback.

-Geliang

> 
> Cheers,
> Matt

