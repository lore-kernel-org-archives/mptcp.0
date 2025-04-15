Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F2F2BAF9
	for <mptcp@lists.linux.dev>; Tue, 15 Apr 2025 03:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744688645; cv=none; b=dttkHNXHO9OyYHN8PQPkFsq+3wF2PDUnycvRQIF7XEHjx79LrHy7hb8EBnswcDDcMV1MN+JRoJgaMyiVbz3ComeCAq9pB2VqfDnpsRg+osIZl5nk75hmHewRiZMlFbkw03MshsMWB7GEe7pARc4ojt9u01KRNycBFWv79grXjoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744688645; c=relaxed/simple;
	bh=2+ZejnebLdJd8MC18yGa/6CrUcLS86vfv0LirAQHrvk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uagi6U0igqhNTG0iPqF/o96zTPH4gZcQyMGANv1/SSEvayqySr9uKDTfG1wKXD8tZph1ChBjHoY1KbQj0evBSWy1Xeq4u/YaB/wQFx1+fa//JYywCYQs+7lRMErRck6WL67oXE/r4w0hCc7o9fFuMIuk0tB9pPaLXZzOkj3HuWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgqpheGr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgqpheGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE50C4CEDD;
	Tue, 15 Apr 2025 03:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744688645;
	bh=2+ZejnebLdJd8MC18yGa/6CrUcLS86vfv0LirAQHrvk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WgqpheGrJnOu5Z8DFxkdOa6o5RMEyVQWLJSV4ZgbDMxdzlxWFZTrImGXaOY7HyCBs
	 vbyKGQD85+aAlNDxj4f1OxLi4erFingHBcH6BOvHKwQHjdySXPYMmUIEYXhEtvOuWH
	 f4Qa9IPIMqHVA240Q8hA/c6PoF2PSxxhyAexCm6zQU0XZh+5zjDB2kwWq/AgKnmge7
	 Wu5RW1wI91+LqOSO7udDF7wdPVHa6rkDTgnbLRcHPs83h5RorxAcXoniwP4+vP1sGO
	 +S2BdeX2XQpjEcuHzyoBncq/JQJXd8pzIl61M3U1mJgqYMbv1TrX2k48UlynOYRZHP
	 lKHpz25N7MrZA==
Message-ID: <8046b5fa40756fe4739fb17376fc5afe1029d0f7.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: pm: drop redundant mptcp_pm_send_ack
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 15 Apr 2025 11:44:00 +0800
In-Reply-To: <ffb15da5-a01f-4703-8ab0-f07acbbc1bef@kernel.org>
References: 
	<539ce4556220df3d2ea4826c311c5bc4e306f9a2.1743863553.git.tanggeliang@kylinos.cn>
	 <ffb15da5-a01f-4703-8ab0-f07acbbc1bef@kernel.org>
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

Thanks for the review.

On Thu, 2025-04-10 at 19:38 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 05/04/2025 16:33, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > mptcp_pm_send_ack() is called twice in __mptcp_pm_addr_send_ack(),
> > which
> > makes the code a bit redundant. The first call to
> > mptcp_pm_send_ack() when
> > a non-stale subflow is found in the loop can be removed. Instead,
> > we can
> > break the loop to use the second mptcp_pm_send_ack().
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/pm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index be1e27ee393e..a4f9cb113018 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -225,8 +225,8 @@ void mptcp_pm_addr_send_ack(struct mptcp_sock
> > *msk)
> >  	mptcp_for_each_subflow(msk, subflow) {
> >  		if (__mptcp_subflow_active(subflow)) {
> >  			if (!subflow->stale) {
> > -				mptcp_pm_send_ack(msk, subflow,
> > false, false);
> > -				return;
> > +				alt = subflow;
> > +				break;
> 
> Is this patch going to simplify another one later on? Because the
> modification sounds strange: here 'alt' stands for 'alternative'. So
> to
> be complete, better to rename the variable as well.

Better to rename it as "pick" or something.

> 
> But... is this really worth it? If you need to modify this helper
> later
> on, maybe. If not, I guess it is fine to keep 'mptcp_pm_send_ack()'
> duplicated for the moment. WDYT?

Sure. Let's drop this patch now, and resend it with other patches in
the future if we have other modifications in this helper.

Thanks,
-Geliang

> 
> This is also to be aligned with:
> 
>  
> https://docs.kernel.org/process/maintainer-netdev.html#clean-up-patche
> s
> 
> (trying to avoid cleanup patches "alone", except if it is part of
> another set of changes related to that)
> 
> >  			}
> >  
> >  			if (!alt)
> Cheers,
> Matt

