Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A980A15199F
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385920; cv=none; b=qi9iSwVs8hfcJIPs25v572d4dXmDgLtOEXZnx0grjdKePN3avU2hNe0KMGcxxfadFE78SHF6nBkVhboeFs2DWLuhf3SnyCjq56asZM8VeUsXnRLyQmzinT6NnZ1jXec1/YybdlR9WdGDoaz0YQ3fIoDsV4kerqrrr8cofL4AcJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385920; c=relaxed/simple;
	bh=xD2RvUcHTuyjzaF+1XoLe1IvHfP+q0FU2w+LnbA9lOY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OUYV9uVgLpkFVGFDiFBQxG1I1QX7H+FraIXROIWn9HzaYJhsWy1eGJlMtLoScWtNZg8lJfjHqpSjRZfSpFST2Z24cxdTPILlMFk6lrc6bai05Vqx0fFj1vx+PDsCbmO+BeX35JhEZfvOtY14DNIr+D7dG59w9cpvQ1Jvc02IO84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWUzph1x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWUzph1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2644AC4CED6;
	Mon, 24 Feb 2025 08:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740385920;
	bh=xD2RvUcHTuyjzaF+1XoLe1IvHfP+q0FU2w+LnbA9lOY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=CWUzph1x5uGGJLypRSU36YMchrEumkHTPZa+QoVRj4TPYn4LjPlfTOhwvRu0IHJmN
	 pMUAZyVjHwKvG5zqshLr+b9ZQt83utUblKLEf6ONmsIDTKGaTWvUH0v4OeGeaptdZX
	 dboboi+bVNMvdOdE+HPu8bAEiODocRdSRrEfFIZpUeXzD3okEtmFk2Othpkpr1SKS9
	 ElAT+B/2um0STlqb1xQrbyj+eJxuhmHdmwAFs6uPfljguIS6KlmADCELdcPzyeBD1K
	 bo6YuPbAnzBA/Tit3cgaubQWzW6rCk+myMX0hy2TWT5JYS7lh4mlKVRZKSmJuviokz
	 FgqLB6M1bCx6Q==
Message-ID: <64115dfbaa4e31a997cdaa8c8195eeeae4fab247.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 3/5] Squash to "bpf: Add mptcp_subflow
 bpf_iter"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 24 Feb 2025 16:31:56 +0800
In-Reply-To: <ba46f04b-e2bb-4d9a-964d-d9dc7ccdec74@kernel.org>
References: <cover.1739787744.git.tanggeliang@kylinos.cn>
	 <f6469225598beecbf0bda12a4c33fafa86c0ff15.1739787744.git.tanggeliang@kylinos.cn>
	 <ba46f04b-e2bb-4d9a-964d-d9dc7ccdec74@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mat,

Thanks for the review.

On Thu, 2025-02-20 at 19:25 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 17/02/2025 11:34, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Drop the NULL check for 'msk' as Martin suggested, add more checks
> > for 'sk'.
> > 
> > Use the "struct sock *sk" instead of "struct mptcp-sock *msk" as
> > the
> > argument in the bpf_iter_mptcp_subflow_new as Martin suggested.
> > 
> > v3:
> >  - continue to use sock_owned_by_user_nocheck and spin_is_locked
> > checks instead of using msk_owned_by_me().
> 
> Why should we continue to do so?
> 
> From what I understood, with the current version, this new
> bpf_iter_mptcp_subflow_new kfunc can only be called from a cg sockopt
> bpf prog, which means these checks are not needed for the moment, no?

Thanks for the clarification. I re-read Martin's comments and he also
suggested removing these checks. So I removed it in v4.

> 
> So maybe we should only add these checks later, when extending its
> usage
> to struct_ops? In the meantime, msk_owned_by_me() could then be used
> instead?

Do I need to add a patch into the "use bpf_iter in bpf schedulers" set
that is under review to do these checks? Do you mean that using
msk_owned_by_me() is enough for struct_ops, and there is no need to use
sock_owned_by_user_nocheck() and spin_is_locked() checks?

Thanks,
-Geliang

> 
> Cheers,
> Matt

