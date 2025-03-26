Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2320415E5AE
	for <mptcp@lists.linux.dev>; Wed, 26 Mar 2025 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984699; cv=none; b=C7C5pllArb20u2vjgvWnAeBHuM35hsvAKkzfobpBeyE7THYeDyBAblabVRztEyiCbZzyWMt+BVtC22tHSikJgXQfzKTTPhkI4F+AmFr4CDaHift3JlLmAmyuLpc/rLmSjAROW5xJUk82pjmngzpHor6lYhzCMwDCEOg7JYA0ICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984699; c=relaxed/simple;
	bh=phl7R6kG4jQiy5ktKN5X1jbcSgR3AGhSL4Hl271XHx0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qc7OmSKshA16uB912/LfmQkCkF7+gWW1rINZsxJMMPo4nFps5XshqtloVrj8Q7d/15MnNPdZjZMMvGf/Wth698In8gmc+OxYMYXNpajeN3e7CJlNJ/5aCJVZjg+UDRb68Qp3YMwPq3VQE7/DJgvYYBvNLzgORi5TD6cJhhU0Y7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMLreTGS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMLreTGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6444AC4CEE2;
	Wed, 26 Mar 2025 10:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742984698;
	bh=phl7R6kG4jQiy5ktKN5X1jbcSgR3AGhSL4Hl271XHx0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JMLreTGSqi9JKXVhXY3kPp7vfhlEuauzDe21Yfsdx0/Di3kBnsoVsvMV+IxeZuo3u
	 j1cqmBW2tkp3oidq3CEU7IMAop7tR7q2fB0jAePUPMgIFh7T1ZuWdYjsdeBSkB8niW
	 OdCkXTsD5a9eRhjBjDUbPBdNecA+7qCmxPNH3TzuK3Ss0g+1evOekwF8+2NjpykR4x
	 RWFSt1Bru6GNJShAGUn/vqA0Y9FEh4xWKxWb2TbJw/0sxEReaW9K0haIL+T3tLZc2T
	 xFluE9ln+wI2oZvkanOLw+T8m0Idk8ChhainY9v+EujiGhd/pDMViRKZdDOP5jHS8O
	 vIQHCdYc5wAGg==
Message-ID: <8a046230f7c8ca9a06a575fc83a3e5f405b7add2.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v1] mptcp: fix cast type of
 is_fully_established
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 26 Mar 2025 18:24:53 +0800
In-Reply-To: <a36555d6-8c71-4a5b-949c-c535919df510@kernel.org>
References: 
	<27b15c2de6fe36088ef95c4823d9e4a6d7bc9ec6.1742898970.git.tanggeliang@kylinos.cn>
	 <90ea00cb-d57e-411e-9108-624aad2194b9@kernel.org>
	 <a68756790c7f4a698dfea5e5b5adb3531fdd2a96.camel@kernel.org>
	 <a36555d6-8c71-4a5b-949c-c535919df510@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2025-03-26 at 11:17 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 26/03/2025 02:08, Geliang Tang wrote:
> > Hi Matt,
> > 
> > Thanks for the review.
> > 
> > On Tue, 2025-03-25 at 11:49 +0100, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > On 25/03/2025 11:36, Geliang Tang wrote:
> > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > 
> > > > The parameter type of mptcp_is_fully_established() is 'struct
> > > > sock
> > > > *',
> > > > not 'void *', so this patch casts 'msk' as 'struct sock *'
> > > > instead
> > > > of
> > > > 'void *' in mptcp_can_accept_new_subflow().
> > > 
> > > Indeed, but it is not really wrong to use 'void *'. Also, it
> > > looks
> > > like
> > > we are doing that in most other files from the net/mptcp
> > > directory.
> > 
> > I just checked, and there're indeed 6 other places that use '(void
> > *)msk' too, but more places (98) use '(struct sock *)msk'.
> > 
> > $ grep -r "(void \*)msk" net/mptcp/ | wc -l
> > 7
> > $ grep -r "(struct sock \*)msk" net/mptcp/ | wc -l
> > 98
> > 
> > I'm wondering if we should change all 7 '(void *)msk' to '(struct
> > sock
> > *)msk' in v2 to be consistent.
> 
> Maybe, I don't know to be honest. There are other (void *) usages,
> and
> they are "fine" for the moment. Changing them might be good for the
> consistency, but annoying in case of backports :-/
> 
> > > If you have to modify this line for another commit, feel free to
> > > include
> > > the modification in this commit if it bothers you ("While at it,
> > > use
> > > the
> > > proper cast instead of the generic 'void *'"), but it can also be
> > > left
> > > unchanged I think.
> > 
> > Or simply drop this patch. Both are OK to me.
> 
> Yes, maybe. I will ask Mat what he thinks about that.

No need, let's drop this patch :)

Thanks,
-Geliang

> 
> Cheers,
> Matt

