Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED330C917
	for <mptcp@lists.linux.dev>; Tue,  6 May 2025 02:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746498976; cv=none; b=sjCxP17Lg8OhIwpbdEEmQdXiFIggK9HEs6POMZVUG6Bcmd+/njtRwot8imLJSet6kDkWlURfA4M6Tux8UsedyRFsJbDsP67FaLubiaH18Xa2XIDpeYseD/fiSaANH3inn1pcgmvVzKHpKvk84Gp1Jq2NxvAcQHgSDDkLKgMsU0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746498976; c=relaxed/simple;
	bh=Z8RbUEvLXCp1G92Lw3EJArQhHw5VZ9hen3aWP8bB7vs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hb8S2Z7wIV1mO4hOolTNUgXKIIhJZlF9PwTAJBBcAFKrB/OhNMnUAid92lePZTPoXfSXJN01HwCzGHAySIgUuhILQZmECNGVHZDfZqIhx15Rs+/IHL6/A7h/+QAoba/J1UFl19IooWo3oOhcJ8a10gKHQvhwn0IRjDSQ30XPoTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCNrxIXK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCNrxIXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A51C4CEEF;
	Tue,  6 May 2025 02:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746498974;
	bh=Z8RbUEvLXCp1G92Lw3EJArQhHw5VZ9hen3aWP8bB7vs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PCNrxIXK8VCvCgLkt7FnCan5ovnRnXJ58JWo7nhKkKpkqitcRjGh1usvON6W6xlQW
	 QMFaCyPUBNemJW148wG5ky3ITNu+QaNgqjby9Wzato4wee3blZry5gBvn7f9P7rip+
	 K9roB1JPZP+FuNhVcqCP5FdHGHbP0HQahrW68o1gbmr3nLF9vAg8f/+ecRwtuB9bkp
	 OCE1U6eG2b/UcqTKGUmvzDrp9dbduIURFo1rvcuqxRhiXzSeKFw8BtBM/jbAAmsixe
	 kLwtJJot/QgvseTS2StGJHUysAo0peFcGvx9vUwRGq1xL9b3laHv67Hj2tyuOgkj+/
	 Rur1GROStRh2g==
Message-ID: <b0d5094ee4a361471f562f29d6d04d9e197fe596.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 2/2] mptcp: add TCP_MAXSEG sockopt support
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 06 May 2025 10:36:10 +0800
In-Reply-To: <d74438da-8eff-469a-82c5-0cf507042ab8@kernel.org>
References: <cover.1745991978.git.geliang@kernel.org>
	 <cdc5f6389f230f8c1eec4332c27efbf51c734a51.1745991978.git.geliang@kernel.org>
	 <d74438da-8eff-469a-82c5-0cf507042ab8@kernel.org>
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

On Wed, 2025-04-30 at 10:55 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 30/04/2025 07:49, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > The TCP_MAXSEG socket option is currently not supported by MPTCP,
> > mainly
> > because it has never been requested before. But there are still
> > valid
> > use-cases, e.g. with HAProxy.
> > 
> > This patch adds its support in MPTCP by propagating the value to
> > all
> > subflows.
> 
> Might be good to add:
> 
>   The get part looks at the value on the first subflow, to be as
> closed
>   as possible to TCP. Only one value can be returned for the cached
> MSS,
>   so this can come only from one subflow.
> 
> The rest looks good to me:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> I can do the modification when applying the patch.
> 
> Note that I will not send them upstream before the addition of the
> packetdrill test in our other repo.

Thanks for applying these patches for me.

They can be WIP on the export branch until I add the packetdrill test,
which I have already started working on.

Thanks,
-Geliang

> 
> Cheers,
> Matt

