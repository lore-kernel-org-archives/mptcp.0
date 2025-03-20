Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7868F6F
	for <mptcp@lists.linux.dev>; Thu, 20 Mar 2025 04:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742443855; cv=none; b=PaEE+iS1ET9a5xIIwglkYhhmXjbESQWr+HZqfLDSa/+IjclCPXOWDu55cdvWhofpPW8px/pVDhCzca39STgyfK3vFSfh1unaBVBQprQza3bwwdG4YnBDr9q0qYr9xKmisurYu6uhApE83MU46OkO5VWgh0NcaZAnAkAhASl1LOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742443855; c=relaxed/simple;
	bh=7Ec0pZA7KfT35eLRZXV9mISUElhP89SsUmPjRgrnILg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gXq1a3p+1aKhdqkYYdD47swg+k0fyMdZzI/wlzZjLagh23eXZ8+VjIPOUxRwQeOdU1TuNk8Ihhz0t9X6Oy1AgL0gdEPO2qltcWXBXnHpAludK48UvS8LGL584dJKZeZ9x5587Vk/5kon8QCuD2qUrT2na8mPCTIK3K1JG+YMZFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvTWTtT9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvTWTtT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CFCC4CEDD;
	Thu, 20 Mar 2025 04:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742443854;
	bh=7Ec0pZA7KfT35eLRZXV9mISUElhP89SsUmPjRgrnILg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gvTWTtT9JWKUJItFAYTSY4FnFYcWfLNRXfocw3H0cTVN9MCWhlPQGxz9KU4WvQlY5
	 fZmSgaQnwAytp+hu0RlvpCejomAJlp/kqiSO/rKSDrpErL+CCj5INzEtijYDISWR1a
	 TMH5a1ZGUmjyEZsEFT2ELhzBVSb+2IskrG/0QS6r82cfHtOKiXTSklzRMBx2LS1zG3
	 KIH7z4hEZb0pQLOP1xo/baFkrmVZTvDwHzoVFWu2ApygNOyni5TW6tMnbr57fCMpL5
	 9FhIKxOrDbr7AGwkAP4WAwWwPCOKYdZyBYGVQqzZ5FYI9FNZhWkvwfGm7pN0V+QfDn
	 WavGTyfeKa+fQ==
Message-ID: <acc3de526416164e0a57ecaab1c7ff16a0279bd4.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v15 0/8] use bpf_iter in bpf schedulers
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 20 Mar 2025 12:10:50 +0800
In-Reply-To: <3440578a-0d36-4c4a-b5fb-292ecfd469f9@kernel.org>
References: <cover.1739788598.git.tanggeliang@kylinos.cn>
	 <ba7822fb-a0cb-4636-89fc-ad1355e4c234@kernel.org>
	 <02622736c58386a5d074b5a64af5d76b7f35248d.camel@kernel.org>
	 <706a3051-8328-4321-8eea-71d4120ea996@kernel.org>
	 <3440578a-0d36-4c4a-b5fb-292ecfd469f9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

On Wed, 2025-03-19 at 18:10 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 07/03/2025 09:48, Matthieu Baerts wrote:
> > On 07/03/2025 04:08, Geliang Tang wrote:
> 
> (...)
> 
> > > Anyway, we can put the patch "mptcp: sched: remove
> > > mptcp_sched_data" on
> > > the export branch and wait for a while, don't send it upstream
> > > recently, and wait for me to send some squash-to patches to
> > > modify
> > > them.
> > 
> > Sure. There are some other patches to send first anyway.
> 
> If I have the opportunity to send more patches for net-next this
> week,
> is it OK for you if I add "mptcp: sched: remove mptcp_sched_data"?

Sure, I agree. Please send this patch upstream.

Thanks,
-Geliang

> 
> If we need to re-introduce the mptcp_sched_data structure later, we
> can
> still do it. Currently, we don't use it in net-next or in our tree,
> so I
> think it is better to drop it for the moment to save some bytes and
> avoid confusions, no?
> 
> Cheers,
> Matt

