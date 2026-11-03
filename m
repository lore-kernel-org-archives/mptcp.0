Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793677019;
	b=i1Pva0HwUhomxxTshNgGMOR+h2qXF50kH5Zua3K5+s/ke5frNsSFUynUZiur24Njv6Bt
	 KCq8FtPbhI8RQhl+cEkltVBQo6kHK0WClNMIxnLuGjRlGs/2FlgLzNrF8wkE7udseI6zb
	 svI2fb2snPeH5yMr5gvdMkyL27UWGaNnxG91vXreLZWrHaSPM+p+gtMCb4VvXREZ1Y+Wb
	 BeOKtYBCXCX4z/6bjWYJSQqm51xkvPDj//lt79cEv0o6LnZDCuKKyoeLwY5txKb3nLRIs
	 TTN5ghoAIt6oIZezE7WnhLRr53PCPBYIN5gUK/2ibz4EZoY6gHHuTwi3QywE5k7EbPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677019;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UXkkIGJVjExvAFXO4tJHpLawZxryMapmjOafXs5vUrw=;
	b=xdg9osx/UNjWUeWgtTUfzeVPTTd3AxYQG0vmHfMS7CmDO8pEAZnPTbq+lcGV6lZflL3A
	 jpVmn4LsxeOKIqowGpy6MU6FfUrQHbsh16/A1RJKdjExL/rU6NyNm+4rucngYsOqrBHL6
	 aHbdBJz0vE4I95T7PUkfEIHDit9mbYLeWW9ydcSOWbWRv7sOZISPUWaS52fxepyDzn2Y7
	 8/ssnjDBXPHUEuNmK7MCf9/xcJ3ZVqGn7K8H6SFgNajo40+N3Cb/0pSzUWngUvK1DIJpN
	 i2gBJUrB/YpYeoWsQ0q0hsViBtPxVyDZmJ3cJb00eUoOlCVaK2Wnem76mPm0hGB42AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bH1F9MBN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBDF606A326
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 03:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bH1F9MBN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523761F000C1;
	Tue,  3 Nov 2026 03:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793677019;
	bh=UXkkIGJVjExvAFXO4tJHpLawZxryMapmjOafXs5vUrw=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=bH1F9MBNfI/3E2iknr8X8G9dwZEIGNa3meDO0g9mpxDqUBXHDDja6w7hYLRJ38/gS
	 WUV7KKC10/AJFRNtTXGyHU5Lsg9PqRr4jdcVhozmvnIuDb4KdWI6H8qByCS5LTWkc0
	 Qj2MwPK1Pv50ooYp05Le9cxtAUTmXQetmjFgDsEo7F5ZNKOD1cfdR7sw6fAsoZvvPN
	 Q1aVUgbMj4wVgcf+QYLLpLLnHBGXVxEuOWVuZdHgzhiuvgt5nJ65vjVBbjrllmYlQW
	 aOsSLvP1d518n84zNhCt0JyeThGjpMbF9WjQyG9z/bdvEaRHlQ8hOx3fcnT+Vz91jI
	 31GVTB+3jnD4Q==
Message-ID: <fc1a3f23c29819adce277e0b19c466bf63fea693.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] Squash to "bpf: Add mptcp_subflow bpf_iter"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
Date: Tue, 03 Nov 2026 11:36:56 +0800
In-Reply-To: <46f86900-a7aa-4ffd-8c34-a15fa8c8d460@kernel.org>
References: 
	<20261102-mptcp-bpf-kf-iter-ret-indep-v1-1-dd262e520168@kernel.org>
	 <46f86900-a7aa-4ffd-8c34-a15fa8c8d460@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10build1 
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Mon, 2026-11-02 at 19:52 +0100, Matthieu Baerts wrote:
> Hello,
> 
> On 02/11/2026 17:45, Matthieu Baerts (NGI0) wrote:
> > Since commit d09c2aa3109f ("bpf: Track borrowed iterator results by
> > default"), the verifier ties a struct pointer returned by an
> > iterator's
> > next kfunc to the current element by default: it is invalidated by
> > the
> > following "next" call, and by "destroy".
> > 
> > That breaks the MPTCP BPF schedulers tests, keeping a subflow after
> > advancing the iterator: bpf_rr keeps the first subflow, and
> > bpf_burst
> > keeps the "best" ones to use them after the loop. Both are now
> > rejected
> > at load time:
> > 
> >   R1 type=scalar expected=ptr_, trusted_ptr_, rcu_ptr_
> >   (...)
> >   # test_rr:FAIL:open_and_load: rr unexpected error: -13
> > 
> > The returned subflow is not tied to the iterator position: next
> > only
> > walks msk->conn_list, destroy is empty, and no per-element
> > protection
> > is dropped. In fact, the subflow is still valid thanks to the held
> > msk
> > lock. Then declare it with KF_ITER_RET_INDEPENDENT.
> 
> It looks like it fixes the issue reported by the CI. I suggest
> applying
> it now, not to impact other devs. I can always change this later if
> needed.

I've just reproduced the issue and confirmed that this patch fixes it.
Please apply this patch.

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> 
> Cheers,
> Matt
