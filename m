Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139B634BA2D
	for <mptcp@lists.linux.dev>; Mon, 13 Oct 2025 02:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324153; cv=none; b=W+wA+9d3KPgqnncqOwMgZeY+ScdFbYl5oXXLYM+TB9YXL8XpFaezglDEmhq6utoxID7EHnJyWvZi7hF3LMhQ48SoJkJ3HkLIxj6PKhh2kH8AiarvUepgewO5+ZlQ9fdKISxoI2VSluOX4EKrogJ+OxUKOBbh5/LUR8yrJgSd9Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324153; c=relaxed/simple;
	bh=pNeanSiCFneWWmRccC5xQZmeVhBCDEdAaUrDi11TkiA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N49kH5a3eJSvIJ69SV1fnQzMoy6g+6Wuzv/qeWYmxybzV/997iyVhXZ2uyADy54G4RAvuu3XLGW7M3G/VCAl61MVtv4H1kYLmj+/o3NmnQDXBJxaBl9HbroHWXfB4G5LmY0K040wKhT9d5SzHlPWC7cIr5p9aoYgTBszWiIpa2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsoxKGTq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsoxKGTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FBCC4CEE7;
	Mon, 13 Oct 2025 02:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760324152;
	bh=pNeanSiCFneWWmRccC5xQZmeVhBCDEdAaUrDi11TkiA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TsoxKGTq9dGIDiegSLlOKadU+YG9Uk0FaNZFxUdtrrGDVmtQWhY0p5dCEkdBlapna
	 r+GwKFaMfZmPIU154Lprvzk8uBsPNT6TcQzlHqqaJS0RQ+8I0+ybCY13UaHKhitDlt
	 a1ykB+37pC3axmja5GJfMe2p19H8p7Q9Nf0+AfUZAzMK6pN9nRaZVAvzn1J08ddGYD
	 SJVxQLs4tUfxOmxtHVyvl9JQQ9UoFhh6EwkBDByKOvWH0d07tiA4PbAagQ7uZZqHgd
	 ZQIRmkPzjW/qMWcACm4MpQ+DtHeKSh8rOnthTM805EmDLwNbUQ+4lTMYccXVHUJJJI
	 oqJsBXK9U/6BA==
Message-ID: <068502dfc6916f7fca095d4da029f63a29ee38bb.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: pm: fix pm_nl_ctl build
 errors with old glibc
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 13 Oct 2025 10:55:45 +0800
In-Reply-To: <f4aca085-7f33-402d-a0b4-2d36321f6dbe@kernel.org>
References: 
	<092fc76415deb1b45da5bb691ef6069fbab7dd09.1758591744.git.tanggeliang@kylinos.cn>
	 <20765ed6-3164-4df7-b125-2ee04e90bb23@kernel.org>
	 <8ab7f8a1452b6660e97b757286cfe2d6a7faafd4.camel@kernel.org>
	 <4cb3a2d4-1f6b-4188-ad2e-065bbf9f3640@kernel.org>
	 <f4aca085-7f33-402d-a0b4-2d36321f6dbe@kernel.org>
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

On Thu, 2025-10-09 at 16:30 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 23/09/2025 10:16, Matthieu Baerts wrote:
> > Hi Geliang,
> > 
> > On 23/09/2025 09:03, Geliang Tang wrote:
> > > Hi Matt,
> > > 
> > > On Tue, 2025-09-23 at 08:53 +0100, Matthieu Baerts wrote:
> > > > Hi Geliang,
> > > > 
> > > > On 23/09/2025 02:42, Geliang Tang wrote:
> > > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > > 
> > > > > Compiling pm_nl_ctl on older versions of glibc will report
> > > > > the
> > > > > following
> > > > > errors:
> > > > > 
> > > > > '''
> > > > >   CC       pm_nl_ctl
> > > > > pm_nl_ctl.c: In function 'capture_events':
> > > > > pm_nl_ctl.c:204:53: error: 'MPTCP_PM_EV_FLAG_DENY_JOIN_ID0'
> > > > > undeclared (first use in this function)
> > > > >   204 |                                         if (flags &
> > > > > MPTCP_PM_EV_FLAG_DENY_JOIN_ID0)
> > > > >       |                                                    
> > > > > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > pm_nl_ctl.c:204:53: note: each undeclared identifier is
> > > > > reported
> > > > > only once for each function it appears in
> > > > > pm_nl_ctl.c:206:53: error: 'MPTCP_PM_EV_FLAG_SERVER_SIDE'
> > > > > undeclared (first use in this function); did you mean
> > > > > 'MPTCP_ATTR_SERVER_SIDE'?
> > > > >   206 |                                         if (flags &
> > > > > MPTCP_PM_EV_FLAG_SERVER_SIDE)
> > > > >       |                                                    
> > > > > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > >       |                                                    
> > > > > MPTCP_ATTR_SERVER_SIDE
> > > > > '''
> > > > > 
> > > > > To fix this, this patch redefines
> > > > > MPTCP_PM_EV_FLAG_DENY_JOIN_ID0
> > > > > and
> > > > > MPTCP_PM_EV_FLAG_SERVER_SIDE in pm_nl_ctl.c.
> > > > 
> > > > You shouldn't get this error, because this file is supposed to
> > > > be
> > > > compiled from the kernel source directory, or at least using
> > > > the
> > > > kernel
> > > > headers built from there
> > > > 
> > > > How do you compile this file? Are you not using the Makefile in
> > > > the
> > > 
> > > I got these errors when compiling the bpf selftests with the
> > > commit
> > > "selftests/bpf: Add mptcp pm_nl_ctl link" using mptcp-upstream-
> > > virtme-
> > > docker:
> > > 
> > > https://patchwork.kernel.org/project/mptcp/patch/8cdb0df7316a6baa93df88b0fe78aaa710f3bb72.1738924354.git.tanggeliang@kylinos.cn/
> > 
> > Mmh, we already had this issue with pm_nl_ctl in BPF selftests in
> > the
> > past, and Alexei didn't want to support KHDR_INCLUDES, because
> > these
> > selftests are not "proper" KSelftests :-/
> > 
> > Did you not add "pm_nl_ctl" because the BPF CI was using a tool old
> > version of IPRoute? They updated it. So maybe we don't need this
> > patch
> > anymore?
> 
> If we can use 'ip' instead of 'pm_nl_ctl', we can drop this patch
> from
> Patchwork. Can we do that?

Currently, 'ip' cannot fully replace 'pm_nl_ctl'. For example, MPTCP
userspace pm commands such as "ann" and "csf" are not yet supported
through 'ip mptcp'. Therefore, when adding MPTCP bpf userspace pm tests
to BPF selftests in the future, 'pm_nl_ctl' will still need to be used.

I agree to drop this patch for now. We can add it back when 'pm_nl_ctl'
is needed in bpf selftests in the future.

I changed the state of this patch as 'Rejected' on Pathwork.

Thanks,
-Geliang

> 
> Cheers,
> Matt

